-- Metric views for domain: partner | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`partner_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic vendor contract performance metrics tracking total contract value, annual spend, renewal risk, and compliance posture across the vendor portfolio"
  source: "`sports_entertainment_ecm`.`partner`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the vendor contract (active, expired, pending, terminated)"
    - name: "contract_type"
      expr: contract_type
      comment: "Classification of contract type (master service agreement, statement of work, purchase agreement)"
    - name: "service_category"
      expr: service_category
      comment: "Primary service category delivered under this contract (broadcast, venue services, merchandise, technology)"
    - name: "vendor_category"
      expr: vendor_category
      comment: "Vendor classification tier (strategic, preferred, approved, conditional)"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level agreement tier defining performance expectations (platinum, gold, silver, bronze)"
    - name: "contract_year"
      expr: YEAR(contract_start_date)
      comment: "Calendar year when the contract was initiated"
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month when the contract started, truncated to first day of month"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Calendar year when the contract expires"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether contract automatically renews at expiration"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Indicates whether vendor has exclusive rights under this contract"
    - name: "penalty_clause_flag"
      expr: penalty_clause_flag
      comment: "Indicates whether contract includes financial penalty provisions for non-performance"
    - name: "sox_relevant_flag"
      expr: sox_relevant_flag
      comment: "Indicates whether contract is subject to Sarbanes-Oxley compliance requirements"
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Legal jurisdiction governing contract disputes and interpretation"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total committed value across all vendor contracts, representing full portfolio exposure"
    - name: "annual_contract_value"
      expr: SUM(CAST(annual_contract_value AS DOUBLE))
      comment: "Annualized contract value representing recurring annual spend commitment"
    - name: "annual_spend"
      expr: SUM(CAST(annual_spend AS DOUBLE))
      comment: "Actual annual spend against vendor contracts, used to track budget utilization"
    - name: "contract_count"
      expr: COUNT(DISTINCT vendor_contract_id)
      comment: "Number of distinct vendor contracts, used to measure portfolio complexity and vendor concentration"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors under contract, indicating vendor diversification"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average total contract value, indicating typical contract size and procurement scale"
    - name: "avg_contract_term_months"
      expr: AVG(DATEDIFF(expiration_date, contract_start_date) / 30.0)
      comment: "Average contract duration in months, measuring commitment horizon and flexibility"
    - name: "penalty_amount_total"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total potential penalty exposure across all contracts with penalty clauses"
    - name: "indemnification_cap_total"
      expr: SUM(CAST(indemnification_cap AS DOUBLE))
      comment: "Total indemnification liability cap across vendor portfolio, representing maximum legal exposure"
    - name: "insurance_min_coverage_total"
      expr: SUM(CAST(insurance_min_coverage AS DOUBLE))
      comment: "Total minimum insurance coverage required from vendors, indicating risk transfer strategy"
    - name: "sla_uptime_avg"
      expr: AVG(CAST(sla_uptime_pct AS DOUBLE))
      comment: "Average contracted SLA uptime percentage, measuring service reliability expectations"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`partner_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and vendor invoice processing metrics tracking payment velocity, approval efficiency, and three-way match compliance"
  source: "`sports_entertainment_ecm`.`partner`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (pending, approved, paid, rejected, blocked)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of invoice type (standard, credit memo, debit memo, prepayment)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status (pending approval, approved, rejected, escalated)"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match between invoice, purchase order, and goods receipt (matched, variance, unmatched)"
    - name: "service_category"
      expr: service_category
      comment: "Service category of invoiced goods or services"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of invoice posting"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of invoice posting"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date, truncated to first day of month"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment date, truncated to first day of month"
    - name: "is_payment_blocked"
      expr: is_payment_blocked
      comment: "Indicates whether invoice payment is currently blocked"
    - name: "is_duplicate"
      expr: is_duplicate
      comment: "Indicates whether invoice has been flagged as a potential duplicate"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which invoice is denominated"
  measures:
    - name: "gross_amount_total"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes, representing total vendor billing"
    - name: "net_amount_total"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts, representing actual payment obligation"
    - name: "tax_amount_total"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices, used for tax liability tracking"
    - name: "discount_amount_total"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured, measuring early payment and negotiation savings"
    - name: "invoice_count"
      expr: COUNT(DISTINCT vendor_invoice_id)
      comment: "Number of distinct vendor invoices processed, measuring AP transaction volume"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors invoicing, indicating active vendor base"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount, indicating typical transaction size"
    - name: "avg_days_to_payment"
      expr: AVG(DATEDIFF(payment_date, invoice_date))
      comment: "Average days from invoice date to payment date, measuring payment velocity and working capital efficiency"
    - name: "avg_days_to_approval"
      expr: AVG(DATEDIFF(approved_timestamp, created_timestamp))
      comment: "Average days from invoice receipt to approval, measuring approval process efficiency"
    - name: "early_payment_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured, measuring cash management effectiveness"
    - name: "withholding_tax_total"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax amount, used for tax compliance and remittance tracking"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`partner_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement execution metrics tracking purchase order value, goods receipt performance, invoice matching, and on-time delivery"
  source: "`sports_entertainment_ecm`.`partner`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of purchase order (open, closed, partially received, cancelled)"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, contract release, service)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status (pending, approved, rejected)"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match between PO, goods receipt, and invoice"
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category classification (direct materials, indirect, services, capital)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of purchase order"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of purchase order creation, truncated to first day of month"
    - name: "is_blanket_release"
      expr: is_blanket_release
      comment: "Indicates whether PO is a release against a blanket agreement"
    - name: "is_goods_receipt_required"
      expr: is_goods_receipt_required
      comment: "Indicates whether goods receipt is required for this PO"
    - name: "is_invoice_receipt_required"
      expr: is_invoice_receipt_required
      comment: "Indicates whether invoice receipt is required for this PO"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of purchase order (urgent, high, normal, low)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which purchase order is denominated"
  measures:
    - name: "gross_order_value_total"
      expr: SUM(CAST(gross_order_value AS DOUBLE))
      comment: "Total gross purchase order value before taxes, representing total procurement spend commitment"
    - name: "net_order_value_total"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net purchase order value after discounts, representing actual procurement obligation"
    - name: "tax_amount_total"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on purchase orders"
    - name: "purchase_order_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of distinct purchase orders, measuring procurement transaction volume"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors receiving purchase orders, indicating vendor diversification"
    - name: "avg_order_value"
      expr: AVG(CAST(net_order_value AS DOUBLE))
      comment: "Average net purchase order value, indicating typical procurement transaction size"
    - name: "goods_receipt_quantity_total"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total quantity of goods received against purchase orders"
    - name: "invoiced_amount_total"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total invoiced amount against purchase orders, used to track invoice-to-PO variance"
    - name: "avg_days_to_approval"
      expr: AVG(DATEDIFF(approved_date, order_date))
      comment: "Average days from PO creation to approval, measuring procurement approval efficiency"
    - name: "avg_days_to_goods_receipt"
      expr: AVG(DATEDIFF(goods_receipt_date, order_date))
      comment: "Average days from PO creation to goods receipt, measuring supplier delivery performance"
    - name: "avg_days_to_invoice_verification"
      expr: AVG(DATEDIFF(invoice_verification_date, order_date))
      comment: "Average days from PO creation to invoice verification, measuring procure-to-pay cycle time"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`partner_vendor_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance management metrics tracking quality, delivery, compliance, and overall vendor scores to drive strategic sourcing decisions"
  source: "`sports_entertainment_ecm`.`partner`.`vendor_scorecard`"
  dimensions:
    - name: "performance_tier"
      expr: performance_tier
      comment: "Current performance tier classification (platinum, gold, silver, bronze, probation)"
    - name: "prior_performance_tier"
      expr: prior_performance_tier
      comment: "Previous performance tier, used to track tier movement and vendor improvement"
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of scorecard evaluation (draft, published, acknowledged, disputed)"
    - name: "vendor_category"
      expr: vendor_category
      comment: "Vendor category classification"
    - name: "evaluation_frequency"
      expr: evaluation_frequency
      comment: "Frequency of scorecard evaluation (monthly, quarterly, annual)"
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Method used for performance evaluation (automated, manual, hybrid)"
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Calendar year of scorecard evaluation"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of scorecard evaluation, truncated to first day of month"
    - name: "improvement_plan_required"
      expr: improvement_plan_required
      comment: "Indicates whether vendor is required to submit a performance improvement plan"
    - name: "vendor_acknowledged"
      expr: vendor_acknowledged
      comment: "Indicates whether vendor has acknowledged the scorecard results"
    - name: "vendor_dispute_raised"
      expr: vendor_dispute_raised
      comment: "Indicates whether vendor has raised a formal dispute on scorecard results"
  measures:
    - name: "overall_score_avg"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall vendor performance score, representing composite vendor quality across all dimensions"
    - name: "quality_score_avg"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score, measuring product/service quality and defect rates"
    - name: "delivery_score_avg"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery score, measuring on-time delivery and fulfillment performance"
    - name: "service_score_avg"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service score, measuring responsiveness and customer service quality"
    - name: "compliance_score_avg"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score, measuring adherence to regulatory and contractual requirements"
    - name: "innovation_score_avg"
      expr: AVG(CAST(innovation_score AS DOUBLE))
      comment: "Average innovation score, measuring vendor contribution to process improvement and innovation"
    - name: "commercial_value_score_avg"
      expr: AVG(CAST(commercial_value_score AS DOUBLE))
      comment: "Average commercial value score, measuring cost competitiveness and value delivery"
    - name: "on_time_delivery_rate_avg"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate percentage, key operational performance indicator"
    - name: "sla_compliance_rate_avg"
      expr: AVG(CAST(sla_compliance_rate AS DOUBLE))
      comment: "Average SLA compliance rate percentage, measuring contractual performance adherence"
    - name: "defect_rate_avg"
      expr: AVG(CAST(defect_rate AS DOUBLE))
      comment: "Average defect rate, measuring quality issues and rework requirements"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors evaluated, indicating active vendor management scope"
    - name: "scorecard_count"
      expr: COUNT(DISTINCT vendor_scorecard_id)
      comment: "Number of scorecard evaluations completed, measuring evaluation activity volume"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`partner_sla_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service level agreement performance metrics tracking SLA compliance, breach frequency, penalty exposure, and remediation effectiveness"
  source: "`sports_entertainment_ecm`.`partner`.`sla_measurement`"
  dimensions:
    - name: "breach_flag"
      expr: breach_flag
      comment: "Indicates whether the SLA measurement resulted in a breach"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of SLA breach (critical, major, minor)"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of SLA measurement (validated, pending review, disputed, accepted)"
    - name: "service_category"
      expr: service_category
      comment: "Service category being measured"
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier level (platinum, gold, silver, bronze)"
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Type of measurement period (real-time, daily, weekly, monthly)"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of SLA measurement, truncated to first day of month"
    - name: "penalty_trigger_flag"
      expr: penalty_trigger_flag
      comment: "Indicates whether breach triggered a contractual penalty"
    - name: "remediation_required_flag"
      expr: remediation_required_flag
      comment: "Indicates whether breach requires formal remediation action"
    - name: "dispute_raised_flag"
      expr: dispute_raised_flag
      comment: "Indicates whether vendor has disputed the SLA measurement"
    - name: "force_majeure_flag"
      expr: force_majeure_flag
      comment: "Indicates whether breach was due to force majeure event"
    - name: "broadcast_event_type"
      expr: broadcast_event_type
      comment: "Type of broadcast event during measurement (live game, studio show, replay)"
  measures:
    - name: "actual_value_avg"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual measured value of SLA metric, used to assess typical performance levels"
    - name: "target_value_avg"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value of SLA metric, representing contracted performance expectations"
    - name: "variance_percentage_avg"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage between actual and target, measuring performance gap"
    - name: "penalty_amount_total"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount triggered by SLA breaches, representing financial impact of non-performance"
    - name: "measurement_count"
      expr: COUNT(DISTINCT sla_measurement_id)
      comment: "Number of distinct SLA measurements, indicating monitoring activity volume"
    - name: "breach_count"
      expr: COUNT(DISTINCT CASE WHEN breach_flag = TRUE THEN sla_measurement_id END)
      comment: "Number of SLA breaches, key indicator of vendor performance issues"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors measured, indicating SLA monitoring scope"
    - name: "data_completeness_avg"
      expr: AVG(CAST(data_completeness_percentage AS DOUBLE))
      comment: "Average data completeness percentage, measuring quality of SLA measurement data"
    - name: "measurement_confidence_avg"
      expr: AVG(CAST(measurement_confidence_score AS DOUBLE))
      comment: "Average measurement confidence score, indicating reliability of SLA measurements"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`partner_vendor_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor incident management metrics tracking incident frequency, severity, resolution time, financial impact, and corrective action effectiveness"
  source: "`sports_entertainment_ecm`.`partner`.`vendor_incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of vendor incident (open, investigating, resolved, closed, escalated)"
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of incident type (service outage, quality issue, safety, security, compliance)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (critical, high, medium, low)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category (process failure, human error, system failure, external factor)"
    - name: "affected_service"
      expr: affected_service
      comment: "Service affected by the incident"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether incident was escalated to senior management"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level of escalation (tier 1, tier 2, executive)"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether incident resulted in SLA breach"
    - name: "penalty_applied_flag"
      expr: penalty_applied_flag
      comment: "Indicates whether financial penalty was applied"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether formal corrective action is required"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Indicates whether incident is a recurrence of a prior issue"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Indicates whether incident requires regulatory notification"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of incident occurrence, truncated to first day of month"
  measures:
    - name: "incident_count"
      expr: COUNT(DISTINCT vendor_incident_id)
      comment: "Number of distinct vendor incidents, measuring vendor reliability and risk exposure"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with incidents, indicating problem vendor concentration"
    - name: "financial_impact_total"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of vendor incidents, representing direct cost of vendor failures"
    - name: "penalty_amount_total"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount applied to vendors, representing financial recovery from non-performance"
    - name: "scorecard_deduction_total"
      expr: SUM(CAST(scorecard_deduction_points AS DOUBLE))
      comment: "Total scorecard points deducted due to incidents, measuring impact on vendor performance ratings"
    - name: "avg_resolution_hours"
      expr: AVG(DATEDIFF(resolution_timestamp, incident_detected_timestamp) * 24.0)
      comment: "Average hours from incident detection to resolution, measuring incident response effectiveness"
    - name: "avg_acknowledgement_hours"
      expr: AVG(DATEDIFF(incident_acknowledged_timestamp, incident_detected_timestamp) * 24.0)
      comment: "Average hours from incident detection to vendor acknowledgement, measuring vendor responsiveness"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`partner_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service order execution metrics tracking service delivery performance, cost variance, SLA compliance, and quality outcomes for event-based vendor services"
  source: "`sports_entertainment_ecm`.`partner`.`service_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of service order (scheduled, in progress, completed, cancelled)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service being delivered (broadcast production, venue setup, security, catering)"
    - name: "service_category"
      expr: service_category
      comment: "Category classification of service"
    - name: "priority"
      expr: priority
      comment: "Priority level of service order (critical, high, normal, low)"
    - name: "sla_breached"
      expr: sla_breached
      comment: "Indicates whether service order breached SLA commitments"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates whether a safety incident occurred during service delivery"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates whether service order is part of a recurring service schedule"
    - name: "access_credential_required"
      expr: access_credential_required
      comment: "Indicates whether service requires special access credentials"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', requested_start_datetime)
      comment: "Month of service delivery, truncated to first day of month"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which service order is priced"
  measures:
    - name: "estimated_cost_total"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of service orders, representing budgeted service spend"
    - name: "actual_cost_total"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of service orders, representing realized service spend"
    - name: "service_order_count"
      expr: COUNT(DISTINCT service_order_id)
      comment: "Number of distinct service orders, measuring service delivery volume"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors delivering services, indicating service provider diversification"
    - name: "avg_service_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per service order, indicating typical service transaction size"
    - name: "post_service_score_avg"
      expr: AVG(CAST(post_service_score AS DOUBLE))
      comment: "Average post-service quality score, measuring service delivery satisfaction"
    - name: "avg_sla_response_hours"
      expr: AVG(CAST(sla_response_hours AS DOUBLE))
      comment: "Average SLA response time in hours, measuring vendor responsiveness"
    - name: "avg_sla_completion_hours"
      expr: AVG(CAST(sla_completion_hours AS DOUBLE))
      comment: "Average SLA completion time in hours, measuring service delivery speed"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`partner_rfp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for proposal lifecycle metrics tracking RFP value, vendor participation, evaluation efficiency, and award outcomes to optimize strategic sourcing"
  source: "`sports_entertainment_ecm`.`partner`.`rfp`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Current status of RFP (draft, issued, evaluation, awarded, cancelled)"
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category of RFP"
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method (open competitive, invited, sole source, emergency)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract being procured"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of RFP (pending, approved, rejected)"
    - name: "rfp_year"
      expr: YEAR(issue_date)
      comment: "Calendar year when RFP was issued"
    - name: "rfp_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month when RFP was issued, truncated to first day of month"
    - name: "requires_nda"
      expr: requires_nda
      comment: "Indicates whether RFP requires vendors to sign non-disclosure agreement"
    - name: "broadcast_rights_involved"
      expr: broadcast_rights_involved
      comment: "Indicates whether RFP involves broadcast rights"
    - name: "gdpr_applicable"
      expr: gdpr_applicable
      comment: "Indicates whether GDPR compliance is required"
    - name: "pci_dss_required"
      expr: pci_dss_required
      comment: "Indicates whether PCI DSS compliance is required"
    - name: "is_incumbent_eligible"
      expr: is_incumbent_eligible
      comment: "Indicates whether incumbent vendor is eligible to bid"
  measures:
    - name: "estimated_contract_value_total"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across all RFPs, representing procurement pipeline value"
    - name: "awarded_contract_value_total"
      expr: SUM(CAST(awarded_contract_value AS DOUBLE))
      comment: "Total awarded contract value, representing realized procurement value"
    - name: "rfp_count"
      expr: COUNT(DISTINCT rfp_id)
      comment: "Number of distinct RFPs, measuring strategic sourcing activity volume"
    - name: "awarded_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors awarded contracts, indicating vendor selection outcomes"
    - name: "avg_rfp_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated RFP value, indicating typical procurement opportunity size"
    - name: "avg_days_to_award"
      expr: AVG(DATEDIFF(award_date, issue_date))
      comment: "Average days from RFP issue to award, measuring procurement cycle time efficiency"
    - name: "avg_days_evaluation_duration"
      expr: AVG(DATEDIFF(award_date, evaluation_start_date))
      comment: "Average days for RFP evaluation phase, measuring evaluation process efficiency"
    - name: "technical_weight_avg"
      expr: AVG(CAST(technical_weight_pct AS DOUBLE))
      comment: "Average technical evaluation weight percentage, indicating technical criteria importance"
    - name: "price_weight_avg"
      expr: AVG(CAST(price_weight_pct AS DOUBLE))
      comment: "Average price evaluation weight percentage, indicating cost criteria importance"
$$;


CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`partner_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master data and portfolio metrics tracking vendor diversity, risk tier distribution, performance scores, and compliance status"
  source: "`sports_entertainment_ecm`.`partner`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of vendor (active, inactive, suspended, blocked)"
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Vendor tier classification (strategic, preferred, approved, conditional)"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification (low, medium, high, critical)"
    - name: "primary_category"
      expr: primary_category
      comment: "Primary service or product category"
    - name: "secondary_category"
      expr: secondary_category
      comment: "Secondary service or product category"
    - name: "business_type"
      expr: business_type
      comment: "Type of business entity (corporation, LLC, partnership, sole proprietor)"
    - name: "registration_country"
      expr: registration_country
      comment: "Country where vendor is legally registered"
    - name: "minority_owned_flag"
      expr: minority_owned_flag
      comment: "Indicates whether vendor is minority-owned business"
    - name: "small_business_flag"
      expr: small_business_flag
      comment: "Indicates whether vendor qualifies as small business"
    - name: "diversity_certification_type"
      expr: diversity_certification_type
      comment: "Type of diversity certification (MBE, WBE, DBE, SDVOSB)"
    - name: "data_processor_flag"
      expr: data_processor_flag
      comment: "Indicates whether vendor processes personal data under GDPR"
    - name: "nda_executed_flag"
      expr: nda_executed_flag
      comment: "Indicates whether vendor has executed non-disclosure agreement"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Calendar year when vendor was onboarded"
  measures:
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Total number of vendors in portfolio, measuring vendor base size and complexity"
    - name: "performance_score_avg"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average vendor performance score, representing overall vendor portfolio quality"
$$;
