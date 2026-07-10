-- Metric views for domain: project | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_cip_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital Improvement Program project portfolio metrics. Tracks budget performance, schedule adherence, cost variance, and project delivery efficiency across the CIP portfolio — essential for capital planning, board reporting, and rate case justification."
  source: "`vibe_water_utilities_v1`.`project`.`cip_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the CIP project (e.g., Active, Closed, On Hold) for portfolio segmentation."
    - name: "project_type"
      expr: project_type
      comment: "Classification of the project type (e.g., Rehabilitation, New Construction, Regulatory) for investment category analysis."
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project (e.g., Planning, Design, Construction) for pipeline stage analysis."
    - name: "infrastructure_category"
      expr: infrastructure_category
      comment: "Infrastructure category (e.g., Water Main, Treatment, Pump Station) for asset-class investment tracking."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier assigned to the project for resource allocation and sequencing decisions."
    - name: "regulatory_driver"
      expr: regulatory_driver
      comment: "Regulatory mandate or driver behind the project, critical for compliance-driven capital planning."
    - name: "cip_program_year"
      expr: cip_program_year
      comment: "Program year the project is budgeted under, enabling year-over-year CIP spend analysis."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the project was planned to start, for schedule cohort analysis."
    - name: "planned_completion_year"
      expr: YEAR(planned_completion_date)
      comment: "Year the project was planned to complete, for delivery timeline analysis."
    - name: "environmental_review_status"
      expr: environmental_review_status
      comment: "Status of environmental review, a key gating factor for project advancement."
  measures:
    - name: "total_authorized_budget"
      expr: SUM(CAST(authorized_budget_amount AS DOUBLE))
      comment: "Total authorized capital budget across the CIP portfolio. Core metric for board-approved capital program sizing and rate case support."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Sum of estimated total costs across all CIP projects. Compared against authorized budget to identify funding gaps."
    - name: "total_actual_cost_to_date"
      expr: SUM(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Total capital expenditure incurred to date across the portfolio. Tracks cash burn rate against budget."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Sum of cost variances (actual vs. budget) across all projects. Negative values indicate over-budget conditions requiring management intervention."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical completion percentage across active CIP projects. Indicates overall portfolio delivery progress."
    - name: "project_count"
      expr: COUNT(1)
      comment: "Total number of CIP projects in the portfolio. Used for workload capacity and resource planning."
    - name: "permit_required_project_count"
      expr: COUNT(CASE WHEN permit_required_flag = TRUE THEN 1 END)
      comment: "Number of projects requiring regulatory permits. Tracks permitting pipeline risk and schedule exposure."
    - name: "avg_design_capacity_mgd"
      expr: AVG(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Average design capacity in million gallons per day across capacity-expansion projects. Informs infrastructure adequacy planning."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_cost_to_date AS DOUBLE)) / NULLIF(SUM(CAST(authorized_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of authorized budget consumed to date. A key capital program efficiency indicator — values significantly above 100% signal overruns requiring board action."
    - name: "cost_variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(cost_variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(authorized_budget_amount AS DOUBLE)), 0), 2)
      comment: "Cost variance as a percentage of authorized budget. Measures overall portfolio budget discipline; negative values indicate systemic overruns."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_construction_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construction contract performance metrics covering contract value, change order exposure, retainage, and delivery performance. Used by project controls, finance, and procurement leadership to manage contractor performance and cost risk."
  source: "`vibe_water_utilities_v1`.`project`.`construction_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the construction contract (e.g., Active, Closed, Terminated) for portfolio segmentation."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract delivery method (e.g., Lump Sum, Unit Price, Cost Plus) for procurement strategy analysis."
    - name: "award_year"
      expr: YEAR(award_date)
      comment: "Year the contract was awarded, enabling cohort analysis of contract performance by vintage."
    - name: "substantial_completion_year"
      expr: YEAR(substantial_completion_date)
      comment: "Year of substantial completion for delivery timeline analysis."
    - name: "payment_bond_required"
      expr: payment_bond_required
      comment: "Whether a payment bond was required, relevant for contractor risk profiling."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Whether a performance bond was required, relevant for contractor risk profiling."
  measures:
    - name: "total_awarded_contract_value"
      expr: SUM(CAST(awarded_contract_value AS DOUBLE))
      comment: "Total value of all awarded construction contracts. Core capital program commitment metric for board and finance reporting."
    - name: "total_current_contract_value"
      expr: SUM(CAST(current_contract_value AS DOUBLE))
      comment: "Total current contract value including approved change orders. Reflects true committed capital exposure."
    - name: "total_change_order_amount"
      expr: SUM(CAST(total_change_order_amount AS DOUBLE))
      comment: "Total value of change orders across all contracts. High values signal scope creep or design deficiency risk."
    - name: "total_paid_to_date"
      expr: SUM(CAST(total_paid_to_date AS DOUBLE))
      comment: "Total payments disbursed to contractors to date. Tracks cash outflow against contract commitments."
    - name: "total_retainage_held"
      expr: SUM(CAST(retainage_amount AS DOUBLE))
      comment: "Total retainage withheld from contractors. Represents contingent liability and contractor incentive for punch list completion."
    - name: "total_liquidated_damages"
      expr: SUM(CAST(liquidated_damages_assessed AS DOUBLE))
      comment: "Total liquidated damages assessed for schedule non-performance. Indicates contractor delivery risk and schedule enforcement effectiveness."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical completion percentage across active construction contracts. Tracks overall construction delivery progress."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of construction contracts. Used for procurement workload and contract administration capacity planning."
    - name: "change_order_exposure_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_change_order_amount AS DOUBLE)) / NULLIF(SUM(CAST(awarded_contract_value AS DOUBLE)), 0), 2)
      comment: "Change order value as a percentage of original awarded contract value. Industry benchmark is typically under 10%; values above signal design or scope management issues."
    - name: "payment_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_paid_to_date AS DOUBLE)) / NULLIF(SUM(CAST(current_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage of current contract value paid to date. Aligns financial disbursement with physical progress for cash flow management."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project cost transaction metrics for capital expenditure tracking, capitalization analysis, and cost element performance. Used by project controls and finance to monitor actual spend, reversals, and cost posting quality."
  source: "`vibe_water_utilities_v1`.`project`.`cost_transaction`"
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Type of cost transaction (e.g., Labor, Material, Equipment, Overhead) for cost element analysis."
    - name: "cost_element"
      expr: cost_element
      comment: "Specific cost element code for granular cost tracking and GL reconciliation."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the transaction (e.g., Posted, Pending, Reversed) for financial close quality monitoring."
    - name: "capitalization_flag"
      expr: capitalization_flag
      comment: "Whether the transaction is capitalized to a fixed asset. Drives CIP-to-fixed-asset transfer analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the transaction is a reversal entry. High reversal rates indicate posting quality issues."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction for annual capital spend reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month) of the transaction for period-over-period spend analysis."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction date for trend analysis of capital spend velocity."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class associated with the cost transaction for capital investment mix analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total capital cost transaction amount. Primary measure of actual project expenditure for financial reporting and budget reconciliation."
    - name: "total_capitalized_amount"
      expr: SUM(CASE WHEN capitalization_flag = TRUE THEN transaction_amount ELSE 0 END)
      comment: "Total amount capitalized to fixed assets. Tracks CIP-to-asset conversion, a key metric for balance sheet management and depreciation planning."
    - name: "total_reversal_amount"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN transaction_amount ELSE 0 END)
      comment: "Total value of reversed transactions. High reversal amounts indicate posting errors or contract disputes requiring investigation."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of cost transactions. Used for transaction volume monitoring and accounts payable workload analysis."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average cost transaction amount. Baseline for anomaly detection — unusually high averages may indicate split-purchase-order avoidance."
    - name: "capitalization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN capitalization_flag = TRUE THEN transaction_amount ELSE 0 END) / NULLIF(SUM(CAST(transaction_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total spend that is capitalized vs. expensed. Critical for GASB 34 compliance and rate base management — utilities target high capitalization rates on CIP spend."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that are reversals. A quality metric for project cost posting accuracy — high rates signal systemic process issues."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project budget health metrics tracking authorized budgets, encumbrances, expenditures, and remaining balances. Used by finance and capital program management for budget sufficiency analysis, appropriation monitoring, and multi-year capital planning."
  source: "`vibe_water_utilities_v1`.`project`.`project_budget`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget record (e.g., Approved, Pending, Expired) for active budget portfolio analysis."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category (e.g., Construction, Engineering, Land) for cost category mix analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget appropriation for annual capital budget reporting."
    - name: "phase"
      expr: phase
      comment: "Project phase the budget covers (e.g., Design, Construction) for phase-level budget tracking."
    - name: "is_multi_year_budget"
      expr: is_multi_year_budget
      comment: "Whether the budget spans multiple fiscal years, relevant for multi-year capital program management."
  measures:
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Total original approved budget across all project budgets. Baseline for measuring budget growth due to amendments."
    - name: "total_current_approved_budget"
      expr: SUM(CAST(current_approved_budget_amount AS DOUBLE))
      comment: "Total current approved budget including all amendments. The authoritative capital program size for board and rate case reporting."
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditures charged against project budgets. Core capital spend tracking metric."
    - name: "total_encumbered_amount"
      expr: SUM(CAST(encumbered_amount AS DOUBLE))
      comment: "Total encumbered (committed but not yet spent) amounts. Represents near-term cash obligations for treasury planning."
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining unspent and unencumbered budget. Critical for assessing capital program funding adequacy."
    - name: "total_contingency"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserves held across project budgets. Tracks risk buffer availability for the capital program."
    - name: "total_approved_amendments"
      expr: SUM(CAST(approved_amendments_amount AS DOUBLE))
      comment: "Total value of approved budget amendments. High amendment totals indicate original budget estimation quality issues."
    - name: "budget_execution_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget actually spent. Low rates indicate capital delivery delays; high rates signal potential overruns. Key metric for capital program efficiency reporting."
    - name: "encumbrance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(encumbered_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget that is encumbered. Combined with execution rate, reveals total committed capital exposure."
    - name: "budget_amendment_growth_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_amendments_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_budget_amount AS DOUBLE)), 0), 2)
      comment: "Budget growth from amendments as a percentage of original budget. Measures estimating accuracy and scope management discipline — a key capital program governance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change order analytics for construction contract scope and cost management. Tracks change order volume, cost impact, approval cycle times, and scope/schedule risk. Used by project controls and executive leadership to manage contractor performance and capital cost risk."
  source: "`vibe_water_utilities_v1`.`project`.`change_order`"
  dimensions:
    - name: "change_order_status"
      expr: change_order_status
      comment: "Current status of the change order (e.g., Approved, Pending, Rejected) for pipeline and approval tracking."
    - name: "change_order_type"
      expr: change_order_type
      comment: "Type of change order (e.g., Scope Addition, Differing Site Conditions, Owner-Directed) for root cause analysis."
    - name: "scope_addition_flag"
      expr: scope_addition_flag
      comment: "Whether the change order adds scope, distinguishing owner-initiated changes from contractor claims."
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Whether the change order is driven by a regulatory requirement, for compliance-driven cost tracking."
    - name: "safety_impact_flag"
      expr: safety_impact_flag
      comment: "Whether the change order has a safety impact, for risk prioritization."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether the change order has an environmental impact, for compliance risk tracking."
    - name: "initiated_year"
      expr: YEAR(initiated_date)
      comment: "Year the change order was initiated for trend analysis of change order frequency."
    - name: "priority"
      expr: priority
      comment: "Priority level of the change order for workload triage and approval queue management."
  measures:
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact of all change orders. Measures the financial exposure from contract modifications — a primary capital cost risk indicator."
    - name: "total_cumulative_change_order_value"
      expr: SUM(CAST(cumulative_change_order_value AS DOUBLE))
      comment: "Sum of cumulative change order values per contract. Tracks total contract modification exposure across the portfolio."
    - name: "change_order_count"
      expr: COUNT(1)
      comment: "Total number of change orders. High volumes indicate design quality or site condition issues requiring process improvement."
    - name: "approved_change_order_count"
      expr: COUNT(CASE WHEN change_order_status = 'Approved' THEN 1 END)
      comment: "Number of approved change orders. Tracks approved scope modifications for contract administration."
    - name: "rejected_change_order_count"
      expr: COUNT(CASE WHEN change_order_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected change orders. High rejection rates may indicate contractor over-claiming or poor change order documentation."
    - name: "scope_addition_cost_impact"
      expr: SUM(CASE WHEN scope_addition_flag = TRUE THEN cost_impact_amount ELSE 0 END)
      comment: "Total cost impact from scope addition change orders. Distinguishes owner-initiated cost growth from contractor claims for accountability reporting."
    - name: "regulatory_driven_cost_impact"
      expr: SUM(CASE WHEN regulatory_requirement_flag = TRUE THEN cost_impact_amount ELSE 0 END)
      comment: "Total cost impact from regulatory-driven change orders. Supports rate case justification for compliance-mandated capital cost increases."
    - name: "avg_cost_impact_per_change_order"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change order. Benchmarks change order magnitude — large averages indicate systemic design or site condition issues."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_pay_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contractor pay application metrics for construction payment management. Tracks payment certifications, retainage, and payment cycle performance. Used by project finance and accounts payable to manage contractor cash flow and payment compliance."
  source: "`vibe_water_utilities_v1`.`project`.`pay_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the pay application (e.g., Submitted, Certified, Paid, Rejected) for payment pipeline tracking."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_end_date)
      comment: "Billing period month for monthly payment volume and cash flow analysis."
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year of payment for annual capital disbursement reporting."
  measures:
    - name: "total_current_payment_due"
      expr: SUM(CAST(current_payment_due_amount AS DOUBLE))
      comment: "Total amount currently due to contractors. Drives accounts payable cash flow planning and payment scheduling."
    - name: "total_owner_approved_amount"
      expr: SUM(CAST(owner_approved_amount AS DOUBLE))
      comment: "Total amount approved by the owner for payment. Measures payment certification throughput and approval efficiency."
    - name: "total_retainage_held"
      expr: SUM(CAST(retainage_amount AS DOUBLE))
      comment: "Total retainage withheld across all pay applications. Represents contingent contractor liability and punch list completion incentive."
    - name: "total_materials_stored"
      expr: SUM(CAST(materials_stored_amount AS DOUBLE))
      comment: "Total value of materials stored on-site included in pay applications. Tracks material procurement advance payments and inventory risk."
    - name: "total_earned_to_date"
      expr: SUM(CAST(total_earned_to_date_amount AS DOUBLE))
      comment: "Total contract value earned to date across all pay applications. Measures cumulative construction progress in financial terms."
    - name: "pay_application_count"
      expr: COUNT(1)
      comment: "Total number of pay applications processed. Tracks payment administration workload."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical completion percentage across pay applications. Aligns financial progress with physical construction progress."
    - name: "payment_certification_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(owner_approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(engineer_certified_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of owner-approved amount to engineer-certified amount. Values below 100% indicate owner withholding beyond retainage, a contractor dispute risk signal."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_funding_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project funding allocation metrics tracking grant, loan, and bond fund utilization against CIP projects. Used by finance and grants management to monitor drawdown progress, matching requirements, and funding compliance."
  source: "`vibe_water_utilities_v1`.`project`.`funding_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the funding allocation (e.g., Active, Closed, Pending) for portfolio management."
    - name: "drawdown_schedule_type"
      expr: drawdown_schedule_type
      comment: "Type of drawdown schedule (e.g., Reimbursement, Advance) for cash flow planning."
    - name: "davis_bacon_required_flag"
      expr: davis_bacon_required_flag
      comment: "Whether Davis-Bacon prevailing wage requirements apply, for federal funding compliance tracking."
    - name: "american_iron_steel_required_flag"
      expr: american_iron_steel_required_flag
      comment: "Whether American Iron and Steel requirements apply, for federal funding compliance tracking."
    - name: "matching_requirement_flag"
      expr: matching_requirement_flag
      comment: "Whether a local match is required, for co-funding obligation tracking."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the funding allocation became effective for vintage analysis."
    - name: "conditions_precedent_met_flag"
      expr: conditions_precedent_met_flag
      comment: "Whether all conditions precedent to drawdown have been met, a key gating indicator for funding access."
  measures:
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total funding allocated to CIP projects. Core metric for capital program funding sufficiency analysis."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed funding amounts. Tracks binding financial obligations to funding agencies."
    - name: "total_drawn_to_date"
      expr: SUM(CAST(amount_drawn_to_date AS DOUBLE))
      comment: "Total funding drawn down to date. Measures grant/loan utilization and cash receipt performance."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining undrawn funding balance. Identifies available capital resources and drawdown urgency before expiration."
    - name: "total_forgiveness_amount"
      expr: SUM(CAST(forgiveness_amount AS DOUBLE))
      comment: "Total principal forgiveness amounts (e.g., SRF principal forgiveness). Measures grant-equivalent benefit from loan programs — critical for rate impact analysis."
    - name: "total_matching_amount"
      expr: SUM(CAST(matching_amount AS DOUBLE))
      comment: "Total local match amounts required. Tracks co-funding obligations that must be met to access federal/state grants."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of funding allocations. Tracks portfolio complexity and grants management workload."
    - name: "drawdown_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_drawn_to_date AS DOUBLE)) / NULLIF(SUM(CAST(allocation_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allocated funding drawn down to date. Low rates near expiration dates signal risk of losing grant funds — a critical grants management KPI."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across loan-based funding allocations. Informs debt service cost projections and rate case financial modeling."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_funding_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding source portfolio metrics for capital program financing analysis. Tracks authorized amounts, disbursements, available balances, and funding mix across grants, bonds, SRF loans, and rate revenue. Used by finance leadership for capital financing strategy and debt management."
  source: "`vibe_water_utilities_v1`.`project`.`funding_source`"
  dimensions:
    - name: "funding_source_type"
      expr: funding_source_type
      comment: "Type of funding source (e.g., SRF Loan, Revenue Bond, Grant, Rate Revenue) for financing mix analysis."
    - name: "funding_status"
      expr: funding_status
      comment: "Current status of the funding source (e.g., Active, Closed, Pending) for portfolio management."
    - name: "interest_rate_type"
      expr: interest_rate_type
      comment: "Fixed or variable interest rate type for debt portfolio risk analysis."
    - name: "disadvantaged_community_flag"
      expr: disadvantaged_community_flag
      comment: "Whether the funding source targets disadvantaged communities, for equity and compliance reporting."
    - name: "green_project_reserve_flag"
      expr: green_project_reserve_flag
      comment: "Whether the funding source includes a green project reserve, for sustainability investment tracking."
    - name: "buy_american_required_flag"
      expr: buy_american_required_flag
      comment: "Whether Buy American requirements apply, for federal funding compliance tracking."
    - name: "authorization_year"
      expr: YEAR(authorization_date)
      comment: "Year the funding source was authorized for vintage and debt maturity analysis."
  measures:
    - name: "total_authorized_amount"
      expr: SUM(CAST(total_authorized_amount AS DOUBLE))
      comment: "Total authorized funding across all sources. Represents the full capital financing capacity of the utility."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated to projects from funding sources. Measures capital commitment against available financing."
    - name: "total_disbursed_amount"
      expr: SUM(CAST(disbursed_amount AS DOUBLE))
      comment: "Total amount disbursed from funding sources. Tracks actual cash outflows for debt service and grant reporting."
    - name: "total_available_balance"
      expr: SUM(CAST(available_balance AS DOUBLE))
      comment: "Total remaining available balance across all funding sources. Critical for capital program liquidity management."
    - name: "funding_source_count"
      expr: COUNT(1)
      comment: "Total number of funding sources in the portfolio. Tracks financing diversification and grants management complexity."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across debt-based funding sources. Key input for debt service cost projections and rate case modeling."
    - name: "avg_principal_forgiveness_pct"
      expr: AVG(CAST(principal_forgiveness_percentage AS DOUBLE))
      comment: "Average principal forgiveness percentage across SRF and grant programs. Measures the grant-equivalent subsidy benefit reducing ratepayer burden."
    - name: "disbursement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(disbursed_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_authorized_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of authorized funding disbursed. Tracks capital program execution against financing commitments — low rates near expiration signal grant forfeiture risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project milestone delivery metrics for schedule performance management. Tracks on-time delivery, critical path adherence, and schedule variance across the CIP portfolio. Used by project managers and executives for schedule risk management and regulatory milestone compliance."
  source: "`vibe_water_utilities_v1`.`project`.`milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g., Complete, In Progress, At Risk, Missed) for delivery pipeline analysis."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (e.g., Design Complete, NTP, Substantial Completion, Regulatory Approval) for phase-level schedule tracking."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Whether the milestone is on the critical path, for prioritized schedule risk management."
    - name: "is_regulatory_milestone"
      expr: is_regulatory_milestone
      comment: "Whether the milestone is a regulatory commitment, for compliance schedule tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the milestone for proactive schedule risk management."
    - name: "baseline_year"
      expr: YEAR(baseline_date)
      comment: "Year of the baseline milestone date for schedule cohort analysis."
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Type of responsible party (e.g., Owner, Contractor, Regulator) for accountability tracking."
  measures:
    - name: "milestone_count"
      expr: COUNT(1)
      comment: "Total number of project milestones. Tracks schedule complexity and project controls workload."
    - name: "completed_milestone_count"
      expr: COUNT(CASE WHEN milestone_status = 'Complete' THEN 1 END)
      comment: "Number of completed milestones. Measures delivery throughput and project execution velocity."
    - name: "critical_path_milestone_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of critical path milestones. Tracks the schedule-critical delivery pipeline requiring executive attention."
    - name: "regulatory_milestone_count"
      expr: COUNT(CASE WHEN is_regulatory_milestone = TRUE THEN 1 END)
      comment: "Number of regulatory commitment milestones. Tracks compliance schedule obligations with potential penalty exposure."
    - name: "total_budget_impact"
      expr: SUM(CAST(budget_impact_amount AS DOUBLE))
      comment: "Total budget impact associated with milestone variances. Quantifies the financial consequence of schedule slippage."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across milestones. Provides a portfolio-level progress indicator for executive dashboards."
    - name: "milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Complete' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones completed. Core schedule performance KPI — low rates on critical path milestones trigger project recovery planning."
    - name: "regulatory_milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_regulatory_milestone = TRUE AND milestone_status = 'Complete' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_regulatory_milestone = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of regulatory milestones completed on time. Critical compliance KPI — missed regulatory milestones can trigger consent order penalties."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project risk portfolio metrics for capital program risk management. Tracks risk exposure, contingency adequacy, and risk response effectiveness. Used by project controls and executive leadership for risk-informed capital decision-making."
  source: "`vibe_water_utilities_v1`.`project`.`risk`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g., Open, Closed, Realized, Mitigated) for active risk portfolio management."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category (e.g., Technical, Regulatory, Financial, Environmental) for risk type analysis."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Probability rating of the risk occurring for likelihood-weighted risk analysis."
    - name: "cost_impact_rating"
      expr: cost_impact_rating
      comment: "Cost impact rating for risk severity analysis and contingency sizing."
    - name: "response_strategy"
      expr: response_strategy
      comment: "Risk response strategy (e.g., Mitigate, Transfer, Accept, Avoid) for risk management approach analysis."
    - name: "identification_year"
      expr: YEAR(identification_date)
      comment: "Year the risk was identified for trend analysis of risk emergence patterns."
  measures:
    - name: "total_estimated_cost_exposure"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost exposure across all open risks. Primary metric for contingency reserve adequacy assessment."
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact_amount AS DOUBLE))
      comment: "Total actual cost impact from realized risks. Measures the financial consequence of risk realization for lessons-learned and future contingency calibration."
    - name: "total_contingency_allocated"
      expr: SUM(CAST(contingency_reserve_allocated_amount AS DOUBLE))
      comment: "Total contingency reserves allocated to risks. Tracks risk-specific contingency consumption against the overall program contingency budget."
    - name: "total_exposure_amount"
      expr: SUM(CAST(exposure_amount AS DOUBLE))
      comment: "Total risk exposure amount (probability-weighted cost impact). The primary risk-adjusted capital cost metric for executive reporting."
    - name: "total_residual_risk_score"
      expr: SUM(CAST(residual_risk_score AS DOUBLE))
      comment: "Sum of residual risk scores after mitigation. Tracks the remaining risk burden in the portfolio after response actions."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Number of open risks. Tracks active risk portfolio size requiring management attention."
    - name: "realized_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Realized' THEN 1 END)
      comment: "Number of risks that have been realized (materialized). Tracks risk realization rate for contingency adequacy assessment."
    - name: "avg_risk_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average risk score across the portfolio. Provides a composite risk severity indicator for portfolio-level risk trending."
    - name: "risk_realization_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_status = 'Realized' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of identified risks that have been realized. Measures risk prediction accuracy and the effectiveness of risk mitigation strategies."
    - name: "contingency_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(contingency_reserve_allocated_amount AS DOUBLE)) / NULLIF(SUM(CAST(estimated_cost_impact_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated cost exposure covered by allocated contingency. Values below 100% indicate under-reserved risk exposure requiring management action."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work Breakdown Structure element performance metrics for earned value management (EVM). Tracks planned value, earned value, actual cost, and schedule/cost performance indices. Used by project controls for EVM reporting and capital program performance management."
  source: "`vibe_water_utilities_v1`.`project`.`wbs_element`"
  dimensions:
    - name: "wbs_element_status"
      expr: wbs_element_status
      comment: "Current status of the WBS element (e.g., Active, Closed, On Hold) for active work package analysis."
    - name: "wbs_element_type"
      expr: wbs_element_type
      comment: "Type of WBS element (e.g., Work Package, Control Account, Summary) for EVM hierarchy analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the WBS element for roll-up and drill-down analysis."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area (e.g., Civil, Mechanical, Electrical) for discipline-level cost performance analysis."
    - name: "commissioning_required_flag"
      expr: commissioning_required_flag
      comment: "Whether commissioning is required for this WBS element, for commissioning pipeline tracking."
    - name: "billing_element_flag"
      expr: billing_element_flag
      comment: "Whether this WBS element is a billing element, for contractor payment milestone tracking."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the WBS element for risk-weighted performance analysis."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted cost of work scheduled (BCWS/Planned Value) across WBS elements. Foundation of earned value management."
    - name: "total_planned_value"
      expr: SUM(CAST(planned_value AS DOUBLE))
      comment: "Total planned value (BCWS) across WBS elements. Represents the time-phased budget baseline for EVM."
    - name: "total_earned_value"
      expr: SUM(CAST(earned_value AS DOUBLE))
      comment: "Total earned value (BCWP) across WBS elements. Measures the budgeted value of work actually performed — the core EVM performance metric."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of work performed (ACWP) across WBS elements. Compared against earned value to compute cost performance."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost AS DOUBLE))
      comment: "Total committed costs (purchase orders, contracts) across WBS elements. Represents near-term cash obligations."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average physical completion percentage across WBS elements. Tracks overall work package delivery progress."
    - name: "wbs_element_count"
      expr: COUNT(1)
      comment: "Total number of WBS elements. Tracks project decomposition complexity and controls workload."
    - name: "cost_performance_index"
      expr: ROUND(SUM(CAST(earned_value AS DOUBLE)) / NULLIF(SUM(CAST(actual_cost AS DOUBLE)), 0), 3)
      comment: "Cost Performance Index (CPI = EV/AC). The primary EVM efficiency metric — CPI < 1.0 indicates cost overrun; CPI > 1.0 indicates under-spend. Used for Estimate at Completion (EAC) forecasting."
    - name: "schedule_performance_index"
      expr: ROUND(SUM(CAST(earned_value AS DOUBLE)) / NULLIF(SUM(CAST(planned_value AS DOUBLE)), 0), 3)
      comment: "Schedule Performance Index (SPI = EV/PV). Measures schedule efficiency — SPI < 1.0 indicates schedule slippage. Combined with CPI, drives project recovery decisions."
    - name: "cost_variance_amount"
      expr: SUM((CAST(earned_value AS DOUBLE)) - (CAST(actual_cost AS DOUBLE)))
      comment: "Cost Variance (CV = EV - AC) across WBS elements. Negative values indicate cost overrun; positive values indicate under-spend. Direct input to EAC forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_closeout_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project closeout performance metrics tracking final cost performance, capitalization, and closeout process completion. Used by project controls, finance, and asset management to ensure proper project closure, asset capitalization, and lessons-learned capture."
  source: "`vibe_water_utilities_v1`.`project`.`closeout_record`"
  dimensions:
    - name: "closeout_status"
      expr: closeout_status
      comment: "Current status of the closeout record (e.g., In Progress, Complete, Pending) for closeout pipeline management."
    - name: "closeout_type"
      expr: closeout_type
      comment: "Type of closeout (e.g., Final, Partial, Administrative) for closeout category analysis."
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year of project completion for vintage analysis of closeout performance."
    - name: "lessons_learned_documented_flag"
      expr: lessons_learned_documented_flag
      comment: "Whether lessons learned were documented, for knowledge management quality tracking."
    - name: "regulatory_inspection_complete_flag"
      expr: regulatory_inspection_complete_flag
      comment: "Whether regulatory inspection was completed, for compliance closeout tracking."
    - name: "asset_handover_complete_flag"
      expr: asset_handover_complete_flag
      comment: "Whether asset handover to operations was completed, for asset management readiness tracking."
  measures:
    - name: "total_final_capitalization"
      expr: SUM(CAST(final_capitalization_amount AS DOUBLE))
      comment: "Total amount capitalized to fixed assets at project closeout. Core metric for balance sheet additions and depreciation schedule updates."
    - name: "total_final_approved_budget"
      expr: SUM(CAST(final_approved_budget_amount AS DOUBLE))
      comment: "Total final approved budget at closeout. Baseline for final budget variance calculation."
    - name: "total_actual_cost"
      expr: SUM(CAST(total_actual_cost AS DOUBLE))
      comment: "Total actual cost at project closeout. Final cost performance measure for lessons-learned and future estimating calibration."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance at closeout (actual vs. final approved budget). Measures final cost performance across the closed project portfolio."
    - name: "total_retainage_released"
      expr: SUM(CAST(retainage_released_amount AS DOUBLE))
      comment: "Total retainage released to contractors at closeout. Tracks final contractor payment obligations and cash outflow."
    - name: "closeout_count"
      expr: COUNT(1)
      comment: "Total number of project closeout records. Tracks closeout pipeline volume and project completion throughput."
    - name: "avg_budget_variance_pct"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage at closeout. Measures estimating accuracy across the closed project portfolio — a key capital program governance KPI."
    - name: "asset_handover_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN asset_handover_complete_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of closed projects with completed asset handover. Ensures new infrastructure is properly transferred to operations and capitalized — critical for asset management and rate base integrity."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_asset_handover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset handover financial summary"
  source: "`vibe_water_utilities_v1`.`project`.`asset_handover`"
  dimensions:
    - name: "handover_status"
      expr: handover_status
      comment: "Current status of the handover"
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Classification code of the asset"
    - name: "geographic_location"
      expr: geographic_location
      comment: "Geographic location of the asset"
    - name: "handover_month"
      expr: DATE_TRUNC('month', handover_date)
      comment: "Month the handover occurred"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of asset handover records"
    - name: "total_installed_cost_amount"
      expr: SUM(CAST(installed_cost_amount AS DOUBLE))
      comment: "Total installed cost amount for handed over assets"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_commissioning_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and performance verification during commissioning"
  source: "`vibe_water_utilities_v1`.`project`.`commissioning_activity`"
  dimensions:
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the commissioning activity"
    - name: "activity_type"
      expr: activity_type
      comment: "Type/category of the activity"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the activity"
    - name: "regulatory_approval_year"
      expr: DATE_TRUNC('year', regulatory_approval_date)
      comment: "Year of regulatory approval"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of commissioning activities recorded"
    - name: "total_flow_test_result_gpm"
      expr: SUM(CAST(flow_test_result_gpm AS DOUBLE))
      comment: "Aggregate flow test results (gallons per minute)"
    - name: "total_pressure_test_result_psi"
      expr: SUM(CAST(pressure_test_result_psi AS DOUBLE))
      comment: "Aggregate pressure test results (psi)"
    - name: "average_disinfection_contact_time_minutes"
      expr: AVG(CAST(disinfection_contact_time_minutes AS DOUBLE))
      comment: "Average disinfection contact time in minutes"
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`project_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Issue tracking with cost implications"
  source: "`vibe_water_utilities_v1`.`project`.`issue`"
  dimensions:
    - name: "issue_status"
      expr: issue_status
      comment: "Current status of the issue"
    - name: "issue_type"
      expr: issue_type
      comment: "Category of the issue (e.g., safety, environmental)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the issue"
    - name: "identified_year"
      expr: DATE_TRUNC('year', date_identified)
      comment: "Year the issue was identified"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of issues logged"
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Aggregate cost impact of all issues"
$$;