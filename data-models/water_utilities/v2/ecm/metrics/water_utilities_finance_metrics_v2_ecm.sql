-- Metric views for domain: finance | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic budget performance metrics tracking appropriation, expenditure, encumbrance, and budget utilization across fiscal years and cost centers. Used by CFO and finance leadership to monitor budget execution and identify over/under-spend."
  source: "`vibe_water_utilities_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for year-over-year trend analysis."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (operating, capital, debt service) for categorical analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget (approved, draft, amended) for pipeline tracking."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for grouping expenditures by program or function."
    - name: "debt_service_flag"
      expr: debt_service_flag
      comment: "Indicates whether the budget line is for debt service obligations."
    - name: "rate_case_flag"
      expr: rate_case_flag
      comment: "Indicates whether the budget is tied to a rate case filing."
  measures:
    - name: "total_appropriation_amount"
      expr: SUM(CAST(appropriation_amount AS DOUBLE))
      comment: "Total appropriated budget authority. Core measure for understanding authorized spending capacity."
    - name: "total_expended_amount"
      expr: SUM(CAST(expended_amount AS DOUBLE))
      comment: "Total actual expenditures against the budget. Drives budget execution monitoring."
    - name: "total_encumbrance_amount"
      expr: SUM(CAST(encumbrance_amount AS DOUBLE))
      comment: "Total encumbered (committed but not yet spent) amounts. Critical for available balance management."
    - name: "total_allotment_amount"
      expr: SUM(CAST(allotment_amount AS DOUBLE))
      comment: "Total allotted budget amounts released for spending within the period."
    - name: "avg_budget_appropriation"
      expr: AVG(CAST(appropriation_amount AS DOUBLE))
      comment: "Average appropriation per budget record, useful for benchmarking budget sizes across programs."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Number of active budget records. Baseline measure for budget portfolio size."
    - name: "amended_budget_count"
      expr: COUNT(CASE WHEN amendment_number IS NOT NULL THEN 1 END)
      comment: "Number of budgets that have been amended. High amendment rates signal planning instability."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular budget line execution metrics tracking original vs. amended budgets, actual expenditures, encumbrances, and available balances. Used by finance managers and department heads to monitor spending against approved budgets."
  source: "`vibe_water_utilities_v1`.`finance`.`budget_line`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for budget line, enabling year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for intra-year budget tracking."
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget line (personnel, O&M, capital) for functional analysis."
    - name: "budget_status"
      expr: budget_status
      comment: "Status of the budget line for pipeline and approval tracking."
    - name: "debt_service_flag"
      expr: debt_service_flag
      comment: "Flags debt service budget lines for separate debt management reporting."
    - name: "rate_case_flag"
      expr: rate_case_flag
      comment: "Flags budget lines included in rate case filings for regulatory cost recovery."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flags budget lines driven by regulatory compliance mandates."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Sum of original approved budget amounts. Baseline for budget variance analysis."
    - name: "total_amended_budget"
      expr: SUM(CAST(amended_budget_amount AS DOUBLE))
      comment: "Sum of amended budget amounts after adjustments. Reflects current authorized spending."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual spending against budget lines. Primary measure of budget execution."
    - name: "total_encumbrance"
      expr: SUM(CAST(encumbrance_amount AS DOUBLE))
      comment: "Total committed but unspent encumbrances. Essential for available balance calculation."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance_amount AS DOUBLE))
      comment: "Total remaining available budget balance. Critical for spend authorization decisions."
    - name: "total_variance"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (budget minus actuals). Negative values indicate over-spend requiring management action."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across lines. Indicates overall budget discipline."
    - name: "over_budget_line_count"
      expr: COUNT(CASE WHEN available_balance_amount < 0 THEN 1 END)
      comment: "Number of budget lines in deficit. Triggers immediate management intervention."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice processing metrics covering invoice volumes, amounts, payment timing, and approval efficiency. Used by AP managers and CFO to monitor payables liability, discount capture, and vendor payment performance."
  source: "`vibe_water_utilities_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (open, paid, disputed) for pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, recurring) for categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for bottleneck identification."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for year-over-year AP trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AP liability reporting."
    - name: "is_capex"
      expr: is_capex
      comment: "Distinguishes capital vs. operating expenditure invoices for GASB classification."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (ACH, check, wire) for cash management analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (PO/receipt/invoice) for procurement control monitoring."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount. Primary measure of payables liability."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts and adjustments."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on invoices for tax liability reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts available. Measures discount capture opportunity."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax amounts for compliance reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices processed. Baseline for AP workload and throughput."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_date IS NOT NULL THEN 1 END)
      comment: "Number of disputed invoices. High dispute rates signal vendor or procurement issues."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average invoice amount for spend pattern analysis and anomaly detection."
    - name: "three_way_match_failure_count"
      expr: COUNT(CASE WHEN three_way_match_status NOT IN ('MATCHED', 'APPROVED') THEN 1 END)
      comment: "Invoices failing three-way match. Indicates procurement control weaknesses requiring remediation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment execution metrics tracking payment volumes, amounts, timing, and void rates. Used by treasury and AP leadership to manage cash outflows, payment efficiency, and vendor relationship health."
  source: "`vibe_water_utilities_v1`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (cleared, outstanding, voided) for cash position management."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (ACH, check, wire) for payment channel optimization."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment for categorization and reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cash outflow reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cash disbursement tracking."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Identifies recurring payments for predictable cash flow forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of payment for multi-currency treasury management."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment disbursements. Primary measure of cash outflow."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after discounts and withholding."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimization."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax withheld from vendor payments for tax compliance."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payments processed. Baseline for payment throughput."
    - name: "voided_payment_count"
      expr: COUNT(CASE WHEN void_date IS NOT NULL THEN 1 END)
      comment: "Number of voided payments. High void rates indicate payment processing errors."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount for spend pattern benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_ar_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable transaction metrics tracking outstanding balances, collections performance, write-offs, and aging. Used by CFO and revenue management to monitor receivables health, collection effectiveness, and bad debt risk."
  source: "`vibe_water_utilities_v1`.`finance`.`ar_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of AR transaction (invoice, payment, adjustment, write-off) for categorization."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the AR transaction for pipeline management."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket (current, 30-60, 60-90, 90+) for receivables aging analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status for tracking accounts in collections workflow."
    - name: "collection_priority"
      expr: collection_priority
      comment: "Priority level for collections resource allocation."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flags disputed transactions for separate dispute resolution tracking."
    - name: "payment_plan_flag"
      expr: payment_plan_flag
      comment: "Identifies accounts on payment plans for collections strategy segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency AR reporting."
  measures:
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original billed amount. Baseline for revenue recognition and AR portfolio size."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding receivables balance. Primary measure of AR exposure and collection need."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected. Measures revenue realization and collection effectiveness."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total written-off receivables. Measures bad debt expense and collection failure."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to AR transactions. Monitors billing correction activity."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total AR transaction count. Baseline for AR volume and workload."
    - name: "disputed_transaction_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed AR transactions. Elevated disputes signal billing quality issues."
    - name: "avg_outstanding_amount"
      expr: AVG(CAST(outstanding_amount AS DOUBLE))
      comment: "Average outstanding balance per transaction for AR risk profiling."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_debt_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debt portfolio metrics tracking outstanding principal, interest rates, debt structure, and maturity profiles. Used by CFO and treasury to manage debt capacity, refinancing risk, and CAFR/GASB reporting obligations."
  source: "`vibe_water_utilities_v1`.`finance`.`debt_instrument`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of debt instrument (revenue bond, SRF loan, WIFIA, line of credit) for portfolio composition analysis."
    - name: "instrument_status"
      expr: instrument_status
      comment: "Current status of the debt instrument (active, retired, defeased) for portfolio management."
    - name: "interest_rate_type"
      expr: interest_rate_type
      comment: "Fixed vs. variable rate classification for interest rate risk management."
    - name: "gasb_classification"
      expr: gasb_classification
      comment: "GASB classification for financial statement presentation and audit compliance."
    - name: "cafr_reporting_category"
      expr: cafr_reporting_category
      comment: "CAFR reporting category for annual financial report disclosure."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Tax-exempt status for IRS compliance and investor reporting."
    - name: "callable_flag"
      expr: callable_flag
      comment: "Identifies callable bonds for refinancing opportunity analysis."
    - name: "security_type"
      expr: security_type
      comment: "Security backing the debt (revenue pledge, general obligation) for credit analysis."
  measures:
    - name: "total_original_principal"
      expr: SUM(CAST(original_principal_amount AS DOUBLE))
      comment: "Total original principal issued. Measures total debt capacity utilized."
    - name: "total_outstanding_principal"
      expr: SUM(CAST(outstanding_principal_balance AS DOUBLE))
      comment: "Total outstanding principal balance. Primary measure of current debt obligation."
    - name: "total_debt_service_reserve"
      expr: SUM(CAST(debt_service_reserve_requirement AS DOUBLE))
      comment: "Total debt service reserve requirements. Critical for covenant compliance monitoring."
    - name: "debt_instrument_count"
      expr: COUNT(1)
      comment: "Number of active debt instruments. Measures debt portfolio complexity."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across debt portfolio. Key metric for cost of capital management."
    - name: "callable_instrument_count"
      expr: COUNT(CASE WHEN callable_flag = TRUE THEN 1 END)
      comment: "Number of callable instruments. Identifies refinancing opportunities when rates decline."
    - name: "variable_rate_instrument_count"
      expr: COUNT(CASE WHEN interest_rate_type = 'VARIABLE' THEN 1 END)
      comment: "Number of variable rate instruments. Measures exposure to interest rate risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_debt_service_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debt service payment metrics tracking principal, interest, fees, and covenant compliance. Used by treasury and CFO to ensure timely debt service, monitor coverage ratios, and maintain bond covenant compliance."
  source: "`vibe_water_utilities_v1`.`finance`.`debt_service_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status (paid, pending, late) for debt service compliance monitoring."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of debt service payment (principal, interest, combined) for cash flow planning."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual debt service reporting and budget alignment."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly debt service cash flow tracking."
    - name: "late_payment_indicator"
      expr: late_payment_indicator
      comment: "Flags late payments for covenant violation risk assessment."
    - name: "covenant_compliance_indicator"
      expr: covenant_compliance_indicator
      comment: "Indicates whether payment meets bond covenant requirements."
    - name: "reserve_fund_draw_indicator"
      expr: reserve_fund_draw_indicator
      comment: "Flags payments requiring reserve fund draws — signals financial stress."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total debt service payments made. Primary measure of debt service cash outflow."
    - name: "total_principal_paid"
      expr: SUM(CAST(principal_amount AS DOUBLE))
      comment: "Total principal repaid. Tracks debt reduction progress."
    - name: "total_interest_paid"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest expense paid. Key component of cost of capital."
    - name: "total_fees_paid"
      expr: SUM(CAST(fees_amount AS DOUBLE))
      comment: "Total fees paid on debt instruments (trustee, paying agent). Monitors administrative cost of debt."
    - name: "total_late_penalty"
      expr: SUM(CAST(late_payment_penalty_amount AS DOUBLE))
      comment: "Total late payment penalties incurred. Non-zero values require immediate treasury action."
    - name: "total_reserve_fund_draw"
      expr: SUM(CAST(reserve_fund_draw_amount AS DOUBLE))
      comment: "Total reserve fund draws. Persistent draws signal debt service coverage ratio stress."
    - name: "avg_debt_service_coverage_ratio"
      expr: AVG(CAST(debt_service_coverage_ratio AS DOUBLE))
      comment: "Average debt service coverage ratio. Core covenant metric — must stay above bond indenture minimums."
    - name: "late_payment_count"
      expr: COUNT(CASE WHEN late_payment_indicator = TRUE THEN 1 END)
      comment: "Number of late debt service payments. Any late payments risk bond covenant violations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_grant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant portfolio metrics tracking award amounts, drawdowns, matching requirements, and compliance status. Used by finance and grants management to maximize federal/state funding utilization and ensure single audit compliance."
  source: "`vibe_water_utilities_v1`.`finance`.`grant`"
  dimensions:
    - name: "grant_type"
      expr: grant_type
      comment: "Type of grant (SRF, WIFIA, CDBG, EPA) for funding source portfolio analysis."
    - name: "grant_status"
      expr: grant_status
      comment: "Current grant status (active, closed, pending) for portfolio management."
    - name: "grantor_agency_name"
      expr: grantor_agency_name
      comment: "Granting agency for funding source diversification analysis."
    - name: "single_audit_required_flag"
      expr: single_audit_required_flag
      comment: "Flags grants subject to federal single audit requirements (>$750K threshold)."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency for grant compliance workload planning."
  measures:
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total grant award amounts. Measures total external funding secured."
    - name: "total_drawn_amount"
      expr: SUM(CAST(total_amount_drawn AS DOUBLE))
      comment: "Total grant funds drawn to date. Measures funding utilization and reimbursement progress."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total undrawn grant balance. Identifies funding at risk of lapsing."
    - name: "total_matching_required"
      expr: SUM(CAST(matching_amount_required AS DOUBLE))
      comment: "Total local match required across grants. Critical for budget planning and grant compliance."
    - name: "grant_count"
      expr: COUNT(1)
      comment: "Total number of grants in portfolio. Measures funding diversification."
    - name: "avg_award_amount"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average grant award size for portfolio benchmarking."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across grants. Monitors overhead recovery on federal awards."
    - name: "avg_matching_requirement_pct"
      expr: AVG(CAST(matching_requirement_percentage AS DOUBLE))
      comment: "Average local match percentage required. Informs capital planning for grant-funded projects."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_grant_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant expenditure tracking metrics covering eligible vs. ineligible costs, match requirements, and audit findings. Used by grants managers and auditors to ensure proper cost allocation and federal compliance."
  source: "`vibe_water_utilities_v1`.`finance`.`grant_expenditure`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category (direct labor, equipment, construction) for allowable cost analysis."
    - name: "eligibility_classification"
      expr: eligibility_classification
      comment: "Eligibility classification for federal cost allowability determination."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the expenditure for workflow management."
    - name: "audit_finding_flag"
      expr: audit_finding_flag
      comment: "Flags expenditures with audit findings for remediation tracking."
    - name: "match_requirement_flag"
      expr: match_requirement_flag
      comment: "Identifies expenditures counting toward local match requirements."
  measures:
    - name: "total_expenditure_amount"
      expr: SUM(CAST(expenditure_amount AS DOUBLE))
      comment: "Total grant expenditures. Primary measure of grant fund utilization."
    - name: "total_eligible_amount"
      expr: SUM(CAST(eligible_amount AS DOUBLE))
      comment: "Total eligible expenditures for reimbursement. Drives drawdown request amounts."
    - name: "total_ineligible_amount"
      expr: SUM(CAST(ineligible_amount AS DOUBLE))
      comment: "Total ineligible expenditures. Must be funded from local sources — risk of disallowance."
    - name: "total_match_amount"
      expr: SUM(CAST(match_amount AS DOUBLE))
      comment: "Total local match expenditures. Tracks compliance with matching requirements."
    - name: "expenditure_count"
      expr: COUNT(1)
      comment: "Total number of grant expenditure transactions."
    - name: "audit_finding_count"
      expr: COUNT(CASE WHEN audit_finding_flag = TRUE THEN 1 END)
      comment: "Number of expenditures with audit findings. Drives corrective action planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_encumbrance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Encumbrance management metrics tracking committed spending, liquidation rates, and year-end carryforward. Used by finance and procurement to manage budget availability and prevent over-commitment of funds."
  source: "`vibe_water_utilities_v1`.`finance`.`encumbrance`"
  dimensions:
    - name: "encumbrance_type"
      expr: encumbrance_type
      comment: "Type of encumbrance (purchase order, contract, requisition) for commitment analysis."
    - name: "encumbrance_status"
      expr: encumbrance_status
      comment: "Current encumbrance status (open, partially liquidated, closed) for portfolio management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual encumbrance reporting and year-end close."
    - name: "expenditure_category"
      expr: expenditure_category
      comment: "Expenditure category for budget category alignment."
    - name: "year_end_carryforward_flag"
      expr: year_end_carryforward_flag
      comment: "Identifies encumbrances carried forward to next fiscal year for budget continuity."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flags reversed encumbrances for audit trail completeness."
  measures:
    - name: "total_encumbrance_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total encumbered amount. Measures total committed but unspent budget."
    - name: "total_liquidated_amount"
      expr: SUM(CAST(liquidated_amount AS DOUBLE))
      comment: "Total liquidated (converted to actual expenditure) encumbrances."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining open encumbrance balance. Drives available budget calculations."
    - name: "encumbrance_count"
      expr: COUNT(1)
      comment: "Total number of encumbrances. Baseline for commitment portfolio size."
    - name: "avg_encumbrance_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average encumbrance size for procurement pattern analysis."
    - name: "carryforward_encumbrance_count"
      expr: COUNT(CASE WHEN year_end_carryforward_flag = TRUE THEN 1 END)
      comment: "Number of encumbrances carried forward. High carryforward rates indicate project execution delays."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics tracking allocated amounts, allocation methods, and rate case eligibility. Used by finance and regulatory affairs to support cost-of-service studies and rate case filings with regulators."
  source: "`vibe_water_utilities_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of cost allocation (direct, indirect, overhead) for cost study categorization."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation methodology (headcount, square footage, usage) for regulatory defensibility."
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis for allocation calculation for audit documentation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cost allocation reporting."
    - name: "gasb_category"
      expr: gasb_category
      comment: "GASB category for financial statement classification."
    - name: "rate_case_eligible_flag"
      expr: rate_case_eligible_flag
      comment: "Flags allocations eligible for rate case cost recovery — critical for revenue requirement calculations."
    - name: "capital_expenditure_flag"
      expr: capital_expenditure_flag
      comment: "Distinguishes capital vs. operating cost allocations for GASB reporting."
    - name: "gasb_compliance_flag"
      expr: gasb_compliance_flag
      comment: "Confirms GASB compliance of the allocation methodology."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated. Primary measure of overhead and indirect cost distribution."
    - name: "total_statistical_key_figure_value"
      expr: SUM(CAST(statistical_key_figure_value AS DOUBLE))
      comment: "Total statistical key figure values (e.g., labor hours, gallons) used as allocation drivers."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of cost allocation transactions."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage. Monitors concentration risk in cost distribution."
    - name: "avg_capital_percentage"
      expr: AVG(CAST(capital_percentage AS DOUBLE))
      comment: "Average capital vs. operating split percentage. Informs rate base calculations."
    - name: "rate_case_eligible_allocation_count"
      expr: COUNT(CASE WHEN rate_case_eligible_flag = TRUE THEN 1 END)
      comment: "Number of allocations eligible for rate case inclusion. Drives revenue requirement calculations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics tracking posting volumes, amounts, and reversal activity. Used by controllers and auditors to monitor GL integrity, manual entry risk, and period-close efficiency."
  source: "`vibe_water_utilities_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "journal_type"
      expr: journal_type
      comment: "Type of journal entry (standard, accrual, reversal, recurring) for GL activity analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status (posted, unposted, error) for period-close management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual GL reporting."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for monthly close activity monitoring."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags reversing entries for accrual management tracking."
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Identifies intercompany/interfund entries for elimination and reconciliation."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit postings. Validates GL balance (debits must equal credits)."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit postings. Validates GL balance integrity."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total journal entries posted. Baseline for GL activity volume and close workload."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversing entries. Monitors accrual management discipline."
    - name: "avg_debit_amount"
      expr: AVG(CAST(total_debit_amount AS DOUBLE))
      comment: "Average journal entry debit amount for anomaly detection and materiality assessment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund accounting metrics tracking fund balances, types, and compliance status. Used by CFO and auditors for GASB fund financial statement preparation and minimum balance policy compliance."
  source: "`vibe_water_utilities_v1`.`finance`.`fund`"
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "GASB fund type (enterprise, capital projects, debt service, general) for financial statement classification."
    - name: "fund_status"
      expr: fund_status
      comment: "Current fund status (active, closed) for portfolio management."
    - name: "gasb_fund_classification"
      expr: gasb_fund_classification
      comment: "GASB fund classification for financial reporting compliance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual fund balance reporting."
    - name: "rate_case_inclusion_flag"
      expr: rate_case_inclusion_flag
      comment: "Flags funds included in rate case revenue requirement calculations."
    - name: "external_audit_required_flag"
      expr: external_audit_required_flag
      comment: "Identifies funds requiring external audit for compliance planning."
    - name: "interfund_transfer_allowed_flag"
      expr: interfund_transfer_allowed_flag
      comment: "Indicates whether interfund transfers are permitted for cash management flexibility."
  measures:
    - name: "total_minimum_fund_balance"
      expr: SUM(CAST(minimum_fund_balance_amount AS DOUBLE))
      comment: "Total minimum required fund balances across all funds. Drives reserve policy compliance."
    - name: "fund_count"
      expr: COUNT(1)
      comment: "Total number of funds. Measures fund accounting complexity."
    - name: "avg_minimum_balance_percentage"
      expr: AVG(CAST(minimum_fund_balance_percentage AS DOUBLE))
      comment: "Average minimum balance percentage policy across funds. Benchmarks reserve adequacy."
    - name: "rate_case_fund_count"
      expr: COUNT(CASE WHEN rate_case_inclusion_flag = TRUE THEN 1 END)
      comment: "Number of funds included in rate case filings. Measures regulatory cost recovery scope."
    - name: "audit_required_fund_count"
      expr: COUNT(CASE WHEN external_audit_required_flag = TRUE THEN 1 END)
      comment: "Number of funds requiring external audit. Drives audit planning and resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treasury bank account metrics tracking balances, collateralization, and investment policy compliance. Used by treasury management to monitor liquidity, FDIC coverage, and investment policy adherence."
  source: "`vibe_water_utilities_v1`.`finance`.`bank_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of bank account (operating, payroll, investment, escrow) for treasury categorization."
    - name: "account_status"
      expr: account_status
      comment: "Current account status (active, closed, dormant) for portfolio management."
    - name: "fund_type"
      expr: fund_type
      comment: "Fund type associated with the account for GASB fund accounting alignment."
    - name: "fdic_insured_flag"
      expr: fdic_insured_flag
      comment: "FDIC insurance status for deposit risk management."
    - name: "interest_bearing_flag"
      expr: interest_bearing_flag
      comment: "Identifies interest-bearing accounts for investment income tracking."
    - name: "collateralization_required_flag"
      expr: collateralization_required_flag
      comment: "Flags accounts requiring collateralization per investment policy."
    - name: "sweep_arrangement_flag"
      expr: sweep_arrangement_flag
      comment: "Identifies accounts with sweep arrangements for overnight investment optimization."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total current balance across all bank accounts. Primary liquidity measure."
    - name: "total_collateral_value"
      expr: SUM(CAST(collateral_value_amount AS DOUBLE))
      comment: "Total collateral value securing deposits. Measures deposit protection coverage."
    - name: "total_minimum_balance_requirement"
      expr: SUM(CAST(minimum_balance_amount AS DOUBLE))
      comment: "Total minimum balance requirements across accounts. Constrains available liquidity."
    - name: "bank_account_count"
      expr: COUNT(1)
      comment: "Total number of bank accounts. Baseline for treasury portfolio complexity."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate_percentage AS DOUBLE))
      comment: "Average interest rate on interest-bearing accounts. Measures investment income yield."
    - name: "investment_policy_compliant_count"
      expr: COUNT(CASE WHEN investment_policy_compliance_flag = TRUE THEN 1 END)
      comment: "Number of accounts in compliance with investment policy. Non-compliant accounts require immediate remediation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_bank_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank reconciliation metrics tracking reconciliation status, variances, and audit findings. Used by controllers and auditors to ensure GL-to-bank agreement and identify unreconciled items requiring resolution."
  source: "`vibe_water_utilities_v1`.`finance`.`bank_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current reconciliation status (reconciled, in-progress, exception) for close management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual reconciliation compliance reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly reconciliation cycle tracking."
    - name: "audit_finding_flag"
      expr: audit_finding_flag
      comment: "Flags reconciliations with audit findings for remediation prioritization."
    - name: "reconciliation_method"
      expr: reconciliation_method
      comment: "Method used for reconciliation (automated, manual) for process efficiency analysis."
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total reconciliation variance. Non-zero aggregate signals GL integrity issues requiring investigation."
    - name: "total_outstanding_checks"
      expr: SUM(CAST(outstanding_checks_amount AS DOUBLE))
      comment: "Total outstanding checks. Measures timing differences in cash position."
    - name: "total_deposits_in_transit"
      expr: SUM(CAST(deposits_in_transit_amount AS DOUBLE))
      comment: "Total deposits in transit. Measures timing differences between bank and GL."
    - name: "total_nsf_checks"
      expr: SUM(CAST(nsf_checks_amount AS DOUBLE))
      comment: "Total NSF (returned) check amounts. Elevated NSF activity signals customer payment risk."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total number of bank reconciliations. Baseline for reconciliation workload."
    - name: "audit_finding_count"
      expr: COUNT(CASE WHEN audit_finding_flag = TRUE THEN 1 END)
      comment: "Number of reconciliations with audit findings. Drives internal control remediation."
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average reconciliation variance per period. Persistent non-zero averages indicate systemic GL issues."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_drawdown_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant drawdown request metrics tracking amounts, approval timing, and request status. Used by grants managers to maximize reimbursement velocity and ensure timely cash recovery from federal/state grantors."
  source: "`vibe_water_utilities_v1`.`finance`.`drawdown_request`"
  dimensions:
    - name: "drawdown_request_status"
      expr: drawdown_request_status
      comment: "Current status of the drawdown request (submitted, approved, paid, rejected) for pipeline management."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for the drawdown for grantor-level reporting."
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flags urgent drawdown requests for prioritized processing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the drawdown request."
  measures:
    - name: "total_gross_amount_requested"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross amount requested in drawdowns. Measures reimbursement pipeline."
    - name: "total_net_amount_requested"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net drawdown amount after adjustments. Actual cash recovery measure."
    - name: "total_amount_adjustment"
      expr: SUM(CAST(amount_adjustment AS DOUBLE))
      comment: "Total adjustments to drawdown requests. Large adjustments signal cost eligibility issues."
    - name: "drawdown_request_count"
      expr: COUNT(1)
      comment: "Total number of drawdown requests. Baseline for grant reimbursement activity."
    - name: "avg_net_amount"
      expr: AVG(CAST(amount_net AS DOUBLE))
      comment: "Average net drawdown amount per request for reimbursement pattern analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_revenue_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue requirement metrics tracking rate base, operating expenses, debt service, and revenue sufficiency for rate case filings. Used by regulatory affairs and CFO to support rate case strategy and ensure revenue adequacy."
  source: "`vibe_water_utilities_v1`.`finance`.`revenue_requirement`"
  dimensions:
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of the revenue requirement calculation (draft, filed, approved) for rate case workflow."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Methodology used (embedded cost, marginal cost) for regulatory defensibility."
    - name: "customer_class"
      expr: customer_class
      comment: "Customer class (residential, commercial, industrial) for rate design allocation."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority (PUC, PSC) for jurisdiction-specific rate case tracking."
    - name: "cost_allocation_method"
      expr: cost_allocation_method
      comment: "Cost allocation method for rate design documentation."
  measures:
    - name: "total_revenue_requirement"
      expr: SUM(CAST(total_revenue_requirement_amount AS DOUBLE))
      comment: "Total revenue requirement. The fundamental rate case metric — determines required rate levels."
    - name: "total_current_revenue"
      expr: SUM(CAST(current_revenue_amount AS DOUBLE))
      comment: "Total current revenue at existing rates. Compared to requirement to determine revenue gap."
    - name: "total_revenue_sufficiency_gap"
      expr: SUM(CAST(revenue_sufficiency_gap_amount AS DOUBLE))
      comment: "Total revenue sufficiency gap (requirement minus current revenue). Drives rate increase requests."
    - name: "total_rate_base"
      expr: SUM(CAST(rate_base_amount AS DOUBLE))
      comment: "Total rate base (net plant in service). Foundation for allowed return calculation."
    - name: "total_operating_expenditure"
      expr: SUM(CAST(operating_expenditure_amount AS DOUBLE))
      comment: "Total operating expenditure in revenue requirement. Largest component of rate case costs."
    - name: "total_debt_service"
      expr: SUM(CAST(debt_service_amount AS DOUBLE))
      comment: "Total debt service included in revenue requirement. Measures capital cost recovery."
    - name: "total_capital_expenditure"
      expr: SUM(CAST(capital_expenditure_amount AS DOUBLE))
      comment: "Total capital expenditure in revenue requirement for infrastructure investment recovery."
    - name: "avg_rate_adjustment_percentage"
      expr: AVG(CAST(rate_adjustment_percentage AS DOUBLE))
      comment: "Average rate adjustment percentage. Key metric for customer impact assessment and rate case strategy."
    - name: "avg_authorized_rate_of_return"
      expr: AVG(CAST(authorized_rate_of_return_percentage AS DOUBLE))
      comment: "Average authorized rate of return. Benchmarks regulatory allowed return against market cost of capital."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_rate_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate case outcome metrics tracking approved revenue requirements, rate impacts, and regulatory lag. Used by regulatory affairs and executive leadership to evaluate rate case strategy effectiveness and customer rate impact."
  source: "`vibe_water_utilities_v1`.`finance`.`finance_rate_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current rate case status (filed, pending, decided, appealed) for regulatory pipeline management."
    - name: "case_type"
      expr: case_type
      comment: "Type of rate case (general rate case, surcharge, DSIC) for regulatory strategy analysis."
    - name: "test_year_type"
      expr: test_year_type
      comment: "Test year type (historical, projected, hybrid) for regulatory methodology tracking."
    - name: "settlement_agreement_flag"
      expr: settlement_agreement_flag
      comment: "Flags cases resolved by settlement vs. full litigation for strategy benchmarking."
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Flags appealed decisions for regulatory risk monitoring."
  measures:
    - name: "total_requested_revenue_requirement"
      expr: SUM(CAST(requested_revenue_requirement AS DOUBLE))
      comment: "Total revenue requirement requested in rate cases. Baseline for regulatory outcome analysis."
    - name: "total_approved_revenue_requirement"
      expr: SUM(CAST(approved_revenue_requirement AS DOUBLE))
      comment: "Total approved revenue requirement. Measures regulatory cost recovery success."
    - name: "total_revenue_increase"
      expr: SUM(CAST(revenue_increase_amount AS DOUBLE))
      comment: "Total approved revenue increase. Direct measure of rate case financial outcome."
    - name: "total_rate_base"
      expr: SUM(CAST(rate_base_amount AS DOUBLE))
      comment: "Total rate base across rate cases. Measures capital investment eligible for return."
    - name: "avg_revenue_increase_percentage"
      expr: AVG(CAST(revenue_increase_percentage AS DOUBLE))
      comment: "Average approved revenue increase percentage. Key metric for rate case outcome benchmarking."
    - name: "avg_allowed_rate_of_return"
      expr: AVG(CAST(allowed_rate_of_return AS DOUBLE))
      comment: "Average allowed rate of return granted by regulators. Benchmarks against cost of capital."
    - name: "avg_residential_rate_impact_pct"
      expr: AVG(CAST(residential_rate_impact_percentage AS DOUBLE))
      comment: "Average residential customer rate impact percentage. Critical for affordability and public relations management."
    - name: "rate_case_count"
      expr: COUNT(1)
      comment: "Total number of rate cases. Baseline for regulatory activity volume."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics tracking acquisition costs, depreciation, net book value, and disposal activity. Used by finance and asset management for GASB capital asset reporting, depreciation expense forecasting, and infrastructure investment decisions."
  source: "`vibe_water_utilities_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current asset status (in-service, retired, disposed) for capital asset portfolio management."
    - name: "gasb_capital_asset_category"
      expr: gasb_capital_asset_category
      comment: "GASB capital asset category for financial statement classification."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (straight-line, units of production) for accounting policy consistency."
    - name: "condition_rating"
      expr: condition_rating
      comment: "Asset condition rating for infrastructure investment prioritization."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Asset criticality rating for risk-based capital planning."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets. Measures total capital investment in infrastructure."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation. Measures asset aging and replacement funding need."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets. Primary GASB capital asset balance sheet measure."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value AS DOUBLE))
      comment: "Total insured value of fixed assets. Monitors insurance coverage adequacy."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Measures asset monetization activity."
    - name: "fixed_asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets. Baseline for capital asset portfolio size."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset. Benchmarks asset age and replacement timing."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center financial metrics tracking budgets, overhead rates, and organizational structure. Used by finance and department heads to manage departmental spending authority and overhead cost allocation."
  source: "`vibe_water_utilities_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "cost_center_type"
      expr: cost_center_type
      comment: "Type of cost center (operations, administration, treatment, distribution) for functional analysis."
    - name: "cost_center_category"
      expr: cost_center_category
      comment: "Category for cost center grouping in reporting hierarchies."
    - name: "cost_center_status"
      expr: cost_center_status
      comment: "Active/inactive status for portfolio management."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area for cross-departmental cost analysis."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flags cost centers included in regulatory cost-of-service reporting."
    - name: "grant_eligible_flag"
      expr: grant_eligible_flag
      comment: "Identifies cost centers eligible for grant funding allocation."
  measures:
    - name: "total_annual_budget"
      expr: SUM(CAST(annual_budget_amount AS DOUBLE))
      comment: "Total annual budget across cost centers. Measures total authorized spending by organizational unit."
    - name: "avg_overhead_rate_percentage"
      expr: AVG(CAST(overhead_rate_percentage AS DOUBLE))
      comment: "Average overhead rate percentage. Key input for cost-of-service studies and rate case filings."
    - name: "avg_capex_opex_split"
      expr: AVG(CAST(capex_opex_split_percentage AS DOUBLE))
      comment: "Average capital vs. operating expenditure split. Informs rate base and O&M expense allocation."
    - name: "cost_center_count"
      expr: COUNT(1)
      comment: "Total number of cost centers. Baseline for organizational complexity."
    - name: "regulatory_reporting_cost_center_count"
      expr: COUNT(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 END)
      comment: "Number of cost centers included in regulatory reporting. Measures regulatory cost recovery scope."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`finance_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment run execution metrics tracking throughput, success rates, and total disbursements. Used by AP and treasury to monitor payment processing efficiency and identify failed payment runs requiring remediation."
  source: "`vibe_water_utilities_v1`.`finance`.`payment_run`"
  dimensions:
    - name: "payment_run_status"
      expr: payment_run_status
      comment: "Status of the payment run (completed, failed, partial) for operational monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (regular, emergency, off-cycle) for cash flow planning."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (ACH, check, wire) for channel optimization."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Payment channel for disbursement method analysis."
    - name: "is_automated"
      expr: is_automated
      comment: "Distinguishes automated vs. manual payment runs for process efficiency tracking."
    - name: "is_priority"
      expr: is_priority
      comment: "Flags priority payment runs for expedited processing monitoring."
  measures:
    - name: "total_gross_disbursement"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount disbursed across payment runs. Primary cash outflow measure."
    - name: "total_net_disbursement"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net disbursement after adjustments. Actual cash outflow measure."
    - name: "total_adjustments"
      expr: SUM(CAST(total_adjustments_amount AS DOUBLE))
      comment: "Total payment adjustments. Large adjustments signal payment processing errors."
    - name: "total_transactions_processed"
      expr: SUM(CAST(total_records_processed AS DOUBLE))
      comment: "Total payment transactions processed. Measures AP throughput."
    - name: "total_failed_transactions"
      expr: SUM(CAST(failed_transactions_count AS DOUBLE))
      comment: "Total failed payment transactions. Drives exception management and vendor relationship risk."
    - name: "total_successful_transactions"
      expr: SUM(CAST(successful_transactions_count AS DOUBLE))
      comment: "Total successful payment transactions. Measures payment processing reliability."
    - name: "payment_run_count"
      expr: COUNT(1)
      comment: "Total number of payment runs executed."
    - name: "avg_net_disbursement_per_run"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net disbursement per payment run for cash flow forecasting."
$$;