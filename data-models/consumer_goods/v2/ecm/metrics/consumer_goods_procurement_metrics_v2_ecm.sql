-- Metric views for domain: procurement | Business: Consumer Goods | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_approved_supplier_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Supplier List (ASL) KPIs measuring supplier approval coverage, qualification levels, preferred supplier concentration, and VMI eligibility for supply base governance."
  source: "`vibe_consumer_goods_v1`.`procurement`.`approved_supplier_list`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the ASL entry (e.g., Approved, Conditional, Blocked) for supply base compliance."
    - name: "approved_supplier_list_status"
      expr: approved_supplier_list_status
      comment: "Overall status of the ASL record for portfolio health monitoring."
    - name: "qualification_level"
      expr: qualification_level
      comment: "Qualification level of the approved supplier (e.g., Preferred, Approved, Conditional) for tiered sourcing."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Flag indicating preferred supplier status for single/dual source strategy analysis."
    - name: "sole_source_flag"
      expr: sole_source_flag
      comment: "Flag indicating sole source status for supply concentration risk analysis."
    - name: "vmi_eligible_flag"
      expr: vmi_eligible_flag
      comment: "Flag indicating VMI eligibility for VMI program expansion planning."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the ASL entry for supply chain risk management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the ASL entry for regulatory and quality governance."
    - name: "approval_date"
      expr: approval_date
      comment: "Date of approval for ASL entry age and renewal cycle analysis."
    - name: "approval_expiration_date"
      expr: approval_expiration_date
      comment: "Expiration date of the ASL approval for renewal risk management."
  measures:
    - name: "total_asl_entries"
      expr: COUNT(1)
      comment: "Total number of Approved Supplier List entries. Baseline for supply base coverage measurement."
    - name: "approved_entry_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of fully approved ASL entries. Measures compliant supply base size."
    - name: "preferred_supplier_count"
      expr: COUNT(CASE WHEN preferred_supplier_flag = TRUE THEN 1 END)
      comment: "Number of preferred supplier ASL entries. Measures preferred supplier program coverage."
    - name: "sole_source_count"
      expr: COUNT(CASE WHEN sole_source_flag = TRUE THEN 1 END)
      comment: "Number of sole source ASL entries. Measures supply concentration risk — high counts indicate single-source dependency."
    - name: "sole_source_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sole_source_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ASL entries that are sole source. Critical supply chain resilience KPI — high rates indicate concentration risk."
    - name: "vmi_eligible_count"
      expr: COUNT(CASE WHEN vmi_eligible_flag = TRUE THEN 1 END)
      comment: "Number of VMI-eligible ASL entries. Measures VMI program expansion potential."
    - name: "total_approved_spend"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total spend amount across ASL entries. Measures spend under approved supplier governance."
    - name: "avg_moq_quantity"
      expr: AVG(CAST(moq_quantity AS DOUBLE))
      comment: "Average minimum order quantity across ASL entries. Informs inventory planning and working capital requirements."
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of ASL entries requiring incoming inspection. Measures quality control workload for receiving operations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule KPIs covering scheduled vs. confirmed vs. delivered quantities, delivery accuracy, and outstanding balances. Enables supply chain teams to manage inbound delivery performance."
  source: "`vibe_consumer_goods_v1`.`procurement`.`delivery_schedule`"
  dimensions:
    - name: "delivery_schedule_status"
      expr: delivery_schedule_status
      comment: "Schedule status for open-commitment and exception tracking."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Supplier confirmation status for delivery reliability assessment."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery execution status for inbound logistics performance."
    - name: "delivery_priority"
      expr: delivery_priority
      comment: "Delivery priority for expediting and supply-risk management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for logistics cost and carbon footprint analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Receiving plant for site-level delivery performance."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Scheduled delivery month for supply planning alignment."
    - name: "currency_code"
      expr: currency_code
      comment: "Schedule currency for financial commitment tracking."
  measures:
    - name: "total_schedule_count"
      expr: COUNT(1)
      comment: "Total delivery schedule lines; baseline inbound supply pipeline metric."
    - name: "total_scheduled_quantity"
      expr: SUM(CAST(scheduled_quantity AS DOUBLE))
      comment: "Total quantity scheduled for delivery; primary inbound supply plan metric."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed by supplier; measures supplier commitment reliability."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity actually delivered; measures fulfilment against schedule."
    - name: "total_outstanding_quantity"
      expr: SUM(CAST(outstanding_quantity AS DOUBLE))
      comment: "Total open quantity not yet delivered; critical for supply-risk and expediting decisions."
    - name: "total_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total financial value of delivery schedules; measures open purchase commitment."
    - name: "delivery_confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled quantity confirmed by supplier; measures supplier responsiveness."
    - name: "delivery_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(delivered_quantity AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled quantity delivered; key inbound OTIF component metric."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs measuring inbound delivery performance, quality acceptance rates, and OTIF compliance for supply chain reliability management."
  source: "`vibe_consumer_goods_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (e.g., Posted, Reversed, Blocked) for inbound pipeline analysis."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality inspection outcome (e.g., Accepted, Rejected, Under Review) for quality performance tracking."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP-style movement type code indicating the nature of the goods movement for inventory impact analysis."
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date goods were physically received, used for delivery performance and lead time analysis."
    - name: "posting_date"
      expr: posting_date
      comment: "Accounting posting date of the goods receipt for financial period alignment."
    - name: "otif_compliance_flag"
      expr: otif_compliance_flag
      comment: "Flag indicating whether the delivery was On-Time In-Full, the primary inbound OTIF indicator."
    - name: "gr_reversal_flag"
      expr: gr_reversal_flag
      comment: "Flag indicating whether the goods receipt was reversed, used to identify problematic receipts."
    - name: "sustainable_sourcing_certification"
      expr: sustainable_sourcing_certification
      comment: "Sustainability certification on the received goods for green procurement compliance tracking."
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipts posted. Baseline inbound volume metric."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received. Measures inbound supply volume for inventory replenishment tracking."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after quality inspection. Measures usable inbound supply."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt. High rejection volumes signal supplier quality problems."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that was rejected. Critical inbound quality KPI — drives supplier corrective actions."
    - name: "acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accepted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity accepted. Measures inbound quality compliance rate."
    - name: "otif_compliant_receipt_count"
      expr: COUNT(CASE WHEN otif_compliance_flag = TRUE THEN 1 END)
      comment: "Number of goods receipts that were OTIF compliant. Measures supplier delivery reliability."
    - name: "otif_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN otif_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts that were On-Time In-Full. Primary inbound OTIF KPI for supplier performance management."
    - name: "reversed_receipt_count"
      expr: COUNT(CASE WHEN gr_reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed goods receipts. High reversal rates indicate receiving errors or supplier disputes."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gr_reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts that were reversed. Tracks receiving process quality and supplier dispute frequency."
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount of goods received. Measures the financial value of inbound supply for inventory valuation."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of goods received. Used for price variance analysis against PO prices."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level invoice KPIs covering price variances, quantity variances, and tax accuracy. Enables AP and procurement to identify billing discrepancies and enforce contract compliance."
  source: "`vibe_consumer_goods_v1`.`procurement`.`invoice_line`"
  dimensions:
    - name: "match_status"
      expr: match_status
      comment: "Line-level match status for exception-driven AP processing."
    - name: "currency_code"
      expr: currency_code
      comment: "Line currency for multi-currency variance analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant for site-level invoice accuracy reporting."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code for indirect-tax line-level compliance."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade-compliance and duty analysis."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification on the invoice line for ESG spend tracking."
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total invoice lines processed; baseline AP line-item workload metric."
    - name: "total_line_net_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Total net amount across invoice lines; primary AP line-level spend metric."
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance AS DOUBLE))
      comment: "Total price variance (invoiced vs. PO price); measures contract price compliance and leakage."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance (invoiced vs. received); flags over/under-billing by suppliers."
    - name: "total_amount_variance"
      expr: SUM(CAST(amount_variance AS DOUBLE))
      comment: "Total monetary variance on invoice lines; aggregate financial exposure from billing discrepancies."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on invoice lines for indirect-tax reconciliation."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts on invoice lines; measures negotiated savings realisation."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price on invoice lines; benchmark for price-trend and contract-compliance monitoring."
    - name: "price_variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(price_variance AS DOUBLE)) / NULLIF(SUM(CAST(line_net_amount AS DOUBLE)), 0), 2)
      comment: "Price variance as a percentage of net invoice amount; executive KPI for contract price leakage."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_po_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PO confirmation KPIs covering supplier confirmation rates, quantity variances, price variances, and OTIF risk. Enables buyers to manage supplier commitment reliability and exception handling."
  source: "`vibe_consumer_goods_v1`.`procurement`.`po_confirmation`"
  dimensions:
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status (confirmed, rejected, pending) for supplier commitment tracking."
    - name: "confirmation_method"
      expr: confirmation_method
      comment: "Confirmation method (EDI, email, portal) for digital integration analysis."
    - name: "buyer_approval_status"
      expr: buyer_approval_status
      comment: "Buyer approval status for exception management workflow."
    - name: "currency_code"
      expr: currency_code
      comment: "Confirmation currency for financial variance analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant for site-level confirmation performance."
    - name: "confirmation_date"
      expr: DATE_TRUNC('month', confirmation_date)
      comment: "Month of confirmation for trend analysis."
    - name: "otif_risk_flag"
      expr: otif_risk_flag
      comment: "OTIF risk flag for proactive supply-risk management."
  measures:
    - name: "total_confirmation_count"
      expr: COUNT(1)
      comment: "Total PO confirmations received; baseline supplier responsiveness metric."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed by suppliers; measures committed inbound supply."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance (confirmed vs. requested); measures supplier fulfilment commitment accuracy."
    - name: "avg_quantity_variance_pct"
      expr: AVG(CAST(quantity_variance_pct AS DOUBLE))
      comment: "Average percentage quantity variance; executive KPI for supplier commitment reliability."
    - name: "otif_risk_count"
      expr: COUNT(CASE WHEN otif_risk_flag = TRUE THEN 1 END)
      comment: "Number of confirmations flagged as OTIF risk; drives proactive expediting and supply-risk mitigation."
    - name: "substitution_count"
      expr: COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END)
      comment: "Number of confirmations with material substitutions; measures supply disruption frequency."
    - name: "otif_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN otif_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of confirmations at OTIF risk; executive supply reliability KPI."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement KPIs covering ordered quantities, received quantities, outstanding balances, and price compliance. Enables buyers to manage open commitments and receipt performance."
  source: "`vibe_consumer_goods_v1`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the PO line (open, closed, blocked) for open-commitment tracking."
    - name: "material_group"
      expr: material_group
      comment: "Material group for category-level spend and volume analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Receiving plant for site-level procurement performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Line currency for multi-currency spend analysis."
    - name: "incoterm_code"
      expr: incoterm_code
      comment: "Incoterm on the line for landed-cost segmentation."
    - name: "delivery_date"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Scheduled delivery month for demand-timing analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code for indirect-tax compliance reporting."
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total PO lines; baseline volume metric for procurement workload."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all lines; input for demand and inventory planning."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity goods-receipted; measures fulfilment progress against orders."
    - name: "total_outstanding_quantity"
      expr: SUM(CAST(outstanding_quantity AS DOUBLE))
      comment: "Total open quantity not yet received; critical for supply-risk and expediting decisions."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net value of PO lines; primary spend-commitment metric at line level."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across lines; benchmark for price-variance and negotiation performance."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total invoiced quantity; used to compute invoice-to-order match rate."
    - name: "receipt_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been received; measures supplier delivery completeness."
    - name: "invoice_match_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(invoiced_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been invoiced; flags billing discrepancies."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_vmi_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Managed Inventory agreement KPIs measuring VMI program coverage, inventory level compliance, and replenishment performance for supply chain collaboration management."
  source: "`vibe_consumer_goods_v1`.`procurement`.`procurement_vmi_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: procurement_vmi_agreement_status
      comment: "Current status of the VMI agreement (e.g., Active, Expired, Suspended) for program health monitoring."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of VMI agreement (e.g., Consignment, Replenishment, Kanban) for program strategy analysis."
    - name: "replenishment_model"
      expr: replenishment_model
      comment: "Replenishment model used in the VMI agreement (e.g., Min-Max, Continuous Review) for operational analysis."
    - name: "consignment_flag"
      expr: consignment_flag
      comment: "Flag indicating whether the VMI agreement includes consignment inventory, for ownership and liability analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether the VMI agreement auto-renews, for contract management planning."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Flag indicating whether EDI is enabled for automated replenishment signals."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the VMI agreement for program age and renewal cycle analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the VMI agreement for expiry risk management."
  measures:
    - name: "total_vmi_agreements"
      expr: COUNT(1)
      comment: "Total number of VMI agreements. Baseline for VMI program scale and coverage."
    - name: "active_vmi_agreement_count"
      expr: COUNT(CASE WHEN procurement_vmi_agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active VMI agreements. Measures active VMI program coverage."
    - name: "consignment_agreement_count"
      expr: COUNT(CASE WHEN consignment_flag = TRUE THEN 1 END)
      comment: "Number of VMI agreements with consignment terms. Measures consignment inventory program scope."
    - name: "edi_enabled_agreement_count"
      expr: COUNT(CASE WHEN edi_enabled_flag = TRUE THEN 1 END)
      comment: "Number of VMI agreements with EDI enabled. Measures automation level in VMI replenishment."
    - name: "edi_enablement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN edi_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VMI agreements with EDI enabled. Tracks VMI automation maturity."
    - name: "avg_sla_fill_rate_target_pct"
      expr: AVG(CAST(sla_fill_rate_target_pct AS DOUBLE))
      comment: "Average SLA fill rate target across VMI agreements. Measures service level ambition in VMI programs."
    - name: "avg_sla_otif_target_pct"
      expr: AVG(CAST(sla_otif_target_pct AS DOUBLE))
      comment: "Average SLA OTIF target across VMI agreements. Tracks delivery performance commitments in VMI contracts."
    - name: "avg_max_inventory_level"
      expr: AVG(CAST(max_inventory_level AS DOUBLE))
      comment: "Average maximum inventory level across VMI agreements. Used for working capital and storage capacity planning."
    - name: "avg_min_inventory_level"
      expr: AVG(CAST(min_inventory_level AS DOUBLE))
      comment: "Average minimum inventory level across VMI agreements. Measures safety stock commitments in VMI programs."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point across VMI agreements. Informs replenishment trigger analysis and stockout risk management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order management: spend volume, approval efficiency, on-time delivery performance, and order cycle health for procurement steering."
  source: "`vibe_consumer_goods_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: purchase_order_status
      comment: "Current lifecycle status of the purchase order (e.g., Open, Closed, Cancelled) for pipeline segmentation."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Blanket, Framework) to segment spend by procurement strategy."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO, used to track bottlenecks in the approval pipeline."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the order, enabling spend analysis by procurement unit."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group (buyer team) that created the order, for workload and spend distribution analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms (e.g., DDP, EXW, CIF) to analyze trade term distribution and risk exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order for multi-currency spend analysis."
    - name: "order_date"
      expr: order_date
      comment: "Date the purchase order was created, used for time-series spend trending."
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Requested delivery date on the PO, used to assess delivery lead time and OTIF risk."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification associated with the PO, enabling green procurement tracking."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g., Air, Sea, Road) for logistics cost and carbon footprint analysis."
    - name: "vmi_indicator"
      expr: vmi_indicator
      comment: "Flag indicating whether the PO is part of a Vendor Managed Inventory agreement."
  measures:
    - name: "total_purchase_order_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline volume metric for procurement activity tracking."
    - name: "total_net_order_value"
      expr: SUM(CAST(net_order_value AS DOUBLE))
      comment: "Total net value of all purchase orders. Primary spend KPI used in budget vs. actuals and category spend analysis."
    - name: "total_order_value"
      expr: SUM(CAST(total_order_value AS DOUBLE))
      comment: "Total gross order value including all line items. Used for committed spend reporting."
    - name: "avg_net_order_value"
      expr: AVG(CAST(net_order_value AS DOUBLE))
      comment: "Average net value per purchase order. Indicates typical transaction size and helps identify outliers."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all purchase orders. Used for tax liability reporting and compliance."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs on purchase orders. Tracks logistics spend as a component of total procurement cost."
    - name: "cancelled_po_count"
      expr: COUNT(CASE WHEN purchase_order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled purchase orders. High cancellation rates signal demand volatility or supplier issues."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN purchase_order_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of purchase orders that were cancelled. A key procurement health indicator — high rates indicate planning or supplier reliability problems."
    - name: "pending_approval_po_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Rejected', 'Cancelled') THEN 1 END)
      comment: "Number of POs awaiting approval. Tracks approval pipeline bottlenecks that delay procurement execution."
    - name: "vmi_po_count"
      expr: COUNT(CASE WHEN vmi_indicator = TRUE THEN 1 END)
      comment: "Number of purchase orders under VMI agreements. Measures VMI program adoption and coverage."
    - name: "sustainable_po_count"
      expr: COUNT(CASE WHEN sustainability_certification IS NOT NULL AND sustainability_certification <> '' THEN 1 END)
      comment: "Number of POs with a sustainability certification. Tracks green procurement progress against ESG targets."
    - name: "sustainable_spend_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainability_certification IS NOT NULL AND sustainability_certification <> '' THEN CAST(net_order_value AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(net_order_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total net order value covered by sustainability-certified POs. Core ESG procurement KPI."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition KPIs covering requisition volumes, approval cycle times, estimated values, and conversion rates. Enables procurement operations to manage demand intake and approval efficiency."
  source: "`vibe_consumer_goods_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "purchase_requisition_status"
      expr: purchase_requisition_status
      comment: "Requisition status (pending, approved, rejected, converted) for pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for bottleneck identification."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Requisition type (standard, service, stock) for demand classification."
    - name: "priority"
      expr: priority
      comment: "Requisition priority for expediting and workload management."
    - name: "currency_code"
      expr: currency_code
      comment: "Requisition currency for spend-value normalisation."
    - name: "material_group_code"
      expr: material_group_code
      comment: "Material group for category-level demand analysis."
    - name: "requisition_date"
      expr: DATE_TRUNC('month', requisition_date)
      comment: "Month of requisition creation for demand trend analysis."
    - name: "sustainability_flag"
      expr: sustainability_flag
      comment: "Sustainability flag on requisitions for ESG demand tracking."
  measures:
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total purchase requisitions raised; baseline procurement demand intake metric."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated value of requisitions; measures uncontracted spend demand pipeline."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price on requisitions; benchmark for price expectation vs. actual PO price."
    - name: "approved_requisition_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved requisitions; measures approval throughput."
    - name: "rejected_requisition_count"
      expr: COUNT(CASE WHEN approval_status = 'REJECTED' THEN 1 END)
      comment: "Number of rejected requisitions; high rejection rate signals policy non-compliance or poor demand planning."
    - name: "sustainable_requisition_count"
      expr: COUNT(CASE WHEN sustainability_flag = TRUE THEN 1 END)
      comment: "Requisitions with sustainability flag; tracks ESG-aligned demand at source."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions approved; measures procurement policy compliance and demand quality."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ (Request for Quotation) process KPIs measuring sourcing competitiveness, supplier participation, award efficiency, and savings realization for strategic sourcing management."
  source: "`vibe_consumer_goods_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g., Draft, Issued, Awarded, Closed) for sourcing pipeline tracking."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g., Open, Sealed, Reverse Auction) for sourcing strategy analysis."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category of the RFQ for spend category sourcing performance analysis."
    - name: "commodity_subcategory"
      expr: commodity_subcategory
      comment: "Commodity subcategory for granular sourcing performance analysis."
    - name: "requires_sustainability_declaration"
      expr: requires_sustainability_declaration
      comment: "Flag indicating whether a sustainability declaration was required, for green sourcing program tracking."
    - name: "issue_date"
      expr: issue_date
      comment: "Date the RFQ was issued to suppliers, for sourcing cycle time analysis."
    - name: "award_date"
      expr: award_date
      comment: "Date the RFQ was awarded, for sourcing lead time and award cycle analysis."
  measures:
    - name: "total_rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued. Baseline sourcing activity volume metric."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all RFQs. Measures the spend under active competitive sourcing."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per RFQ. Indicates typical sourcing event size for resource planning."
    - name: "avg_suppliers_invited"
      expr: AVG(CAST(supplier_count_invited AS DOUBLE))
      comment: "Average number of suppliers invited per RFQ. Measures sourcing market coverage and competition breadth."
    - name: "avg_suppliers_responded"
      expr: AVG(CAST(supplier_count_responded AS DOUBLE))
      comment: "Average number of suppliers that responded per RFQ. Measures supplier engagement and market interest."
    - name: "sustainability_rfq_count"
      expr: COUNT(CASE WHEN requires_sustainability_declaration = TRUE THEN 1 END)
      comment: "Number of RFQs requiring sustainability declarations. Tracks green sourcing program adoption."
    - name: "sustainability_rfq_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_sustainability_declaration = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs requiring sustainability declarations. ESG sourcing compliance KPI."
    - name: "awarded_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Awarded' THEN 1 END)
      comment: "Number of RFQs that have been awarded. Measures sourcing pipeline conversion and completion rate."
    - name: "rfq_award_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rfq_status = 'Awarded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs that resulted in an award. Measures sourcing process effectiveness and completion."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_rfq_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier bid response KPIs covering quoted prices, evaluation scores, award rates, and response quality. Enables sourcing teams to evaluate supplier competitiveness and bid quality."
  source: "`vibe_consumer_goods_v1`.`procurement`.`rfq_response`"
  dimensions:
    - name: "rfq_response_status"
      expr: rfq_response_status
      comment: "Response status (submitted, awarded, rejected) for bid pipeline management."
    - name: "currency_code"
      expr: currency_code
      comment: "Response currency for price normalisation."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms on the bid for landed-cost comparison."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification offered by the bidder for ESG sourcing evaluation."
    - name: "response_date"
      expr: DATE_TRUNC('month', response_date)
      comment: "Month of bid submission for sourcing timeline analysis."
    - name: "is_awarded"
      expr: is_awarded
      comment: "Whether the response was awarded; enables win/loss analysis."
  measures:
    - name: "total_response_count"
      expr: COUNT(1)
      comment: "Total bid responses received; measures supplier market engagement."
    - name: "awarded_response_count"
      expr: COUNT(CASE WHEN is_awarded = TRUE THEN 1 END)
      comment: "Number of awarded bids; baseline for award decision tracking."
    - name: "total_quoted_value"
      expr: SUM(CAST(total_quoted_value AS DOUBLE))
      comment: "Total value of all bids received; measures competitive market pricing pool."
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price across responses; benchmark for market price intelligence."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average bid evaluation score; measures overall quality of supplier responses."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount offered by bidders; measures competitive pricing pressure."
    - name: "sds_provided_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sds_provided_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of responses with SDS documentation; measures regulatory compliance in bidding."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_service_entry_sheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service entry sheet KPIs covering service spend, approval rates, and supplier performance. Enables procurement and finance to manage indirect and services spend lifecycle."
  source: "`vibe_consumer_goods_v1`.`procurement`.`service_entry_sheet`"
  dimensions:
    - name: "service_entry_sheet_status"
      expr: service_entry_sheet_status
      comment: "SES status (pending, approved, rejected) for services AP pipeline management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for services spend governance."
    - name: "service_type"
      expr: service_type
      comment: "Type of service for indirect spend category analysis."
    - name: "service_category"
      expr: service_category
      comment: "Service category for spend classification and budget tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "SES currency for multi-currency services spend reporting."
    - name: "service_date"
      expr: DATE_TRUNC('month', service_date)
      comment: "Month of service delivery for accrual and period-close management."
    - name: "is_sustainable"
      expr: is_sustainable
      comment: "Sustainable service flag for ESG services spend tracking."
  measures:
    - name: "total_ses_count"
      expr: COUNT(1)
      comment: "Total service entry sheets; baseline for services procurement activity."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net services spend; primary indirect spend metric for services category."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on service entry sheets for indirect-tax compliance."
    - name: "total_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross services spend including tax; full liability metric for services AP."
    - name: "avg_supplier_performance_score"
      expr: AVG(CAST(supplier_performance_score AS DOUBLE))
      comment: "Average supplier performance score on SES; measures service delivery quality."
    - name: "approved_ses_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of approved SES; measures services spend approval throughput."
    - name: "ses_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SES approved; measures services procurement process compliance."
    - name: "sustainable_ses_count"
      expr: COUNT(CASE WHEN is_sustainable = TRUE THEN 1 END)
      comment: "SES flagged as sustainable; tracks ESG-aligned services spend."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing event KPIs measuring savings realization, supplier participation, and sourcing program effectiveness for category management and CPO reporting."
  source: "`vibe_consumer_goods_v1`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "sourcing_event_status"
      expr: sourcing_event_status
      comment: "Current status of the sourcing event (e.g., Planning, Active, Awarded, Closed) for pipeline management."
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (e.g., RFQ, RFP, Auction, Negotiation) for sourcing strategy analysis."
    - name: "event_outcome"
      expr: event_outcome
      comment: "Outcome of the sourcing event (e.g., Awarded, No Award, Cancelled) for effectiveness measurement."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category of the sourcing event for category-level savings and performance analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the sourcing event for governance compliance tracking."
    - name: "strategic_initiative_flag"
      expr: strategic_initiative_flag
      comment: "Flag indicating whether the event is part of a strategic procurement initiative."
    - name: "sustainability_requirement_flag"
      expr: sustainability_requirement_flag
      comment: "Flag indicating whether sustainability criteria were required in the sourcing event."
    - name: "start_date"
      expr: start_date
      comment: "Start date of the sourcing event for time-series sourcing activity analysis."
    - name: "end_date"
      expr: end_date
      comment: "End date of the sourcing event for cycle time and duration analysis."
  measures:
    - name: "total_sourcing_events"
      expr: COUNT(1)
      comment: "Total number of sourcing events. Baseline sourcing program activity metric."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated spend value under sourcing events. Measures spend under active management."
    - name: "total_baseline_spend"
      expr: SUM(CAST(baseline_spend_amount AS DOUBLE))
      comment: "Total baseline spend amount across sourcing events. Used as the denominator for savings rate calculation."
    - name: "total_awarded_savings"
      expr: SUM(CAST(awarded_savings_amount AS DOUBLE))
      comment: "Total savings awarded through sourcing events. Primary procurement value creation KPI for CPO and CFO reporting."
    - name: "total_target_savings"
      expr: SUM(CAST(target_savings_amount AS DOUBLE))
      comment: "Total target savings set for sourcing events. Used to measure savings realization vs. target."
    - name: "savings_realization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(awarded_savings_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_savings_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of target savings actually realized through sourcing events. Critical procurement effectiveness KPI."
    - name: "savings_on_baseline_pct"
      expr: ROUND(100.0 * SUM(CAST(awarded_savings_amount AS DOUBLE)) / NULLIF(SUM(CAST(baseline_spend_amount AS DOUBLE)), 0), 2)
      comment: "Awarded savings as a percentage of baseline spend. Measures procurement cost reduction impact on total spend."
    - name: "strategic_event_count"
      expr: COUNT(CASE WHEN strategic_initiative_flag = TRUE THEN 1 END)
      comment: "Number of sourcing events classified as strategic initiatives. Tracks strategic procurement program activity."
    - name: "sustainability_event_count"
      expr: COUNT(CASE WHEN sustainability_requirement_flag = TRUE THEN 1 END)
      comment: "Number of sourcing events with sustainability requirements. Tracks green sourcing program adoption."
    - name: "avg_suppliers_participated"
      expr: AVG(CAST(suppliers_participated_count AS DOUBLE))
      comment: "Average number of suppliers participating per sourcing event. Measures market competition and supplier engagement."
    - name: "avg_awarded_savings_per_event"
      expr: AVG(CAST(awarded_savings_amount AS DOUBLE))
      comment: "Average savings awarded per sourcing event. Measures sourcing event productivity and ROI."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_spend_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend category management KPIs measuring category spend performance, contract coverage, savings targets, and strategic category portfolio health for category managers and CPOs."
  source: "`vibe_consumer_goods_v1`.`procurement`.`spend_category`"
  dimensions:
    - name: "category_status"
      expr: spend_category_status
      comment: "Current status of the spend category (e.g., Active, Under Review, Archived) for portfolio management."
    - name: "category_level"
      expr: category_level
      comment: "Hierarchy level of the spend category (e.g., L1, L2, L3) for hierarchical spend analysis."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type classification for cross-category spend benchmarking."
    - name: "is_direct_spend"
      expr: is_direct_spend
      comment: "Flag distinguishing direct (production) from indirect spend categories for strategic prioritization."
    - name: "is_strategic"
      expr: is_strategic
      comment: "Flag indicating whether the category is classified as strategic for executive attention and resource allocation."
    - name: "risk_profile"
      expr: risk_profile
      comment: "Risk profile of the spend category (e.g., Low, Medium, High) for supply chain risk management."
    - name: "preferred_sourcing_strategy"
      expr: preferred_sourcing_strategy
      comment: "Preferred sourcing strategy for the category (e.g., Single Source, Dual Source, Competitive) for strategy compliance."
    - name: "sustainable_sourcing_flag"
      expr: sustainable_sourcing_flag
      comment: "Flag indicating whether sustainable sourcing is required for this category."
  measures:
    - name: "total_category_count"
      expr: COUNT(1)
      comment: "Total number of spend categories. Baseline for category taxonomy size and management scope."
    - name: "total_annual_spend"
      expr: SUM(CAST(annual_spend AS DOUBLE))
      comment: "Total annual spend across all categories. Primary spend under management KPI for CPO reporting."
    - name: "total_annual_spend_budget"
      expr: SUM(CAST(annual_spend_budget_amount AS DOUBLE))
      comment: "Total annual spend budget across categories. Used for budget vs. actuals analysis."
    - name: "avg_contract_coverage_pct"
      expr: AVG(CAST(contract_coverage_percentage AS DOUBLE))
      comment: "Average contract coverage percentage across spend categories. Measures spend under contract governance — a key procurement maturity KPI."
    - name: "avg_cost_savings_target_pct"
      expr: AVG(CAST(cost_savings_target_percentage AS DOUBLE))
      comment: "Average cost savings target percentage across categories. Tracks ambition level of the savings program."
    - name: "strategic_category_count"
      expr: COUNT(CASE WHEN is_strategic = TRUE THEN 1 END)
      comment: "Number of strategic spend categories. Measures strategic category portfolio size for resource allocation."
    - name: "direct_spend_category_count"
      expr: COUNT(CASE WHEN is_direct_spend = TRUE THEN 1 END)
      comment: "Number of direct spend categories. Measures direct procurement scope and complexity."
    - name: "sustainable_category_count"
      expr: COUNT(CASE WHEN sustainable_sourcing_flag = TRUE THEN 1 END)
      comment: "Number of categories with sustainable sourcing requirements. Tracks ESG procurement program coverage."
    - name: "sustainable_category_spend"
      expr: SUM(CASE WHEN sustainable_sourcing_flag = TRUE THEN CAST(annual_spend AS DOUBLE) ELSE 0 END)
      comment: "Total annual spend in categories with sustainable sourcing requirements. Measures ESG-governed spend volume."
    - name: "high_risk_category_count"
      expr: COUNT(CASE WHEN risk_profile = 'High' THEN 1 END)
      comment: "Number of high-risk spend categories. Drives supply chain risk mitigation prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master KPIs covering supplier base composition, risk profile, certification coverage, and strategic segmentation for supplier relationship management."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current status of the supplier (e.g., Active, Blocked, Pending) for supplier base health monitoring."
    - name: "supplier_type"
      expr: supplier_type
      comment: "Classification of the supplier (e.g., Direct, Indirect, Service) for spend category analysis."
    - name: "tier"
      expr: tier
      comment: "Supplier tier (e.g., Tier 1, Tier 2) indicating supply chain depth and strategic importance."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the supplier for supply chain risk management and mitigation prioritization."
    - name: "country_code"
      expr: country_code
      comment: "Country of the supplier for geographic spend distribution and geopolitical risk analysis."
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Supplier diversity classification (e.g., MBE, WBE, SDVOB) for diversity spend reporting."
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Onboarding lifecycle status of the supplier, used to track pipeline of new suppliers being activated."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms agreed with the supplier, for working capital and cash flow analysis."
    - name: "is_strategic"
      expr: is_strategic
      comment: "Flag indicating whether the supplier is classified as strategic, for prioritized relationship management."
    - name: "vmi_eligible_flag"
      expr: vmi_eligible_flag
      comment: "Flag indicating whether the supplier is eligible for VMI programs."
  measures:
    - name: "total_supplier_count"
      expr: COUNT(1)
      comment: "Total number of suppliers in the master. Baseline for supplier base size and consolidation tracking."
    - name: "active_supplier_count"
      expr: COUNT(CASE WHEN supplier_status = 'Active' THEN 1 END)
      comment: "Number of currently active suppliers. Core metric for supplier base health and consolidation initiatives."
    - name: "strategic_supplier_count"
      expr: COUNT(CASE WHEN is_strategic = TRUE THEN 1 END)
      comment: "Number of suppliers classified as strategic. Used to track strategic supplier portfolio size."
    - name: "high_risk_supplier_count"
      expr: COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN 1 END)
      comment: "Number of suppliers rated high or critical risk. Drives supply chain risk mitigation prioritization."
    - name: "high_risk_supplier_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN risk_rating IN ('High', 'Critical') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with high or critical risk rating. Key supply chain resilience KPI for executive review."
    - name: "vmi_eligible_supplier_count"
      expr: COUNT(CASE WHEN vmi_eligible_flag = TRUE THEN 1 END)
      comment: "Number of suppliers eligible for VMI programs. Measures VMI program expansion potential."
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average supplier performance score across the active base. Tracks overall supplier quality and reliability."
    - name: "iso_9001_certified_supplier_count"
      expr: COUNT(CASE WHEN iso_9001_certified_flag = TRUE THEN 1 END)
      comment: "Number of ISO 9001 certified suppliers. Measures quality certification coverage in the supply base."
    - name: "iso_9001_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_9001_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with ISO 9001 certification. Quality compliance KPI for procurement governance."
    - name: "diversity_supplier_count"
      expr: COUNT(CASE WHEN diversity_classification IS NOT NULL AND diversity_classification <> '' THEN 1 END)
      comment: "Number of diversity-classified suppliers. Tracks supplier diversity program performance against ESG commitments."
    - name: "diversity_supplier_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN diversity_classification IS NOT NULL AND diversity_classification <> '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppliers with a diversity classification. Core ESG and supplier diversity KPI."
    - name: "avg_moq_quantity"
      expr: AVG(CAST(moq_quantity AS DOUBLE))
      comment: "Average minimum order quantity across suppliers. Informs inventory planning and working capital requirements."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier contract portfolio KPIs measuring contract coverage, value under management, renewal risk, and compliance for contract lifecycle management."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_contract`"
  dimensions:
    - name: "contract_status"
      expr: supplier_contract_status
      comment: "Current status of the supplier contract (e.g., Active, Expired, Terminated) for portfolio health monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., Framework, Blanket, Fixed Price) for contract strategy analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Flag indicating whether the contract auto-renews, for renewal risk and workload planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency spend under contract analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms in the contract for working capital and cash flow analysis."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification required in the contract for green procurement compliance tracking."
    - name: "effective_date"
      expr: effective_date
      comment: "Contract effective date for portfolio age and renewal cycle analysis."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Contract expiry date for renewal risk management and pipeline planning."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of supplier contracts. Baseline contract portfolio size metric."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN supplier_contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active supplier contracts. Measures active contract coverage of the supply base."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all supplier contracts. Measures spend under contract management — a key procurement governance KPI."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value. Indicates typical contract size for resource and risk management planning."
    - name: "expiring_contract_count"
      expr: COUNT(CASE WHEN supplier_contract_status = 'Expired' THEN 1 END)
      comment: "Number of expired contracts. Tracks contract renewal backlog and compliance risk from operating without active contracts."
    - name: "auto_renew_contract_count"
      expr: COUNT(CASE WHEN auto_renew_flag = TRUE THEN 1 END)
      comment: "Number of contracts set to auto-renew. Measures passive renewal exposure requiring proactive review."
    - name: "auto_renew_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renew_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts with auto-renewal. High rates may indicate insufficient contract review governance."
    - name: "sustainable_contract_count"
      expr: COUNT(CASE WHEN sustainability_certification IS NOT NULL AND sustainability_certification <> '' THEN 1 END)
      comment: "Number of contracts with sustainability certification requirements. Tracks green procurement contract coverage."
    - name: "sustainable_contract_value"
      expr: SUM(CASE WHEN sustainability_certification IS NOT NULL AND sustainability_certification <> '' THEN CAST(total_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of contracts with sustainability requirements. Measures ESG-compliant spend under contract."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total committed minimum order quantities across contracts. Measures supply commitment obligations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice management KPIs covering invoice processing efficiency, payment performance, tax liability, and three-way match compliance."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (e.g., Open, Paid, Blocked, Disputed) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., Standard, Credit Memo, Debit Memo) for AP transaction classification."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g., Paid, Overdue, Scheduled) for cash flow and DPO analysis."
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status (e.g., Matched, Unmatched, Partial) for invoice processing compliance."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Detailed three-way match outcome for PO/GR/Invoice reconciliation compliance tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., ACH, Wire, Check) for payment channel analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP analysis and FX exposure tracking."
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date of the supplier invoice for aging and period-based AP analysis."
    - name: "due_date"
      expr: due_date
      comment: "Payment due date for cash flow forecasting and early payment discount analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for period-close AP reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for annual spend and liability reporting."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices. Baseline AP volume metric."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount. Primary AP liability metric for cash flow and budget management."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Measures actual AP obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices. Used for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimization through early payment programs."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax amount. Required for tax compliance reporting in applicable jurisdictions."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(invoice_amount AS DOUBLE))
      comment: "Average invoice amount. Indicates typical transaction size and helps identify anomalous invoices."
    - name: "matched_invoice_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'Matched' THEN 1 END)
      comment: "Number of invoices with successful three-way match. Measures AP process compliance and automation rate."
    - name: "three_way_match_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_way_match_status = 'Matched' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices with successful three-way match. Critical AP compliance KPI — low rates indicate process breakdowns or supplier billing issues."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Blocked' THEN 1 END)
      comment: "Number of blocked invoices. Tracks AP processing bottlenecks that delay payment and damage supplier relationships."
    - name: "overdue_invoice_count"
      expr: COUNT(CASE WHEN payment_status = 'Overdue' THEN 1 END)
      comment: "Number of overdue invoices. Measures payment compliance and risk of supplier relationship damage or late payment penalties."
    - name: "paid_invoice_count"
      expr: COUNT(CASE WHEN payment_status = 'Paid' THEN 1 END)
      comment: "Number of paid invoices. Tracks AP throughput and payment cycle completion."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier qualification and audit KPIs measuring compliance certification rates, audit scores, and qualification pipeline health for supply chain quality governance."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: supplier_qualification_status
      comment: "Current status of the qualification (e.g., Qualified, Conditional, Disqualified) for supply base compliance tracking."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g., Initial, Re-qualification, Audit) for qualification program analysis."
    - name: "qualification_result"
      expr: qualification_result
      comment: "Outcome of the qualification assessment (e.g., Pass, Fail, Conditional Pass) for quality gate analysis."
    - name: "audit_method"
      expr: audit_method
      comment: "Method used for the audit (e.g., On-site, Remote, Document Review) for audit program management."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flag indicating whether corrective action was required, for supplier development prioritization."
    - name: "gmp_compliant_flag"
      expr: gmp_compliant_flag
      comment: "Flag indicating GMP compliance, critical for consumer goods and regulated product categories."
    - name: "iso_9001_compliant_flag"
      expr: iso_9001_compliant_flag
      comment: "Flag indicating ISO 9001 compliance for quality management system certification tracking."
    - name: "sustainability_criteria_met_flag"
      expr: sustainability_criteria_met_flag
      comment: "Flag indicating whether sustainability criteria were met in the qualification."
    - name: "qualification_date"
      expr: qualification_date
      comment: "Date of qualification for time-series compliance trend analysis."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of supplier qualification records. Baseline qualification program activity metric."
    - name: "qualified_supplier_count"
      expr: COUNT(CASE WHEN qualification_result = 'Pass' THEN 1 END)
      comment: "Number of suppliers that passed qualification. Measures qualified supply base size."
    - name: "qualification_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_result = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualification assessments that resulted in a pass. Key supply base quality KPI."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all supplier qualifications. Measures overall supply base audit performance."
    - name: "avg_overall_qualification_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall qualification score. Tracks supply base quality compliance level."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of qualifications requiring corrective action. Drives supplier development prioritization."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications requiring corrective action. Measures supply base compliance gap severity."
    - name: "gmp_compliant_count"
      expr: COUNT(CASE WHEN gmp_compliant_flag = TRUE THEN 1 END)
      comment: "Number of GMP-compliant supplier qualifications. Critical for regulated consumer goods categories."
    - name: "gmp_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualified suppliers that are GMP compliant. Regulatory compliance KPI for consumer goods procurement."
    - name: "sustainability_criteria_met_count"
      expr: COUNT(CASE WHEN sustainability_criteria_met_flag = TRUE THEN 1 END)
      comment: "Number of qualifications where sustainability criteria were met. Tracks ESG compliance in the supply base."
    - name: "sustainability_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sustainability_criteria_met_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of supplier qualifications meeting sustainability criteria. Core ESG supply chain KPI."
    - name: "avg_critical_findings"
      expr: AVG(CAST(critical_findings_count AS DOUBLE))
      comment: "Average number of critical findings per qualification audit. Measures severity of supply base compliance issues."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`procurement_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard KPIs measuring quality, delivery, cost, and overall supplier health for strategic supplier relationship management and development."
  source: "`vibe_consumer_goods_v1`.`procurement`.`supplier_scorecard`"
  dimensions:
    - name: "scorecard_status"
      expr: supplier_scorecard_status
      comment: "Status of the scorecard record (e.g., Draft, Final, Approved) for data quality filtering."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier assigned to the supplier (e.g., Preferred, Approved, Conditional) based on scorecard results."
    - name: "rating_grade"
      expr: rating_grade
      comment: "Letter or grade rating (e.g., A, B, C) summarizing overall supplier performance."
    - name: "evaluation_period"
      expr: evaluation_period
      comment: "The evaluation period (e.g., Q1 2024, FY2024) for time-series performance trending."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the evaluation period for time-based performance analysis."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the evaluation period."
    - name: "action_plan_required_flag"
      expr: action_plan_required_flag
      comment: "Flag indicating whether a corrective action plan is required, used to prioritize supplier development interventions."
  measures:
    - name: "total_scorecards"
      expr: COUNT(1)
      comment: "Total number of supplier scorecards issued. Baseline for scorecard program coverage."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score. Primary KPI for supplier base health in QBRs and executive dashboards."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across all evaluated suppliers. Tracks quality compliance and drives quality improvement programs."
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score. Measures on-time delivery reliability across the supply base."
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost competitiveness score. Tracks price competitiveness and cost reduction performance."
    - name: "avg_sustainability_compliance_score"
      expr: AVG(CAST(sustainability_compliance_score AS DOUBLE))
      comment: "Average sustainability compliance score. Core ESG KPI for supplier sustainability program management."
    - name: "avg_otif_pct"
      expr: AVG(CAST(otif_pct AS DOUBLE))
      comment: "Average On-Time In-Full delivery rate across suppliers. Critical supply chain reliability KPI."
    - name: "avg_invoice_accuracy_rate_pct"
      expr: AVG(CAST(invoice_accuracy_rate_pct AS DOUBLE))
      comment: "Average invoice accuracy rate. Tracks AP process efficiency and supplier billing quality."
    - name: "avg_quality_rejection_rate_ppm"
      expr: AVG(CAST(quality_rejection_rate_ppm AS DOUBLE))
      comment: "Average quality rejection rate in parts per million. Measures incoming material quality and drives supplier quality improvement."
    - name: "suppliers_requiring_action_plan_count"
      expr: COUNT(CASE WHEN action_plan_required_flag = TRUE THEN 1 END)
      comment: "Number of suppliers requiring a corrective action plan. Drives supplier development prioritization."
    - name: "action_plan_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_plan_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluated suppliers requiring corrective action. Key supplier risk KPI for procurement leadership."
    - name: "total_purchase_value"
      expr: SUM(CAST(total_purchase_value AS DOUBLE))
      comment: "Total purchase value covered by scorecards. Measures spend under active performance management."
    - name: "avg_score_trend_vs_prior"
      expr: AVG(CAST(overall_score AS DOUBLE) - CAST(prior_period_overall_score AS DOUBLE))
      comment: "Average change in overall score versus prior period. Tracks whether supplier performance is improving or declining across the base."
$$;
