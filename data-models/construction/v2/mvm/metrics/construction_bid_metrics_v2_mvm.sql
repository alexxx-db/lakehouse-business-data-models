-- Metric views for domain: bid | Business: Construction | Version: 2 | Generated on: 2026-07-10 14:32:32

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic bid opportunity pipeline metrics tracking estimated contract value, win probability, and opportunity progression through stages"
  source: "`vibe_construction_v1`.`bid`.`bid_opportunity`"
  dimensions:
    - name: "bid_decision"
      expr: bid_decision
      comment: "Final decision on whether to pursue the bid opportunity (Go/No-Go)"
    - name: "stage"
      expr: stage
      comment: "Current stage of the bid opportunity in the sales pipeline"
    - name: "win_loss_status"
      expr: win_loss_status
      comment: "Final outcome status of the bid opportunity (Won/Lost/Pending)"
    - name: "pipeline_forecast_category"
      expr: pipeline_forecast_category
      comment: "Forecast category for pipeline reporting (e.g., Best Case, Commit, Pipeline)"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment or industry vertical for the opportunity"
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project (e.g., Commercial, Residential, Infrastructure)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the project opportunity is located"
    - name: "gmp_type"
      expr: gmp_type
      comment: "Guaranteed Maximum Price contract type classification"
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating whether the opportunity involves a joint venture partnership"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the opportunity was sourced (e.g., Direct, Referral, RFP)"
    - name: "bid_due_year"
      expr: YEAR(bid_due_date)
      comment: "Year when the bid is due for submission"
    - name: "bid_due_quarter"
      expr: CONCAT('Q', QUARTER(bid_due_date), '-', YEAR(bid_due_date))
      comment: "Quarter and year when the bid is due"
    - name: "bid_due_month"
      expr: DATE_TRUNC('MONTH', bid_due_date)
      comment: "Month when the bid is due for submission"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when the opportunity record was created"
    - name: "created_quarter"
      expr: CONCAT('Q', QUARTER(created_timestamp), '-', YEAR(created_timestamp))
      comment: "Quarter when the opportunity was created"
  measures:
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across all opportunities in the pipeline"
    - name: "total_net_estimated_value"
      expr: SUM(CAST(net_estimated_value AS DOUBLE))
      comment: "Total net estimated value after discounts and adjustments"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount offered across opportunities"
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond amount required across all opportunities"
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE) * CAST(probability_of_win AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value (contract value × win probability) for forecasting"
    - name: "avg_probability_of_win"
      expr: AVG(CAST(probability_of_win AS DOUBLE))
      comment: "Average win probability percentage across opportunities"
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity"
    - name: "opportunity_count"
      expr: COUNT(DISTINCT bid_opportunity_id)
      comment: "Distinct count of bid opportunities"
    - name: "avg_discount_rate"
      expr: ROUND(100.0 * AVG(CAST(discount_amount AS DOUBLE) / NULLIF(CAST(estimated_contract_value AS DOUBLE), 0)), 2)
      comment: "Average discount rate as a percentage of estimated contract value"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_tender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tender submission and evaluation metrics tracking bid performance, compliance, and award outcomes"
  source: "`vibe_construction_v1`.`bid`.`tender`"
  dimensions:
    - name: "tender_type"
      expr: tender_type
      comment: "Type of tender (e.g., Open, Selective, Negotiated)"
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid submitted (e.g., Lump Sum, Unit Price, Cost Plus)"
    - name: "award_status"
      expr: award_status
      comment: "Status of the tender award decision (e.g., Awarded, Not Awarded, Pending)"
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the tender submission (e.g., Submitted, Draft, Withdrawn)"
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Prequalification status for the tender (e.g., Qualified, Not Qualified, Pending)"
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Method used to evaluate the tender (e.g., Lowest Price, Best Value, Quality-Based)"
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used for the tender (e.g., Public Tender, Framework Agreement)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the tender (e.g., Low, Medium, High)"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code for the tender project"
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating whether the tender involves a joint venture"
    - name: "bid_bond_required"
      expr: bid_bond_required
      comment: "Flag indicating whether a bid bond is required for the tender"
    - name: "compliance_requirements_met"
      expr: compliance_requirements_met
      comment: "Flag indicating whether all compliance requirements have been met"
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Flag indicating whether regulatory approval is required"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year when the tender was submitted"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date), '-', YEAR(submission_date))
      comment: "Quarter when the tender was submitted"
    - name: "award_decision_year"
      expr: YEAR(award_decision_date)
      comment: "Year when the award decision was made"
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all tenders"
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond amount required across all tenders"
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average evaluation score received across tenders"
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per tender"
    - name: "tender_count"
      expr: COUNT(DISTINCT tender_id)
      comment: "Distinct count of tenders"
    - name: "avg_estimated_duration_months"
      expr: AVG(CAST(estimated_duration_months AS DOUBLE))
      comment: "Average estimated project duration in months across tenders"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_requirements_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tenders where compliance requirements were met"
    - name: "award_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN award_status = 'Awarded' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tenders that resulted in an award"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_win_loss_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Win/loss analysis metrics tracking bid outcomes, competitive performance, and contract awards"
  source: "`vibe_construction_v1`.`bid`.`win_loss_record`"
  dimensions:
    - name: "outcome_status"
      expr: outcome_status
      comment: "Final outcome of the bid (Won/Lost)"
    - name: "loss_reason_category"
      expr: loss_reason_category
      comment: "Categorized reason for losing the bid (e.g., Price, Technical, Schedule)"
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid submitted (e.g., Lump Sum, Unit Price, Cost Plus)"
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Method used to evaluate the bid (e.g., Lowest Price, Best Value)"
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating whether the bid involved a joint venture"
    - name: "is_award_confirmed"
      expr: is_award_confirmed
      comment: "Flag indicating whether the award has been officially confirmed"
    - name: "decision_year"
      expr: YEAR(decision_timestamp)
      comment: "Year when the win/loss decision was made"
    - name: "decision_quarter"
      expr: CONCAT('Q', QUARTER(decision_timestamp), '-', YEAR(decision_timestamp))
      comment: "Quarter when the win/loss decision was made"
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_timestamp)
      comment: "Month when the win/loss decision was made"
    - name: "contract_start_year"
      expr: YEAR(contract_start_date)
      comment: "Year when the awarded contract is scheduled to start"
  measures:
    - name: "total_awarded_contract_value"
      expr: SUM(CAST(awarded_contract_value AS DOUBLE))
      comment: "Total value of all awarded contracts (wins only)"
    - name: "total_winning_bid_price"
      expr: SUM(CAST(winning_bid_price AS DOUBLE))
      comment: "Total winning bid price across all decisions"
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond amount across all win/loss records"
    - name: "avg_evaluation_score_technical"
      expr: AVG(CAST(evaluation_score_technical AS DOUBLE))
      comment: "Average technical evaluation score across bids"
    - name: "avg_evaluation_score_commercial"
      expr: AVG(CAST(evaluation_score_commercial AS DOUBLE))
      comment: "Average commercial evaluation score across bids"
    - name: "avg_evaluation_score_hsse"
      expr: AVG(CAST(evaluation_score_hsse AS DOUBLE))
      comment: "Average health, safety, security, and environment (HSSE) evaluation score"
    - name: "avg_price_gap_to_winner"
      expr: AVG(CAST(price_gap_to_winner AS DOUBLE))
      comment: "Average price gap between our bid and the winning bid (for losses)"
    - name: "win_loss_count"
      expr: COUNT(DISTINCT win_loss_record_id)
      comment: "Distinct count of win/loss records"
    - name: "win_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN outcome_status = 'Won' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Win rate percentage (wins divided by total decisions)"
    - name: "avg_competitor_count"
      expr: AVG(CAST(competitor_count AS DOUBLE))
      comment: "Average number of competitors per bid"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost estimation metrics tracking estimate accuracy, contingency planning, and pricing strategy"
  source: "`vibe_construction_v1`.`bid`.`estimate`"
  dimensions:
    - name: "estimate_status"
      expr: estimate_status
      comment: "Current status of the estimate (e.g., Draft, Approved, Rejected)"
    - name: "estimate_type"
      expr: estimate_type
      comment: "Type of estimate (e.g., Conceptual, Preliminary, Detailed)"
    - name: "estimating_method"
      expr: estimating_method
      comment: "Method used for estimating (e.g., Parametric, Bottom-Up, Analogous)"
    - name: "category"
      expr: estimate_category
      comment: "Category of the estimate (e.g., Labor, Material, Equipment)"
    - name: "is_gmp"
      expr: is_gmp
      comment: "Flag indicating whether this is a Guaranteed Maximum Price estimate"
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Flag indicating whether this is a lump sum estimate"
    - name: "is_locked"
      expr: is_locked
      comment: "Flag indicating whether the estimate is locked from further changes"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the estimate amounts"
    - name: "revision_year"
      expr: YEAR(revision_date)
      comment: "Year when the estimate was last revised"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year when the estimate was created"
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all estimates"
    - name: "total_escalation_allowance"
      expr: SUM(CAST(escalation_allowance AS DOUBLE))
      comment: "Total escalation allowance for cost inflation"
    - name: "avg_contingency_percentage"
      expr: AVG(CAST(contingency_percentage AS DOUBLE))
      comment: "Average contingency percentage applied to estimates"
    - name: "avg_overhead_percentage"
      expr: AVG(CAST(overhead_percentage AS DOUBLE))
      comment: "Average overhead percentage applied to estimates"
    - name: "avg_profit_margin_percentage"
      expr: AVG(CAST(profit_margin_percentage AS DOUBLE))
      comment: "Average profit margin percentage applied to estimates"
    - name: "avg_risk_factor"
      expr: AVG(CAST(risk_factor AS DOUBLE))
      comment: "Average risk factor applied to estimates"
    - name: "estimate_count"
      expr: COUNT(DISTINCT estimate_id)
      comment: "Distinct count of estimates"
    - name: "avg_estimated_cost"
      expr: AVG(CAST(total_estimated_cost AS DOUBLE))
      comment: "Average estimated cost per estimate"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_estimate_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed estimate line-item metrics tracking cost components, variances, and resource pricing"
  source: "`vibe_construction_v1`.`bid`.`estimate_line`"
  dimensions:
    - name: "estimate_line_status"
      expr: estimate_line_status
      comment: "Status of the estimate line item (e.g., Active, Revised, Deleted)"
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost (e.g., Labor, Material, Equipment, Subcontract)"
    - name: "material_type"
      expr: material_type
      comment: "Type of material for material cost lines"
    - name: "labor_rate_type"
      expr: labor_rate_type
      comment: "Type of labor rate applied (e.g., Standard, Overtime, Premium)"
    - name: "risk_factor_band"
      expr: CASE WHEN CAST(risk_factor AS DOUBLE) < 1.05 THEN 'Low' WHEN CAST(risk_factor AS DOUBLE) < 1.15 THEN 'Medium' ELSE 'High' END
      comment: "Risk factor banded into Low/Medium/High categories"
    - name: "is_deleted"
      expr: is_deleted
      comment: "Flag indicating whether the estimate line has been deleted"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the line item quantity"
    - name: "wbs_element"
      expr: wbs_element
      comment: "Work Breakdown Structure element code"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for financial tracking"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year when the estimate line was approved"
  measures:
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost across all estimate lines"
    - name: "total_baseline_cost"
      expr: SUM(CAST(baseline_cost AS DOUBLE))
      comment: "Total baseline cost before revisions"
    - name: "total_revised_cost"
      expr: SUM(CAST(revised_cost AS DOUBLE))
      comment: "Total revised cost after changes"
    - name: "total_cost_variance"
      expr: SUM(CAST(cost_variance AS DOUBLE))
      comment: "Total cost variance (revised minus baseline)"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across estimate lines"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all estimate lines"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per estimate line"
    - name: "avg_productivity_factor"
      expr: AVG(CAST(productivity_factor AS DOUBLE))
      comment: "Average productivity factor applied to labor estimates"
    - name: "avg_waste_factor"
      expr: AVG(CAST(waste_factor AS DOUBLE))
      comment: "Average waste factor applied to material estimates"
    - name: "estimate_line_count"
      expr: COUNT(DISTINCT estimate_line_id)
      comment: "Distinct count of estimate line items"
    - name: "cost_variance_rate"
      expr: ROUND(100.0 * SUM(CAST(cost_variance AS DOUBLE)) / NULLIF(SUM(CAST(baseline_cost AS DOUBLE)), 0), 2)
      comment: "Cost variance as a percentage of baseline cost"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_boq_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Quantities line-item metrics tracking quantities, rates, and cost breakdowns for tender pricing"
  source: "`vibe_construction_v1`.`bid`.`boq_line`"
  dimensions:
    - name: "bid_boq_line_status"
      expr: bid_boq_line_status
      comment: "Status of the BOQ line item (e.g., Active, Revised, Withdrawn)"
    - name: "cost_category"
      expr: cost_category
      comment: "Category of cost (e.g., Labor, Material, Equipment, Subcontract)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the BOQ line item (e.g., Low, Medium, High)"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating whether the line item is on the project critical path"
    - name: "is_gmp_applicable"
      expr: is_gmp_applicable
      comment: "Flag indicating whether Guaranteed Maximum Price applies to this line"
    - name: "is_lump_sum"
      expr: is_lump_sum
      comment: "Flag indicating whether this is a lump sum line item"
    - name: "is_taxable"
      expr: is_taxable
      comment: "Flag indicating whether the line item is subject to tax"
    - name: "change_order_flag"
      expr: change_order_flag
      comment: "Flag indicating whether the line is part of a change order"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the line item quantity"
    - name: "wbs_code"
      expr: wbs_code
      comment: "Work Breakdown Structure code for the line item"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for financial tracking"
  measures:
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount across all BOQ line items"
    - name: "total_labour_cost"
      expr: SUM(CAST(labour_cost AS DOUBLE))
      comment: "Total labor cost across BOQ lines"
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost across BOQ lines"
    - name: "total_plant_cost"
      expr: SUM(CAST(plant_cost AS DOUBLE))
      comment: "Total plant and equipment cost across BOQ lines"
    - name: "total_subcontract_cost"
      expr: SUM(CAST(subcontract_cost AS DOUBLE))
      comment: "Total subcontract cost across BOQ lines"
    - name: "total_overhead_amount"
      expr: SUM(CAST(overhead_amount AS DOUBLE))
      comment: "Total overhead amount across BOQ lines"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across BOQ lines"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all BOQ line items"
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate per BOQ line item"
    - name: "avg_profit_margin_percent"
      expr: AVG(CAST(profit_margin_percent AS DOUBLE))
      comment: "Average profit margin percentage across BOQ lines"
    - name: "boq_line_count"
      expr: COUNT(DISTINCT boq_line_id)
      comment: "Distinct count of BOQ line items"
    - name: "labour_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(labour_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Labor cost as a percentage of total BOQ amount"
    - name: "material_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(material_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Material cost as a percentage of total BOQ amount"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_bond`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bond and guarantee metrics tracking bond amounts, expiry management, and compliance status"
  source: "`vibe_construction_v1`.`bid`.`bond`"
  dimensions:
    - name: "bond_type"
      expr: bond_type
      comment: "Type of bond (e.g., Bid Bond, Performance Bond, Payment Bond, Retention Bond)"
    - name: "bond_status"
      expr: bond_status
      comment: "Current status of the bond (e.g., Active, Expired, Released, Claimed)"
    - name: "issuer_type"
      expr: issuer_type
      comment: "Type of bond issuer (e.g., Bank, Insurance Company, Surety)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the bond (e.g., Low, Medium, High)"
    - name: "compliance_requirements_met"
      expr: compliance_requirements_met
      comment: "Flag indicating whether compliance requirements have been met"
    - name: "guarantee_extension_allowed"
      expr: guarantee_extension_allowed
      comment: "Flag indicating whether the bond guarantee can be extended"
    - name: "confidentiality_flag"
      expr: confidentiality_flag
      comment: "Flag indicating whether the bond information is confidential"
    - name: "documents_attached"
      expr: documents_attached
      comment: "Flag indicating whether supporting documents are attached"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year when the bond was issued"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year when the bond expires"
    - name: "expiry_quarter"
      expr: CONCAT('Q', QUARTER(expiry_date), '-', YEAR(expiry_date))
      comment: "Quarter when the bond expires"
  measures:
    - name: "total_bond_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total bond amount across all bonds"
    - name: "avg_bond_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average bond amount per bond"
    - name: "avg_bond_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average bond percentage of contract value"
    - name: "bond_count"
      expr: COUNT(DISTINCT bond_id)
      comment: "Distinct count of bonds"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_requirements_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bonds where compliance requirements are met"
    - name: "extension_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN guarantee_extension_allowed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bonds that allow guarantee extensions"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`bid_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid submission performance metrics tracking submission quality, scoring, and compliance"
  source: "`vibe_construction_v1`.`bid`.`submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the bid submission (e.g., Submitted, Under Review, Accepted, Rejected)"
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid submitted (e.g., Lump Sum, Unit Price, Cost Plus)"
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Method used to evaluate the submission (e.g., Lowest Price, Best Value)"
    - name: "method"
      expr: method
      comment: "Submission method (e.g., Electronic, Physical, Hybrid)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the submission (e.g., Low, Medium, High)"
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Flag indicating whether the submission involves a joint venture"
    - name: "compliance_requirements_met"
      expr: compliance_requirements_met
      comment: "Flag indicating whether compliance requirements were met"
    - name: "late_submission_flag"
      expr: late_submission_flag
      comment: "Flag indicating whether the submission was late"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code for the submission"
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year when the submission was made"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_timestamp), '-', YEAR(submission_timestamp))
      comment: "Quarter when the submission was made"
    - name: "deadline_year"
      expr: YEAR(deadline)
      comment: "Year of the submission deadline"
  measures:
    - name: "total_bid_price"
      expr: SUM(CAST(bid_price AS DOUBLE))
      comment: "Total bid price across all submissions"
    - name: "total_bid_price_adjustment"
      expr: SUM(CAST(bid_price_adjustment AS DOUBLE))
      comment: "Total bid price adjustments across submissions"
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond amount across submissions"
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical evaluation score across submissions"
    - name: "avg_commercial_score"
      expr: AVG(CAST(commercial_score AS DOUBLE))
      comment: "Average commercial evaluation score across submissions"
    - name: "avg_bid_price"
      expr: AVG(CAST(bid_price AS DOUBLE))
      comment: "Average bid price per submission"
    - name: "submission_count"
      expr: COUNT(DISTINCT submission_id)
      comment: "Distinct count of bid submissions"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_requirements_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions meeting compliance requirements"
    - name: "late_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN late_submission_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions that were submitted late"
$$;
