-- Metric views for domain: sourcing | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing purchase order metrics tracking order value, delivery performance, landed costs, and compliance across vendors and factories"
  source: "`apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g., draft, approved, in-transit, received)"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., fabric, trim, finished goods, CMT)"
    - name: "product_category"
      expr: product_category
      comment: "Product category being sourced (e.g., apparel, footwear, accessories)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the goods are manufactured"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms defining delivery responsibilities (e.g., FOB, CIF, DDP)"
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification status or type (e.g., GOTS, OEKO-TEX, Fair Trade)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with vendor (e.g., Net 30, Net 60, LC at sight)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the purchase order is denominated"
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Year the purchase order was created"
    - name: "po_quarter"
      expr: CONCAT('Q', QUARTER(po_date))
      comment: "Quarter the purchase order was created"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the purchase order was created"
    - name: "otif_flag"
      expr: otif_flag
      comment: "On-Time In-Full delivery flag indicating whether order met delivery commitments"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Flag indicating whether quality inspection is required for this order"
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of sourcing purchase orders"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of all purchase orders in original currency"
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost AS DOUBLE))
      comment: "Total landed cost including freight, duty, and taxes"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight costs across all purchase orders"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total duty amounts paid on imported goods"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts on purchase orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average purchase order value"
    - name: "avg_landed_cost"
      expr: AVG(CAST(landed_cost AS DOUBLE))
      comment: "Average landed cost per purchase order"
    - name: "otif_order_count"
      expr: SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of orders delivered on-time and in-full"
    - name: "otif_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of orders delivered on-time and in-full - key supplier performance metric"
    - name: "sustainable_po_count"
      expr: SUM(CASE WHEN sustainability_certification IS NOT NULL AND sustainability_certification != '' THEN 1 ELSE 0 END)
      comment: "Count of purchase orders with sustainability certification"
    - name: "sustainability_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainability_certification IS NOT NULL AND sustainability_certification != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase orders with sustainability certification - tracks ESG compliance"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors across purchase orders"
    - name: "distinct_factory_count"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of unique production factories used"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_purchase_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed line-level sourcing metrics tracking unit costs, quantities, delivery performance, and quality status by SKU and style"
  source: "`apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the purchase order line (e.g., open, shipped, received, cancelled)"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the line item"
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection status (e.g., passed, failed, pending)"
    - name: "pp_approval_status"
      expr: pp_approval_status
      comment: "Pre-production sample approval status"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the line item is manufactured"
    - name: "style_code"
      expr: style_code
      comment: "Style code for the product being sourced"
    - name: "color_code"
      expr: color_code
      comment: "Color code for the product"
    - name: "size_code"
      expr: size_code
      comment: "Size code for the product"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the line is priced"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantities (e.g., pieces, yards, meters)"
    - name: "costing_method"
      expr: costing_method
      comment: "Costing method used (e.g., FOB, CMT, landed)"
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample if applicable (e.g., proto, SMS, PP)"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for this line"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of purchase order lines"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all lines"
    - name: "total_outstanding_quantity"
      expr: SUM(CAST(outstanding_quantity AS DOUBLE))
      comment: "Total quantity still outstanding (not yet received)"
    - name: "total_line_cost"
      expr: SUM(CAST(line_total_cost AS DOUBLE))
      comment: "Total cost across all purchase order lines"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across all lines"
    - name: "fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been received - key supply chain efficiency metric"
    - name: "quality_pass_count"
      expr: SUM(CASE WHEN quality_status = 'passed' THEN 1 ELSE 0 END)
      comment: "Count of lines that passed quality inspection"
    - name: "quality_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_status = 'passed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lines passing quality inspection - critical quality control metric"
    - name: "pp_approved_count"
      expr: SUM(CASE WHEN pp_approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of lines with approved pre-production samples"
    - name: "pp_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pp_approval_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lines with approved pre-production samples - tracks development efficiency"
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs across purchase order lines"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors across lines"
    - name: "distinct_factory_count"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of unique production factories across lines"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_vendor_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor quote analysis metrics tracking pricing competitiveness, lead times, capacity, and quote acceptance rates for sourcing decisions"
  source: "`apparel_fashion_ecm`.`sourcing`.`vendor_quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the vendor quote (e.g., submitted, under review, accepted, rejected)"
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance decision status for the quote"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for quote rejection if applicable"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm specified in the quote"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the quote is provided"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms offered by vendor"
    - name: "quality_certification"
      expr: quality_certification
      comment: "Quality certifications held by vendor"
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certifications held by vendor"
    - name: "port_of_loading"
      expr: port_of_loading
      comment: "Port from which goods will be shipped"
    - name: "quote_year"
      expr: YEAR(quote_date)
      comment: "Year the quote was submitted"
    - name: "quote_quarter"
      expr: CONCAT('Q', QUARTER(quote_date))
      comment: "Quarter the quote was submitted"
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month the quote was submitted"
  measures:
    - name: "total_quote_count"
      expr: COUNT(1)
      comment: "Total number of vendor quotes received"
    - name: "avg_fob_price"
      expr: AVG(CAST(fob_price AS DOUBLE))
      comment: "Average FOB price across all quotes"
    - name: "avg_cmt_rate"
      expr: AVG(CAST(cmt_rate AS DOUBLE))
      comment: "Average cut-make-trim rate across quotes"
    - name: "avg_material_cost"
      expr: AVG(CAST(material_cost AS DOUBLE))
      comment: "Average material cost quoted by vendors"
    - name: "avg_ldp_estimate"
      expr: AVG(CAST(ldp_estimate AS DOUBLE))
      comment: "Average landed duty paid cost estimate"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost_estimate AS DOUBLE))
      comment: "Average freight cost estimate across quotes"
    - name: "avg_sample_cost"
      expr: AVG(CAST(sample_cost AS DOUBLE))
      comment: "Average sample development cost"
    - name: "avg_tooling_cost"
      expr: AVG(CAST(tooling_cost AS DOUBLE))
      comment: "Average tooling and setup cost"
    - name: "avg_benchmark_score"
      expr: AVG(CAST(benchmark_score AS DOUBLE))
      comment: "Average benchmark score for vendor quotes - tracks vendor competitiveness"
    - name: "accepted_quote_count"
      expr: SUM(CASE WHEN acceptance_status = 'accepted' THEN 1 ELSE 0 END)
      comment: "Count of quotes that were accepted"
    - name: "quote_acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN acceptance_status = 'accepted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes accepted - measures vendor competitiveness and sourcing efficiency"
    - name: "sustainable_quote_count"
      expr: SUM(CASE WHEN sustainability_certification IS NOT NULL AND sustainability_certification != '' THEN 1 ELSE 0 END)
      comment: "Count of quotes with sustainability certification"
    - name: "sustainable_quote_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainability_certification IS NOT NULL AND sustainability_certification != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotes with sustainability certification - tracks sustainable sourcing progress"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors submitting quotes"
    - name: "distinct_rfq_count"
      expr: COUNT(DISTINCT rfq_id)
      comment: "Number of unique RFQs receiving quotes"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for Quote metrics tracking RFQ cycle efficiency, vendor response rates, award decisions, and cost targets"
  source: "`apparel_fashion_ecm`.`sourcing`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g., open, closed, awarded, cancelled)"
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g., fabric, trim, finished goods, CMT)"
    - name: "product_category"
      expr: product_category
      comment: "Product category being sourced"
    - name: "material_type"
      expr: material_type
      comment: "Type of material being sourced"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the sourcing request"
    - name: "sourcing_region"
      expr: sourcing_region
      comment: "Geographic region targeted for sourcing"
    - name: "destination_country"
      expr: destination_country
      comment: "Destination country for the goods"
    - name: "shipping_origin_country"
      expr: shipping_origin_country
      comment: "Country from which goods will be shipped"
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms specified in the RFQ"
    - name: "sustainability_requirement"
      expr: sustainability_requirement
      comment: "Sustainability requirements specified in RFQ"
    - name: "quality_standard"
      expr: quality_standard
      comment: "Quality standards required"
    - name: "sample_required_flag"
      expr: sample_required_flag
      comment: "Flag indicating whether samples are required"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the RFQ was issued"
    - name: "issue_quarter"
      expr: CONCAT('Q', QUARTER(issue_date))
      comment: "Quarter the RFQ was issued"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the RFQ was issued"
  measures:
    - name: "total_rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued"
    - name: "avg_target_cost"
      expr: AVG(CAST(target_cost AS DOUBLE))
      comment: "Average target cost across RFQs"
    - name: "total_target_cost"
      expr: SUM(CAST(target_cost AS DOUBLE))
      comment: "Total target cost across all RFQs"
    - name: "avg_awarded_quote_amount"
      expr: AVG(CAST(awarded_quote_amount AS DOUBLE))
      comment: "Average awarded quote amount"
    - name: "total_awarded_quote_amount"
      expr: SUM(CAST(awarded_quote_amount AS DOUBLE))
      comment: "Total value of awarded quotes"
    - name: "awarded_rfq_count"
      expr: SUM(CASE WHEN vendor_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of RFQs that have been awarded"
    - name: "rfq_award_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vendor_id IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs that have been awarded - measures sourcing decision velocity"
    - name: "cost_savings_pct"
      expr: ROUND(100.0 * (SUM(CAST(target_cost AS DOUBLE)) - SUM(CAST(awarded_quote_amount AS DOUBLE))) / NULLIF(SUM(CAST(target_cost AS DOUBLE)), 0), 2)
      comment: "Percentage cost savings achieved vs target - key procurement efficiency metric"
    - name: "sample_required_count"
      expr: SUM(CASE WHEN sample_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of RFQs requiring samples"
    - name: "sustainable_rfq_count"
      expr: SUM(CASE WHEN sustainability_requirement IS NOT NULL AND sustainability_requirement != '' THEN 1 ELSE 0 END)
      comment: "Count of RFQs with sustainability requirements"
    - name: "sustainable_rfq_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainability_requirement IS NOT NULL AND sustainability_requirement != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs with sustainability requirements - tracks sustainable sourcing commitment"
    - name: "distinct_awarded_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors awarded RFQs"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing agreement metrics tracking contract value, pricing, capacity commitments, compliance, and renewal status across vendor partnerships"
  source: "`apparel_fashion_ecm`.`sourcing`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., draft, active, expired, terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g., master, blanket, spot buy, framework)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the agreement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the agreement is denominated"
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms specified in the agreement"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated in the agreement"
    - name: "season_code"
      expr: season_code
      comment: "Season code associated with the agreement"
    - name: "quality_standard"
      expr: quality_standard
      comment: "Quality standards required by the agreement"
    - name: "sustainability_requirement"
      expr: sustainability_requirement
      comment: "Sustainability requirements specified in the agreement"
    - name: "compliance_certification_required"
      expr: compliance_certification_required
      comment: "Compliance certifications required by the agreement"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether agreement auto-renews"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Flag indicating whether agreement includes exclusivity terms"
    - name: "fob_port_code"
      expr: fob_port_code
      comment: "FOB port specified in the agreement"
    - name: "destination_port_code"
      expr: destination_port_code
      comment: "Destination port specified in the agreement"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the agreement became effective"
  measures:
    - name: "total_agreement_count"
      expr: COUNT(1)
      comment: "Total number of sourcing agreements"
    - name: "active_agreement_count"
      expr: SUM(CASE WHEN agreement_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active agreements"
    - name: "avg_base_fob_price"
      expr: AVG(CAST(base_fob_price AS DOUBLE))
      comment: "Average base FOB price across agreements"
    - name: "avg_base_cmt_rate"
      expr: AVG(CAST(base_cmt_rate AS DOUBLE))
      comment: "Average base CMT rate across agreements"
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume_quantity AS DOUBLE))
      comment: "Total committed volume across all agreements"
    - name: "avg_committed_volume"
      expr: AVG(CAST(committed_volume_quantity AS DOUBLE))
      comment: "Average committed volume per agreement"
    - name: "avg_capacity_allocation_pct"
      expr: AVG(CAST(capacity_allocation_percent AS DOUBLE))
      comment: "Average capacity allocation percentage - measures vendor capacity commitment"
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across agreements"
    - name: "exclusive_agreement_count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of agreements with exclusivity terms"
    - name: "exclusivity_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with exclusivity - tracks strategic vendor partnerships"
    - name: "auto_renewal_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of agreements with auto-renewal"
    - name: "auto_renewal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with auto-renewal - measures vendor relationship stability"
    - name: "sustainable_agreement_count"
      expr: SUM(CASE WHEN sustainability_requirement IS NOT NULL AND sustainability_requirement != '' THEN 1 ELSE 0 END)
      comment: "Count of agreements with sustainability requirements"
    - name: "sustainable_agreement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainability_requirement IS NOT NULL AND sustainability_requirement != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements with sustainability requirements - tracks ESG compliance in sourcing"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with agreements"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_sample_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample evaluation metrics tracking approval rates, quality scores, revision cycles, and time-to-approval for product development"
  source: "`apparel_fashion_ecm`.`sourcing`.`sample_evaluation`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the sample evaluation (e.g., in progress, completed, pending resubmission)"
    - name: "overall_approval_decision"
      expr: overall_approval_decision
      comment: "Overall approval decision (e.g., approved, rejected, conditional)"
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample being evaluated (e.g., proto, SMS, PP, TOP)"
    - name: "rejection_reason_category"
      expr: rejection_reason_category
      comment: "Category of rejection reason if sample was rejected"
    - name: "pp_approval_flag"
      expr: pp_approval_flag
      comment: "Flag indicating whether pre-production sample was approved"
    - name: "measurement_deviation_flag"
      expr: measurement_deviation_flag
      comment: "Flag indicating whether measurements deviated from spec"
    - name: "resubmission_required_flag"
      expr: resubmission_required_flag
      comment: "Flag indicating whether sample resubmission is required"
    - name: "photo_documentation_flag"
      expr: photo_documentation_flag
      comment: "Flag indicating whether photo documentation was provided"
    - name: "evaluator_role"
      expr: evaluator_role
      comment: "Role of the person evaluating the sample (e.g., designer, technical designer, QA)"
    - name: "revision_round"
      expr: revision_round
      comment: "Revision round number for the sample"
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Year the evaluation was conducted"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month the evaluation was conducted"
  measures:
    - name: "total_evaluation_count"
      expr: COUNT(1)
      comment: "Total number of sample evaluations conducted"
    - name: "approved_sample_count"
      expr: SUM(CASE WHEN overall_approval_decision = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of samples approved"
    - name: "sample_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_approval_decision = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples approved on evaluation - key product development efficiency metric"
    - name: "pp_approved_count"
      expr: SUM(CASE WHEN pp_approval_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of pre-production samples approved"
    - name: "pp_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pp_approval_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pre-production samples approved - critical go-to-production gate metric"
    - name: "first_pass_approval_count"
      expr: SUM(CASE WHEN overall_approval_decision = 'approved' AND revision_round = '1' THEN 1 ELSE 0 END)
      comment: "Count of samples approved on first submission"
    - name: "first_pass_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_approval_decision = 'approved' AND revision_round = '1' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples approved on first submission - measures development quality and vendor capability"
    - name: "resubmission_required_count"
      expr: SUM(CASE WHEN resubmission_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of evaluations requiring sample resubmission"
    - name: "resubmission_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN resubmission_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples requiring resubmission - inverse indicator of development efficiency"
    - name: "measurement_deviation_count"
      expr: SUM(CASE WHEN measurement_deviation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of samples with measurement deviations"
    - name: "measurement_conformance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN measurement_deviation_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of samples meeting measurement specifications - quality control metric"
    - name: "distinct_style_count"
      expr: COUNT(DISTINCT style_id)
      comment: "Number of unique styles evaluated"
    - name: "distinct_evaluator_count"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique evaluators"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_tna_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time and action milestone metrics tracking on-time performance, delays, critical path adherence, and approval cycle efficiency"
  source: "`apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of TNA milestone (e.g., fabric approval, sample submission, bulk production start)"
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category of milestone (e.g., design, sourcing, production, logistics)"
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the milestone (e.g., completed, in progress, delayed, not started)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status if approval is required"
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Flag indicating whether approval is required for this milestone"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating whether milestone is on the critical path"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating whether milestone has been escalated"
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Code for the reason of delay if milestone is delayed"
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Type of party responsible for the milestone (e.g., internal, vendor, factory)"
    - name: "milestone_code"
      expr: milestone_code
      comment: "Standard code for the milestone"
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year the milestone was planned"
    - name: "planned_quarter"
      expr: CONCAT('Q', QUARTER(planned_date))
      comment: "Quarter the milestone was planned"
    - name: "planned_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month the milestone was planned"
  measures:
    - name: "total_milestone_count"
      expr: COUNT(1)
      comment: "Total number of TNA milestones"
    - name: "completed_milestone_count"
      expr: SUM(CASE WHEN completion_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed milestones"
    - name: "milestone_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones completed - overall TNA execution metric"
    - name: "on_time_milestone_count"
      expr: SUM(CASE WHEN actual_date IS NOT NULL AND actual_date <= planned_date THEN 1 ELSE 0 END)
      comment: "Count of milestones completed on or before planned date"
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_date IS NOT NULL AND actual_date <= planned_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN actual_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of completed milestones that were on-time - critical supply chain performance metric"
    - name: "delayed_milestone_count"
      expr: SUM(CASE WHEN actual_date IS NOT NULL AND actual_date > planned_date THEN 1 ELSE 0 END)
      comment: "Count of milestones completed late"
    - name: "critical_path_milestone_count"
      expr: SUM(CASE WHEN is_critical_path = TRUE THEN 1 ELSE 0 END)
      comment: "Count of milestones on the critical path"
    - name: "critical_path_on_time_count"
      expr: SUM(CASE WHEN is_critical_path = TRUE AND actual_date IS NOT NULL AND actual_date <= planned_date THEN 1 ELSE 0 END)
      comment: "Count of critical path milestones completed on time"
    - name: "critical_path_on_time_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_critical_path = TRUE AND actual_date IS NOT NULL AND actual_date <= planned_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_critical_path = TRUE AND actual_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of critical path milestones completed on time - highest priority schedule metric"
    - name: "escalated_milestone_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of milestones that have been escalated"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones requiring escalation - indicates execution risk"
    - name: "approval_required_count"
      expr: SUM(CASE WHEN approval_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of milestones requiring approval"
    - name: "approved_milestone_count"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of milestones that have been approved"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN approval_required_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of approval-required milestones that are approved - tracks approval bottlenecks"
    - name: "distinct_style_count"
      expr: COUNT(DISTINCT style_id)
      comment: "Number of unique styles tracked in TNA"
    - name: "distinct_po_count"
      expr: COUNT(DISTINCT sourcing_purchase_order_id)
      comment: "Number of unique purchase orders tracked in TNA"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_vendor_cost_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed vendor cost breakdown metrics tracking FOB, CMT, fabric, trim, freight, duty, and margin components for cost analysis and negotiation"
  source: "`apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the cost quote"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which costs are quoted"
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm for the cost quote"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the quote"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the cost quote"
    - name: "quote_version"
      expr: quote_version
      comment: "Version number of the quote"
    - name: "moq_unit"
      expr: moq_unit
      comment: "Unit of measure for minimum order quantity"
    - name: "quote_year"
      expr: YEAR(quote_date)
      comment: "Year the cost quote was provided"
    - name: "quote_quarter"
      expr: CONCAT('Q', QUARTER(quote_date))
      comment: "Quarter the cost quote was provided"
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month the cost quote was provided"
  measures:
    - name: "total_cost_quote_count"
      expr: COUNT(1)
      comment: "Total number of vendor cost quotes"
    - name: "avg_fob_cost"
      expr: AVG(CAST(fob_cost AS DOUBLE))
      comment: "Average FOB cost across quotes"
    - name: "avg_cmt_cost"
      expr: AVG(CAST(cmt_cost AS DOUBLE))
      comment: "Average cut-make-trim cost"
    - name: "avg_fabric_cost"
      expr: AVG(CAST(fabric_cost AS DOUBLE))
      comment: "Average fabric cost component"
    - name: "avg_trim_cost"
      expr: AVG(CAST(trim_cost AS DOUBLE))
      comment: "Average trim cost component"
    - name: "avg_embellishment_cost"
      expr: AVG(CAST(embellishment_cost AS DOUBLE))
      comment: "Average embellishment cost"
    - name: "avg_packaging_cost"
      expr: AVG(CAST(packaging_cost AS DOUBLE))
      comment: "Average packaging cost"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost"
    - name: "avg_duty_cost"
      expr: AVG(CAST(duty_cost AS DOUBLE))
      comment: "Average duty cost"
    - name: "avg_ldp_cost"
      expr: AVG(CAST(ldp_cost AS DOUBLE))
      comment: "Average landed duty paid cost"
    - name: "avg_testing_certification_cost"
      expr: AVG(CAST(testing_certification_cost AS DOUBLE))
      comment: "Average testing and certification cost"
    - name: "avg_agent_commission"
      expr: AVG(CAST(agent_commission AS DOUBLE))
      comment: "Average agent commission"
    - name: "avg_sample_cost"
      expr: AVG(CAST(sample_cost AS DOUBLE))
      comment: "Average sample development cost"
    - name: "avg_cogs_estimate"
      expr: AVG(CAST(cogs_estimate AS DOUBLE))
      comment: "Average cost of goods sold estimate"
    - name: "avg_target_imu_pct"
      expr: AVG(CAST(target_imu_percent AS DOUBLE))
      comment: "Average target initial markup percentage - key profitability planning metric"
    - name: "avg_target_retail_price"
      expr: AVG(CAST(target_retail_price AS DOUBLE))
      comment: "Average target retail price"
    - name: "fabric_cost_pct_of_fob"
      expr: ROUND(100.0 * SUM(CAST(fabric_cost AS DOUBLE)) / NULLIF(SUM(CAST(fob_cost AS DOUBLE)), 0), 2)
      comment: "Fabric cost as percentage of FOB - measures material cost efficiency"
    - name: "cmt_cost_pct_of_fob"
      expr: ROUND(100.0 * SUM(CAST(cmt_cost AS DOUBLE)) / NULLIF(SUM(CAST(fob_cost AS DOUBLE)), 0), 2)
      comment: "CMT cost as percentage of FOB - measures labor cost efficiency"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors providing cost quotes"
    - name: "distinct_style_count"
      expr: COUNT(DISTINCT style_id)
      comment: "Number of unique styles quoted"
$$;
