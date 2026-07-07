-- Metric views for domain: bid | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid governance and approval metrics covering approval scores, margin approvals, risk ratings, and decision outcomes. Used by governance committees and executives to ensure bid approvals meet strategic, financial, and risk thresholds."
  source: "`vibe_construction_v1`.`bid`.`approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval (e.g. pending, approved, rejected) for governance pipeline tracking."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Final decision outcome (e.g. approved, rejected, conditional) for approval effectiveness analysis."
    - name: "decision_stage"
      expr: decision_stage
      comment: "Stage of the decision process (e.g. pre-bid, post-tender) for governance workflow analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the approved bid for risk-adjusted portfolio governance."
    - name: "delegation_of_authority_level"
      expr: delegation_of_authority_level
      comment: "Level of delegation of authority required for the approval, tracking governance escalation patterns."
    - name: "is_conditional"
      expr: is_conditional
      comment: "Indicates conditional approvals requiring additional conditions to be met before proceeding."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the approved bid price for multi-currency governance reporting."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month of approval decision for time-series governance activity analysis."
  measures:
    - name: "total_approvals"
      expr: COUNT(1)
      comment: "Total number of bid approvals processed. Baseline governance activity metric."
    - name: "total_approved_bid_price"
      expr: SUM(CAST(approved_bid_price AS DOUBLE))
      comment: "Total approved bid price across all approvals. Tracks the aggregate value of bids sanctioned through governance."
    - name: "avg_approved_margin_pct"
      expr: AVG(CAST(approved_margin_pct AS DOUBLE))
      comment: "Average approved margin percentage. The primary governance KPI — ensures bids are approved only above minimum margin thresholds."
    - name: "avg_total_governance_score"
      expr: AVG(CAST(total_governance_score AS DOUBLE))
      comment: "Average total governance score across approvals. Composite score tracking strategic fit, risk, and financial quality of approved bids."
    - name: "avg_strategic_fit_score"
      expr: AVG(CAST(strategic_fit_score AS DOUBLE))
      comment: "Average strategic fit score. Tracks whether approved bids align with corporate strategy and target markets."
    - name: "avg_risk_profile_score"
      expr: AVG(CAST(risk_profile_score AS DOUBLE))
      comment: "Average risk profile score across approved bids. Tracks the risk quality of the approved bid portfolio."
    - name: "conditional_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_conditional = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approvals that are conditional. A high rate indicates governance concerns requiring additional conditions before bid submission."
    - name: "avg_bonding_capacity_score"
      expr: AVG(CAST(bonding_capacity_score AS DOUBLE))
      comment: "Average bonding capacity score across approvals. Tracks whether approved bids are within the firm's bonding capacity limits."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_bond`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid bond portfolio metrics covering bond values, expiry management, and compliance. Used by treasury and commercial teams to manage bonding capacity utilisation and ensure bond compliance."
  source: "`vibe_construction_v1`.`bid`.`bond`"
  dimensions:
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond (e.g. bid bond, performance bond, advance payment bond) for bond portfolio composition analysis."
    - name: "bond_status"
      expr: bond_status
      comment: "Current status of the bond (e.g. active, expired, released, called) for bond lifecycle management."
    - name: "issuer_type"
      expr: issuer_type
      comment: "Type of bond issuer (e.g. bank, surety company) for counterparty risk analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the bond for risk-adjusted portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bond for multi-currency exposure analysis."
    - name: "compliance_requirements_met"
      expr: compliance_requirements_met
      comment: "Indicates whether bond compliance requirements are met for compliance monitoring."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of bond expiry for renewal pipeline management and cash flow planning."
  measures:
    - name: "total_bonds"
      expr: COUNT(1)
      comment: "Total number of bonds in the portfolio. Baseline metric for bond portfolio size."
    - name: "total_bond_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total bond amount across the portfolio. Primary metric for total bonding capacity utilisation."
    - name: "avg_bond_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average bond percentage of contract value. Tracks standard bonding requirements and their financial impact."
    - name: "expiring_within_30_days"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND bond_status = 'Active' THEN 1 END)
      comment: "Number of active bonds expiring within 30 days. Critical operational metric for proactive bond renewal to avoid compliance breaches."
    - name: "non_compliant_bond_count"
      expr: COUNT(CASE WHEN compliance_requirements_met = FALSE THEN 1 END)
      comment: "Number of bonds not meeting compliance requirements. Tracks compliance risk in the bond portfolio."
    - name: "total_extended_bonds"
      expr: COUNT(CASE WHEN guarantee_extension_allowed = TRUE THEN 1 END)
      comment: "Number of bonds with extension provisions. Tracks flexibility in the bond portfolio for project timeline changes."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Estimating accuracy and cost metrics covering total estimated cost, margin, contingency, and escalation across bid estimates. Used by chief estimators and CFOs to assess estimating quality, margin targets, and cost competitiveness."
  source: "`vibe_construction_v1`.`bid`.`estimate`"
  dimensions:
    - name: "estimate_type"
      expr: estimate_type
      comment: "Type of estimate (e.g. conceptual, detailed, definitive) for accuracy benchmarking by estimate class."
    - name: "estimate_category"
      expr: estimate_category
      comment: "Category of estimate (e.g. civil, MEP, fit-out) for cost structure analysis."
    - name: "estimate_status"
      expr: estimate_status
      comment: "Current status of the estimate (e.g. draft, approved, submitted) for workflow tracking."
    - name: "estimating_method"
      expr: estimating_method
      comment: "Method used to develop the estimate (e.g. parametric, bottom-up, analogous) for methodology effectiveness analysis."
    - name: "is_gmp"
      expr: is_gmp
      comment: "Indicates whether the estimate is for a Guaranteed Maximum Price contract, which carries higher margin risk."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Indicates lump sum pricing structure for contract type mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimate for multi-currency cost analysis."
    - name: "base_pricing_date_month"
      expr: DATE_TRUNC('MONTH', base_pricing_date)
      comment: "Month of base pricing date for escalation and inflation trend analysis."
  measures:
    - name: "total_estimates"
      expr: COUNT(1)
      comment: "Total number of estimates produced. Baseline volume metric for estimating team workload."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all estimates. Primary cost volume metric for the bid portfolio."
    - name: "avg_estimated_cost"
      expr: AVG(CAST(total_estimated_cost AS DOUBLE))
      comment: "Average estimated cost per estimate. Tracks deal size and complexity trends in the bid portfolio."
    - name: "avg_profit_margin_pct"
      expr: AVG(CAST(profit_margin_percentage AS DOUBLE))
      comment: "Average profit margin percentage across estimates. The most critical estimating KPI — directly measures whether bids are priced to achieve target returns."
    - name: "avg_contingency_pct"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage applied to estimates. Tracks risk provisioning levels and estimating conservatism."
    - name: "avg_overhead_pct"
      expr: AVG(CAST(overhead_percentage AS DOUBLE))
      comment: "Average overhead percentage applied. Tracks overhead recovery rates and cost structure competitiveness."
    - name: "total_escalation_allowance"
      expr: SUM(CAST(escalation_allowance AS DOUBLE))
      comment: "Total escalation allowance across estimates. Tracks inflation risk provisioning in the bid portfolio."
    - name: "avg_risk_factor"
      expr: AVG(CAST(risk_factor AS DOUBLE))
      comment: "Average risk factor applied to estimates. Indicates the aggregate risk premium being priced into bids."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_estimate_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed cost breakdown metrics at the estimate line level covering cost by category, unit rates, productivity, and variance. Used by estimators and project controllers to validate cost assumptions and identify pricing anomalies."
  source: "`vibe_construction_v1`.`bid`.`estimate_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category of the estimate line (e.g. labour, material, plant, subcontract) for cost structure analysis."
    - name: "estimate_line_status"
      expr: estimate_line_status
      comment: "Status of the estimate line (e.g. active, revised, deleted) for data quality filtering."
    - name: "material_type"
      expr: material_type
      comment: "Type of material for material cost composition analysis."
    - name: "labor_grade"
      expr: labor_grade
      comment: "Labour grade for workforce cost analysis and rate benchmarking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based cost analysis."
    - name: "wbs_element"
      expr: wbs_element
      comment: "WBS element code for cost breakdown by work package."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimate line for multi-currency cost analysis."
  measures:
    - name: "total_line_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost across all estimate lines. Primary cost aggregation metric for bottom-up estimate validation."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per estimate line. Used for rate benchmarking against historical data and market rates."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across estimate lines. Used for scope volume analysis and productivity planning."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance between baseline and revised estimates. Tracks scope change and estimating revision impact on total cost."
    - name: "avg_productivity_factor"
      expr: AVG(CAST(productivity_factor AS DOUBLE))
      comment: "Average productivity factor applied across estimate lines. Tracks productivity assumptions and their impact on labour cost competitiveness."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across estimate lines. Tracks tax exposure in the bid cost structure."
    - name: "avg_waste_factor"
      expr: AVG(CAST(waste_factor AS DOUBLE))
      comment: "Average waste factor applied to material estimate lines. Tracks material waste assumptions and their cost impact."
    - name: "total_revised_cost"
      expr: SUM(CAST(revised_cost AS DOUBLE))
      comment: "Total revised cost after change orders and adjustments. Reflects the current best estimate of total cost."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_subcontractor_bond`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontractor bond metrics covering bond values, premium costs, claim activity, and compliance. Used by commercial and risk teams to manage subcontractor default risk and bond portfolio health."
  source: "`vibe_construction_v1`.`bid`.`subcontractor_bond`"
  dimensions:
    - name: "bond_type"
      expr: bond_type
      comment: "Type of subcontractor bond (e.g. performance, payment, warranty) for bond portfolio composition analysis."
    - name: "bond_status"
      expr: bond_status
      comment: "Current status of the bond (e.g. active, expired, claimed, released) for lifecycle management."
    - name: "bond_form"
      expr: bond_form
      comment: "Form of the bond (e.g. AIA A312, custom) for standardisation analysis."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Indicates bonds requiring renewal for proactive renewal management."
    - name: "bond_currency_code"
      expr: bond_currency_code
      comment: "Currency of the bond for multi-currency exposure analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of bond expiry for renewal pipeline management."
  measures:
    - name: "total_subcontractor_bonds"
      expr: COUNT(1)
      comment: "Total number of subcontractor bonds. Baseline metric for subcontractor bond portfolio size."
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount AS DOUBLE))
      comment: "Total subcontractor bond amount. Tracks total financial protection from subcontractor default."
    - name: "total_bond_premium"
      expr: SUM(CAST(bond_premium_amount AS DOUBLE))
      comment: "Total bond premium cost. Tracks the cost of subcontractor bond protection in the project portfolio."
    - name: "total_claim_amount"
      expr: SUM(CAST(claim_amount AS DOUBLE))
      comment: "Total amount claimed against subcontractor bonds. Tracks subcontractor default exposure and bond call activity."
    - name: "total_claim_paid_amount"
      expr: SUM(CAST(claim_paid_amount AS DOUBLE))
      comment: "Total amount paid out on bond claims. Tracks actual subcontractor default losses recovered through bonds."
    - name: "claim_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(claim_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(claim_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed bond amounts that have been paid out. Tracks bond claim recovery effectiveness."
    - name: "avg_bond_percentage"
      expr: AVG(CAST(bond_percentage AS DOUBLE))
      comment: "Average bond percentage of subcontract value. Tracks standard bonding requirements across the subcontract portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_subcontractor_prequalification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontractor prequalification metrics covering qualification scores, financial capacity, bonding limits, and approval rates. Used by procurement and risk teams to maintain a qualified subcontractor pool and manage supply chain risk."
  source: "`vibe_construction_v1`.`bid`.`subcontractor_prequalification`"
  dimensions:
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification status (e.g. approved, pending, expired, rejected) for supply chain qualification pipeline tracking."
    - name: "trade_category"
      expr: trade_category
      comment: "Trade category of the subcontractor for qualification coverage analysis by trade."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the prequalification for regional supply chain coverage analysis."
    - name: "reference_check_completed"
      expr: reference_check_completed
      comment: "Indicates whether reference checks have been completed, tracking due diligence thoroughness."
    - name: "financial_statements_verified"
      expr: financial_statements_verified
      comment: "Indicates whether financial statements have been verified, tracking financial due diligence completion."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of prequalification submission for time-series qualification activity analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of prequalification expiry for renewal pipeline management."
  measures:
    - name: "total_prequalifications"
      expr: COUNT(1)
      comment: "Total number of subcontractor prequalifications. Baseline metric for qualified supply chain pool size."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall prequalification score. Primary quality metric for the subcontractor pool — a declining average signals supply chain quality deterioration."
    - name: "avg_financial_capacity_score"
      expr: AVG(CAST(financial_capacity_score AS DOUBLE))
      comment: "Average financial capacity score. Tracks the financial health of the qualified subcontractor pool."
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score. Tracks technical competence levels in the qualified supply chain."
    - name: "avg_safety_record_score"
      expr: AVG(CAST(safety_record_score AS DOUBLE))
      comment: "Average safety record score. Tracks HSSE performance quality of the qualified subcontractor pool."
    - name: "total_bonding_limit"
      expr: SUM(CAST(bonding_limit_amount AS DOUBLE))
      comment: "Total bonding limit capacity across qualified subcontractors. Tracks aggregate bonding capacity available in the supply chain."
    - name: "avg_maximum_contract_value"
      expr: AVG(CAST(maximum_contract_value AS DOUBLE))
      comment: "Average maximum contract value approved per subcontractor. Tracks the scale of work the qualified pool can absorb."
    - name: "expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of approved prequalifications expiring within 90 days. Critical operational metric for proactive renewal management to avoid supply chain gaps."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid submission performance metrics covering submission volume, bid pricing, technical and commercial scores, and compliance. Used by bid directors to evaluate submission quality, pricing competitiveness, and process adherence."
  source: "`vibe_construction_v1`.`bid`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (e.g. submitted, under review, awarded) for pipeline stage analysis."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid submitted (e.g. lump sum, unit rate) for contract structure mix analysis."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Indicates joint venture submissions for JV vs. solo performance comparison."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the submission for risk-adjusted performance analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the submission for regional performance benchmarking."
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Indicates whether the submission was submitted after the deadline. Used to track process discipline."
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Evaluation method used by the client (e.g. lowest price, best value) for strategy alignment analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission for time-series volume and value trend analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of bid submissions. Baseline volume metric for bid activity tracking."
    - name: "total_bid_price"
      expr: SUM(CAST(bid_price AS DOUBLE))
      comment: "Total bid price across all submissions. Tracks the aggregate value of bids submitted to market."
    - name: "avg_bid_price"
      expr: AVG(CAST(bid_price AS DOUBLE))
      comment: "Average bid price per submission. Tracks pricing level trends and deal size evolution."
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical evaluation score. Indicates the technical quality and competitiveness of submissions."
    - name: "avg_commercial_score"
      expr: AVG(CAST(commercial_score AS DOUBLE))
      comment: "Average commercial evaluation score. Tracks pricing competitiveness relative to evaluation criteria."
    - name: "late_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN late_submission_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions submitted after the deadline. A high rate signals process failures that risk disqualification and reputational damage."
    - name: "total_bid_bond_exposure"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond amount committed across submissions. Tracks financial exposure from outstanding bid bonds."
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_requirements_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions meeting all compliance requirements. Non-compliant submissions are disqualified, making this a critical quality gate metric."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_tender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tender management metrics covering tender volume, estimated value, evaluation scores, and submission compliance. Used by bid managers and executives to assess tender pipeline health, procurement method mix, and award conversion."
  source: "`vibe_construction_v1`.`bid`.`tender`"
  dimensions:
    - name: "tender_type"
      expr: tender_type
      comment: "Type of tender (e.g. open, selective, negotiated) for procurement method analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g. competitive bid, sole source) for strategic sourcing analysis."
    - name: "award_status"
      expr: award_status
      comment: "Current award status of the tender (e.g. awarded, pending, cancelled) for pipeline conversion tracking."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status of the tender for compliance and completeness monitoring."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid (e.g. lump sum, unit rate, GMP) for contract structure analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the tender for regional pipeline distribution analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the tender for risk-adjusted pipeline reporting."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Indicates joint venture tenders for JV strategy performance tracking."
    - name: "submission_deadline_month"
      expr: DATE_TRUNC('MONTH', submission_deadline)
      comment: "Month of submission deadline for workload planning and deadline concentration analysis."
    - name: "award_decision_date_month"
      expr: DATE_TRUNC('MONTH', award_decision_date)
      comment: "Month of award decision for conversion timeline analysis."
  measures:
    - name: "total_tenders"
      expr: COUNT(1)
      comment: "Total number of tenders tracked. Baseline volume metric for tender pipeline management."
    - name: "total_estimated_tender_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all tenders. Primary metric for assessing the scale of the tender pipeline."
    - name: "avg_estimated_tender_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated tender value. Tracks deal size trends and portfolio composition shifts."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average evaluation score across tenders. Indicates competitive positioning and bid quality trends."
    - name: "total_bid_bond_value"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value committed across tenders. Tracks bonding capacity utilization and financial exposure."
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_requirements_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tenders meeting all compliance requirements. A low rate signals systemic compliance gaps that risk disqualification."
    - name: "regulatory_approval_pending_count"
      expr: COUNT(CASE WHEN regulatory_approval_required = TRUE AND regulatory_approval_status != 'Approved' THEN 1 END)
      comment: "Number of tenders requiring regulatory approval that have not yet been approved. Tracks regulatory bottlenecks that could delay award."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_trade_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade package procurement metrics covering package values, bid participation, award rates, and procurement timelines. Used by procurement managers and project directors to manage subcontractor sourcing strategy and package award performance."
  source: "`vibe_construction_v1`.`bid`.`trade_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the trade package (e.g. in bid, awarded, cancelled) for procurement pipeline tracking."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type for the trade package (e.g. lump sum, unit rate) for procurement strategy analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g. competitive, selective, negotiated) for sourcing strategy analysis."
    - name: "trade_discipline_code"
      expr: trade_discipline_code
      comment: "Trade discipline code for cost analysis by trade category."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the trade package for risk-weighted procurement analysis."
    - name: "package_priority"
      expr: package_priority
      comment: "Priority of the trade package for procurement scheduling and resource allocation."
    - name: "prequalification_required"
      expr: prequalification_required
      comment: "Indicates whether prequalification is required for the package, tracking procurement rigor."
    - name: "bid_closing_date_month"
      expr: DATE_TRUNC('MONTH', bid_closing_date)
      comment: "Month of bid closing date for procurement workload planning."
  measures:
    - name: "total_trade_packages"
      expr: COUNT(1)
      comment: "Total number of trade packages. Baseline metric for procurement pipeline volume."
    - name: "total_estimated_package_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all trade packages. Primary metric for subcontract procurement exposure."
    - name: "total_awarded_package_value"
      expr: SUM(CAST(awarded_value AS DOUBLE))
      comment: "Total awarded value of trade packages. Tracks actual subcontract commitment vs. budget."
    - name: "avg_budget_allowance"
      expr: AVG(CAST(budget_allowance AS DOUBLE))
      comment: "Average budget allowance per trade package. Tracks budget adequacy for subcontract procurement."
    - name: "total_budget_allowance"
      expr: SUM(CAST(budget_allowance AS DOUBLE))
      comment: "Total budget allowance across all trade packages. Tracks total subcontract budget provision."
    - name: "award_vs_estimate_ratio"
      expr: ROUND(SUM(CAST(awarded_value AS DOUBLE)) / NULLIF(SUM(CAST(estimated_value AS DOUBLE)), 0), 4)
      comment: "Ratio of awarded value to estimated value. Values above 1.0 indicate cost overruns at award; below 1.0 indicate savings. Critical for budget management."
    - name: "total_liquidated_damages_rate"
      expr: SUM(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Total liquidated damages rate exposure across trade packages. Tracks contractual penalty exposure in the subcontract portfolio."
    - name: "avg_retention_pct"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across trade packages. Tracks cash flow impact of retention provisions in subcontracts."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_vendor_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor quote metrics covering quoted values, evaluation scores, and compliance. Used by procurement and estimating teams to benchmark vendor pricing, assess quote quality, and support bid pricing decisions."
  source: "`vibe_construction_v1`.`bid`.`vendor_quote`"
  dimensions:
    - name: "vendor_quote_status"
      expr: vendor_quote_status
      comment: "Current status of the vendor quote (e.g. received, evaluated, accepted, rejected) for quote pipeline tracking."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g. supplier, subcontractor, specialist) for supply chain segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the vendor quote for multi-currency pricing analysis."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms of the quote (e.g. DDP, EXW) for logistics cost analysis."
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Indicates whether regulatory approval is required for the quoted item."
    - name: "quote_received_month"
      expr: DATE_TRUNC('MONTH', quote_received_timestamp)
      comment: "Month quote was received for time-series vendor market pricing analysis."
  measures:
    - name: "total_vendor_quotes"
      expr: COUNT(1)
      comment: "Total number of vendor quotes received. Baseline metric for vendor market engagement."
    - name: "total_quoted_value"
      expr: SUM(CAST(total_quoted_value AS DOUBLE))
      comment: "Total quoted value across all vendor quotes. Tracks aggregate vendor pricing for bid cost benchmarking."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across vendor quotes. Primary benchmarking metric for unit rate validation in estimates."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average vendor quote evaluation score. Tracks overall quality and competitiveness of vendor quotes received."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(delivery_lead_time_days AS DOUBLE))
      comment: "Average delivery lead time in days. Tracks supply chain responsiveness and its impact on project scheduling."
    - name: "total_quantity_quoted"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity quoted across vendor quotes. Tracks supply capacity available from the vendor market."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_win_loss_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Win/loss analysis metrics providing insight into bid competitiveness, award conversion, pricing gaps, and evaluation performance. The primary strategic feedback loop for business development and estimating teams."
  source: "`vibe_construction_v1`.`bid`.`win_loss_record`"
  dimensions:
    - name: "outcome_status"
      expr: outcome_status
      comment: "Win or loss outcome of the bid for win-rate calculation and trend analysis."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid for win-rate analysis by contract structure."
    - name: "loss_reason_category"
      expr: loss_reason_category
      comment: "Category of loss reason (e.g. price, technical, experience) for root cause analysis of bid failures."
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Evaluation method used by the client for win-rate analysis by procurement approach."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Indicates joint venture bids for JV vs. solo win-rate comparison."
    - name: "is_award_confirmed"
      expr: is_award_confirmed
      comment: "Indicates whether the award has been formally confirmed for pipeline certainty analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bid values for multi-currency win/loss analysis."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month of bid decision for time-series win-rate trend analysis."
  measures:
    - name: "total_bids_decided"
      expr: COUNT(1)
      comment: "Total number of bids with a win/loss decision. Denominator for win-rate calculations."
    - name: "total_wins"
      expr: COUNT(CASE WHEN outcome_status = 'Won' THEN 1 END)
      comment: "Total number of bids won. Primary success metric for business development performance."
    - name: "win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome_status = 'Won' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bids won. The single most important business development KPI — directly measures market competitiveness."
    - name: "total_awarded_contract_value"
      expr: SUM(CAST(awarded_contract_value AS DOUBLE))
      comment: "Total value of contracts awarded (won bids). Primary revenue conversion metric from the bid pipeline."
    - name: "avg_awarded_contract_value"
      expr: AVG(CAST(awarded_contract_value AS DOUBLE))
      comment: "Average awarded contract value per won bid. Tracks deal size trends for won business."
    - name: "avg_price_gap_to_winner"
      expr: AVG(CAST(price_gap_to_winner AS DOUBLE))
      comment: "Average price gap between our bid and the winning bid on lost opportunities. Quantifies pricing competitiveness gap and informs estimating calibration."
    - name: "avg_technical_evaluation_score"
      expr: AVG(CAST(evaluation_score_technical AS DOUBLE))
      comment: "Average technical evaluation score across all bids. Tracks technical proposal quality and competitiveness trends."
    - name: "avg_commercial_evaluation_score"
      expr: AVG(CAST(evaluation_score_commercial AS DOUBLE))
      comment: "Average commercial evaluation score across all bids. Tracks pricing competitiveness in evaluated tenders."
    - name: "avg_hsse_evaluation_score"
      expr: AVG(CAST(evaluation_score_hsse AS DOUBLE))
      comment: "Average HSSE evaluation score across all bids. Tracks safety performance reputation as a competitive differentiator."
    - name: "total_winning_bid_price"
      expr: SUM(CAST(winning_bid_price AS DOUBLE))
      comment: "Total winning bid price across all decided bids (including competitor wins). Used for market pricing benchmarking."
$$;
