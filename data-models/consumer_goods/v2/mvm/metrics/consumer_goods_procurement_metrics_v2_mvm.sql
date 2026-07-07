-- Metric views for domain: procurement | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-27 07:41:37

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order management covering spend value, order volume, approval efficiency, and supplier concentration. Enables procurement leadership to monitor total committed spend, order cycle health, and sourcing strategy effectiveness."
  source: "`vibe_consumer_goods_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: purchase_order_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Closed, Cancelled) for pipeline and backlog analysis."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Blanket, Framework) to segment spend by procurement strategy."
    - name: "currency"
      expr: currency_code
      comment: "Transaction currency of the purchase order for multi-currency spend analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Organizational unit responsible for the purchase order, enabling spend analysis by procurement entity."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group responsible for the purchase order, enabling workload and spend distribution analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the purchase order to monitor governance compliance and bottlenecks."
    - name: "order_date"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of purchase order creation for trend and seasonality analysis of procurement activity."
    - name: "requested_delivery_month"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of requested delivery for demand timing and supplier scheduling analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms governing delivery responsibility, used to analyze logistics cost allocation across orders."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification associated with the purchase order for ESG sourcing compliance tracking."
    - name: "vmi_indicator"
      expr: vmi_indicator
      comment: "Flag indicating whether the order is under a Vendor Managed Inventory arrangement."
  measures:
    - name: "total_purchase_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total committed spend value across all purchase orders. Core procurement spend KPI used in budget tracking and supplier spend analysis."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Sum of net order values excluding taxes and freight, representing the baseline procurement cost for margin and cost analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across purchase orders, used for tax compliance reporting and cash flow planning."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across purchase orders, enabling logistics cost management and incoterms strategy evaluation."
    - name: "purchase_order_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of distinct purchase orders issued, used to measure procurement activity volume and buyer workload."
    - name: "avg_purchase_order_value"
      expr: AVG(CAST(total_order_value AS DOUBLE))
      comment: "Average value per purchase order, indicating order consolidation efficiency and procurement strategy effectiveness."
    - name: "cancelled_order_count"
      expr: COUNT(DISTINCT CASE WHEN purchase_order_status = 'Cancelled' THEN purchase_order_id END)
      comment: "Number of cancelled purchase orders, a leading indicator of supply disruption, demand volatility, or supplier reliability issues."
    - name: "approved_order_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN purchase_order_id END)
      comment: "Number of purchase orders that have received formal approval, used to track governance compliance and approval throughput."
    - name: "vmi_order_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_indicator = TRUE THEN purchase_order_id END)
      comment: "Number of purchase orders under Vendor Managed Inventory, tracking adoption of advanced replenishment strategies."
    - name: "sustainable_order_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certification IS NOT NULL THEN purchase_order_id END)
      comment: "Number of purchase orders with a sustainability certification, used for ESG sourcing compliance and reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs covering ordered quantities, receipt performance, invoice matching, and delivery compliance. Enables operations and procurement teams to monitor fulfillment accuracy, open order exposure, and line-level spend efficiency."
  source: "`vibe_consumer_goods_v1`.`procurement`.`po_line`"
  dimensions:
    - name: "po_line_status"
      expr: po_line_status
      comment: "Current status of the purchase order line (e.g. Open, Closed, Blocked) for pipeline and backlog management."
    - name: "line_status"
      expr: line_status
      comment: "Operational processing status of the PO line for workflow and exception management."
    - name: "material_group"
      expr: material_group
      comment: "Material group classification of the ordered item for category spend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the PO line for multi-currency spend analysis."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Trade terms for the PO line governing delivery responsibility and risk transfer."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax classification applied to the PO line for tax compliance and cost analysis."
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month of scheduled delivery for demand timing and supplier scheduling analysis."
    - name: "confirmed_delivery_month"
      expr: DATE_TRUNC('month', confirmed_delivery_date)
      comment: "Month of supplier-confirmed delivery date for on-time delivery performance tracking."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Flag indicating whether a goods receipt is required for this PO line, used for three-way match compliance analysis."
    - name: "invoice_receipt_indicator"
      expr: invoice_receipt_indicator
      comment: "Flag indicating whether an invoice receipt is required, used for accounts payable process compliance."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group responsible for the PO line for workload and spend distribution analysis."
  measures:
    - name: "total_line_spend"
      expr: SUM(CAST(line_total AS DOUBLE))
      comment: "Total committed spend at the PO line level, the most granular view of procurement cost for category and material analysis."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Sum of net order values at line level, used for cost baseline and margin analysis excluding taxes."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across PO lines, used for demand volume analysis and supplier capacity planning."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received against PO lines, measuring fulfillment completeness and goods receipt performance."
    - name: "total_outstanding_quantity"
      expr: SUM(CAST(outstanding_quantity AS DOUBLE))
      comment: "Total open/unfulfilled quantity on PO lines, representing supply exposure and delivery risk."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced against PO lines, used for three-way match and accounts payable reconciliation."
    - name: "receipt_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been received, a key supplier fulfillment performance KPI. Low fill rate signals supply risk."
    - name: "invoice_match_rate"
      expr: ROUND(100.0 * SUM(CAST(invoiced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been invoiced, used to track accounts payable completeness and three-way match efficiency."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines, used for price benchmarking and negotiation effectiveness analysis."
    - name: "po_line_count"
      expr: COUNT(DISTINCT po_line_id)
      comment: "Number of distinct PO lines, used to measure procurement complexity and buyer workload."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods receipt KPIs covering receipt volumes, quality acceptance rates, rejection rates, and valuation. Enables supply chain and quality teams to monitor supplier delivery performance, inspection outcomes, and inventory intake accuracy."
  source: "`vibe_consumer_goods_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Current status of the goods receipt document for inbound logistics and inventory management."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection outcome for the goods receipt, used to track supplier quality performance."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type associated with the goods receipt for stock management and accounting analysis."
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location where goods were received, used for inventory placement and warehouse capacity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the goods receipt for multi-currency valuation analysis."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of goods receipt for trend analysis of inbound supply volumes and delivery timing."
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of accounting posting for financial period alignment and accrual analysis."
    - name: "gr_reversal_flag"
      expr: gr_reversal_flag
      comment: "Flag indicating whether the goods receipt was reversed, used to identify receipt errors and supplier disputes."
    - name: "otif_compliance_flag"
      expr: otif_compliance_flag
      comment: "On-Time In-Full compliance flag for the delivery, a critical supplier performance KPI dimension."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Flag indicating whether quality inspection was required for this receipt, used for quality process compliance analysis."
    - name: "sustainable_sourcing_certification"
      expr: sustainable_sourcing_certification
      comment: "Sustainability certification associated with the received goods for ESG supply chain compliance tracking."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received, the primary inbound supply volume KPI for inventory and demand fulfillment tracking."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after inspection, representing usable inbound supply for production and inventory planning."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt, a direct measure of supplier quality failure and associated rework/return costs."
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total inventory valuation of received goods, used for balance sheet accuracy and cost of goods received reporting."
    - name: "quality_acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(accepted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that passed quality inspection. A critical supplier quality KPI — low rates trigger supplier corrective action."
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity rejected at inspection. Directly impacts production continuity and supplier scorecard ratings."
    - name: "otif_receipt_count"
      expr: COUNT(DISTINCT CASE WHEN otif_compliance_flag = TRUE THEN goods_receipt_id END)
      comment: "Number of goods receipts that were On-Time In-Full compliant, used to calculate OTIF delivery performance rate."
    - name: "total_receipt_count"
      expr: COUNT(DISTINCT goods_receipt_id)
      comment: "Total number of goods receipt documents, used as the denominator for OTIF rate and quality rate calculations."
    - name: "reversal_count"
      expr: COUNT(DISTINCT CASE WHEN gr_reversal_flag = TRUE THEN goods_receipt_id END)
      comment: "Number of reversed goods receipts, indicating receipt errors, supplier disputes, or returns that impact inventory accuracy."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price at goods receipt, used for price variance analysis against purchase order unit prices."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs covering invoice volumes, payment performance, discount capture, tax liability, and three-way match compliance. Enables finance and procurement to manage cash flow, payment terms adherence, and invoice processing efficiency."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the supplier invoice (e.g. Open, Paid, Blocked) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of supplier invoice (e.g. Standard, Credit Memo, Debit Memo) for AP categorization and reporting."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment execution status of the invoice for cash flow and working capital management."
    - name: "match_status"
      expr: match_status
      comment: "Two-way or three-way match status of the invoice against PO and goods receipt for compliance and exception management."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match result (PO, GR, Invoice) — a critical AP control KPI dimension for fraud prevention and accuracy."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the invoice (e.g. ACH, Wire, Check) for treasury and cash management analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms applied to the invoice for early payment discount capture and DPO analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP and FX exposure analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date for AP volume trend and accrual analysis."
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month of invoice due date for cash flow forecasting and payment scheduling."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-based financial reporting and budget vs. actuals analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for sub-annual financial reporting and accrual management."
    - name: "blocking_reason_code"
      expr: blocking_reason_code
      comment: "Reason code for invoice payment block, used to identify and resolve AP processing bottlenecks."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total gross invoice amount across all supplier invoices. Primary AP spend KPI for cash flow and budget management."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts, representing actual cash outflow for cost accounting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on supplier invoices for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured, a direct measure of working capital optimization and supplier relationship value."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from supplier payments for tax compliance and regulatory reporting."
    - name: "invoice_count"
      expr: COUNT(DISTINCT supplier_invoice_id)
      comment: "Total number of supplier invoices processed, used to measure AP workload and processing throughput."
    - name: "blocked_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN invoice_status = 'Blocked' THEN supplier_invoice_id END)
      comment: "Number of invoices currently blocked from payment, indicating AP processing exceptions that risk supplier relationship damage."
    - name: "three_way_match_pass_count"
      expr: COUNT(DISTINCT CASE WHEN three_way_match_status = 'Matched' THEN supplier_invoice_id END)
      comment: "Number of invoices that passed three-way match (PO, GR, Invoice), a key AP control and fraud prevention metric."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(invoice_amount AS DOUBLE))
      comment: "Average invoice value, used to benchmark invoice complexity and identify outliers requiring additional scrutiny."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and deductions, used for spend baseline and vendor spend analysis."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master KPIs covering supplier base composition, performance scores, risk ratings, certification compliance, and strategic classification. Enables procurement leadership to manage supplier portfolio health, risk exposure, and sustainability compliance."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current operational status of the supplier (e.g. Active, Inactive, Blocked) for supplier base management."
    - name: "supplier_type"
      expr: supplier_type
      comment: "Classification of the supplier type (e.g. Manufacturer, Distributor, Service Provider) for sourcing strategy analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the supplier for procurement use, used to track supplier qualification compliance."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Supplier onboarding lifecycle status for pipeline management of new supplier activation."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Supplier risk rating (e.g. Low, Medium, High, Critical) for supply chain risk management and mitigation prioritization."
    - name: "tier"
      expr: tier
      comment: "Supplier tier classification (e.g. Tier 1, Tier 2) for supply chain visibility and strategic sourcing decisions."
    - name: "country_code"
      expr: country_code
      comment: "Country of the supplier for geographic spend analysis, trade compliance, and supply chain resilience assessment."
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Supplier diversity classification (e.g. MBE, WBE, SDVOB) for diversity spend reporting and ESG compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Default transaction currency of the supplier for FX exposure and multi-currency spend analysis."
    - name: "is_strategic"
      expr: is_strategic
      comment: "Flag indicating whether the supplier is classified as strategic, used to differentiate investment and relationship management."
    - name: "onboarding_month"
      expr: DATE_TRUNC('month', onboarding_date)
      comment: "Month of supplier onboarding for new supplier activation trend analysis."
  measures:
    - name: "active_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN supplier_status = 'Active' THEN supplier_id END)
      comment: "Number of active suppliers in the approved supplier base. Core supplier portfolio KPI for sourcing capacity and concentration risk."
    - name: "total_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Total number of suppliers in the master data, used as the denominator for active rate and risk distribution calculations."
    - name: "strategic_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN is_strategic = TRUE THEN supplier_id END)
      comment: "Number of suppliers classified as strategic, used to track strategic sourcing portfolio size and relationship investment."
    - name: "high_risk_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN risk_rating = 'High' THEN supplier_id END)
      comment: "Number of suppliers rated as high risk, a critical supply chain resilience KPI requiring executive attention and mitigation plans."
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average supplier performance score across the supplier base, used to benchmark overall supply chain quality and delivery reliability."
    - name: "iso_9001_certified_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN iso_9001_certified_flag = TRUE THEN supplier_id END)
      comment: "Number of ISO 9001 certified suppliers, tracking quality management system compliance across the supply base."
    - name: "gmp_certified_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN gmp_certified_flag = TRUE THEN supplier_id END)
      comment: "Number of GMP (Good Manufacturing Practice) certified suppliers, critical for consumer goods regulatory compliance."
    - name: "rspo_certified_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN rspo_certified_flag = TRUE THEN supplier_id END)
      comment: "Number of RSPO certified suppliers, tracking sustainable palm oil sourcing compliance for consumer goods ESG commitments."
    - name: "edi_capable_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN edi_capable_flag = TRUE THEN supplier_id END)
      comment: "Number of EDI-capable suppliers, measuring digital integration maturity of the supply base for order automation efficiency."
    - name: "approved_supplier_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_approved = TRUE THEN supplier_id END) / NULLIF(COUNT(DISTINCT supplier_id), 0), 2)
      comment: "Percentage of suppliers that are formally approved for procurement use, a governance compliance KPI for sourcing risk management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier contract portfolio KPIs covering contract value, coverage, renewal risk, and compliance. Enables procurement and legal teams to manage contract lifecycle, spend under contract, and expiry risk to protect commercial terms."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the supplier contract (e.g. Active, Expired, Terminated) for contract portfolio management."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of supplier contract (e.g. Framework, Blanket, Fixed Price) for sourcing strategy and commercial terms analysis."
    - name: "supplier_contract_status"
      expr: supplier_contract_status
      comment: "Operational status of the supplier contract for procurement workflow and compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency spend under contract analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Organizational unit owning the contract for spend under contract analysis by procurement entity."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group managing the contract for workload and portfolio distribution analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Trade terms in the contract governing delivery responsibility and risk transfer."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms in the contract for working capital and cash flow analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Flag indicating whether the contract auto-renews, used to manage renewal risk and renegotiation opportunities."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification required by the contract for ESG sourcing compliance tracking."
    - name: "contract_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month of contract start for portfolio vintage analysis and contract coverage trend tracking."
    - name: "contract_end_month"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month of contract expiry for renewal pipeline management and expiry risk monitoring."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all supplier contracts in the portfolio. Primary spend under contract KPI for procurement coverage and commercial risk management."
    - name: "total_contract_value_committed"
      expr: SUM(CAST(contract_value_total AS DOUBLE))
      comment: "Total committed contract value across the portfolio, used for budget commitment tracking and supplier spend forecasting."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity_total AS DOUBLE))
      comment: "Total target quantity committed across contracts, used for supply capacity planning and volume commitment compliance."
    - name: "active_contract_count"
      expr: COUNT(DISTINCT CASE WHEN contract_status = 'Active' THEN supplier_contract_id END)
      comment: "Number of active supplier contracts, measuring the breadth of contractual coverage across the supply base."
    - name: "total_contract_count"
      expr: COUNT(DISTINCT supplier_contract_id)
      comment: "Total number of supplier contracts in the portfolio, used as the denominator for active rate and expiry risk calculations."
    - name: "expiring_contract_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN supplier_contract_id END)
      comment: "Number of contracts expiring within the next 90 days, a critical renewal risk KPI requiring immediate procurement action."
    - name: "auto_renew_contract_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renew_flag = TRUE THEN supplier_contract_id END)
      comment: "Number of contracts set to auto-renew, used to identify renegotiation opportunities before automatic renewal locks in terms."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value across the portfolio, used to benchmark contract size and identify consolidation opportunities."
    - name: "sustainable_contract_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certification IS NOT NULL THEN supplier_contract_id END)
      comment: "Number of contracts with sustainability certification requirements, tracking ESG sourcing compliance across the contract portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition KPIs covering requisition volumes, approval cycle performance, spend authorization, and sourcing compliance. Enables procurement and finance to monitor demand-to-order efficiency, budget adherence, and requisition-to-PO conversion."
  source: "`vibe_consumer_goods_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "purchase_requisition_status"
      expr: purchase_requisition_status
      comment: "Current lifecycle status of the purchase requisition (e.g. Pending, Approved, Rejected, Converted) for pipeline management."
    - name: "requisition_status"
      expr: requisition_status
      comment: "Operational processing status of the requisition for workflow and exception management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the requisition for governance compliance and bottleneck identification."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required for the requisition, used to analyze approval complexity and cycle time by tier."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of purchase requisition (e.g. Standard, Emergency, Blanket) for demand categorization and process compliance."
    - name: "material_group_code"
      expr: material_group_code
      comment: "Material group of the requested item for category spend analysis and sourcing strategy alignment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition for multi-currency spend authorization analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the requisition (e.g. Urgent, Normal, Low) for workload management and SLA compliance."
    - name: "purchasing_organization_code"
      expr: purchasing_organization_code
      comment: "Purchasing organization responsible for the requisition for spend authorization analysis by entity."
    - name: "purchasing_group_code"
      expr: purchasing_group_code
      comment: "Buyer group assigned to the requisition for workload distribution and processing efficiency analysis."
    - name: "sustainability_flag"
      expr: sustainability_flag
      comment: "Flag indicating whether the requisition has sustainability requirements for ESG procurement compliance tracking."
    - name: "requisition_month"
      expr: DATE_TRUNC('month', requisition_date)
      comment: "Month of requisition creation for demand trend analysis and procurement planning."
    - name: "required_delivery_month"
      expr: DATE_TRUNC('month', required_delivery_date)
      comment: "Month of required delivery for demand timing and supply planning alignment."
  measures:
    - name: "total_estimated_requisition_value"
      expr: SUM(CAST(total_estimated_value AS DOUBLE))
      comment: "Total estimated spend value across all purchase requisitions, used for budget demand forecasting and spend authorization monitoring."
    - name: "total_requested_quantity"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across requisitions, used for demand volume analysis and supply planning."
    - name: "requisition_count"
      expr: COUNT(DISTINCT purchase_requisition_id)
      comment: "Total number of purchase requisitions submitted, measuring procurement demand volume and buyer workload."
    - name: "approved_requisition_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN purchase_requisition_id END)
      comment: "Number of approved requisitions, used to calculate approval rate and measure governance throughput."
    - name: "rejected_requisition_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Rejected' THEN purchase_requisition_id END)
      comment: "Number of rejected requisitions, indicating demand quality issues, budget overruns, or policy non-compliance requiring investigation."
    - name: "requisition_approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN purchase_requisition_id END) / NULLIF(COUNT(DISTINCT purchase_requisition_id), 0), 2)
      comment: "Percentage of requisitions approved on first submission, a governance efficiency KPI. Low rates indicate policy gaps or budget misalignment."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across requisitions, used for price benchmarking and early detection of cost inflation in demand."
    - name: "sustainable_requisition_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_flag = TRUE THEN purchase_requisition_id END)
      comment: "Number of requisitions with sustainability requirements, tracking ESG procurement policy adoption across the organization."
    - name: "urgent_requisition_count"
      expr: COUNT(DISTINCT CASE WHEN priority = 'Urgent' THEN purchase_requisition_id END)
      comment: "Number of urgent priority requisitions, a leading indicator of supply planning failures and emergency procurement costs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level KPIs covering invoiced spend, price and quantity variances, discount capture, and tax analysis. Enables finance and procurement to monitor AP accuracy, three-way match exceptions, and line-level cost control."
  source: "`vibe_consumer_goods_v1`.`procurement`.`invoice_line`"
  dimensions:
    - name: "invoice_line_status"
      expr: invoice_line_status
      comment: "Current processing status of the invoice line for AP exception management and workflow tracking."
    - name: "match_status"
      expr: match_status
      comment: "Match status of the invoice line against PO and goods receipt for three-way match compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice line currency for multi-currency AP analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice line for tax compliance and cost analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms on the invoice line for early payment discount and DPO analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the invoiced goods for trade compliance and import duty analysis."
    - name: "blocking_reason"
      expr: blocking_reason
      comment: "Reason for invoice line payment block, used to identify and resolve AP processing bottlenecks."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification on the invoice line for ESG spend compliance tracking."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total invoiced amount at line level, the most granular AP spend KPI for category and material cost analysis."
    - name: "total_net_invoiced_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Total net invoiced amount after discounts at line level, representing actual cost for margin and profitability analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(line_tax_amount AS DOUBLE))
      comment: "Total tax amount at invoice line level for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured at invoice line level, measuring early payment discount optimization."
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance AS DOUBLE))
      comment: "Total price variance between invoiced price and PO price, a key AP accuracy KPI. Large variances indicate pricing disputes or contract non-compliance."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance between invoiced and received quantities, indicating billing accuracy and goods receipt discrepancies."
    - name: "total_amount_variance"
      expr: SUM(CAST(amount_variance AS DOUBLE))
      comment: "Total monetary variance on invoice lines, used to quantify AP exception exposure and prioritize resolution efforts."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced at line level for volume reconciliation against purchase orders and goods receipts."
    - name: "invoice_line_count"
      expr: COUNT(DISTINCT invoice_line_id)
      comment: "Total number of invoice lines processed, used to measure AP processing complexity and workload."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across invoice lines, used for price benchmarking and detection of price drift from contracted rates."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_approved_supplier_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Supplier List (ASL) KPIs covering supplier qualification coverage, preference rankings, compliance status, and audit health. Enables procurement and quality teams to manage sourcing eligibility, supplier qualification expiry risk, and sustainability compliance."
  source: "`vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the ASL entry (e.g. Approved, Pending, Rejected) for supplier qualification pipeline management."
    - name: "approved_supplier_list_status"
      expr: approved_supplier_list_status
      comment: "Operational status of the ASL record for sourcing eligibility and compliance tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the approved supplier entry for regulatory and quality compliance monitoring."
    - name: "qualification_level"
      expr: qualification_level
      comment: "Qualification tier of the supplier on the ASL (e.g. Preferred, Approved, Conditional) for sourcing strategy analysis."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the ASL entry for supply chain risk management and mitigation prioritization."
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality performance rating of the supplier on the ASL for supplier scorecard and selection decisions."
    - name: "delivery_rating"
      expr: delivery_rating
      comment: "Delivery performance rating of the supplier on the ASL for on-time delivery analysis and supplier selection."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Flag indicating whether the supplier is preferred for this material/facility combination, used for sourcing strategy analysis."
    - name: "sole_source_flag"
      expr: sole_source_flag
      comment: "Flag indicating sole-source supply arrangements, a critical supply chain concentration risk indicator."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification of the ASL entry for ESG sourcing compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the ASL pricing for multi-currency sourcing analysis."
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of ASL approval for qualification trend analysis and supplier onboarding velocity tracking."
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month of ASL entry expiry for qualification renewal risk monitoring."
  measures:
    - name: "approved_supplier_entry_count"
      expr: COUNT(DISTINCT CASE WHEN approval_status = 'Approved' THEN approved_supplier_list_id END)
      comment: "Number of active approved supplier entries on the ASL, measuring the breadth of qualified sourcing options available."
    - name: "total_asl_entry_count"
      expr: COUNT(DISTINCT approved_supplier_list_id)
      comment: "Total number of ASL entries across all statuses, used as the denominator for approval rate and compliance rate calculations."
    - name: "preferred_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN preferred_supplier_flag = TRUE THEN approved_supplier_list_id END)
      comment: "Number of preferred supplier designations on the ASL, tracking strategic sourcing concentration and preferred supplier utilization."
    - name: "sole_source_count"
      expr: COUNT(DISTINCT CASE WHEN sole_source_flag = TRUE THEN approved_supplier_list_id END)
      comment: "Number of sole-source supplier arrangements, a critical supply chain concentration risk KPI requiring executive attention and dual-sourcing strategy."
    - name: "expiring_asl_count"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN approved_supplier_list_id END)
      comment: "Number of ASL entries expiring within 90 days, a supply continuity risk KPI requiring proactive re-qualification to avoid sourcing disruption."
    - name: "total_asl_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total contracted amount across ASL entries, representing the financial value of approved sourcing arrangements."
    - name: "avg_moq_quantity"
      expr: AVG(CAST(moq_quantity AS DOUBLE))
      comment: "Average minimum order quantity across ASL entries, used for inventory planning and order consolidation strategy."
    - name: "sustainable_asl_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certification IS NOT NULL THEN approved_supplier_list_id END)
      comment: "Number of ASL entries with sustainability certifications, tracking ESG sourcing compliance across the approved supplier base."
    - name: "vmi_eligible_asl_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_eligible_flag = TRUE THEN approved_supplier_list_id END)
      comment: "Number of ASL entries eligible for Vendor Managed Inventory, tracking adoption potential of advanced replenishment strategies."
$$;