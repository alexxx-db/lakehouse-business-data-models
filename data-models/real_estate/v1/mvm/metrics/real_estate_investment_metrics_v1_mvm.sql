-- Metric views for domain: investment | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`investment_asset_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core asset-level investment performance KPIs covering NOI, cap rate, IRR, occupancy, leverage, and return metrics. Used by portfolio managers and investment committees to evaluate individual asset health and compare against underwriting targets."
  source: "`real_estate_ecm`.`investment`.`asset_performance`"
  dimensions:
    - name: "performance_status"
      expr: performance_status
      comment: "Current performance status of the asset (e.g. Stabilized, Value-Add, Distressed) used to segment KPIs by asset lifecycle stage."
    - name: "period_type"
      expr: period_type
      comment: "Reporting period granularity (e.g. Monthly, Quarterly, Annual) enabling time-series analysis at the correct cadence."
    - name: "hold_period_years"
      expr: hold_period_years
      comment: "Planned hold period bucket for the asset, used to segment return metrics by investment horizon."
    - name: "sensitivity_scenario"
      expr: sensitivity_scenario
      comment: "Underwriting scenario label (e.g. Base, Upside, Downside) enabling scenario-based performance comparison."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system that originated the performance record, used for data lineage and reconciliation."
    - name: "performance_period_start_year"
      expr: YEAR(performance_period_start_date)
      comment: "Calendar year of the performance period start date, enabling year-over-year trend analysis."
    - name: "performance_period_start_quarter"
      expr: DATE_TRUNC('quarter', performance_period_start_date)
      comment: "Quarter of the performance period start date for quarterly KPI trending."
  measures:
    - name: "total_noi"
      expr: SUM(CAST(noi AS DOUBLE))
      comment: "Total Net Operating Income across assets in scope. Primary income metric used by investment committees to assess portfolio cash generation."
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average capitalization rate across assets. Drives asset valuation and acquisition/disposition pricing decisions."
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average physical occupancy rate across assets. A primary leading indicator of revenue stability and leasing performance."
    - name: "avg_unlevered_irr"
      expr: AVG(CAST(unlevered_irr AS DOUBLE))
      comment: "Average unlevered IRR across assets, reflecting pure asset-level return before financing effects. Used to benchmark against target IRR hurdles."
    - name: "avg_levered_irr"
      expr: AVG(CAST(levered_irr AS DOUBLE))
      comment: "Average levered IRR across assets, reflecting equity return after debt service. Key metric for LP reporting and fund performance attribution."
    - name: "avg_cash_on_cash_return"
      expr: AVG(CAST(cash_on_cash_return AS DOUBLE))
      comment: "Average cash-on-cash return, measuring annual pre-tax cash flow relative to equity invested. Used by investors to assess near-term yield."
    - name: "avg_dscr"
      expr: AVG(CAST(dscr AS DOUBLE))
      comment: "Average Debt Service Coverage Ratio across assets. Critical for covenant compliance monitoring and lender reporting."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average Loan-to-Value ratio across assets. Monitors leverage risk and covenant headroom against lender thresholds."
    - name: "total_noi_psf"
      expr: SUM(CAST(noi AS DOUBLE)) / NULLIF(SUM(CAST(nla_sqft AS DOUBLE)), 0)
      comment: "Portfolio-weighted NOI per square foot, enabling cross-asset productivity comparison on a normalized area basis."
    - name: "avg_vacancy_rate"
      expr: AVG(CAST(vacancy_rate AS DOUBLE))
      comment: "Average vacancy rate across assets. Inverse of occupancy; used to quantify revenue leakage from unleased space."
    - name: "total_vacancy_credit_loss"
      expr: SUM(CAST(vacancy_credit_loss AS DOUBLE))
      comment: "Total revenue lost to vacancy and credit loss. Quantifies the financial impact of unleased or non-paying space across the portfolio."
    - name: "total_capex"
      expr: SUM(CAST(capex AS DOUBLE))
      comment: "Total capital expenditure deployed across assets in the period. Used to track reinvestment levels and assess value-add execution."
    - name: "avg_total_return"
      expr: AVG(CAST(total_return AS DOUBLE))
      comment: "Average total return (income + appreciation) across assets. The headline performance metric for investor reporting and benchmark comparison."
    - name: "avg_exit_cap_rate"
      expr: AVG(CAST(exit_cap_rate AS DOUBLE))
      comment: "Average underwritten exit cap rate. Drives terminal value assumptions and sensitivity to market cap rate movements at disposition."
    - name: "avg_projected_noi_growth_rate"
      expr: AVG(CAST(projected_noi_growth_rate AS DOUBLE))
      comment: "Average projected NOI growth rate across assets. Forward-looking metric used in underwriting and portfolio stress testing."
    - name: "total_npv"
      expr: SUM(CAST(npv AS DOUBLE))
      comment: "Total Net Present Value across assets. Aggregates discounted cash flow value creation, used in investment committee approvals."
    - name: "avg_walt"
      expr: AVG(CAST(walt AS DOUBLE))
      comment: "Average Weighted Average Lease Term across assets. Measures income security and re-leasing risk horizon for the portfolio."
    - name: "avg_opex_psf"
      expr: AVG(CAST(opex_psf AS DOUBLE))
      comment: "Average operating expense per square foot. Benchmarks operational efficiency across assets and identifies cost outliers."
    - name: "total_egi"
      expr: SUM(CAST(egi AS DOUBLE))
      comment: "Total Effective Gross Income across assets, representing gross potential income net of vacancy and credit loss. Core revenue line for NOI derivation."
    - name: "total_operating_expenses"
      expr: SUM(CAST(operating_expenses AS DOUBLE))
      comment: "Total operating expenses across assets. Used alongside EGI to derive NOI and assess expense management performance."
    - name: "asset_count"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets with performance records in scope. Provides portfolio size context for all per-asset averages."
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`investment_fund_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund-level performance metrics covering NAV, IRR, equity multiples, distributions, leverage, and benchmark comparison. Primary view for LP reporting, board decks, and regulatory filings."
  source: "`real_estate_ecm`.`investment`.`fund_performance`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Reporting period granularity (Monthly, Quarterly, Annual) for time-series fund performance analysis."
    - name: "period_status"
      expr: period_status
      comment: "Status of the reporting period (e.g. Preliminary, Final, Audited) to filter for authoritative figures."
    - name: "nav_methodology"
      expr: nav_methodology
      comment: "Valuation methodology used to compute NAV (e.g. DCF, Market Comparable, Cost) for methodology-level comparison."
    - name: "benchmark_name"
      expr: benchmark_name
      comment: "Name of the benchmark index used for alpha and relative return calculations."
    - name: "auditor_signoff_status"
      expr: auditor_signoff_status
      comment: "Audit sign-off status of the period financials, critical for regulatory and LP reporting governance."
    - name: "period_end_year"
      expr: YEAR(period_end_date)
      comment: "Calendar year of the fund performance period end date for annual trend analysis."
    - name: "period_end_quarter"
      expr: DATE_TRUNC('quarter', period_end_date)
      comment: "Quarter of the fund performance period end date for quarterly LP reporting."
  measures:
    - name: "total_nav"
      expr: SUM(CAST(nav AS DOUBLE))
      comment: "Total Net Asset Value across fund performance records. The primary fund valuation metric reported to LPs and regulators."
    - name: "total_aum"
      expr: SUM(CAST(aum AS DOUBLE))
      comment: "Total Assets Under Management. Headline fund size metric used for management fee calculation and market positioning."
    - name: "avg_net_irr"
      expr: AVG(CAST(net_irr AS DOUBLE))
      comment: "Average net IRR (after fees and carry) across reporting periods. The primary return metric for LP performance evaluation."
    - name: "avg_gross_irr"
      expr: AVG(CAST(gross_irr AS DOUBLE))
      comment: "Average gross IRR (before fees and carry). Used alongside net IRR to quantify fee drag and assess GP value creation."
    - name: "avg_equity_multiple"
      expr: AVG(CAST(equity_multiple AS DOUBLE))
      comment: "Average equity multiple (MOIC) across periods. Measures total value returned per dollar invested, a key LP return metric."
    - name: "avg_tvpi"
      expr: AVG(CAST(tvpi AS DOUBLE))
      comment: "Average Total Value to Paid-In capital ratio. Combines DPI and RVPI to show total value creation relative to invested capital."
    - name: "avg_dpi"
      expr: AVG(CAST(dpi AS DOUBLE))
      comment: "Average Distributions to Paid-In capital ratio. Measures realized returns actually returned to LPs — a key liquidity metric."
    - name: "avg_rvpi"
      expr: AVG(CAST(rvpi AS DOUBLE))
      comment: "Average Residual Value to Paid-In capital ratio. Measures unrealized value remaining in the fund relative to invested capital."
    - name: "avg_leverage_ratio"
      expr: AVG(CAST(leverage_ratio AS DOUBLE))
      comment: "Average fund-level leverage ratio. Monitors debt utilization against policy limits and lender covenants."
    - name: "total_distributions"
      expr: SUM(CAST(total_distributions AS DOUBLE))
      comment: "Total cash distributions made to investors. Tracks cumulative capital returned and informs DPI calculations."
    - name: "avg_nav_per_unit"
      expr: AVG(CAST(nav_per_unit AS DOUBLE))
      comment: "Average NAV per unit across reporting periods. Used for unit pricing, subscription/redemption processing, and LP statements."
    - name: "avg_alpha"
      expr: AVG(CAST(alpha AS DOUBLE))
      comment: "Average alpha (excess return over benchmark) across periods. Measures GP skill in generating returns above market indices."
    - name: "avg_benchmark_return"
      expr: AVG(CAST(benchmark_return AS DOUBLE))
      comment: "Average benchmark index return for the same periods. Provides the baseline for alpha and relative performance assessment."
    - name: "total_noi"
      expr: SUM(CAST(noi AS DOUBLE))
      comment: "Total NOI at fund level across reporting periods. Tracks operating income generation as a driver of fund-level returns."
    - name: "total_capex"
      expr: SUM(CAST(capex AS DOUBLE))
      comment: "Total capital expenditure at fund level. Monitors reinvestment activity and value-add execution across the fund portfolio."
    - name: "avg_cap_rate"
      expr: AVG(CAST(cap_rate AS DOUBLE))
      comment: "Average fund-level cap rate across reporting periods. Tracks portfolio yield compression or expansion over time."
    - name: "avg_premium_discount_to_nav"
      expr: AVG(CAST(premium_discount_to_nav AS DOUBLE))
      comment: "Average premium or discount to NAV. For listed or semi-liquid vehicles, indicates market sentiment relative to intrinsic value."
    - name: "avg_twr"
      expr: AVG(CAST(twr AS DOUBLE))
      comment: "Average Time-Weighted Return, eliminating the distortion of cash flow timing. Standard GIPS-compliant return metric for manager performance comparison."
    - name: "avg_mwr"
      expr: AVG(CAST(mwr AS DOUBLE))
      comment: "Average Money-Weighted Return, reflecting the actual investor experience including timing of capital flows. Complements TWR for LP reporting."
    - name: "fund_performance_period_count"
      expr: COUNT(1)
      comment: "Number of fund performance reporting periods in scope. Provides denominator context for all average metrics."
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`investment_capital_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investor-level capital account metrics tracking contributions, distributions, balances, and returns. Core view for LP statements, waterfall calculations, and investor relations reporting."
  source: "`real_estate_ecm`.`investment`.`capital_account`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the capital account statement, enabling year-over-year investor return analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the capital account statement for quarterly LP reporting cadence."
    - name: "period_type"
      expr: period_type
      comment: "Period type (e.g. Quarterly, Annual) for the capital account statement."
    - name: "statement_status"
      expr: statement_status
      comment: "Status of the capital account statement (e.g. Draft, Final, Audited) to filter for authoritative investor figures."
    - name: "is_tax_exempt_investor"
      expr: is_tax_exempt_investor
      comment: "Flag indicating whether the investor is tax-exempt (e.g. pension fund, endowment). Enables tax-sensitive return segmentation."
    - name: "statement_period_end_quarter"
      expr: DATE_TRUNC('quarter', statement_period_end_date)
      comment: "Quarter of the statement period end date for time-series capital account trending."
  measures:
    - name: "total_capital_contributions"
      expr: SUM(CAST(capital_contributions AS DOUBLE))
      comment: "Total capital contributed by investors in the period. Tracks pace of capital deployment against fund commitments."
    - name: "total_capital_distributions"
      expr: SUM(CAST(capital_distributions AS DOUBLE))
      comment: "Total capital distributed to investors in the period. Primary metric for LP liquidity and DPI tracking."
    - name: "total_ending_capital_balance"
      expr: SUM(CAST(ending_capital_balance AS DOUBLE))
      comment: "Total ending capital balance across investor accounts. Represents aggregate LP equity at period end."
    - name: "total_cumulative_contributions"
      expr: SUM(CAST(cumulative_contributions AS DOUBLE))
      comment: "Total cumulative capital contributed since inception. Denominator for DPI, RVPI, and TVPI calculations."
    - name: "total_cumulative_distributions"
      expr: SUM(CAST(cumulative_distributions AS DOUBLE))
      comment: "Total cumulative distributions since inception. Numerator for DPI; tracks total capital returned to LP base."
    - name: "avg_moic"
      expr: AVG(CAST(moic AS DOUBLE))
      comment: "Average Multiple on Invested Capital across investor accounts. Headline return multiple for LP performance reporting."
    - name: "avg_dpi"
      expr: AVG(CAST(dpi AS DOUBLE))
      comment: "Average Distributions to Paid-In ratio across investor accounts. Measures realized return actually received by LPs."
    - name: "avg_rvpi"
      expr: AVG(CAST(rvpi AS DOUBLE))
      comment: "Average Residual Value to Paid-In ratio. Measures unrealized value remaining per dollar of invested capital."
    - name: "avg_inception_to_date_irr"
      expr: AVG(CAST(inception_to_date_irr AS DOUBLE))
      comment: "Average inception-to-date IRR across investor accounts. The primary long-term return metric for LP performance evaluation."
    - name: "total_carried_interest_allocated"
      expr: SUM(CAST(carried_interest_allocated AS DOUBLE))
      comment: "Total carried interest allocated to the GP across investor accounts. Tracks GP economics and waterfall execution."
    - name: "total_management_fees_charged"
      expr: SUM(CAST(management_fees_charged AS DOUBLE))
      comment: "Total management fees charged to investors. Quantifies fee burden on LP returns and validates fee calculation accuracy."
    - name: "total_preferred_return_accrued"
      expr: SUM(CAST(preferred_return_accrued AS DOUBLE))
      comment: "Total preferred return accrued to investors. Tracks the hurdle obligation that must be met before GP carry is earned."
    - name: "total_unrealized_gain_loss"
      expr: SUM(CAST(unrealized_gain_loss AS DOUBLE))
      comment: "Total unrealized gain or loss across investor accounts. Measures mark-to-market value creation not yet realized through disposition."
    - name: "total_realized_gain_loss"
      expr: SUM(CAST(realized_gain_loss AS DOUBLE))
      comment: "Total realized gain or loss from dispositions. Tracks actual value crystallized through asset sales."
    - name: "total_uncalled_commitment"
      expr: SUM(CAST(uncalled_commitment_amount AS DOUBLE))
      comment: "Total uncalled capital commitment remaining across investors. Tracks dry powder available for future capital calls."
    - name: "avg_nav_per_unit"
      expr: AVG(CAST(nav_per_unit AS DOUBLE))
      comment: "Average NAV per unit across investor accounts. Used for unit pricing and LP statement reconciliation."
    - name: "investor_account_count"
      expr: COUNT(DISTINCT investor_id)
      comment: "Number of distinct investors with capital accounts in scope. Provides LP base size context for all aggregate metrics."
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`investment_capital_call`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital call execution metrics tracking call amounts, funding rates, defaults, and penalties. Used by fund operations and investor relations to monitor capital deployment pace and LP compliance."
  source: "`real_estate_ecm`.`investment`.`capital_call`"
  dimensions:
    - name: "call_status"
      expr: call_status
      comment: "Current status of the capital call (e.g. Issued, Funded, Defaulted, Cancelled) for pipeline and compliance monitoring."
    - name: "call_type"
      expr: call_type
      comment: "Type of capital call (e.g. Investment, Fees, Expenses) to segment deployment by purpose."
    - name: "call_purpose"
      expr: call_purpose
      comment: "Business purpose of the capital call (e.g. Acquisition, CapEx, Operating) for deployment attribution analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the capital call for governance and control monitoring."
    - name: "is_default"
      expr: is_default
      comment: "Flag indicating whether the investor defaulted on this capital call. Used to monitor LP default rates and trigger remediation."
    - name: "call_date_month"
      expr: DATE_TRUNC('month', call_date)
      comment: "Month of the capital call date for monthly deployment pace analysis."
    - name: "call_date_quarter"
      expr: DATE_TRUNC('quarter', call_date)
      comment: "Quarter of the capital call date for quarterly deployment tracking."
  measures:
    - name: "total_call_amount"
      expr: SUM(CAST(call_amount AS DOUBLE))
      comment: "Total capital called from investors. Primary metric for tracking capital deployment pace against fund investment period."
    - name: "total_funded_amount"
      expr: SUM(CAST(funded_amount AS DOUBLE))
      comment: "Total capital actually received from investors. Measures LP funding compliance and cash availability for deployment."
    - name: "total_shortfall_amount"
      expr: SUM(CAST(shortfall_amount AS DOUBLE))
      comment: "Total funding shortfall across capital calls. Quantifies the gap between called and received capital, indicating LP default risk."
    - name: "funding_rate"
      expr: SUM(CAST(funded_amount AS DOUBLE)) / NULLIF(SUM(CAST(call_amount AS DOUBLE)), 0)
      comment: "Ratio of funded amount to called amount. Measures LP compliance rate; values below 1.0 indicate funding shortfalls requiring remediation."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties assessed on late or defaulted capital calls. Tracks financial consequences of LP non-compliance."
    - name: "total_interest_on_late_payment"
      expr: SUM(CAST(interest_on_late_payment AS DOUBLE))
      comment: "Total interest charged on late capital call payments. Quantifies the cost of LP payment delays to the fund."
    - name: "total_cumulative_called_amount"
      expr: SUM(CAST(cumulative_called_amount AS DOUBLE))
      comment: "Total cumulative capital called since inception across all calls. Tracks overall deployment progress against total commitments."
    - name: "total_uncalled_commitment"
      expr: SUM(CAST(uncalled_commitment_amount AS DOUBLE))
      comment: "Total remaining uncalled commitment across investors. Represents dry powder available for future capital calls."
    - name: "default_call_count"
      expr: COUNT(CASE WHEN is_default = TRUE THEN 1 END)
      comment: "Number of capital calls that resulted in investor default. Tracks LP compliance failures requiring legal or remediation action."
    - name: "capital_call_count"
      expr: COUNT(1)
      comment: "Total number of capital calls issued. Provides volume context for all per-call average metrics."
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`investment_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investor commitment metrics tracking total committed capital, called capital, distributions, and fee economics. Used by fund management to monitor fundraising progress, deployment, and LP economics."
  source: "`real_estate_ecm`.`investment`.`commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Status of the investor commitment (e.g. Active, Defaulted, Transferred, Closed) for pipeline and portfolio monitoring."
    - name: "capital_call_schedule_type"
      expr: capital_call_schedule_type
      comment: "Type of capital call schedule (e.g. On-Demand, Scheduled) to segment commitments by deployment structure."
    - name: "management_fee_basis"
      expr: management_fee_basis
      comment: "Basis for management fee calculation (e.g. Committed Capital, Invested Capital, NAV) for fee economics analysis."
    - name: "co_investment_flag"
      expr: co_investment_flag
      comment: "Flag indicating co-investment commitments, which typically carry different fee structures and governance rights."
    - name: "erisa_flag"
      expr: erisa_flag
      comment: "Flag indicating ERISA-governed investor commitments, which impose additional regulatory constraints on the fund."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating tax-exempt investor commitments (e.g. pension funds, endowments) for tax-sensitive reporting."
    - name: "close_date_year"
      expr: YEAR(close_date)
      comment: "Year of the commitment close date, enabling vintage-year analysis of fundraising and deployment."
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total capital committed by investors. Primary fundraising metric tracking progress toward fund target size."
    - name: "total_called_capital"
      expr: SUM(CAST(called_capital_amount AS DOUBLE))
      comment: "Total capital called from investors to date. Measures deployment pace against total commitments."
    - name: "total_uncalled_capital"
      expr: SUM(CAST(uncalled_capital_amount AS DOUBLE))
      comment: "Total remaining uncalled capital across commitments. Represents dry powder available for future investment activity."
    - name: "total_distributed_capital"
      expr: SUM(CAST(distributed_capital_amount AS DOUBLE))
      comment: "Total capital distributed back to investors. Tracks return of capital and income distributions against commitments."
    - name: "deployment_rate"
      expr: SUM(CAST(called_capital_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0)
      comment: "Ratio of called capital to total committed capital. Measures fund deployment progress; low rates may indicate deployment risk near investment period end."
    - name: "avg_management_fee_rate"
      expr: AVG(CAST(management_fee_rate AS DOUBLE))
      comment: "Average management fee rate across commitments. Tracks fee economics and validates fee schedule compliance."
    - name: "avg_carried_interest_rate"
      expr: AVG(CAST(carried_interest_rate AS DOUBLE))
      comment: "Average carried interest rate across commitments. Tracks GP economics and validates carry schedule consistency."
    - name: "avg_preferred_return_rate"
      expr: AVG(CAST(preferred_return_rate AS DOUBLE))
      comment: "Average preferred return (hurdle) rate across commitments. Tracks the minimum return threshold LPs must receive before GP carry is earned."
    - name: "total_aum_contribution"
      expr: SUM(CAST(aum_contribution_amount AS DOUBLE))
      comment: "Total AUM contribution from commitments. Used for management fee base calculation and fund size reporting."
    - name: "total_recallable_distributions"
      expr: SUM(CAST(recallable_distributions_amount AS DOUBLE))
      comment: "Total recallable distributions across commitments. Tracks capital that can be recalled for future investments per LPA terms."
    - name: "investor_commitment_count"
      expr: COUNT(DISTINCT investor_id)
      comment: "Number of distinct investors with active commitments. Tracks LP base breadth and concentration risk."
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`investment_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deal pipeline and underwriting metrics covering deal flow, pricing, underwriting assumptions, and IC decision outcomes. Used by investment teams and executives to manage the acquisition pipeline and evaluate deal quality."
  source: "`real_estate_ecm`.`investment`.`investment_deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the investment deal (e.g. Prospecting, LOI, Under Contract, Closed, Dead) for pipeline stage analysis."
    - name: "stage"
      expr: stage
      comment: "Detailed pipeline stage of the deal for funnel conversion analysis."
    - name: "ic_decision"
      expr: ic_decision
      comment: "Investment Committee decision outcome (e.g. Approved, Rejected, Deferred) for IC approval rate tracking."
    - name: "dead_reason"
      expr: dead_reason
      comment: "Reason a deal was killed, used to identify systemic sourcing or underwriting issues."
    - name: "is_off_market"
      expr: is_off_market
      comment: "Flag indicating off-market deals, which typically offer better pricing and less competition."
    - name: "sourced_date_year"
      expr: YEAR(sourced_date)
      comment: "Year the deal was sourced, enabling vintage-year deal flow and conversion analysis."
    - name: "sourced_date_quarter"
      expr: DATE_TRUNC('quarter', sourced_date)
      comment: "Quarter the deal was sourced for quarterly pipeline velocity tracking."
  measures:
    - name: "total_underwritten_value"
      expr: SUM(CAST(underwritten_value AS DOUBLE))
      comment: "Total underwritten asset value across deals in scope. Measures aggregate deal volume and capital deployment opportunity."
    - name: "total_underwritten_equity"
      expr: SUM(CAST(underwritten_equity_amount AS DOUBLE))
      comment: "Total underwritten equity requirement across deals. Tracks equity capital needed for pipeline execution."
    - name: "total_underwritten_debt"
      expr: SUM(CAST(underwritten_debt_amount AS DOUBLE))
      comment: "Total underwritten debt across deals. Monitors leverage levels in the pipeline against fund policy limits."
    - name: "avg_target_irr"
      expr: AVG(CAST(target_irr AS DOUBLE))
      comment: "Average target IRR across deals. Tracks whether the pipeline meets fund return hurdles at the underwriting stage."
    - name: "avg_target_cap_rate"
      expr: AVG(CAST(target_cap_rate AS DOUBLE))
      comment: "Average target cap rate across deals. Monitors acquisition yield levels relative to market benchmarks and fund targets."
    - name: "avg_target_equity_multiple"
      expr: AVG(CAST(target_equity_multiple AS DOUBLE))
      comment: "Average target equity multiple across deals. Tracks projected return multiples against fund target equity multiple."
    - name: "avg_underwritten_ltv"
      expr: AVG(CAST(underwritten_ltv AS DOUBLE))
      comment: "Average underwritten LTV across deals. Monitors leverage risk in the pipeline against fund leverage policy."
    - name: "avg_underwritten_noi"
      expr: AVG(CAST(underwritten_noi AS DOUBLE))
      comment: "Average underwritten NOI per deal. Benchmarks income assumptions across the pipeline for consistency and quality."
    - name: "avg_asking_price"
      expr: AVG(CAST(asking_price AS DOUBLE))
      comment: "Average asking price across deals. Tracks market pricing levels and negotiation headroom in the pipeline."
    - name: "avg_contracted_price"
      expr: AVG(CAST(contracted_price AS DOUBLE))
      comment: "Average contracted price across closed deals. Measures actual execution pricing versus asking price."
    - name: "price_negotiation_savings"
      expr: SUM((CAST(asking_price AS DOUBLE)) - (CAST(contracted_price AS DOUBLE)))
      comment: "Total price reduction achieved through negotiation (asking minus contracted). Quantifies GP negotiation effectiveness."
    - name: "avg_hold_period_years"
      expr: AVG(CAST(hold_period_years AS DOUBLE))
      comment: "Average planned hold period across deals. Tracks investment horizon assumptions and alignment with fund term."
    - name: "ic_approval_rate"
      expr: COUNT(CASE WHEN ic_decision = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN ic_decision IS NOT NULL THEN 1 END), 0)
      comment: "Ratio of IC-approved deals to total IC decisions. Measures underwriting quality and deal selectivity."
    - name: "deal_count"
      expr: COUNT(1)
      comment: "Total number of investment deals in scope. Provides pipeline volume context for all per-deal average metrics."
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`investment_debt_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debt facility metrics covering outstanding balances, leverage ratios, covenant compliance, and interest rate exposure. Used by treasury, risk management, and investment teams to monitor portfolio-level debt health."
  source: "`real_estate_ecm`.`investment`.`debt_facility`"
  dimensions:
    - name: "facility_status"
      expr: facility_status
      comment: "Current status of the debt facility (e.g. Active, Matured, Refinanced, Defaulted) for portfolio debt monitoring."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of debt facility (e.g. Mortgage, Bridge, Construction, Mezzanine) for debt stack composition analysis."
    - name: "interest_rate_type"
      expr: interest_rate_type
      comment: "Interest rate type (Fixed or Floating) to assess interest rate risk exposure across the debt portfolio."
    - name: "seniority_tier"
      expr: seniority_tier
      comment: "Seniority tier of the debt (e.g. Senior, Mezzanine, Subordinate) for capital stack risk analysis."
    - name: "recourse_type"
      expr: recourse_type
      comment: "Recourse type (Full, Partial, Non-Recourse) indicating sponsor liability exposure on the facility."
    - name: "covenant_compliance_status"
      expr: covenant_compliance_status
      comment: "Current covenant compliance status of the facility. Critical for identifying facilities at risk of breach or default."
    - name: "amortization_type"
      expr: amortization_type
      comment: "Amortization structure (e.g. Interest-Only, Amortizing) affecting cash flow requirements and refinancing risk."
    - name: "maturity_date_year"
      expr: YEAR(maturity_date)
      comment: "Year of facility maturity for debt maturity wall analysis and refinancing planning."
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding debt balance across facilities. Primary metric for portfolio leverage monitoring and lender reporting."
    - name: "total_commitment_amount"
      expr: SUM(CAST(commitment_amount AS DOUBLE))
      comment: "Total committed debt capacity across facilities. Measures total debt availability including unfunded portions."
    - name: "total_unfunded_commitment"
      expr: SUM(CAST(unfunded_commitment AS DOUBLE))
      comment: "Total unfunded debt commitment (available but undrawn). Tracks liquidity reserves and future draw capacity."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across debt facilities. Tracks blended cost of debt and interest rate risk exposure."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average Loan-to-Value ratio across facilities. Monitors leverage levels against covenant thresholds and fund policy."
    - name: "avg_dscr"
      expr: AVG(CAST(dscr AS DOUBLE))
      comment: "Average Debt Service Coverage Ratio across facilities. Key covenant metric; values approaching threshold trigger lender notification."
    - name: "avg_rate_spread"
      expr: AVG(CAST(rate_spread AS DOUBLE))
      comment: "Average spread over index rate across floating-rate facilities. Tracks credit pricing and lender risk assessment of the portfolio."
    - name: "covenant_breach_facility_count"
      expr: COUNT(CASE WHEN covenant_compliance_status = 'Breach' THEN 1 END)
      comment: "Number of facilities with active covenant breaches. Critical risk metric requiring immediate management attention and lender engagement."
    - name: "cross_collateralized_facility_count"
      expr: COUNT(CASE WHEN is_cross_collateralized = TRUE THEN 1 END)
      comment: "Number of cross-collateralized facilities. Tracks contagion risk where a breach on one asset can trigger default on others."
    - name: "debt_facility_count"
      expr: COUNT(1)
      comment: "Total number of debt facilities in scope. Provides portfolio size context for all per-facility average metrics."
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`investment_debt_covenant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debt covenant compliance metrics tracking threshold breaches, measurement frequency, and cure status. Used by risk management and treasury to proactively monitor covenant headroom and prevent lender defaults."
  source: "`real_estate_ecm`.`investment`.`debt_covenant`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the covenant (e.g. Compliant, Watch List, Breach, Waived) for risk triage."
    - name: "covenant_type"
      expr: covenant_type
      comment: "Type of covenant (e.g. Financial, Operational, Reporting) to segment compliance monitoring by covenant category."
    - name: "covenant_metric"
      expr: covenant_metric
      comment: "The specific financial metric being tested (e.g. DSCR, LTV, Occupancy) for metric-level compliance analysis."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency at which the covenant is tested (e.g. Monthly, Quarterly, Annual) for compliance calendar management."
    - name: "is_financial_covenant"
      expr: is_financial_covenant
      comment: "Flag indicating financial covenants (vs. operational/reporting), which carry higher default risk if breached."
    - name: "threshold_direction"
      expr: threshold_direction
      comment: "Direction of the covenant threshold (e.g. Minimum, Maximum) to correctly interpret headroom calculations."
    - name: "next_measurement_date_quarter"
      expr: DATE_TRUNC('quarter', next_measurement_date)
      comment: "Quarter of the next covenant measurement date for compliance calendar and workload planning."
  measures:
    - name: "avg_last_measured_value"
      expr: AVG(CAST(last_measured_value AS DOUBLE))
      comment: "Average last measured covenant value across covenants. Tracks actual performance levels relative to thresholds."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average covenant threshold value. Provides the benchmark against which measured values are compared."
    - name: "avg_covenant_headroom"
      expr: AVG(CAST(last_measured_value AS DOUBLE) - CAST(threshold_value AS DOUBLE))
      comment: "Average headroom between measured value and threshold. Positive values indicate compliance buffer; negative values indicate breach."
    - name: "breach_covenant_count"
      expr: COUNT(CASE WHEN compliance_status = 'Breach' THEN 1 END)
      comment: "Number of covenants currently in breach. Critical risk metric requiring immediate remediation and lender notification."
    - name: "watch_list_covenant_count"
      expr: COUNT(CASE WHEN compliance_status = 'Watch List' THEN 1 END)
      comment: "Number of covenants on the watch list (approaching threshold). Leading indicator of potential future breaches."
    - name: "financial_covenant_breach_count"
      expr: COUNT(CASE WHEN is_financial_covenant = TRUE AND compliance_status = 'Breach' THEN 1 END)
      comment: "Number of financial covenant breaches specifically. Financial covenant breaches carry the highest default risk and lender remedies."
    - name: "covenant_count"
      expr: COUNT(1)
      comment: "Total number of covenants in scope. Provides denominator for breach rate calculations and compliance coverage assessment."
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`investment_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investor distribution metrics tracking gross and net distribution amounts, return of capital, carried interest, and withholding taxes. Used by fund operations and investor relations for LP payment processing and tax reporting."
  source: "`real_estate_ecm`.`investment`.`investment_distribution`"
  dimensions:
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g. Ordinary Income, Return of Capital, Capital Gain, Carried Interest) for tax and waterfall attribution."
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current status of the distribution (e.g. Declared, Paid, Cancelled) for payment processing monitoring."
    - name: "frequency"
      expr: frequency
      comment: "Distribution frequency (e.g. Monthly, Quarterly, Annual) for cash flow planning and LP expectation management."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the distribution (e.g. Wire, ACH, Reinvestment) for operational processing analysis."
    - name: "reinvestment_elected"
      expr: reinvestment_elected
      comment: "Flag indicating whether the investor elected to reinvest the distribution. Tracks DRIP participation rates."
    - name: "k1_issued"
      expr: k1_issued
      comment: "Flag indicating whether a K-1 tax form has been issued for the distribution. Tracks tax reporting compliance."
    - name: "distribution_date_quarter"
      expr: DATE_TRUNC('quarter', distribution_date)
      comment: "Quarter of the distribution payment date for quarterly cash flow and LP reporting analysis."
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year of the distribution for annual K-1 reporting and tax compliance tracking."
  measures:
    - name: "total_gross_distribution"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross distribution amount before withholding taxes. Primary metric for LP cash flow reporting."
    - name: "total_net_distribution"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net distribution amount after withholding taxes. Represents actual cash received by investors."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from distributions. Tracks tax leakage and validates withholding rate application."
    - name: "total_return_of_capital"
      expr: SUM(CAST(return_of_capital_amount AS DOUBLE))
      comment: "Total return of capital component of distributions. Tracks non-taxable capital return versus income distributions."
    - name: "total_carried_interest_distributed"
      expr: SUM(CAST(carried_interest_amount AS DOUBLE))
      comment: "Total carried interest distributed to the GP. Tracks GP economics realization and waterfall execution."
    - name: "total_preferred_return_distributed"
      expr: SUM(CAST(preferred_return_amount AS DOUBLE))
      comment: "Total preferred return distributed to LPs. Tracks fulfillment of the hurdle rate obligation before GP carry."
    - name: "avg_amount_per_unit"
      expr: AVG(CAST(amount_per_unit AS DOUBLE))
      comment: "Average distribution amount per unit. Tracks per-unit yield for unit-based fund structures."
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate applied across distributions. Monitors tax efficiency and validates rate schedule compliance."
    - name: "total_ffo_component"
      expr: SUM(CAST(ffo_component_amount AS DOUBLE))
      comment: "Total Funds From Operations component of distributions. Key REIT metric tracking operating cash flow distributed to investors."
    - name: "total_affo_component"
      expr: SUM(CAST(affo_component_amount AS DOUBLE))
      comment: "Total Adjusted Funds From Operations component of distributions. Refined REIT metric accounting for recurring capex and straight-line rent adjustments."
    - name: "distribution_count"
      expr: COUNT(1)
      comment: "Total number of distribution events in scope. Provides volume context for all per-distribution average metrics."
$$;


CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`investment_portfolio_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio asset-level metrics covering acquisition cost, book value, NOI, occupancy, equity invested, and unrealized gains. Used by portfolio managers to track asset-level performance, hold/sell decisions, and capital allocation."
  source: "`real_estate_ecm`.`investment`.`portfolio_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the portfolio asset (e.g. Stabilized, Value-Add, Development, Disposed) for lifecycle stage analysis."
    - name: "hold_strategy"
      expr: hold_strategy
      comment: "Planned hold strategy for the asset (e.g. Core, Core-Plus, Value-Add, Opportunistic) for strategy-level performance attribution."
    - name: "investment_risk_profile"
      expr: investment_risk_profile
      comment: "Risk profile classification of the asset for risk-adjusted return analysis."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating joint venture assets, which have different governance, reporting, and return attribution requirements."
    - name: "is_encumbered"
      expr: is_encumbered
      comment: "Flag indicating whether the asset is encumbered by debt, affecting disposition flexibility and refinancing options."
    - name: "acquisition_date_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition for vintage-year performance analysis and hold period tracking."
    - name: "acquisition_date_quarter"
      expr: DATE_TRUNC('quarter', acquisition_date)
      comment: "Quarter of asset acquisition for quarterly deployment and vintage analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost across portfolio assets. Tracks total capital deployed in acquisitions."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total current book value of portfolio assets. Tracks carrying value for financial reporting and NAV calculation."
    - name: "total_equity_invested"
      expr: SUM(CAST(equity_invested AS DOUBLE))
      comment: "Total equity capital invested across portfolio assets. Denominator for equity multiple and cash-on-cash return calculations."
    - name: "total_in_place_noi"
      expr: SUM(CAST(in_place_noi AS DOUBLE))
      comment: "Total current in-place NOI across portfolio assets. Measures actual income generation of the portfolio at current occupancy."
    - name: "total_stabilized_noi"
      expr: SUM(CAST(stabilized_noi AS DOUBLE))
      comment: "Total stabilized NOI across portfolio assets. Represents the income potential at full occupancy, used for valuation and underwriting."
    - name: "noi_stabilization_gap"
      expr: SUM((CAST(stabilized_noi AS DOUBLE)) - (CAST(in_place_noi AS DOUBLE)))
      comment: "Gap between stabilized and in-place NOI. Quantifies the value-add opportunity remaining in the portfolio through leasing."
    - name: "total_unrealized_gain_loss"
      expr: SUM(CAST(unrealized_gain_loss AS DOUBLE))
      comment: "Total unrealized gain or loss across portfolio assets. Measures mark-to-market value creation not yet realized through disposition."
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate across portfolio assets. Primary operational metric driving NOI and asset valuation."
    - name: "total_capex_budget"
      expr: SUM(CAST(capex_budget AS DOUBLE))
      comment: "Total approved capex budget across portfolio assets. Tracks planned reinvestment for value-add execution."
    - name: "total_capex_spent_to_date"
      expr: SUM(CAST(capex_spent_to_date AS DOUBLE))
      comment: "Total capex spent to date across portfolio assets. Tracks execution progress against approved capex budgets."
    - name: "capex_budget_utilization_rate"
      expr: SUM(CAST(capex_spent_to_date AS DOUBLE)) / NULLIF(SUM(CAST(capex_budget AS DOUBLE)), 0)
      comment: "Ratio of capex spent to approved budget. Measures value-add execution pace; low rates may indicate project delays."
    - name: "avg_target_irr"
      expr: AVG(CAST(target_irr AS DOUBLE))
      comment: "Average target IRR across portfolio assets. Tracks whether the portfolio is positioned to meet fund return hurdles."
    - name: "avg_target_cap_rate"
      expr: AVG(CAST(target_cap_rate AS DOUBLE))
      comment: "Average target exit cap rate across portfolio assets. Monitors exit pricing assumptions and sensitivity to cap rate expansion."
    - name: "portfolio_asset_count"
      expr: COUNT(1)
      comment: "Total number of portfolio assets in scope. Provides portfolio size context for all per-asset average metrics."
$$;
