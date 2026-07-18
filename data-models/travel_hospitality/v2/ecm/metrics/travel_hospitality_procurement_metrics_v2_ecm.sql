-- Metric views for domain: procurement | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-07-10 20:24:18

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order KPIs tracking procurement spend, cycle time, and operational efficiency"
  source: "`vibe_travel_hospitality_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Purchase order status (open, closed, cancelled)"
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, contract)"
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month when purchase order was created"
    - name: "po_quarter"
      expr: DATE_TRUNC('QUARTER', po_date)
      comment: "Quarter when purchase order was created"
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Year when purchase order was created"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order"
    - name: "goods_receipt_completed"
      expr: goods_receipt_completed_flag
      comment: "Whether goods receipt is complete"
    - name: "invoice_receipt_completed"
      expr: invoice_receipt_completed_flag
      comment: "Whether invoice receipt is complete"
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders"
    - name: "total_po_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total purchase order spend amount before tax"
    - name: "total_po_spend_with_tax"
      expr: SUM(CAST(total_amount_with_tax AS DOUBLE))
      comment: "Total purchase order spend including tax"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all purchase orders"
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value"
    - name: "avg_po_cycle_time_days"
      expr: AVG(DATEDIFF(actual_delivery_date, po_date))
      comment: "Average days from PO creation to actual delivery"
    - name: "avg_delivery_delay_days"
      expr: AVG(DATEDIFF(actual_delivery_date, promised_delivery_date))
      comment: "Average days of delivery delay (actual vs promised)"
    - name: "total_commitment_released"
      expr: SUM(CAST(commitment_released_amount AS DOUBLE))
      comment: "Total commitment amount released from blanket POs"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with purchase orders"
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties placing purchase orders"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor invoice KPIs tracking AP processing efficiency, payment performance, and dispute management"
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice processing status"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, debit memo)"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when invoice was issued"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year when invoice was issued"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (matched, variance, unmatched)"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether invoice is in dispute"
    - name: "early_payment_eligible"
      expr: early_payment_discount_eligible_flag
      comment: "Whether invoice qualifies for early payment discount"
    - name: "expense_type"
      expr: expense_type
      comment: "Type of expense (CAPEX, OPEX)"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices"
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and tax"
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_invoice_tax"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount currently in dispute"
    - name: "total_match_variance"
      expr: SUM(CAST(match_variance_amount AS DOUBLE))
      comment: "Total three-way match variance amount"
    - name: "avg_invoice_processing_days"
      expr: AVG(DATEDIFF(approved_timestamp, created_timestamp))
      comment: "Average days from invoice receipt to approval"
    - name: "avg_payment_cycle_days"
      expr: AVG(DATEDIFF(payment_date, invoice_date))
      comment: "Average days from invoice date to payment"
    - name: "avg_days_past_due"
      expr: AVG(DATEDIFF(payment_date, payment_due_date))
      comment: "Average days payment was past due date"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors invoiced"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance KPIs tracking quality, delivery, responsiveness, and overall vendor scorecard metrics"
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor_performance`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of vendor performance evaluation"
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start_date)
      comment: "Month when evaluation period started"
    - name: "evaluation_period_start_year"
      expr: YEAR(evaluation_period_start_date)
      comment: "Year when evaluation period started"
    - name: "contract_renewal_recommendation"
      expr: contract_renewal_recommendation
      comment: "Recommendation for contract renewal (renew, renegotiate, terminate)"
    - name: "preferred_vendor"
      expr: preferred_vendor_flag
      comment: "Whether vendor has preferred status"
    - name: "qualified_vendor"
      expr: qualified_vendor_flag
      comment: "Whether vendor is qualified"
    - name: "payment_terms_compliant"
      expr: payment_terms_compliance_flag
      comment: "Whether vendor complies with payment terms"
    - name: "sustainability_compliant"
      expr: sustainability_compliance_flag
      comment: "Whether vendor meets sustainability requirements"
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of vendor performance evaluations"
    - name: "avg_overall_vendor_score"
      expr: AVG(CAST(overall_vendor_score AS DOUBLE))
      comment: "Average overall vendor performance score"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate percentage"
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate percentage"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate percentage"
    - name: "avg_responsiveness_rating"
      expr: AVG(CAST(responsiveness_rating AS DOUBLE))
      comment: "Average vendor responsiveness rating"
    - name: "avg_cost_competitiveness_rating"
      expr: AVG(CAST(cost_competitiveness_rating AS DOUBLE))
      comment: "Average cost competitiveness rating"
    - name: "avg_contract_compliance_score"
      expr: AVG(CAST(contract_compliance_score AS DOUBLE))
      comment: "Average contract compliance score"
    - name: "avg_emergency_support_rating"
      expr: AVG(CAST(emergency_order_support_rating AS DOUBLE))
      comment: "Average emergency order support rating"
    - name: "total_spend_evaluated"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total spend amount under evaluation"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(average_lead_time_days AS DOUBLE))
      comment: "Average vendor lead time in days"
    - name: "distinct_vendors_evaluated"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors evaluated"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs tracking receiving efficiency, quality inspection, and three-way match performance"
  source: "`vibe_travel_hospitality_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Goods receipt status"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (PO-GR-Invoice)"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month when goods were received"
    - name: "receipt_year"
      expr: YEAR(receipt_date)
      comment: "Year when goods were received"
    - name: "quality_rejection"
      expr: quality_rejection_flag
      comment: "Whether goods were rejected for quality"
    - name: "return_delivery"
      expr: return_delivery_flag
      comment: "Whether this is a return delivery"
    - name: "capex_opex_indicator"
      expr: capex_opex_indicator
      comment: "Capital or operational expenditure classification"
    - name: "condition_on_receipt"
      expr: condition_on_receipt
      comment: "Condition of goods upon receipt"
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions"
    - name: "total_quantity_received"
      expr: SUM(CAST(total_quantity_received AS DOUBLE))
      comment: "Total quantity of goods received"
    - name: "total_receipt_value"
      expr: SUM(CAST(total_value_amount AS DOUBLE))
      comment: "Total value of goods received"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount between expected and received"
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges_amount AS DOUBLE))
      comment: "Total freight charges incurred"
    - name: "avg_receipt_processing_days"
      expr: AVG(DATEDIFF(posted_timestamp, receipt_date))
      comment: "Average days from receipt to posting"
    - name: "avg_receipt_value"
      expr: AVG(CAST(total_value_amount AS DOUBLE))
      comment: "Average value per goods receipt"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with goods receipts"
    - name: "distinct_purchase_orders"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of unique purchase orders received against"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition KPIs tracking demand planning, approval efficiency, and requisition-to-PO conversion"
  source: "`vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Status of purchase requisition"
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (standard, emergency, blanket)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of requisition"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month when requisition was submitted"
    - name: "submitted_year"
      expr: YEAR(submitted_timestamp)
      comment: "Year when requisition was submitted"
    - name: "converted_to_po"
      expr: converted_to_po_flag
      comment: "Whether requisition was converted to purchase order"
    - name: "budget_available"
      expr: budget_available_flag
      comment: "Whether budget was available at requisition time"
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy for requisition"
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions"
    - name: "total_requisition_value"
      expr: SUM(CAST(estimated_total_amount AS DOUBLE))
      comment: "Total estimated value of requisitions"
    - name: "avg_requisition_value"
      expr: AVG(CAST(estimated_total_amount AS DOUBLE))
      comment: "Average estimated value per requisition"
    - name: "avg_approval_cycle_days"
      expr: AVG(DATEDIFF(approval_date, submitted_timestamp))
      comment: "Average days from submission to approval"
    - name: "avg_requisition_to_po_days"
      expr: AVG(DATEDIFF(closed_timestamp, submitted_timestamp))
      comment: "Average days from requisition submission to PO creation"
    - name: "distinct_requestors"
      expr: COUNT(DISTINCT employee_id)
      comment: "Number of unique employees submitting requisitions"
    - name: "distinct_preferred_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique preferred vendors specified"
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with requisitions"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs tracking vendor portfolio composition, risk profile, and diversity metrics"
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current vendor status (active, inactive, suspended)"
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Vendor tier classification (strategic, preferred, approved)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Vendor risk rating"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Vendor compliance status"
    - name: "classification"
      expr: classification
      comment: "Vendor classification"
    - name: "diversity_certification"
      expr: diversity_certification
      comment: "Diversity certification type (MBE, WBE, etc.)"
    - name: "payment_method"
      expr: payment_method
      comment: "Preferred payment method"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year vendor was onboarded"
  measures:
    - name: "total_vendors"
      expr: COUNT(1)
      comment: "Total number of vendors in portfolio"
    - name: "total_annual_spend"
      expr: SUM(CAST(annual_spend_amount AS DOUBLE))
      comment: "Total annual spend across all vendors"
    - name: "avg_annual_spend_per_vendor"
      expr: AVG(CAST(annual_spend_amount AS DOUBLE))
      comment: "Average annual spend per vendor"
    - name: "avg_minimum_order_amount"
      expr: AVG(CAST(minimum_order_amount AS DOUBLE))
      comment: "Average minimum order amount across vendors"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average vendor lead time in days"
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of unique countries vendors operate from"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract KPIs tracking contract value, compliance, renewal pipeline, and SLA performance"
  source: "`vibe_travel_hospitality_v1`.`procurement`.`procurement_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (master, spot, framework)"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year contract became effective"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year contract expires"
    - name: "auto_renewal"
      expr: auto_renewal_flag
      comment: "Whether contract auto-renews"
    - name: "capex_designation"
      expr: capex_designation_flag
      comment: "Whether contract is designated for capital expenditure"
    - name: "pip_project"
      expr: pip_project_flag
      comment: "Whether contract is for property improvement plan project"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of vendor contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all vendor contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value"
    - name: "avg_contract_duration_days"
      expr: AVG(DATEDIFF(expiry_date, effective_date))
      comment: "Average contract duration in days"
    - name: "avg_negotiated_discount_pct"
      expr: AVG(CAST(negotiated_discount_percent AS DOUBLE))
      comment: "Average negotiated discount percentage"
    - name: "avg_sla_on_time_delivery_pct"
      expr: AVG(CAST(sla_on_time_delivery_percent AS DOUBLE))
      comment: "Average SLA on-time delivery percentage"
    - name: "avg_sla_quality_acceptance_pct"
      expr: AVG(CAST(sla_quality_acceptance_percent AS DOUBLE))
      comment: "Average SLA quality acceptance percentage"
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(delivery_lead_time_days AS DOUBLE))
      comment: "Average delivery lead time in days per contract"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with contracts"
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with vendor contracts"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement category KPIs tracking spend allocation, compliance requirements, and category management effectiveness"
  source: "`vibe_travel_hospitality_v1`.`procurement`.`category`"
  dimensions:
    - name: "category_type"
      expr: category_type
      comment: "Type of procurement category"
    - name: "category_level"
      expr: category_level
      comment: "Hierarchical level of category"
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification of category"
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy for category"
    - name: "spend_classification"
      expr: spend_classification
      comment: "Spend classification (direct, indirect)"
    - name: "active_flag"
      expr: active_flag
      comment: "Whether category is active"
    - name: "competitive_bid_required"
      expr: competitive_bid_required_flag
      comment: "Whether competitive bidding is required"
    - name: "regulatory_compliance_required"
      expr: regulatory_compliance_flag
      comment: "Whether regulatory compliance is required"
  measures:
    - name: "total_categories"
      expr: COUNT(1)
      comment: "Total number of procurement categories"
    - name: "total_annual_spend_budget"
      expr: SUM(CAST(annual_spend_budget_amount AS DOUBLE))
      comment: "Total annual spend budget across categories"
    - name: "avg_annual_spend_budget"
      expr: AVG(CAST(annual_spend_budget_amount AS DOUBLE))
      comment: "Average annual spend budget per category"
    - name: "avg_approval_threshold"
      expr: AVG(CAST(approval_threshold_amount AS DOUBLE))
      comment: "Average approval threshold amount"
    - name: "avg_bid_threshold"
      expr: AVG(CAST(bid_threshold_amount AS DOUBLE))
      comment: "Average bid threshold amount"
    - name: "avg_lead_time_days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average lead time in days for category"
$$;


CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement project KPIs tracking capital projects, PIP initiatives, budget performance, and project delivery"
  source: "`vibe_travel_hospitality_v1`.`procurement`.`project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current project status"
    - name: "project_type"
      expr: project_type
      comment: "Type of project (renovation, new build, maintenance)"
    - name: "project_category"
      expr: project_category
      comment: "Project category classification"
    - name: "priority"
      expr: priority
      comment: "Project priority level"
    - name: "risk_level"
      expr: risk_level
      comment: "Project risk level"
    - name: "is_pip_project"
      expr: is_pip_project
      comment: "Whether this is a property improvement plan project"
    - name: "brand_standard_compliance"
      expr: brand_standard_compliance
      comment: "Whether project meets brand standards"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year project is planned to start"
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of procurement projects"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across projects"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred"
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost AS DOUBLE))
      comment: "Total committed cost"
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per project"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average project completion percentage"
    - name: "avg_planned_duration_days"
      expr: AVG(DATEDIFF(planned_end_date, planned_start_date))
      comment: "Average planned project duration in days"
    - name: "avg_actual_duration_days"
      expr: AVG(DATEDIFF(actual_end_date, actual_start_date))
      comment: "Average actual project duration in days"
    - name: "avg_schedule_variance_days"
      expr: AVG(DATEDIFF(actual_end_date, planned_end_date))
      comment: "Average schedule variance in days (actual vs planned)"
    - name: "distinct_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of unique properties with projects"
$$;
