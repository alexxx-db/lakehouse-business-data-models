-- Metric views for domain: supply | Business: Water_Utilities | Version: 2 | Generated on: 2026-07-10 19:05:00

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order volume, spend, and approval cycle performance. Enables procurement leadership to monitor committed spend, capital vs. operating mix, and approval efficiency across cost centers, funds, and vendors."
  source: "`vibe_water_utilities_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g., Open, Approved, Closed, Cancelled) — primary filter for active spend analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Blanket, Framework) — used to segment spend by procurement strategy."
    - name: "is_capital_purchase"
      expr: is_capital_purchase
      comment: "Flag indicating whether the PO is a capital expenditure — critical for CapEx vs. OpEx budget tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO — used to identify bottlenecks in the procurement approval pipeline."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order — needed for multi-currency spend normalization."
    - name: "po_date_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the PO was issued — enables trend analysis of procurement activity over time."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month the delivery was requested — used to align procurement demand with operational schedules."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline volume metric for procurement activity monitoring."
    - name: "total_committed_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders (pre-tax). Core CapEx/OpEx budget consumption metric used in quarterly financial reviews."
    - name: "total_committed_spend_with_tax"
      expr: SUM(CAST(total_amount_with_tax AS DOUBLE))
      comment: "Total committed spend including tax. Used for full-cost budget reconciliation and cash flow forecasting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across purchase orders. Supports tax accrual and compliance reporting."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across purchase orders. Enables logistics cost optimization and vendor freight term negotiations."
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value. Benchmarks procurement transaction size and identifies outliers requiring additional scrutiny."
    - name: "capital_po_count"
      expr: COUNT(CASE WHEN is_capital_purchase = TRUE THEN 1 END)
      comment: "Number of capital purchase orders. Tracks CIP-related procurement volume for capital program management."
    - name: "capital_spend_amount"
      expr: SUM(CASE WHEN is_capital_purchase = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total spend on capital purchase orders. Essential for CIP budget tracking and rate case capital expenditure documentation."
    - name: "approved_po_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved purchase orders. Measures procurement throughput and approval pipeline health."
    - name: "pending_approval_po_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Rejected', 'Cancelled') THEN 1 END)
      comment: "Number of POs awaiting approval. Operational metric for identifying procurement bottlenecks and cycle time issues."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor scorecard KPIs measuring delivery reliability, quality conformance, pricing accuracy, and overall supplier performance. Drives vendor rationalization, contract renewal decisions, and corrective action management."
  source: "`vibe_water_utilities_v1`.`supply`.`vendor_performance`"
  dimensions:
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Categorical performance rating assigned to the vendor (e.g., Excellent, Satisfactory, Unsatisfactory) — primary dimension for vendor tier segmentation."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the performance evaluation record (e.g., Draft, Final, Approved) — filters for completed evaluations only."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity or service category being evaluated — enables category-level supplier performance benchmarking."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates whether a corrective action plan was required — key risk flag for supplier quality management."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start_date)
      comment: "Start month of the evaluation period — enables trending of vendor performance over time."
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of vendor performance evaluations completed. Baseline metric for supplier management program activity."
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall vendor performance score across all evaluations. Primary KPI for vendor scorecard dashboards and contract renewal decisions."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate across evaluated vendors. Measures supply chain reliability — critical for chemical and emergency materials procurement."
    - name: "avg_quality_conformance_rate_pct"
      expr: AVG(CAST(quality_conformance_rate_pct AS DOUBLE))
      comment: "Average quality conformance rate. Tracks whether materials meet NSF/AWWA specifications — directly linked to water quality compliance risk."
    - name: "avg_pricing_accuracy_rate_pct"
      expr: AVG(CAST(pricing_accuracy_rate_pct AS DOUBLE))
      comment: "Average pricing accuracy rate. Measures invoice-to-PO price match — drives accounts payable efficiency and contract compliance."
    - name: "avg_order_fill_rate_pct"
      expr: AVG(CAST(order_fill_rate_pct AS DOUBLE))
      comment: "Average order fill rate across vendors. Measures supply availability — critical for maintaining chemical inventory and avoiding treatment disruptions."
    - name: "avg_coa_compliance_rate_pct"
      expr: AVG(CAST(coa_compliance_rate_pct AS DOUBLE))
      comment: "Average Certificate of Analysis compliance rate. Measures vendor documentation compliance for regulated materials (NSF/ANSI 61, AWWA standards)."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average vendor responsiveness score. Measures vendor communication and issue resolution speed — important for emergency procurement scenarios."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of evaluations requiring corrective action. Risk metric for identifying underperforming vendors requiring intervention or disqualification."
    - name: "total_order_value_evaluated"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total value of orders covered by performance evaluations. Provides spend-weighted context for performance scores."
    - name: "distinct_vendors_evaluated"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors evaluated. Measures breadth of supplier performance management program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs covering invoice volumes, payment timing, discount capture, and exception rates. Supports working capital management, early payment discount optimization, and AP process efficiency."
  source: "`vibe_water_utilities_v1`.`supply`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the vendor invoice (e.g., Received, Approved, Paid, Blocked) — primary dimension for AP pipeline analysis."
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Payment method used (e.g., ACH, Check, Wire) — used to analyze payment channel mix and associated costs."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code (e.g., Net30, 2/10Net30) — critical for early payment discount capture analysis."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception type code for invoices with matching or processing issues — drives root cause analysis for AP exceptions."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice — enables year-over-year spend and liability comparisons."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice — supports period-close accrual and liability reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was dated — enables monthly AP volume and spend trend analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant/facility code associated with the invoice — enables facility-level spend tracking."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices received. Baseline AP volume metric for staffing and process capacity planning."
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount across all invoices. Primary AP liability metric for cash flow forecasting and budget reconciliation."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Actual cash outflow metric for working capital management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across invoices. Supports tax accrual, use tax compliance, and tax jurisdiction reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures effectiveness of dynamic discounting and early payment programs — directly impacts working capital cost."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax amounts. Required for 1099 reporting and tax compliance for applicable vendor types."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average invoice amount. Benchmarks transaction size and identifies anomalous invoices for fraud detection."
    - name: "exception_invoice_count"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL AND exception_code <> '' THEN 1 END)
      comment: "Number of invoices with processing exceptions. Measures AP process quality — high exception rates indicate vendor data quality or PO management issues."
    - name: "distinct_vendors_invoiced"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors submitting invoices. Measures active vendor base size for supplier consolidation analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving and three-way match KPIs measuring goods receipt volumes, value received, quality inspection rates, and reversal activity. Supports inventory accuracy, supplier delivery performance, and AP three-way match efficiency."
  source: "`vibe_water_utilities_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Status of the goods receipt document (e.g., Posted, Reversed, Blocked) — primary filter for valid receipt activity."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type code (e.g., 101=GR for PO, 122=Return) — classifies the nature of the stock movement."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g., Unrestricted, Quality Inspection, Blocked) — critical for inventory availability analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the PO/GR/Invoice three-way match — key AP control metric for payment authorization."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Indicates whether quality inspection was required for the received goods — used to track NSF/AWWA compliance inspection rates."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the goods receipt was reversed — used to identify receiving errors and supplier return activity."
    - name: "gr_posting_month"
      expr: DATE_TRUNC('MONTH', gr_posting_date)
      comment: "Month the goods receipt was posted — enables monthly receiving volume and value trend analysis."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt documents. Baseline receiving activity metric for warehouse operations planning."
    - name: "total_received_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of goods received. Primary inventory inflow metric for asset capitalization and inventory valuation."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts. Measures physical inventory inflow volume for stock replenishment tracking."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received goods. Benchmarks procurement pricing and detects price variance from PO terms."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed goods receipts. Measures receiving error rate and supplier return frequency — high rates indicate quality or logistics issues."
    - name: "quality_inspection_receipt_count"
      expr: COUNT(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of receipts requiring quality inspection. Tracks compliance with NSF/AWWA material qualification requirements."
    - name: "three_way_match_passed_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'Matched' THEN 1 END)
      comment: "Number of receipts where three-way match passed. Measures AP control effectiveness and invoice processing straight-through rate."
    - name: "distinct_vendors_received_from"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors from whom goods were received. Measures active supply base breadth for a given period."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_inventory_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and working capital KPIs covering stock levels, turnover, safety stock adequacy, and days of supply. Enables procurement and operations leadership to prevent stockouts of critical materials (chemicals, spare parts) while minimizing carrying costs."
  source: "`vibe_water_utilities_v1`.`supply`.`inventory_stock`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the inventory stock record (e.g., Active, Obsolete, Blocked) — primary filter for active inventory analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (e.g., Unrestricted, Quality Inspection, Blocked) — used to assess available vs. restricted inventory."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification of the material (A=high value/critical, B=medium, C=low) — drives inventory management priority and review frequency."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the stocked material is hazardous — required for regulatory compliance and safety reporting."
    - name: "mrp_type"
      expr: mrp_type
      comment: "Material Requirements Planning type — indicates replenishment strategy (e.g., reorder point, MRP, manual) for inventory optimization."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant/facility code where stock is held — enables facility-level inventory analysis."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type for the material (e.g., External, In-house) — used to segment make vs. buy inventory."
  measures:
    - name: "total_stock_value"
      expr: SUM(CAST(stock_value_amount AS DOUBLE))
      comment: "Total value of inventory on hand. Primary working capital metric — high stock values tie up capital that could fund CIP projects."
    - name: "total_unrestricted_quantity"
      expr: SUM(CAST(unrestricted_stock_quantity AS DOUBLE))
      comment: "Total unrestricted (available) stock quantity. Measures immediately usable inventory for operations and maintenance."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity after reservations. Net available stock for fulfilling new material requisitions."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for open work orders and requisitions. Measures committed inventory demand."
    - name: "total_blocked_stock_quantity"
      expr: SUM(CAST(blocked_stock_quantity AS DOUBLE))
      comment: "Total blocked stock quantity (quality holds, returns). Measures inventory unavailable for use — high values indicate quality or receiving issues."
    - name: "total_quality_inspection_quantity"
      expr: SUM(CAST(quality_inspection_stock_quantity AS DOUBLE))
      comment: "Total quantity in quality inspection. Tracks materials awaiting NSF/AWWA compliance clearance before use."
    - name: "avg_stock_turnover_ratio"
      expr: AVG(CAST(stock_turnover_ratio AS DOUBLE))
      comment: "Average inventory turnover ratio. Measures how efficiently inventory is consumed — low turnover indicates excess stock and unnecessary carrying costs."
    - name: "avg_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply remaining across stocked materials. Critical operational metric — low values signal risk of stockout for treatment chemicals or critical spare parts."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN CAST(available_quantity AS DOUBLE) < CAST(reorder_point AS DOUBLE) THEN 1 END)
      comment: "Number of materials below their reorder point. Urgent procurement trigger metric — directly prevents treatment chemical stockouts and service disruptions."
    - name: "below_safety_stock_count"
      expr: COUNT(CASE WHEN CAST(available_quantity AS DOUBLE) < CAST(safety_stock_quantity AS DOUBLE) THEN 1 END)
      comment: "Number of materials below safety stock level. Critical risk metric — materials below safety stock represent immediate operational risk for water treatment continuity."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs covering contract value, utilization, expiration risk, and diversity spend. Enables procurement leadership to manage contract compliance, renewal pipelines, and supplier diversity goals."
  source: "`vibe_water_utilities_v1`.`supply`.`procurement_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the procurement contract (e.g., Active, Expired, Terminated, Draft) — primary filter for active contract portfolio analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., Blanket, Fixed Price, Time & Materials) — used to segment contract portfolio by procurement strategy."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity or service category covered by the contract — enables category-level contract coverage analysis."
    - name: "minority_business_enterprise"
      expr: minority_business_enterprise
      comment: "Indicates whether the contract is with a minority business enterprise — tracks supplier diversity program compliance."
    - name: "small_business_enterprise"
      expr: small_business_enterprise
      comment: "Indicates whether the contract is with a small business enterprise — tracks small business set-aside compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency — used for multi-currency contract portfolio valuation."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective — enables contract vintage analysis and renewal pipeline planning."
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month the contract expires — critical for renewal pipeline management and avoiding uncontracted spend."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of procurement contracts. Baseline portfolio size metric for contract management capacity planning."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all contracts in portfolio. Primary metric for procurement spend under contract — high coverage reduces maverick spend risk."
    - name: "total_released_value"
      expr: SUM(CAST(total_released_value AS DOUBLE))
      comment: "Total value released/called off against contracts. Measures actual contract utilization vs. committed value."
    - name: "total_remaining_contract_value"
      expr: SUM(CAST(remaining_contract_value AS DOUBLE))
      comment: "Total remaining uncommitted contract value. Measures available contract capacity for future procurement without new sourcing events."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value. Benchmarks contract size and identifies outlier contracts requiring enhanced oversight."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active contracts. Measures active contract coverage for procurement operations."
    - name: "diversity_contract_count"
      expr: COUNT(CASE WHEN minority_business_enterprise = TRUE OR small_business_enterprise = TRUE THEN 1 END)
      comment: "Number of contracts with diversity-certified vendors. Tracks supplier diversity program performance against regulatory and policy goals."
    - name: "total_released_quantity"
      expr: SUM(CAST(total_released_quantity AS DOUBLE))
      comment: "Total quantity released against contracts. Measures physical contract utilization for volume-based contracts."
    - name: "distinct_vendors_under_contract"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active contracts. Measures contracted supply base breadth for vendor consolidation analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_approved_vendor_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved vendor list (AVL) qualification and compliance KPIs. Tracks vendor qualification status, spend authorization limits, performance ratings, and compliance certifications to ensure only qualified suppliers are used for water utility procurement."
  source: "`vibe_water_utilities_v1`.`supply`.`approved_vendor_list`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the vendor on the AVL (e.g., Approved, Suspended, Expired) — primary filter for active qualified vendor analysis."
    - name: "approval_type"
      expr: approval_type
      comment: "Type of approval (e.g., Full, Conditional, Provisional) — used to segment vendor qualification tier."
    - name: "service_category_code"
      expr: service_category_code
      comment: "Service or commodity category for which the vendor is approved — enables category-level AVL coverage analysis."
    - name: "nsf_certification_flag"
      expr: nsf_certification_flag
      comment: "Indicates whether the vendor holds NSF certification — critical compliance dimension for water treatment chemical and material suppliers."
    - name: "awwa_standards_compliance_flag"
      expr: awwa_standards_compliance_flag
      comment: "Indicates whether the vendor meets AWWA standards — required for water infrastructure material procurement."
    - name: "local_vendor_flag"
      expr: local_vendor_flag
      comment: "Indicates whether the vendor is a local supplier — used for local preference policy compliance and emergency supply chain resilience."
    - name: "minority_owned_business_flag"
      expr: minority_owned_business_flag
      comment: "Indicates minority-owned business status — tracks supplier diversity program participation."
    - name: "woman_owned_business_flag"
      expr: woman_owned_business_flag
      comment: "Indicates woman-owned business status — tracks supplier diversity program participation."
    - name: "qualification_year"
      expr: DATE_TRUNC('YEAR', qualification_date)
      comment: "Year the vendor was qualified — enables cohort analysis of vendor qualification vintage and renewal cycles."
  measures:
    - name: "total_approved_vendors"
      expr: COUNT(1)
      comment: "Total number of approved vendor list entries. Baseline metric for qualified supply base size."
    - name: "active_approved_vendor_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of currently active approved vendors. Measures available qualified supply base for procurement operations."
    - name: "suspended_vendor_count"
      expr: COUNT(CASE WHEN approval_status = 'Suspended' THEN 1 END)
      comment: "Number of suspended vendors. Risk metric — suspended vendors indicate supply chain disruption risk requiring alternative sourcing."
    - name: "nsf_certified_vendor_count"
      expr: COUNT(CASE WHEN nsf_certification_flag = TRUE THEN 1 END)
      comment: "Number of NSF-certified approved vendors. Compliance metric ensuring adequate qualified supply base for regulated water treatment materials."
    - name: "avg_performance_rating_score"
      expr: AVG(CAST(performance_rating_score AS DOUBLE))
      comment: "Average performance rating score across approved vendors. Measures overall quality of the approved supply base."
    - name: "total_approved_spend_limit"
      expr: SUM(CAST(approved_spend_limit_amount AS DOUBLE))
      comment: "Total approved spend limit across all AVL entries. Measures total authorized procurement capacity within the qualified vendor base."
    - name: "diversity_vendor_count"
      expr: COUNT(CASE WHEN minority_owned_business_flag = TRUE OR woman_owned_business_flag = TRUE THEN 1 END)
      comment: "Number of diversity-certified vendors on the approved list. Tracks supplier diversity program pipeline and compliance with diversity spend goals."
    - name: "all_qualifications_met_count"
      expr: COUNT(CASE WHEN financial_qualification_met_flag = TRUE AND technical_qualification_met_flag = TRUE AND quality_qualification_met_flag = TRUE AND safety_qualification_met_flag = TRUE THEN 1 END)
      comment: "Number of vendors meeting all qualification criteria simultaneously. Measures the fully-qualified vendor pool available for high-value or critical procurements."
    - name: "distinct_qualified_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors on the approved list. Measures unique qualified supplier count for supply base rationalization."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive sourcing KPIs measuring RFQ activity, bid participation, award values, and sourcing cycle performance. Enables procurement leadership to assess competitive bidding compliance, sourcing efficiency, and budget adherence."
  source: "`vibe_water_utilities_v1`.`supply`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g., Open, Closed, Awarded, Cancelled) — primary filter for active sourcing pipeline analysis."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g., Formal Bid, Informal Quote, Emergency) — used to segment sourcing events by procurement method."
    - name: "competitive_bidding_flag"
      expr: competitive_bidding_flag
      comment: "Indicates whether the RFQ was a competitive bid — tracks compliance with competitive procurement thresholds."
    - name: "bonding_required_flag"
      expr: bonding_required_flag
      comment: "Indicates whether performance bonding was required — used for capital project procurement compliance tracking."
    - name: "insurance_required_flag"
      expr: insurance_required_flag
      comment: "Indicates whether insurance was required — tracks risk management compliance in procurement."
    - name: "diversity_preference_flag"
      expr: diversity_preference_flag
      comment: "Indicates whether diversity preference was applied — tracks supplier diversity program integration in sourcing."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the RFQ was issued — enables sourcing activity trend analysis."
  measures:
    - name: "total_rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued. Baseline sourcing activity metric for procurement workload and competitive bidding compliance monitoring."
    - name: "total_estimated_budget"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all RFQs. Measures procurement pipeline value for budget planning and cash flow forecasting."
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total value awarded through RFQ process. Measures actual sourcing outcomes vs. budget estimates for procurement efficiency analysis."
    - name: "avg_awarded_amount"
      expr: AVG(CAST(awarded_amount AS DOUBLE))
      comment: "Average award value per RFQ. Benchmarks sourcing transaction size and identifies outlier awards requiring board or regulatory approval."
    - name: "competitive_rfq_count"
      expr: COUNT(CASE WHEN competitive_bidding_flag = TRUE THEN 1 END)
      comment: "Number of RFQs conducted as competitive bids. Measures compliance with competitive procurement thresholds required by public utility regulations."
    - name: "avg_quotes_received"
      expr: AVG(CAST(quotes_received_count AS DOUBLE))
      comment: "Average number of quotes received per RFQ. Measures market competition and sourcing effectiveness — low values may indicate supply market concentration risk."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all RFQs. Measures procurement demand volume for supply market capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory transaction KPIs tracking material flow, consumption value, and reversal activity. Enables operations and finance to monitor material consumption rates, cost center allocations, and inventory accuracy."
  source: "`vibe_water_utilities_v1`.`supply`.`stock_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type code (e.g., 101=GR, 201=GI to Cost Center, 261=GI to Order) — primary dimension for classifying material flow direction and purpose."
    - name: "movement_status"
      expr: movement_status
      comment: "Processing status of the stock movement (e.g., Posted, Reversed, Pending) — used to filter valid movements for consumption analysis."
    - name: "movement_indicator"
      expr: movement_indicator
      comment: "Indicator for movement direction (e.g., Receipt, Issue, Transfer) — used to separate inbound from outbound material flows."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the movement was reversed — used to identify and exclude erroneous transactions from consumption analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant/facility where the movement occurred — enables facility-level material consumption tracking."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type for the material movement — used for split valuation analysis (e.g., new vs. refurbished parts)."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the movement was posted — enables monthly material consumption trend analysis for budget vs. actual tracking."
  measures:
    - name: "total_movement_count"
      expr: COUNT(1)
      comment: "Total number of stock movements. Baseline inventory transaction volume metric for warehouse operations monitoring."
    - name: "total_movement_value"
      expr: SUM(CAST(amount_in_local_currency AS DOUBLE))
      comment: "Total value of all stock movements in local currency. Primary material cost flow metric for cost center consumption reporting and budget variance analysis."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across all stock movements. Measures physical material flow volume for consumption rate analysis."
    - name: "avg_movement_value"
      expr: AVG(CAST(amount_in_local_currency AS DOUBLE))
      comment: "Average value per stock movement. Benchmarks transaction size and identifies high-value movements requiring additional authorization."
    - name: "reversal_movement_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed stock movements. Measures inventory posting error rate — high reversal rates indicate data quality or process compliance issues."
    - name: "reversal_value"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN CAST(amount_in_local_currency AS DOUBLE) ELSE 0 END)
      comment: "Total value of reversed stock movements. Measures financial impact of inventory posting errors on cost center allocations."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition pipeline KPIs measuring demand creation, approval cycle performance, and spend authorization. Enables procurement and finance to monitor demand-to-PO conversion, budget pre-commitment, and requisition backlog."
  source: "`vibe_water_utilities_v1`.`supply`.`purchase_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the purchase requisition (e.g., Open, Approved, Converted to PO, Rejected) — primary filter for active demand pipeline analysis."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (e.g., Standard, Emergency, Blanket) — used to segment demand by procurement urgency and method."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level of the requisition (e.g., Urgent, Normal, Low) — used to identify high-priority procurement needs requiring expedited processing."
    - name: "account_assignment_category"
      expr: account_assignment_category
      comment: "Account assignment category (e.g., Cost Center, Project, Asset) — determines how the procurement cost will be allocated in the general ledger."
    - name: "requesting_plant_code"
      expr: requesting_plant_code
      comment: "Plant/facility originating the requisition — enables facility-level demand analysis."
    - name: "requisition_month"
      expr: DATE_TRUNC('MONTH', requisition_date)
      comment: "Month the requisition was created — enables monthly demand trend analysis for procurement planning."
    - name: "required_delivery_month"
      expr: DATE_TRUNC('MONTH', required_delivery_date)
      comment: "Month the material is required — used for demand forecasting and procurement lead time management."
  measures:
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions created. Baseline procurement demand metric for workload planning."
    - name: "total_estimated_requisition_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated value of all purchase requisitions. Measures pre-committed procurement demand for budget planning and cash flow forecasting."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across requisitions. Benchmarks price expectations and identifies requisitions with anomalous pricing for review."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all requisitions. Measures aggregate procurement demand volume for supply planning."
    - name: "approved_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'Approved' THEN 1 END)
      comment: "Number of approved requisitions. Measures procurement approval throughput and pipeline conversion rate."
    - name: "rejected_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected requisitions. Measures demand quality and budget compliance — high rejection rates indicate poor demand planning or budget overruns."
    - name: "distinct_requestors"
      expr: COUNT(DISTINCT primary_purchase_requisitioner_employee_id)
      comment: "Number of distinct employees creating requisitions. Measures breadth of procurement demand origination across the organization."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor base health metrics for procurement governance"
  source: "`vibe_water_utilities_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (Active, Inactive, etc.)"
    - name: "vendor_type"
      expr: vendor_type
      comment: "Classification of vendor (e.g., Manufacturer, Distributor)"
    - name: "small_business_flag"
      expr: small_business_flag
      comment: "Indicates if vendor is a small business"
    - name: "woman_owned_flag"
      expr: woman_owned_flag
      comment: "Indicates if vendor is woman‑owned"
    - name: "minority_owned_flag"
      expr: minority_owned_flag
      comment: "Indicates if vendor is minority‑owned"
    - name: "country_code"
      expr: country_code
      comment: "Country where the vendor is located"
  measures:
    - name: "vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the system"
    - name: "certified_insurance_vendor_count"
      expr: SUM(CASE WHEN insurance_certificate_on_file_flag THEN 1 ELSE 0 END)
      comment: "Count of vendors with a valid insurance certificate on file"
    - name: "active_vendor_count"
      expr: SUM(CASE WHEN vendor_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of vendors currently marked as Active"
$$;