-- Metric views for domain: supplier | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and performance metrics for the vendor master, covering delivery reliability, fill rates, quality acceptance, and contract health across the active supplier base."
  source: "`vibe_retail_v1`.`supplier`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current lifecycle status of the vendor (e.g., active, suspended, inactive), used to filter or segment performance metrics."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of the vendor (e.g., direct, drop-ship, marketplace, distributor) for segmented performance analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Assigned risk tier for the vendor, enabling risk-stratified performance and compliance reporting."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Negotiated payment terms code (e.g., Net30, Net60) for cash flow and working capital analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the vendor, used to segment financial metrics by currency exposure."
    - name: "sustainability_certified"
      expr: sustainability_certified_flag
      comment: "Indicates whether the vendor holds a sustainability certification, supporting ESG supplier segmentation."
    - name: "edi_capable"
      expr: edi_capable_flag
      comment: "Indicates whether the vendor supports electronic data interchange, relevant for operational efficiency analysis."
    - name: "vmi_enabled"
      expr: vmi_enabled_flag
      comment: "Indicates whether vendor-managed inventory is active for this vendor, used to segment replenishment performance."
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the vendor was onboarded, enabling cohort analysis of vendor performance over time."
  measures:
    - name: "total_active_vendors"
      expr: COUNT(CASE WHEN vendor_status = 'active' THEN vendor_id END)
      comment: "Count of vendors currently in active status. Tracks the size and health of the active supplier base for procurement capacity planning."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate across all vendors. A primary supply chain reliability KPI used in quarterly vendor reviews and procurement steering."
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average order fill rate across vendors. Directly impacts in-stock availability and lost sales; a core vendor performance indicator."
    - name: "avg_quality_acceptance_rate_pct"
      expr: AVG(CAST(quality_acceptance_rate_pct AS DOUBLE))
      comment: "Average quality acceptance rate across vendors. Measures the proportion of received goods meeting quality standards, driving decisions on vendor qualification and chargebacks."
    - name: "vendors_with_expiring_contracts_90d"
      expr: COUNT(CASE WHEN contract_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN vendor_id END)
      comment: "Number of vendors whose contracts expire within 90 days. Triggers procurement action to renegotiate or renew contracts before supply disruption."
    - name: "vendors_with_expiring_insurance_90d"
      expr: COUNT(CASE WHEN insurance_certificate_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN vendor_id END)
      comment: "Number of vendors with insurance certificates expiring within 90 days. Flags compliance risk requiring immediate follow-up to maintain coverage requirements."
    - name: "high_risk_vendor_count"
      expr: COUNT(CASE WHEN risk_rating IN ('high', 'critical') THEN vendor_id END)
      comment: "Count of vendors rated high or critical risk. Used by procurement leadership to prioritize risk mitigation and contingency sourcing."
    - name: "avg_moq_units"
      expr: AVG(CAST(moq_units AS DOUBLE))
      comment: "Average minimum order quantity across vendors. Informs inventory planning and working capital requirements for procurement decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comprehensive vendor performance scorecard metrics covering composite scores, delivery, fill rate, quality, EDI compliance, invoice accuracy, and chargeback exposure across scoring periods."
  source: "`vibe_retail_v1`.`supplier`.`vendor_scorecard`"
  dimensions:
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Current status of the scorecard record (e.g., draft, published, finalized), used to filter to actionable scorecard data."
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Tier classification assigned to the vendor on this scorecard (e.g., preferred, approved, probationary), enabling tier-based performance benchmarking."
    - name: "score_trend"
      expr: score_trend
      comment: "Direction of composite score movement (e.g., improving, declining, stable) for trend-based vendor management decisions."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether a corrective action plan is required based on scorecard results, used to track vendor remediation pipeline."
    - name: "scoring_period_start"
      expr: DATE_TRUNC('month', scoring_period_start_date)
      comment: "Month bucket of the scoring period start date, enabling time-series analysis of vendor performance trends."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which chargeback and purchase order financial metrics are denominated."
  measures:
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite vendor performance score across all scorecards in scope. The primary executive KPI for overall supplier quality and reliability."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate from scorecard evaluations. Directly measures supply chain reliability and informs vendor tier decisions."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate from scorecard evaluations. Measures vendor ability to fulfill orders completely, impacting in-stock performance."
    - name: "avg_product_quality_score"
      expr: AVG(CAST(product_quality_score AS DOUBLE))
      comment: "Average product quality score from vendor evaluations. Drives decisions on vendor qualification, chargebacks, and return-to-vendor activity."
    - name: "avg_edi_compliance_rate"
      expr: AVG(CAST(edi_compliance_rate AS DOUBLE))
      comment: "Average EDI compliance rate across scorecards. Measures vendor adherence to electronic transaction standards, reducing manual processing costs."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate from scorecard data. Inaccurate invoices drive AP processing costs and disputes; this KPI steers vendor compliance programs."
    - name: "avg_lead_time_adherence_rate"
      expr: AVG(CAST(lead_time_adherence_rate AS DOUBLE))
      comment: "Average lead time adherence rate. Measures vendor reliability in meeting agreed lead times, critical for inventory planning and replenishment."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback value assessed to vendors across all scorecards. Quantifies financial penalties for non-compliance, a key P&L and vendor management metric."
    - name: "total_purchase_order_value"
      expr: SUM(CAST(total_purchase_order_value AS DOUBLE))
      comment: "Total purchase order value covered by scorecards. Provides spend context for normalizing performance metrics and prioritizing vendor management effort."
    - name: "avg_score_change_vs_prior_period"
      expr: AVG(CAST(composite_score AS DOUBLE) - CAST(prior_period_composite_score AS DOUBLE))
      comment: "Average change in composite score versus the prior scoring period. Measures whether the vendor base is improving or declining in aggregate performance."
    - name: "vendors_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN vendor_scorecard_id END)
      comment: "Number of scorecard records requiring a corrective action plan. Tracks the volume of underperforming vendors needing active remediation."
    - name: "avg_return_to_vendor_amount"
      expr: AVG(CAST(return_to_vendor_amount AS DOUBLE))
      comment: "Average return-to-vendor financial value per scorecard. Elevated RTV amounts signal quality or compliance issues requiring vendor intervention."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor chargeback metrics tracking penalty amounts, violation patterns, dispute rates, and recovery performance to manage supplier compliance and financial recovery."
  source: "`vibe_retail_v1`.`supplier`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback (e.g., open, disputed, resolved, recovered), used to segment the chargeback pipeline by stage."
    - name: "chargeback_type"
      expr: chargeback_type
      comment: "Category of chargeback (e.g., routing violation, labeling, ASN error, fill rate), enabling root-cause analysis of compliance failures."
    - name: "violation_category"
      expr: violation_category
      comment: "Specific violation category driving the chargeback, used for compliance program targeting and vendor coaching."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any vendor dispute against the chargeback, used to track contested amounts and resolution pipeline."
    - name: "is_repeat_violation"
      expr: is_repeat_violation
      comment: "Flags chargebacks arising from repeat violations, enabling escalation and vendor risk scoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the chargeback penalty is denominated."
    - name: "violation_month"
      expr: DATE_TRUNC('month', violation_date)
      comment: "Month of the violation, enabling trend analysis of chargeback volumes and amounts over time."
    - name: "penalty_calculation_method"
      expr: penalty_calculation_method
      comment: "Method used to calculate the penalty (e.g., flat fee, percentage of invoice), relevant for policy consistency analysis."
    - name: "notification_method"
      expr: notification_method
      comment: "Channel used to notify the vendor of the chargeback, used to assess communication effectiveness and dispute rates by channel."
  measures:
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total chargeback penalty amount assessed to vendors. A direct P&L recovery metric and primary indicator of supplier compliance program effectiveness."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average chargeback penalty per violation. Benchmarks penalty severity and informs penalty schedule calibration."
    - name: "total_chargebacks"
      expr: COUNT(chargeback_id)
      comment: "Total number of chargeback records. Tracks overall volume of vendor compliance violations for trend and capacity analysis."
    - name: "repeat_violation_chargebacks"
      expr: COUNT(CASE WHEN is_repeat_violation = TRUE THEN chargeback_id END)
      comment: "Count of chargebacks arising from repeat violations. High repeat rates indicate systemic vendor non-compliance requiring escalation."
    - name: "disputed_chargebacks"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != '' THEN chargeback_id END)
      comment: "Number of chargebacks that have been disputed by the vendor. Elevated dispute rates may signal unclear compliance standards or over-penalization."
    - name: "total_vendor_scorecard_impact"
      expr: SUM(CAST(vendor_scorecard_impact AS DOUBLE))
      comment: "Total scorecard impact points deducted due to chargebacks. Quantifies the aggregate effect of compliance violations on vendor performance ratings."
    - name: "avg_penalty_percentage"
      expr: AVG(CAST(penalty_percentage AS DOUBLE))
      comment: "Average penalty as a percentage of the transaction value. Used to assess whether penalty rates are proportionate and consistent across violation types."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor allowance and trade funding metrics tracking accrued, claimed, settled, and disputed amounts to manage trade spend effectiveness and recovery rates."
  source: "`vibe_retail_v1`.`supplier`.`vendor_allowance`"
  dimensions:
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of vendor allowance (e.g., promotional, volume rebate, co-op advertising, slotting), enabling trade spend analysis by funding category."
    - name: "allowance_status"
      expr: allowance_status
      comment: "Current status of the allowance (e.g., active, expired, claimed, settled), used to track the allowance lifecycle pipeline."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the allowance (e.g., pending, partially settled, fully settled), critical for accounts receivable and trade fund recovery tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the allowance record, used to filter to authorized trade funding commitments."
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue the allowance (e.g., off-invoice, bill-back), relevant for financial accounting and audit purposes."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the allowance is denominated, used for multi-currency trade spend reporting."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the allowance became effective, enabling time-series analysis of trade funding commitments."
    - name: "product_category"
      expr: product_category
      comment: "Product category associated with the allowance, enabling category-level trade spend analysis."
  measures:
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total committed vendor allowance value. The primary trade spend commitment metric used in P&L planning and vendor negotiation reviews."
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total amount accrued against vendor allowances. Tracks the financial liability recognized for trade funding, critical for accurate P&L reporting."
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total amount claimed from vendors under allowance agreements. Measures trade fund recovery progress against commitments."
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total amount fully settled with vendors. Represents realized trade income and is a key cash flow and working capital metric."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total allowance amount currently under dispute. Elevated disputed amounts signal vendor relationship friction and at-risk trade income."
    - name: "avg_allowance_percentage"
      expr: AVG(CAST(allowance_percentage AS DOUBLE))
      comment: "Average allowance rate as a percentage of purchase value. Benchmarks trade funding generosity across vendors and categories for negotiation strategy."
    - name: "unsettled_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE) - CAST(settled_amount AS DOUBLE))
      comment: "Total allowance value not yet settled. Quantifies outstanding trade receivables requiring follow-up to recover committed vendor funding."
    - name: "total_minimum_purchase_amount"
      expr: SUM(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Total minimum purchase commitment required to qualify for allowances. Used in procurement planning to ensure qualifying spend thresholds are met."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor dispute metrics tracking dispute volumes, financial exposure, resolution timelines, and escalation rates to manage supplier relationship health and accounts payable risk."
  source: "`vibe_retail_v1`.`supplier`.`vendor_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the vendor dispute (e.g., open, under review, resolved, escalated), used to track the dispute resolution pipeline."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute (e.g., invoice discrepancy, short shipment, quality claim), enabling root-cause analysis of vendor relationship issues."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Business category of the dispute, used for trend analysis and compliance program targeting."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the dispute has been escalated, used to track high-priority disputes requiring senior intervention."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the disputed amount is denominated."
    - name: "dispute_submission_channel"
      expr: dispute_submission_channel
      comment: "Channel through which the dispute was submitted (e.g., portal, email, EDI), used to assess process efficiency by channel."
    - name: "dispute_submission_month"
      expr: DATE_TRUNC('month', dispute_submission_date)
      comment: "Month the dispute was submitted, enabling trend analysis of dispute volumes over time."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial value under dispute with vendors. A key accounts payable risk metric and indicator of vendor relationship health."
    - name: "total_approved_credit_amount"
      expr: SUM(CAST(approved_credit_amount AS DOUBLE))
      comment: "Total credit amount approved in resolution of vendor disputes. Measures the financial outcome of dispute resolution and recovery effectiveness."
    - name: "total_open_disputes"
      expr: COUNT(CASE WHEN dispute_status NOT IN ('resolved', 'closed') THEN vendor_dispute_id END)
      comment: "Number of currently open vendor disputes. Tracks the active dispute backlog requiring resolution resources."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN vendor_dispute_id END)
      comment: "Number of disputes that have been escalated. High escalation rates indicate systemic vendor compliance or relationship issues requiring executive attention."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute record. Benchmarks dispute severity and informs staffing and resolution process investment decisions."
    - name: "unresolved_disputed_amount"
      expr: SUM(CASE WHEN dispute_status NOT IN ('resolved', 'closed') THEN disputed_amount ELSE 0 END)
      comment: "Total financial value in unresolved disputes. Quantifies at-risk payables exposure requiring active management to prevent write-offs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor risk assessment metrics covering overall risk scores, domain-specific risk dimensions (financial, ESG, cybersecurity, supply continuity), and assessment currency to support strategic sourcing risk management."
  source: "`vibe_retail_v1`.`supplier`.`risk_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the risk assessment (e.g., in progress, completed, expired), used to filter to current and actionable assessments."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g., initial onboarding, annual review, triggered reassessment), enabling analysis by assessment lifecycle stage."
    - name: "overall_risk_tier"
      expr: overall_risk_tier
      comment: "Risk tier assigned based on overall risk score (e.g., low, medium, high, critical), the primary dimension for risk-stratified vendor management."
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Status of required mitigation actions (e.g., pending, in progress, completed), used to track risk remediation pipeline."
    - name: "third_party_assessment_flag"
      expr: third_party_assessment_flag
      comment: "Indicates whether the assessment was conducted by a third-party assessor, enabling comparison of internal vs. external risk ratings."
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of the risk assessment, enabling trend analysis of vendor risk profiles over time."
  measures:
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall vendor risk score across all assessments in scope. The primary executive KPI for aggregate supplier risk exposure."
    - name: "avg_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score across vendor assessments. Identifies financially vulnerable suppliers that pose supply continuity risk."
    - name: "avg_supply_continuity_risk_score"
      expr: AVG(CAST(supply_continuity_risk_score AS DOUBLE))
      comment: "Average supply continuity risk score. Measures the risk of supply disruption, directly impacting inventory availability and customer service levels."
    - name: "avg_esg_risk_score"
      expr: AVG(CAST(esg_risk_score AS DOUBLE))
      comment: "Average ESG risk score across vendor assessments. Supports sustainability reporting and responsible sourcing program management."
    - name: "avg_cybersecurity_risk_score"
      expr: AVG(CAST(cybersecurity_risk_score AS DOUBLE))
      comment: "Average cybersecurity risk score. Identifies vendors with data security vulnerabilities that could expose the organization to breach risk."
    - name: "avg_compliance_risk_score"
      expr: AVG(CAST(compliance_risk_score AS DOUBLE))
      comment: "Average compliance risk score across vendor assessments. Flags vendors at risk of regulatory non-compliance requiring proactive management."
    - name: "high_risk_assessments"
      expr: COUNT(CASE WHEN overall_risk_tier IN ('high', 'critical') THEN risk_assessment_id END)
      comment: "Number of assessments resulting in a high or critical risk tier. Tracks the volume of vendors requiring active risk mitigation and contingency sourcing."
    - name: "assessments_expiring_90d"
      expr: COUNT(CASE WHEN assessment_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN risk_assessment_id END)
      comment: "Number of risk assessments expiring within 90 days. Triggers reassessment scheduling to maintain current risk visibility across the supplier base."
    - name: "avg_single_source_dependency_score"
      expr: AVG(CAST(single_source_dependency_score AS DOUBLE))
      comment: "Average single-source dependency score. Quantifies concentration risk where the organization relies on a sole supplier, informing dual-sourcing strategy."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor certification compliance metrics tracking certification coverage, audit frequency, corrective action rates, and renewal pipeline to manage supplier quality and regulatory compliance."
  source: "`vibe_retail_v1`.`supplier`.`vendor_certification`"
  dimensions:
    - name: "compliance_level"
      expr: compliance_level
      comment: "Level of compliance achieved by the vendor for this certification (e.g., full, partial, non-compliant), the primary dimension for certification health analysis."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the certification is mandatory for the vendor to operate, used to prioritize compliance follow-up."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether a corrective action is required based on the certification audit, used to track remediation pipeline."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the certified vendor facility is located, enabling geographic compliance risk analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the certification (e.g., third-party audit, self-declaration, document review), relevant for assurance quality analysis."
    - name: "audit_frequency"
      expr: audit_frequency
      comment: "Frequency at which the certification is audited (e.g., annual, biannual), used to assess audit coverage adequacy."
  measures:
    - name: "total_certifications"
      expr: COUNT(vendor_certification_id)
      comment: "Total number of vendor certification records. Tracks the breadth of certification coverage across the supplier base."
    - name: "certifications_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN vendor_certification_id END)
      comment: "Number of certifications with open corrective action requirements. Tracks the volume of compliance gaps requiring active remediation."
    - name: "certifications_expiring_90d"
      expr: COUNT(CASE WHEN renewal_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN vendor_certification_id END)
      comment: "Number of certifications due for renewal within 90 days. Triggers proactive renewal management to prevent compliance lapses."
    - name: "mandatory_non_compliant_certifications"
      expr: COUNT(CASE WHEN is_mandatory = TRUE AND compliance_level = 'non-compliant' THEN vendor_certification_id END)
      comment: "Number of mandatory certifications where the vendor is non-compliant. Represents critical compliance risk requiring immediate escalation and potential vendor suspension."
    - name: "avg_compliance_penalty_rate"
      expr: AVG(0)
      comment: "Placeholder — compliance_penalty_rate is not available on vendor_certification; use lead_time_agreement metrics for penalty rate analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_lead_time_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead time agreement performance metrics covering SLA targets, fill rate commitments, on-time delivery thresholds, and compliance penalty exposure to manage vendor delivery performance contracts."
  source: "`vibe_retail_v1`.`supplier`.`lead_time_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the lead time agreement (e.g., active, expired, pending), used to filter to operative agreements."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of lead time agreement (e.g., standard, expedited, seasonal), enabling analysis by agreement category."
    - name: "scope_level"
      expr: scope_level
      comment: "Scope at which the agreement applies (e.g., vendor, category, SKU), used to segment SLA coverage analysis."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation specified in the agreement (e.g., truck, rail, air), relevant for logistics cost and lead time analysis."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterms code governing delivery responsibility, used to segment agreements by risk and cost transfer point."
    - name: "vmi_enabled"
      expr: vmi_enabled_flag
      comment: "Indicates whether vendor-managed inventory is enabled under this agreement, used to segment VMI vs. standard replenishment performance."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the agreement became effective, enabling cohort analysis of agreement performance over time."
  measures:
    - name: "avg_fill_rate_sla_pct"
      expr: AVG(CAST(fill_rate_sla_percent AS DOUBLE))
      comment: "Average fill rate SLA target across lead time agreements. Benchmarks the contractual fill rate standard the organization has negotiated with vendors."
    - name: "avg_on_time_delivery_sla_pct"
      expr: AVG(CAST(on_time_delivery_sla_percent AS DOUBLE))
      comment: "Average on-time delivery SLA target across agreements. Establishes the contractual delivery reliability standard for vendor performance management."
    - name: "total_compliance_penalty_rate"
      expr: SUM(CAST(compliance_penalty_rate AS DOUBLE))
      comment: "Total compliance penalty rate exposure across all active lead time agreements. Quantifies the financial risk of vendor non-compliance with delivery SLAs."
    - name: "avg_compliance_penalty_rate"
      expr: AVG(CAST(compliance_penalty_rate AS DOUBLE))
      comment: "Average compliance penalty rate per agreement. Used to assess whether penalty structures are consistently applied and appropriately calibrated."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across lead time agreements. Informs procurement planning and working capital requirements."
    - name: "active_agreements_count"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN lead_time_agreement_id END)
      comment: "Number of currently active lead time agreements. Tracks the breadth of contractual delivery coverage across the supplier base."
    - name: "agreements_expiring_90d"
      expr: COUNT(CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN lead_time_agreement_id END)
      comment: "Number of lead time agreements expiring within 90 days. Triggers renegotiation to prevent gaps in contractual delivery performance standards."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_rtv_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return-to-vendor request metrics tracking return volumes, financial value, chargeback recovery, and disposition patterns to manage vendor quality accountability and inventory recovery."
  source: "`vibe_retail_v1`.`supplier`.`rtv_request`"
  dimensions:
    - name: "rtv_status"
      expr: rtv_status
      comment: "Current status of the return-to-vendor request (e.g., pending, approved, shipped, credited), used to track the RTV pipeline."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return (e.g., quality defect, overstock, recall), enabling root-cause analysis of vendor return drivers."
    - name: "disposition_method"
      expr: disposition_method
      comment: "How returned goods are handled (e.g., return to vendor, destroy, donate, liquidate), used to analyze recovery value by disposition type."
    - name: "is_recall_related"
      expr: is_recall_related
      comment: "Indicates whether the RTV is related to a product recall, used to isolate recall-driven return volumes and costs."
    - name: "freight_responsibility"
      expr: freight_responsibility
      comment: "Party responsible for return freight costs (e.g., vendor, retailer), relevant for cost recovery analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which return values and chargeback amounts are denominated."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month the RTV request was initiated, enabling trend analysis of return volumes over time."
  measures:
    - name: "total_return_value"
      expr: SUM(CAST(total_return_value AS DOUBLE))
      comment: "Total financial value of goods returned to vendors. A key inventory recovery and vendor accountability metric used in P&L and procurement reviews."
    - name: "total_return_quantity"
      expr: SUM(CAST(total_return_quantity AS DOUBLE))
      comment: "Total units returned to vendors. Tracks the volume of defective or excess inventory returned, informing quality and buying decisions."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount recovered through RTV requests. Measures financial recovery from vendor-responsible quality or compliance failures."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost incurred for return-to-vendor shipments. Quantifies the logistics cost of vendor quality failures for cost recovery negotiations."
    - name: "avg_return_value_per_request"
      expr: AVG(CAST(total_return_value AS DOUBLE))
      comment: "Average return value per RTV request. Benchmarks the financial materiality of individual returns for process prioritization."
    - name: "recall_related_rtv_count"
      expr: COUNT(CASE WHEN is_recall_related = TRUE THEN rtv_request_id END)
      comment: "Number of RTV requests related to product recalls. Tracks the operational impact of recall events on vendor return activity."
    - name: "open_rtv_requests"
      expr: COUNT(CASE WHEN rtv_status NOT IN ('completed', 'closed', 'credited') THEN rtv_request_id END)
      comment: "Number of RTV requests not yet completed. Tracks the active return pipeline requiring operational follow-through."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vmi_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor-managed inventory configuration metrics tracking inventory thresholds, replenishment parameters, penalty exposure, and program health to manage VMI program performance and vendor accountability."
  source: "`vibe_retail_v1`.`supplier`.`vmi_config`"
  dimensions:
    - name: "config_status"
      expr: config_status
      comment: "Current status of the VMI configuration (e.g., active, suspended, expired), used to filter to operative VMI programs."
    - name: "replenishment_model"
      expr: replenishment_model
      comment: "Replenishment model used in the VMI configuration (e.g., min-max, continuous review, periodic), enabling analysis by replenishment strategy."
    - name: "replenishment_frequency"
      expr: replenishment_frequency
      comment: "Frequency of replenishment orders under the VMI program, used to assess operational cadence and inventory velocity."
    - name: "consignment_flag"
      expr: consignment_flag
      comment: "Indicates whether inventory is held on consignment under this VMI configuration, relevant for working capital and ownership analysis."
    - name: "auto_replenishment_enabled"
      expr: auto_replenishment_enabled
      comment: "Indicates whether automatic replenishment is enabled, used to segment manual vs. automated VMI performance."
    - name: "ownership_transfer_point"
      expr: ownership_transfer_point
      comment: "Point at which inventory ownership transfers from vendor to retailer, relevant for financial reporting and risk analysis."
  measures:
    - name: "avg_target_inventory_level"
      expr: AVG(CAST(target_inventory_level AS DOUBLE))
      comment: "Average target inventory level across VMI configurations. Benchmarks planned inventory positions for capacity and working capital planning."
    - name: "avg_safety_stock_level"
      expr: AVG(CAST(safety_stock_level AS DOUBLE))
      comment: "Average safety stock level across VMI programs. Quantifies the buffer inventory maintained to protect against supply variability."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point across VMI configurations. Defines the inventory trigger level for replenishment, critical for in-stock performance management."
    - name: "total_stockout_penalty_exposure"
      expr: SUM(CAST(stockout_penalty_amount AS DOUBLE))
      comment: "Total stockout penalty amount across VMI configurations. Quantifies the financial risk of inventory shortfalls under VMI contracts, driving replenishment investment decisions."
    - name: "total_excess_inventory_penalty_exposure"
      expr: SUM(CAST(excess_inventory_penalty_amount AS DOUBLE))
      comment: "Total excess inventory penalty exposure across VMI configurations. Quantifies the cost of over-stocking under VMI contracts, informing inventory optimization."
    - name: "avg_performance_sla_target"
      expr: AVG(CAST(performance_sla_target AS DOUBLE))
      comment: "Average performance SLA target across VMI programs. Establishes the contractual service level standard for vendor-managed replenishment performance."
    - name: "active_vmi_configs"
      expr: COUNT(CASE WHEN config_status = 'active' THEN vmi_config_id END)
      comment: "Number of active VMI configurations. Tracks the scale of the VMI program across the supplier base and inventory network."
    - name: "avg_max_inventory_threshold"
      expr: AVG(CAST(max_inventory_threshold AS DOUBLE))
      comment: "Average maximum inventory threshold across VMI configurations. Used to assess whether inventory caps are appropriately set to prevent excess stock accumulation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_onboarding_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor onboarding pipeline metrics tracking application volumes, stage progression, risk assessment scores, and compliance readiness to manage supplier onboarding efficiency and quality."
  source: "`vibe_retail_v1`.`supplier`.`onboarding_request`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of the onboarding request (e.g., submitted, under review, approved, rejected), used to track the onboarding pipeline by stage."
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Specific stage within the onboarding process (e.g., document collection, risk assessment, EDI setup), enabling bottleneck analysis."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned during onboarding assessment (e.g., low, medium, high), used to segment onboarding throughput by risk profile."
    - name: "edi_capable"
      expr: edi_capable_flag
      comment: "Indicates whether the prospective vendor supports EDI, used to assess digital readiness of the incoming supplier base."
    - name: "sustainability_certified"
      expr: sustainability_certified_flag
      comment: "Indicates whether the prospective vendor holds sustainability certification, supporting ESG sourcing program analysis."
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country of the vendor headquarters, enabling geographic analysis of the onboarding pipeline and sourcing diversification."
    - name: "application_month"
      expr: DATE_TRUNC('month', application_submitted_date)
      comment: "Month the onboarding application was submitted, enabling trend analysis of new vendor pipeline volume."
  measures:
    - name: "total_onboarding_requests"
      expr: COUNT(onboarding_request_id)
      comment: "Total number of vendor onboarding requests. Tracks the volume of new supplier pipeline, a leading indicator of sourcing capacity expansion."
    - name: "approved_onboarding_requests"
      expr: COUNT(CASE WHEN onboarding_status = 'approved' THEN onboarding_request_id END)
      comment: "Number of onboarding requests that have been approved. Measures the throughput of the vendor qualification process."
    - name: "rejected_onboarding_requests"
      expr: COUNT(CASE WHEN onboarding_status = 'rejected' THEN onboarding_request_id END)
      comment: "Number of onboarding requests rejected. Tracks the rejection rate to assess qualification standards and sourcing pipeline quality."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score for onboarding applicants. Benchmarks the risk profile of the incoming supplier base for procurement risk management."
    - name: "high_risk_onboarding_requests"
      expr: COUNT(CASE WHEN risk_tier IN ('high', 'critical') THEN onboarding_request_id END)
      comment: "Number of onboarding requests classified as high or critical risk. Flags applicants requiring enhanced due diligence before approval."
    - name: "edi_ready_applicants"
      expr: COUNT(CASE WHEN edi_capable_flag = TRUE AND edi_setup_completed_flag = TRUE THEN onboarding_request_id END)
      comment: "Number of onboarding applicants with EDI capability confirmed and setup completed. Measures digital readiness of the incoming supplier base."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_edi_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EDI transaction processing metrics tracking transmission volumes, error rates, acknowledgment compliance, and chargeback exposure to manage electronic supply chain communication quality."
  source: "`vibe_retail_v1`.`supplier`.`supplier_edi_transaction`"
  dimensions:
    - name: "processing_status"
      expr: processing_status
      comment: "Current processing status of the EDI transaction (e.g., received, processed, failed, pending), used to track transaction pipeline health."
    - name: "transaction_set_type"
      expr: transaction_set_type
      comment: "EDI transaction set type (e.g., 850 purchase order, 856 ASN, 810 invoice), enabling analysis of transaction volumes and error rates by document type."
    - name: "direction"
      expr: direction
      comment: "Direction of the EDI transaction (inbound or outbound), used to segment transmission performance by flow direction."
    - name: "functional_acknowledgment_status"
      expr: functional_acknowledgment_status
      comment: "Status of the functional acknowledgment (e.g., accepted, rejected, pending), critical for EDI compliance monitoring."
    - name: "chargeback_eligible"
      expr: chargeback_eligible
      comment: "Indicates whether the transaction is eligible for a chargeback due to non-compliance, used to quantify financial risk of EDI failures."
    - name: "test_indicator"
      expr: test_indicator
      comment: "Indicates whether the transaction is a test transmission, used to exclude test data from production performance metrics."
    - name: "transmission_month"
      expr: DATE_TRUNC('month', transmission_timestamp)
      comment: "Month of the EDI transmission, enabling trend analysis of transaction volumes and error rates over time."
  measures:
    - name: "total_edi_transactions"
      expr: COUNT(CASE WHEN test_indicator = FALSE OR test_indicator IS NULL THEN supplier_edi_transaction_id END)
      comment: "Total number of production EDI transactions. Tracks the volume of electronic supply chain communications for capacity and compliance analysis."
    - name: "failed_edi_transactions"
      expr: COUNT(CASE WHEN processing_status = 'failed' AND (test_indicator = FALSE OR test_indicator IS NULL) THEN supplier_edi_transaction_id END)
      comment: "Number of failed EDI transactions. Failed transactions cause supply chain delays and potential chargebacks; a key operational reliability metric."
    - name: "chargeback_eligible_transactions"
      expr: COUNT(CASE WHEN chargeback_eligible = TRUE AND (test_indicator = FALSE OR test_indicator IS NULL) THEN supplier_edi_transaction_id END)
      comment: "Number of EDI transactions eligible for chargeback due to non-compliance. Quantifies the volume of transactions generating financial penalty exposure."
    - name: "total_chargeback_amount"
      expr: SUM(CASE WHEN test_indicator = FALSE OR test_indicator IS NULL THEN chargeback_amount ELSE 0 END)
      comment: "Total chargeback amount associated with non-compliant EDI transactions. Measures the financial cost of EDI failures to the organization."
    - name: "avg_file_size_bytes"
      expr: AVG(CAST(file_size_bytes AS DOUBLE))
      comment: "Average EDI file size in bytes. Used to monitor transmission payload trends and identify anomalous transaction sizes that may indicate data quality issues."
    - name: "unacknowledged_transactions"
      expr: COUNT(CASE WHEN functional_acknowledgment_status NOT IN ('accepted', 'acknowledged') AND (test_indicator = FALSE OR test_indicator IS NULL) THEN supplier_edi_transaction_id END)
      comment: "Number of transactions without a valid functional acknowledgment. Unacknowledged transactions represent unconfirmed supply chain communications requiring follow-up."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract management metrics tracking contract value, terms, compliance features, and renewal status for procurement governance"
  source: "`vibe_retail_v1`.`supplier`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of contract (active, expired, pending, terminated)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (master, spot, blanket, framework)"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms negotiated in contract"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method specified in contract (ACH, wire, check, card)"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms defining delivery responsibility"
    - name: "contract_currency_code"
      expr: contract_currency_code
      comment: "Currency for contract financial terms"
    - name: "auto_renewal"
      expr: CASE WHEN auto_renewal_flag = TRUE THEN 'Auto-Renew' ELSE 'Manual Renewal' END
      comment: "Whether contract automatically renews"
    - name: "exclusivity"
      expr: CASE WHEN exclusivity_flag = TRUE THEN 'Exclusive' ELSE 'Non-Exclusive' END
      comment: "Whether contract grants exclusivity to vendor"
    - name: "edi_enabled"
      expr: CASE WHEN edi_enabled_flag = TRUE THEN 'EDI' ELSE 'Manual' END
      comment: "Whether contract includes EDI transaction capability"
    - name: "vmi_enabled"
      expr: CASE WHEN vmi_enabled_flag = TRUE THEN 'VMI' ELSE 'Standard' END
      comment: "Whether contract includes vendor-managed inventory terms"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year contract became effective"
    - name: "expiry_year"
      expr: YEAR(effective_end_date)
      comment: "Year contract expires"
    - name: "signature_year"
      expr: YEAR(signature_date)
      comment: "Year contract was signed"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT vendor_contract_id)
      comment: "Total count of vendor contracts for portfolio management"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total committed contract value across vendor portfolio"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average contract value for spend concentration analysis"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage negotiated across contracts"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time days specified in contracts"
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across contracts"
    - name: "avg_renewal_term_months"
      expr: AVG(CAST(renewal_term_months AS DOUBLE))
      comment: "Average renewal term length in months"
    - name: "avg_termination_notice_days"
      expr: AVG(CAST(termination_notice_days AS DOUBLE))
      comment: "Average termination notice period in days"
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN vendor_contract_id END)
      comment: "Count of active contracts for current portfolio size"
    - name: "auto_renewal_contract_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN vendor_contract_id END)
      comment: "Count of contracts with auto-renewal for renewal planning"
    - name: "edi_enabled_contract_count"
      expr: COUNT(DISTINCT CASE WHEN edi_enabled_flag = TRUE THEN vendor_contract_id END)
      comment: "Count of EDI-enabled contracts for automation coverage"
    - name: "vmi_enabled_contract_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN vendor_contract_id END)
      comment: "Count of VMI-enabled contracts for inventory optimization"
    - name: "exclusive_contract_count"
      expr: COUNT(DISTINCT CASE WHEN exclusivity_flag = TRUE THEN vendor_contract_id END)
      comment: "Count of exclusive contracts for sourcing risk assessment"
$$;