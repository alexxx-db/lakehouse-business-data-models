-- Metric views for domain: procurement | Business: Construction | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule performance KPIs — tracks on-time delivery, quantity fulfilment, and expediting activity to manage supply chain reliability and project material availability."
  source: "`vibe_construction_v1`.`procurement`.`delivery_schedule`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status (e.g. Scheduled, In Transit, Delivered, Delayed) for supply chain pipeline monitoring."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g. Road, Sea, Air, Rail) for logistics cost and lead-time analysis."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterm governing delivery risk and cost allocation for this schedule line."
    - name: "expedite_flag"
      expr: expedite_flag
      comment: "Flags deliveries under active expediting — a leading indicator of supply chain stress and schedule risk."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether this delivery is on the project critical path — prioritises monitoring of schedule-critical materials."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Flags deliveries requiring pre-receipt inspection — relevant for quality gate planning."
    - name: "required_on_site_date_month"
      expr: DATE_TRUNC('MONTH', required_on_site_date)
      comment: "Month materials are required on site for demand-side delivery planning and look-ahead scheduling."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Coded reason for delivery delay — enables root-cause analysis of supply chain disruptions."
  measures:
    - name: "total_delivery_quantity"
      expr: SUM(CAST(delivery_quantity AS DOUBLE))
      comment: "Total quantity scheduled for delivery — the primary supply chain volume KPI for material availability planning."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total quantity actually received against delivery schedules — measures physical delivery fulfilment."
    - name: "delivery_schedule_count"
      expr: COUNT(1)
      comment: "Total number of delivery schedule lines — baseline supply chain activity volume metric."
    - name: "expedited_delivery_count"
      expr: COUNT(CASE WHEN expedite_flag = TRUE THEN 1 END)
      comment: "Number of deliveries under active expediting — high counts signal systemic supply chain reliability issues."
    - name: "critical_path_delivery_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of critical-path deliveries — measures the volume of schedule-critical supply chain dependencies requiring priority management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt performance KPIs — measures delivery accuracy, rejection rates, and inspection outcomes to manage vendor delivery quality and inventory accuracy."
  source: "`vibe_construction_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection outcome at goods receipt (e.g. Passed, Failed, Pending) for vendor quality tracking."
    - name: "receipt_condition"
      expr: receipt_condition
      comment: "Physical condition of goods on arrival — identifies transit damage and packaging failures."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type code (e.g. 101 Goods Receipt, 122 Return) for stock ledger analysis."
    - name: "delivery_completed_flag"
      expr: delivery_completed_flag
      comment: "Indicates whether the full ordered quantity has been delivered, tracking open delivery obligations."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flags reversed goods receipts, which may indicate posting errors or vendor disputes."
    - name: "invoice_verification_status"
      expr: invoice_verification_status
      comment: "Status of invoice verification against this goods receipt — a key three-way match control point."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of goods receipt posting for trend analysis of inbound material flows."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for received quantities, enabling cross-commodity volume comparisons."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods received — primary inbound supply chain volume KPI."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across receipts — denominator for delivery fulfilment rate calculations."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt — a direct measure of vendor delivery quality failure."
    - name: "total_goods_receipt_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of goods received — measures the financial throughput of the inbound supply chain."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price of received goods — benchmarks procurement pricing performance against market rates."
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions — baseline inbound logistics throughput metric."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed goods receipts — high counts indicate posting quality issues or vendor disputes requiring investigation."
    - name: "rejected_receipt_count"
      expr: COUNT(CASE WHEN rejected_quantity > 0 THEN 1 END)
      comment: "Number of receipts with at least one rejected item — measures vendor delivery quality at the transaction level."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_inspection_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection and material release KPIs — tracks inspection outcomes, NCR volumes, and release cycle times to manage material quality gates and vendor compliance."
  source: "`vibe_construction_v1`.`procurement`.`inspection_release`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g. Pending, In Progress, Released, Rejected) for quality gate pipeline monitoring."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection conducted (e.g. Dimensional, Visual, NDT, FAT) for quality programme analysis."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the inspection (e.g. Pass, Fail, Conditional Release) — the primary quality gate KPI."
    - name: "document_review_status"
      expr: document_review_status
      comment: "Status of document review associated with the inspection — tracks completeness of quality documentation."
    - name: "inspection_witness_required"
      expr: inspection_witness_required
      comment: "Indicates whether a third-party witness is required — relevant for high-criticality material inspections."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for trend analysis of quality gate activity volumes."
    - name: "inspector_organization"
      expr: inspector_organization
      comment: "Organisation conducting the inspection (e.g. Third-Party, Client, Internal) for inspection programme governance."
  measures:
    - name: "inspection_release_count"
      expr: COUNT(1)
      comment: "Total number of inspection release records — baseline quality gate activity volume metric."
    - name: "passed_inspection_count"
      expr: COUNT(CASE WHEN inspection_result = 'Pass' THEN 1 END)
      comment: "Number of inspections with a passing result — measures the quality acceptance rate of procured materials."
    - name: "failed_inspection_count"
      expr: COUNT(CASE WHEN inspection_result = 'Fail' THEN 1 END)
      comment: "Number of failed inspections — a direct measure of vendor quality non-conformance requiring corrective action."
    - name: "witness_required_count"
      expr: COUNT(CASE WHEN inspection_witness_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring third-party witness — measures the volume of high-criticality quality hold points."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_po_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks purchase order amendment activity to quantify scope creep, budget impact, and schedule disruption across the procurement portfolio."
  source: "`vibe_construction_v1`.`procurement`.`po_amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Pending, Approved, Rejected) for pipeline monitoring."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Category of amendment (e.g. Price, Scope, Delivery Date) for root-cause analysis of PO changes."
    - name: "amendment_reason"
      expr: amendment_reason
      comment: "Business reason driving the amendment — identifies systemic procurement planning weaknesses."
    - name: "budget_impact_flag"
      expr: budget_impact_flag
      comment: "Flags amendments that have a direct budget impact, enabling prioritised review of cost-affecting changes."
    - name: "client_approval_required"
      expr: client_approval_required
      comment: "Indicates whether client sign-off is required, highlighting amendments that may delay project execution."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency amendment value reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the amendment became effective, enabling trend analysis of change activity over time."
    - name: "wbs_element"
      expr: wbs_element
      comment: "WBS element linking amendment cost impact to project cost structure."
  measures:
    - name: "total_value_delta"
      expr: SUM(CAST(value_delta AS DOUBLE))
      comment: "Net monetary change introduced by amendments — the primary KPI for quantifying procurement scope creep and cost growth."
    - name: "total_amended_po_value"
      expr: SUM(CAST(amended_po_value AS DOUBLE))
      comment: "Sum of revised PO values post-amendment, representing the updated committed spend position."
    - name: "total_original_po_value"
      expr: SUM(CAST(original_po_value AS DOUBLE))
      comment: "Sum of original PO values before amendments, used as the baseline for cost-growth calculations."
    - name: "amendment_count"
      expr: COUNT(1)
      comment: "Total number of amendments issued — high counts signal procurement instability and poor initial scope definition."
    - name: "budget_impacting_amendment_count"
      expr: COUNT(CASE WHEN budget_impact_flag = TRUE THEN 1 END)
      comment: "Number of amendments with direct budget impact — a leading indicator of cost overrun risk."
    - name: "avg_value_delta"
      expr: AVG(CAST(value_delta AS DOUBLE))
      comment: "Average monetary change per amendment — benchmarks the materiality of individual scope changes."
    - name: "total_amended_quantity"
      expr: SUM(CAST(amended_quantity AS DOUBLE))
      comment: "Total quantity change across amendments — tracks volume adjustments separate from price changes."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order line-item KPIs — tracks ordered quantities, delivery performance, invoicing progress, and outstanding obligations at the line level for granular spend management."
  source: "`vibe_construction_v1`.`procurement`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the PO line (e.g. Open, Partially Delivered, Closed) for open-order liability management."
    - name: "item_category"
      expr: item_category
      comment: "Item category classification (e.g. Standard, Service, Consignment) for spend category analysis."
    - name: "material_group"
      expr: material_group
      comment: "Material group for commodity-level spend analysis and category management."
    - name: "currency_code"
      expr: currency_code
      comment: "Line-item currency for multi-currency spend reporting."
    - name: "goods_receipt_indicator"
      expr: goods_receipt_indicator
      comment: "Indicates whether goods receipt is required for this line — a three-way match control flag."
    - name: "invoice_receipt_indicator"
      expr: invoice_receipt_indicator
      comment: "Indicates whether invoice receipt is required — relevant for service-based PO line payment controls."
    - name: "deletion_indicator"
      expr: deletion_indicator
      comment: "Flags deleted PO lines — used to exclude cancelled items from active spend reporting."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of scheduled delivery for demand-side material availability planning."
    - name: "wbs_element"
      expr: wbs_element
      comment: "WBS element linking PO line spend to project cost structure."
  measures:
    - name: "total_net_value"
      expr: SUM(CAST(net_value AS DOUBLE))
      comment: "Total net value of PO lines — the primary committed spend KPI at the line-item level."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across PO lines — baseline procurement volume metric."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total quantity received against PO lines — measures physical delivery fulfilment progress."
    - name: "total_invoiced_quantity"
      expr: SUM(CAST(invoiced_quantity AS DOUBLE))
      comment: "Total quantity invoiced against PO lines — measures AP processing progress relative to delivery."
    - name: "total_outstanding_quantity"
      expr: SUM(CAST(outstanding_quantity AS DOUBLE))
      comment: "Total outstanding quantity yet to be delivered — measures open procurement obligations and supply chain exposure."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across PO lines — required for tax compliance reporting and reclaim calculations."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines — benchmarks procurement pricing performance and identifies price outliers."
    - name: "po_line_count"
      expr: COUNT(1)
      comment: "Total number of PO lines — baseline procurement transaction volume metric."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_bid`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid evaluation and award KPIs — tracks bid competitiveness, evaluation scores, and award outcomes to optimise vendor selection and competitive tendering effectiveness."
  source: "`vibe_construction_v1`.`procurement`.`procurement_bid`"
  dimensions:
    - name: "bid_status"
      expr: bid_status
      comment: "Current status of the bid (e.g. Submitted, Under Evaluation, Awarded, Rejected) for evaluation pipeline monitoring."
    - name: "is_awarded"
      expr: is_awarded
      comment: "Indicates whether this bid was selected for award — the primary bid outcome dimension."
    - name: "is_compliant"
      expr: is_compliant
      comment: "Indicates whether the bid met all compliance requirements — filters non-compliant bids from award consideration."
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the bid (e.g. Portal, Email, Hard Copy) for process standardisation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Bid currency for multi-currency evaluation and award value reporting."
    - name: "bid_date_month"
      expr: DATE_TRUNC('MONTH', bid_date)
      comment: "Month the bid was submitted for trend analysis of tendering activity."
    - name: "award_recommendation"
      expr: award_recommendation
      comment: "Evaluator's award recommendation for the bid — tracks alignment between recommendation and final award decision."
  measures:
    - name: "total_bid_amount"
      expr: SUM(CAST(total_bid_amount AS DOUBLE))
      comment: "Total value of all bids received — measures the aggregate competitive market response to procurement tenders."
    - name: "avg_bid_amount"
      expr: AVG(CAST(total_bid_amount AS DOUBLE))
      comment: "Average bid amount — benchmarks market pricing and identifies outlier bids for commercial scrutiny."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average overall evaluation score across bids — measures the quality of the vendor pool responding to tenders."
    - name: "avg_technical_score"
      expr: AVG(CAST(technical_score AS DOUBLE))
      comment: "Average technical evaluation score — assesses the technical capability of bidding vendors."
    - name: "avg_commercial_score"
      expr: AVG(CAST(commercial_score AS DOUBLE))
      comment: "Average commercial evaluation score — measures the commercial competitiveness of received bids."
    - name: "bid_count"
      expr: COUNT(1)
      comment: "Total number of bids received — measures market engagement and competitive tension in the tendering process."
    - name: "compliant_bid_count"
      expr: COUNT(CASE WHEN is_compliant = TRUE THEN 1 END)
      comment: "Number of compliant bids — measures the quality of vendor responses and effectiveness of pre-qualification controls."
    - name: "awarded_bid_count"
      expr: COUNT(CASE WHEN is_awarded = TRUE THEN 1 END)
      comment: "Number of bids that were awarded — baseline award activity metric for sourcing pipeline reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_framework_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Framework agreement utilisation and value KPIs — tracks spend commitment, utilisation rates, and agreement health to maximise the value of long-term vendor partnerships."
  source: "`vibe_construction_v1`.`procurement`.`procurement_framework_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the framework agreement (e.g. Active, Expired, Terminated) for portfolio health monitoring."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of framework agreement (e.g. Supply, Service, Blanket Order) for category-specific performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Agreement currency for multi-currency commitment and spend reporting."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews — relevant for contract management and budget planning."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Indicates whether a performance bond is required — a risk management control for high-value agreements."
    - name: "commodity_category_code"
      expr: commodity_category_code
      comment: "Commodity category for spend analysis by procurement category."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the agreement became effective for cohort analysis of framework agreement portfolio vintage."
  measures:
    - name: "total_maximum_commitment_value"
      expr: SUM(CAST(maximum_commitment_value AS DOUBLE))
      comment: "Total maximum commitment value across all framework agreements — the ceiling of spend authorised under framework arrangements."
    - name: "total_spend_to_date"
      expr: SUM(CAST(total_spend_to_date AS DOUBLE))
      comment: "Total spend consumed against framework agreements — the primary utilisation KPI for framework agreement management."
    - name: "avg_performance_bond_percentage"
      expr: AVG(CAST(performance_bond_percentage AS DOUBLE))
      comment: "Average performance bond percentage across agreements — benchmarks risk mitigation levels in framework contracting."
    - name: "framework_agreement_count"
      expr: COUNT(1)
      comment: "Total number of framework agreements — measures the scale of the organisation's strategic vendor partnership programme."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity commitments across agreements — measures the organisation's take-or-pay obligations."
    - name: "total_maximum_order_quantity"
      expr: SUM(CAST(maximum_order_quantity AS DOUBLE))
      comment: "Total maximum order quantity ceilings across agreements — measures the upper bound of supply capacity secured."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order portfolio management — tracks committed spend, amendment activity, retention exposure, and tax burden across the procurement pipeline."
  source: "`vibe_construction_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Draft, Approved, Closed) for pipeline segmentation."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Blanket, Framework) for spend category analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend reporting and FX exposure analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g. Net 30, Net 60) driving cash-flow forecasting."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing delivery risk and cost allocation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state of the PO, used to identify bottlenecks in the approval pipeline."
    - name: "gmp_flag"
      expr: gmp_flag
      comment: "Indicates whether the PO is subject to a Guaranteed Maximum Price ceiling."
    - name: "issued_date_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the PO was issued, enabling trend analysis of procurement activity over time."
    - name: "wbs_element"
      expr: wbs_element
      comment: "Work Breakdown Structure element linking PO spend to project cost structure."
  measures:
    - name: "total_po_value"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total committed spend across all purchase orders — primary procurement spend KPI for executive dashboards."
    - name: "total_original_po_value"
      expr: SUM(CAST(original_po_value AS DOUBLE))
      comment: "Sum of original PO values before amendments, used to quantify scope growth when compared to total_po_value."
    - name: "total_cumulative_amendment_value"
      expr: SUM(CAST(cumulative_amendment_value AS DOUBLE))
      comment: "Total value added through amendments across all POs — signals scope creep and change-order exposure."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Aggregate retention withheld from vendors — a cash-flow liability that must be released upon project completion."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax burden across the PO portfolio, relevant for tax planning and compliance reporting."
    - name: "total_gmp_amount"
      expr: SUM(CAST(gmp_amount AS DOUBLE))
      comment: "Sum of Guaranteed Maximum Price ceilings across GMP-type POs — caps the organisation's maximum cost exposure."
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — baseline volume metric for procurement throughput analysis."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value — benchmarks deal size and identifies outlier POs requiring additional scrutiny."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention rate applied across POs — informs vendor cash-flow impact and contract negotiation benchmarks."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition pipeline KPIs — tracks demand origination, budget availability, conversion rates, and cost estimation accuracy to manage procurement demand planning."
  source: "`vibe_construction_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the purchase requisition (e.g. Draft, Approved, Converted, Rejected) for demand pipeline monitoring."
    - name: "pr_type"
      expr: pr_type
      comment: "Type of requisition (e.g. Material, Service, Capital) for spend category demand analysis."
    - name: "urgency_classification"
      expr: urgency_classification
      comment: "Urgency level of the requisition (e.g. Routine, Urgent, Emergency) for procurement prioritisation."
    - name: "budget_available_flag"
      expr: budget_available_flag
      comment: "Indicates whether budget is available for the requisition — a critical approval gate for cost control."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of requisition conversion to a purchase order — measures procurement pipeline throughput."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department originating the requisition for departmental spend demand analysis."
    - name: "procurement_strategy"
      expr: procurement_strategy
      comment: "Sourcing strategy selected for the requisition (e.g. Competitive Bid, Single Source, Framework) for strategy mix analysis."
    - name: "requisition_date_month"
      expr: DATE_TRUNC('MONTH', requisition_date)
      comment: "Month the requisition was raised for trend analysis of procurement demand volumes."
    - name: "wbs_element"
      expr: wbs_element
      comment: "WBS element linking requisition demand to project cost structure."
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of all purchase requisitions — the primary demand-side spend forecast KPI."
    - name: "total_budget_variance_amount"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance across requisitions — measures the gap between requisitioned spend and available budget."
    - name: "avg_estimated_unit_cost"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost across requisitions — benchmarks pricing assumptions in demand planning."
    - name: "avg_estimated_total_cost"
      expr: AVG(CAST(estimated_total_cost AS DOUBLE))
      comment: "Average total estimated cost per requisition — benchmarks requisition size for procurement resource planning."
    - name: "requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions raised — baseline procurement demand volume metric."
    - name: "budget_available_count"
      expr: COUNT(CASE WHEN budget_available_flag = TRUE THEN 1 END)
      comment: "Number of requisitions with confirmed budget availability — measures the proportion of demand that is funded and ready to procure."
    - name: "converted_requisition_count"
      expr: COUNT(CASE WHEN conversion_status = 'Converted' THEN 1 END)
      comment: "Number of requisitions successfully converted to purchase orders — measures procurement pipeline conversion effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ (Request for Quotation) process KPIs — measures sourcing cycle efficiency, award values, and vendor engagement to optimise the competitive tendering process."
  source: "`vibe_construction_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g. Draft, Issued, Closed, Awarded) for pipeline stage analysis."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g. Open, Selective, Single Source) for sourcing strategy performance analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Intended contract type for the award (e.g. Lump Sum, Reimbursable) for commercial strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "RFQ currency for multi-currency award value reporting."
    - name: "bid_bond_required"
      expr: bid_bond_required
      comment: "Indicates whether a bid bond was required — a risk management control for high-value procurements."
    - name: "vendor_prequalification_required"
      expr: vendor_prequalification_required
      comment: "Flags RFQs requiring vendor prequalification — measures the organisation's use of quality gates in sourcing."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the RFQ was issued for trend analysis of sourcing activity volumes."
    - name: "issuing_department"
      expr: issuing_department
      comment: "Department that issued the RFQ for departmental procurement activity analysis."
  measures:
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total value awarded through RFQ processes — the primary sourcing outcome KPI measuring procurement throughput value."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value required across RFQs — measures financial risk controls applied in the tendering process."
    - name: "total_retention_percentage"
      expr: SUM(CAST(retention_percentage AS DOUBLE))
      comment: "Sum of retention percentages across RFQs — used to calculate average retention terms in conjunction with rfq_count."
    - name: "avg_awarded_amount"
      expr: AVG(CAST(awarded_amount AS DOUBLE))
      comment: "Average award value per RFQ — benchmarks deal size and identifies outlier procurements requiring additional governance."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage applied in RFQ awards — informs vendor cash-flow impact and contract negotiation benchmarks."
    - name: "rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued — baseline sourcing activity volume metric."
    - name: "awarded_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Awarded' THEN 1 END)
      comment: "Number of RFQs that resulted in an award — measures sourcing process completion rate and pipeline conversion."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_sourcing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing plan pipeline KPIs — tracks planned procurement value, long-lead item exposure, and critical-path sourcing activity to support project procurement schedule management."
  source: "`vibe_construction_v1`.`procurement`.`sourcing_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the sourcing plan (e.g. Draft, Approved, In Execution, Closed) for procurement pipeline monitoring."
    - name: "sourcing_method"
      expr: sourcing_method
      comment: "Sourcing strategy selected (e.g. Competitive Bid, Single Source, Framework) for strategy mix analysis."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Commodity or service category for category-level sourcing pipeline analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Intended contract type (e.g. Lump Sum, Reimbursable, Unit Rate) for commercial strategy analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates whether this sourcing plan item is on the project critical path — prioritises procurement management attention."
    - name: "is_long_lead_item"
      expr: is_long_lead_item
      comment: "Flags long-lead items requiring early procurement action to protect project schedule."
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification of the sourcing plan item (e.g. High, Medium, Low) for procurement risk management."
    - name: "currency_code"
      expr: currency_code
      comment: "Plan currency for multi-currency procurement budget reporting."
    - name: "planned_award_date_month"
      expr: DATE_TRUNC('MONTH', planned_award_date)
      comment: "Month planned for contract award — enables procurement schedule look-ahead and resource planning."
  measures:
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated procurement value across all sourcing plans — the primary procurement budget demand KPI."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per sourcing plan item — benchmarks deal size for procurement resource allocation."
    - name: "sourcing_plan_count"
      expr: COUNT(1)
      comment: "Total number of sourcing plan items — baseline procurement pipeline volume metric."
    - name: "critical_path_item_count"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of critical-path sourcing items — measures the volume of schedule-critical procurements requiring priority management."
    - name: "long_lead_item_count"
      expr: COUNT(CASE WHEN is_long_lead_item = TRUE THEN 1 END)
      comment: "Number of long-lead items in the sourcing pipeline — a leading indicator of schedule risk from procurement delays."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage planned across sourcing items — informs vendor cash-flow impact in contract negotiations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs — profiles the approved vendor base by financial capacity, diversity classification, and qualification standing to support strategic supplier relationship management."
  source: "`vibe_construction_v1`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current status of the vendor (e.g. Active, Suspended, Blocked) — the primary AVL eligibility dimension."
    - name: "classification"
      expr: classification
      comment: "Vendor classification tier (e.g. Preferred, Approved, Conditional) for tiered sourcing strategy management."
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Diversity category (e.g. Minority-Owned, Women-Owned, Indigenous) for supply chain diversity reporting and compliance."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates preferred vendor status — drives sourcing prioritisation and framework agreement utilisation."
    - name: "country_code"
      expr: country_code
      comment: "Vendor country of registration for geographic supply chain risk and local content analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Standard payment terms code for the vendor — informs cash-flow forecasting and working capital management."
    - name: "credit_rating"
      expr: credit_rating
      comment: "External credit rating of the vendor — a financial risk indicator for high-value contract awards."
    - name: "registration_date_year"
      expr: DATE_TRUNC('YEAR', registration_date)
      comment: "Year of vendor registration for cohort analysis of vendor base growth and tenure."
  measures:
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue_amount AS DOUBLE))
      comment: "Total annual revenue across the vendor base — measures the aggregate financial scale of the supply chain."
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue_amount AS DOUBLE))
      comment: "Average vendor annual revenue — benchmarks the financial scale of vendors in the approved pool."
    - name: "total_bonding_capacity"
      expr: SUM(CAST(bonding_capacity_amount AS DOUBLE))
      comment: "Total bonding capacity across all active vendors — measures the organisation's maximum aggregate procurement capacity."
    - name: "avg_prequalification_score"
      expr: AVG(CAST(prequalification_score AS DOUBLE))
      comment: "Average prequalification score across vendors — the headline vendor quality benchmark for the approved vendor pool."
    - name: "vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the master register — measures the breadth of the supply chain."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN preferred_vendor_flag = TRUE THEN 1 END)
      comment: "Number of preferred vendors — measures the concentration of strategic supplier relationships."
    - name: "suspended_vendor_count"
      expr: COUNT(CASE WHEN vendor_status = 'Suspended' THEN 1 END)
      comment: "Number of suspended vendors — a supply chain risk indicator requiring active management and alternative sourcing."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard KPIs — aggregates quality, HSE, commercial, and technical scores to support approved vendor list management and strategic sourcing decisions."
  source: "`vibe_construction_v1`.`procurement`.`vendor_evaluation`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation conducted (e.g. Annual, Post-Project, Qualification) for performance trend segmentation."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation record (e.g. Draft, Completed, Approved) for workflow monitoring."
    - name: "performance_grade"
      expr: performance_grade
      comment: "Overall performance grade assigned to the vendor (e.g. A, B, C, D) for AVL tier management."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Vendor qualification standing resulting from the evaluation — drives bid invitation eligibility."
    - name: "bid_invitation_eligible_flag"
      expr: bid_invitation_eligible_flag
      comment: "Indicates whether the vendor is eligible for future bid invitations based on evaluation outcome."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Flags vendors requiring corrective action plans — a leading indicator of supply chain risk."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of evaluation for trend analysis of vendor performance over time."
  measures:
    - name: "avg_overall_kpi_rating"
      expr: AVG(CAST(overall_kpi_rating AS DOUBLE))
      comment: "Average overall KPI rating across evaluated vendors — the headline vendor performance score for executive reporting."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate across vendors — measures the proportion of delivered work meeting quality standards."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate — a critical supply chain reliability KPI directly impacting project schedule performance."
    - name: "avg_hse_rating_score"
      expr: AVG(CAST(hse_rating_score AS DOUBLE))
      comment: "Average HSE performance score across vendors — a mandatory safety governance KPI for contractor management."
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score — informs sourcing strategy and vendor development investment decisions."
    - name: "avg_commercial_compliance_score"
      expr: AVG(CAST(commercial_compliance_score AS DOUBLE))
      comment: "Average commercial compliance score — measures vendor adherence to contractual commercial obligations."
    - name: "avg_financial_health_score"
      expr: AVG(CAST(financial_health_score AS DOUBLE))
      comment: "Average financial health score — a risk indicator for vendor insolvency and supply chain continuity."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of evaluations triggering corrective action requirements — quantifies the scale of vendor performance remediation needed."
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Total number of vendor evaluations completed — measures the organisation's vendor governance programme activity."
    - name: "avg_bonding_limit_amount"
      expr: AVG(CAST(bonding_limit_amount AS DOUBLE))
      comment: "Average bonding capacity limit across evaluated vendors — informs maximum contract value that can be safely awarded to each vendor tier."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs — monitors invoice volumes, payment performance, dispute rates, and retention liabilities to manage vendor cash-flow obligations."
  source: "`vibe_construction_v1`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (e.g. Received, Approved, Paid, Disputed) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of invoice type (e.g. Standard, Credit Note, Advance) for payment categorisation."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP reporting and FX exposure tracking."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms governing due-date calculation and early-payment discount eligibility."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g. EFT, Cheque, SWIFT) for treasury and cash management analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO-GR-Invoice three-way match — a critical control gate before payment authorisation."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flags invoices under dispute, enabling targeted resolution workflows and vendor relationship management."
    - name: "verification_status"
      expr: verification_status
      comment: "Invoice verification state in the AP workflow, identifying bottlenecks in the payment process."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for trend analysis of AP volumes and spend patterns."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-close accrual and financial reporting alignment."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual spend reporting and budget vs. actual comparisons."
  measures:
    - name: "total_invoice_gross_amount"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross invoice value — the primary AP liability KPI representing total vendor payment obligations."
    - name: "total_invoice_net_amount"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net invoice value after discounts — the actual cash outflow obligation to vendors."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component across invoices — required for tax compliance reporting and reclaim calculations."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from vendor invoices — a balance sheet liability to be released at project milestones."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment or negotiated discounts captured — measures procurement's ability to optimise payment terms."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted at source — a statutory obligation with direct cash-flow impact."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices processed — baseline AP throughput metric."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices under dispute — high counts signal vendor relationship or contract administration issues."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Average invoice value — benchmarks transaction size and identifies unusually large or small invoices for review."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor qualification and approved vendor list (AVL) KPIs — tracks qualification health, certification compliance, and HSE standing to manage supply chain risk and sourcing eligibility."
  source: "`vibe_construction_v1`.`procurement`.`vendor_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification standing (e.g. Approved, Suspended, Expired) — the primary AVL eligibility dimension."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g. Material Supplier, Subcontractor, Consultant) for category-specific AVL management."
    - name: "qualification_category"
      expr: qualification_category
      comment: "Commodity or service category for which the vendor is qualified — drives sourcing strategy by category."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 quality management certification status — a mandatory qualification criterion for many project categories."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "ISO 14001 environmental management certification status — required for environmentally sensitive project scopes."
    - name: "iso_45001_certified"
      expr: iso_45001_certified
      comment: "ISO 45001 occupational health and safety certification status — a critical HSE governance requirement."
    - name: "hse_performance_rating"
      expr: hse_performance_rating
      comment: "HSE performance rating tier for the vendor — drives bid eligibility and contract award decisions."
    - name: "qualification_expiry_date_month"
      expr: DATE_TRUNC('MONTH', qualification_expiry_date)
      comment: "Month of qualification expiry for proactive renewal management and AVL gap analysis."
  measures:
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score across qualified vendors — benchmarks the technical depth of the approved vendor pool."
    - name: "avg_past_performance_score"
      expr: AVG(CAST(past_performance_score AS DOUBLE))
      comment: "Average past performance score — a composite historical KPI informing future award decisions."
    - name: "avg_financial_health_score"
      expr: AVG(CAST(financial_health_score AS DOUBLE))
      comment: "Average financial health score — measures the financial resilience of the qualified vendor base."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across qualified vendors — a supply chain reliability benchmark for the AVL."
    - name: "avg_quality_defect_rate"
      expr: AVG(CAST(quality_defect_rate AS DOUBLE))
      comment: "Average quality defect rate — a critical quality governance KPI; high rates trigger AVL suspension reviews."
    - name: "avg_lti_frequency_rate"
      expr: AVG(CAST(lti_frequency_rate AS DOUBLE))
      comment: "Average Lost Time Injury frequency rate across vendors — a mandatory HSE KPI for contractor safety governance."
    - name: "avg_trir_rate"
      expr: AVG(CAST(trir_rate AS DOUBLE))
      comment: "Average Total Recordable Incident Rate — the headline safety performance KPI for vendor qualification decisions."
    - name: "avg_bonding_capacity_limit"
      expr: AVG(CAST(bonding_capacity_limit AS DOUBLE))
      comment: "Average bonding capacity across qualified vendors — informs maximum contract value that can be safely awarded."
    - name: "total_bonding_capacity_limit"
      expr: SUM(CAST(bonding_capacity_limit AS DOUBLE))
      comment: "Total bonding capacity across the qualified vendor pool — measures the organisation's aggregate procurement capacity ceiling."
    - name: "qualification_count"
      expr: COUNT(1)
      comment: "Total number of vendor qualifications on record — measures the breadth of the approved vendor pool."
$$;
