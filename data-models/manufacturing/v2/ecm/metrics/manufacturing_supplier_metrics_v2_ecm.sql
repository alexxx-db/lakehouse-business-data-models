-- Metric views for domain: supplier | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier portfolio metrics covering qualification status, delivery performance, quality acceptance, and scorecard ratings — used by procurement leadership to manage the supplier base and identify at-risk vendors."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current operational status of the supplier (Active, Inactive, Blocked, etc.) for portfolio segmentation."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification standing of the supplier (Qualified, Conditional, Disqualified) for sourcing eligibility analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk tier assigned to the supplier (Low, Medium, High, Critical) for risk-based monitoring."
    - name: "supplier_category"
      expr: supplier_category
      comment: "Category classification of the supplier (Direct, Indirect, Services, etc.) for spend and performance segmentation."
    - name: "business_type"
      expr: business_type
      comment: "Legal or organizational type of the supplier (e.g., Manufacturer, Distributor, Broker) for strategic sourcing analysis."
    - name: "headquarters_country"
      expr: headquarters_country
      comment: "Country of supplier headquarters for geographic supply chain risk analysis."
    - name: "relationship_start_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the supplier relationship began, used to analyze tenure and loyalty of the supplier base."
    - name: "iso9001_certified"
      expr: iso9001_certified
      comment: "Flag indicating whether the supplier holds ISO 9001 certification, used for quality gate filtering."
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Preferred transaction currency of the supplier for financial exposure analysis."
  measures:
    - name: "total_active_suppliers"
      expr: COUNT(CASE WHEN supplier_status = 'Active' THEN supplier_id END)
      comment: "Count of active suppliers in the portfolio. Executives use this to track supply base size and concentration risk."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across all suppliers. A key operational KPI for supply chain reliability; drops trigger supplier reviews."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average incoming quality acceptance rate across suppliers. Directly linked to production yield and rework costs."
    - name: "avg_overall_scorecard_rating"
      expr: AVG(CAST(overall_scorecard_rating AS DOUBLE))
      comment: "Average composite scorecard rating across the supplier base. Used in QBRs to benchmark supplier performance trends."
    - name: "high_risk_supplier_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN supplier_id END)
      comment: "Number of suppliers rated High or Critical risk. Drives risk mitigation investment and dual-sourcing decisions."
    - name: "qualified_supplier_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN supplier_id END)
      comment: "Count of fully qualified suppliers available for sourcing. A drop signals qualification backlog or attrition risk."
    - name: "single_source_supplier_count"
      expr: COUNT(CASE WHEN small_business = FALSE AND minority_owned = FALSE THEN supplier_id END)
      comment: "Proxy count of suppliers that may represent single-source dependencies, used to flag supply continuity risk."
    - name: "iso9001_certified_supplier_count"
      expr: COUNT(CASE WHEN iso9001_certified = TRUE THEN supplier_id END)
      comment: "Number of ISO 9001 certified suppliers. Used to track quality certification coverage across the supply base."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average payment terms (in days) across suppliers. Informs working capital and cash flow planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard metrics covering quality, delivery, cost, and responsiveness scores — used by procurement and supply chain leadership to track supplier performance trends and drive improvement actions."
  source: "`vibe_manufacturing_v1`.`supplier`.`scorecard`"
  dimensions:
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Publication or approval status of the scorecard (Draft, Published, Approved) for filtering active evaluations."
    - name: "period_type"
      expr: period_type
      comment: "Evaluation period type (Monthly, Quarterly, Annual) for time-series performance trending."
    - name: "rating_tier"
      expr: rating_tier
      comment: "Overall performance tier assigned (Preferred, Approved, Conditional, Disqualified) for supplier segmentation."
    - name: "rating_grade"
      expr: rating_grade
      comment: "Letter or numeric grade assigned to the supplier for the period, used in executive dashboards."
    - name: "evaluation_period_start"
      expr: DATE_TRUNC('quarter', evaluation_period_start_date)
      comment: "Quarter in which the evaluation period started, enabling quarterly performance trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for financial KPIs within the scorecard, for multi-currency normalization."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average composite supplier performance score across all evaluated suppliers. The primary KPI for supplier performance steering meetings."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality dimension score. Directly tied to incoming quality rates and production disruption risk."
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score. Drives decisions on safety stock levels and expediting costs."
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost competitiveness score. Used to identify suppliers for cost reduction negotiations."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score. Indicates supplier agility and collaboration quality for strategic partnership decisions."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate recorded in scorecards. A leading indicator of supply chain reliability."
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average parts-per-million defect rate across evaluated suppliers. Directly linked to quality cost and customer satisfaction."
    - name: "avg_defect_rate_percent"
      expr: AVG(CAST(defect_rate_percent AS DOUBLE))
      comment: "Average defect rate percentage. Used alongside PPM to assess incoming quality trends and set improvement targets."
    - name: "total_purchase_value_evaluated"
      expr: SUM(CAST(total_purchase_value AS DOUBLE))
      comment: "Total purchase spend covered by scorecards in the period. Ensures performance evaluation covers material spend exposure."
    - name: "avg_cost_variance_pct"
      expr: AVG(CAST(cost_variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage versus target. Signals pricing discipline and contract compliance across the supply base."
    - name: "suppliers_requiring_improvement"
      expr: COUNT(CASE WHEN improvement_actions_required IS NOT NULL AND improvement_actions_required <> '' THEN scorecard_id END)
      comment: "Count of scorecards with open improvement actions required. Drives supplier development resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_risk_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier risk assessment metrics covering financial, operational, quality, ESG, and geopolitical risk dimensions — used by supply chain risk management and procurement leadership to prioritize mitigation investments."
  source: "`vibe_manufacturing_v1`.`supplier`.`risk_rating`"
  dimensions:
    - name: "overall_risk_tier"
      expr: overall_risk_tier
      comment: "Composite risk tier (Low, Medium, High, Critical) for portfolio-level risk segmentation."
    - name: "risk_category"
      expr: risk_category
      comment: "Primary risk category driving the assessment (Financial, Operational, Geopolitical, ESG, Cybersecurity) for targeted mitigation."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (Draft, Published, Approved) for filtering active risk records."
    - name: "country_risk_rating"
      expr: country_risk_rating
      comment: "Country-level risk rating for geographic concentration and geopolitical risk analysis."
    - name: "assessment_period_start"
      expr: DATE_TRUNC('quarter', assessment_period_start_date)
      comment: "Quarter of the assessment period start for trend analysis of risk evolution over time."
    - name: "sanctions_flag"
      expr: sanctions_flag
      comment: "Indicates whether the supplier is flagged under sanctions screening, a critical compliance gate."
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Indicates single-source dependency, amplifying the business impact of any risk materialization."
  measures:
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average composite risk score across assessed suppliers. The primary KPI for supply chain risk steering; increases trigger mitigation programs."
    - name: "avg_financial_risk_score"
      expr: AVG(CAST(financial_risk_score AS DOUBLE))
      comment: "Average financial risk score. Signals supplier solvency risk and potential supply disruption from financial distress."
    - name: "avg_operational_risk_score"
      expr: AVG(CAST(operational_risk_score AS DOUBLE))
      comment: "Average operational risk score. Reflects capacity, lead time, and process stability risks affecting supply continuity."
    - name: "avg_quality_risk_score"
      expr: AVG(CAST(quality_risk_score AS DOUBLE))
      comment: "Average quality risk score. Directly linked to incoming quality failure rates and production disruption probability."
    - name: "avg_esg_risk_score"
      expr: AVG(CAST(esg_risk_score AS DOUBLE))
      comment: "Average ESG risk score. Increasingly material for regulatory compliance, investor reporting, and brand risk management."
    - name: "avg_geopolitical_risk_score"
      expr: AVG(CAST(geopolitical_risk_score AS DOUBLE))
      comment: "Average geopolitical risk score. Used to assess supply chain exposure to trade disruptions, tariffs, and regional instability."
    - name: "avg_cybersecurity_risk_score"
      expr: AVG(CAST(cybersecurity_risk_score AS DOUBLE))
      comment: "Average cybersecurity risk score. Critical for suppliers with digital integration or access to sensitive systems."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN overall_risk_tier IN ('High', 'Critical') THEN risk_rating_id END)
      comment: "Number of suppliers assessed at High or Critical risk. Drives board-level supply chain risk reporting and mitigation budget allocation."
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average PPM defect rate from risk assessments. Cross-validates quality risk scores with actual defect data."
    - name: "avg_lead_time_volatility_index"
      expr: AVG(CAST(lead_time_volatility_index AS DOUBLE))
      comment: "Average lead time volatility index. High volatility drives safety stock increases and expediting costs."
    - name: "sanctions_flagged_supplier_count"
      expr: COUNT(CASE WHEN sanctions_flag = TRUE THEN risk_rating_id END)
      comment: "Count of suppliers flagged under sanctions screening. A compliance-critical metric requiring immediate executive action."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit execution and outcome metrics covering audit scores, findings, CAPA rates, and follow-up compliance — used by supplier quality and procurement leadership to manage audit programs and track supplier improvement."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (Initial, Surveillance, Re-qualification, Announced, Unannounced) for program coverage analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (Planned, In Progress, Completed, Closed) for pipeline and completion tracking."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit outcome (Pass, Conditional Pass, Fail) for supplier qualification decision-making."
    - name: "audit_method"
      expr: audit_method
      comment: "Method used for the audit (On-site, Remote, Document Review) for resource planning and coverage analysis."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Standard against which the audit was conducted (ISO 9001, IATF 16949, ISO 14001) for compliance coverage tracking."
    - name: "audit_date_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of audit execution for scheduling cadence and workload distribution analysis."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Indicates whether a CAPA was required as an audit outcome, used to measure audit severity distribution."
    - name: "follow_up_audit_required_flag"
      expr: follow_up_audit_required_flag
      comment: "Indicates whether a follow-up audit was mandated, signaling unresolved compliance gaps."
  measures:
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all completed audits. The primary KPI for supplier quality system maturity; declines trigger escalation."
    - name: "total_audits_completed"
      expr: COUNT(CASE WHEN audit_status = 'Completed' THEN supplier_audit_id END)
      comment: "Total number of completed audits. Measures audit program execution rate against the planned schedule."
    - name: "avg_total_findings_count"
      expr: AVG(CAST(total_findings_count AS DOUBLE))
      comment: "Average number of findings per audit. Higher averages indicate systemic supplier quality system weaknesses."
    - name: "capa_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_required_flag = TRUE THEN supplier_audit_id END) / NULLIF(COUNT(supplier_audit_id), 0), 2)
      comment: "Percentage of audits requiring a CAPA. A high rate signals widespread non-conformance across the supply base."
    - name: "follow_up_audit_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN supplier_audit_id END) / NULLIF(COUNT(supplier_audit_id), 0), 2)
      comment: "Percentage of audits requiring a follow-up. Indicates the proportion of suppliers with unresolved compliance gaps."
    - name: "audit_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_result = 'Pass' THEN supplier_audit_id END) / NULLIF(COUNT(CASE WHEN audit_status = 'Completed' THEN supplier_audit_id END), 0), 2)
      comment: "Percentage of completed audits resulting in a Pass. A key supplier quality KPI for executive reporting."
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per audit. Used to optimize audit program spend and justify remote vs. on-site audit decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding severity, closure, and recurrence metrics — used by supplier quality teams to prioritize corrective actions, track finding resolution rates, and identify systemic supplier non-conformances."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding (Major Non-conformance, Minor Non-conformance, Observation) for severity-based prioritization."
    - name: "finding_status"
      expr: finding_status
      comment: "Current resolution status of the finding (Open, In Progress, Closed, Overdue) for workload and compliance tracking."
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding for risk-weighted analysis of the supplier audit finding portfolio."
    - name: "finding_category"
      expr: finding_category
      comment: "Business process area category of the finding (Quality System, Process Control, Documentation, etc.) for root cause trending."
    - name: "process_area"
      expr: process_area
      comment: "Specific process area where the finding was identified, enabling targeted improvement program design."
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Indicates whether the finding is a recurrence of a previously identified issue, signaling ineffective corrective actions."
    - name: "identified_date_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the finding was identified for trend analysis of finding rates over time."
  measures:
    - name: "total_open_findings"
      expr: COUNT(CASE WHEN finding_status = 'Open' THEN supplier_audit_finding_id END)
      comment: "Total number of open audit findings. A critical compliance KPI; high open counts signal supplier quality system risk."
    - name: "repeat_finding_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_finding_flag = TRUE THEN supplier_audit_finding_id END) / NULLIF(COUNT(supplier_audit_finding_id), 0), 2)
      comment: "Percentage of findings that are recurrences. High repeat rates indicate ineffective corrective actions and systemic supplier issues."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN supplier_audit_finding_id END) / NULLIF(COUNT(supplier_audit_finding_id), 0), 2)
      comment: "Percentage of findings that required escalation. Signals supplier non-responsiveness and drives relationship management decisions."
    - name: "finding_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN finding_status = 'Closed' THEN supplier_audit_finding_id END) / NULLIF(COUNT(supplier_audit_finding_id), 0), 2)
      comment: "Percentage of findings that have been closed. Measures effectiveness of the supplier corrective action process."
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded. Used to track audit program intensity and supplier non-conformance volume."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier corrective action (SCAR) metrics covering closure rates, cost impact, recurrence, and timeliness — used by supplier quality leadership to measure corrective action effectiveness and supplier responsiveness."
  source: "`vibe_manufacturing_v1`.`supplier`.`corrective_action`"
  dimensions:
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action (Open, In Progress, Closed, Overdue) for workload and compliance tracking."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (Containment, Root Cause, Preventive) for process improvement analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the underlying issue driving the corrective action, for risk-weighted prioritization."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Indicates whether the issue is a recurrence, signaling ineffective prior corrective actions."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the corrective action was escalated due to supplier non-responsiveness."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the corrective action is due, for scheduling and overdue risk analysis."
  measures:
    - name: "total_open_corrective_actions"
      expr: COUNT(CASE WHEN corrective_action_status = 'Open' THEN corrective_action_id END)
      comment: "Total open corrective actions. A key supplier quality KPI; high open counts signal unresolved supplier non-conformances."
    - name: "corrective_action_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status = 'Closed' THEN corrective_action_id END) / NULLIF(COUNT(corrective_action_id), 0), 2)
      comment: "Percentage of corrective actions closed. Measures supplier responsiveness and quality system effectiveness."
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN corrective_action_id END) / NULLIF(COUNT(corrective_action_id), 0), 2)
      comment: "Percentage of corrective actions that are recurrences. High rates indicate systemic supplier quality failures requiring escalation."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial cost impact of supplier corrective actions. Directly informs supplier performance penalties and development investment decisions."
    - name: "avg_cost_impact_per_action"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per corrective action. Used to prioritize high-cost supplier issues for executive attention."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of parts or materials affected by corrective actions. Measures the production impact of supplier quality failures."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN corrective_action_id END) / NULLIF(COUNT(corrective_action_id), 0), 2)
      comment: "Percentage of corrective actions escalated. Signals supplier non-responsiveness and drives relationship management decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier qualification status and audit performance metrics — used by procurement and supplier quality teams to manage qualification pipelines, track expiry risk, and ensure sourcing eligibility."
  source: "`vibe_manufacturing_v1`.`supplier`.`qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (Qualified, Conditional, Disqualified, Expired) for sourcing eligibility filtering."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (Initial, Re-qualification, Conditional) for program management analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned during qualification for risk-stratified supplier management."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category covered by the qualification for spend category management."
    - name: "ppap_level"
      expr: ppap_level
      comment: "PPAP level required or achieved during qualification, relevant for automotive and regulated manufacturing."
    - name: "re_qualification_eligible"
      expr: re_qualification_eligible
      comment: "Indicates whether the supplier is eligible for re-qualification, used to manage qualification renewal pipelines."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of qualification expiry for proactive renewal planning and sourcing continuity risk management."
  measures:
    - name: "total_qualified_suppliers"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN qualification_id END)
      comment: "Total number of fully qualified suppliers. A baseline KPI for sourcing capacity and supply base health."
    - name: "qualification_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Qualified' THEN qualification_id END) / NULLIF(COUNT(qualification_id), 0), 2)
      comment: "Percentage of qualification assessments resulting in full qualification. Measures supplier development program effectiveness."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score achieved during qualification assessments. Indicates the quality maturity of the incoming supplier base."
    - name: "avg_qualification_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average overall qualification score. Used to benchmark supplier readiness and set minimum qualification thresholds."
    - name: "expiring_qualifications_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND qualification_status = 'Qualified' THEN qualification_id END)
      comment: "Count of qualifications expiring within 90 days. Drives proactive renewal actions to prevent sourcing disruptions."
    - name: "conditional_qualification_count"
      expr: COUNT(CASE WHEN qualification_status = 'Conditional' THEN qualification_id END)
      comment: "Number of suppliers with conditional qualification status. Signals elevated supply risk requiring active monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_approved_vendor_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Vendor List (AVL) metrics covering supplier approval status, quality and delivery ratings, and spend targets — used by procurement to manage sourcing eligibility, preferred supplier programs, and commodity coverage."
  source: "`vibe_manufacturing_v1`.`supplier`.`approved_vendor_list`"
  dimensions:
    - name: "avl_status"
      expr: avl_status
      comment: "Current AVL status of the supplier-commodity combination (Active, Inactive, Suspended) for sourcing eligibility."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status (Approved, Pending, Rejected) for AVL governance tracking."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category covered by the AVL entry for spend category management and coverage analysis."
    - name: "preferred_flag"
      expr: preferred_flag
      comment: "Indicates preferred supplier designation for a commodity, used to drive sourcing channel optimization."
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Flags single-source AVL entries representing supply continuity risk."
    - name: "geographic_supply_region"
      expr: geographic_supply_region
      comment: "Geographic region of supply for regional concentration and geopolitical risk analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the AVL entry for risk-stratified supplier management."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the AVL entry became effective for tenure and renewal analysis."
  measures:
    - name: "total_active_avl_entries"
      expr: COUNT(CASE WHEN avl_status = 'Active' THEN approved_vendor_list_id END)
      comment: "Total active AVL entries. Measures the breadth of approved sourcing options across commodities."
    - name: "preferred_supplier_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN preferred_flag = TRUE THEN approved_vendor_list_id END) / NULLIF(COUNT(CASE WHEN avl_status = 'Active' THEN approved_vendor_list_id END), 0), 2)
      comment: "Percentage of active AVL entries designated as preferred suppliers. Measures preferred supplier program penetration."
    - name: "single_source_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN single_source_flag = TRUE THEN approved_vendor_list_id END) / NULLIF(COUNT(CASE WHEN avl_status = 'Active' THEN approved_vendor_list_id END), 0), 2)
      comment: "Percentage of active AVL entries that are single-source. High rates signal supply continuity risk requiring dual-sourcing investment."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating of approved vendors. Used to set minimum quality thresholds for AVL maintenance."
    - name: "avg_delivery_rating"
      expr: AVG(CAST(delivery_rating AS DOUBLE))
      comment: "Average delivery performance rating of approved vendors. Informs safety stock and lead time planning decisions."
    - name: "avg_cost_competitiveness_rating"
      expr: AVG(CAST(cost_competitiveness_rating AS DOUBLE))
      comment: "Average cost competitiveness rating of approved vendors. Used to identify commodity categories with pricing improvement opportunities."
    - name: "total_annual_spend_target"
      expr: SUM(CAST(annual_spend_target AS DOUBLE))
      comment: "Total planned annual spend across all AVL entries. Used for procurement budget planning and supplier concentration analysis."
    - name: "avg_moq"
      expr: AVG(CAST(moq AS DOUBLE))
      comment: "Average minimum order quantity across AVL entries. Informs inventory policy and working capital requirements."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier agreement portfolio metrics covering contract value, payment terms, compliance flags, and renewal risk — used by procurement and legal leadership to manage contract coverage, value, and compliance obligations."
  source: "`vibe_manufacturing_v1`.`supplier`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (Active, Expired, Terminated, Draft) for contract portfolio management."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (Framework, Blanket, Spot, Long-term) for contract strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement for multi-currency spend exposure analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews, used to manage renewal risk and negotiation windows."
    - name: "esg_compliance_flag"
      expr: esg_compliance_flag
      comment: "Indicates whether ESG compliance clauses are included, for sustainability program coverage tracking."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective for contract vintage and renewal cycle analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing the agreement for logistics cost and risk allocation analysis."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of all supplier agreements. The primary financial KPI for procurement contract portfolio management."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average agreement value. Used to benchmark contract sizes and identify outliers requiring special governance."
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END)
      comment: "Total number of active supplier agreements. Measures contract coverage across the supply base."
    - name: "expiring_agreements_90d"
      expr: COUNT(CASE WHEN effective_end_date <= DATE_ADD(CURRENT_DATE(), 90) AND agreement_status = 'Active' THEN agreement_id END)
      comment: "Count of active agreements expiring within 90 days. Drives proactive renewal and renegotiation actions."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average payment terms (days) across agreements. Informs working capital optimization and cash flow forecasting."
    - name: "esg_compliance_coverage_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN esg_compliance_flag = TRUE THEN agreement_id END) / NULLIF(COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END), 0), 2)
      comment: "Percentage of active agreements with ESG compliance clauses. Measures sustainability program contractual coverage."
    - name: "avg_price_index"
      expr: AVG(CAST(price_index AS DOUBLE))
      comment: "Average price index across agreements. Used to track commodity price escalation exposure and contract pricing trends."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier certification portfolio metrics covering certification coverage, expiry risk, and non-conformance rates — used by supplier quality and procurement leadership to ensure supply base compliance with quality and regulatory standards."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (Active, Expired, Suspended, Revoked) for compliance gate management."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (ISO 9001, IATF 16949, AS9100, ISO 14001, etc.) for standard-specific coverage analysis."
    - name: "standard"
      expr: standard
      comment: "Specific standard version the certification covers for regulatory compliance tracking."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating associated with the certification status for prioritizing renewal and audit actions."
    - name: "business_criticality"
      expr: business_criticality
      comment: "Business criticality of the certification (Critical, High, Medium, Low) for prioritizing renewal resources."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of certification expiry for proactive renewal planning and sourcing continuity risk management."
    - name: "procurement_gate_enabled"
      expr: procurement_gate_enabled
      comment: "Indicates whether this certification is a hard gate for procurement, making expiry a sourcing-blocking event."
  measures:
    - name: "total_active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN supplier_certification_id END)
      comment: "Total active supplier certifications. Measures the breadth of certified supply base coverage."
    - name: "expiring_certifications_90d"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND certification_status = 'Active' THEN supplier_certification_id END)
      comment: "Count of active certifications expiring within 90 days. Drives proactive renewal actions to prevent sourcing disruptions."
    - name: "certification_expiry_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'Expired' THEN supplier_certification_id END) / NULLIF(COUNT(supplier_certification_id), 0), 2)
      comment: "Percentage of certifications that have expired. High rates signal gaps in certification renewal management."
    - name: "corrective_actions_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_actions_required = TRUE THEN supplier_certification_id END) / NULLIF(COUNT(CASE WHEN certification_status = 'Active' THEN supplier_certification_id END), 0), 2)
      comment: "Percentage of active certifications with open corrective actions required. Signals certification compliance risk."
    - name: "procurement_gated_certification_count"
      expr: COUNT(CASE WHEN procurement_gate_enabled = TRUE AND certification_status = 'Active' THEN supplier_certification_id END)
      comment: "Count of active certifications that are hard procurement gates. Expiry of these directly blocks purchasing, making them highest priority."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_development_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier development plan metrics covering improvement targets, cost impact, and plan completion rates — used by supplier development teams and procurement leadership to track supplier capability improvement investments and outcomes."
  source: "`vibe_manufacturing_v1`.`supplier`.`development_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the development plan (Active, Completed, Cancelled, On Hold) for portfolio management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the development plan (Critical, High, Medium, Low) for resource allocation decisions."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the underlying issue driving the development plan, for risk-weighted prioritization."
    - name: "action_type"
      expr: action_type
      comment: "Type of development action (Quality Improvement, Capacity Expansion, Cost Reduction, Delivery Improvement) for program analysis."
    - name: "target_kpi_metric"
      expr: target_kpi_metric
      comment: "The KPI being targeted for improvement (PPM, OTD, Cost, etc.) for outcome-based program tracking."
    - name: "plan_start_year"
      expr: YEAR(plan_start_date)
      comment: "Year the development plan started for investment trend and program vintage analysis."
  measures:
    - name: "total_active_development_plans"
      expr: COUNT(CASE WHEN plan_status = 'Active' THEN development_plan_id END)
      comment: "Total active supplier development plans. Measures the scale of supplier improvement investment in progress."
    - name: "plan_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status = 'Completed' THEN development_plan_id END) / NULLIF(COUNT(development_plan_id), 0), 2)
      comment: "Percentage of development plans completed. Measures the effectiveness of the supplier development program."
    - name: "avg_target_improvement_percent"
      expr: AVG(CAST(target_improvement_percent AS DOUBLE))
      comment: "Average improvement target set across development plans. Indicates the ambition level of the supplier development program."
    - name: "avg_actual_kpi_improvement"
      expr: AVG(CAST(actual_kpi_value AS DOUBLE) - CAST(baseline_kpi_value AS DOUBLE))
      comment: "Average actual KPI improvement achieved versus baseline. The primary outcome KPI for supplier development program ROI."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact of active development plans. Used to justify supplier development investment budgets."
    - name: "total_estimated_savings"
      expr: SUM(CAST(estimated_savings AS DOUBLE))
      comment: "Total estimated savings from supplier development plans. A key ROI metric for the supplier development function."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier onboarding pipeline and cycle time metrics — used by procurement operations and supply chain leadership to track onboarding throughput, identify bottlenecks, and ensure new supplier readiness."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier_onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of the onboarding process (In Progress, Completed, Rejected, On Hold) for pipeline management."
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current stage in the onboarding workflow for bottleneck identification and process improvement."
    - name: "onboarding_type"
      expr: onboarding_type
      comment: "Type of onboarding (New Supplier, Re-activation, Site Addition) for workload categorization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the onboarding request for resource allocation and SLA management."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category for the onboarding request for supply category pipeline analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned during onboarding for risk-stratified process management."
    - name: "request_date_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month the onboarding was requested for throughput trend analysis."
    - name: "blocking_issue_flag"
      expr: blocking_issue_flag
      comment: "Indicates whether a blocking issue is preventing onboarding completion, for escalation management."
  measures:
    - name: "total_onboardings_in_progress"
      expr: COUNT(CASE WHEN onboarding_status = 'In Progress' THEN supplier_onboarding_id END)
      comment: "Total supplier onboardings currently in progress. Measures pipeline volume and resource demand."
    - name: "onboarding_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN onboarding_status = 'Completed' THEN supplier_onboarding_id END) / NULLIF(COUNT(supplier_onboarding_id), 0), 2)
      comment: "Percentage of onboarding requests successfully completed. Measures procurement operations efficiency."
    - name: "avg_estimated_annual_spend"
      expr: AVG(CAST(estimated_annual_spend AS DOUBLE))
      comment: "Average estimated annual spend for onboarded suppliers. Used to prioritize onboarding resources toward highest-value suppliers."
    - name: "total_estimated_annual_spend_pipeline"
      expr: SUM(CAST(estimated_annual_spend AS DOUBLE))
      comment: "Total estimated annual spend represented by the onboarding pipeline. Measures the strategic value of the onboarding program."
    - name: "blocking_issue_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN blocking_issue_flag = TRUE THEN supplier_onboarding_id END) / NULLIF(COUNT(CASE WHEN onboarding_status = 'In Progress' THEN supplier_onboarding_id END), 0), 2)
      comment: "Percentage of in-progress onboardings with blocking issues. High rates signal process or compliance bottlenecks requiring intervention."
    - name: "quality_audit_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_audit_result = 'Pass' THEN supplier_onboarding_id END) / NULLIF(COUNT(CASE WHEN quality_audit_required_flag = TRUE THEN supplier_onboarding_id END), 0), 2)
      comment: "Percentage of onboardings requiring a quality audit that passed. Measures incoming supplier quality readiness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier site performance and capability metrics covering quality scores, delivery performance, capacity, and certification status — used by procurement and supply chain leadership to manage multi-site supplier relationships and geographic risk."
  source: "`vibe_manufacturing_v1`.`supplier`.`site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Current operational status of the supplier site (Active, Inactive, Suspended) for sourcing eligibility."
    - name: "site_type"
      expr: site_type
      comment: "Type of supplier site (Manufacturing, Distribution, R&D, Assembly) for capability-based sourcing analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the supplier site for geographic concentration and geopolitical risk analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the site for regional supply chain risk and capacity analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the supplier site for risk-stratified monitoring and audit prioritization."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 certification status of the site, a key quality gate for sourcing decisions."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Indicates preferred site designation for sourcing channel optimization."
  measures:
    - name: "total_active_sites"
      expr: COUNT(CASE WHEN site_status = 'Active' THEN site_id END)
      comment: "Total active supplier sites. Measures supply network breadth and geographic coverage."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across supplier sites. Used to benchmark site quality performance and set improvement targets."
    - name: "avg_delivery_performance_score"
      expr: AVG(CAST(delivery_performance_score AS DOUBLE))
      comment: "Average delivery performance score across sites. Informs safety stock and lead time planning decisions."
    - name: "total_annual_production_capacity"
      expr: SUM(CAST(production_capacity_annual AS DOUBLE))
      comment: "Total annual production capacity across all active supplier sites. Used for supply capacity planning and risk assessment."
    - name: "iso9001_certified_site_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_9001_certified = TRUE THEN site_id END) / NULLIF(COUNT(CASE WHEN site_status = 'Active' THEN site_id END), 0), 2)
      comment: "Percentage of active sites with ISO 9001 certification. Measures quality certification coverage across the supply network."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across supplier sites. Informs inventory policy and working capital requirements."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_change_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier change notification (SCN) metrics covering change volume, approval rates, risk impact, and PPAP resubmission requirements — used by engineering, quality, and procurement leadership to manage supply chain change risk."
  source: "`vibe_manufacturing_v1`.`supplier`.`change_notification`"
  dimensions:
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change notification (Open, Under Review, Approved, Rejected, Closed) for pipeline management."
    - name: "change_type"
      expr: change_type
      comment: "Type of supplier change (Process, Material, Sub-supplier, Location, Design) for risk categorization."
    - name: "impact_level"
      expr: impact_level
      comment: "Assessed impact level of the change (Critical, Major, Minor) for prioritization and escalation decisions."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for governance and compliance tracking."
    - name: "ppap_resubmission_required_flag"
      expr: ppap_resubmission_required_flag
      comment: "Indicates whether PPAP resubmission is required, signaling significant process or material changes."
    - name: "quality_impact_flag"
      expr: quality_impact_flag
      comment: "Indicates whether the change has a quality impact, for quality risk management prioritization."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Indicates whether the change has a regulatory compliance impact, requiring legal and compliance review."
    - name: "notification_date_month"
      expr: DATE_TRUNC('month', notification_date)
      comment: "Month the change notification was received for volume trend analysis."
  measures:
    - name: "total_open_change_notifications"
      expr: COUNT(CASE WHEN change_status = 'Open' THEN change_notification_id END)
      comment: "Total open supplier change notifications. High volumes signal supply chain instability requiring management attention."
    - name: "change_approval_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN change_notification_id END) / NULLIF(COUNT(CASE WHEN approval_status IN ('Approved', 'Rejected') THEN change_notification_id END), 0), 2)
      comment: "Percentage of change notifications approved. Used to assess change management process efficiency and supplier change quality."
    - name: "ppap_resubmission_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ppap_resubmission_required_flag = TRUE THEN change_notification_id END) / NULLIF(COUNT(change_notification_id), 0), 2)
      comment: "Percentage of change notifications requiring PPAP resubmission. High rates indicate significant supply chain changes with quality risk."
    - name: "quality_impact_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_impact_flag = TRUE THEN change_notification_id END) / NULLIF(COUNT(change_notification_id), 0), 2)
      comment: "Percentage of change notifications with quality impact. Drives quality review resource allocation and risk mitigation planning."
    - name: "regulatory_impact_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN change_notification_id END) / NULLIF(COUNT(change_notification_id), 0), 2)
      comment: "Percentage of change notifications with regulatory impact. Critical for compliance risk management and regulatory reporting."
    - name: "total_affected_parts"
      expr: COUNT(DISTINCT change_notification_id)
      comment: "Count of distinct change notifications as a proxy for affected part families. Used to assess the breadth of supply chain change exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_tooling_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier-held tooling asset metrics covering asset value, utilization, condition, and lifecycle — used by procurement and engineering leadership to manage tooling investments, track asset health, and plan maintenance and replacement."
  source: "`vibe_manufacturing_v1`.`supplier`.`tooling_asset`"
  dimensions:
    - name: "tool_status"
      expr: tool_status
      comment: "Current operational status of the tooling asset (Active, Inactive, Under Repair, Scrapped) for asset portfolio management."
    - name: "tooling_type"
      expr: tooling_type
      comment: "Type of tooling asset (Die, Mold, Fixture, Gauge, etc.) for asset category management and replacement planning."
    - name: "condition_status"
      expr: condition_status
      comment: "Physical condition of the tooling asset (Good, Fair, Poor, Critical) for maintenance prioritization."
    - name: "ownership_status"
      expr: ownership_status
      comment: "Ownership status of the tooling (Customer-owned, Supplier-owned, Shared) for asset recovery and liability management."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Business criticality of the tooling asset for prioritizing maintenance and replacement investments."
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the tooling asset for portfolio segmentation and capital planning."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the tooling asset was acquired for age-based lifecycle and replacement planning."
  measures:
    - name: "total_tooling_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of supplier-held tooling assets. The primary financial KPI for tooling investment management."
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Total current book value of tooling assets. Used for balance sheet reporting and asset recovery planning."
    - name: "avg_remaining_cycle_capacity"
      expr: AVG(CAST(remaining_cycle_capacity AS DOUBLE))
      comment: "Average remaining production cycle capacity across tooling assets. Drives proactive tooling replacement planning."
    - name: "total_production_cycles"
      expr: SUM(CAST(total_production_cycles AS DOUBLE))
      comment: "Total production cycles completed across all tooling assets. Measures tooling utilization and lifecycle consumption."
    - name: "tooling_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(total_production_cycles AS DOUBLE)) / NULLIF(SUM(CAST(rated_cycle_capacity AS DOUBLE)), 0), 2)
      comment: "Percentage of rated cycle capacity consumed across the tooling portfolio. High rates signal imminent replacement needs."
    - name: "critical_condition_tooling_count"
      expr: COUNT(CASE WHEN condition_status = 'Critical' THEN tooling_asset_id END)
      comment: "Count of tooling assets in critical condition. Drives urgent maintenance and replacement investment decisions."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average expected useful life of tooling assets. Used for depreciation planning and long-term capital expenditure forecasting."
$$;