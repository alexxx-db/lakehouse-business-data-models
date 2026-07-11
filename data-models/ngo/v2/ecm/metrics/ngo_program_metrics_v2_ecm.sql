-- Metric views for domain: program | Business: Ngo | Version: 2 | Generated on: 2026-07-10 18:25:58

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic program portfolio metrics providing executive visibility into program health, budget scale, geographic spread, and lifecycle status across the NGO's program portfolio."
  source: "`vibe_ngo_v1`.`program`.`program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current lifecycle status of the program (e.g. Active, Closed, Pipeline) — primary filter for portfolio health dashboards."
    - name: "program_type"
      expr: program_type
      comment: "Classification of the program by type (e.g. Emergency, Development, Resilience) — used to segment portfolio by strategic pillar."
    - name: "sector_name"
      expr: sector_name
      comment: "Humanitarian or development sector the program operates in — used for sector-level portfolio analysis."
    - name: "sector_code"
      expr: sector_code
      comment: "Standardised sector code for cross-program sector aggregation and donor reporting."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code where the program operates — enables geographic portfolio breakdown."
    - name: "region"
      expr: region
      comment: "Regional grouping of the program — supports regional portfolio steering and resource allocation decisions."
    - name: "budget_currency"
      expr: budget_currency
      comment: "Currency in which the program budget is denominated — required for currency-aware financial analysis."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating whether the program is an emergency response — used to separate humanitarian surge from development programming."
    - name: "is_multi_year"
      expr: is_multi_year
      comment: "Flag indicating multi-year programs — relevant for long-term funding pipeline and sustainability analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Assessed risk rating of the program — used to prioritise oversight and risk mitigation resources."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG goals the program contributes to — used for impact reporting and donor alignment narratives."
    - name: "cluster_code"
      expr: cluster_code
      comment: "Humanitarian cluster code (e.g. WASH, Nutrition, Shelter) — used for cluster coordination reporting."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the program — flags programs requiring corrective action or at risk of donor non-compliance."
    - name: "start_date"
      expr: start_date
      comment: "Program start date — used for cohort and vintage analysis of the portfolio."
    - name: "end_date"
      expr: end_date
      comment: "Program end date — used to identify programs approaching closeout or overdue for closure."
  measures:
    - name: "total_programs"
      expr: COUNT(DISTINCT program_id)
      comment: "Total number of distinct programs in the portfolio — baseline KPI for portfolio size and coverage."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget committed across all programs — primary financial scale indicator for executive portfolio reviews."
    - name: "avg_program_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per program — used to benchmark program scale and identify outliers requiring additional oversight."
    - name: "active_program_count"
      expr: COUNT(DISTINCT CASE WHEN program_status = 'Active' THEN program_id END)
      comment: "Number of currently active programs — key operational capacity indicator for leadership."
    - name: "emergency_program_count"
      expr: COUNT(DISTINCT CASE WHEN is_emergency = TRUE THEN program_id END)
      comment: "Number of emergency response programs — tracks humanitarian surge capacity and resource commitment."
    - name: "multi_year_program_count"
      expr: COUNT(DISTINCT CASE WHEN is_multi_year = TRUE THEN program_id END)
      comment: "Number of multi-year programs — indicates long-term funding pipeline depth and sustainability commitments."
    - name: "high_risk_program_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating = 'High' THEN program_id END)
      comment: "Number of programs rated high risk — triggers executive oversight and risk mitigation prioritisation."
    - name: "non_compliant_program_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status != 'Compliant' THEN program_id END)
      comment: "Number of programs with non-compliant status — critical for donor relationship management and audit readiness."
    - name: "total_budget_emergency_programs"
      expr: SUM(CAST(CASE WHEN is_emergency = TRUE THEN budget_amount ELSE 0 END AS DOUBLE))
      comment: "Total budget allocated to emergency programs — measures financial commitment to humanitarian response vs development."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_intervention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intervention-level operational and financial metrics enabling program managers and executives to assess intervention portfolio health, budget scale, sector coverage, and compliance with humanitarian standards."
  source: "`vibe_ngo_v1`.`program`.`intervention`"
  dimensions:
    - name: "intervention_status"
      expr: intervention_status
      comment: "Current lifecycle status of the intervention — primary filter for active vs closed intervention analysis."
    - name: "intervention_type"
      expr: intervention_type
      comment: "Type classification of the intervention — used to segment portfolio by modality (e.g. Cash, In-Kind, Service Delivery)."
    - name: "sector"
      expr: sector
      comment: "Sector the intervention operates in — used for sector-level resource allocation and impact analysis."
    - name: "sub_sector"
      expr: sub_sector
      comment: "Sub-sector classification — enables granular sector analysis for technical advisors and donors."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the intervention — used for geographic portfolio analysis and coverage gap identification."
    - name: "phase"
      expr: phase
      comment: "Implementation phase of the intervention — used to track pipeline vs active vs closeout distribution."
    - name: "gender_marker_score"
      expr: gender_marker_score
      comment: "IASC gender marker score — used to assess gender mainstreaming across the intervention portfolio."
    - name: "sdg_goal_primary"
      expr: sdg_goal_primary
      comment: "Primary SDG goal the intervention contributes to — used for SDG impact reporting and donor alignment."
    - name: "chs_compliant"
      expr: chs_compliant
      comment: "Flag indicating CHS (Core Humanitarian Standard) compliance — critical for accountability and quality reporting."
    - name: "safeguarding_policy_applied"
      expr: safeguarding_policy_applied
      comment: "Flag indicating whether safeguarding policy has been applied — used for safeguarding compliance monitoring."
    - name: "planned_start_date"
      expr: planned_start_date
      comment: "Planned start date of the intervention — used for pipeline and scheduling analysis."
    - name: "planned_end_date"
      expr: planned_end_date
      comment: "Planned end date of the intervention — used to identify interventions approaching completion."
  measures:
    - name: "total_interventions"
      expr: COUNT(DISTINCT intervention_id)
      comment: "Total number of distinct interventions — baseline portfolio size metric for operational planning."
    - name: "total_intervention_budget"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budget committed across all interventions — primary financial scale indicator for program portfolio reviews."
    - name: "avg_intervention_budget"
      expr: AVG(CAST(total_budget_amount AS DOUBLE))
      comment: "Average budget per intervention — benchmarks intervention scale and identifies underfunded or oversized interventions."
    - name: "chs_compliant_intervention_count"
      expr: COUNT(DISTINCT CASE WHEN chs_compliant = TRUE THEN intervention_id END)
      comment: "Number of CHS-compliant interventions — measures adherence to Core Humanitarian Standards across the portfolio."
    - name: "safeguarding_applied_count"
      expr: COUNT(DISTINCT CASE WHEN safeguarding_policy_applied = TRUE THEN intervention_id END)
      comment: "Number of interventions with safeguarding policy applied — tracks safeguarding coverage across the portfolio."
    - name: "do_no_harm_completed_count"
      expr: COUNT(DISTINCT CASE WHEN do_no_harm_assessment_completed = TRUE THEN intervention_id END)
      comment: "Number of interventions with completed Do No Harm assessments — measures risk management compliance."
    - name: "environmental_assessment_completed_count"
      expr: COUNT(DISTINCT CASE WHEN environmental_impact_assessment_completed = TRUE THEN intervention_id END)
      comment: "Number of interventions with completed environmental impact assessments — tracks environmental compliance."
    - name: "rbm_framework_applied_count"
      expr: COUNT(DISTINCT CASE WHEN rbm_framework_applied = TRUE THEN intervention_id END)
      comment: "Number of interventions using Results-Based Management framework — measures MEL quality and donor reporting readiness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program budget plan metrics providing financial oversight of planned vs approved budgets, cost structure analysis, and budget health across the program portfolio."
  source: "`vibe_ngo_v1`.`program`.`budget_plan`"
  dimensions:
    - name: "budget_status"
      expr: budget_status
      comment: "Approval and lifecycle status of the budget plan — used to filter active vs draft vs approved budgets."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget plan (e.g. Original, Revised, Supplemental) — used to track budget revision history."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget plan — required for multi-currency financial analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code — used for donor reporting and sector-level budget allocation analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the budget plan — used for SDG-tagged financial reporting."
    - name: "budget_period_start_date"
      expr: budget_period_start_date
      comment: "Start of the budget period — used for time-series budget analysis and fiscal year comparisons."
    - name: "budget_period_end_date"
      expr: budget_period_end_date
      comment: "End of the budget period — used to identify expiring budgets requiring reallocation."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Flag indicating whether the budget is visible to donors — used to segment internal vs donor-facing budget views."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget_amount AS DOUBLE))
      comment: "Total approved budget across all budget plans — primary financial commitment metric for executive portfolio reviews."
    - name: "total_direct_costs"
      expr: SUM(CAST(total_direct_costs AS DOUBLE))
      comment: "Total direct costs across budget plans — measures programmatic spend excluding overhead."
    - name: "total_personnel_costs"
      expr: SUM(CAST(personnel_costs AS DOUBLE))
      comment: "Total personnel costs across budget plans — largest cost driver; used for workforce cost management decisions."
    - name: "total_indirect_costs"
      expr: SUM(CAST(indirect_costs AS DOUBLE))
      comment: "Total indirect costs (overhead) across budget plans — used to monitor overhead rate compliance with donor limits."
    - name: "total_travel_costs"
      expr: SUM(CAST(travel_costs AS DOUBLE))
      comment: "Total travel costs across budget plans — monitored for cost efficiency and donor travel cost restrictions."
    - name: "total_supplies_costs"
      expr: SUM(CAST(supplies_costs AS DOUBLE))
      comment: "Total supplies costs across budget plans — key input for supply chain planning and procurement forecasting."
    - name: "total_equipment_costs"
      expr: SUM(CAST(equipment_costs AS DOUBLE))
      comment: "Total equipment costs across budget plans — used for asset management and capital expenditure oversight."
    - name: "total_cost_share_amount"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost share contributions across budget plans — measures co-financing leverage and donor match compliance."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across budget plans — benchmarks overhead efficiency and donor rate compliance."
    - name: "budget_plan_count"
      expr: COUNT(DISTINCT budget_plan_id)
      comment: "Total number of budget plans — used to track budget planning activity and revision frequency."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_budget_plan_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular budget line metrics enabling cost category analysis, unit cost benchmarking, and budget allocation efficiency across program budget plans."
  source: "`vibe_ngo_v1`.`program`.`budget_plan_line`"
  dimensions:
    - name: "budget_plan_line_status"
      expr: budget_plan_line_status
      comment: "Status of the budget line — used to filter active vs cancelled vs approved lines."
    - name: "cost_category"
      expr: cost_category
      comment: "High-level cost category (e.g. Personnel, Travel, Supplies) — primary dimension for cost structure analysis."
    - name: "cost_subcategory"
      expr: cost_subcategory
      comment: "Detailed cost sub-category — enables granular cost breakdown for budget management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget line — required for multi-currency financial analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code on the budget line — used for sector-level cost allocation reporting."
    - name: "direct_cost_flag"
      expr: direct_cost_flag
      comment: "Flag indicating whether the line is a direct cost — used to separate direct vs indirect cost analysis."
    - name: "cost_sharing_flag"
      expr: cost_sharing_flag
      comment: "Flag indicating cost-sharing lines — used to track co-financing contributions at line level."
    - name: "allowable_cost_flag"
      expr: allowable_cost_flag
      comment: "Flag indicating donor-allowable costs — used to identify lines at risk of disallowance during audits."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line — used for annual budget analysis and year-over-year comparisons."
    - name: "budget_period_start_date"
      expr: budget_period_start_date
      comment: "Start of the budget period for this line — used for time-phased budget analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total planned budget amount across all lines — primary financial planning metric for budget management."
    - name: "total_cost_sharing_amount"
      expr: SUM(CAST(cost_sharing_amount AS DOUBLE))
      comment: "Total cost-sharing contributions at line level — measures co-financing leverage and donor match compliance."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across budget lines — used for cost benchmarking and value-for-money analysis."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units planned across budget lines — used for procurement planning and supply forecasting."
    - name: "budget_line_count"
      expr: COUNT(DISTINCT budget_plan_line_id)
      comment: "Total number of budget lines — measures budget plan granularity and planning detail."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate at line level — used to monitor overhead allocation consistency across budget lines."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_closeout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program closeout metrics providing executive visibility into financial reconciliation, compliance certification, donor sign-off, and beneficiary reach at program completion — critical for donor accountability and audit readiness."
  source: "`vibe_ngo_v1`.`program`.`program_closeout`"
  dimensions:
    - name: "program_closeout_status"
      expr: program_closeout_status
      comment: "Current status of the closeout process — used to track closeout pipeline and identify stalled closures."
    - name: "program_closeout_type"
      expr: program_closeout_type
      comment: "Type of closeout (e.g. Planned, Early Termination, Emergency) — used to segment closeout analysis by cause."
    - name: "donor_signoff_status"
      expr: donor_signoff_status
      comment: "Status of donor sign-off on the closeout — critical for grant compliance and final payment release."
    - name: "audit_completion_status"
      expr: audit_completion_status
      comment: "Status of the final audit — used to track audit completion and identify programs with outstanding audit obligations."
    - name: "final_financial_reconciliation_status"
      expr: final_financial_reconciliation_status
      comment: "Status of final financial reconciliation — used to identify programs with unresolved financial discrepancies."
    - name: "compliance_certification_flag"
      expr: compliance_certification_flag
      comment: "Flag indicating compliance certification has been obtained — used for donor reporting and audit readiness."
    - name: "outstanding_obligations_flag"
      expr: outstanding_obligations_flag
      comment: "Flag indicating outstanding financial or programmatic obligations — used to prioritise closeout resolution actions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the closeout financial figures — required for multi-currency financial analysis."
    - name: "program_end_date"
      expr: program_end_date
      comment: "Official program end date — used for closeout timeliness analysis."
    - name: "completion_date"
      expr: completion_date
      comment: "Actual closeout completion date — used to measure closeout cycle time."
  measures:
    - name: "total_final_budget"
      expr: SUM(CAST(final_budget_amount AS DOUBLE))
      comment: "Total final approved budget across closed programs — baseline for financial reconciliation analysis."
    - name: "total_final_expenditure"
      expr: SUM(CAST(final_expenditure_amount AS DOUBLE))
      comment: "Total actual expenditure at closeout — compared against final budget to assess financial performance."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance (over/underspend) at closeout — key financial accountability metric for donor reporting."
    - name: "avg_budget_utilization_pct"
      expr: AVG(CAST(budget_utilization_percentage AS DOUBLE))
      comment: "Average budget utilization percentage at closeout — measures financial efficiency and identifies chronic underspend patterns."
    - name: "closeout_count"
      expr: COUNT(DISTINCT program_closeout_id)
      comment: "Total number of program closeouts — tracks closeout pipeline volume and completion throughput."
    - name: "programs_with_outstanding_obligations"
      expr: COUNT(DISTINCT CASE WHEN outstanding_obligations_flag = TRUE THEN program_closeout_id END)
      comment: "Number of closeouts with outstanding obligations — identifies programs requiring urgent resolution to avoid donor penalties."
    - name: "donor_signoff_pending_count"
      expr: COUNT(DISTINCT CASE WHEN donor_signoff_status != 'Approved' THEN program_closeout_id END)
      comment: "Number of closeouts awaiting donor sign-off — tracks donor approval pipeline and potential payment release blockers."
    - name: "compliance_certified_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_certification_flag = TRUE THEN program_closeout_id END)
      comment: "Number of closeouts with compliance certification obtained — measures regulatory and donor compliance at program end."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program amendment metrics tracking scope changes, budget revisions, and timeline extensions — used by program directors and donors to assess program stability and change management effectiveness."
  source: "`vibe_ngo_v1`.`program`.`program_amendment`"
  dimensions:
    - name: "program_amendment_status"
      expr: program_amendment_status
      comment: "Current approval status of the amendment — used to track amendment pipeline and approval bottlenecks."
    - name: "program_amendment_type"
      expr: program_amendment_type
      comment: "Type of amendment (e.g. Budget, Timeline, Scope) — used to categorise change drivers across the portfolio."
    - name: "grant_requirement_flag"
      expr: grant_requirement_flag
      comment: "Flag indicating whether the amendment requires donor/grant approval — used to prioritise donor engagement."
    - name: "logframe_revision_flag"
      expr: logframe_revision_flag
      comment: "Flag indicating whether the amendment triggers a logframe revision — used to track MEL framework stability."
    - name: "budget_change_currency"
      expr: budget_change_currency
      comment: "Currency of the budget change amount — required for multi-currency amendment analysis."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the amendment takes effect — used for time-series amendment trend analysis."
    - name: "submission_date"
      expr: submission_date
      comment: "Date the amendment was submitted for approval — used to measure amendment processing cycle time."
  measures:
    - name: "total_amendments"
      expr: COUNT(DISTINCT program_amendment_id)
      comment: "Total number of program amendments — measures program change frequency and portfolio stability."
    - name: "total_budget_change_amount"
      expr: SUM(CAST(budget_change_amount AS DOUBLE))
      comment: "Total net budget change across all amendments — measures cumulative financial scope change in the portfolio."
    - name: "avg_budget_change_amount"
      expr: AVG(CAST(budget_change_amount AS DOUBLE))
      comment: "Average budget change per amendment — benchmarks amendment scale and identifies outlier scope changes."
    - name: "donor_approval_required_count"
      expr: COUNT(DISTINCT CASE WHEN grant_requirement_flag = TRUE THEN program_amendment_id END)
      comment: "Number of amendments requiring donor approval — tracks donor engagement workload and approval pipeline."
    - name: "logframe_revision_count"
      expr: COUNT(DISTINCT CASE WHEN logframe_revision_flag = TRUE THEN program_amendment_id END)
      comment: "Number of amendments triggering logframe revisions — measures MEL framework instability across the portfolio."
    - name: "pending_amendment_count"
      expr: COUNT(DISTINCT CASE WHEN program_amendment_status = 'Pending' THEN program_amendment_id END)
      comment: "Number of amendments currently pending approval — identifies approval bottlenecks requiring management attention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_review_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program review event metrics providing visibility into reporting compliance, beneficiary reach, and financial performance at review milestones — used by program managers and donors to assess program progress."
  source: "`vibe_ngo_v1`.`program`.`review_event`"
  dimensions:
    - name: "review_event_status"
      expr: review_event_status
      comment: "Status of the review event (e.g. Submitted, Approved, Overdue) — used to track reporting compliance."
    - name: "review_event_type"
      expr: review_event_type
      comment: "Type of review event (e.g. Quarterly Report, Mid-Term Review, Final Evaluation) — used to segment reporting analysis."
    - name: "chs_compliance_flag"
      expr: chs_compliance_flag
      comment: "Flag indicating CHS compliance at the review event — used for accountability and quality reporting."
    - name: "sphere_standards_applied_flag"
      expr: sphere_standards_applied_flag
      comment: "Flag indicating Sphere standards were applied — used for humanitarian quality assurance reporting."
    - name: "donor_visibility_flag"
      expr: donor_visibility_flag
      comment: "Flag indicating whether the review is visible to donors — used to segment internal vs donor-facing reporting."
    - name: "cluster_submission_flag"
      expr: cluster_submission_flag
      comment: "Flag indicating submission to humanitarian cluster — used for cluster coordination reporting compliance."
    - name: "financial_summary_currency_code"
      expr: financial_summary_currency_code
      comment: "Currency of the financial summary — required for multi-currency financial analysis."
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start of the reporting period — used for time-series progress analysis."
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End of the reporting period — used to identify overdue reports and reporting gaps."
  measures:
    - name: "total_review_events"
      expr: COUNT(DISTINCT review_event_id)
      comment: "Total number of review events — baseline reporting activity metric for compliance monitoring."
    - name: "total_beneficiary_reach"
      expr: SUM(CAST(beneficiary_reach_total AS DOUBLE))
      comment: "Total beneficiaries reached across all review events — primary impact metric for donor and board reporting."
    - name: "total_beneficiary_reach_female"
      expr: SUM(CAST(beneficiary_reach_female AS DOUBLE))
      comment: "Total female beneficiaries reached — used for gender disaggregation reporting and gender marker compliance."
    - name: "total_beneficiary_reach_male"
      expr: SUM(CAST(beneficiary_reach_male AS DOUBLE))
      comment: "Total male beneficiaries reached — used for gender disaggregation reporting."
    - name: "total_beneficiary_reach_children"
      expr: SUM(CAST(beneficiary_reach_children AS DOUBLE))
      comment: "Total children reached — used for child-focused programming analysis and donor reporting."
    - name: "total_financial_budget"
      expr: SUM(CAST(financial_summary_budget_amount AS DOUBLE))
      comment: "Total budget reported across review events — used for financial progress tracking."
    - name: "total_financial_expenditure"
      expr: SUM(CAST(financial_summary_expenditure_amount AS DOUBLE))
      comment: "Total expenditure reported across review events — used to track burn rate and financial progress."
    - name: "chs_compliant_review_count"
      expr: COUNT(DISTINCT CASE WHEN chs_compliance_flag = TRUE THEN review_event_id END)
      comment: "Number of review events confirming CHS compliance — measures accountability standard adherence across reporting periods."
    - name: "avg_beneficiary_reach_per_review"
      expr: AVG(CAST(beneficiary_reach_total AS DOUBLE))
      comment: "Average beneficiaries reached per review event — benchmarks program reach efficiency and identifies underperforming programs."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_risk_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program risk register metrics providing executive visibility into risk exposure, mitigation coverage, and risk escalation patterns across the program portfolio."
  source: "`vibe_ngo_v1`.`program`.`risk_register`"
  dimensions:
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk (e.g. Open, Mitigated, Closed, Escalated) — primary filter for active risk monitoring."
    - name: "risk_category"
      expr: risk_category
      comment: "Category of the risk (e.g. Financial, Operational, Safeguarding, Compliance) — used for risk portfolio analysis."
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Sub-category of the risk — enables granular risk analysis for risk managers."
    - name: "risk_level"
      expr: risk_level
      comment: "Overall risk level (e.g. Low, Medium, High, Critical) — primary dimension for risk prioritisation dashboards."
    - name: "impact_rating"
      expr: impact_rating
      comment: "Impact rating of the risk — used to assess potential consequence severity."
    - name: "likelihood_rating"
      expr: likelihood_rating
      comment: "Likelihood rating of the risk — used to assess probability of occurrence."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Flag indicating whether the risk requires escalation — used to prioritise management attention."
    - name: "affected_sector"
      expr: affected_sector
      comment: "Sector affected by the risk — used for sector-level risk exposure analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the risk — used for geographic risk concentration analysis."
    - name: "identification_date"
      expr: identification_date
      comment: "Date the risk was identified — used for risk aging analysis and trend monitoring."
  measures:
    - name: "total_risks"
      expr: COUNT(DISTINCT risk_register_id)
      comment: "Total number of risks in the register — baseline risk portfolio size metric."
    - name: "open_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_status = 'Open' THEN risk_register_id END)
      comment: "Number of currently open risks — primary operational risk monitoring metric for program managers."
    - name: "high_critical_risk_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level IN ('High', 'Critical') THEN risk_register_id END)
      comment: "Number of high or critical risks — triggers executive escalation and resource reallocation decisions."
    - name: "escalation_required_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_required_flag = TRUE THEN risk_register_id END)
      comment: "Number of risks requiring escalation — identifies risks needing immediate senior management attention."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation — measures overall portfolio risk exposure post-mitigation."
    - name: "avg_inherent_risk_score"
      expr: AVG(CAST(inherent_risk_score AS DOUBLE))
      comment: "Average inherent risk score before mitigation — benchmarks gross risk exposure across the portfolio."
    - name: "avg_likelihood_score"
      expr: AVG(CAST(likelihood_score AS DOUBLE))
      comment: "Average likelihood score across risks — used to assess overall probability of risk materialisation."
    - name: "avg_impact_score"
      expr: AVG(CAST(impact_score AS DOUBLE))
      comment: "Average impact score across risks — used to assess potential consequence severity across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_partner_linkage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner linkage metrics providing visibility into partner performance, capacity, compliance, and financial accountability across program partnerships — used by partnership managers and program directors."
  source: "`vibe_ngo_v1`.`program`.`partner_linkage`"
  dimensions:
    - name: "partnership_status"
      expr: partnership_status
      comment: "Current status of the partnership (e.g. Active, Suspended, Closed) — primary filter for active partner monitoring."
    - name: "partnership_type"
      expr: partnership_type
      comment: "Type of partnership (e.g. Sub-grant, MOU, Service Agreement) — used to segment partnership portfolio by modality."
    - name: "partnership_role"
      expr: partnership_role
      comment: "Role of the partner in the intervention — used to analyse partner contribution types."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating of the partner — primary KPI for partner accountability and renewal decisions."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the partnership — used to prioritise monitoring visits and capacity building."
    - name: "capacity_assessment_status"
      expr: capacity_assessment_status
      comment: "Status of the partner capacity assessment — used to track due diligence compliance."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the partnership — flags partnerships at risk of non-compliance."
    - name: "local_partner_flag"
      expr: local_partner_flag
      comment: "Flag indicating local partner — used to track localisation agenda progress."
    - name: "community_based_organization_flag"
      expr: community_based_organization_flag
      comment: "Flag indicating community-based organisation — used for CBO engagement analysis."
    - name: "capacity_building_required_flag"
      expr: capacity_building_required_flag
      comment: "Flag indicating capacity building is required — used to plan and resource partner support activities."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the partnership — used for geographic partner coverage analysis."
    - name: "sector_focus"
      expr: sector_focus
      comment: "Sector focus of the partnership — used for sector-level partner portfolio analysis."
  measures:
    - name: "total_partner_linkages"
      expr: COUNT(DISTINCT partner_linkage_id)
      comment: "Total number of partner linkages — baseline metric for partnership portfolio size."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated_amount AS DOUBLE))
      comment: "Total budget allocated to partners — measures financial scale of partnership portfolio and sub-grant commitments."
    - name: "avg_capacity_assessment_score"
      expr: AVG(CAST(capacity_assessment_score AS DOUBLE))
      comment: "Average partner capacity assessment score — benchmarks partner capability and identifies capacity gaps requiring investment."
    - name: "local_partner_count"
      expr: COUNT(DISTINCT CASE WHEN local_partner_flag = TRUE THEN partner_linkage_id END)
      comment: "Number of local partner linkages — measures localisation agenda progress and local partner engagement."
    - name: "high_risk_partner_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating = 'High' THEN partner_linkage_id END)
      comment: "Number of high-risk partnerships — triggers enhanced monitoring and risk mitigation actions."
    - name: "capacity_building_required_count"
      expr: COUNT(DISTINCT CASE WHEN capacity_building_required_flag = TRUE THEN partner_linkage_id END)
      comment: "Number of partnerships requiring capacity building — used to plan and resource partner support programmes."
    - name: "avg_monitoring_visit_count"
      expr: AVG(CAST(monitoring_visit_count AS DOUBLE))
      comment: "Average number of monitoring visits per partnership — measures oversight intensity and partner accountability."
    - name: "non_compliant_partner_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status != 'Compliant' THEN partner_linkage_id END)
      comment: "Number of non-compliant partnerships — critical for donor accountability and sub-grant management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_logframe_row`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logframe row metrics providing visibility into results framework coverage, target setting, and baseline data quality — used by MEL teams and program directors to assess results framework completeness."
  source: "`vibe_ngo_v1`.`program`.`logframe_row`"
  dimensions:
    - name: "logframe_row_status"
      expr: logframe_row_status
      comment: "Status of the logframe row (e.g. Active, Archived, Draft) — used to filter active results framework entries."
    - name: "result_level"
      expr: result_level
      comment: "Results chain level (e.g. Input, Activity, Output, Outcome, Impact) — primary dimension for results framework analysis."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting for this logframe row — used to plan MEL data collection schedules."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect data for this indicator — used to assess data quality and collection feasibility."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "SDG alignment of the logframe row — used for SDG contribution reporting."
    - name: "sector_classification"
      expr: sector_classification
      comment: "Sector classification of the logframe row — used for sector-level results analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the logframe row — used for geographic results coverage analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the logframe row is currently active — used to filter active vs archived results."
    - name: "target_date"
      expr: target_date
      comment: "Target achievement date for the logframe row — used for results timeline analysis."
  measures:
    - name: "total_logframe_rows"
      expr: COUNT(DISTINCT logframe_row_id)
      comment: "Total number of logframe rows — measures results framework size and complexity."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total target value across logframe rows — aggregated results target for portfolio-level impact planning."
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Total baseline value across logframe rows — used to contextualise target ambition and measure change."
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated to logframe rows — measures financial investment in results delivery."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per logframe row — benchmarks target ambition and identifies outlier targets."
    - name: "active_logframe_row_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN logframe_row_id END)
      comment: "Number of active logframe rows — measures current results framework scope and monitoring workload."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`program_intervention_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intervention compliance metrics tracking donor requirement fulfilment, effort costs, and waiver patterns — used by compliance officers and program directors to manage donor obligations and audit risk."
  source: "`vibe_ngo_v1`.`program`.`intervention_compliance`"
  dimensions:
    - name: "requirement_status"
      expr: requirement_status
      comment: "Status of the compliance requirement (e.g. Met, Pending, Overdue, Waived) — primary filter for compliance monitoring."
    - name: "deliverable_format"
      expr: deliverable_format
      comment: "Format of the compliance deliverable (e.g. Report, Audit, Certification) — used to categorise compliance workload."
    - name: "waiver_granted_flag"
      expr: waiver_granted_flag
      comment: "Flag indicating a compliance waiver was granted — used to track waiver frequency and donor flexibility."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the compliance cost — required for multi-currency compliance cost analysis."
    - name: "due_date"
      expr: due_date
      comment: "Due date for the compliance requirement — used to identify overdue obligations and prioritise actions."
    - name: "submission_date"
      expr: submission_date
      comment: "Date the compliance deliverable was submitted — used to measure compliance timeliness."
  measures:
    - name: "total_compliance_requirements"
      expr: COUNT(DISTINCT intervention_compliance_id)
      comment: "Total number of compliance requirements across interventions — measures overall compliance workload."
    - name: "total_compliance_cost"
      expr: SUM(CAST(associated_cost_amount AS DOUBLE))
      comment: "Total cost associated with compliance activities — measures financial burden of donor requirements."
    - name: "total_compliance_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total staff effort hours spent on compliance — measures human resource cost of donor requirement fulfilment."
    - name: "avg_compliance_effort_hours"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average effort hours per compliance requirement — benchmarks compliance efficiency and identifies high-burden requirements."
    - name: "waiver_count"
      expr: COUNT(DISTINCT CASE WHEN waiver_granted_flag = TRUE THEN intervention_compliance_id END)
      comment: "Number of compliance waivers granted — tracks donor flexibility and compliance risk patterns."
    - name: "overdue_requirement_count"
      expr: COUNT(DISTINCT CASE WHEN requirement_status = 'Overdue' THEN intervention_compliance_id END)
      comment: "Number of overdue compliance requirements — critical risk indicator for donor relationship management and audit exposure."
$$;