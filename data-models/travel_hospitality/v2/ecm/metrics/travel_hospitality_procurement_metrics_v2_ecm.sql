-- Metric views for domain: procurement | Business: Travel Hospitality | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt and receiving performance KPIs. Enables supply chain and operations leadership to monitor receipt volumes, quality rejection rates, variance, and three-way match compliance."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "gr_status"
      expr: gr_status
      comment: "Goods receipt document status (e.g. Posted, Cancelled, Pending) for receiving pipeline analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status for goods received. Tracks inspection compliance."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match result (PO/GR/Invoice) for AP control reporting."
    - name: "capex_opex_indicator"
      expr: capex_opex_indicator
      comment: "CapEx vs OpEx classification for financial reporting and budget tracking."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type for stock management analysis."
    - name: "quality_rejection_flag"
      expr: quality_rejection_flag
      comment: "Indicates quality rejection at receipt. Used to segment clean vs rejected receipts."
    - name: "return_delivery_flag"
      expr: return_delivery_flag
      comment: "Indicates return delivery receipts for reverse logistics tracking."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of goods receipt for receiving volume trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods receipt for multi-currency inventory valuation."
  measures:
    - name: "total_receipt_count"
      expr: COUNT(1)
      comment: "Total number of goods receipts. Baseline receiving throughput KPI."
    - name: "total_quantity_received"
      expr: SUM(CAST(total_quantity_received AS DOUBLE))
      comment: "Total quantity of goods received. Measures supply chain inflow volume."
    - name: "total_receipt_value"
      expr: SUM(CAST(total_value_amount AS DOUBLE))
      comment: "Total value of goods received. Primary inventory inflow value KPI."
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges_amount AS DOUBLE))
      comment: "Total freight charges on goods receipts. Supports logistics cost management."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total receipt variance amount (quantity or price). Measures procurement accuracy and supplier reliability."
    - name: "quality_rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_rejection_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts with quality rejections. Key vendor quality KPI driving corrective action."
    - name: "avg_receipt_value"
      expr: AVG(CAST(total_value_amount AS DOUBLE))
      comment: "Average value per goods receipt. Indicates typical delivery size for logistics planning."
    - name: "three_way_match_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN three_way_match_status = 'Matched' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts passing three-way match. Measures AP control effectiveness and invoice accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs for procurement leadership. Tracks contract value, compliance, renewal risk, and lifecycle status to manage vendor obligations and reduce contractual exposure."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`procurement_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract lifecycle status (e.g. Active, Expired, Terminated, Draft)."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g. Master Service Agreement, Framework, Spot) for portfolio segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency portfolio analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates auto-renewal contracts requiring proactive management."
    - name: "capex_designation_flag"
      expr: capex_designation_flag
      comment: "Indicates CapEx-designated contracts for capital budget tracking."
    - name: "pip_project_flag"
      expr: pip_project_flag
      comment: "Indicates Property Improvement Plan contracts for asset management reporting."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year contract became effective for portfolio vintage analysis."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of contract expiry for renewal pipeline management."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of procurement contracts. Baseline portfolio size KPI."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total committed contract value across the portfolio. Primary spend commitment KPI."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value. Indicates deal size and negotiation leverage."
    - name: "avg_negotiated_discount_pct"
      expr: AVG(CAST(negotiated_discount_percent AS DOUBLE))
      comment: "Average negotiated discount percentage across contracts. Measures procurement savings effectiveness."
    - name: "total_negotiated_discount_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE) * CAST(negotiated_discount_percent AS DOUBLE) / 100.0)
      comment: "Estimated total savings from negotiated discounts. Quantifies procurement value creation."
    - name: "auto_renewal_contract_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of contracts set to auto-renew. Flags contracts requiring proactive review to avoid unintended renewals."
    - name: "capex_contract_value"
      expr: SUM(CASE WHEN capex_designation_flag = TRUE THEN CAST(total_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of CapEx-designated contracts. Supports capital expenditure budget management."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors under contract. Measures vendor base coverage."
    - name: "avg_sla_on_time_delivery_pct"
      expr: AVG(CAST(sla_on_time_delivery_percent AS DOUBLE))
      comment: "Average contracted SLA for on-time delivery. Baseline for vendor performance benchmarking."
    - name: "avg_sla_quality_acceptance_pct"
      expr: AVG(CAST(sla_quality_acceptance_percent AS DOUBLE))
      comment: "Average contracted SLA for quality acceptance. Baseline for quality compliance benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement work order execution KPIs. Enables facilities and procurement leadership to monitor work order volumes, cost performance, budget variance, and completion rates for vendor-executed work."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`procurement_work_order`"
  dimensions:
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current work order status (e.g. Open, In Progress, Completed, Cancelled) for execution pipeline analysis."
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g. Preventive, Corrective, Emergency) for maintenance strategy analysis."
    - name: "priority"
      expr: priority
      comment: "Work order priority for resource allocation and SLA management."
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "Expenditure type (CapEx/OpEx) for financial classification."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates recurring work orders for maintenance program planning."
    - name: "warranty_applicable"
      expr: warranty_applicable
      comment: "Indicates warranty-covered work orders for cost recovery tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Work order currency for multi-currency cost analysis."
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month work order was requested for volume trend analysis."
  measures:
    - name: "total_work_order_count"
      expr: COUNT(1)
      comment: "Total number of procurement work orders. Baseline maintenance and service activity KPI."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of work orders executed. Primary maintenance spend KPI."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of work orders. Used for budget planning and variance analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost variance (actual minus estimated). Measures work order cost estimation accuracy."
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across work orders. Supports workforce cost allocation."
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost across work orders. Supports inventory and procurement cost analysis."
    - name: "total_service_cost"
      expr: SUM(CAST(service_cost AS DOUBLE))
      comment: "Total third-party service cost across work orders. Measures vendor service spend."
    - name: "avg_actual_cost_per_work_order"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per work order. Benchmarks maintenance cost efficiency."
    - name: "contract_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN contract_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work orders meeting contract compliance requirements. Measures vendor contract adherence."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_program_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program assignment lifecycle and spend KPIs. Enables program management and procurement leadership to monitor assignment coverage, billing rates, contract values, and performance across vendor and employee program assignments."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`program_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current assignment status (e.g. Active, Completed, Terminated) for pipeline management."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g. Vendor, Employee, Contractor) for resource classification."
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of the assignee in the program for capability and coverage analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the assignment for governance and compliance tracking."
    - name: "is_primary_assignment"
      expr: is_primary_assignment
      comment: "Indicates primary vs secondary assignments for resource accountability."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the assignment for regulatory and contractual adherence."
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month assignment started for resource planning trend analysis."
    - name: "certification_verified_flag"
      expr: certification_verified_flag
      comment: "Indicates whether required certifications have been verified for the assignment."
  measures:
    - name: "total_assignment_count"
      expr: COUNT(1)
      comment: "Total number of program assignments. Baseline resource deployment KPI."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across all program assignments. Measures program spend commitment."
    - name: "total_spend_commitment"
      expr: SUM(CAST(spend_commitment AS DOUBLE))
      comment: "Total spend committed across assignments. Tracks financial exposure in program portfolio."
    - name: "total_spend_to_date"
      expr: SUM(CAST(spend_to_date AS DOUBLE))
      comment: "Total spend incurred to date across assignments. Measures program budget consumption."
    - name: "avg_billing_rate"
      expr: AVG(CAST(billing_rate AS DOUBLE))
      comment: "Average billing rate across assignments. Benchmarks program resource cost efficiency."
    - name: "avg_allocation_pct"
      expr: AVG(CAST(allocation_pct AS DOUBLE))
      comment: "Average resource allocation percentage. Measures resource utilization intensity across programs."
    - name: "avg_budget_amount"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per assignment. Indicates typical program assignment investment size."
    - name: "certification_verified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certification_verified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assignments with verified certifications. Measures compliance readiness in program staffing."
    - name: "distinct_program_count"
      expr: COUNT(DISTINCT program_id)
      comment: "Number of distinct programs with active assignments. Measures program portfolio breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CapEx and PIP project portfolio KPIs. Enables asset management and finance leadership to monitor project spend, budget variance, completion rates, and risk across property improvement programs."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current project status (e.g. Active, Completed, On Hold, Cancelled) for portfolio health monitoring."
    - name: "project_type"
      expr: project_type
      comment: "Project type (e.g. CapEx, PIP, OpEx, Renovation) for capital vs operating spend classification."
    - name: "project_category"
      expr: project_category
      comment: "Project category for spend taxonomy and portfolio segmentation."
    - name: "is_pip_project"
      expr: is_pip_project
      comment: "Indicates Property Improvement Plan projects for brand standard compliance tracking."
    - name: "priority"
      expr: priority
      comment: "Project priority level for resource allocation decisions."
    - name: "risk_level"
      expr: risk_level
      comment: "Project risk level for portfolio risk management."
    - name: "brand_standard_compliance"
      expr: brand_standard_compliance
      comment: "Indicates brand standard compliance status for franchise/brand management."
    - name: "currency_code"
      expr: currency_code
      comment: "Project currency for multi-currency capital budget reporting."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Planned start year for capital planning and budget cycle analysis."
  measures:
    - name: "total_project_count"
      expr: COUNT(1)
      comment: "Total number of procurement projects. Baseline portfolio size KPI."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved project budget. Primary capital expenditure planning KPI."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across projects. Measures capital spend execution."
    - name: "total_committed_cost"
      expr: SUM(CAST(committed_cost AS DOUBLE))
      comment: "Total committed cost (POs issued but not yet invoiced). Measures capital commitment exposure."
    - name: "total_budget_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Total budget variance (actual minus budget). Negative = under budget; positive = over budget. Critical CapEx control KPI."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average project completion percentage. Measures portfolio execution progress."
    - name: "pip_project_count"
      expr: SUM(CASE WHEN is_pip_project = TRUE THEN 1 ELSE 0 END)
      comment: "Number of active PIP projects. Tracks brand standard improvement program scale."
    - name: "pip_project_budget"
      expr: SUM(CASE WHEN is_pip_project = TRUE THEN CAST(budget_amount AS DOUBLE) ELSE 0 END)
      comment: "Total budget allocated to PIP projects. Measures brand investment commitment."
    - name: "high_risk_project_count"
      expr: SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Number of high-risk projects. Drives executive attention and risk mitigation resource allocation."
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with active projects. Measures capital investment geographic spread."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order volume, spend, and fulfillment performance. Enables procurement leadership to monitor PO throughput, committed spend, and delivery compliance by property, vendor, and category."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current lifecycle status of the purchase order (e.g. Open, Closed, Cancelled) for pipeline segmentation."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g. Standard, Blanket, Framework) for spend classification."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Vendor payment terms (e.g. Net 30, Net 60) for cash-flow planning."
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month the PO was issued, used for trend and seasonality analysis."
    - name: "po_year"
      expr: YEAR(po_date)
      comment: "Fiscal year of PO issuance for annual spend reporting."
    - name: "goods_receipt_completed_flag"
      expr: goods_receipt_completed_flag
      comment: "Indicates whether goods receipt has been completed, enabling open-PO aging analysis."
    - name: "invoice_receipt_completed_flag"
      expr: invoice_receipt_completed_flag
      comment: "Indicates whether invoice receipt has been completed, enabling three-way match tracking."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method used on the PO for logistics cost analysis."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline volume KPI for procurement throughput."
    - name: "total_po_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders (pre-tax). Core spend management KPI."
    - name: "total_po_spend_with_tax"
      expr: SUM(CAST(total_amount_with_tax AS DOUBLE))
      comment: "Total PO spend inclusive of tax. Used for full-cost budgeting and AP accruals."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across purchase orders. Supports tax liability reporting."
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value. Indicates procurement ticket size and sourcing efficiency."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors receiving POs. Measures vendor base breadth and concentration risk."
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties issuing POs. Supports property-level spend allocation."
    - name: "goods_receipt_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN goods_receipt_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs with completed goods receipt. Measures supply chain fulfillment effectiveness."
    - name: "invoice_receipt_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN invoice_receipt_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of POs with completed invoice receipt. Tracks AP processing completeness."
    - name: "commitment_released_amount_total"
      expr: SUM(CAST(commitment_released_amount AS DOUBLE))
      comment: "Total budget commitment released from closed/cancelled POs. Supports budget reallocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase requisition pipeline and approval KPIs. Enables procurement and finance leadership to monitor requisition volumes, approval cycle efficiency, conversion rates, and budget compliance."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current requisition status (e.g. Draft, Submitted, Approved, Rejected, Converted) for pipeline analysis."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition (e.g. Standard, Emergency, Blanket) for spend classification."
    - name: "priority_level"
      expr: priority_level
      comment: "Requisition priority level for workload and urgency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Requisition currency for multi-currency spend analysis."
    - name: "budget_available_flag"
      expr: budget_available_flag
      comment: "Indicates whether budget was available at requisition time. Tracks budget compliance."
    - name: "converted_to_po_flag"
      expr: converted_to_po_flag
      comment: "Indicates whether requisition was converted to a PO. Measures procurement pipeline conversion."
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy applied (e.g. Competitive Bid, Sole Source) for compliance monitoring."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month requisition was submitted for volume trend analysis."
  measures:
    - name: "total_requisition_count"
      expr: COUNT(1)
      comment: "Total number of purchase requisitions. Baseline procurement demand KPI."
    - name: "total_estimated_spend"
      expr: SUM(CAST(estimated_total_amount AS DOUBLE))
      comment: "Total estimated spend across all requisitions. Measures procurement demand pipeline value."
    - name: "avg_estimated_requisition_value"
      expr: AVG(CAST(estimated_total_amount AS DOUBLE))
      comment: "Average estimated value per requisition. Indicates typical procurement request size."
    - name: "po_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN converted_to_po_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions converted to purchase orders. Measures procurement pipeline efficiency."
    - name: "budget_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN budget_available_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions submitted with available budget. Measures financial discipline in procurement."
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties submitting requisitions. Measures procurement demand distribution."
    - name: "emergency_requisition_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN requisition_type = 'Emergency' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions flagged as emergency. High rate signals planning failures and premium cost risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_purchase_return`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase return and vendor credit KPIs. Enables procurement and quality leadership to monitor return volumes, return values, quality rejection drivers, and credit recovery performance."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`purchase_return`"
  dimensions:
    - name: "return_status"
      expr: return_status
      comment: "Current return status (e.g. Initiated, Shipped, Credit Received) for return pipeline management."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return (e.g. Quality Defect, Wrong Item, Overshipment) for root cause analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the return for AP credit recovery tracking."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Indicates items placed on quality hold. Flags quality-driven returns."
    - name: "perishable_item_flag"
      expr: perishable_item_flag
      comment: "Indicates perishable item returns for food safety and waste management analysis."
    - name: "ap_credit_posted_flag"
      expr: ap_credit_posted_flag
      comment: "Indicates whether AP credit has been posted for the return. Tracks credit recovery completion."
    - name: "return_month"
      expr: DATE_TRUNC('MONTH', return_date)
      comment: "Month of return for trend and seasonality analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Return currency for multi-currency credit analysis."
  measures:
    - name: "total_return_count"
      expr: COUNT(1)
      comment: "Total number of purchase returns. Baseline return volume KPI."
    - name: "total_return_value"
      expr: SUM(CAST(return_value_amount AS DOUBLE))
      comment: "Total value of goods returned. Measures financial impact of procurement quality issues."
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(credit_memo_amount AS DOUBLE))
      comment: "Total credit memo value recovered from vendors. Measures AP credit recovery effectiveness."
    - name: "total_return_quantity"
      expr: SUM(CAST(return_quantity AS DOUBLE))
      comment: "Total quantity of goods returned. Measures supply chain quality volume impact."
    - name: "total_restocking_fee"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees incurred on returns. Measures cost of return logistics."
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total shipping cost for returns. Measures reverse logistics cost."
    - name: "ap_credit_recovery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ap_credit_posted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returns with AP credit posted. Measures credit recovery process effectiveness."
    - name: "avg_return_value"
      expr: AVG(CAST(return_value_amount AS DOUBLE))
      comment: "Average value per return. Benchmarks return transaction size for vendor quality management."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_request_for_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing event and RFQ pipeline KPIs. Enables procurement leadership to monitor competitive bidding activity, award values, vendor participation, and sourcing cycle performance."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`request_for_quotation`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current RFQ status (e.g. Draft, Issued, Awarded, Cancelled) for sourcing pipeline management."
    - name: "event_type"
      expr: event_type
      comment: "Sourcing event type (e.g. RFQ, RFP, Auction) for sourcing strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "RFQ currency for multi-currency sourcing analysis."
    - name: "capex_opex_flag"
      expr: capex_opex_flag
      comment: "CapEx vs OpEx classification for capital vs operating sourcing analysis."
    - name: "pip_project_flag"
      expr: pip_project_flag
      comment: "Indicates PIP-related sourcing events for brand improvement tracking."
    - name: "sustainability_requirement_flag"
      expr: sustainability_requirement_flag
      comment: "Indicates RFQs with sustainability requirements for ESG sourcing reporting."
    - name: "minority_vendor_preference_flag"
      expr: minority_vendor_preference_flag
      comment: "Indicates RFQs with minority vendor preference for supplier diversity tracking."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year RFQ was issued for annual sourcing activity analysis."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month RFQ was issued for sourcing cycle trend analysis."
  measures:
    - name: "total_rfq_count"
      expr: COUNT(1)
      comment: "Total number of RFQs issued. Baseline sourcing activity KPI."
    - name: "total_awarded_contract_value"
      expr: SUM(CAST(awarded_contract_value AS DOUBLE))
      comment: "Total value of contracts awarded through RFQ process. Measures sourcing program spend coverage."
    - name: "total_estimated_annual_spend"
      expr: SUM(CAST(estimated_annual_spend_amount AS DOUBLE))
      comment: "Total estimated annual spend covered by RFQs. Measures sourcing pipeline value."
    - name: "avg_awarded_contract_value"
      expr: AVG(CAST(awarded_contract_value AS DOUBLE))
      comment: "Average awarded contract value per RFQ. Indicates sourcing deal size."
    - name: "avg_vendor_participation"
      expr: AVG(CAST(participating_vendor_count AS DOUBLE))
      comment: "Average number of vendors participating per RFQ. Measures competitive market depth."
    - name: "avg_response_received_count"
      expr: AVG(CAST(response_received_count AS DOUBLE))
      comment: "Average number of responses received per RFQ. Measures vendor engagement in sourcing events."
    - name: "sustainability_rfq_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainability_requirement_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFQs with sustainability requirements. Tracks ESG integration in sourcing."
    - name: "distinct_property_count"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties issuing RFQs. Measures sourcing activity distribution."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs for procurement and supply chain leadership. Tracks vendor base health, spend concentration, risk profile, and compliance status to support strategic sourcing decisions."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current vendor status (e.g. Active, Inactive, Blocked) for vendor base health monitoring."
    - name: "tier"
      expr: tier
      comment: "Vendor tier classification (e.g. Strategic, Preferred, Approved) for spend segmentation."
    - name: "classification"
      expr: classification
      comment: "Vendor classification (e.g. Goods, Services, Contractor) for category analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Vendor compliance status for regulatory and audit reporting."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Vendor risk rating for supply chain risk management."
    - name: "diversity_certification"
      expr: diversity_certification
      comment: "Diversity certification type (e.g. MBE, WBE) for supplier diversity program tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Preferred payment method for AP and treasury planning."
    - name: "country_code"
      expr: country_code
      comment: "Vendor country for geographic spend analysis and trade compliance."
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year vendor was onboarded for vendor base vintage analysis."
  measures:
    - name: "total_vendor_count"
      expr: COUNT(1)
      comment: "Total number of vendors in the master file. Baseline vendor base size KPI."
    - name: "active_vendor_count"
      expr: SUM(CASE WHEN vendor_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active vendors. Measures usable vendor base size for sourcing."
    - name: "total_annual_spend"
      expr: SUM(CAST(annual_spend_amount AS DOUBLE))
      comment: "Total annual spend across all vendors. Primary spend concentration KPI."
    - name: "avg_annual_spend_per_vendor"
      expr: AVG(CAST(annual_spend_amount AS DOUBLE))
      comment: "Average annual spend per vendor. Measures spend distribution and concentration risk."
    - name: "insurance_expiry_risk_count"
      expr: SUM(CASE WHEN insurance_certificate_expiry_date <= CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of vendors with expired insurance certificates. Flags compliance and liability risk."
    - name: "diversity_certified_vendor_count"
      expr: SUM(CASE WHEN diversity_certification IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of diversity-certified vendors. Tracks supplier diversity program performance."
    - name: "diversity_certified_vendor_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN diversity_certification IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors with diversity certification. KPI for supplier diversity goals."
    - name: "high_risk_vendor_count"
      expr: SUM(CASE WHEN risk_rating = 'High' THEN 1 ELSE 0 END)
      comment: "Number of vendors rated high risk. Drives supply chain risk mitigation actions."
    - name: "avg_minimum_order_amount"
      expr: AVG(CAST(minimum_order_amount AS DOUBLE))
      comment: "Average vendor minimum order amount. Informs procurement policy and small-order cost management."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor certification compliance KPIs. Enables procurement and risk management to monitor certification coverage, expiry risk, and compliance gate status across the vendor base."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (e.g. Active, Expired, Pending Renewal) for compliance monitoring."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. ISO, Insurance, Safety, ESG) for compliance category analysis."
    - name: "certification_subtype"
      expr: certification_subtype
      comment: "Certification subtype for granular compliance reporting."
    - name: "compliance_gate_flag"
      expr: compliance_gate_flag
      comment: "Indicates certifications that are mandatory compliance gates. Prioritizes critical compliance gaps."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates auto-renewing certifications for renewal management."
    - name: "brand_standard_flag"
      expr: brand_standard_flag
      comment: "Indicates brand standard certifications for franchise compliance tracking."
    - name: "esg_reporting_flag"
      expr: esg_reporting_flag
      comment: "Indicates ESG-reportable certifications for sustainability disclosure."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the certification for prioritized compliance management."
    - name: "issuing_country_code"
      expr: issuing_country_code
      comment: "Country of certification issuance for jurisdictional compliance analysis."
  measures:
    - name: "total_certification_count"
      expr: COUNT(1)
      comment: "Total number of vendor certifications on file. Baseline compliance coverage KPI."
    - name: "active_certification_count"
      expr: SUM(CASE WHEN certification_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active certifications. Measures live compliance coverage."
    - name: "expired_certification_count"
      expr: SUM(CASE WHEN expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of expired certifications. Flags immediate compliance risk requiring remediation."
    - name: "compliance_gate_expiry_risk_count"
      expr: SUM(CASE WHEN compliance_gate_flag = TRUE AND expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Number of expired mandatory compliance gate certifications. Critical risk KPI requiring immediate action."
    - name: "avg_coverage_amount"
      expr: AVG(CAST(coverage_amount AS DOUBLE))
      comment: "Average insurance/certification coverage amount. Measures vendor liability coverage adequacy."
    - name: "total_coverage_amount"
      expr: SUM(CAST(coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all vendor certifications. Measures aggregate liability protection."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors with certifications on file. Measures certification program vendor coverage."
    - name: "esg_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN esg_reporting_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications flagged for ESG reporting. Tracks sustainability disclosure coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs. Enables finance and procurement leadership to monitor invoice volumes, dispute rates, payment performance, and early payment discount capture."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the vendor invoice (e.g. Pending, Approved, Paid, Disputed)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g. Standard, Credit Memo, Debit Memo) for AP classification."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. ACH, Wire, Check) for cash management analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code for DPO and cash flow analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for AP aging and trend analysis."
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice for annual AP spend reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute. Used to segment disputed vs clean invoices."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match result (PO/GR/Invoice) for compliance and audit reporting."
    - name: "expense_type"
      expr: expense_type
      comment: "Expense classification for GL coding and cost center analysis."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of vendor invoices processed. Baseline AP throughput KPI."
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice value. Primary AP spend KPI for cash flow and accrual management."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice value after discounts. Used for actual payment obligation reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on vendor invoices. Supports tax liability and reclaim reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured on vendor invoices. Measures negotiated savings realization."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total value of invoices under dispute. Flags AP risk and vendor relationship issues."
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices in dispute. High dispute rate signals vendor quality or process issues."
    - name: "early_payment_discount_eligible_count"
      expr: SUM(CASE WHEN early_payment_discount_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of invoices eligible for early payment discount. Supports working capital optimization."
    - name: "avg_invoice_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value per vendor invoice. Indicates vendor transaction size."
    - name: "total_match_variance_amount"
      expr: SUM(CAST(match_variance_amount AS DOUBLE))
      comment: "Total three-way match variance amount. Measures invoice accuracy and procurement control effectiveness."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors invoicing. Measures AP vendor concentration."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor scorecard and performance KPIs. Enables procurement leadership to evaluate vendor quality, delivery reliability, and overall score to drive sourcing decisions and contract renewals."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor_performance`"
  dimensions:
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the vendor evaluation cycle (e.g. Completed, In Progress, Pending)."
    - name: "contract_renewal_recommendation"
      expr: contract_renewal_recommendation
      comment: "Renewal recommendation outcome (e.g. Renew, Renegotiate, Terminate) for strategic sourcing decisions."
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates preferred vendor status for spend concentration analysis."
    - name: "qualified_vendor_flag"
      expr: qualified_vendor_flag
      comment: "Indicates whether vendor is qualified for procurement use."
    - name: "sustainability_compliance_flag"
      expr: sustainability_compliance_flag
      comment: "Indicates ESG/sustainability compliance status for responsible sourcing reporting."
    - name: "payment_terms_compliance_flag"
      expr: payment_terms_compliance_flag
      comment: "Indicates whether vendor complies with agreed payment terms."
    - name: "evaluation_period_year"
      expr: YEAR(evaluation_period_start_date)
      comment: "Year of the evaluation period for annual vendor scorecard trending."
    - name: "evaluation_period_month"
      expr: DATE_TRUNC('MONTH', evaluation_period_start_date)
      comment: "Month of evaluation period start for periodic performance tracking."
  measures:
    - name: "total_evaluations"
      expr: COUNT(1)
      comment: "Total number of vendor performance evaluations. Baseline KPI for evaluation program coverage."
    - name: "avg_overall_vendor_score"
      expr: AVG(CAST(overall_vendor_score AS DOUBLE))
      comment: "Average overall vendor score across evaluations. Primary vendor quality KPI for sourcing decisions."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across vendors. Measures supply chain reliability."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate. Measures vendor product/service quality compliance."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate. Measures billing precision and AP processing efficiency."
    - name: "avg_contract_compliance_score"
      expr: AVG(CAST(contract_compliance_score AS DOUBLE))
      comment: "Average contract compliance score. Measures vendor adherence to contractual obligations."
    - name: "avg_responsiveness_rating"
      expr: AVG(CAST(responsiveness_rating AS DOUBLE))
      comment: "Average vendor responsiveness rating. Measures service quality and issue resolution speed."
    - name: "total_spend_under_evaluation"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total spend amount covered by vendor performance evaluations. Measures evaluation program spend coverage."
    - name: "preferred_vendor_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN preferred_vendor_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of evaluated vendors with preferred status. Tracks preferred vendor program penetration."
    - name: "sustainability_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainability_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vendors meeting sustainability compliance requirements. ESG sourcing KPI."
    - name: "avg_cost_competitiveness_rating"
      expr: AVG(CAST(cost_competitiveness_rating AS DOUBLE))
      comment: "Average cost competitiveness rating. Measures vendor price positioning relative to market."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`procurement_vendor_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ response and vendor quotation KPIs. Enables sourcing teams to evaluate competitive bidding outcomes, price competitiveness, and award decisions to optimize sourcing strategy."
  source: "`vibe_travel_hospitality_v1`.`procurement`.`vendor_quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Current status of the vendor quotation (e.g. Received, Evaluated, Awarded, Rejected)."
    - name: "currency_code"
      expr: currency_code
      comment: "Quotation currency for multi-currency price comparison."
    - name: "award_recommendation_flag"
      expr: award_recommendation_flag
      comment: "Indicates whether this quotation was recommended for award. Used to track award decision quality."
    - name: "specification_compliance_flag"
      expr: specification_compliance_flag
      comment: "Indicates whether vendor met specification requirements. Filters non-compliant bids."
    - name: "sustainability_compliance_flag"
      expr: sustainability_compliance_flag
      comment: "Indicates ESG/sustainability compliance in the quotation. Supports responsible sourcing."
    - name: "quotation_received_month"
      expr: DATE_TRUNC('MONTH', quotation_received_date)
      comment: "Month quotation was received for sourcing cycle analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms on the quotation for logistics cost comparison."
  measures:
    - name: "total_quotation_count"
      expr: COUNT(1)
      comment: "Total number of vendor quotations received. Measures competitive bidding participation."
    - name: "total_quoted_amount"
      expr: SUM(CAST(quoted_total_amount AS DOUBLE))
      comment: "Total value of all quotations received. Measures sourcing pipeline value."
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price across all bids. Baseline for price benchmarking and negotiation."
    - name: "avg_vendor_score"
      expr: AVG(CAST(vendor_score AS DOUBLE))
      comment: "Average vendor evaluation score across quotations. Measures overall bid quality."
    - name: "specification_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN specification_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotations meeting specification requirements. Measures vendor capability alignment."
    - name: "award_recommendation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN award_recommendation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quotations recommended for award. Measures competitive bid success rate."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct vendors submitting quotations. Measures competitive market participation."
    - name: "avg_quoted_quantity"
      expr: AVG(CAST(quoted_quantity AS DOUBLE))
      comment: "Average quoted quantity per bid. Supports volume-price analysis and MOQ benchmarking."
$$;
