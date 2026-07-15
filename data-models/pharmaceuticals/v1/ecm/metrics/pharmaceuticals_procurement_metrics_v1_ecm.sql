-- Metric views for domain: procurement | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core procurement KPIs tracking purchase order value, volume, cycle time, and quality compliance for strategic sourcing decisions"
  source: "`pharmaceuticals_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Purchase order status (open, approved, closed, cancelled) for pipeline and fulfillment analysis"
    - name: "po_type"
      expr: po_type
      comment: "Purchase order type (standard, blanket, contract, emergency) for procurement strategy segmentation"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the order for organizational performance tracking"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group managing the order for buyer performance and workload analysis"
    - name: "gmp_relevant_flag"
      expr: gmp_relevant_flag
      comment: "Whether the PO is GMP-relevant for regulatory compliance tracking"
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Whether quality inspection is required for quality assurance workload planning"
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Year of purchase order creation for trend analysis"
    - name: "po_quarter"
      expr: CONCAT('Q', QUARTER(po_date))
      comment: "Quarter of purchase order creation for seasonal analysis"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month of purchase order creation for monthly performance tracking"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code for freight cost and risk allocation analysis"
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total purchase order value for spend analysis and budget tracking"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total order value for financial commitment tracking"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for tax liability and compliance reporting"
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges AS DOUBLE))
      comment: "Total freight charges for logistics cost optimization"
    - name: "po_count"
      expr: COUNT(1)
      comment: "Number of purchase orders for volume and workload tracking"
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value for order sizing and efficiency analysis"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors for supplier diversification and concentration risk analysis"
    - name: "gmp_po_count"
      expr: SUM(CASE WHEN gmp_relevant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of GMP-relevant purchase orders for regulatory compliance tracking"
    - name: "gmp_po_percentage"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_relevant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase orders that are GMP-relevant for compliance portfolio assessment"
    - name: "quality_inspection_po_count"
      expr: SUM(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of purchase orders requiring quality inspection for QA resource planning"
    - name: "avg_approval_cycle_days"
      expr: AVG(DATEDIFF(approval_date, po_date))
      comment: "Average days from PO creation to approval for process efficiency measurement"
    - name: "avg_fulfillment_cycle_days"
      expr: AVG(DATEDIFF(confirmed_delivery_date, po_date))
      comment: "Average days from PO creation to confirmed delivery for lead time optimization"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard KPIs for supplier quality management, on-time delivery, and strategic vendor selection decisions"
  source: "`pharmaceuticals_ecm`.`procurement`.`vendor_performance`"
  dimensions:
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Overall vendor performance rating (excellent, good, acceptable, poor) for strategic sourcing decisions"
    - name: "performance_trend"
      expr: performance_trend
      comment: "Performance trend direction (improving, stable, declining) for vendor development prioritization"
    - name: "scorecard_type"
      expr: scorecard_type
      comment: "Type of performance scorecard (quarterly, annual, ad-hoc) for evaluation cadence analysis"
    - name: "evaluation_year"
      expr: YEAR(evaluation_period_start_date)
      comment: "Year of evaluation period for trend analysis"
    - name: "evaluation_quarter"
      expr: CONCAT('Q', QUARTER(evaluation_period_start_date))
      comment: "Quarter of evaluation period for seasonal performance tracking"
    - name: "re_qualification_required_flag"
      expr: re_qualification_required_flag
      comment: "Whether vendor re-qualification is required for compliance and risk management"
  measures:
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage for supplier reliability assessment"
    - name: "avg_in_full_delivery_pct"
      expr: AVG(CAST(in_full_delivery_percentage AS DOUBLE))
      comment: "Average in-full delivery percentage for order fulfillment quality tracking"
    - name: "avg_otif_pct"
      expr: AVG(CAST(otif_percentage AS DOUBLE))
      comment: "Average on-time-in-full percentage for comprehensive delivery performance measurement"
    - name: "avg_coa_compliance_pct"
      expr: AVG(CAST(coa_compliance_percentage AS DOUBLE))
      comment: "Average certificate of analysis compliance percentage for quality documentation adherence"
    - name: "avg_documentation_accuracy_pct"
      expr: AVG(CAST(documentation_accuracy_percentage AS DOUBLE))
      comment: "Average documentation accuracy percentage for regulatory compliance quality"
    - name: "avg_capa_closure_rate_pct"
      expr: AVG(CAST(capa_closure_rate_percentage AS DOUBLE))
      comment: "Average CAPA closure rate percentage for corrective action effectiveness tracking"
    - name: "total_spend_amount"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total spend amount with vendors for strategic sourcing and cost management"
    - name: "total_financial_claims"
      expr: SUM(CAST(financial_claims_amount AS DOUBLE))
      comment: "Total financial claims amount for vendor cost of poor quality measurement"
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score for vendor quality system assessment"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(average_lead_time_days AS DOUBLE))
      comment: "Average lead time in days for supply chain planning and inventory optimization"
    - name: "total_quality_complaints"
      expr: SUM(CAST(quality_complaints_count AS BIGINT))
      comment: "Total quality complaints count for vendor quality issue tracking"
    - name: "total_rejected_lots"
      expr: SUM(CAST(rejected_lots_count AS BIGINT))
      comment: "Total rejected lots count for incoming quality failure rate measurement"
    - name: "total_non_conformances"
      expr: SUM(CAST(non_conformance_count AS BIGINT))
      comment: "Total non-conformance count for quality system effectiveness tracking"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total critical audit findings for high-risk vendor identification"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS BIGINT))
      comment: "Total major audit findings for vendor quality system gap analysis"
    - name: "total_temperature_excursions"
      expr: SUM(CAST(temperature_excursion_count AS BIGINT))
      comment: "Total temperature excursion count for cold chain compliance monitoring"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors evaluated for supplier base management"
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Number of performance evaluations for scorecard activity tracking"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs for receiving efficiency, quality inspection workload, and inventory accuracy tracking"
  source: "`pharmaceuticals_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Goods receipt status (posted, blocked, cancelled) for receiving process monitoring"
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type (unrestricted, quality inspection, blocked) for inventory classification"
    - name: "movement_type"
      expr: movement_type
      comment: "Movement type for transaction classification and audit trail"
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Whether quality inspection is required for QA workload planning"
    - name: "coa_received_flag"
      expr: coa_received_flag
      comment: "Whether certificate of analysis was received for documentation compliance tracking"
    - name: "temperature_excursion_flag"
      expr: temperature_excursion_flag
      comment: "Whether temperature excursion occurred for cold chain quality monitoring"
    - name: "packaging_condition"
      expr: packaging_condition
      comment: "Packaging condition at receipt (good, damaged, acceptable) for quality assessment"
    - name: "receipt_year"
      expr: YEAR(posting_date)
      comment: "Year of goods receipt posting for trend analysis"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of goods receipt posting for monthly receiving performance tracking"
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received for inventory inflow and throughput tracking"
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance for receiving accuracy and vendor performance measurement"
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount for inventory value tracking and financial reporting"
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Number of goods receipts for receiving workload and efficiency tracking"
    - name: "avg_received_quantity"
      expr: AVG(CAST(received_quantity AS DOUBLE))
      comment: "Average quantity per receipt for order sizing and handling efficiency analysis"
    - name: "quality_inspection_gr_count"
      expr: SUM(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of goods receipts requiring quality inspection for QA resource planning"
    - name: "quality_inspection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts requiring quality inspection for compliance workload assessment"
    - name: "coa_received_count"
      expr: SUM(CASE WHEN coa_received_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of goods receipts with COA received for documentation compliance tracking"
    - name: "coa_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN coa_received_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts with COA received for vendor documentation compliance measurement"
    - name: "temperature_excursion_count"
      expr: SUM(CASE WHEN temperature_excursion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of goods receipts with temperature excursions for cold chain quality monitoring"
    - name: "temperature_excursion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_excursion_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts with temperature excursions for cold chain failure rate tracking"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with goods receipts for supplier activity tracking"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_id)
      comment: "Number of unique materials received for inventory diversity tracking"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`procurement_supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit KPIs for vendor quality assurance, GMP compliance, and audit program effectiveness measurement"
  source: "`pharmaceuticals_ecm`.`procurement`.`supplier_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status (planned, in-progress, completed, cancelled) for audit program tracking"
    - name: "audit_type"
      expr: audit_type
      comment: "Audit type (initial, surveillance, for-cause, re-audit) for audit strategy analysis"
    - name: "overall_audit_outcome"
      expr: overall_audit_outcome
      comment: "Overall audit outcome (approved, conditional, not approved) for vendor qualification decisions"
    - name: "gmp_compliance_rating"
      expr: gmp_compliance_rating
      comment: "GMP compliance rating for regulatory quality assessment"
    - name: "gdp_compliance_rating"
      expr: gdp_compliance_rating
      comment: "GDP compliance rating for distribution quality assessment"
    - name: "quality_system_rating"
      expr: quality_system_rating
      comment: "Quality system rating for vendor quality maturity assessment"
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Whether CAPA is required for corrective action workload tracking"
    - name: "audit_year"
      expr: YEAR(actual_start_date)
      comment: "Year of audit start for trend analysis"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(actual_start_date))
      comment: "Quarter of audit start for seasonal audit program tracking"
  measures:
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost AS DOUBLE))
      comment: "Total audit cost for audit program budget tracking and ROI analysis"
    - name: "avg_audit_cost"
      expr: AVG(CAST(audit_cost AS DOUBLE))
      comment: "Average audit cost per audit for cost efficiency benchmarking"
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Number of supplier audits for audit program activity tracking"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total critical findings for high-risk vendor identification and escalation"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS BIGINT))
      comment: "Total major findings for vendor quality system gap analysis"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS BIGINT))
      comment: "Total minor findings for continuous improvement opportunity tracking"
    - name: "total_observations"
      expr: SUM(CAST(observations_count AS BIGINT))
      comment: "Total observations for vendor quality system enhancement opportunities"
    - name: "total_findings"
      expr: SUM(CAST(total_findings_count AS BIGINT))
      comment: "Total findings across all severity levels for overall audit effectiveness measurement"
    - name: "avg_critical_findings_per_audit"
      expr: AVG(CAST(critical_findings_count AS DOUBLE))
      comment: "Average critical findings per audit for vendor quality risk assessment"
    - name: "avg_total_findings_per_audit"
      expr: AVG(CAST(total_findings_count AS DOUBLE))
      comment: "Average total findings per audit for vendor quality maturity benchmarking"
    - name: "avg_audit_duration_days"
      expr: AVG(DATEDIFF(actual_end_date, actual_start_date))
      comment: "Average audit duration in days for audit efficiency and resource planning"
    - name: "avg_capa_cycle_days"
      expr: AVG(DATEDIFF(capa_verification_date, capa_submission_date))
      comment: "Average days from CAPA submission to verification for corrective action effectiveness tracking"
    - name: "capa_required_audit_count"
      expr: SUM(CASE WHEN capa_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits requiring CAPA for corrective action workload planning"
    - name: "capa_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN capa_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring CAPA for vendor quality issue prevalence measurement"
    - name: "distinct_vendor_site_count"
      expr: COUNT(DISTINCT vendor_site_id)
      comment: "Number of unique vendor sites audited for audit program coverage tracking"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`procurement_vendor_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor complaint KPIs for supplier quality issue tracking, CAPA effectiveness, and cost of poor quality measurement"
  source: "`pharmaceuticals_ecm`.`procurement`.`vendor_complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Complaint status (open, under investigation, closed) for complaint resolution tracking"
    - name: "complaint_type"
      expr: complaint_type
      comment: "Complaint type (quality, delivery, documentation, service) for root cause categorization"
    - name: "complaint_severity"
      expr: complaint_severity
      comment: "Complaint severity (critical, major, minor) for prioritization and escalation"
    - name: "complaint_resolution_status"
      expr: complaint_resolution_status
      comment: "Complaint resolution status for closure effectiveness tracking"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic issue identification and prevention"
    - name: "impact_to_product_quality"
      expr: impact_to_product_quality
      comment: "Impact to product quality (high, medium, low, none) for risk assessment"
    - name: "impact_to_patient_safety"
      expr: impact_to_patient_safety
      comment: "Impact to patient safety (high, medium, low, none) for regulatory risk prioritization"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether complaint is regulatory reportable for compliance tracking"
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Whether CAPA is required for corrective action workload planning"
    - name: "financial_claim_status"
      expr: financial_claim_status
      comment: "Financial claim status (pending, approved, rejected, paid) for cost recovery tracking"
    - name: "complaint_year"
      expr: YEAR(complaint_date)
      comment: "Year of complaint for trend analysis"
    - name: "complaint_quarter"
      expr: CONCAT('Q', QUARTER(complaint_date))
      comment: "Quarter of complaint for seasonal quality issue tracking"
  measures:
    - name: "complaint_count"
      expr: COUNT(1)
      comment: "Number of vendor complaints for supplier quality issue volume tracking"
    - name: "total_financial_claims"
      expr: SUM(CAST(financial_claim_amount AS DOUBLE))
      comment: "Total financial claim amount for cost of poor quality measurement and recovery tracking"
    - name: "avg_financial_claim"
      expr: AVG(CAST(financial_claim_amount AS DOUBLE))
      comment: "Average financial claim amount per complaint for quality cost impact assessment"
    - name: "avg_resolution_cycle_days"
      expr: AVG(DATEDIFF(complaint_closure_date, complaint_date))
      comment: "Average days from complaint to closure for resolution efficiency measurement"
    - name: "avg_vendor_response_days"
      expr: AVG(DATEDIFF(vendor_response_date, vendor_notification_date))
      comment: "Average days from vendor notification to response for vendor responsiveness tracking"
    - name: "avg_capa_cycle_days"
      expr: AVG(DATEDIFF(capa_completion_date, capa_due_date))
      comment: "Average days from CAPA due date to completion for corrective action timeliness tracking"
    - name: "critical_complaint_count"
      expr: SUM(CASE WHEN complaint_severity = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical complaints for high-risk vendor quality issue tracking"
    - name: "critical_complaint_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN complaint_severity = 'critical' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints that are critical for severity distribution analysis"
    - name: "regulatory_reportable_count"
      expr: SUM(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of regulatory reportable complaints for compliance risk tracking"
    - name: "regulatory_reportable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints that are regulatory reportable for compliance risk assessment"
    - name: "capa_required_count"
      expr: SUM(CASE WHEN capa_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complaints requiring CAPA for corrective action workload tracking"
    - name: "capa_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN capa_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints requiring CAPA for systemic issue prevalence measurement"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with complaints for supplier quality issue distribution tracking"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT affected_material_code)
      comment: "Number of unique materials with complaints for material quality risk identification"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing event KPIs for strategic sourcing effectiveness, cost savings, and supplier competition measurement"
  source: "`pharmaceuticals_ecm`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Sourcing event status (draft, published, evaluation, awarded, cancelled) for pipeline tracking"
    - name: "event_type"
      expr: event_type
      comment: "Sourcing event type (RFQ, RFP, auction, negotiation) for sourcing strategy analysis"
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category for spend category management and sourcing strategy"
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type (fixed price, cost plus, framework) for commercial model analysis"
    - name: "gmp_requirement_flag"
      expr: gmp_requirement_flag
      comment: "Whether GMP compliance is required for regulatory sourcing tracking"
    - name: "gdp_requirement_flag"
      expr: gdp_requirement_flag
      comment: "Whether GDP compliance is required for distribution quality sourcing"
    - name: "audit_requirement_flag"
      expr: audit_requirement_flag
      comment: "Whether supplier audit is required for quality assurance sourcing"
    - name: "quality_agreement_required"
      expr: quality_agreement_required
      comment: "Whether quality agreement is required for GMP sourcing compliance"
    - name: "event_year"
      expr: YEAR(publication_date)
      comment: "Year of event publication for trend analysis"
    - name: "event_quarter"
      expr: CONCAT('Q', QUARTER(publication_date))
      comment: "Quarter of event publication for seasonal sourcing activity tracking"
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated value of sourcing events for strategic sourcing pipeline tracking"
    - name: "total_awarded_value"
      expr: SUM(CAST(awarded_bid_amount AS DOUBLE))
      comment: "Total awarded bid amount for actual spend commitment tracking"
    - name: "total_savings_achieved"
      expr: SUM(CAST(savings_achieved AS DOUBLE))
      comment: "Total savings achieved for sourcing program ROI and cost reduction measurement"
    - name: "avg_savings_achieved"
      expr: AVG(CAST(savings_achieved AS DOUBLE))
      comment: "Average savings per sourcing event for sourcing effectiveness benchmarking"
    - name: "sourcing_event_count"
      expr: COUNT(1)
      comment: "Number of sourcing events for sourcing activity and workload tracking"
    - name: "avg_invited_vendor_count"
      expr: AVG(CAST(invited_vendor_count AS DOUBLE))
      comment: "Average number of vendors invited per event for competition level assessment"
    - name: "avg_responding_vendor_count"
      expr: AVG(CAST(responding_vendor_count AS DOUBLE))
      comment: "Average number of responding vendors per event for supplier engagement measurement"
    - name: "avg_evaluation_cycle_days"
      expr: AVG(DATEDIFF(evaluation_completion_date, evaluation_start_date))
      comment: "Average evaluation cycle time in days for sourcing process efficiency tracking"
    - name: "avg_award_cycle_days"
      expr: AVG(DATEDIFF(award_date, publication_date))
      comment: "Average days from publication to award for sourcing cycle time optimization"
    - name: "gmp_sourcing_event_count"
      expr: SUM(CASE WHEN gmp_requirement_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of GMP-required sourcing events for regulatory sourcing workload tracking"
    - name: "gmp_sourcing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_requirement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sourcing events requiring GMP for regulatory sourcing portfolio assessment"
    - name: "audit_required_event_count"
      expr: SUM(CASE WHEN audit_requirement_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of sourcing events requiring supplier audit for quality assurance workload planning"
    - name: "distinct_awarded_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors awarded contracts for supplier diversification tracking"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`procurement_incoming_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incoming inspection KPIs for material quality acceptance, inspection efficiency, and supplier quality performance measurement"
  source: "`pharmaceuticals_ecm`.`procurement`.`incoming_inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection status (pending, in-progress, completed, cancelled) for inspection workload tracking"
    - name: "inspection_decision"
      expr: inspection_decision
      comment: "Inspection decision (accepted, rejected, conditional, on-hold) for quality acceptance tracking"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Inspection type (full, reduced, skip-lot, for-cause) for inspection strategy analysis"
    - name: "coa_review_status"
      expr: coa_review_status
      comment: "Certificate of analysis review status for documentation compliance tracking"
    - name: "coa_received_flag"
      expr: coa_received_flag
      comment: "Whether COA was received for vendor documentation compliance measurement"
    - name: "identity_test_result"
      expr: identity_test_result
      comment: "Identity test result (pass, fail, not tested) for material verification tracking"
    - name: "microbiological_test_result"
      expr: microbiological_test_result
      comment: "Microbiological test result for sterility and contamination control tracking"
    - name: "inspection_year"
      expr: YEAR(inspection_start_date)
      comment: "Year of inspection start for trend analysis"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_start_date)
      comment: "Month of inspection start for monthly inspection workload tracking"
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Number of incoming inspections for QA workload and throughput tracking"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received for inspection volume tracking"
    - name: "avg_quantity_received"
      expr: AVG(CAST(quantity_received AS DOUBLE))
      comment: "Average quantity per inspection for lot sizing and efficiency analysis"
    - name: "avg_inspection_cycle_days"
      expr: AVG(DATEDIFF(inspection_completion_date, inspection_start_date))
      comment: "Average inspection cycle time in days for QA efficiency and lead time optimization"
    - name: "accepted_inspection_count"
      expr: SUM(CASE WHEN inspection_decision = 'accepted' THEN 1 ELSE 0 END)
      comment: "Count of accepted inspections for quality acceptance rate tracking"
    - name: "rejected_inspection_count"
      expr: SUM(CASE WHEN inspection_decision = 'rejected' THEN 1 ELSE 0 END)
      comment: "Count of rejected inspections for supplier quality failure tracking"
    - name: "acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_decision = 'accepted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections accepted for incoming quality performance measurement"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_decision = 'rejected' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections rejected for supplier quality issue prevalence tracking"
    - name: "coa_received_count"
      expr: SUM(CASE WHEN coa_received_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of inspections with COA received for vendor documentation compliance tracking"
    - name: "coa_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN coa_received_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections with COA received for vendor documentation compliance measurement"
    - name: "avg_assay_result"
      expr: AVG(CAST(assay_result_value AS DOUBLE))
      comment: "Average assay result value for material potency and quality trending"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors inspected for supplier quality coverage tracking"
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_id)
      comment: "Number of unique materials inspected for material quality diversity tracking"
$$;


CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`procurement_supply_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply contract KPIs for contract value, compliance requirements, and strategic supplier relationship management"
  source: "`pharmaceuticals_ecm`.`procurement`.`supply_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Contract status (active, expired, terminated, draft) for contract portfolio management"
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type (blanket, framework, spot, long-term) for sourcing strategy analysis"
    - name: "material_category"
      expr: material_category
      comment: "Material category for spend category management and sourcing strategy"
    - name: "gmp_compliance_required"
      expr: gmp_compliance_required
      comment: "Whether GMP compliance is required for regulatory contract tracking"
    - name: "gdp_compliance_required"
      expr: gdp_compliance_required
      comment: "Whether GDP compliance is required for distribution quality contract tracking"
    - name: "quality_agreement_required"
      expr: quality_agreement_required
      comment: "Whether quality agreement is required for GMP contract compliance"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether contract auto-renews for contract lifecycle management"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Contract risk rating (high, medium, low) for risk-based contract management"
    - name: "price_basis"
      expr: price_basis
      comment: "Price basis (fixed, variable, indexed) for pricing strategy analysis"
    - name: "contract_year"
      expr: YEAR(effective_start_date)
      comment: "Year of contract start for trend analysis"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value for strategic spend commitment and budget tracking"
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS DOUBLE))
      comment: "Total committed volume for supply assurance and capacity planning"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value for contract sizing and negotiation benchmarking"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of supply contracts for contract portfolio management"
    - name: "active_contract_count"
      expr: SUM(CASE WHEN contract_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active contracts for current supplier relationship tracking"
    - name: "gmp_contract_count"
      expr: SUM(CASE WHEN gmp_compliance_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of GMP-required contracts for regulatory contract portfolio tracking"
    - name: "gmp_contract_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_compliance_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts requiring GMP for regulatory contract portfolio assessment"
    - name: "quality_agreement_contract_count"
      expr: SUM(CASE WHEN quality_agreement_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts requiring quality agreement for quality assurance contract tracking"
    - name: "auto_renewal_contract_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of auto-renewal contracts for contract lifecycle management"
    - name: "avg_contract_duration_months"
      expr: AVG(DATEDIFF(effective_end_date, effective_start_date) / 30.0)
      comment: "Average contract duration in months for contract term strategy analysis"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with contracts for supplier diversification tracking"
$$;
