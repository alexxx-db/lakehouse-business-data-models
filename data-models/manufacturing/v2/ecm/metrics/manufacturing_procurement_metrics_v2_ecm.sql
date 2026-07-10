-- Metric views for domain: procurement | Business: Manufacturing | Version: 2 | Generated on: 2026-07-03 05:35:52

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order volume, value, and fulfillment performance. Enables procurement leadership to monitor order pipeline, supplier delivery compliance, and spend commitments."
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g. Open, Closed, Cancelled) for pipeline segmentation."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g. Standard, Blanket, Consignment) for spend categorization."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the order, enabling org-level spend analysis."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group (buyer team) for granular procurement performance tracking."
    - name: "material_category"
      expr: material_category
      comment: "Material category of the primary item on the PO for category spend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend normalization."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms (e.g. DDP, EXW) affecting landed cost and risk allocation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the PO for compliance and workflow monitoring."
    - name: "po_date_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month of PO creation for trend analysis of procurement activity."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Goods receipt status indicating whether ordered goods have been received."
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline volume KPI for procurement activity."
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total committed spend value across all purchase orders. Core spend commitment KPI."
    - name: "total_net_po_value"
      expr: SUM(CAST(net_po_value AS DOUBLE))
      comment: "Total net value of purchase orders excluding tax. Used for budget vs. actuals comparison."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value. Indicates typical transaction size and procurement efficiency."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all purchase orders. Supports tax liability reporting."
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross spend including tax. Full cost commitment view for finance reconciliation."
    - name: "open_po_count"
      expr: COUNT(CASE WHEN po_status = 'Open' THEN 1 END)
      comment: "Number of open purchase orders. Indicates active procurement pipeline requiring management attention."
    - name: "pending_approval_po_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN 1 END)
      comment: "Number of POs awaiting approval. Flags bottlenecks in the procurement approval workflow."
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers on purchase orders. Measures supplier base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_spend_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comprehensive spend analytics KPIs covering total spend, maverick spend, savings realization, and category-level spend distribution. Primary dashboard for CPO and category managers."
  source: "`vibe_manufacturing_v1`.`procurement`.`spend_record`"
  dimensions:
    - name: "spend_type"
      expr: spend_type
      comment: "Type of spend (direct, indirect, services) for strategic spend categorization."
    - name: "spend_category"
      expr: CAST(spend_category AS STRING)
      comment: "Spend category classification for category management analysis."
    - name: "commodity_code_l1"
      expr: commodity_code_l1
      comment: "Top-level commodity code for high-level spend taxonomy reporting."
    - name: "commodity_code_l2"
      expr: commodity_code_l2
      comment: "Second-level commodity code for mid-level category drill-down."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization for org-level spend accountability."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group (buyer team) for granular spend ownership."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or facility where spend was incurred for site-level cost analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the spend record for annual budget vs. actuals tracking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly spend trend analysis."
    - name: "procurement_channel"
      expr: procurement_channel
      comment: "Channel through which procurement was executed (e.g. PO, P-card, contract) for compliance analysis."
    - name: "is_maverick_spend"
      expr: is_maverick_spend
      comment: "Flag indicating off-contract or unauthorized spend for compliance monitoring."
    - name: "supplier_segment"
      expr: supplier_segment
      comment: "Supplier segmentation tier for strategic vs. tactical spend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of spend posting for time-series trend analysis."
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total procurement spend in transaction currency. Primary spend KPI for category and executive reporting."
    - name: "total_spend_amount_usd"
      expr: SUM(CAST(spend_amount_usd AS DOUBLE))
      comment: "Total spend normalized to USD for cross-currency global spend analysis."
    - name: "total_addressable_spend"
      expr: SUM(CAST(addressable_spend_amount AS DOUBLE))
      comment: "Total addressable spend eligible for strategic sourcing. Identifies savings opportunity pool."
    - name: "total_savings_realized"
      expr: SUM(CAST(savings_amount AS DOUBLE))
      comment: "Total procurement savings realized. Core KPI for measuring sourcing effectiveness and cost reduction."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price paid across spend records. Tracks price competitiveness over time."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax incurred on procurement spend for tax liability management."
    - name: "maverick_spend_count"
      expr: COUNT(CASE WHEN is_maverick_spend = TRUE THEN 1 END)
      comment: "Number of maverick (off-contract) spend transactions. Compliance risk indicator."
    - name: "total_transaction_records"
      expr: COUNT(1)
      comment: "Total number of spend records. Baseline volume for spend data completeness assessment."
    - name: "distinct_suppliers_with_spend"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers receiving spend. Measures supplier base concentration."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs covering invoice volumes, payment performance, three-way match rates, and tolerance variances. Critical for AP efficiency and cash flow management."
  source: "`vibe_manufacturing_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the supplier invoice (e.g. Posted, Blocked, Paid) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit memo, debit memo) for invoice mix analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match result (PO/GR/Invoice) — key compliance and payment release indicator."
    - name: "tolerance_check_status"
      expr: tolerance_check_status
      comment: "Tolerance check outcome for price/quantity variance management."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity for which the invoice was posted. Enables entity-level AP reporting."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization associated with the invoice for org-level AP analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant receiving the goods/services on the invoice for site-level cost tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for AP volume and aging trend analysis."
    - name: "material_category"
      expr: material_category
      comment: "Material category on the invoice for category-level AP spend analysis."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of supplier invoices. Baseline AP volume KPI."
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice value. Primary AP liability KPI for cash flow forecasting."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice value excluding tax. Used for cost accrual and budget reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on supplier invoices for tax liability reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures effectiveness of payment terms optimization."
    - name: "total_tolerance_variance_amount"
      expr: SUM(CAST(tolerance_variance_amount AS DOUBLE))
      comment: "Total price/quantity variance within tolerance. Indicates invoice accuracy and supplier billing quality."
    - name: "avg_invoice_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average supplier invoice value. Benchmarks typical transaction size for AP workload planning."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Blocked' THEN 1 END)
      comment: "Number of blocked invoices. Operational KPI for AP exception management and payment delay risk."
    - name: "three_way_match_passed_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'Matched' THEN 1 END)
      comment: "Number of invoices passing three-way match. Measures procurement-to-pay process quality."
    - name: "distinct_suppliers_invoiced"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers submitting invoices. Tracks active supplier billing relationships."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt performance KPIs measuring delivery accuracy, quality inspection outcomes, and receiving efficiency. Enables supply chain and procurement teams to monitor supplier delivery compliance."
  source: "`vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (e.g. Posted, Reversed, Partial) for receiving pipeline management."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Detailed receipt status for granular receiving workflow tracking."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for received goods. Key supplier quality KPI."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type (e.g. 101 GR, 122 Return) for stock movement categorization."
    - name: "plant_code"
      expr: plant_code
      comment: "Receiving plant for site-level delivery performance analysis."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type (unrestricted, quality inspection, blocked) for inventory availability analysis."
    - name: "damage_flag"
      expr: damage_flag
      comment: "Indicates whether received goods were damaged. Supplier quality and logistics risk indicator."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of goods receipt posting for receiving volume trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt value for multi-currency receiving analysis."
  measures:
    - name: "total_goods_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt documents. Baseline receiving activity KPI."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received. Measures inbound supply volume."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered on associated POs. Used to compute delivery fill rate."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt. Supplier quality and incoming inspection KPI."
    - name: "total_quantity_variance"
      expr: SUM(CAST(quantity_variance AS DOUBLE))
      comment: "Total quantity variance (ordered vs. received). Measures supplier delivery accuracy."
    - name: "total_goods_receipt_value"
      expr: SUM(CAST(goods_receipt_value AS DOUBLE))
      comment: "Total value of goods received. Used for GR/IR clearing and accrual management."
    - name: "damaged_receipt_count"
      expr: COUNT(CASE WHEN damage_flag = TRUE THEN 1 END)
      comment: "Number of receipts with damage reported. Supplier and logistics quality risk indicator."
    - name: "reversed_receipt_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed goods receipts. Indicates receiving errors or supplier return activity."
    - name: "quality_inspection_required_count"
      expr: COUNT(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of receipts requiring quality inspection. Drives quality workload planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing performance KPIs measuring savings achievement, supplier participation, and sourcing cycle effectiveness. Primary dashboard for category managers and CPO."
  source: "`vibe_manufacturing_v1`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of the sourcing event (e.g. Draft, Published, Awarded, Closed)."
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (RFQ, RFP, Auction, eRFx) for sourcing method analysis."
    - name: "sourcing_method"
      expr: sourcing_method
      comment: "Sourcing methodology used (competitive bid, negotiation, sole source) for strategy effectiveness."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category being sourced for category-level savings tracking."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization running the event for org-level sourcing performance."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the sourcing event for site-level sourcing activity."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract resulting from the event (frame agreement, spot buy) for contract mix analysis."
    - name: "is_multi_round"
      expr: is_multi_round
      comment: "Whether the event involved multiple bidding rounds. Indicates negotiation complexity."
    - name: "award_date_month"
      expr: DATE_TRUNC('MONTH', award_date)
      comment: "Month of award for sourcing cycle time and savings trend analysis."
  measures:
    - name: "total_sourcing_events"
      expr: COUNT(1)
      comment: "Total number of sourcing events executed. Baseline sourcing activity KPI."
    - name: "total_estimated_spend"
      expr: SUM(CAST(estimated_spend_amount AS DOUBLE))
      comment: "Total estimated spend under management in sourcing events. Measures sourcing coverage."
    - name: "total_baseline_spend"
      expr: SUM(CAST(baseline_spend_amount AS DOUBLE))
      comment: "Total baseline spend before sourcing. Reference point for savings calculation."
    - name: "total_awarded_spend"
      expr: SUM(CAST(awarded_spend_amount AS DOUBLE))
      comment: "Total spend awarded through sourcing events. Measures sourcing throughput."
    - name: "total_actual_savings"
      expr: SUM(CAST(actual_savings_amount AS DOUBLE))
      comment: "Total actual savings achieved through sourcing. Primary CPO performance KPI."
    - name: "total_savings_target"
      expr: SUM(CAST(savings_target_amount AS DOUBLE))
      comment: "Total savings target set for sourcing events. Used to compute savings attainment rate."
    - name: "total_realized_savings"
      expr: SUM(CAST(realized_savings AS DOUBLE))
      comment: "Total realized savings confirmed post-award. Measures savings capture effectiveness."
    - name: "avg_actual_savings_pct"
      expr: AVG(CAST(actual_savings_percentage AS DOUBLE))
      comment: "Average savings percentage achieved per sourcing event. Benchmarks sourcing effectiveness."
    - name: "avg_contract_duration_months"
      expr: AVG(CAST(contract_duration_months AS DOUBLE))
      comment: "Average contract duration resulting from sourcing events. Informs contract portfolio planning."
    - name: "total_awarded_events"
      expr: COUNT(CASE WHEN event_status = 'Awarded' THEN 1 END)
      comment: "Number of sourcing events that resulted in an award. Measures sourcing completion rate."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs covering contract value, coverage, compliance, and lifecycle management. Enables procurement leadership to manage contract risk and maximize contract utilization."
  source: "`vibe_manufacturing_v1`.`procurement`.`procurement_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (Active, Expired, Terminated) for portfolio health monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type (frame agreement, blanket order, spot) for contract mix analysis."
    - name: "material_category"
      expr: material_category
      comment: "Material category covered by the contract for category contract coverage analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization owning the contract for org-level contract portfolio management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Contract compliance status for regulatory and policy adherence monitoring."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the contract auto-renews. Flags contracts requiring proactive renewal management."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency portfolio valuation."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month contract became effective for contract activation trend analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month of contract expiration for renewal pipeline management."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of procurement contracts. Baseline contract portfolio size KPI."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all procurement contracts. Primary contract portfolio value KPI."
    - name: "total_remaining_value"
      expr: SUM(CAST(remaining_value AS DOUBLE))
      comment: "Total remaining uncommitted contract value. Measures available contract capacity."
    - name: "total_release_value"
      expr: SUM(CAST(release_value AS DOUBLE))
      comment: "Total value released against contracts. Measures contract utilization."
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS DOUBLE))
      comment: "Total volume committed under contracts. Supports supply security and demand planning."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value. Benchmarks contract size for portfolio segmentation."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN 1 END)
      comment: "Number of currently active contracts. Measures live contract coverage."
    - name: "expiring_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Expiring' THEN 1 END)
      comment: "Number of contracts nearing expiration. Drives renewal prioritization."
    - name: "distinct_suppliers_under_contract"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with active contracts. Measures contract coverage of supplier base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_supplier_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier bidding and quotation analytics KPIs measuring price competitiveness, award rates, compliance, and total cost of ownership. Enables sourcing teams to evaluate supplier bid quality."
  source: "`vibe_manufacturing_v1`.`procurement`.`supplier_quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Status of the supplier quotation (Submitted, Evaluated, Awarded, Rejected)."
    - name: "is_awarded"
      expr: is_awarded
      comment: "Whether the quotation was awarded. Primary bid outcome dimension."
    - name: "technical_compliance_flag"
      expr: technical_compliance_flag
      comment: "Whether the quotation meets technical requirements. Quality gate for bid evaluation."
    - name: "commercial_compliance_flag"
      expr: commercial_compliance_flag
      comment: "Whether the quotation meets commercial requirements. Compliance gate for bid evaluation."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether the quotation meets environmental requirements. Sustainability sourcing KPI."
    - name: "currency_code"
      expr: currency_code
      comment: "Quotation currency for multi-currency price comparison."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms on the quotation affecting total landed cost."
    - name: "plant_code"
      expr: plant_code
      comment: "Destination plant for the quoted supply for site-level sourcing analysis."
    - name: "quotation_date_month"
      expr: DATE_TRUNC('MONTH', quotation_date)
      comment: "Month of quotation submission for bid activity trend analysis."
  measures:
    - name: "total_quotations"
      expr: COUNT(1)
      comment: "Total number of supplier quotations received. Baseline sourcing market engagement KPI."
    - name: "total_quoted_amount"
      expr: SUM(CAST(total_quoted_amount AS DOUBLE))
      comment: "Total value of all supplier quotations. Measures market response to sourcing events."
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price across all bids. Benchmarks market price for category management."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average supplier evaluation score. Measures overall bid quality and supplier competitiveness."
    - name: "avg_total_cost_of_ownership"
      expr: AVG(CAST(total_cost_of_ownership AS DOUBLE))
      comment: "Average total cost of ownership across quotations. Enables TCO-based sourcing decisions."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost quoted. Identifies logistics cost impact on total procurement cost."
    - name: "awarded_quotation_count"
      expr: COUNT(CASE WHEN is_awarded = TRUE THEN 1 END)
      comment: "Number of quotations that were awarded. Measures sourcing award activity."
    - name: "technically_compliant_count"
      expr: COUNT(CASE WHEN technical_compliance_flag = TRUE THEN 1 END)
      comment: "Number of technically compliant quotations. Measures supplier technical capability in the market."
    - name: "distinct_bidding_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers submitting quotations. Measures competitive market depth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition pipeline KPIs measuring demand capture, approval cycle times, and requisition-to-order conversion. Enables procurement operations to manage demand intake and approval efficiency."
  source: "`vibe_manufacturing_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the purchase requisition (Open, Approved, Converted, Rejected)."
    - name: "pr_type"
      expr: pr_type
      comment: "Type of requisition (standard, service, asset) for demand categorization."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority of the requisition for urgency-based procurement queue management."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant requesting the material or service for site-level demand analysis."
    - name: "purchasing_organization_code"
      expr: purchasing_organization_code
      comment: "Purchasing organization for org-level requisition volume tracking."
    - name: "purchasing_group_code"
      expr: purchasing_group_code
      comment: "Purchasing group for buyer workload and demand management."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the requisition has a compliance requirement. Flags regulated procurement."
    - name: "pr_date_month"
      expr: DATE_TRUNC('MONTH', pr_date)
      comment: "Month of requisition creation for demand trend analysis."
    - name: "requestor_department"
      expr: requestor_department
      comment: "Department originating the requisition for demand attribution and budget management."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions. Baseline procurement demand intake KPI."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated value of all requisitions. Measures uncommitted procurement demand pipeline."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price on requisitions. Benchmarks internal price expectations vs. market."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity requested across all requisitions. Measures demand volume for supply planning."
    - name: "open_requisition_count"
      expr: COUNT(CASE WHEN pr_status = 'Open' THEN 1 END)
      comment: "Number of open requisitions awaiting processing. Measures procurement backlog."
    - name: "rejected_requisition_count"
      expr: COUNT(CASE WHEN pr_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected requisitions. Indicates demand quality and approval policy compliance."
    - name: "converted_to_po_count"
      expr: COUNT(CASE WHEN po_number IS NOT NULL THEN 1 END)
      comment: "Number of requisitions converted to purchase orders. Measures requisition-to-PO conversion rate."
    - name: "distinct_requestor_departments"
      expr: COUNT(DISTINCT requestor_department)
      comment: "Number of distinct departments raising requisitions. Measures procurement demand breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ (Request for Quotation) process KPIs measuring market engagement, bid response rates, and sourcing event effectiveness. Enables category managers to optimize competitive bidding processes."
  source: "`vibe_manufacturing_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current RFQ status (Draft, Issued, Closed, Awarded, Cancelled) for pipeline management."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (open, selective, single source) for sourcing strategy analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RFQ for compliance and governance tracking."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code for category-level RFQ activity analysis."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category for strategic sourcing portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "RFQ currency for multi-currency sourcing analysis."
    - name: "technical_specification_required"
      expr: technical_specification_required
      comment: "Whether technical specs are required. Indicates complexity of the sourcing requirement."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month RFQ was issued for sourcing activity trend analysis."
  measures:
    - name: "total_rfqs"
      expr: COUNT(1)
      comment: "Total number of RFQs issued. Baseline sourcing market engagement KPI."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_total_value AS DOUBLE))
      comment: "Total estimated spend value covered by RFQs. Measures spend under competitive bidding."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per RFQ. Benchmarks typical sourcing event size."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value required. Measures financial commitment required from bidders."
    - name: "awarded_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Awarded' THEN 1 END)
      comment: "Number of RFQs resulting in an award. Measures sourcing completion rate."
    - name: "cancelled_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled RFQs. Indicates sourcing process inefficiency or demand volatility."
    - name: "distinct_commodity_codes"
      expr: COUNT(DISTINCT commodity_code)
      comment: "Number of distinct commodity codes covered by RFQs. Measures sourcing category breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_invoice_line_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level KPIs for three-way match accuracy, price variance analysis, and invoice processing quality. Enables AP teams to identify billing discrepancies and improve invoice accuracy."
  source: "`vibe_manufacturing_v1`.`procurement`.`invoice_line_item`"
  dimensions:
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status at line level (Matched, Price Variance, Quantity Variance) for exception management."
    - name: "verification_status"
      expr: verification_status
      comment: "Invoice line verification status for AP processing workflow tracking."
    - name: "line_type"
      expr: line_type
      comment: "Type of invoice line (material, service, freight) for spend categorization."
    - name: "blocking_reason"
      expr: blocking_reason
      comment: "Reason for invoice line block. Identifies root causes of payment delays."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the invoice line for site-level AP analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice line for tax compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice line currency for multi-currency AP analysis."
    - name: "baseline_date_month"
      expr: DATE_TRUNC('MONTH', baseline_date)
      comment: "Month of baseline date for payment due date trend analysis."
  measures:
    - name: "total_invoice_lines"
      expr: COUNT(1)
      comment: "Total number of invoice line items. Baseline AP processing volume KPI."
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total invoice line amount. Measures AP liability at line level."
    - name: "total_net_line_amount"
      expr: SUM(CAST(net_line_amount AS DOUBLE))
      comment: "Total net invoice line amount excluding tax. Used for cost accrual accuracy."
    - name: "total_price_variance_amount"
      expr: SUM(CAST(price_variance_amount AS DOUBLE))
      comment: "Total price variance between PO price and invoiced price. Measures billing accuracy and supplier compliance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on invoice lines for tax liability reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured on invoice lines. Measures payment terms optimization."
    - name: "avg_price_variance"
      expr: AVG(CAST(price_variance AS DOUBLE))
      comment: "Average price variance per invoice line. Benchmarks supplier billing accuracy."
    - name: "matched_line_count"
      expr: COUNT(CASE WHEN match_status = 'Matched' THEN 1 END)
      comment: "Number of invoice lines passing three-way match. Measures invoice processing quality."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced across all lines. Validates against goods receipt quantities."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_commodity_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category management KPIs covering spend concentration, supplier base, risk profile, and savings targets by commodity category. Enables category managers to prioritize strategic sourcing efforts."
  source: "`vibe_manufacturing_v1`.`procurement`.`commodity_category`"
  dimensions:
    - name: "category_status"
      expr: category_status
      comment: "Status of the commodity category (Active, Under Review, Inactive) for portfolio management."
    - name: "category_level"
      expr: category_level
      comment: "Hierarchy level of the category (L1, L2, L3) for drill-down spend analysis."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Supply risk classification (Critical, High, Medium, Low) for risk-based category prioritization."
    - name: "sourcing_complexity"
      expr: sourcing_complexity
      comment: "Complexity of sourcing the category. Informs resource allocation for category management."
    - name: "unspsc_segment"
      expr: unspsc_segment
      comment: "UNSPSC segment for industry-standard category taxonomy alignment."
    - name: "unspsc_family"
      expr: unspsc_family
      comment: "UNSPSC family for mid-level category taxonomy analysis."
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Whether the category has preferred suppliers. Measures contract coverage maturity."
    - name: "compliance_requirement_flag"
      expr: compliance_requirement_flag
      comment: "Whether the category has compliance requirements. Flags regulated spend categories."
    - name: "last_review_date_month"
      expr: DATE_TRUNC('MONTH', last_review_date)
      comment: "Month of last category review for governance cadence monitoring."
  measures:
    - name: "total_categories"
      expr: COUNT(1)
      comment: "Total number of commodity categories. Baseline category portfolio size KPI."
    - name: "total_annual_spend"
      expr: SUM(CAST(annual_spend_amount AS DOUBLE))
      comment: "Total annual spend across all commodity categories. Primary category spend portfolio KPI."
    - name: "avg_annual_spend_per_category"
      expr: AVG(CAST(annual_spend_amount AS DOUBLE))
      comment: "Average annual spend per category. Benchmarks category spend concentration."
    - name: "total_cost_reduction_target_pct"
      expr: AVG(CAST(cost_reduction_target_pct AS DOUBLE))
      comment: "Average cost reduction target percentage across categories. Measures savings ambition level."
    - name: "total_price_volatility_index"
      expr: AVG(CAST(price_volatility_index AS DOUBLE))
      comment: "Average price volatility index across categories. Identifies high-risk spend categories."
    - name: "high_risk_category_count"
      expr: COUNT(CASE WHEN risk_classification = 'Critical' OR risk_classification = 'High' THEN 1 END)
      comment: "Number of high or critical risk categories. Drives risk mitigation prioritization."
    - name: "categories_with_preferred_suppliers"
      expr: COUNT(CASE WHEN preferred_supplier_flag = TRUE THEN 1 END)
      comment: "Number of categories with preferred suppliers. Measures contract coverage maturity."
    - name: "categories_with_compliance_requirements"
      expr: COUNT(CASE WHEN compliance_requirement_flag = TRUE THEN 1 END)
      comment: "Number of categories with compliance requirements. Measures regulated spend exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_approval_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement approval workflow efficiency KPIs measuring cycle times, escalation rates, policy violations, and approval bottlenecks. Enables process owners to optimize procurement governance."
  source: "`vibe_manufacturing_v1`.`procurement`.`approval_workflow`"
  dimensions:
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status of the approval workflow (Pending, Approved, Rejected, Escalated)."
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of approval workflow (PO, PR, Contract) for process-specific performance analysis."
    - name: "approval_document_type"
      expr: approval_document_type
      comment: "Document type being approved for workflow routing analysis."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval hierarchy level for bottleneck identification."
    - name: "current_stage"
      expr: current_stage
      comment: "Current stage in the approval workflow for pipeline management."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the workflow has been escalated. Key governance risk indicator."
    - name: "policy_violation_flag"
      expr: policy_violation_flag
      comment: "Whether a policy violation was detected. Compliance monitoring KPI."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity for the approval workflow for entity-level governance reporting."
    - name: "approval_request_month"
      expr: DATE_TRUNC('MONTH', approval_request_timestamp)
      comment: "Month of approval request for workflow volume trend analysis."
  measures:
    - name: "total_approval_workflows"
      expr: COUNT(1)
      comment: "Total number of approval workflows initiated. Baseline procurement governance activity KPI."
    - name: "total_document_amount"
      expr: SUM(CAST(document_total_amount AS DOUBLE))
      comment: "Total value of documents under approval. Measures financial exposure in approval pipeline."
    - name: "avg_approval_duration_hours"
      expr: AVG(CAST(approval_duration_hours AS DOUBLE))
      comment: "Average approval cycle time in hours. Primary procurement process efficiency KPI."
    - name: "total_approval_threshold_amount"
      expr: SUM(CAST(approval_threshold_amount AS DOUBLE))
      comment: "Total approval threshold value across workflows. Measures financial authorization exposure."
    - name: "escalated_workflow_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated approval workflows. Indicates approval bottlenecks and governance failures."
    - name: "policy_violation_count"
      expr: COUNT(CASE WHEN policy_violation_flag = TRUE THEN 1 END)
      comment: "Number of workflows with policy violations detected. Measures procurement compliance risk."
    - name: "avg_total_stages"
      expr: AVG(CAST(total_stages AS DOUBLE))
      comment: "Average number of approval stages per workflow. Measures approval process complexity."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN workflow_status = 'Pending' THEN 1 END)
      comment: "Number of workflows currently pending approval. Measures active approval backlog."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`procurement_service_entry_sheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service procurement KPIs measuring service delivery acceptance, invoice verification, and three-way match performance for services. Enables procurement and AP teams to manage service spend quality."
  source: "`vibe_manufacturing_v1`.`procurement`.`service_entry_sheet`"
  dimensions:
    - name: "ses_status"
      expr: ses_status
      comment: "Status of the service entry sheet (Draft, Submitted, Approved, Rejected) for workflow management."
    - name: "ses_type"
      expr: ses_type
      comment: "Type of service entry sheet for service category analysis."
    - name: "service_category"
      expr: service_category
      comment: "Category of service performed for service spend categorization."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status for service invoices. Key AP compliance indicator."
    - name: "acceptance_flag"
      expr: acceptance_flag
      comment: "Whether the service was formally accepted. Measures service delivery confirmation rate."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where service was performed for site-level service spend analysis."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity for the service entry for entity-level service spend reporting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of SES posting for service spend trend analysis."
  measures:
    - name: "total_service_entry_sheets"
      expr: COUNT(1)
      comment: "Total number of service entry sheets. Baseline service procurement activity KPI."
    - name: "total_gross_value"
      expr: SUM(CAST(gross_value AS DOUBLE))
      comment: "Total gross value of services recorded. Primary service spend KPI."
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value of services excluding tax. Used for service cost accrual."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on service entry sheets for tax liability reporting."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity of services formally accepted. Measures service delivery completion."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price for services. Benchmarks service rate competitiveness."
    - name: "accepted_ses_count"
      expr: COUNT(CASE WHEN acceptance_flag = TRUE THEN 1 END)
      comment: "Number of service entry sheets formally accepted. Measures service delivery success rate."
    - name: "distinct_suppliers_for_services"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct service suppliers. Measures service supplier base breadth."
$$;