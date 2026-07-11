-- Metric views for domain: procurement | Business: Manufacturing | Version: 2 | Generated on: 2026-07-10 11:52:40

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order management: spend volume, order cycle efficiency, supplier concentration, and compliance posture. Used by CPO and procurement leadership to steer sourcing decisions and monitor PO health."
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Closed, Cancelled) for pipeline segmentation."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g. Standard, Blanket, Framework) for spend categorisation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organisation responsible for the PO, enabling org-level spend benchmarking."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group that raised the PO, supporting buyer-level performance analysis."
    - name: "material_category"
      expr: material_category
      comment: "Material category of the PO for category-level spend analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state of the PO to monitor bottlenecks in the approval pipeline."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Goods receipt status to identify open POs awaiting delivery."
    - name: "invoice_receipt_status"
      expr: invoice_receipt_status
      comment: "Invoice receipt status for three-way match monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the PO for regulatory and policy adherence tracking."
    - name: "po_date_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the PO was raised, for trend analysis of procurement volumes."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms on the PO, relevant for logistics cost allocation."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed on the PO, used for cash flow and DPO analysis."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders raised. Baseline volume KPI for procurement activity."
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total committed spend value across all purchase orders. Primary spend-under-management KPI for CPO reporting."
    - name: "total_net_po_value"
      expr: SUM(CAST(net_po_value AS DOUBLE))
      comment: "Total net PO value (excluding tax) for clean spend analysis and budget reconciliation."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value. Tracks order size trends and identifies fragmentation or consolidation opportunities."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all POs. Used for tax liability reporting and compliance."
    - name: "approved_po_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of purchase orders that have been formally approved. Measures approval throughput."
    - name: "pending_approval_po_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('Approved', 'Rejected') THEN 1 END)
      comment: "Number of POs awaiting approval. Highlights bottlenecks in the approval workflow that delay procurement."
    - name: "po_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs that have been approved. Low rates signal approval process inefficiency or policy non-compliance."
    - name: "goods_receipt_pending_po_count"
      expr: COUNT(CASE WHEN goods_receipt_status NOT IN ('Complete', 'Closed') THEN 1 END)
      comment: "Number of POs with outstanding goods receipts. Tracks open delivery obligations and supplier fulfilment risk."
    - name: "compliance_non_conformant_po_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of POs flagged as non-compliant. Drives regulatory risk management and corrective action prioritisation."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers on active POs. Measures supplier base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_spend_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comprehensive spend analytics KPIs covering total spend, savings realisation, maverick spend, and category-level performance. Core dashboard for CPO, category managers, and finance for spend governance."
  source: "`vibe_manufacturing_v1`.`procurement`.`spend_record`"
  dimensions:
    - name: "spend_category"
      expr: spend_category
      comment: "High-level spend category for category management and strategic sourcing analysis."
    - name: "commodity_code_l1"
      expr: commodity_code_l1
      comment: "Level-1 commodity code for top-level spend taxonomy reporting."
    - name: "commodity_code_l2"
      expr: commodity_code_l2
      comment: "Level-2 commodity code for mid-level category drill-down."
    - name: "commodity_code_l3"
      expr: commodity_code_l3
      comment: "Level-3 commodity code for granular category analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organisation for org-level spend benchmarking."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group for buyer-level spend accountability."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend normalisation."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used, relevant for cash management and payment channel analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for DPO and working capital analysis."
    - name: "maverick_spend_flag"
      expr: maverick_spend_flag
      comment: "Indicates whether the spend was off-contract (maverick). Key compliance dimension for spend governance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual spend budgeting and variance analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for periodic spend reporting and accrual management."
    - name: "supplier_segment"
      expr: supplier_segment
      comment: "Supplier segmentation tier (e.g. Strategic, Preferred, Approved) for supplier relationship management."
    - name: "procurement_channel"
      expr: procurement_channel
      comment: "Channel through which the spend was transacted (e.g. PO, P-Card, Catalogue) for channel compliance analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of spend posting for trend analysis."
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend in transaction currency. Primary spend-under-management KPI for category and executive reporting."
    - name: "total_spend_amount_usd"
      expr: SUM(CAST(spend_amount_usd AS DOUBLE))
      comment: "Total spend normalised to USD for cross-currency consolidated spend reporting."
    - name: "total_savings_amount"
      expr: SUM(CAST(savings_amount AS DOUBLE))
      comment: "Total procurement savings realised. Core KPI for demonstrating procurement value and ROI to leadership."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price paid across spend records. Tracks price competitiveness and negotiation effectiveness."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on spend records for tax liability and compliance reporting."
    - name: "maverick_spend_amount_usd"
      expr: SUM(CASE WHEN maverick_spend_flag = TRUE THEN CAST(spend_amount_usd AS DOUBLE) ELSE 0 END)
      comment: "Total off-contract (maverick) spend in USD. High maverick spend signals policy non-compliance and lost savings opportunities."
    - name: "maverick_spend_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN maverick_spend_flag = TRUE THEN CAST(spend_amount_usd AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(spend_amount_usd AS DOUBLE)), 0), 2)
      comment: "Percentage of total spend that is off-contract. A leading indicator of procurement compliance risk; target is typically below 5%."
    - name: "savings_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(savings_amount AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount_usd AS DOUBLE)), 0), 2)
      comment: "Savings as a percentage of total spend. Measures procurement effectiveness and negotiation yield."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers in the spend base. Tracks supplier consolidation progress and concentration risk."
    - name: "total_spend_record_count"
      expr: COUNT(1)
      comment: "Total number of spend transactions. Baseline volume metric for spend data completeness and activity level."
    - name: "avg_spend_per_transaction_usd"
      expr: AVG(CAST(spend_amount_usd AS DOUBLE))
      comment: "Average spend per transaction in USD. Low averages may indicate fragmented purchasing that should be consolidated."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs: invoice volumes, payment performance, three-way match rates, and tolerance variances. Used by AP, finance, and procurement to manage supplier payment health and working capital."
  source: "`vibe_manufacturing_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the supplier invoice (e.g. Posted, Blocked, Paid) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g. Standard, Credit Memo, Debit Memo) for invoice mix analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice for cash flow and DPO tracking."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match result (PO / GR / Invoice) — critical for AP compliance and fraud prevention."
    - name: "payment_block_indicator"
      expr: payment_block_indicator
      comment: "Indicates whether the invoice is blocked for payment, used to monitor AP bottlenecks."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organisation for org-level AP performance benchmarking."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group for buyer-level invoice management accountability."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual AP accrual and liability reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for periodic AP close and accrual management."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for trend analysis of AP volumes and payment cycles."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (e.g. ACH, Wire, Cheque) for payment channel optimisation."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for DPO calculation and early payment discount analysis."
    - name: "tolerance_check_status"
      expr: tolerance_check_status
      comment: "Result of tolerance check on invoice vs PO price/quantity for exception management."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices. Baseline AP volume KPI."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount. Primary AP liability KPI for cash flow forecasting and balance sheet reporting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount (excluding tax and discounts). Used for clean spend and budget reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on supplier invoices for tax liability reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimisation from discount programmes."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges on supplier invoices. Tracks logistics cost embedded in AP for freight cost management."
    - name: "total_tolerance_variance_amount"
      expr: SUM(CAST(tolerance_variance_amount AS DOUBLE))
      comment: "Total monetary variance between invoiced and PO amounts. High variance signals pricing disputes or data quality issues."
    - name: "avg_tolerance_variance_pct"
      expr: AVG(CAST(tolerance_variance_percentage AS DOUBLE))
      comment: "Average invoice tolerance variance percentage. Measures invoice accuracy and supplier billing compliance."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_indicator = TRUE THEN 1 END)
      comment: "Number of invoices blocked for payment. High counts indicate AP processing bottlenecks or supplier disputes."
    - name: "three_way_match_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_way_match_status = 'Matched' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices passing three-way match (PO/GR/Invoice). A core AP quality KPI; low rates drive manual intervention costs and fraud risk."
    - name: "paid_invoice_count"
      expr: COUNT(CASE WHEN payment_status = 'Paid' THEN 1 END)
      comment: "Number of invoices that have been paid. Tracks AP clearance throughput."
    - name: "avg_gross_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount. Tracks invoice size trends and identifies anomalies in billing patterns."
    - name: "withholding_tax_total"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted on supplier invoices. Required for tax compliance and statutory reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs: contract coverage, value under management, compliance posture, and renewal risk. Used by category managers and CPO to manage contract lifecycle and mitigate supply risk."
  source: "`vibe_manufacturing_v1`.`procurement`.`procurement_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Lifecycle status of the contract (e.g. Active, Expired, Draft) for portfolio health monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of procurement contract (e.g. Framework, Blanket, Fixed Price) for contract mix analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the contract for regulatory and policy adherence tracking."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the contract auto-renews. Used to manage renewal risk and avoid unintended commitments."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency portfolio valuation."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organisation responsible for the contract."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group managing the contract."
    - name: "material_category"
      expr: material_category
      comment: "Material category covered by the contract for category-level coverage analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the contract became effective for contract start trend analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the contract expires for renewal pipeline management."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms on the contract for logistics cost allocation."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for working capital and DPO analysis."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of procurement contracts in the portfolio. Baseline contract management KPI."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all contracts under management. Primary contract portfolio KPI for CPO and finance reporting."
    - name: "total_remaining_value"
      expr: SUM(CAST(remaining_value AS DOUBLE))
      comment: "Total remaining uncommitted contract value. Measures available contract capacity and release opportunity."
    - name: "total_release_value"
      expr: SUM(CAST(release_value AS DOUBLE))
      comment: "Total value released against contracts. Tracks contract utilisation and spend-against-contract performance."
    - name: "contract_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(release_value AS DOUBLE)) / NULLIF(SUM(CAST(total_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total contract value that has been released/consumed. Low utilisation may indicate over-contracting or demand shortfalls."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value. Tracks deal size trends and negotiation scale."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active contracts. Core contract portfolio health metric."
    - name: "expiring_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' AND expiration_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of active contracts expiring within 90 days. Drives renewal prioritisation and supply continuity risk management."
    - name: "non_compliant_contract_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' THEN 1 END)
      comment: "Number of contracts with compliance issues. Tracks regulatory and policy risk in the contract portfolio."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity commitments across contracts. Used for demand planning and commitment risk assessment."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers under contract. Measures contract coverage breadth and supplier consolidation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition pipeline KPIs: requisition volumes, approval cycle efficiency, value under request, and conversion to PO. Used by procurement operations and finance to manage demand-to-order cycle performance."
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the purchase requisition (e.g. Pending, Approved, Rejected, Converted) for pipeline management."
    - name: "pr_type"
      expr: pr_type
      comment: "Type of purchase requisition for demand categorisation."
    - name: "approval_level_required"
      expr: approval_level_required
      comment: "Approval level required for the requisition, used to analyse approval complexity and cycle time."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority of the requisition for urgency-based processing analysis."
    - name: "purchasing_organization_code"
      expr: purchasing_organization_code
      comment: "Purchasing organisation for org-level requisition volume analysis."
    - name: "purchasing_group_code"
      expr: purchasing_group_code
      comment: "Buyer group for buyer-level workload and performance analysis."
    - name: "requestor_department"
      expr: requestor_department
      comment: "Department that raised the requisition for demand-by-department analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the requisition for multi-currency spend pipeline analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the requisition is compliant with procurement policy."
    - name: "pr_date_month"
      expr: DATE_TRUNC('MONTH', pr_date)
      comment: "Month the requisition was raised for demand trend analysis."
    - name: "source_determination_indicator"
      expr: source_determination_indicator
      comment: "Indicates how the source of supply was determined (e.g. automatic, manual) for sourcing efficiency analysis."
  measures:
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions. Baseline demand pipeline volume KPI."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated value of all requisitions. Measures the demand pipeline value entering procurement."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price on requisitions. Tracks price expectations vs actual PO prices for savings identification."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all requisitions. Supports demand planning and inventory replenishment analysis."
    - name: "approved_requisition_count"
      expr: COUNT(CASE WHEN pr_status = 'Approved' THEN 1 END)
      comment: "Number of approved requisitions. Measures approval throughput in the procure-to-pay cycle."
    - name: "rejected_requisition_count"
      expr: COUNT(CASE WHEN pr_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected requisitions. High rejection rates signal poor demand planning or policy non-compliance."
    - name: "requisition_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pr_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions approved. A low rate indicates demand quality issues or overly restrictive approval policies."
    - name: "converted_to_po_count"
      expr: COUNT(CASE WHEN po_number IS NOT NULL AND po_number != '' THEN 1 END)
      comment: "Number of requisitions converted to a purchase order. Measures requisition-to-PO conversion efficiency."
    - name: "pr_to_po_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN po_number IS NOT NULL AND po_number != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions that resulted in a PO. Low conversion rates may indicate sourcing failures or demand cancellations."
    - name: "non_compliant_requisition_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of requisitions flagged as non-compliant. Drives policy enforcement and procurement governance actions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing KPIs: event activity, supplier participation, savings realisation, and award efficiency. Used by category managers and CPO to evaluate sourcing programme effectiveness and competitive bidding outcomes."
  source: "`vibe_manufacturing_v1`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the sourcing event (e.g. Draft, Published, Awarded, Cancelled) for pipeline management."
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (e.g. RFQ, RFP, Auction) for sourcing method mix analysis."
    - name: "award_strategy"
      expr: award_strategy
      comment: "Award strategy applied (e.g. Single Source, Multi-Award) for sourcing strategy effectiveness analysis."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category targeted by the sourcing event for category-level sourcing activity analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organisation running the event for org-level sourcing performance benchmarking."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group managing the event for buyer-level workload analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the sourcing event for multi-currency savings analysis."
    - name: "is_multi_round"
      expr: is_multi_round
      comment: "Indicates whether the event ran multiple bidding rounds, relevant for negotiation complexity analysis."
    - name: "is_sealed_bid"
      expr: is_sealed_bid
      comment: "Indicates whether bids were sealed, relevant for competitive integrity analysis."
    - name: "publish_date_month"
      expr: DATE_TRUNC('MONTH', publish_date)
      comment: "Month the sourcing event was published for sourcing activity trend analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract expected from the sourcing event outcome."
  measures:
    - name: "total_sourcing_event_count"
      expr: COUNT(1)
      comment: "Total number of sourcing events. Baseline KPI for strategic sourcing programme activity."
    - name: "total_estimated_spend"
      expr: SUM(CAST(estimated_spend_amount AS DOUBLE))
      comment: "Total estimated spend under sourcing events. Measures the scale of spend being competitively sourced."
    - name: "total_baseline_spend"
      expr: SUM(CAST(baseline_spend_amount AS DOUBLE))
      comment: "Total baseline spend before sourcing events. Used as the denominator for savings rate calculation."
    - name: "total_actual_savings"
      expr: SUM(CAST(actual_savings_amount AS DOUBLE))
      comment: "Total actual savings realised from sourcing events. Primary ROI KPI for the strategic sourcing programme."
    - name: "total_savings_target"
      expr: SUM(CAST(savings_target_amount AS DOUBLE))
      comment: "Total savings target set for sourcing events. Used to measure savings attainment vs plan."
    - name: "savings_attainment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_savings_amount AS DOUBLE)) / NULLIF(SUM(CAST(savings_target_amount AS DOUBLE)), 0), 2)
      comment: "Actual savings as a percentage of savings target. Measures sourcing programme delivery against plan; below 80% triggers strategic review."
    - name: "avg_actual_savings_pct"
      expr: AVG(CAST(actual_savings_percentage AS DOUBLE))
      comment: "Average savings percentage achieved per sourcing event. Benchmarks negotiation effectiveness across categories."
    - name: "total_awarded_spend"
      expr: SUM(CAST(awarded_spend_amount AS DOUBLE))
      comment: "Total spend awarded through sourcing events. Measures the volume of spend placed under competitive contract."
    - name: "avg_supplier_participation_count"
      expr: AVG(CAST(invited_supplier_count AS DOUBLE))
      comment: "Average number of suppliers invited per sourcing event. Low participation may indicate limited competition and suboptimal pricing."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers engaged across sourcing events. Measures supplier base breadth in competitive sourcing."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt and inbound delivery KPIs: receipt volumes, quantity accuracy, quality inspection outcomes, and reversal rates. Used by procurement operations and supply chain to manage supplier delivery performance."
  source: "`vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (e.g. Posted, Reversed, Pending) for inbound delivery pipeline management."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for received goods. Tracks supplier quality at point of receipt."
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Indicates whether quality inspection was required for the receipt."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type (e.g. 101 GR for PO) for stock movement analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock received (e.g. Unrestricted, Quality Inspection, Blocked) for inventory availability analysis."
    - name: "gr_ir_clearing_status"
      expr: gr_ir_clearing_status
      comment: "GR/IR clearing status for AP reconciliation and accrual management."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Indicates whether received goods were damaged. Tracks supplier packaging and logistics quality."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the goods receipt was reversed. High reversal rates signal receiving errors or supplier disputes."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt for multi-currency inventory valuation."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of delivery for inbound delivery trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of inventory posting for period-end accrual and inventory reporting."
  measures:
    - name: "total_goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts. Baseline inbound delivery volume KPI."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received. Core inbound supply volume KPI for inventory replenishment tracking."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered on the associated POs. Used as denominator for delivery completeness rate."
    - name: "total_goods_receipt_value"
      expr: SUM(CAST(goods_receipt_value AS DOUBLE))
      comment: "Total value of goods received. Used for inventory valuation and GR/IR accrual reporting."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance between ordered and received. Measures supplier delivery accuracy and short-shipment exposure."
    - name: "delivery_completeness_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity actually received. A key supplier delivery performance KPI; below target triggers supplier corrective action."
    - name: "damaged_receipt_count"
      expr: COUNT(CASE WHEN damage_flag = TRUE THEN 1 END)
      comment: "Number of goods receipts with damage reported. Tracks inbound quality and packaging compliance."
    - name: "damaged_receipt_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with damage. High rates indicate supplier packaging or logistics quality issues requiring corrective action."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods receipts that were reversed. High reversal rates signal receiving process errors or supplier disputes."
    - name: "quality_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_inspection_status = 'Passed' THEN 1 END) / NULLIF(COUNT(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of inspected receipts passing quality inspection. Core supplier quality KPI for incoming goods control."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_supplier_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quotation and competitive bidding KPIs: bid volumes, pricing competitiveness, award rates, and compliance. Used by category managers and sourcing teams to evaluate supplier responsiveness and bid quality."
  source: "`vibe_manufacturing_v1`.`procurement`.`supplier_quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Status of the supplier quotation (e.g. Submitted, Awarded, Rejected) for bid pipeline management."
    - name: "award_flag"
      expr: award_flag
      comment: "Indicates whether the quotation was awarded. Used to calculate award rates and competitive win analysis."
    - name: "technical_compliance_flag"
      expr: technical_compliance_flag
      comment: "Indicates technical compliance of the bid. Non-compliant bids are disqualified, affecting competition quality."
    - name: "commercial_compliance_flag"
      expr: commercial_compliance_flag
      comment: "Indicates commercial compliance of the bid for bid qualification analysis."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Indicates environmental compliance of the bid for sustainability sourcing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the quotation for multi-currency price comparison."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the quoted goods for supply chain risk and trade compliance analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms on the quotation for total landed cost comparison."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms offered by the supplier for working capital analysis."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of bid submission for sourcing activity trend analysis."
    - name: "material_group"
      expr: material_group
      comment: "Material group of the quoted item for category-level bid analysis."
  measures:
    - name: "total_quotation_count"
      expr: COUNT(1)
      comment: "Total number of supplier quotations received. Baseline competitive bidding activity KPI."
    - name: "total_quoted_amount"
      expr: SUM(CAST(total_quoted_amount AS DOUBLE))
      comment: "Total value of all supplier quotations. Measures the scale of competitive bids received."
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price across all bids. Benchmarks market pricing and identifies outlier bids."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average bid evaluation score. Measures overall supplier bid quality and competitiveness."
    - name: "avg_total_cost_of_ownership"
      expr: AVG(CAST(total_cost_of_ownership AS DOUBLE))
      comment: "Average total cost of ownership across bids. Enables TCO-based sourcing decisions beyond unit price."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across quotations for tax-inclusive cost analysis."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost quoted by suppliers. Tracks logistics cost component in supplier bids."
    - name: "award_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN award_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotations that were awarded. Low rates may indicate poor supplier fit or overly competitive events."
    - name: "technical_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN technical_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bids meeting technical requirements. Low rates indicate supplier capability gaps or unclear specifications."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount offered by suppliers in quotations. Measures negotiation leverage and supplier pricing flexibility."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers submitting quotations. Measures competitive market depth for the sourcing event."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_approval_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement approval workflow KPIs: approval cycle efficiency, escalation rates, policy compliance, and bottleneck identification. Used by procurement operations and compliance to optimise the approval process and reduce cycle time."
  source: "`vibe_manufacturing_v1`.`procurement`.`approval_workflow`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval workflow (e.g. Pending, Approved, Rejected, Escalated) for pipeline management."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval level required (e.g. L1, L2, L3) for bottleneck analysis by approval tier."
    - name: "approval_action"
      expr: approval_action
      comment: "Action taken on the approval (e.g. Approve, Reject, Delegate) for workflow action analysis."
    - name: "approval_document_type"
      expr: approval_document_type
      comment: "Type of document being approved (e.g. PO, PR, Contract) for approval volume by document type."
    - name: "policy_violation_flag"
      expr: policy_violation_flag
      comment: "Indicates whether the approval involved a policy violation. Key compliance dimension."
    - name: "mandatory_approval_flag"
      expr: mandatory_approval_flag
      comment: "Indicates whether approval was mandatory. Used to prioritise mandatory approval SLA monitoring."
    - name: "parallel_approval_flag"
      expr: parallel_approval_flag
      comment: "Indicates whether parallel approval was used. Parallel approvals typically reduce cycle time."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Result of compliance check during approval for regulatory adherence monitoring."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organisation for org-level approval performance benchmarking."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Buyer group for buyer-level approval workload analysis."
    - name: "approval_request_month"
      expr: DATE_TRUNC('MONTH', approval_request_timestamp)
      comment: "Month the approval was requested for trend analysis of approval volumes."
    - name: "material_category"
      expr: material_category
      comment: "Material category of the document under approval for category-level approval analysis."
  measures:
    - name: "total_approval_count"
      expr: COUNT(1)
      comment: "Total number of approval workflow instances. Baseline approval activity KPI."
    - name: "total_document_amount"
      expr: SUM(CAST(document_total_amount AS DOUBLE))
      comment: "Total value of documents going through the approval workflow. Measures the financial scale of approval activity."
    - name: "avg_approval_duration_hours"
      expr: AVG(CAST(approval_duration_hours AS DOUBLE))
      comment: "Average time to complete an approval in hours. Core cycle time KPI; high values indicate bottlenecks that delay procurement."
    - name: "total_approval_threshold_amount"
      expr: SUM(CAST(approval_threshold_amount AS DOUBLE))
      comment: "Total approval threshold amounts across workflows. Used to assess the financial risk exposure managed through the approval process."
    - name: "policy_violation_count"
      expr: COUNT(CASE WHEN policy_violation_flag = TRUE THEN 1 END)
      comment: "Number of approvals involving policy violations. High counts signal systemic procurement policy non-compliance."
    - name: "policy_violation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN policy_violation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approvals with policy violations. A leading indicator of procurement governance risk; drives policy enforcement actions."
    - name: "approved_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approvals granted. Measures approval throughput."
    - name: "rejected_count"
      expr: COUNT(CASE WHEN approval_status = 'Rejected' THEN 1 END)
      comment: "Number of approvals rejected. High rejection rates may indicate poor requisition quality or overly restrictive policies."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approval requests that were approved. Measures approval process efficiency and demand quality."
    - name: "compliance_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_check_status = 'Passed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approvals passing compliance checks. Measures regulatory adherence in the procurement approval process."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_commodity_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category management KPIs: category portfolio health, contract coverage, preferred supplier penetration, and strategic sourcing priority. Used by category managers and CPO to manage the commodity portfolio and sourcing strategy."
  source: "`vibe_manufacturing_v1`.`procurement`.`commodity_category`"
  dimensions:
    - name: "category_status"
      expr: category_status
      comment: "Status of the commodity category (e.g. Active, Inactive, Under Review) for portfolio health monitoring."
    - name: "category_level"
      expr: category_level
      comment: "Hierarchy level of the category (L1/L2/L3/L4) for drill-down analysis."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification of the category (e.g. Critical, High, Medium, Low) for supply risk management."
    - name: "strategic_sourcing_priority"
      expr: strategic_sourcing_priority
      comment: "Strategic priority level of the category for resource allocation in sourcing programmes."
    - name: "spend_type"
      expr: spend_type
      comment: "Type of spend (e.g. Direct, Indirect, Services) for spend mix analysis."
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy applied to the category (e.g. Single Source, Dual Source, Competitive) for strategy mix analysis."
    - name: "contract_coverage_flag"
      expr: contract_coverage_flag
      comment: "Indicates whether the category has contract coverage. Uncovered categories represent maverick spend risk."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Indicates whether a preferred supplier is designated for the category."
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Indicates whether the category has compliance requirements (e.g. regulatory, environmental)."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Indicates whether environmental compliance is required for the category."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organisation responsible for the category."
    - name: "unspsc_segment"
      expr: unspsc_segment
      comment: "UNSPSC segment classification for industry-standard category benchmarking."
  measures:
    - name: "total_category_count"
      expr: COUNT(1)
      comment: "Total number of commodity categories in the portfolio. Baseline category management KPI."
    - name: "avg_cost_reduction_target_pct"
      expr: AVG(CAST(cost_reduction_target_pct AS DOUBLE))
      comment: "Average cost reduction target across categories. Measures the ambition level of the category management programme."
    - name: "contract_covered_category_count"
      expr: COUNT(CASE WHEN contract_coverage_flag = TRUE THEN 1 END)
      comment: "Number of categories with contract coverage. Measures spend-under-contract breadth."
    - name: "contract_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN contract_coverage_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of categories with contract coverage. A core procurement maturity KPI; higher coverage reduces maverick spend risk."
    - name: "preferred_supplier_category_count"
      expr: COUNT(CASE WHEN preferred_supplier_flag = TRUE THEN 1 END)
      comment: "Number of categories with a designated preferred supplier. Measures supplier rationalisation progress."
    - name: "high_risk_category_count"
      expr: COUNT(CASE WHEN risk_classification IN ('Critical', 'High') THEN 1 END)
      comment: "Number of categories classified as high or critical risk. Drives supply risk mitigation prioritisation."
    - name: "compliance_required_category_count"
      expr: COUNT(CASE WHEN compliance_requirement_flag = TRUE THEN 1 END)
      comment: "Number of categories with mandatory compliance requirements. Used to scope compliance monitoring programmes."
$$;