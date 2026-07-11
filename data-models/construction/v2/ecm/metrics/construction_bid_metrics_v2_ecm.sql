-- Metric views for domain: bid | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic pipeline metrics for bid opportunities — tracks estimated contract value, win probability, and pipeline composition to guide pursuit investment decisions."
  source: "`vibe_construction_v1`.`bid`.`bid_opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current pursuit stage (e.g. Qualify, Develop, Propose, Close) for pipeline funnel analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment (e.g. Civil, Buildings, Industrial) for portfolio mix analysis."
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project being pursued for strategic segmentation."
    - name: "win_loss_status"
      expr: win_loss_status
      comment: "Outcome status of the opportunity (Won, Lost, Pending) for win-rate reporting."
    - name: "bid_decision"
      expr: bid_decision
      comment: "Go/No-Go decision recorded for the opportunity, used to track pursuit discipline."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the opportunity was sourced (e.g. Repeat Client, Tender Portal, Referral)."
    - name: "country_code"
      expr: country_code
      comment: "Country where the project opportunity is located for geographic pipeline analysis."
    - name: "pipeline_forecast_category"
      expr: pipeline_forecast_category
      comment: "Forecast category (e.g. Commit, Best Case, Pipeline) for revenue forecasting."
    - name: "gmp_type"
      expr: gmp_type
      comment: "Guaranteed Maximum Price contract type indicator for contract structure analysis."
    - name: "bid_due_date_month"
      expr: DATE_TRUNC('MONTH', bid_due_date)
      comment: "Month the bid is due, used for workload planning and pipeline timing."
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of bid opportunities in the pipeline. Baseline volume metric for pipeline health."
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Sum of estimated contract values across all opportunities. Represents total addressable pipeline value in currency."
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity. Indicates deal size trends and portfolio mix shifts."
    - name: "total_net_estimated_value"
      expr: SUM(CAST(net_estimated_value AS DOUBLE))
      comment: "Sum of net estimated values (after discounts) across all opportunities. Reflects realistic pipeline value after commercial adjustments."
    - name: "avg_probability_of_win"
      expr: AVG(CAST(probability_of_win AS DOUBLE))
      comment: "Average probability of win across opportunities. A declining average signals deteriorating competitiveness or poor pursuit selection."
    - name: "probability_weighted_pipeline_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE) * CAST(probability_of_win AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value (ECV × P-win). The primary leading indicator of expected revenue for executive forecasting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across opportunities. Tracks commercial concessions that erode margin."
    - name: "avg_bid_bond_amount"
      expr: AVG(CAST(bid_bond_amount AS DOUBLE))
      comment: "Average bid bond amount required. Indicates bonding capacity demand across the active pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_tender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tender performance metrics tracking submission outcomes, evaluation scores, and financial exposure across all formal tender submissions."
  source: "`vibe_construction_v1`.`bid`.`tender`"
  dimensions:
    - name: "tender_type"
      expr: tender_type
      comment: "Type of tender (e.g. Open, Selective, Negotiated) for procurement method analysis."
    - name: "bid_type"
      expr: bid_type
      comment: "Bid type (e.g. Lump Sum, Unit Rate, GMP) for contract structure segmentation."
    - name: "award_status"
      expr: award_status
      comment: "Current award status of the tender (Awarded, Pending, Rejected) for pipeline conversion tracking."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission status (Submitted, Draft, Withdrawn) for tender pipeline management."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g. Design-Build, DBB, CMAR) for delivery model analysis."
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Evaluation method (e.g. Lowest Price, Best Value, MEAT) for competitive strategy analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the tender for regional performance benchmarking."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of tender submission for workload and pipeline timing analysis."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating whether the tender is submitted as a joint venture."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the tender for risk-adjusted portfolio analysis."
  measures:
    - name: "total_tenders"
      expr: COUNT(1)
      comment: "Total number of tenders submitted. Baseline volume metric for bid activity."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all tenders submitted. Represents gross revenue opportunity pursued."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per tender. Tracks deal size trends and strategic positioning."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average evaluation score achieved across tenders. A key indicator of bid quality and competitiveness."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond exposure across all active tenders. Critical for bonding capacity management."
    - name: "avg_estimated_duration_months"
      expr: AVG(CAST(estimated_duration_months AS DOUBLE))
      comment: "Average estimated project duration in months across tenders. Informs resource planning and backlog forecasting."
    - name: "awarded_tenders_count"
      expr: COUNT(CASE WHEN award_status = 'Awarded' THEN 1 END)
      comment: "Count of tenders that have been awarded. Used to compute win rate when divided by total tenders."
    - name: "win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN award_status = 'Awarded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tenders awarded out of total submitted. The primary competitive performance KPI for the bid function."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid submission quality and financial metrics — tracks bid prices, scores, compliance, and submission timeliness to evaluate bid execution effectiveness."
  source: "`vibe_construction_v1`.`bid`.`submission`"
  dimensions:
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid submitted (e.g. Lump Sum, Unit Rate) for contract structure analysis."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (Submitted, Draft, Withdrawn) for pipeline tracking."
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Evaluation method applied to this submission for competitive strategy analysis."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the submission for regional performance benchmarking."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the submission for risk-adjusted portfolio analysis."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Whether the submission is a joint venture bid."
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Flag indicating whether the submission was submitted after the deadline. Used to track bid discipline."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of submission for trend analysis of bid activity volume."
    - name: "method"
      expr: method
      comment: "Submission method (e.g. Electronic, Physical) for process efficiency analysis."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of bid submissions. Baseline volume metric for bid activity."
    - name: "total_bid_price"
      expr: SUM(CAST(bid_price AS DOUBLE))
      comment: "Total bid price across all submissions. Represents gross revenue pursued through formal bids."
    - name: "avg_bid_price"
      expr: AVG(CAST(bid_price AS DOUBLE))
      comment: "Average bid price per submission. Tracks deal size and pricing strategy trends."
    - name: "avg_commercial_score"
      expr: AVG(CAST(commercial_score AS DOUBLE))
      comment: "Average commercial evaluation score. Indicates commercial competitiveness of bids submitted."
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical evaluation score. Indicates technical quality and capability demonstrated in bids."
    - name: "total_bid_price_adjustment"
      expr: SUM(CAST(bid_price_adjustment AS DOUBLE))
      comment: "Total price adjustments applied across submissions. Tracks commercial concessions and escalation adjustments."
    - name: "late_submission_count"
      expr: COUNT(CASE WHEN late_submission_flag = TRUE THEN 1 END)
      comment: "Number of submissions submitted after the deadline. A process quality KPI — high counts indicate bid management failures."
    - name: "late_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN late_submission_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions that were late. Directly measures bid execution discipline and process health."
    - name: "compliance_met_count"
      expr: COUNT(CASE WHEN compliance_requirements_met = TRUE THEN 1 END)
      comment: "Number of submissions meeting all compliance requirements. Tracks regulatory and contractual compliance in bid submissions."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond exposure across all submissions. Critical for bonding capacity and financial risk management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost estimation accuracy and composition metrics — tracks estimated costs, margins, contingencies, and overhead to evaluate estimating quality and bid competitiveness."
  source: "`vibe_construction_v1`.`bid`.`estimate`"
  dimensions:
    - name: "estimate_type"
      expr: estimate_type
      comment: "Type of estimate (e.g. Conceptual, Detailed, Definitive) for accuracy benchmarking by estimate class."
    - name: "estimate_category"
      expr: estimate_category
      comment: "Category of estimate (e.g. Civil, MEP, Structural) for cost composition analysis."
    - name: "estimate_status"
      expr: estimate_status
      comment: "Current status of the estimate (Draft, Approved, Superseded) for pipeline management."
    - name: "estimating_method"
      expr: estimating_method
      comment: "Method used to prepare the estimate (e.g. Parametric, Bottom-Up, Analogous) for methodology benchmarking."
    - name: "is_gmp"
      expr: is_gmp
      comment: "Whether the estimate is for a Guaranteed Maximum Price contract — affects risk and contingency strategy."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Whether the estimate is for a lump sum contract — affects pricing strategy and risk allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimate for multi-currency portfolio analysis."
    - name: "revision_date_month"
      expr: DATE_TRUNC('MONTH', revision_date)
      comment: "Month of estimate revision for tracking estimating activity and revision frequency."
  measures:
    - name: "total_estimates"
      expr: COUNT(1)
      comment: "Total number of estimates prepared. Baseline volume metric for estimating workload."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all estimates. Represents the aggregate cost basis for bids in preparation."
    - name: "avg_estimated_cost"
      expr: AVG(CAST(total_estimated_cost AS DOUBLE))
      comment: "Average estimated cost per estimate. Tracks deal size and estimating scope trends."
    - name: "avg_profit_margin_pct"
      expr: AVG(CAST(profit_margin_percentage AS DOUBLE))
      comment: "Average profit margin percentage across estimates. The primary margin health KPI for the bid function — declining averages signal margin erosion."
    - name: "avg_overhead_pct"
      expr: AVG(CAST(overhead_percentage AS DOUBLE))
      comment: "Average overhead percentage applied in estimates. Tracks overhead loading consistency and competitiveness."
    - name: "avg_contingency_pct"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage applied. Indicates risk appetite and estimating conservatism across the portfolio."
    - name: "total_escalation_allowance"
      expr: SUM(CAST(escalation_allowance AS DOUBLE))
      comment: "Total escalation allowance across estimates. Tracks inflation and market risk provisions in the bid portfolio."
    - name: "avg_risk_factor"
      expr: AVG(CAST(risk_factor AS DOUBLE))
      comment: "Average risk factor applied across estimates. Indicates the aggregate risk loading in the bid portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_estimate_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed cost line metrics for bid estimates — tracks cost composition by category, variance, and resource type to identify cost drivers and estimating accuracy."
  source: "`vibe_construction_v1`.`bid`.`estimate_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category (e.g. Labour, Material, Plant, Subcontract) for cost composition analysis."
    - name: "material_type"
      expr: material_type
      comment: "Type of material for material cost breakdown analysis."
    - name: "labor_grade"
      expr: labor_grade
      comment: "Labour grade for workforce cost analysis and rate benchmarking."
    - name: "labor_rate_type"
      expr: labor_rate_type
      comment: "Labour rate type (e.g. Straight Time, Overtime, Premium) for cost control analysis."
    - name: "estimate_line_status"
      expr: estimate_line_status
      comment: "Status of the estimate line (Active, Deleted, Revised) for data quality filtering."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based cost analysis."
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason for cost variance between baseline and revised cost — key for estimating lessons learned."
  measures:
    - name: "total_estimate_lines"
      expr: COUNT(1)
      comment: "Total number of estimate lines. Baseline volume metric for estimate complexity."
    - name: "total_baseline_cost"
      expr: SUM(CAST(baseline_cost AS DOUBLE))
      comment: "Total baseline cost across all estimate lines. Represents the original cost plan before revisions."
    - name: "total_revised_cost"
      expr: SUM(CAST(revised_cost AS DOUBLE))
      comment: "Total revised cost across all estimate lines. Reflects current cost position after changes."
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (revised minus baseline) across estimate lines. Negative values indicate cost overruns vs. original estimate."
    - name: "total_line_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost across all estimate lines. Represents the aggregate cost build-up for the estimate."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across estimate lines. Used for rate benchmarking and productivity analysis."
    - name: "avg_productivity_factor"
      expr: AVG(CAST(productivity_factor AS DOUBLE))
      comment: "Average productivity factor applied. Tracks productivity assumptions and their impact on labour cost estimates."
    - name: "avg_waste_factor"
      expr: AVG(CAST(waste_factor AS DOUBLE))
      comment: "Average waste factor applied to material lines. Tracks material waste assumptions and sustainability performance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across estimate lines. Tracks tax exposure in the bid cost build-up."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_boq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Quantities metrics tracking total values, revision activity, and currency exposure across BOQs to support cost control and bid pricing governance."
  source: "`vibe_construction_v1`.`bid`.`boq`"
  dimensions:
    - name: "boq_type"
      expr: boq_type
      comment: "Type of BOQ (e.g. Priced, Unpriced, Provisional) for pricing completeness analysis."
    - name: "boq_status"
      expr: boq_status
      comment: "Current status of the BOQ (Draft, Approved, Superseded) for governance tracking."
    - name: "currency"
      expr: currency
      comment: "Currency of the BOQ for multi-currency portfolio analysis."
    - name: "specification_standard"
      expr: specification_standard
      comment: "Specification standard applied (e.g. NRM, SMM7, POMI) for methodology consistency analysis."
    - name: "contains_confidential_pricing"
      expr: contains_confidential_pricing
      comment: "Flag indicating whether the BOQ contains confidential pricing — used for access control and governance reporting."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the BOQ was issued for workload and timeline analysis."
  measures:
    - name: "total_boqs"
      expr: COUNT(1)
      comment: "Total number of BOQs prepared. Baseline volume metric for estimating workload."
    - name: "total_boq_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value across all BOQs. Represents the aggregate priced scope of work in the bid portfolio."
    - name: "avg_boq_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average BOQ value. Tracks deal size and scope complexity trends."
    - name: "total_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity across all BOQs. Supports volume-based productivity and resource planning analysis."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across BOQs. Tracks currency risk exposure in multi-currency bids."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_boq_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BOQ line-level cost composition metrics — tracks labour, material, plant, and subcontract costs to identify cost drivers and margin by work section."
  source: "`vibe_construction_v1`.`bid`.`bid_boq_line`"
  dimensions:
    - name: "cost_category"
      expr: cost_category
      comment: "Cost category (Labour, Material, Plant, Subcontract, Overhead) for cost composition analysis."
    - name: "work_section"
      expr: work_section
      comment: "Work section or trade discipline for cost breakdown by scope area."
    - name: "bid_boq_line_status"
      expr: bid_boq_line_status
      comment: "Status of the BOQ line (Active, Deleted, Revised) for data quality filtering."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based rate analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the BOQ line for risk-weighted cost analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Whether the BOQ line is on the critical path — used to prioritise cost control focus."
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Whether the line is priced as a lump sum — affects measurement and payment risk."
    - name: "change_order_flag"
      expr: change_order_flag
      comment: "Flag indicating whether the line is associated with a change order — tracks scope growth."
  measures:
    - name: "total_boq_lines"
      expr: COUNT(1)
      comment: "Total number of BOQ lines. Baseline volume metric for scope complexity."
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total priced amount across all BOQ lines. Represents the aggregate cost build-up for the BOQ."
    - name: "total_labour_cost"
      expr: SUM(CAST(labour_cost AS DOUBLE))
      comment: "Total labour cost across BOQ lines. Key cost driver for workforce planning and productivity analysis."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost across BOQ lines. Key cost driver for procurement and supply chain management."
    - name: "total_plant_cost"
      expr: SUM(CAST(plant_cost AS DOUBLE))
      comment: "Total plant and equipment cost across BOQ lines. Tracks equipment utilisation and hire cost exposure."
    - name: "total_subcontract_cost"
      expr: SUM(CAST(subcontract_cost AS DOUBLE))
      comment: "Total subcontract cost across BOQ lines. Tracks subcontractor spend exposure in the bid."
    - name: "total_overhead_amount"
      expr: SUM(CAST(overhead_amount AS DOUBLE))
      comment: "Total overhead amount across BOQ lines. Tracks overhead loading and its impact on competitiveness."
    - name: "avg_profit_margin_pct"
      expr: AVG(CAST(profit_margin_percent AS DOUBLE))
      comment: "Average profit margin percentage across BOQ lines. Identifies low-margin work sections requiring pricing review."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across BOQ lines. Tracks tax exposure in the priced BOQ."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across BOQ lines. Used for rate benchmarking against market and historical data."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_win_loss`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Win/loss analysis metrics — tracks awarded contract values, price gaps, evaluation scores, and competitive outcomes to drive bid strategy improvement."
  source: "`vibe_construction_v1`.`bid`.`win_loss_record`"
  dimensions:
    - name: "outcome_status"
      expr: outcome_status
      comment: "Outcome of the bid (Won, Lost, No Award) for win-rate analysis."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid (Lump Sum, Unit Rate, GMP) for win-rate analysis by contract type."
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Evaluation method used (Lowest Price, Best Value) for competitive strategy analysis."
    - name: "loss_reason_category"
      expr: loss_reason_category
      comment: "Category of loss reason (Price, Technical, Commercial, Capacity) for root cause analysis of losses."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Whether the bid was submitted as a joint venture — used to compare JV vs. solo win rates."
    - name: "is_award_confirmed"
      expr: is_award_confirmed
      comment: "Whether the award has been formally confirmed — used to distinguish pipeline from confirmed backlog."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month of bid decision for trend analysis of win/loss performance over time."
  measures:
    - name: "total_bid_outcomes"
      expr: COUNT(1)
      comment: "Total number of bid outcomes recorded. Baseline volume metric for competitive activity."
    - name: "total_awarded_contract_value"
      expr: SUM(CAST(awarded_contract_value AS DOUBLE))
      comment: "Total value of contracts awarded (won bids). The primary revenue conversion metric for the bid function."
    - name: "avg_awarded_contract_value"
      expr: AVG(CAST(awarded_contract_value AS DOUBLE))
      comment: "Average awarded contract value. Tracks deal size of won work and strategic positioning."
    - name: "total_winning_bid_price"
      expr: SUM(CAST(winning_bid_price AS DOUBLE))
      comment: "Total winning bid price across all outcomes. Used to benchmark our pricing against market-clearing prices."
    - name: "avg_price_gap_to_winner"
      expr: AVG(CAST(price_gap_to_winner AS DOUBLE))
      comment: "Average price gap between our bid and the winning bid on lost tenders. Directly informs pricing strategy — large gaps indicate over-pricing."
    - name: "avg_technical_score"
      expr: AVG(CAST(evaluation_score_technical AS DOUBLE))
      comment: "Average technical evaluation score across bid outcomes. Tracks technical quality and capability perception."
    - name: "avg_commercial_score"
      expr: AVG(CAST(evaluation_score_commercial AS DOUBLE))
      comment: "Average commercial evaluation score across bid outcomes. Tracks commercial competitiveness."
    - name: "avg_hsse_score"
      expr: AVG(CAST(evaluation_score_hsse AS DOUBLE))
      comment: "Average HSSE evaluation score across bid outcomes. Tracks safety and sustainability performance in bid evaluations."
    - name: "won_bids_count"
      expr: COUNT(CASE WHEN outcome_status = 'Won' THEN 1 END)
      comment: "Count of won bids. Used to compute win rate and track conversion performance."
    - name: "win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome_status = 'Won' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bids won out of total outcomes. The headline competitive performance KPI for the bid function."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond amount across all outcomes. Tracks bonding capacity consumed by competitive bids."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid risk portfolio metrics — tracks risk exposure, contingency provisions, and residual risk scores to support risk-adjusted pricing and go/no-go decisions."
  source: "`vibe_construction_v1`.`bid`.`bid_risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g. Commercial, Technical, Regulatory, Environmental) for risk portfolio analysis."
    - name: "bid_risk_status"
      expr: bid_risk_status
      comment: "Current status of the risk (Open, Mitigated, Closed, Transferred) for active risk tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the risk (High, Medium, Low) for risk triage and management focus."
    - name: "probability_rating"
      expr: probability_rating
      comment: "Probability rating of the risk occurring for risk matrix analysis."
    - name: "origin"
      expr: origin
      comment: "Origin of the risk (Client, Design, Site, Regulatory) for root cause analysis."
    - name: "is_key_risk"
      expr: is_key_risk
      comment: "Flag indicating whether this is a key/critical risk requiring executive attention."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the risk was identified for trend analysis of risk emergence patterns."
  measures:
    - name: "total_risks"
      expr: COUNT(1)
      comment: "Total number of bid risks identified. Baseline volume metric for risk portfolio size."
    - name: "total_impact_cost"
      expr: SUM(CAST(impact_cost AS DOUBLE))
      comment: "Total potential cost impact across all bid risks. Represents gross risk exposure in the bid portfolio."
    - name: "total_contingency_amount"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency provisions across all bid risks. Tracks risk budget allocated in estimates."
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(residual_risk_score AS DOUBLE))
      comment: "Average residual risk score after mitigation. Indicates the remaining risk exposure in the bid portfolio."
    - name: "avg_risk_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average inherent risk score across all bid risks. Tracks overall risk profile of the bid portfolio."
    - name: "total_residual_impact_cost"
      expr: SUM(CAST(residual_impact_cost AS DOUBLE))
      comment: "Total residual cost impact after mitigation. Represents the net risk exposure remaining in the bid."
    - name: "avg_contingency_pct"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage applied to risks. Tracks risk provisioning adequacy across the portfolio."
    - name: "key_risk_count"
      expr: COUNT(CASE WHEN is_key_risk = TRUE THEN 1 END)
      comment: "Count of key/critical risks. Tracks the number of risks requiring executive-level attention and mitigation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid governance and approval metrics — tracks approval scores, decision outcomes, and governance compliance to ensure bids meet strategic and financial thresholds before submission."
  source: "`vibe_construction_v1`.`bid`.`approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval (Pending, Approved, Rejected, Conditional) for governance pipeline tracking."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Outcome of the approval decision (Go, No-Go, Conditional Go) for bid governance analysis."
    - name: "decision_stage"
      expr: decision_stage
      comment: "Stage at which the approval decision was made (Stage Gate 1, 2, 3) for governance process analysis."
    - name: "delegation_of_authority_level"
      expr: delegation_of_authority_level
      comment: "Level of delegation of authority required for the approval — tracks governance compliance."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the approved bid for risk-adjusted portfolio analysis."
    - name: "is_conditional"
      expr: is_conditional
      comment: "Whether the approval was conditional — tracks governance quality and conditions imposed."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month of approval decision for trend analysis of governance activity."
  measures:
    - name: "total_approvals"
      expr: COUNT(1)
      comment: "Total number of bid approvals processed. Baseline volume metric for governance activity."
    - name: "total_approved_bid_price"
      expr: SUM(CAST(approved_bid_price AS DOUBLE))
      comment: "Total approved bid price across all approvals. Represents the aggregate value of bids authorised for submission."
    - name: "avg_approved_margin_pct"
      expr: AVG(CAST(approved_margin_pct AS DOUBLE))
      comment: "Average approved margin percentage. The primary margin governance KPI — ensures bids meet minimum margin thresholds."
    - name: "avg_total_governance_score"
      expr: AVG(CAST(total_governance_score AS DOUBLE))
      comment: "Average total governance score across approvals. Tracks overall bid quality and strategic alignment at approval gate."
    - name: "avg_strategic_fit_score"
      expr: AVG(CAST(strategic_fit_score AS DOUBLE))
      comment: "Average strategic fit score. Measures alignment of pursued bids with corporate strategy."
    - name: "avg_risk_profile_score"
      expr: AVG(CAST(risk_profile_score AS DOUBLE))
      comment: "Average risk profile score at approval. Tracks risk-adjusted quality of the bid portfolio approved for submission."
    - name: "avg_resource_availability_score"
      expr: AVG(CAST(resource_availability_score AS DOUBLE))
      comment: "Average resource availability score. Tracks whether approved bids are resourced — low scores indicate overcommitment risk."
    - name: "conditional_approval_count"
      expr: COUNT(CASE WHEN is_conditional = TRUE THEN 1 END)
      comment: "Count of conditional approvals. High counts indicate governance concerns requiring follow-up on conditions imposed."
    - name: "avg_bonding_capacity_score"
      expr: AVG(CAST(bonding_capacity_score AS DOUBLE))
      comment: "Average bonding capacity score at approval. Tracks whether the firm has sufficient bonding capacity for approved bids."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_bond`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid bond exposure and compliance metrics — tracks bond amounts, expiry risk, and compliance status to manage financial guarantee obligations."
  source: "`vibe_construction_v1`.`bid`.`bond`"
  dimensions:
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond (Bid Bond, Performance Bond, Payment Bond) for bond portfolio analysis."
    - name: "bond_status"
      expr: bond_status
      comment: "Current status of the bond (Active, Expired, Released, Called) for bond lifecycle management."
    - name: "issuer_type"
      expr: issuer_type
      comment: "Type of bond issuer (Bank, Insurance Company, Surety) for counterparty risk analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bond for multi-currency exposure analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the bond for risk-adjusted portfolio analysis."
    - name: "compliance_requirements_met"
      expr: compliance_requirements_met
      comment: "Whether all compliance requirements for the bond have been met — tracks regulatory compliance."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of bond expiry for proactive renewal and extension management."
  measures:
    - name: "total_bonds"
      expr: COUNT(1)
      comment: "Total number of bonds issued. Baseline volume metric for bond portfolio size."
    - name: "total_bond_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total bond amount across all bonds. Represents aggregate financial guarantee exposure."
    - name: "avg_bond_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average bond amount per bond. Tracks typical bond size and exposure per project."
    - name: "avg_bond_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average bond percentage of contract value. Tracks bond loading and financial guarantee requirements."
    - name: "active_bond_count"
      expr: COUNT(CASE WHEN bond_status = 'Active' THEN 1 END)
      comment: "Count of currently active bonds. Tracks live financial guarantee obligations."
    - name: "total_active_bond_amount"
      expr: SUM(CASE WHEN bond_status = 'Active' THEN amount ELSE 0 END)
      comment: "Total amount of currently active bonds. Represents live financial guarantee exposure requiring management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_subcontractor_prequalification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontractor prequalification metrics — tracks evaluation scores, financial capacity, and approval rates to ensure only qualified subcontractors are invited to bid."
  source: "`vibe_construction_v1`.`bid`.`subcontractor_prequalification`"
  dimensions:
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification status (Approved, Rejected, Pending, Expired) for supplier qualification pipeline."
    - name: "trade_category"
      expr: trade_category
      comment: "Trade category of the subcontractor (e.g. Civil, Electrical, Mechanical) for supply chain analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the subcontractor for regional supply chain capacity analysis."
    - name: "requalification_trigger"
      expr: requalification_trigger
      comment: "Trigger for requalification (Expiry, Performance Issue, Scope Change) for supply chain risk management."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of evaluation for trend analysis of prequalification activity."
  measures:
    - name: "total_prequalifications"
      expr: COUNT(1)
      comment: "Total number of subcontractor prequalifications processed. Baseline volume metric for supply chain development activity."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall prequalification score. Tracks the quality of the approved subcontractor pool."
    - name: "avg_financial_capacity_score"
      expr: AVG(CAST(financial_capacity_score AS DOUBLE))
      comment: "Average financial capacity score. Tracks financial health of the subcontractor pool — low scores indicate supply chain financial risk."
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score. Tracks technical competence of the approved subcontractor pool."
    - name: "avg_safety_record_score"
      expr: AVG(CAST(safety_record_score AS DOUBLE))
      comment: "Average safety record score. Tracks HSSE performance of the subcontractor pool — critical for site safety management."
    - name: "avg_maximum_contract_value"
      expr: AVG(CAST(maximum_contract_value AS DOUBLE))
      comment: "Average maximum contract value approved for subcontractors. Tracks financial capacity limits in the supply chain."
    - name: "approved_subcontractor_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END)
      comment: "Count of currently approved subcontractors. Tracks the size of the qualified supply chain pool."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prequalification applications approved. Tracks supply chain qualification standards and selectivity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_trade_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade package procurement metrics — tracks awarded values, budget performance, bidder participation, and package status to manage subcontract procurement effectiveness."
  source: "`vibe_construction_v1`.`bid`.`trade_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the trade package (Draft, Issued, Awarded, Closed) for procurement pipeline management."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type for the trade package (Lump Sum, Unit Rate, Cost Plus) for procurement strategy analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method (Open Tender, Selective Tender, Negotiated) for procurement governance analysis."
    - name: "trade_discipline_code"
      expr: trade_discipline_code
      comment: "Trade discipline code for cost breakdown by trade and supply chain analysis."
    - name: "csi_masterformat_code"
      expr: csi_masterformat_code
      comment: "CSI MasterFormat code for standardised cost classification and benchmarking."
    - name: "package_priority"
      expr: package_priority
      comment: "Priority of the trade package (Critical, High, Medium, Low) for procurement scheduling."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the trade package for risk-adjusted procurement management."
    - name: "award_date_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month of package award for procurement timeline and workload analysis."
  measures:
    - name: "total_trade_packages"
      expr: COUNT(1)
      comment: "Total number of trade packages. Baseline volume metric for procurement workload."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value across all trade packages. Represents the aggregate subcontract procurement budget."
    - name: "total_awarded_value"
      expr: SUM(CAST(awarded_value AS DOUBLE))
      comment: "Total awarded value across all trade packages. Represents committed subcontract spend."
    - name: "total_budget_allowance"
      expr: SUM(CAST(budget_allowance AS DOUBLE))
      comment: "Total budget allowance across all trade packages. Represents the approved budget for subcontract procurement."
    - name: "avg_awarded_vs_estimated_ratio"
      expr: ROUND(100.0 * SUM(CAST(awarded_value AS DOUBLE)) / NULLIF(SUM(CAST(estimated_value AS DOUBLE)), 0), 2)
      comment: "Ratio of awarded value to estimated value as a percentage. Values above 100% indicate cost overruns vs. estimate — a key procurement performance KPI."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across trade packages. Tracks financial risk exposure from subcontractor delays."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across trade packages. Tracks cash flow impact of retention provisions."
    - name: "avg_bidders_invited"
      expr: AVG(CAST(number_of_bidders_invited AS DOUBLE))
      comment: "Average number of bidders invited per trade package. Tracks market competition and procurement competitiveness."
    - name: "avg_bids_received"
      expr: AVG(CAST(number_of_bids_received AS DOUBLE))
      comment: "Average number of bids received per trade package. Low response rates indicate supply chain capacity constraints or unattractive packages."
    - name: "bid_response_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(number_of_bids_received AS DOUBLE)) / NULLIF(SUM(CAST(number_of_bidders_invited AS DOUBLE)), 0), 2)
      comment: "Percentage of invited bidders who submitted a response. A key supply chain health indicator — low rates signal market capacity issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_vendor_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor quote analysis metrics — tracks quoted amounts, evaluation scores, and compliance to support competitive vendor selection during bid preparation."
  source: "`vibe_construction_v1`.`bid`.`vendor_quote`"
  dimensions:
    - name: "vendor_quote_status"
      expr: vendor_quote_status
      comment: "Current status of the vendor quote (Received, Evaluated, Accepted, Rejected) for procurement pipeline tracking."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (Supplier, Subcontractor, Specialist) for supply chain segmentation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based price analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quote for multi-currency procurement analysis."
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Whether regulatory approval is required for the quoted item — tracks compliance complexity."
    - name: "quote_received_month"
      expr: DATE_TRUNC('MONTH', quote_received_timestamp)
      comment: "Month the quote was received for procurement activity trend analysis."
  measures:
    - name: "total_vendor_quotes"
      expr: COUNT(1)
      comment: "Total number of vendor quotes received. Baseline volume metric for procurement market engagement."
    - name: "total_quoted_value"
      expr: SUM(CAST(total_quoted_value AS DOUBLE))
      comment: "Total quoted value across all vendor quotes. Represents aggregate vendor pricing received for bid cost build-up."
    - name: "avg_quoted_amount"
      expr: AVG(CAST(quoted_amount AS DOUBLE))
      comment: "Average quoted amount per vendor quote. Tracks market pricing levels for cost estimation benchmarking."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across vendor quotes. Used for rate benchmarking and identifying outlier pricing."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average evaluation score across vendor quotes. Tracks overall quality of vendor responses received."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(delivery_lead_time_days AS DOUBLE))
      comment: "Average delivery lead time in days. Tracks supply chain responsiveness and schedule risk from procurement."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_firm_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subcontractor and vendor firm profile metrics — tracks prequalification status, safety performance, bonding capacity, and diversity certifications across the approved supply chain."
  source: "`vibe_construction_v1`.`bid`.`firm_profile`"
  dimensions:
    - name: "firm_status"
      expr: firm_status
      comment: "Current status of the firm (Active, Suspended, Blacklisted, Expired) for supply chain governance."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Prequalification status of the firm for supply chain qualification tracking."
    - name: "primary_trade_classification"
      expr: primary_trade_classification
      comment: "Primary trade classification of the firm for supply chain segmentation by discipline."
    - name: "annual_revenue_band"
      expr: annual_revenue_band
      comment: "Annual revenue band of the firm for financial capacity segmentation."
    - name: "country_of_incorporation"
      expr: country_of_incorporation
      comment: "Country of incorporation for geographic supply chain analysis."
    - name: "is_union_shop"
      expr: is_union_shop
      comment: "Whether the firm is a union shop — relevant for labour relations and project labour agreements."
    - name: "dbe_certified"
      expr: dbe_certified
      comment: "Disadvantaged Business Enterprise certification status for diversity spend tracking."
    - name: "mbe_certified"
      expr: mbe_certified
      comment: "Minority Business Enterprise certification status for diversity spend tracking."
    - name: "wbe_certified"
      expr: wbe_certified
      comment: "Women Business Enterprise certification status for diversity spend tracking."
  measures:
    - name: "total_firms"
      expr: COUNT(1)
      comment: "Total number of firm profiles in the registry. Baseline metric for supply chain pool size."
    - name: "avg_emr"
      expr: AVG(CAST(emr AS DOUBLE))
      comment: "Average Experience Modification Rate (EMR) across firms. The primary safety performance KPI for the supply chain — EMR > 1.0 indicates above-average incident rates."
    - name: "avg_trir"
      expr: AVG(CAST(trir AS DOUBLE))
      comment: "Average Total Recordable Incident Rate (TRIR) across firms. Tracks safety performance of the supply chain pool."
    - name: "avg_bonding_capacity_usd"
      expr: AVG(CAST(bonding_capacity_usd AS DOUBLE))
      comment: "Average bonding capacity in USD across firms. Tracks financial guarantee capacity available in the supply chain."
    - name: "avg_single_project_bond_limit_usd"
      expr: AVG(CAST(single_project_bond_limit_usd AS DOUBLE))
      comment: "Average single project bond limit in USD. Tracks the maximum project size each firm can bond — critical for large project procurement."
    - name: "diversity_certified_firm_count"
      expr: COUNT(CASE WHEN dbe_certified = TRUE OR mbe_certified = TRUE OR wbe_certified = TRUE THEN 1 END)
      comment: "Count of firms with at least one diversity certification (DBE, MBE, or WBE). Tracks diversity supply chain pool size for compliance reporting."
    - name: "diversity_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dbe_certified = TRUE OR mbe_certified = TRUE OR wbe_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of firms with diversity certifications. Tracks progress toward diversity spend targets and supplier diversity goals."
    - name: "iso_9001_certified_count"
      expr: COUNT(CASE WHEN iso_9001_certified = TRUE THEN 1 END)
      comment: "Count of firms with ISO 9001 quality certification. Tracks quality management standards in the supply chain."
$$;