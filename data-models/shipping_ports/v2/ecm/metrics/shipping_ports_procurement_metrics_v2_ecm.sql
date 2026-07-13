-- Metric views for domain: procurement | Business: Shipping_Ports | Version: 2 | Generated on: 2026-07-13 07:51:56

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over purchase orders covering spend volume, approval cycle efficiency, and order status distribution. Used by CPO and procurement leadership to steer sourcing strategy and vendor spend."
  source: "`vibe_shipping_ports_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Closed, Cancelled) for pipeline and backlog analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (Standard, Framework, Service, etc.) enabling spend categorization by procurement instrument."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order for multi-currency spend reporting."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the order, enabling spend allocation by organizational unit."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group (buyer team) that raised the order, for workload and spend distribution analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing delivery responsibility, relevant for logistics cost and risk analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO, used to track bottlenecks in the approval pipeline."
    - name: "document_date_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Month of PO document date for trend analysis of procurement activity over time."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of expected delivery for demand forecasting and supplier scheduling."
    - name: "priority"
      expr: priority
      comment: "Priority level of the purchase order (High/Medium/Low) for urgency-based procurement triage."
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total committed spend value across all purchase orders. Core spend-under-management KPI used by CPO to track procurement volume and budget utilization."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Sum of net order values (excluding tax) across POs. Used for pre-tax spend analysis and budget commitment tracking."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across purchase orders. Used by finance for VAT/GST accrual and tax compliance reporting."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value. Indicates procurement ticket size; a declining average may signal fragmentation or maverick buying."
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders raised. Baseline volume metric for procurement workload and process efficiency benchmarking."
    - name: "cancelled_po_count"
      expr: COUNT(CASE WHEN po_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled purchase orders. High cancellation rates signal demand planning failures or vendor issues requiring intervention."
    - name: "open_po_count"
      expr: COUNT(CASE WHEN po_status = 'Open' THEN 1 END)
      comment: "Number of open (unfulfilled) purchase orders. Tracks outstanding procurement commitments and delivery pipeline."
    - name: "pending_approval_po_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Number of POs awaiting approval. A leading indicator of approval bottlenecks that delay procurement execution."
    - name: "service_entry_required_po_count"
      expr: COUNT(CASE WHEN service_entry_required = TRUE THEN 1 END)
      comment: "Number of POs requiring service entry sheet confirmation. Tracks service procurement volume requiring acceptance verification."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`procurement_vendor_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard metrics covering quality, delivery, HSSE compliance, and overall ratings. Used by procurement leadership and supply chain risk teams to manage vendor relationships and tier assignments."
  source: "`vibe_shipping_ports_v1`.`procurement`.`vendor_evaluation`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of vendor evaluation (Annual, Periodic, Triggered) for segmenting performance reviews by cadence."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the evaluation record (Draft, Completed, Approved) for pipeline tracking."
    - name: "current_vendor_tier"
      expr: current_vendor_tier
      comment: "Current vendor tier classification (Preferred, Approved, Conditional) for tier-based performance benchmarking."
    - name: "recommended_vendor_tier"
      expr: recommended_vendor_tier
      comment: "Recommended tier after evaluation, enabling tier migration analysis and vendor development tracking."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Qualitative overall rating (Excellent/Good/Satisfactory/Poor) for executive-level vendor health reporting."
    - name: "corrective_action_required"
      expr: CAST(corrective_action_required AS STRING)
      comment: "Flag indicating whether a corrective action plan was mandated, for compliance and risk tracking."
    - name: "evaluation_period_start_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start_date)
      comment: "Start month of the evaluation period for time-series performance trend analysis."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall vendor performance score across evaluations. Primary KPI for vendor health; scores below threshold trigger tier demotion or corrective action."
    - name: "avg_quality_compliance_score"
      expr: AVG(CAST(quality_compliance_score AS DOUBLE))
      comment: "Average quality compliance score. Directly linked to goods rejection rates and rework costs; drives quality improvement programs."
    - name: "avg_on_time_delivery_score"
      expr: AVG(CAST(on_time_delivery_score AS DOUBLE))
      comment: "Average on-time delivery performance score. Critical for port operations continuity; low scores trigger supply chain risk escalation."
    - name: "avg_hsse_compliance_score"
      expr: AVG(CAST(hsse_compliance_score AS DOUBLE))
      comment: "Average HSSE (Health, Safety, Security, Environment) compliance score. Mandatory for port vendor qualification; low scores trigger suspension."
    - name: "avg_price_competitiveness_score"
      expr: AVG(CAST(price_competitiveness_score AS DOUBLE))
      comment: "Average price competitiveness score across evaluations. Used to benchmark vendor pricing against market and negotiate better terms."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average vendor responsiveness score. Low responsiveness scores indicate service risk for time-critical port procurement."
    - name: "total_purchase_value_evaluated"
      expr: SUM(CAST(total_purchase_value AS DOUBLE))
      comment: "Total spend value covered by vendor evaluations. Measures the proportion of spend under active performance management."
    - name: "vendors_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of vendor evaluations resulting in mandatory corrective action. High counts signal systemic vendor quality issues requiring strategic sourcing intervention."
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Total number of vendor evaluations completed. Baseline for evaluating coverage of the vendor base under active performance management."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average goods quality acceptance rate across vendor evaluations. Directly measures incoming quality and impacts port operational readiness."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs covering invoice volumes, payment performance, three-way match compliance, and financial exposure. Used by finance and procurement to manage cash flow, compliance, and vendor payment health."
  source: "`vibe_shipping_ports_v1`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the vendor invoice (Posted, Blocked, Paid, Reversed) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (Standard, Credit Memo, Debit Memo) for financial classification and reporting."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match result (Matched, Quantity Variance, Price Variance, Unmatched) — core compliance KPI for procure-to-pay integrity."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP exposure analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (Wire, ACH, Cheque) for cash management and payment channel optimization."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for AP accrual trend analysis and period-end close reporting."
    - name: "payment_due_date_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month of payment due date for cash flow forecasting and working capital management."
    - name: "reversal_indicator"
      expr: CAST(reversal_indicator AS STRING)
      comment: "Flag indicating reversed invoices, used to identify correction volumes and AP error rates."
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross invoice value including tax. Primary AP liability metric used by finance for cash flow planning and period-end accruals."
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net invoice value excluding tax. Used for spend reporting and budget consumption tracking."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across vendor invoices. Used for VAT/GST reclaim and tax compliance reporting."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments. Required for tax authority reporting and vendor remittance reconciliation."
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance AS DOUBLE))
      comment: "Total price variance between PO price and invoiced price. High variance signals contract non-compliance or pricing disputes requiring procurement intervention."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance between goods received and invoiced. Indicates delivery shortfalls or overbilling requiring vendor dispute resolution."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices processed. Baseline AP workload metric for staffing and automation ROI assessment."
    - name: "three_way_match_failure_count"
      expr: COUNT(CASE WHEN three_way_match_status != 'Matched' THEN 1 END)
      comment: "Number of invoices failing three-way match. High failure rates indicate procurement control weaknesses and increase fraud/overpayment risk."
    - name: "reversed_invoice_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversed invoices. Tracks AP correction volume; high reversal rates signal invoice processing quality issues."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(invoice_net_amount AS DOUBLE))
      comment: "Average net invoice value. Used to benchmark invoice size and detect anomalous billing patterns."
    - name: "total_cash_discount_amount"
      expr: SUM(CAST(cash_discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimization from dynamic discounting programs."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master health and compliance KPIs covering certification status, ISPS clearance, ISO compliance, and vendor tier distribution. Used by procurement and compliance teams to manage vendor qualification and supply chain risk."
  source: "`vibe_shipping_ports_v1`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Active/Inactive/Suspended status of the vendor for supply base health monitoring."
    - name: "tier"
      expr: tier
      comment: "Vendor tier classification (Preferred/Approved/Conditional/Restricted) for strategic sourcing segmentation."
    - name: "vendor_category"
      expr: vendor_category
      comment: "Category of vendor (Goods, Services, Works) for spend category management."
    - name: "isps_clearance_status"
      expr: isps_clearance_status
      comment: "ISPS port security clearance status — mandatory for vendors operating in restricted port zones."
    - name: "iso_9001_certified"
      expr: CAST(iso_9001_certified AS STRING)
      comment: "ISO 9001 quality management certification flag for vendor quality baseline assessment."
    - name: "iso_14001_certified"
      expr: CAST(iso_14001_certified AS STRING)
      comment: "ISO 14001 environmental management certification flag for sustainability compliance tracking."
    - name: "iso_45001_certified"
      expr: CAST(iso_45001_certified AS STRING)
      comment: "ISO 45001 occupational health and safety certification flag for HSSE vendor qualification."
    - name: "currency_code"
      expr: currency_code
      comment: "Primary transaction currency of the vendor for FX exposure and multi-currency procurement analysis."
    - name: "onboarding_date_year"
      expr: DATE_TRUNC('YEAR', onboarding_date)
      comment: "Year of vendor onboarding for supply base growth trend analysis."
  measures:
    - name: "active_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'Active' THEN 1 END)
      comment: "Number of active vendors in the approved supply base. Core supply base size KPI; declining counts signal vendor attrition risk."
    - name: "isps_compliant_vendor_count"
      expr: COUNT(CASE WHEN isps_clearance_status = 'Cleared' THEN 1 END)
      comment: "Number of vendors with valid ISPS port security clearance. Non-compliant vendors cannot operate in restricted port areas — a critical operational risk metric."
    - name: "iso_9001_certified_vendor_count"
      expr: COUNT(CASE WHEN iso_9001_certified = TRUE THEN 1 END)
      comment: "Number of ISO 9001 certified vendors. Measures quality management coverage across the supply base."
    - name: "iso_14001_certified_vendor_count"
      expr: COUNT(CASE WHEN iso_14001_certified = TRUE THEN 1 END)
      comment: "Number of ISO 14001 certified vendors. Tracks environmental compliance coverage — relevant for port sustainability reporting."
    - name: "iso_45001_certified_vendor_count"
      expr: COUNT(CASE WHEN iso_45001_certified = TRUE THEN 1 END)
      comment: "Number of ISO 45001 certified vendors. Measures HSSE qualification coverage — mandatory for stevedoring and hazmat vendors."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN tier = 'Preferred' THEN 1 END)
      comment: "Number of preferred-tier vendors. Preferred vendors receive priority sourcing; tracking this count guides vendor development investment."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit extended to vendors. Used by finance to assess AP credit exposure across the supply base."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit exposure across all vendors. Aggregate financial risk metric for treasury and AP management."
    - name: "vendor_count"
      expr: COUNT(1)
      comment: "Total vendor master records. Baseline supply base size metric for procurement governance and vendor rationalization programs."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt and inbound logistics KPIs covering delivery accuracy, quality inspection outcomes, and three-way match compliance. Used by procurement and warehouse operations to manage supplier delivery performance and inventory accuracy."
  source: "`vibe_shipping_ports_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (Posted, Reversed, Blocked) for inbound delivery pipeline tracking."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome (Passed, Failed, Pending) for incoming goods quality monitoring."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match result at goods receipt level for procure-to-pay compliance tracking."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type (Goods Receipt, Return, Transfer) for stock movement classification."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of received goods for trade compliance and local content reporting."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for delivery (Sea, Air, Road, Rail) for logistics cost and lead time analysis."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of goods delivery for inbound volume trend analysis and supplier scheduling."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type classification (Unrestricted, Quality Inspection, Blocked) for inventory availability analysis."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received. Core inbound volume metric for inventory replenishment and demand fulfillment tracking."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across goods receipts. Used as denominator for delivery completeness rate calculation."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (ordered vs received). Persistent positive variance indicates chronic under-delivery requiring supplier escalation."
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total value of goods received at standard/moving average price. Used for inventory valuation and goods receipt accrual in financial close."
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipt documents. Baseline inbound logistics volume metric for warehouse staffing and dock scheduling."
    - name: "quality_failed_receipt_count"
      expr: COUNT(CASE WHEN quality_inspection_status = 'Failed' THEN 1 END)
      comment: "Number of goods receipts failing quality inspection. High failure rates trigger supplier quality improvement programs and impact port operational readiness."
    - name: "three_way_match_failure_count"
      expr: COUNT(CASE WHEN three_way_match_status != 'Matched' THEN 1 END)
      comment: "Number of goods receipts with three-way match failures. Indicates invoice processing risk and potential overpayment exposure."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received goods. Used to benchmark actual receipt prices against PO prices and purchasing info records."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ (Request for Quotation) process KPIs covering sourcing competitiveness, award efficiency, and market engagement. Used by procurement leadership to evaluate sourcing strategy effectiveness and competitive bidding outcomes."
  source: "`vibe_shipping_ports_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (Open, Closed, Awarded, Cancelled) for sourcing pipeline management."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (Open, Selective, Single Source) for sourcing method analysis and compliance reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RFQ for governance and delegation of authority compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RFQ for multi-currency sourcing analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization issuing the RFQ for organizational spend and sourcing activity analysis."
    - name: "vendor_prequalification_required"
      expr: CAST(vendor_prequalification_required AS STRING)
      comment: "Flag indicating whether vendor prequalification was required, for tracking strategic vs open sourcing."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of RFQ issuance for sourcing activity trend analysis."
    - name: "award_date_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month of RFQ award for sourcing cycle time and award velocity tracking."
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(total_estimated_value AS DOUBLE))
      comment: "Total estimated spend value of RFQs issued. Measures the volume of spend being competitively sourced — a key procurement governance KPI."
    - name: "total_lowest_quoted_price"
      expr: SUM(CAST(lowest_quoted_price AS DOUBLE))
      comment: "Sum of lowest quoted prices across RFQs. Used to calculate savings against budget estimates when compared to total_estimated_value."
    - name: "avg_lowest_quoted_price"
      expr: AVG(CAST(lowest_quoted_price AS DOUBLE))
      comment: "Average lowest quoted price per RFQ. Benchmarks market pricing levels for category management and budget planning."
    - name: "rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued. Baseline sourcing activity volume metric for procurement team capacity planning."
    - name: "awarded_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Awarded' THEN 1 END)
      comment: "Number of RFQs successfully awarded. Measures sourcing completion rate and pipeline conversion efficiency."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all RFQs. Used for demand aggregation analysis and volume-based negotiation strategy."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`procurement_tender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Formal tender process KPIs covering competitive bidding, award values, and tender cycle performance. Used by CPO and procurement governance teams to ensure compliance with formal procurement thresholds and evaluate sourcing outcomes."
  source: "`vibe_shipping_ports_v1`.`procurement`.`tender`"
  dimensions:
    - name: "tender_status"
      expr: tender_status
      comment: "Current status of the tender (Draft, Published, Evaluation, Awarded, Cancelled) for tender pipeline management."
    - name: "tender_type"
      expr: tender_type
      comment: "Type of tender (Open, Restricted, Negotiated, Single Source) for procurement method compliance analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the tender for governance and delegation of authority compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the tender for multi-currency spend analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the tender for organizational spend attribution."
    - name: "pre_qualification_required"
      expr: CAST(pre_qualification_required AS STRING)
      comment: "Flag indicating whether vendor pre-qualification was required, for strategic sourcing compliance tracking."
    - name: "performance_bond_required"
      expr: CAST(performance_bond_required AS STRING)
      comment: "Flag indicating whether a performance bond was required, for high-value contract risk management tracking."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of tender issuance for procurement activity trend analysis."
    - name: "outcome"
      expr: outcome
      comment: "Tender outcome (Awarded, No Award, Cancelled) for sourcing success rate analysis."
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of tenders issued. Measures formal procurement spend volume subject to competitive tendering requirements."
    - name: "total_awarded_value"
      expr: SUM(CAST(awarded_value AS DOUBLE))
      comment: "Total value of awarded tenders. Core procurement outcome metric; compared against estimated value to measure savings or cost overruns."
    - name: "avg_awarded_value"
      expr: AVG(CAST(awarded_value AS DOUBLE))
      comment: "Average awarded tender value. Benchmarks contract size and informs procurement resource allocation for tender management."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value across tenders. Measures financial security coverage in the tender pipeline for risk management."
    - name: "tender_count"
      expr: COUNT(1)
      comment: "Total number of tenders issued. Baseline formal procurement activity metric for governance reporting and workload management."
    - name: "awarded_tender_count"
      expr: COUNT(CASE WHEN tender_status = 'Awarded' THEN 1 END)
      comment: "Number of successfully awarded tenders. Measures tender completion rate and sourcing pipeline conversion."
    - name: "cancelled_tender_count"
      expr: COUNT(CASE WHEN tender_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled tenders. High cancellation rates signal demand planning failures or market engagement issues requiring process review."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`procurement_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier contract portfolio KPIs covering contract value, utilization, risk classification, and lifecycle management. Used by procurement and legal teams to manage contract compliance, renewal risk, and spend under contract."
  source: "`vibe_shipping_ports_v1`.`procurement`.`supplier_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the supplier contract (Active, Expired, Terminated, Draft) for contract portfolio health monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (Framework, Blanket Order, Service Agreement, Supply Agreement) for contract instrument analysis."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification of the contract (High/Medium/Low) for supply chain risk management prioritization."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency spend commitment analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization owning the contract for organizational spend attribution."
    - name: "vendor_performance_rating"
      expr: vendor_performance_rating
      comment: "Vendor performance rating on the contract for contract renewal and extension decision support."
    - name: "valid_from_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Month of contract start for contract portfolio vintage analysis."
    - name: "valid_to_month"
      expr: DATE_TRUNC('MONTH', valid_to_date)
      comment: "Month of contract expiry for renewal pipeline management and expiry risk tracking."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total value of all supplier contracts. Measures total spend under contract — a key procurement governance KPI for spend coverage."
    - name: "total_released_value"
      expr: SUM(CAST(released_value AS DOUBLE))
      comment: "Total value released (called off) against supplier contracts. Measures actual spend consumption vs contracted commitment."
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average contract utilization rate. Low utilization indicates over-contracting or demand shortfalls; high utilization signals need for contract extension."
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity released against supplier contracts. Used for volume commitment tracking and minimum purchase obligation compliance."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total contracted target quantity across supplier contracts. Used as denominator for quantity utilization rate calculation."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of supplier contracts. Baseline contract portfolio size metric for contract management workload and vendor consolidation analysis."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active supplier contracts. Measures live contractual coverage of procurement spend."
    - name: "high_risk_contract_count"
      expr: COUNT(CASE WHEN risk_classification = 'High' THEN 1 END)
      comment: "Number of high-risk supplier contracts. Drives contract risk mitigation prioritization and contingency sourcing planning."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`procurement_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement planning KPIs covering budget commitment, CAPEX/OPEX allocation, and strategic sourcing pipeline. Used by CPO and finance to align procurement spend with budget and strategic objectives."
  source: "`vibe_shipping_ports_v1`.`procurement`.`procurement_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the procurement plan (Draft, Approved, In Execution, Closed) for planning pipeline management."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of procurement plan (Annual, Project, Emergency) for planning instrument classification."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the procurement plan for annual budget cycle alignment and year-over-year comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the procurement plan for multi-currency budget analysis."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification of the procurement plan for supply chain risk prioritization."
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy (Single Source, Dual Source, Competitive) for strategic procurement analysis."
    - name: "competitive_tender_required_flag"
      expr: CAST(competitive_tender_required_flag AS STRING)
      comment: "Flag indicating whether competitive tendering is required, for procurement governance compliance tracking."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Start month of the procurement plan period for time-phased spend planning analysis."
  measures:
    - name: "total_planned_spend"
      expr: SUM(CAST(total_planned_spend_amount AS DOUBLE))
      comment: "Total planned procurement spend across all plans. Primary budget planning KPI used by CPO and CFO to align procurement with financial targets."
    - name: "total_budget_commitment"
      expr: SUM(CAST(budget_commitment_amount AS DOUBLE))
      comment: "Total budget committed to procurement plans. Measures encumbered budget for financial planning and budget availability tracking."
    - name: "total_capex_allocation"
      expr: SUM(CAST(capex_allocation_amount AS DOUBLE))
      comment: "Total CAPEX allocated in procurement plans. Used by finance for capital expenditure planning and asset investment tracking."
    - name: "total_opex_allocation"
      expr: SUM(CAST(opex_allocation_amount AS DOUBLE))
      comment: "Total OPEX allocated in procurement plans. Used for operational cost budgeting and P&L impact forecasting."
    - name: "avg_local_content_requirement_pct"
      expr: AVG(CAST(local_content_requirement_percentage AS DOUBLE))
      comment: "Average local content requirement percentage across procurement plans. Tracks compliance with local procurement mandates relevant to port concession agreements."
    - name: "procurement_plan_count"
      expr: COUNT(1)
      comment: "Total number of procurement plans. Baseline planning activity metric for procurement governance and resource allocation."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN 1 END)
      comment: "Number of approved procurement plans. Measures planning readiness and budget authorization coverage for the procurement pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_shipping_ports_v1`.`_metrics`.`procurement_vendor_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor certification compliance KPIs tracking certification coverage, expiry risk, and renewal pipeline. Used by procurement and HSSE teams to ensure vendor qualification standards are maintained and regulatory compliance is sustained."
  source: "`vibe_shipping_ports_v1`.`procurement`.`vendor_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (Active, Expired, Suspended, Pending Renewal) for compliance pipeline management."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (ISO, ISPS, HSSE, Trade License, etc.) for compliance category analysis."
    - name: "certification_name"
      expr: certification_name
      comment: "Name of the specific certification for granular compliance tracking."
    - name: "is_mandatory"
      expr: CAST(is_mandatory AS STRING)
      comment: "Flag indicating whether the certification is mandatory for vendor qualification — critical for compliance risk prioritization."
    - name: "is_verified"
      expr: CAST(is_verified AS STRING)
      comment: "Flag indicating whether the certification has been independently verified by procurement."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the certification (Not Started, In Progress, Renewed) for expiry risk management."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating associated with the certification lapse (High/Medium/Low) for compliance risk prioritization."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of certification expiry for renewal pipeline planning and compliance calendar management."
  measures:
    - name: "certification_count"
      expr: COUNT(1)
      comment: "Total number of vendor certifications tracked. Baseline compliance coverage metric for the vendor qualification program."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Number of currently active vendor certifications. Measures live compliance coverage across the supply base."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Number of expired vendor certifications. Expired mandatory certifications create immediate vendor disqualification risk and operational disruption."
    - name: "mandatory_expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' AND is_mandatory = TRUE THEN 1 END)
      comment: "Number of expired mandatory certifications. Critical compliance risk KPI — each instance represents a vendor that should be suspended from operations."
    - name: "unverified_certification_count"
      expr: COUNT(CASE WHEN is_verified = FALSE THEN 1 END)
      comment: "Number of certifications not yet independently verified. Unverified certifications represent procurement control gaps and potential fraud risk."
    - name: "suspended_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Suspended' THEN 1 END)
      comment: "Number of suspended vendor certifications. Suspended certifications may block vendor from operating in regulated port areas."
$$;