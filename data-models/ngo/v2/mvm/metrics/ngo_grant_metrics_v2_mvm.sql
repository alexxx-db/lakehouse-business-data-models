-- Metric views for domain: grant | Business: Ngo | Version: 2 | Generated on: 2026-07-10 20:18:10

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for grant awards — tracks portfolio size, funding obligations, cost-share commitments, and award lifecycle health for executive portfolio oversight."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Current lifecycle status of the award (e.g. Active, Closed, Suspended) — primary filter for portfolio health dashboards."
    - name: "award_type"
      expr: award_type
      comment: "Instrument type of the award (e.g. Grant, Cooperative Agreement, Contract) — drives compliance and reporting obligations."
    - name: "thematic_sector"
      expr: thematic_sector
      comment: "Thematic sector alignment (e.g. Health, Education, WASH) — used for portfolio allocation analysis."
    - name: "currency"
      expr: currency
      comment: "Award currency code — needed for multi-currency portfolio analysis."
    - name: "functional_currency"
      expr: functional_currency
      comment: "Functional reporting currency for the award — used for consolidated financial reporting."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the award — supports regional portfolio breakdown."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — required for ODA/donor regulatory reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goal alignment tag — used for impact and strategic alignment reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment mechanism (e.g. Reimbursement, Advance) — affects cash-flow planning."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Donor-required reporting cadence — drives compliance workload planning."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Applicable regulatory framework (e.g. 2 CFR 200, FCDO Smart Rules) — determines compliance requirements."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Boolean flag indicating whether cost-share is a condition of the award."
    - name: "audit_required"
      expr: audit_required
      comment: "Boolean flag indicating whether an audit is required — used for audit planning and risk management."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Award start month — used for cohort and pipeline timing analysis."
    - name: "end_date_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Award end month — used for closeout planning and pipeline expiry analysis."
    - name: "agreement_signed_year"
      expr: YEAR(agreement_signed_date)
      comment: "Year the award agreement was signed — used for vintage/cohort analysis of the portfolio."
  measures:
    - name: "active_award_count"
      expr: COUNT(CASE WHEN award_status = 'Active' THEN award_id END)
      comment: "Number of currently active awards — primary portfolio size KPI for executive dashboards."
    - name: "total_obligated_amount_usd"
      expr: SUM(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Total obligated funding in functional currency across all awards — primary portfolio value KPI."
    - name: "avg_award_obligated_amount_usd"
      expr: AVG(CAST(total_obligated_amount_functional AS DOUBLE))
      comment: "Average obligated amount per award in functional currency — indicates typical award size for benchmarking."
    - name: "total_authorized_amount"
      expr: SUM(CAST(authorized_amount AS DOUBLE))
      comment: "Total authorized funding ceiling across all awards — measures maximum funding envelope available."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share committed across all awards — tracks organizational co-investment obligations to donors."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage across awards — indicates organizational leverage and donor partnership intensity."
    - name: "total_indirect_cost_ceiling"
      expr: SUM(CAST(indirect_cost_ceiling AS DOUBLE))
      comment: "Total indirect cost ceiling across all awards — critical for overhead recovery planning."
    - name: "avg_nicra_icr_rate"
      expr: AVG(CAST(nicra_icr_rate AS DOUBLE))
      comment: "Average NICRA/ICR indirect cost rate applied across awards — used to assess overhead recovery efficiency."
    - name: "awards_requiring_audit_count"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN award_id END)
      comment: "Number of awards requiring an audit — drives audit planning, resource allocation, and compliance risk management."
    - name: "awards_with_cost_share_count"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN award_id END)
      comment: "Number of awards with mandatory cost-share — tracks co-financing obligation exposure across the portfolio."
    - name: "total_audit_threshold_amount"
      expr: SUM(CAST(audit_threshold_amount AS DOUBLE))
      comment: "Sum of audit threshold amounts across awards — used to assess aggregate audit risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development pipeline KPIs — tracks proposal win rates, funding requested, cost-share proposed, and pipeline conversion for strategic resource allocation decisions."
  source: "`vibe_ngo_v1`.`grant`.`proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g. Draft, Submitted, Won, Lost) — primary pipeline stage dimension."
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of proposal (e.g. Unsolicited, Competitive, Sole Source) — affects win-rate benchmarking."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final win/loss outcome of the proposal — core dimension for conversion rate analysis."
    - name: "go_no_go_decision"
      expr: go_no_go_decision
      comment: "Go/No-Go decision outcome — used to assess pipeline qualification rigor."
    - name: "lead_technical_sector"
      expr: lead_technical_sector
      comment: "Primary technical sector of the proposal — used for sector-level win-rate and pipeline analysis."
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic focus of the proposal — supports regional pipeline and win-rate analysis."
    - name: "partnership_model"
      expr: partnership_model
      comment: "Partnership model (e.g. Prime, Sub, Consortium) — affects competitive positioning analysis."
    - name: "requested_currency"
      expr: requested_currency
      comment: "Currency of the requested funding amount — needed for multi-currency pipeline valuation."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the proposal was submitted — used for year-over-year pipeline trend analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the proposal was submitted — used for monthly pipeline volume and seasonality analysis."
    - name: "compliance_review_completed"
      expr: compliance_review_completed
      comment: "Boolean flag indicating whether compliance review was completed before submission."
  measures:
    - name: "total_proposals_submitted"
      expr: COUNT(CASE WHEN proposal_status = 'Submitted' THEN proposal_id END)
      comment: "Total number of proposals submitted — primary business development pipeline volume KPI."
    - name: "total_proposals_won"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Won' THEN proposal_id END)
      comment: "Total number of proposals won — measures business development success and revenue generation."
    - name: "total_proposals_lost"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Lost' THEN proposal_id END)
      comment: "Total number of proposals lost — used to calculate win rate and identify competitive gaps."
    - name: "total_requested_amount_usd"
      expr: SUM(CAST(requested_amount_usd AS DOUBLE))
      comment: "Total funding requested across all proposals in USD — measures the gross pipeline value."
    - name: "avg_requested_amount_usd"
      expr: AVG(CAST(requested_amount_usd AS DOUBLE))
      comment: "Average requested amount per proposal in USD — indicates typical deal size for resource planning."
    - name: "total_won_requested_amount_usd"
      expr: SUM(CASE WHEN win_loss_outcome = 'Won' THEN CAST(requested_amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total USD value of won proposals — measures actual funding secured through business development."
    - name: "total_cost_share_proposed_usd"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amount proposed across all proposals — tracks organizational co-investment commitments in the pipeline."
    - name: "avg_indirect_cost_rate_proposed"
      expr: AVG(CAST(indirect_cost_rate_proposed AS DOUBLE))
      comment: "Average indirect cost rate proposed — used to assess overhead recovery strategy across the pipeline."
    - name: "proposals_with_compliance_review_count"
      expr: COUNT(CASE WHEN compliance_review_completed = TRUE THEN proposal_id END)
      comment: "Number of proposals with completed compliance review — measures process adherence and submission quality."
    - name: "distinct_funding_sources_targeted"
      expr: COUNT(DISTINCT funding_source_id)
      comment: "Number of distinct funding sources targeted in proposals — measures donor diversification in the pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Award budget performance KPIs — tracks approved budget composition, cost structure, indirect cost recovery, and budget version management for financial stewardship decisions."
  source: "`vibe_ngo_v1`.`grant`.`award_budget`"
  dimensions:
    - name: "award_budget_status"
      expr: award_budget_status
      comment: "Current status of the budget (e.g. Draft, Approved, Superseded) — primary filter for active budget analysis."
    - name: "award_currency"
      expr: award_currency
      comment: "Currency of the award budget — needed for multi-currency budget analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Type of fund restriction (e.g. Restricted, Unrestricted) — affects budget flexibility and reallocation decisions."
    - name: "indirect_cost_base"
      expr: indirect_cost_base
      comment: "Base used for indirect cost calculation (e.g. MTDC, TDC) — affects overhead recovery analysis."
    - name: "is_amendment"
      expr: is_amendment
      comment: "Boolean flag indicating whether this budget is associated with an amendment — used to track budget revision frequency."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Boolean flag indicating whether cost-share is required for this budget."
    - name: "period"
      expr: period
      comment: "Budget period label — used for period-over-period budget comparison."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Budget period start month — used for time-series budget analysis."
    - name: "period_end_month"
      expr: DATE_TRUNC('MONTH', period_end_date)
      comment: "Budget period end month — used for budget expiry and closeout planning."
    - name: "donor_approval_year"
      expr: YEAR(donor_approval_date)
      comment: "Year of donor budget approval — used for approval cycle time analysis."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Total approved budget across all award budgets — primary financial envelope KPI for portfolio oversight."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct costs budgeted — measures programmatic spend capacity."
    - name: "total_indirect_costs"
      expr: SUM(CAST(total_indirect_costs AS DOUBLE))
      comment: "Total indirect costs budgeted — measures overhead recovery across the portfolio."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel costs budgeted — largest cost driver; critical for workforce planning and cost structure analysis."
    - name: "total_contractual_costs"
      expr: SUM(CAST(contractual_costs AS DOUBLE))
      comment: "Total contractual/subaward costs budgeted — measures partnership and subcontracting financial exposure."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel costs budgeted — used for operational efficiency and cost reduction analysis."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs budgeted — used for asset planning and donor prior-approval tracking."
    - name: "total_supplies_costs"
      expr: SUM(CAST(supplies_costs AS DOUBLE))
      comment: "Total supplies costs budgeted — used for procurement planning and cost structure analysis."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied across budgets — used to assess consistency of overhead recovery rate application."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amount budgeted — tracks organizational co-financing obligations across the portfolio."
    - name: "amendment_budget_count"
      expr: COUNT(CASE WHEN is_amendment = TRUE THEN award_budget_id END)
      comment: "Number of budgets associated with amendments — indicates portfolio instability and scope change frequency."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_award_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget line-level execution KPIs — tracks approved vs. revised amounts, expenditure variance, cost compliance flags, and burn rate at the most granular financial level for operational financial management."
  source: "`vibe_ngo_v1`.`grant`.`award_budget_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g. Personnel, Travel, Equipment) — primary dimension for cost structure analysis."
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Detailed cost subcategory — enables granular cost analysis within each category."
    - name: "budget_line_status"
      expr: budget_line_status
      comment: "Current status of the budget line (e.g. Active, Closed, Pending) — used to filter active spend analysis."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Fund restriction type for the budget line — affects allowability and reallocation decisions."
    - name: "donor_reporting_category"
      expr: donor_reporting_category
      comment: "Donor-defined reporting category — used for donor financial report preparation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — used for annual budget vs. actuals analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget line — used for period-level burn rate and variance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line — needed for multi-currency financial analysis."
    - name: "allocability_flag"
      expr: allocability_flag
      comment: "Boolean flag indicating whether the cost is allocable to the award — used for compliance monitoring."
    - name: "allowability_flag"
      expr: allowability_flag
      comment: "Boolean flag indicating whether the cost is allowable under donor rules — critical compliance dimension."
    - name: "reasonableness_flag"
      expr: reasonableness_flag
      comment: "Boolean flag indicating whether the cost is deemed reasonable — used for cost compliance audits."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code — links budget lines to the financial accounting system."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the budget line was approved — used for approval cycle analysis."
  measures:
    - name: "total_approved_amount_usd"
      expr: SUM(CAST(approved_amount_usd AS DOUBLE))
      comment: "Total approved budget amount in USD across all budget lines — primary financial envelope measure."
    - name: "total_revised_amount_usd"
      expr: SUM(CAST(revised_amount_usd AS DOUBLE))
      comment: "Total revised budget amount in USD — measures cumulative budget modifications and scope changes."
    - name: "total_cumulative_expenditure_usd"
      expr: SUM(CAST(cumulative_expenditure_usd AS DOUBLE))
      comment: "Total cumulative expenditure in USD — measures actual spend against approved budget."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance amount (approved minus actual) — key financial management KPI for under/over-spend detection."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across budget lines — used to assess overall budget execution accuracy."
    - name: "total_indirect_cost_amount"
      expr: SUM(CAST(indirect_cost_amount AS DOUBLE))
      comment: "Total indirect costs charged across budget lines — used for overhead recovery monitoring."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amount across budget lines — tracks co-financing fulfillment at line level."
    - name: "non_compliant_line_count"
      expr: COUNT(CASE WHEN allowability_flag = FALSE OR allocability_flag = FALSE OR reasonableness_flag = FALSE THEN award_budget_line_id END)
      comment: "Number of budget lines failing at least one compliance flag (allowability, allocability, or reasonableness) — critical audit risk KPI."
    - name: "avg_nicra_rate_applied"
      expr: AVG(CAST(nicra_rate_applied AS DOUBLE))
      comment: "Average NICRA rate applied at budget line level — used to verify consistent overhead rate application."
    - name: "distinct_awards_with_expenditure"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct awards with budget line activity — measures portfolio breadth of financial execution."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor reporting compliance and financial performance KPIs — tracks submission timeliness, overdue reports, financial amounts reported, and budget variance for donor relationship management and compliance risk oversight."
  source: "`vibe_ngo_v1`.`grant`.`donor_report`"
  dimensions:
    - name: "donor_report_status"
      expr: donor_report_status
      comment: "Current status of the donor report (e.g. Draft, Submitted, Accepted, Overdue) — primary compliance monitoring dimension."
    - name: "donor_report_type"
      expr: donor_report_type
      comment: "Type of donor report (e.g. Financial, Narrative, Final) — used to segment reporting workload and compliance obligations."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting cadence (e.g. Quarterly, Annual) — used to analyze compliance burden by frequency."
    - name: "financial_currency"
      expr: financial_currency
      comment: "Currency of the financial amounts reported — needed for multi-currency financial reporting analysis."
    - name: "is_overdue"
      expr: is_overdue
      comment: "Boolean flag indicating whether the report is overdue — primary compliance risk dimension."
    - name: "is_final_version"
      expr: is_final_version
      comment: "Boolean flag indicating whether this is the final version of the report."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Boolean flag indicating whether compliance certification was included — used for regulatory compliance tracking."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the report (e.g. Portal, Email) — used for process efficiency analysis."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the report was submitted — used for year-over-year compliance trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the report was due — used for workload planning and deadline management."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start_date)
      comment: "Start month of the reporting period — used for period-level financial performance analysis."
  measures:
    - name: "total_reports_submitted"
      expr: COUNT(CASE WHEN donor_report_status = 'Submitted' THEN donor_report_id END)
      comment: "Total number of donor reports submitted — primary compliance volume KPI."
    - name: "overdue_report_count"
      expr: COUNT(CASE WHEN is_overdue = TRUE THEN donor_report_id END)
      comment: "Number of overdue donor reports — critical compliance risk KPI; triggers escalation and donor relationship risk."
    - name: "total_financial_amount_reported_usd"
      expr: SUM(CAST(financial_amount_reported_usd AS DOUBLE))
      comment: "Total financial amount reported to donors in USD — measures financial accountability and reporting completeness."
    - name: "total_cumulative_expenditure_to_date"
      expr: SUM(CAST(cumulative_expenditure_to_date AS DOUBLE))
      comment: "Total cumulative expenditure reported to date across all donor reports — tracks aggregate spend accountability."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance amount reported — measures aggregate financial deviation from approved budgets across the portfolio."
    - name: "avg_budget_variance_percentage"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across donor reports — used to assess overall financial execution quality."
    - name: "reports_with_compliance_certification_count"
      expr: COUNT(CASE WHEN compliance_certification_flag = TRUE THEN donor_report_id END)
      comment: "Number of reports with compliance certification — measures regulatory compliance adherence rate."
    - name: "distinct_awards_reported"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct awards with donor reports — measures reporting portfolio breadth."
    - name: "avg_exchange_rate_used"
      expr: AVG(CAST(exchange_rate_used AS DOUBLE))
      comment: "Average exchange rate used in donor reports — used to monitor currency risk exposure in financial reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_subaward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subaward portfolio KPIs — tracks obligated amounts, disbursements, remaining balances, indirect cost recovery, and compliance flags for partner financial management and flow-down oversight."
  source: "`vibe_ngo_v1`.`grant`.`award`"
  dimensions:
    - name: "currency"
      expr: currency
      comment: "Currency of the subaward — needed for multi-currency portfolio analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the subaward (e.g. Advance, Reimbursement) — affects cash flow and financial risk."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting cadence required of the subrecipient — drives compliance workload planning."
  measures:
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share amount committed by subrecipients — tracks partner co-financing obligations."
    - name: "distinct_parent_awards_count"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct parent awards with subawards — measures the breadth of pass-through funding activity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grant amendment KPIs — tracks funding changes, no-cost extensions, scope modifications, and approval cycle times to monitor portfolio stability and donor relationship management."
  source: "`vibe_ngo_v1`.`grant`.`amendment`"
  dimensions:
    - name: "grant_amendment_status"
      expr: grant_amendment_status
      comment: "Current status of the amendment (e.g. Pending, Approved, Rejected) — primary lifecycle dimension."
    - name: "grant_amendment_type"
      expr: grant_amendment_type
      comment: "Type of amendment (e.g. Budget Modification, No-Cost Extension, Scope Change) — used to categorize portfolio instability drivers."
    - name: "is_no_cost_extension"
      expr: is_no_cost_extension
      comment: "Boolean flag indicating whether the amendment is a no-cost extension — key indicator of project delivery challenges."
    - name: "donor_prior_approval_required"
      expr: donor_prior_approval_required
      comment: "Boolean flag indicating whether donor prior approval was required — used to track compliance with donor approval thresholds."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amendment funding change — needed for multi-currency amendment analysis."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the amendment was approved — used for year-over-year amendment volume trend analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the amendment became effective — used for portfolio change timeline analysis."
    - name: "approved_by_title"
      expr: approved_by_title
      comment: "Title of the approver — used to analyze approval authority distribution and escalation patterns."
  measures:
    - name: "total_amendment_count"
      expr: COUNT(amendment_id)
      comment: "Total number of amendments across the portfolio — primary indicator of portfolio instability and change management burden."
    - name: "no_cost_extension_count"
      expr: COUNT(CASE WHEN is_no_cost_extension = TRUE THEN amendment_id END)
      comment: "Number of no-cost extension amendments — key indicator of project delivery delays and implementation challenges."
    - name: "total_funding_change"
      expr: SUM(CAST(funding_change AS DOUBLE))
      comment: "Net total funding change across all amendments — measures aggregate budget modification impact on the portfolio."
    - name: "total_revised_obligation"
      expr: SUM(CAST(revised_total_obligation AS DOUBLE))
      comment: "Total revised obligation amount across all amendments — measures the updated financial commitment after modifications."
    - name: "total_original_obligation"
      expr: SUM(CAST(original_total_obligation AS DOUBLE))
      comment: "Total original obligation amount before amendments — used as baseline for measuring portfolio scope change."
    - name: "amendments_requiring_donor_approval_count"
      expr: COUNT(CASE WHEN donor_prior_approval_required = TRUE THEN amendment_id END)
      comment: "Number of amendments requiring donor prior approval — measures compliance burden and donor relationship management workload."
    - name: "distinct_awards_amended"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct awards that have been amended — measures portfolio-wide amendment prevalence."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_donor_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor condition compliance KPIs — tracks special award conditions, compliance status, overdue conditions, and financial thresholds to manage donor relationship risk and regulatory obligations."
  source: "`vibe_ngo_v1`.`grant`.`donor_condition`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the donor condition (e.g. Compliant, Non-Compliant, Pending) — primary risk monitoring dimension."
    - name: "donor_condition_type"
      expr: donor_condition_type
      comment: "Type of donor condition (e.g. Financial, Programmatic, Reporting) — used to categorize compliance obligations."
    - name: "category"
      expr: donor_condition_category
      comment: "Category of the donor condition — used for grouping and prioritization of compliance actions."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the condition (e.g. High, Medium, Low) — used for compliance workload prioritization."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the donor condition — used for risk-based compliance monitoring decisions."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for fulfilling the condition — used for accountability and workload distribution analysis."
    - name: "is_special_award_condition"
      expr: is_special_award_condition
      comment: "Boolean flag indicating whether this is a Special Award Condition (SAC) — SACs carry elevated compliance risk."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Frequency of condition monitoring — used to assess oversight intensity."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the condition is due — used for compliance deadline planning and workload forecasting."
    - name: "recurrence_frequency"
      expr: recurrence_frequency
      comment: "Recurrence frequency for recurring conditions — used to forecast ongoing compliance obligations."
  measures:
    - name: "total_conditions_count"
      expr: COUNT(donor_condition_id)
      comment: "Total number of donor conditions across the portfolio — measures overall compliance obligation volume."
    - name: "non_compliant_condition_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN donor_condition_id END)
      comment: "Number of non-compliant donor conditions — critical risk KPI; non-compliance can trigger award suspension or clawback."
    - name: "special_award_condition_count"
      expr: COUNT(CASE WHEN is_special_award_condition = TRUE THEN donor_condition_id END)
      comment: "Number of Special Award Conditions (SACs) — elevated compliance risk items requiring executive attention."
    - name: "high_risk_condition_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN donor_condition_id END)
      comment: "Number of high-risk donor conditions — used to prioritize compliance monitoring resources."
    - name: "total_financial_threshold_amount"
      expr: SUM(CAST(financial_threshold_amount AS DOUBLE))
      comment: "Total financial threshold amount across all donor conditions — measures aggregate financial compliance exposure."
    - name: "distinct_awards_with_conditions"
      expr: COUNT(DISTINCT award_id)
      comment: "Number of distinct awards with donor conditions — measures breadth of compliance obligation across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`grant_funding_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Funding source portfolio KPIs — tracks available funding, cost-share requirements, indirect cost rates, and donor diversification for strategic resource mobilization decisions."
  source: "`vibe_ngo_v1`.`grant`.`funding_source`"
  dimensions:
    - name: "funding_source_status"
      expr: funding_source_status
      comment: "Current status of the funding source (e.g. Active, Inactive, Pipeline) — primary filter for active funding analysis."
    - name: "funding_mechanism_type"
      expr: funding_mechanism_type
      comment: "Type of funding mechanism (e.g. Grant, Contract, Cooperative Agreement) — affects compliance and reporting requirements."
    - name: "fund_restriction_type"
      expr: fund_restriction_type
      comment: "Restriction type of the funding source (e.g. Restricted, Unrestricted) — affects budget flexibility."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the funding source — needed for multi-currency portfolio analysis."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Applicable compliance framework (e.g. 2 CFR 200, FCDO) — determines regulatory requirements."
    - name: "indirect_cost_rate_type"
      expr: indirect_cost_rate_type
      comment: "Type of indirect cost rate (e.g. NICRA, Negotiated, De Minimis) — affects overhead recovery strategy."
    - name: "oda_dac_classification"
      expr: oda_dac_classification
      comment: "ODA/DAC classification of the funding source — used for ODA reporting and donor alignment analysis."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Boolean flag indicating whether cost-share is required — affects organizational co-financing obligations."
    - name: "subaward_allowed"
      expr: subaward_allowed
      comment: "Boolean flag indicating whether subawards are permitted — affects partnership model decisions."
    - name: "advance_payment_allowed"
      expr: advance_payment_allowed
      comment: "Boolean flag indicating whether advance payments are allowed — affects cash flow planning."
    - name: "funding_start_year"
      expr: YEAR(funding_start_date)
      comment: "Year the funding source becomes available — used for pipeline timing analysis."
    - name: "funding_end_year"
      expr: YEAR(funding_end_date)
      comment: "Year the funding source expires — used for pipeline expiry and renewal planning."
  measures:
    - name: "total_funding_available"
      expr: SUM(CAST(total_funding_available AS DOUBLE))
      comment: "Total funding available across all funding sources — primary resource mobilization pipeline KPI."
    - name: "avg_nicra_rate"
      expr: AVG(CAST(nicra_rate AS DOUBLE))
      comment: "Average NICRA indirect cost rate across funding sources — used to assess overhead recovery potential."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required across funding sources — measures organizational co-financing burden."
    - name: "avg_budget_revision_threshold"
      expr: AVG(CAST(budget_revision_threshold AS DOUBLE))
      comment: "Average budget revision threshold across funding sources — indicates typical flexibility for budget modifications without donor approval."
    - name: "active_funding_source_count"
      expr: COUNT(CASE WHEN funding_source_status = 'Active' THEN funding_source_id END)
      comment: "Number of active funding sources — measures donor diversification and funding pipeline breadth."
    - name: "subaward_eligible_source_count"
      expr: COUNT(CASE WHEN subaward_allowed = TRUE THEN funding_source_id END)
      comment: "Number of funding sources that permit subawards — measures partnership and pass-through funding capacity."
$$;
