-- Metric views for domain: procurement | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order volume, spend, compliance, and cycle efficiency. Enables procurement leadership to monitor order flow, supplier concentration, and approval health."
  source: "`vibe_restaurants_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Draft, Approved, Received, Closed). Used to segment open vs. closed spend."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Blanket, Emergency). Drives procurement channel analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO. Identifies bottlenecks in the approval pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the purchase order is denominated. Supports multi-currency spend analysis."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the purchase order was placed. Enables trend analysis of procurement spend over time."
    - name: "order_year"
      expr: DATE_TRUNC('YEAR', order_date)
      comment: "Year the purchase order was placed. Supports annual spend benchmarking."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the purchase order (e.g. High, Normal, Low). Identifies urgency distribution across the order portfolio."
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating whether the purchase order was marked urgent. Tracks emergency procurement frequency."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the purchase order passed compliance checks. Used to monitor procurement policy adherence."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of goods receipt against the purchase order. Tracks fulfillment completion."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Baseline volume metric for procurement throughput analysis."
    - name: "total_gross_spend"
      expr: SUM(CAST(total_amount_gross AS DOUBLE))
      comment: "Total gross spend across all purchase orders. Primary financial KPI for procurement budget tracking and supplier spend management."
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend (after discounts) across purchase orders. Used to measure realized procurement savings vs. gross commitment."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across purchase orders. Supports tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured across purchase orders. Measures negotiated savings realized through procurement."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across purchase orders. Identifies logistics cost as a component of total procurement spend."
    - name: "avg_gross_spend_per_po"
      expr: AVG(CAST(total_amount_gross AS DOUBLE))
      comment: "Average gross spend per purchase order. Benchmarks typical order size and flags anomalous high-value orders."
    - name: "urgent_po_count"
      expr: COUNT(CASE WHEN is_urgent = TRUE THEN 1 END)
      comment: "Number of purchase orders flagged as urgent. High urgency rates signal supply chain instability or poor demand planning."
    - name: "non_compliant_po_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of purchase orders that failed compliance checks. Drives corrective action in procurement policy enforcement."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers used across purchase orders. Measures supplier diversification and concentration risk."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of goods ordered across purchase orders. Supports logistics planning and freight cost benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance KPIs derived from scorecard evaluations. Enables procurement leadership to rank, compare, and act on supplier quality, delivery, and compliance performance."
  source: "`vibe_restaurants_v1`.`procurement`.`supplier_scorecard`"
  dimensions:
    - name: "supplier_category"
      expr: supplier_category
      comment: "Category of the supplier being evaluated (e.g. Food, Packaging, Equipment). Enables category-level performance benchmarking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status recorded on the scorecard. Identifies suppliers with regulatory or contractual compliance issues."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the supplier at time of evaluation. Supports risk-tiered supplier management decisions."
    - name: "supplier_scorecard_status"
      expr: supplier_scorecard_status
      comment: "Lifecycle status of the scorecard record (e.g. Active, Archived). Filters to current vs. historical evaluations."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start)
      comment: "Month the evaluation period started. Enables trend analysis of supplier performance over time."
    - name: "region"
      expr: region
      comment: "Geographic region of the supplier. Supports regional procurement performance analysis."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score across evaluations. Primary KPI for supplier ranking and strategic sourcing decisions."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across supplier scorecards. Directly impacts restaurant operations and inventory availability."
    - name: "avg_quality_rejection_rate"
      expr: AVG(CAST(quality_rejection_rate AS DOUBLE))
      comment: "Average quality rejection rate across supplier scorecards. High rejection rates drive supplier corrective action or disqualification."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate. Measures billing quality and reduces AP reconciliation overhead."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average order fill rate across supplier scorecards. Measures supplier ability to fulfill ordered quantities, critical for supply continuity."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average supplier responsiveness score. Measures how quickly suppliers respond to inquiries and issues."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across supplier evaluations. Supports ESG-driven procurement strategy and supplier selection."
    - name: "avg_cost_savings_percent"
      expr: AVG(CAST(cost_savings_percent AS DOUBLE))
      comment: "Average cost savings percentage delivered by suppliers. Quantifies procurement value creation through supplier negotiations."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(average_lead_time_days AS DOUBLE))
      comment: "Average supplier lead time in days. Informs safety stock levels and procurement planning horizons."
    - name: "evaluated_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers evaluated. Measures breadth of supplier performance monitoring coverage."
    - name: "scorecard_count"
      expr: COUNT(1)
      comment: "Total number of scorecard evaluations. Baseline for evaluation frequency and supplier review cadence analysis."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs. Enables finance and procurement to monitor invoice accuracy, dispute rates, payment performance, and COGS impact."
  source: "`vibe_restaurants_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the supplier invoice. Identifies invoices pending approval vs. cleared for payment."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g. Paid, Pending, Overdue). Core dimension for cash flow and AP aging analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of supplier invoice (e.g. Standard, Credit Note, Adjustment). Enables invoice portfolio composition analysis."
    - name: "supplier_invoice_status"
      expr: supplier_invoice_status
      comment: "Lifecycle status of the invoice record. Filters active vs. closed invoices."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice. Supports multi-currency AP analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued. Enables monthly AP volume and spend trend analysis."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether the invoice is under dispute. High dispute rates signal supplier billing quality issues."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to pay the invoice (e.g. ACH, Wire, Check). Supports payment channel optimization."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices. Baseline AP volume metric."
    - name: "total_gross_invoiced_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoiced amount across all supplier invoices. Primary AP spend KPI for budget vs. actuals tracking."
    - name: "total_net_invoiced_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoiced amount after discounts. Measures realized AP liability."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across supplier invoices. Supports tax liability and compliance reporting."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment or negotiated discounts captured. Measures AP-driven cost savings."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute. High dispute counts indicate supplier billing quality problems requiring escalation."
    - name: "avg_cogs_percentage"
      expr: AVG(CAST(cogs_percentage AS DOUBLE))
      comment: "Average COGS percentage across invoices. Tracks supplier invoice contribution to cost of goods sold, a key restaurant profitability driver."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied across foreign-currency invoices. Supports FX exposure monitoring in global procurement."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers invoiced. Measures active supplier base breadth in AP."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing KPIs covering event volume, award values, budget utilization, and competitive bidding health. Enables category managers and CPOs to evaluate sourcing effectiveness."
  source: "`vibe_restaurants_v1`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (e.g. RFP, RFQ, Auction). Enables analysis of sourcing strategy mix."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the sourcing event (e.g. Draft, Active, Awarded, Cancelled). Tracks pipeline health."
    - name: "category_scope"
      expr: category_scope
      comment: "Procurement category scope of the sourcing event. Enables category-level sourcing activity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the sourcing event is denominated. Supports multi-currency award value analysis."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month the sourcing event started. Enables trend analysis of sourcing activity over time."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Flag indicating whether the sourcing event is confidential. Supports governance and access control reporting."
    - name: "award_decision"
      expr: award_decision
      comment: "Outcome of the sourcing event award decision. Tracks award rates and decision patterns."
  measures:
    - name: "total_sourcing_events"
      expr: COUNT(1)
      comment: "Total number of sourcing events. Baseline metric for sourcing activity volume and team throughput."
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total value awarded through sourcing events. Primary KPI for measuring strategic sourcing impact on procurement spend."
    - name: "total_sourcing_budget"
      expr: SUM(CAST(total_budget AS DOUBLE))
      comment: "Total budget allocated across sourcing events. Enables budget utilization analysis against awarded amounts."
    - name: "avg_award_amount"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average award value per sourcing event. Benchmarks deal size and identifies outlier high-value events."
    - name: "awarded_event_count"
      expr: COUNT(CASE WHEN award_decision IS NOT NULL AND award_decision != '' THEN 1 END)
      comment: "Number of sourcing events that resulted in an award. Measures sourcing pipeline conversion rate."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers engaged across sourcing events. Measures competitive market coverage in sourcing."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_sourcing_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier bid and response quality KPIs. Enables category managers to evaluate competitive intensity, pricing competitiveness, and supplier eligibility across sourcing events."
  source: "`vibe_restaurants_v1`.`procurement`.`sourcing_response`"
  dimensions:
    - name: "award_status"
      expr: award_status
      comment: "Award outcome for the sourcing response (e.g. Awarded, Not Awarded, Pending). Tracks win/loss distribution across suppliers."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid submitted (e.g. Initial, Revised, Best and Final). Enables bid round analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assessed for the supplier response. Supports risk-adjusted sourcing decisions."
    - name: "sourcing_response_status"
      expr: sourcing_response_status
      comment: "Lifecycle status of the sourcing response. Filters active vs. disqualified responses."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bid. Supports multi-currency price comparison."
    - name: "is_eligible"
      expr: is_eligible
      comment: "Flag indicating whether the supplier response met eligibility criteria. Measures qualification pass rate."
    - name: "is_preferred_supplier"
      expr: is_preferred_supplier
      comment: "Flag indicating whether the responding supplier is on the preferred supplier list. Tracks preferred supplier participation in sourcing."
  measures:
    - name: "total_response_count"
      expr: COUNT(1)
      comment: "Total number of sourcing responses received. Measures competitive intensity and supplier engagement in sourcing events."
    - name: "total_net_price"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net price across all sourcing responses. Aggregates bid value for budget vs. market price analysis."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average unit price bid across sourcing responses. Benchmarks market pricing and identifies outlier bids."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across supplier responses. Measures supplier regulatory and contractual compliance quality in bids."
    - name: "avg_scoring_total"
      expr: AVG(CAST(scoring_total AS DOUBLE))
      comment: "Average total evaluation score across sourcing responses. Primary KPI for comparing supplier bid quality."
    - name: "avg_supplier_rating"
      expr: AVG(CAST(supplier_rating AS DOUBLE))
      comment: "Average supplier rating at time of response. Correlates historical performance with bid quality."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount offered across sourcing responses. Measures negotiated savings potential from competitive bidding."
    - name: "eligible_response_count"
      expr: COUNT(CASE WHEN is_eligible = TRUE THEN 1 END)
      comment: "Number of responses that met eligibility criteria. Measures effective competitive pool size per sourcing event."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers submitting responses. Measures supplier market breadth and competitive intensity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_supplier_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier risk KPIs for monitoring financial stability, dependency concentration, and compliance exposure. Enables CPO and risk teams to prioritize mitigation actions."
  source: "`vibe_restaurants_v1`.`procurement`.`supplier_risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g. Financial, Operational, Compliance, Geopolitical). Enables risk portfolio analysis by type."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned to the supplier (e.g. Tier 1, Tier 2, Tier 3). Drives prioritization of risk mitigation resources."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk record (e.g. Open, Mitigated, Closed). Tracks risk resolution progress."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the supplier. Enables regional concentration risk analysis."
    - name: "single_source_dependency"
      expr: single_source_dependency
      comment: "Flag indicating single-source dependency on this supplier. Critical supply chain vulnerability indicator."
    - name: "compliance_fda_flag"
      expr: compliance_fda_flag
      comment: "Flag indicating FDA compliance status. Tracks food safety regulatory risk across the supplier base."
    - name: "compliance_osha_flag"
      expr: compliance_osha_flag
      comment: "Flag indicating OSHA compliance status. Tracks workplace safety regulatory risk."
  measures:
    - name: "total_risk_records"
      expr: COUNT(1)
      comment: "Total number of supplier risk records. Baseline for risk portfolio size and monitoring coverage."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across supplier risk assessments. Primary KPI for overall supplier risk exposure level."
    - name: "avg_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score across suppliers. Identifies financially vulnerable suppliers that pose supply continuity risk."
    - name: "avg_dependency_percentage"
      expr: AVG(CAST(dependency_percentage AS DOUBLE))
      comment: "Average spend dependency percentage on assessed suppliers. High dependency signals concentration risk requiring diversification."
    - name: "single_source_supplier_count"
      expr: COUNT(CASE WHEN single_source_dependency = TRUE THEN 1 END)
      comment: "Number of suppliers with single-source dependency. Quantifies critical supply chain vulnerability requiring strategic mitigation."
    - name: "open_risk_count"
      expr: COUNT(CASE WHEN risk_status = 'Open' THEN 1 END)
      comment: "Number of open (unresolved) supplier risk records. Tracks outstanding risk exposure requiring active management."
    - name: "distinct_at_risk_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers with active risk records. Measures breadth of supplier risk exposure across the supply base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_approved_vendor_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved vendor list (AVL) KPIs for monitoring vendor qualification status, risk scores, and compliance health. Enables procurement governance and audit readiness."
  source: "`vibe_restaurants_v1`.`procurement`.`approved_vendor_list`"
  dimensions:
    - name: "approved_status"
      expr: approved_status
      comment: "Approval status of the vendor on the AVL (e.g. Approved, Pending, Suspended). Core dimension for vendor qualification analysis."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g. Distributor, Manufacturer, Broker). Enables vendor portfolio composition analysis."
    - name: "vendor_category_code"
      expr: vendor_category_code
      comment: "Category code assigned to the vendor. Supports category-level vendor qualification coverage analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the vendor on the AVL. Identifies vendors with outstanding compliance requirements."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the vendor approval. Enables regional vendor qualification analysis."
    - name: "is_currently_approved"
      expr: is_currently_approved
      comment: "Flag indicating whether the vendor is currently approved. Filters active vs. lapsed vendor approvals."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Flag indicating preferred vendor status. Tracks preferred vendor concentration and utilization."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the vendor was approved. Enables trend analysis of vendor onboarding activity."
  measures:
    - name: "total_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendor entries on the approved vendor list. Baseline for vendor base size and qualification coverage."
    - name: "currently_approved_vendor_count"
      expr: COUNT(CASE WHEN is_currently_approved = TRUE THEN 1 END)
      comment: "Number of currently approved vendors. Measures active qualified vendor base available for procurement."
    - name: "avg_vendor_rating"
      expr: AVG(CAST(vendor_rating AS DOUBLE))
      comment: "Average vendor rating across AVL entries. Tracks overall quality of the approved vendor base."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across approved vendors. Monitors aggregate risk exposure within the qualified vendor base."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN 1 END)
      comment: "Number of preferred vendors on the AVL. Tracks preferred vendor tier size for strategic sourcing leverage."
    - name: "disqualified_vendor_count"
      expr: COUNT(CASE WHEN disqualification_date IS NOT NULL THEN 1 END)
      comment: "Number of vendors that have been disqualified. Measures vendor attrition and qualification failure rate."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order line-level KPIs for spend accuracy, delivery performance, waste, and three-way match compliance. Enables procurement operations to manage line-level execution quality."
  source: "`vibe_restaurants_v1`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the PO line (e.g. Open, Received, Invoiced, Closed). Tracks line-level fulfillment progress."
    - name: "line_type"
      expr: line_type
      comment: "Type of PO line (e.g. Goods, Services, Freight). Enables spend categorization by procurement type."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the PO line. Tracks fulfillment execution at the line level."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the PO line. Supports multi-currency spend analysis."
    - name: "is_late"
      expr: is_late
      comment: "Flag indicating whether the PO line delivery was late. Measures supplier on-time delivery performance."
    - name: "is_three_way_match"
      expr: is_three_way_match
      comment: "Flag indicating whether the PO line passed three-way match (PO, receipt, invoice). Critical AP control metric."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance flag on the PO line. Identifies non-compliant line items requiring review."
  measures:
    - name: "total_po_line_count"
      expr: COUNT(1)
      comment: "Total number of PO lines. Baseline for procurement line-level activity volume."
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended amount (quantity x unit price) across PO lines. Primary line-level spend KPI."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount across PO lines after discounts and adjustments. Measures realized line-level spend."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across PO lines. Supports demand volume analysis and supplier capacity planning."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across PO lines. Measures fulfillment completeness against ordered quantities."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced across PO lines. Enables comparison against received quantity for billing accuracy."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across PO lines. Tracks procurement waste as a cost efficiency and sustainability KPI."
    - name: "late_line_count"
      expr: COUNT(CASE WHEN is_late = TRUE THEN 1 END)
      comment: "Number of PO lines delivered late. Measures supplier delivery reliability at the line level."
    - name: "three_way_match_line_count"
      expr: COUNT(CASE WHEN is_three_way_match = TRUE THEN 1 END)
      comment: "Number of PO lines that passed three-way match. Measures AP control compliance and invoice processing efficiency."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured at the PO line level. Measures line-level savings from negotiated pricing."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs for monitoring contract value, renewal risk, compliance, and lifecycle health. Enables legal, procurement, and finance to manage contract obligations and savings."
  source: "`vibe_restaurants_v1`.`procurement`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract (e.g. Active, Expired, Terminated, Pending). Core dimension for contract portfolio health analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g. Master Supply Agreement, SOW, NDA). Enables contract portfolio composition analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract. Supports multi-currency contract value analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality classification of the contract. Supports governance and access control reporting."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether the contract auto-renews. Identifies contracts requiring proactive renewal management."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the contract. Tracks compliance with regulatory contracting requirements."
    - name: "effective_start_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the contract became effective. Enables cohort analysis of contract vintage and value."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of contracts. Baseline for contract portfolio size and management workload."
    - name: "total_contract_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value across all contracts. Primary KPI for measuring procurement contract spend under management."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average contract value. Benchmarks deal size and identifies outlier high-value contracts requiring enhanced oversight."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate negotiated across contracts. Measures procurement negotiation effectiveness."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of contracts set to auto-renew. Identifies contracts requiring proactive review to avoid unintended renewals."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers under contract. Measures contracted supplier base coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement requisition KPIs for monitoring request volume, spend estimates, approval cycle health, and compliance. Enables procurement operations to manage demand intake efficiency."
  source: "`vibe_restaurants_v1`.`procurement`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Lifecycle status of the requisition (e.g. Draft, Submitted, Approved, Rejected). Tracks pipeline health of procurement demand."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the requisition. Identifies bottlenecks in the approval process."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Method used to fulfill the requisition (e.g. PO, P-Card, Direct Buy). Enables channel mix analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the requisition. Tracks urgency distribution across procurement demand."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition. Supports multi-currency spend estimate analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance flag on the requisition. Identifies non-compliant requests requiring review."
    - name: "urgency_flag"
      expr: urgency_flag
      comment: "Flag indicating urgent requisitions. Tracks emergency demand frequency and its impact on procurement costs."
    - name: "requisition_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the requisition was created. Enables trend analysis of procurement demand over time."
  measures:
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total number of requisitions. Baseline for procurement demand volume and team workload."
    - name: "total_estimated_spend"
      expr: SUM(CAST(total_estimated_amount AS DOUBLE))
      comment: "Total estimated spend across requisitions. Primary KPI for demand-side spend forecasting and budget planning."
    - name: "total_net_estimated_amount"
      expr: SUM(CAST(net_estimated_amount AS DOUBLE))
      comment: "Total net estimated amount across requisitions after discounts. Measures expected net procurement spend from demand pipeline."
    - name: "avg_estimated_spend"
      expr: AVG(CAST(total_estimated_amount AS DOUBLE))
      comment: "Average estimated spend per requisition. Benchmarks typical request size and identifies outlier high-value requests."
    - name: "urgent_requisition_count"
      expr: COUNT(CASE WHEN urgency_flag = TRUE THEN 1 END)
      comment: "Number of urgent requisitions. High urgency rates signal demand planning failures and drive premium procurement costs."
    - name: "non_compliant_requisition_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of requisitions flagged as non-compliant. Measures policy adherence in the procurement demand process."
    - name: "distinct_requester_count"
      expr: COUNT(DISTINCT created_by_employee_id)
      comment: "Number of distinct employees submitting requisitions. Measures breadth of procurement demand across the organization."
$$;