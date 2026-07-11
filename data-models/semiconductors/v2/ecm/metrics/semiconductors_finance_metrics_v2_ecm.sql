-- Metric views for domain: finance | Business: Semiconductors | Version: 2 | Generated on: 2026-07-10 11:52:05

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_asset_depreciation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks depreciation expense, accumulated depreciation, and utilization across fixed assets. Supports capital planning, tax reporting, and asset lifecycle management decisions."
  source: "`vibe_semiconductors_v1`.`finance`.`asset_depreciation`"
  dimensions:
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g., straight-line, declining balance) — used to compare cost profiles across asset classes."
    - name: "depreciation_area"
      expr: depreciation_area
      comment: "Accounting area for depreciation (book, tax, IFRS) — critical for multi-GAAP reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the depreciation posting — enables year-over-year trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year — supports monthly close and period-end reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the depreciation record — filters for posted vs. pending entries."
    - name: "asset_depreciation_status"
      expr: asset_depreciation_status
      comment: "Lifecycle status of the depreciation record — identifies active, reversed, or cancelled entries."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node associated with the asset — enables depreciation analysis by process generation (e.g., 5nm, 7nm)."
    - name: "posted_date_month"
      expr: DATE_TRUNC('MONTH', posted_date)
      comment: "Month of posting date — supports monthly depreciation trend dashboards."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the depreciation amounts — required for multi-currency consolidation."
  measures:
    - name: "total_depreciation_amount"
      expr: SUM(CAST(depreciation_amount AS DOUBLE))
      comment: "Total depreciation expense charged in the period. Core P&L cost metric for capital-intensive semiconductor fabs."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all assets. Indicates how much of the original asset value has been consumed — key for net book value analysis."
    - name: "total_depreciation_adjustment"
      expr: SUM(CAST(depreciation_adjustment_amount AS DOUBLE))
      comment: "Sum of depreciation adjustments (true-ups, corrections). Large values signal asset revaluation events or accounting corrections requiring executive attention."
    - name: "avg_utilization_factor"
      expr: AVG(CAST(utilization_factor AS DOUBLE))
      comment: "Average asset utilization factor across depreciation records. Low utilization on high-value fab equipment directly impacts cost-per-wafer and ROI."
    - name: "avg_depreciation_rate"
      expr: AVG(CAST(depreciation_rate AS DOUBLE))
      comment: "Average depreciation rate applied. Monitors consistency of rate application across asset classes and depreciation areas."
    - name: "depreciation_record_count"
      expr: COUNT(1)
      comment: "Number of depreciation records in scope. Used as a denominator baseline for average calculations and audit completeness checks."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a comprehensive view of the fixed asset register for semiconductor capital equipment. Supports capex ROI, impairment monitoring, net book value tracking, and maintenance cost governance."
  source: "`vibe_semiconductors_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the fixed asset (e.g., fab equipment, building, IT) — primary grouping for capital reporting."
    - name: "asset_type"
      expr: asset_type
      comment: "Type classification of the asset — supports granular capex analysis by asset class."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset — used to compare cost profiles and policy compliance."
    - name: "fixed_asset_status"
      expr: fixed_asset_status
      comment: "Lifecycle status of the asset (active, disposed, impaired) — filters for in-service vs. retired assets."
    - name: "capitalized"
      expr: capitalized
      comment: "Whether the asset has been capitalized — distinguishes expensed vs. capitalized items for balance sheet accuracy."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Flag indicating the asset has been impaired — critical for financial statement accuracy and audit."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers associated with the asset — enables capex analysis by process generation."
    - name: "acquisition_date_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition — supports vintage analysis and capex wave tracking."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of the asset (sale, scrap, transfer) — informs asset lifecycle and residual value management."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total original acquisition cost of fixed assets. Primary capex investment metric for board-level capital allocation decisions."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value (cost minus accumulated depreciation) of the asset base. Core balance sheet metric for semiconductor capital-intensive operations."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all fixed assets. Measures how much of the capital base has been consumed."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges recorded. Elevated impairment signals technology obsolescence or demand downturns requiring strategic response."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Tracks capital recovery from retired equipment — relevant for fab refresh and technology migration programs."
    - name: "total_grant_amount"
      expr: SUM(CAST(grant_amount AS DOUBLE))
      comment: "Total government grants (e.g., CHIPS Act) received against fixed assets. Critical for tracking subsidized capex and compliance with grant conditions."
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average utilization percentage of fixed assets. Low utilization on high-value fab tools directly drives up cost-per-wafer and reduces ROI."
    - name: "total_depreciation_amount"
      expr: SUM(CAST(depreciation_amount AS DOUBLE))
      comment: "Total periodic depreciation expense across the asset register. Key P&L cost driver for semiconductor manufacturing."
    - name: "total_depreciation_adjustment"
      expr: SUM(CAST(depreciation_adjustment_amount AS DOUBLE))
      comment: "Total depreciation adjustments applied. Large adjustments indicate revaluation events or policy changes requiring disclosure."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed asset records. Baseline for average cost and utilization calculations; also used in audit completeness checks."
    - name: "impaired_asset_count"
      expr: COUNT(CASE WHEN impairment_indicator = TRUE THEN 1 END)
      comment: "Number of assets flagged as impaired. Rising count signals technology obsolescence risk or demand deterioration in specific process nodes."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks capital expenditure requests through the approval pipeline. Supports capex governance, budget vs. approved variance analysis, and CHIPS Act funding eligibility tracking."
  source: "`vibe_semiconductors_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the capex request — primary filter for pipeline vs. approved capex reporting."
    - name: "approval_stage"
      expr: approval_stage
      comment: "Stage in the approval workflow — identifies bottlenecks in the capex approval process."
    - name: "capex_request_status"
      expr: capex_request_status
      comment: "Lifecycle status of the request (draft, submitted, approved, rejected) — used for pipeline management."
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment being requested — enables capex analysis by asset class (lithography, etch, CVD, etc.)."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node the capex investment targets — critical for node-level investment planning."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding (internal, CHIPS Act grant, debt) — required for capital structure and compliance reporting."
    - name: "chips_act_funding_eligible"
      expr: chips_act_funding_eligible
      comment: "Whether the request qualifies for CHIPS Act funding — key filter for government subsidy tracking."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Planned depreciation method for the requested asset — used in financial modeling and tax planning."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the capex request — supports risk-adjusted capital allocation decisions."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month the request was submitted — enables capex pipeline trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the request amounts — required for multi-currency capex consolidation."
  measures:
    - name: "total_request_amount"
      expr: SUM(CAST(request_amount AS DOUBLE))
      comment: "Total value of all capex requests submitted. Primary metric for capex pipeline sizing and budget adequacy assessment."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total capex approved. Compared against budget to assess capital deployment pace and approval efficiency."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted capex across all requests. Baseline for budget vs. approved and budget vs. actual variance analysis."
    - name: "avg_request_amount"
      expr: AVG(CAST(request_amount AS DOUBLE))
      comment: "Average capex request size. Tracks whether investment scale is shifting toward larger or smaller projects over time."
    - name: "capex_request_count"
      expr: COUNT(1)
      comment: "Total number of capex requests. Used to assess investment activity volume and approval throughput."
    - name: "chips_act_eligible_request_count"
      expr: COUNT(CASE WHEN chips_act_funding_eligible = TRUE THEN 1 END)
      comment: "Number of capex requests eligible for CHIPS Act funding. Tracks the scale of government-subsidized investment pipeline."
    - name: "chips_act_eligible_amount"
      expr: SUM(CASE WHEN chips_act_funding_eligible = TRUE THEN request_amount ELSE 0 END)
      comment: "Total value of CHIPS Act-eligible capex requests. Quantifies the potential government subsidy benefit in the investment pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors budget planning performance including planned spend, variance to prior year, and CHIPS Act funding indicators. Supports annual planning, reforecast, and financial governance."
  source: "`vibe_semiconductors_v1`.`finance`.`budget_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget plan — primary time dimension for annual planning cycles."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (original, revised, forecast) — distinguishes planning versions for variance analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the budget plan — filters for approved vs. draft budgets in reporting."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the plan (active, closed, archived) — ensures only current plans are included in operational reporting."
    - name: "planning_method"
      expr: planning_method
      comment: "Planning methodology used (top-down, bottom-up, zero-based) — supports planning process governance."
    - name: "financial_reporting_standard"
      expr: financial_reporting_standard
      comment: "Accounting standard (GAAP, IFRS) under which the budget is prepared — required for multi-standard reporting."
    - name: "chips_act_funding_indicator"
      expr: chips_act_funding_indicator
      comment: "Whether the budget plan includes CHIPS Act funding — critical for government subsidy compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget amounts — required for multi-currency consolidation."
  measures:
    - name: "total_planned_amount_local"
      expr: SUM(CAST(planned_amount_local AS DOUBLE))
      comment: "Total planned spend in local currency. Primary budget sizing metric for cost center and entity-level planning."
    - name: "total_planned_amount_group"
      expr: SUM(CAST(planned_amount_group AS DOUBLE))
      comment: "Total planned spend in group reporting currency. Used for consolidated budget reporting across legal entities."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity (wafers, units, headcount) across budget plans. Supports volume-based planning and capacity alignment."
    - name: "total_variance_to_prior_year_amount"
      expr: SUM(CAST(variance_to_prior_year_amount AS DOUBLE))
      comment: "Total budget variance versus prior year in absolute terms. Key metric for year-over-year investment trend analysis presented to the board."
    - name: "avg_variance_to_prior_year_percent"
      expr: AVG(CAST(variance_to_prior_year_percent AS DOUBLE))
      comment: "Average percentage variance to prior year budget. Indicates the magnitude of budget growth or reduction across the planning portfolio."
    - name: "budget_plan_count"
      expr: COUNT(1)
      comment: "Number of budget plans in scope. Used to assess planning coverage and completeness across cost centers."
    - name: "chips_act_budget_plan_count"
      expr: COUNT(CASE WHEN chips_act_funding_indicator = TRUE THEN 1 END)
      comment: "Number of budget plans with CHIPS Act funding. Tracks the breadth of government-subsidized investment planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides line-level budget execution analysis including planned vs. variance amounts. Supports cost center budget control, fiscal period close, and compliance-flagged spend monitoring."
  source: "`vibe_semiconductors_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — primary time dimension for annual budget reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget line — supports monthly budget vs. actual close reporting."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget line (capex, opex, R&D) — enables spend category analysis."
    - name: "cost_element_type"
      expr: cost_element_type
      comment: "Type of cost element (labor, material, overhead) — supports cost structure analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget line — filters for approved vs. pending lines in close reporting."
    - name: "budget_line_status"
      expr: budget_line_status
      comment: "Lifecycle status of the budget line — identifies frozen, active, or cancelled lines."
    - name: "is_frozen"
      expr: is_frozen
      comment: "Whether the budget line is frozen — frozen lines cannot be modified, indicating finalized budget periods."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the budget line has a compliance requirement — used to track regulatory spend obligations."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate costs to this budget line — supports cost allocation governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line amounts — required for multi-currency reporting."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all lines. Primary metric for budget adequacy and cost center funding assessment."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (planned vs. actual). Negative variance signals overspend requiring management intervention."
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average budget variance percentage. Tracks overall budget execution discipline across cost centers."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity across budget lines. Supports volume-based budget analysis (wafers, headcount, units)."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget lines. Used as a baseline for average calculations and budget completeness audits."
    - name: "compliance_flagged_line_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of budget lines with compliance requirements. Tracks the volume of regulatory spend obligations in the budget."
    - name: "frozen_line_count"
      expr: COUNT(CASE WHEN is_frozen = TRUE THEN 1 END)
      comment: "Number of frozen budget lines. Indicates the proportion of the budget that has been locked for the period."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides cost center master data analytics including budget sizing, hierarchy coverage, and active/inactive status. Supports cost center governance, controlling area management, and organizational cost structure analysis."
  source: "`vibe_semiconductors_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (production, overhead, R&D, admin) — primary grouping for cost structure analysis."
    - name: "cost_center_category"
      expr: cost_center_category
      comment: "Category classification of the cost center — supports granular cost reporting."
    - name: "controlling_area"
      expr: controlling_area
      comment: "Controlling area the cost center belongs to — required for SAP-style management accounting segmentation."
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Active/inactive status of the cost center — filters for operational vs. closed cost centers."
    - name: "is_active"
      expr: is_active
      comment: "Boolean active flag — quick filter for active cost centers in operational reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country of the cost center — enables geographic cost analysis across global fab operations."
    - name: "region_code"
      expr: region_code
      comment: "Regional grouping of the cost center — supports regional P&L and cost allocation analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the cost center hierarchy — used to filter for leaf-level vs. summary cost centers."
    - name: "budget_year"
      expr: budget_year
      comment: "Budget year associated with the cost center — supports annual budget cycle analysis."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted spend across all cost centers. Primary metric for organizational cost planning and resource allocation."
    - name: "cost_center_count"
      expr: COUNT(1)
      comment: "Total number of cost centers. Used to assess organizational complexity and controlling area coverage."
    - name: "active_cost_center_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active cost centers. Tracks the operational footprint of the controlling organization."
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per cost center. Identifies cost centers that are significantly over- or under-resourced relative to peers."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analyzes cost allocation execution including allocated amounts, allocation rates, and reversal activity. Supports overhead absorption governance, period-end close quality, and allocation method effectiveness."
  source: "`vibe_semiconductors_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate costs (activity-based, headcount, square footage) — primary dimension for allocation policy analysis."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis for the allocation (labor hours, machine hours, revenue) — supports allocation driver analysis."
    - name: "cost_allocation_status"
      expr: cost_allocation_status
      comment: "Status of the allocation record (posted, reversed, pending) — filters for completed vs. in-progress allocations."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation — enables year-over-year overhead absorption trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the allocation — supports monthly close and period-end allocation completeness checks."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the allocation — supports quarterly overhead absorption reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the allocation was reversed — high reversal rates signal allocation quality issues."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation amounts — required for multi-currency overhead reporting."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated across all records. Primary metric for overhead absorption completeness and cost distribution effectiveness."
    - name: "avg_allocation_rate"
      expr: AVG(CAST(allocation_rate AS DOUBLE))
      comment: "Average allocation rate applied. Monitors rate consistency and identifies outliers that may indicate misallocation."
    - name: "total_allocation_base_quantity"
      expr: SUM(CAST(allocation_base_quantity AS DOUBLE))
      comment: "Total allocation driver quantity (hours, units, etc.). Used to validate allocation base adequacy and driver accuracy."
    - name: "allocation_record_count"
      expr: COUNT(1)
      comment: "Total number of allocation records. Baseline for allocation completeness and period-end close quality assessment."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed allocation records. High reversal counts indicate allocation quality issues requiring process improvement."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors general ledger journal entry activity including posting volumes, amounts, tax, and reversal rates. Supports period-end close governance, audit readiness, and financial control effectiveness."
  source: "`vibe_semiconductors_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (standard, accrual, reversal, intercompany) — primary classification for GL activity analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the journal entry (posted, parked, blocked) — critical for period-end close completeness."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry — enables year-over-year GL activity trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry — supports monthly close volume and amount analysis."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator — used to validate balanced entry posting and detect anomalies."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Whether the entry is intercompany — used to isolate intercompany elimination candidates."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the entry has been reversed — high reversal rates signal close quality issues."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the journal entry — required for multi-currency GL reporting."
    - name: "posting_timestamp_month"
      expr: DATE_TRUNC('MONTH', posting_timestamp)
      comment: "Month of posting — supports monthly close volume trend analysis."
  measures:
    - name: "total_amount_base"
      expr: SUM(CAST(amount_base AS DOUBLE))
      comment: "Total journal entry amount in base currency. Primary GL volume metric for financial close monitoring."
    - name: "total_amount_local"
      expr: SUM(CAST(amount_local AS DOUBLE))
      comment: "Total journal entry amount in local currency. Used for entity-level P&L and balance sheet reconciliation."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after tax across all journal entries. Supports net P&L impact analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted via journal entries. Supports tax provision reconciliation and indirect tax reporting."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries. Baseline for close volume analysis and audit sampling frame sizing."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entries. High reversal rates indicate close quality issues or systematic posting errors."
    - name: "intercompany_entry_count"
      expr: COUNT(CASE WHEN intercompany_indicator = TRUE THEN 1 END)
      comment: "Number of intercompany journal entries. Used to size the intercompany elimination workload and monitor intercompany balance exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides line-level GL analysis for detailed cost and revenue attribution. Supports account-level reconciliation, cost center charge analysis, and audit trail completeness."
  source: "`vibe_semiconductors_v1`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator at the line level — used to validate balanced posting and detect anomalies."
    - name: "line_status"
      expr: line_status
      comment: "Status of the journal entry line (posted, cleared, open) — supports reconciliation and open item management."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area (manufacturing, R&D, SG&A) — enables P&L analysis by business function."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the line — supports indirect tax analysis and compliance reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the line has been reversed — used to identify correcting entries and assess close quality."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of the effective date — supports monthly accrual and cost attribution analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of the posting date — used for period-end close completeness monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line amounts — required for multi-currency GL line analysis."
  measures:
    - name: "total_amount_document_currency"
      expr: SUM(CAST(amount_document_currency AS DOUBLE))
      comment: "Total line amount in document currency. Primary metric for GL line-level financial analysis and account reconciliation."
    - name: "total_amount_local_currency"
      expr: SUM(CAST(amount_local_currency AS DOUBLE))
      comment: "Total line amount in local currency. Used for entity-level cost attribution and P&L analysis."
    - name: "journal_entry_line_count"
      expr: COUNT(1)
      comment: "Total number of journal entry lines. Baseline for audit sampling, reconciliation completeness, and close volume monitoring."
    - name: "reversal_line_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed journal entry lines. Elevated counts signal systematic posting errors or close quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_depreciation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors depreciation run execution including total depreciation posted, accumulated balances, and run completion status. Supports period-end close governance and depreciation policy compliance."
  source: "`vibe_semiconductors_v1`.`finance`.`depreciation_run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Type of depreciation run (planned, unplanned, test) — distinguishes production runs from test executions."
    - name: "depreciation_run_status"
      expr: depreciation_run_status
      comment: "Status of the depreciation run (completed, failed, in-progress) — critical for period-end close monitoring."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied in the run — used to validate method consistency across periods."
    - name: "schedule_frequency"
      expr: schedule_frequency
      comment: "Frequency of the depreciation schedule (monthly, quarterly) — supports run cadence governance."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Whether the run included manual overrides — manual overrides require additional audit scrutiny."
    - name: "period_start_date_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the depreciation period start — enables monthly depreciation trend analysis."
  measures:
    - name: "total_depreciation_amount"
      expr: SUM(CAST(total_depreciation_amount AS DOUBLE))
      comment: "Total depreciation amount posted across all runs. Primary metric for period depreciation expense monitoring."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(total_accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation balance across all runs. Tracks the cumulative consumption of the fixed asset base."
    - name: "total_book_value"
      expr: SUM(CAST(total_book_value AS DOUBLE))
      comment: "Total net book value of assets after depreciation runs. Key balance sheet metric for capital-intensive semiconductor operations."
    - name: "total_tax_adjustment"
      expr: SUM(CAST(depreciation_tax_adjustment AS DOUBLE))
      comment: "Total tax depreciation adjustments across runs. Supports deferred tax calculation and tax provision accuracy."
    - name: "avg_depreciation_rate"
      expr: AVG(CAST(depreciation_rate AS DOUBLE))
      comment: "Average depreciation rate applied across runs. Monitors rate consistency and identifies policy deviations."
    - name: "depreciation_run_count"
      expr: COUNT(1)
      comment: "Total number of depreciation runs. Used to verify run completeness for each period-end close."
    - name: "manual_override_run_count"
      expr: COUNT(CASE WHEN is_manual_override = TRUE THEN 1 END)
      comment: "Number of runs with manual overrides. Elevated counts require audit justification and may signal control weaknesses."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks standard cost models for semiconductor products including wafer cost, die cost, and yield targets. Supports cost-per-wafer benchmarking, margin modeling, and technology node cost competitiveness analysis."
  source: "`vibe_semiconductors_v1`.`finance`.`standard_cost`"
  dimensions:
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node of the standard cost model — primary dimension for node-level cost competitiveness analysis."
    - name: "cost_type"
      expr: cost_type
      comment: "Type of standard cost (current, planned, target) — distinguishes cost versions for variance analysis."
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost (wafer, packaging, test, overhead) — enables cost structure decomposition."
    - name: "cost_status"
      expr: cost_status
      comment: "Status of the cost model (active, superseded, draft) — filters for current vs. historical cost standards."
    - name: "is_active"
      expr: is_active
      comment: "Whether the cost model is currently active — primary filter for operational cost reporting."
    - name: "cost_basis"
      expr: cost_basis
      comment: "Basis for cost calculation (actual, standard, target) — supports cost accounting method analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the standard cost — enables product-line margin analysis."
    - name: "product_family"
      expr: product_family
      comment: "Product family of the standard cost — supports family-level cost benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost amounts — required for multi-currency cost comparison."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the standard cost became effective — supports cost trend analysis over time."
  measures:
    - name: "total_wafer_cost"
      expr: SUM(CAST(total_wafer_cost AS DOUBLE))
      comment: "Total standard wafer cost across all cost models. Primary cost metric for fab economics and cost-per-wafer benchmarking."
    - name: "avg_cost_per_good_die"
      expr: AVG(CAST(cost_per_good_die AS DOUBLE))
      comment: "Average cost per good die. Core profitability metric — directly drives product gross margin and pricing decisions."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage across cost models. Low yield targets signal process maturity issues that inflate cost-per-die."
    - name: "avg_material_cost_per_wafer"
      expr: AVG(CAST(material_cost_per_wafer AS DOUBLE))
      comment: "Average material cost per wafer. Tracks raw material cost efficiency — key input for supply chain cost reduction initiatives."
    - name: "avg_equipment_depreciation_per_wafer"
      expr: AVG(CAST(equipment_depreciation_per_wafer AS DOUBLE))
      comment: "Average equipment depreciation allocated per wafer. Measures capital intensity of the manufacturing process — critical for node economics."
    - name: "avg_fab_overhead_rate"
      expr: AVG(CAST(fab_overhead_rate AS DOUBLE))
      comment: "Average fab overhead rate. Tracks overhead absorption efficiency — high rates indicate underutilization of fab capacity."
    - name: "avg_packaging_cost_per_die"
      expr: AVG(CAST(packaging_cost_per_die AS DOUBLE))
      comment: "Average packaging cost per die. Packaging is a significant cost component — tracks OSAT cost efficiency."
    - name: "avg_mask_set_cost"
      expr: AVG(CAST(mask_set_cost AS DOUBLE))
      comment: "Average mask set cost amortized into standard cost. High mask costs at advanced nodes are a key NRE cost driver."
    - name: "avg_labor_rate_per_hour"
      expr: AVG(CAST(labor_rate_per_hour AS DOUBLE))
      comment: "Average labor rate per hour in the standard cost model. Supports workforce cost benchmarking and fab location decisions."
    - name: "standard_cost_model_count"
      expr: COUNT(1)
      comment: "Total number of standard cost models. Used to assess cost model coverage across products and technology nodes."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_wafer_cost_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides detailed wafer cost model analytics by technology node and process flow. Supports cost-per-wafer benchmarking, fab economics analysis, and technology node investment decisions."
  source: "`vibe_semiconductors_v1`.`finance`.`wafer_cost_model`"
  dimensions:
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node of the wafer cost model — primary dimension for node-level cost competitiveness analysis."
    - name: "model_code"
      expr: model_code
      comment: "Unique code identifying the cost model version — used to track model evolution over time."
    - name: "wafer_cost_model_status"
      expr: wafer_cost_model_status
      comment: "Status of the cost model (active, archived, draft) — filters for current vs. historical models."
    - name: "fab_location"
      expr: fab_location
      comment: "Physical fab location of the cost model — enables cost comparison across fab sites."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost model amounts — required for multi-currency cost benchmarking."
    - name: "effective_start_date_year"
      expr: YEAR(effective_start_date)
      comment: "Year the cost model became effective — supports annual cost trend analysis."
    - name: "wafer_diameter_mm"
      expr: wafer_diameter_mm
      comment: "Wafer diameter in millimeters (200mm, 300mm) — critical dimension for cost-per-wafer comparison across fab generations."
  measures:
    - name: "avg_total_cost_per_wafer"
      expr: AVG(CAST(total_cost_per_wafer_usd AS DOUBLE))
      comment: "Average total cost per wafer in USD. The single most important fab economics metric — drives pricing, margin, and technology investment decisions."
    - name: "avg_silicon_wafer_cost"
      expr: AVG(CAST(silicon_wafer_cost_usd AS DOUBLE))
      comment: "Average silicon wafer substrate cost. Tracks raw material cost efficiency — key input for supply chain negotiations."
    - name: "avg_equipment_depreciation_per_wafer"
      expr: AVG(CAST(equipment_depreciation_usd_per_wafer AS DOUBLE))
      comment: "Average equipment depreciation per wafer. Measures capital intensity — high values at advanced nodes drive investment justification analysis."
    - name: "avg_labor_cost_per_wafer"
      expr: AVG(CAST(labor_rate_usd_per_hour AS DOUBLE) * CAST(labor_hours_per_wafer AS DOUBLE))
      comment: "Average labor cost per wafer (rate × hours). Tracks workforce cost efficiency across fab locations and technology nodes."
    - name: "avg_chemicals_gases_cost_per_wafer"
      expr: AVG(CAST(chemicals_gases_cost_usd_per_wafer AS DOUBLE))
      comment: "Average chemicals and gases cost per wafer. Consumables are a significant variable cost — tracks process efficiency and supplier pricing."
    - name: "avg_fab_overhead_rate_percent"
      expr: AVG(CAST(fab_overhead_rate_percent AS DOUBLE))
      comment: "Average fab overhead rate percentage. High overhead rates signal underutilization — key metric for capacity management decisions."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage in cost models. Yield is the primary lever for cost-per-good-die reduction at advanced nodes."
    - name: "avg_mask_set_cost"
      expr: AVG(CAST(mask_set_cost_usd AS DOUBLE))
      comment: "Average mask set cost in USD. At advanced nodes, mask costs are a major NRE component — critical for technology node economics."
    - name: "avg_mask_set_amortization_wafers"
      expr: AVG(CAST(mask_set_amortization_wafers AS DOUBLE))
      comment: "Average number of wafers over which mask set cost is amortized. Higher volumes reduce per-wafer NRE burden — key for volume commitment decisions."
    - name: "wafer_cost_model_count"
      expr: COUNT(1)
      comment: "Total number of wafer cost models. Used to assess cost model coverage across technology nodes and fab locations."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_transfer_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors intercompany transfer pricing including price levels, margins, and compliance status. Supports OECD transfer pricing documentation, tax authority audit readiness, and intercompany margin governance."
  source: "`vibe_semiconductors_v1`.`finance`.`transfer_price`"
  dimensions:
    - name: "price_method"
      expr: price_method
      comment: "Transfer pricing method (CUP, cost-plus, TNMM, profit split) — primary dimension for OECD compliance analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of transfer pricing agreement (product, service, IP license) — supports intercompany transaction classification."
    - name: "transfer_price_type"
      expr: transfer_price_type
      comment: "Type of transfer price (standard, actual, negotiated) — distinguishes pricing approaches for compliance reporting."
    - name: "transfer_price_status"
      expr: transfer_price_status
      comment: "Status of the transfer price (active, expired, under review) — filters for current vs. historical pricing."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the transfer price — identifies unapproved prices that may create tax risk."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the transfer price is compliant with applicable regulations — critical for tax audit risk management."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Whether the transfer is subject to tax — used to identify taxable intercompany flows."
    - name: "product_category"
      expr: product_category
      comment: "Product category covered by the transfer price — supports product-level intercompany pricing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transfer price — required for multi-currency intercompany analysis."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the transfer price became effective — supports annual pricing trend analysis."
  measures:
    - name: "avg_effective_price_per_unit"
      expr: AVG(CAST(effective_price_per_unit AS DOUBLE))
      comment: "Average effective transfer price per unit. Core metric for intercompany pricing benchmarking and arm's-length compliance."
    - name: "avg_margin_rate"
      expr: AVG(CAST(margin_rate AS DOUBLE))
      comment: "Average margin rate applied in transfer pricing. Monitors arm's-length margin compliance — deviations trigger tax authority scrutiny."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average tax rate applied to transfer prices. Supports effective tax rate analysis and tax planning."
    - name: "total_price_amount"
      expr: SUM(CAST(price_amount AS DOUBLE))
      comment: "Total transfer price amount across all agreements. Quantifies the scale of intercompany transactions subject to transfer pricing rules."
    - name: "transfer_price_count"
      expr: COUNT(1)
      comment: "Total number of transfer price records. Used to assess intercompany pricing coverage and documentation completeness."
    - name: "non_compliant_price_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of transfer prices flagged as non-compliant. Each non-compliant price represents a potential tax adjustment risk requiring immediate remediation."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_tax_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks income tax provisions including current and deferred tax balances, effective tax rates, and credit carryforwards. Supports ASC 740 / IAS 12 compliance, tax planning, and earnings quality analysis."
  source: "`vibe_semiconductors_v1`.`finance`.`tax_provision`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (income, deferred, withholding) — primary classification for tax provision analysis."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Tax jurisdiction — enables jurisdiction-level effective tax rate analysis and Pillar Two compliance monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax provision — primary time dimension for annual tax reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the provision — supports quarterly tax provision close monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the tax provision — filters for approved vs. pending provisions in financial reporting."
    - name: "tax_provision_status"
      expr: tax_provision_status
      comment: "Lifecycle status of the provision (open, closed, reversed) — used for provision completeness monitoring."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the provision has been reversed — tracks temporary difference reversals."
    - name: "tax_rate_change_indicator"
      expr: tax_rate_change_indicator
      comment: "Whether a tax rate change affected this provision — flags provisions requiring remeasurement disclosure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the provision amounts — required for multi-currency tax reporting."
  measures:
    - name: "total_tax_expense_amount"
      expr: SUM(CAST(tax_expense_amount AS DOUBLE))
      comment: "Total income tax expense. Primary P&L tax metric — directly impacts reported earnings and effective tax rate."
    - name: "total_deferred_tax_asset"
      expr: SUM(CAST(deferred_tax_asset_amount AS DOUBLE))
      comment: "Total deferred tax asset balance. Tracks future tax benefits from temporary differences — key balance sheet metric for tax planning."
    - name: "total_deferred_tax_liability"
      expr: SUM(CAST(deferred_tax_liability_amount AS DOUBLE))
      comment: "Total deferred tax liability balance. Represents future tax obligations — monitored for balance sheet risk and cash flow planning."
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total taxable base amount across provisions. Used to validate effective tax rate calculations."
    - name: "total_tax_credit_carryforward"
      expr: SUM(CAST(tax_credit_carryforward_amount AS DOUBLE))
      comment: "Total tax credit carryforward balance. Represents future tax savings — critical for tax planning and valuation allowance assessment."
    - name: "total_tax_credit_used"
      expr: SUM(CAST(tax_credit_used_amount AS DOUBLE))
      comment: "Total tax credits utilized in the period. Tracks the consumption of tax credit assets — supports R&D credit and CHIPS Act incentive utilization analysis."
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(effective_tax_rate AS DOUBLE))
      comment: "Average effective tax rate across provisions. Core metric for tax efficiency benchmarking and investor communications."
    - name: "tax_provision_count"
      expr: COUNT(1)
      comment: "Total number of tax provision records. Used for provision completeness and audit coverage assessment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors intercompany transaction volumes, amounts, and elimination status. Supports consolidation close, intercompany reconciliation, and transfer pricing compliance."
  source: "`vibe_semiconductors_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (product sale, service, IP royalty, loan) — primary classification for intercompany analysis."
    - name: "intercompany_transaction_status"
      expr: intercompany_transaction_status
      comment: "Status of the transaction (posted, eliminated, pending) — critical for consolidation close completeness."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction — enables year-over-year intercompany volume trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction — supports monthly intercompany reconciliation."
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Whether the transaction has been eliminated in consolidation — uneliminated intercompany transactions overstate consolidated revenue."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether the transaction requires regulatory reporting — identifies transactions subject to country-by-country reporting."
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method applied — supports OECD documentation and tax authority audit readiness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction — required for multi-currency intercompany analysis."
    - name: "transaction_timestamp_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the transaction — supports monthly intercompany volume trend analysis."
  measures:
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross intercompany transaction amount. Quantifies the scale of intercompany flows subject to elimination and transfer pricing rules."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net intercompany transaction amount after tax. Used for net intercompany balance reconciliation."
    - name: "total_amount_tax"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax on intercompany transactions. Supports withholding tax and indirect tax compliance analysis."
    - name: "avg_transfer_pricing_margin"
      expr: AVG(CAST(transfer_pricing_margin AS DOUBLE))
      comment: "Average transfer pricing margin applied. Monitors arm's-length margin compliance across intercompany transactions."
    - name: "avg_transfer_pricing_rate"
      expr: AVG(CAST(transfer_pricing_rate AS DOUBLE))
      comment: "Average transfer pricing rate. Tracks rate consistency and identifies deviations from approved pricing policies."
    - name: "intercompany_transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions. Baseline for reconciliation completeness and elimination workload sizing."
    - name: "uneliminated_transaction_count"
      expr: COUNT(CASE WHEN elimination_flag = FALSE THEN 1 END)
      comment: "Number of intercompany transactions not yet eliminated. Uneliminated transactions overstate consolidated financials — requires immediate close action."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_consolidation_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks consolidation journal entries including adjustment amounts and reversal activity. Supports group close governance, consolidation quality monitoring, and multi-entity financial reporting."
  source: "`vibe_semiconductors_v1`.`finance`.`consolidation_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of consolidation entry (elimination, adjustment, currency translation) — primary classification for consolidation analysis."
    - name: "consolidation_method"
      expr: consolidation_method
      comment: "Consolidation method applied (full, proportional, equity) — used to validate method consistency across entities."
    - name: "consolidation_entry_status"
      expr: consolidation_entry_status
      comment: "Status of the consolidation entry (posted, reversed, pending) — critical for group close completeness monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the consolidation entry — primary time dimension for annual group reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the entry — supports monthly group close monitoring."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether the entry is a reversal — tracks temporary consolidation adjustments."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the consolidation entry — required for multi-currency group reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of the effective date — supports monthly consolidation trend analysis."
  measures:
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross amount of consolidation entries. Quantifies the scale of consolidation adjustments in the group close."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net consolidation entry amount. Primary metric for group P&L and balance sheet impact of consolidation adjustments."
    - name: "total_amount_adjustment"
      expr: SUM(CAST(amount_adjustment AS DOUBLE))
      comment: "Total adjustment amount in consolidation entries. Large adjustments signal significant intercompany or currency translation impacts."
    - name: "consolidation_entry_count"
      expr: COUNT(1)
      comment: "Total number of consolidation entries. Used to assess group close complexity and completeness."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Number of reversal consolidation entries. Tracks temporary adjustment activity in the group close process."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_nre_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks NRE (Non-Recurring Engineering) agreement financials including total NRE amounts, recovery methods, and CHIPS Act linkage. Supports NRE revenue recognition, customer contract governance, and R&D cost recovery analysis."
  source: "`vibe_semiconductors_v1`.`finance`.`finance_nre_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of NRE agreement (design, mask, process development) — primary classification for NRE revenue analysis."
    - name: "finance_nre_agreement_status"
      expr: finance_nre_agreement_status
      comment: "Status of the NRE agreement (active, completed, terminated) — filters for active vs. closed agreements."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method for recovering NRE costs (milestone, time-and-materials, fixed-fee) — supports revenue recognition method analysis."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method applied (ASC 606 POC, milestone) — critical for financial reporting compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the NRE agreement — required for multi-currency NRE revenue reporting."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the NRE agreement — supports regional NRE revenue analysis."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the NRE agreement became effective — supports annual NRE revenue trend analysis."
  measures:
    - name: "total_nre_amount"
      expr: SUM(CAST(total_nre_amount AS DOUBLE))
      comment: "Total NRE agreement value. Primary metric for NRE revenue pipeline and R&D cost recovery tracking."
    - name: "avg_nre_amount"
      expr: AVG(CAST(total_nre_amount AS DOUBLE))
      comment: "Average NRE agreement value. Tracks deal size trends — increasing averages indicate movement toward larger, more complex design engagements."
    - name: "nre_agreement_count"
      expr: COUNT(1)
      comment: "Total number of NRE agreements. Measures the breadth of customer design engagement activity."
    - name: "active_nre_agreement_count"
      expr: COUNT(CASE WHEN finance_nre_agreement_status = 'active' THEN 1 END)
      comment: "Number of active NRE agreements. Tracks the current NRE revenue backlog and customer engagement pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_nre_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks NRE milestone billing and revenue recognition including milestone amounts, completion status, and revenue recognition timing. Supports ASC 606 compliance, cash flow forecasting, and NRE billing governance."
  source: "`vibe_semiconductors_v1`.`finance`.`finance_nre_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of NRE milestone (design complete, tapeout, silicon bring-up) — primary classification for milestone billing analysis."
    - name: "finance_nre_milestone_status"
      expr: finance_nre_milestone_status
      comment: "Status of the milestone (pending, completed, invoiced) — critical for billing pipeline and revenue recognition monitoring."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice status of the milestone (not invoiced, invoiced, paid) — supports cash collection tracking."
    - name: "is_revenue_recognized"
      expr: is_revenue_recognized
      comment: "Whether revenue has been recognized for this milestone — critical for ASC 606 compliance monitoring."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method applied — supports multi-method revenue analysis."
    - name: "expense_type"
      expr: expense_type
      comment: "Type of expense associated with the milestone — supports cost-to-complete analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the milestone has a compliance requirement — tracks regulatory obligations in NRE billing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the milestone amounts — required for multi-currency NRE reporting."
    - name: "planned_completion_date_month"
      expr: DATE_TRUNC('MONTH', planned_completion_date)
      comment: "Month of planned completion — supports NRE billing schedule and cash flow forecasting."
  measures:
    - name: "total_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross NRE milestone amount. Primary metric for NRE billing pipeline and revenue backlog quantification."
    - name: "total_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net NRE milestone amount after tax. Used for net NRE revenue recognition and P&L impact analysis."
    - name: "total_amount_tax"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax on NRE milestones. Supports indirect tax compliance and cash flow planning."
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Total number of NRE milestones. Used to assess billing schedule completeness and revenue recognition coverage."
    - name: "recognized_milestone_count"
      expr: COUNT(CASE WHEN is_revenue_recognized = TRUE THEN 1 END)
      comment: "Number of milestones with revenue recognized. Tracks ASC 606 recognition completeness — unrecognized completed milestones represent deferred revenue risk."
    - name: "unrecognized_milestone_amount"
      expr: SUM(CASE WHEN is_revenue_recognized = FALSE THEN amount_net ELSE 0 END)
      comment: "Total net amount of milestones where revenue has not yet been recognized. Quantifies the deferred revenue balance requiring recognition action."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks WBS (Work Breakdown Structure) element budget execution and cost performance. Supports project cost control, R&D capitalization eligibility, and capital expenditure governance."
  source: "`vibe_semiconductors_v1`.`finance`.`wbs_element`"
  dimensions:
    - name: "wbs_element_type"
      expr: wbs_element_type
      comment: "Type of WBS element (project, phase, work package) — primary classification for project cost analysis."
    - name: "wbs_element_status"
      expr: wbs_element_status
      comment: "Status of the WBS element (open, closed, technically complete) — filters for active vs. closed project elements."
    - name: "project_phase"
      expr: project_phase
      comment: "Phase of the project (feasibility, development, production) — supports phase-gate cost analysis."
    - name: "is_capital_expenditure"
      expr: is_capital_expenditure
      comment: "Whether the WBS element is a capex item — distinguishes capex from opex for balance sheet treatment."
    - name: "r_and_d_capitalization_flag"
      expr: r_and_d_capitalization_flag
      comment: "Whether R&D costs on this WBS element are eligible for capitalization — critical for ASC 730 / IAS 38 compliance."
    - name: "wbs_element_level"
      expr: wbs_element_level
      comment: "Hierarchy level of the WBS element — used to filter for summary vs. detail-level cost reporting."
    - name: "financial_year"
      expr: financial_year
      comment: "Financial year of the WBS element — supports annual project cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the WBS element amounts — required for multi-currency project cost reporting."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted cost across WBS elements. Primary metric for project budget adequacy and cost control."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across WBS elements. Core project cost performance metric — compared against budget to identify overruns."
    - name: "total_cost_variance"
      expr: SUM(CAST(budget_amount AS DOUBLE) - CAST(actual_cost AS DOUBLE))
      comment: "Total cost variance (budget minus actual) across WBS elements. Negative variance signals project cost overruns requiring management intervention."
    - name: "wbs_element_count"
      expr: COUNT(1)
      comment: "Total number of WBS elements. Used to assess project structure complexity and cost control coverage."
    - name: "capex_wbs_count"
      expr: COUNT(CASE WHEN is_capital_expenditure = TRUE THEN 1 END)
      comment: "Number of WBS elements classified as capex. Tracks the capital investment component of the project portfolio."
    - name: "rd_capitalizable_wbs_count"
      expr: COUNT(CASE WHEN r_and_d_capitalization_flag = TRUE THEN 1 END)
      comment: "Number of WBS elements eligible for R&D capitalization. Tracks the scope of capitalizable development costs under ASC 730 / IAS 38."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_rd_capitalization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks R&D capitalization events including capitalized amounts, amortization linkage, and audit status. Supports ASC 730 / IAS 38 compliance, IP asset creation tracking, and technology investment governance."
  source: "`vibe_semiconductors_v1`.`finance`.`rd_capitalization`"
  dimensions:
    - name: "capitalized_asset_type"
      expr: capitalized_asset_type
      comment: "Type of capitalized R&D asset (software, IP core, process technology) — primary classification for R&D asset analysis."
    - name: "rd_capitalization_status"
      expr: rd_capitalization_status
      comment: "Status of the capitalization event (active, reversed, amortizing) — filters for current vs. historical capitalizations."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Amortization method applied to the capitalized R&D asset — used to validate method consistency."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the capitalization event — supports annual R&D capitalization trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the capitalization — supports quarterly R&D capitalization reporting."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether the capitalization was reversed — tracks write-offs of previously capitalized R&D."
    - name: "external_audit_flag"
      expr: external_audit_flag
      comment: "Whether the capitalization was subject to external audit — used to assess audit coverage of R&D assets."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "TRL at time of capitalization — supports stage-gate analysis of when R&D transitions from expense to asset."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the capitalization amounts — required for multi-currency R&D asset reporting."
  measures:
    - name: "total_capitalized_amount"
      expr: SUM(CAST(capitalized_amount AS DOUBLE))
      comment: "Total R&D costs capitalized as intangible assets. Primary metric for R&D investment conversion to balance sheet assets — key for IP valuation."
    - name: "total_original_expense_amount"
      expr: SUM(CAST(original_expense_amount AS DOUBLE))
      comment: "Total original R&D expense amount before capitalization. Used to calculate the capitalization rate (capitalized / total R&D spend)."
    - name: "rd_capitalization_count"
      expr: COUNT(1)
      comment: "Total number of R&D capitalization events. Used to assess the breadth of R&D asset creation activity."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Number of R&D capitalization reversals. Reversals indicate write-offs of previously capitalized R&D — signals technology project failures or impairment."
    - name: "externally_audited_count"
      expr: COUNT(CASE WHEN external_audit_flag = TRUE THEN 1 END)
      comment: "Number of capitalizations subject to external audit. Tracks audit coverage of R&D assets — important for SOX and financial statement audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_amortization_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors amortization schedules for intangible assets including period amounts, remaining balances, and accumulated amortization. Supports intangible asset lifecycle management and period-end close accuracy."
  source: "`vibe_semiconductors_v1`.`finance`.`amortization_schedule`"
  dimensions:
    - name: "amortization_method"
      expr: amortization_method
      comment: "Amortization method applied (straight-line, units of production) — primary dimension for method consistency analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of amortization schedule (book, tax, IFRS) — supports multi-GAAP amortization reporting."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the schedule (active, completed, suspended) — filters for active vs. completed amortization."
    - name: "depreciation_category"
      expr: depreciation_category
      comment: "Category of the asset being amortized — supports asset class-level amortization analysis."
    - name: "period_type"
      expr: period_type
      comment: "Type of amortization period (monthly, quarterly, annual) — used to validate schedule cadence."
    - name: "tax_effect_flag"
      expr: tax_effect_flag
      comment: "Whether the amortization has a tax effect — used to identify schedules requiring deferred tax calculation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amortization amounts — required for multi-currency intangible asset reporting."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the amortization schedule became effective — supports vintage analysis of intangible assets."
  measures:
    - name: "total_period_amount"
      expr: SUM(CAST(period_amount AS DOUBLE))
      comment: "Total periodic amortization amount. Primary P&L metric for intangible asset amortization expense."
    - name: "total_accumulated_amortization"
      expr: SUM(CAST(accumulated_amortization AS DOUBLE))
      comment: "Total accumulated amortization across all schedules. Measures how much of the intangible asset base has been consumed."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining unamortized balance. Represents the net book value of intangible assets — key balance sheet metric."
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total original amortizable amount across all schedules. Used to calculate the amortization completion rate."
    - name: "amortization_schedule_count"
      expr: COUNT(1)
      comment: "Total number of amortization schedules. Used to assess intangible asset coverage and schedule completeness."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_legal_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides legal entity master analytics including entity counts by type, jurisdiction, and compliance status. Supports group structure governance, regulatory compliance monitoring, and consolidation scope management."
  source: "`vibe_semiconductors_v1`.`finance`.`legal_entity`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Type of legal entity (subsidiary, branch, JV, holding) — primary classification for group structure analysis."
    - name: "legal_entity_status"
      expr: legal_entity_status
      comment: "Status of the legal entity (active, dormant, in liquidation) — filters for operational vs. inactive entities."
    - name: "country_of_incorporation"
      expr: country_of_incorporation
      comment: "Country where the entity is incorporated — primary geographic dimension for regulatory and tax analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the entity — identifies entities with outstanding regulatory obligations."
    - name: "is_public_company"
      expr: is_public_company
      comment: "Whether the entity is publicly listed — distinguishes listed vs. private entities for disclosure requirements."
    - name: "reporting_currency"
      expr: reporting_currency
      comment: "Reporting currency of the entity — supports multi-currency consolidation analysis."
    - name: "tax_status"
      expr: tax_status
      comment: "Tax status of the entity — used for tax planning and Pillar Two compliance analysis."
    - name: "incorporation_date_year"
      expr: YEAR(incorporation_date)
      comment: "Year of incorporation — supports entity vintage analysis and group structure evolution tracking."
  measures:
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue across legal entities. Supports group revenue sizing and Pillar Two revenue threshold compliance (EUR 750M threshold)."
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per legal entity. Used to identify material vs. immaterial entities for consolidation scope decisions."
    - name: "legal_entity_count"
      expr: COUNT(1)
      comment: "Total number of legal entities. Measures group complexity — directly impacts consolidation effort and regulatory reporting burden."
    - name: "active_entity_count"
      expr: COUNT(CASE WHEN legal_entity_status = 'active' THEN 1 END)
      comment: "Number of active legal entities. Tracks the operational footprint of the corporate group."
    - name: "non_compliant_entity_count"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' THEN 1 END)
      comment: "Number of entities with non-compliant status. Each non-compliant entity represents a regulatory risk requiring remediation."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors profit center financial performance including budget, actual spend, and variance. Supports P&L accountability, cost allocation governance, and technology node profitability analysis."
  source: "`vibe_semiconductors_v1`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Type of profit center (product line, geography, technology node) — primary classification for P&L analysis."
    - name: "profit_center_category"
      expr: profit_center_category
      comment: "Category of the profit center — supports granular P&L segmentation."
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Status of the profit center (active, closed) — filters for operational vs. inactive profit centers."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the profit center — enables regional P&L analysis."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node associated with the profit center — supports node-level profitability analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line of the profit center — enables product-line P&L analysis."
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Whether the profit center is included in group consolidation — used to validate consolidation scope."
    - name: "sox_compliant"
      expr: sox_compliant
      comment: "Whether the profit center is SOX compliant — identifies entities requiring enhanced internal controls."
    - name: "reporting_currency"
      expr: reporting_currency
      comment: "Reporting currency of the profit center — required for multi-currency P&L analysis."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across profit centers. Primary metric for P&L budget sizing and resource allocation."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend across profit centers. Core P&L execution metric — compared against budget to identify variances."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget vs. actual variance across profit centers. Negative variance signals overspend requiring management intervention."
    - name: "avg_allocation_percent"
      expr: AVG(CAST(allocation_percent AS DOUBLE))
      comment: "Average cost allocation percentage across profit centers. Monitors allocation policy consistency."
    - name: "profit_center_count"
      expr: COUNT(1)
      comment: "Total number of profit centers. Used to assess P&L reporting granularity and organizational complexity."
    - name: "sox_compliant_count"
      expr: COUNT(CASE WHEN sox_compliant = TRUE THEN 1 END)
      comment: "Number of SOX-compliant profit centers. Tracks internal control coverage across the P&L reporting structure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_gl_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides chart of accounts analytics including account balances, hierarchy coverage, and budget control status. Supports financial close governance, account rationalization, and chart of accounts optimization."
  source: "`vibe_semiconductors_v1`.`finance`.`gl_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of GL account (P&L, balance sheet, statistical) — primary classification for financial statement analysis."
    - name: "account_category"
      expr: account_category
      comment: "Category of the GL account (revenue, expense, asset, liability) — supports financial statement line analysis."
    - name: "account_group"
      expr: account_group
      comment: "Account group in the chart of accounts — used for account hierarchy and reporting structure analysis."
    - name: "gl_account_status"
      expr: gl_account_status
      comment: "Status of the GL account (active, blocked, marked for deletion) — filters for active vs. inactive accounts."
    - name: "is_budget_controlled"
      expr: is_budget_controlled
      comment: "Whether the account is subject to budget control — identifies accounts with spending limits."
    - name: "is_reconciliation_account"
      expr: is_reconciliation_account
      comment: "Whether the account is a reconciliation account — reconciliation accounts require sub-ledger matching."
    - name: "is_consolidation_account"
      expr: is_consolidation_account
      comment: "Whether the account is used in group consolidation — identifies accounts included in the consolidated financial statements."
    - name: "financial_statement"
      expr: financial_statement
      comment: "Financial statement the account appears on (P&L, balance sheet, cash flow) — supports statement-level analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the GL account — required for multi-currency chart of accounts analysis."
  measures:
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance across GL accounts. Baseline for period movement analysis and balance sheet reconciliation."
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance AS DOUBLE))
      comment: "Total closing balance across GL accounts. Primary balance sheet metric for period-end financial reporting."
    - name: "total_period_movement"
      expr: SUM(CAST(closing_balance AS DOUBLE) - CAST(opening_balance AS DOUBLE))
      comment: "Total period movement (closing minus opening balance) across GL accounts. Quantifies the net financial activity in the period."
    - name: "gl_account_count"
      expr: COUNT(1)
      comment: "Total number of GL accounts. Used to assess chart of accounts complexity and rationalization opportunities."
    - name: "budget_controlled_account_count"
      expr: COUNT(CASE WHEN is_budget_controlled = TRUE THEN 1 END)
      comment: "Number of budget-controlled GL accounts. Tracks the scope of budget control coverage in the chart of accounts."
    - name: "avg_depreciation_rate"
      expr: AVG(CAST(depreciation_rate AS DOUBLE))
      comment: "Average depreciation rate on GL accounts configured for asset depreciation. Monitors rate consistency across asset accounts."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`finance_allocation_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors cost allocation cycle configuration and execution including allocation percentages, frequency, and automation status. Supports overhead absorption governance and period-end close efficiency."
  source: "`vibe_semiconductors_v1`.`finance`.`allocation_cycle`"
  dimensions:
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of allocation cycle (assessment, distribution, settlement) — primary classification for allocation method analysis."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used in the allocation cycle — supports allocation policy governance."
    - name: "allocation_frequency"
      expr: allocation_frequency
      comment: "Frequency of the allocation cycle (monthly, quarterly) — used to validate cycle cadence and close schedule alignment."
    - name: "allocation_cycle_status"
      expr: allocation_cycle_status
      comment: "Status of the allocation cycle (active, inactive, completed) — filters for operational vs. closed cycles."
    - name: "is_automatic"
      expr: is_automatic
      comment: "Whether the cycle runs automatically — tracks automation coverage of the allocation process."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis for the allocation (headcount, square footage, revenue) — supports allocation driver analysis."
    - name: "last_run_timestamp_month"
      expr: DATE_TRUNC('MONTH', last_run_timestamp)
      comment: "Month of the last allocation run — used to identify stale cycles that have not run recently."
  measures:
    - name: "avg_default_allocation_percentage"
      expr: AVG(CAST(default_allocation_percentage AS DOUBLE))
      comment: "Average default allocation percentage across cycles. Monitors allocation rate consistency and identifies outliers."
    - name: "allocation_cycle_count"
      expr: COUNT(1)
      comment: "Total number of allocation cycles. Used to assess the complexity of the overhead allocation structure."
    - name: "automatic_cycle_count"
      expr: COUNT(CASE WHEN is_automatic = TRUE THEN 1 END)
      comment: "Number of automated allocation cycles. Higher automation rates reduce manual close effort and error risk."
    - name: "active_cycle_count"
      expr: COUNT(CASE WHEN allocation_cycle_status = 'active' THEN 1 END)
      comment: "Number of active allocation cycles. Tracks the operational scope of the cost allocation framework."
$$;