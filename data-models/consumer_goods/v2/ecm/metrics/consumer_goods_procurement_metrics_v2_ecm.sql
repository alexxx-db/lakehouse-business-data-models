-- Metric views for domain: procurement | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core procurement KPIs tracking purchase order value, volume, cycle time, and on-time delivery performance"
  source: "`vibe_consumer_goods_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the purchase order was created"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the purchase order was created"
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, contract, etc.)"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the order"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group handling the order"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms for delivery"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation for the order"
    - name: "vmi_indicator"
      expr: vmi_indicator
      comment: "Whether this is a vendor-managed inventory order"
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification associated with the order"
  measures:
    - name: "total_order_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of all purchase orders including tax and freight"
    - name: "net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Net value of purchase orders excluding tax and freight"
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across all purchase orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all purchase orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average purchase order value"
    - name: "freight_to_order_value_pct"
      expr: ROUND(100.0 * SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_order_value AS DOUBLE)), 0), 2)
      comment: "Freight cost as percentage of net order value"
    - name: "avg_procurement_cycle_days"
      expr: AVG(DATEDIFF(confirmed_delivery_date, order_date))
      comment: "Average days from order creation to confirmed delivery date"
    - name: "vmi_order_count"
      expr: SUM(CASE WHEN vmi_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vendor-managed inventory orders"
    - name: "vmi_penetration_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vmi_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders that are vendor-managed inventory"
    - name: "sustainable_order_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certification IS NOT NULL THEN purchase_order_id END)
      comment: "Count of orders with sustainability certification"
    - name: "sustainable_order_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sustainability_certification IS NOT NULL THEN purchase_order_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders with sustainability certification"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier portfolio KPIs tracking supplier count, diversity, certification compliance, and risk profile"
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current status of the supplier"
    - name: "supplier_type"
      expr: supplier_type
      comment: "Type or category of supplier"
    - name: "country_code"
      expr: country_code
      comment: "Country where supplier is located"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the supplier"
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Diversity classification of the supplier"
    - name: "tier"
      expr: tier
      comment: "Supplier tier classification"
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status of the supplier"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms for the supplier"
    - name: "currency_code"
      expr: currency_code
      comment: "Default currency for supplier transactions"
    - name: "iso_9001_certified"
      expr: iso_9001_certified_flag
      comment: "Whether supplier is ISO 9001 certified"
    - name: "gmp_certified"
      expr: gmp_certified_flag
      comment: "Whether supplier is GMP certified"
    - name: "fsc_certified"
      expr: fsc_certified_flag
      comment: "Whether supplier is FSC certified"
    - name: "rspo_certified"
      expr: rspo_certified_flag
      comment: "Whether supplier is RSPO certified"
    - name: "vmi_eligible"
      expr: vmi_eligible_flag
      comment: "Whether supplier is eligible for vendor-managed inventory"
    - name: "edi_capable"
      expr: edi_capable_flag
      comment: "Whether supplier has EDI capability"
  measures:
    - name: "total_supplier_count"
      expr: COUNT(1)
      comment: "Total number of suppliers in the portfolio"
    - name: "active_supplier_count"
      expr: SUM(CASE WHEN supplier_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active suppliers"
    - name: "avg_supplier_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average performance score across all suppliers"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days across suppliers"
    - name: "avg_moq_quantity"
      expr: AVG(CAST(moq_quantity AS DOUBLE))
      comment: "Average minimum order quantity across suppliers"
    - name: "iso_9001_certified_count"
      expr: SUM(CASE WHEN iso_9001_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ISO 9001 certified suppliers"
    - name: "iso_9001_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN iso_9001_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with ISO 9001 certification"
    - name: "gmp_certified_count"
      expr: SUM(CASE WHEN gmp_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of GMP certified suppliers"
    - name: "gmp_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with GMP certification"
    - name: "sustainable_certified_count"
      expr: SUM(CASE WHEN fsc_certified_flag = TRUE OR rspo_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of suppliers with sustainability certifications (FSC or RSPO)"
    - name: "sustainable_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fsc_certified_flag = TRUE OR rspo_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with sustainability certifications"
    - name: "vmi_eligible_count"
      expr: SUM(CASE WHEN vmi_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of suppliers eligible for vendor-managed inventory"
    - name: "vmi_eligibility_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vmi_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers eligible for VMI programs"
    - name: "edi_capable_count"
      expr: SUM(CASE WHEN edi_capable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of suppliers with EDI capability"
    - name: "edi_capability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN edi_capable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with EDI capability"
    - name: "diverse_supplier_count"
      expr: SUM(CASE WHEN diversity_classification IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of suppliers with diversity classification"
    - name: "diverse_supplier_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN diversity_classification IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with diversity classification"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable KPIs tracking invoice volume, value, payment performance, and three-way match accuracy"
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO, GR, Invoice)"
    - name: "tolerance_check_result"
      expr: tolerance_check_result
      comment: "Result of tolerance check for invoice variances"
    - name: "blocking_reason_code"
      expr: blocking_reason_code
      comment: "Code indicating reason for invoice blocking"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment for the invoice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice"
    - name: "company_code"
      expr: company_code
      comment: "Company code for the invoice"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax amount"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross amount captured as discounts"
    - name: "avg_payment_cycle_days"
      expr: AVG(DATEDIFF(payment_date, invoice_date))
      comment: "Average days from invoice date to payment date"
    - name: "avg_days_to_post"
      expr: AVG(DATEDIFF(posting_date, invoice_receipt_date))
      comment: "Average days from invoice receipt to posting"
    - name: "three_way_match_pass_count"
      expr: SUM(CASE WHEN three_way_match_status = 'Passed' THEN 1 ELSE 0 END)
      comment: "Count of invoices that passed three-way match"
    - name: "three_way_match_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN three_way_match_status = 'Passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices passing three-way match on first attempt"
    - name: "blocked_invoice_count"
      expr: SUM(CASE WHEN blocking_reason_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of invoices currently blocked"
    - name: "blocked_invoice_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN blocking_reason_code IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices blocked for payment"
    - name: "paid_invoice_count"
      expr: SUM(CASE WHEN payment_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of invoices that have been paid"
    - name: "payment_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that have been paid"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving operations KPIs tracking receipt volume, quality compliance, and on-time in-full (OTIF) performance"
  source: "`vibe_consumer_goods_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "receipt_year"
      expr: YEAR(posting_date)
      comment: "Year the goods receipt was posted"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the goods receipt was posted"
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt"
    - name: "movement_type"
      expr: movement_type
      comment: "Type of inventory movement"
    - name: "receiving_plant_code"
      expr: receiving_plant_code
      comment: "Plant code where goods were received"
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location where goods were placed"
    - name: "quality_inspection_required"
      expr: quality_inspection_required_flag
      comment: "Whether quality inspection is required"
    - name: "certificate_of_analysis_received"
      expr: certificate_of_analysis_received_flag
      comment: "Whether certificate of analysis was received"
    - name: "otif_compliance"
      expr: otif_compliance_flag
      comment: "Whether receipt met on-time in-full criteria"
    - name: "gr_reversal"
      expr: gr_reversal_flag
      comment: "Whether this is a goods receipt reversal"
    - name: "sustainable_sourcing_certification"
      expr: sustainable_sourcing_certification
      comment: "Sustainability certification for the received goods"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt valuation"
  measures:
    - name: "total_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received"
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount of goods received"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received goods"
    - name: "avg_received_quantity"
      expr: AVG(CAST(received_quantity AS DOUBLE))
      comment: "Average quantity per goods receipt"
    - name: "otif_compliant_count"
      expr: SUM(CASE WHEN otif_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts meeting on-time in-full criteria"
    - name: "otif_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts meeting OTIF criteria"
    - name: "quality_inspection_required_count"
      expr: SUM(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts requiring quality inspection"
    - name: "quality_inspection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts requiring quality inspection"
    - name: "coa_received_count"
      expr: SUM(CASE WHEN certificate_of_analysis_received_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts with certificate of analysis received"
    - name: "coa_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certificate_of_analysis_received_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with certificate of analysis"
    - name: "reversal_count"
      expr: SUM(CASE WHEN gr_reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of goods receipt reversals"
    - name: "reversal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gr_reversal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts that were reversed"
    - name: "sustainable_receipt_count"
      expr: COUNT(DISTINCT CASE WHEN sustainable_sourcing_certification IS NOT NULL THEN goods_receipt_id END)
      comment: "Count of receipts with sustainability certification"
    - name: "sustainable_receipt_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sustainable_sourcing_certification IS NOT NULL THEN goods_receipt_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with sustainability certification"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance management KPIs tracking quality, delivery, cost, and overall supplier performance scores"
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard`"
  dimensions:
    - name: "evaluation_year"
      expr: YEAR(evaluation_period_end_date)
      comment: "Year of the evaluation period end"
    - name: "evaluation_quarter"
      expr: QUARTER(evaluation_period_end_date)
      comment: "Quarter of the evaluation period end"
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Status of the supplier scorecard"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier assigned to the supplier"
    - name: "trend_vs_prior_period"
      expr: trend_vs_prior_period
      comment: "Performance trend compared to prior period"
    - name: "action_plan_required"
      expr: action_plan_required_flag
      comment: "Whether an action plan is required for improvement"
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended action based on scorecard results"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for purchase value metrics"
  measures:
    - name: "total_scorecard_count"
      expr: COUNT(1)
      comment: "Total number of supplier scorecards"
    - name: "avg_overall_weighted_score"
      expr: AVG(CAST(overall_weighted_score AS DOUBLE))
      comment: "Average overall weighted performance score across suppliers"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality performance score"
    - name: "avg_otif_score"
      expr: AVG(CAST(otif_score AS DOUBLE))
      comment: "Average on-time in-full delivery score"
    - name: "avg_cost_competitiveness_score"
      expr: AVG(CAST(cost_competitiveness_score AS DOUBLE))
      comment: "Average cost competitiveness score"
    - name: "avg_invoice_accuracy_score"
      expr: AVG(CAST(invoice_accuracy_score AS DOUBLE))
      comment: "Average invoice accuracy score"
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness score"
    - name: "avg_innovation_collaboration_score"
      expr: AVG(CAST(innovation_collaboration_score AS DOUBLE))
      comment: "Average innovation and collaboration score"
    - name: "avg_sustainability_compliance_score"
      expr: AVG(CAST(sustainability_compliance_score AS DOUBLE))
      comment: "Average sustainability compliance score"
    - name: "avg_regulatory_adherence_score"
      expr: AVG(CAST(regulatory_adherence_score AS DOUBLE))
      comment: "Average regulatory adherence score"
    - name: "avg_otif_delivery_rate"
      expr: AVG(CAST(otif_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time in-full delivery rate percentage"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate_pct AS DOUBLE))
      comment: "Average invoice accuracy rate percentage"
    - name: "avg_quality_rejection_rate_ppm"
      expr: AVG(CAST(quality_rejection_rate_ppm AS DOUBLE))
      comment: "Average quality rejection rate in parts per million"
    - name: "total_purchase_value"
      expr: SUM(CAST(total_purchase_value AS DOUBLE))
      comment: "Total purchase value across all evaluated suppliers"
    - name: "avg_purchase_value_per_supplier"
      expr: AVG(CAST(total_purchase_value AS DOUBLE))
      comment: "Average purchase value per supplier"
    - name: "action_plan_required_count"
      expr: SUM(CASE WHEN action_plan_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of suppliers requiring action plans"
    - name: "action_plan_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN action_plan_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers requiring action plans"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_spend_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend category management KPIs tracking category coverage, strategic importance, and sourcing strategy effectiveness"
  source: "`vibe_consumer_goods_v1`.`procurement`.`spend_category`"
  dimensions:
    - name: "category_level"
      expr: category_level
      comment: "Hierarchical level of the spend category"
    - name: "category_status"
      expr: category_status
      comment: "Status of the spend category"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity in the category"
    - name: "strategic_importance"
      expr: strategic_importance
      comment: "Strategic importance rating of the category"
    - name: "risk_profile"
      expr: risk_profile
      comment: "Risk profile of the spend category"
    - name: "preferred_sourcing_strategy"
      expr: preferred_sourcing_strategy
      comment: "Preferred sourcing strategy for the category"
    - name: "procurement_organization"
      expr: procurement_organization
      comment: "Procurement organization managing the category"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group responsible for the category"
    - name: "sustainable_sourcing"
      expr: sustainable_sourcing_flag
      comment: "Whether sustainable sourcing is required for the category"
    - name: "sds_required"
      expr: sds_required_flag
      comment: "Whether safety data sheet is required for the category"
    - name: "moq_applicable"
      expr: moq_applicable_flag
      comment: "Whether minimum order quantity applies to the category"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for spend budget metrics"
  measures:
    - name: "total_category_count"
      expr: COUNT(1)
      comment: "Total number of spend categories"
    - name: "active_category_count"
      expr: SUM(CASE WHEN category_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active spend categories"
    - name: "total_annual_spend_budget"
      expr: SUM(CAST(annual_spend_budget_amount AS DOUBLE))
      comment: "Total annual spend budget across all categories"
    - name: "avg_annual_spend_budget"
      expr: AVG(CAST(annual_spend_budget_amount AS DOUBLE))
      comment: "Average annual spend budget per category"
    - name: "avg_contract_coverage_pct"
      expr: AVG(CAST(contract_coverage_percentage AS DOUBLE))
      comment: "Average contract coverage percentage across categories"
    - name: "avg_cost_savings_target_pct"
      expr: AVG(CAST(cost_savings_target_percentage AS DOUBLE))
      comment: "Average cost savings target percentage"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days_typical AS DOUBLE))
      comment: "Average typical lead time in days across categories"
    - name: "strategic_category_count"
      expr: SUM(CASE WHEN strategic_importance IN ('High', 'Critical') THEN 1 ELSE 0 END)
      comment: "Count of strategically important categories"
    - name: "strategic_category_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN strategic_importance IN ('High', 'Critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of categories with high strategic importance"
    - name: "sustainable_sourcing_category_count"
      expr: SUM(CASE WHEN sustainable_sourcing_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of categories requiring sustainable sourcing"
    - name: "sustainable_sourcing_category_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainable_sourcing_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of categories with sustainable sourcing requirements"
    - name: "high_risk_category_count"
      expr: SUM(CASE WHEN risk_profile IN ('High', 'Critical') THEN 1 ELSE 0 END)
      comment: "Count of high-risk spend categories"
    - name: "high_risk_category_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_profile IN ('High', 'Critical') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of categories with high risk profile"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for quotation KPIs tracking sourcing event effectiveness, supplier participation, and competitive bidding outcomes"
  source: "`vibe_consumer_goods_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_year"
      expr: YEAR(issue_date)
      comment: "Year the RFQ was issued"
    - name: "rfq_quarter"
      expr: QUARTER(issue_date)
      comment: "Quarter the RFQ was issued"
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ"
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ"
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category for the RFQ"
    - name: "commodity_subcategory"
      expr: commodity_subcategory
      comment: "Commodity subcategory for the RFQ"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm specified in the RFQ"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for the RFQ"
    - name: "requires_quality_certification"
      expr: requires_quality_certification
      comment: "Whether quality certification is required"
    - name: "requires_sds"
      expr: requires_sds
      comment: "Whether safety data sheet is required"
    - name: "requires_sustainability_declaration"
      expr: requires_sustainability_declaration
      comment: "Whether sustainability declaration is required"
  measures:
    - name: "total_rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued"
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all RFQs"
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per RFQ"
    - name: "total_estimated_volume"
      expr: SUM(CAST(estimated_volume AS DOUBLE))
      comment: "Total estimated volume across all RFQs"
    - name: "avg_estimated_volume"
      expr: AVG(CAST(estimated_volume AS DOUBLE))
      comment: "Average estimated volume per RFQ"
    - name: "avg_suppliers_invited"
      expr: AVG(CAST(supplier_count_invited AS DOUBLE))
      comment: "Average number of suppliers invited per RFQ"
    - name: "avg_suppliers_responded"
      expr: AVG(CAST(supplier_count_responded AS DOUBLE))
      comment: "Average number of suppliers who responded per RFQ"
    - name: "avg_supplier_response_rate"
      expr: ROUND(100.0 * AVG(CAST(supplier_count_responded AS DOUBLE)) / NULLIF(AVG(CAST(supplier_count_invited AS DOUBLE)), 0), 2)
      comment: "Average supplier response rate as percentage of invited suppliers"
    - name: "awarded_rfq_count"
      expr: SUM(CASE WHEN award_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of RFQs that have been awarded"
    - name: "award_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN award_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs that have been awarded"
    - name: "avg_rfq_cycle_days"
      expr: AVG(DATEDIFF(award_date, issue_date))
      comment: "Average days from RFQ issue to award"
    - name: "quality_cert_required_count"
      expr: SUM(CASE WHEN requires_quality_certification = TRUE THEN 1 ELSE 0 END)
      comment: "Count of RFQs requiring quality certification"
    - name: "quality_cert_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_quality_certification = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs requiring quality certification"
    - name: "sustainability_required_count"
      expr: SUM(CASE WHEN requires_sustainability_declaration = TRUE THEN 1 ELSE 0 END)
      comment: "Count of RFQs requiring sustainability declaration"
    - name: "sustainability_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_sustainability_declaration = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs requiring sustainability declaration"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract management KPIs tracking contract value, coverage, renewal risk, and compliance with terms"
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_contract`"
  dimensions:
    - name: "contract_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of supplier contract"
    - name: "pricing_mechanism"
      expr: pricing_mechanism
      comment: "Pricing mechanism defined in the contract"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms specified in the contract"
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms specified in the contract"
    - name: "auto_renewal"
      expr: auto_renewal_flag
      comment: "Whether the contract has auto-renewal enabled"
    - name: "sds_required"
      expr: sds_required_flag
      comment: "Whether safety data sheet is required"
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification required by the contract"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization managing the contract"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group responsible for the contract"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract"
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of supplier contracts"
    - name: "active_contract_count"
      expr: SUM(CASE WHEN contract_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active supplier contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_total AS DOUBLE))
      comment: "Total value of all supplier contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_total AS DOUBLE))
      comment: "Average value per supplier contract"
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity_total AS DOUBLE))
      comment: "Total target quantity across all contracts"
    - name: "avg_target_quantity"
      expr: AVG(CAST(target_quantity_total AS DOUBLE))
      comment: "Average target quantity per contract"
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across contracts"
    - name: "avg_maximum_order_quantity"
      expr: AVG(CAST(maximum_order_quantity AS DOUBLE))
      comment: "Average maximum order quantity across contracts"
    - name: "avg_contract_duration_days"
      expr: AVG(DATEDIFF(expiry_date, effective_date))
      comment: "Average contract duration in days"
    - name: "auto_renewal_contract_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts with auto-renewal"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with auto-renewal enabled"
    - name: "expiring_soon_count"
      expr: SUM(CASE WHEN DATEDIFF(expiry_date, CURRENT_DATE()) <= 90 AND contract_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active contracts expiring within 90 days"
    - name: "terminated_contract_count"
      expr: SUM(CASE WHEN termination_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of contracts that have been terminated"
    - name: "sustainable_contract_count"
      expr: SUM(CASE WHEN sustainability_certification IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of contracts with sustainability certification requirements"
    - name: "sustainable_contract_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainability_certification IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with sustainability requirements"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial invoice line KPIs"
  source: "`vibe_consumer_goods_v1`.`procurement`.`invoice_line`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice line"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of invoice line creation"
  measures:
    - name: "total_line_net_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Sum of net amounts for invoice lines"
    - name: "total_line_tax_amount"
      expr: SUM(CAST(line_tax_amount AS DOUBLE))
      comment: "Sum of tax amounts for invoice lines"
    - name: "average_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied on invoice lines"
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Number of invoice line records"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial planning KPIs for purchase requisitions"
  source: "`vibe_consumer_goods_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "priority"
      expr: priority
      comment: "Priority level of the requisition"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Business type of the requisition"
    - name: "requested_month"
      expr: DATE_TRUNC('month', requested_date)
      comment: "Month the requisition was requested"
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Sum of estimated total value for requisitions"
    - name: "average_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across requisitions"
    - name: "requisition_count"
      expr: COUNT(1)
      comment: "Number of purchase requisitions"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing efficiency KPIs"
  source: "`vibe_consumer_goods_v1`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event"
    - name: "event_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the event was created"
  measures:
    - name: "total_awarded_savings_amount"
      expr: SUM(CAST(awarded_savings_amount AS DOUBLE))
      comment: "Total savings awarded from sourcing events"
    - name: "total_baseline_spend_amount"
      expr: SUM(CAST(baseline_spend_amount AS DOUBLE))
      comment: "Total baseline spend amount for sourcing events"
    - name: "sourcing_event_count"
      expr: COUNT(1)
      comment: "Number of sourcing events"
$$;