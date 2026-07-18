-- Metric views for domain: sourcing | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:03:30

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for Quotation strategic metrics tracking RFQ effectiveness, vendor competition, cost targeting, and award performance"
  source: "`apparel_fashion_ecm`.`sourcing`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (open, closed, awarded, cancelled)"
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (fabric, trim, CMT, full package)"
    - name: "sourcing_region"
      expr: sourcing_region
      comment: "Geographic region targeted for sourcing"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the RFQ"
    - name: "material_type"
      expr: material_type
      comment: "Type of material being sourced"
    - name: "destination_country"
      expr: destination_country
      comment: "Destination country for the sourced goods"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the RFQ was issued"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the RFQ was issued"
  measures:
    - name: "total_rfqs"
      expr: COUNT(1)
      comment: "Total number of RFQs issued"
    - name: "total_awarded_quote_value"
      expr: SUM(CAST(awarded_quote_amount AS DOUBLE))
      comment: "Total value of awarded quotes across all RFQs"
    - name: "avg_awarded_quote_value"
      expr: AVG(CAST(awarded_quote_amount AS DOUBLE))
      comment: "Average awarded quote amount per RFQ"
    - name: "total_target_cost"
      expr: SUM(CAST(target_cost AS DOUBLE))
      comment: "Total target cost across all RFQs"
    - name: "avg_target_cost"
      expr: AVG(CAST(target_cost AS DOUBLE))
      comment: "Average target cost per RFQ"
    - name: "rfq_award_rate"
      expr: COUNT(DISTINCT CASE WHEN vendor_id IS NOT NULL THEN rfq_id END) * 100.0 / NULLIF(COUNT(DISTINCT rfq_id), 0)
      comment: "Percentage of RFQs that resulted in vendor awards"
    - name: "distinct_awarded_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors awarded RFQs"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_vendor_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor quote competitiveness and pricing metrics for sourcing decision-making"
  source: "`apparel_fashion_ecm`.`sourcing`.`vendor_quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Status of the vendor quote (submitted, accepted, rejected, expired)"
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance status of the quote"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the quote is denominated"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms for the quote"
    - name: "port_of_loading"
      expr: port_of_loading
      comment: "Port from which goods will be shipped"
    - name: "quality_certification"
      expr: quality_certification
      comment: "Quality certification offered by vendor"
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification offered by vendor"
    - name: "quote_year"
      expr: YEAR(quote_date)
      comment: "Year the quote was submitted"
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month the quote was submitted"
  measures:
    - name: "total_quotes"
      expr: COUNT(1)
      comment: "Total number of vendor quotes received"
    - name: "avg_fob_price"
      expr: AVG(CAST(fob_price AS DOUBLE))
      comment: "Average FOB price across all quotes"
    - name: "avg_cmt_rate"
      expr: AVG(CAST(cmt_rate AS DOUBLE))
      comment: "Average CMT (Cut-Make-Trim) rate across quotes"
    - name: "avg_material_cost"
      expr: AVG(CAST(material_cost AS DOUBLE))
      comment: "Average material cost per quote"
    - name: "avg_ldp_estimate"
      expr: AVG(CAST(ldp_estimate AS DOUBLE))
      comment: "Average landed duty paid cost estimate"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost_estimate AS DOUBLE))
      comment: "Average freight cost estimate per quote"
    - name: "avg_benchmark_score"
      expr: AVG(CAST(benchmark_score AS DOUBLE))
      comment: "Average benchmark score for vendor quotes"
    - name: "quote_acceptance_rate"
      expr: COUNT(DISTINCT CASE WHEN acceptance_status = 'accepted' THEN vendor_quote_id END) * 100.0 / NULLIF(COUNT(DISTINCT vendor_quote_id), 0)
      comment: "Percentage of quotes that were accepted"
    - name: "distinct_vendors_quoting"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors submitting quotes"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing purchase order financial and operational performance metrics including OTIF and landed cost analysis"
  source: "`apparel_fashion_ecm`.`sourcing`.`sourcing_purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (fabric, trim, CMT, full package)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where goods are manufactured"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order"
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms for the order"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with vendor"
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification for the order"
    - name: "otif_flag"
      expr: otif_flag
      comment: "On-time in-full delivery flag"
    - name: "sample_approval_status"
      expr: sample_approval_status
      comment: "Status of sample approval for the order"
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Year the purchase order was created"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the purchase order was created"
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of sourcing purchase orders"
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of all purchase orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average purchase order value"
    - name: "total_landed_cost"
      expr: SUM(CAST(landed_cost AS DOUBLE))
      comment: "Total landed cost across all orders"
    - name: "avg_landed_cost"
      expr: AVG(CAST(landed_cost AS DOUBLE))
      comment: "Average landed cost per order"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all orders"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total duty amount across all orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all orders"
    - name: "otif_rate"
      expr: COUNT(CASE WHEN otif_flag = TRUE THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "On-time in-full delivery rate percentage"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with purchase orders"
    - name: "distinct_factories"
      expr: COUNT(DISTINCT supplier_factory_id)
      comment: "Number of unique supplier factories with orders"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_vendor_cost_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed cost breakdown metrics for vendor quotes enabling cost structure analysis and margin planning"
  source: "`apparel_fashion_ecm`.`sourcing`.`vendor_cost_quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Status of the cost quote"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost quote"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the quote"
    - name: "quote_year"
      expr: YEAR(quote_date)
      comment: "Year the cost quote was submitted"
    - name: "quote_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month the cost quote was submitted"
  measures:
    - name: "total_cost_quotes"
      expr: COUNT(1)
      comment: "Total number of vendor cost quotes"
    - name: "avg_fob_cost"
      expr: AVG(CAST(fob_cost AS DOUBLE))
      comment: "Average FOB cost per quote"
    - name: "avg_cmt_cost"
      expr: AVG(CAST(cmt_cost AS DOUBLE))
      comment: "Average CMT cost per quote"
    - name: "avg_fabric_cost"
      expr: AVG(CAST(fabric_cost AS DOUBLE))
      comment: "Average fabric cost per quote"
    - name: "avg_trim_cost"
      expr: AVG(CAST(trim_cost AS DOUBLE))
      comment: "Average trim cost per quote"
    - name: "avg_embellishment_cost"
      expr: AVG(CAST(embellishment_cost AS DOUBLE))
      comment: "Average embellishment cost per quote"
    - name: "avg_packaging_cost"
      expr: AVG(CAST(packaging_cost AS DOUBLE))
      comment: "Average packaging cost per quote"
    - name: "avg_testing_certification_cost"
      expr: AVG(CAST(testing_certification_cost AS DOUBLE))
      comment: "Average testing and certification cost per quote"
    - name: "avg_ldp_cost"
      expr: AVG(CAST(ldp_cost AS DOUBLE))
      comment: "Average landed duty paid cost"
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per quote"
    - name: "avg_duty_cost"
      expr: AVG(CAST(duty_cost AS DOUBLE))
      comment: "Average duty cost per quote"
    - name: "avg_agent_commission"
      expr: AVG(CAST(agent_commission AS DOUBLE))
      comment: "Average agent commission per quote"
    - name: "avg_target_imu_percent"
      expr: AVG(CAST(target_imu_percent AS DOUBLE))
      comment: "Average target initial markup percentage"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors providing cost quotes"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_sample_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample request cycle time and approval metrics tracking product development efficiency"
  source: "`apparel_fashion_ecm`.`sourcing`.`sample_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the sample request"
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample requested (proto, fit, PP, SMS, etc.)"
    - name: "approval_decision"
      expr: approval_decision
      comment: "Final approval decision for the sample"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the sample request"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the sample"
    - name: "measurement_conformance_status"
      expr: measurement_conformance_status
      comment: "Whether sample measurements conform to spec"
    - name: "color_accuracy_evaluation"
      expr: color_accuracy_evaluation
      comment: "Evaluation of color accuracy"
    - name: "request_year"
      expr: YEAR(created_timestamp)
      comment: "Year the sample was requested"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the sample was requested"
  measures:
    - name: "total_sample_requests"
      expr: COUNT(1)
      comment: "Total number of sample requests"
    - name: "avg_sample_cost_fob"
      expr: AVG(CAST(sample_cost_fob AS DOUBLE))
      comment: "Average FOB cost per sample"
    - name: "total_sample_cost"
      expr: SUM(CAST(sample_cost_fob AS DOUBLE))
      comment: "Total sample cost across all requests"
    - name: "sample_approval_rate"
      expr: COUNT(CASE WHEN approval_decision = 'approved' THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of samples approved on submission"
    - name: "distinct_styles_sampled"
      expr: COUNT(DISTINCT style_id)
      comment: "Number of unique styles with sample requests"
    - name: "distinct_factories_sampling"
      expr: COUNT(DISTINCT supplier_factory_id)
      comment: "Number of unique factories submitting samples"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_sample_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sample quality evaluation metrics tracking fit, construction, color, and material compliance scores"
  source: "`apparel_fashion_ecm`.`sourcing`.`sample_evaluation`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the evaluation (in progress, completed, pending)"
    - name: "overall_approval_decision"
      expr: overall_approval_decision
      comment: "Overall approval decision for the sample"
    - name: "sample_type"
      expr: sample_type
      comment: "Type of sample being evaluated"
    - name: "fit_evaluation_score"
      expr: fit_evaluation_score
      comment: "Fit evaluation score"
    - name: "construction_quality_score"
      expr: construction_quality_score
      comment: "Construction quality score"
    - name: "color_accuracy_score"
      expr: color_accuracy_score
      comment: "Color accuracy score"
    - name: "material_compliance_score"
      expr: material_compliance_score
      comment: "Material compliance score"
    - name: "evaluator_role"
      expr: evaluator_role
      comment: "Role of the person evaluating the sample"
    - name: "rejection_reason_category"
      expr: rejection_reason_category
      comment: "Category of rejection reason if sample was rejected"
    - name: "measurement_deviation_flag"
      expr: measurement_deviation_flag
      comment: "Flag indicating measurement deviation from spec"
    - name: "resubmission_required_flag"
      expr: resubmission_required_flag
      comment: "Flag indicating if resubmission is required"
    - name: "pp_approval_flag"
      expr: pp_approval_flag
      comment: "Pre-production approval flag"
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Year the evaluation was conducted"
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month the evaluation was conducted"
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of sample evaluations conducted"
    - name: "sample_approval_rate"
      expr: COUNT(CASE WHEN overall_approval_decision = 'approved' THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of samples approved after evaluation"
    - name: "pp_approval_rate"
      expr: COUNT(CASE WHEN pp_approval_flag = TRUE THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Pre-production approval rate percentage"
    - name: "resubmission_rate"
      expr: COUNT(CASE WHEN resubmission_required_flag = TRUE THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of samples requiring resubmission"
    - name: "measurement_deviation_rate"
      expr: COUNT(CASE WHEN measurement_deviation_flag = TRUE THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of samples with measurement deviations"
    - name: "distinct_styles_evaluated"
      expr: COUNT(DISTINCT style_id)
      comment: "Number of unique styles evaluated"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_lab_dip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lab dip color approval metrics tracking color accuracy, fastness ratings, and submission cycle efficiency"
  source: "`apparel_fashion_ecm`.`sourcing`.`lab_dip`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the lab dip"
    - name: "color_standard_type"
      expr: color_standard_type
      comment: "Type of color standard used (Pantone, LAB, etc.)"
    - name: "submission_round"
      expr: submission_round
      comment: "Round number of lab dip submission"
    - name: "color_fastness_rating"
      expr: color_fastness_rating
      comment: "Color fastness rating"
    - name: "light_fastness_grade"
      expr: light_fastness_grade
      comment: "Light fastness grade"
    - name: "wash_fastness_grade"
      expr: wash_fastness_grade
      comment: "Wash fastness grade"
    - name: "is_strike_off_required"
      expr: is_strike_off_required
      comment: "Flag indicating if strike-off is required"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for lab dip rejection"
    - name: "season_code"
      expr: season_code
      comment: "Season code for the lab dip"
    - name: "collection_name"
      expr: collection_name
      comment: "Collection name"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the lab dip was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the lab dip was submitted"
  measures:
    - name: "total_lab_dips"
      expr: COUNT(1)
      comment: "Total number of lab dips submitted"
    - name: "avg_delta_e_value"
      expr: AVG(CAST(delta_e_value AS DOUBLE))
      comment: "Average Delta E color difference value"
    - name: "lab_dip_approval_rate"
      expr: COUNT(CASE WHEN approval_status = 'approved' THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of lab dips approved"
    - name: "first_submission_approval_rate"
      expr: COUNT(CASE WHEN approval_status = 'approved' AND submission_round = '1' THEN 1 END) * 100.0 / NULLIF(COUNT(CASE WHEN submission_round = '1' THEN 1 END), 0)
      comment: "Percentage of lab dips approved on first submission"
    - name: "distinct_colorways"
      expr: COUNT(DISTINCT colorway_id)
      comment: "Number of unique colorways with lab dips"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors submitting lab dips"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sourcing_tna_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing time-and-action milestone performance metrics tracking on-time delivery, delays, and critical path adherence"
  source: "`apparel_fashion_ecm`.`sourcing`.`sourcing_tna_milestone`"
  dimensions:
    - name: "milestone_name"
      expr: milestone_name
      comment: "Name of the TNA milestone"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of milestone (sample, approval, production, shipment)"
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category of the milestone"
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the milestone"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status if approval is required"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating if milestone is on critical path"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating if milestone has been escalated"
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Code for delay reason"
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Type of party responsible for the milestone"
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year the milestone was planned"
    - name: "planned_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month the milestone was planned"
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of TNA milestones"
    - name: "on_time_completion_rate"
      expr: COUNT(CASE WHEN actual_date <= planned_date THEN 1 END) * 100.0 / NULLIF(COUNT(CASE WHEN actual_date IS NOT NULL THEN 1 END), 0)
      comment: "Percentage of milestones completed on or before planned date"
    - name: "critical_path_on_time_rate"
      expr: COUNT(CASE WHEN is_critical_path = TRUE AND actual_date <= planned_date THEN 1 END) * 100.0 / NULLIF(COUNT(CASE WHEN is_critical_path = TRUE AND actual_date IS NOT NULL THEN 1 END), 0)
      comment: "On-time completion rate for critical path milestones"
    - name: "escalation_rate"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of milestones that were escalated"
    - name: "distinct_purchase_orders"
      expr: COUNT(DISTINCT sourcing_purchase_order_id)
      comment: "Number of unique purchase orders tracked"
    - name: "distinct_styles"
      expr: COUNT(DISTINCT style_id)
      comment: "Number of unique styles tracked in TNA"
$$;
