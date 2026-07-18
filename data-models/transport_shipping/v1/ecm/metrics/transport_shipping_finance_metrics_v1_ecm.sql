-- Metric views for domain: finance | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key accounts payable metrics for monitoring payment obligations, discount capture, and supplier payment performance in transport shipping operations."
  source: "`transport_shipping_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the payable (e.g., open, cleared, blocked)"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging classification of the payable (e.g., 0-30, 31-60, 61-90 days)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit memo, debit memo)"
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Method of payment (e.g., wire, check, ACH)"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the payable"
    - name: "payable_category"
      expr: payable_category
      comment: "Category of the payable (e.g., freight, fuel, maintenance)"
    - name: "payment_block_reason"
      expr: payment_block_reason
      comment: "Reason for payment block if applicable"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Whether the payable is an intercompany transaction"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting for time-series analysis"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice for trend analysis"
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross amount of all AP invoices — measures total payment obligations"
    - name: "total_net_payable_amount"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable amount after discounts — actual cash outflow obligation"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured — measures working capital optimization"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on payables for tax liability tracking"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax withheld on supplier payments"
    - name: "avg_net_payable_amount"
      expr: AVG(CAST(net_payable_amount AS DOUBLE))
      comment: "Average net payable per invoice — indicates typical payment size"
    - name: "payable_count"
      expr: COUNT(1)
      comment: "Total number of AP transactions for volume tracking"
    - name: "disputed_payable_count"
      expr: SUM(CASE WHEN dispute_flag = true THEN 1 ELSE 0 END)
      comment: "Number of disputed payables — indicates supplier relationship health"
    - name: "blocked_payment_count"
      expr: SUM(CASE WHEN payment_block_code IS NOT NULL AND payment_block_code != '' THEN 1 ELSE 0 END)
      comment: "Number of blocked payments requiring intervention"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers with outstanding payables"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key accounts receivable metrics for monitoring collections, credit exposure, and revenue realization in transport shipping."
  source: "`transport_shipping_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "receivable_status"
      expr: receivable_status
      comment: "Current status of the receivable (e.g., open, cleared, written off)"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging classification of the receivable"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for receivable analysis (e.g., enterprise, SMB)"
    - name: "service_line"
      expr: service_line
      comment: "Service line generating the receivable (e.g., express, freight, supply chain)"
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the receivable"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level indicating collection escalation stage"
    - name: "document_type"
      expr: document_type
      comment: "Type of AR document (invoice, credit note, etc.)"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Whether the receivable is intercompany"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting for trend analysis"
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Whether the receivable has been written off"
  measures:
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding receivable amount — key cash flow indicator"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross receivable amount before adjustments"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net receivable amount after discounts"
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit_exposure AS DOUBLE))
      comment: "Total credit exposure across all customers — risk indicator"
    - name: "total_discount_given"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts given to customers"
    - name: "avg_outstanding_per_customer"
      expr: AVG(CAST(outstanding_amount AS DOUBLE))
      comment: "Average outstanding amount per receivable record"
    - name: "receivable_count"
      expr: COUNT(1)
      comment: "Total number of AR transactions"
    - name: "disputed_receivable_count"
      expr: SUM(CASE WHEN dispute_flag = true THEN 1 ELSE 0 END)
      comment: "Number of disputed receivables — indicates billing quality issues"
    - name: "written_off_count"
      expr: SUM(CASE WHEN write_off_flag = true THEN 1 ELSE 0 END)
      comment: "Number of written-off receivables — bad debt indicator"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with outstanding receivables"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics for monitoring financial posting activity, accuracy, and control compliance."
  source: "`transport_shipping_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of journal document (e.g., SA, AB, KR)"
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the journal posting"
    - name: "currency_code"
      expr: currency_code
      comment: "Document currency code"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area for segment reporting"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether this is a reversal entry"
    - name: "manual_entry_flag"
      expr: manual_entry_flag
      comment: "Whether the entry was manually posted (SOX risk indicator)"
    - name: "source_system_code"
      expr: source_system_code
      comment: "Originating system of the journal entry"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting for period analysis"
    - name: "posting_key"
      expr: posting_key
      comment: "Posting key indicating debit/credit and account type"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit postings — one side of double-entry accounting"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit postings — balancing side of double-entry accounting"
    - name: "total_local_currency_debit"
      expr: SUM(CAST(local_currency_debit_amount AS DOUBLE))
      comment: "Total debits in local currency for consolidated reporting"
    - name: "total_local_currency_credit"
      expr: SUM(CAST(local_currency_credit_amount AS DOUBLE))
      comment: "Total credits in local currency for consolidated reporting"
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted"
    - name: "manual_entry_count"
      expr: SUM(CASE WHEN manual_entry_flag = true THEN 1 ELSE 0 END)
      comment: "Number of manual journal entries — SOX control risk indicator"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = true THEN 1 ELSE 0 END)
      comment: "Number of reversal entries — indicates correction frequency"
    - name: "distinct_document_count"
      expr: COUNT(DISTINCT document_number)
      comment: "Number of unique journal documents"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget management metrics for monitoring budget allocation, consumption, and variance across the transport shipping organization."
  source: "`transport_shipping_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget (e.g., operational, capital, project)"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., annual, quarterly, rolling)"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (e.g., draft, approved, closed)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency"
    - name: "planning_scenario"
      expr: planning_scenario
      comment: "Planning scenario (e.g., base case, optimistic, pessimistic)"
    - name: "subcategory"
      expr: subcategory
      comment: "Budget subcategory for detailed analysis"
    - name: "ebitda_impact_flag"
      expr: ebitda_impact_flag
      comment: "Whether the budget item impacts EBITDA"
  measures:
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved budget amount — authorized spending ceiling"
    - name: "total_consumed_amount"
      expr: SUM(CAST(consumed_amount AS DOUBLE))
      comment: "Total consumed budget — actual spending against budget"
    - name: "total_available_amount"
      expr: SUM(CAST(available_amount AS DOUBLE))
      comment: "Total remaining available budget — spending headroom"
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total allocated budget across cost centers"
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of budget records"
    - name: "avg_budget_approved"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved budget per budget item"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics for monitoring fleet and infrastructure asset values, depreciation, and capital efficiency in transport shipping."
  source: "`transport_shipping_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class (e.g., vehicles, aircraft, warehouses, IT equipment)"
    - name: "asset_class_name"
      expr: asset_class_name
      comment: "Descriptive name of the asset class"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset (e.g., active, disposed, under construction)"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g., straight-line, declining balance)"
    - name: "asset_location_name"
      expr: asset_location_name
      comment: "Physical location of the asset"
    - name: "country_code"
      expr: country_code
      comment: "Country where asset is located"
    - name: "capex_category"
      expr: capex_category
      comment: "Capital expenditure category"
    - name: "currency_code"
      expr: currency_code
      comment: "Asset value currency"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition for vintage analysis"
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Whether the asset has been impaired"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total original acquisition cost of all assets — gross capital invested"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value — current carrying value of asset base"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — measures asset consumption"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss_amount AS DOUBLE))
      comment: "Total impairment losses recognized"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets in years"
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution metrics for monitoring disbursement efficiency, payment processing, and cash outflow management."
  source: "`transport_shipping_ecm`.`finance`.`payment_run`"
  dimensions:
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Status of the payment run (e.g., scheduled, executed, failed)"
    - name: "payment_run_type"
      expr: payment_run_type
      comment: "Type of payment run (e.g., regular, urgent, manual)"
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Payment method used (e.g., wire, ACH, check)"
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment run"
    - name: "payment_run_month"
      expr: DATE_TRUNC('month', payment_run_date)
      comment: "Month of payment run execution"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total amount disbursed across all payment runs"
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured in payment runs"
    - name: "net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Net cash disbursed after discounts and withholdings"
    - name: "total_withholding_tax"
      expr: SUM(CAST(total_withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments"
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Number of payment runs executed"
    - name: "avg_payment_per_run"
      expr: AVG(CAST(total_payment_amount AS DOUBLE))
      comment: "Average payment amount per run — indicates batch size"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_intercompany_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany settlement metrics for monitoring transfer pricing, netting efficiency, and elimination accuracy across legal entities."
  source: "`transport_shipping_ecm`.`finance`.`intercompany_settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Status of the intercompany settlement"
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (e.g., service charge, cost allocation, loan)"
    - name: "service_category"
      expr: service_category
      comment: "Category of intercompany service provided"
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing methodology applied"
    - name: "group_currency_code"
      expr: group_currency_code
      comment: "Group reporting currency"
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Whether the settlement requires consolidation elimination"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this is a reversal of a prior settlement"
    - name: "settlement_month"
      expr: DATE_TRUNC('month', settlement_date)
      comment: "Month of settlement for trend analysis"
  measures:
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total intercompany settlement amount — measures IC activity volume"
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Net settlement after netting — actual cash movement between entities"
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total intercompany interest charged"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on intercompany transactions"
    - name: "settlement_count"
      expr: COUNT(1)
      comment: "Number of intercompany settlements"
    - name: "avg_settlement_amount"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per transaction"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_tax_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax filing metrics for monitoring tax compliance, filing timeliness, and tax liability across jurisdictions in global transport operations."
  source: "`transport_shipping_ecm`.`finance`.`tax_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the tax filing (e.g., draft, submitted, accepted)"
    - name: "filing_type"
      expr: filing_type
      comment: "Type of tax filing (e.g., VAT, income tax, customs duty)"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Tax jurisdiction code for geographic compliance tracking"
    - name: "filing_method"
      expr: filing_method
      comment: "Method of filing (e.g., electronic, paper)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the tax liability"
    - name: "amendment_flag"
      expr: amendment_flag
      comment: "Whether this is an amended filing"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the tax filing"
    - name: "filing_period_month"
      expr: DATE_TRUNC('month', filing_period_start_date)
      comment: "Filing period start month"
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability filed — key compliance and cash flow metric"
    - name: "total_taxable_base_amount"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount across filings"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties incurred — compliance failure indicator"
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest on late tax payments"
    - name: "filing_count"
      expr: COUNT(1)
      comment: "Number of tax filings submitted"
    - name: "amended_filing_count"
      expr: SUM(CASE WHEN amendment_flag = true THEN 1 ELSE 0 END)
      comment: "Number of amended filings — indicates initial filing accuracy"
    - name: "avg_audit_risk_score"
      expr: AVG(CAST(audit_risk_score AS DOUBLE))
      comment: "Average audit risk score across filings — risk exposure indicator"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_bank_statement_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank statement line metrics for monitoring cash flow, reconciliation efficiency, and banking transaction patterns."
  source: "`transport_shipping_ecm`.`finance`.`bank_statement_line`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of bank transaction (e.g., payment, receipt, fee, interest)"
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Whether the transaction is a debit or credit"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the line item"
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Currency of the bank transaction"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area associated with the transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of the bank transaction"
    - name: "manual_reconciliation_flag"
      expr: manual_reconciliation_flag
      comment: "Whether manual reconciliation was required"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount across all bank statement lines"
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total amount in local currency for consolidated cash reporting"
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank charges incurred — cost of banking services"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on bank transactions"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of bank statement line items"
    - name: "unreconciled_count"
      expr: SUM(CASE WHEN reconciliation_status != 'reconciled' THEN 1 ELSE 0 END)
      comment: "Number of unreconciled items — indicates reconciliation backlog"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per line item"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics for monitoring overhead distribution, allocation accuracy, and cost transparency across the logistics network."
  source: "`transport_shipping_ecm`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of cost allocation (e.g., direct, indirect, activity-based)"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation (e.g., planned, posted, reversed)"
    - name: "allocation_basis_type"
      expr: allocation_basis_type
      comment: "Basis for allocation (e.g., headcount, revenue, volume)"
    - name: "service_line"
      expr: service_line
      comment: "Service line receiving the allocation"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area for segment analysis"
    - name: "controlling_area_code"
      expr: controlling_area_code
      comment: "Controlling area governing the allocation"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether this is a reversal of a prior allocation"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of allocation posting"
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated across cost centers — overhead distribution volume"
    - name: "total_allocation_basis_quantity"
      expr: SUM(CAST(allocation_basis_quantity AS DOUBLE))
      comment: "Total allocation basis quantity (e.g., hours, units, headcount)"
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage — indicates distribution concentration"
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Number of cost allocation transactions"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = true THEN 1 ELSE 0 END)
      comment: "Number of reversed allocations — indicates allocation accuracy issues"
    - name: "avg_allocated_amount"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average allocated amount per transaction"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_lease_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease contract metrics for monitoring fleet and facility lease obligations, IFRS 16 compliance, and lease portfolio management."
  source: "`transport_shipping_ecm`.`finance`.`lease_contract`"
  dimensions:
    - name: "lease_classification"
      expr: lease_classification
      comment: "Lease classification (e.g., operating, finance) per IFRS 16"
    - name: "lease_category"
      expr: lease_category
      comment: "Category of leased asset (e.g., vehicle, warehouse, aircraft)"
    - name: "accounting_standard"
      expr: accounting_standard
      comment: "Applicable accounting standard (e.g., IFRS 16, ASC 842)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the lease contract"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of lease payments (e.g., monthly, quarterly)"
    - name: "currency"
      expr: currency
      comment: "Lease currency"
    - name: "is_renewable"
      expr: is_renewable
      comment: "Whether the lease has renewal options"
    - name: "status"
      expr: lease_contract_status
      comment: "Current contract status (e.g., active, expired, terminated)"
  measures:
    - name: "total_lease_liability"
      expr: SUM(CAST(total_lease_liability AS DOUBLE))
      comment: "Total lease liability on balance sheet — IFRS 16 obligation"
    - name: "total_capitalized_amount"
      expr: SUM(CAST(capitalized_amount AS DOUBLE))
      comment: "Total right-of-use asset capitalized amount"
    - name: "total_lease_amount"
      expr: SUM(CAST(lease_amount AS DOUBLE))
      comment: "Total periodic lease payment amount"
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total residual value of leased assets at end of term"
    - name: "lease_contract_count"
      expr: COUNT(1)
      comment: "Number of active lease contracts"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average incremental borrowing rate across lease portfolio"
    - name: "total_early_termination_fee"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Total potential early termination fees — exit cost exposure"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`finance_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual metrics for monitoring period-end adjustments, revenue/expense recognition accuracy, and financial close quality."
  source: "`transport_shipping_ecm`.`finance`.`accrual`"
  dimensions:
    - name: "accrual_type"
      expr: accrual_type
      comment: "Type of accrual (e.g., revenue, expense, provision)"
    - name: "accrual_status"
      expr: accrual_status
      comment: "Current status of the accrual (e.g., open, reversed, posted)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual"
    - name: "currency_code"
      expr: currency_code
      comment: "Accrual currency"
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area for the accrual"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Whether this is an intercompany accrual"
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of accrual posting"
  measures:
    - name: "total_accrual_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total accrual amount — measures period-end adjustment magnitude"
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total accruals in functional currency for consolidated view"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of accruals"
    - name: "accrual_count"
      expr: COUNT(1)
      comment: "Number of accrual entries"
    - name: "avg_accrual_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average accrual amount — indicates typical adjustment size"
$$;
