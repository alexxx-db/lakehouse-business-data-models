-- Metric views for domain: procurement | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:10:25

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order volume, spend, cycle efficiency, and compliance across the procurement function. Enables CPO and finance leadership to monitor PO throughput, approval velocity, and total committed spend."
  source: "`vibe_restaurants_v1`.`procurement`.`procurement_purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Draft, Approved, Received, Closed) for pipeline analysis."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Blanket, Emergency) to segment spend patterns."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status to identify bottlenecks in the PO authorization process."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend normalization."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the purchase order was placed, enabling trend analysis of procurement activity."
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Year the purchase order was placed for annual spend benchmarking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the purchase order (e.g. Urgent, Normal) to assess emergency procurement frequency."
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag indicating whether the PO was raised as urgent, used to track unplanned procurement."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Goods receipt status of the PO to monitor fulfillment and open order exposure."
    - name: "category_code"
      expr: category_code
      comment: "Spend category code for category-level procurement analysis."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders raised. Baseline volume metric for procurement activity tracking."
    - name: "total_gross_spend"
      expr: SUM(CAST(total_amount_gross AS DOUBLE))
      comment: "Total gross committed spend across all purchase orders. Primary spend KPI for budget vs. actuals analysis."
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend after discounts across all purchase orders. Used for true cost-of-goods analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across purchase orders for tax accrual and compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured across purchase orders. Measures negotiation effectiveness and savings realization."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight and logistics cost across POs. Informs logistics cost optimization decisions."
    - name: "avg_po_gross_value"
      expr: AVG(CAST(total_amount_gross AS DOUBLE))
      comment: "Average gross value per purchase order. Indicates order sizing trends and consolidation opportunities."
    - name: "urgent_po_count"
      expr: COUNT(CASE WHEN is_urgent = TRUE THEN 1 END)
      comment: "Number of urgent purchase orders. High values signal supply chain instability or poor demand planning."
    - name: "urgent_po_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_urgent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs flagged as urgent. A leading indicator of procurement planning maturity; target below 10%."
    - name: "compliance_po_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of POs meeting compliance requirements. Used for regulatory and audit readiness reporting."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase orders that are fully compliant. Critical for audit and governance scorecards."
    - name: "consolidated_po_count"
      expr: COUNT(CASE WHEN is_consolidated = TRUE THEN 1 END)
      comment: "Number of consolidated purchase orders. Measures procurement consolidation strategy effectiveness."
    - name: "avg_total_weight_kg"
      expr: AVG(CAST(total_weight_kg AS DOUBLE))
      comment: "Average weight per purchase order in kilograms. Supports logistics planning and freight cost benchmarking."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers used across purchase orders. Tracks supplier base concentration and diversification."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs covering spend accuracy, delivery performance, invoice matching, and waste. Enables category managers and operations teams to evaluate supplier execution at the SKU level."
  source: "`vibe_restaurants_v1`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line (e.g. Open, Received, Invoiced, Closed) for pipeline visibility."
    - name: "line_type"
      expr: line_type
      comment: "Type of PO line (e.g. Goods, Services) to segment spend by procurement category."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery fulfillment status of the line item for on-time delivery analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency line-level spend analysis."
    - name: "is_late"
      expr: is_late
      comment: "Flag indicating whether the line item delivery was late. Key supplier performance indicator."
    - name: "is_three_way_match"
      expr: is_three_way_match
      comment: "Flag indicating three-way match (PO, receipt, invoice) completion. Critical for AP controls."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance status of the PO line for regulatory and audit tracking."
    - name: "expected_delivery_month"
      expr: DATE_TRUNC('MONTH', expected_delivery_date)
      comment: "Month of expected delivery for demand planning and supplier scheduling analysis."
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of PO lines. Baseline volume metric for procurement line activity."
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended line amount (quantity × unit price). Primary line-level spend KPI."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts at line level. Used for true cost-of-goods analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured at line level. Measures negotiated savings realization per SKU."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount at line level for tax accrual and compliance reporting."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all PO lines. Supports demand and inventory planning."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received. Compared against ordered quantity to compute fill rate."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced by supplier. Used for three-way match and invoice accuracy analysis."
    - name: "fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received. Core supplier fulfillment KPI; target above 95%."
    - name: "late_line_count"
      expr: COUNT(CASE WHEN is_late = TRUE THEN 1 END)
      comment: "Number of PO lines delivered late. Drives supplier performance management conversations."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PO lines delivered on time. Key supplier SLA metric tracked in QBRs."
    - name: "three_way_match_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_three_way_match = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PO lines with completed three-way match. Measures AP control effectiveness and fraud risk reduction."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines. Benchmarks pricing trends and negotiation outcomes."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across PO lines. Informs yield management and supplier quality standards."
    - name: "total_waste_cost_estimate"
      expr: SUM(CAST(extended_amount AS DOUBLE) * CAST(waste_percentage AS DOUBLE) / 100.0)
      comment: "Estimated cost of waste across PO lines (extended amount × waste %). Quantifies waste impact on food cost."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice management KPIs covering invoice accuracy, dispute rates, payment performance, and cost-of-goods. Enables finance and procurement leadership to manage cash flow, AP aging, and supplier payment compliance."
  source: "`vibe_restaurants_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "supplier_invoice_status"
      expr: supplier_invoice_status
      comment: "Current status of the supplier invoice (e.g. Pending, Approved, Paid, Disputed) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g. Standard, Credit Note, Debit Note) for AP categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval workflow status to identify bottlenecks in the payment authorization process."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether the invoice is under dispute. Drives supplier relationship and AP risk management."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for AP accrual and spend trend analysis."
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice date for annual AP spend benchmarking."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the invoice is tax-exempt, for tax liability and compliance reporting."
    - name: "category_code"
      expr: category_code
      comment: "Spend category code for category-level AP analysis."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices processed. Baseline AP volume metric."
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount. Primary AP spend KPI for cash flow and budget management."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Used for true cost-of-goods and margin analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across invoices for tax accrual and compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment and negotiated discounts captured. Measures working capital optimization."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount. Benchmarks invoice sizing and supplier billing patterns."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of disputed invoices. High values indicate supplier quality or billing accuracy issues."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_disputed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices under dispute. Key AP quality metric; target below 2% for healthy supplier relationships."
    - name: "total_disputed_amount"
      expr: SUM(CASE WHEN is_disputed = TRUE THEN CAST(gross_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross amount of disputed invoices. Quantifies financial exposure from billing disputes."
    - name: "cogs_percentage_avg"
      expr: AVG(CAST(cogs_percentage AS DOUBLE))
      comment: "Average cost-of-goods-sold percentage across invoices. Tracks food cost as a percentage of revenue at the invoice level."
    - name: "early_payment_discount_avg_pct"
      expr: AVG(CAST(early_payment_discount_percent AS DOUBLE))
      comment: "Average early payment discount percentage available. Informs dynamic discounting and working capital strategy."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers invoiced. Tracks AP supplier base concentration."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance KPIs aggregated from scorecards covering quality, delivery, responsiveness, and sustainability. Enables procurement leadership to rank, tier, and manage the supplier base strategically."
  source: "`vibe_restaurants_v1`.`procurement`.`supplier_scorecard`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Supplier compliance status at time of evaluation for regulatory and audit segmentation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk tier of the supplier (e.g. Low, Medium, High) for risk-stratified performance management."
    - name: "supplier_category"
      expr: supplier_category
      comment: "Category of goods or services supplied for category-level performance benchmarking."
    - name: "region"
      expr: region
      comment: "Geographic region of the supplier for regional supply chain performance analysis."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start)
      comment: "Month of evaluation period start for trend analysis of supplier performance over time."
    - name: "evaluator_department"
      expr: evaluator_department
      comment: "Department that conducted the evaluation for cross-functional performance visibility."
  measures:
    - name: "total_scorecard_count"
      expr: COUNT(1)
      comment: "Total number of supplier scorecards completed. Measures evaluation program coverage."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score. Primary KPI for supplier base health and QBR reporting."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across evaluated suppliers. Core supply chain reliability metric."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate across suppliers. Measures supplier ability to fulfill ordered quantities completely."
    - name: "avg_quality_rejection_rate"
      expr: AVG(CAST(quality_rejection_rate AS DOUBLE))
      comment: "Average quality rejection rate across suppliers. High values drive supplier development or disqualification decisions."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate. Measures billing quality and AP processing efficiency."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average supplier responsiveness score. Reflects supplier agility and communication quality."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across suppliers. Supports ESG reporting and responsible sourcing strategy."
    - name: "avg_cost_savings_pct"
      expr: AVG(CAST(cost_savings_percent AS DOUBLE))
      comment: "Average cost savings percentage delivered by suppliers. Measures procurement value creation."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(average_lead_time_days AS DOUBLE))
      comment: "Average supplier lead time in days. Informs safety stock levels and replenishment planning."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers evaluated. Measures scorecard program coverage across the supplier base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing KPIs covering event volume, award values, competitive participation, and cycle times. Enables CPO and category managers to evaluate sourcing program effectiveness and savings generation."
  source: "`vibe_restaurants_v1`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (e.g. RFP, RFQ, Auction) for sourcing strategy analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the sourcing event (e.g. Draft, Active, Awarded, Cancelled)."
    - name: "award_decision"
      expr: award_decision
      comment: "Outcome of the sourcing event award decision for win/loss and competitive analysis."
    - name: "category_scope"
      expr: category_scope
      comment: "Category scope of the sourcing event for category-level sourcing activity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the sourcing event for multi-currency award value analysis."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Whether the sourcing event is confidential, for governance and access control reporting."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', CAST(event_start_timestamp AS DATE))
      comment: "Month the sourcing event started for trend analysis of sourcing pipeline activity."
  measures:
    - name: "total_event_count"
      expr: COUNT(1)
      comment: "Total number of sourcing events conducted. Measures sourcing program activity and pipeline volume."
    - name: "total_award_amount"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total value awarded through sourcing events. Primary KPI for sourcing program value generation."
    - name: "total_budget_value"
      expr: SUM(CAST(total_budget AS DOUBLE))
      comment: "Total budget allocated across sourcing events. Used for budget utilization and savings calculation."
    - name: "avg_award_amount"
      expr: AVG(CAST(award_amount AS DOUBLE))
      comment: "Average award value per sourcing event. Benchmarks deal size and sourcing scope."
    - name: "savings_vs_budget_amount"
      expr: SUM((CAST(total_budget AS DOUBLE)) - (CAST(award_amount AS DOUBLE)))
      comment: "Total savings achieved versus budget across sourcing events. Core procurement value creation KPI."
    - name: "savings_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(total_budget AS DOUBLE)) - SUM(CAST(award_amount AS DOUBLE))) / NULLIF(SUM(CAST(total_budget AS DOUBLE)), 0), 2)
      comment: "Percentage savings achieved versus total budget across sourcing events. Strategic KPI for CPO reporting."
    - name: "avg_weighting_scheme"
      expr: AVG(CAST(weighting_scheme AS DOUBLE))
      comment: "Average evaluation weighting scheme score across events. Indicates balance between price and non-price criteria."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers engaged in sourcing events. Measures competitive market engagement."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_sourcing_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier bid and response KPIs covering competitive pricing, compliance, scoring, and award rates. Enables category managers to evaluate bid quality, supplier competitiveness, and sourcing event outcomes."
  source: "`vibe_restaurants_v1`.`procurement`.`sourcing_response`"
  dimensions:
    - name: "sourcing_response_status"
      expr: sourcing_response_status
      comment: "Status of the sourcing response (e.g. Submitted, Under Review, Awarded, Rejected)."
    - name: "award_status"
      expr: award_status
      comment: "Award outcome for the response (e.g. Awarded, Not Awarded) for win-rate analysis."
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid submitted (e.g. Initial, Best and Final) for bid round analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the supplier response for risk-adjusted sourcing decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bid for multi-currency price comparison."
    - name: "is_eligible"
      expr: is_eligible
      comment: "Whether the response met eligibility criteria. Used to measure disqualification rates."
    - name: "is_preferred_supplier"
      expr: is_preferred_supplier
      comment: "Whether the responding supplier is on the preferred supplier list for preferred vs. open market analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', CAST(submission_timestamp AS DATE))
      comment: "Month of bid submission for sourcing pipeline trend analysis."
  measures:
    - name: "total_response_count"
      expr: COUNT(1)
      comment: "Total number of sourcing responses received. Measures competitive participation in sourcing events."
    - name: "total_net_price"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net price across all bids. Used for aggregate spend commitment analysis."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average unit price bid across responses. Benchmarks market pricing for category management."
    - name: "avg_scoring_total"
      expr: AVG(CAST(scoring_total AS DOUBLE))
      comment: "Average total evaluation score across responses. Measures overall bid quality in the sourcing event."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across supplier responses. Tracks supplier regulatory and policy adherence."
    - name: "avg_supplier_rating"
      expr: AVG(CAST(supplier_rating AS DOUBLE))
      comment: "Average supplier rating across responses. Informs preferred supplier list management."
    - name: "eligible_response_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of responses meeting eligibility criteria. Low rates indicate poor supplier qualification or unclear RFP requirements."
    - name: "awarded_response_count"
      expr: COUNT(CASE WHEN award_status = 'Awarded' THEN 1 END)
      comment: "Number of responses that resulted in an award. Used to calculate competitive win rates."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount offered across all bids. Measures supplier willingness to negotiate."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers submitting responses. Measures competitive market depth per sourcing event."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs covering active contract value, renewal risk, compliance, and supplier concentration. Enables legal, procurement, and finance leadership to manage contract lifecycle and commercial risk."
  source: "`vibe_restaurants_v1`.`procurement`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (e.g. Active, Expired, Terminated, Under Review)."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g. Master Supply Agreement, Spot, Framework) for portfolio segmentation."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model used in the contract (e.g. Fixed, Cost-Plus, Index-Linked) for commercial risk analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency portfolio analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews. Identifies contracts requiring active renewal management."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the contract grants supplier exclusivity. Tracks single-source dependency risk."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the contract for compliance and legal reporting."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective for contract vintage analysis."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of contracts in the portfolio. Baseline metric for contract management scope."
    - name: "total_contract_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total committed value across all contracts. Primary KPI for commercial exposure and budget planning."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average contract value. Benchmarks deal size and informs negotiation strategy."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate negotiated across contracts. Measures procurement negotiation effectiveness."
    - name: "avg_rebate_terms"
      expr: AVG(CAST(rebate_terms AS DOUBLE))
      comment: "Average rebate terms value across contracts. Tracks rebate program value in the contract portfolio."
    - name: "auto_renewal_contract_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of contracts set to auto-renew. Identifies contracts requiring proactive renewal review."
    - name: "exclusivity_contract_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of exclusive supplier contracts. Quantifies single-source dependency risk in the portfolio."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers under contract. Measures supplier base coverage and concentration."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_vendor_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor rebate program KPIs covering accrued, earned, and paid rebate values, thresholds, and program performance. Enables finance and procurement to maximize rebate capture and track working capital benefits."
  source: "`vibe_restaurants_v1`.`procurement`.`vendor_rebate`"
  dimensions:
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (e.g. Volume, Growth, Compliance) for rebate program segmentation."
    - name: "rebate_status"
      expr: rebate_status
      comment: "Current status of the rebate (e.g. Accruing, Earned, Paid, Expired) for cash flow planning."
    - name: "vendor_rebate_status"
      expr: vendor_rebate_status
      comment: "Vendor-side rebate status for reconciliation and dispute management."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the rebate for AR and cash collection tracking."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the rebate (e.g. Flat Rate, Tiered, Retroactive) for program design analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rebate for multi-currency rebate portfolio analysis."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month the rebate period started for trend analysis of rebate accruals over time."
    - name: "rebate_program_name"
      expr: rebate_program_name
      comment: "Name of the rebate program for program-level performance comparison."
  measures:
    - name: "total_rebate_count"
      expr: COUNT(1)
      comment: "Total number of vendor rebate records. Measures rebate program breadth."
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total rebate amount accrued. Primary KPI for rebate program value tracking and financial accrual reporting."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate amount earned. Measures actual rebate value realized from supplier programs."
    - name: "total_accrual_amount"
      expr: SUM(CAST(accrual_amount AS DOUBLE))
      comment: "Total accrual amount across rebate records for balance sheet accrual management."
    - name: "avg_rebate_rate_pct"
      expr: AVG(CAST(rebate_rate_percent AS DOUBLE))
      comment: "Average rebate rate percentage across programs. Benchmarks rebate program competitiveness."
    - name: "avg_volume_threshold"
      expr: AVG(CAST(volume_threshold AS DOUBLE))
      comment: "Average volume threshold required to trigger rebates. Informs purchasing volume strategy."
    - name: "avg_threshold_amount"
      expr: AVG(CAST(threshold_amount AS DOUBLE))
      comment: "Average spend threshold required to trigger rebates. Used for spend consolidation planning."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers with active rebate programs. Measures rebate program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_approved_vendor_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved vendor list KPIs covering vendor qualification status, risk scores, compliance rates, and approval coverage. Enables procurement governance teams to maintain a healthy, compliant, and risk-managed supplier base."
  source: "`vibe_restaurants_v1`.`procurement`.`approved_vendor_list`"
  dimensions:
    - name: "approved_status"
      expr: approved_status
      comment: "Current approval status of the vendor (e.g. Approved, Pending, Suspended, Disqualified)."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g. Distributor, Manufacturer, Broker) for supply base segmentation."
    - name: "vendor_category_code"
      expr: vendor_category_code
      comment: "Category code of the vendor for category-level AVL coverage analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the vendor for regulatory and audit reporting."
    - name: "is_currently_approved"
      expr: is_currently_approved
      comment: "Whether the vendor is currently approved. Used to filter active vs. lapsed vendor approvals."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Whether the vendor is on the preferred vendor list for preferred vs. approved-only segmentation."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the vendor approval for regional supply chain analysis."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of vendor approval for onboarding trend analysis."
  measures:
    - name: "total_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors on the approved vendor list. Measures supply base breadth."
    - name: "currently_approved_count"
      expr: COUNT(CASE WHEN is_currently_approved = TRUE THEN 1 END)
      comment: "Number of currently approved vendors. Tracks active supply base size for procurement planning."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_currently_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors currently approved. Measures AVL health and qualification program effectiveness."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN 1 END)
      comment: "Number of preferred vendors. Tracks preferred supplier program coverage."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across vendors on the AVL. Monitors overall supply base risk exposure."
    - name: "avg_vendor_rating"
      expr: AVG(CAST(vendor_rating AS DOUBLE))
      comment: "Average vendor rating across the approved vendor list. Tracks overall supply base quality."
    - name: "disqualified_vendor_count"
      expr: COUNT(CASE WHEN disqualification_date IS NOT NULL THEN 1 END)
      comment: "Number of vendors that have been disqualified. Measures supply base attrition and quality enforcement."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`procurement_supplier_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier risk KPIs covering financial stability, dependency concentration, compliance flags, and risk tier distribution. Enables CPO and risk management teams to proactively identify and mitigate supply chain vulnerabilities."
  source: "`vibe_restaurants_v1`.`procurement`.`supplier_risk`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g. Financial, Geopolitical, Compliance, Operational) for risk type analysis."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier of the supplier (e.g. Critical, High, Medium, Low) for risk-stratified management."
    - name: "risk_status"
      expr: risk_status
      comment: "Current status of the risk assessment (e.g. Open, Mitigated, Accepted, Escalated)."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the supplier for geopolitical and regional risk analysis."
    - name: "compliance_fda_flag"
      expr: compliance_fda_flag
      comment: "FDA compliance flag for food safety regulatory risk tracking."
    - name: "compliance_osha_flag"
      expr: compliance_osha_flag
      comment: "OSHA compliance flag for workplace safety regulatory risk tracking."
    - name: "single_source_dependency"
      expr: single_source_dependency
      comment: "Whether the supplier is a single-source dependency. Critical risk concentration indicator."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', CAST(assessment_timestamp AS DATE))
      comment: "Month of risk assessment for trend analysis of supply chain risk over time."
  measures:
    - name: "total_risk_assessment_count"
      expr: COUNT(1)
      comment: "Total number of supplier risk assessments. Measures risk management program coverage."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all supplier risk assessments. Primary KPI for supply chain risk exposure."
    - name: "avg_financial_stability_score"
      expr: AVG(CAST(financial_stability_score AS DOUBLE))
      comment: "Average financial stability score across suppliers. Tracks financial health of the supply base."
    - name: "avg_dependency_percentage"
      expr: AVG(CAST(dependency_percentage AS DOUBLE))
      comment: "Average spend dependency percentage per supplier. High values indicate concentration risk."
    - name: "single_source_supplier_count"
      expr: COUNT(CASE WHEN single_source_dependency = TRUE THEN 1 END)
      comment: "Number of single-source dependent suppliers. Quantifies critical supply chain vulnerability."
    - name: "single_source_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN single_source_dependency = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with single-source dependency. Strategic risk KPI for supply chain resilience."
    - name: "high_risk_supplier_count"
      expr: COUNT(CASE WHEN risk_tier IN ('Critical', 'High') THEN 1 END)
      comment: "Number of suppliers in critical or high risk tiers. Drives risk mitigation prioritization."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers with risk assessments. Measures risk program coverage."
$$;