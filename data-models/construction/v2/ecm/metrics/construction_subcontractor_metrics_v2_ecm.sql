-- Metric views for domain: subcontractor | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_back_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks subcontractor back-charge activity including claimed amounts, approved deductions, dispute rates, and cost composition. Enables project controls teams and commercial managers to monitor cost recovery from subcontractors for defective or non-performed work."
  source: "`vibe_construction_v1`.`subcontractor`.`back_charge`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — enables back-charge analysis by project."
    - name: "subcontract_id"
      expr: subcontract_id
      comment: "Foreign key to the subcontract — enables analysis per subcontract agreement."
    - name: "back_charge_status"
      expr: back_charge_status
      comment: "Current lifecycle status of the back charge (e.g. Draft, Submitted, Approved, Disputed, Closed)."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the back charge (e.g. defective work, non-performance, safety violation)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the back charge is denominated."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Boolean indicating whether the back charge is under dispute — used to segment disputed vs. undisputed population."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of back-charge approval — enables trend analysis of approvals over time."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month the underlying incident occurred — supports root-cause trending."
    - name: "cost_account_id"
      expr: cost_account_id
      comment: "Foreign key to the cost account — enables cost recovery analysis by cost account."
  measures:
    - name: "total_claimed_amount"
      expr: SUM(CAST(total_claimed_amount AS DOUBLE))
      comment: "Total value of all back charges claimed against subcontractors. Directly measures cost recovery exposure and drives commercial decisions on subcontractor performance."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total back-charge value formally approved for deduction. Represents confirmed cost recovery and impacts subcontractor final account settlement."
    - name: "total_deduction_applied_amount"
      expr: SUM(CAST(deduction_applied_amount AS DOUBLE))
      comment: "Total amount actually deducted from subcontractor payments. Measures realised cost recovery versus approved amounts."
    - name: "total_labor_cost_amount"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Labor cost component of all back charges. Identifies whether back-charge exposure is driven by labour remediation costs."
    - name: "total_material_cost_amount"
      expr: SUM(CAST(material_cost_amount AS DOUBLE))
      comment: "Material cost component of all back charges. Identifies material remediation cost exposure."
    - name: "total_equipment_cost_amount"
      expr: SUM(CAST(equipment_cost_amount AS DOUBLE))
      comment: "Equipment cost component of all back charges. Identifies equipment mobilisation cost exposure from subcontractor failures."
    - name: "total_overhead_cost_amount"
      expr: SUM(CAST(overhead_cost_amount AS DOUBLE))
      comment: "Overhead cost component of all back charges. Captures indirect cost burden from subcontractor non-performance."
    - name: "back_charge_count"
      expr: COUNT(1)
      comment: "Total number of back-charge records. Baseline volume metric for frequency analysis of subcontractor non-performance events."
    - name: "disputed_back_charge_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of back charges currently under dispute. High dispute counts signal commercial relationship risk and potential legal exposure."
    - name: "approved_back_charge_count"
      expr: COUNT(CASE WHEN back_charge_status = 'Approved' THEN 1 END)
      comment: "Number of back charges that have been formally approved. Measures the rate at which claims are substantiated."
    - name: "avg_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved back-charge value per record. Indicates typical severity of subcontractor non-performance events."
    - name: "recovery_rate_numerator"
      expr: SUM(CAST(deduction_applied_amount AS DOUBLE))
      comment: "Numerator for back-charge recovery rate (deductions applied). Combine with total_claimed_amount in BI to compute recovery rate percentage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_final_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures subcontract financial close-out performance including final agreed values versus original contract values, retention release, liquidated damages, and settlement timeliness. Critical for commercial close-out governance and cash-flow forecasting."
  source: "`vibe_construction_v1`.`subcontractor`.`final_account`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — enables final account analysis by project."
    - name: "subcontract_id"
      expr: subcontract_id
      comment: "Foreign key to the subcontract — enables per-subcontract close-out analysis."
    - name: "final_account_status"
      expr: final_account_status
      comment: "Lifecycle status of the final account (e.g. Draft, Under Review, Agreed, Signed, Closed)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the final account settlement."
    - name: "performance_bond_released"
      expr: performance_bond_released
      comment: "Boolean indicating whether the performance bond has been released — key close-out milestone."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Method used to resolve disputes (e.g. Negotiation, Adjudication, Arbitration) — informs commercial risk management strategy."
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of final account settlement — enables close-out velocity trending."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the final account was approved — supports approval cycle time analysis."
    - name: "dlp_end_month"
      expr: DATE_TRUNC('MONTH', defects_liability_period_end_date)
      comment: "Month the defects liability period ends — used to track DLP expiry pipeline."
  measures:
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Sum of original subcontract values across all final accounts. Baseline for measuring contract growth and change order impact."
    - name: "total_final_agreed_value"
      expr: SUM(CAST(final_agreed_value AS DOUBLE))
      comment: "Sum of final agreed subcontract values. Represents the total financial settlement with subcontractors and directly impacts project cost at completion."
    - name: "total_approved_change_orders"
      expr: SUM(CAST(total_approved_change_orders AS DOUBLE))
      comment: "Total value of approved change orders across all final accounts. Measures scope growth and commercial exposure from variations."
    - name: "total_back_charges_deducted"
      expr: SUM(CAST(total_back_charges AS DOUBLE))
      comment: "Total back charges deducted in final account settlements. Measures realised cost recovery from subcontractor non-performance at close-out."
    - name: "total_liquidated_damages_deducted"
      expr: SUM(CAST(liquidated_damages_deducted AS DOUBLE))
      comment: "Total liquidated damages applied in final accounts. Measures financial penalties levied for subcontractor delay — a key commercial risk outcome."
    - name: "total_retention_released"
      expr: SUM(CAST(retention_released AS DOUBLE))
      comment: "Total retention released to subcontractors at final account. Tracks cash outflow obligations at project close-out."
    - name: "total_claims_settled_value"
      expr: SUM(CAST(claims_settled_value AS DOUBLE))
      comment: "Total value of claims settled in final accounts. Measures commercial dispute resolution outcomes and their financial impact."
    - name: "final_account_count"
      expr: COUNT(1)
      comment: "Total number of final accounts. Baseline volume metric for close-out pipeline management."
    - name: "signed_final_account_count"
      expr: COUNT(CASE WHEN final_account_status = 'Signed' THEN 1 END)
      comment: "Number of final accounts that have been fully signed off. Measures close-out completion rate — a key project governance KPI."
    - name: "avg_contract_growth_amount"
      expr: AVG(CAST(final_agreed_value AS DOUBLE) - CAST(original_contract_value AS DOUBLE))
      comment: "Average difference between final agreed value and original contract value per subcontract. Indicates typical scope growth and commercial management effectiveness."
    - name: "avg_final_agreed_value"
      expr: AVG(CAST(final_agreed_value AS DOUBLE))
      comment: "Average final agreed subcontract value. Provides a benchmark for subcontract size and settlement scale."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_bid_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the post-award performance of subcontractors and vendors evaluated through the performance scorecard process. Measures average performance scores, on-time delivery rates, and quality compliance rates to give executives a consolidated view of supply-chain execution health across all projects. This KPI drives subcontractor re-qualification decisions and informs future bid evaluations."
  source: "`vibe_construction_v1`.`subcontractor`.`performance_scorecard`"
  filter: scorecard_status = 'COMPLETED'
  dimensions:
    - name: "Scorecard Period"
      expr: evaluation_period
      comment: "The period (month/quarter) in which the performance scorecard was completed, enabling trend analysis over time"
    - name: "Scorecard Status"
      expr: scorecard_status
      comment: "Current lifecycle status of the scorecard record (COMPLETED, IN_REVIEW, DRAFT)"
  measures:
    - name: "Average Overall Score"
      expr: ROUND(AVG(CAST(overall_score AS DOUBLE)), 2)
      comment: "Mean overall performance score across all evaluated subcontractors in the selected period; executive headline metric"
    - name: "Total Scorecards Completed"
      expr: COUNT(performance_scorecard_id)
      comment: "Total number of completed performance scorecards, indicating evaluation coverage breadth"
    - name: "High Performers (Score >= 80%)"
      expr: COUNT(CASE WHEN overall_score >= 80 THEN 1 ELSE NULL END)
      comment: "Count of subcontractors achieving a score of 80 or above, flagging preferred-supplier candidates"
    - name: "Underperformers (Score < 60%)"
      expr: COUNT(CASE WHEN overall_score < 60 THEN 1 ELSE NULL END)
      comment: "Count of subcontractors scoring below 60, triggering re-qualification or remediation action"
    - name: "High Performer Rate (%)"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_score >= 80 THEN 1 ELSE NULL END) / NULLIF(COUNT(performance_scorecard_id), 0), 2)
      comment: "Percentage of evaluated subcontractors classified as high performers; primary executive KPI for supply-chain quality"
    - name: "Underperformer Rate (%)"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_score < 60 THEN 1 ELSE NULL END) / NULLIF(COUNT(performance_scorecard_id), 0), 2)
      comment: "Percentage of evaluated subcontractors classified as underperformers; risk indicator for project delivery"
    - name: "Average Safety Score"
      expr: ROUND(AVG(CAST(safety_score AS DOUBLE)), 2)
      comment: "Mean safety performance score across all scorecards; critical leading indicator for HSE compliance"
    - name: "Average Quality Score"
      expr: ROUND(AVG(CAST(quality_score AS DOUBLE)), 2)
      comment: "Mean quality performance score; tracks defect rates and rework exposure at the subcontractor level"
    - name: "Average Schedule Score"
      expr: ROUND(AVG(CAST(schedule_score AS DOUBLE)), 2)
      comment: "Mean schedule adherence score; proxy for on-time delivery and programme risk contribution"
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures subcontractor performance across quality, safety, schedule, productivity, and commercial conduct dimensions. Enables procurement and project leadership to make evidence-based decisions on subcontractor prequalification, bid eligibility, and contract renewal."
  source: "`vibe_construction_v1`.`subcontractor`.`performance_scorecard`"
  dimensions:
    - name: "project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — enables performance benchmarking by project."
    - name: "vendor_id"
      expr: vendor_id
      comment: "Foreign key to the vendor/subcontractor — enables longitudinal performance tracking per subcontractor."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Qualitative overall performance rating (e.g. Excellent, Satisfactory, Poor) — primary executive-level performance signal."
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Lifecycle status of the scorecard (e.g. Draft, Submitted, Approved, Finalised)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the scorecard — distinguishes approved evaluations from pending ones."
    - name: "bid_eligibility_status"
      expr: bid_eligibility_status
      comment: "Whether the subcontractor is eligible to bid on future work based on this evaluation — directly drives procurement decisions."
    - name: "evaluation_period"
      expr: evaluation_period
      comment: "Descriptive label for the evaluation period (e.g. Q1 2024, H1 2024)."
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of evaluation — enables performance trend analysis over time."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Boolean indicating whether a follow-up action is required — flags subcontractors needing intervention."
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended management action based on evaluation (e.g. Retain, Improve, Remove) — key decision output."
  measures:
    - name: "scorecard_count"
      expr: COUNT(1)
      comment: "Total number of performance scorecards. Baseline volume metric for evaluation programme coverage."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall performance score across all evaluated subcontractors. Primary KPI for portfolio-level subcontractor performance — drives prequalification and bid eligibility decisions."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality performance score. Directly linked to NCR rates and rework costs — informs quality risk management decisions."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average HSE/safety performance score. Critical for regulatory compliance and site safety governance — low scores trigger immediate intervention."
    - name: "avg_schedule_score"
      expr: AVG(CAST(schedule_score AS DOUBLE))
      comment: "Average schedule adherence score. Measures subcontractor contribution to programme delivery — informs delay risk and EOT exposure."
    - name: "avg_hse_score"
      expr: AVG(CAST(hse_score AS DOUBLE))
      comment: "Average HSE compliance score. Measures subcontractor safety management system effectiveness — a key prequalification criterion."
    - name: "avg_commercial_conduct_score"
      expr: AVG(CAST(commercial_conduct_score AS DOUBLE))
      comment: "Average commercial conduct score. Measures subcontractor behaviour in change order and claims management — informs contract administration risk."
    - name: "avg_productivity_score"
      expr: AVG(CAST(productivity_score AS DOUBLE))
      comment: "Average productivity performance score. Measures subcontractor output efficiency — informs resource planning and subcontract value decisions."
    - name: "avg_hse_trir"
      expr: AVG(CAST(hse_trir AS DOUBLE))
      comment: "Average Total Recordable Incident Rate (TRIR) across evaluated subcontractors. Industry-standard safety KPI used in prequalification and regulatory reporting."
    - name: "avg_schedule_adherence_spi"
      expr: AVG(CAST(schedule_adherence_spi AS DOUBLE))
      comment: "Average Schedule Performance Index (SPI) across subcontractors. SPI < 1.0 indicates behind-schedule performance — triggers programme intervention."
    - name: "avg_quality_ncr_rate"
      expr: AVG(CAST(quality_ncr_rate AS DOUBLE))
      comment: "Average NCR (Non-Conformance Report) rate across subcontractors. Measures quality defect frequency — high rates drive rework cost and schedule impact."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Number of subcontractors requiring follow-up action. Measures the scale of active performance management interventions needed."
    - name: "avg_productivity_units_completed"
      expr: AVG(CAST(productivity_units_completed AS DOUBLE))
      comment: "Average units of work completed per evaluation period. Provides a productivity benchmark for subcontractor output planning."
$$;
