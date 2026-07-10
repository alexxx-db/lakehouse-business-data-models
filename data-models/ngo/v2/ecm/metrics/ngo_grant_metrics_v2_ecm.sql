-- Metric views for domain: grant | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for grant awards — portfolio size, funding volume, cost-share leverage, and amendment activity. Used by grant directors and CFOs to steer portfolio allocation and donor relationship strategy."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Lifecycle status of the award (e.g. active, closed, suspended) — primary filter for portfolio health views."
    - name: "award_type"
      expr: award_type
      comment: "Classification of the award instrument (e.g. grant, cooperative agreement, contract) — drives compliance and reporting requirements."
    - name: "funding_mechanism"
      expr: funding_mechanism
      comment: "Mechanism through which funding is delivered (e.g. direct, sub-award) — used to segment portfolio by funding modality."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction classification of the award funds (restricted, unrestricted, etc.) — critical for financial planning and compliance."
    - name: "currency"
      expr: currency
      comment: "Award currency code — used to segment multi-currency portfolio analysis."
    - name: "thematic_sector"
      expr: thematic_sector
      comment: "Thematic sector of the award (e.g. health, education, WASH) — enables sector-level portfolio analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for ODA classification and donor reporting."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency at which donor reports are due — used to plan reporting workload."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Flag indicating whether cost-sharing is a condition of the award — segments awards with leverage obligations."
    - name: "audit_required"
      expr: audit_required
      comment: "Flag indicating whether an external audit is required — used for compliance planning."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the award period of performance begins — used for cohort and vintage analysis."
    - name: "end_year"
      expr: YEAR(end_date)
      comment: "Year the award period of performance ends — used to identify awards approaching closeout."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the award — enables regional portfolio segmentation."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goals the award contributes to — used for impact reporting and donor alignment."
  measures:
    - name: "total_awards"
      expr: COUNT(1)
      comment: "Total number of awards in the portfolio. Baseline volume metric for portfolio sizing and trend analysis."
    - name: "total_obligated_amount_usd"
      expr: SUM(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Total obligated funding in functional currency across all awards. Primary financial KPI for portfolio value and donor commitment tracking."
    - name: "avg_award_size_usd"
      expr: AVG(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Average obligated amount per award in functional currency. Indicates typical award scale and informs resource planning per award."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share committed across all awards. Measures leverage of donor funding with organizational or partner co-investment."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage across awards. Indicates the typical leverage ratio the organization achieves on donor funding."
    - name: "total_indirect_cost_ceiling"
      expr: SUM(CAST(indirect_cost_ceiling AS DOUBLE))
      comment: "Total indirect cost ceiling across all awards. Used by finance to assess maximum recoverable overhead and plan cost recovery strategy."
    - name: "avg_nicra_icr_rate"
      expr: AVG(CAST(nicra_icr_rate AS DOUBLE))
      comment: "Average NICRA indirect cost rate applied across awards. Benchmarks cost recovery efficiency against negotiated rates."
    - name: "awards_with_cost_share"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN 1 END)
      comment: "Number of awards requiring cost-share. Quantifies the compliance burden of co-financing obligations in the portfolio."
    - name: "awards_requiring_audit"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN 1 END)
      comment: "Number of awards requiring external audit. Drives audit planning, budget allocation, and compliance risk assessment."
    - name: "total_authorized_amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Total authorized funding amount across all awards. Compared against obligated amounts to identify funding gaps or over-authorization."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development pipeline KPIs — win rates, funding requested, and proposal conversion. Used by BD directors and leadership to evaluate pipeline health and resource investment in proposal development."
  source: "`vibe_ngo_v1`.`grant`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g. draft, submitted, awarded, rejected) — primary dimension for pipeline stage analysis."
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (e.g. unsolicited, competitive, sole-source) — segments pipeline by acquisition strategy."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final outcome of the proposal (won, lost, withdrawn) — core dimension for win-rate analysis."
    - name: "lead_technical_sector"
      expr: lead_technical_sector
      comment: "Primary technical sector of the proposal — enables sector-level win-rate and pipeline analysis."
    - name: "requested_currency"
      expr: requested_currency
      comment: "Currency in which the proposal amount is requested — used for multi-currency pipeline valuation."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the proposal was submitted — enables year-over-year pipeline trend analysis."
    - name: "go_no_go_decision"
      expr: go_no_go_decision
      comment: "Go/No-Go decision outcome — measures quality of opportunity screening and pipeline discipline."
    - name: "partnership_model"
      expr: partnership_model
      comment: "Partnership model for the proposal (prime, sub, consortium) — segments pipeline by organizational role."
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic focus of the proposal — enables regional pipeline analysis."
  measures:
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of proposals in the pipeline. Baseline volume metric for BD activity and pipeline sizing."
    - name: "total_requested_amount_usd"
      expr: SUM(CAST(requested_amount_usd AS DOUBLE))
      comment: "Total funding requested across all proposals in USD. Primary pipeline value KPI used by leadership to assess BD investment and potential revenue."
    - name: "avg_requested_amount_usd"
      expr: AVG(CAST(requested_amount_usd AS DOUBLE))
      comment: "Average proposal size in USD. Indicates typical deal size and informs BD resource allocation per opportunity."
    - name: "proposals_won"
      expr: COUNT(CASE WHEN win_loss_outcome = 'won' THEN 1 END)
      comment: "Number of proposals with a winning outcome. Numerator for win-rate calculation and BD performance tracking."
    - name: "proposals_submitted"
      expr: COUNT(CASE WHEN proposal_status = 'submitted' OR submission_date IS NOT NULL THEN 1 END)
      comment: "Number of proposals formally submitted to donors. Measures BD throughput and submission pipeline activity."
    - name: "total_cost_share_proposed"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share committed in proposals. Measures leverage offered to donors and co-financing pipeline obligations."
    - name: "avg_cost_share_percentage_proposed"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage offered in proposals. Benchmarks competitiveness of co-financing offers across the pipeline."
    - name: "proposals_with_compliance_review"
      expr: COUNT(CASE WHEN compliance_review_completed = TRUE THEN 1 END)
      comment: "Number of proposals that completed compliance review. Measures BD process quality and risk management discipline."
    - name: "total_awarded_from_proposals"
      expr: COUNT(CASE WHEN award_id IS NOT NULL THEN 1 END)
      comment: "Number of proposals that resulted in an award. Used with total_proposals to compute conversion rate at the BI layer."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award budget version and cost structure KPIs — total approved budgets, cost category breakdowns, and amendment tracking. Used by finance and grants management to monitor budget adequacy and cost allocation."
  source: "`vibe_ngo_v1`.`grant`.`award_budget`"
  dimensions:
    - name: "award_budget_status"
      expr: award_budget_status
      comment: "Approval status of the budget version (e.g. draft, approved, superseded) — primary filter for active budget analysis."
    - name: "award_currency"
      expr: award_currency
      comment: "Currency of the award budget — used for multi-currency budget analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of the budget funds — segments budgets by flexibility of use."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Flag indicating whether this budget version is an amendment — distinguishes original from revised budgets."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Flag indicating whether cost-share is required for this budget — used to segment budgets with co-financing obligations."
    - name: "period"
      expr: period
      comment: "Budget period label (e.g. Year 1, Year 2) — enables period-level budget analysis."
    - name: "period_start_year"
      expr: YEAR(period_start_date)
      comment: "Year the budget period begins — used for annual budget trend analysis."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the budget was submitted for approval — used for budget cycle analysis."
  measures:
    - name: "total_approved_budget_sum"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Total approved budget across all award budget versions. Primary financial KPI for grant portfolio budget sizing."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel costs budgeted across awards. Measures workforce cost burden and informs staffing strategy."
    - name: "total_indirect_costs"
      expr: SUM(CAST(total_indirect_costs AS DOUBLE))
      comment: "Total indirect costs budgeted. Measures overhead recovery and benchmarks against NICRA ceilings."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct costs budgeted. Primary programmatic cost measure used to assess program delivery investment."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied across budget versions. Benchmarks actual cost recovery rates against negotiated ceilings."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel costs budgeted. Monitors travel spend as a proportion of program delivery costs."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs budgeted. Used for asset planning and donor prior-approval threshold monitoring."
    - name: "total_cost_share_budgeted"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amount budgeted. Measures co-financing commitments embedded in approved budgets."
    - name: "indirect_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_indirect_costs AS DOUBLE)) / NULLIF(SUM(CAST(total_direct_costs AS DOUBLE)), 0), 2)
      comment: "Indirect cost as a percentage of direct costs. Key efficiency ratio used by finance and donors to assess overhead burden."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line-level KPIs — variance tracking, cost category analysis, and budget utilization. Used by grants finance teams to monitor spending against approved budgets and identify over/under-runs."
  source: "`vibe_ngo_v1`.`grant`.`award_budget_line`"
  dimensions:
    - name: "budget_line_status"
      expr: budget_line_status
      comment: "Status of the budget line (e.g. active, closed, revised) — primary filter for active budget line analysis."
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g. personnel, travel, equipment) — primary dimension for cost structure analysis."
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Detailed cost subcategory — enables granular cost breakdown analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of the budget line funds — segments lines by flexibility of use."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — enables annual budget analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget line — enables period-level budget monitoring."
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor-defined reporting category for the budget line — used for donor financial report preparation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line — used for multi-currency budget analysis."
    - name: "allocability_flag"
      expr: allocability_flag
      comment: "Flag indicating whether the cost is allocable to the award — used for compliance and audit analysis."
    - name: "allowability_flag"
      expr: allowability_flag
      comment: "Flag indicating whether the cost is allowable under donor rules — critical for compliance monitoring."
  measures:
    - name: "total_approved_amount_usd"
      expr: SUM(CAST(approved_amount_usd AS DOUBLE))
      comment: "Total approved budget amount in USD across all budget lines. Primary budget baseline for variance and utilization analysis."
    - name: "total_cumulative_expenditure_usd"
      expr: SUM(CAST(cumulative_expenditure_usd AS DOUBLE))
      comment: "Total cumulative expenditure in USD across budget lines. Measures actual spending against approved budget."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (approved minus expended) across lines. Negative values indicate over-runs requiring donor prior approval."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across lines. Indicates overall budget execution accuracy and financial management quality."
    - name: "total_revised_amount_usd"
      expr: SUM(CAST(revised_amount_usd AS DOUBLE))
      comment: "Total revised budget amount in USD. Compared against approved amounts to quantify scope of budget modifications."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs charged across budget lines. Used to verify compliance with NICRA ceilings at line level."
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(cumulative_expenditure_usd AS DOUBLE)) / NULLIF(SUM(CAST(approved_amount_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget expended. Core financial management KPI — low rates signal under-spending risk; high rates signal over-run risk."
    - name: "non_compliant_lines"
      expr: COUNT(CASE WHEN allowability_flag = FALSE OR allocability_flag = FALSE THEN 1 END)
      comment: "Number of budget lines flagged as non-allowable or non-allocable. Drives compliance remediation and audit risk management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor reporting compliance and timeliness KPIs — submission rates, overdue reports, and financial reporting accuracy. Used by grants compliance teams and leadership to manage donor relationships and reporting obligations."
  source: "`vibe_ngo_v1`.`grant`.`donor_report`"
  dimensions:
    - name: "donor_report_status"
      expr: donor_report_status
      comment: "Current status of the donor report (e.g. draft, submitted, accepted, overdue) — primary filter for reporting pipeline management."
    - name: "donor_report_type"
      expr: donor_report_type
      comment: "Type of donor report (e.g. financial, narrative, progress) — segments reporting workload by report category."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting obligation (e.g. quarterly, annual) — used to plan reporting workload."
    - name: "is_overdue"
      expr: is_overdue
      comment: "Flag indicating whether the report is overdue — primary dimension for compliance risk monitoring."
    - name: "is_final_version"
      expr: is_final_version
      comment: "Flag indicating whether this is the final version of the report — distinguishes draft from final submissions."
    - name: "financial_currency"
      expr: financial_currency
      comment: "Currency of the financial amounts reported — used for multi-currency reporting analysis."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the report was submitted — enables year-over-year reporting compliance trend analysis."
    - name: "reporting_period_end_year"
      expr: YEAR(reporting_period_end_date)
      comment: "Year the reporting period ends — used for cohort-based reporting analysis."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Flag indicating whether the report includes a compliance certification — used for regulatory compliance monitoring."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of donor reports. Baseline volume metric for reporting workload and compliance obligation tracking."
    - name: "overdue_reports"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN 1 END)
      comment: "Number of overdue donor reports. Critical compliance KPI — high values signal donor relationship risk and potential award suspension."
    - name: "on_time_submission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overdue = FALSE AND submission_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of submitted reports delivered on time. Primary donor compliance KPI used in performance reviews and donor relationship management."
    - name: "total_financial_amount_reported_usd"
      expr: SUM(CAST(financial_amount_reported_usd AS DOUBLE))
      comment: "Total financial amount reported to donors in USD. Measures financial reporting volume and validates against award obligations."
    - name: "total_budget_variance_reported"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance reported across all donor reports. Identifies systemic over/under-spending patterns requiring management action."
    - name: "avg_budget_variance_percentage"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across reports. Benchmarks financial execution quality across the portfolio."
    - name: "reports_with_audit_findings"
      expr: COUNT(CASE WHEN audit_findings_count IS NOT NULL AND audit_findings_count != '0' THEN 1 END)
      comment: "Number of reports with audit findings. Drives audit remediation prioritization and compliance risk management."
    - name: "accepted_reports"
      expr: COUNT(CASE WHEN donor_acceptance_date IS NOT NULL THEN 1 END)
      comment: "Number of reports formally accepted by the donor. Measures reporting quality and donor satisfaction with deliverables."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant amendment KPIs — amendment volume, funding changes, and extension patterns. Used by grants management and leadership to monitor award stability, scope creep, and donor relationship complexity. SSOT owner for the amendment entity per VREQ-003."
  source: "`vibe_ngo_v1`.`grant`.`grant_amendment`"
  dimensions:
    - name: "grant_amendment_status"
      expr: grant_amendment_status
      comment: "Current status of the amendment (e.g. pending, approved, rejected) — primary filter for amendment pipeline management."
    - name: "grant_amendment_type"
      expr: grant_amendment_type
      comment: "Type of amendment (e.g. no-cost extension, budget modification, scope change) — segments amendments by nature of change."
    - name: "is_no_cost_extension"
      expr: is_no_cost_extension
      comment: "Flag indicating whether the amendment is a no-cost extension — key dimension for timeline management analysis."
    - name: "donor_prior_approval_required"
      expr: donor_prior_approval_required
      comment: "Flag indicating whether donor prior approval is required — segments amendments by compliance burden."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amendment financial changes — used for multi-currency amendment analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the amendment becomes effective — enables trend analysis of amendment activity over time."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the amendment was approved — used for approval cycle time analysis."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of grant amendments. Baseline volume metric — high amendment counts signal award instability or complex donor relationships."
    - name: "total_funding_change"
      expr: SUM(CAST(funding_change AS DOUBLE))
      comment: "Net funding change across all amendments. Measures portfolio-level funding adjustments and donor commitment evolution."
    - name: "avg_funding_change_per_amendment"
      expr: AVG(CAST(funding_change AS DOUBLE))
      comment: "Average funding change per amendment. Indicates typical scale of financial modifications and donor flexibility."
    - name: "total_revised_obligation"
      expr: SUM(CAST(revised_total_obligation AS DOUBLE))
      comment: "Total revised obligation amount across all amendments. Measures the current committed funding level after all modifications."
    - name: "no_cost_extensions"
      expr: COUNT(CASE WHEN is_no_cost_extension = TRUE THEN 1 END)
      comment: "Number of no-cost extension amendments. High counts indicate execution challenges and timeline management issues."
    - name: "amendments_requiring_donor_approval"
      expr: COUNT(CASE WHEN donor_prior_approval_required = TRUE THEN 1 END)
      comment: "Number of amendments requiring donor prior approval. Measures compliance burden and donor relationship management workload."
    - name: "avg_period_extension_days"
      expr: AVG(CAST(period_extension_days AS DOUBLE))
      comment: "Average number of days added per amendment. Measures typical timeline slippage and informs future award duration planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant closeout KPIs — financial reconciliation, compliance certification, and outstanding obligations. Used by grants management and finance to ensure clean award closures and minimize financial risk. SSOT owner for the closeout entity per VREQ-003."
  source: "`vibe_ngo_v1`.`grant`.`grant_closeout`"
  dimensions:
    - name: "grant_closeout_status"
      expr: grant_closeout_status
      comment: "Current status of the closeout process (e.g. initiated, in-progress, complete) — primary filter for closeout pipeline management."
    - name: "grant_closeout_type"
      expr: grant_closeout_type
      comment: "Type of closeout (e.g. planned, early termination) — segments closeouts by nature of award ending."
    - name: "outstanding_issues_flag"
      expr: outstanding_issues_flag
      comment: "Flag indicating unresolved issues at closeout — primary risk indicator for closeout quality."
    - name: "final_audit_status"
      expr: final_audit_status
      comment: "Status of the final audit (e.g. pending, completed, findings) — used for audit risk monitoring."
    - name: "equipment_disposition_status"
      expr: equipment_disposition_status
      comment: "Status of equipment disposition at closeout — used for asset management compliance."
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year the closeout was initiated — enables closeout cycle time trend analysis."
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the closeout was completed — used for closeout duration analysis."
  measures:
    - name: "total_closeouts"
      expr: COUNT(1)
      comment: "Total number of grant closeouts. Baseline volume metric for closeout workload planning."
    - name: "total_unliquidated_obligations"
      expr: SUM(CAST(unliquidated_obligations_amount AS DOUBLE))
      comment: "Total unliquidated obligations at closeout. Critical financial risk KPI — high values indicate funds that must be returned to donors."
    - name: "total_unobligated_balance"
      expr: SUM(CAST(unobligated_balance_amount AS DOUBLE))
      comment: "Total unobligated balance at closeout. Measures unused funding that must be returned, indicating under-execution risk."
    - name: "closeouts_with_outstanding_issues"
      expr: COUNT(CASE WHEN outstanding_issues_flag = TRUE THEN 1 END)
      comment: "Number of closeouts with unresolved issues. Drives remediation prioritization and donor relationship risk management."
    - name: "closeouts_with_audit_findings"
      expr: COUNT(CASE WHEN final_audit_status = 'findings' THEN 1 END)
      comment: "Number of closeouts with audit findings. Measures compliance quality and informs future award management practices."
    - name: "avg_unliquidated_obligations"
      expr: AVG(CAST(unliquidated_obligations_amount AS DOUBLE))
      comment: "Average unliquidated obligations per closeout. Benchmarks financial reconciliation quality across the portfolio."
    - name: "clean_closeout_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outstanding_issues_flag = FALSE AND unliquidated_obligations_amount = 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of closeouts completed without outstanding issues or unliquidated obligations. Strategic KPI for grants management quality and donor trust."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_subaward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sub-award portfolio KPIs — disbursement tracking, partner performance, and compliance monitoring. Used by grants and partnership teams to manage sub-recipient relationships and financial accountability."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of sub-award funds — used for compliance and financial management analysis."
    - name: "currency"
      expr: currency
      comment: "Currency of the sub-award — used for multi-currency portfolio analysis."
  measures:
    - name: "total_subawards"
      expr: COUNT(1)
      comment: "Total number of sub-awards. Baseline volume metric for partnership portfolio sizing."
    - name: "total_cost_share_committed"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share committed by sub-recipients. Measures partner co-financing contributions to award leverage."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_sub_award_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sub-award disbursement transaction KPIs — cash flow, liquidation, and financial compliance. Used by finance and grants teams to monitor partner payment flows and advance liquidation."
  source: "`vibe_ngo_v1`.`grant`.`sub_award_disbursement`"
  dimensions:
    - name: "sub_award_disbursement_status"
      expr: sub_award_disbursement_status
      comment: "Status of the disbursement transaction (e.g. pending, processed, liquidated) — primary filter for disbursement pipeline management."
    - name: "sub_award_disbursement_type"
      expr: sub_award_disbursement_type
      comment: "Type of disbursement (e.g. advance, reimbursement, final) — segments cash flows by payment modality."
    - name: "liquidation_status"
      expr: liquidation_status
      comment: "Status of advance liquidation — primary dimension for advance management and financial accountability."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of disbursed funds — used for compliance and financial management analysis."
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the disbursement — enables cost structure analysis of sub-award spending."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the disbursement — enables annual cash flow trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the disbursement — enables period-level cash flow monitoring."
    - name: "is_emergency_disbursement"
      expr: is_emergency_disbursement
      comment: "Flag indicating emergency disbursement — used to track exceptional payment flows."
    - name: "disbursement_year"
      expr: YEAR(sub_award_disbursement_date)
      comment: "Year of the disbursement — used for annual disbursement trend analysis."
  measures:
    - name: "total_disbursements"
      expr: COUNT(1)
      comment: "Total number of disbursement transactions. Baseline volume metric for payment processing workload."
    - name: "total_disbursed_amount_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total disbursed amount in USD. Primary cash flow KPI for sub-award financial management."
    - name: "total_liquidated_amount"
      expr: SUM(CAST(liquidated_amount AS DOUBLE))
      comment: "Total amount liquidated against advances. Measures partner accountability for advance utilization."
    - name: "total_advance_balance_outstanding"
      expr: SUM(CAST(advance_balance_outstanding AS DOUBLE))
      comment: "Total outstanding advance balance across all disbursements. Critical financial risk KPI — high balances indicate unliquidated partner advances."
    - name: "advance_liquidation_rate"
      expr: ROUND(100.0 * SUM(CAST(liquidated_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of disbursed advances that have been liquidated. Core partner accountability KPI — low rates signal financial management weaknesses."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total amount withheld from disbursements. Measures financial risk mitigation actions taken against underperforming partners."
    - name: "total_indirect_cost_disbursed"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs included in disbursements. Used to verify compliance with NICRA ceilings at transaction level."
    - name: "avg_disbursement_amount_usd"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average disbursement transaction size in USD. Benchmarks typical payment scale and informs cash flow planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_cost_share_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost-share commitment KPIs — co-financing compliance, verification rates, and variance tracking. Used by grants compliance and finance teams to ensure cost-share obligations are met and properly documented."
  source: "`vibe_ngo_v1`.`grant`.`cost_share_commitment`"
  dimensions:
    - name: "cost_share_commitment_status"
      expr: cost_share_commitment_status
      comment: "Status of the cost-share commitment (e.g. pending, verified, non-compliant) — primary filter for compliance monitoring."
    - name: "cost_share_type"
      expr: cost_share_type
      comment: "Type of cost-share (e.g. cash, in-kind, volunteer) — segments commitments by contribution modality."
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the cost-share contribution — enables cost structure analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the cost-share commitment — primary dimension for compliance risk monitoring."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating whether cost-share is a mandatory award condition — segments voluntary from required contributions."
    - name: "is_restricted_fund"
      expr: is_restricted_fund
      comment: "Flag indicating whether the cost-share source is a restricted fund — used for fund restriction compliance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost-share commitment — enables annual compliance trend analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the cost-share contribution — used for audit quality assessment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost-share commitment — used for multi-currency analysis."
  measures:
    - name: "total_commitments"
      expr: COUNT(1)
      comment: "Total number of cost-share commitments. Baseline volume metric for co-financing obligation tracking."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total cost-share amount committed. Primary KPI for co-financing portfolio value and donor leverage measurement."
    - name: "total_verified_amount"
      expr: SUM(CAST(verified_amount AS DOUBLE))
      comment: "Total cost-share amount verified and documented. Measures actual co-financing delivered versus committed."
    - name: "total_required_cost_share"
      expr: SUM(CAST(required_cost_share_amount AS DOUBLE))
      comment: "Total required cost-share amount across all commitments. Baseline for compliance gap analysis."
    - name: "cost_share_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(verified_amount AS DOUBLE)) / NULLIF(SUM(CAST(required_cost_share_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of required cost-share that has been verified. Core compliance KPI — values below 100% indicate risk of donor clawback."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between committed and required cost-share. Negative values indicate shortfalls requiring remediation."
    - name: "total_volunteer_hours"
      expr: SUM(CAST(volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours contributed as in-kind cost-share. Measures community engagement and non-cash co-financing."
    - name: "avg_required_cost_share_percentage"
      expr: AVG(CAST(required_cost_share_percentage AS DOUBLE))
      comment: "Average required cost-share percentage across commitments. Benchmarks co-financing burden across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor condition compliance KPIs — condition tracking, risk ratings, and compliance status. Used by grants compliance teams to monitor special award conditions and prevent donor relationship deterioration."
  source: "`vibe_ngo_v1`.`grant`.`donor_condition`"
  dimensions:
    - name: "donor_condition_type"
      expr: donor_condition_type
      comment: "Type of donor condition (e.g. financial, programmatic, reporting) — segments conditions by compliance domain."
    - name: "donor_condition_category"
      expr: donor_condition_category
      comment: "Category of the donor condition — enables grouping for compliance workload analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the condition — primary filter for compliance risk monitoring."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the condition — primary dimension for risk-based compliance prioritization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the condition — used to triage compliance workload."
    - name: "is_special_award_condition"
      expr: is_special_award_condition
      comment: "Flag indicating whether this is a special award condition — segments standard from exceptional compliance requirements."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency of condition monitoring — used to plan compliance oversight workload."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the condition is due — used for compliance deadline planning."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the condition — enables workload distribution analysis."
  measures:
    - name: "total_conditions"
      expr: COUNT(1)
      comment: "Total number of donor conditions. Baseline volume metric for compliance obligation tracking."
    - name: "high_risk_conditions"
      expr: COUNT(CASE WHEN risk_rating = 'high' THEN 1 END)
      comment: "Number of high-risk donor conditions. Critical compliance KPI — drives escalation and remediation prioritization."
    - name: "non_compliant_conditions"
      expr: COUNT(CASE WHEN compliance_status = 'non-compliant' THEN 1 END)
      comment: "Number of conditions in non-compliant status. Measures compliance failure rate and donor relationship risk."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of donor conditions in compliant status. Strategic KPI for grants compliance performance and donor trust management."
    - name: "special_award_conditions"
      expr: COUNT(CASE WHEN is_special_award_condition = TRUE THEN 1 END)
      comment: "Number of special award conditions. Measures exceptional compliance burden requiring dedicated management attention."
    - name: "total_financial_threshold_amount"
      expr: SUM(CAST(financial_threshold_amount AS DOUBLE))
      comment: "Total financial threshold amount across conditions. Measures the financial exposure associated with condition compliance."
    - name: "overdue_conditions"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND actual_completion_date IS NULL THEN 1 END)
      comment: "Number of conditions past their due date without completion. Drives urgent compliance remediation and donor communication."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_prior_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prior approval request KPIs — approval rates, processing times, and financial thresholds. Used by grants compliance teams to manage donor prior approval obligations and track decision outcomes."
  source: "`vibe_ngo_v1`.`grant`.`prior_approval`"
  dimensions:
    - name: "prior_approval_type"
      expr: prior_approval_type
      comment: "Type of prior approval request (e.g. budget reallocation, key personnel change) — segments requests by compliance category."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the prior approval request (e.g. pending, approved, denied) — primary filter for approval pipeline management."
    - name: "decision"
      expr: decision
      comment: "Final decision on the prior approval request (approved, denied, withdrawn) — used for approval rate analysis."
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category requiring prior approval — segments requests by type of expenditure."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating emergency prior approval — segments routine from urgent requests."
    - name: "is_retroactive"
      expr: is_retroactive
      comment: "Flag indicating retroactive prior approval — retroactive requests signal compliance process failures."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Flag indicating follow-up is required — used to track open action items."
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year the prior approval was requested — enables trend analysis of approval activity."
  measures:
    - name: "total_prior_approvals"
      expr: COUNT(1)
      comment: "Total number of prior approval requests. Baseline volume metric for compliance workload and donor engagement tracking."
    - name: "approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision = 'approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN decision IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of prior approval requests approved by donors. Measures proposal quality and donor relationship strength."
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Total amount requested across all prior approval requests. Measures financial scope of compliance-gated expenditures."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved across all prior approval requests. Measures donor-authorized expenditure scope."
    - name: "retroactive_requests"
      expr: COUNT(CASE WHEN is_retroactive = TRUE THEN 1 END)
      comment: "Number of retroactive prior approval requests. High counts indicate compliance process failures requiring corrective action."
    - name: "emergency_requests"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN 1 END)
      comment: "Number of emergency prior approval requests. Measures operational urgency and informs process improvement planning."
    - name: "denied_requests"
      expr: COUNT(CASE WHEN decision = 'denied' THEN 1 END)
      comment: "Number of denied prior approval requests. Drives analysis of denial patterns and proposal quality improvement."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_solicitation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding opportunity pipeline KPIs — opportunity identification, competitive intelligence, and go/no-go decision quality. Used by BD leadership to manage the opportunity pipeline and resource allocation for proposal development."
  source: "`vibe_ngo_v1`.`grant`.`solicitation`"
  dimensions:
    - name: "solicitation_status"
      expr: solicitation_status
      comment: "Current status of the solicitation (e.g. open, closed, awarded) — primary filter for active opportunity pipeline."
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (e.g. RFP, RFA, NOFO) — segments opportunities by acquisition instrument."
    - name: "thematic_focus_area"
      expr: thematic_focus_area
      comment: "Thematic focus area of the solicitation — enables sector-level pipeline analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for ODA alignment and donor reporting."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Flag indicating whether cost-share is required — segments opportunities by co-financing burden."
    - name: "consortium_allowed"
      expr: consortium_allowed
      comment: "Flag indicating whether consortium bids are allowed — used for partnership strategy planning."
    - name: "indirect_cost_rate_allowed"
      expr: indirect_cost_rate_allowed
      comment: "Flag indicating whether indirect cost recovery is allowed — used for financial viability assessment."
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the opportunity was identified — enables pipeline vintage analysis."
    - name: "geographic_eligibility"
      expr: geographic_eligibility
      comment: "Geographic eligibility criteria — used for regional opportunity pipeline analysis."
  measures:
    - name: "total_solicitations"
      expr: COUNT(1)
      comment: "Total number of solicitations tracked. Baseline volume metric for opportunity pipeline sizing."
    - name: "total_estimated_funding"
      expr: SUM(CAST(estimated_funding_amount AS DOUBLE))
      comment: "Total estimated funding available across all solicitations. Primary pipeline value KPI for BD strategy and resource allocation."
    - name: "avg_estimated_funding"
      expr: AVG(CAST(estimated_funding_amount AS DOUBLE))
      comment: "Average estimated funding per solicitation. Indicates typical opportunity scale and informs BD investment decisions."
    - name: "avg_indirect_cost_rate_cap"
      expr: AVG(CAST(indirect_cost_rate_cap AS DOUBLE))
      comment: "Average indirect cost rate cap across solicitations. Benchmarks cost recovery constraints in the opportunity pipeline."
    - name: "solicitations_with_cost_share"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN 1 END)
      comment: "Number of solicitations requiring cost-share. Measures co-financing burden in the opportunity pipeline."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required across solicitations. Benchmarks co-financing demands in the pipeline."
    - name: "solicitations_allowing_indirect_costs"
      expr: COUNT(CASE WHEN indirect_cost_rate_allowed = TRUE THEN 1 END)
      comment: "Number of solicitations allowing indirect cost recovery. Measures financial viability of the pipeline for cost recovery strategy."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_asset_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT asset allocation KPIs — cost allocation, depreciation, and donor approval compliance. Used by grants finance and operations teams to manage asset costs charged to awards."
  source: "`vibe_ngo_v1`.`grant`.`asset_allocation`"
  dimensions:
    - name: "asset_allocation_status"
      expr: asset_allocation_status
      comment: "Status of the asset allocation (e.g. active, disposed, expired) — primary filter for active asset allocation analysis."
    - name: "donor_approval_required"
      expr: donor_approval_required
      comment: "Flag indicating whether donor approval is required for the asset allocation — used for compliance monitoring."
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the asset allocation begins — used for annual asset cost trend analysis."
    - name: "end_year"
      expr: YEAR(end_date)
      comment: "Year the asset allocation ends — used to identify expiring allocations."
    - name: "purchase_year"
      expr: YEAR(purchase_date)
      comment: "Year the asset was purchased — used for asset vintage analysis."
  measures:
    - name: "total_cost_allocated"
      expr: SUM(CAST(cost_allocated AS DOUBLE))
      comment: "Total cost allocated to awards across all asset allocations. Measures asset cost burden on grant budgets."
    - name: "total_depreciation_allocation"
      expr: SUM(CAST(depreciation_allocation AS DOUBLE))
      comment: "Total depreciation allocated to awards. Measures non-cash asset cost recovery charged to grants."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average percentage of asset cost allocated to awards. Benchmarks asset sharing efficiency across the portfolio."
    - name: "assets_requiring_donor_approval"
      expr: COUNT(CASE WHEN donor_approval_required = TRUE THEN 1 END)
      comment: "Number of asset allocations requiring donor approval. Measures compliance burden for asset cost recovery."
    - name: "assets_with_donor_approval"
      expr: COUNT(CASE WHEN donor_approval_required = TRUE AND donor_approval_date IS NOT NULL THEN 1 END)
      comment: "Number of asset allocations with donor approval obtained. Used with assets_requiring_donor_approval to compute approval compliance rate."
$$;