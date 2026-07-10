-- Metric views for domain: supplier | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core supplier master KPIs tracking portfolio health, qualification status, performance ratings, and risk distribution across the active supplier base."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current lifecycle status of the supplier (e.g. Active, Inactive, Blocked) for portfolio segmentation."
    - name: "supplier_category"
      expr: supplier_category
      comment: "Category classification of the supplier (e.g. Raw Material, MRO, Services) for spend and risk analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification state of the supplier (e.g. Qualified, Conditional, Disqualified) for sourcing gate decisions."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk tier assigned to the supplier for risk-based monitoring and mitigation prioritization."
    - name: "business_type"
      expr: business_type
      comment: "Legal or organizational type of the supplier (e.g. Manufacturer, Distributor, Broker)."
    - name: "headquarters_country"
      expr: headquarters_country
      comment: "Country of supplier headquarters for geographic concentration and geopolitical risk analysis."
    - name: "minority_owned"
      expr: minority_owned
      comment: "Flag indicating minority-owned supplier for diversity spend reporting."
    - name: "small_business"
      expr: small_business
      comment: "Flag indicating small business classification for regulatory diversity reporting."
    - name: "woman_owned"
      expr: woman_owned
      comment: "Flag indicating woman-owned supplier for diversity spend reporting."
    - name: "iso9001_certified"
      expr: iso9001_certified
      comment: "ISO 9001 quality certification flag for quality gate filtering."
    - name: "relationship_start_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the supplier relationship began, used for tenure cohort analysis."
  measures:
    - name: "total_active_suppliers"
      expr: COUNT(DISTINCT CASE WHEN supplier_status = 'Active' THEN supplier_id END)
      comment: "Count of distinct active suppliers in the portfolio. Executives use this to assess supply base breadth and concentration risk."
    - name: "qualified_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN qualification_status = 'Qualified' THEN supplier_id END)
      comment: "Count of fully qualified suppliers available for sourcing. Drives sourcing strategy and single-source risk assessment."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across all suppliers. A key supply chain reliability KPI used in QBRs and supplier performance reviews."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average incoming quality acceptance rate across suppliers. Directly tied to production yield and cost of poor quality."
    - name: "avg_overall_scorecard_rating"
      expr: AVG(CAST(overall_scorecard_rating AS DOUBLE))
      comment: "Average overall scorecard rating across the supplier base. Used by procurement leadership to benchmark supplier performance."
    - name: "high_risk_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating IN ('High', 'Critical') THEN supplier_id END)
      comment: "Count of suppliers rated High or Critical risk. Triggers executive escalation and mitigation investment decisions."
    - name: "diversity_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN minority_owned = TRUE OR woman_owned = TRUE OR small_business = TRUE THEN supplier_id END)
      comment: "Count of diversity-classified suppliers (minority, woman-owned, or small business). Required for regulatory diversity spend reporting."
    - name: "iso9001_certified_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN iso9001_certified = TRUE THEN supplier_id END)
      comment: "Count of ISO 9001 certified suppliers. Used to assess quality system coverage across the supply base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard KPIs measuring quality, delivery, cost, and responsiveness scores across evaluation periods to drive supplier development and sourcing decisions."
  source: "`vibe_manufacturing_v1`.`supplier`.`scorecard`"
  dimensions:
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Current status of the scorecard (e.g. Draft, Published, Approved) for filtering to finalized evaluations."
    - name: "rating_tier"
      expr: rating_tier
      comment: "Performance tier assigned by the scorecard (e.g. Preferred, Approved, Conditional, Disqualified) for supplier segmentation."
    - name: "period_type"
      expr: period_type
      comment: "Evaluation period type (e.g. Monthly, Quarterly, Annual) for time-series performance trending."
    - name: "evaluation_period_start_year"
      expr: YEAR(evaluation_period_start_date)
      comment: "Year of the evaluation period start date for annual performance trending."
    - name: "evaluation_period_start_quarter"
      expr: DATE_TRUNC('quarter', evaluation_period_start_date)
      comment: "Quarter of the evaluation period for quarterly business review analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase value recorded on the scorecard for financial normalization."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score across all scorecards. The primary KPI for supplier performance management and tier assignment."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality dimension score. Directly linked to incoming quality, defect rates, and cost of poor quality."
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery dimension score. Tied to supply chain reliability and production schedule adherence."
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost competitiveness score. Used by procurement to benchmark pricing and negotiate contracts."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score measuring supplier agility and communication quality."
    - name: "avg_otd_percentage"
      expr: AVG(CAST(otd_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across evaluated scorecards. A leading indicator of supply chain disruption risk."
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average parts-per-million defect rate across scorecards. A critical quality KPI used in supplier development and disqualification decisions."
    - name: "total_purchase_value_evaluated"
      expr: SUM(CAST(total_purchase_value AS DOUBLE))
      comment: "Total purchase value covered by evaluated scorecards. Provides spend-weighted context for performance analysis."
    - name: "avg_cost_variance_percentage"
      expr: AVG(CAST(cost_variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage versus target. Signals pricing discipline and contract compliance across the supply base."
    - name: "preferred_tier_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN rating_tier = 'Preferred' THEN supplier_id END)
      comment: "Count of suppliers achieving Preferred tier rating. Used to track progress toward a high-performing supply base."
    - name: "scorecard_count"
      expr: COUNT(1)
      comment: "Total number of scorecards issued. Measures evaluation coverage and cadence across the supplier base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_risk_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier risk assessment KPIs covering financial, operational, quality, ESG, cybersecurity, and geopolitical risk dimensions to support risk-based sourcing and mitigation investment decisions."
  source: "`vibe_manufacturing_v1`.`supplier`.`risk_rating`"
  dimensions:
    - name: "overall_risk_tier"
      expr: overall_risk_tier
      comment: "Composite risk tier (e.g. Low, Medium, High, Critical) for executive risk dashboard segmentation."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the risk assessment (e.g. Draft, Published, Approved) for filtering to finalized assessments."
    - name: "country_risk_rating"
      expr: country_risk_rating
      comment: "Country-level risk rating for geopolitical and supply chain concentration analysis."
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Flag indicating single-source dependency, a critical supply continuity risk factor."
    - name: "sanctions_flag"
      expr: sanctions_flag
      comment: "Flag indicating the supplier is subject to trade sanctions, requiring immediate sourcing action."
    - name: "conflict_minerals_flag"
      expr: conflict_minerals_flag
      comment: "Flag indicating conflict minerals exposure for regulatory compliance reporting."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of the risk assessment for annual risk trend analysis."
    - name: "assessment_quarter"
      expr: DATE_TRUNC('quarter', assessment_date)
      comment: "Quarter of the risk assessment for quarterly risk review cadence."
  measures:
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average composite risk score across all assessed suppliers. The primary executive KPI for supply base risk posture."
    - name: "avg_financial_risk_score"
      expr: AVG(CAST(financial_risk_score AS DOUBLE))
      comment: "Average financial risk score. Signals supplier financial instability that could cause supply disruptions."
    - name: "avg_quality_risk_score"
      expr: AVG(CAST(quality_risk_score AS DOUBLE))
      comment: "Average quality risk score. Tied to incoming quality performance and cost of poor quality."
    - name: "avg_operational_risk_score"
      expr: AVG(CAST(operational_risk_score AS DOUBLE))
      comment: "Average operational risk score covering capacity, lead time, and delivery reliability."
    - name: "avg_esg_risk_score"
      expr: AVG(CAST(esg_risk_score AS DOUBLE))
      comment: "Average ESG risk score. Increasingly required for regulatory reporting and investor ESG disclosures."
    - name: "avg_cybersecurity_risk_score"
      expr: AVG(CAST(cybersecurity_risk_score AS DOUBLE))
      comment: "Average cybersecurity risk score. Critical for supply chain security and regulatory compliance (e.g. IEC 62443)."
    - name: "avg_geopolitical_risk_score"
      expr: AVG(CAST(geopolitical_risk_score AS DOUBLE))
      comment: "Average geopolitical risk score. Used to assess supply chain exposure to trade disruptions and sanctions."
    - name: "avg_lead_time_volatility_index"
      expr: AVG(CAST(lead_time_volatility_index AS DOUBLE))
      comment: "Average lead time volatility index. A supply planning KPI indicating how unpredictable supplier lead times are."
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average PPM defect rate from risk assessments. Cross-validates quality scorecard data for risk calibration."
    - name: "single_source_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN single_source_flag = TRUE THEN supplier_id END)
      comment: "Count of single-source suppliers. A critical supply continuity risk metric requiring executive attention and dual-source strategy."
    - name: "sanctioned_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN sanctions_flag = TRUE THEN supplier_id END)
      comment: "Count of suppliers flagged under trade sanctions. Requires immediate legal and procurement escalation."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN overall_risk_tier IN ('High', 'Critical') THEN 1 END)
      comment: "Count of risk assessments resulting in High or Critical tier. Drives risk mitigation investment prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier corrective action (SCAR) KPIs measuring quality issue resolution effectiveness, cycle times, recurrence rates, and cost impact to drive supplier quality improvement."
  source: "`vibe_manufacturing_v1`.`supplier`.`corrective_action`"
  dimensions:
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action (e.g. Open, In Progress, Closed, Overdue) for workload and escalation management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the quality issue (e.g. Critical, Major, Minor) for prioritization and escalation."
    - name: "issue_type"
      expr: issue_type
      comment: "Type of quality issue triggering the corrective action for root cause category analysis."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Flag indicating whether this is a recurring issue, a key indicator of corrective action effectiveness."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating the corrective action has been escalated, signaling supplier non-responsiveness."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the quality issue was identified for annual trend analysis."
    - name: "issue_quarter"
      expr: DATE_TRUNC('quarter', issue_date)
      comment: "Quarter the quality issue was identified for quarterly quality review trending."
    - name: "cost_impact_currency_code"
      expr: cost_impact_currency_code
      comment: "Currency of the cost impact amount for financial normalization."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of supplier corrective actions issued. A baseline quality management KPI indicating supplier quality issue volume."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open corrective actions. Measures outstanding quality risk exposure requiring supplier response."
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that are recurring issues. A critical indicator of corrective action effectiveness and systemic supplier quality problems."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that required escalation. Signals supplier non-responsiveness and relationship risk."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial cost impact of supplier quality issues. Directly informs supplier development investment decisions and charge-back negotiations."
    - name: "avg_cost_impact_per_action"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per corrective action. Used to prioritize high-cost quality issues for supplier development focus."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of material affected by supplier quality issues. Measures supply disruption magnitude."
    - name: "critical_severity_count"
      expr: COUNT(CASE WHEN severity_level = 'Critical' THEN 1 END)
      comment: "Count of critical severity corrective actions. Triggers executive escalation and potential supplier disqualification review."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit KPIs measuring audit coverage, scores, findings, and CAPA compliance to ensure supply base quality system integrity and regulatory compliance."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (e.g. Quality System, Process, Product, Environmental) for audit program coverage analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g. Planned, In Progress, Completed, Closed) for audit pipeline management."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit result (e.g. Pass, Conditional Pass, Fail) for supplier qualification gate decisions."
    - name: "audit_method"
      expr: audit_method
      comment: "Method used for the audit (e.g. On-site, Remote, Document Review) for audit program effectiveness analysis."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Flag indicating whether a CAPA was required as a result of the audit."
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Flag indicating a follow-up audit is required, signaling unresolved findings."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard audited against (e.g. ISO 9001, IATF 16949) for compliance coverage analysis."
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year the audit was conducted for annual audit program trending."
    - name: "audit_quarter"
      expr: DATE_TRUNC('quarter', audit_date)
      comment: "Quarter the audit was conducted for quarterly audit cadence reporting."
  measures:
    - name: "total_audits_conducted"
      expr: COUNT(1)
      comment: "Total number of supplier audits conducted. Measures audit program coverage and cadence."
    - name: "avg_audit_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average audit score across all completed audits. The primary KPI for supply base quality system health."
    - name: "audit_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_result = 'Pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN audit_result IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of audits resulting in a Pass outcome. Measures overall supply base quality system compliance."
    - name: "avg_total_findings_count"
      expr: AVG(CAST(total_findings_count AS DOUBLE))
      comment: "Average number of findings per audit. Indicates systemic quality system gaps across the supply base."
    - name: "avg_critical_findings_count"
      expr: AVG(CAST(critical_findings_count AS DOUBLE))
      comment: "Average critical findings per audit. Critical findings trigger immediate sourcing risk escalation."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of supplier audits conducted. Used to optimize audit program ROI and budget allocation."
    - name: "capa_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring a CAPA. Measures the proportion of audits uncovering actionable non-conformances."
    - name: "follow_up_audit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring a follow-up audit. Indicates unresolved findings and supplier remediation gaps."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier qualification KPIs tracking qualification status, audit scores, approval rates, and expiry risk to ensure only qualified suppliers are used in sourcing decisions."
  source: "`vibe_manufacturing_v1`.`supplier`.`qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (e.g. Qualified, Conditional, Disqualified, Expired) for sourcing gate enforcement."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g. New Supplier, Re-qualification, Commodity-specific) for program coverage analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned during qualification for risk-stratified supplier management."
    - name: "re_qualification_eligible"
      expr: re_qualification_eligible
      comment: "Flag indicating whether the supplier is eligible for re-qualification, informing supplier recovery decisions."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category scope of the qualification for category-level supply base coverage analysis."
    - name: "part_family"
      expr: part_family
      comment: "Part family scope of the qualification for product-level sourcing gate analysis."
    - name: "evaluation_start_year"
      expr: YEAR(evaluation_start_date)
      comment: "Year the qualification evaluation started for annual qualification program trending."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of supplier qualifications on record. Measures qualification program scope and coverage."
    - name: "qualified_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Count of fully qualified supplier-commodity combinations. Directly determines sourcing optionality and single-source risk."
    - name: "qualification_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualification evaluations resulting in full approval. Measures qualification program effectiveness and supplier readiness."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score achieved during qualification evaluations. Benchmarks supplier quality system maturity at onboarding."
    - name: "expiring_qualification_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND qualification_status = 'Qualified' THEN 1 END)
      comment: "Count of qualifications expiring within 90 days. A critical operational KPI to prevent sourcing disruptions from lapsed qualifications."
    - name: "disqualified_count"
      expr: COUNT(CASE WHEN qualification_status = 'Disqualified' THEN 1 END)
      comment: "Count of disqualified supplier-commodity combinations. Measures supply base attrition and sourcing risk exposure."
    - name: "conditional_approval_count"
      expr: COUNT(CASE WHEN qualification_status = 'Conditional' THEN 1 END)
      comment: "Count of conditionally approved qualifications requiring monitoring. Signals elevated supply risk requiring active management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_development_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier development plan KPIs measuring improvement program effectiveness, KPI achievement, cost impact, and closure rates to steer supplier development investment."
  source: "`vibe_manufacturing_v1`.`supplier`.`development_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the development plan (e.g. Active, Completed, Cancelled) for program pipeline management."
    - name: "action_type"
      expr: action_type
      comment: "Type of development action (e.g. Quality Improvement, Delivery Improvement, Cost Reduction) for program focus analysis."
    - name: "issue_type"
      expr: issue_type
      comment: "Type of issue driving the development plan for root cause category analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the issue addressed by the development plan for prioritization."
    - name: "priority"
      expr: priority
      comment: "Priority level of the development plan for resource allocation decisions."
    - name: "plan_start_year"
      expr: YEAR(plan_start_date)
      comment: "Year the development plan started for annual program investment trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of cost and savings estimates for financial normalization."
  measures:
    - name: "total_development_plans"
      expr: COUNT(1)
      comment: "Total number of supplier development plans. Measures the scale of active supplier improvement investment."
    - name: "plan_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of development plans successfully completed. Measures supplier development program effectiveness."
    - name: "avg_kpi_improvement"
      expr: AVG(CAST(actual_kpi_value AS DOUBLE) - CAST(baseline_kpi_value AS DOUBLE))
      comment: "Average KPI improvement achieved versus baseline across development plans. Quantifies the business impact of supplier development investments."
    - name: "kpi_target_achievement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_kpi_value >= target_kpi_value THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_kpi_value IS NOT NULL AND target_kpi_value IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of development plans where the target KPI was achieved. The primary effectiveness KPI for supplier development programs."
    - name: "total_estimated_savings"
      expr: SUM(CAST(estimated_savings AS DOUBLE))
      comment: "Total estimated savings from supplier development plans. Used to justify supplier development program ROI to leadership."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact of supplier development initiatives. Informs procurement budget planning."
    - name: "active_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN 1 END)
      comment: "Count of currently active development plans. Measures the current supplier development workload and investment scope."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier onboarding KPIs measuring onboarding cycle times, completion rates, blocking issues, and spend pipeline to optimize the supplier intake process."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier_onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status (e.g. In Progress, Completed, Rejected, On Hold) for pipeline management."
    - name: "onboarding_type"
      expr: onboarding_type
      comment: "Type of onboarding (e.g. New Supplier, Re-activation, Expansion) for program segmentation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned during onboarding for risk-stratified intake management."
    - name: "blocking_issue_flag"
      expr: blocking_issue_flag
      comment: "Flag indicating a blocking issue is preventing onboarding completion, requiring escalation."
    - name: "quality_audit_required_flag"
      expr: quality_audit_required_flag
      comment: "Flag indicating a quality audit is required as part of onboarding for audit resource planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the onboarding request for workload prioritization."
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year the onboarding request was submitted for annual intake volume trending."
    - name: "request_quarter"
      expr: DATE_TRUNC('quarter', request_date)
      comment: "Quarter the onboarding request was submitted for quarterly intake pipeline analysis."
    - name: "spend_currency_code"
      expr: spend_currency_code
      comment: "Currency of the estimated annual spend for financial normalization."
  measures:
    - name: "total_onboarding_requests"
      expr: COUNT(1)
      comment: "Total number of supplier onboarding requests. Measures supply base expansion activity and procurement pipeline."
    - name: "onboarding_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN onboarding_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of onboarding requests successfully completed. Measures onboarding process efficiency and supplier intake effectiveness."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average onboarding cycle time in days. A key process efficiency KPI; long cycle times delay supply base expansion and sourcing agility."
    - name: "blocking_issue_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN blocking_issue_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of onboarding requests with blocking issues. Identifies systemic process bottlenecks requiring operational intervention."
    - name: "total_estimated_annual_spend_pipeline"
      expr: SUM(CAST(estimated_annual_spend AS DOUBLE))
      comment: "Total estimated annual spend represented by in-flight onboarding requests. Measures the financial value of the supplier intake pipeline."
    - name: "avg_estimated_annual_spend"
      expr: AVG(CAST(estimated_annual_spend AS DOUBLE))
      comment: "Average estimated annual spend per onboarding request. Used to prioritize high-value supplier onboarding for resource allocation."
    - name: "blocked_onboarding_count"
      expr: COUNT(CASE WHEN blocking_issue_flag = TRUE AND onboarding_status NOT IN ('Completed', 'Rejected', 'Cancelled') THEN 1 END)
      comment: "Count of currently blocked onboarding requests. Requires immediate operational escalation to prevent supply pipeline delays."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_approved_vendor_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Vendor List (AVL) KPIs measuring supply base coverage, quality and delivery ratings, single-source risk, and spend targets to govern sourcing decisions."
  source: "`vibe_manufacturing_v1`.`supplier`.`approved_vendor_list`"
  dimensions:
    - name: "avl_status"
      expr: avl_status
      comment: "Current AVL status (e.g. Active, Inactive, Pending Review) for sourcing gate enforcement."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the AVL entry for risk-stratified sourcing decisions."
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Flag indicating single-source dependency for supply continuity risk analysis."
    - name: "certification_required_flag"
      expr: certification_required_flag
      comment: "Flag indicating certification is required for this AVL entry for compliance gate management."
    - name: "material_group"
      expr: material_group
      comment: "Material group classification for commodity-level supply base coverage analysis."
    - name: "geographic_supply_region"
      expr: geographic_supply_region
      comment: "Geographic region of supply for supply chain concentration and resilience analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of spend targets and pricing for financial normalization."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of AVL approval for annual supply base evolution tracking."
  measures:
    - name: "total_avl_entries"
      expr: COUNT(1)
      comment: "Total number of AVL entries. Measures the breadth of the approved supply base."
    - name: "active_avl_count"
      expr: COUNT(CASE WHEN avl_status = 'Active' THEN 1 END)
      comment: "Count of active AVL entries. Determines the currently available sourcing options for procurement."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across AVL entries. Used to benchmark supply base quality performance for sourcing decisions."
    - name: "avg_delivery_rating"
      expr: AVG(CAST(delivery_rating AS DOUBLE))
      comment: "Average delivery rating across AVL entries. Measures supply base delivery reliability for supply chain planning."
    - name: "avg_cost_competitiveness_rating"
      expr: AVG(CAST(cost_competitiveness_rating AS DOUBLE))
      comment: "Average cost competitiveness rating across AVL entries. Informs sourcing strategy and negotiation priorities."
    - name: "total_annual_spend_target"
      expr: SUM(CAST(annual_spend_target AS DOUBLE))
      comment: "Total annual spend target across all AVL entries. Provides the financial scale of the approved supply base."
    - name: "single_source_avl_count"
      expr: COUNT(CASE WHEN single_source_flag = TRUE THEN 1 END)
      comment: "Count of single-source AVL entries. A critical supply continuity risk KPI requiring dual-source strategy investment."
    - name: "avg_moq"
      expr: AVG(CAST(moq AS DOUBLE))
      comment: "Average minimum order quantity across AVL entries. Informs inventory policy and working capital requirements."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier certification KPIs tracking certification coverage, expiry risk, compliance rates, and corrective action requirements to maintain supply base regulatory and quality compliance."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (e.g. Active, Expired, Suspended, Revoked) for compliance gate enforcement."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. ISO 9001, IATF 16949, ISO 14001) for compliance coverage analysis."
    - name: "standard"
      expr: standard
      comment: "Certification standard for regulatory compliance reporting."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating associated with the certification for risk-stratified compliance management."
    - name: "corrective_actions_required"
      expr: corrective_actions_required
      comment: "Flag indicating corrective actions are required for this certification for compliance remediation tracking."
    - name: "procurement_gate_enabled"
      expr: procurement_gate_enabled
      comment: "Flag indicating this certification is a procurement gate, blocking sourcing if expired."
    - name: "auto_renewal_enabled"
      expr: auto_renewal_enabled
      comment: "Flag indicating auto-renewal is enabled for proactive certification management."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the certification was issued for certification portfolio aging analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of supplier certifications on record. Measures certification portfolio breadth."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Count of currently active certifications. Determines compliant sourcing capacity across the supply base."
    - name: "certification_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications currently active and compliant. A key regulatory compliance KPI for supply base audits."
    - name: "expiring_certification_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND certification_status = 'Active' THEN 1 END)
      comment: "Count of certifications expiring within 90 days. A critical operational KPI to prevent sourcing disruptions from lapsed certifications."
    - name: "procurement_gate_at_risk_count"
      expr: COUNT(CASE WHEN procurement_gate_enabled = TRUE AND certification_status != 'Active' THEN 1 END)
      comment: "Count of procurement-gated certifications that are not active. Directly blocks sourcing and requires immediate remediation."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_actions_required = TRUE THEN 1 END)
      comment: "Count of certifications with open corrective action requirements. Measures compliance remediation workload."
    - name: "avg_nonconformance_count"
      expr: AVG(CAST(nonconformance_count AS DOUBLE))
      comment: "Average number of nonconformances per certification. Benchmarks supplier quality system maturity across the supply base."
$$;