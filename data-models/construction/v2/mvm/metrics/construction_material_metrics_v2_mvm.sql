-- Metric views for domain: material | Business: Construction | Version: 2 | Generated on: 2026-06-27 01:50:09

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_level`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and availability metrics derived from current stock level snapshots. Supports decisions on reorder triggers, capital tied up in inventory, and warehouse utilisation."
  source: "`vibe_construction_v1`.`material`.`stock_level`"
  dimensions:
    - name: "material_code"
      expr: material_code
      comment: "Material identifier code for grouping stock metrics by material type."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse foreign key enabling stock analysis by storage location."
    - name: "location_code"
      expr: location_code
      comment: "Physical storage location within a warehouse for granular inventory tracking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for normalising quantity comparisons across materials."
    - name: "stock_level_status"
      expr: stock_level_status
      comment: "Current status of the stock record (e.g. Active, Blocked, Expired) for filtering operational stock."
    - name: "lot_number"
      expr: lot_number
      comment: "Lot number dimension for traceability and batch-level stock analysis."
    - name: "last_movement_type"
      expr: last_movement_type
      comment: "Type of the most recent stock movement (e.g. GR, GI, Transfer) to understand inventory activity patterns."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical stock on hand across all selected warehouses and materials. Core inventory availability KPI used in supply planning and procurement decisions."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity already committed to open orders or work orders. Indicates how much of on-hand stock is already allocated and unavailable for new demand."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for planned consumption. Helps procurement teams understand future demand obligations against current stock."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked due to quality holds or inspection. High blocked quantities signal quality or compliance issues requiring management intervention."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit between warehouses or from suppliers. Critical for supply chain visibility and avoiding unnecessary re-orders."
    - name: "total_quality_inspection_quantity"
      expr: SUM(CAST(quality_inspection_quantity AS DOUBLE))
      comment: "Total quantity currently under quality inspection. Elevated values indicate potential supply disruption risk if materials fail inspection."
    - name: "available_quantity"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE) - CAST(committed_quantity AS DOUBLE) - CAST(reserved_quantity AS DOUBLE) - CAST(blocked_quantity AS DOUBLE))
      comment: "Net available quantity calculated as on-hand minus committed, reserved, and blocked quantities. The true free-to-use stock figure for operational planning."
    - name: "total_inventory_value"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE) * CAST(cost_per_unit AS DOUBLE))
      comment: "Total monetary value of on-hand inventory (quantity × cost per unit). Key capital-tied-up metric for finance and procurement leadership."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average unit cost across stock records. Used to benchmark procurement pricing and identify cost outliers by material or supplier."
    - name: "stock_below_reorder_point_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN stock_level_id END)
      comment: "Number of stock records where on-hand quantity has fallen below the reorder point. Directly triggers procurement action to avoid material shortages on site."
    - name: "stock_below_safety_stock_count"
      expr: COUNT(CASE WHEN quantity_on_hand < safety_stock THEN stock_level_id END)
      comment: "Number of stock records below safety stock threshold. A leading indicator of critical shortage risk that demands immediate escalation."
    - name: "stock_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(committed_quantity AS DOUBLE) + CAST(reserved_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock already committed or reserved. High utilisation signals tight supply and potential inability to fulfil new demand without replenishment."
    - name: "blocked_stock_pct"
      expr: ROUND(100.0 * SUM(CAST(blocked_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand stock that is blocked. A quality and compliance KPI — high values indicate systemic inspection or supplier quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material consumption and issuance metrics tracking the flow of materials from warehouse to site. Supports cost control, compliance monitoring, and consumption efficiency analysis."
  source: "`vibe_construction_v1`.`material`.`goods_issue`"
  dimensions:
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Current status of the goods issue document (e.g. Posted, Reversed, Pending) for filtering active vs. cancelled transactions."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the goods issue. Enables analysis of approval bottlenecks and compliance adherence."
    - name: "issue_reason"
      expr: issue_reason
      comment: "Business reason for the goods issue (e.g. Construction, Maintenance, Scrap). Supports consumption analysis by purpose."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the issued material. Required for HSE reporting and regulatory compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods issue transaction for multi-currency cost analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection outcome for the issued goods. Tracks quality gate compliance at point of issue."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master foreign key for grouping consumption metrics by material type."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Source warehouse for the goods issue, enabling consumption analysis by storage location."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost centre responsible for the goods issue, enabling cost allocation and budget tracking."
    - name: "is_returned"
      expr: is_returned
      comment: "Flag indicating whether this goods issue is a return transaction. Separates consumption from return flows in analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance indicator for the goods issue. Non-compliant issues require immediate investigation and corrective action."
  measures:
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity of materials issued to site. Primary consumption volume KPI for material planning and waste analysis."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all goods issued. Core cost-of-materials-consumed metric used in project cost control and budget variance analysis."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of goods issued (excluding tax). Used for project cost reporting and financial reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on goods issued. Required for tax compliance reporting and financial close processes."
    - name: "avg_net_amount_per_issue"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per goods issue transaction. Benchmarks typical issue size and helps detect abnormally large or small transactions."
    - name: "non_compliant_issue_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN goods_issue_id END)
      comment: "Number of goods issues flagged as non-compliant. A critical HSE and audit KPI — any non-zero value demands investigation."
    - name: "non_compliant_issue_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = FALSE THEN goods_issue_id END) / NULLIF(COUNT(goods_issue_id), 0), 2)
      comment: "Percentage of goods issues that are non-compliant. Tracks compliance rate trend for regulatory and internal audit purposes."
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE THEN goods_issue_id END)
      comment: "Number of goods issues requiring inspection. Indicates quality gate workload and potential bottlenecks in material release."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN goods_issue_id END)
      comment: "Number of goods issues awaiting approval. High pending counts indicate workflow bottlenecks that delay site material availability."
    - name: "return_issue_count"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN goods_issue_id END)
      comment: "Number of goods issues that are returns. High return rates signal over-issuance, planning inefficiency, or material quality problems."
    - name: "return_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_returned = TRUE THEN goods_issue_id END) / NULLIF(COUNT(goods_issue_id), 0), 2)
      comment: "Percentage of goods issues that are returns. A material planning efficiency KPI — high return rates increase handling costs and indicate demand forecasting gaps."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_mto_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Take-Off (MTO) line-level metrics tracking material requirements, procurement progress, and cost estimates against design quantities. Supports procurement planning, schedule adherence, and cost control."
  source: "`vibe_construction_v1`.`material`.`mto_line`"
  dimensions:
    - name: "mto_status"
      expr: mto_status
      comment: "Current status of the MTO line (e.g. Draft, Approved, Procured) for pipeline stage analysis."
    - name: "procurement_status"
      expr: procurement_status
      comment: "Procurement progress status of the MTO line. Enables tracking of materials through the procurement lifecycle."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline (e.g. Civil, Mechanical, Electrical) for cross-discipline material demand analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating whether the material is on the critical path. Critical materials require priority procurement attention."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating hazardous material classification. Required for HSE planning and regulatory compliance."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity comparisons across MTO lines."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost estimate analysis in multi-currency project environments."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master foreign key for grouping MTO metrics by material type."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost centre for budget allocation and cost tracking of material requirements."
    - name: "mto_header_id"
      expr: mto_header_id
      comment: "Parent MTO header for roll-up analysis of line-level metrics to document level."
  measures:
    - name: "total_design_quantity"
      expr: SUM(CAST(design_quantity AS DOUBLE))
      comment: "Total design quantity across MTO lines. Baseline material demand figure used in procurement planning and budget estimation."
    - name: "total_net_required_quantity"
      expr: SUM(CAST(net_required_quantity AS DOUBLE))
      comment: "Total net quantity required after accounting for existing stock and commitments. The actionable procurement demand figure."
    - name: "total_actual_received_quantity"
      expr: SUM(CAST(actual_received_quantity AS DOUBLE))
      comment: "Total quantity actually received against MTO requirements. Measures procurement fulfilment progress against plan."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all MTO lines. Primary material budget commitment figure used in project cost forecasting."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost variance between estimated and actual costs on MTO lines. Negative variance indicates cost overrun — a key project financial health indicator."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between required and received quantities. Persistent positive variance signals procurement delays or supply chain failures."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across MTO lines. Used to benchmark material pricing and identify cost outliers by discipline or material type."
    - name: "critical_line_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN mto_line_id END)
      comment: "Number of MTO lines flagged as critical path materials. Executives use this to prioritise procurement resources and mitigate schedule risk."
    - name: "procurement_fulfilment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(net_required_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of net required quantity that has been received. Core procurement performance KPI — low fulfilment against schedule triggers escalation."
    - name: "cost_variance_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_estimated_cost AS DOUBLE)), 0), 2)
      comment: "Cost variance as a percentage of total estimated cost. Measures budget accuracy and procurement cost control effectiveness."
    - name: "wastage_adjusted_quantity"
      expr: SUM(CAST(net_required_quantity AS DOUBLE) * CAST(wastage_factor AS DOUBLE))
      comment: "Total quantity adjusted for wastage factors. Provides a realistic procurement quantity target that accounts for expected material losses during construction."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material requisition metrics tracking demand initiation, approval cycle performance, and cost estimation accuracy. Supports procurement efficiency, budget control, and emergency supply risk management."
  source: "`vibe_construction_v1`.`material`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current lifecycle status of the requisition (e.g. Draft, Submitted, Approved, Fulfilled) for pipeline stage analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status. Enables identification of approval bottlenecks that delay material availability on site."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfilment status of the requisition. Tracks how effectively demand is being met by procurement and warehouse teams."
    - name: "priority"
      expr: priority
      comment: "Priority level of the requisition (e.g. High, Medium, Low). Enables prioritised workload management in procurement."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating emergency requisitions. High emergency rates signal poor planning and carry premium procurement costs."
    - name: "is_stock_available"
      expr: is_stock_available
      comment: "Flag indicating whether stock was available at time of requisition. Supports make-vs-buy and inventory optimisation decisions."
    - name: "requester_department"
      expr: requester_department
      comment: "Department originating the requisition. Enables demand analysis by organisational unit for budget allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost estimate for multi-currency project environments."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost centre for budget tracking and cost allocation of material demand."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master foreign key for demand analysis by material type."
    - name: "safety_review_status"
      expr: safety_review_status
      comment: "Safety review outcome for the requisition. Non-reviewed or failed safety reviews represent HSE compliance risk."
  measures:
    - name: "total_requisition_count"
      expr: COUNT(requisition_id)
      comment: "Total number of material requisitions. Baseline demand volume metric used to track procurement workload and planning effectiveness."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of materials requested across all requisitions. Measures aggregate material demand for supply planning."
    - name: "total_cost_estimate_gross"
      expr: SUM(CAST(cost_estimate_gross AS DOUBLE))
      comment: "Total gross cost estimate across all requisitions. Provides a forward-looking view of committed material spend for budget management."
    - name: "total_cost_estimate_net"
      expr: SUM(CAST(cost_estimate_net AS DOUBLE))
      comment: "Total net cost estimate (excluding tax). Used in project cost forecasting and budget variance analysis."
    - name: "total_cost_estimate_tax"
      expr: SUM(CAST(cost_estimate_tax AS DOUBLE))
      comment: "Total estimated tax on requisitions. Required for tax liability forecasting and financial close processes."
    - name: "emergency_requisition_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN requisition_id END)
      comment: "Number of emergency requisitions. High emergency counts indicate planning failures and carry significant cost premiums that erode project margins."
    - name: "emergency_requisition_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency = TRUE THEN requisition_id END) / NULLIF(COUNT(requisition_id), 0), 2)
      comment: "Percentage of requisitions classified as emergency. A planning maturity KPI — industry best practice targets below 5%; higher rates signal systemic planning deficiencies."
    - name: "stock_available_fulfilment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stock_available = TRUE THEN requisition_id END) / NULLIF(COUNT(requisition_id), 0), 2)
      comment: "Percentage of requisitions where stock was available at time of request. High rates indicate effective inventory management; low rates signal chronic stock-out risk."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN requisition_id END)
      comment: "Number of requisitions awaiting approval. Approval backlogs directly delay material availability and can cause site stoppages."
    - name: "avg_cost_estimate_per_requisition"
      expr: AVG(CAST(cost_estimate_net AS DOUBLE))
      comment: "Average net cost estimate per requisition. Benchmarks typical requisition value and helps detect abnormally large requests that warrant additional scrutiny."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_batch_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch and lot quality, traceability, and cost metrics. Supports quality assurance, supplier performance evaluation, and material compliance reporting."
  source: "`vibe_construction_v1`.`material`.`batch_lot`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (e.g. Released, Quarantined, Rejected) for quality pipeline analysis."
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Quarantine status of the batch. Quarantined batches represent blocked supply and potential project delay risk."
    - name: "supplier"
      expr: supplier
      comment: "Supplier name for supplier quality performance benchmarking and sourcing decisions."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer of the batch material. Enables manufacturer-level quality and compliance analysis."
    - name: "inspection_passed"
      expr: inspection_passed
      comment: "Boolean flag indicating whether the batch passed inspection. Core quality gate KPI for material acceptance."
    - name: "test_passed"
      expr: test_passed
      comment: "Boolean flag indicating whether the batch passed material testing. Distinguishes inspection pass from full test compliance."
    - name: "lot_traceability_flag"
      expr: lot_traceability_flag
      comment: "Flag indicating whether full lot traceability is enabled. Required for regulatory compliance and quality audit trails."
    - name: "currency"
      expr: currency
      comment: "Currency of the batch cost for multi-currency cost analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master foreign key for grouping batch metrics by material type."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse where the batch is stored for location-based quality and inventory analysis."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Disposal method for rejected or expired batches. Tracks waste management compliance and disposal costs."
  measures:
    - name: "total_batch_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all batch lots. Measures aggregate material volume in the batch management system."
    - name: "total_batch_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of all batch lots. Represents the financial value of batched inventory — key for working capital and inventory valuation reporting."
    - name: "avg_unit_weight_kg"
      expr: AVG(CAST(unit_weight AS DOUBLE))
      comment: "Average unit weight across batches. Used in logistics planning, freight cost estimation, and storage capacity management."
    - name: "avg_unit_volume"
      expr: AVG(CAST(unit_volume AS DOUBLE))
      comment: "Average unit volume across batches. Supports warehouse space planning and transportation optimisation."
    - name: "inspection_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_passed = TRUE THEN batch_lot_id END) / NULLIF(COUNT(batch_lot_id), 0), 2)
      comment: "Percentage of batches that passed inspection. Primary supplier and material quality KPI — declining rates trigger supplier review or material substitution decisions."
    - name: "test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_passed = TRUE THEN batch_lot_id END) / NULLIF(COUNT(batch_lot_id), 0), 2)
      comment: "Percentage of batches that passed material testing. Measures compliance with technical specifications — critical for structural and safety-critical materials."
    - name: "quarantined_batch_count"
      expr: COUNT(CASE WHEN quarantine_status IS NOT NULL AND quarantine_status != 'Released' THEN batch_lot_id END)
      comment: "Number of batches currently under quarantine. Quarantined batches represent blocked supply — high counts signal quality or supplier issues requiring immediate action."
    - name: "quarantined_quantity"
      expr: SUM(CASE WHEN quarantine_status IS NOT NULL AND quarantine_status != 'Released' THEN quantity ELSE 0 END)
      comment: "Total quantity of material under quarantine. Measures the volume of supply at risk due to quality holds — directly impacts site material availability."
    - name: "avg_cost_per_batch"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per batch lot. Benchmarks batch procurement economics and supports supplier cost comparison."
    - name: "traceability_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN lot_traceability_flag = TRUE THEN batch_lot_id END) / NULLIF(COUNT(batch_lot_id), 0), 2)
      comment: "Percentage of batches with full lot traceability enabled. Regulatory and quality compliance KPI — gaps in traceability create audit and liability exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock movement and goods receipt metrics tracking material inflows, freight costs, and receipt quality. Supports supplier delivery performance, cost control, and compliance monitoring."
  source: "`vibe_construction_v1`.`material`.`stock_movement`"
  dimensions:
    - name: "goods_receipt_type"
      expr: goods_receipt_type
      comment: "Type of goods receipt (e.g. Purchase Order, Transfer, Return) for movement classification and analysis."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g. Posted, Pending, Reversed). Enables tracking of receipt processing completeness."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection outcome for the received goods. Tracks supplier quality at point of receipt."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the stock movement. Non-compliant movements require investigation and corrective action."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency cost analysis."
    - name: "is_critical_material"
      expr: is_critical_material
      comment: "Flag indicating critical path materials. Enables focused monitoring of high-priority material receipts."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating hazardous material movements. Required for HSE compliance and regulatory reporting."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master foreign key for grouping movement metrics by material type."
    - name: "source_warehouse_id"
      expr: source_warehouse_id
      comment: "Source warehouse for transfer movements, enabling inter-warehouse flow analysis."
    - name: "accounting_entry_posted"
      expr: accounting_entry_posted
      comment: "Flag indicating whether the accounting entry has been posted. Unposted entries represent financial close risk."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost centre code for cost allocation of material movements."
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of materials received across all stock movements. Primary supply inflow volume metric for procurement performance tracking."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all stock movements. Measures total material spend flowing through the supply chain — key for cost control and budget tracking."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of stock movements (excluding tax). Used in financial reporting and project cost reconciliation."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight and logistics cost across all stock movements. Freight cost as a percentage of material value is a key supply chain efficiency KPI."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on stock movements. Required for tax compliance reporting and financial close."
    - name: "avg_freight_cost_per_movement"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per stock movement. Benchmarks logistics efficiency and supports freight contract negotiations."
    - name: "freight_cost_pct_of_net"
      expr: ROUND(100.0 * SUM(CAST(freight_cost AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Freight cost as a percentage of net material value. A supply chain efficiency ratio — high values indicate logistics cost overruns that erode project margins."
    - name: "unposted_accounting_entry_count"
      expr: COUNT(CASE WHEN accounting_entry_posted = FALSE THEN stock_movement_id END)
      comment: "Number of stock movements where the accounting entry has not been posted. Unposted entries create financial reporting gaps and period-close risk."
    - name: "non_compliant_movement_count"
      expr: COUNT(CASE WHEN compliance_status != 'Compliant' THEN stock_movement_id END)
      comment: "Number of stock movements with non-compliant status. Compliance failures in material movements carry regulatory and contractual risk."
    - name: "delivery_on_time_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN stock_movement_id END)
      comment: "Number of stock movements delivered on or before the expected delivery date. Measures supplier on-time delivery performance — a key procurement KPI."
    - name: "on_time_delivery_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN stock_movement_id END) / NULLIF(COUNT(stock_movement_id), 0), 2)
      comment: "Percentage of stock movements delivered on time. Core supplier performance KPI used in vendor scorecards and contract renewal decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_boq_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Quantities (BOQ) line metrics tracking contracted material quantities, unit rates, and total values. Supports contract management, change order analysis, and budget baseline control."
  source: "`vibe_construction_v1`.`material`.`boq_line`"
  dimensions:
    - name: "material_boq_line_status"
      expr: material_boq_line_status
      comment: "Current status of the BOQ line (e.g. Active, Revised, Cancelled) for contract scope analysis."
    - name: "trade_discipline"
      expr: trade_discipline
      comment: "Trade or engineering discipline for the BOQ line. Enables cross-discipline cost and quantity analysis."
    - name: "is_change_order"
      expr: is_change_order
      comment: "Flag indicating whether the BOQ line originated from a change order. Separates original scope from variation work for contract management."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity comparisons across BOQ lines."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master foreign key for grouping BOQ metrics by material type."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost centre for budget allocation and cost tracking of BOQ lines."
    - name: "revision_number"
      expr: revision_number
      comment: "Revision number of the BOQ line. Enables tracking of scope changes and contract evolution over time."
  measures:
    - name: "total_contract_quantity"
      expr: SUM(CAST(contract_quantity AS DOUBLE))
      comment: "Total contracted quantity across all BOQ lines. Defines the material scope baseline for the contract — deviations drive change orders and cost claims."
    - name: "total_boq_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total current quantity across BOQ lines (including revisions). Compared against contract quantity to measure scope growth."
    - name: "total_boq_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total monetary value of all BOQ lines. Represents the contracted material budget baseline — the primary financial reference for project cost control."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across BOQ lines. Used to benchmark pricing against market rates and identify over-priced line items in contract negotiations."
    - name: "change_order_line_count"
      expr: COUNT(CASE WHEN is_change_order = TRUE THEN boq_line_id END)
      comment: "Number of BOQ lines originating from change orders. High change order counts indicate scope instability and contract management challenges."
    - name: "change_order_value"
      expr: SUM(CASE WHEN is_change_order = TRUE THEN total_value ELSE 0 END)
      comment: "Total value of change order BOQ lines. Measures the financial impact of scope changes — a key contract management and client billing KPI."
    - name: "change_order_value_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_change_order = TRUE THEN total_value ELSE 0 END) / NULLIF(SUM(CAST(total_value AS DOUBLE)), 0), 2)
      comment: "Change order value as a percentage of total BOQ value. Measures scope creep intensity — high percentages signal poor initial scope definition or client-driven changes."
    - name: "quantity_variance"
      expr: SUM(CAST(quantity AS DOUBLE) - CAST(contract_quantity AS DOUBLE))
      comment: "Total variance between current quantity and contracted quantity across all BOQ lines. Positive variance indicates scope growth that may require additional funding or change order claims."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity, certification, and operational readiness metrics. Supports facility management, HSE compliance, and storage capacity planning decisions."
  source: "`vibe_construction_v1`.`material`.`warehouse`"
  dimensions:
    - name: "warehouse_status"
      expr: warehouse_status
      comment: "Operational status of the warehouse (e.g. Active, Inactive, Under Maintenance) for availability analysis."
    - name: "warehouse_type"
      expr: warehouse_type
      comment: "Type of warehouse (e.g. Bulk, Hazardous, Cold Storage) for capacity planning by storage category."
    - name: "country_code"
      expr: country_code
      comment: "Country where the warehouse is located for geographic distribution analysis."
    - name: "city"
      expr: city
      comment: "City location of the warehouse for regional capacity and logistics planning."
    - name: "is_hazardous_material_certified"
      expr: is_hazardous_material_certified
      comment: "Flag indicating whether the warehouse is certified for hazardous material storage. Critical for HSE compliance and material routing decisions."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Flag indicating temperature-controlled storage capability. Required for materials with specific storage requirements."
    - name: "climate_control_type"
      expr: climate_control_type
      comment: "Type of climate control system. Supports matching of material storage requirements to warehouse capabilities."
    - name: "security_level"
      expr: security_level
      comment: "Security classification of the warehouse. Relevant for high-value or sensitive material storage decisions."
    - name: "site_id"
      expr: site_id
      comment: "Project site foreign key for grouping warehouse metrics by site."
  measures:
    - name: "total_capacity_area_sqm"
      expr: SUM(CAST(capacity_area_sqm AS DOUBLE))
      comment: "Total warehouse floor area capacity in square metres. Baseline storage capacity metric for facility planning and site logistics."
    - name: "total_capacity_weight_tonnes"
      expr: SUM(CAST(capacity_weight_tonnes AS DOUBLE))
      comment: "Total weight capacity across all warehouses in tonnes. Critical for heavy material storage planning and structural compliance."
    - name: "avg_capacity_area_sqm"
      expr: AVG(CAST(capacity_area_sqm AS DOUBLE))
      comment: "Average warehouse floor area. Benchmarks warehouse size for facility investment and expansion planning."
    - name: "hazmat_certified_warehouse_count"
      expr: COUNT(CASE WHEN is_hazardous_material_certified = TRUE THEN warehouse_id END)
      comment: "Number of warehouses certified for hazardous material storage. Insufficient hazmat capacity creates HSE compliance risk and operational constraints."
    - name: "hazmat_certified_capacity_sqm"
      expr: SUM(CASE WHEN is_hazardous_material_certified = TRUE THEN capacity_area_sqm ELSE 0 END)
      comment: "Total floor area of hazmat-certified warehouses. Measures available compliant storage capacity for hazardous materials across the project portfolio."
    - name: "temperature_controlled_capacity_sqm"
      expr: SUM(CASE WHEN temperature_controlled = TRUE THEN capacity_area_sqm ELSE 0 END)
      comment: "Total floor area of temperature-controlled warehouses. Ensures sufficient compliant storage for temperature-sensitive materials."
    - name: "certification_expiry_within_90_days_count"
      expr: COUNT(CASE WHEN certification_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND certification_expiry_date >= CURRENT_DATE() THEN warehouse_id END)
      comment: "Number of warehouses with certifications expiring within 90 days. A compliance risk KPI — expired certifications can result in regulatory penalties and forced warehouse closure."
    - name: "inspection_overdue_count"
      expr: COUNT(CASE WHEN next_inspection_due < CURRENT_DATE() THEN warehouse_id END)
      comment: "Number of warehouses with overdue inspections. Overdue inspections represent HSE compliance failures and potential liability exposure."
$$;