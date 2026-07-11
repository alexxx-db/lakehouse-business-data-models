-- Metric views for domain: regulatory | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over regulatory enforcement actions — financial penalties, escalation rates, repeat violations, and resolution cycle times. Drives executive risk management and compliance investment decisions."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Category of regulatory action (e.g. Warning Letter, Consent Decree, Import Alert) for segmenting penalty exposure by action class."
    - name: "action_status"
      expr: action_status
      comment: "Current lifecycle status of the action (Open, Closed, Under Appeal) to filter active vs. resolved enforcement matters."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the action — used to prioritise executive attention and resource allocation."
    - name: "violation_category"
      expr: violation_category
      comment: "Type of regulatory violation cited, enabling root-cause trend analysis across product lines."
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Regulatory jurisdiction where the action was issued — supports geographic risk heat-maps."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory body that issued the action (FDA, EPA, CPSC, etc.) for authority-level compliance tracking."
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall classification (Class I/II/III) when the action involves a product recall."
    - name: "action_year"
      expr: YEAR(action_date)
      comment: "Calendar year of the action date for year-over-year trend analysis."
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', action_date)
      comment: "Month bucket of the action date for monthly enforcement trend dashboards."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the action has been escalated — used to segment high-priority enforcement matters."
    - name: "repeat_violation_flag"
      expr: repeat_violation_flag
      comment: "Flags repeat violations, a leading indicator of systemic compliance failure requiring structural intervention."
    - name: "recall_required_flag"
      expr: recall_required_flag
      comment: "Indicates whether a product recall is mandated by this action — critical for supply chain and brand risk dashboards."
  measures:
    - name: "total_actions"
      expr: COUNT(1)
      comment: "Total number of regulatory enforcement actions. Baseline volume KPI for compliance risk dashboards and QBRs."
    - name: "total_financial_penalty_amount"
      expr: SUM(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed across all regulatory actions. Direct P&L impact metric used by CFO and General Counsel."
    - name: "avg_financial_penalty_per_action"
      expr: AVG(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Average penalty per enforcement action. Benchmarks penalty severity and informs insurance and reserve planning."
    - name: "max_financial_penalty_amount"
      expr: MAX(financial_penalty_amount)
      comment: "Largest single penalty on record. Flags tail-risk exposure for executive and board-level risk reporting."
    - name: "escalated_action_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of actions that have been escalated. High escalation counts signal systemic compliance gaps requiring leadership intervention."
    - name: "repeat_violation_count"
      expr: COUNT(CASE WHEN repeat_violation_flag = TRUE THEN 1 END)
      comment: "Count of repeat violations. A rising repeat-violation rate indicates that corrective actions are ineffective — a key quality and compliance KPI."
    - name: "recall_required_count"
      expr: COUNT(CASE WHEN recall_required_flag = TRUE THEN 1 END)
      comment: "Number of actions requiring a product recall. Directly tied to consumer safety risk and brand equity impact."
    - name: "open_action_count"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Count of currently open enforcement actions. Measures unresolved regulatory exposure at any point in time."
    - name: "avg_resolution_days"
      expr: AVG(DATEDIFF(resolution_date, received_date))
      comment: "Average calendar days from action receipt to resolution. Measures regulatory response efficiency — a key operational compliance KPI."
    - name: "avg_response_cycle_days"
      expr: AVG(DATEDIFF(response_submitted_date, received_date))
      comment: "Average days from receipt to response submission. Tracks regulatory responsiveness against authority deadlines."
    - name: "public_disclosure_count"
      expr: COUNT(CASE WHEN public_disclosure_flag = TRUE THEN 1 END)
      comment: "Number of actions requiring public disclosure. Quantifies brand and reputational risk exposure from enforcement actions."
    - name: "external_audit_required_count"
      expr: COUNT(CASE WHEN external_audit_required_flag = TRUE THEN 1 END)
      comment: "Count of actions triggering mandatory external audits. Drives audit resource planning and third-party compliance spend."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over regulatory compliance obligations — cost exposure, deadline adherence, and obligation portfolio health. Enables proactive compliance investment and risk prioritisation."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`compliance_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation (Licensing, Reporting, Testing, etc.) for portfolio segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (Compliant, Non-Compliant, Pending) — primary filter for risk dashboards."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the obligation — drives prioritisation of remediation resources."
    - name: "priority"
      expr: priority
      comment: "Business priority assigned to the obligation for workload and resource planning."
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body governing the obligation (FDA, EPA, REACH, etc.) for authority-level compliance tracking."
    - name: "applicable_product_category"
      expr: applicable_product_category
      comment: "Product category scope of the obligation — links compliance cost to product portfolio decisions."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department accountable for the obligation — supports departmental compliance scorecards."
    - name: "renewal_frequency"
      expr: renewal_frequency
      comment: "How often the obligation must be renewed — used for forward-looking compliance calendar planning."
    - name: "is_active"
      expr: is_active
      comment: "Flags currently active obligations to filter the live compliance portfolio."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the obligation became effective — supports cohort analysis of obligation vintage."
    - name: "compliance_deadline_month"
      expr: DATE_TRUNC('MONTH', compliance_deadline)
      comment: "Month bucket of the compliance deadline — drives near-term deadline heat-maps for operations teams."
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations in the portfolio. Baseline volume for compliance program sizing."
    - name: "total_estimated_compliance_cost"
      expr: SUM(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Total estimated cost to meet all compliance obligations. Core input to annual compliance budget and CFO reporting."
    - name: "avg_estimated_compliance_cost"
      expr: AVG(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Average compliance cost per obligation. Benchmarks cost efficiency and identifies high-cost obligation types."
    - name: "max_estimated_compliance_cost"
      expr: MAX(estimated_compliance_cost)
      comment: "Highest single-obligation compliance cost. Flags tail-risk obligations for executive prioritisation."
    - name: "non_compliant_obligation_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of obligations currently out of compliance. A rising count signals systemic compliance failure requiring immediate leadership action."
    - name: "active_obligation_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active obligations. Measures the live compliance workload for resource planning."
    - name: "high_risk_obligation_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk obligations. Directly informs risk committee reporting and remediation investment decisions."
    - name: "notification_sent_count"
      expr: COUNT(CASE WHEN notification_sent_flag = TRUE THEN 1 END)
      comment: "Count of obligations where regulatory notifications have been dispatched. Tracks proactive compliance communication coverage."
    - name: "overdue_obligation_count"
      expr: COUNT(CASE WHEN compliance_deadline < CURRENT_DATE AND compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of obligations past their compliance deadline and not yet compliant. A critical risk KPI for executive escalation."
    - name: "upcoming_renewal_count_30d"
      expr: COUNT(CASE WHEN next_renewal_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 30) THEN 1 END)
      comment: "Obligations due for renewal within the next 30 days. Drives near-term compliance operations planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over regulatory submissions — approval rates, cycle times, fee spend, and pipeline health. Enables R&D and regulatory affairs teams to optimise submission strategy and resource allocation."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (NDA, 510k, REACH Dossier, etc.) for pipeline segmentation."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (Pending, Approved, Rejected, Withdrawn) — primary filter for pipeline dashboards."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Final regulatory decision (Approved, Rejected, Approvable with Conditions) — drives approval rate KPIs."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body receiving the submission (FDA, EMA, PMDA, etc.) for authority-level performance benchmarking."
    - name: "authority_jurisdiction"
      expr: authority_jurisdiction
      comment: "Geographic jurisdiction of the submission — supports market-entry pipeline analysis."
    - name: "priority"
      expr: priority
      comment: "Submission priority classification — used to segment fast-track vs. standard review pipelines."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level associated with the submission (relevant for adverse event and recall submissions)."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flags submissions requiring corrective action — used to track post-submission remediation workload."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Calendar year of submission for year-over-year pipeline trend analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month bucket of submission date for monthly pipeline velocity tracking."
    - name: "channel"
      expr: channel
      comment: "Submission channel (electronic, paper, portal) — informs digital transformation of regulatory operations."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions. Baseline pipeline volume KPI for regulatory affairs capacity planning."
    - name: "approved_submission_count"
      expr: COUNT(CASE WHEN decision_outcome = 'Approved' THEN 1 END)
      comment: "Number of submissions receiving regulatory approval. Directly measures regulatory success rate and market-entry velocity."
    - name: "rejected_submission_count"
      expr: COUNT(CASE WHEN decision_outcome = 'Rejected' THEN 1 END)
      comment: "Number of rejected submissions. A rising rejection count signals quality issues in submission preparation — triggers process review."
    - name: "pending_submission_count"
      expr: COUNT(CASE WHEN submission_status = 'Pending' THEN 1 END)
      comment: "Count of submissions awaiting regulatory decision. Measures active pipeline backlog for resource planning."
    - name: "total_submission_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total regulatory submission fees paid. Core input to regulatory affairs budget and cost-per-approval analysis."
    - name: "avg_submission_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee per submission. Benchmarks submission cost efficiency across authorities and submission types."
    - name: "avg_review_cycle_days"
      expr: AVG(DATEDIFF(actual_decision_date, submission_date))
      comment: "Average calendar days from submission to regulatory decision. Measures authority review speed and informs launch timeline planning."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of submissions requiring corrective action post-review. Tracks rework burden and submission quality."
    - name: "distinct_skus_submitted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active regulatory submissions. Measures breadth of product portfolio under regulatory review."
    - name: "overdue_decision_count"
      expr: COUNT(CASE WHEN target_decision_date < CURRENT_DATE AND submission_status = 'Pending' THEN 1 END)
      comment: "Submissions past their target decision date still awaiting outcome. Flags authority delays impacting product launch schedules."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over product recalls — financial impact, recovery effectiveness, and recall portfolio health. Directly informs consumer safety, brand risk, and supply chain response decisions at the executive level."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`product_recall`"
  dimensions:
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (Voluntary, Mandatory, Market Withdrawal) — determines regulatory obligation and response urgency."
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall lifecycle status (Active, Closed, Monitoring) — primary filter for active recall dashboards."
    - name: "recall_classification"
      expr: recall_classification
      comment: "FDA recall class (Class I/II/III) indicating health hazard severity — drives executive escalation thresholds."
    - name: "recall_reason_code"
      expr: recall_reason_code
      comment: "Coded reason for the recall — enables root-cause trend analysis to prevent recurrence."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Authority mandating or overseeing the recall — supports authority-level compliance tracking."
    - name: "recall_scope"
      expr: recall_scope
      comment: "Geographic or channel scope of the recall — informs supply chain and logistics response planning."
    - name: "consumer_remedy_type"
      expr: consumer_remedy_type
      comment: "Type of consumer remedy offered (Refund, Replacement, Repair) — impacts recall cost and consumer satisfaction."
    - name: "regulatory_mandate_flag"
      expr: regulatory_mandate_flag
      comment: "Indicates whether the recall was mandated by a regulatory authority vs. voluntary — a key risk classification dimension."
    - name: "recall_initiation_year"
      expr: YEAR(recall_initiation_date)
      comment: "Year the recall was initiated for year-over-year recall trend analysis."
    - name: "recall_initiation_month"
      expr: DATE_TRUNC('MONTH', recall_initiation_date)
      comment: "Month bucket of recall initiation for monthly recall volume tracking."
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of product recalls. Baseline consumer safety and brand risk KPI for executive and board reporting."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of all recalls. Core P&L risk metric for CFO and insurance reserve planning."
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per recall. Benchmarks recall cost severity and informs product risk scoring."
    - name: "total_units_recalled"
      expr: SUM(CAST(quantity_recalled_units AS DOUBLE))
      comment: "Total units subject to recall. Measures supply chain exposure and consumer safety reach of recall events."
    - name: "total_units_recovered"
      expr: SUM(CAST(quantity_recovered_units AS DOUBLE))
      comment: "Total units successfully recovered from the market. Measures recall execution effectiveness."
    - name: "avg_recall_effectiveness_pct"
      expr: AVG(CAST(recall_effectiveness_percentage AS DOUBLE))
      comment: "Average recall effectiveness percentage across all recalls. A key consumer safety KPI — low effectiveness signals inadequate recall execution."
    - name: "active_recall_count"
      expr: COUNT(CASE WHEN recall_status = 'Active' THEN 1 END)
      comment: "Number of currently active recalls. Measures live consumer safety and brand risk exposure."
    - name: "class_i_recall_count"
      expr: COUNT(CASE WHEN recall_classification = 'Class I' THEN 1 END)
      comment: "Count of Class I (most severe) recalls. Highest-priority consumer safety KPI for executive and regulatory reporting."
    - name: "mandatory_recall_count"
      expr: COUNT(CASE WHEN regulatory_mandate_flag = TRUE THEN 1 END)
      comment: "Number of recalls mandated by regulatory authorities. Distinguishes forced vs. voluntary recalls for risk and compliance reporting."
    - name: "avg_recall_completion_days"
      expr: AVG(DATEDIFF(recall_completion_date, recall_initiation_date))
      comment: "Average days from recall initiation to completion. Measures recall response speed — a key operational efficiency and consumer safety KPI."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over compliance assessments — assessment outcomes, corrective action rates, and audit cycle health. Enables quality and regulatory teams to track compliance posture and remediation effectiveness."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`compliance_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment (Internal Audit, Third-Party Audit, Self-Assessment) for segmenting assessment portfolio."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status from the assessment (Compliant, Non-Compliant, Partially Compliant) — primary risk filter."
    - name: "compliance_finding"
      expr: compliance_finding
      comment: "Key finding from the assessment — enables trend analysis of recurring compliance gaps."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the assessment finding — drives prioritisation of corrective action resources."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework assessed (ISO, GMP, REACH, FDA 21 CFR, etc.) for framework-level compliance tracking."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Authority whose requirements were assessed — supports authority-level compliance scorecards."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flags assessments requiring corrective action — used to measure remediation workload."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action (Open, In Progress, Closed) — tracks remediation pipeline health."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for year-over-year compliance trend analysis."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month bucket of assessment date for monthly compliance audit cadence tracking."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where the assessment was conducted — supports geographic compliance risk mapping."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments conducted. Baseline audit activity KPI for compliance program management."
    - name: "non_compliant_assessment_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of assessments resulting in a non-compliant finding. Core compliance health KPI — rising count triggers executive escalation."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of assessments requiring corrective action. Measures remediation workload and compliance gap severity."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_status = 'Open' THEN 1 END)
      comment: "Count of assessments with open corrective actions. Tracks unresolved compliance gaps requiring active management."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk compliance assessments. Directly informs risk committee reporting and remediation investment prioritisation."
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(closure_date, assessment_date))
      comment: "Average days from assessment to closure. Measures compliance remediation cycle time — a key operational efficiency KPI."
    - name: "avg_days_to_corrective_action_due"
      expr: AVG(DATEDIFF(corrective_action_due_date, assessment_date))
      comment: "Average days between assessment and corrective action deadline. Informs remediation urgency and resource scheduling."
    - name: "overdue_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_due_date < CURRENT_DATE AND corrective_action_status != 'Closed' THEN 1 END)
      comment: "Assessments with overdue corrective actions. A critical compliance risk KPI — overdue actions signal systemic remediation failure."
    - name: "distinct_skus_assessed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs covered by compliance assessments. Measures breadth of product compliance coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_surveillance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over post-market surveillance events — signal detection rates, injury reporting, investigation cycle times, and recall initiation. Drives consumer safety and post-market vigilance decisions."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`surveillance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of surveillance event (Adverse Event, Consumer Complaint, Field Alert, etc.) for signal categorisation."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the surveillance event (Open, Under Investigation, Closed) — primary filter for active signal dashboards."
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity of the event — drives escalation thresholds and regulatory reporting obligations."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the event — enables systemic failure trend analysis across product lines."
    - name: "signal_source"
      expr: signal_source
      comment: "Source of the surveillance signal (Consumer, Healthcare Professional, Regulatory Authority) for signal origin analysis."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Market where the event occurred — supports geographic risk heat-maps for post-market surveillance."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority to whom the event must be reported — tracks reporting obligation coverage."
    - name: "injury_reported_flag"
      expr: injury_reported_flag
      comment: "Flags events involving reported consumer injury — highest-priority consumer safety dimension."
    - name: "recall_initiated_flag"
      expr: recall_initiated_flag
      comment: "Indicates whether the event triggered a product recall — links surveillance signals to recall outcomes."
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Flags events requiring mandatory regulatory reporting — tracks compliance with post-market vigilance obligations."
    - name: "event_year"
      expr: YEAR(event_occurrence_date)
      comment: "Year of event occurrence for year-over-year surveillance trend analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_occurrence_date)
      comment: "Month bucket of event occurrence for monthly signal volume tracking."
  measures:
    - name: "total_surveillance_events"
      expr: COUNT(1)
      comment: "Total number of post-market surveillance events. Baseline signal volume KPI for consumer safety and vigilance dashboards."
    - name: "injury_reported_event_count"
      expr: COUNT(CASE WHEN injury_reported_flag = TRUE THEN 1 END)
      comment: "Number of events involving reported consumer injury. Highest-priority consumer safety KPI — directly informs recall and regulatory reporting decisions."
    - name: "recall_initiated_event_count"
      expr: COUNT(CASE WHEN recall_initiated_flag = TRUE THEN 1 END)
      comment: "Number of surveillance events that escalated to a product recall. Measures signal-to-recall conversion rate for safety risk management."
    - name: "regulatory_reporting_required_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Count of events requiring mandatory regulatory reporting. Tracks compliance with post-market vigilance reporting obligations."
    - name: "medical_treatment_required_count"
      expr: COUNT(CASE WHEN medical_treatment_required_flag = TRUE THEN 1 END)
      comment: "Events requiring medical treatment. A leading indicator of serious adverse events — triggers expedited regulatory reporting."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of surveillance events requiring corrective action. Measures post-market remediation workload."
    - name: "total_financial_impact_estimate"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of surveillance events. Quantifies post-market risk exposure for CFO and insurance planning."
    - name: "avg_investigation_cycle_days"
      expr: AVG(DATEDIFF(investigation_completion_date, investigation_start_date))
      comment: "Average days to complete a surveillance investigation. Measures post-market vigilance response speed — a key regulatory compliance KPI."
    - name: "open_event_count"
      expr: COUNT(CASE WHEN event_status = 'Open' THEN 1 END)
      comment: "Number of currently open surveillance events. Measures unresolved post-market risk exposure at any point in time."
    - name: "distinct_skus_with_events"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with surveillance events. Measures breadth of post-market safety signal coverage across the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over product and facility regulatory registrations — registration portfolio health, renewal pipeline, and fee spend. Enables market access and regulatory affairs teams to manage registration compliance."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`regulatory_registration`"
  dimensions:
    - name: "registration_type"
      expr: registration_type
      comment: "Type of registration (Product, Facility, Ingredient, etc.) for portfolio segmentation."
    - name: "registration_status"
      expr: registration_status
      comment: "Current registration status (Active, Expired, Pending, Suspended) — primary filter for market access dashboards."
    - name: "registration_category"
      expr: registration_category
      comment: "Regulatory category of the registration — links registrations to product classification and market access requirements."
    - name: "registering_authority"
      expr: registering_authority
      comment: "Regulatory authority that issued the registration — supports authority-level portfolio management."
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country of registration — enables geographic market access portfolio analysis."
    - name: "jurisdiction_region"
      expr: jurisdiction_region
      comment: "Regional jurisdiction of the registration — supports regional market access planning."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicates GMP compliance status of the registration — a mandatory requirement for many markets."
    - name: "post_market_surveillance_required"
      expr: post_market_surveillance_required
      comment: "Flags registrations requiring post-market surveillance — links registration portfolio to vigilance obligations."
    - name: "renewal_due_month"
      expr: DATE_TRUNC('MONTH', renewal_due_date)
      comment: "Month bucket of renewal due date — drives near-term renewal pipeline planning."
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total number of regulatory registrations. Baseline market access portfolio KPI for regulatory affairs management."
    - name: "active_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN 1 END)
      comment: "Number of currently active registrations. Measures live market access coverage across the product portfolio."
    - name: "expired_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Expired' THEN 1 END)
      comment: "Number of expired registrations. Flags market access gaps requiring immediate renewal action."
    - name: "pending_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Pending' THEN 1 END)
      comment: "Count of registrations awaiting approval. Measures market entry pipeline backlog."
    - name: "total_registration_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees paid for regulatory registrations. Core input to regulatory affairs budget and market access cost analysis."
    - name: "avg_registration_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average registration fee. Benchmarks market access cost efficiency across authorities and registration types."
    - name: "renewals_due_next_90_days"
      expr: COUNT(CASE WHEN renewal_due_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Registrations due for renewal within 90 days. Drives near-term renewal workload planning and prevents market access lapses."
    - name: "gmp_compliant_registration_count"
      expr: COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN 1 END)
      comment: "Number of registrations with confirmed GMP compliance. Measures GMP coverage across the registration portfolio."
    - name: "distinct_skus_registered"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one regulatory registration. Measures product portfolio market access breadth."
    - name: "distinct_markets_registered"
      expr: COUNT(DISTINCT jurisdiction_country_code)
      comment: "Number of distinct country markets with active registrations. Measures geographic market access footprint."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_cpsc_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over CPSC (Consumer Product Safety Commission) filings — incident volumes, injury severity, recall announcements, and filing pipeline health. Directly informs consumer safety and product liability risk management."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`cpsc_filing`"
  dimensions:
    - name: "filing_type"
      expr: filing_type
      comment: "Type of CPSC filing (Section 15(b) Report, SaferProducts.gov, etc.) for regulatory obligation segmentation."
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the CPSC filing (Submitted, Under Review, Closed) — primary filter for active filing dashboards."
    - name: "hazard_type"
      expr: hazard_type
      comment: "Type of product hazard reported — enables hazard trend analysis to drive product safety improvements."
    - name: "injury_severity"
      expr: injury_severity
      comment: "Severity of reported injuries — drives escalation thresholds and recall decision-making."
    - name: "corrective_action_type"
      expr: corrective_action_type
      comment: "Type of corrective action taken (Recall, Repair, Replacement, Refund) — informs consumer remedy cost planning."
    - name: "cpsc_response_type"
      expr: cpsc_response_type
      comment: "Type of CPSC response received — tracks regulatory authority engagement and enforcement posture."
    - name: "recall_announced_flag"
      expr: recall_announced_flag
      comment: "Indicates whether a public recall has been announced — links CPSC filings to active recall events."
    - name: "legal_review_completed_flag"
      expr: legal_review_completed_flag
      comment: "Flags filings that have completed legal review — tracks legal readiness of CPSC submissions."
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year of CPSC filing for year-over-year consumer safety trend analysis."
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', filing_date)
      comment: "Month bucket of filing date for monthly CPSC filing volume tracking."
  measures:
    - name: "total_cpsc_filings"
      expr: COUNT(1)
      comment: "Total number of CPSC filings. Baseline consumer product safety KPI for executive and legal reporting."
    - name: "recall_announced_count"
      expr: COUNT(CASE WHEN recall_announced_flag = TRUE THEN 1 END)
      comment: "Number of CPSC filings that resulted in a public recall announcement. Directly measures consumer safety and brand risk exposure."
    - name: "legal_review_completed_count"
      expr: COUNT(CASE WHEN legal_review_completed_flag = TRUE THEN 1 END)
      comment: "Number of filings with completed legal review. Tracks legal readiness and compliance with CPSC submission requirements."
    - name: "pending_cpsc_response_count"
      expr: COUNT(CASE WHEN filing_status = 'Under Review' THEN 1 END)
      comment: "Filings currently under CPSC review. Measures active regulatory engagement and pending enforcement risk."
    - name: "avg_days_to_cpsc_response"
      expr: AVG(DATEDIFF(cpsc_response_received_date, filing_date))
      comment: "Average days from filing to CPSC response. Benchmarks regulatory authority response speed for planning purposes."
    - name: "distinct_skus_with_cpsc_filings"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with CPSC filings. Measures breadth of product safety risk exposure across the portfolio."
    - name: "avg_days_knowledge_to_filing"
      expr: AVG(DATEDIFF(filing_date, knowledge_date))
      comment: "Average days from knowledge of defect to CPSC filing. Measures regulatory reporting timeliness — a key CPSC compliance KPI (Section 15(b) requires prompt reporting)."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_reach_substance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over REACH-registered substances — SVHC exposure, authorization status, and registration portfolio health. Enables chemical compliance and supply chain risk management decisions."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`reach_substance`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "REACH registration status (Registered, Pending, Exempt) — primary filter for compliance portfolio dashboards."
    - name: "svhc_status"
      expr: svhc_status
      comment: "Substance of Very High Concern (SVHC) status — highest-priority chemical compliance dimension for REACH."
    - name: "restriction_status"
      expr: restriction_status
      comment: "Whether the substance is restricted under REACH Annex XVII — drives formulation and supply chain decisions."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "GHS/CLP hazard classification of the substance — informs SDS requirements and worker safety obligations."
    - name: "authorization_required_flag"
      expr: authorization_required_flag
      comment: "Flags substances requiring REACH authorization (Annex XIV) — identifies substances at risk of market access restriction."
    - name: "pbt_assessment"
      expr: pbt_assessment
      comment: "Persistent, Bioaccumulative and Toxic (PBT) assessment outcome — a key SVHC identification criterion."
    - name: "endocrine_disruptor_flag"
      expr: endocrine_disruptor_flag
      comment: "Flags substances identified as endocrine disruptors — a growing regulatory risk category in EU and global markets."
    - name: "tonnage_band"
      expr: tonnage_band
      comment: "REACH tonnage band of the substance — determines registration data requirements and regulatory obligations."
    - name: "market_access_status_eu"
      expr: market_access_status_eu
      comment: "EU market access status for the substance — directly informs product formulation and market entry decisions."
    - name: "substance_origin_country_code"
      expr: substance_origin_country_code
      comment: "Country of origin of the substance — supports supply chain risk and geopolitical dependency analysis."
  measures:
    - name: "total_reach_substances"
      expr: COUNT(1)
      comment: "Total number of REACH-registered substances in the portfolio. Baseline chemical compliance portfolio KPI."
    - name: "svhc_substance_count"
      expr: COUNT(CASE WHEN svhc_status = 'SVHC' THEN 1 END)
      comment: "Number of substances on the SVHC candidate list. Highest-priority REACH compliance KPI — SVHC substances face potential authorization requirements and market restrictions."
    - name: "authorization_required_count"
      expr: COUNT(CASE WHEN authorization_required_flag = TRUE THEN 1 END)
      comment: "Number of substances requiring REACH authorization. Measures regulatory risk exposure from Annex XIV substances."
    - name: "restricted_substance_count"
      expr: COUNT(CASE WHEN restriction_status = 'Restricted' THEN 1 END)
      comment: "Number of restricted substances in the portfolio. Drives formulation change and supply chain substitution decisions."
    - name: "endocrine_disruptor_count"
      expr: COUNT(CASE WHEN endocrine_disruptor_flag = TRUE THEN 1 END)
      comment: "Number of substances flagged as endocrine disruptors. A growing regulatory risk category requiring proactive formulation management."
    - name: "avg_dnel_value"
      expr: AVG(CAST(dnel_value AS DOUBLE))
      comment: "Average Derived No-Effect Level (DNEL) across substances. Benchmarks worker and consumer exposure thresholds for safety assessment."
    - name: "avg_pnec_value"
      expr: AVG(CAST(pnec_value AS DOUBLE))
      comment: "Average Predicted No-Effect Concentration (PNEC) across substances. Measures environmental risk profile of the substance portfolio."
    - name: "authorization_expiring_90d_count"
      expr: COUNT(CASE WHEN authorization_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Substances with REACH authorizations expiring within 90 days. Drives near-term renewal planning to prevent market access disruption."
    - name: "sds_required_count"
      expr: COUNT(CASE WHEN sds_required_flag = TRUE THEN 1 END)
      comment: "Number of substances requiring a Safety Data Sheet. Measures SDS documentation obligation coverage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over regulatory changes — implementation pipeline health, impact severity distribution, and compliance risk exposure. Enables regulatory affairs and product teams to prioritise change response and resource allocation."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of regulatory change (New Regulation, Amendment, Guidance Update, etc.) for change portfolio segmentation."
    - name: "change_status"
      expr: change_status
      comment: "Current status of the regulatory change (Pending, In Progress, Implemented, Superseded) — primary pipeline filter."
    - name: "change_category"
      expr: change_category
      comment: "Category of regulatory change (Labeling, Ingredient, Safety, Packaging, etc.) — links changes to affected business functions."
    - name: "compliance_risk_level"
      expr: compliance_risk_level
      comment: "Risk level of non-compliance with the change — drives prioritisation of implementation resources."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of business impact from the regulatory change — informs investment and timeline decisions."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Status of change implementation (Not Started, In Progress, Complete) — tracks execution pipeline health."
    - name: "source_authority"
      expr: source_authority
      comment: "Regulatory authority issuing the change — supports authority-level change tracking."
    - name: "affected_product_category"
      expr: affected_product_category
      comment: "Product category affected by the change — links regulatory changes to product portfolio impact."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether compliance with the change is mandatory — distinguishes obligatory from voluntary changes."
    - name: "priority"
      expr: priority
      comment: "Business priority assigned to the change — drives workload sequencing for regulatory affairs teams."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the regulatory change becomes effective — supports forward-looking compliance calendar planning."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month bucket of effective date — drives near-term implementation deadline heat-maps."
  measures:
    - name: "total_regulatory_changes"
      expr: COUNT(1)
      comment: "Total number of regulatory changes tracked. Baseline regulatory landscape monitoring KPI for compliance program management."
    - name: "mandatory_change_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory regulatory changes. Measures obligatory compliance workload — a key input to regulatory affairs resource planning."
    - name: "high_risk_change_count"
      expr: COUNT(CASE WHEN compliance_risk_level = 'High' THEN 1 END)
      comment: "Number of high compliance-risk regulatory changes. Directly informs executive prioritisation and remediation investment decisions."
    - name: "not_started_implementation_count"
      expr: COUNT(CASE WHEN implementation_status = 'Not Started' THEN 1 END)
      comment: "Changes where implementation has not yet begun. Flags implementation backlog risk — rising count signals resource constraints."
    - name: "overdue_implementation_count"
      expr: COUNT(CASE WHEN required_action_deadline < CURRENT_DATE AND implementation_status != 'Complete' THEN 1 END)
      comment: "Changes past their required action deadline and not yet implemented. A critical compliance risk KPI requiring immediate executive attention."
    - name: "avg_implementation_cycle_days"
      expr: AVG(DATEDIFF(implementation_end_date, implementation_start_date))
      comment: "Average days to implement a regulatory change. Measures regulatory change management efficiency — informs capacity planning."
    - name: "impact_assessed_count"
      expr: COUNT(CASE WHEN impact_assessment_status = 'Complete' THEN 1 END)
      comment: "Number of changes with completed impact assessments. Tracks readiness of the regulatory change pipeline for implementation."
    - name: "changes_effective_next_90d"
      expr: COUNT(CASE WHEN effective_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Regulatory changes becoming effective within 90 days. Drives near-term compliance implementation prioritisation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_ifra_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over IFRA fragrance compliance records — usage level compliance, allergen exposure, and assessment currency. Enables fragrance safety and regulatory teams to manage IFRA standard adherence across the product portfolio."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`ifra_compliance_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "IFRA compliance status of the fragrance ingredient (Compliant, Non-Compliant, Exempt) — primary safety filter."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the IFRA compliance record — tracks sign-off pipeline for fragrance safety assessments."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of IFRA restriction (Prohibited, Restricted, Specification) — informs formulation decisions."
    - name: "ifra_product_category"
      expr: ifra_product_category
      comment: "IFRA product category (1-11) — determines applicable usage level limits for each fragrance ingredient."
    - name: "allergen_declaration_required"
      expr: allergen_declaration_required
      comment: "Flags ingredients requiring allergen declaration on product labels — links IFRA compliance to labeling obligations."
    - name: "allergen_threshold_exceeded"
      expr: allergen_threshold_exceeded
      comment: "Indicates whether the allergen threshold has been exceeded — a critical consumer safety and labeling compliance flag."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the IFRA compliance record — supports market-specific compliance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flags currently active IFRA compliance records — filters the live compliance portfolio."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of IFRA compliance assessment for trend analysis."
  measures:
    - name: "total_ifra_records"
      expr: COUNT(1)
      comment: "Total number of IFRA compliance records. Baseline fragrance compliance portfolio KPI."
    - name: "non_compliant_record_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of non-compliant IFRA records. Directly flags formulation changes required to meet IFRA standards — a key product safety KPI."
    - name: "allergen_threshold_exceeded_count"
      expr: COUNT(CASE WHEN allergen_threshold_exceeded = TRUE THEN 1 END)
      comment: "Number of records where allergen thresholds are exceeded. Triggers mandatory label updates and potential reformulation — a critical consumer safety KPI."
    - name: "allergen_declaration_required_count"
      expr: COUNT(CASE WHEN allergen_declaration_required = TRUE THEN 1 END)
      comment: "Number of ingredients requiring allergen declaration. Measures labeling compliance obligation scope across the fragrance portfolio."
    - name: "avg_safety_margin_pct"
      expr: AVG(CAST(safety_margin_percentage AS DOUBLE))
      comment: "Average safety margin percentage (permitted level vs. actual usage). Measures headroom to IFRA limits — low margins signal reformulation risk."
    - name: "avg_actual_usage_level"
      expr: AVG(CAST(actual_formulated_usage_level AS DOUBLE))
      comment: "Average actual formulated usage level across all IFRA records. Benchmarks fragrance concentration levels against permitted maxima."
    - name: "avg_max_permitted_usage_level"
      expr: AVG(CAST(maximum_permitted_usage_level AS DOUBLE))
      comment: "Average maximum permitted usage level across IFRA categories. Provides the benchmark denominator for safety margin analysis."
    - name: "overdue_assessment_count"
      expr: COUNT(CASE WHEN assessment_due_date < CURRENT_DATE AND compliance_status != 'Compliant' THEN 1 END)
      comment: "IFRA records with overdue assessments that are not yet compliant. Flags fragrance compliance gaps requiring immediate attention."
    - name: "distinct_skus_with_ifra_records"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with IFRA compliance records. Measures breadth of fragrance compliance coverage across the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`regulatory_region`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs over regulatory regions — geographic market coverage, economic profile, and jurisdictional hierarchy. Supports market prioritisation, regulatory investment allocation, and geographic expansion decisions. Note: per VREQ-042, this table serves as the SSOT for regulatory geographic regions (moved from shared.region)."
  source: "`vibe_consumer_goods_v1`.`regulatory`.`regulatory_region`"
  dimensions:
    - name: "regulatory_region_type"
      expr: regulatory_region_type
      comment: "Type of regulatory region (Country, State/Province, Trade Bloc, etc.) for geographic hierarchy analysis."
    - name: "regulatory_region_status"
      expr: regulatory_region_status
      comment: "Active/inactive status of the regulatory region — filters the live geographic compliance footprint."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the regulatory region hierarchy (Global, Regional, National, Sub-national) for roll-up analysis."
    - name: "iso_country_code"
      expr: iso_country_code
      comment: "ISO country code — standard geographic dimension for cross-domain market analysis."
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone of the region — relevant for product stability, packaging, and labeling requirements."
    - name: "primary_language"
      expr: primary_language
      comment: "Primary language of the region — drives labeling language compliance requirements."
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Indicates cross-border regulatory regions (e.g. EU, ASEAN) — identifies multi-jurisdiction compliance complexity."
    - name: "time_zone"
      expr: time_zone
      comment: "Time zone of the region — supports regulatory deadline and reporting calendar management."
  measures:
    - name: "total_regulatory_regions"
      expr: COUNT(1)
      comment: "Total number of regulatory regions in the model. Baseline geographic compliance footprint KPI."
    - name: "active_region_count"
      expr: COUNT(CASE WHEN regulatory_region_status = 'Active' THEN 1 END)
      comment: "Number of active regulatory regions. Measures the live geographic scope of regulatory compliance obligations."
    - name: "total_population"
      expr: SUM(CAST(population AS DOUBLE))
      comment: "Total population across all regulatory regions. Measures consumer market reach and regulatory impact scale."
    - name: "total_gdp_usd"
      expr: SUM(CAST(gdp_usd AS DOUBLE))
      comment: "Total GDP (USD) across regulatory regions. Quantifies economic value of the regulatory compliance footprint — informs market prioritisation."
    - name: "avg_gdp_usd_per_region"
      expr: AVG(CAST(gdp_usd AS DOUBLE))
      comment: "Average GDP per regulatory region. Benchmarks economic significance of individual markets for investment prioritisation."
    - name: "avg_median_income_usd"
      expr: AVG(CAST(median_income_usd AS DOUBLE))
      comment: "Average median income across regulatory regions. Informs pricing strategy and market segmentation decisions."
    - name: "avg_urbanization_rate"
      expr: AVG(CAST(urbanization_rate AS DOUBLE))
      comment: "Average urbanization rate across regulatory regions. Informs distribution channel strategy and market development planning."
    - name: "cross_border_region_count"
      expr: COUNT(CASE WHEN is_cross_border = TRUE THEN 1 END)
      comment: "Number of cross-border regulatory regions. Measures multi-jurisdiction compliance complexity in the geographic portfolio."
    - name: "total_area_sq_km"
      expr: SUM(CAST(area_sq_km AS DOUBLE))
      comment: "Total geographic area covered by regulatory regions. Measures physical scale of the regulatory compliance footprint."
$$;