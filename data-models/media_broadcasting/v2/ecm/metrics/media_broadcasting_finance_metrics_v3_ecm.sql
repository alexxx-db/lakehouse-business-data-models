-- Metric views for domain: finance | Business: Media_Broadcasting | Version: 3 | Generated on: 2026-07-10 19:06:42

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core general ledger KPIs tracking net balances, budget variance, and revenue vs. cost composition by fiscal period, segment, and account type. Used by CFO and controllers for period-end financial steering."
  source: "`vibe_media_broadcasting_v1`.`finance`.`general_ledger`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period financial analysis."
    - name: "posting_period"
      expr: posting_period
      comment: "Accounting posting period within the fiscal year for monthly close analysis."
    - name: "account_type"
      expr: account_type
      comment: "GL account type (P&L, Balance Sheet) for financial statement classification."
    - name: "gl_account"
      expr: gl_account
      comment: "General ledger account code for granular cost and revenue tracking."
    - name: "segment"
      expr: segment
      comment: "Business segment for segment-level P&L reporting."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for entity-level financial reporting."
    - name: "document_type"
      expr: document_type
      comment: "GL document type (invoice, journal, accrual) for transaction classification."
    - name: "ebitda_indicator"
      expr: ebitda_indicator
      comment: "Flag indicating whether the GL line contributes to EBITDA calculation."
  measures:
    - name: "total_net_balance_functional_currency"
      expr: SUM(CAST(net_balance_functional_currency AS DOUBLE))
      comment: "Total net GL balance in functional currency. Core financial position metric used by controllers and CFO for period-end close and balance sheet review."
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount_functional_currency AS DOUBLE))
      comment: "Total debit postings in functional currency. Used to assess gross expenditure and cost flows across the ledger."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount_functional_currency AS DOUBLE))
      comment: "Total credit postings in functional currency. Used to assess gross revenue and liability flows across the ledger."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount_functional_currency AS DOUBLE))
      comment: "Total budgeted amount in functional currency. Baseline for budget vs. actual variance analysis."
    - name: "total_variance_from_budget"
      expr: SUM(CAST(variance_amount_functional_currency AS DOUBLE))
      comment: "Total variance between actual and budgeted GL amounts. Negative variance signals overspend; used in steering meetings to trigger budget reallocation decisions."
    - name: "ebitda_net_balance"
      expr: SUM(CASE WHEN ebitda_indicator = TRUE THEN net_balance_functional_currency ELSE 0 END)
      comment: "Net GL balance restricted to EBITDA-contributing lines. Provides a ledger-level EBITDA contribution view for executive reporting."
    - name: "closing_balance_total"
      expr: SUM(CAST(closing_balance_functional_currency AS DOUBLE))
      comment: "Sum of period closing balances across all GL accounts. Used for balance sheet roll-forward and period-end financial position assessment."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_ebitda_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive EBITDA and P&L KPIs derived from periodic snapshots. Tracks revenue composition, cost structure, margin performance, and budget/forecast variance by business segment, cost center, and fiscal period. Primary dashboard for CFO, CEO, and board reporting."
  source: "`vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual and year-to-date EBITDA trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly EBITDA and margin tracking."
    - name: "business_segment"
      expr: business_segment
      comment: "Business segment (e.g., broadcast, streaming, syndication) for segment-level P&L decomposition."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for entity-level EBITDA reporting."
    - name: "snapshot_status"
      expr: snapshot_status
      comment: "Status of the EBITDA snapshot (draft, approved, locked) for data quality filtering."
    - name: "covenant_compliance_flag"
      expr: covenant_compliance_flag
      comment: "Indicates whether the period meets debt covenant EBITDA thresholds. Critical for lender reporting."
  measures:
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA across all snapshots. Primary executive KPI for operational profitability assessment and covenant compliance monitoring."
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue across all revenue streams. Top-line metric for revenue growth tracking and investor reporting."
    - name: "total_advertising_revenue"
      expr: SUM(CAST(advertising_revenue_amount AS DOUBLE))
      comment: "Total advertising revenue. Key revenue driver for broadcast and streaming businesses; tracked against upfront and scatter commitments."
    - name: "total_subscription_revenue"
      expr: SUM(CAST(subscription_revenue_amount AS DOUBLE))
      comment: "Total subscription revenue. Recurring revenue stream critical for valuation and churn impact analysis."
    - name: "total_syndication_revenue"
      expr: SUM(CAST(syndication_revenue_amount AS DOUBLE))
      comment: "Total syndication revenue. Tracks content monetization through third-party distribution deals."
    - name: "total_carriage_fee_revenue"
      expr: SUM(CAST(carriage_fee_revenue_amount AS DOUBLE))
      comment: "Total carriage fee revenue from distribution partners. Tracks affiliate fee income critical to broadcast network economics."
    - name: "total_direct_cost"
      expr: SUM(CAST(total_direct_cost_amount AS DOUBLE))
      comment: "Total direct costs including content acquisition, production, and distribution. Used to assess cost of revenue and gross margin."
    - name: "total_operating_expense"
      expr: SUM(CAST(total_operating_expense_amount AS DOUBLE))
      comment: "Total operating expenses. Used to assess operational efficiency and cost discipline relative to revenue growth."
    - name: "total_content_acquisition_cost"
      expr: SUM(CAST(content_acquisition_cost_amount AS DOUBLE))
      comment: "Total content acquisition spend. Largest cost driver for media companies; tracked against content ROI and rights amortization schedules."
    - name: "total_production_cost"
      expr: SUM(CAST(production_cost_amount AS DOUBLE))
      comment: "Total production costs. Tracks original content investment against budget and revenue return."
    - name: "avg_ebitda_margin_pct"
      expr: AVG(CAST(ebitda_margin_percentage AS DOUBLE))
      comment: "Average EBITDA margin percentage across snapshots. Key profitability ratio used in board decks and investor presentations."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_percentage AS DOUBLE))
      comment: "Average gross margin percentage. Measures revenue efficiency after direct costs; used to benchmark against industry peers."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total EBITDA variance vs. budget. Negative values trigger management intervention and reforecast cycles."
    - name: "total_forecast_variance"
      expr: SUM(CAST(forecast_variance_amount AS DOUBLE))
      comment: "Total EBITDA variance vs. latest forecast. Used in rolling forecast reviews to assess forecast accuracy and business trajectory."
    - name: "total_personnel_expense"
      expr: SUM(CAST(personnel_expense_amount AS DOUBLE))
      comment: "Total personnel expense. Largest controllable cost line; tracked for headcount efficiency and compensation benchmarking."
    - name: "total_technology_expense"
      expr: SUM(CAST(technology_expense_amount AS DOUBLE))
      comment: "Total technology expense. Tracks infrastructure and platform investment relative to revenue and digital transformation goals."
    - name: "prior_period_ebitda_total"
      expr: SUM(CAST(prior_period_ebitda_amount AS DOUBLE))
      comment: "Prior period EBITDA total for year-over-year and period-over-period comparison. Enables trend analysis in executive reviews."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging, collection efficiency, and dispute KPIs. Used by CFO, treasury, and revenue assurance teams to manage cash flow, DSO, and credit risk."
  source: "`vibe_media_broadcasting_v1`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual AR trend and aging analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AR balance and collection tracking."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket (current, 30, 60, 90+ days) for collection prioritization and credit risk assessment."
    - name: "document_type"
      expr: document_type
      comment: "AR document type (invoice, credit memo, debit memo) for transaction classification."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Payment clearing status for open vs. cleared item analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates disputed AR items requiring resolution before collection."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for cash application and collection channel analysis."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit for AR performance benchmarking across divisions."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level for overdue accounts, indicating collection urgency."
  measures:
    - name: "total_open_ar"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open (uncollected) AR balance. Primary cash flow metric; high open AR signals collection risk and working capital pressure."
    - name: "total_original_ar"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original billed AR amount. Baseline for collection rate and write-off analysis."
    - name: "total_disputed_ar"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN open_amount ELSE 0 END)
      comment: "Total AR balance under dispute. Disputed AR blocks cash collection; tracked to prioritize resolution and protect revenue."
    - name: "count_overdue_accounts"
      expr: COUNT(DISTINCT CASE WHEN days_past_due IS NOT NULL AND days_past_due != '0' THEN accounts_receivable_id END)
      comment: "Count of overdue AR records. Operational metric for collections team workload and credit risk exposure."
    - name: "total_local_currency_ar"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total AR balance in local currency. Used for multi-currency treasury management and FX exposure analysis."
    - name: "count_disputed_items"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed AR items. High dispute counts indicate billing quality issues or customer satisfaction problems requiring process improvement."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable liability, payment efficiency, and discount capture KPIs. Used by CFO, treasury, and procurement to manage cash outflows, vendor relationships, and working capital optimization."
  source: "`vibe_media_broadcasting_v1`.`finance`.`accounts_payable`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual AP spend and liability trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AP balance and payment cycle tracking."
    - name: "document_type"
      expr: document_type
      comment: "AP document type (vendor invoice, credit memo) for payable classification."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for cash disbursement channel analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Vendor payment terms for DPO analysis and early payment discount optimization."
    - name: "clearing_status"
      expr: clearing_status
      comment: "Payment clearing status for open vs. paid liability tracking."
    - name: "payment_block"
      expr: payment_block
      comment: "Payment block indicator for identifying held invoices requiring resolution."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for compliance-relevant AP transactions requiring audit trail."
  measures:
    - name: "total_gross_ap"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP liability. Primary working capital metric; tracks total vendor payment obligations outstanding."
    - name: "total_open_ap"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open (unpaid) AP balance. Cash flow planning metric; used by treasury to forecast payment runs and manage liquidity."
    - name: "total_net_ap"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP after discounts and adjustments. Reflects actual cash outflow obligation for payment planning."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimization; uncaptured discounts represent lost savings."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on AP invoices. Used for tax liability reporting and VAT/GST reclaim analysis."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on vendor payments. Regulatory compliance metric for cross-border vendor payment reporting."
    - name: "count_blocked_invoices"
      expr: COUNT(CASE WHEN payment_block IS NOT NULL AND payment_block != '' THEN 1 END)
      comment: "Number of invoices with payment blocks. Blocked invoices delay vendor payments and damage supplier relationships; tracked for operational resolution."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center budget capacity and operational status KPIs. Used by finance business partners and department heads to manage budget allocation, cost center health, and organizational cost structure."
  source: "`vibe_media_broadcasting_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Cost center type (production, overhead, shared services) for cost structure analysis."
    - name: "cost_center_category"
      expr: cost_center_category
      comment: "Cost center category for grouping related cost centers in hierarchical reporting."
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Active/inactive status for filtering operational cost centers."
    - name: "ebitda_reporting_segment"
      expr: ebitda_reporting_segment
      comment: "EBITDA reporting segment for segment-level cost allocation analysis."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area (content, technology, sales) for cross-functional cost benchmarking."
    - name: "is_revenue_generating"
      expr: is_revenue_generating
      comment: "Distinguishes revenue-generating cost centers from pure cost centers for margin analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level cost center portfolio analysis."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control scope flag for compliance-relevant cost centers."
  measures:
    - name: "total_annual_budget"
      expr: SUM(CAST(annual_budget_amount AS DOUBLE))
      comment: "Total annual budget across all cost centers. Baseline for budget utilization and variance analysis at organizational level."
    - name: "avg_annual_budget_per_cost_center"
      expr: AVG(CAST(annual_budget_amount AS DOUBLE))
      comment: "Average annual budget per cost center. Used to identify over- or under-resourced cost centers relative to organizational norms."
    - name: "count_active_cost_centers"
      expr: COUNT(CASE WHEN cost_center_status = 'Active' THEN 1 END)
      comment: "Number of active cost centers. Tracks organizational cost structure complexity and spans of financial control."
    - name: "count_revenue_generating_cost_centers"
      expr: COUNT(CASE WHEN is_revenue_generating = TRUE THEN 1 END)
      comment: "Number of revenue-generating cost centers. Used to assess the ratio of profit centers to overhead centers in the organizational structure."
    - name: "count_sox_controlled_cost_centers"
      expr: COUNT(CASE WHEN sox_control_flag = TRUE THEN 1 END)
      comment: "Number of cost centers in SOX control scope. Used by internal audit to size the SOX compliance program and resource audit activities."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset portfolio, depreciation, and disposal KPIs. Used by CFO, asset management, and finance teams to track capital investment, asset utilization, net book value, and disposal gains/losses."
  source: "`vibe_media_broadcasting_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (broadcast equipment, buildings, IT) for capital portfolio composition analysis."
    - name: "asset_status"
      expr: asset_status
      comment: "Asset lifecycle status (active, disposed, under construction) for portfolio health monitoring."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (straight-line, declining balance) for accounting policy analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level asset portfolio reporting."
    - name: "ebitda_reporting_segment"
      expr: ebitda_reporting_segment
      comment: "EBITDA segment for segment-level capital intensity analysis."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for assets subject to financial reporting controls."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets. Measures total capital invested in the asset base; key input for capital intensity ratios."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets after accumulated depreciation. Balance sheet asset value; used for leverage ratio and asset coverage calculations."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across the asset base. Measures asset age and replacement cycle urgency; high accumulated depreciation signals capital refresh needs."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Tracks capital recycling and asset monetization activity."
    - name: "total_gain_loss_on_disposal"
      expr: SUM(CAST(gain_loss_on_disposal AS DOUBLE))
      comment: "Total gain or loss on asset disposals. P&L impact of asset lifecycle management; negative values indicate below-book disposals requiring explanation."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life across the asset base. Indicates capital refresh urgency; declining average signals upcoming capex requirements."
    - name: "count_active_assets"
      expr: COUNT(CASE WHEN asset_status = 'Active' THEN 1 END)
      comment: "Count of active fixed assets. Tracks the size of the operational asset base for asset management and insurance purposes."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure project portfolio KPIs tracking budget utilization, spend efficiency, and project status. Used by CFO, capital planning, and investment committees to govern capex allocation and project delivery."
  source: "`vibe_media_broadcasting_v1`.`finance`.`capex_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Capex project status (approved, in-progress, completed, cancelled) for portfolio health monitoring."
    - name: "project_classification"
      expr: project_classification
      comment: "Project classification (maintenance, growth, regulatory) for strategic investment mix analysis."
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class being created for capital investment composition analysis."
    - name: "company_code"
      expr: company_code
      comment: "Company code for entity-level capex portfolio reporting."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Project risk rating for investment committee risk-adjusted portfolio review."
    - name: "governance_review_status"
      expr: governance_review_status
      comment: "Governance review status for tracking investment approval pipeline."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for capex projects subject to financial reporting controls."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved capex budget across all projects. Primary capital allocation metric for investment committee and board reporting."
    - name: "total_cumulative_spend"
      expr: SUM(CAST(cumulative_spend_amount AS DOUBLE))
      comment: "Total cumulative spend across all capex projects. Tracks capital deployment rate against approved budgets."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining unspent capex budget. Used by treasury for cash flow forecasting and by capital planning for reallocation decisions."
    - name: "avg_budget_utilization_pct"
      expr: AVG(ROUND(100.0 * cumulative_spend_amount / NULLIF(approved_budget_amount, 0), 2))
      comment: "Average budget utilization percentage across capex projects. Low utilization may indicate project delays; high utilization signals budget pressure."
    - name: "count_active_projects"
      expr: COUNT(CASE WHEN project_status = 'In-Progress' THEN 1 END)
      comment: "Number of active capex projects. Tracks capital program execution capacity and resource demand."
    - name: "count_overbudget_projects"
      expr: COUNT(CASE WHEN cumulative_spend_amount > approved_budget_amount THEN 1 END)
      comment: "Number of projects exceeding approved budget. Critical governance metric; overbudget projects require investment committee escalation and reapproval."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_depreciation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset depreciation schedule KPIs tracking depreciation charges, net book value, and impairment. Used by finance and asset management teams for depreciation planning, impairment testing, and balance sheet management."
  source: "`vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule`"
  dimensions:
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method for accounting policy consistency analysis."
    - name: "depreciation_book_type"
      expr: depreciation_book_type
      comment: "Depreciation book type (tax, GAAP, IFRS) for multi-GAAP reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual depreciation charge planning and actuals comparison."
    - name: "approval_status"
      expr: approval_status
      comment: "Schedule approval status for governance and audit readiness."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Impairment flag for identifying assets requiring write-down assessment."
    - name: "depreciation_schedule_status"
      expr: depreciation_schedule_status
      comment: "Schedule lifecycle status for active vs. closed schedule filtering."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for depreciation schedules subject to financial reporting controls."
  measures:
    - name: "total_annual_depreciation"
      expr: SUM(CAST(annual_depreciation_amount AS DOUBLE))
      comment: "Total annual depreciation charge across all schedules. P&L impact metric; drives EBITDA-to-net-income bridge and tax depreciation planning."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across the asset base. Balance sheet metric indicating asset age and replacement cycle proximity."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value across all depreciation schedules. Balance sheet asset value for leverage and asset coverage ratio calculations."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges recorded. Significant impairments signal asset value deterioration and trigger investor disclosure requirements."
    - name: "total_original_cost"
      expr: SUM(CAST(original_cost AS DOUBLE))
      comment: "Total original cost of assets on depreciation schedules. Gross asset base for capital intensity and replacement cost analysis."
    - name: "avg_depreciation_rate_pct"
      expr: AVG(CAST(depreciation_rate_percent AS DOUBLE))
      comment: "Average depreciation rate across schedules. Used to assess consistency of depreciation policy and identify outliers requiring review."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life assumption across the asset base. Drives depreciation charge forecasting and capital refresh planning."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASC 606 / IFRS 15 revenue recognition KPIs tracking recognized vs. deferred revenue, recognition compliance, and reversal activity. Used by CFO, revenue assurance, and external auditors for revenue quality and compliance reporting."
  source: "`vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual revenue recognition trend and compliance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly revenue recognition close and assurance review."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method (point-in-time, over-time) for ASC 606 performance obligation analysis."
    - name: "recognition_status"
      expr: recognition_status
      comment: "Recognition status (recognized, deferred, reversed) for revenue pipeline tracking."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type (broadcast, streaming, digital) for revenue recognition by distribution channel."
    - name: "asc_606_compliant_flag"
      expr: asc_606_compliant_flag
      comment: "ASC 606 compliance flag for identifying non-compliant recognition events requiring remediation."
    - name: "ifrs_15_compliant_flag"
      expr: ifrs_15_compliant_flag
      comment: "IFRS 15 compliance flag for international entity revenue recognition compliance."
    - name: "revenue_assurance_status"
      expr: revenue_assurance_status
      comment: "Revenue assurance review status for identifying events pending validation."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for revenue recognition events subject to financial reporting controls."
    - name: "contract_modification_flag"
      expr: contract_modification_flag
      comment: "Indicates revenue events arising from contract modifications, which require special ASC 606 treatment."
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized in the period. Primary top-line revenue metric for P&L reporting and investor disclosure."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total deferred revenue not yet recognized. Balance sheet liability metric; high deferred revenue indicates future revenue backlog and recognition timing risk."
    - name: "count_non_asc606_compliant_events"
      expr: COUNT(CASE WHEN asc_606_compliant_flag = FALSE THEN 1 END)
      comment: "Number of revenue recognition events not compliant with ASC 606. Compliance risk metric; non-compliant events require restatement and auditor escalation."
    - name: "count_reversed_events"
      expr: COUNT(CASE WHEN recognition_status = 'Reversed' THEN 1 END)
      comment: "Number of reversed revenue recognition events. High reversal counts indicate billing errors or contract disputes affecting revenue quality."
    - name: "count_contract_modification_events"
      expr: COUNT(CASE WHEN contract_modification_flag = TRUE THEN 1 END)
      comment: "Number of revenue events from contract modifications. Tracks complexity of revenue recognition arising from deal amendments and renegotiations."
    - name: "total_recognized_from_modifications"
      expr: SUM(CASE WHEN contract_modification_flag = TRUE THEN recognized_amount ELSE 0 END)
      comment: "Revenue recognized from contract modifications. Isolates modification-driven revenue for ASC 606 disclosure and audit support."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_financial_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial reconciliation quality and close efficiency KPIs. Used by controllers, internal audit, and CFO to monitor period-close completeness, reconciliation variance, and SOX control adherence."
  source: "`vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual reconciliation quality trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close reconciliation status monitoring."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Reconciliation type (bank, intercompany, subledger) for close process coverage analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status (open, in-review, approved, rejected) for close pipeline tracking."
    - name: "sign_off_status"
      expr: sign_off_status
      comment: "Controller sign-off status for SOX-compliant close completion tracking."
    - name: "adjustment_required_flag"
      expr: adjustment_required_flag
      comment: "Indicates reconciliations requiring adjusting journal entries, signaling data quality issues."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for reconciliations subject to internal control requirements."
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Intercompany flag for identifying reconciliations requiring elimination in consolidation."
  measures:
    - name: "total_gl_balance"
      expr: SUM(CAST(gl_balance_amount AS DOUBLE))
      comment: "Total GL balance across all reconciliations. Baseline for reconciliation completeness and balance sheet accuracy assessment."
    - name: "total_subledger_balance"
      expr: SUM(CAST(subledger_balance_amount AS DOUBLE))
      comment: "Total subledger balance across all reconciliations. Compared against GL balance to identify reconciling items."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total unreconciled variance across all reconciliations. High variance signals data integrity issues requiring investigation before period close."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across reconciliations. Used to assess reconciliation quality and identify systemic data issues."
    - name: "count_open_reconciliations"
      expr: COUNT(CASE WHEN reconciliation_status = 'Open' THEN 1 END)
      comment: "Number of open (incomplete) reconciliations. Close readiness metric; high open counts at period end delay financial reporting."
    - name: "count_requiring_adjustment"
      expr: COUNT(CASE WHEN adjustment_required_flag = TRUE THEN 1 END)
      comment: "Number of reconciliations requiring adjusting entries. Indicates data quality issues in source systems that inflate close effort and risk."
    - name: "total_materiality_threshold"
      expr: SUM(CAST(materiality_threshold_amount AS DOUBLE))
      comment: "Total materiality threshold across reconciliations. Used to assess whether variances are material for financial statement purposes."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal entry volume, quality, and control KPIs. Used by controllers, internal audit, and SOX teams to monitor manual journal entry risk, approval compliance, and period-close activity."
  source: "`vibe_media_broadcasting_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual journal entry volume and quality trend analysis."
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period for monthly close journal entry activity monitoring."
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (standard, accrual, reversal) for entry classification."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Adjustment type for categorizing manual vs. system-generated entries."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Approval workflow status for monitoring unapproved entries at period end."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Reversal flag for identifying accrual reversals and their timing."
    - name: "recurring_entry_indicator"
      expr: recurring_entry_indicator
      comment: "Recurring entry flag for distinguishing automated from manual journal entries."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Intercompany flag for entries requiring elimination in group consolidation."
  measures:
    - name: "count_total_journal_entries"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Volume metric for close complexity assessment and audit sampling frame sizing."
    - name: "count_manual_journal_entries"
      expr: COUNT(CASE WHEN recurring_entry_indicator = FALSE THEN 1 END)
      comment: "Number of non-recurring (manual) journal entries. High manual entry counts are a SOX risk indicator; used by internal audit to scope testing."
    - name: "count_unapproved_entries"
      expr: COUNT(CASE WHEN workflow_status != 'Approved' THEN 1 END)
      comment: "Number of journal entries not yet approved. Unapproved entries at period end are a SOX control failure; tracked for close readiness."
    - name: "count_reversal_entries"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal entries. Tracks accrual reversal completeness and identifies missed reversals that distort period results."
    - name: "count_intercompany_entries"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Used by consolidation team to ensure all intercompany entries are matched and eliminated."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across journal entries. Used to assess FX translation consistency and identify rate anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Period-close process efficiency and compliance KPIs. Used by CFO, controllers, and SOX teams to monitor close cycle time, checklist completion, and regulatory compliance across legal entities."
  source: "`vibe_media_broadcasting_v1`.`finance`.`period_close`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual close cycle trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close performance benchmarking."
    - name: "close_status"
      expr: close_status
      comment: "Close status (open, in-progress, closed) for real-time close pipeline monitoring."
    - name: "close_phase"
      expr: close_phase
      comment: "Close phase for identifying bottlenecks in the period-end close process."
    - name: "period_type"
      expr: period_type
      comment: "Period type (monthly, quarterly, annual) for close complexity and effort analysis."
    - name: "sox_control_status"
      expr: sox_control_status
      comment: "SOX control status for compliance readiness at period end."
    - name: "external_audit_required"
      expr: external_audit_required
      comment: "Flag for periods requiring external audit, indicating higher close rigor requirements."
    - name: "posting_period_locked"
      expr: posting_period_locked
      comment: "Indicates whether the posting period is locked, preventing further adjustments."
  measures:
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(close_checklist_completion_pct AS DOUBLE))
      comment: "Average close checklist completion percentage. Tracks close readiness; low completion at scheduled close date signals risk of delayed financial reporting."
    - name: "total_unreconciled_amount"
      expr: SUM(CAST(unreconciled_amount AS DOUBLE))
      comment: "Total unreconciled balance at period close. High unreconciled amounts indicate data quality issues that may require restatement."
    - name: "avg_unreconciled_items_count"
      expr: AVG(CAST(unreconciled_items_count AS DOUBLE))
      comment: "Average number of unreconciled items per close period. Tracks reconciliation backlog and close quality over time."
    - name: "avg_open_items_count"
      expr: AVG(CAST(open_items_count AS DOUBLE))
      comment: "Average number of open items at period close. Operational metric for close team workload and bottleneck identification."
    - name: "total_ebitda_at_close"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA as reported at period close. Authoritative EBITDA figure for financial reporting and covenant compliance."
    - name: "total_forecast_variance_at_close"
      expr: SUM(CAST(variance_to_forecast_amount AS DOUBLE))
      comment: "Total variance between actual close results and latest forecast. Measures forecast accuracy and business predictability for investor relations."
    - name: "count_periods_with_reopen"
      expr: COUNT(CASE WHEN CAST(reopen_count AS INT) > 0 THEN 1 END)
      comment: "Number of periods that required reopening after initial close. Reopened periods indicate control failures or late adjustments; tracked for audit and process improvement."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_revenue_stream`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue stream portfolio and commission KPIs. Used by CFO and revenue management to analyze revenue mix, pricing model distribution, and commission economics across the business."
  source: "`vibe_media_broadcasting_v1`.`finance`.`revenue_stream`"
  dimensions:
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category (advertising, subscription, syndication) for revenue mix analysis."
    - name: "revenue_subcategory"
      expr: revenue_subcategory
      comment: "Revenue subcategory for granular revenue stream decomposition."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform type (broadcast, OTT, digital) for cross-platform revenue analysis."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model (CPM, flat fee, subscription) for revenue economics analysis."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method for ASC 606 compliance analysis by stream."
    - name: "revenue_stream_status"
      expr: revenue_stream_status
      comment: "Active/inactive status for filtering operational revenue streams."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Recurring vs. one-time revenue flag for revenue quality and predictability analysis."
    - name: "is_deferred"
      expr: is_deferred
      comment: "Deferred revenue flag for identifying streams with timing differences between billing and recognition."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for revenue streams subject to financial reporting controls."
  measures:
    - name: "count_active_revenue_streams"
      expr: COUNT(CASE WHEN revenue_stream_status = 'Active' THEN 1 END)
      comment: "Number of active revenue streams. Tracks revenue diversification; concentrated revenue streams increase business risk."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate across revenue streams. Used to assess sales cost efficiency and negotiate agency commission structures."
    - name: "count_recurring_streams"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Number of recurring revenue streams. Higher recurring stream count indicates more predictable revenue base, valued by investors and lenders."
    - name: "count_deferred_streams"
      expr: COUNT(CASE WHEN is_deferred = TRUE THEN 1 END)
      comment: "Number of deferred revenue streams. Tracks revenue recognition complexity and balance sheet deferred revenue liability exposure."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production budget utilization, variance, and cost composition KPIs. Used by production finance, CFO, and content investment committees to govern content spend, track above/below-the-line costs, and manage budget adherence."
  source: "`vibe_media_broadcasting_v1`.`finance`.`production_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Budget approval status (draft, approved, locked) for governance pipeline tracking."
    - name: "budget_type"
      expr: budget_type
      comment: "Budget type (original, revised, final) for version-controlled budget analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual content investment planning and actuals comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency production budget analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved production budget. Primary content investment metric for investment committee and board reporting."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total actual production spend to date. Tracks capital deployment against approved budgets for cost control."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (contracted but not yet spent) production costs. Used for cash flow forecasting and budget availability analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs. approved). Negative variance signals overspend requiring production finance intervention."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across production budgets. Used to benchmark production cost discipline and identify chronic overspend patterns."
    - name: "total_above_the_line_cost"
      expr: SUM(CAST(above_the_line_amount AS DOUBLE))
      comment: "Total above-the-line production costs (talent, writers, directors). Key creative investment metric tracked separately from below-the-line costs."
    - name: "total_below_the_line_cost"
      expr: SUM(CAST(below_the_line_amount AS DOUBLE))
      comment: "Total below-the-line production costs (crew, equipment, facilities). Operational cost metric for production efficiency benchmarking."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency budget reserved across productions. Tracks risk buffer utilization; depleted contingency signals production risk escalation."
    - name: "total_post_production_cost"
      expr: SUM(CAST(post_production_amount AS DOUBLE))
      comment: "Total post-production costs. Tracks editing, VFX, and finishing spend as a component of total content cost."
    - name: "total_vfx_cost"
      expr: SUM(CAST(vfx_amount AS DOUBLE))
      comment: "Total VFX spend across productions. Tracks high-cost creative investment in visual effects for content quality and budget management."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation efficiency and intercompany KPIs. Used by finance controllers and management accountants to monitor cost distribution accuracy, allocation method consistency, and intercompany charge governance."
  source: "`vibe_media_broadcasting_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Allocation type (direct, indirect, statistical) for cost distribution methodology analysis."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method for consistency analysis and audit support."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status for monitoring pending vs. completed allocations at period end."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cost allocation trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly allocation cycle monitoring."
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Intercompany flag for identifying cross-entity allocations requiring elimination in consolidation."
    - name: "ebitda_reporting_segment"
      expr: ebitda_reporting_segment
      comment: "EBITDA segment for segment-level cost allocation analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Reversal flag for identifying corrective allocation entries."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated across all cost centers. Measures the volume of cost redistribution; used to assess shared service cost recovery completeness."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage across all allocation records. Used to identify concentration risk where a single receiver absorbs disproportionate shared costs."
    - name: "total_intercompany_allocated"
      expr: SUM(CASE WHEN intercompany_flag = TRUE THEN allocated_amount ELSE 0 END)
      comment: "Total intercompany cost allocations. Tracks cross-entity charge volume requiring elimination in group consolidation."
    - name: "count_pending_approvals"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE AND allocation_status != 'Approved' THEN 1 END)
      comment: "Number of allocations pending approval. Unapproved allocations at period end delay close and create reconciliation risk."
$$;