-- Metric views for domain: finance | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-30 04:55:25

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AP liability, aging, and payment-discipline KPIs for working-capital and cash-flow steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`accounts_payable`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Legal entity / company code for entity-level AP rollups."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Whether the payable is open or cleared/paid."
    - name: "document_currency"
      expr: document_currency
      comment: "Transaction currency of the payable."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Vendor payment terms (e.g. Net-30) for DPO analysis."
    - name: "payment_block_reason"
      expr: payment_block_reason
      comment: "Reason a payment is blocked, used to triage stuck disbursements."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the posting for period reporting."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month bucket for AP trend analysis."
  measures:
    - name: "total_open_payables"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding open AP balance — primary working-capital liability KPI."
    - name: "total_gross_payables"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoiced amount payable."
    - name: "total_discount_available"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discount value at risk if not captured."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax accrued for compliance reporting."
    - name: "avg_payable_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average invoice size to characterise vendor spend profile."
    - name: "payable_invoice_count"
      expr: COUNT(1)
      comment: "Count of AP documents — base volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AR aging, collections, and dispute KPIs for DSO and cash-collection steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Legal entity / company code for entity-level AR rollups."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Receivable aging bucket for collections prioritisation."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Whether the receivable is open or cleared/collected."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level applied to the receivable."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the receivable."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the posting for period reporting."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month bucket for AR trend analysis."
  measures:
    - name: "total_open_receivables"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding open AR balance — primary collections KPI."
    - name: "total_original_receivables"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total originally invoiced receivable amount."
    - name: "disputed_receivable_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(open_amount AS DOUBLE) ELSE 0 END)
      comment: "Open AR currently in dispute — collection risk indicator."
    - name: "disputed_receivable_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputed receivables for dispute backlog management."
    - name: "avg_receivable_amount"
      expr: AVG(CAST(open_amount AS DOUBLE))
      comment: "Average open receivable size."
    - name: "receivable_count"
      expr: COUNT(1)
      comment: "Count of AR documents — base volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL balance and posting KPIs for financial position, P&L, and EBITDA steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`general_ledger`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level financial reporting."
    - name: "account_type"
      expr: account_type
      comment: "GL account type (asset/liability/revenue/expense) for statement classification."
    - name: "segment"
      expr: segment
      comment: "Reporting segment for segmented financial analysis."
    - name: "revenue_stream_category"
      expr: revenue_stream_category
      comment: "Revenue stream category for revenue mix analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period reporting."
    - name: "posting_period"
      expr: posting_period
      comment: "Fiscal posting period for monthly close analysis."
  measures:
    - name: "total_debits"
      expr: SUM(CAST(debit_amount_functional_currency AS DOUBLE))
      comment: "Total debit postings in functional currency."
    - name: "total_credits"
      expr: SUM(CAST(credit_amount_functional_currency AS DOUBLE))
      comment: "Total credit postings in functional currency."
    - name: "net_balance"
      expr: SUM(CAST(net_balance_functional_currency AS DOUBLE))
      comment: "Net balance in functional currency — core ledger position KPI."
    - name: "closing_balance"
      expr: SUM(CAST(closing_balance_functional_currency AS DOUBLE))
      comment: "Closing balance in functional currency for balance-sheet rollup."
    - name: "budget_variance"
      expr: SUM(CAST(variance_amount_functional_currency AS DOUBLE))
      comment: "Total variance vs budget for plan-vs-actual steering."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_ebitda_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EBITDA, margin, and revenue/cost composition KPIs for executive profitability steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot`"
  dimensions:
    - name: "business_segment"
      expr: business_segment
      comment: "Business segment for segmented EBITDA reporting."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level profitability."
    - name: "snapshot_status"
      expr: snapshot_status
      comment: "Status of the EBITDA snapshot (draft/approved)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly EBITDA trend."
  measures:
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA — flagship profitability KPI."
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue across all streams."
    - name: "advertising_revenue"
      expr: SUM(CAST(advertising_revenue_amount AS DOUBLE))
      comment: "Advertising revenue contribution to top line."
    - name: "subscription_revenue"
      expr: SUM(CAST(subscription_revenue_amount AS DOUBLE))
      comment: "Subscription revenue contribution to top line."
    - name: "carriage_fee_revenue"
      expr: SUM(CAST(carriage_fee_revenue_amount AS DOUBLE))
      comment: "Carriage/affiliate fee revenue contribution."
    - name: "total_operating_expense"
      expr: SUM(CAST(total_operating_expense_amount AS DOUBLE))
      comment: "Total operating expense for cost-base monitoring."
    - name: "avg_ebitda_margin_pct"
      expr: AVG(CAST(ebitda_margin_percentage AS DOUBLE))
      comment: "Average EBITDA margin percentage across snapshots."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total EBITDA variance to budget for plan-vs-actual steering."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recognized and deferred revenue KPIs (ASC606/IFRS15) for revenue-assurance steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level revenue recognition."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method (point-in-time/over-time)."
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of the recognition event."
    - name: "platform_type"
      expr: platform_type
      comment: "Distribution platform driving the revenue."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly revenue trend."
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Recognition month bucket for revenue trend analysis."
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total recognized revenue — core revenue KPI."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total deferred revenue still to be recognised."
    - name: "asc606_compliant_events"
      expr: SUM(CASE WHEN asc_606_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ASC606-compliant recognition events for compliance assurance."
    - name: "avg_recognized_amount"
      expr: AVG(CAST(recognized_amount AS DOUBLE))
      comment: "Average recognized amount per event."
    - name: "recognition_event_count"
      expr: COUNT(1)
      comment: "Count of recognition events — base volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial close cycle-time, completeness, and reconciliation KPIs for controllership steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`period_close`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level close tracking."
    - name: "close_status"
      expr: close_status
      comment: "Status of the period close (open/in-progress/closed)."
    - name: "close_phase"
      expr: close_phase
      comment: "Current close phase for soft/hard close monitoring."
    - name: "period_type"
      expr: period_type
      comment: "Period type (month/quarter/year)."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period being closed."
  measures:
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(close_checklist_completion_pct AS DOUBLE))
      comment: "Average close-checklist completion — close-readiness KPI."
    - name: "total_unreconciled_amount"
      expr: SUM(CAST(unreconciled_amount AS DOUBLE))
      comment: "Total unreconciled amount at close — financial-risk indicator."
    - name: "total_ebitda_at_close"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "EBITDA reported at close for executive review."
    - name: "total_forecast_variance"
      expr: SUM(CAST(variance_to_forecast_amount AS DOUBLE))
      comment: "Total variance to forecast at close."
    - name: "reopened_period_count"
      expr: SUM(CASE WHEN reopen_count IS NOT NULL AND reopen_count <> '0' THEN 1 ELSE 0 END)
      comment: "Count of periods that were reopened — close-quality control indicator."
    - name: "period_close_count"
      expr: COUNT(1)
      comment: "Count of period-close records — base volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_financial_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GL-vs-subledger reconciliation variance and sign-off KPIs for SOX and audit control."
  source: "`vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level reconciliation tracking."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the reconciliation."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation performed."
    - name: "sign_off_status"
      expr: sign_off_status
      comment: "Sign-off status for control completeness."
    - name: "ebitda_reporting_segment"
      expr: ebitda_reporting_segment
      comment: "EBITDA reporting segment."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period reporting."
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total GL-vs-subledger variance — reconciliation risk KPI."
    - name: "total_gl_balance"
      expr: SUM(CAST(gl_balance_amount AS DOUBLE))
      comment: "Total GL balance under reconciliation."
    - name: "total_subledger_balance"
      expr: SUM(CAST(subledger_balance_amount AS DOUBLE))
      comment: "Total subledger balance under reconciliation."
    - name: "adjustments_required_count"
      expr: SUM(CASE WHEN adjustment_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reconciliations requiring adjustment — control-exception indicator."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across reconciliations."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Count of reconciliation records — base volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany volume, elimination, and settlement KPIs for consolidation steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "sending_company_code"
      expr: sending_company_code
      comment: "Sending company code for intercompany flow analysis."
    - name: "receiving_company_code"
      expr: receiving_company_code
      comment: "Receiving company code for intercompany flow analysis."
    - name: "elimination_status"
      expr: elimination_status
      comment: "Elimination status for consolidation completeness."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the intercompany transaction."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Transaction month bucket for trend analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction value."
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total amount in group currency for consolidation."
    - name: "unsettled_amount"
      expr: SUM(CASE WHEN settlement_status <> 'SETTLED' THEN CAST(transaction_amount AS DOUBLE) ELSE 0 END)
      comment: "Value of intercompany transactions not yet settled — settlement risk KPI."
    - name: "pending_elimination_count"
      expr: SUM(CASE WHEN elimination_flag = TRUE AND elimination_status <> 'ELIMINATED' THEN 1 ELSE 0 END)
      comment: "Count of transactions awaiting elimination for consolidation close."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Count of intercompany transactions — base volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production budget vs actual spend and variance KPIs for content-cost steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`production_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Status of the production budget."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of production budget."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved production budget — content-cost commitment KPI."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total actual spend to date against budgets."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (PO/contracted) amount."
    - name: "total_contingency"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserve in production budgets."
    - name: "total_budget_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance for overrun monitoring."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project budget, spend, and governance KPIs for investment steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`capex_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Status of the capex project."
    - name: "project_classification"
      expr: project_classification
      comment: "Classification of the capital investment."
    - name: "business_area"
      expr: business_area
      comment: "Business area sponsoring the project."
    - name: "governance_review_status"
      expr: governance_review_status
      comment: "Governance review status for control oversight."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the capital project."
    - name: "fiscal_year_approval"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Approval-year bucket for capex vintage analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved capex budget — investment commitment KPI."
    - name: "total_cumulative_spend"
      expr: SUM(CAST(cumulative_spend_amount AS DOUBLE))
      comment: "Total cumulative spend across capital projects."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining capex budget available."
    - name: "avg_project_budget"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved budget per capital project."
    - name: "capex_project_count"
      expr: COUNT(1)
      comment: "Count of capital projects — base volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset book value, depreciation, and disposal KPIs for asset-base steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for asset-register segmentation."
    - name: "asset_status"
      expr: asset_status
      comment: "Status of the fixed asset (active/disposed)."
    - name: "business_area"
      expr: business_area
      comment: "Business area owning the asset."
    - name: "ebitda_reporting_segment"
      expr: ebitda_reporting_segment
      comment: "EBITDA reporting segment for asset rollup."
    - name: "company_code"
      expr: company_code
      comment: "Company code owning the asset."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of the asset base."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value — current asset-base valuation KPI."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across assets."
    - name: "total_disposal_gain_loss"
      expr: SUM(CAST(gain_loss_on_disposal AS DOUBLE))
      comment: "Total gain/loss on asset disposals."
    - name: "avg_remaining_useful_life"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life — reinvestment-planning indicator."
    - name: "fixed_asset_count"
      expr: COUNT(1)
      comment: "Count of fixed assets — base volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_depreciation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depreciation posting volume, accuracy, and run-health KPIs for asset accounting."
  source: "`vibe_media_broadcasting_v1`.`finance`.`depreciation_run`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code of the depreciation run."
    - name: "run_status"
      expr: run_status
      comment: "Status of the depreciation run."
    - name: "run_type"
      expr: run_type
      comment: "Type of depreciation run (planned/repeat/test)."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class processed in the run."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the run."
  measures:
    - name: "total_planned_depreciation"
      expr: SUM(CAST(planned_depreciation_amount AS DOUBLE))
      comment: "Total planned depreciation amount."
    - name: "total_posted_depreciation"
      expr: SUM(CAST(posted_depreciation_amount AS DOUBLE))
      comment: "Total posted depreciation — actual expense KPI."
    - name: "total_depreciation_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total planned-vs-posted depreciation variance."
    - name: "depreciation_run_count"
      expr: COUNT(1)
      comment: "Count of depreciation runs — base volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_tax_posting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax liability and rate KPIs by jurisdiction and type for tax compliance steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`tax_posting`"
  dimensions:
    - name: "tax_jurisdiction"
      expr: tax_jurisdiction
      comment: "Tax jurisdiction for jurisdiction-level reporting."
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (VAT/sales/withholding)."
    - name: "tax_reporting_country"
      expr: tax_reporting_country
      comment: "Reporting country for the tax posting."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the tax posting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the posting."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted — tax liability KPI."
    - name: "total_taxable_base"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base for effective-rate analysis."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate across postings."
    - name: "tax_posting_count"
      expr: COUNT(1)
      comment: "Count of tax postings — base volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation volume and intercompany KPIs for cost-distribution steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of cost allocation performed."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate cost."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the allocation."
    - name: "ebitda_reporting_segment"
      expr: ebitda_reporting_segment
      comment: "EBITDA reporting segment receiving the allocation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total allocated cost amount — cost-distribution KPI."
    - name: "intercompany_allocation_amount"
      expr: SUM(CASE WHEN intercompany_flag = TRUE THEN CAST(allocated_amount AS DOUBLE) ELSE 0 END)
      comment: "Allocated cost flagged as intercompany for consolidation."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage applied."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Count of allocation records — base volume measure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry volume, workflow, and control KPIs for close-process and SOX monitoring."
  source: "`vibe_media_broadcasting_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code of the journal entry."
    - name: "document_type"
      expr: document_type
      comment: "Document type of the journal entry."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Workflow/approval status of the entry."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the entry."
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period for close-process monitoring."
  measures:
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Count of journal entries — manual-posting volume indicator."
    - name: "parked_entry_count"
      expr: SUM(CASE WHEN parked_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of parked (unposted) entries — close-backlog indicator."
    - name: "reversal_entry_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversal entries — error/correction indicator."
    - name: "intercompany_entry_count"
      expr: SUM(CASE WHEN intercompany_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intercompany journal entries."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_budget_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget version performance and control metrics"
  source: "`vibe_media_broadcasting_v1`.`finance`.`budget_version`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget version"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center identifier"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center identifier"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget"
    - name: "version_type"
      expr: version_type
      comment: "Type of budget version"
    - name: "version_number"
      expr: version_number
      comment: "Version number"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of budget version records"
    - name: "total_approved_amount"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved budget amount"
    - name: "avg_variance_threshold_percentage"
      expr: AVG(CAST(variance_threshold_percentage AS DOUBLE))
      comment: "Average variance threshold percentage across budgets"
$$;