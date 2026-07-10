-- Metric views for domain: finance | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice KPIs for spend management, cash outflow planning, and vendor payment governance. Single-table view over finance.ap_invoice."
  source: "`vibe_healthcare_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Lifecycle status of the AP invoice (e.g. open, paid, on-hold) for aging and workflow analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state used to monitor bottlenecks in AP processing."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, prepayment) for spend categorization."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (check, ACH, wire) for treasury and disbursement analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match outcome (matched vs exception) for procurement compliance monitoring."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice month bucket for period-over-period spend trending."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due-date month bucket for cash outflow forecasting."
  measures:
    - name: "Invoice Count"
      expr: COUNT(1)
      comment: "Total number of AP invoices — baseline volume for workload and throughput analysis."
    - name: "Total Invoice Amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total gross invoice spend — drives cash outflow planning and vendor spend management."
    - name: "Total Amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total payable amount including tax and freight — the committed cash obligation."
    - name: "Total Discount Amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-pay/negotiated discounts captured — measures working-capital savings."
    - name: "Total Tax Amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on AP invoices for tax reporting and reconciliation."
    - name: "Avg Invoice Amount"
      expr: AVG(CAST(invoice_amount AS DOUBLE))
      comment: "Average invoice size — signals vendor mix and spend concentration shifts."
    - name: "Distinct Vendor Count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors billed — measures supplier base breadth and concentration risk."
    - name: "On Hold Invoice Count"
      expr: SUM(CASE WHEN hold_reason_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of invoices placed on hold — flags disputes and payment blockages requiring intervention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable disbursement KPIs for treasury cash management, payment reconciliation, and discount capture. Single-table view over finance.ap_payment."
  source: "`vibe_healthcare_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment (issued, cleared, voided) for disbursement monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (check, ACH, wire) for treasury channel analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Payment type classification for spend categorization."
    - name: "payment_reconciliation_status"
      expr: payment_reconciliation_status
      comment: "Reconciliation state used to track outstanding vs cleared disbursements."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment month bucket for cash-outflow trending."
  measures:
    - name: "Payment Count"
      expr: COUNT(1)
      comment: "Total disbursements issued — baseline for treasury workload and throughput."
    - name: "Total Payment Amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total cash disbursed to vendors — core treasury outflow KPI."
    - name: "Total Discount Taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-pay discounts realized on payment — measures working-capital efficiency."
    - name: "Avg Payment Amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment size — informs batch sizing and fraud-threshold tuning."
    - name: "Voided Payment Count"
      expr: SUM(CASE WHEN void_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of voided payments — flags process errors and disbursement rework."
    - name: "Distinct Vendor Count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Distinct vendors paid — supplier payment concentration measure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ar_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable account KPIs for collections effectiveness, aging, bad-debt exposure, and write-off monitoring. Single-table view over finance.ar_account."
  source: "`vibe_healthcare_v1`.`finance`.`ar_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "AR account status (active, collections, written-off) for portfolio health analysis."
    - name: "account_type"
      expr: account_type
      comment: "Account type for receivables segmentation."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket (0-30, 31-60, etc.) — the primary lens for collections prioritization."
    - name: "debtor_type"
      expr: debtor_type
      comment: "Type of debtor (payer, patient, guarantor) for AR mix analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice month bucket for receivables cohort trending."
  measures:
    - name: "Account Count"
      expr: COUNT(1)
      comment: "Total AR accounts — baseline for portfolio sizing."
    - name: "Total Current Balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding receivable balance — the core AR exposure KPI."
    - name: "Total Original Balance"
      expr: SUM(CAST(original_balance AS DOUBLE))
      comment: "Total original billed balance — denominator for collection-rate analysis."
    - name: "Total Payments Received"
      expr: SUM(CAST(total_payments_received AS DOUBLE))
      comment: "Total cash collected against accounts — measures collections effectiveness."
    - name: "Total Write Off Amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total written-off receivables — bad-debt loss that leadership must minimize."
    - name: "Total Interest Accrued"
      expr: SUM(CAST(total_interest_accrued AS DOUBLE))
      comment: "Total interest accrued on overdue balances — revenue recovery on delinquency."
    - name: "Disputed Account Count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputed accounts — flags revenue at risk requiring resolution."
    - name: "Legal Action Account Count"
      expr: SUM(CASE WHEN legal_action_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Accounts in legal action — escalated collections exposure."
    - name: "Avg Current Balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average outstanding balance per account — informs collections staffing and strategy."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_ar_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AR transaction KPIs for cash application, adjustments, and posting monitoring. Single-table view over finance.ar_transaction."
  source: "`vibe_healthcare_v1`.`finance`.`ar_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Transaction type (payment, adjustment, charge) for receivables activity mix."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status for GL-integration monitoring."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket at transaction level for delinquency analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state for cash-application controls."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Transaction month bucket for AR activity trending."
  measures:
    - name: "Transaction Count"
      expr: COUNT(1)
      comment: "Total AR transactions — baseline activity volume."
    - name: "Total Transaction Amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total value of AR transactions — drives cash-flow and receivables movement analysis."
    - name: "Total Tax Amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on AR transactions for reporting reconciliation."
    - name: "Reversal Transaction Count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversed transactions — flags posting errors and rework."
    - name: "Avg Transaction Amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction size for anomaly detection and process sizing."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget KPIs for financial planning, revenue/expense targets, and net-income planning oversight. Single-table view over finance.budget."
  source: "`vibe_healthcare_v1`.`finance`.`budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Budget lifecycle status (draft, approved, active) for planning-cycle monitoring."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (operating, capital) for planning segmentation."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for expenditure classification."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning comparison."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source (operations, grant, philanthropy) for funding-mix analysis."
  measures:
    - name: "Budget Count"
      expr: COUNT(1)
      comment: "Total budgets defined — baseline planning portfolio size."
    - name: "Total Budgeted Revenue"
      expr: SUM(CAST(total_budgeted_revenue AS DOUBLE))
      comment: "Total planned revenue — the top-line target executives steer toward."
    - name: "Total Budgeted Expense"
      expr: SUM(CAST(total_budgeted_expense AS DOUBLE))
      comment: "Total planned expense — the cost envelope leadership manages against."
    - name: "Total Budgeted Capital"
      expr: SUM(CAST(total_budgeted_capital AS DOUBLE))
      comment: "Total planned capital spend — informs capital-allocation decisions."
    - name: "Total Budgeted Net Income"
      expr: SUM(CAST(budgeted_net_income AS DOUBLE))
      comment: "Total planned net income — the bottom-line profitability target."
    - name: "Total Budgeted FTE"
      expr: SUM(CAST(budgeted_fte_count AS DOUBLE))
      comment: "Total budgeted full-time equivalents — labor-cost planning driver."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_financial_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial forecast KPIs for rolling projections of revenue, expense, and operating income to support strategic planning. Single-table view over finance.financial_forecast."
  source: "`vibe_healthcare_v1`.`finance`.`financial_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Forecast lifecycle status for planning-cycle tracking."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Forecast type for planning segmentation."
    - name: "forecast_scenario"
      expr: forecast_scenario
      comment: "Scenario (base, upside, downside) for sensitivity analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the forecast for annual projection comparison."
    - name: "forecast_period_month"
      expr: DATE_TRUNC('MONTH', forecast_period_start_date)
      comment: "Forecast period month for time-series projection trending."
  measures:
    - name: "Forecast Count"
      expr: COUNT(1)
      comment: "Number of forecasts — baseline planning-model volume."
    - name: "Total Forecast Revenue"
      expr: SUM(CAST(total_forecast_revenue AS DOUBLE))
      comment: "Total projected revenue — the forward-looking top line for strategic steering."
    - name: "Total Forecast Expense"
      expr: SUM(CAST(total_forecast_expense AS DOUBLE))
      comment: "Total projected expense — forward cost envelope for planning."
    - name: "Total Forecasted Net Income"
      expr: SUM(CAST(total_forecasted_net_income AS DOUBLE))
      comment: "Total projected net income — forward profitability leadership monitors."
    - name: "Total Forecasted Operating Income"
      expr: SUM(CAST(total_forecasted_operating_income AS DOUBLE))
      comment: "Total projected operating income — core operating-performance projection."
    - name: "Total Forecasted Capital Expenditure"
      expr: SUM(CAST(total_forecasted_capital_expenditure AS DOUBLE))
      comment: "Total projected capital spend — forward capital-planning driver."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry KPIs for close-process monitoring, posting controls, and adjustment oversight. Single-table view over finance.journal_entry."
  source: "`vibe_healthcare_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status (unposted, posted) — key control for close completeness."
    - name: "journal_category"
      expr: journal_category
      comment: "Journal category for entry classification and audit."
    - name: "journal_source"
      expr: journal_source
      comment: "Source system of the entry for automation vs manual analysis."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Adjustment type for period-end adjustment monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual GL-activity comparison."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month bucket for GL-activity trending."
  measures:
    - name: "Journal Entry Count"
      expr: COUNT(1)
      comment: "Total journal entries — baseline GL activity and close workload."
    - name: "Total Debit Amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debits posted — a leg of ledger balancing and volume monitoring."
    - name: "Total Credit Amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credits posted — the offsetting leg for balancing controls."
    - name: "Reversal Entry Count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversal entries — flags error correction and process quality."
    - name: "Intercompany Entry Count"
      expr: SUM(CASE WHEN intercompany_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intercompany entries — elimination and consolidation workload driver."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset KPIs for capital-base valuation, depreciation exposure, and asset-lifecycle management. Single-table view over finance.fixed_asset."
  source: "`vibe_healthcare_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Asset status (in-service, disposed, retired) for lifecycle analysis."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category (equipment, building, IT) for capital-base segmentation."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method for accounting-policy analysis."
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Acquisition month bucket for capital-investment trending."
  measures:
    - name: "Asset Count"
      expr: COUNT(1)
      comment: "Total fixed assets — baseline capital-base inventory."
    - name: "Total Acquisition Cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost — the invested capital base."
    - name: "Total Net Book Value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value — current balance-sheet asset value executives monitor."
    - name: "Total Accumulated Depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — measures asset aging and reinvestment need."
    - name: "Total Disposal Proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals — capital-recovery measure."
    - name: "Avg Useful Life Years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets — informs depreciation planning and replacement cycles."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation KPIs for indirect-cost distribution, cost-center accountability, and Medicare cost-report support. Single-table view over finance.cost_allocation."
  source: "`vibe_healthcare_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status for run-completion monitoring."
    - name: "allocation_category"
      expr: allocation_category
      comment: "Allocation category for cost-pool classification."
    - name: "allocation_tier"
      expr: allocation_tier
      comment: "Step-down allocation tier for cost-report methodology analysis."
    - name: "service_line_code"
      expr: service_line_code
      comment: "Service line for allocated-cost accountability by line of business."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual allocation comparison."
  measures:
    - name: "Allocation Count"
      expr: COUNT(1)
      comment: "Number of allocation records — baseline distribution volume."
    - name: "Total Allocated Amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated to targets — the core indirect-cost distribution KPI."
    - name: "Total Source Amount"
      expr: SUM(CAST(source_amount AS DOUBLE))
      comment: "Total source cost pool amount — denominator for allocation coverage."
    - name: "Total Adjustment Amount"
      expr: SUM(CAST(allocation_adjustment_amount AS DOUBLE))
      comment: "Total allocation adjustments — flags true-ups and methodology corrections."
    - name: "Medicare Reportable Allocation Count"
      expr: SUM(CASE WHEN is_medicare_reportable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Medicare-reportable allocations — cost-report compliance driver."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_capital_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project KPIs for capital-plan execution, budget variance, and ROI oversight. Single-table view over finance.capital_project."
  source: "`vibe_healthcare_v1`.`finance`.`capital_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Project status for capital-plan execution monitoring."
    - name: "project_phase"
      expr: project_phase
      comment: "Project phase (planning, construction, closeout) for lifecycle analysis."
    - name: "project_type"
      expr: project_type
      comment: "Project type for capital-portfolio segmentation."
    - name: "project_priority"
      expr: project_priority
      comment: "Project priority for capital-allocation prioritization."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for capital-financing analysis."
  measures:
    - name: "Project Count"
      expr: COUNT(1)
      comment: "Number of capital projects — baseline capital-portfolio size."
    - name: "Total Approved Capital Budget"
      expr: SUM(CAST(approved_capital_budget AS DOUBLE))
      comment: "Total approved capital budget — the committed capital envelope."
    - name: "Total Actual Costs"
      expr: SUM(CAST(total_actual_costs AS DOUBLE))
      comment: "Total actual capital spend to date — burn against approved budget."
    - name: "Total Committed Costs"
      expr: SUM(CAST(total_committed_costs AS DOUBLE))
      comment: "Total committed (contracted) costs — forward capital obligation."
    - name: "Total Expected Annual Savings"
      expr: SUM(CAST(expected_annual_savings AS DOUBLE))
      comment: "Total projected annual savings — ROI driver for capital justification."
    - name: "Total Expected Annual Revenue"
      expr: SUM(CAST(expected_annual_revenue AS DOUBLE))
      comment: "Total projected annual revenue from projects — revenue-generating capital ROI."
    - name: "Avg Variance Percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average budget variance percentage — flags cost overruns needing intervention."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation KPIs for cash-control effectiveness, unreconciled-variance monitoring, and treasury governance. Single-table view over finance.bank_reconciliation."
  source: "`vibe_healthcare_v1`.`finance`.`bank_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for control-completion monitoring."
    - name: "statement_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Statement month bucket for reconciliation-cycle trending."
  measures:
    - name: "Reconciliation Count"
      expr: COUNT(1)
      comment: "Number of reconciliations performed — baseline control-activity volume."
    - name: "Total Unreconciled Variance"
      expr: SUM(CAST(unreconciled_variance AS DOUBLE))
      comment: "Total unreconciled variance — the key cash-control exposure requiring investigation."
    - name: "Total Outstanding Checks"
      expr: SUM(CAST(outstanding_checks_amount AS DOUBLE))
      comment: "Total outstanding checks — cash-timing float that affects available balance."
    - name: "Total Deposits In Transit"
      expr: SUM(CAST(deposits_in_transit AS DOUBLE))
      comment: "Total deposits in transit — pending cash inflow for treasury planning."
    - name: "Exception Reconciliation Count"
      expr: SUM(CASE WHEN exception_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reconciliations with exceptions — flags control breakdowns."
    - name: "Avg Difference Amount"
      expr: AVG(CAST(difference_amount AS DOUBLE))
      comment: "Average reconciliation difference — signals systemic reconciliation issues."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_donor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Philanthropy donor KPIs for fundraising performance, donor-base health, and lifetime-value analysis. Single-table view over finance.donor."
  source: "`vibe_healthcare_v1`.`finance`.`donor`"
  dimensions:
    - name: "donor_type"
      expr: donor_type
      comment: "Donor type (individual, corporate, foundation) for fundraising segmentation."
    - name: "donor_status"
      expr: donor_status
      comment: "Donor status (active, lapsed) for retention analysis."
    - name: "donor_category"
      expr: donor_category
      comment: "Donor category for giving-tier segmentation."
    - name: "recognition_level"
      expr: recognition_level
      comment: "Recognition level for major-gift stewardship analysis."
    - name: "segment"
      expr: segment
      comment: "Donor segment for campaign targeting."
  measures:
    - name: "Donor Count"
      expr: COUNT(1)
      comment: "Total donors — baseline donor-base size."
    - name: "Total Lifetime Giving"
      expr: SUM(CAST(lifetime_giving_amount AS DOUBLE))
      comment: "Total lifetime giving across donors — cumulative philanthropic value."
    - name: "Total Contributed Amount"
      expr: SUM(CAST(total_contributed_amount AS DOUBLE))
      comment: "Total contributed amount — fundraising revenue KPI leadership tracks."
    - name: "Avg Lifetime Giving"
      expr: AVG(CAST(lifetime_giving_amount AS DOUBLE))
      comment: "Average lifetime giving per donor — measures donor value and cultivation ROI."
    - name: "Avg Affinity Score"
      expr: AVG(CAST(affinity_score AS DOUBLE))
      comment: "Average donor affinity score — informs prospect prioritization."
    - name: "Planned Giving Donor Count"
      expr: SUM(CASE WHEN planned_giving_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of planned-giving donors — future revenue pipeline for major gifts."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund KPIs for restricted/endowment fund balance tracking, spending-policy compliance, and stewardship. Single-table view over finance.fund."
  source: "`vibe_healthcare_v1`.`finance`.`fund`"
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Fund type (operating, endowment, restricted) for fund-portfolio segmentation."
    - name: "fund_status"
      expr: fund_status
      comment: "Fund status for lifecycle monitoring."
    - name: "fund_category"
      expr: fund_category
      comment: "Fund category for classification and reporting."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction type for donor-restriction compliance analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for fund-origin analysis."
  measures:
    - name: "Fund Count"
      expr: COUNT(1)
      comment: "Number of funds — baseline fund-portfolio size."
    - name: "Total Fund Balance"
      expr: SUM(CAST(fund_balance AS DOUBLE))
      comment: "Total fund balance — the aggregate stewarded assets executives monitor."
    - name: "Total Endowment Corpus"
      expr: SUM(CAST(endowment_corpus_amount AS DOUBLE))
      comment: "Total endowment corpus — permanently restricted principal base."
    - name: "Total Beginning Balance"
      expr: SUM(CAST(beginning_balance AS DOUBLE))
      comment: "Total beginning balance — baseline for fund-growth analysis."
    - name: "Restricted Fund Count"
      expr: SUM(CASE WHEN is_restricted = TRUE THEN 1 ELSE 0 END)
      comment: "Count of restricted funds — compliance-monitoring scope for donor restrictions."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant KPIs for sponsored-program financial oversight, spend-down tracking, and indirect-cost recovery. Single-table view over finance.grant."
  source: "`vibe_healthcare_v1`.`finance`.`grant`"
  dimensions:
    - name: "grant_status"
      expr: grant_status
      comment: "Grant status (active, closeout) for program-lifecycle monitoring."
    - name: "grant_type"
      expr: grant_type
      comment: "Grant type for sponsored-program segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status for grant-reporting risk monitoring."
    - name: "sponsor_name"
      expr: sponsor_name
      comment: "Sponsor name for funder-relationship analysis."
    - name: "funding_mechanism"
      expr: funding_mechanism
      comment: "Funding mechanism for grant-portfolio segmentation."
  measures:
    - name: "Grant Count"
      expr: COUNT(1)
      comment: "Number of grants — baseline sponsored-program portfolio size."
    - name: "Total Awarded Amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total grant awards — the sponsored-funding revenue base."
    - name: "Total Amount Expended"
      expr: SUM(CAST(amount_expended AS DOUBLE))
      comment: "Total grant funds expended — spend-down progress against awards."
    - name: "Total Direct Cost"
      expr: SUM(CAST(direct_cost_amount AS DOUBLE))
      comment: "Total direct costs — core program spending for compliance reporting."
    - name: "Total Indirect Cost"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs recovered — overhead-recovery KPI for financial sustainability."
    - name: "Total Cost Share"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total institutional cost-share commitment — matching-fund obligation to monitor."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_financial_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial period close KPIs for close-cycle efficiency, checklist completion, and audit-readiness monitoring. Single-table view over finance.financial_period_close."
  source: "`vibe_healthcare_v1`.`finance`.`financial_period_close`"
  dimensions:
    - name: "close_status"
      expr: close_status
      comment: "Close status for period-close progress monitoring."
    - name: "close_type"
      expr: close_type
      comment: "Close type (soft, hard) for close-cycle analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for close sign-off monitoring."
    - name: "close_efficiency_rating"
      expr: close_efficiency_rating
      comment: "Close efficiency rating for process-quality benchmarking."
  measures:
    - name: "Close Count"
      expr: COUNT(1)
      comment: "Number of period closes — baseline close-cycle volume."
    - name: "Avg Checklist Completion Pct"
      expr: AVG(CAST(close_checklist_completion_percentage AS DOUBLE))
      comment: "Average close-checklist completion percentage — measures close readiness and control adherence."
    - name: "Prior Period Adjustment Count"
      expr: SUM(CASE WHEN prior_period_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of closes with prior-period adjustments — flags restatement risk and control weakness."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction KPIs for consolidation, elimination completeness, and settlement monitoring. Single-table view over finance.intercompany_transaction."
  source: "`vibe_healthcare_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Intercompany transaction type for activity classification."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Transaction status for processing monitoring."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status for intercompany cash-settlement tracking."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for consolidation-control monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual intercompany-activity comparison."
  measures:
    - name: "Transaction Count"
      expr: COUNT(1)
      comment: "Number of intercompany transactions — baseline consolidation workload."
    - name: "Total Transaction Amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction value — gross activity requiring elimination."
    - name: "Total Reconciliation Variance"
      expr: SUM(CAST(reconciliation_variance_amount AS DOUBLE))
      comment: "Total intercompany reconciliation variance — flags out-of-balance consolidation exposure."
    - name: "Elimination Transaction Count"
      expr: SUM(CASE WHEN elimination_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of elimination-flagged transactions — consolidation-completeness driver."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`finance_capital_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure metrics"
  source: "`vibe_healthcare_v1`.`finance`.`capital_expenditure`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expenditure"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center charged"
    - name: "capital_project_id"
      expr: capital_project_id
      comment: "Associated capital project identifier"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the capital asset"
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "Type of capital expenditure"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor providing the capital asset"
  measures:
    - name: "total_expenditure_amount"
      expr: SUM(CAST(expenditure_amount AS DOUBLE))
      comment: "Total capital expenditure amount"
    - name: "expenditure_count"
      expr: COUNT(1)
      comment: "Number of capital expenditure records"
    - name: "average_expenditure_amount"
      expr: AVG(CAST(expenditure_amount AS DOUBLE))
      comment: "Average expenditure amount"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total salvage value of assets"
$$;