-- Metric views for domain: procurement | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over purchase orders — tracks procurement spend, order volumes, approval cycle efficiency, and tax exposure to support CFO-level spend governance and procurement performance reviews."
  source: "`mining_ecm`.`procurement`.`purchase_order`"
  filter: is_deleted = False AND deletion_indicator = False
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Closed, Cancelled) — used to segment active vs completed spend."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Framework Call-Off, Blanket) — drives procurement strategy analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organisation responsible for the order — enables spend analysis by organisational unit."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group within the purchasing organisation — supports team-level procurement performance tracking."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity / company code — enables cross-entity spend consolidation and intercompany analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or mine site receiving the goods — supports site-level procurement cost allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order — required for multi-currency spend normalisation."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms governing delivery risk and cost transfer — informs logistics cost attribution."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms agreed with the vendor — used to model cash-flow timing and working capital impact."
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "CAPEX vs OPEX classification — critical for budget governance and financial reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state of the purchase order — identifies bottlenecks in the procure-to-pay cycle."
    - name: "po_date_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the purchase order was raised — enables trend analysis of procurement activity over time."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month the delivery is due — supports supply planning and on-time delivery monitoring."
    - name: "priority"
      expr: priority
      comment: "Order priority level — used to triage urgent procurement needs and assess expediting costs."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — baseline volume metric for procurement activity tracking."
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Sum of net order values across all purchase orders — primary spend KPI for budget governance and vendor spend analysis."
    - name: "total_gross_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Sum of total order values including tax — used for full liability exposure reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Aggregate tax liability across purchase orders — supports tax compliance reporting and cash-flow forecasting."
    - name: "avg_net_order_value"
      expr: AVG(CAST(net_value AS DOUBLE))
      comment: "Average net value per purchase order — benchmarks order sizing and identifies abnormally large or small orders."
    - name: "approved_po_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of purchase orders that have received full approval — measures procurement throughput and approval efficiency."
    - name: "pending_approval_po_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Rejected', 'Cancelled') THEN 1 END)
      comment: "Number of purchase orders awaiting approval — flags approval bottlenecks that delay supply and increase operational risk."
    - name: "approved_spend_value"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN CAST(net_value AS DOUBLE) ELSE 0 END)
      comment: "Total net spend value on approved purchase orders — represents committed procurement expenditure for budget tracking."
    - name: "capex_spend_value"
      expr: SUM(CASE WHEN expenditure_type = 'CAPEX' THEN CAST(net_value AS DOUBLE) ELSE 0 END)
      comment: "Total CAPEX procurement spend — tracked separately for capital budget governance and asset investment reporting."
    - name: "opex_spend_value"
      expr: SUM(CASE WHEN expenditure_type = 'OPEX' THEN CAST(net_value AS DOUBLE) ELSE 0 END)
      comment: "Total OPEX procurement spend — monitored against operational budgets to control recurring cost base."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors receiving purchase orders — measures vendor base breadth and concentration risk."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_purchase_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs — tracks ordered quantities, net order values, delivery performance gaps, and invoice accuracy at the material and cost-centre level to support detailed spend analysis and goods receipt reconciliation."
  source: "`mining_ecm`.`procurement`.`purchase_order_line`"
  filter: deletion_indicator = False
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual PO line (e.g. Open, Partially Delivered, Closed) — used to identify lines with outstanding obligations."
    - name: "material_group"
      expr: material_group
      comment: "Material group classification — enables category-level spend analysis and sourcing strategy reviews."
    - name: "material_number"
      expr: material_number
      comment: "Specific material or SKU ordered — supports item-level demand and spend analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Destination plant for the ordered material — enables site-level consumption and cost allocation."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group responsible for the line — supports team-level procurement performance measurement."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the line item — required for multi-currency spend normalisation."
    - name: "account_assignment_category"
      expr: account_assignment_category
      comment: "Account assignment type (e.g. Cost Centre, WBS, Asset) — determines how the spend is financially posted."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered quantity — required for volume-based analysis and yield calculations."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month the line item is due for delivery — supports supply planning and on-time delivery monitoring."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Flag indicating whether a goods receipt is required for this line — distinguishes service lines from material lines."
    - name: "invoice_receipt_indicator"
      expr: invoice_receipt_indicator
      comment: "Flag indicating whether an invoice receipt is required — used to track three-way match compliance."
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of purchase order lines — baseline volume metric for procurement line activity."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Sum of net order values at line level — granular spend KPI for category and material-level cost management."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered across all lines — measures procurement volume for supply planning and vendor capacity assessment."
    - name: "total_quantity_received"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total quantity confirmed as received via goods receipt — measures actual supply fulfilment against orders."
    - name: "total_outstanding_quantity"
      expr: SUM(CAST(outstanding_quantity AS DOUBLE))
      comment: "Total quantity still outstanding (ordered but not yet received) — critical for supply gap and expediting decisions."
    - name: "total_invoice_quantity"
      expr: SUM(CAST(invoice_quantity AS DOUBLE))
      comment: "Total quantity invoiced by vendors — used to reconcile invoiced vs received quantities for three-way match."
    - name: "avg_net_price"
      expr: AVG(CAST(net_price AS DOUBLE))
      comment: "Average net unit price across order lines — benchmarks pricing against market rates and contract terms."
    - name: "open_line_count"
      expr: COUNT(CASE WHEN line_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Number of open purchase order lines — measures active procurement pipeline and outstanding commitments."
    - name: "over_delivery_tolerance_avg"
      expr: AVG(CAST(over_delivery_tolerance_percent AS DOUBLE))
      comment: "Average over-delivery tolerance percentage across lines — informs acceptable variance bands in goods receipt processing."
    - name: "under_delivery_tolerance_avg"
      expr: AVG(CAST(under_delivery_tolerance_percent AS DOUBLE))
      comment: "Average under-delivery tolerance percentage across lines — used to assess acceptable shortfall thresholds in supply contracts."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs — measures supply fulfilment accuracy, quality inspection rates, reversal rates, and valuation of received goods to support supply chain performance and three-way match governance."
  source: "`mining_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt document (e.g. Posted, Reversed, Blocked) — used to filter valid receipts from reversals."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP movement type code for the goods receipt — distinguishes standard receipts, returns, and special stock movements."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g. Unrestricted, Quality Inspection, Blocked) — critical for inventory availability analysis."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type applied to the received goods — supports split-valuation and cost layer analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt valuation — required for multi-currency inventory valuation."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the goods receipt was posted — enables trend analysis of inbound supply volumes over time."
    - name: "received_date_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month goods were physically received — used to measure actual delivery timing vs planned."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Indicates whether a quality inspection was required for this receipt — used to segment quality-controlled vs standard receipts."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flags receipts that have been reversed — used to calculate net receipt volumes and identify supply chain errors."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Physical condition of goods on receipt (e.g. Good, Damaged, Partial) — drives quality and supplier performance analysis."
    - name: "unloading_point"
      expr: unloading_point
      comment: "Physical unloading point at the receiving location — supports logistics and yard management analysis."
  measures:
    - name: "total_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipt documents — baseline measure of inbound supply activity."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received across all goods receipts — primary supply fulfilment volume KPI."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered as recorded on the goods receipt — used to compute receipt fill rate against ordered quantity."
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total value of goods received at standard or moving average price — measures inventory value added through procurement."
    - name: "total_gross_weight"
      expr: SUM(CAST(gross_weight AS DOUBLE))
      comment: "Total gross weight of goods received — supports logistics capacity planning and freight cost reconciliation."
    - name: "total_net_weight"
      expr: SUM(CAST(net_weight AS DOUBLE))
      comment: "Total net weight of goods received — used for yield and moisture-adjusted quantity analysis."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = True THEN 1 END)
      comment: "Number of reversed goods receipts — high reversal rates signal data quality issues, vendor disputes, or process failures."
    - name: "quality_inspection_count"
      expr: COUNT(CASE WHEN quality_inspection_required_flag = True THEN 1 END)
      comment: "Number of receipts requiring quality inspection — measures quality control workload and vendor quality risk exposure."
    - name: "avg_valuation_per_receipt"
      expr: AVG(CAST(valuation_amount AS DOUBLE))
      comment: "Average valuation amount per goods receipt — benchmarks typical receipt size for anomaly detection and cost control."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors delivering goods — measures active supplier base and concentration risk in inbound supply."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs — tracks vendor base health, risk exposure, certification status, and financial capacity to support strategic sourcing decisions, vendor rationalisation, and supply chain risk management."
  source: "`mining_ecm`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (e.g. Active, Blocked, Inactive) — used to segment the active supplier base."
    - name: "vendor_category"
      expr: vendor_category
      comment: "Category classification of the vendor (e.g. Contractor, Supplier, Service Provider) — supports category management."
    - name: "classification"
      expr: classification
      comment: "Strategic classification of the vendor (e.g. Preferred, Approved, Conditional) — drives sourcing strategy decisions."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the vendor — critical for supply chain risk management and contingency planning."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Financial credit rating of the vendor — used to assess financial stability and payment risk."
    - name: "country_code"
      expr: country_code
      comment: "Country of the vendor — enables geographic concentration risk analysis and trade compliance monitoring."
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status of the vendor (e.g. Certified, Expired, Pending) — ensures only compliant vendors are used."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Prequalification status of the vendor — gates vendor eligibility for new contracts and purchase orders."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates whether the vendor is on the preferred vendor list — used to measure preferred vendor utilisation rates."
    - name: "blacklist_flag"
      expr: blacklist_flag
      comment: "Indicates whether the vendor is blacklisted — critical compliance dimension to prevent spend with prohibited vendors."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Standard payment terms for the vendor — used to model working capital and cash-flow impact of the vendor base."
    - name: "onboarding_date_year"
      expr: DATE_TRUNC('YEAR', onboarding_date)
      comment: "Year the vendor was onboarded — tracks vendor base growth and renewal cycles."
  measures:
    - name: "total_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the master data — baseline measure of vendor base size for rationalisation analysis."
    - name: "active_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'Active' THEN 1 END)
      comment: "Number of active vendors — measures the effective supplier base available for procurement."
    - name: "blacklisted_vendor_count"
      expr: COUNT(CASE WHEN blacklist_flag = True THEN 1 END)
      comment: "Number of blacklisted vendors — compliance KPI; any spend with blacklisted vendors is a critical control failure."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = True THEN 1 END)
      comment: "Number of preferred vendors — measures the size of the strategic supplier panel for sourcing governance."
    - name: "high_risk_vendor_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Number of vendors rated high or critical risk — drives supply chain risk mitigation and contingency sourcing decisions."
    - name: "expired_certification_vendor_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Number of vendors with expired certifications — compliance KPI; expired certifications create regulatory and quality risk."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all vendors — measures aggregate financial exposure to the vendor base."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per vendor — benchmarks credit exposure and identifies outliers requiring financial risk review."
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage held by vendors — measures aggregate risk transfer through vendor insurance programmes."
    - name: "prequalified_vendor_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of prequalified vendors — measures the pool of vendors eligible for new contract awards."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard KPIs — aggregates delivery, quality, price, and service performance scores to support vendor rationalisation, contract renewal decisions, and corrective action management."
  source: "`mining_ecm`.`procurement`.`procurement_vendor_performance`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the vendor performance evaluation (e.g. Draft, Approved, Closed) — filters to completed evaluations for reporting."
    - name: "overall_performance_rating"
      expr: overall_performance_rating
      comment: "Qualitative overall performance rating (e.g. Excellent, Satisfactory, Poor) — used for vendor tiering and strategic sourcing decisions."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned during the evaluation — drives supply chain risk mitigation and contingency sourcing actions."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates whether a corrective action plan is required — flags vendors needing active performance management intervention."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates preferred vendor status at time of evaluation — used to monitor whether preferred vendors maintain performance standards."
    - name: "responsiveness_rating"
      expr: responsiveness_rating
      comment: "Qualitative responsiveness rating — measures vendor communication and issue resolution speed."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of procurement values in the evaluation period — required for multi-currency spend normalisation."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start_date)
      comment: "Start month of the evaluation period — enables trend analysis of vendor performance over time."
    - name: "evaluation_period_end_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_end_date)
      comment: "End month of the evaluation period — used to align performance scores to reporting periods."
  measures:
    - name: "total_evaluation_count"
      expr: COUNT(1)
      comment: "Total number of vendor performance evaluations — baseline measure of performance review programme coverage."
    - name: "avg_overall_performance_score"
      expr: AVG(CAST(overall_performance_score AS DOUBLE))
      comment: "Average overall vendor performance score — primary KPI for vendor scorecard reporting and strategic sourcing decisions."
    - name: "avg_delivery_performance_score"
      expr: AVG(CAST(delivery_performance_score AS DOUBLE))
      comment: "Average delivery performance score — measures vendor reliability in meeting delivery commitments."
    - name: "avg_quality_performance_score"
      expr: AVG(CAST(quality_performance_score AS DOUBLE))
      comment: "Average quality performance score — measures vendor product and service quality against specification."
    - name: "avg_price_performance_score"
      expr: AVG(CAST(price_performance_score AS DOUBLE))
      comment: "Average price performance score — measures vendor competitiveness and value for money."
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_percent AS DOUBLE))
      comment: "Average on-time delivery rate percentage — critical supply chain KPI; low rates signal delivery risk and operational disruption."
    - name: "avg_quality_acceptance_rate_pct"
      expr: AVG(CAST(quality_acceptance_rate_percent AS DOUBLE))
      comment: "Average quality acceptance rate percentage — measures proportion of deliveries meeting quality specifications."
    - name: "avg_rejection_rate_pct"
      expr: AVG(CAST(rejection_rate_percent AS DOUBLE))
      comment: "Average rejection rate percentage — high rejection rates drive rework costs and supply disruption; triggers corrective action."
    - name: "avg_invoice_accuracy_rate_pct"
      expr: AVG(CAST(invoice_accuracy_rate_percent AS DOUBLE))
      comment: "Average invoice accuracy rate percentage — measures vendor billing compliance; low rates increase AP processing costs."
    - name: "avg_price_variance_pct"
      expr: AVG(CAST(price_variance_percent AS DOUBLE))
      comment: "Average price variance percentage against contracted rates — measures vendor pricing compliance and contract leakage."
    - name: "total_procurement_value"
      expr: SUM(CAST(total_procurement_value AS DOUBLE))
      comment: "Total procurement spend with evaluated vendors in the period — contextualises performance scores with spend weight."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = True THEN 1 END)
      comment: "Number of evaluations requiring corrective action — measures the scale of active vendor performance remediation needed."
    - name: "avg_issue_resolution_time_days"
      expr: AVG(CAST(average_issue_resolution_time_days AS DOUBLE))
      comment: "Average days to resolve vendor issues — measures vendor responsiveness and the cost of supply chain disruptions."
    - name: "avg_order_fill_rate_pct"
      expr: AVG(CAST(order_fill_rate_percent AS DOUBLE))
      comment: "Average order fill rate percentage — measures vendor ability to fulfil ordered quantities in full, impacting production continuity."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs — tracks contracted spend commitments, contract lifecycle status, pricing terms, and renewal exposure to support contract governance, spend under management, and commercial risk management."
  source: "`mining_ecm`.`procurement`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (e.g. Active, Expired, Terminated) — used to segment the active contract portfolio."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g. Fixed Price, Cost Plus, Framework) — drives commercial risk and pricing strategy analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity associated with the contract — enables cross-entity contract portfolio analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organisation responsible for the contract — supports organisational spend under management reporting."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group managing the contract — enables team-level contract portfolio tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency — required for multi-currency portfolio valuation."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms governing delivery risk — informs logistics cost attribution and risk transfer analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms in the contract — used to model working capital impact of the contract portfolio."
    - name: "renewal_indicator"
      expr: renewal_indicator
      comment: "Indicates whether the contract has an auto-renewal clause — used to forecast future committed spend."
    - name: "price_escalation_clause"
      expr: price_escalation_clause
      comment: "Type of price escalation clause in the contract — critical for forecasting future cost increases."
    - name: "start_date_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the contract commenced — enables cohort analysis of contract vintage and renewal cycles."
    - name: "end_date_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the contract expires — used to identify upcoming contract renewals and expiry risk."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of contracts in the portfolio — baseline measure of contract management scope."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all contracts — primary KPI for spend under management and commercial commitment reporting."
    - name: "total_contracted_quantity"
      expr: SUM(CAST(contracted_quantity AS DOUBLE))
      comment: "Total contracted volume across all contracts — measures supply volume commitments for production planning."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value — benchmarks contract sizing and identifies outliers requiring enhanced governance."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active contracts — measures the live contract portfolio under management."
    - name: "active_contract_value"
      expr: SUM(CASE WHEN contract_status = 'Active' THEN CAST(total_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of active contracts — measures current committed spend under active contract governance."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across contracts — benchmarks contracted unit pricing for market competitiveness analysis."
    - name: "renewal_eligible_contract_count"
      expr: COUNT(CASE WHEN renewal_indicator = True THEN 1 END)
      comment: "Number of contracts with renewal clauses — measures the proportion of spend subject to automatic renewal risk."
    - name: "amended_contract_count"
      expr: COUNT(CASE WHEN latest_amendment_number IS NOT NULL THEN 1 END)
      comment: "Number of contracts that have been amended — high amendment rates signal scope instability and commercial risk."
    - name: "terminated_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Terminated' THEN 1 END)
      comment: "Number of terminated contracts — tracks early terminations which may indicate vendor performance failures or commercial disputes."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors under contract — measures contracted vendor base breadth and concentration risk."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory balance KPIs — tracks stock levels, valuation, accuracy, and safety stock compliance to support materials management, working capital optimisation, and production continuity decisions."
  source: "`mining_ecm`.`procurement`.`inventory_balance`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the inventory (e.g. Available, Blocked, In Transit) — used to segment usable vs restricted stock."
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location within the warehouse — enables location-level inventory analysis and space utilisation."
    - name: "valuation_type"
      expr: valuation_type
      comment: "Valuation type applied to the stock — supports split-valuation and cost layer analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the inventory valuation — required for multi-currency stock value reporting."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the inventory balance record — used to filter confirmed vs pending inventory postings."
    - name: "count_frequency_category"
      expr: count_frequency_category
      comment: "Frequency category for physical inventory counts (e.g. Annual, Cycle) — supports count planning and compliance monitoring."
    - name: "last_count_date_month"
      expr: DATE_TRUNC('MONTH', last_count_date)
      comment: "Month of the last physical inventory count — used to identify stale counts and schedule recount requirements."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for stock quantities — required for volume-based inventory analysis."
  measures:
    - name: "total_unrestricted_stock_quantity"
      expr: SUM(CAST(unrestricted_stock_quantity AS DOUBLE))
      comment: "Total unrestricted (available) stock quantity — primary inventory availability KPI for production continuity planning."
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total value of inventory on hand — key working capital KPI for balance sheet and cash-flow management."
    - name: "total_blocked_stock_quantity"
      expr: SUM(CAST(blocked_stock_quantity AS DOUBLE))
      comment: "Total blocked stock quantity — measures inventory held back due to quality issues or disputes, impacting production availability."
    - name: "total_in_transit_stock_quantity"
      expr: SUM(CAST(in_transit_stock_quantity AS DOUBLE))
      comment: "Total stock quantity in transit — measures pipeline inventory for supply planning and working capital forecasting."
    - name: "total_quality_inspection_stock_quantity"
      expr: SUM(CAST(quality_inspection_stock_quantity AS DOUBLE))
      comment: "Total stock under quality inspection — measures the volume of inventory at risk pending quality clearance."
    - name: "avg_stock_accuracy_percentage"
      expr: AVG(CAST(stock_accuracy_percentage AS DOUBLE))
      comment: "Average stock accuracy percentage — measures physical vs system inventory alignment; low accuracy drives write-offs and production disruptions."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total inventory variance quantity (physical count vs system) — measures stock discrepancy exposure requiring investigation."
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Total financial value of inventory variances — measures the monetary impact of stock discrepancies on the balance sheet."
    - name: "below_safety_stock_count"
      expr: COUNT(CASE WHEN unrestricted_stock_quantity < safety_stock_quantity THEN 1 END)
      comment: "Number of materials where unrestricted stock is below safety stock level — critical supply risk KPI; triggers emergency procurement."
    - name: "above_maximum_stock_count"
      expr: COUNT(CASE WHEN unrestricted_stock_quantity > maximum_stock_level_quantity THEN 1 END)
      comment: "Number of materials where stock exceeds maximum level — identifies overstock situations driving excess working capital and storage costs."
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials held in inventory — measures the breadth of the materials portfolio under management."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition KPIs — tracks requisition volumes, estimated spend, approval cycle efficiency, and conversion to purchase orders to support procurement pipeline management and demand planning."
  source: "`mining_ecm`.`procurement`.`requisition`"
  filter: deletion_indicator = False
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (e.g. Open, Approved, Converted, Rejected) — used to track the procurement pipeline."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (e.g. Standard, Blanket, Service) — supports category-level demand analysis."
    - name: "approval_workflow_status"
      expr: approval_workflow_status
      comment: "Status of the approval workflow — identifies bottlenecks in the requisition-to-order cycle."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Indicates whether the requisition has been converted to a purchase order — measures procurement pipeline conversion efficiency."
    - name: "material_group"
      expr: material_group
      comment: "Material group of the requested item — enables category-level demand and spend analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant requesting the material — supports site-level demand planning and budget allocation."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group responsible for processing the requisition — enables team-level workload and performance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimated requisition value — required for multi-currency spend pipeline reporting."
    - name: "priority_indicator"
      expr: priority_indicator
      comment: "Priority level of the requisition — used to triage urgent procurement needs and measure expediting workload."
    - name: "account_assignment_category"
      expr: account_assignment_category
      comment: "Account assignment type (e.g. Cost Centre, WBS, Asset) — determines financial posting and budget impact."
    - name: "requisition_date_month"
      expr: DATE_TRUNC('MONTH', requisition_date)
      comment: "Month the requisition was raised — enables trend analysis of procurement demand over time."
    - name: "required_delivery_date_month"
      expr: DATE_TRUNC('MONTH', required_delivery_date)
      comment: "Month the requester needs delivery — used to assess lead time adequacy and supply risk."
  measures:
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions — baseline measure of procurement demand pipeline volume."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all requisitions — measures the procurement demand pipeline value for budget forecasting."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per requisition — benchmarks typical procurement request size for anomaly detection."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity requested across all requisitions — measures aggregate demand volume for supply planning."
    - name: "approved_requisition_count"
      expr: COUNT(CASE WHEN approval_workflow_status = 'Approved' THEN 1 END)
      comment: "Number of approved requisitions — measures procurement approval throughput and pipeline readiness."
    - name: "pending_approval_requisition_count"
      expr: COUNT(CASE WHEN approval_workflow_status NOT IN ('Approved', 'Rejected', 'Cancelled') THEN 1 END)
      comment: "Number of requisitions awaiting approval — flags approval bottlenecks that delay procurement and risk supply continuity."
    - name: "converted_requisition_count"
      expr: COUNT(CASE WHEN conversion_status = 'Converted' THEN 1 END)
      comment: "Number of requisitions converted to purchase orders — measures procurement pipeline conversion efficiency."
    - name: "rejected_requisition_count"
      expr: COUNT(CASE WHEN requisition_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected requisitions — high rejection rates signal poor demand planning or budget non-compliance."
    - name: "approved_pipeline_value"
      expr: SUM(CASE WHEN approval_workflow_status = 'Approved' THEN CAST(estimated_value AS DOUBLE) ELSE 0 END)
      comment: "Total estimated value of approved requisitions not yet converted — measures committed but uncommitted procurement spend."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors nominated on requisitions — measures vendor diversity in the demand pipeline."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule KPIs — tracks planned vs actual delivery performance, outstanding quantities, and schedule adherence to support supply chain reliability monitoring and vendor delivery performance management."
  source: "`mining_ecm`.`procurement`.`delivery_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the delivery schedule line (e.g. Open, Delivered, Cancelled) — used to segment active vs completed schedules."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of delivery schedule (e.g. Firm, Forecast, JIT) — informs supply planning horizon and commitment level."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms governing delivery risk — informs logistics cost attribution and risk transfer analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity associated with the delivery schedule — enables cross-entity supply performance analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Destination plant for the scheduled delivery — supports site-level supply reliability monitoring."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group responsible for the schedule — enables team-level delivery performance tracking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for scheduled quantities — required for volume-based delivery performance analysis."
    - name: "priority_indicator"
      expr: priority_indicator
      comment: "Priority of the delivery schedule line — used to triage critical supply needs and measure expediting effectiveness."
    - name: "hazardous_material_indicator"
      expr: hazardous_material_indicator
      comment: "Indicates whether the scheduled material is hazardous — used to segment deliveries requiring special handling compliance."
    - name: "planned_delivery_date_month"
      expr: DATE_TRUNC('MONTH', planned_delivery_date)
      comment: "Month the delivery was planned — enables trend analysis of planned supply volumes and schedule adherence."
    - name: "actual_delivery_date_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month the delivery actually occurred — used to measure on-time delivery performance against plan."
  measures:
    - name: "total_schedule_line_count"
      expr: COUNT(1)
      comment: "Total number of delivery schedule lines — baseline measure of scheduled supply activity."
    - name: "total_called_off_quantity"
      expr: SUM(CAST(called_off_quantity AS DOUBLE))
      comment: "Total quantity called off against delivery schedules — measures actual demand placed on vendors under scheduling agreements."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed by vendors for delivery — measures vendor commitment to supply obligations."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity actually delivered — primary supply fulfilment KPI for production continuity management."
    - name: "total_outstanding_quantity"
      expr: SUM(CAST(outstanding_quantity AS DOUBLE))
      comment: "Total quantity still outstanding (called off but not delivered) — critical supply gap KPI for expediting and risk management."
    - name: "avg_delivery_tolerance_pct"
      expr: AVG(CAST(delivery_tolerance_percent AS DOUBLE))
      comment: "Average delivery tolerance percentage — measures acceptable variance bands in delivery quantity compliance."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= planned_delivery_date AND actual_delivery_date IS NOT NULL THEN 1 END)
      comment: "Number of schedule lines delivered on or before the planned date — numerator for on-time delivery rate calculation."
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date > planned_delivery_date THEN 1 END)
      comment: "Number of schedule lines delivered after the planned date — measures vendor delivery reliability failures."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with active delivery schedules — measures active supply base breadth."
$$;


CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`procurement_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight order KPIs — tracks freight costs, cargo volumes, customs clearance performance, and dangerous goods exposure to support logistics cost management and supply chain compliance."
  source: "`mining_ecm`.`procurement`.`freight_order`"
  dimensions:
    - name: "freight_status"
      expr: freight_status
      comment: "Current status of the freight order (e.g. In Transit, Delivered, Cancelled) — used to segment active vs completed freight movements."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g. Sea, Rail, Road, Air) — enables modal split analysis for logistics cost and carbon footprint management."
    - name: "direction"
      expr: direction
      comment: "Direction of freight movement (e.g. Inbound, Outbound) — distinguishes procurement inbound freight from sales outbound freight."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms governing freight risk and cost — informs logistics cost attribution and risk transfer analysis."
    - name: "freight_cost_currency_code"
      expr: freight_cost_currency_code
      comment: "Currency of the freight cost — required for multi-currency logistics cost reporting."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Status of customs clearance — identifies freight held at customs, which creates supply delays and demurrage risk."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Indicates whether the freight contains dangerous goods — used to segment high-compliance freight movements."
    - name: "expected_arrival_date_month"
      expr: DATE_TRUNC('MONTH', expected_arrival_date)
      comment: "Month the freight is expected to arrive — enables supply pipeline visibility and port planning."
    - name: "actual_departure_date_month"
      expr: DATE_TRUNC('MONTH', DATE(actual_departure_timestamp))
      comment: "Month the freight actually departed — used to measure schedule adherence and voyage duration analysis."
  measures:
    - name: "total_freight_order_count"
      expr: COUNT(1)
      comment: "Total number of freight orders — baseline measure of logistics activity volume."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_amount AS DOUBLE))
      comment: "Total freight cost across all orders — primary logistics cost KPI for supply chain cost management."
    - name: "avg_freight_cost_per_order"
      expr: AVG(CAST(freight_cost_amount AS DOUBLE))
      comment: "Average freight cost per order — benchmarks logistics cost efficiency and identifies outlier shipments."
    - name: "avg_freight_rate_per_tonne"
      expr: AVG(CAST(freight_rate_per_tonne AS DOUBLE))
      comment: "Average freight rate per tonne — key logistics cost efficiency KPI for benchmarking against market rates."
    - name: "total_gross_weight_tonnes"
      expr: SUM(CAST(gross_weight_tonnes AS DOUBLE))
      comment: "Total gross weight of freight moved — measures logistics throughput volume for capacity planning."
    - name: "total_net_weight_tonnes"
      expr: SUM(CAST(net_weight_tonnes AS DOUBLE))
      comment: "Total net weight of freight moved — used for yield analysis and freight cost per net tonne calculations."
    - name: "total_loaded_quantity_tonnes"
      expr: SUM(CAST(loaded_quantity_tonnes AS DOUBLE))
      comment: "Total quantity loaded onto vessels or vehicles — measures actual cargo throughput against nominated quantities."
    - name: "total_nominated_quantity_tonnes"
      expr: SUM(CAST(nominated_quantity_tonnes AS DOUBLE))
      comment: "Total nominated cargo quantity — measures planned freight volume commitments for logistics capacity planning."
    - name: "dangerous_goods_order_count"
      expr: COUNT(CASE WHEN dangerous_goods_flag = True THEN 1 END)
      comment: "Number of freight orders involving dangerous goods — measures compliance workload and regulatory risk exposure."
    - name: "customs_pending_count"
      expr: COUNT(CASE WHEN customs_clearance_status NOT IN ('Cleared', 'Completed') AND customs_clearance_status IS NOT NULL THEN 1 END)
      comment: "Number of freight orders with pending customs clearance — identifies supply delays and demurrage risk at border crossings."
$$;
