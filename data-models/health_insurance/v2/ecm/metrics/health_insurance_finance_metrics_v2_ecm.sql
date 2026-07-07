-- Metric views for domain: finance | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_actuarial_reserve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Actuarial reserve adequacy and liability metrics for financial risk management and statutory reporting. Tracks reserve estimates, confidence intervals, paid claims, and LAE by reserve type, line of business, and development method. Used by CFO, Chief Actuary, and board risk committee to assess reserve adequacy and solvency."
  source: "`vibe_health_insurance_v1`.`finance`.`actuarial_reserve`"
  filter: is_active = TRUE
  dimensions:
    - name: "reserve_type"
      expr: reserve_type
      comment: "Type of actuarial reserve (IBNR, IBNER, LAE, unearned premium) for reserve category analysis."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for reserve segmentation by product portfolio."
    - name: "development_method"
      expr: development_method
      comment: "Actuarial development method used (chain-ladder, Bornhuetter-Ferguson, etc.) for methodology transparency."
    - name: "actuarial_reserve_status"
      expr: actuarial_reserve_status
      comment: "Status of the reserve record (preliminary, final, approved) for governance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reserve for multi-currency entity reporting."
    - name: "mlr_flag"
      expr: mlr_flag
      comment: "Indicates whether the reserve is included in MLR calculations."
    - name: "reserve_period_month"
      expr: DATE_TRUNC('MONTH', reserve_period)
      comment: "Reserve period month for time-series reserve development tracking."
  measures:
    - name: "total_reserve_estimate"
      expr: SUM(CAST(reserve_estimate_amount AS DOUBLE))
      comment: "Total actuarial reserve estimate. Primary solvency metric — must be adequate to cover all future claim obligations."
    - name: "total_liability"
      expr: SUM(CAST(total_liability_amount AS DOUBLE))
      comment: "Total actuarial liability including all reserve components. Used for balance sheet reporting and RBC (Risk-Based Capital) calculations."
    - name: "total_paid_claims"
      expr: SUM(CAST(paid_claims_amount AS DOUBLE))
      comment: "Total paid claims amount used in reserve development. Tracks actual claims experience against reserve assumptions."
    - name: "total_paid_lae"
      expr: SUM(CAST(paid_lae_amount AS DOUBLE))
      comment: "Total paid loss adjustment expenses. Tracks administrative cost of claims settlement against LAE reserve."
    - name: "avg_confidence_interval_high"
      expr: AVG(CAST(confidence_interval_high AS DOUBLE))
      comment: "Average upper bound of the actuarial confidence interval. Measures reserve uncertainty and tail risk exposure."
    - name: "avg_confidence_interval_low"
      expr: AVG(CAST(confidence_interval_low AS DOUBLE))
      comment: "Average lower bound of the actuarial confidence interval. Measures the minimum reserve adequacy scenario."
    - name: "reserve_confidence_spread"
      expr: AVG(CAST(confidence_interval_high AS DOUBLE) - CAST(confidence_interval_low AS DOUBLE))
      comment: "Average spread between high and low confidence interval bounds. Measures actuarial uncertainty — wider spreads indicate higher reserve risk."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to reserves. Tracks population risk profile changes that affect reserve adequacy."
    - name: "reserve_count"
      expr: COUNT(1)
      comment: "Count of actuarial reserve records. Used to validate completeness of reserve development across all required segments."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice management metrics tracking vendor payment obligations, aging, discount capture, and processing efficiency. Used by CFO, Controller, and AP operations to manage cash flow, vendor relationships, and payment compliance."
  source: "`vibe_health_insurance_v1`.`finance`.`ap_invoice`"
  filter: void_flag = FALSE
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (vendor services, claims, capitation, etc.) for spend categorization."
    - name: "ap_invoice_status"
      expr: ap_invoice_status
      comment: "Current status of the invoice (pending, approved, paid, on-hold) for workflow and aging analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (unpaid, partial, paid) for cash flow management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for internal controls and audit compliance."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for cost allocation and LOB-level expense management."
    - name: "division_code"
      expr: division_code
      comment: "Division for organizational cost center reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP management."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date month for AP volume and spend trending."
    - name: "n1099_flag"
      expr: n1099_flag
      comment: "Indicates 1099-reportable vendor payments for tax compliance tracking."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount. Primary accounts payable liability metric for cash flow planning and vendor spend management."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice amount after discounts and adjustments. Represents actual cash outflow obligation."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures AP efficiency and working capital optimization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on AP invoices. Required for tax liability reporting and 1099 compliance."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices. Measures AP processing volume and operational throughput."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount. Benchmarks typical vendor transaction size and identifies outliers."
    - name: "on_hold_invoice_count"
      expr: COUNT(CASE WHEN ap_invoice_status = 'ON_HOLD' THEN 1 END)
      comment: "Count of invoices currently on hold. Tracks AP processing bottlenecks and vendor dispute exposure."
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross invoice value captured as early payment discounts. Measures AP working capital efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment execution metrics tracking cash disbursements, payment methods, reconciliation status, and foreign currency exposure. Used by Treasury, Controller, and CFO to manage cash outflows, bank reconciliation, and payment risk."
  source: "`vibe_health_insurance_v1`.`finance`.`ap_payment`"
  filter: void_flag = FALSE
  dimensions:
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (check, ACH, wire, EFT) for payment channel analysis and fraud risk management."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for disbursement channel optimization."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel (electronic, paper) for digital payment adoption tracking."
    - name: "ap_payment_status"
      expr: ap_payment_status
      comment: "Current payment status (pending, cleared, voided) for cash position management."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Reconciliation status flag for bank reconciliation completeness tracking."
    - name: "is_foreign_currency"
      expr: is_foreign_currency
      comment: "Identifies foreign currency payments for FX exposure management."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for cost allocation of disbursements."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date month for cash flow trending and disbursement scheduling."
  measures:
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross cash disbursed. Primary cash outflow metric for treasury and cash flow management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after discounts. Represents actual cash leaving the organization."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at payment time. Measures early payment discount program effectiveness."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AP payments processed. Measures payment operations throughput."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN is_reconciled = FALSE THEN 1 END)
      comment: "Count of payments not yet reconciled to bank statements. Tracks bank reconciliation backlog and financial close risk."
    - name: "foreign_currency_payment_amount"
      expr: SUM(CASE WHEN is_foreign_currency = TRUE THEN gross_amount ELSE 0 END)
      comment: "Total disbursements in foreign currency. Measures FX exposure requiring hedging or treasury management."
    - name: "electronic_payment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN payment_channel = 'ELECTRONIC' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments made electronically. Tracks digital payment adoption and paper check reduction progress."
    - name: "avg_payment_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment amount per disbursement. Benchmarks payment size distribution for fraud detection and vendor analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice and revenue collection metrics tracking premium billing, collection status, write-offs, and aging. Used by CFO, Revenue Cycle, and Controller to manage premium receivables, collection efficiency, and bad debt exposure."
  source: "`vibe_health_insurance_v1`.`finance`.`ar_invoice`"
  filter: is_void = FALSE
  dimensions:
    - name: "ar_invoice_status"
      expr: ar_invoice_status
      comment: "Current AR invoice status (open, paid, overdue, written-off) for receivables aging and collection management."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection workflow status for delinquency management and collections prioritization."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment receipt status for cash application tracking."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for receivables segmentation by product portfolio."
    - name: "party_type"
      expr: party_type
      comment: "Type of billing party (employer group, individual member, government) for receivables portfolio analysis."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle (monthly, quarterly, annual) for cash flow forecasting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date month for AR volume and revenue trending."
    - name: "is_written_off"
      expr: is_written_off
      comment: "Identifies written-off receivables for bad debt analysis and reserve adequacy."
  measures:
    - name: "total_gross_billed"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed to customers. Primary revenue billing metric for premium revenue cycle management."
    - name: "total_net_receivable"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR balance after discounts. Represents the expected cash collection from outstanding invoices."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash receipts not yet matched to invoices. Tracks cash application backlog and revenue recognition risk."
    - name: "total_written_off_amount"
      expr: SUM(CASE WHEN is_written_off = TRUE THEN net_amount ELSE 0 END)
      comment: "Total AR written off as uncollectible. Measures bad debt expense and collection program effectiveness."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total AR invoice count. Measures billing volume and revenue cycle throughput."
    - name: "write_off_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_written_off = TRUE THEN net_amount ELSE 0 END) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of net AR written off as bad debt. Key credit risk and collection effectiveness KPI."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net AR invoice amount. Benchmarks typical billing transaction size by party type and LOB."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on AR invoices. Tracks revenue leakage from billing adjustments and contractual allowances."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation quality and completeness metrics tracking reconciliation status, outstanding items, and balance discrepancies. Used by Controller, Treasury, and internal audit to ensure cash account integrity and detect fraud or errors."
  source: "`vibe_health_insurance_v1`.`finance`.`bank_reconciliation`"
  filter: is_active = TRUE
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status (in-progress, completed, approved) for financial close tracking."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of bank reconciliation (monthly, interim, year-end) for close cycle management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for internal controls compliance — unapproved reconciliations are a SOX risk."
    - name: "is_adjusted"
      expr: is_adjusted
      comment: "Identifies reconciliations requiring adjusting entries for error correction tracking."
    - name: "reconciliation_period_start_month"
      expr: DATE_TRUNC('MONTH', reconciliation_period_start)
      comment: "Reconciliation period start month for close cycle calendar management."
  measures:
    - name: "total_unreconciled_items"
      expr: SUM(CAST(unreconciled_items_amount AS DOUBLE))
      comment: "Total dollar value of unreconciled items. Primary cash integrity metric — large unreconciled balances indicate fraud risk or processing errors."
    - name: "total_outstanding_checks"
      expr: SUM(CAST(outstanding_checks_amount AS DOUBLE))
      comment: "Total outstanding checks not yet cleared. Tracks stale check exposure and cash position accuracy."
    - name: "total_deposits_in_transit"
      expr: SUM(CAST(deposits_in_transit_amount AS DOUBLE))
      comment: "Total deposits in transit not yet reflected in bank statements. Measures timing differences in cash reporting."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total bank reconciliation count. Measures financial close completeness across all bank accounts."
    - name: "unapproved_reconciliation_count"
      expr: COUNT(CASE WHEN approval_status != 'APPROVED' THEN 1 END)
      comment: "Count of reconciliations not yet approved. Tracks SOX internal control compliance and financial close risk."
    - name: "avg_unreconciled_amount"
      expr: AVG(CAST(unreconciled_items_amount AS DOUBLE))
      comment: "Average unreconciled items amount per reconciliation. Benchmarks typical reconciliation quality and identifies problem accounts."
    - name: "gl_to_bank_variance"
      expr: AVG(CAST(gl_balance AS DOUBLE) - CAST(bank_statement_balance AS DOUBLE))
      comment: "Average difference between GL balance and bank statement balance. Non-zero values indicate reconciling items requiring resolution."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise budget performance metrics tracking total budgeted amounts, variances, and budget utilization by cost center, line of business, and fiscal year. Used by CFO, Finance Business Partners, and department heads to monitor spending against plan and drive resource allocation decisions."
  source: "`vibe_health_insurance_v1`.`finance`.`budget`"
  filter: is_active = TRUE
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Budget type (operating, capital, project) for budget portfolio management."
    - name: "budget_status"
      expr: budget_status
      comment: "Budget approval status (draft, approved, locked) for governance and financial planning cycle tracking."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for LOB-level budget allocation and variance analysis."
    - name: "fiscal_year"
      expr: year
      comment: "Fiscal year for annual budget cycle management and year-over-year comparison."
    - name: "division_code"
      expr: division_code
      comment: "Division for organizational budget hierarchy reporting."
    - name: "department_code"
      expr: department_code
      comment: "Department for granular budget ownership and accountability."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-entity financial planning."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(total_budgeted_amount AS DOUBLE))
      comment: "Total approved budget amount. Primary financial planning metric for resource allocation and spending authority."
    - name: "total_adjusted_budget"
      expr: SUM(CAST(total_adjusted_amount AS DOUBLE))
      comment: "Total budget after mid-year adjustments. Reflects current spending authority after reforecasting."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs. budget). Negative variance indicates overspend — triggers management intervention."
    - name: "total_prior_year_actual"
      expr: SUM(CAST(prior_year_actual_amount AS DOUBLE))
      comment: "Total prior year actual spend. Used for year-over-year budget growth analysis and trend-based planning."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of budget records. Measures budget planning completeness across the organization."
    - name: "budget_adjustment_rate"
      expr: ROUND(100.0 * SUM(CAST(total_adjusted_amount AS DOUBLE) - CAST(total_budgeted_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Percentage change from original to adjusted budget. Measures forecast accuracy and mid-year reallocation activity."
    - name: "variance_rate"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Budget variance as a percentage of total budget. Key financial discipline metric — large negative rates signal cost overruns requiring executive action."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial regulatory filing compliance metrics tracking filing status, timeliness, tax liabilities, and submission outcomes by jurisdiction and filing type. Used by CFO, Compliance, and Regulatory Affairs to ensure timely and accurate financial regulatory submissions and manage deficiency risk."
  source: "`vibe_health_insurance_v1`.`finance`.`finance_regulatory_filing`"
  filter: is_active = TRUE
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of regulatory filing (annual statement, premium tax, MLR report) for compliance portfolio management."
    - name: "filing_status"
      expr: filing_status
      comment: "Current filing status (draft, submitted, accepted, rejected) for compliance deadline tracking."
    - name: "filing_category"
      expr: filing_category
      comment: "Filing category for regulatory reporting classification."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Regulatory jurisdiction (state, federal) for multi-jurisdiction compliance management."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body (CMS, DOI, IRS) receiving the filing for agency-level compliance tracking."
    - name: "filing_is_amended"
      expr: filing_is_amended
      comment: "Identifies amended filings for audit risk and data quality assessment."
    - name: "filing_period_start_month"
      expr: DATE_TRUNC('MONTH', filing_period_start)
      comment: "Filing period start month for compliance calendar management."
  measures:
    - name: "total_tax_liability"
      expr: SUM(CAST(tax_liability_amount AS DOUBLE))
      comment: "Total tax liability reported across regulatory filings. Primary financial obligation metric for regulatory compliance."
    - name: "total_final_tax_due"
      expr: SUM(CAST(final_tax_due_amount AS DOUBLE))
      comment: "Total final tax due per regulatory filings. Represents actual cash obligation to regulatory bodies."
    - name: "total_taxable_base"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base (e.g., earned premium) reported. Used to verify effective tax rate and filing accuracy."
    - name: "total_estimated_payment"
      expr: SUM(CAST(estimated_payment_amount AS DOUBLE))
      comment: "Total estimated payments reported in regulatory filings. Tracks prepayment adequacy for penalty avoidance."
    - name: "filing_count"
      expr: COUNT(1)
      comment: "Total regulatory filing count. Measures compliance workload and multi-jurisdiction filing complexity."
    - name: "rejected_filing_count"
      expr: COUNT(CASE WHEN filing_status = 'REJECTED' THEN 1 END)
      comment: "Count of rejected regulatory filings. Tracks compliance quality — rejections require resubmission and may trigger penalties."
    - name: "amended_filing_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN filing_is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory filings that are amendments. High rates indicate data quality or process issues in initial submissions."
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate across regulatory filings. Benchmarks tax burden by jurisdiction for financial planning."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset KPIs including acquisition cost, accumulated depreciation, net book value, and disposal metrics for asset management and financial reporting."
  source: "`vibe_health_insurance_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Category of fixed asset (Building, Equipment, Vehicle, IT, etc.)"
    - name: "asset_subcategory"
      expr: asset_subcategory
      comment: "Subcategory of fixed asset"
    - name: "asset_status"
      expr: asset_status
      comment: "Status of the asset (Active, Disposed, Retired, Under Maintenance, etc.)"
    - name: "asset_condition"
      expr: asset_condition
      comment: "Condition of the asset (Excellent, Good, Fair, Poor, etc.)"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (Straight Line, Declining Balance, Units of Production, etc.)"
    - name: "disposal_status"
      expr: disposal_status
      comment: "Disposal status of the asset"
    - name: "location_code"
      expr: location_code
      comment: "Location code where the asset is located"
    - name: "assigned_department"
      expr: assigned_department
      comment: "Department to which the asset is assigned"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition"
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of asset acquisition"
    - name: "disposal_year"
      expr: YEAR(disposal_date)
      comment: "Year of asset disposal"
    - name: "disposal_month"
      expr: DATE_TRUNC('MONTH', disposal_date)
      comment: "Month of asset disposal"
  measures:
    - name: "Total Acquisition Cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets"
    - name: "Total Accumulated Depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation on fixed assets"
    - name: "Total Net Book Value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets (cost minus accumulated depreciation)"
    - name: "Total Depreciation Amount"
      expr: SUM(CAST(depreciation_amount AS DOUBLE))
      comment: "Total depreciation amount for the period"
    - name: "Total Salvage Value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total salvage value of fixed assets"
    - name: "Total Disposal Proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals"
    - name: "Total Maintenance Cost"
      expr: SUM(CAST(maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost for fixed assets"
    - name: "Asset Count"
      expr: COUNT(1)
      comment: "Number of fixed assets"
    - name: "Distinct Cost Center Count"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of unique cost centers with fixed assets"
    - name: "Distinct Vendor Count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors from whom assets were acquired"
    - name: "Distinct Employee Count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees assigned to assets"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics for financial close quality, posting efficiency, and intercompany elimination tracking. Used by Controller, CFO, and external auditors to monitor GL integrity, period-close completeness, and intercompany balance management."
  source: "`vibe_health_insurance_v1`.`finance`.`journal_entry`"
  filter: is_active = TRUE
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Journal entry type (standard, adjusting, closing, reversing) for GL activity classification."
    - name: "entry_status"
      expr: entry_status
      comment: "Posting status (draft, posted, approved) for financial close workflow tracking."
    - name: "posting_status"
      expr: posting_status
      comment: "GL posting status for period-close completeness monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual GL activity and year-over-year comparison."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for period-close monitoring and monthly financial reporting."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for LOB-level P&L and cost allocation."
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Identifies intercompany journal entries requiring elimination in consolidated financials."
    - name: "is_consolidation_elimination"
      expr: is_consolidation_elimination
      comment: "Flags consolidation elimination entries for intercompany balance reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency consolidation analysis."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit postings in the GL. Used to verify debit-credit balance and detect out-of-balance entries."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit postings in the GL. Used with total debits to verify GL balance integrity."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net GL posting amount. Should be zero for a balanced ledger — non-zero values indicate out-of-balance conditions requiring investigation."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total journal entry count. Measures GL activity volume and period-close workload."
    - name: "unposted_entry_count"
      expr: COUNT(CASE WHEN posting_status != 'POSTED' THEN 1 END)
      comment: "Count of journal entries not yet posted to the GL. Tracks period-close backlog and financial reporting readiness."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN is_intercompany = TRUE THEN 1 END)
      comment: "Count of intercompany journal entries. Measures intercompany transaction volume requiring elimination in consolidation."
    - name: "avg_journal_entry_amount"
      expr: AVG(ABS(net_amount))
      comment: "Average absolute net journal entry amount. Benchmarks typical transaction size and identifies unusually large entries for audit review."
    - name: "statistical_amount_total"
      expr: SUM(CAST(statistical_amount AS DOUBLE))
      comment: "Total statistical (non-monetary) journal entry amounts. Used for headcount, unit, and volume-based allocations in management reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_mlr_financial_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Loss Ratio (MLR) financial performance metrics for ACA regulatory compliance and profitability management. Tracks incurred claims, quality improvement expenses, earned premium, MLR percentage, and rebate liability by line of business, market segment, and reporting year. Used by CFO, actuarial, and compliance leadership for CMS/DOI MLR filings and rebate management."
  source: "`vibe_health_insurance_v1`.`finance`.`mlr_financial_entry`"
  filter: is_active = TRUE
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (Individual, Small Group, Large Group) — ACA MLR is calculated separately per market segment."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for MLR segmentation per ACA regulatory requirements."
    - name: "reporting_year"
      expr: reporting_year
      comment: "Calendar year for which MLR is being reported. ACA requires annual MLR reporting and rebate calculation."
    - name: "state_code"
      expr: state_code
      comment: "State jurisdiction for state-level MLR reporting and rebate distribution."
    - name: "mlr_financial_entry_status"
      expr: mlr_financial_entry_status
      comment: "Status of the MLR entry (draft, submitted, accepted) for workflow tracking."
    - name: "submission_status"
      expr: submission_status
      comment: "Regulatory submission status for CMS/DOI MLR filing tracking."
  measures:
    - name: "total_incurred_claims"
      expr: SUM(CAST(incurred_claims_amount AS DOUBLE))
      comment: "Total incurred claims amount — the numerator of the MLR calculation. Directly drives ACA rebate liability and profitability assessment."
    - name: "total_quality_improvement_expenses"
      expr: SUM(CAST(quality_improvement_expenses AS DOUBLE))
      comment: "Total quality improvement (QI) expenses included in the MLR numerator per ACA rules. Tracks investment in care quality programs."
    - name: "total_earned_premium"
      expr: SUM(CAST(total_earned_premium AS DOUBLE))
      comment: "Total earned premium — the MLR denominator. Used to compute the MLR ratio and assess premium adequacy."
    - name: "total_rebate_liability"
      expr: SUM(CAST(rebate_liability_amount AS DOUBLE))
      comment: "Total MLR rebate liability owed to members/employers when MLR falls below ACA minimums. Critical financial obligation for CFO and treasury."
    - name: "avg_mlr_percentage"
      expr: AVG(CAST(mlr_percentage AS DOUBLE))
      comment: "Average MLR percentage across entries. Tracks whether the plan is meeting ACA minimum MLR thresholds (80% individual/small group, 85% large group)."
    - name: "mlr_numerator_total"
      expr: SUM(CAST(incurred_claims_amount AS DOUBLE) + CAST(quality_improvement_expenses AS DOUBLE))
      comment: "Combined MLR numerator (incurred claims plus QI expenses). Used to compute the final MLR ratio for regulatory filing."
    - name: "mlr_compliance_gap_amount"
      expr: SUM(CAST(total_earned_premium AS DOUBLE) * CAST(minimum_mlr_threshold AS DOUBLE) - (CAST(incurred_claims_amount AS DOUBLE) + CAST(quality_improvement_expenses AS DOUBLE)))
      comment: "Dollar gap between actual MLR numerator and the minimum required MLR threshold applied to earned premium. Positive values indicate rebate exposure; negative values indicate compliance headroom."
    - name: "entry_count"
      expr: COUNT(1)
      comment: "Count of MLR financial entries. Used to validate completeness of MLR data across all required market segments and states."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_premium_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic premium revenue performance metrics tracking earned premium, written premium, reinsurance ceded amounts, risk adjustment, and VBC shared savings by line of business, market segment, and plan. Used by CFO and actuarial leadership to monitor revenue recognition, risk corridor exposure, and value-based care economics."
  source: "`vibe_health_insurance_v1`.`finance`.`premium_revenue`"
  filter: is_active = TRUE
  dimensions:
    - name: "line_of_business"
      expr: lob
      comment: "Line of business (e.g. Commercial, Medicare, Medicaid) for revenue segmentation."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (e.g. Individual, Small Group, Large Group) for premium revenue analysis."
    - name: "premium_type"
      expr: premium_type
      comment: "Type of premium (e.g. standard, COBRA, APTC-subsidized) to differentiate revenue streams."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual revenue trending and budget comparison."
    - name: "fiscal_month"
      expr: fiscal_month
      comment: "Fiscal month for intra-year revenue monitoring and seasonality analysis."
    - name: "is_capitated"
      expr: is_capitated
      comment: "Flag indicating capitated vs. fee-for-service revenue arrangements."
    - name: "mlr_denominator_flag"
      expr: mlr_denominator_flag
      comment: "Indicates whether the premium record is included in the MLR denominator for regulatory reporting."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flags premium records subject to regulatory reporting requirements."
    - name: "revenue_date_month"
      expr: DATE_TRUNC('MONTH', revenue_date)
      comment: "Revenue recognition month for time-series trending."
  measures:
    - name: "total_written_premium"
      expr: SUM(CAST(written_premium AS DOUBLE))
      comment: "Total written premium — the gross premium billed before any adjustments. Core top-line revenue KPI for CFO and board reporting."
    - name: "total_earned_premium"
      expr: SUM(CAST(earned_premium AS DOUBLE))
      comment: "Total earned premium recognized in the period. Primary revenue recognition metric for GAAP and statutory reporting."
    - name: "total_net_earned_premium"
      expr: SUM(CAST(net_earned_premium AS DOUBLE))
      comment: "Net earned premium after reinsurance ceded. Represents the retained revenue exposure and is the MLR denominator."
    - name: "total_reinsurance_ceded_premium"
      expr: SUM(CAST(reinsurance_ceded_premium AS DOUBLE))
      comment: "Total premium ceded to reinsurers. Tracks risk transfer cost and reinsurance program utilization."
    - name: "total_capitation_amount"
      expr: SUM(CAST(capitation_amount AS DOUBLE))
      comment: "Total capitation payments made to providers under capitated arrangements. Key metric for VBC and managed care cost management."
    - name: "total_risk_corridor_adjustment"
      expr: SUM(CAST(risk_corridor_adjustment AS DOUBLE))
      comment: "Total ACA risk corridor adjustments. Tracks regulatory risk-sharing program impact on net revenue."
    - name: "total_vbc_shared_savings"
      expr: SUM(CAST(vbc_shared_savings_amount AS DOUBLE))
      comment: "Total value-based care shared savings earned. Measures VBC program financial performance and provider partnership returns."
    - name: "total_unearned_premium_reserve"
      expr: SUM(CAST(unearned_premium_reserve AS DOUBLE))
      comment: "Total unearned premium reserve (liability for future coverage periods). Critical for balance sheet accuracy and IBNR estimation."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor (RAF) across the member population. Drives CMS risk adjustment revenue and population health investment decisions."
    - name: "reinsurance_cession_rate"
      expr: ROUND(100.0 * SUM(CAST(reinsurance_ceded_premium AS DOUBLE)) / NULLIF(SUM(CAST(written_premium AS DOUBLE)), 0), 2)
      comment: "Percentage of written premium ceded to reinsurers. Measures reinsurance program scale and risk transfer efficiency."
    - name: "net_retention_rate"
      expr: ROUND(100.0 * SUM(CAST(net_earned_premium AS DOUBLE)) / NULLIF(SUM(CAST(earned_premium AS DOUBLE)), 0), 2)
      comment: "Percentage of earned premium retained after reinsurance cession. Key indicator of net risk exposure and reinsurance program adequacy."
    - name: "premium_record_count"
      expr: COUNT(1)
      comment: "Count of premium revenue records. Used to validate completeness of premium billing and revenue recognition cycles."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_reinsurance_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reinsurance program financial metrics tracking ceded premium, ceded losses, recoveries, and net reinsurance economics. Used by CFO, Chief Actuary, and Risk Management to evaluate reinsurance program cost-effectiveness, recovery performance, and net risk retention."
  source: "`vibe_health_insurance_v1`.`finance`.`reinsurance_transaction`"
  filter: is_active = TRUE
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Reinsurance transaction type (cession, assumption, settlement, recovery) for program activity classification."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Transaction processing status for settlement tracking and financial close."
    - name: "attachment_point_type"
      expr: attachment_point_type
      comment: "Type of reinsurance attachment (per-occurrence, aggregate stop-loss) for program structure analysis."
    - name: "is_ceded"
      expr: is_ceded
      comment: "Identifies ceded vs. assumed reinsurance transactions for net position calculation."
    - name: "is_stop_loss"
      expr: is_stop_loss
      comment: "Identifies stop-loss reinsurance transactions for catastrophic risk protection tracking."
    - name: "is_quota_share"
      expr: is_quota_share
      comment: "Identifies quota share arrangements for proportional reinsurance program analysis."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status for reinsurance receivable and payable management."
    - name: "coverage_start_month"
      expr: DATE_TRUNC('MONTH', coverage_start_date)
      comment: "Coverage period start month for reinsurance program cycle analysis."
  measures:
    - name: "total_ceded_premium"
      expr: SUM(CAST(ceded_premium_amount AS DOUBLE))
      comment: "Total premium ceded to reinsurers. Measures the cost of reinsurance protection and risk transfer program scale."
    - name: "total_ceded_loss"
      expr: SUM(CAST(ceded_loss_amount AS DOUBLE))
      comment: "Total losses ceded to reinsurers. Measures reinsurance recovery utilization and catastrophic loss protection value."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total reinsurance recoveries received. Tracks actual cash recovered from reinsurers against ceded losses."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net reinsurance transaction amount (recoveries minus ceded premium). Measures net cost/benefit of the reinsurance program."
    - name: "total_rbc_credit"
      expr: SUM(CAST(rbc_credit_amount AS DOUBLE))
      comment: "Total Risk-Based Capital credit from reinsurance arrangements. Measures capital relief provided by the reinsurance program for solvency management."
    - name: "reinsurance_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recovery_amount AS DOUBLE)) / NULLIF(SUM(CAST(ceded_loss_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of ceded losses actually recovered from reinsurers. Measures reinsurance counterparty performance and collection effectiveness."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total reinsurance transaction count. Measures reinsurance program activity volume."
    - name: "avg_attachment_point"
      expr: AVG(CAST(attachment_point_amount AS DOUBLE))
      comment: "Average reinsurance attachment point amount. Tracks the level of self-insured retention across the reinsurance portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_tax_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax compliance and liability metrics tracking tax filings, payment status, estimated vs. actual tax liability, and filing timeliness. Used by CFO, Tax Director, and compliance teams to manage tax obligations, avoid penalties, and ensure regulatory compliance."
  source: "`vibe_health_insurance_v1`.`finance`.`tax_filing`"
  filter: is_active = TRUE
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (premium tax, income tax, payroll tax) for tax obligation categorization."
    - name: "tax_category"
      expr: tax_category
      comment: "Tax category for detailed tax liability classification and reporting."
    - name: "filing_status"
      expr: filing_status
      comment: "Filing status (draft, filed, accepted, rejected) for compliance deadline tracking."
    - name: "tax_payment_status"
      expr: tax_payment_status
      comment: "Tax payment status for cash flow and penalty avoidance management."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction (federal, state, local) for multi-jurisdiction tax management."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for annual tax liability trending and year-over-year comparison."
    - name: "is_amended"
      expr: is_amended
      comment: "Identifies amended filings for audit risk and compliance quality tracking."
    - name: "filing_date_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Filing date month for tax compliance calendar management."
  measures:
    - name: "total_tax_liability"
      expr: SUM(CAST(tax_liability_amount AS DOUBLE))
      comment: "Total tax liability across all filings. Primary tax obligation metric for cash flow planning and regulatory compliance."
    - name: "total_final_tax_due"
      expr: SUM(CAST(final_tax_due_amount AS DOUBLE))
      comment: "Total final tax due after credits and estimated payments. Represents actual cash tax obligation."
    - name: "total_estimated_payments"
      expr: SUM(CAST(estimated_payments_amount AS DOUBLE))
      comment: "Total estimated tax payments made. Tracks prepayment adequacy and potential underpayment penalty exposure."
    - name: "total_taxable_base"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount (e.g., earned premium for premium tax). Used to verify effective tax rate calculations."
    - name: "filing_count"
      expr: COUNT(1)
      comment: "Total tax filing count. Measures tax compliance workload and multi-jurisdiction filing complexity."
    - name: "amended_filing_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tax filings that are amendments. High amendment rates indicate data quality issues or aggressive initial filing positions."
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate across filings. Benchmarks tax burden by jurisdiction and tax type for tax planning."
    - name: "payment_coverage_rate"
      expr: ROUND(100.0 * SUM(CAST(estimated_payments_amount AS DOUBLE)) / NULLIF(SUM(CAST(final_tax_due_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of final tax due covered by estimated payments. Values below 90% indicate underpayment penalty risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`finance_vbc_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value-based care settlement performance metrics tracking shared savings, quality scores, benchmark vs. actual expenditure, and settlement outcomes by VBC program and provider. Used by CFO, CMO, and VBC program leadership to evaluate provider partnership economics and VBC program ROI."
  source: "`vibe_health_insurance_v1`.`finance`.`vbc_settlement`"
  filter: is_active = TRUE
  dimensions:
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of VBC settlement (shared savings, shared risk, quality bonus) for program economics analysis."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status (pending, finalized, disputed, paid) for settlement lifecycle tracking."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the VBC settlement for cash flow and provider payment management."
    - name: "is_shared_risk"
      expr: is_shared_risk
      comment: "Identifies two-sided risk arrangements vs. upside-only shared savings programs."
    - name: "currency_code"
      expr: currency_code
      comment: "Settlement currency for multi-entity VBC program reporting."
    - name: "performance_period_start_month"
      expr: DATE_TRUNC('MONTH', performance_period_start)
      comment: "Performance period start month for VBC program cycle tracking."
  measures:
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual medical expenditure under VBC arrangements. Measures cost performance against benchmark targets."
    - name: "total_benchmark_expenditure"
      expr: SUM(CAST(benchmark_expenditure_amount AS DOUBLE))
      comment: "Total benchmark expenditure target for VBC programs. The reference point for shared savings/loss calculations."
    - name: "total_savings_amount"
      expr: SUM(CAST(savings_amount AS DOUBLE))
      comment: "Total gross savings generated (benchmark minus actual). Primary VBC program value creation metric."
    - name: "total_final_settlement_amount"
      expr: SUM(CAST(final_settlement_amount AS DOUBLE))
      comment: "Total final settlement payments to/from providers. Represents actual VBC financial transfers and program cost/benefit."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across VBC settlements. Quality gates determine shared savings eligibility — low scores forfeit savings."
    - name: "avg_shared_savings_percentage"
      expr: AVG(CAST(shared_savings_percentage AS DOUBLE))
      comment: "Average shared savings percentage across VBC contracts. Measures provider incentive generosity and program design."
    - name: "savings_rate"
      expr: ROUND(100.0 * SUM(CAST(savings_amount AS DOUBLE)) / NULLIF(SUM(CAST(benchmark_expenditure_amount AS DOUBLE)), 0), 2)
      comment: "Savings as a percentage of benchmark expenditure. Core VBC efficiency metric — measures how much below benchmark providers are performing."
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Total VBC settlement count. Measures VBC program scale and provider participation."
    - name: "avg_risk_adjustment_factor"
      expr: AVG(CAST(risk_adjustment_factor AS DOUBLE))
      comment: "Average risk adjustment factor applied to VBC settlements. Ensures fair comparison of provider performance across different patient populations."
$$;
