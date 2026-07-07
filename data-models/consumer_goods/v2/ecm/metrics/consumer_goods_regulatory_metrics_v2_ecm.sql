-- Metric views for domain: regulatory | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory enforcement actions — penalties, violations, and resolution timelines. Enables legal, compliance, and executive leadership to monitor enforcement exposure, financial liability, and resolution velocity."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of regulatory action (e.g., Warning Letter, Consent Decree, Civil Penalty) for enforcement category analysis."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the action (e.g., Open, Resolved, Appealed) for pipeline and resolution tracking."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the action for risk prioritization and escalation decisions."
    - name: "violation_category"
      expr: violation_category
      comment: "Category of the underlying violation (e.g., Labeling, Safety, Environmental) for root-cause pattern analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the action for workload and escalation management."
    - name: "recall_required_flag"
      expr: recall_required_flag
      comment: "Boolean flag indicating whether the action requires a product recall, for high-severity filtering."
    - name: "action_year_month"
      expr: DATE_TRUNC('month', action_date)
      comment: "Month of action date for trend analysis of enforcement activity over time."
    - name: "repeat_violation_flag"
      expr: repeat_violation_flag
      comment: "Boolean flag indicating a repeat violation, which signals systemic compliance failure and elevated regulatory risk."
  measures:
    - name: "total_actions"
      expr: COUNT(1)
      comment: "Total number of regulatory actions. Baseline enforcement activity volume for compliance program health monitoring."
    - name: "total_financial_penalty_amount"
      expr: SUM(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Total financial penalties incurred from regulatory actions. Direct measure of regulatory financial liability for CFO and legal reporting."
    - name: "avg_financial_penalty_amount"
      expr: AVG(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Average financial penalty per action. Benchmarks penalty severity and informs settlement negotiation strategy."
    - name: "open_action_count"
      expr: COUNT(CASE WHEN action_status NOT IN ('Resolved', 'Closed', 'Dismissed') THEN 1 END)
      comment: "Count of currently open regulatory actions. Measures live enforcement exposure and legal workload."
    - name: "recall_required_action_count"
      expr: COUNT(CASE WHEN recall_required_flag = TRUE THEN 1 END)
      comment: "Count of actions requiring a product recall. High-severity KPI directly tied to consumer safety and brand risk."
    - name: "repeat_violation_count"
      expr: COUNT(CASE WHEN repeat_violation_flag = TRUE THEN 1 END)
      comment: "Count of actions flagged as repeat violations. Signals systemic compliance failure and elevated regulatory scrutiny risk."
    - name: "escalated_action_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of actions that have been escalated. Measures the volume of high-priority enforcement matters requiring senior attention."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory change events — implementation status, compliance risk, and submission requirements. Enables regulatory affairs and product teams to manage change impact, prioritize high-risk changes, and ensure timely implementation."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of regulatory change (e.g., Labeling, Formulation, Registration) for impact categorization."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change (e.g., Pending, In Progress, Implemented) for pipeline management."
    - name: "compliance_risk_level"
      expr: compliance_risk_level
      comment: "Compliance risk level of the change for prioritization of high-risk regulatory changes."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of the change (e.g., Not Started, In Progress, Complete) for execution tracking."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Boolean flag indicating whether the change is mandatory, for prioritizing legally required changes."
    - name: "submission_required"
      expr: submission_required
      comment: "Boolean flag indicating whether a regulatory submission is required for the change, for submission pipeline planning."
    - name: "change_year_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month of change initiation for trend analysis of regulatory change volume and implementation velocity."
    - name: "change_category"
      expr: change_category
      comment: "Category of the regulatory change for portfolio-level impact analysis."
  measures:
    - name: "total_changes"
      expr: COUNT(1)
      comment: "Total number of regulatory changes. Baseline KPI for regulatory change management workload."
    - name: "mandatory_change_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Count of mandatory regulatory changes. Measures legally required change burden on the organization."
    - name: "open_change_count"
      expr: COUNT(CASE WHEN change_status NOT IN ('Implemented', 'Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open regulatory changes. Measures active change management backlog and compliance implementation risk."
    - name: "high_risk_change_count"
      expr: COUNT(CASE WHEN compliance_risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Count of high or critical compliance risk changes. Directly measures the volume of changes with significant regulatory exposure."
    - name: "submission_required_change_count"
      expr: COUNT(CASE WHEN submission_required = TRUE THEN 1 END)
      comment: "Count of changes requiring a regulatory submission. Drives submission pipeline planning and resource allocation."
    - name: "overdue_implementation_count"
      expr: COUNT(CASE WHEN required_action_deadline < CURRENT_DATE AND implementation_status NOT IN ('Complete', 'Implemented') THEN 1 END)
      comment: "Count of changes past their required action deadline without implementation. Measures regulatory non-compliance risk from delayed change execution."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks compliance assessment outcomes, scores, and corrective action rates across facilities, SKUs, and regulatory frameworks. Enables compliance leadership to monitor assessment health, identify high-risk areas, and drive remediation prioritization."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment (e.g., internal audit, third-party, regulatory inspection) for segmenting assessment workload."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status outcome of the assessment (e.g., Compliant, Non-Compliant, Partial) for pass/fail analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the assessment finding, used to prioritize remediation effort."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the assessment was conducted (e.g., FDA, EU Cosmetics Regulation)."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether a corrective action was required, enabling CA rate analysis."
    - name: "assessment_year_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of assessment date for trend analysis of compliance assessment volume and outcomes over time."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action (e.g., Open, In Progress, Closed) to track remediation pipeline."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments conducted. Baseline volume KPI for compliance program activity."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all assessments. A declining average signals systemic compliance degradation requiring executive intervention."
    - name: "total_assessments_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of assessments that triggered a corrective action requirement. High values indicate systemic non-compliance exposure."
    - name: "non_compliant_assessment_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of assessments resulting in a non-compliant finding. Directly drives regulatory risk and remediation cost."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Closed', 'Completed') AND corrective_action_required = TRUE THEN 1 END)
      comment: "Count of assessments with open/unresolved corrective actions. Measures remediation backlog and regulatory exposure."
    - name: "min_compliance_score"
      expr: MIN(CAST(compliance_score AS DOUBLE))
      comment: "Minimum compliance score observed, identifying the worst-performing assessment for targeted intervention."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors the portfolio of regulatory compliance obligations — their cost, status, and deadline adherence. Enables the Chief Compliance Officer and Finance to manage obligation risk, budget exposure, and renewal cadence."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (e.g., permit, license, reporting requirement) for portfolio segmentation."
    - name: "compliance_obligation_status"
      expr: compliance_obligation_status
      comment: "Current status of the obligation (e.g., Active, Expired, Pending Renewal) for lifecycle management."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the obligation, used to prioritize high-risk compliance gaps."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the obligation (e.g., REACH, FDA 21 CFR) for framework-level cost and risk analysis."
    - name: "frequency"
      expr: frequency
      comment: "Renewal or reporting frequency of the obligation (e.g., Annual, Quarterly) for workload planning."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the obligation is currently active, for filtering active vs. historical obligations."
    - name: "due_year_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month of obligation due date for deadline pipeline and workload forecasting."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations in the portfolio. Baseline for compliance program scope."
    - name: "total_estimated_compliance_cost"
      expr: SUM(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Total estimated cost to fulfill all compliance obligations. Critical for compliance budget planning and CFO reporting."
    - name: "avg_estimated_compliance_cost"
      expr: AVG(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Average estimated compliance cost per obligation. Benchmarks cost efficiency of the compliance program."
    - name: "active_obligation_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active compliance obligations. Measures the live regulatory burden on the organization."
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND compliance_obligation_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Count of obligations past their due date without completion. Directly measures regulatory non-compliance exposure and penalty risk."
    - name: "upcoming_renewal_count_30d"
      expr: COUNT(CASE WHEN next_renewal_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN 1 END)
      comment: "Count of obligations due for renewal within the next 30 days. Enables proactive renewal management to avoid lapses."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_cpsc_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors CPSC (Consumer Product Safety Commission) filings — incident counts, injury severity, and filing status. Enables regulatory, legal, and executive leadership to manage consumer safety reporting obligations and recall risk."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of CPSC filing (e.g., Section 15(b) Report, SaferProducts.gov Report) for regulatory reporting category analysis."
    - name: "cpsc_filing_status"
      expr: cpsc_filing_status
      comment: "Current status of the CPSC filing (e.g., Draft, Submitted, Acknowledged) for pipeline management."
    - name: "hazard_category"
      expr: hazard_category
      comment: "Category of the product hazard (e.g., Fire, Laceration, Choking) for safety signal pattern analysis."
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity of reported injuries for consumer safety risk prioritization."
    - name: "recall_announced_flag"
      expr: recall_announced_flag
      comment: "Boolean flag indicating whether a recall was announced in connection with the filing."
    - name: "legal_review_completed_flag"
      expr: legal_review_completed_flag
      comment: "Boolean flag indicating whether legal review was completed, for compliance process tracking."
    - name: "filing_year_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Month of filing date for trend analysis of CPSC filing volume over time."
  measures:
    - name: "total_cpsc_filings"
      expr: COUNT(1)
      comment: "Total number of CPSC filings. Baseline KPI for consumer product safety reporting volume."
    - name: "recall_announced_filing_count"
      expr: COUNT(CASE WHEN recall_announced_flag = TRUE THEN 1 END)
      comment: "Count of CPSC filings associated with an announced recall. Measures the volume of highest-severity consumer safety events."
    - name: "pending_legal_review_count"
      expr: COUNT(CASE WHEN legal_review_completed_flag = FALSE OR legal_review_completed_flag IS NULL THEN 1 END)
      comment: "Count of filings pending legal review completion. Measures legal compliance process backlog for CPSC reporting."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs involved in CPSC filings. Measures the breadth of the product safety exposure portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_dossier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors the regulatory dossier portfolio — completeness, approval status, and expiration risk. Enables regulatory affairs to manage dossier quality, submission readiness, and market authorization currency."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`dossier`"
  dimensions:
    - name: "dossier_type"
      expr: dossier_type
      comment: "Type of regulatory dossier (e.g., PIF, CTD, CPNP Notification) for portfolio segmentation by submission format."
    - name: "dossier_status"
      expr: dossier_status
      comment: "Current status of the dossier (e.g., Draft, Submitted, Approved, Expired) for lifecycle management."
    - name: "completeness_status"
      expr: completeness_status
      comment: "Completeness status of the dossier (e.g., Complete, Incomplete, Under Review) for submission readiness tracking."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the dossier for information governance and access control reporting."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Boolean flag indicating GMP compliance inclusion in the dossier, for manufacturing compliance coverage analysis."
    - name: "dossier_year"
      expr: DATE_TRUNC('year', compilation_date)
      comment: "Year of dossier compilation for portfolio age and renewal cycle analysis."
  measures:
    - name: "total_dossiers"
      expr: COUNT(1)
      comment: "Total number of regulatory dossiers. Baseline KPI for regulatory affairs portfolio scope."
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average dossier completeness percentage. Measures overall dossier quality and submission readiness across the portfolio."
    - name: "complete_dossier_count"
      expr: COUNT(CASE WHEN completeness_status = 'Complete' THEN 1 END)
      comment: "Count of fully complete dossiers. Measures the volume of market-ready regulatory packages."
    - name: "expiring_dossier_count_90d"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Count of dossiers expiring within 90 days. Enables proactive renewal to prevent market authorization lapses."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs covered by dossiers. Measures the breadth of the regulatory-covered product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_ifra_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors IFRA (International Fragrance Association) compliance records — concentration compliance, allergen declarations, and safety margins. Enables regulatory and R&D leadership to manage fragrance ingredient compliance and reformulation risk."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record`"
  dimensions:
    - name: "ifra_category"
      expr: ifra_category
      comment: "IFRA product category (e.g., Category 4 - Fine Fragrance, Category 9 - Rinse-off) for compliance segmentation by use type."
    - name: "compliance_status"
      expr: compliance_status
      comment: "IFRA compliance status (e.g., Compliant, Non-Compliant, Borderline) for portfolio compliance health monitoring."
    - name: "allergen_declaration_required"
      expr: allergen_declaration_required
      comment: "Boolean flag indicating whether allergen declaration is required for the ingredient, for labeling compliance tracking."
    - name: "allergen_threshold_exceeded"
      expr: allergen_threshold_exceeded
      comment: "Boolean flag indicating whether the allergen threshold was exceeded, for high-priority reformulation flagging."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of IFRA restriction (e.g., Prohibited, Restricted, Specification) for compliance category analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the compliance record is currently active."
    - name: "assessment_year_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of IFRA compliance assessment for trend analysis of compliance review activity."
  measures:
    - name: "total_ifra_records"
      expr: COUNT(1)
      comment: "Total number of IFRA compliance records. Baseline KPI for fragrance compliance program scope."
    - name: "non_compliant_record_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of non-compliant IFRA records. Directly measures fragrance ingredient compliance failures requiring reformulation."
    - name: "allergen_threshold_exceeded_count"
      expr: COUNT(CASE WHEN allergen_threshold_exceeded = TRUE THEN 1 END)
      comment: "Count of records where allergen thresholds are exceeded. High-priority consumer safety and labeling compliance KPI."
    - name: "avg_safety_margin_pct"
      expr: AVG(CAST(safety_margin_percentage AS DOUBLE))
      comment: "Average safety margin percentage across IFRA compliance records. Measures the buffer between actual and maximum permitted usage levels — a key formulation risk indicator."
    - name: "avg_actual_concentration_pct"
      expr: AVG(CAST(actual_concentration_pct AS DOUBLE))
      comment: "Average actual fragrance ingredient concentration across records. Benchmarks formulation intensity against IFRA limits."
    - name: "avg_max_concentration_pct"
      expr: AVG(CAST(max_concentration_pct AS DOUBLE))
      comment: "Average maximum permitted concentration across IFRA categories. Provides the regulatory ceiling benchmark for formulation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_label_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks product label version management across markets and jurisdictions — monitoring approval status, currency, and compliance to ensure all products carry legally compliant labels in every market."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`label_version`"
  dimensions:
    - name: "label_version_status"
      expr: label_version_status
      comment: "Current status of the label version (e.g., Approved, Draft, Superseded) for label lifecycle management."
    - name: "approval_status"
      expr: approval_status
      comment: "Regulatory approval status of the label version — for tracking label approval pipeline."
    - name: "label_type"
      expr: label_type
      comment: "Type of label (e.g., Primary, Secondary, Outer Carton) for label portfolio categorization."
    - name: "market_country_code"
      expr: market_country_code
      comment: "Country market for which the label version is intended — for geographic label compliance coverage analysis."
    - name: "language_code"
      expr: language_code
      comment: "Language of the label — for multilingual compliance coverage monitoring."
    - name: "is_current_version"
      expr: is_current_version
      comment: "Boolean flag indicating whether this is the current approved label version — for identifying outdated labels in market."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the label requirements (e.g., EU Cosmetics, FDA OTC) for framework-level analysis."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of label approval — for tracking label approval throughput and cycle time trends."
  measures:
    - name: "total_label_versions"
      expr: COUNT(1)
      comment: "Total number of label versions across the portfolio — baseline for label management complexity."
    - name: "approved_label_versions"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of approved label versions — measures the compliant label coverage across the product portfolio."
    - name: "pending_approval_labels"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Rejected', 'Withdrawn') THEN 1 END)
      comment: "Count of label versions awaiting regulatory approval — measures label approval pipeline backlog."
    - name: "expired_label_versions"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND is_current_version = TRUE THEN 1 END)
      comment: "Count of current label versions that have passed their expiry date — a critical compliance risk for market-facing products."
    - name: "distinct_markets_with_labels"
      expr: COUNT(DISTINCT market_country_code)
      comment: "Number of distinct markets with label versions — measures geographic label compliance coverage breadth."
    - name: "avg_net_content_quantity"
      expr: AVG(CAST(net_content_quantity AS DOUBLE))
      comment: "Average net content quantity declared on labels — useful for portfolio standardization and regulatory declaration audits."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors product recall events — financial impact, recovery effectiveness, and resolution timelines. Enables supply chain, quality, and executive leadership to manage recall risk, consumer safety, and brand protection."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`product_recall`"
  dimensions:
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g., Voluntary, Mandatory, Market Withdrawal) for classification and regulatory reporting."
    - name: "recall_class"
      expr: recall_class
      comment: "FDA/CPSC recall class (Class I, II, III) indicating severity of health hazard for risk prioritization."
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (e.g., Active, Completed, Terminated) for lifecycle management."
    - name: "recall_reason_code"
      expr: recall_reason_code
      comment: "Coded reason for the recall (e.g., contamination, mislabeling) for root-cause pattern analysis."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Boolean flag indicating whether the recall was mandated by a regulatory authority vs. voluntary."
    - name: "recall_initiation_year_month"
      expr: DATE_TRUNC('month', recall_initiation_date)
      comment: "Month of recall initiation for trend analysis of recall frequency over time."
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of product recall events. Baseline KPI for product safety program health and brand risk monitoring."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of all recalls. Critical for CFO reporting, insurance, and risk management decisions."
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per recall event. Benchmarks recall cost severity for risk modeling."
    - name: "total_units_recalled"
      expr: SUM(CAST(quantity_recalled_units AS DOUBLE))
      comment: "Total units subject to recall. Measures consumer exposure and supply chain disruption scale."
    - name: "total_units_recovered"
      expr: SUM(CAST(quantity_recovered_units AS DOUBLE))
      comment: "Total units successfully recovered from the market. Measures recall execution effectiveness."
    - name: "avg_recall_effectiveness_pct"
      expr: AVG(CAST(recall_effectiveness_percentage AS DOUBLE))
      comment: "Average recall effectiveness percentage across all recalls. Directly measures consumer protection program performance — a key regulatory and brand KPI."
    - name: "active_recall_count"
      expr: COUNT(CASE WHEN recall_status NOT IN ('Completed', 'Terminated', 'Closed') THEN 1 END)
      comment: "Count of currently active recalls. Measures live consumer safety exposure and operational recall management burden."
    - name: "mandatory_recall_count"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN 1 END)
      comment: "Count of recalls mandated by regulatory authorities. Distinguishes forced vs. voluntary recalls for regulatory relationship management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_reach_substance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors the REACH substance portfolio — SVHC status, authorization requirements, and registration compliance. Enables regulatory, R&D, and procurement leadership to manage chemical compliance risk and supply chain substitution decisions."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`reach_substance`"
  dimensions:
    - name: "reach_substance_status"
      expr: reach_substance_status
      comment: "Current REACH registration status of the substance for compliance portfolio management."
    - name: "svhc_status"
      expr: svhc_status
      comment: "SVHC (Substance of Very High Concern) status flag for prioritizing high-risk substance management."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "GHS/CLP hazard classification of the substance for safety and regulatory risk segmentation."
    - name: "authorisation_required"
      expr: authorisation_required
      comment: "Boolean flag indicating whether EU REACH authorisation is required for continued use of the substance."
    - name: "endocrine_disruptor_flag"
      expr: endocrine_disruptor_flag
      comment: "Boolean flag indicating endocrine disruptor classification, a high-priority regulatory risk indicator."
    - name: "registration_status"
      expr: registration_status
      comment: "REACH registration status (e.g., Registered, Pre-registered, Exempt) for compliance tracking."
    - name: "tonnage_band"
      expr: tonnage_band
      comment: "REACH tonnage band (e.g., 1-10t, 10-100t) determining registration requirements and data obligations."
  measures:
    - name: "total_reach_substances"
      expr: COUNT(1)
      comment: "Total number of REACH substances in the portfolio. Baseline KPI for chemical compliance program scope."
    - name: "svhc_substance_count"
      expr: COUNT(CASE WHEN svhc_flag = TRUE THEN 1 END)
      comment: "Count of substances classified as SVHC. Directly measures the highest-risk chemical compliance exposure requiring substitution or authorisation."
    - name: "authorisation_required_count"
      expr: COUNT(CASE WHEN authorisation_required = TRUE THEN 1 END)
      comment: "Count of substances requiring EU REACH authorisation. Measures the volume of substances at risk of market access restriction."
    - name: "avg_dnel_value"
      expr: AVG(CAST(dnel_value AS DOUBLE))
      comment: "Average Derived No-Effect Level (DNEL) across substances. Benchmarks the toxicological risk profile of the substance portfolio."
    - name: "avg_pnec_value"
      expr: AVG(CAST(pnec_value AS DOUBLE))
      comment: "Average Predicted No-Effect Concentration (PNEC) across substances. Measures environmental risk profile of the substance portfolio."
    - name: "expiring_authorization_count_90d"
      expr: COUNT(CASE WHEN authorization_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Count of substances with REACH authorisations expiring within 90 days. Enables proactive renewal to prevent use restrictions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the portfolio of regulatory product registrations — their status, renewal timelines, and fee spend. Enables regulatory affairs and market access teams to manage registration currency, renewal risk, and market entry compliance."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`"
  dimensions:
    - name: "registration_type"
      expr: registration_type
      comment: "Type of regulatory registration (e.g., Cosmetic Notification, Drug Registration, Pesticide Registration) for portfolio segmentation."
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the registration (e.g., Active, Expired, Pending) for lifecycle and renewal management."
    - name: "registration_category"
      expr: registration_category
      comment: "Category of the registration for product classification and regulatory framework alignment."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Boolean flag indicating GMP compliance status of the registration, for manufacturing quality compliance monitoring."
    - name: "post_market_surveillance_required"
      expr: post_market_surveillance_required
      comment: "Boolean flag indicating whether post-market surveillance is required, for surveillance program scoping."
    - name: "regulatory_registration_status"
      expr: regulatory_registration_status
      comment: "Detailed regulatory registration status for granular lifecycle tracking."
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total number of regulatory registrations. Baseline KPI for market access portfolio scope."
    - name: "active_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN 1 END)
      comment: "Count of currently active registrations. Measures the live authorized market access footprint."
    - name: "expired_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Expired' THEN 1 END)
      comment: "Count of expired registrations. Directly measures market access gaps and regulatory non-compliance exposure."
    - name: "total_registration_fee_spend"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees paid for regulatory registrations. Measures direct market access cost for budget planning."
    - name: "avg_registration_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average registration fee per registration. Benchmarks market access cost efficiency across jurisdictions."
    - name: "renewals_due_90d"
      expr: COUNT(CASE WHEN renewal_due_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Count of registrations due for renewal within 90 days. Enables proactive renewal management to prevent market access lapses."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with regulatory registrations. Measures the breadth of the registered product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory submission pipeline — approval rates, fee spend, and decision timelines. Enables regulatory affairs leadership to manage submission throughput, approval velocity, and market access timelines."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., NDA, PIF, Notification) for portfolio segmentation by submission category."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (e.g., Submitted, Under Review, Approved, Rejected) for pipeline management."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Final decision outcome (e.g., Approved, Rejected, Withdrawn) for approval rate analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the submission for workload and resource allocation decisions."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether a corrective action was required as part of the submission response."
    - name: "submission_year_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission date for trend analysis of submission volume and approval velocity over time."
    - name: "fee_payment_status"
      expr: fee_payment_status
      comment: "Payment status of the submission fee (e.g., Paid, Pending, Waived) for financial compliance tracking."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions. Baseline KPI for regulatory affairs workload and market access pipeline."
    - name: "approved_submission_count"
      expr: COUNT(CASE WHEN decision_outcome = 'Approved' THEN 1 END)
      comment: "Count of submissions receiving approval. Measures regulatory affairs effectiveness and market access success rate."
    - name: "rejected_submission_count"
      expr: COUNT(CASE WHEN decision_outcome = 'Rejected' THEN 1 END)
      comment: "Count of rejected submissions. High rejection rates signal dossier quality issues requiring process improvement."
    - name: "total_submission_fee_spend"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total regulatory submission fees paid. Measures direct cost of market access and informs regulatory budget planning."
    - name: "avg_submission_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee per submission. Benchmarks submission cost efficiency across jurisdictions and submission types."
    - name: "pending_submission_count"
      expr: COUNT(CASE WHEN submission_status NOT IN ('Approved', 'Rejected', 'Withdrawn', 'Closed') THEN 1 END)
      comment: "Count of submissions currently pending a decision. Measures the active market access pipeline and regulatory authority workload dependency."
    - name: "submissions_with_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of submissions requiring corrective action. Indicates dossier quality gaps and regulatory deficiency exposure."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_surveillance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors post-market surveillance events — adverse events, consumer complaints, and recall triggers. Enables pharmacovigilance, quality, and regulatory leadership to detect safety signals, manage reporting obligations, and drive corrective actions."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`surveillance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of surveillance event (e.g., Adverse Event, Consumer Complaint, Field Alert) for signal categorization."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the surveillance event (e.g., Open, Under Investigation, Closed) for pipeline management."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the event for risk prioritization and regulatory reporting thresholds."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the event for systemic issue identification and corrective action targeting."
    - name: "recall_initiated_flag"
      expr: recall_initiated_flag
      comment: "Boolean flag indicating whether the event triggered a product recall, for high-severity signal monitoring."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Boolean flag indicating whether the event requires regulatory authority reporting, for compliance obligation tracking."
    - name: "event_year_month"
      expr: DATE_TRUNC('month', event_date)
      comment: "Month of event occurrence for trend analysis of surveillance signal volume and severity over time."
    - name: "injury_reported_flag"
      expr: injury_reported_flag
      comment: "Boolean flag indicating whether an injury was reported, for consumer safety severity segmentation."
  measures:
    - name: "total_surveillance_events"
      expr: COUNT(1)
      comment: "Total number of post-market surveillance events. Baseline KPI for product safety signal volume monitoring."
    - name: "total_financial_impact_estimate"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of surveillance events. Measures aggregate liability exposure from post-market safety signals."
    - name: "avg_financial_impact_estimate"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average financial impact per surveillance event. Benchmarks event severity and informs risk reserve calculations."
    - name: "recall_triggered_event_count"
      expr: COUNT(CASE WHEN recall_initiated_flag = TRUE THEN 1 END)
      comment: "Count of surveillance events that triggered a product recall. Critical consumer safety KPI for executive and regulatory reporting."
    - name: "reportable_event_count"
      expr: COUNT(CASE WHEN reportable_flag = TRUE THEN 1 END)
      comment: "Count of events classified as reportable to regulatory authorities. Measures mandatory reporting obligation volume."
    - name: "open_investigation_count"
      expr: COUNT(CASE WHEN event_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Count of surveillance events with open investigations. Measures active safety signal backlog and investigation resource demand."
    - name: "injury_reported_event_count"
      expr: COUNT(CASE WHEN injury_reported_flag = TRUE THEN 1 END)
      comment: "Count of events with reported consumer injuries. Highest-severity consumer safety KPI, directly tied to regulatory enforcement risk."
$$;
