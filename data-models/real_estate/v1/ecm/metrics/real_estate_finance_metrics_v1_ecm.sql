-- Metric views for domain: finance | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics tracking revenue recognition, aging, collections performance, and tenant billing patterns"
  source: "`real_estate_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (e.g., open, paid, disputed, written off)"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging category for receivables analysis (e.g., current, 30-60 days, 60-90 days, 90+ days)"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for revenue recognition and period-over-period analysis"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice issuance for trend analysis"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance for seasonality and trend analysis"
    - name: "is_nsf"
      expr: nsf_flag
      comment: "Flag indicating non-sufficient funds payment failure"
    - name: "is_disputed"
      expr: CASE WHEN dispute_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Indicator for invoices under dispute"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(ar_invoice_id)
      comment: "Total number of AR invoices issued"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before adjustments"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after tax and adjustments"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied from payments against invoices"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total outstanding receivable amount not yet collected"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible bad debt"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount per invoice"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount successfully collected (applied / net)"
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount written off as bad debt"
    - name: "distinct_tenant_count"
      expr: COUNT(DISTINCT tenant_id)
      comment: "Number of unique tenants billed in the period"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking vendor spend, payment timing, cash flow obligations, and expense management"
  source: "`real_estate_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice (e.g., pending, approved, paid, void)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for spend control"
    - name: "expense_category"
      expr: expense_category
      comment: "Category of expense for spend analysis (e.g., maintenance, utilities, professional services)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., ACH, check, wire, credit card)"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating recurring expense for budget forecasting"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice receipt for trend analysis"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice receipt for seasonality and trend analysis"
    - name: "is_overdue"
      expr: CASE WHEN due_date < CURRENT_DATE() AND payment_date IS NULL THEN TRUE ELSE FALSE END
      comment: "Indicator for invoices past due date and unpaid"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(ap_invoice_id)
      comment: "Total number of AP invoices received"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts and tax"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid to vendors"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured for cash management efficiency"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount per invoice"
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available discounts captured through timely payment"
    - name: "payment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount paid"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors paid in the period"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_noi_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Operating Income statement metrics tracking property-level profitability, operating efficiency, and investment performance"
  source: "`real_estate_ecm`.`finance`.`noi_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Status of the NOI statement (e.g., draft, approved, published, restated)"
    - name: "statement_type"
      expr: statement_type
      comment: "Type of NOI statement (e.g., actual, budget, forecast, variance)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the NOI statement for year-over-year analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period performance tracking"
    - name: "period_frequency"
      expr: period_frequency
      comment: "Reporting frequency (e.g., monthly, quarterly, annual)"
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Flag indicating consolidated multi-property statement"
  measures:
    - name: "total_statement_count"
      expr: COUNT(noi_statement_id)
      comment: "Total number of NOI statements generated"
    - name: "total_pgi"
      expr: SUM(CAST(pgi AS DOUBLE))
      comment: "Total Potential Gross Income across all properties"
    - name: "total_vacancy_loss"
      expr: SUM(CAST(vacancy_loss AS DOUBLE))
      comment: "Total revenue loss due to vacancy and concessions"
    - name: "total_egi"
      expr: SUM(CAST(egi AS DOUBLE))
      comment: "Total Effective Gross Income (PGI minus vacancy loss plus other income)"
    - name: "total_operating_expenses"
      expr: SUM(CAST(total_operating_expenses AS DOUBLE))
      comment: "Total operating expenses before debt service"
    - name: "total_noi"
      expr: SUM(CAST(noi AS DOUBLE))
      comment: "Total Net Operating Income (EGI minus operating expenses) - primary profitability metric"
    - name: "total_debt_service"
      expr: SUM(CAST(debt_service AS DOUBLE))
      comment: "Total debt service payments for leverage analysis"
    - name: "avg_occupancy_rate_pct"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate across properties"
    - name: "avg_vacancy_rate_pct"
      expr: AVG(CAST(vacancy_rate AS DOUBLE))
      comment: "Average vacancy rate across properties"
    - name: "avg_dscr"
      expr: AVG(CAST(dscr AS DOUBLE))
      comment: "Average Debt Service Coverage Ratio - key lender covenant metric"
    - name: "noi_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(noi AS DOUBLE)) / NULLIF(SUM(CAST(egi AS DOUBLE)), 0), 2)
      comment: "NOI margin as percentage of EGI - operating efficiency metric"
    - name: "opex_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(total_operating_expenses AS DOUBLE)) / NULLIF(SUM(CAST(egi AS DOUBLE)), 0), 2)
      comment: "Operating expense ratio as percentage of EGI - cost efficiency metric"
    - name: "economic_vacancy_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(vacancy_loss AS DOUBLE)) / NULLIF(SUM(CAST(pgi AS DOUBLE)), 0), 2)
      comment: "Economic vacancy rate including physical vacancy and concessions"
    - name: "avg_noi_psf"
      expr: AVG(CAST(noi_psf AS DOUBLE))
      comment: "Average NOI per square foot for property performance benchmarking"
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique properties included in NOI reporting"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_debt_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debt instrument metrics tracking leverage, financing costs, covenant compliance, and capital structure management"
  source: "`real_estate_ecm`.`finance`.`debt_instrument`"
  dimensions:
    - name: "instrument_status"
      expr: instrument_status
      comment: "Current status of the debt instrument (e.g., active, matured, refinanced, defaulted)"
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of debt instrument (e.g., mortgage, construction loan, bridge loan, line of credit)"
    - name: "rate_type"
      expr: rate_type
      comment: "Interest rate structure (e.g., fixed, floating, hybrid)"
    - name: "recourse_type"
      expr: recourse_type
      comment: "Recourse structure (e.g., non-recourse, full recourse, limited recourse)"
    - name: "amortization_type"
      expr: amortization_type
      comment: "Amortization structure (e.g., fully amortizing, interest-only, balloon)"
    - name: "origination_year"
      expr: YEAR(origination_date)
      comment: "Year of loan origination for vintage analysis"
    - name: "maturity_year"
      expr: YEAR(maturity_date)
      comment: "Year of loan maturity for refinancing pipeline planning"
    - name: "is_cross_collateralized"
      expr: cross_collateralized
      comment: "Flag indicating cross-collateralized loan structure"
  measures:
    - name: "total_loan_count"
      expr: COUNT(debt_instrument_id)
      comment: "Total number of active debt instruments in portfolio"
    - name: "total_original_principal"
      expr: SUM(CAST(original_principal AS DOUBLE))
      comment: "Total original principal amount at loan origination"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total current outstanding loan balance - key leverage metric"
    - name: "total_debt_issuance_costs"
      expr: SUM(CAST(debt_issuance_costs AS DOUBLE))
      comment: "Total capitalized loan origination and issuance costs"
    - name: "weighted_avg_interest_rate_pct"
      expr: ROUND(SUM(CAST(interest_rate AS DOUBLE) * CAST(outstanding_balance AS DOUBLE)) / NULLIF(SUM(CAST(outstanding_balance AS DOUBLE)), 0), 4)
      comment: "Weighted average interest rate across portfolio by outstanding balance"
    - name: "avg_ltv_ratio_pct"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio - key leverage and risk metric"
    - name: "avg_dscr_covenant"
      expr: AVG(CAST(dscr_covenant_threshold AS DOUBLE))
      comment: "Average DSCR covenant threshold across loans"
    - name: "total_scheduled_payment"
      expr: SUM(CAST(scheduled_payment_amount AS DOUBLE))
      comment: "Total scheduled monthly debt service payment amount"
    - name: "principal_paydown_amount"
      expr: SUM((CAST(original_principal AS DOUBLE)) - (CAST(outstanding_balance AS DOUBLE)))
      comment: "Total principal paid down since origination"
    - name: "principal_paydown_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(original_principal AS DOUBLE)) - SUM(CAST(outstanding_balance AS DOUBLE))) / NULLIF(SUM(CAST(original_principal AS DOUBLE)), 0), 2)
      comment: "Percentage of original principal paid down - amortization progress metric"
    - name: "distinct_lender_count"
      expr: COUNT(DISTINCT lender_id)
      comment: "Number of unique lenders in portfolio for concentration risk analysis"
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of unique properties with debt financing"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line metrics tracking budget vs actual performance, variance analysis, and financial planning accuracy"
  source: "`real_estate_ecm`.`finance`.`budget_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the budget line (e.g., active, approved, locked, revised)"
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for hierarchical budget analysis"
    - name: "line_type"
      expr: line_type
      comment: "Type of budget line (e.g., revenue, expense, capital)"
    - name: "budget_scenario"
      expr: budget_scenario
      comment: "Budget scenario (e.g., base case, best case, worst case)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for year-over-year planning"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-level budget tracking"
    - name: "is_capex"
      expr: is_capex
      comment: "Flag indicating capital expenditure budget line"
    - name: "is_cam_recoverable"
      expr: is_cam_recoverable
      comment: "Flag indicating expense recoverable through CAM charges"
    - name: "noi_component"
      expr: noi_component
      comment: "NOI statement component classification"
  measures:
    - name: "total_budget_line_count"
      expr: COUNT(budget_line_id)
      comment: "Total number of budget lines in the plan"
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount across all lines"
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual amount incurred or earned"
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget after adjustments"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between actual and budget (positive = favorable for expenses, unfavorable for revenue)"
    - name: "budget_accuracy_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Budget accuracy as percentage of actual to budget - forecasting quality metric"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage across budget lines"
    - name: "favorable_variance_amount"
      expr: SUM(CASE WHEN CAST(variance_amount AS DOUBLE) > 0 THEN CAST(variance_amount AS DOUBLE) ELSE 0 END)
      comment: "Total favorable variance amount"
    - name: "unfavorable_variance_amount"
      expr: SUM(CASE WHEN CAST(variance_amount AS DOUBLE) < 0 THEN ABS(CAST(variance_amount AS DOUBLE)) ELSE 0 END)
      comment: "Total unfavorable variance amount"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_financial_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial forecast metrics tracking projected performance, investment returns, and strategic planning assumptions"
  source: "`real_estate_ecm`.`finance`.`financial_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (e.g., draft, approved, published, archived)"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., acquisition, disposition, hold, development)"
    - name: "forecast_scenario"
      expr: forecast_scenario
      comment: "Forecast scenario (e.g., base case, upside, downside, stress test)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast for planning horizon analysis"
    - name: "is_baseline"
      expr: is_baseline
      comment: "Flag indicating baseline forecast for scenario comparison"
  measures:
    - name: "total_forecast_count"
      expr: COUNT(financial_forecast_id)
      comment: "Total number of financial forecasts generated"
    - name: "total_projected_noi"
      expr: SUM(CAST(projected_noi AS DOUBLE))
      comment: "Total projected Net Operating Income across forecasts"
    - name: "total_projected_egi"
      expr: SUM(CAST(projected_egi AS DOUBLE))
      comment: "Total projected Effective Gross Income"
    - name: "total_projected_opex"
      expr: SUM(CAST(projected_opex AS DOUBLE))
      comment: "Total projected operating expenses"
    - name: "total_projected_capex"
      expr: SUM(CAST(projected_capex AS DOUBLE))
      comment: "Total projected capital expenditures for investment planning"
    - name: "total_projected_debt_service"
      expr: SUM(CAST(projected_debt_service AS DOUBLE))
      comment: "Total projected debt service payments"
    - name: "avg_projected_cap_rate_pct"
      expr: AVG(CAST(projected_cap_rate AS DOUBLE))
      comment: "Average projected capitalization rate for valuation"
    - name: "avg_projected_dscr"
      expr: AVG(CAST(projected_dscr AS DOUBLE))
      comment: "Average projected Debt Service Coverage Ratio for financing feasibility"
    - name: "avg_rent_growth_rate_pct"
      expr: AVG(CAST(rent_growth_rate AS DOUBLE))
      comment: "Average projected rent growth rate assumption"
    - name: "avg_vacancy_rate_assumption_pct"
      expr: AVG(CAST(vacancy_rate_assumption AS DOUBLE))
      comment: "Average vacancy rate assumption in forecasts"
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate for NPV and IRR calculations"
    - name: "projected_noi_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(projected_noi AS DOUBLE)) / NULLIF(SUM(CAST(projected_egi AS DOUBLE)), 0), 2)
      comment: "Projected NOI margin as percentage of EGI - forecasted operating efficiency"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry metrics tracking general ledger activity, posting volume, approval workflow, and accounting control effectiveness"
  source: "`real_estate_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the journal entry for control monitoring"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for period analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-close and reconciliation tracking"
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Flag indicating intercompany transaction requiring elimination"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag indicating reversal entry for accrual management"
    - name: "is_balanced"
      expr: is_balanced
      comment: "Flag indicating balanced entry (debits = credits) for data quality monitoring"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting for trend and volume analysis"
    - name: "noi_category"
      expr: noi_category
      comment: "NOI statement category for property-level reporting"
  measures:
    - name: "total_entry_count"
      expr: COUNT(journal_entry_id)
      comment: "Total number of journal entries posted"
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across all entries"
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across all entries"
    - name: "avg_entry_amount"
      expr: AVG(CAST(total_debit_amount AS DOUBLE))
      comment: "Average journal entry amount for materiality analysis"
    - name: "unbalanced_entry_count"
      expr: COUNT(CASE WHEN is_balanced = FALSE THEN journal_entry_id END)
      comment: "Count of unbalanced entries requiring correction - data quality metric"
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN journal_entry_id END)
      comment: "Count of reversal entries for accrual tracking"
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN is_intercompany = TRUE THEN journal_entry_id END)
      comment: "Count of intercompany entries requiring elimination"
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN journal_entry_id END)
      comment: "Count of entries pending approval for workflow monitoring"
    - name: "distinct_posted_by_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees posting entries for segregation of duties analysis"
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking capital asset base, depreciation, impairment, and asset lifecycle management"
  source: "`real_estate_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset (e.g., in service, under construction, disposed, impaired)"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for depreciation and reporting (e.g., building, land improvement, equipment, furniture)"
    - name: "asset_sub_class"
      expr: asset_sub_class
      comment: "Detailed asset sub-classification"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (e.g., straight-line, declining balance, units of production)"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition for vintage analysis"
    - name: "in_service_year"
      expr: YEAR(in_service_date)
      comment: "Year asset placed in service for depreciation start tracking"
    - name: "is_leed_certified"
      expr: leed_certified
      comment: "Flag indicating LEED green building certification"
  measures:
    - name: "total_asset_count"
      expr: COUNT(fixed_asset_id)
      comment: "Total number of fixed assets in the portfolio"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation to date"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value (acquisition cost minus accumulated depreciation) - key balance sheet metric"
    - name: "total_ytd_depreciation"
      expr: SUM(CAST(ytd_depreciation AS DOUBLE))
      comment: "Total year-to-date depreciation expense"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognized - asset quality indicator"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life assumption across assets"
    - name: "avg_depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Average depreciation rate as percentage of acquisition cost - asset age indicator"
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value of fixed assets for risk management"
$$;
