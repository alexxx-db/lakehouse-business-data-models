-- Metric views for domain: grant | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the award portfolio — total obligated funding, cost-share commitments, indirect-cost ceilings, and amendment activity. Supports executive portfolio reviews, donor pipeline analysis, and compliance monitoring across the INGO grant lifecycle (SAP Grants Management, eTools, InSight)."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Lifecycle stage of the award (e.g., Active, Closed, Suspended) — primary filter for portfolio health dashboards."
    - name: "award_type"
      expr: award_type
      comment: "Classification of the award instrument (Grant, Cooperative Agreement, Contract, etc.) — drives compliance and reporting requirements."
    - name: "funding_mechanism"
      expr: funding_mechanism
      comment: "Mechanism through which funds flow (Direct, Pass-through, etc.) — relevant for FFATA and IATI reporting."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction level on award funds (Restricted, Unrestricted, Temporarily Restricted) — critical for finance and compliance teams."
    - name: "thematic_sector"
      expr: thematic_sector
      comment: "Humanitarian or development sector (WASH, Health, Protection, Food Security, etc.) — used for portfolio sector analysis."
    - name: "primary_country_code"
      expr: primary_country_code
      comment: "ISO country code of the primary implementation country — enables geographic portfolio breakdown."
    - name: "currency"
      expr: currency
      comment: "Award currency code — needed for multi-currency portfolio reconciliation."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — required for ODA/IATI reporting and donor compliance."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Donor-required reporting cadence (Monthly, Quarterly, Annual) — drives workload planning for grants teams."
    - name: "award_start_year"
      expr: YEAR(start_date)
      comment: "Year the award period of performance begins — enables cohort and vintage analysis."
    - name: "award_end_year"
      expr: YEAR(end_date)
      comment: "Year the award period of performance ends — used to identify awards approaching closeout."
    - name: "is_grantmaking_out"
      expr: is_grantmaking_out
      comment: "Flags awards where the organization is making grants outward (foundation/grantmaking-out flows) — relevant for 501(c)(3) and foundation governance."
    - name: "audit_required"
      expr: audit_required
      comment: "Whether the award requires an external audit — used to plan audit workload and compliance calendar."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN Sustainable Development Goal alignment codes — used for impact reporting and donor communications."
  measures:
    - name: "total_awards"
      expr: COUNT(1)
      comment: "Total number of awards in the portfolio. Baseline volume metric for portfolio sizing and trend analysis."
    - name: "total_obligated_amount_usd"
      expr: SUM(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Sum of all obligated award amounts in functional (USD) currency. Primary top-line funding KPI for executive portfolio reviews and board reporting."
    - name: "total_authorized_amount_usd"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Sum of all authorized award amounts. Compared against obligated amounts to identify funding gaps or over-authorization."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share contributions committed across all awards. Tracks the organization's leveraged funding and compliance with cost-share requirements."
    - name: "total_indirect_cost_ceiling"
      expr: SUM(CAST(indirect_cost_ceiling AS DOUBLE))
      comment: "Sum of indirect cost ceilings across awards. Used by finance to monitor NICRA/ICR recovery capacity and budget headroom."
    - name: "avg_obligated_amount_usd"
      expr: AVG(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Average obligated amount per award in functional currency. Benchmarks award size and informs business development targeting."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required across awards. Monitors the burden of cost-share obligations on the organization."
    - name: "avg_nicra_icr_rate"
      expr: AVG(CAST(nicra_icr_rate AS DOUBLE))
      comment: "Average NICRA indirect cost recovery rate applied across awards. Tracks ICR negotiation outcomes and recovery efficiency."
    - name: "avg_period_of_performance_months"
      expr: AVG(DATEDIFF(end_date, start_date) / 30.0)
      comment: "Average award duration in months derived from start and end dates. Informs program planning and staffing horizon."
    - name: "awards_with_amendments"
      expr: COUNT(CASE WHEN last_amendment_date IS NOT NULL THEN 1 END)
      comment: "Number of awards that have been amended at least once. High amendment rates signal scope instability or donor relationship complexity."
    - name: "cost_share_coverage_rate"
      expr: ROUND(100.0 * SUM(CAST(cost_share_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_obligated_amount_functional AS DOUBLE)), 0), 2)
      comment: "Cost-share as a percentage of total obligated funding. Measures the organization's leverage ratio — a key metric for donor negotiations and sustainability reporting."
    - name: "indirect_cost_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(indirect_cost_ceiling AS DOUBLE)) / NULLIF(SUM(CAST(total_obligated_amount_functional AS DOUBLE)), 0), 2)
      comment: "Indirect cost ceiling as a percentage of total obligated amount. Tracks ICR recovery efficiency across the portfolio — directly impacts organizational sustainability."
    - name: "audit_required_award_count"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN 1 END)
      comment: "Number of awards requiring external audit. Drives audit planning, compliance calendar, and resource allocation for the finance and compliance teams."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget health and cost-structure KPIs at the award budget level. Tracks personnel vs. direct vs. indirect cost composition, cost-share compliance, and budget version activity. Used by grants finance teams for budget monitoring and donor reporting (SAP Grants Management, ICON procurement)."
  source: "`vibe_ngo_v1`.`grant`.`award_budget`"
  dimensions:
    - name: "budget_status"
      expr: CAST(budget_status AS STRING)
      comment: "Approval and lifecycle status of the budget (Draft, Submitted, Approved, Revised) — primary filter for active budget monitoring."
    - name: "award_currency"
      expr: award_currency
      comment: "Currency in which the award budget is denominated — needed for multi-currency budget reconciliation."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type on budget funds — drives allowability and allocability compliance checks."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Flags whether this budget version is an amendment — used to track budget revision history and donor approval requirements."
    - name: "donor_approval_reference"
      expr: donor_approval_reference
      comment: "Reference number for donor budget approval — used for audit trail and compliance verification."
    - name: "budget_submission_year"
      expr: YEAR(donor_approval_date)
      comment: "Year of donor budget approval — enables annual budget cycle analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Sum of all approved award budgets. Top-line budget KPI for portfolio financial planning and donor reporting."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Sum of all direct costs across award budgets. Tracks the programmatic spend base and informs cost structure analysis."
    - name: "total_indirect_costs"
      expr: SUM(CAST(total_indirect_costs AS DOUBLE))
      comment: "Sum of all indirect costs (overhead/ICR) across award budgets. Monitors ICR recovery against NICRA rates."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Sum of personnel costs across all award budgets. Largest cost driver in most INGO awards — tracked for staffing sustainability."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Sum of travel costs across award budgets. Monitored for allowability and reasonableness under donor regulations (2 CFR 200, USAID ADS)."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Sum of equipment costs across award budgets. Requires donor prior approval above thresholds — tracked for compliance."
    - name: "total_cost_share_committed"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts committed in award budgets. Compared against required cost-share to assess compliance risk."
    - name: "indirect_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_indirect_costs AS DOUBLE)) / NULLIF(SUM(CAST(total_direct_costs AS DOUBLE)), 0), 2)
      comment: "Indirect costs as a percentage of direct costs. Key efficiency ratio — compared against NICRA rate to identify over/under-recovery."
    - name: "personnel_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(personnel_costs AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_budget AS DOUBLE)), 0), 2)
      comment: "Personnel costs as a percentage of total approved budget. Benchmarks staffing intensity and informs workforce planning."
    - name: "cost_share_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(cost_share_amount AS DOUBLE)) / NULLIF(SUM(CAST(cost_share_required AS DOUBLE)), 0), 2)
      comment: "Ratio of committed cost-share to required cost-share. Measures compliance with donor cost-share obligations — a critical audit finding risk area."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA indirect cost rate applied across award budgets. Tracks consistency of ICR application and flags deviations from negotiated rates."
    - name: "budget_amendment_count"
      expr: COUNT(CASE WHEN is_amendment = TRUE THEN 1 END)
      comment: "Number of budget versions that are amendments. High amendment counts signal scope instability or budget management challenges."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level budget execution KPIs — approved vs. revised vs. cumulative expenditure, variance analysis, and cost compliance flags. Supports grants finance monitoring, donor reporting, and audit readiness (SAP, ICON, eZHACT)."
  source: "`vibe_ngo_v1`.`grant`.`award_budget_line`"
  dimensions:
    - name: "cost_category"
      expr: CAST(cost_category AS STRING)
      comment: "Budget cost category (Personnel, Travel, Equipment, Supplies, etc.) — primary grouping for cost structure analysis."
    - name: "cost_subcategory"
      expr: CAST(cost_subcategory AS STRING)
      comment: "Detailed cost subcategory — enables granular budget monitoring and donor reporting by line type."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — enables annual budget cycle and year-over-year variance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) of the budget line — supports periodic budget monitoring and burn-rate analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type on the budget line — drives allowability compliance checks."
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor-defined reporting category for the budget line — maps internal cost categories to donor report line items."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line — needed for multi-currency budget reconciliation."
    - name: "allocability_flag"
      expr: allocability_flag
      comment: "Whether the cost is allocable to the award — compliance flag for audit and donor review."
    - name: "allowability_flag"
      expr: allowability_flag
      comment: "Whether the cost is allowable under donor regulations — critical compliance dimension."
    - name: "cost_share_required_flag"
      expr: cost_share_required_flag
      comment: "Flags budget lines with cost-share requirements — used to track cost-share compliance at line level."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code — links budget lines to the chart of accounts for financial reconciliation."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of budget line approval — used for approval cycle analysis."
  measures:
    - name: "total_approved_amount_usd"
      expr: SUM(CAST(approved_amount_usd AS DOUBLE))
      comment: "Total approved budget amount in USD across all lines. Primary budget baseline for expenditure tracking and donor reporting."
    - name: "total_revised_amount_usd"
      expr: SUM(CAST(revised_amount_usd AS DOUBLE))
      comment: "Total revised budget amount in USD. Compared against approved amount to quantify scope of budget modifications."
    - name: "total_cumulative_expenditure_usd"
      expr: SUM(CAST(cumulative_expenditure_usd AS DOUBLE))
      comment: "Total cumulative expenditure in USD across all budget lines. Core burn-rate metric for award financial management."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of budget variances (approved minus expended) across all lines. Identifies under- or over-spending requiring management action."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs charged across budget lines. Monitors ICR recovery and compliance with NICRA rate ceilings."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts recorded at budget line level. Tracks cost-share fulfillment for audit and donor compliance."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(cumulative_expenditure_usd AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount_usd AS DOUBLE)), 0), 2)
      comment: "Cumulative expenditure as a percentage of approved budget. Primary burn-rate KPI — flags under-spending (risk of fund return) or over-spending (compliance risk)."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across lines. Measures overall budget execution accuracy — high variance triggers management review."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied at budget line level. Validates consistency of ICR application across cost categories."
    - name: "non_compliant_line_count"
      expr: COUNT(CASE WHEN allowability_flag = FALSE OR allocability_flag = FALSE THEN 1 END)
      comment: "Number of budget lines flagged as non-allowable or non-allocable. Direct audit risk indicator — any non-zero value requires immediate remediation."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines. Used for cost reasonableness analysis and benchmarking against market rates."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor reporting compliance and financial performance KPIs. Tracks submission timeliness, budget variance, KPI achievement, and report status across the award portfolio. Critical for donor relationship management and compliance audits (eTools, InSight, SAP)."
  source: "`vibe_ngo_v1`.`grant`.`donor_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of donor report (Financial, Programmatic, Combined, Final) — primary classification for reporting workload analysis."
    - name: "report_status"
      expr: report_status
      comment: "Current status of the report (Draft, Submitted, Accepted, Rejected, Overdue) — primary operational filter."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Cadence of reporting requirement (Monthly, Quarterly, Annual) — used for workload forecasting."
    - name: "financial_currency"
      expr: financial_currency
      comment: "Currency of financial amounts reported — needed for multi-currency portfolio analysis."
    - name: "is_overdue"
      expr: is_overdue
      comment: "Flags reports past their due date — primary compliance risk indicator for donor relationship management."
    - name: "is_final_version"
      expr: is_final_version
      comment: "Flags final report versions — used to distinguish draft activity from completed submissions."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Whether the report includes a compliance certification — required by many institutional donors (USAID, EU, UN agencies)."
    - name: "submission_method"
      expr: submission_method
      comment: "How the report was submitted (Portal, Email, System) — used for process efficiency analysis."
    - name: "reporting_period_end_year"
      expr: YEAR(reporting_period_end_date)
      comment: "Year of the reporting period end — enables annual reporting cycle analysis."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of report submission — used for trend analysis of reporting volume and timeliness."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of donor reports. Baseline volume metric for reporting workload management."
    - name: "overdue_report_count"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN 1 END)
      comment: "Number of overdue donor reports. Critical compliance KPI — overdue reports risk donor relationship damage and award suspension."
    - name: "on_time_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overdue = FALSE AND submission_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of submitted reports delivered on time. Primary donor compliance KPI — tracked in quarterly grants management reviews."
    - name: "total_financial_amount_reported_usd"
      expr: SUM(CAST(financial_amount_reported_usd AS DOUBLE))
      comment: "Total financial amounts reported to donors in USD. Tracks cumulative financial reporting volume across the portfolio."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Sum of budget variances reported to donors. Large aggregate variances signal financial management issues requiring executive attention."
    - name: "avg_budget_variance_percentage"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across donor reports. Benchmarks financial execution accuracy — high averages trigger donor scrutiny."
    - name: "total_kpis_met"
      expr: COUNT(CASE WHEN key_performance_indicators_met IS NOT NULL THEN 1 END)
      comment: "Count of reports with KPI achievement data recorded. Proxy for programmatic performance documentation completeness."
    - name: "total_kpis_reported"
      expr: SUM(CAST(key_performance_indicators_total AS DOUBLE))
      comment: "Sum of total KPIs reported across all donor reports. Tracks the scale of programmatic commitments being reported against."
    - name: "avg_days_to_submission"
      expr: AVG(DATEDIFF(submission_date, reporting_period_end_date))
      comment: "Average days between reporting period end and submission date. Measures reporting turnaround efficiency — a key grants management performance indicator."
    - name: "compliance_certified_report_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_certification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports with compliance certification. Tracks adherence to donor certification requirements — gaps create audit findings."
    - name: "accepted_report_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN report_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(CASE WHEN submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of submitted reports accepted by donors without revision. Measures report quality and donor satisfaction — low rates signal systemic quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_subaward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subaward portfolio KPIs — obligated vs. disbursed amounts, remaining balances, risk ratings, and compliance flags. Supports partner financial oversight, FFATA/FSRS reporting, and single-audit compliance (SAP, eTools, ICON)."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type on subaward funds — drives allowability and compliance monitoring."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency from the subawardee — used for reporting workload planning."
    - name: "currency"
      expr: currency
      comment: "Currency of the subaward — needed for multi-currency portfolio reconciliation."
  measures:
    - name: "total_subawards"
      expr: COUNT(1)
      comment: "Total number of subawards in the portfolio. Baseline volume metric for partner oversight planning."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share contributions from subawardees. Tracks partner leverage and cost-share compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_sub_award_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow and liquidation KPIs for subaward disbursements. Tracks disbursement volumes, advance balances, liquidation rates, and withholding. Used by grants finance for cash management, partner oversight, and donor financial reporting (SAP, eZHACT)."
  source: "`vibe_ngo_v1`.`grant`.`sub_award_disbursement`"
  dimensions:
    - name: "disbursement_status"
      expr: disbursement_status
      comment: "Status of the disbursement (Pending, Approved, Paid, Cancelled) — primary operational filter."
    - name: "disbursement_type"
      expr: disbursement_type
      comment: "Type of disbursement (Advance, Reimbursement, Final Payment) — drives cash flow and liquidation analysis."
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Payment method (Wire Transfer, Check, Mobile Money) — used for treasury and banking operations analysis."
    - name: "liquidation_status"
      expr: liquidation_status
      comment: "Status of advance liquidation (Pending, Partial, Complete, Overdue) — critical for advance management compliance."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type on disbursed funds — drives allowability compliance."
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor reporting category for the disbursement — maps to donor financial report line items."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the disbursement — enables annual cash flow analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the disbursement — supports periodic cash flow monitoring."
    - name: "is_emergency_disbursement"
      expr: is_emergency_disbursement
      comment: "Flags emergency disbursements — used to track expedited payments and associated compliance risks."
    - name: "disbursement_year"
      expr: YEAR(disbursement_date)
      comment: "Year of disbursement — enables year-over-year cash flow trend analysis."
    - name: "disbursement_currency"
      expr: disbursement_currency
      comment: "Currency of the disbursement — needed for multi-currency cash flow reconciliation."
  measures:
    - name: "total_disbursement_amount_usd"
      expr: SUM(CAST(disbursement_amount_usd AS DOUBLE))
      comment: "Total disbursement amounts in USD. Primary cash flow KPI for subaward financial management and donor reporting."
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net disbursements (after withholding). Tracks actual cash transferred to partners."
    - name: "total_liquidated_amount"
      expr: SUM(CAST(liquidated_amount AS DOUBLE))
      comment: "Total advance amounts liquidated by partners. Measures partner financial accountability and advance management performance."
    - name: "total_advance_balance_outstanding"
      expr: SUM(CAST(advance_balance_outstanding AS DOUBLE))
      comment: "Total outstanding advance balances across subawardees. Critical risk metric — large outstanding balances signal partner financial management weaknesses."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total amounts withheld from disbursements. Tracks risk-based withholding decisions and their financial impact on partners."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs included in disbursements. Monitors ICR pass-through to subawardees against prime award ceilings."
    - name: "liquidation_rate"
      expr: ROUND(100.0 * SUM(CAST(liquidated_amount AS DOUBLE)) / NULLIF(SUM(CAST(disbursement_amount_usd AS DOUBLE)), 0), 2)
      comment: "Liquidated amount as a percentage of total disbursed. Measures advance liquidation efficiency — low rates indicate partner accountability gaps."
    - name: "avg_disbursement_amount_usd"
      expr: AVG(CAST(disbursement_amount_usd AS DOUBLE))
      comment: "Average disbursement amount in USD. Benchmarks payment size and informs cash flow forecasting."
    - name: "emergency_disbursement_count"
      expr: COUNT(CASE WHEN is_emergency_disbursement = TRUE THEN 1 END)
      comment: "Number of emergency disbursements. High counts signal operational stress or humanitarian response surge — tracked for risk management."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied to disbursements. Validates ICR consistency across subaward payments."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amendment activity and financial change KPIs. Tracks scope, budget, and timeline modifications across the award portfolio. Used by grants management to monitor award stability, donor approval requirements, and no-cost extension patterns (eTools, SAP)."
  source: "`vibe_ngo_v1`.`grant`.`grant_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (Budget Modification, No-Cost Extension, Scope Change, Key Personnel Change) — primary classification for amendment analysis."
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (Pending, Approved, Rejected, Executed) — operational filter for amendment pipeline management."
    - name: "is_no_cost_extension"
      expr: is_no_cost_extension
      comment: "Flags no-cost extensions — a key indicator of implementation delays and program management challenges."
    - name: "donor_prior_approval_required"
      expr: donor_prior_approval_required
      comment: "Whether donor prior approval is required for the amendment — drives compliance workflow and timeline planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amendment financial changes — needed for multi-currency portfolio analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment becomes effective — enables trend analysis of amendment activity by year."
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year the amendment was requested — used for amendment pipeline and processing time analysis."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of grant amendments. Baseline volume metric — high amendment counts signal portfolio instability."
    - name: "total_funding_change"
      expr: SUM(CAST(funding_change AS DOUBLE))
      comment: "Net change in funding across all amendments. Tracks portfolio-level budget modifications and their financial impact."
    - name: "total_revised_obligation"
      expr: SUM(CAST(revised_total_obligation AS DOUBLE))
      comment: "Sum of revised total obligations post-amendment. Reflects the current financial commitment of the portfolio after all modifications."
    - name: "total_original_obligation"
      expr: SUM(CAST(original_total_obligation AS DOUBLE))
      comment: "Sum of original total obligations before amendments. Baseline for measuring portfolio scope change."
    - name: "net_obligation_change"
      expr: SUM(CAST(revised_total_obligation AS DOUBLE) - CAST(original_total_obligation AS DOUBLE))
      comment: "Net change in total obligations due to amendments. Measures the aggregate financial impact of portfolio modifications."
    - name: "no_cost_extension_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_no_cost_extension = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments that are no-cost extensions. High rates indicate systemic implementation delays — a key program management performance indicator."
    - name: "donor_prior_approval_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN donor_prior_approval_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amendments requiring donor prior approval. Measures compliance burden and donor relationship complexity."
    - name: "avg_period_extension_days"
      expr: AVG(CAST(period_extension_days AS DOUBLE))
      comment: "Average number of days added to award periods through amendments. Quantifies implementation delay patterns across the portfolio."
    - name: "avg_days_to_approval"
      expr: AVG(DATEDIFF(approval_date, request_date))
      comment: "Average days from amendment request to approval. Measures amendment processing efficiency — long cycles delay program implementation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development pipeline KPIs — win rates, requested amounts, proposal volume, and go/no-go decision patterns. Used by business development and senior leadership to manage the funding pipeline and resource allocation (Salesforce NPSP, eTools, InSight)."
  source: "`vibe_ngo_v1`.`grant`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (In Development, Submitted, Won, Lost, Withdrawn) — primary pipeline stage dimension."
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (Concept Note, Full Application, Unsolicited, etc.) — used for pipeline composition analysis."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final outcome of the proposal (Won, Lost, No Decision) — primary dimension for win-rate analysis."
    - name: "go_no_go_decision"
      expr: go_no_go_decision
      comment: "Go/No-Go decision made for the proposal — tracks pipeline qualification discipline."
    - name: "lead_technical_sector"
      expr: lead_technical_sector
      comment: "Primary technical sector of the proposal (Health, WASH, Protection, etc.) — enables sector-level pipeline analysis."
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic focus area of the proposal — used for country/regional pipeline analysis."
    - name: "requested_currency"
      expr: requested_currency
      comment: "Currency of the requested amount — needed for multi-currency pipeline valuation."
    - name: "partnership_model"
      expr: partnership_model
      comment: "Partnership model (Lead, Consortium Member, Sub-recipient) — tracks organizational positioning in competitive bids."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of proposal submission — enables annual pipeline trend analysis."
    - name: "compliance_review_completed"
      expr: compliance_review_completed
      comment: "Whether compliance review was completed before submission — tracks proposal quality control discipline."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals in the pipeline. Baseline volume metric for business development activity tracking."
    - name: "total_requested_amount_usd"
      expr: SUM(CAST(requested_amount_usd AS DOUBLE))
      comment: "Total funding requested across all proposals in USD. Primary pipeline value KPI for business development reporting to leadership."
    - name: "total_won_amount_usd"
      expr: SUM(CASE WHEN win_loss_outcome = 'Won' THEN requested_amount_usd ELSE 0 END)
      comment: "Total funding won through successful proposals in USD. Measures business development revenue generation — a core organizational sustainability KPI."
    - name: "win_rate_by_count"
      expr: ROUND(100.0 * COUNT(CASE WHEN win_loss_outcome = 'Won' THEN 1 END) / NULLIF(COUNT(CASE WHEN win_loss_outcome IN ('Won', 'Lost') THEN 1 END), 0), 2)
      comment: "Percentage of decided proposals that were won. Primary business development performance KPI — tracked in quarterly BD reviews."
    - name: "win_rate_by_value"
      expr: ROUND(100.0 * SUM(CASE WHEN win_loss_outcome = 'Won' THEN requested_amount_usd ELSE 0 END) / NULLIF(SUM(CASE WHEN win_loss_outcome IN ('Won', 'Lost') THEN requested_amount_usd ELSE 0 END), 0), 2)
      comment: "Value of won proposals as a percentage of total decided proposal value. Measures funding capture efficiency — high-value win rate is more strategically important than count-based win rate."
    - name: "avg_requested_amount_usd"
      expr: AVG(CAST(requested_amount_usd AS DOUBLE))
      comment: "Average requested amount per proposal in USD. Benchmarks proposal size and informs BD targeting strategy."
    - name: "avg_proposed_duration_months"
      expr: AVG(CAST(proposed_duration_months AS DOUBLE))
      comment: "Average proposed program duration in months. Informs staffing and implementation planning for the pipeline."
    - name: "go_decision_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN go_no_go_decision = 'Go' THEN 1 END) / NULLIF(COUNT(CASE WHEN go_no_go_decision IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of opportunities where a Go decision was made. Measures BD pipeline qualification discipline — very high rates may indicate insufficient selectivity."
    - name: "compliance_review_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_review_completed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of submitted proposals with completed compliance review. Tracks proposal quality control — gaps create post-award compliance risks."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage proposed. Monitors the cost-share burden being committed in the pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_cost_share_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost-share compliance and verification KPIs. Tracks committed vs. required vs. verified cost-share amounts, compliance status, and variance. Critical for donor audits and 2 CFR 200 compliance (SAP, eZHACT)."
  source: "`vibe_ngo_v1`.`grant`.`cost_share_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Status of the cost-share commitment (Pending, Verified, Rejected, Waived) — primary compliance monitoring dimension."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the cost-share commitment — flags non-compliant commitments for remediation."
    - name: "cost_share_type"
      expr: CAST(cost_share_type AS STRING)
      comment: "Type of cost-share (Cash, In-Kind, Third-Party) — drives valuation methodology and audit requirements."
    - name: "in_kind_valuation_method"
      expr: in_kind_valuation_method
      comment: "Method used to value in-kind contributions — required for audit documentation and donor compliance."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the cost-share is a mandatory donor requirement — mandatory commitments carry higher compliance risk."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Whether the cost-share source is a restricted fund — affects allowability and accounting treatment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost-share commitment — needed for multi-currency compliance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost-share commitment — enables annual compliance tracking."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the cost-share (Audit, Self-Certification, Third-Party Review) — tracks verification rigor."
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total cost-share amounts committed. Primary cost-share portfolio KPI for donor compliance reporting."
    - name: "total_required_cost_share_amount"
      expr: SUM(CAST(required_cost_share_amount AS DOUBLE))
      comment: "Total cost-share amounts required by donors. Baseline for measuring compliance gap."
    - name: "total_verified_amount"
      expr: SUM(CAST(verified_amount AS DOUBLE))
      comment: "Total cost-share amounts verified through audit or review. Measures the portion of commitments with documented evidence."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of variances between committed and required cost-share. Identifies compliance gaps requiring remediation."
    - name: "cost_share_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(committed_amount AS DOUBLE)) / NULLIF(SUM(CAST(required_cost_share_amount AS DOUBLE)), 0), 2)
      comment: "Committed cost-share as a percentage of required cost-share. Primary compliance KPI — below 100% triggers donor audit findings."
    - name: "cost_share_verification_rate"
      expr: ROUND(100.0 * SUM(CAST(verified_amount AS DOUBLE)) / NULLIF(SUM(CAST(committed_amount AS DOUBLE)), 0), 2)
      comment: "Verified cost-share as a percentage of committed cost-share. Measures documentation quality — low rates create audit risk."
    - name: "avg_required_cost_share_percentage"
      expr: AVG(CAST(required_cost_share_percentage AS DOUBLE))
      comment: "Average required cost-share percentage across commitments. Benchmarks the cost-share burden across the portfolio."
    - name: "non_compliant_commitment_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('Compliant', 'Verified') THEN 1 END)
      comment: "Number of cost-share commitments with non-compliant status. Direct audit risk indicator requiring immediate management attention."
    - name: "volunteer_hours_total"
      expr: SUM(CAST(volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours recorded as in-kind cost-share. Tracks the scale of volunteer labor contributions to cost-share compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award closeout completion and financial risk KPIs. Tracks unliquidated obligations, unobligated balances, audit status, and closeout timeliness. Used by grants management and finance for closeout planning and donor compliance (SAP, eTools)."
  source: "`vibe_ngo_v1`.`grant`.`grant_closeout`"
  dimensions:
    - name: "closeout_status"
      expr: closeout_status
      comment: "Current status of the closeout process (Initiated, In Progress, Complete, Overdue) — primary operational filter."
    - name: "closeout_type"
      expr: closeout_type
      comment: "Type of closeout (Planned, Early Termination, Mutual Agreement) — drives closeout process requirements."
    - name: "final_audit_status"
      expr: final_audit_status
      comment: "Status of the final audit (Not Required, Pending, In Progress, Complete, Finding) — critical compliance dimension."
    - name: "equipment_disposition_status"
      expr: equipment_disposition_status
      comment: "Status of equipment disposition at closeout — required for donor compliance and asset management."
    - name: "outstanding_issues_flag"
      expr: outstanding_issues_flag
      comment: "Flags closeouts with unresolved issues — primary risk indicator for closeout management."
    - name: "closeout_year"
      expr: YEAR(completion_date)
      comment: "Year of closeout completion — enables annual closeout volume and trend analysis."
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year closeout was initiated — used for closeout cycle time analysis."
  measures:
    - name: "total_closeouts"
      expr: COUNT(1)
      comment: "Total number of award closeouts. Baseline volume metric for closeout workload planning."
    - name: "total_unliquidated_obligations"
      expr: SUM(CAST(unliquidated_obligations_amount AS DOUBLE))
      comment: "Total unliquidated obligations at closeout. Critical financial risk KPI — must be resolved before final closeout to avoid donor findings."
    - name: "total_unobligated_balance"
      expr: SUM(CAST(unobligated_balance_amount AS DOUBLE))
      comment: "Total unobligated balances to be returned to donors. Tracks fund return obligations and their financial impact."
    - name: "closeouts_with_outstanding_issues"
      expr: COUNT(CASE WHEN outstanding_issues_flag = TRUE THEN 1 END)
      comment: "Number of closeouts with unresolved outstanding issues. Measures closeout quality and compliance risk — each outstanding issue is a potential audit finding."
    - name: "avg_closeout_cycle_days"
      expr: AVG(DATEDIFF(completion_date, initiation_date))
      comment: "Average days from closeout initiation to completion. Measures closeout process efficiency — long cycles increase compliance risk and resource burden."
    - name: "final_audit_finding_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN final_audit_status = 'Finding' THEN 1 END) / NULLIF(COUNT(CASE WHEN final_audit_status IS NOT NULL AND final_audit_status != 'Not Required' THEN 1 END), 0), 2)
      comment: "Percentage of completed audits that resulted in findings. Measures audit quality and compliance program effectiveness — high rates signal systemic issues."
    - name: "on_time_final_report_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN final_financial_report_submission_date <= final_financial_report_due_date THEN 1 END) / NULLIF(COUNT(CASE WHEN final_financial_report_submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of final financial reports submitted on time. Measures closeout compliance — late final reports are a leading cause of donor relationship damage."
    - name: "avg_unliquidated_obligations"
      expr: AVG(CAST(unliquidated_obligations_amount AS DOUBLE))
      comment: "Average unliquidated obligations per closeout. Benchmarks financial resolution complexity and informs closeout resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_prior_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor prior approval request KPIs — approval rates, processing times, emergency requests, and financial thresholds. Used by grants compliance teams to manage donor approval workflows and track regulatory compliance (eTools, SAP)."
  source: "`vibe_ngo_v1`.`grant`.`prior_approval`"
  dimensions:
    - name: "approval_type"
      expr: approval_type
      comment: "Type of prior approval required (Budget Reallocation, Key Personnel Change, Equipment Purchase, etc.) — primary classification for compliance analysis."
    - name: "approval_subtype"
      expr: approval_subtype
      comment: "Detailed subtype of the prior approval request — enables granular compliance tracking."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the prior approval request (Pending, Submitted, Approved, Denied, Withdrawn) — primary operational filter."
    - name: "approval_decision"
      expr: approval_decision
      comment: "Final decision on the prior approval (Approved, Denied, Approved with Conditions) — used for approval rate analysis."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flags emergency prior approval requests — tracks expedited approval needs and associated compliance risks."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Flags retroactive prior approval requests — retroactive approvals are a compliance red flag requiring management attention."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up action is required after the approval decision — used for compliance action tracking."
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year of the prior approval request — enables annual trend analysis of approval activity."
  measures:
    - name: "total_prior_approval_requests"
      expr: COUNT(1)
      comment: "Total number of prior approval requests. Baseline volume metric for compliance workload planning."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_decision = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN approval_decision IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of decided prior approval requests that were approved. Measures donor relationship quality and request preparation effectiveness."
    - name: "retroactive_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_retroactive = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prior approval requests that are retroactive. High rates indicate compliance process failures — retroactive approvals are a significant audit risk."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total financial amounts approved through prior approval requests. Tracks the financial scale of donor-approved modifications."
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total financial amounts requested through prior approvals. Compared against approved amounts to measure approval efficiency."
    - name: "avg_days_to_response"
      expr: AVG(DATEDIFF(response_date, request_date))
      comment: "Average days from request submission to donor response. Measures donor responsiveness and informs timeline planning for program modifications."
    - name: "overdue_response_count"
      expr: COUNT(CASE WHEN response_date > response_due_date THEN 1 END)
      comment: "Number of prior approval requests where donor response exceeded the due date. Tracks donor responsiveness issues that delay program implementation."
    - name: "emergency_request_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN 1 END)
      comment: "Number of emergency prior approval requests. High counts signal operational stress or inadequate advance planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_solicitation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding opportunity pipeline KPIs — opportunity volume, estimated funding, competitive intelligence, and go/no-go decision patterns. Used by business development teams to manage the opportunity pipeline and prioritize resource allocation (Salesforce NPSP, InSight)."
  source: "`vibe_ngo_v1`.`grant`.`solicitation`"
  dimensions:
    - name: "solicitation_status"
      expr: solicitation_status
      comment: "Current status of the solicitation (Identified, Active, Closed, Awarded, Cancelled) — primary pipeline stage dimension."
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (RFA, RFP, NOFO, Unsolicited, etc.) — drives proposal strategy and compliance requirements."
    - name: "thematic_focus_area"
      expr: thematic_focus_area
      comment: "Thematic focus area of the solicitation (Health, WASH, Protection, etc.) — enables sector-level opportunity analysis."
    - name: "geographic_eligibility"
      expr: geographic_eligibility
      comment: "Geographic eligibility for the solicitation — used for country/regional opportunity pipeline analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for ODA alignment and portfolio sector analysis."
    - name: "submission_method"
      expr: submission_method
      comment: "Required submission method (Online Portal, Email, Physical) — used for proposal preparation planning."
    - name: "consortium_allowed"
      expr: consortium_allowed
      comment: "Whether consortium applications are allowed — drives partnership strategy decisions."
    - name: "funding_currency"
      expr: funding_currency
      comment: "Currency of the solicitation funding — needed for multi-currency pipeline valuation."
    - name: "publication_year"
      expr: YEAR(publication_date)
      comment: "Year the solicitation was published — enables annual opportunity pipeline trend analysis."
  measures:
    - name: "total_solicitations"
      expr: COUNT(1)
      comment: "Total number of solicitations tracked. Baseline volume metric for opportunity pipeline management."
    - name: "total_estimated_funding"
      expr: SUM(CAST(estimated_funding_amount AS DOUBLE))
      comment: "Total estimated funding available across all tracked solicitations. Primary pipeline value KPI for business development strategy and resource allocation."
    - name: "avg_estimated_funding"
      expr: AVG(CAST(estimated_funding_amount AS DOUBLE))
      comment: "Average estimated funding per solicitation. Benchmarks opportunity size and informs BD targeting strategy."
    - name: "avg_program_duration_months"
      expr: AVG(CAST(program_duration_months AS DOUBLE))
      comment: "Average program duration of solicitations in months. Informs staffing and implementation planning for the opportunity pipeline."
    - name: "avg_internal_priority_score"
      expr: AVG(CAST(internal_priority_score AS DOUBLE))
      comment: "Average internal priority score assigned to solicitations. Measures pipeline quality and BD team selectivity."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required across solicitations. Monitors the cost-share burden in the opportunity pipeline."
    - name: "high_priority_solicitation_count"
      expr: COUNT(CASE WHEN internal_priority_score >= 7.0 THEN 1 END)
      comment: "Number of solicitations with high internal priority scores. Tracks the volume of high-value opportunities requiring BD resource investment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor condition compliance KPIs — condition status, overdue conditions, financial thresholds, and risk ratings. Used by grants compliance teams to monitor award conditions and prevent compliance failures (eTools, SAP)."
  source: "`vibe_ngo_v1`.`grant`.`donor_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of donor condition (Reporting, Financial, Programmatic, Legal) — primary classification for compliance monitoring."
    - name: "condition_category"
      expr: condition_category
      comment: "Category of the condition — enables grouping for compliance dashboard analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (Compliant, Non-Compliant, Pending, Waived) — primary risk filter."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the condition (Low, Medium, High, Critical) — drives escalation and monitoring intensity."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the condition — used for workload prioritization."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for condition compliance — enables accountability tracking."
    - name: "is_special_award_condition"
      expr: is_special_award_condition
      comment: "Flags special award conditions (SACs) — SACs carry higher compliance risk and require enhanced monitoring."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Required monitoring frequency for the condition — used for compliance calendar planning."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the condition is due — enables annual compliance workload planning."
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total number of donor conditions tracked. Baseline compliance workload metric."
    - name: "non_compliant_condition_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of conditions with non-compliant status. Critical risk KPI — each non-compliant condition is a potential award suspension trigger."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conditions in compliant status. Primary compliance program performance KPI — tracked in board and donor reporting."
    - name: "high_risk_condition_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Number of conditions rated high or critical risk. Drives escalation to senior management and enhanced monitoring."
    - name: "special_award_condition_count"
      expr: COUNT(CASE WHEN is_special_award_condition = TRUE THEN 1 END)
      comment: "Number of special award conditions (SACs). SACs require donor prior approval for any deviation — tracking volume informs compliance resource planning."
    - name: "total_financial_threshold_amount"
      expr: SUM(CAST(financial_threshold_amount AS DOUBLE))
      comment: "Sum of financial thresholds associated with donor conditions. Quantifies the financial exposure of condition non-compliance."
    - name: "overdue_condition_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND actual_completion_date IS NULL THEN 1 END)
      comment: "Number of conditions past their due date without completion. Real-time compliance risk indicator requiring immediate management action."
    - name: "avg_days_to_completion"
      expr: AVG(DATEDIFF(actual_completion_date, created_timestamp))
      comment: "Average days from condition creation to completion. Measures compliance process efficiency and team responsiveness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_asset_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT asset allocation KPIs for grant-funded equipment. Tracks allocated costs, depreciation, donor approval requirements, and allocation percentages. Used by grants finance and compliance teams for equipment management and donor reporting (SAP Asset Management)."
  source: "`vibe_ngo_v1`.`grant`.`asset_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the asset allocation (Active, Disposed, Transferred, Expired) — primary filter for active asset monitoring."
    - name: "donor_approval_required"
      expr: donor_approval_required
      comment: "Whether donor approval is required for the asset allocation — flags compliance obligations for equipment purchases."
    - name: "allocation_start_year"
      expr: YEAR(allocation_start_date)
      comment: "Year the asset allocation begins — enables annual asset portfolio analysis."
    - name: "purchase_year"
      expr: YEAR(purchase_date)
      comment: "Year the asset was purchased — used for asset age and depreciation analysis."
  measures:
    - name: "total_cost_allocated"
      expr: SUM(CAST(cost_allocated AS DOUBLE))
      comment: "Total cost allocated to awards for IT assets. Tracks the financial scale of grant-funded equipment and donor reporting obligations."
    - name: "total_depreciation_allocation"
      expr: SUM(CAST(depreciation_allocation AS DOUBLE))
      comment: "Total depreciation allocated to awards. Monitors depreciation cost recovery and compliance with donor equipment policies."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average percentage of asset cost allocated to awards. Benchmarks asset utilization and informs cost allocation methodology reviews."
    - name: "donor_approval_required_count"
      expr: COUNT(CASE WHEN donor_approval_required = TRUE THEN 1 END)
      comment: "Number of asset allocations requiring donor approval. Tracks compliance obligations for equipment purchases above donor thresholds."
    - name: "total_assets_allocated"
      expr: COUNT(1)
      comment: "Total number of asset allocations. Baseline metric for grant-funded equipment portfolio sizing."
$$;