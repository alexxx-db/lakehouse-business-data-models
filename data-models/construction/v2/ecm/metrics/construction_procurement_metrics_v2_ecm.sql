-- Metric views for domain: procurement | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order portfolio management — tracks committed spend, amendment activity, retention exposure, and tax burden across projects and vendors."
  source: "`vibe_construction_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Draft, Approved, Closed) for pipeline segmentation."
    - name: "po_type"
      expr: po_type
      comment: "Classification of the purchase order type (e.g. Standard, Framework Call-Off, Subcontract) for spend categorisation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend analysis and FX exposure reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g. Net 30, Net 60) for cash-flow forecasting."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing delivery risk and cost allocation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow state of the PO for bottleneck and compliance monitoring."
    - name: "gmp_flag"
      expr: gmp_flag
      comment: "Indicates whether the PO is subject to a Guaranteed Maximum Price arrangement."
    - name: "issued_date_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the PO was issued, for trend analysis of procurement activity."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "FK to the construction project — enables project-level spend drill-down."
  measures:
    - name: "total_po_value_sum"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total committed spend across all purchase orders. Core procurement spend KPI used in budget vs. commitment reporting."
    - name: "original_po_value_sum"
      expr: SUM(CAST(original_po_value AS DOUBLE))
      comment: "Sum of original (pre-amendment) PO values. Compared against total_po_value_sum to quantify scope growth."
    - name: "cumulative_amendment_value_sum"
      expr: SUM(CAST(cumulative_amendment_value AS DOUBLE))
      comment: "Total value added through amendments across all POs. High values signal scope creep or poor initial scoping."
    - name: "retention_amount_sum"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld from vendors. Tracks cash held back pending satisfactory completion — a key cash-flow lever."
    - name: "tax_amount_sum"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across the PO portfolio. Used for VAT/GST reclaim and tax compliance reporting."
    - name: "gmp_amount_sum"
      expr: SUM(CAST(gmp_amount AS DOUBLE))
      comment: "Total value of POs under Guaranteed Maximum Price arrangements. Tracks GMP exposure for risk management."
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders. Baseline volume metric for procurement workload and throughput analysis."
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average PO value. Indicates typical transaction size; sharp changes signal procurement strategy shifts."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention rate applied across POs. Benchmarks against contract terms to detect non-standard retention practices."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with active POs. Measures supply base breadth and single-source dependency risk."
    - name: "distinct_project_count"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with purchase orders. Indicates procurement spread across the project portfolio."
    - name: "amendment_rate"
      expr: ROUND(100.0 * SUM(CAST(cumulative_amendment_value AS DOUBLE)) / NULLIF(SUM(CAST(original_po_value AS DOUBLE)), 0), 2)
      comment: "Percentage by which PO values have grown through amendments vs. original value. A leading indicator of scope management effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts-payable and invoice processing KPIs — tracks invoice volumes, payment performance, dispute rates, retention, and tax across vendors and projects."
  source: "`vibe_construction_v1`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (e.g. Received, Approved, Paid, Disputed) for AP pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of invoice type (e.g. Progress, Final, Advance) for payment category analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP exposure reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g. EFT, Cheque, SWIFT) for treasury and cash management analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms governing due dates for DPO and cash-flow analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO/GR/Invoice three-way match — critical for AP automation and fraud prevention."
    - name: "verification_status"
      expr: verification_status
      comment: "Invoice verification state for compliance and audit trail reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute — used to segment disputed vs. clean invoice populations."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-close accrual and financial reporting alignment."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for trend analysis of AP volumes and spend."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "FK to construction project for project-level cost accrual and AP reporting."
  measures:
    - name: "invoice_gross_amount_sum"
      expr: SUM(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Total gross invoice value processed. Primary AP spend KPI for cash-flow forecasting and budget consumption tracking."
    - name: "invoice_net_amount_sum"
      expr: SUM(CAST(invoice_net_amount AS DOUBLE))
      comment: "Total net invoice value after discounts. Used for actual cost recognition in project accounting."
    - name: "tax_amount_sum"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across invoices. Supports VAT/GST reclaim and tax compliance reporting."
    - name: "retention_amount_sum"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld on invoices. Tracks cash held back from vendors pending project completion milestones."
    - name: "discount_amount_sum"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured. Measures treasury efficiency in leveraging payment terms."
    - name: "withholding_tax_amount_sum"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted. Required for tax authority reporting and vendor remittance reconciliation."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices processed. Baseline AP throughput metric for workload and automation benchmarking."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute. High counts indicate vendor relationship or quality issues requiring intervention."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices in dispute. A key vendor management KPI — elevated rates signal systemic procurement or quality problems."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(invoice_gross_amount AS DOUBLE))
      comment: "Average gross invoice value. Tracks typical transaction size; useful for AP staffing and automation threshold setting."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors invoicing in the period. Measures active supply base size for vendor management."
    - name: "three_way_match_pass_count"
      expr: COUNT(CASE WHEN three_way_match_status = 'Matched' THEN 1 END)
      comment: "Number of invoices that passed three-way match automatically. Measures AP automation effectiveness and straight-through processing rate."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance management KPIs — tracks quality, HSE, delivery, financial health, and overall vendor ratings to drive supply base decisions."
  source: "`vibe_construction_v1`.`procurement`.`vendor_evaluation`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation conducted (e.g. Annual, Post-Project, Incident-Triggered) for performance programme management."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation record (e.g. In Progress, Completed, Approved)."
    - name: "performance_grade"
      expr: performance_grade
      comment: "Overall performance grade assigned to the vendor (e.g. A, B, C, D) for supply base tiering."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Vendor qualification standing resulting from the evaluation (e.g. Approved, Conditional, Suspended)."
    - name: "bid_invitation_eligible_flag"
      expr: bid_invitation_eligible_flag
      comment: "Whether the vendor is eligible to receive bid invitations based on evaluation outcome."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicates whether a corrective action plan was mandated — used to track vendor improvement programmes."
    - name: "evaluation_date_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of evaluation for trend analysis of vendor performance over time."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "FK to construction project for project-specific vendor performance benchmarking."
  measures:
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Total number of vendor evaluations completed. Baseline metric for vendor management programme activity."
    - name: "avg_overall_kpi_rating"
      expr: AVG(CAST(overall_kpi_rating AS DOUBLE))
      comment: "Average overall KPI rating across evaluated vendors. Primary vendor performance scorecard metric for supply base health."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate across vendors. Directly linked to rework costs and project quality outcomes."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate. Critical schedule performance indicator — low rates signal supply chain risk to project timelines."
    - name: "avg_hse_rating_score"
      expr: AVG(CAST(hse_rating_score AS DOUBLE))
      comment: "Average HSE performance score. Mandatory KPI for contractor safety governance and prequalification decisions."
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score. Used in vendor tiering and bid invitation eligibility decisions."
    - name: "avg_financial_health_score"
      expr: AVG(CAST(financial_health_score AS DOUBLE))
      comment: "Average financial health score. Monitors vendor solvency risk — critical for long-lead and high-value procurement."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average vendor responsiveness score. Measures commercial agility and communication effectiveness."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of evaluations resulting in mandatory corrective action. Tracks supply base improvement programme load."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluations requiring corrective action. A leading indicator of supply base quality deterioration."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors evaluated. Measures coverage of the vendor management programme."
    - name: "avg_bonding_limit_amount"
      expr: AVG(CAST(bonding_limit_amount AS DOUBLE))
      comment: "Average bonding capacity limit across evaluated vendors. Informs maximum contract value that can be awarded to the supply base."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor prequalification and compliance KPIs — tracks qualification status, ISO certification coverage, HSE performance, financial capacity, and quality defect rates across the approved vendor list."
  source: "`vibe_construction_v1`.`procurement`.`vendor_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification standing (e.g. Approved, Conditional, Suspended, Expired) for AVL management."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g. Goods, Services, Works) for category-specific supply base analysis."
    - name: "qualification_category"
      expr: qualification_category
      comment: "Commodity or service category the vendor is qualified for — enables category management reporting."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "Whether the vendor holds ISO 9001 quality management certification — a key prequalification gate."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "Whether the vendor holds ISO 14001 environmental management certification."
    - name: "iso_45001_certified"
      expr: iso_45001_certified
      comment: "Whether the vendor holds ISO 45001 occupational health and safety certification."
    - name: "hse_performance_rating"
      expr: hse_performance_rating
      comment: "HSE performance rating band for safety-critical vendor segmentation."
    - name: "qualification_assessment_date_month"
      expr: DATE_TRUNC('MONTH', qualification_assessment_date)
      comment: "Month of qualification assessment for programme activity trending."
  measures:
    - name: "qualification_count"
      expr: COUNT(1)
      comment: "Total number of vendor qualification records. Baseline metric for AVL size and prequalification programme throughput."
    - name: "approved_vendor_count"
      expr: COUNT(CASE WHEN qualification_status = 'Approved' THEN 1 END)
      comment: "Number of vendors with approved qualification status. Measures active supply base size available for procurement."
    - name: "avg_technical_capability_score"
      expr: AVG(CAST(technical_capability_score AS DOUBLE))
      comment: "Average technical capability score across qualified vendors. Benchmarks supply base technical competence."
    - name: "avg_financial_health_score"
      expr: AVG(CAST(financial_health_score AS DOUBLE))
      comment: "Average financial health score. Monitors aggregate solvency risk across the approved vendor list."
    - name: "avg_past_performance_score"
      expr: AVG(CAST(past_performance_score AS DOUBLE))
      comment: "Average past performance score. Composite historical delivery and quality indicator for vendor selection decisions."
    - name: "avg_quality_defect_rate"
      expr: AVG(CAST(quality_defect_rate AS DOUBLE))
      comment: "Average quality defect rate across the vendor base. Directly linked to rework costs and project quality risk."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across qualified vendors. Supply chain schedule reliability indicator."
    - name: "avg_lti_frequency_rate"
      expr: AVG(CAST(lti_frequency_rate AS DOUBLE))
      comment: "Average Lost Time Injury frequency rate across vendors. Critical safety KPI for contractor HSE governance."
    - name: "avg_trir_rate"
      expr: AVG(CAST(trir_rate AS DOUBLE))
      comment: "Average Total Recordable Incident Rate across vendors. Industry-standard safety performance benchmark."
    - name: "avg_bonding_capacity_limit"
      expr: AVG(CAST(bonding_capacity_limit AS DOUBLE))
      comment: "Average bonding capacity across qualified vendors. Determines maximum contract values the supply base can support."
    - name: "iso_triple_certified_count"
      expr: COUNT(CASE WHEN iso_9001_certified = TRUE AND iso_14001_certified = TRUE AND iso_45001_certified = TRUE THEN 1 END)
      comment: "Number of vendors holding all three ISO certifications (9001, 14001, 45001). Identifies premium-tier vendors for critical procurement."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors in the qualification register. Measures approved vendor list breadth."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt and inbound logistics KPIs — tracks delivery performance, rejection rates, quantity variances, and inspection outcomes for material inbound control."
  source: "`vibe_construction_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection outcome for received goods (e.g. Passed, Failed, Pending) for inbound quality management."
    - name: "invoice_verification_status"
      expr: invoice_verification_status
      comment: "Status of invoice verification against the goods receipt for three-way match processing."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type code (e.g. 101 Goods Receipt, 122 Return) for stock transaction analysis."
    - name: "delivery_completed_flag"
      expr: delivery_completed_flag
      comment: "Indicates whether the full ordered quantity has been received — used for open delivery tracking."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the goods receipt was reversed — used to identify posting errors and corrections."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity analysis and cross-material comparison."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of goods receipt for inbound volume trending and seasonal analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "FK to construction project for project-level material receipt and cost accrual reporting."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of materials received. Primary inbound logistics volume metric for supply chain throughput."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across goods receipts. Baseline for delivery completeness and fill-rate calculation."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt. High values indicate vendor quality problems driving rework and re-procurement costs."
    - name: "total_receipt_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of goods received. Used for cost accrual, GR/IR reconciliation, and project cost reporting."
    - name: "goods_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions. Baseline inbound logistics activity metric."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity rejected at inspection. Key vendor quality KPI — elevated rates trigger corrective action and re-sourcing decisions."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price at goods receipt. Used for price variance analysis against PO unit prices."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversed goods receipts. Indicates posting error frequency and process quality in the receiving function."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors delivering in the period. Measures active supply base utilisation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement demand management KPIs — tracks requisition volumes, conversion rates, budget availability, cost estimates, and cycle times from demand to PO."
  source: "`vibe_construction_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "pr_status"
      expr: pr_status
      comment: "Current status of the purchase requisition (e.g. Draft, Pending Approval, Approved, Converted, Rejected) for pipeline management."
    - name: "pr_type"
      expr: pr_type
      comment: "Type of requisition (e.g. Material, Service, Capital) for spend category analysis."
    - name: "urgency_classification"
      expr: urgency_classification
      comment: "Urgency level of the requisition (e.g. Routine, Urgent, Emergency) for prioritisation and expediting decisions."
    - name: "procurement_strategy"
      expr: procurement_strategy
      comment: "Sourcing strategy selected for the requisition (e.g. Open Market, Framework, Sole Source) for strategy compliance monitoring."
    - name: "budget_available_flag"
      expr: budget_available_flag
      comment: "Indicates whether budget was confirmed available at requisition creation — used for budget control compliance."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of conversion from PR to PO/RFQ — tracks procurement pipeline progression."
    - name: "material_group"
      expr: material_group
      comment: "Material or service category group for spend category management and sourcing strategy alignment."
    - name: "requisition_date_month"
      expr: DATE_TRUNC('MONTH', requisition_date)
      comment: "Month of requisition creation for demand trend analysis and procurement planning."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "FK to construction project for project-level demand and procurement pipeline reporting."
  measures:
    - name: "requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions. Baseline procurement demand volume metric for workload planning."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost of all requisitions. Measures uncommitted procurement demand for budget forecasting."
    - name: "avg_estimated_unit_cost"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost across requisitions. Benchmarks against actual PO unit prices to assess estimation accuracy."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total budget variance across requisitions. Identifies aggregate over/under-budget demand for financial control."
    - name: "converted_requisition_count"
      expr: COUNT(CASE WHEN conversion_status = 'Converted' THEN 1 END)
      comment: "Number of requisitions successfully converted to POs or RFQs. Measures procurement pipeline throughput."
    - name: "conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_status = 'Converted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions converted to purchase orders. A key procurement efficiency KPI — low rates indicate approval bottlenecks or poor demand quality."
    - name: "budget_available_count"
      expr: COUNT(CASE WHEN budget_available_flag = TRUE THEN 1 END)
      comment: "Number of requisitions with confirmed budget availability. Measures budget discipline in the demand management process."
    - name: "urgent_requisition_count"
      expr: COUNT(CASE WHEN urgency_classification = 'Urgent' OR urgency_classification = 'Emergency' THEN 1 END)
      comment: "Number of urgent or emergency requisitions. High counts indicate poor demand planning and drive premium procurement costs."
    - name: "distinct_project_count"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects generating procurement demand. Measures portfolio-wide procurement activity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ (Request for Quotation) and competitive tendering KPIs — tracks bid coverage, award values, retention, and sourcing cycle performance."
  source: "`vibe_construction_v1`.`procurement`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g. Draft, Issued, Closed, Awarded, Cancelled) for tendering pipeline management."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g. Open, Selective, Single Source) for sourcing strategy compliance monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type being tendered (e.g. Lump Sum, Reimbursable, Unit Rate) for commercial strategy analysis."
    - name: "vendor_prequalification_required"
      expr: vendor_prequalification_required
      comment: "Whether vendor prequalification was required — used to assess compliance with procurement governance."
    - name: "bid_bond_required"
      expr: bid_bond_required
      comment: "Whether a bid bond was required — indicates high-value or risk-sensitive procurement events."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the RFQ was issued for tendering activity trend analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "FK to construction project for project-level tendering activity reporting."
  measures:
    - name: "rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued. Baseline tendering activity metric for procurement workload management."
    - name: "total_awarded_amount"
      expr: SUM(CAST(awarded_amount AS DOUBLE))
      comment: "Total value awarded through RFQ processes. Measures procurement throughput and committed spend from competitive tendering."
    - name: "avg_awarded_amount"
      expr: AVG(CAST(awarded_amount AS DOUBLE))
      comment: "Average award value per RFQ. Benchmarks typical procurement transaction size for resource planning."
    - name: "total_bid_bond_amount"
      expr: SUM(CAST(bid_bond_amount AS DOUBLE))
      comment: "Total bid bond value required across RFQs. Measures financial security exposure in the tendering programme."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage applied in RFQ awards. Benchmarks against contract policy for commercial consistency."
    - name: "awarded_rfq_count"
      expr: COUNT(CASE WHEN rfq_status = 'Awarded' THEN 1 END)
      comment: "Number of RFQs successfully awarded. Measures tendering programme completion rate."
    - name: "award_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rfq_status = 'Awarded' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of issued RFQs resulting in an award. Low rates indicate tendering inefficiency or market availability issues."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT awarded_vendor_id)
      comment: "Number of distinct vendors awarded through RFQ. Measures supply base utilisation from competitive tendering."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_po_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order amendment and change management KPIs — tracks scope growth, value changes, schedule impacts, and amendment approval cycle performance."
  source: "`vibe_construction_v1`.`procurement`.`po_amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Draft, Pending Approval, Approved, Rejected) for change pipeline management."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Scope Change, Price Adjustment, Delivery Extension) for change cause analysis."
    - name: "amendment_reason"
      expr: amendment_reason
      comment: "Root cause of the amendment for Pareto analysis of change drivers."
    - name: "budget_impact_flag"
      expr: budget_impact_flag
      comment: "Indicates whether the amendment has a budget impact — used to trigger budget revision workflows."
    - name: "client_approval_required"
      expr: client_approval_required
      comment: "Whether client approval is required for the amendment — tracks contractual change control compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amendment value for multi-currency change management reporting."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the amendment became effective for change activity trend analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "FK to construction project for project-level change management reporting."
  measures:
    - name: "amendment_count"
      expr: COUNT(1)
      comment: "Total number of PO amendments. High volumes indicate poor initial scoping or volatile project requirements."
    - name: "total_value_delta"
      expr: SUM(CAST(value_delta AS DOUBLE))
      comment: "Net change in PO value from all amendments. Measures total scope growth or reduction across the procurement portfolio."
    - name: "total_amended_po_value"
      expr: SUM(CAST(amended_po_value AS DOUBLE))
      comment: "Total revised PO value after amendments. Represents current committed spend including all changes."
    - name: "total_original_po_value"
      expr: SUM(CAST(original_po_value AS DOUBLE))
      comment: "Total original PO value before amendments. Baseline for measuring scope growth."
    - name: "avg_value_delta"
      expr: AVG(CAST(value_delta AS DOUBLE))
      comment: "Average value change per amendment. Indicates typical amendment magnitude for change control threshold calibration."
    - name: "budget_impacting_amendment_count"
      expr: COUNT(CASE WHEN budget_impact_flag = TRUE THEN 1 END)
      comment: "Number of amendments with confirmed budget impact. Drives budget revision and re-approval workflows."
    - name: "scope_growth_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(value_delta AS DOUBLE)) / NULLIF(SUM(CAST(original_po_value AS DOUBLE)), 0), 2)
      comment: "Percentage growth in PO value from amendments vs. original value. Key procurement governance KPI — high rates indicate scope management failure."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with amended POs. Identifies vendors with high change activity for relationship management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_vendor_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor quotation and commercial evaluation KPIs — tracks pricing competitiveness, evaluation scores, discount capture, and quotation quality across the supply base."
  source: "`vibe_construction_v1`.`procurement`.`vendor_quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Current status of the vendor quotation (e.g. Submitted, Under Evaluation, Awarded, Rejected) for evaluation pipeline management."
    - name: "technical_compliance_status"
      expr: technical_compliance_status
      comment: "Technical compliance outcome (e.g. Compliant, Non-Compliant, Conditional) for bid qualification filtering."
    - name: "currency_code"
      expr: currency_code
      comment: "Quotation currency for multi-currency commercial comparison."
    - name: "delivery_terms"
      expr: delivery_terms
      comment: "Delivery terms offered by the vendor for commercial and logistics comparison."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms offered in the quotation for cash-flow impact assessment."
    - name: "submission_date_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of quotation submission for tendering activity trend analysis."
  measures:
    - name: "quotation_count"
      expr: COUNT(1)
      comment: "Total number of vendor quotations received. Measures market response rate and competitive tension in procurement events."
    - name: "total_quoted_value"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total value of all quotations received. Measures aggregate market pricing for budget benchmarking."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across quotations. Benchmarks market pricing for cost estimation and negotiation."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average commercial and technical evaluation score. Measures overall quality of market response to procurement events."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount offered by vendors. Measures negotiation leverage and competitive pricing pressure."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across quotations. Identifies logistics cost as a component of total landed cost for sourcing decisions."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across quotations. Used for total cost of ownership comparison and tax optimisation in sourcing."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors submitting quotations. Measures competitive tension — fewer vendors increases single-source risk."
    - name: "technically_compliant_count"
      expr: COUNT(CASE WHEN technical_compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of technically compliant quotations. Measures effective supply base depth for the procurement category."
    - name: "technical_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN technical_compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotations meeting technical requirements. Low rates indicate specification quality issues or supply base capability gaps."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_framework_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Framework agreement utilisation and performance KPIs — tracks spend against framework ceilings, utilisation rates, and agreement portfolio health."
  source: "`vibe_construction_v1`.`procurement`.`procurement_framework_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the framework agreement (e.g. Active, Expired, Terminated) for portfolio management."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of framework agreement (e.g. Single Supplier, Multi-Supplier, DPS) for commercial strategy analysis."
    - name: "commodity_category_code"
      expr: commodity_category_code
      comment: "Commodity or service category covered by the framework for category management reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Agreement currency for multi-currency framework portfolio analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the agreement auto-renews — used for contract expiry risk management."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Whether a performance bond is required under the framework — indicates risk-sensitive agreements."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the framework agreement became effective for portfolio timeline analysis."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "FK to construction project for project-specific framework utilisation reporting."
  measures:
    - name: "framework_agreement_count"
      expr: COUNT(1)
      comment: "Total number of framework agreements. Baseline metric for strategic sourcing portfolio size."
    - name: "total_maximum_commitment_value"
      expr: SUM(CAST(maximum_commitment_value AS DOUBLE))
      comment: "Total ceiling value across all framework agreements. Measures strategic procurement capacity available to the organisation."
    - name: "total_spend_to_date_sum"
      expr: SUM(CAST(total_spend_to_date AS DOUBLE))
      comment: "Total spend consumed against framework agreements. Measures framework utilisation and remaining capacity."
    - name: "avg_utilisation_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average utilisation rate across framework agreements. Low utilisation indicates poor framework adoption; high rates signal capacity risk."
    - name: "avg_performance_bond_percentage"
      expr: AVG(CAST(performance_bond_percentage AS DOUBLE))
      comment: "Average performance bond percentage across frameworks. Benchmarks financial security requirements in the strategic sourcing portfolio."
    - name: "remaining_capacity_sum"
      expr: SUM(CAST(maximum_commitment_value AS DOUBLE) - CAST(total_spend_to_date AS DOUBLE))
      comment: "Total remaining uncommitted capacity across framework agreements. Critical for procurement planning — indicates available headroom before new agreements are needed."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors under framework agreements. Measures strategic supply base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_approval_workflow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement approval governance KPIs — tracks workflow configuration, threshold coverage, risk levels, and delegation of authority across the procurement approval framework."
  source: "`vibe_construction_v1`.`procurement`.`approval_workflow`"
  dimensions:
    - name: "approval_workflow_status"
      expr: approval_workflow_status
      comment: "Current status of the approval workflow (e.g. Active, Archived, Draft) for governance framework management."
    - name: "approval_workflow_type"
      expr: approval_workflow_type
      comment: "Type of approval workflow (e.g. PO Approval, RFQ Approval, Amendment Approval) for process coverage analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the workflow (e.g. Low, Medium, High) for risk-based approval governance."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the workflow is mandatory — used to identify compliance-critical approval paths."
    - name: "is_parallel_approval"
      expr: is_parallel_approval
      comment: "Whether approvals run in parallel — impacts cycle time and bottleneck analysis."
    - name: "auto_approval"
      expr: auto_approval
      comment: "Whether auto-approval is enabled — measures automation coverage in the approval framework."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "FK to construction project for project-specific delegation of authority reporting."
  measures:
    - name: "workflow_count"
      expr: COUNT(1)
      comment: "Total number of approval workflows configured. Measures governance framework coverage across procurement transaction types."
    - name: "avg_approval_threshold_amount"
      expr: AVG(CAST(approval_threshold_amount AS DOUBLE))
      comment: "Average approval threshold value across workflows. Benchmarks delegation of authority levels for policy compliance."
    - name: "max_approval_threshold_amount"
      expr: MAX(CAST(approval_threshold_amount AS DOUBLE))
      comment: "Maximum approval threshold in the framework. Identifies the highest delegation level configured — critical for board-level governance review."
    - name: "mandatory_workflow_count"
      expr: COUNT(CASE WHEN is_mandatory = TRUE THEN 1 END)
      comment: "Number of mandatory approval workflows. Measures compliance-critical governance coverage."
    - name: "auto_approval_workflow_count"
      expr: COUNT(CASE WHEN auto_approval = TRUE THEN 1 END)
      comment: "Number of workflows with auto-approval enabled. Measures procurement automation maturity and straight-through processing capability."
    - name: "high_risk_workflow_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk approval workflows. Ensures adequate governance controls are in place for high-risk procurement categories."
    - name: "distinct_project_count"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with configured approval workflows. Measures governance framework deployment across the project portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`procurement_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material delivery scheduling and logistics KPIs — tracks delivery performance, schedule variance, expediting activity, and critical path delivery compliance."
  source: "`vibe_construction_v1`.`procurement`.`delivery_schedule`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status (e.g. Scheduled, In Transit, Delivered, Delayed) for logistics pipeline management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g. Road, Rail, Sea, Air) for logistics cost and risk analysis."
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether the delivery is on the project critical path — used to prioritise expediting resources."
    - name: "expedite_flag"
      expr: expedite_flag
      comment: "Indicates whether the delivery has been expedited — measures reactive supply chain management activity."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether inspection is required before delivery acceptance — impacts lead time planning."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Coded reason for delivery delay for root cause analysis and vendor accountability."
    - name: "required_on_site_date_month"
      expr: DATE_TRUNC('MONTH', required_on_site_date)
      comment: "Month materials are required on site for demand-side delivery planning."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "FK to construction project for project-level delivery performance reporting."
    - name: "site_id"
      expr: site_id
      comment: "FK to site for site-level delivery coordination and logistics planning."
  measures:
    - name: "delivery_schedule_count"
      expr: COUNT(1)
      comment: "Total number of scheduled deliveries. Baseline logistics volume metric for site coordination planning."
    - name: "total_delivery_quantity"
      expr: SUM(CAST(delivery_quantity AS DOUBLE))
      comment: "Total quantity scheduled for delivery. Measures material flow volume for site logistics capacity planning."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total quantity confirmed received. Compared against delivery_quantity to measure delivery completeness."
    - name: "critical_path_delivery_count"
      expr: COUNT(CASE WHEN critical_path_flag = TRUE THEN 1 END)
      comment: "Number of deliveries on the project critical path. Prioritisation metric for expediting and logistics management."
    - name: "expedited_delivery_count"
      expr: COUNT(CASE WHEN expedite_flag = TRUE THEN 1 END)
      comment: "Number of deliveries requiring expediting. High counts indicate supply chain disruption and drive premium freight costs."
    - name: "expedite_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN expedite_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries requiring expediting. A leading indicator of supply chain stress — elevated rates signal procurement planning failures."
    - name: "delivery_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(goods_receipt_quantity AS DOUBLE)) / NULLIF(SUM(CAST(delivery_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled delivery quantity actually received. Measures vendor delivery completeness and supply reliability."
    - name: "distinct_project_count"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with active delivery schedules. Measures logistics coordination breadth."
$$;