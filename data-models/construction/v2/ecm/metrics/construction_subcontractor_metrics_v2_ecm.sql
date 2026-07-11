-- Metric views for domain: subcontractor | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_back_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks financial exposure, recovery, and dispute patterns for back charges issued against subcontractors. Supports cost recovery governance, dispute resolution monitoring, and subcontractor accountability reporting."
  source: "`vibe_construction_v1`.`subcontractor`.`back_charge`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project under which the back charge was raised, enabling project-level cost recovery analysis."
    - name: "back_charge_status"
      expr: back_charge_status
      comment: "Current lifecycle status of the back charge (e.g. Pending, Approved, Disputed, Closed) for pipeline and aging analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Categorised reason for the back charge (e.g. Defective Work, Safety Violation, Delay) to identify systemic subcontractor performance issues."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the back charge is under dispute, enabling separation of clean vs. contested recovery amounts."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the back charge for multi-currency project reporting."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the back charge was approved, supporting trend analysis of recovery activity over time."
    - name: "subcontract_id"
      expr: subcontract_id
      comment: "Subcontract against which the back charge is raised, enabling subcontract-level cost recovery tracking."
  measures:
    - name: "total_claimed_amount"
      expr: SUM(CAST(total_claimed_amount AS DOUBLE))
      comment: "Total value of all back charges claimed. Indicates gross financial exposure from subcontractor non-performance."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total value of back charges formally approved for deduction. Represents confirmed cost recovery from subcontractors."
    - name: "total_deduction_applied_amount"
      expr: SUM(CAST(deduction_applied_amount AS DOUBLE))
      comment: "Total amount actually deducted from subcontractor payments. Measures realised financial recovery."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Aggregate labor cost component of back charges. Identifies labour-driven remediation costs."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost_amount AS DOUBLE))
      comment: "Aggregate material cost component of back charges. Identifies material-driven remediation costs."
    - name: "total_equipment_cost"
      expr: SUM(CAST(equipment_cost_amount AS DOUBLE))
      comment: "Aggregate equipment cost component of back charges. Identifies plant and equipment remediation costs."
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost_amount AS DOUBLE))
      comment: "Aggregate overhead cost component of back charges. Captures indirect costs of remediation."
    - name: "back_charge_count"
      expr: COUNT(1)
      comment: "Total number of back charges raised. Baseline volume metric for subcontractor non-performance frequency."
    - name: "disputed_back_charge_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of back charges currently under dispute. High values signal subcontractor relationship or documentation quality issues."
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deduction_applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed back charge value actually recovered via deductions. A key measure of cost recovery effectiveness."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_claimed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of claimed back charge value that has been formally approved. Indicates substantiation quality of back charge submissions."
    - name: "avg_back_charge_value"
      expr: AVG(CAST(total_claimed_amount AS DOUBLE))
      comment: "Average value per back charge. Helps benchmark severity of subcontractor non-performance incidents."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of back charges that are disputed. Elevated rates indicate subcontractor pushback or weak documentation practices."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_final_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures financial settlement outcomes for subcontract final accounts, including value variance, deductions, retention release, and settlement timeliness. Supports commercial close-out governance and cash flow management."
  source: "`vibe_construction_v1`.`subcontractor`.`final_account`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project to which the final account belongs, enabling project-level commercial close-out tracking."
    - name: "final_account_status"
      expr: final_account_status
      comment: "Current status of the final account (e.g. Draft, Agreed, Disputed, Closed) for pipeline management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the final account for multi-currency reporting."
    - name: "performance_bond_released"
      expr: performance_bond_released
      comment: "Indicates whether the performance bond has been released, a key commercial close-out milestone."
    - name: "settlement_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of final account settlement, supporting trend analysis of commercial close-out velocity."
    - name: "subcontract_id"
      expr: subcontract_id
      comment: "Subcontract being settled, enabling subcontract-level final account analysis."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Method used to resolve disputes (e.g. Negotiation, Adjudication, Arbitration) for dispute resolution effectiveness analysis."
  measures:
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Sum of original contract values across final accounts. Baseline for measuring commercial growth or reduction."
    - name: "total_final_agreed_value"
      expr: SUM(CAST(final_agreed_value AS DOUBLE))
      comment: "Sum of final agreed settlement values. Represents the total commercial out-turn for subcontracts."
    - name: "total_change_order_value"
      expr: SUM(CAST(total_approved_change_orders AS DOUBLE))
      comment: "Total value of approved change orders incorporated into final accounts. Measures scope growth impact."
    - name: "total_back_charges_deducted"
      expr: SUM(CAST(total_back_charges AS DOUBLE))
      comment: "Total back charges deducted in final account settlements. Measures cost recovery embedded in close-out."
    - name: "total_liquidated_damages"
      expr: SUM(CAST(liquidated_damages_deducted AS DOUBLE))
      comment: "Total liquidated damages deducted from final accounts. Indicates financial penalty exposure from subcontractor delays."
    - name: "total_retention_released"
      expr: SUM(CAST(retention_released AS DOUBLE))
      comment: "Total retention monies released at final account. Tracks cash flow impact of retention release obligations."
    - name: "total_claims_settled_value"
      expr: SUM(CAST(claims_settled_value AS DOUBLE))
      comment: "Total value of claims settled within final accounts. Measures commercial dispute resolution quantum."
    - name: "final_account_count"
      expr: COUNT(1)
      comment: "Total number of final accounts. Baseline volume metric for commercial close-out activity."
    - name: "value_growth_pct"
      expr: ROUND(100.0 * (SUM(CAST(final_agreed_value AS DOUBLE)) - SUM(CAST(original_contract_value AS DOUBLE))) / NULLIF(SUM(CAST(original_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage growth from original contract value to final agreed value. A key measure of scope creep and commercial risk on subcontracts."
    - name: "avg_final_agreed_value"
      expr: AVG(CAST(final_agreed_value AS DOUBLE))
      comment: "Average final agreed value per subcontract. Supports benchmarking of subcontract size and commercial complexity."
    - name: "avg_liquidated_damages_per_account"
      expr: AVG(CAST(liquidated_damages_deducted AS DOUBLE))
      comment: "Average liquidated damages deducted per final account. Indicates typical delay penalty exposure per subcontract."
    - name: "performance_bond_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN performance_bond_released = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of final accounts where the performance bond has been released. Tracks commercial close-out completeness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Evaluates subcontractor performance across HSE, quality, schedule, productivity, and commercial conduct dimensions. Supports prequalification decisions, contract renewal, and subcontractor development programmes."
  source: "`vibe_construction_v1`.`subcontractor`.`performance_scorecard`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project on which the subcontractor was evaluated, enabling project-level performance benchmarking."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Categorical overall performance rating (e.g. Excellent, Satisfactory, Poor) for subcontractor tiering and prequalification decisions."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the scorecard (e.g. Approved, Pending, Rejected) for governance workflow tracking."
    - name: "bid_eligibility_status"
      expr: bid_eligibility_status
      comment: "Whether the subcontractor remains eligible to bid based on performance. Directly links performance to procurement decisions."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Indicates whether a performance improvement follow-up is required, flagging subcontractors needing intervention."
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of evaluation for trend analysis of subcontractor performance over time."
    - name: "firm_profile_id"
      expr: firm_profile_id
      comment: "Subcontractor firm being evaluated, enabling firm-level performance aggregation across projects."
  measures:
    - name: "scorecard_count"
      expr: COUNT(1)
      comment: "Total number of performance scorecards issued. Baseline volume metric for subcontractor evaluation activity."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall performance score across evaluated subcontractors. Primary KPI for subcontractor performance benchmarking."
    - name: "avg_hse_score"
      expr: AVG(CAST(hse_score AS DOUBLE))
      comment: "Average HSE performance score. Critical safety governance metric for subcontractor HSE compliance management."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality performance score. Drives quality assurance decisions and NCR trend analysis."
    - name: "avg_schedule_score"
      expr: AVG(CAST(schedule_score AS DOUBLE))
      comment: "Average schedule adherence score. Indicates subcontractor reliability in meeting programme commitments."
    - name: "avg_productivity_score"
      expr: AVG(CAST(productivity_score AS DOUBLE))
      comment: "Average productivity score. Supports resource planning and subcontractor efficiency benchmarking."
    - name: "avg_commercial_conduct_score"
      expr: AVG(CAST(commercial_conduct_score AS DOUBLE))
      comment: "Average commercial conduct score. Measures subcontractor behaviour in claims, variations, and contract administration."
    - name: "avg_schedule_performance_index"
      expr: AVG(CAST(schedule_adherence_spi AS DOUBLE))
      comment: "Average Schedule Performance Index (SPI) across evaluated subcontractors. SPI < 1.0 indicates systemic schedule underperformance."
    - name: "avg_quality_ncr_rate"
      expr: AVG(CAST(quality_ncr_rate AS DOUBLE))
      comment: "Average NCR (Non-Conformance Report) rate per subcontractor evaluation. Elevated rates signal quality management failures."
    - name: "avg_hse_trir"
      expr: AVG(CAST(hse_trir AS DOUBLE))
      comment: "Average Total Recordable Incident Rate (TRIR) across subcontractor evaluations. A mandatory safety KPI for executive HSE reporting."
    - name: "avg_productivity_rate"
      expr: AVG(CAST(productivity_rate AS DOUBLE))
      comment: "Average productivity rate (units per period) across subcontractor evaluations. Supports labour productivity benchmarking."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scorecards requiring performance improvement follow-up. Indicates the proportion of underperforming subcontractors needing intervention."
    - name: "avg_rfi_response_timeliness_score"
      expr: AVG(CAST(rfi_response_timeliness_score AS DOUBLE))
      comment: "Average RFI response timeliness score. Measures subcontractor responsiveness to design and technical queries, impacting project schedule."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_change_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks financial and schedule impact of change orders issued to subcontractors. Supports scope change governance, budget variance analysis, and contract administration efficiency."
  source: "`vibe_construction_v1`.`subcontractor`.`subcontractor_change_order`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project to which the change order belongs, enabling project-level scope change analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the change order (e.g. Pending, Approved, Rejected) for pipeline and governance tracking."
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g. Scope Addition, Scope Reduction, Variation) for categorised change analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause category for the change order (e.g. Design Change, Client Request, Site Condition) to identify systemic change drivers."
    - name: "is_back_charge"
      expr: is_back_charge
      comment: "Indicates whether the change order is a back charge, enabling separation of punitive vs. scope-driven changes."
    - name: "is_time_and_material"
      expr: is_time_and_material
      comment: "Indicates whether the change order is priced on a time-and-material basis, which carries higher cost risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the change order for multi-currency project reporting."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the change order was submitted, supporting trend analysis of change order volume over time."
    - name: "subcontract_id"
      expr: subcontract_id
      comment: "Subcontract to which the change order applies, enabling subcontract-level change analysis."
  measures:
    - name: "change_order_count"
      expr: COUNT(1)
      comment: "Total number of subcontractor change orders. Baseline volume metric for scope change frequency."
    - name: "total_change_amount"
      expr: SUM(CAST(change_amount AS DOUBLE))
      comment: "Total net value of all subcontractor change orders. Measures aggregate financial impact of scope changes on subcontracts."
    - name: "total_original_contract_value"
      expr: SUM(CAST(original_contract_value AS DOUBLE))
      comment: "Sum of original contract values at time of change order. Baseline for measuring change order magnitude relative to contract size."
    - name: "total_revised_contract_value"
      expr: SUM(CAST(revised_contract_value AS DOUBLE))
      comment: "Sum of revised contract values after change orders. Represents the updated financial commitment to subcontractors."
    - name: "total_contingency_allocation"
      expr: SUM(CAST(contingency_allocation AS DOUBLE))
      comment: "Total contingency drawn down by subcontractor change orders. Tracks contingency consumption rate for budget risk management."
    - name: "avg_change_amount"
      expr: AVG(CAST(change_amount AS DOUBLE))
      comment: "Average value per change order. Benchmarks typical change order size for subcontract risk profiling."
    - name: "contract_value_growth_pct"
      expr: ROUND(100.0 * (SUM(CAST(revised_contract_value AS DOUBLE)) - SUM(CAST(original_contract_value AS DOUBLE))) / NULLIF(SUM(CAST(original_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage growth in subcontract value due to change orders. A primary indicator of scope creep and commercial risk."
    - name: "approved_change_order_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of change orders with approved status. Measures throughput of the change approval process."
    - name: "time_and_material_change_count"
      expr: COUNT(CASE WHEN is_time_and_material = TRUE THEN 1 END)
      comment: "Number of change orders priced on time-and-material basis. High volumes indicate cost control risk from unpriced scope."
    - name: "back_charge_change_order_count"
      expr: COUNT(CASE WHEN is_back_charge = TRUE THEN 1 END)
      comment: "Number of change orders that are back charges. Tracks punitive commercial actions embedded in the change order process."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`subcontractor_eot_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analyses Extension of Time (EOT) claims submitted by subcontractors, covering claim volumes, days claimed vs. granted, critical path impacts, and dispute rates. Supports programme risk management and contractual entitlement governance."
  source: "`vibe_construction_v1`.`subcontractor`.`subcontractor_eot_claim`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project to which the EOT claim relates, enabling project-level programme risk analysis."
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the EOT claim (e.g. Submitted, Under Assessment, Granted, Rejected, Disputed) for pipeline management."
    - name: "delay_cause_category"
      expr: delay_cause_category
      comment: "Category of delay event (e.g. Employer Risk, Force Majeure, Concurrent Delay) for root cause analysis of programme slippage."
    - name: "critical_path_impact_flag"
      expr: critical_path_impact_flag
      comment: "Indicates whether the claimed delay impacts the critical path. Critical path claims carry the highest programme risk."
    - name: "concurrent_delay_flag"
      expr: concurrent_delay_flag
      comment: "Indicates concurrent delay, which affects entitlement assessment and is a key factor in EOT determination."
    - name: "notice_compliance_flag"
      expr: notice_compliance_flag
      comment: "Indicates whether the subcontractor complied with contractual notice requirements. Non-compliance may bar entitlement."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status of the EOT claim for contested claims tracking and resolution management."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the EOT claim was submitted, supporting trend analysis of claim activity over the project lifecycle."
    - name: "subcontract_id"
      expr: subcontract_id
      comment: "Subcontract under which the EOT claim is submitted, enabling subcontract-level entitlement analysis."
  measures:
    - name: "eot_claim_count"
      expr: COUNT(1)
      comment: "Total number of EOT claims submitted by subcontractors. Baseline volume metric for programme disruption frequency."
    - name: "critical_path_claim_count"
      expr: COUNT(CASE WHEN critical_path_impact_flag = TRUE THEN 1 END)
      comment: "Number of EOT claims asserting critical path impact. These claims carry the highest risk to project completion date."
    - name: "notice_non_compliance_count"
      expr: COUNT(CASE WHEN notice_compliance_flag = FALSE THEN 1 END)
      comment: "Number of EOT claims where the subcontractor failed to comply with contractual notice requirements. Indicates contract administration weaknesses."
    - name: "concurrent_delay_claim_count"
      expr: COUNT(CASE WHEN concurrent_delay_flag = TRUE THEN 1 END)
      comment: "Number of EOT claims involving concurrent delay. Concurrent delay claims are complex and typically reduce subcontractor entitlement."
    - name: "cost_associated_claim_count"
      expr: COUNT(CASE WHEN cost_claim_associated_flag = TRUE THEN 1 END)
      comment: "Number of EOT claims with an associated cost claim. These represent dual financial and programme risk to the project."
    - name: "critical_path_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_path_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EOT claims asserting critical path impact. High rates indicate systemic programme risk from subcontractor delays."
    - name: "notice_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN notice_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EOT claims where contractual notice was properly served. Low rates indicate subcontractor contract administration failures."
    - name: "cost_associated_claim_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cost_claim_associated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of EOT claims that also carry a financial cost claim. Measures the proportion of programme claims escalating to financial disputes."
    - name: "distinct_subcontracts_with_eot_claims"
      expr: COUNT(DISTINCT subcontract_id)
      comment: "Number of distinct subcontracts that have submitted at least one EOT claim. Measures breadth of programme disruption across the subcontractor base."
$$;