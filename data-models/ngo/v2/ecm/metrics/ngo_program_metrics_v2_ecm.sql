-- Metric views for domain: program | Business: Ngo | Version: 2 | Generated on: 2026-07-03 05:04:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for humanitarian/development interventions. Source of record for program portfolio performance across sectors, geographies, and SDG alignment. Relevant to SAP S/4HANA project structures, eTools programme management, and UNICEF RAM/InSight reporting."
  source: "`vibe_ngo_v1`.`program`.`intervention`"
  dimensions:
    - name: "intervention_status"
      expr: intervention_status
      comment: "Lifecycle status of the intervention (e.g. Active, Closed, Pipeline) — primary filter for portfolio dashboards."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type of intervention (e.g. Emergency Response, Development, Resilience) — used to segment portfolio by modality."
    - name: "sector"
      expr: sector
      comment: "Primary sector (e.g. Nutrition, WASH, Protection) — essential for cluster-level and donor reporting."
    - name: "sub_sector"
      expr: sub_sector
      comment: "Sub-sector classification for granular programmatic analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the intervention — used for field-level portfolio mapping."
    - name: "phase"
      expr: phase
      comment: "Implementation phase (e.g. Design, Implementation, Closeout) — tracks pipeline maturity."
    - name: "sdg_goal_primary"
      expr: sdg_goal_primary
      comment: "Primary SDG goal alignment — required for donor and UN reporting on SDG contribution."
    - name: "gender_marker_score"
      expr: gender_marker_score
      comment: "IASC gender marker score — mandatory for OCHA FTS and many bilateral donor reports."
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Year the intervention was planned to start — used for cohort and pipeline analysis."
    - name: "chs_compliant"
      expr: chs_compliant
      comment: "Whether the intervention is certified CHS-compliant — accountability to affected populations flag."
    - name: "ip_transfer_modality"
      expr: ip_transfer_modality
      comment: "Implementing partner transfer modality (e.g. Direct, Sub-grant, Cash Transfer) — key for partnership and compliance analysis."
  measures:
    - name: "total_interventions"
      expr: COUNT(1)
      comment: "Total number of interventions in the portfolio. Baseline KPI for portfolio size and pipeline tracking on executive dashboards."
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved budget across all interventions. Core financial KPI for portfolio investment sizing and donor commitment tracking."
    - name: "avg_budget_per_intervention"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per intervention. Indicates typical investment scale; outliers signal over/under-resourced programmes."
    - name: "active_intervention_count"
      expr: COUNT(CASE WHEN intervention_status = 'Active' THEN 1 END)
      comment: "Number of currently active interventions. Operational throughput KPI used in steering meetings to assess delivery capacity."
    - name: "chs_compliant_count"
      expr: COUNT(CASE WHEN chs_compliant = TRUE THEN 1 END)
      comment: "Number of interventions certified as CHS-compliant. Accountability and quality assurance KPI required for CHS self-assessment reporting."
    - name: "chs_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN chs_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interventions that are CHS-compliant. Strategic quality KPI — low rates trigger accountability reviews and donor scrutiny."
    - name: "safeguarding_policy_applied_count"
      expr: COUNT(CASE WHEN safeguarding_policy_applied = TRUE THEN 1 END)
      comment: "Number of interventions with safeguarding policy applied. Mandatory risk management KPI for PSEA compliance and donor audits."
    - name: "do_no_harm_completed_count"
      expr: COUNT(CASE WHEN do_no_harm_assessment_completed = TRUE THEN 1 END)
      comment: "Number of interventions with completed Do No Harm assessments. Humanitarian principles compliance KPI — gaps trigger programme risk escalation."
    - name: "sphere_standards_applied_count"
      expr: COUNT(CASE WHEN sphere_standards_applied = TRUE THEN 1 END)
      comment: "Number of interventions applying Sphere standards. Quality benchmark KPI for humanitarian response adequacy."
    - name: "total_budget_by_sector"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget aggregated by sector dimension. Used in sector-level resource allocation decisions and cluster coordination reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme budget planning KPIs covering cost structure, cost-share commitments, and indirect cost rates. Supports SAP S/4HANA budget management, eZHACT cost allocation, and donor budget compliance reviews."
  source: "`vibe_ngo_v1`.`program`.`budget_plan`"
  dimensions:
    - name: "budget_status"
      expr: CAST(budget_status AS STRING)
      comment: "Approval and lifecycle status of the budget plan — primary filter for active vs. draft budgets."
    - name: "budget_type"
      expr: CAST(budget_type AS STRING)
      comment: "Type of budget (e.g. Original, Revised, Supplemental) — used to track amendment history."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget plan — required for multi-currency portfolio consolidation."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — mandatory for ODA reporting and donor statistical submissions."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment tag on the budget plan — used for SDG-tagged finance reporting."
    - name: "budget_period_start_year"
      expr: DATE_TRUNC('YEAR', budget_period_start_date)
      comment: "Fiscal year the budget period starts — used for annual budget cycle analysis."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the budget is visible to the donor — governs which plans appear in donor-facing reports."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across all plans. Primary financial KPI for programme resource envelope sizing."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel costs across budget plans. Workforce cost KPI — high ratios vs. total budget trigger efficiency reviews."
    - name: "total_indirect_costs"
      expr: SUM(CAST(indirect_costs AS DOUBLE))
      comment: "Total indirect/overhead costs. Donor compliance KPI — must stay within negotiated NICRA rate ceilings."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct programme costs. Core delivery cost KPI used in cost-efficiency analysis."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share commitments across budget plans. Donor leverage KPI — tracks matched funding obligations."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across budget plans. Overhead efficiency KPI — compared against NICRA negotiated rates."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel costs. Operational efficiency KPI — elevated travel spend relative to programme delivery triggers scrutiny."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs. Asset investment KPI — tracked for donor prior-approval thresholds and disposition planning."
    - name: "personnel_cost_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(personnel_costs AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Personnel costs as a percentage of total approved budget. Efficiency KPI — benchmarked against sector norms (typically 20-40% for INGOs)."
    - name: "indirect_cost_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(indirect_costs AS DOUBLE)) / NULLIF(SUM(CAST(total_direct_costs AS DOUBLE)), 0), 2)
      comment: "Indirect costs as a percentage of total direct costs. NICRA compliance KPI — must not exceed the negotiated indirect cost rate ceiling."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level budget KPIs for cost category analysis, cost-sharing tracking, and allowability compliance. Supports SAP S/4HANA cost center accounting, eZHACT line-item reporting, and donor budget note reviews."
  source: "`vibe_ngo_v1`.`program`.`budget_plan_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g. Personnel, Travel, Supplies) — primary grouping for budget structure analysis."
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Detailed cost sub-category — used for granular budget variance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — used for annual budget cycle and multi-year programme tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line — required for multi-currency consolidation."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code at line level — enables sector-tagged budget analysis for ODA reporting."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Whether the line is a direct cost — used to separate direct vs. indirect cost pools."
    - name: "cost_sharing_flag"
      expr: cost_sharing_flag
      comment: "Whether the line includes cost-sharing — tracks matched funding commitments at line level."
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Whether the cost is allowable under donor rules — compliance filter for audit-ready budget reporting."
    - name: "budget_period_start_year"
      expr: DATE_TRUNC('YEAR', budget_period_start_date)
      comment: "Year the budget line period starts — used for annual phasing analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all lines. Core financial KPI for budget envelope tracking at line level."
    - name: "total_cost_sharing_amount"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost-sharing amount across lines. Donor leverage KPI — tracks matched funding obligations at granular level."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines. Cost efficiency KPI — benchmarked against sector unit cost norms (e.g. cost per beneficiary)."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units planned across budget lines. Delivery volume KPI — used to compute cost-per-unit efficiency ratios."
    - name: "direct_cost_total"
      expr: SUM(CASE WHEN direct_cost_flag = TRUE THEN total_planned_amount ELSE 0 END)
      comment: "Total direct costs across budget lines. Donor compliance KPI — direct costs must meet minimum thresholds in many grant agreements."
    - name: "cost_sharing_total"
      expr: SUM(CASE WHEN cost_sharing_flag = TRUE THEN cost_sharing_amount ELSE 0 END)
      comment: "Total cost-sharing commitments on flagged lines. Matched funding compliance KPI — shortfalls trigger grant compliance issues."
    - name: "non_allowable_cost_total"
      expr: SUM(CASE WHEN allowable_cost_flag = FALSE THEN total_planned_amount ELSE 0 END)
      comment: "Total planned amount on non-allowable cost lines. Risk KPI — non-zero values require immediate remediation before donor submission."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate at line level. NICRA compliance KPI — compared against negotiated rate ceilings per cost center."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme closeout performance KPIs covering budget utilization, financial reconciliation, compliance certification, and donor sign-off. Critical for grant closeout audits, SAP S/4HANA project closure, and donor final reporting."
  source: "`vibe_ngo_v1`.`program`.`program_closeout`"
  dimensions:
    - name: "closeout_status"
      expr: closeout_status
      comment: "Current status of the closeout process (e.g. In Progress, Complete, Overdue) — primary operational filter."
    - name: "closeout_type"
      expr: closeout_type
      comment: "Type of closeout (e.g. Planned, Early Termination, Emergency) — used to segment closeout risk profiles."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the closeout financials — required for multi-currency portfolio reconciliation."
    - name: "donor_signoff_status"
      expr: donor_signoff_status
      comment: "Status of donor sign-off on the closeout — tracks outstanding donor approvals blocking final closure."
    - name: "final_financial_reconciliation_status"
      expr: final_financial_reconciliation_status
      comment: "Status of final financial reconciliation — audit readiness KPI dimension."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Whether compliance certification has been issued — mandatory for grant closeout and donor final reporting."
    - name: "outstanding_obligations_flag"
      expr: outstanding_obligations_flag
      comment: "Whether outstanding financial obligations remain — risk flag for incomplete closeouts."
    - name: "program_end_year"
      expr: DATE_TRUNC('YEAR', program_end_date)
      comment: "Year the programme ended — used for cohort analysis of closeout timeliness."
  measures:
    - name: "total_closeouts"
      expr: COUNT(1)
      comment: "Total number of programme closeouts. Portfolio lifecycle KPI — tracks closeout pipeline volume for resource planning."
    - name: "total_final_budget"
      expr: SUM(CAST(final_budget_amount AS DOUBLE))
      comment: "Total final approved budget across closed programmes. Financial portfolio KPI for closeout financial envelope."
    - name: "total_final_expenditure"
      expr: SUM(CAST(final_expenditure_amount AS DOUBLE))
      comment: "Total final expenditure across closed programmes. Delivery KPI — compared against budget to assess absorption."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance (over/under-spend) across closeouts. Financial risk KPI — large variances trigger donor queries and audit findings."
    - name: "avg_budget_utilization_pct"
      expr: AVG(CAST(budget_utilization_percentage AS DOUBLE))
      comment: "Average budget utilization rate across closed programmes. Absorption efficiency KPI — low utilization signals delivery failures; high utilization confirms full delivery."
    - name: "compliance_certified_count"
      expr: COUNT(CASE WHEN compliance_certification_flag = TRUE THEN 1 END)
      comment: "Number of closeouts with compliance certification issued. Audit readiness KPI — uncertified closeouts are a donor audit risk."
    - name: "outstanding_obligations_count"
      expr: COUNT(CASE WHEN outstanding_obligations_flag = TRUE THEN 1 END)
      comment: "Number of closeouts with outstanding financial obligations. Financial risk KPI — each outstanding obligation is a potential liability."
    - name: "donor_signoff_pending_count"
      expr: COUNT(CASE WHEN donor_signoff_status != 'Approved' THEN 1 END)
      comment: "Number of closeouts awaiting donor sign-off. Operational bottleneck KPI — pending sign-offs delay final grant closure and fund release."
    - name: "expenditure_to_budget_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(final_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(final_budget_amount AS DOUBLE)), 0), 2)
      comment: "Final expenditure as a percentage of final budget. Absorption rate KPI — the primary closeout financial performance indicator for donors and auditors."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_review_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme review and reporting event KPIs covering beneficiary reach, financial progress, and compliance. Supports OCHA SitRep, UNICEF RAM, donor progress reports, and cluster coordination submissions."
  source: "`vibe_ngo_v1`.`program`.`review_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of review event (e.g. Mid-Term Review, Annual Report, Donor Progress Report) — primary classification for reporting cycle analysis."
    - name: "event_status"
      expr: event_status
      comment: "Status of the review event (e.g. Draft, Submitted, Approved) — tracks reporting pipeline."
    - name: "financial_summary_currency_code"
      expr: financial_summary_currency_code
      comment: "Currency of the financial summary — required for multi-currency portfolio consolidation."
    - name: "chs_compliance_flag"
      expr: chs_compliance_flag
      comment: "Whether the review confirms CHS compliance — accountability KPI dimension."
    - name: "cluster_submission_flag"
      expr: cluster_submission_flag
      comment: "Whether the review was submitted to the cluster — OCHA coordination compliance dimension."
    - name: "sphere_standards_applied_flag"
      expr: sphere_standards_applied_flag
      comment: "Whether Sphere standards were applied in the review period — humanitarian quality dimension."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the review is visible to the donor — governs donor-facing reporting."
    - name: "reporting_period_start_year"
      expr: DATE_TRUNC('YEAR', reporting_period_start_date)
      comment: "Year of the reporting period — used for annual programme performance trend analysis."
    - name: "review_quarter"
      expr: DATE_TRUNC('QUARTER', review_date)
      comment: "Quarter of the review date — used for quarterly steering meeting dashboards."
  measures:
    - name: "total_review_events"
      expr: COUNT(1)
      comment: "Total number of review events. Reporting compliance KPI — tracks whether programmes are meeting reporting frequency requirements."
    - name: "total_beneficiary_reach"
      expr: SUM(CAST(beneficiary_reach_total AS DOUBLE))
      comment: "Total beneficiaries reached across all review events. Primary programme impact KPI — the headline number for donor reports and board decks."
    - name: "total_beneficiary_reach_female"
      expr: SUM(CAST(beneficiary_reach_female AS DOUBLE))
      comment: "Total female beneficiaries reached. Gender disaggregation KPI — mandatory for IASC gender marker compliance and most bilateral donor reports."
    - name: "total_beneficiary_reach_male"
      expr: SUM(CAST(beneficiary_reach_male AS DOUBLE))
      comment: "Total male beneficiaries reached. Gender disaggregation KPI — paired with female reach for gender balance analysis."
    - name: "total_beneficiary_reach_children"
      expr: SUM(CAST(beneficiary_reach_children AS DOUBLE))
      comment: "Total children reached. Child-focused KPI — mandatory for UNICEF, Save the Children, and child protection cluster reporting."
    - name: "total_financial_budget"
      expr: SUM(CAST(financial_summary_budget_amount AS DOUBLE))
      comment: "Total budget amount reported across review events. Financial progress KPI — tracks cumulative budget commitment over reporting periods."
    - name: "total_financial_expenditure"
      expr: SUM(CAST(financial_summary_expenditure_amount AS DOUBLE))
      comment: "Total expenditure reported across review events. Absorption KPI — compared against budget to assess financial delivery pace."
    - name: "expenditure_absorption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(financial_summary_expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(financial_summary_budget_amount AS DOUBLE)), 0), 2)
      comment: "Expenditure as a percentage of budget across review events. Delivery pace KPI — low absorption mid-programme triggers no-cost extension risk; high absorption late triggers over-spend risk."
    - name: "female_beneficiary_share_pct"
      expr: ROUND(100.0 * SUM(CAST(beneficiary_reach_female AS DOUBLE)) / NULLIF(SUM(CAST(beneficiary_reach_total AS DOUBLE)), 0), 2)
      comment: "Female beneficiaries as a percentage of total reach. Gender equity KPI — benchmarked against 50% parity target and IASC gender marker requirements."
    - name: "chs_compliant_review_count"
      expr: COUNT(CASE WHEN chs_compliance_flag = TRUE THEN 1 END)
      comment: "Number of review events confirming CHS compliance. Accountability KPI — used in CHS self-assessment and donor accountability reporting."
    - name: "cluster_submitted_review_count"
      expr: COUNT(CASE WHEN cluster_submission_flag = TRUE THEN 1 END)
      comment: "Number of reviews submitted to the cluster. OCHA coordination compliance KPI — tracks inter-agency reporting obligations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme risk management KPIs covering risk distribution, escalation rates, and mitigation coverage. Supports INGO risk management frameworks, donor risk reporting, and SAP S/4HANA project risk modules."
  source: "`vibe_ngo_v1`.`program`.`risk_register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g. Open, Mitigated, Closed, Escalated) — primary operational filter."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category (e.g. Fiduciary, Security, Programmatic, Reputational) — used to segment risk portfolio by type."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level (e.g. Low, Medium, High, Critical) — primary severity dimension for risk dashboards."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating of the risk — used in risk heat map analysis."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk — paired with impact for risk matrix positioning."
    - name: "affected_sector"
      expr: affected_sector
      comment: "Sector affected by the risk — used for sector-level risk concentration analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the risk — used for country/region risk concentration analysis."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether the risk requires escalation — used to filter high-priority risks for leadership attention."
    - name: "identification_year"
      expr: DATE_TRUNC('YEAR', identification_date)
      comment: "Year the risk was identified — used for risk trend analysis over time."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of risks in the register. Portfolio risk volume KPI — tracks risk accumulation over programme lifecycle."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Number of currently open risks. Operational risk exposure KPI — high open counts trigger risk review meetings."
    - name: "high_critical_risk_count"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Number of high or critical risks. Executive risk KPI — the primary indicator for board-level risk reporting and donor risk disclosures."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of risks requiring escalation. Leadership action KPI — each escalation-required risk demands senior management response."
    - name: "high_critical_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of risks rated High or Critical. Risk concentration KPI — rising rates signal deteriorating programme risk environment."
    - name: "mitigated_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Mitigated' THEN 1 END)
      comment: "Number of risks with mitigation applied. Risk management effectiveness KPI — tracks progress in reducing risk exposure."
    - name: "mitigation_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_status = 'Mitigated' THEN 1 END) / NULLIF(COUNT(CASE WHEN risk_status IN ('Open', 'Mitigated') THEN 1 END), 0), 2)
      comment: "Percentage of open/mitigated risks that have mitigation applied. Risk management maturity KPI — low rates indicate inadequate risk response planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme amendment KPIs tracking scope changes, budget revisions, and donor approval cycles. Supports grant management in eTools, SAP S/4HANA project change management, and donor prior-approval compliance."
  source: "`vibe_ngo_v1`.`program`.`program_amendment`"
  dimensions:
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. No-Cost Extension, Budget Revision, Scope Change) — primary classification for amendment analysis."
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Draft, Submitted, Approved, Rejected) — tracks amendment pipeline."
    - name: "grant_requirement_flag"
      expr: grant_requirement_flag
      comment: "Whether the amendment requires donor prior approval — compliance dimension for grant management."
    - name: "logframe_revision_flag"
      expr: logframe_revision_flag
      comment: "Whether the amendment includes a logframe revision — MEL impact dimension."
    - name: "submission_year"
      expr: DATE_TRUNC('YEAR', submission_date)
      comment: "Year the amendment was submitted — used for amendment frequency trend analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the amendment became effective — used for programme change timeline analysis."
  measures:
    - name: "total_amendments"
      expr: COUNT(1)
      comment: "Total number of programme amendments. Programme stability KPI — high amendment counts signal poor initial planning or volatile operating environments."
    - name: "total_budget_change_amount"
      expr: SUM(CAST(budget_change_amount AS DOUBLE))
      comment: "Total budget change amount across all amendments. Financial revision KPI — tracks cumulative budget volatility across the programme portfolio."
    - name: "approved_amendment_count"
      expr: COUNT(CASE WHEN amendment_status = 'Approved' THEN 1 END)
      comment: "Number of approved amendments. Donor relationship KPI — approval rates reflect donor confidence and programme management quality."
    - name: "rejected_amendment_count"
      expr: COUNT(CASE WHEN amendment_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected amendments. Risk KPI — rejections signal misalignment with donor requirements and may delay programme delivery."
    - name: "amendment_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN amendment_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN amendment_status IN ('Approved', 'Rejected') THEN 1 END), 0), 2)
      comment: "Percentage of decided amendments that were approved. Donor relationship quality KPI — low approval rates indicate systemic compliance or planning issues."
    - name: "prior_approval_required_count"
      expr: COUNT(CASE WHEN grant_requirement_flag = TRUE THEN 1 END)
      comment: "Number of amendments requiring donor prior approval. Compliance workload KPI — each prior-approval requirement adds donor engagement overhead."
    - name: "logframe_revision_count"
      expr: COUNT(CASE WHEN logframe_revision_flag = TRUE THEN 1 END)
      comment: "Number of amendments that revised the logframe. MEL stability KPI — frequent logframe revisions undermine results measurement continuity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_partner_linkage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Implementing partner performance and compliance KPIs at the intervention level. Supports eTools partner management, UNICEF HACT framework, and donor sub-award monitoring requirements."
  source: "`vibe_ngo_v1`.`program`.`partner_linkage`"
  dimensions:
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current status of the partnership (e.g. Active, Suspended, Closed) — primary operational filter."
    - name: "partnership_type"
      expr: partnership_type
      comment: "Type of partnership (e.g. Sub-grant, MOU, Service Contract) — used to segment partner portfolio by modality."
    - name: "partnership_role"
      expr: partnership_role
      comment: "Role of the partner in the intervention (e.g. Lead Implementer, Co-implementer) — used for accountability mapping."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the partnership — primary risk filter for partner oversight dashboards."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the partner (e.g. Low, Medium, High) — drives monitoring intensity under HACT and donor frameworks."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the partner — used for partner portfolio quality assessment."
    - name: "local_partner_flag"
      expr: local_partner_flag
      comment: "Whether the partner is a local/national organization — tracks localization agenda progress."
    - name: "capacity_building_required_flag"
      expr: capacity_building_required_flag
      comment: "Whether capacity building is required — drives capacity development investment decisions."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the partnership — used for geographic partner coverage analysis."
  measures:
    - name: "total_partner_linkages"
      expr: COUNT(1)
      comment: "Total number of partner linkages. Partnership portfolio size KPI — tracks implementing partner network scale."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to implementing partners. Sub-award financial KPI — tracks total funds flowing through partner channel."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average partner capacity assessment score. HACT compliance KPI — low scores trigger enhanced monitoring and capacity building requirements."
    - name: "high_risk_partner_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of high-risk partner linkages. Risk management KPI — high-risk partners require enhanced monitoring visits and financial spot-checks."
    - name: "local_partner_count"
      expr: COUNT(CASE WHEN local_partner_flag = TRUE THEN 1 END)
      comment: "Number of local/national partner linkages. Localization KPI — tracks progress against Grand Bargain and donor localization commitments."
    - name: "local_partner_budget_share_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN local_partner_flag = TRUE THEN budget_allocated_amount ELSE 0 END) / NULLIF(SUM(CAST(budget_allocated_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of partner budget allocated to local/national organizations. Grand Bargain localization KPI — donors increasingly require 25%+ local partner funding."
    - name: "capacity_building_required_count"
      expr: COUNT(CASE WHEN capacity_building_required_flag = TRUE THEN 1 END)
      comment: "Number of partners requiring capacity building. Investment planning KPI — drives capacity development budget and workplan."
    - name: "avg_budget_per_partner"
      expr: AVG(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Average budget allocated per partner linkage. Portfolio concentration KPI — very high averages indicate over-reliance on few partners."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_logframe_row`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Results framework KPIs tracking logframe target achievement, baseline coverage, and results chain completeness. Supports UNICEF RAM, USAID PIRS, eTools results management, and IATI results reporting."
  source: "`vibe_ngo_v1`.`program`.`logframe_row`"
  dimensions:
    - name: "result_level"
      expr: result_level
      comment: "Results chain level (e.g. Input, Activity, Output, Outcome, Impact) — primary dimension for results framework analysis."
    - name: "logframe_row_status"
      expr: logframe_row_status
      comment: "Status of the logframe row (e.g. On Track, At Risk, Off Track, Achieved) — primary performance filter."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Reporting frequency for the indicator (e.g. Monthly, Quarterly, Annual) — used for reporting schedule analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the result — used for geographic results distribution analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the logframe row — used for SDG contribution reporting."
    - name: "is_active"
      expr: is_active
      comment: "Whether the logframe row is currently active — used to filter current vs. historical results."
    - name: "implementation_start_year"
      expr: DATE_TRUNC('YEAR', implementation_start_date)
      comment: "Year implementation started — used for results timeline analysis."
  measures:
    - name: "total_logframe_rows"
      expr: COUNT(1)
      comment: "Total number of logframe rows. Results framework completeness KPI — tracks the scale of the results measurement architecture."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all logframe target values. Aggregate ambition KPI — tracks total programme targets set across the results framework."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Sum of all baseline values. Starting point KPI — used to compute change from baseline across the results framework."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to logframe rows. Results-based budgeting KPI — tracks financial resources linked to specific results."
    - name: "on_track_row_count"
      expr: COUNT(CASE WHEN logframe_row_status = 'On Track' THEN 1 END)
      comment: "Number of logframe rows on track. Programme performance KPI — the primary indicator for mid-term review and donor progress reporting."
    - name: "at_risk_off_track_count"
      expr: COUNT(CASE WHEN logframe_row_status IN ('At Risk', 'Off Track') THEN 1 END)
      comment: "Number of logframe rows at risk or off track. Early warning KPI — triggers management response and corrective action planning."
    - name: "results_on_track_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN logframe_row_status = 'On Track' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active logframe rows on track. Programme delivery quality KPI — the headline results performance indicator for board and donor reporting."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per logframe row. Ambition calibration KPI — used to assess whether targets are appropriately scaled."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_design_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme design quality and needs assessment KPIs covering data quality, ethical compliance, and humanitarian needs coverage. Supports Kobo Toolbox assessment management, OCHA needs analysis, and UNICEF situation analysis processes."
  source: "`vibe_ngo_v1`.`program`.`design_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (e.g. Needs Assessment, Feasibility Study, Context Analysis) — primary classification dimension."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g. Planned, In Progress, Complete) — operational pipeline filter."
    - name: "country_code"
      expr: country_code
      comment: "Country where the assessment was conducted — geographic analysis dimension."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for sector-level needs analysis aggregation."
    - name: "ethical_approval_obtained"
      expr: ethical_approval_obtained
      comment: "Whether ethical approval was obtained — research ethics compliance dimension."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Whether the assessment is visible to donors — governs donor-facing evidence sharing."
    - name: "data_collection_start_year"
      expr: DATE_TRUNC('YEAR', data_collection_start_date)
      comment: "Year data collection started — used for assessment timeliness and evidence currency analysis."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of design assessments. Evidence base KPI — tracks the volume of needs evidence underpinning programme design."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across assessments. Evidence quality KPI — low scores undermine programme design credibility and donor confidence."
    - name: "avg_gam_prevalence_pct"
      expr: AVG(CAST(gam_prevalence_percent AS DOUBLE))
      comment: "Average Global Acute Malnutrition (GAM) prevalence across nutrition assessments. Humanitarian severity KPI — GAM >15% triggers emergency nutrition response."
    - name: "avg_sam_prevalence_pct"
      expr: AVG(CAST(sam_prevalence_percent AS DOUBLE))
      comment: "Average Severe Acute Malnutrition (SAM) prevalence. Critical nutrition KPI — SAM >2% triggers therapeutic feeding programme activation."
    - name: "avg_wash_coverage_gap_pct"
      expr: AVG(CAST(wash_coverage_gap_percent AS DOUBLE))
      comment: "Average WASH coverage gap percentage. Humanitarian needs KPI — drives WASH programme targeting and Sphere standard compliance planning."
    - name: "ethical_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ethical_approval_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments with ethical approval obtained. Research ethics compliance KPI — required for publication, donor reporting, and IRB compliance."
    - name: "completed_assessment_count"
      expr: COUNT(CASE WHEN assessment_status = 'Complete' THEN 1 END)
      comment: "Number of completed assessments. Evidence pipeline KPI — tracks available evidence base for programme design decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_intervention_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor compliance requirement tracking KPIs for interventions. Supports grant compliance management in eTools, SAP S/4HANA compliance modules, and donor audit preparation."
  source: "`vibe_ngo_v1`.`program`.`intervention_compliance`"
  dimensions:
    - name: "requirement_status"
      expr: requirement_status
      comment: "Status of the compliance requirement (e.g. Pending, Submitted, Overdue, Waived) — primary compliance pipeline filter."
    - name: "deliverable_format"
      expr: deliverable_format
      comment: "Format of the compliance deliverable (e.g. Report, Audit, Certification) — used to segment compliance workload by type."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Whether a waiver was granted for the requirement — tracks exceptions to donor compliance obligations."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the compliance cost — required for multi-currency compliance cost analysis."
    - name: "due_year"
      expr: DATE_TRUNC('YEAR', due_date)
      comment: "Year the compliance requirement is due — used for compliance calendar and workload planning."
  measures:
    - name: "total_compliance_requirements"
      expr: COUNT(1)
      comment: "Total number of compliance requirements. Compliance workload KPI — tracks the volume of donor obligations requiring management attention."
    - name: "overdue_requirement_count"
      expr: COUNT(CASE WHEN requirement_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue compliance requirements. Critical risk KPI — overdue donor requirements trigger grant suspension and audit findings."
    - name: "total_compliance_cost"
      expr: SUM(CAST(associated_cost_amount AS DOUBLE))
      comment: "Total cost associated with compliance activities. Compliance overhead KPI — tracks the financial burden of donor compliance requirements."
    - name: "total_compliance_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total staff hours spent on compliance activities. Compliance efficiency KPI — high effort hours relative to programme delivery signal over-burdensome donor requirements."
    - name: "compliance_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requirement_status = 'Submitted' THEN 1 END) / NULLIF(COUNT(CASE WHEN requirement_status IN ('Submitted', 'Overdue', 'Pending') THEN 1 END), 0), 2)
      comment: "Percentage of compliance requirements submitted on time. Donor relationship quality KPI — low rates signal systemic compliance management failures."
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted_flag = TRUE THEN 1 END)
      comment: "Number of compliance requirements with waivers granted. Exception management KPI — high waiver counts may indicate unrealistic donor requirements or weak programme capacity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_humanitarian_response_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Humanitarian Response Plan (HRP) funding and coverage KPIs. Supports OCHA FTS reporting, cluster coordination, and UN-agency strategic planning. Critical for tracking funding gaps against humanitarian needs."
  source: "`vibe_ngo_v1`.`program`.`humanitarian_response_plan`"
  dimensions:
    - name: "humanitarian_response_plan_status"
      expr: humanitarian_response_plan_status
      comment: "Status of the HRP (e.g. Active, Expired, Under Revision) — primary filter for current vs. historical plans."
    - name: "plan_year"
      expr: plan_year
      comment: "Year of the humanitarian response plan — used for annual HRP cycle analysis and OCHA FTS reporting."
  measures:
    - name: "total_hrp_count"
      expr: COUNT(1)
      comment: "Total number of Humanitarian Response Plans. Portfolio coverage KPI — tracks the number of active humanitarian crises with formal response plans."
    - name: "total_people_in_need"
      expr: SUM(CAST(people_in_need AS DOUBLE))
      comment: "Total people in need across all HRPs. Humanitarian scale KPI — the primary indicator of global humanitarian caseload for executive and donor reporting."
    - name: "total_people_targeted"
      expr: SUM(CAST(people_targeted AS DOUBLE))
      comment: "Total people targeted for assistance across HRPs. Response ambition KPI — compared against people in need to assess targeting coverage."
    - name: "total_requirements_usd"
      expr: SUM(CAST(total_requirements_usd AS DOUBLE))
      comment: "Total funding requirements across all HRPs in USD. Humanitarian financing KPI — the headline figure for donor appeals and OCHA FTS."
    - name: "total_funded_usd"
      expr: SUM(CAST(total_funded_usd AS DOUBLE))
      comment: "Total funding received across all HRPs in USD. Funding mobilization KPI — compared against requirements to compute the funding gap."
    - name: "funding_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_funded_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_requirements_usd AS DOUBLE)), 0), 2)
      comment: "Funded amount as a percentage of total requirements. Humanitarian funding gap KPI — the primary indicator for donor mobilization urgency. Below 50% signals critical underfunding."
    - name: "targeting_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(people_targeted AS DOUBLE)) / NULLIF(SUM(CAST(people_in_need AS DOUBLE)), 0), 2)
      comment: "People targeted as a percentage of people in need. Response ambition KPI — low rates indicate triage decisions; high rates indicate comprehensive response planning."
    - name: "funding_gap_usd"
      expr: SUM(CAST(total_requirements_usd AS DOUBLE) - CAST(total_funded_usd AS DOUBLE))
      comment: "Total funding gap across all HRPs in USD. Donor mobilization KPI — the single most important number for humanitarian fundraising campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Programme portfolio KPIs covering budget, multi-year coverage, emergency response, and risk profile. Supports SAP S/4HANA programme management, UNICEF InSight, and organizational strategic planning."
  source: "`vibe_ngo_v1`.`program`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Lifecycle status of the programme (e.g. Active, Closed, Pipeline) — primary portfolio filter."
    - name: "program_type"
      expr: program_type
      comment: "Type of programme (e.g. Emergency, Development, Resilience) — used to segment portfolio by modality."
    - name: "sector_code"
      expr: sector_code
      comment: "Sector code of the programme — used for sector-level portfolio analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the programme — used for regional portfolio distribution analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the programme — used for country-level portfolio analysis."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Whether the programme is an emergency response — used to segment humanitarian vs. development portfolio."
    - name: "is_multi_year"
      expr: is_multi_year
      comment: "Whether the programme spans multiple years — used to assess portfolio sustainability and long-term commitment."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the programme — used for risk-weighted portfolio analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the programme — used to identify programmes with compliance issues."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the programme started — used for cohort and vintage analysis."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of programmes. Portfolio size KPI — baseline measure for organizational programme footprint."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget across all programmes. Portfolio investment KPI — the primary financial scale indicator for executive and board reporting."
    - name: "avg_budget_per_program"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per programme. Investment scale KPI — used to assess typical programme size and identify outliers."
    - name: "emergency_program_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN 1 END)
      comment: "Number of emergency response programmes. Humanitarian portfolio KPI — tracks the organization's emergency response footprint."
    - name: "multi_year_program_count"
      expr: COUNT(CASE WHEN is_multi_year = TRUE THEN 1 END)
      comment: "Number of multi-year programmes. Portfolio sustainability KPI — multi-year programmes indicate longer-term donor commitments and planning horizons."
    - name: "high_risk_program_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Number of high-risk programmes. Portfolio risk KPI — high-risk programmes require enhanced oversight and contingency planning."
    - name: "emergency_budget_share_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_emergency = TRUE THEN budget_amount ELSE 0 END) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Emergency programme budget as a percentage of total portfolio budget. Strategic balance KPI — tracks the humanitarian vs. development investment split."
$$;