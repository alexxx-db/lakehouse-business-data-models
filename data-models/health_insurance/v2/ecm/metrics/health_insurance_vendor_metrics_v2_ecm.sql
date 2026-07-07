-- Metric views for domain: vendor | Business: Health Insurance | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_baa_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business Associate Agreement (BAA) compliance metrics tracking execution status, breach notification obligations, and review currency. Used by Privacy, Compliance, and Legal leadership to manage HIPAA BAA obligations across the vendor portfolio."
  source: "`vibe_health_insurance_v1`.`vendor`.`baa_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of BAA agreement (e.g., standard, custom, subcontractor) for compliance program segmentation."
    - name: "baa_agreement_status"
      expr: baa_agreement_status
      comment: "Current status of the BAA (active, expired, terminated, pending) for compliance tracking."
    - name: "compliance_certification_status"
      expr: compliance_certification_status
      comment: "Compliance certification status of the BAA for regulatory readiness reporting."
    - name: "breach_notification_obligation"
      expr: breach_notification_obligation
      comment: "Whether the BAA includes breach notification obligations, for HIPAA compliance program management."
    - name: "is_active"
      expr: is_active
      comment: "Whether the BAA record is currently active."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Year the BAA became effective for vintage and renewal cycle analysis."
  measures:
    - name: "total_baa_agreements"
      expr: COUNT(DISTINCT baa_agreement_id)
      comment: "Total number of BAA agreements in the portfolio. Baseline for HIPAA BAA compliance program scope."
    - name: "active_baa_agreements"
      expr: COUNT(DISTINCT CASE WHEN baa_agreement_status = 'Active' AND is_active = TRUE THEN baa_agreement_id END)
      comment: "Number of currently active BAA agreements. Core HIPAA compliance metric — all PHI-handling vendors must have active BAAs."
    - name: "expired_baa_agreements"
      expr: COUNT(DISTINCT CASE WHEN effective_until < CURRENT_DATE OR baa_agreement_status = 'Expired' THEN baa_agreement_id END)
      comment: "Number of expired BAA agreements. Critical HIPAA compliance risk — expired BAAs create regulatory exposure."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across BAA agreements. Measures PHI-handling risk profile of the vendor portfolio."
    - name: "baa_with_breach_obligation"
      expr: COUNT(DISTINCT CASE WHEN breach_notification_obligation = TRUE THEN baa_agreement_id END)
      comment: "Number of BAAs with explicit breach notification obligations. Tracks HIPAA breach notification coverage across vendor agreements."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor incident and breach metrics tracking PHI exposure, regulatory notification compliance, and incident resolution. Used by Compliance, Privacy, and Risk leadership to manage HIPAA breach obligations and vendor security incidents."
  source: "`vibe_health_insurance_v1`.`vendor`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of incident (e.g., data breach, service outage, compliance violation) for incident categorization."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, under investigation, resolved, closed)."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the incident (critical, high, medium, low) for triage and escalation."
    - name: "is_phi_involved"
      expr: is_phi_involved
      comment: "Whether PHI was involved in the incident. Triggers HIPAA breach notification obligations."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required, for compliance deadline tracking."
    - name: "breach_notification_sent"
      expr: breach_notification_sent
      comment: "Whether breach notification has been sent, for HIPAA compliance status tracking."
    - name: "incident_date"
      expr: DATE_TRUNC('month', incident_date)
      comment: "Month the incident occurred for trend analysis of incident frequency."
  measures:
    - name: "total_incidents"
      expr: COUNT(DISTINCT incident_id)
      comment: "Total number of vendor incidents recorded. Baseline for vendor security and compliance incident program."
    - name: "phi_incidents"
      expr: COUNT(DISTINCT CASE WHEN is_phi_involved = TRUE THEN incident_id END)
      comment: "Number of incidents involving PHI. Critical HIPAA compliance metric requiring executive and regulatory attention."
    - name: "total_affected_members"
      expr: SUM(CAST(affected_member_count AS DOUBLE))
      comment: "Total number of members affected across all vendor incidents. Measures breach impact scope for regulatory reporting."
    - name: "open_incidents"
      expr: COUNT(DISTINCT CASE WHEN incident_status NOT IN ('Resolved', 'Closed') THEN incident_id END)
      comment: "Number of currently open incidents. Operational metric for incident response backlog management."
    - name: "notification_overdue_incidents"
      expr: COUNT(DISTINCT CASE WHEN regulatory_notification_required = TRUE AND breach_notification_sent = FALSE AND incident_status NOT IN ('Closed') THEN incident_id END)
      comment: "Incidents requiring regulatory notification where notification has not yet been sent. Critical HIPAA compliance risk metric."
    - name: "critical_incidents"
      expr: COUNT(DISTINCT CASE WHEN severity_level IN ('Critical', 'High') THEN incident_id END)
      comment: "Number of high or critical severity incidents. Drives executive escalation and emergency response resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor invoice processing metrics covering payment cycle efficiency, dispute rates, discount capture, and compliance. Used by Finance and Accounts Payable leadership to manage cash flow, payment terms compliance, and invoice processing quality."
  source: "`vibe_health_insurance_v1`.`vendor`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (pending, approved, paid, disputed) for AP pipeline management."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (paid, outstanding, overdue) for cash flow management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for invoice authorization tracking."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice is under dispute, for dispute resolution pipeline tracking."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the invoice is tax-exempt, for tax reporting and compliance."
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category of the invoice for cost allocation and budget variance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP reporting."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month the invoice was issued for monthly AP volume and aging analysis."
  measures:
    - name: "total_invoices"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Total number of vendor invoices. Baseline for AP processing volume and capacity planning."
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all vendor invoices. Primary AP financial exposure metric for cash flow management."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Reflects actual payment obligation to vendors."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment and negotiated discounts captured. Measures AP efficiency and working capital optimization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on vendor invoices. Required for tax liability reporting and financial close."
    - name: "disputed_invoices"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN invoice_id END)
      comment: "Number of invoices under dispute. Measures invoice quality and vendor billing accuracy."
    - name: "disputed_invoice_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of disputed invoices. Financial risk metric for AP dispute resolution prioritization."
    - name: "early_payment_discount_amount"
      expr: SUM(CAST(early_payment_discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimization through early payment programs."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor onboarding pipeline metrics tracking completion rates, checklist compliance, and onboarding cost. Used by Procurement and Compliance leadership to manage vendor intake quality, speed, and regulatory readiness."
  source: "`vibe_health_insurance_v1`.`vendor`.`onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current stage of the onboarding process (pending, in-progress, completed, rejected)."
    - name: "stage"
      expr: stage
      comment: "Specific onboarding stage for funnel analysis and bottleneck identification."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the onboarding process (approved, rejected, withdrawn) for conversion analysis."
    - name: "requestor_department"
      expr: requestor_department
      comment: "Department requesting vendor onboarding for demand analysis and resource allocation."
    - name: "compliance_certification_status"
      expr: compliance_certification_status
      comment: "Compliance certification status at time of onboarding for regulatory readiness tracking."
    - name: "request_date"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month the onboarding request was submitted for pipeline volume trend analysis."
  measures:
    - name: "total_onboarding_requests"
      expr: COUNT(DISTINCT onboarding_id)
      comment: "Total vendor onboarding requests initiated. Baseline for procurement pipeline volume."
    - name: "completed_onboardings"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Completed' THEN onboarding_id END)
      comment: "Number of successfully completed onboardings. Measures onboarding program throughput."
    - name: "total_onboarding_cost"
      expr: SUM(CAST(total_onboarding_cost AS DOUBLE))
      comment: "Total cost incurred for vendor onboarding activities. Financial metric for procurement operations budgeting."
    - name: "avg_onboarding_cost"
      expr: AVG(CAST(total_onboarding_cost AS DOUBLE))
      comment: "Average cost per vendor onboarding. Benchmarks onboarding efficiency and informs process improvement investments."
    - name: "baa_executed_rate"
      expr: COUNT(DISTINCT CASE WHEN checklist_baa_executed = TRUE THEN onboarding_id END)
      comment: "Number of onboardings with BAA executed. HIPAA compliance metric — BAA execution is mandatory for PHI-handling vendors."
    - name: "insurance_verified_rate"
      expr: COUNT(DISTINCT CASE WHEN checklist_insurance_verified = TRUE THEN onboarding_id END)
      comment: "Number of onboardings with insurance verification completed. Risk management metric for vendor coverage compliance."
    - name: "security_questionnaire_completed"
      expr: COUNT(DISTINCT CASE WHEN checklist_security_questionnaire = TRUE THEN onboarding_id END)
      comment: "Number of onboardings with security questionnaire completed. Cybersecurity risk management metric for vendor intake."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score at onboarding. Measures the risk profile of vendors entering the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard metrics tracking SLA compliance, quality, delivery, and financial stability. Used by Vendor Management and Operations leadership to identify underperforming vendors and drive improvement actions."
  source: "`vibe_health_insurance_v1`.`vendor`.`performance`"
  dimensions:
    - name: "evaluation_period"
      expr: evaluation_period
      comment: "The evaluation period label (e.g., Q1 2024) for trend analysis across performance cycles."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the performance evaluation (completed, in-progress, pending) for pipeline tracking."
    - name: "tier_decision"
      expr: tier_decision
      comment: "Tier assignment resulting from the evaluation, used to segment vendors by performance tier."
    - name: "is_active"
      expr: is_active
      comment: "Whether the performance record is currently active."
    - name: "evaluation_start_date"
      expr: DATE_TRUNC('quarter', evaluation_start_date)
      comment: "Quarter the evaluation period started, for quarterly performance trend analysis."
  measures:
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall vendor performance score across evaluations. Primary KPI for vendor scorecard reporting."
    - name: "avg_sla_compliance_rate"
      expr: AVG(CAST(sla_compliance_rate AS DOUBLE))
      comment: "Average SLA compliance rate across vendors. Directly measures contractual obligation fulfillment."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate. Operational efficiency metric for supply chain and service delivery."
    - name: "avg_quality_defect_rate"
      expr: AVG(CAST(quality_defect_rate AS DOUBLE))
      comment: "Average quality defect rate across vendor evaluations. Drives quality improvement interventions."
    - name: "avg_customer_satisfaction_rating"
      expr: AVG(CAST(customer_satisfaction_rating AS DOUBLE))
      comment: "Average customer satisfaction rating from vendor evaluations. Reflects end-user experience with vendor services."
    - name: "avg_issue_resolution_time_days"
      expr: AVG(CAST(issue_resolution_time_days AS DOUBLE))
      comment: "Average days to resolve vendor issues. Operational responsiveness metric used to manage SLA breach risk."
    - name: "avg_financial_stability_rating"
      expr: AVG(CAST(financial_stability_rating AS DOUBLE))
      comment: "Average financial stability rating. Informs vendor concentration risk and business continuity planning."
    - name: "total_evaluations"
      expr: COUNT(DISTINCT performance_id)
      comment: "Total number of vendor performance evaluations completed. Tracks evaluation program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order analytics tracking procurement volume, approval efficiency, payment status, and three-way match compliance. Critical for procurement process optimization and spend control."
  source: "`vibe_health_insurance_v1`.`vendor`.`purchase_order`"
  dimensions:
    - name: "purchase_order_status"
      expr: purchase_order_status
      comment: "Current PO status (draft, approved, issued, received, closed) for procurement workflow tracking"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, contract, etc.) for procurement strategy analysis"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for accounts payable and cash flow management"
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category for spend classification and category management"
    - name: "is_three_way_match_enabled"
      expr: is_three_way_match_enabled
      comment: "Indicates if three-way match is enabled - procurement control indicator"
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department requesting the purchase for departmental spend tracking"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for budget accountability and financial reporting"
    - name: "currency_code"
      expr: currency_code
      comment: "PO currency for foreign exchange exposure analysis"
    - name: "order_year"
      expr: YEAR(order_timestamp)
      comment: "Year of PO creation for annual procurement trending"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_timestamp)
      comment: "Month of PO creation for monthly procurement volume tracking"
  measures:
    - name: "total_po_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total purchase order amount - primary procurement spend commitment metric"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net PO amount after discounts - actual procurement cost metric"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured - procurement negotiation savings"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on purchase orders - tax liability tracking"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid against purchase orders - actual cash outflow metric"
    - name: "avg_po_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order amount - typical PO size for procurement process design"
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders - procurement transaction volume"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with POs - active vendor relationship count"
    - name: "three_way_match_po_count"
      expr: SUM(CASE WHEN is_three_way_match_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Number of POs with three-way match enabled - procurement control coverage"
    - name: "avg_approval_cycle_days"
      expr: AVG(CAST(DATEDIFF(approval_date, order_timestamp) AS DOUBLE))
      comment: "Average days from PO creation to approval - procurement approval efficiency metric"
    - name: "avg_payment_cycle_days"
      expr: AVG(CAST(DATEDIFF(payment_date, order_timestamp) AS DOUBLE))
      comment: "Average days from PO creation to payment - procurement-to-pay cycle time"
    - name: "avg_delivery_cycle_days"
      expr: AVG(CAST(DATEDIFF(receipt_received_date, order_timestamp) AS DOUBLE))
      comment: "Average days from PO creation to receipt - procurement lead time metric"
    - name: "three_way_match_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_three_way_match_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs with three-way match enabled - procurement control effectiveness"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of PO value captured as discounts - procurement negotiation effectiveness"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_rfp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP (Request for Proposal) analytics tracking solicitation volumes, award amounts, competitive participation, and procurement cycle management for strategic sourcing in health insurance."
  source: "`vibe_health_insurance_v1`.`vendor`.`rfp`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Current RFP status (draft, issued, evaluation, awarded, cancelled) for pipeline management"
    - name: "award_status"
      expr: award_status
      comment: "Award status for procurement outcome tracking"
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (RFP, RFI, RFQ) for procurement method analysis"
    - name: "spend_category"
      expr: spend_category
      comment: "Spend category for strategic sourcing alignment"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for governance and authorization tracking"
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month RFP was issued for procurement activity trending"
  measures:
    - name: "rfp_count"
      expr: COUNT(1)
      comment: "Total RFPs issued for procurement activity and strategic sourcing volume"
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of RFPs — measures procurement pipeline value"
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total awarded amounts — measures actual procurement commitment from competitive sourcing"
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated RFP value for procurement sizing and resource planning"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of RFPs for procurement risk management"
    - name: "awarded_rfp_count"
      expr: SUM(CASE WHEN award_status = 'awarded' THEN 1 ELSE 0 END)
      comment: "Count of awarded RFPs for procurement conversion and cycle time analysis"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor risk assessment analytics tracking cybersecurity, financial stability, regulatory compliance, and overall vendor risk profile. Critical for third-party risk management and business continuity planning."
  source: "`vibe_health_insurance_v1`.`vendor`.`risk_assessment`"
  dimensions:
    - name: "risk_assessment_status"
      expr: risk_assessment_status
      comment: "Status of risk assessment (completed, in-progress, overdue) for risk management cycle tracking"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (initial, annual, event-driven, etc.) for risk program management"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Vendor risk tier (high, medium, low) for risk-based vendor management"
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating before controls - baseline risk exposure"
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls - actual risk exposure"
    - name: "risk_domain"
      expr: risk_domain
      comment: "Risk domain (cybersecurity, financial, operational, etc.) for risk category analysis"
    - name: "control_effectiveness_rating"
      expr: control_effectiveness_rating
      comment: "Effectiveness of risk controls - risk mitigation quality indicator"
    - name: "concentration_risk_flag"
      expr: concentration_risk_flag
      comment: "Indicates vendor concentration risk - single-source dependency indicator"
    - name: "reputational_risk_flag"
      expr: reputational_risk_flag
      comment: "Indicates reputational risk exposure - brand and reputation impact indicator"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Regulatory compliance status - compliance risk indicator"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of risk assessment for annual risk trending"
    - name: "assessment_quarter"
      expr: DATE_TRUNC('QUARTER', assessment_date)
      comment: "Quarter of risk assessment for quarterly risk monitoring"
  measures:
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average overall vendor risk score - primary third-party risk KPI for portfolio risk management"
    - name: "avg_residual_risk_score"
      expr: AVG(CAST(overall_residual_score AS DOUBLE))
      comment: "Average residual risk score after controls - actual risk exposure metric"
    - name: "avg_cybersecurity_score"
      expr: AVG(CAST(cybersecurity_score AS DOUBLE))
      comment: "Average cybersecurity risk score - information security risk metric"
    - name: "avg_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score - vendor business continuity risk metric"
    - name: "avg_regulatory_compliance_score"
      expr: AVG(CAST(regulatory_compliance_score AS DOUBLE))
      comment: "Average regulatory compliance score - compliance risk metric"
    - name: "avg_business_continuity_score"
      expr: AVG(CAST(business_continuity_score AS DOUBLE))
      comment: "Average business continuity score - operational resilience risk metric"
    - name: "assessment_count"
      expr: COUNT(1)
      comment: "Total number of risk assessments - risk management activity volume"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors assessed - risk assessment coverage metric"
    - name: "high_risk_vendor_count"
      expr: SUM(CASE WHEN risk_tier = 'high' THEN 1 ELSE 0 END)
      comment: "Number of high-risk vendors - critical risk exposure requiring mitigation"
    - name: "concentration_risk_vendor_count"
      expr: SUM(CASE WHEN concentration_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of vendors with concentration risk - single-source dependency exposure"
    - name: "reputational_risk_vendor_count"
      expr: SUM(CASE WHEN reputational_risk_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of vendors with reputational risk - brand and reputation exposure"
    - name: "non_compliant_vendor_count"
      expr: SUM(CASE WHEN regulatory_compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Number of vendors with regulatory compliance issues - compliance risk exposure"
    - name: "high_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_tier = 'high' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors rated as high risk - portfolio risk concentration indicator"
    - name: "concentration_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN concentration_risk_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors with concentration risk - single-source dependency rate"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors meeting regulatory compliance - compliance risk health metric"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor risk assessment metrics covering overall residual risk, cybersecurity posture, financial stability, and regulatory compliance scores. Used by Risk Management and Procurement leadership to prioritize vendor oversight and mitigation investments."
  source: "`vibe_health_insurance_v1`.`vendor`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g., initial, annual, triggered) for assessment program tracking."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned to the vendor (e.g., Critical, High, Medium, Low) for prioritized oversight."
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating before controls, for baseline risk exposure analysis."
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls, for net risk posture reporting."
    - name: "risk_domain"
      expr: risk_domain
      comment: "Domain of risk assessed (e.g., cybersecurity, financial, operational) for domain-specific risk reporting."
    - name: "risk_assessment_status"
      expr: risk_assessment_status
      comment: "Current status of the risk assessment (completed, in-progress, overdue)."
    - name: "concentration_risk_flag"
      expr: concentration_risk_flag
      comment: "Flags vendors with concentration risk (single-source dependency) for strategic sourcing decisions."
    - name: "reputational_risk_flag"
      expr: reputational_risk_flag
      comment: "Flags vendors with identified reputational risk for executive escalation."
    - name: "assessment_date"
      expr: DATE_TRUNC('quarter', assessment_date)
      comment: "Quarter the assessment was conducted for trend analysis of risk posture over time."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(DISTINCT risk_assessment_id)
      comment: "Total number of vendor risk assessments completed. Tracks coverage of the risk assessment program."
    - name: "avg_overall_residual_risk_score"
      expr: AVG(CAST(overall_residual_score AS DOUBLE))
      comment: "Average residual risk score across all vendor assessments. Primary KPI for enterprise vendor risk posture."
    - name: "avg_cybersecurity_score"
      expr: AVG(CAST(cybersecurity_score AS DOUBLE))
      comment: "Average cybersecurity risk score. Critical for HIPAA security rule compliance and PHI protection oversight."
    - name: "avg_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score. Informs vendor viability risk and business continuity planning."
    - name: "avg_regulatory_compliance_score"
      expr: AVG(CAST(regulatory_compliance_score AS DOUBLE))
      comment: "Average regulatory compliance score across vendor assessments. Drives compliance remediation prioritization."
    - name: "avg_business_continuity_score"
      expr: AVG(CAST(business_continuity_score AS DOUBLE))
      comment: "Average business continuity score. Measures vendor resilience for critical service continuity planning."
    - name: "high_risk_vendors"
      expr: COUNT(DISTINCT CASE WHEN risk_tier IN ('Critical', 'High') THEN vendor_id END)
      comment: "Number of vendors classified as high or critical risk. Drives enhanced oversight and mitigation resource allocation."
    - name: "concentration_risk_vendors"
      expr: COUNT(DISTINCT CASE WHEN concentration_risk_flag = TRUE THEN vendor_id END)
      comment: "Number of vendors with concentration risk flags. Strategic sourcing metric for single-source dependency reduction."
    - name: "overdue_assessments"
      expr: COUNT(DISTINCT CASE WHEN next_assessment_due_date < CURRENT_DATE AND risk_assessment_status NOT IN ('Completed') THEN risk_assessment_id END)
      comment: "Risk assessments past their due date. Compliance and governance metric for assessment program timeliness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor SLA performance tracking measuring service level breaches, penalty triggers, and resolution effectiveness. Drives vendor accountability and contract enforcement."
  source: "`vibe_health_insurance_v1`.`vendor`.`sla_event`"
  dimensions:
    - name: "sla_status"
      expr: sla_status
      comment: "SLA event status (met, breached, pending) for service level tracking"
    - name: "sla_metric_name"
      expr: sla_metric_name
      comment: "Name of SLA metric being measured for metric-specific analysis"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of SLA breach (critical, major, minor) for prioritization"
    - name: "penalty_triggered"
      expr: penalty_triggered
      comment: "Indicates if SLA breach triggered contractual penalty"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of breach resolution for remediation tracking"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure SLA for methodology consistency"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year of SLA event for annual trending"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of SLA event for monthly performance tracking"
  measures:
    - name: "sla_event_count"
      expr: COUNT(1)
      comment: "Total number of SLA events - service level monitoring activity volume"
    - name: "breach_count"
      expr: SUM(CASE WHEN sla_status = 'breached' THEN 1 ELSE 0 END)
      comment: "Number of SLA breaches - service level failure count"
    - name: "penalty_triggered_count"
      expr: SUM(CASE WHEN penalty_triggered = TRUE THEN 1 ELSE 0 END)
      comment: "Number of breaches triggering penalties - financial impact event count"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed - financial impact of SLA breaches"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per breach - typical financial impact of service failures"
    - name: "avg_variance"
      expr: AVG(CAST(variance AS DOUBLE))
      comment: "Average variance from SLA target - typical service level deviation"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual performance value - typical service level achieved"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target performance value - typical service level commitment"
    - name: "distinct_contract_count"
      expr: COUNT(DISTINCT vendor_contract_id)
      comment: "Number of unique contracts with SLA events - contract coverage metric"
    - name: "avg_resolution_days"
      expr: AVG(CAST(DATEDIFF(resolution_date, event_timestamp) AS DOUBLE))
      comment: "Average days to resolve SLA breach - vendor responsiveness metric"
    - name: "breach_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_status = 'breached' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLA events that are breaches - service level failure rate"
    - name: "penalty_trigger_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN penalty_triggered = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN sla_status = 'breached' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of breaches triggering penalties - financial consequence rate"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_status = 'met' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLA events meeting target - overall service level compliance"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_sla_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA breach and compliance event metrics tracking penalty exposure, breach severity, and resolution performance. Used by Vendor Management and Legal to manage contractual SLA enforcement and financial recovery."
  source: "`vibe_health_insurance_v1`.`vendor`.`sla_event`"
  dimensions:
    - name: "sla_metric_name"
      expr: sla_metric_name
      comment: "Name of the SLA metric being measured (e.g., response time, uptime) for granular breach analysis."
    - name: "sla_status"
      expr: sla_status
      comment: "Current status of the SLA event (breach, at-risk, compliant) for triage and escalation."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of the SLA breach (critical, major, minor) for prioritization."
    - name: "penalty_triggered"
      expr: penalty_triggered
      comment: "Whether a financial penalty was triggered by this SLA event. Drives financial recovery tracking."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the SLA event (resolved, open, escalated)."
    - name: "event_timestamp"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month the SLA event occurred, for trend analysis of breach frequency over time."
  measures:
    - name: "total_sla_events"
      expr: COUNT(DISTINCT sla_event_id)
      comment: "Total number of SLA events recorded. Baseline for SLA monitoring program scope."
    - name: "total_sla_breaches"
      expr: COUNT(DISTINCT CASE WHEN sla_status = 'Breach' OR penalty_triggered = TRUE THEN sla_event_id END)
      comment: "Total SLA breach events. Primary metric for contractual compliance enforcement."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties triggered by SLA breaches. Measures financial recovery and vendor accountability."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per SLA breach event. Benchmarks penalty severity and contract enforcement effectiveness."
    - name: "avg_sla_variance"
      expr: AVG(CAST(variance AS DOUBLE))
      comment: "Average variance between actual and target SLA values. Quantifies the magnitude of SLA underperformance."
    - name: "open_sla_breaches"
      expr: COUNT(DISTINCT CASE WHEN resolution_status NOT IN ('Resolved', 'Closed') AND (sla_status = 'Breach' OR penalty_triggered = TRUE) THEN sla_event_id END)
      comment: "Unresolved SLA breach events. Operational metric for breach remediation backlog management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor spend analytics covering total expenditure, budget adherence, category distribution, and payment efficiency. Used by Finance and Procurement leadership for cost management, budget variance analysis, and spend optimization."
  source: "`vibe_health_insurance_v1`.`vendor`.`spend`"
  dimensions:
    - name: "spend_category"
      expr: spend_category
      comment: "Spend category classification for cost allocation and category management analysis."
    - name: "expense_type"
      expr: expense_type
      comment: "Type of expense (e.g., capital, operational) for financial reporting segmentation."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the spend transaction for annual budget vs. actual analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the spend transaction for quarterly financial reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the spend transaction for multi-currency portfolio analysis."
    - name: "spend_status"
      expr: spend_status
      comment: "Approval and processing status of the spend record (approved, pending, rejected)."
    - name: "is_approved"
      expr: is_approved
      comment: "Whether the spend has been formally approved, for compliance and audit reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., ACH, check, wire) for payment operations analysis."
    - name: "transaction_date"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of the spend transaction for monthly spend trend analysis."
  measures:
    - name: "total_spend_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total vendor spend in USD. Primary financial metric for procurement cost management and budget reporting."
    - name: "total_gross_spend"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross spend before discounts and taxes. Used for gross expenditure reporting."
    - name: "total_net_spend"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net spend after discounts. Reflects actual cost to the organization."
    - name: "total_discount_captured"
      expr: SUM(CAST(amount_discount AS DOUBLE))
      comment: "Total discount amounts captured across vendor spend. Measures procurement negotiation effectiveness."
    - name: "total_tax_amount"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax amounts on vendor spend. Required for tax reporting and financial close."
    - name: "avg_spend_per_transaction"
      expr: AVG(CAST(amount_usd AS DOUBLE))
      comment: "Average spend per transaction in USD. Benchmarks transaction size for procurement efficiency analysis."
    - name: "unapproved_spend_amount"
      expr: SUM(CASE WHEN is_approved = FALSE OR is_approved IS NULL THEN CAST(amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total spend not yet formally approved. Compliance and controls metric for spend authorization governance."
    - name: "compliance_flagged_spend"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN CAST(amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total spend flagged for compliance review. Risk management metric for procurement audit and controls."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vendor master metrics tracking portfolio health, risk concentration, diversity, and compliance status across the vendor base. Used by Procurement and Vendor Management leadership to steer sourcing strategy and risk posture."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor`"
  dimensions:
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classifies vendors by type (e.g., IT, clinical, administrative) for segmented portfolio analysis."
    - name: "vendor_tier"
      expr: tier
      comment: "Vendor tier designation (e.g., Tier 1, Tier 2) indicating strategic importance and oversight level."
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current operational status of the vendor (active, suspended, terminated)."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Vendor-level compliance certification status for regulatory and contractual obligations."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding stage of the vendor, used to track pipeline of new vendors entering the network."
    - name: "incorporation_state"
      expr: incorporation_state
      comment: "State of incorporation for geographic and regulatory segmentation."
    - name: "small_business_flag"
      expr: small_business_flag
      comment: "Indicates whether the vendor qualifies as a small business for diversity spend reporting."
    - name: "minority_owned_flag"
      expr: minority_owned_flag
      comment: "Indicates minority-owned business status for supplier diversity tracking."
    - name: "women_owned_flag"
      expr: women_owned_flag
      comment: "Indicates women-owned business status for supplier diversity tracking."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the vendor record is currently active."
  measures:
    - name: "total_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Total number of distinct vendors in the portfolio. Baseline KPI for portfolio size management."
    - name: "active_vendors"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN vendor_id END)
      comment: "Count of currently active vendors. Tracks the live vendor base available for procurement."
    - name: "compliant_vendors"
      expr: COUNT(DISTINCT CASE WHEN compliance_status = 'Compliant' THEN vendor_id END)
      comment: "Number of vendors with a compliant certification status. Drives regulatory risk posture reporting."
    - name: "non_compliant_vendors"
      expr: COUNT(DISTINCT CASE WHEN compliance_status NOT IN ('Compliant') AND compliance_status IS NOT NULL THEN vendor_id END)
      comment: "Number of vendors with non-compliant status. Triggers remediation and escalation workflows."
    - name: "diverse_vendors"
      expr: COUNT(DISTINCT CASE WHEN minority_owned_flag = TRUE OR women_owned_flag = TRUE OR small_business_flag = TRUE THEN vendor_id END)
      comment: "Count of vendors qualifying under at least one diversity category. Supports supplier diversity program reporting."
    - name: "vendors_pending_onboarding"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status NOT IN ('Completed', 'Active') AND onboarding_status IS NOT NULL THEN vendor_id END)
      comment: "Vendors currently in an incomplete onboarding state. Operational metric for procurement pipeline management."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor audit metrics covering audit completion rates, findings severity, corrective action status, and audit cost. Used by Compliance and Internal Audit leadership to manage vendor oversight program effectiveness."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (e.g., compliance, financial, operational) for audit program segmentation."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (in-progress, completed, overdue) for pipeline management."
    - name: "auditor_type"
      expr: auditor_type
      comment: "Whether the auditor is internal or external, for audit resource and independence tracking."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Regulatory or compliance framework under which the audit was conducted (e.g., HIPAA, SOC2)."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall audit rating (e.g., satisfactory, needs improvement, unsatisfactory) for vendor risk classification."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required as a result of the audit."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body associated with the audit for regulatory reporting segmentation."
    - name: "audit_start_date"
      expr: DATE_TRUNC('quarter', audit_start_date)
      comment: "Quarter the audit started for trend analysis of audit program activity."
  measures:
    - name: "total_audits"
      expr: COUNT(DISTINCT vendor_audit_id)
      comment: "Total number of vendor audits conducted. Baseline for audit program coverage and capacity planning."
    - name: "completed_audits"
      expr: COUNT(DISTINCT CASE WHEN audit_status = 'Completed' THEN vendor_audit_id END)
      comment: "Number of completed vendor audits. Measures audit program throughput and completion rate."
    - name: "audits_requiring_corrective_action"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN vendor_audit_id END)
      comment: "Audits that identified issues requiring corrective action. Drives remediation program prioritization."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of vendor audits. Financial metric for audit program budget management."
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per vendor audit. Benchmarks audit efficiency and informs outsourcing vs. insourcing decisions."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk score from vendor audits. Tracks aggregate vendor risk level identified through audit activity."
    - name: "overdue_corrective_actions"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE AND corrective_action_due_date < CURRENT_DATE AND audit_status NOT IN ('Closed', 'Completed') THEN vendor_audit_id END)
      comment: "Audits with overdue corrective actions. Critical compliance metric for regulatory and board reporting."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor certification compliance metrics tracking certification coverage, expiration risk, and renewal pipeline. Used by Compliance and Procurement leadership to ensure vendors maintain required certifications for regulatory and contractual compliance."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., HIPAA, ISO 27001, SOC2) for compliance program segmentation."
    - name: "vendor_certification_status"
      expr: vendor_certification_status
      comment: "Current status of the certification (active, expired, pending renewal) for compliance tracking."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification for regulatory authority tracking."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category the certification satisfies for regulatory obligation mapping."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction under which the certification applies for geographic compliance reporting."
    - name: "expiration_notice_sent"
      expr: expiration_notice_sent
      comment: "Whether expiration notice has been sent to the vendor for renewal pipeline management."
    - name: "expiration_date"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the certification expires for renewal pipeline forecasting."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT vendor_certification_id)
      comment: "Total number of vendor certifications tracked. Baseline for certification compliance program coverage."
    - name: "active_certifications"
      expr: COUNT(DISTINCT CASE WHEN vendor_certification_status = 'Active' AND is_active = TRUE THEN vendor_certification_id END)
      comment: "Number of currently active and valid certifications. Measures current compliance posture of the vendor base."
    - name: "expired_certifications"
      expr: COUNT(DISTINCT CASE WHEN expiration_date < CURRENT_DATE OR vendor_certification_status = 'Expired' THEN vendor_certification_id END)
      comment: "Number of expired certifications. Critical compliance risk metric requiring immediate remediation action."
    - name: "certifications_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND vendor_certification_status = 'Active' THEN vendor_certification_id END)
      comment: "Certifications expiring within 90 days. Drives proactive renewal outreach and compliance risk mitigation."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score associated with vendor certifications. Informs certification-based risk tiering."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract portfolio metrics covering contract value, lifecycle status, renewal risk, and compliance obligations. Used by Procurement, Legal, and Finance leadership to manage contract exposure and renewal pipeline."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of vendor contract (e.g., MSA, SOW, SLA) for portfolio segmentation."
    - name: "vendor_contract_status"
      expr: vendor_contract_status
      comment: "Current lifecycle status of the contract (active, expired, terminated, pending)."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Sensitivity classification of the contract for access control and risk reporting."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract auto-renews, critical for managing unintended renewals."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flags exclusive vendor arrangements that create single-source dependency risk."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Indicates whether the contract is mandatory for operations, affecting termination risk."
    - name: "is_active"
      expr: is_active
      comment: "Whether the contract record is currently active."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the contract became effective, used for cohort and vintage analysis."
    - name: "expiration_date"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the contract expires, used for renewal pipeline forecasting."
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT vendor_contract_id)
      comment: "Total number of vendor contracts in the portfolio. Baseline for contract management scope."
    - name: "active_contracts"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN vendor_contract_id END)
      comment: "Number of currently active vendor contracts. Core operational metric for contract management."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Sum of total contract values across the portfolio. Primary financial exposure metric for procurement leadership."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value. Benchmarks deal size and informs negotiation strategy."
    - name: "total_annual_contract_value"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Sum of annualized contract values. Used for annual budget planning and spend forecasting."
    - name: "auto_renewal_contracts"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE AND is_active = TRUE THEN vendor_contract_id END)
      comment: "Active contracts set to auto-renew. Flags contracts requiring proactive review to avoid unintended renewals."
    - name: "exclusive_contracts"
      expr: COUNT(DISTINCT CASE WHEN is_exclusive = TRUE AND is_active = TRUE THEN vendor_contract_id END)
      comment: "Active exclusive contracts creating single-source dependency. Key concentration risk indicator."
    - name: "contracts_expiring_within_90_days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN vendor_contract_id END)
      comment: "Contracts expiring within the next 90 days. Drives renewal pipeline urgency and resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor dispute metrics tracking dispute volume, financial exposure, escalation rates, and resolution efficiency. Used by Legal, Procurement, and Finance leadership to manage vendor relationship risk and financial recovery."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor_dispute`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of vendor dispute (e.g., invoice, service quality, contract breach) for root cause analysis."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the dispute for structured reporting and trend analysis."
    - name: "vendor_dispute_status"
      expr: vendor_dispute_status
      comment: "Current status of the dispute (open, under review, resolved, escalated)."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the dispute has been escalated, for executive attention and legal resource allocation."
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute for triage and resolution sequencing."
    - name: "open_timestamp"
      expr: DATE_TRUNC('month', open_timestamp)
      comment: "Month the dispute was opened for trend analysis of dispute frequency."
  measures:
    - name: "total_disputes"
      expr: COUNT(DISTINCT vendor_dispute_id)
      comment: "Total number of vendor disputes. Baseline for dispute management program scope."
    - name: "open_disputes"
      expr: COUNT(DISTINCT CASE WHEN vendor_dispute_status NOT IN ('Resolved', 'Closed') THEN vendor_dispute_id END)
      comment: "Number of currently open disputes. Operational metric for dispute resolution backlog management."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial value under dispute. Primary financial risk metric for vendor dispute portfolio management."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts paid or received. Measures financial resolution outcomes of vendor disputes."
    - name: "escalated_disputes"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN vendor_dispute_id END)
      comment: "Number of escalated disputes. Measures dispute severity and relationship risk requiring executive intervention."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across vendor disputes. Quantifies aggregate dispute risk for portfolio risk management."
$$;
