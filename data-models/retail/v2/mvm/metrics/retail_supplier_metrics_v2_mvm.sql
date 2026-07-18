-- Metric views for domain: supplier | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:23:39

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vendor performance and operational metrics tracking vendor health, compliance, and delivery performance"
  source: "`vibe_retail_v1`.`supplier`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current operational status of the vendor (active, inactive, suspended)"
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of vendor by business relationship type"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk assessment rating for vendor relationship"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Standard payment terms code for vendor transactions"
    - name: "diversity_certification"
      expr: diversity_certification
      comment: "Diversity certification status for supplier diversity programs"
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Whether vendor supports EDI transactions"
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Whether vendor-managed inventory is enabled"
    - name: "sustainability_certified_flag"
      expr: sustainability_certified_flag
      comment: "Whether vendor holds sustainability certifications"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year vendor was onboarded"
    - name: "onboarding_quarter"
      expr: CONCAT('Q', QUARTER(onboarding_date), '-', YEAR(onboarding_date))
      comment: "Quarter and year vendor was onboarded"
  measures:
    - name: "total_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Total unique vendor count for portfolio sizing and diversity analysis"
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_pct AS DOUBLE))
      comment: "Average fill rate percentage across vendors - key supply reliability metric"
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate percentage - critical operational performance KPI"
    - name: "avg_quality_acceptance_rate_pct"
      expr: AVG(CAST(quality_acceptance_rate_pct AS DOUBLE))
      comment: "Average quality acceptance rate percentage - product quality performance indicator"
    - name: "vendor_performance_composite"
      expr: AVG(CAST((fill_rate_pct + on_time_delivery_rate_pct + quality_acceptance_rate_pct) / 3.0 AS DOUBLE))
      comment: "Composite vendor performance score averaging fill rate, on-time delivery, and quality acceptance - executive-level vendor health metric"
    - name: "edi_adoption_rate"
      expr: AVG(CAST(CASE WHEN edi_capable_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of vendors with EDI capability - digital transformation and efficiency metric"
    - name: "vmi_adoption_rate"
      expr: AVG(CAST(CASE WHEN vmi_enabled_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of vendors with VMI enabled - supply chain automation metric"
    - name: "sustainability_compliance_rate"
      expr: AVG(CAST(CASE WHEN sustainability_certified_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of vendors with sustainability certifications - ESG compliance metric"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard metrics tracking quality, delivery, compliance, and financial impact across evaluation periods"
  source: "`vibe_retail_v1`.`supplier`.`vendor_scorecard`"
  dimensions:
    - name: "scorecard_status"
      expr: scorecard_status
      comment: "Current status of the vendor scorecard evaluation"
    - name: "vendor_tier"
      expr: vendor_tier
      comment: "Vendor tier classification based on performance (strategic, preferred, approved, probation)"
    - name: "score_trend"
      expr: score_trend
      comment: "Trend direction of vendor performance (improving, stable, declining)"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action is required based on scorecard results"
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Year of scorecard evaluation"
    - name: "evaluation_quarter"
      expr: CONCAT('Q', QUARTER(evaluation_date), '-', YEAR(evaluation_date))
      comment: "Quarter and year of scorecard evaluation"
    - name: "scoring_period_year"
      expr: YEAR(scoring_period_start_date)
      comment: "Year of scoring period start"
  measures:
    - name: "total_scorecards"
      expr: COUNT(DISTINCT vendor_scorecard_id)
      comment: "Total vendor scorecard evaluations conducted"
    - name: "avg_composite_score"
      expr: AVG(CAST(composite_score AS DOUBLE))
      comment: "Average composite vendor performance score - primary vendor quality metric for executive review"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate from scorecards - critical supply chain reliability KPI"
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate from scorecards - inventory availability performance metric"
    - name: "avg_product_quality_score"
      expr: AVG(CAST(product_quality_score AS DOUBLE))
      comment: "Average product quality score - quality assurance performance indicator"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate - financial operations efficiency metric"
    - name: "avg_edi_compliance_rate"
      expr: AVG(CAST(edi_compliance_rate AS DOUBLE))
      comment: "Average EDI compliance rate - digital integration effectiveness metric"
    - name: "avg_lead_time_adherence_rate"
      expr: AVG(CAST(lead_time_adherence_rate AS DOUBLE))
      comment: "Average lead time adherence rate - planning reliability metric"
    - name: "avg_moq_compliance_rate"
      expr: AVG(CAST(minimum_order_quantity_compliance_rate AS DOUBLE))
      comment: "Average minimum order quantity compliance rate - contract adherence metric"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount assessed against vendors - financial penalty and compliance cost metric"
    - name: "total_rtv_amount"
      expr: SUM(CAST(return_to_vendor_amount AS DOUBLE))
      comment: "Total return-to-vendor amount - quality issue financial impact metric"
    - name: "total_purchase_order_value"
      expr: SUM(CAST(total_purchase_order_value AS DOUBLE))
      comment: "Total purchase order value in scoring period - vendor spend volume metric"
    - name: "avg_score_improvement"
      expr: AVG(CAST(composite_score - prior_period_composite_score AS DOUBLE))
      comment: "Average period-over-period composite score change - vendor performance trend metric for steering decisions"
    - name: "corrective_action_rate"
      expr: AVG(CAST(CASE WHEN corrective_action_required = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of scorecards requiring corrective action - vendor risk and intervention metric"
    - name: "chargeback_per_po_value"
      expr: SUM(CAST(chargeback_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_purchase_order_value AS DOUBLE)), 0)
      comment: "Chargeback amount as ratio of purchase order value - vendor penalty rate for cost-of-quality analysis"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor chargeback and penalty metrics tracking compliance violations, financial penalties, and dispute resolution"
  source: "`vibe_retail_v1`.`supplier`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback (pending, approved, disputed, settled)"
    - name: "chargeback_type"
      expr: chargeback_type
      comment: "Type of chargeback (quality, delivery, compliance, documentation)"
    - name: "violation_category"
      expr: violation_category
      comment: "Category of vendor violation triggering the chargeback"
    - name: "dispute_status"
      expr: dispute_status
      comment: "Status of any dispute filed by vendor"
    - name: "is_repeat_violation"
      expr: is_repeat_violation
      comment: "Whether this is a repeat violation by the vendor"
    - name: "penalty_calculation_method"
      expr: penalty_calculation_method
      comment: "Method used to calculate penalty amount"
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover chargeback amount"
    - name: "violation_year"
      expr: YEAR(violation_date)
      comment: "Year of violation occurrence"
    - name: "violation_quarter"
      expr: CONCAT('Q', QUARTER(violation_date), '-', YEAR(violation_date))
      comment: "Quarter and year of violation occurrence"
    - name: "detection_year"
      expr: YEAR(detection_date)
      comment: "Year violation was detected"
  measures:
    - name: "total_chargebacks"
      expr: COUNT(DISTINCT chargeback_id)
      comment: "Total number of chargebacks issued - vendor compliance volume metric"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount assessed - financial impact of vendor non-compliance"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per chargeback - typical violation cost metric"
    - name: "avg_penalty_percentage"
      expr: AVG(CAST(penalty_percentage AS DOUBLE))
      comment: "Average penalty percentage applied - standard penalty rate metric"
    - name: "total_scorecard_impact"
      expr: SUM(CAST(vendor_scorecard_impact AS DOUBLE))
      comment: "Total vendor scorecard impact points - cumulative performance degradation metric"
    - name: "avg_scorecard_impact"
      expr: AVG(CAST(vendor_scorecard_impact AS DOUBLE))
      comment: "Average scorecard impact per chargeback - typical performance penalty metric"
    - name: "dispute_rate"
      expr: AVG(CAST(CASE WHEN dispute_status IS NOT NULL AND dispute_status != '' THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of chargebacks disputed by vendors - vendor relationship friction metric"
    - name: "repeat_violation_rate"
      expr: AVG(CAST(CASE WHEN is_repeat_violation = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of chargebacks for repeat violations - vendor learning and improvement metric"
    - name: "avg_detection_lag_days"
      expr: AVG(CAST(DATEDIFF(detection_date, violation_date) AS DOUBLE))
      comment: "Average days between violation and detection - compliance monitoring effectiveness metric"
    - name: "avg_resolution_lag_days"
      expr: AVG(CAST(DATEDIFF(resolution_date, detection_date) AS DOUBLE))
      comment: "Average days from detection to resolution - chargeback process efficiency metric"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor allowance and promotional funding metrics tracking trade spend, accruals, settlements, and claim performance"
  source: "`vibe_retail_v1`.`supplier`.`vendor_allowance`"
  dimensions:
    - name: "allowance_status"
      expr: allowance_status
      comment: "Current status of the allowance (active, expired, settled, cancelled)"
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of vendor allowance (promotional, volume, markdown, advertising)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the allowance"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of allowance claims"
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue allowance amounts"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to settle allowance payments"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year allowance became effective"
    - name: "effective_quarter"
      expr: CONCAT('Q', QUARTER(effective_start_date), '-', YEAR(effective_start_date))
      comment: "Quarter and year allowance became effective"
  measures:
    - name: "total_allowances"
      expr: COUNT(DISTINCT vendor_allowance_id)
      comment: "Total number of vendor allowances - trade spend program volume metric"
    - name: "total_allowance_amount"
      expr: SUM(CAST(allowance_amount AS DOUBLE))
      comment: "Total allowance amount committed - vendor funding commitment metric"
    - name: "total_accrued_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total accrued allowance amount - financial liability metric for trade spend"
    - name: "total_claimed_amount"
      expr: SUM(CAST(claimed_amount AS DOUBLE))
      comment: "Total claimed allowance amount - actual trade spend utilization metric"
    - name: "total_settled_amount"
      expr: SUM(CAST(settled_amount AS DOUBLE))
      comment: "Total settled allowance amount - realized trade spend metric"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total disputed allowance amount - vendor relationship friction and audit risk metric"
    - name: "claim_utilization_rate"
      expr: SUM(CAST(claimed_amount AS DOUBLE)) / NULLIF(SUM(CAST(allowance_amount AS DOUBLE)), 0) * 100.0
      comment: "Percentage of allowance amount claimed - trade spend effectiveness and vendor engagement metric"
    - name: "settlement_rate"
      expr: SUM(CAST(settled_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0) * 100.0
      comment: "Percentage of claimed amount settled - allowance processing efficiency metric"
    - name: "dispute_rate"
      expr: SUM(CAST(disputed_amount AS DOUBLE)) / NULLIF(SUM(CAST(claimed_amount AS DOUBLE)), 0) * 100.0
      comment: "Percentage of claimed amount disputed - vendor relationship quality and process accuracy metric"
    - name: "avg_allowance_percentage"
      expr: AVG(CAST(allowance_percentage AS DOUBLE))
      comment: "Average allowance percentage offered - typical trade spend rate metric"
    - name: "avg_minimum_purchase_amount"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase amount required - allowance qualification threshold metric"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_rtv_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return-to-vendor request metrics tracking product returns, quality issues, and vendor credit recovery"
  source: "`vibe_retail_v1`.`supplier`.`rtv_request`"
  dimensions:
    - name: "rtv_status"
      expr: rtv_status
      comment: "Current status of the RTV request (pending, approved, shipped, credited, rejected)"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized code for return reason"
    - name: "disposition_method"
      expr: disposition_method
      comment: "Method for disposing returned goods (credit, replacement, repair, scrap)"
    - name: "freight_responsibility"
      expr: freight_responsibility
      comment: "Party responsible for return freight costs"
    - name: "is_recall_related"
      expr: is_recall_related
      comment: "Whether RTV is related to a product recall"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Whether quality inspection is required for the return"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of quality inspection if performed"
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year RTV request was created"
    - name: "request_quarter"
      expr: CONCAT('Q', QUARTER(request_date), '-', YEAR(request_date))
      comment: "Quarter and year RTV request was created"
  measures:
    - name: "total_rtv_requests"
      expr: COUNT(DISTINCT rtv_request_id)
      comment: "Total number of RTV requests - vendor quality issue volume metric"
    - name: "total_return_quantity"
      expr: SUM(CAST(total_return_quantity AS DOUBLE))
      comment: "Total quantity of units returned to vendors - product quality volume metric"
    - name: "total_return_value"
      expr: SUM(CAST(total_return_value AS DOUBLE))
      comment: "Total value of goods returned to vendors - financial impact of quality issues"
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amount for RTV - vendor penalty for quality failures"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost for returns - logistics cost of quality issues"
    - name: "avg_return_value"
      expr: AVG(CAST(total_return_value AS DOUBLE))
      comment: "Average value per RTV request - typical return transaction size metric"
    - name: "recall_related_rate"
      expr: AVG(CAST(CASE WHEN is_recall_related = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of RTVs related to recalls - product safety issue rate metric"
    - name: "avg_authorization_lag_days"
      expr: AVG(CAST(DATEDIFF(authorization_date, request_date) AS DOUBLE))
      comment: "Average days from request to authorization - RTV process efficiency metric"
    - name: "avg_credit_lag_days"
      expr: AVG(CAST(DATEDIFF(credit_date, authorization_date) AS DOUBLE))
      comment: "Average days from authorization to credit - vendor credit processing speed metric"
    - name: "rtv_rate_by_value"
      expr: SUM(CAST(total_return_value AS DOUBLE)) / NULLIF(SUM(CAST(total_return_value AS DOUBLE)) + SUM(CAST(chargeback_amount AS DOUBLE)), 0) * 100.0
      comment: "RTV value as percentage of total vendor transactions - vendor quality performance metric"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor contract metrics tracking contract value, terms, compliance features, and renewal status"
  source: "`vibe_retail_v1`.`supplier`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the vendor contract (active, expired, pending, terminated)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of vendor contract (master, spot, blanket, consignment)"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether contract automatically renews"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether contract includes exclusivity terms"
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Whether EDI is enabled for this contract"
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Whether VMI is enabled for this contract"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code for the contract"
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "International commercial terms code"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year contract became effective"
    - name: "signature_year"
      expr: YEAR(signature_date)
      comment: "Year contract was signed"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT vendor_contract_id)
      comment: "Total number of vendor contracts - contract portfolio size metric"
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value_amount AS DOUBLE))
      comment: "Total contract value amount - committed vendor spend metric for financial planning"
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value_amount AS DOUBLE))
      comment: "Average contract value - typical contract size metric"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across contracts - negotiated savings rate metric"
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity - typical MOQ constraint metric"
    - name: "auto_renewal_rate"
      expr: AVG(CAST(CASE WHEN auto_renewal_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of contracts with auto-renewal - contract management automation metric"
    - name: "exclusivity_rate"
      expr: AVG(CAST(CASE WHEN exclusivity_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of contracts with exclusivity terms - vendor relationship depth metric"
    - name: "edi_adoption_rate"
      expr: AVG(CAST(CASE WHEN edi_enabled_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of contracts with EDI enabled - digital integration metric"
    - name: "vmi_adoption_rate"
      expr: AVG(CAST(CASE WHEN vmi_enabled_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of contracts with VMI enabled - supply chain automation metric"
    - name: "avg_contract_duration_days"
      expr: AVG(CAST(DATEDIFF(effective_end_date, effective_start_date) AS DOUBLE))
      comment: "Average contract duration in days - typical contract term length metric for planning"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_vendor_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor item catalog metrics tracking sourcing options, costs, lead times, and item-level vendor performance"
  source: "`vibe_retail_v1`.`supplier`.`vendor_item`"
  dimensions:
    - name: "vendor_item_status"
      expr: vendor_item_status
      comment: "Current status of vendor item (active, discontinued, pending, inactive)"
    - name: "category"
      expr: vendor_item_category
      comment: "Product category of vendor item"
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Whether this is the preferred vendor for the item"
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Whether item is private label"
    - name: "dsd_eligible_flag"
      expr: dsd_eligible_flag
      comment: "Whether item is eligible for direct store delivery"
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Whether EDI is enabled for this item"
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Whether VMI is enabled for this item"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where item is manufactured or sourced"
    - name: "cost_effective_year"
      expr: YEAR(cost_effective_date)
      comment: "Year current cost became effective"
  measures:
    - name: "total_vendor_items"
      expr: COUNT(DISTINCT vendor_item_id)
      comment: "Total number of vendor items - sourcing catalog breadth metric"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across vendor items - typical item cost metric for budgeting"
    - name: "total_catalog_value"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Sum of unit costs across catalog - total sourcing cost baseline metric"
    - name: "preferred_vendor_rate"
      expr: AVG(CAST(CASE WHEN preferred_vendor_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of items with preferred vendor designation - sourcing optimization metric"
    - name: "private_label_rate"
      expr: AVG(CAST(CASE WHEN private_label_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of items that are private label - brand strategy metric"
    - name: "dsd_eligible_rate"
      expr: AVG(CAST(CASE WHEN dsd_eligible_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of items eligible for direct store delivery - distribution efficiency opportunity metric"
    - name: "edi_enabled_rate"
      expr: AVG(CAST(CASE WHEN edi_enabled_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of items with EDI enabled - item-level digital integration metric"
    - name: "vmi_enabled_rate"
      expr: AVG(CAST(CASE WHEN vmi_enabled_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of items with VMI enabled - item-level supply chain automation metric"
    - name: "avg_case_pack_quantity"
      expr: AVG(CAST(case_pack_quantity AS DOUBLE))
      comment: "Average case pack quantity - typical packaging configuration metric for logistics planning"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`supplier_lead_time_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead time agreement metrics tracking delivery commitments, SLA targets, and supply chain planning parameters"
  source: "`vibe_retail_v1`.`supplier`.`lead_time_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of lead time agreement (active, expired, pending, suspended)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of lead time agreement (standard, expedited, seasonal, promotional)"
    - name: "scope_level"
      expr: scope_level
      comment: "Scope level of agreement (vendor, category, SKU, location)"
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Primary transportation mode for deliveries"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms for delivery"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether agreement automatically renews"
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Whether EDI is enabled for this agreement"
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Whether VMI is enabled for this agreement"
    - name: "delivery_frequency"
      expr: delivery_frequency
      comment: "Frequency of deliveries under agreement"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year agreement became effective"
  measures:
    - name: "total_agreements"
      expr: COUNT(DISTINCT lead_time_agreement_id)
      comment: "Total number of lead time agreements - supply chain planning coverage metric"
    - name: "avg_standard_lead_time_days"
      expr: AVG(CAST(standard_lead_time_days AS DOUBLE))
      comment: "Average standard lead time in days - typical replenishment cycle metric for inventory planning"
    - name: "avg_expedited_lead_time_days"
      expr: AVG(CAST(expedited_lead_time_days AS DOUBLE))
      comment: "Average expedited lead time in days - fast-track delivery capability metric"
    - name: "avg_seasonal_adjustment_days"
      expr: AVG(CAST(seasonal_lead_time_adjustment_days AS DOUBLE))
      comment: "Average seasonal lead time adjustment - seasonal planning buffer metric"
    - name: "avg_on_time_delivery_sla"
      expr: AVG(CAST(on_time_delivery_sla_percent AS DOUBLE))
      comment: "Average on-time delivery SLA percentage - contracted delivery performance target"
    - name: "avg_fill_rate_sla"
      expr: AVG(CAST(fill_rate_sla_percent AS DOUBLE))
      comment: "Average fill rate SLA percentage - contracted availability performance target"
    - name: "avg_compliance_penalty_rate"
      expr: AVG(CAST(compliance_penalty_rate AS DOUBLE))
      comment: "Average compliance penalty rate - typical SLA breach cost metric"
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity - typical MOQ constraint for planning"
    - name: "avg_order_increment_quantity"
      expr: AVG(CAST(order_increment_quantity AS DOUBLE))
      comment: "Average order increment quantity - order sizing constraint metric"
    - name: "edi_adoption_rate"
      expr: AVG(CAST(CASE WHEN edi_enabled_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of agreements with EDI enabled - digital ordering automation metric"
    - name: "vmi_adoption_rate"
      expr: AVG(CAST(CASE WHEN vmi_enabled_flag = TRUE THEN 100.0 ELSE 0.0 END AS DOUBLE))
      comment: "Percentage of agreements with VMI enabled - vendor-managed inventory adoption metric"
    - name: "lead_time_reduction_opportunity"
      expr: AVG(CAST(standard_lead_time_days AS DOUBLE)) - AVG(CAST(expedited_lead_time_days AS DOUBLE))
      comment: "Average difference between standard and expedited lead times - supply chain acceleration potential metric for strategic planning"
$$;
