-- Metric views for domain: grant | Business: Ngo | Version: 2 | Generated on: 2026-07-03 06:15:30

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the award fact table. Tracks portfolio size, funding volumes, cost-share commitments, and indirect cost ceilings to support grant portfolio steering and donor relationship management."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Lifecycle status of the award (e.g. Active, Closed, Suspended) — primary filter for portfolio health dashboards."
    - name: "award_type"
      expr: award_type
      comment: "Classification of the award instrument (e.g. Grant, Cooperative Agreement, Contract) — drives compliance and reporting obligations."
    - name: "funding_mechanism"
      expr: funding_mechanism
      comment: "Mechanism through which funding is delivered (e.g. Direct, Pass-through) — informs sub-award and flow-down analysis."
    - name: "thematic_sector"
      expr: thematic_sector
      comment: "Programmatic sector alignment (e.g. Health, WASH, Education) — used for portfolio allocation and donor reporting."
    - name: "primary_country_code"
      expr: primary_country_code
      comment: "ISO country code of the primary implementation geography — enables geographic portfolio analysis."
    - name: "currency"
      expr: currency
      comment: "Award currency code — required for multi-currency portfolio reconciliation."
    - name: "functional_currency"
      expr: functional_currency
      comment: "Functional reporting currency — used to normalise cross-currency comparisons."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — required for ODA/donor regulatory reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "Sustainable Development Goal alignment tag — supports impact and strategic reporting."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Donor-required reporting cadence — drives report scheduling and compliance workload planning."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction classification (Restricted / Unrestricted / Temporarily Restricted) — critical for fund utilisation governance."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the award period of performance begins — used for cohort and vintage analysis."
    - name: "end_year"
      expr: YEAR(end_date)
      comment: "Year the award period of performance ends — used to identify awards approaching closeout."
    - name: "is_grantmaking_out"
      expr: is_grantmaking_out
      comment: "Flag indicating the organisation is acting as a grantmaker (pass-through) — separates prime from sub-recipient portfolio views."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Breadth of geographic coverage (e.g. National, Regional, Global) — used for programme reach analysis."
  measures:
    - name: "total_awards"
      expr: COUNT(1)
      comment: "Total number of awards in the portfolio. Baseline volume KPI for portfolio size tracking."
    - name: "total_obligated_amount"
      expr: SUM(CAST(total_obligated_amount AS DOUBLE))
      comment: "Sum of all obligated award amounts in award currency. Primary funding volume KPI for portfolio valuation and donor stewardship."
    - name: "total_obligated_amount_functional"
      expr: SUM(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Sum of obligated amounts converted to functional currency. Enables normalised cross-currency portfolio comparison for executive reporting."
    - name: "total_authorized_amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Sum of amounts formally authorised for expenditure. Compared against obligated amounts to identify funding gaps or over-authorisation."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share (matching) commitments across the portfolio. Tracks organisational co-investment obligations to donors."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage across awards. Indicates the typical co-investment burden and informs proposal strategy."
    - name: "total_indirect_cost_ceiling"
      expr: SUM(CAST(indirect_cost_ceiling AS DOUBLE))
      comment: "Sum of indirect cost ceilings across all awards. Tracks the maximum recoverable overhead and informs NICRA negotiation strategy."
    - name: "avg_nicra_icr_rate"
      expr: AVG(CAST(nicra_icr_rate AS DOUBLE))
      comment: "Average NICRA indirect cost recovery rate across awards. Benchmarks overhead recovery performance against negotiated rates."
    - name: "avg_period_of_performance_months"
      expr: AVG(DATEDIFF(end_date, start_date) / 30.44)
      comment: "Average award duration in months derived from start and end dates. Informs programme planning and resource allocation cycles."
    - name: "active_award_count"
      expr: COUNT(CASE WHEN award_status = 'Active' THEN 1 END)
      comment: "Count of currently active awards. Core operational KPI for portfolio management and staffing capacity planning."
    - name: "awards_with_audit_required"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN 1 END)
      comment: "Number of awards requiring a formal audit. Drives audit scheduling, compliance workload, and risk management planning."
    - name: "audit_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of awards subject to audit requirements. Indicates compliance exposure and audit resource demand across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development and pipeline KPI layer over the proposal fact table. Tracks win rates, funding requested, proposal conversion, and pipeline health to steer grant acquisition strategy."
  source: "`vibe_ngo_v1`.`grant`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current stage of the proposal lifecycle (e.g. Draft, Submitted, Won, Lost) — primary dimension for pipeline funnel analysis."
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (e.g. Unsolicited, Competitive, Renewal) — informs business development strategy and resource allocation."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final outcome of the proposal (Won / Lost / No Decision) — core dimension for win-rate and conversion analysis."
    - name: "go_no_go_decision"
      expr: go_no_go_decision
      comment: "Internal go/no-go gate decision — tracks proposal qualification discipline and pipeline quality."
    - name: "lead_technical_sector"
      expr: lead_technical_sector
      comment: "Primary technical sector of the proposal — enables sector-level win-rate and funding pipeline analysis."
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic focus of the proposed programme — supports regional business development strategy."
    - name: "partnership_model"
      expr: partnership_model
      comment: "Partnership structure (e.g. Prime, Sub, Consortium) — informs partnership strategy and risk distribution."
    - name: "requested_currency"
      expr: requested_currency
      comment: "Currency of the funding request — required for multi-currency pipeline valuation."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the proposal was submitted — enables year-over-year business development trend analysis."
    - name: "compliance_review_completed"
      expr: compliance_review_completed
      comment: "Flag indicating internal compliance review was completed before submission — tracks proposal quality gate adherence."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals in the pipeline. Baseline volume KPI for business development activity tracking."
    - name: "total_requested_amount_usd"
      expr: SUM(CAST(requested_amount_usd AS DOUBLE))
      comment: "Total funding requested across all proposals in USD. Primary pipeline valuation KPI for business development forecasting."
    - name: "avg_requested_amount_usd"
      expr: AVG(CAST(requested_amount_usd AS DOUBLE))
      comment: "Average funding requested per proposal in USD. Benchmarks deal size and informs resource allocation per proposal."
    - name: "won_proposals_count"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Won' THEN 1 END)
      comment: "Number of proposals that resulted in an award. Core business development success KPI."
    - name: "win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN win_loss_outcome = 'Won' THEN 1 END) / NULLIF(COUNT(CASE WHEN win_loss_outcome IN ('Won', 'Lost') THEN 1 END), 0), 2)
      comment: "Percentage of decided proposals that were won. Strategic KPI for evaluating business development effectiveness and proposal quality."
    - name: "total_won_amount_usd"
      expr: SUM(CASE WHEN win_loss_outcome = 'Won' THEN CAST(requested_amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total USD value of won proposals. Measures the financial yield of the business development function."
    - name: "avg_proposed_duration_months"
      expr: AVG(CAST(proposed_duration_months AS DOUBLE))
      comment: "Average proposed programme duration in months. Informs programme planning capacity and multi-year funding strategy."
    - name: "total_cost_share_committed_usd"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts committed in proposals. Tracks organisational co-investment obligations being proposed to donors."
    - name: "compliance_review_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_review_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of proposals with completed compliance review. Measures proposal quality gate adherence and risk management discipline."
    - name: "go_no_go_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN go_no_go_decision = 'Go' THEN 1 END) / NULLIF(COUNT(CASE WHEN go_no_go_decision IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of proposals that passed the go/no-go gate. Tracks pipeline qualification discipline and strategic selectivity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and cost structure KPI layer over the award budget fact table. Tracks approved budgets, cost category breakdowns, indirect cost recovery, and budget amendment activity to support financial governance."
  source: "`vibe_ngo_v1`.`grant`.`award_budget`"
  dimensions:
    - name: "award_currency"
      expr: award_currency
      comment: "Currency of the award budget — required for multi-currency budget analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of the budget (Restricted / Unrestricted) — governs allowable expenditure and reporting."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Flag indicating this budget version is an amendment — separates original budgets from revised versions for trend analysis."
    - name: "approved_by"
      expr: approved_by
      comment: "Name or role of the approving authority — supports approval workflow audit and accountability tracking."
    - name: "donor_approval_year"
      expr: YEAR(donor_approval_date)
      comment: "Year of donor budget approval — enables year-over-year budget approval cycle analysis."
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the budget record was created — used for budget vintage and planning cycle analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Sum of all approved award budgets. Primary financial planning KPI for portfolio budget under management."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Sum of all direct programme costs across budgets. Measures the direct programme investment and informs cost structure analysis."
    - name: "total_indirect_costs"
      expr: SUM(CAST(total_indirect_costs AS DOUBLE))
      comment: "Sum of all indirect (overhead) costs across budgets. Tracks overhead recovery and informs NICRA rate negotiations."
    - name: "indirect_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_indirect_costs AS DOUBLE)) / NULLIF(SUM(CAST(total_direct_costs AS DOUBLE)), 0), 2)
      comment: "Indirect costs as a percentage of direct costs across the portfolio. Strategic KPI for overhead efficiency and donor cost-effectiveness reporting."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Sum of personnel costs across all budgets. Tracks the largest cost driver and informs staffing and HR planning."
    - name: "personnel_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(personnel_costs AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_budget AS DOUBLE)), 0), 2)
      comment: "Personnel costs as a percentage of total approved budget. Benchmarks staffing intensity and informs budget structure decisions."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Sum of travel costs across all budgets. Tracks field presence investment and informs travel policy and cost containment."
    - name: "total_contractual_costs"
      expr: SUM(CAST(contractual_costs AS DOUBLE))
      comment: "Sum of contractual (sub-award and vendor) costs. Tracks partnership and procurement spend volume."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share contributions budgeted. Tracks organisational co-investment commitments against donor requirements."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA indirect cost rate applied across budgets. Benchmarks actual rate application against negotiated ceilings."
    - name: "amendment_budget_count"
      expr: COUNT(CASE WHEN is_amendment = TRUE THEN 1 END)
      comment: "Number of budget records that are amendments. Tracks budget revision frequency as a proxy for award complexity and change management burden."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item budget execution KPI layer. Tracks approved vs revised amounts, expenditure variances, cost allowability, and indirect cost recovery at the most granular budget level to support financial control and donor reporting."
  source: "`vibe_ngo_v1`.`grant`.`award_budget_line`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line — required for multi-currency expenditure analysis."
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor-defined cost category for reporting — maps internal cost structure to donor reporting requirements."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of the budget line — governs allowable use of funds."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code — links budget lines to financial accounting for reconciliation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — enables year-over-year budget and expenditure trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g. quarter or month) of the budget line — supports periodic financial reporting."
    - name: "allocability_flag"
      expr: allocability_flag
      comment: "Flag indicating the cost is allocable to the award — used to identify and remediate non-allocable charges."
    - name: "allowability_flag"
      expr: allowability_flag
      comment: "Flag indicating the cost is allowable under donor rules — critical for compliance and audit risk management."
    - name: "reasonableness_flag"
      expr: reasonableness_flag
      comment: "Flag indicating the cost meets reasonableness standards — supports cost certification and audit defence."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the budget line item — enables quantity-based cost analysis."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the budget line was approved — used for approval cycle and budget planning analysis."
  measures:
    - name: "total_approved_amount_usd"
      expr: SUM(CAST(approved_amount_usd AS DOUBLE))
      comment: "Total approved budget line amounts in USD. Primary budget baseline KPI for financial planning and donor reporting."
    - name: "total_revised_amount_usd"
      expr: SUM(CAST(revised_amount_usd AS DOUBLE))
      comment: "Total revised budget line amounts in USD. Tracks cumulative budget modifications and amendment impact."
    - name: "total_cumulative_expenditure_usd"
      expr: SUM(CAST(cumulative_expenditure_usd AS DOUBLE))
      comment: "Total cumulative expenditure against budget lines in USD. Core financial execution KPI for burn rate and budget utilisation tracking."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of budget-to-actual variance amounts. Identifies over- and under-spending patterns requiring management intervention."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across line items. Measures overall budget execution accuracy and financial management quality."
    - name: "budget_utilisation_rate"
      expr: ROUND(100.0 * SUM(CAST(cumulative_expenditure_usd AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount_usd AS DOUBLE)), 0), 2)
      comment: "Cumulative expenditure as a percentage of approved budget in USD. Strategic KPI for burn rate monitoring and closeout readiness assessment."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs charged at line-item level. Tracks overhead recovery against NICRA ceilings."
    - name: "non_allowable_line_count"
      expr: COUNT(CASE WHEN allowability_flag = FALSE THEN 1 END)
      comment: "Number of budget lines flagged as non-allowable. Critical compliance KPI — non-allowable costs must be remediated before donor reporting."
    - name: "non_allocable_line_count"
      expr: COUNT(CASE WHEN allocability_flag = FALSE THEN 1 END)
      comment: "Number of budget lines flagged as non-allocable. Tracks cost allocation compliance risk requiring corrective action."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied at line-item level. Validates consistent rate application across the award portfolio."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts at line-item level. Tracks granular co-investment fulfilment against donor commitments."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor reporting compliance and performance KPI layer. Tracks submission timeliness, overdue reports, financial reporting accuracy, and report acceptance rates to manage donor relationships and regulatory compliance."
  source: "`vibe_ngo_v1`.`grant`.`donor_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of donor report (e.g. Financial, Narrative, Progress, Final) — primary dimension for report workload and compliance analysis."
    - name: "report_status"
      expr: report_status
      comment: "Current status of the report (e.g. Draft, Submitted, Accepted, Rejected) — tracks report lifecycle and compliance posture."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Cadence of reporting obligation (e.g. Monthly, Quarterly, Annual) — informs reporting workload planning."
    - name: "submission_method"
      expr: submission_method
      comment: "Channel used to submit the report (e.g. Portal, Email, Post) — tracks digital adoption and submission efficiency."
    - name: "financial_currency"
      expr: financial_currency
      comment: "Currency of financial amounts reported — required for multi-currency financial reporting analysis."
    - name: "is_final_version"
      expr: is_final_version
      comment: "Flag indicating this is the final accepted version — separates draft iterations from official submissions."
    - name: "is_overdue"
      expr: is_overdue
      comment: "Flag indicating the report was submitted after the due date — primary dimension for compliance risk dashboards."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Flag indicating the report includes a compliance certification — tracks regulatory certification adherence."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of report submission — enables year-over-year reporting compliance trend analysis."
    - name: "reporting_period_end_year"
      expr: YEAR(reporting_period_end_date)
      comment: "Year the reporting period ends — used for cohort-based compliance analysis."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of donor reports. Baseline volume KPI for reporting workload and compliance obligation tracking."
    - name: "overdue_report_count"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN 1 END)
      comment: "Number of reports submitted after their due date. Critical compliance KPI — overdue reports risk donor relationship damage and funding suspension."
    - name: "on_time_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overdue = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports submitted on time. Strategic KPI for donor relationship management and compliance performance benchmarking."
    - name: "total_financial_amount_reported_usd"
      expr: SUM(CAST(financial_amount_reported_usd AS DOUBLE))
      comment: "Total financial amounts reported to donors in USD. Tracks the scale of financial accountability and donor stewardship."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Sum of budget-to-actual variance amounts reported to donors. Identifies systemic over- or under-spending patterns requiring management action."
    - name: "avg_budget_variance_percentage"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across donor reports. Measures financial execution accuracy as reported to donors."
    - name: "accepted_report_count"
      expr: COUNT(CASE WHEN report_status = 'Accepted' THEN 1 END)
      comment: "Number of reports formally accepted by donors. Measures reporting quality and donor satisfaction with submissions."
    - name: "report_acceptance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN report_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(CASE WHEN report_status IN ('Accepted', 'Rejected') THEN 1 END), 0), 2)
      comment: "Percentage of decided reports accepted by donors. Strategic KPI for reporting quality and donor relationship health."
    - name: "compliance_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_certification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports including a compliance certification. Tracks regulatory certification adherence across the reporting portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_subaward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sub-award portfolio management KPI layer. Tracks sub-award obligations, disbursements, remaining balances, risk ratings, and compliance flags to support partner financial oversight and pass-through grant governance."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of sub-award funds — governs allowable expenditure and reporting obligations."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Sub-awardee reporting cadence — informs compliance workload and partner capacity planning."
    - name: "currency"
      expr: currency
      comment: "Currency of the sub-award — required for multi-currency portfolio analysis."
  measures:
    - name: "total_subawards"
      expr: COUNT(1)
      comment: "Total number of sub-awards in the portfolio. Baseline volume KPI for partnership and pass-through grant management."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share contributions required from sub-awardees. Tracks partner co-investment obligations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_sub_award_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sub-award cash flow and disbursement execution KPI layer. Tracks disbursement volumes, advance balances, liquidation performance, and emergency disbursements to support partner financial management and cash flow governance."
  source: "`vibe_ngo_v1`.`grant`.`sub_award_disbursement`"
  dimensions:
    - name: "disbursement_status"
      expr: disbursement_status
      comment: "Current status of the disbursement (e.g. Pending, Approved, Paid, Cancelled) — primary dimension for payment pipeline monitoring."
    - name: "disbursement_type"
      expr: disbursement_type
      comment: "Type of disbursement (e.g. Advance, Reimbursement, Final Payment) — informs cash flow pattern and advance management analysis."
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Payment method used (e.g. Wire Transfer, Mobile Money, Cheque) — tracks payment channel efficiency and financial inclusion."
    - name: "disbursement_currency"
      expr: disbursement_currency
      comment: "Currency of the disbursement — required for multi-currency cash flow analysis."
    - name: "liquidation_status"
      expr: liquidation_status
      comment: "Status of advance liquidation (e.g. Pending, Partial, Fully Liquidated) — tracks advance accountability and financial risk."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of disbursed funds — governs allowable use and reporting."
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor cost category for the disbursement — maps cash flows to donor reporting requirements."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the disbursement — enables year-over-year cash flow trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the disbursement — supports periodic cash flow and burn rate reporting."
    - name: "is_emergency_disbursement"
      expr: is_emergency_disbursement
      comment: "Flag indicating an emergency disbursement — tracks humanitarian response cash flow separately from regular programme disbursements."
    - name: "disbursement_year"
      expr: YEAR(disbursement_date)
      comment: "Year of actual disbursement — used for annual cash flow and partner payment trend analysis."
  measures:
    - name: "total_disbursement_amount_usd"
      expr: SUM(CAST(disbursement_amount_usd AS DOUBLE))
      comment: "Total disbursements to sub-awardees in USD. Primary cash flow KPI for partner financial management and programme implementation tracking."
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net disbursements after withholdings. Measures actual cash transferred to partners net of deductions."
    - name: "total_advance_balance_outstanding"
      expr: SUM(CAST(advance_balance_outstanding AS DOUBLE))
      comment: "Total outstanding advance balances across sub-awardees. Critical financial risk KPI — high outstanding advances indicate liquidation risk and potential misuse of funds."
    - name: "total_liquidated_amount"
      expr: SUM(CAST(liquidated_amount AS DOUBLE))
      comment: "Total advance amounts liquidated by sub-awardees. Tracks accountability for advances and partner financial management capacity."
    - name: "advance_liquidation_rate"
      expr: ROUND(100.0 * SUM(CAST(liquidated_amount AS DOUBLE)) / NULLIF(SUM(CAST(disbursement_amount_usd AS DOUBLE)), 0), 2)
      comment: "Liquidated amount as a percentage of total disbursements. Strategic KPI for advance accountability and partner financial management quality."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total amounts withheld from disbursements. Tracks compliance-driven payment deductions and their financial impact on partners."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs included in disbursements. Tracks overhead recovery through the sub-award payment cycle."
    - name: "emergency_disbursement_count"
      expr: COUNT(CASE WHEN is_emergency_disbursement = TRUE THEN 1 END)
      comment: "Number of emergency disbursements. Tracks humanitarian response payment volume and informs emergency cash flow planning."
    - name: "emergency_disbursement_amount_usd"
      expr: SUM(CASE WHEN is_emergency_disbursement = TRUE THEN CAST(disbursement_amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total USD value of emergency disbursements. Measures the financial scale of humanitarian response cash flows."
    - name: "avg_disbursement_amount_usd"
      expr: AVG(CAST(disbursement_amount_usd AS DOUBLE))
      comment: "Average disbursement amount per transaction in USD. Benchmarks payment size and informs cash flow forecasting and partner capacity assessment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor condition compliance KPI layer. Tracks condition fulfilment rates, overdue conditions, financial thresholds, and risk ratings to manage award compliance obligations and donor relationship risk."
  source: "`vibe_ngo_v1`.`grant`.`donor_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of donor condition (e.g. Precedent, Subsequent, Reporting) — primary dimension for compliance obligation categorisation."
    - name: "condition_category"
      expr: condition_category
      comment: "Category of the condition (e.g. Financial, Programmatic, Legal) — enables targeted compliance management by domain."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g. Met, Pending, Overdue, Waived) — primary dimension for compliance risk dashboards."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the condition (e.g. Critical, High, Medium, Low) — drives escalation and resource allocation for compliance management."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the condition — informs monitoring intensity and escalation thresholds."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for condition fulfilment — enables workload distribution and accountability tracking."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency of condition monitoring — tracks oversight intensity relative to risk and priority."
    - name: "is_special_award_condition"
      expr: is_special_award_condition
      comment: "Flag indicating a special award condition (SAC) — SACs require elevated management attention and donor approval."
    - name: "is_membership_obligation"
      expr: is_membership_obligation
      comment: "Flag indicating a membership dues obligation — separates membership compliance from programmatic award conditions."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the condition is due — used for compliance calendar and workload planning."
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total number of donor conditions. Baseline compliance obligation volume KPI for workload and risk management planning."
    - name: "met_condition_count"
      expr: COUNT(CASE WHEN compliance_status = 'Met' THEN 1 END)
      comment: "Number of conditions successfully met. Tracks compliance fulfilment performance across the award portfolio."
    - name: "condition_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Met' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of donor conditions met. Strategic KPI for compliance performance and donor relationship health — low rates signal systemic compliance risk."
    - name: "overdue_condition_count"
      expr: COUNT(CASE WHEN compliance_status = 'Overdue' THEN 1 END)
      comment: "Number of conditions past their due date without fulfilment. Critical risk KPI — overdue conditions can trigger donor sanctions or funding suspension."
    - name: "high_risk_condition_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of conditions rated high risk. Tracks the concentration of high-risk compliance obligations requiring priority management attention."
    - name: "total_financial_threshold_amount"
      expr: SUM(CAST(financial_threshold_amount AS DOUBLE))
      comment: "Sum of financial thresholds associated with donor conditions. Quantifies the financial exposure linked to compliance obligations."
    - name: "total_membership_dues_amount"
      expr: SUM(CAST(membership_dues_amount AS DOUBLE))
      comment: "Total membership dues obligations tracked as donor conditions. Tracks financial commitments to membership bodies and networks."
    - name: "special_award_condition_count"
      expr: COUNT(CASE WHEN is_special_award_condition = TRUE THEN 1 END)
      comment: "Number of special award conditions (SACs). SACs represent elevated compliance obligations requiring donor prior approval — tracking volume informs compliance resource planning."
    - name: "critical_priority_condition_count"
      expr: COUNT(CASE WHEN priority_level = 'Critical' THEN 1 END)
      comment: "Number of conditions at critical priority level. Drives immediate escalation and executive attention for highest-risk compliance obligations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_funding_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding source portfolio KPI layer. Tracks available funding, endowment assets, cost-share requirements, and compliance characteristics of funding sources to support donor diversification and funding strategy."
  source: "`vibe_ngo_v1`.`grant`.`funding_source`"
  dimensions:
    - name: "funding_source_status"
      expr: funding_source_status
      comment: "Status of the funding source (e.g. Active, Inactive, Closed) — primary dimension for active funding pipeline analysis."
    - name: "funding_mechanism_type"
      expr: funding_mechanism_type
      comment: "Mechanism type (e.g. Grant, Contract, Cooperative Agreement, Endowment) — informs compliance requirements and reporting obligations."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction classification — governs allowable use and financial reporting requirements."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the funding source — required for multi-currency portfolio analysis."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Regulatory compliance framework (e.g. US Federal, EU, UN) — drives compliance and reporting obligations."
    - name: "audit_requirement"
      expr: audit_requirement
      comment: "Audit requirement type associated with the funding source — informs audit planning and compliance workload."
    - name: "is_endowment_fund"
      expr: is_endowment_fund
      comment: "Flag indicating an endowment fund — separates endowment from operational funding sources for investment and spending policy analysis."
    - name: "subaward_allowed"
      expr: subaward_allowed
      comment: "Flag indicating sub-awarding is permitted — informs partnership and pass-through programme design."
    - name: "oda_dac_classification"
      expr: oda_dac_classification
      comment: "OECD DAC ODA classification — required for official development assistance reporting and donor regulatory compliance."
    - name: "funding_start_year"
      expr: YEAR(funding_start_date)
      comment: "Year the funding source becomes available — used for funding pipeline and vintage analysis."
  measures:
    - name: "total_funding_available"
      expr: SUM(CAST(total_funding_available AS DOUBLE))
      comment: "Total funding available across all funding sources. Primary portfolio valuation KPI for funding pipeline and resource planning."
    - name: "total_endowment_principal"
      expr: SUM(CAST(endowment_principal_amount AS DOUBLE))
      comment: "Total endowment principal under management. Tracks the long-term asset base supporting organisational sustainability."
    - name: "total_endowment_net_appreciation"
      expr: SUM(CAST(endowment_net_appreciation_amount AS DOUBLE))
      comment: "Total net appreciation on endowment assets. Measures investment performance and growth of the endowment portfolio."
    - name: "avg_endowment_spending_policy_rate"
      expr: AVG(CAST(endowment_spending_policy_rate AS DOUBLE))
      comment: "Average endowment spending policy rate. Benchmarks the sustainable draw-down rate against investment returns for long-term financial health."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required by funding sources. Informs proposal strategy and organisational co-investment capacity planning."
    - name: "avg_nicra_rate"
      expr: AVG(CAST(nicra_rate AS DOUBLE))
      comment: "Average NICRA indirect cost rate across funding sources. Benchmarks overhead recovery rates and informs NICRA negotiation strategy."
    - name: "active_funding_source_count"
      expr: COUNT(CASE WHEN funding_source_status = 'Active' THEN 1 END)
      comment: "Number of currently active funding sources. Tracks funding diversification and pipeline health."
    - name: "endowment_fund_count"
      expr: COUNT(CASE WHEN is_endowment_fund = TRUE THEN 1 END)
      comment: "Number of endowment funding sources. Tracks the breadth of long-term sustainable funding instruments."
    - name: "subaward_eligible_source_count"
      expr: COUNT(CASE WHEN subaward_allowed = TRUE THEN 1 END)
      comment: "Number of funding sources permitting sub-awards. Informs partnership programme design and pass-through funding capacity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award amendment KPI layer. Tracks amendment volumes, funding changes, budget modifications, period extensions, and approval cycles to support award change management and donor prior approval governance."
  source: "`vibe_ngo_v1`.`grant`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Draft, Pending Approval, Approved, Rejected) — primary dimension for amendment pipeline monitoring."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Budget Modification, No-Cost Extension, Scope Change) — categorises the nature of award changes."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amendment financial values — required for multi-currency amendment analysis."
    - name: "donor_prior_approval_required"
      expr: donor_prior_approval_required
      comment: "Flag indicating donor prior approval was required — tracks compliance with donor prior approval requirements."
    - name: "is_no_cost_extension"
      expr: is_no_cost_extension
      comment: "Flag indicating a no-cost extension amendment — separates period extensions from financial modifications."
    - name: "approved_by_title"
      expr: approved_by_title
      comment: "Title of the approving authority — tracks approval authority levels and delegation of authority compliance."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the amendment was approved — enables year-over-year amendment trend analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment takes effect — used for programme planning and financial period analysis."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of amendments. Baseline volume KPI for award change management workload and portfolio complexity."
    - name: "total_funding_change"
      expr: SUM(CAST(funding_change AS DOUBLE))
      comment: "Net sum of funding changes across all amendments. Tracks the cumulative financial impact of award modifications on the portfolio."
    - name: "total_budget_modification_amount"
      expr: SUM(CAST(budget_modification_summary AS DOUBLE))
      comment: "Total budget modification amounts across amendments. Measures the scale of budget restructuring activity and financial management complexity."
    - name: "total_revised_obligation"
      expr: SUM(CAST(revised_total_obligation AS DOUBLE))
      comment: "Sum of revised total obligations post-amendment. Tracks the updated financial commitment level across amended awards."
    - name: "no_cost_extension_count"
      expr: COUNT(CASE WHEN is_no_cost_extension = TRUE THEN 1 END)
      comment: "Number of no-cost extension amendments. Tracks programme timeline extensions — high counts may indicate implementation challenges."
    - name: "no_cost_extension_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_no_cost_extension = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments that are no-cost extensions. Strategic KPI for programme delivery performance — high rates signal systemic implementation delays."
    - name: "donor_prior_approval_required_count"
      expr: COUNT(CASE WHEN donor_prior_approval_required = TRUE THEN 1 END)
      comment: "Number of amendments requiring donor prior approval. Tracks compliance workload and donor relationship management burden."
    - name: "avg_approval_cycle_days"
      expr: AVG(DATEDIFF(approval_date, request_date))
      comment: "Average number of days from amendment request to approval. Measures amendment processing efficiency and identifies bottlenecks in the approval workflow."
$$;