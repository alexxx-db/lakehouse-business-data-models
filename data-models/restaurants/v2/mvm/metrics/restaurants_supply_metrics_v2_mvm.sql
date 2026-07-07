-- Metric views for domain: supply | Business: Restaurants | Version: 2 | Generated on: 2026-07-02 03:59:48

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order management — tracks procurement spend, approval efficiency, and order fulfilment timing across suppliers and restaurant units."
  source: "`vibe_restaurants_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "purchase_order_status"
      expr: purchase_order_status
      comment: "Current lifecycle status of the purchase order (e.g. Draft, Submitted, Approved, Received, Cancelled) — used to segment open vs. closed procurement activity."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the purchase order — distinguishes pending, approved, and rejected orders for governance reporting."
    - name: "is_approved"
      expr: is_approved
      comment: "Boolean flag indicating whether the purchase order has been formally approved — used to filter approved spend."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the purchase order is denominated — supports multi-currency spend analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Agreed payment terms on the purchase order (e.g. Net 30, Net 60) — used to analyse cash-flow exposure by terms bucket."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method specified on the purchase order — used to analyse logistics cost and lead-time by delivery mode."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Calendar month in which the purchase order was placed — primary time dimension for procurement trend analysis."
    - name: "expected_delivery_date"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Calendar month of the expected delivery date — used to project incoming supply and identify future delivery concentration."
  measures:
    - name: "total_procurement_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed procurement spend across all purchase orders in scope. Core financial KPI for supply chain cost management and budget tracking."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per purchase order. Tracks purchasing efficiency and helps identify whether order consolidation opportunities exist."
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Used as the denominator for approval-rate and on-time-delivery-rate calculations and as a volume indicator."
    - name: "approved_order_count"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN 1 END)
      comment: "Number of purchase orders that have been formally approved. Tracks governance compliance and procurement workflow throughput."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase orders that have been approved. A low rate signals bottlenecks in the procurement approval workflow."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_purchase_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs — measures ordered vs. received quantities, unit pricing, and fulfilment accuracy to drive supplier performance and cost control decisions."
  source: "`vibe_restaurants_v1`.`supply`.`purchase_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Fulfilment status of the individual purchase order line (e.g. Open, Partially Received, Closed) — used to identify outstanding supply obligations."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered ingredient — enables quantity comparisons within the same UoM bucket."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line-level pricing — supports multi-currency cost analysis."
    - name: "expected_delivery_date"
      expr: DATE_TRUNC('month', expected_delivery_date)
      comment: "Calendar month of the expected line-level delivery — used to project ingredient availability by period."
    - name: "sku"
      expr: sku
      comment: "Stock-keeping unit identifier on the purchase order line — enables ingredient-level procurement analysis."
  measures:
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all purchase order lines. Tracks procurement volume and supports demand-supply balancing."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received against purchase order lines. Compared with ordered quantity to measure fulfilment completeness."
    - name: "total_extended_amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended line amount (unit price × quantity) across all purchase order lines. Represents committed ingredient-level spend."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value captured on purchase order lines. Measures negotiated savings and supplier discount utilisation."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price paid per purchase order line. Tracks price trends over time and supports price benchmarking against contracted rates."
    - name: "fulfilment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been received. A key supplier reliability KPI — low rates indicate supply shortfalls or delivery failures."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods receipt KPIs — monitors receiving volumes, cold-chain compliance, temperature deviations, and total inbound cost to manage food safety and supply quality."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Current status of the goods receipt (e.g. Pending, Completed, Rejected) — used to track receiving workflow completion."
    - name: "receiving_method"
      expr: receiving_method
      comment: "Method used to receive goods (e.g. dock, direct-store) — used to analyse receiving efficiency by method."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt cost — supports multi-currency inbound cost analysis."
    - name: "is_cold_chain_compliant"
      expr: is_cold_chain_compliant
      comment: "Boolean flag indicating whether the delivery maintained cold-chain integrity — critical food safety dimension."
    - name: "temperature_deviation_flag"
      expr: temperature_deviation_flag
      comment: "Boolean flag indicating a temperature deviation was recorded during receipt — used to identify food safety risk events."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Calendar month of the goods receipt — primary time dimension for inbound supply trend analysis."
  measures:
    - name: "total_inbound_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all goods received. Core inbound supply chain cost KPI used for budget tracking and supplier cost management."
    - name: "total_received_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts. Tracks inbound supply volume and supports inventory replenishment analysis."
    - name: "avg_receipt_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature recorded at goods receipt. Monitors cold-chain performance — deviations from safe ranges indicate food safety risk."
    - name: "cold_chain_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cold_chain_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts that were cold-chain compliant. A critical food safety KPI — low rates trigger supplier corrective actions and regulatory risk."
    - name: "temperature_deviation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts with a recorded temperature deviation. Directly linked to food safety risk and potential product rejection costs."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level inbound quality and quantity KPIs — tracks received vs. rejected quantities, quality scores, variance amounts, and compliance rates to drive supplier quality management."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt_line`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection outcome for the receipt line (e.g. Passed, Failed, Pending) — used to segment compliant vs. non-compliant inbound goods."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Boolean flag indicating whether the received item is perishable — used to prioritise quality monitoring for high-risk ingredients."
    - name: "is_returned"
      expr: is_returned
      comment: "Boolean flag indicating whether the line item was returned to the supplier — used to track return rates and supplier quality issues."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether the receipt line met compliance requirements — used to measure regulatory and quality adherence."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the received item — enables quantity comparisons within the same UoM bucket."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line-level cost — supports multi-currency inbound cost analysis."
    - name: "sku"
      expr: sku
      comment: "Stock-keeping unit of the received item — enables SKU-level quality and cost analysis."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received across all goods receipt lines. Core inbound volume KPI for supply chain throughput tracking."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt. High rejection volumes signal supplier quality failures and drive corrective action."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that was rejected. A primary supplier quality KPI — high rates trigger supplier reviews and sourcing changes."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score assigned at goods receipt line level. Tracks inbound ingredient quality trends and supports supplier scorecarding."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total financial variance between invoiced and received amounts. Measures invoice accuracy and supplier billing compliance — large variances drive AP disputes."
    - name: "total_inbound_line_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of goods received at line level. Enables ingredient-level cost tracking and supports cost-per-SKU analysis."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipt lines that met compliance requirements. Tracks regulatory and quality adherence at the ingredient receipt level."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety and quality inspection KPIs — monitors inspection pass/fail rates, corrective action requirements, and temperature compliance to manage food safety risk and regulatory obligations."
  source: "`vibe_restaurants_v1`.`supply`.`quality_inspection`"
  dimensions:
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the quality inspection (e.g. Pass, Fail, Conditional Pass) — primary dimension for quality performance segmentation."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of quality inspection performed (e.g. Incoming, In-Process, Final) — used to analyse quality performance by inspection stage."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for the quality inspection (e.g. Visual, Lab, Temperature) — used to assess inspection coverage and methodology effectiveness."
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defect identified during inspection — used to prioritise corrective actions by defect type."
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken on the inspected lot (e.g. Accept, Reject, Quarantine, Return to Supplier) — tracks how quality failures are resolved."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Boolean flag indicating whether the inspected item met compliance requirements — used for regulatory reporting."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating whether a corrective action was required — used to track supplier quality improvement obligations."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Current status of the quality inspection record (e.g. Open, Closed, Pending Review) — used to track inspection workflow completion."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Calendar month of the quality inspection — primary time dimension for quality trend analysis."
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of quality inspections performed. Tracks inspection throughput and coverage across inbound supply."
    - name: "pass_count"
      expr: COUNT(CASE WHEN inspection_result = 'Pass' THEN 1 END)
      comment: "Number of inspections with a passing result. Used to calculate pass rate and track quality improvement over time."
    - name: "fail_count"
      expr: COUNT(CASE WHEN inspection_result = 'Fail' THEN 1 END)
      comment: "Number of inspections with a failing result. Directly linked to supplier quality risk and potential food safety incidents."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quality inspections that passed. A primary food safety and supplier quality KPI — low rates trigger supplier corrective actions."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring corrective action. Tracks the burden of quality remediation and supplier non-conformance frequency."
    - name: "total_rejection_quantity"
      expr: SUM(CAST(rejection_quantity AS DOUBLE))
      comment: "Total quantity rejected across all quality inspections. Measures the volume of supply lost to quality failures — directly impacts food cost and waste."
    - name: "avg_inspection_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature recorded during quality inspections. Monitors cold-chain and storage temperature compliance — deviations indicate food safety risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master KPIs — evaluates supplier quality ratings, on-time delivery performance, approval status, and food safety certification to support strategic sourcing decisions."
  source: "`vibe_restaurants_v1`.`supply`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current status of the supplier (e.g. Active, Inactive, Suspended) — used to segment active vs. inactive supplier base."
    - name: "supplier_type"
      expr: supplier_type
      comment: "Classification of the supplier (e.g. Distributor, Manufacturer, Local Farm) — used to analyse performance by supply channel type."
    - name: "is_approved"
      expr: is_approved
      comment: "Boolean flag indicating whether the supplier is formally approved for procurement — used to enforce approved-supplier-list compliance."
    - name: "preferred_flag"
      expr: preferred_flag
      comment: "Boolean flag indicating whether the supplier is on the preferred supplier list — used to track preferred-supplier spend concentration."
    - name: "food_safety_certified_flag"
      expr: food_safety_certified_flag
      comment: "Boolean flag indicating whether the supplier holds a food safety certification — critical for regulatory compliance and risk management."
    - name: "country_code"
      expr: country_code
      comment: "Country of the supplier — used to analyse supply chain geographic concentration and geopolitical risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Default currency of the supplier — used for multi-currency spend analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms agreed with the supplier — used to analyse cash-flow exposure by supplier payment terms."
    - name: "onboarded_month"
      expr: DATE_TRUNC('month', onboarded_date)
      comment: "Calendar month the supplier was onboarded — used to track supplier base growth and cohort analysis."
  measures:
    - name: "active_supplier_count"
      expr: COUNT(CASE WHEN supplier_status = 'Active' THEN 1 END)
      comment: "Number of currently active suppliers. Tracks the size of the active supply base — a key indicator of supply chain resilience and concentration risk."
    - name: "approved_supplier_count"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN 1 END)
      comment: "Number of formally approved suppliers. Measures compliance with approved-supplier-list policies — unapproved supplier usage is a procurement governance risk."
    - name: "food_safety_certified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN food_safety_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers holding food safety certification. A regulatory compliance KPI — low rates indicate supply chain food safety risk exposure."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across all suppliers. Tracks overall supply base quality performance — used in supplier scorecarding and strategic sourcing reviews."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across all suppliers. A primary supply chain reliability KPI — low rates signal delivery risk and potential restaurant operational disruption."
    - name: "preferred_supplier_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN preferred_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers designated as preferred. Tracks strategic supplier relationship concentration and preferred-supplier programme effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice management KPIs — tracks invoice amounts, payment status, tax exposure, and matching accuracy to manage cash flow and supplier payment compliance."
  source: "`vibe_restaurants_v1`.`supply`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. Draft, Submitted, Approved, Paid, Disputed) — used to segment outstanding vs. settled payables."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g. Unpaid, Partially Paid, Paid) — used to track outstanding payment obligations."
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status of the invoice against PO and goods receipt (e.g. Matched, Unmatched, Exception) — used to identify invoice discrepancies."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the invoice — used to analyse cash-flow exposure by payment terms bucket."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice — supports multi-currency payables analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Calendar month of the invoice date — primary time dimension for payables trend analysis."
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Calendar month the invoice is due — used to project upcoming payment obligations and manage cash flow."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced amount across all invoices. Core accounts payable KPI for cash flow management and procurement cost tracking."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount (excluding tax). Used to measure pre-tax procurement spend and compare against purchase order commitments."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices. Tracks tax liability on procurement spend — used for tax reporting and cost allocation."
    - name: "unpaid_invoice_amount"
      expr: SUM(CASE WHEN payment_status != 'Paid' THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of unpaid invoices. Measures outstanding accounts payable exposure — a key cash flow and working capital management KPI."
    - name: "invoice_match_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN match_status = 'Matched' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that have been successfully three-way matched. Low match rates indicate invoice discrepancies, supplier billing errors, or receiving process failures."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_ingredient_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient lot traceability and quality KPIs — monitors lot quality scores, waste, yield, recall flags, and cold-chain compliance to manage food safety, traceability, and ingredient cost."
  source: "`vibe_restaurants_v1`.`supply`.`ingredient_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the ingredient lot (e.g. Available, Quarantined, Consumed, Expired) — used to track lot lifecycle and available inventory."
    - name: "lot_type"
      expr: lot_type
      comment: "Type classification of the ingredient lot — used to segment lots by procurement or production origin."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status of the lot — used to identify lots pending or failing inspection."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Boolean flag indicating whether the lot is subject to a recall — critical food safety dimension for traceability and regulatory response."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Boolean flag indicating whether the lot is organically certified — used to track organic ingredient sourcing compliance."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Boolean flag indicating whether the lot requires temperature-controlled storage — used to manage cold-chain compliance."
    - name: "traceability_enabled"
      expr: traceability_enabled
      comment: "Boolean flag indicating whether full traceability is enabled for the lot — used to assess traceability coverage across the supply chain."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the ingredient lot — used for provenance tracking and country-of-origin labelling compliance."
    - name: "received_month"
      expr: DATE_TRUNC('month', received_date)
      comment: "Calendar month the lot was received — primary time dimension for lot intake trend analysis."
    - name: "best_by_month"
      expr: DATE_TRUNC('month', best_by_date)
      comment: "Calendar month of the best-by date — used to identify lots approaching expiry and prioritise consumption."
  measures:
    - name: "total_lot_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all ingredient lots. Tracks inbound ingredient volume and supports inventory position analysis."
    - name: "total_lot_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all ingredient lots. Core ingredient cost KPI used for food cost management and supplier cost benchmarking."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across all ingredient lots. Tracks inbound ingredient quality trends and supports supplier quality scorecarding."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across ingredient lots. Measures usable ingredient output relative to received quantity — directly impacts food cost and recipe costing accuracy."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across ingredient lots. Tracks ingredient waste at the lot level — high waste rates drive food cost increases and sustainability concerns."
    - name: "recall_lot_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of ingredient lots subject to a recall. A critical food safety KPI — any non-zero value triggers immediate operational and regulatory response."
    - name: "traceability_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN traceability_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ingredient lots with full traceability enabled. Measures supply chain traceability coverage — low rates increase food safety recall response risk."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier contract management KPIs — tracks contract compliance, rebate exposure, liability limits, and contract lifecycle to support strategic sourcing governance and cost optimisation."
  source: "`vibe_restaurants_v1`.`supply`.`supplier_contract`"
  dimensions:
    - name: "supplier_contract_status"
      expr: supplier_contract_status
      comment: "Current lifecycle status of the supplier contract (e.g. Active, Expired, Terminated, Pending) — used to segment active vs. inactive contractual obligations."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of supplier contract (e.g. Master Supply Agreement, Spot Purchase, Framework) — used to analyse contract portfolio by type."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the contract — used to identify contracts with compliance issues requiring management attention."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of contract renewal (e.g. Auto-Renew, Manual, One-Time) — used to manage contract renewal pipeline and avoid unintended auto-renewals."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Boolean flag indicating whether the contract includes an exclusivity clause — used to track supply exclusivity commitments and sourcing flexibility."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract — supports multi-currency contract value analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Calendar month the contract became effective — used to track contract portfolio vintage and renewal cycles."
    - name: "effective_until_month"
      expr: DATE_TRUNC('month', effective_until)
      comment: "Calendar month the contract expires — used to identify contracts approaching expiry and prioritise renewal negotiations."
  measures:
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN supplier_contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active supplier contracts. Tracks the size of the active contract portfolio — a key procurement governance metric."
    - name: "total_liability_limit"
      expr: SUM(CAST(liability_limit AS DOUBLE))
      comment: "Total contractual liability limit across all supplier contracts. Measures the organisation's maximum financial exposure from supplier contract claims."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across supplier contracts. Tracks the value of negotiated rebates — a key lever for reducing net procurement cost."
    - name: "total_rebate_threshold_amount"
      expr: SUM(CAST(rebate_threshold_amount AS DOUBLE))
      comment: "Total rebate threshold amount across all contracts. Measures the spend commitment required to unlock supplier rebates — used to track rebate attainment progress."
    - name: "compliance_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status != 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of supplier contracts with a non-compliant status. Tracks contract compliance risk — high rates indicate supplier relationship or legal exposure."
    - name: "exclusivity_contract_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of supplier contracts with exclusivity clauses. Measures sourcing flexibility risk — high exclusivity concentration limits the ability to switch suppliers."
$$;