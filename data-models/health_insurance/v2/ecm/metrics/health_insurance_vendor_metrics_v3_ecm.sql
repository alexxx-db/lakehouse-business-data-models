-- Metric views for domain: vendor | Business: Health_Insurance | Version: 3 | Generated on: 2026-07-10 20:04:11

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vendor master metrics tracking portfolio composition, risk profile, and diversity status across the vendor base. Used by Procurement and Vendor Management leadership to steer sourcing strategy and risk exposure."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor`"
  dimensions:
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of the vendor (e.g., supplier, service provider, staffing) for portfolio segmentation."
    - name: "vendor_tier"
      expr: tier
      comment: "Strategic tier of the vendor (e.g., Tier 1, Tier 2) indicating relationship importance and oversight level."
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current lifecycle status of the vendor (active, suspended, terminated) for active portfolio analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Vendor compliance certification status used to filter non-compliant vendors for remediation."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding stage of the vendor, used to track pipeline of new vendors entering the network."
    - name: "business_category"
      expr: business_category
      comment: "Business category of the vendor for spend and risk analysis by category."
    - name: "incorporation_state"
      expr: incorporation_state
      comment: "State of incorporation for geographic and regulatory jurisdiction analysis."
    - name: "ownership_structure"
      expr: ownership_structure
      comment: "Ownership structure (e.g., public, private, cooperative) for financial risk segmentation."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the vendor for financial stability monitoring."
  measures:
    - name: "total_active_vendors"
      expr: COUNT(DISTINCT CASE WHEN vendor_status = 'active' THEN vendor_id END)
      comment: "Count of currently active vendors in the portfolio. Executives use this to track network size and sourcing capacity."
    - name: "minority_owned_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN minority_owned_flag = TRUE THEN vendor_id END)
      comment: "Number of minority-owned vendors. Tracks diversity sourcing compliance and ESG commitments."
    - name: "women_owned_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN women_owned_flag = TRUE THEN vendor_id END)
      comment: "Number of women-owned vendors. Tracks gender diversity in the supply chain for ESG reporting."
    - name: "small_business_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN small_business_flag = TRUE THEN vendor_id END)
      comment: "Number of small business vendors. Supports regulatory small-business set-aside compliance tracking."
    - name: "non_compliant_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN compliance_status != 'compliant' THEN vendor_id END)
      comment: "Count of vendors not in compliant status. A rising number triggers procurement intervention and risk escalation."
    - name: "vendors_pending_onboarding"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status NOT IN ('completed', 'terminated') THEN vendor_id END)
      comment: "Vendors currently in the onboarding pipeline. Tracks procurement throughput and onboarding backlog."
    - name: "diversity_vendor_pct_numerator"
      expr: COUNT(DISTINCT CASE WHEN minority_owned_flag = TRUE OR women_owned_flag = TRUE OR small_business_flag = TRUE THEN vendor_id END)
      comment: "Numerator for diversity vendor percentage: count of vendors with at least one diversity designation. Combine with total_active_vendors in BI for the ratio."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio metrics covering financial exposure, renewal risk, and compliance status across all vendor contracts. Used by Legal, Procurement, and Finance leadership to manage contract lifecycle and financial commitments."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor_contract`"
  dimensions:
    - name: "vendor_contract_type"
      expr: vendor_contract_type
      comment: "Type of vendor contract (e.g., MSA, SOW, SLA) for portfolio segmentation."
    - name: "vendor_contract_status"
      expr: vendor_contract_status
      comment: "Current lifecycle status of the contract (active, expired, terminated) for active portfolio management."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews, used to identify contracts requiring proactive renewal decisions."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the contract for access control and compliance reporting."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the contract for legal risk and regulatory compliance analysis."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the contract is exclusive, indicating single-source dependency risk."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms (e.g., Net 30, Net 60) for cash flow and working capital analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract for FX exposure analysis."
  measures:
    - name: "total_contract_value_sum"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total committed contract value across all vendor contracts. Core financial exposure metric for CFO and Procurement leadership."
    - name: "annual_contract_value_sum"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Sum of annualized contract values. Used for annual budget planning and vendor spend forecasting."
    - name: "avg_annual_contract_value"
      expr: AVG(CAST(annual_contract_value AS DOUBLE))
      comment: "Average annualized contract value per vendor contract. Benchmarks contract size and identifies outliers."
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN vendor_contract_status = 'active' THEN vendor_contract_id END)
      comment: "Number of currently active vendor contracts. Tracks the size of the active contract portfolio."
    - name: "expiring_contracts_90_days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN vendor_contract_id END)
      comment: "Contracts expiring within 90 days. Critical renewal risk indicator for procurement and legal teams."
    - name: "auto_renewal_contract_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN vendor_contract_id END)
      comment: "Number of contracts set to auto-renew. Identifies contracts requiring proactive opt-out decisions to avoid unintended renewals."
    - name: "exclusive_contract_value_sum"
      expr: SUM(CASE WHEN is_exclusive = TRUE THEN total_contract_value ELSE 0 END)
      comment: "Total value of exclusive vendor contracts. Quantifies single-source financial dependency and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor spend analytics covering gross, net, and approved spend by category, fiscal period, and organizational unit. Primary financial management tool for Procurement, Finance, and executive leadership to control costs and optimize sourcing."
  source: "`vibe_health_insurance_v1`.`vendor`.`spend`"
  dimensions:
    - name: "spend_category"
      expr: spend_category
      comment: "Category of spend (e.g., IT, professional services, facilities) for category management analysis."
    - name: "expense_type"
      expr: expense_type
      comment: "Type of expense for financial classification and budget alignment."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the spend transaction for year-over-year trend analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the spend transaction for quarterly budget variance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the spend transaction for FX exposure and multi-currency reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the spend transaction for treasury and cash management analysis."
    - name: "spend_status"
      expr: spend_status
      comment: "Current status of the spend record (approved, pending, rejected) for spend pipeline management."
    - name: "is_approved"
      expr: is_approved
      comment: "Whether the spend has been approved, used to separate committed from pending spend."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the spend is flagged for compliance review, used to identify policy violations."
  measures:
    - name: "total_gross_spend"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross spend across all vendor transactions. Primary top-line spend metric for executive dashboards and budget reviews."
    - name: "total_net_spend"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net spend after discounts and adjustments. Reflects actual financial outflow for P&L and budget variance analysis."
    - name: "total_usd_spend"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total spend normalized to USD for cross-currency comparison and consolidated financial reporting."
    - name: "total_discount_captured"
      expr: SUM(CAST(amount_discount AS DOUBLE))
      comment: "Total discount amount captured across vendor transactions. Measures procurement negotiation effectiveness and savings realization."
    - name: "total_tax_amount"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax paid on vendor spend. Used for tax liability reporting and compliance."
    - name: "avg_net_spend_per_transaction"
      expr: AVG(CAST(amount_net AS DOUBLE))
      comment: "Average net spend per transaction. Benchmarks transaction size and identifies anomalous spend patterns."
    - name: "non_compliant_spend_amount"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN amount_net ELSE 0 END)
      comment: "Total net spend flagged for compliance issues. Quantifies financial exposure from policy violations requiring remediation."
    - name: "unapproved_spend_amount"
      expr: SUM(CASE WHEN is_approved = FALSE THEN amount_net ELSE 0 END)
      comment: "Total net spend not yet approved. Tracks maverick spend and approval pipeline backlog for financial controls."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to spend transactions. Used for FX risk monitoring and currency hedging decisions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard metrics tracking quality, delivery, SLA compliance, and financial stability ratings. Used by Vendor Management and Procurement leadership to make tier decisions, contract renewals, and sourcing strategy adjustments."
  source: "`vibe_health_insurance_v1`.`vendor`.`performance`"
  dimensions:
    - name: "evaluation_period"
      expr: evaluation_period
      comment: "Evaluation period label (e.g., Q1 2024) for trend analysis across performance cycles."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the performance evaluation (completed, in-progress, pending) for pipeline management."
    - name: "tier_decision"
      expr: tier_decision
      comment: "Tier classification decision resulting from the evaluation, used to track vendor tier movements."
    - name: "compliance_certification_status"
      expr: compliance_certification_status
      comment: "Compliance certification status at time of evaluation for regulatory risk segmentation."
  measures:
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall vendor performance score across evaluations. Primary KPI for vendor scorecard reviews and tier decisions."
    - name: "avg_sla_compliance_rate"
      expr: AVG(CAST(sla_compliance_rate AS DOUBLE))
      comment: "Average SLA compliance rate across vendor evaluations. Measures contractual obligation fulfillment; below-threshold triggers contract remediation."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate. Operational quality KPI used to identify vendors with chronic delivery failures."
    - name: "avg_quality_defect_rate"
      expr: AVG(CAST(quality_defect_rate AS DOUBLE))
      comment: "Average quality defect rate across vendor evaluations. Rising defect rates trigger quality improvement plans or vendor replacement."
    - name: "avg_customer_satisfaction_rating"
      expr: AVG(CAST(customer_satisfaction_rating AS DOUBLE))
      comment: "Average customer satisfaction rating for vendor services. Directly tied to member and internal stakeholder experience outcomes."
    - name: "avg_financial_stability_rating"
      expr: AVG(CAST(financial_stability_rating AS DOUBLE))
      comment: "Average financial stability rating across evaluations. Used to identify vendors at risk of financial distress requiring contingency planning."
    - name: "avg_issue_resolution_time_days"
      expr: AVG(CAST(issue_resolution_time_days AS DOUBLE))
      comment: "Average days to resolve vendor issues. Measures vendor responsiveness; high values indicate service delivery risk."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across vendor performance evaluations. Aggregated risk signal for portfolio-level risk management."
    - name: "low_performing_vendor_evaluations"
      expr: COUNT(DISTINCT CASE WHEN overall_score < 60 THEN performance_id END)
      comment: "Count of evaluations where overall score fell below 60. Identifies vendors requiring performance improvement plans or contract termination."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor risk assessment metrics covering cybersecurity, financial stability, regulatory compliance, and overall residual risk. Used by Risk Management, Compliance, and Procurement leadership to prioritize vendor oversight and mitigation investments."
  source: "`vibe_health_insurance_v1`.`vendor`.`risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g., initial, annual, triggered) for assessment pipeline analysis."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned to the vendor (e.g., critical, high, medium, low) for prioritized oversight."
    - name: "risk_domain"
      expr: risk_domain
      comment: "Domain of risk assessed (e.g., cybersecurity, financial, operational) for targeted risk management."
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating before controls for gross risk exposure analysis."
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after controls for net risk exposure and control effectiveness analysis."
    - name: "risk_assessment_status"
      expr: risk_assessment_status
      comment: "Current status of the risk assessment (completed, in-progress, overdue) for assessment pipeline management."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the vendor is flagged for regulatory compliance issues, used to prioritize remediation."
    - name: "concentration_risk_flag"
      expr: concentration_risk_flag
      comment: "Whether the vendor represents a concentration risk (single-source dependency) for supply chain resilience analysis."
  measures:
    - name: "avg_overall_residual_risk_score"
      expr: AVG(CAST(overall_residual_score AS DOUBLE))
      comment: "Average residual risk score across all vendor risk assessments. Portfolio-level risk KPI for executive risk dashboards."
    - name: "avg_cybersecurity_score"
      expr: AVG(CAST(cybersecurity_score AS DOUBLE))
      comment: "Average cybersecurity risk score. Critical for HIPAA compliance and PHI protection oversight in health insurance operations."
    - name: "avg_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score across vendor assessments. Identifies vendors at risk of insolvency requiring contingency sourcing."
    - name: "avg_regulatory_compliance_score"
      expr: AVG(CAST(regulatory_compliance_score AS DOUBLE))
      comment: "Average regulatory compliance score. Measures vendor adherence to health insurance regulatory requirements (HIPAA, CMS, state mandates)."
    - name: "avg_business_continuity_score"
      expr: AVG(CAST(business_continuity_score AS DOUBLE))
      comment: "Average business continuity score. Assesses vendor resilience to disruptions affecting health plan operations."
    - name: "high_risk_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN risk_tier IN ('critical', 'high') THEN risk_assessment_id END)
      comment: "Count of assessments resulting in high or critical risk tier. Drives prioritized vendor oversight and remediation resource allocation."
    - name: "concentration_risk_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN concentration_risk_flag = TRUE THEN risk_assessment_id END)
      comment: "Count of vendors flagged for concentration risk. Quantifies single-source dependency exposure requiring diversification strategy."
    - name: "regulatory_non_compliant_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_compliance_flag = FALSE THEN risk_assessment_id END)
      comment: "Count of vendor assessments with regulatory compliance failures. Triggers immediate remediation to avoid regulatory penalties."
    - name: "overdue_reassessment_count"
      expr: COUNT(DISTINCT CASE WHEN next_assessment_due_date < CURRENT_DATE THEN risk_assessment_id END)
      comment: "Count of vendors with overdue risk reassessments. Identifies gaps in the risk monitoring program requiring immediate scheduling."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor audit program metrics tracking audit outcomes, findings severity, corrective actions, and risk scores. Used by Compliance, Internal Audit, and Vendor Management leadership to assess vendor control environments and drive remediation."
  source: "`vibe_health_insurance_v1`.`vendor`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (e.g., financial, operational, compliance, security) for audit program analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, completed, closed) for audit pipeline management."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall audit rating (e.g., satisfactory, needs improvement, unsatisfactory) for vendor control environment assessment."
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework assessed (e.g., HIPAA, SOC2, ISO 27001) for regulatory coverage analysis."
    - name: "auditor_type"
      expr: auditor_type
      comment: "Type of auditor (internal, external, regulatory) for audit independence and coverage analysis."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was required, used to filter audits with remediation obligations."
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body associated with the audit for regulatory compliance tracking."
  measures:
    - name: "total_audit_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of vendor audits. Used for audit program budget management and cost-per-audit benchmarking."
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per vendor audit. Benchmarks audit efficiency and identifies cost outliers."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk score from vendor audits. Portfolio-level signal for vendor control environment quality."
    - name: "audits_requiring_corrective_action"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE THEN audit_id END)
      comment: "Count of audits requiring corrective action. Measures the volume of vendor control deficiencies requiring remediation."
    - name: "overdue_corrective_actions"
      expr: COUNT(DISTINCT CASE WHEN corrective_action_required = TRUE AND corrective_action_due_date < CURRENT_DATE AND audit_status != 'closed' THEN audit_id END)
      comment: "Count of audits with overdue corrective actions. Critical compliance risk indicator requiring immediate escalation."
    - name: "total_audits_completed"
      expr: COUNT(DISTINCT CASE WHEN audit_status = 'completed' THEN audit_id END)
      comment: "Total number of completed vendor audits. Measures audit program throughput and coverage."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor incident management metrics tracking PHI breaches, regulatory notifications, severity distribution, and resolution performance. Critical for HIPAA compliance, regulatory reporting, and vendor risk management in health insurance operations."
  source: "`vibe_health_insurance_v1`.`vendor`.`incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Type of vendor incident (e.g., data breach, service outage, compliance violation) for incident categorization."
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, investigating, resolved, closed) for incident pipeline management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident (critical, high, medium, low) for prioritized response and escalation."
    - name: "is_phi_involved"
      expr: is_phi_involved
      comment: "Whether PHI was involved in the incident. HIPAA-critical dimension for breach notification obligation tracking."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required, used to track HIPAA and state breach notification obligations."
    - name: "breach_notification_sent"
      expr: breach_notification_sent
      comment: "Whether breach notification has been sent, used to identify overdue notification obligations."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required from the vendor following the incident."
  measures:
    - name: "total_affected_members"
      expr: SUM(CAST(affected_member_count AS DOUBLE))
      comment: "Total number of members affected by vendor incidents. Primary impact metric for HIPAA breach severity assessment and regulatory reporting."
    - name: "avg_affected_members_per_incident"
      expr: AVG(CAST(affected_member_count AS DOUBLE))
      comment: "Average number of members affected per incident. Benchmarks incident impact severity for risk prioritization."
    - name: "phi_incident_count"
      expr: COUNT(DISTINCT CASE WHEN is_phi_involved = TRUE THEN incident_id END)
      comment: "Count of incidents involving PHI. HIPAA-critical KPI triggering mandatory breach notification and regulatory reporting obligations."
    - name: "open_critical_incidents"
      expr: COUNT(DISTINCT CASE WHEN incident_status = 'open' AND severity_level = 'critical' THEN incident_id END)
      comment: "Count of open critical-severity incidents. Immediate escalation trigger for executive and compliance leadership."
    - name: "overdue_regulatory_notifications"
      expr: COUNT(DISTINCT CASE WHEN regulatory_notification_required = TRUE AND breach_notification_sent = FALSE AND incident_status != 'closed' THEN incident_id END)
      comment: "Count of incidents requiring regulatory notification where notification has not been sent. Identifies HIPAA compliance violations requiring immediate action."
    - name: "total_incidents"
      expr: COUNT(DISTINCT incident_id)
      comment: "Total number of vendor incidents. Tracks overall vendor incident volume for trend analysis and vendor risk scoring."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_sla_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA breach and performance event metrics tracking penalty exposure, breach severity, and resolution performance across vendor contracts. Used by Vendor Management and Finance to enforce contractual obligations and recover penalties."
  source: "`vibe_health_insurance_v1`.`vendor`.`sla_event`"
  dimensions:
    - name: "sla_metric_name"
      expr: sla_metric_name
      comment: "Name of the SLA metric being measured (e.g., uptime, response time, accuracy rate) for metric-level performance analysis."
    - name: "sla_status"
      expr: sla_status
      comment: "Status of the SLA event (breach, at-risk, compliant) for SLA compliance monitoring."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of the SLA breach (critical, major, minor) for prioritized remediation and penalty enforcement."
    - name: "penalty_triggered"
      expr: penalty_triggered
      comment: "Whether a financial penalty was triggered by the SLA event, used to track penalty recovery pipeline."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the SLA event (resolved, pending, escalated) for remediation pipeline management."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure the SLA metric for audit and dispute resolution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the penalty amount for financial reporting."
  measures:
    - name: "total_penalty_amount"
      expr: SUM(CASE WHEN penalty_triggered = TRUE THEN penalty_amount ELSE 0 END)
      comment: "Total financial penalties triggered by SLA breaches. Measures contractual enforcement effectiveness and vendor financial accountability."
    - name: "avg_penalty_per_breach"
      expr: AVG(CASE WHEN penalty_triggered = TRUE THEN penalty_amount END)
      comment: "Average penalty amount per SLA breach event. Benchmarks penalty severity and contract enforcement consistency."
    - name: "total_sla_breaches"
      expr: COUNT(DISTINCT CASE WHEN sla_status = 'breach' THEN sla_event_id END)
      comment: "Total number of SLA breach events. Primary SLA compliance KPI for vendor performance management and contract renewal decisions."
    - name: "avg_sla_variance"
      expr: AVG(CAST(variance AS DOUBLE))
      comment: "Average variance between actual and target SLA values. Quantifies the magnitude of SLA underperformance across the vendor portfolio."
    - name: "unresolved_breach_penalty_exposure"
      expr: SUM(CASE WHEN penalty_triggered = TRUE AND resolution_status != 'resolved' THEN penalty_amount ELSE 0 END)
      comment: "Total penalty exposure from unresolved SLA breaches. Financial risk metric for accounts payable and vendor management teams."
    - name: "critical_breach_count"
      expr: COUNT(DISTINCT CASE WHEN breach_severity = 'critical' THEN sla_event_id END)
      comment: "Count of critical-severity SLA breaches. Triggers immediate vendor escalation and potential contract termination review."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor invoice processing metrics covering payment performance, dispute rates, tax exposure, and early payment discount capture. Used by Finance, Accounts Payable, and Procurement leadership to optimize payment operations and cash management."
  source: "`vibe_health_insurance_v1`.`vendor`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (pending, approved, paid, disputed) for AP pipeline management."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice for cash flow and aging analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., ACH, wire, check) for treasury and payment operations analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms (e.g., Net 30, Net 60) for working capital and cash flow optimization."
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category of the invoice for cost center and budget allocation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice for FX exposure and multi-currency AP reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the invoice is under dispute, used to track disputed invoice volume and financial exposure."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the invoice is tax-exempt for tax liability and compliance reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice for AP workflow and authorization control analysis."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoice amount across all vendor invoices. Primary AP financial exposure metric for cash flow planning."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Reflects actual AP liability for financial reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across vendor invoices. Used for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured on vendor invoices. Measures AP savings from negotiated discounts."
    - name: "early_payment_discount_captured"
      expr: SUM(CASE WHEN is_early_payment_discount = TRUE THEN early_payment_discount_amount ELSE 0 END)
      comment: "Total early payment discounts captured. Measures treasury effectiveness in optimizing payment timing for cost savings."
    - name: "disputed_invoice_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN total_amount ELSE 0 END)
      comment: "Total amount of invoices under dispute. Quantifies financial exposure from invoice disputes requiring resolution."
    - name: "disputed_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN invoice_id END)
      comment: "Count of invoices under dispute. Tracks AP dispute volume for process improvement and vendor relationship management."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount. Benchmarks invoice size for anomaly detection and spend pattern analysis."
    - name: "retention_amount_held"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention amounts held on vendor invoices. Tracks financial leverage retained pending contract milestone completion."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor onboarding pipeline metrics tracking completion rates, checklist compliance, cost, and cycle time. Used by Procurement and Compliance leadership to optimize vendor intake processes and ensure regulatory requirements are met before vendor activation."
  source: "`vibe_health_insurance_v1`.`vendor`.`onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of the onboarding process (in-progress, completed, rejected) for pipeline management."
    - name: "stage"
      expr: stage
      comment: "Current stage of the onboarding workflow for funnel analysis and bottleneck identification."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the onboarding process (approved, rejected, withdrawn) for conversion analysis."
    - name: "requestor_department"
      expr: requestor_department
      comment: "Department requesting the vendor onboarding for demand analysis and departmental accountability."
    - name: "compliance_certification_status"
      expr: compliance_certification_status
      comment: "Compliance certification status during onboarding for regulatory gate tracking."
  measures:
    - name: "total_onboarding_cost"
      expr: SUM(CAST(total_onboarding_cost AS DOUBLE))
      comment: "Total cost of vendor onboarding across all cases. Used for procurement budget management and cost-per-onboarding benchmarking."
    - name: "avg_onboarding_cost"
      expr: AVG(CAST(total_onboarding_cost AS DOUBLE))
      comment: "Average cost per vendor onboarding. Benchmarks onboarding efficiency and identifies high-cost outliers."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score at onboarding. Measures the risk profile of vendors entering the network."
    - name: "checklist_completion_rate_numerator"
      expr: SUM(CASE WHEN checklist_baa_executed = TRUE AND checklist_w9_received = TRUE AND checklist_insurance_verified = TRUE AND checklist_security_questionnaire = TRUE AND checklist_financial_due_diligence = TRUE AND checklist_diversity_cert_verified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of onboardings with all checklist items completed. Numerator for full checklist completion rate; combine with total onboarding count in BI."
    - name: "baa_execution_gap_count"
      expr: COUNT(DISTINCT CASE WHEN checklist_baa_executed = FALSE AND onboarding_status = 'completed' THEN onboarding_id END)
      comment: "Count of completed onboardings where BAA was not executed. HIPAA compliance risk indicator requiring immediate remediation."
    - name: "insurance_verification_gap_count"
      expr: COUNT(DISTINCT CASE WHEN checklist_insurance_verified = FALSE AND onboarding_status = 'completed' THEN onboarding_id END)
      comment: "Count of completed onboardings where insurance was not verified. Identifies vendors activated without required insurance coverage."
    - name: "approved_onboarding_count"
      expr: COUNT(DISTINCT CASE WHEN outcome = 'approved' THEN onboarding_id END)
      comment: "Count of successfully approved vendor onboardings. Measures procurement throughput and new vendor network growth."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor dispute metrics tracking financial exposure, escalation rates, settlement outcomes, and resolution performance. Used by Finance, Legal, and Vendor Management leadership to manage dispute liability and vendor relationship health."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor_dispute`"
  dimensions:
    - name: "vendor_dispute_type"
      expr: vendor_dispute_type
      comment: "Type of vendor dispute (e.g., invoice, contract, delivery) for dispute categorization and root cause analysis."
    - name: "vendor_dispute_category"
      expr: vendor_dispute_category
      comment: "Category of the dispute for detailed classification and trend analysis."
    - name: "vendor_dispute_status"
      expr: vendor_dispute_status
      comment: "Current status of the dispute (open, in-negotiation, resolved, closed) for dispute pipeline management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the dispute for resource allocation and escalation management."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the dispute has been escalated, used to track escalation rates and management attention required."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the dispute has compliance implications for regulatory risk tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount for financial reporting."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial amount under dispute across all vendor disputes. Primary financial exposure metric for Finance and Legal leadership."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount settled across resolved vendor disputes. Measures dispute resolution financial outcomes and negotiation effectiveness."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute. Benchmarks dispute size and identifies high-value disputes requiring priority attention."
    - name: "open_dispute_exposure"
      expr: SUM(CASE WHEN vendor_dispute_status = 'open' THEN disputed_amount ELSE 0 END)
      comment: "Total financial exposure from open vendor disputes. Tracks unresolved liability for financial reporting and provisioning."
    - name: "escalated_dispute_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN vendor_dispute_id END)
      comment: "Count of escalated vendor disputes. Measures dispute severity and management escalation burden."
    - name: "settlement_recovery_rate_numerator"
      expr: SUM(CASE WHEN vendor_dispute_status = 'resolved' THEN settlement_amount ELSE 0 END)
      comment: "Total settlement amount recovered on resolved disputes. Numerator for settlement recovery rate; combine with total_disputed_amount in BI to compute recovery percentage."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across vendor disputes. Aggregated risk signal for vendor relationship health monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor certification compliance metrics tracking certification coverage, expiration risk, and renewal pipeline. Used by Compliance and Vendor Management leadership to ensure vendors maintain required certifications for regulatory and contractual compliance."
  source: "`vibe_health_insurance_v1`.`vendor`.`vendor_certification`"
  dimensions:
    - name: "vendor_certification_type"
      expr: vendor_certification_type
      comment: "Type of certification (e.g., HIPAA, ISO 27001, SOC2) for certification program coverage analysis."
    - name: "vendor_certification_status"
      expr: vendor_certification_status
      comment: "Current status of the certification (active, expired, suspended) for compliance monitoring."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Organization that issued the certification for accreditation source analysis."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the certification for geographic compliance coverage analysis."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the certification for regulatory framework alignment."
    - name: "risk_assessment_level"
      expr: risk_assessment_level
      comment: "Risk assessment level associated with the certification for prioritized renewal management."
  measures:
    - name: "active_certification_count"
      expr: COUNT(DISTINCT CASE WHEN vendor_certification_status = 'active' THEN vendor_certification_id END)
      comment: "Count of currently active vendor certifications. Measures certification coverage across the vendor portfolio."
    - name: "expired_certification_count"
      expr: COUNT(DISTINCT CASE WHEN vendor_certification_status = 'expired' THEN vendor_certification_id END)
      comment: "Count of expired vendor certifications. Identifies compliance gaps requiring immediate vendor remediation."
    - name: "expiring_certifications_60_days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 60) THEN vendor_certification_id END)
      comment: "Count of certifications expiring within 60 days. Proactive renewal risk indicator for compliance management."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score across vendor certifications. Measures overall certification risk profile of the vendor portfolio."
    - name: "renewal_notice_sent_count"
      expr: COUNT(DISTINCT CASE WHEN expiration_notice_sent = TRUE THEN vendor_certification_id END)
      comment: "Count of certifications where renewal notice has been sent. Tracks proactive renewal management program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_rfp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP and sourcing event metrics tracking award values, response rates, approval performance, and sourcing cycle efficiency. Used by Procurement leadership to evaluate sourcing program effectiveness and competitive bidding outcomes."
  source: "`vibe_health_insurance_v1`.`vendor`.`rfp`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Current status of the RFP (draft, issued, evaluation, awarded, cancelled) for sourcing pipeline management."
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (RFP, RFQ, RFI) for sourcing method analysis."
    - name: "spend_category"
      expr: spend_category
      comment: "Spend category of the RFP for category management and sourcing strategy analysis."
    - name: "award_status"
      expr: award_status
      comment: "Award status of the RFP (awarded, pending, cancelled) for sourcing outcome tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RFP for governance and authorization tracking."
  measures:
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total value of contracts awarded through RFP processes. Measures sourcing program financial impact and procurement value delivered."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of active RFPs in the pipeline. Tracks sourcing pipeline financial volume for budget planning."
    - name: "avg_award_amount"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average contract award amount per RFP. Benchmarks sourcing deal size and identifies outliers."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across RFPs. Measures sourcing risk profile for procurement governance."
    - name: "awarded_rfp_count"
      expr: COUNT(DISTINCT CASE WHEN award_status = 'awarded' THEN rfp_id END)
      comment: "Count of successfully awarded RFPs. Measures sourcing program throughput and competitive bidding success rate."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`vendor_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order financial metrics tracking committed spend, payment performance, and procurement pipeline. Used by Finance and Procurement leadership to manage purchase commitments, cash flow, and three-way match compliance."
  source: "`vibe_health_insurance_v1`.`vendor`.`purchase_order`"
  dimensions:
    - name: "purchase_order_status"
      expr: purchase_order_status
      comment: "Current status of the purchase order (open, received, invoiced, closed) for PO lifecycle management."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, emergency) for procurement method analysis."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category of the PO for category spend analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the PO for AP and cash flow management."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms of the PO for working capital optimization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the PO for FX exposure analysis."
    - name: "is_three_way_match_enabled"
      expr: is_three_way_match_enabled
      comment: "Whether three-way match is enabled for the PO, used to assess financial control coverage."
  measures:
    - name: "total_po_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed purchase order amount. Primary procurement financial commitment metric for budget and cash flow management."
    - name: "total_net_po_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net purchase order amount after discounts. Reflects actual financial commitment for AP and budget reporting."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid against purchase orders. Tracks actual cash outflow versus committed spend for variance analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on purchase orders. Used for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured on purchase orders. Measures procurement savings from negotiated discounts."
    - name: "avg_po_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order amount. Benchmarks PO size for anomaly detection and procurement pattern analysis."
    - name: "open_po_count"
      expr: COUNT(DISTINCT CASE WHEN purchase_order_status = 'open' THEN purchase_order_id END)
      comment: "Count of open purchase orders. Tracks active procurement pipeline volume for workload and commitment management."
    - name: "three_way_match_enabled_po_count"
      expr: COUNT(DISTINCT CASE WHEN is_three_way_match_enabled = TRUE THEN purchase_order_id END)
      comment: "Count of POs with three-way match enabled. Measures financial control coverage across the procurement portfolio."
$$;