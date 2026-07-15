-- Metric views for domain: material | Business: Construction | Version: 2 | Generated on: 2026-07-10 12:14:04

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_level`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and stock position metrics across materials and warehouses. Drives replenishment decisions, safety stock compliance, and working capital optimization."
  source: "`vibe_construction_v1`.`material`.`stock_level`"
  dimensions:
    - name: "material_code"
      expr: material_code
      comment: "Material code for grouping stock metrics by material identity."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for contextualizing quantity metrics."
    - name: "stock_level_status"
      expr: stock_level_status
      comment: "Current stock status (e.g., active, blocked, in-transit) for filtering and segmentation."
    - name: "last_movement_type"
      expr: last_movement_type
      comment: "Type of last stock movement (receipt, issue, transfer) for activity analysis."
    - name: "location_code"
      expr: location_code
      comment: "Storage location code within the warehouse for granular inventory positioning."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical stock on hand across all locations. Core inventory position metric used by procurement and operations to assess availability."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for open orders. Indicates committed stock that cannot be reallocated, critical for available-to-promise calculations."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed to project activities. Drives procurement planning by showing how much stock is already allocated."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked (e.g., quality hold, damaged). High blocked quantity signals quality or handling issues requiring management intervention."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit between warehouses or from suppliers. Used to project near-term availability."
    - name: "total_quality_inspection_quantity"
      expr: SUM(CAST(quality_inspection_quantity AS DOUBLE))
      comment: "Total quantity under quality inspection. Elevated values indicate inspection bottlenecks that may delay project material availability."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average unit cost across stock records. Used for inventory valuation benchmarking and cost trend analysis."
    - name: "total_available_quantity"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE) - CAST(reserved_quantity AS DOUBLE) - CAST(blocked_quantity AS DOUBLE))
      comment: "Net available quantity (on-hand minus reserved and blocked). The primary metric for procurement decisions — if this falls below reorder point, action is required."
    - name: "stock_below_safety_stock_count"
      expr: COUNT(CASE WHEN quantity_on_hand < safety_stock THEN 1 END)
      comment: "Number of material-location combinations where on-hand quantity is below safety stock threshold. A leading indicator of stockout risk requiring urgent replenishment."
    - name: "stock_below_reorder_point_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Number of material-location combinations where stock has fallen below reorder point. Triggers procurement action to avoid project delays."
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_code)
      comment: "Number of distinct materials tracked in inventory. Indicates portfolio breadth and complexity of inventory management."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material consumption and goods issue performance metrics. Tracks material flow from warehouse to project activities, enabling cost control and compliance monitoring."
  source: "`vibe_construction_v1`.`material`.`goods_issue`"
  dimensions:
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Current status of the goods issue (e.g., pending, approved, issued, returned) for pipeline analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the goods issue for governance and compliance tracking."
    - name: "issue_reason"
      expr: issue_reason
      comment: "Business reason for the goods issue (e.g., project consumption, return, scrap) for cost categorization."
    - name: "material_description"
      expr: material_description
      comment: "Description of the material issued for business-readable reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity metrics."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods issue transaction for multi-currency analysis."
    - name: "is_returned"
      expr: is_returned
      comment: "Flag indicating whether this goods issue is a return transaction, enabling return rate analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance flag indicating whether the goods issue meets regulatory requirements."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the issued material for safety and regulatory reporting."
  measures:
    - name: "total_goods_issues"
      expr: COUNT(1)
      comment: "Total number of goods issue transactions. Baseline volume metric for material consumption activity."
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity of materials issued from warehouse. Core throughput metric for material consumption tracking against project budgets."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of materials issued. Primary financial metric for material cost tracking against project budgets."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of materials issued (excluding tax). Used for cost accounting and budget variance analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on goods issues. Required for tax compliance reporting and financial reconciliation."
    - name: "avg_gross_amount_per_issue"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross value per goods issue transaction. Benchmarks typical issue size and detects anomalous high-value transactions."
    - name: "return_transaction_count"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Number of goods issue return transactions. High return counts indicate material quality issues, over-ordering, or project scope changes."
    - name: "non_compliant_issue_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of goods issues flagged as non-compliant. A critical risk metric — non-compliant material usage can trigger regulatory penalties and project shutdowns."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'PENDING' THEN 1 END)
      comment: "Number of goods issues awaiting approval. Backlog in approvals can delay project material availability and cause schedule slippage."
    - name: "hazardous_material_issue_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE THEN 1 END)
      comment: "Number of goods issues requiring inspection (typically hazardous or regulated materials). Tracks compliance burden and inspection resource demand."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_wastage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material wastage and loss metrics for cost control, sustainability reporting, and regulatory compliance. Wastage directly impacts project profitability and environmental obligations."
  source: "`vibe_construction_v1`.`material`.`wastage`"
  dimensions:
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste (e.g., construction debris, hazardous, recyclable) for waste stream analysis and regulatory reporting."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of waste disposal (e.g., landfill, recycling, incineration) for sustainability and compliance tracking."
    - name: "wastage_status"
      expr: wastage_status
      comment: "Current status of the wastage record for pipeline and approval tracking."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating hazardous waste for regulatory segregation and reporting."
    - name: "is_recyclable"
      expr: is_recyclable
      comment: "Flag indicating recyclable waste for sustainability KPI tracking."
    - name: "material_code"
      expr: material_code
      comment: "Material code of the wasted material for material-level wastage analysis."
    - name: "cause"
      expr: cause
      comment: "Root cause of wastage (e.g., over-ordering, damage, design change) for corrective action targeting."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for time-series wastage trend analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based wastage metrics."
  measures:
    - name: "total_wastage_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of material wasted. Primary volume metric for wastage — directly linked to sustainability targets and material efficiency KPIs."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity of material for the activities generating wastage. Used as denominator for wastage rate calculations."
    - name: "total_actual_quantity_consumed"
      expr: SUM(CAST(actual_quantity_consumed AS DOUBLE))
      comment: "Total actual quantity consumed including wastage. Compared against planned to compute over-consumption variance."
    - name: "total_waste_cost_gross"
      expr: SUM(CAST(waste_cost_gross AS DOUBLE))
      comment: "Total gross cost of material wastage. Directly impacts project profitability — a key metric for cost control reviews."
    - name: "total_waste_cost_net"
      expr: SUM(CAST(waste_cost_net AS DOUBLE))
      comment: "Total net cost of material wastage (excluding tax adjustments). Used for budget variance and cost-to-complete analysis."
    - name: "total_waste_cost_adjustment"
      expr: SUM(CAST(waste_cost_adjustment AS DOUBLE))
      comment: "Total cost adjustments applied to wastage records (e.g., credits, recoveries). Tracks financial mitigation of waste costs."
    - name: "avg_wastage_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average wastage percentage across records. Benchmarks material efficiency — industry targets typically below 5%; values above trigger investigation."
    - name: "hazardous_wastage_count"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END)
      comment: "Number of hazardous waste records. Regulatory compliance metric — each hazardous waste event requires documented disposal and may trigger authority notification."
    - name: "recyclable_wastage_count"
      expr: COUNT(CASE WHEN is_recyclable = TRUE THEN 1 END)
      comment: "Number of recyclable waste records. Sustainability KPI tracking diversion from landfill — used in ESG reporting."
    - name: "distinct_waste_materials_count"
      expr: COUNT(DISTINCT material_code)
      comment: "Number of distinct materials generating wastage. High diversity indicates systemic over-ordering or poor material planning across the project."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material receipt and stock movement performance metrics. Tracks goods receipt quality, delivery performance, and financial posting accuracy for procurement-to-inventory cycle."
  source: "`vibe_construction_v1`.`material`.`stock_movement`"
  dimensions:
    - name: "goods_receipt_type"
      expr: goods_receipt_type
      comment: "Type of goods receipt (e.g., purchase order, return, transfer) for movement categorization."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g., posted, pending, reversed) for pipeline and reconciliation analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status of received goods for quality gate monitoring."
    - name: "material_code"
      expr: material_code
      comment: "Material code for grouping movement metrics by material."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency financial analysis."
    - name: "is_critical_material"
      expr: is_critical_material
      comment: "Flag for critical path materials where delays directly impact project schedule."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Hazardous material flag for safety and compliance segmentation."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the stock movement for regulatory tracking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity metrics."
  measures:
    - name: "total_stock_movements"
      expr: COUNT(1)
      comment: "Total number of stock movement transactions. Baseline activity volume for warehouse operations benchmarking."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of materials received into stock. Core supply chain throughput metric for procurement performance tracking."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of stock movements. Primary financial metric for goods receipt valuation and accounts payable matching."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of stock movements. Used for cost accounting and budget consumption tracking."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight and logistics cost for received materials. Tracks logistics spend as a component of total material cost."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on stock movements. Required for tax compliance and financial reconciliation."
    - name: "accounting_posted_count"
      expr: COUNT(CASE WHEN accounting_entry_posted = TRUE THEN 1 END)
      comment: "Number of movements with accounting entries posted. Unposted movements represent financial exposure — gap between this and total movements is a close risk."
    - name: "unposted_movement_count"
      expr: COUNT(CASE WHEN accounting_entry_posted = FALSE THEN 1 END)
      comment: "Number of stock movements not yet posted to accounting. A critical financial close metric — high unposted counts delay period-end reporting."
    - name: "critical_material_receipt_count"
      expr: COUNT(CASE WHEN is_critical_material = TRUE THEN 1 END)
      comment: "Number of receipts for critical path materials. Tracks supply chain performance for materials that directly impact project schedule."
    - name: "avg_gross_amount_per_movement"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross value per stock movement. Benchmarks transaction size and identifies anomalous high-value receipts requiring additional scrutiny."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material requisition cycle metrics tracking procurement demand, approval efficiency, and cost estimation accuracy. Drives procurement planning and budget control."
  source: "`vibe_construction_v1`.`material`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (e.g., draft, submitted, approved, fulfilled) for pipeline analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for governance and bottleneck identification in the approval workflow."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status indicating whether the requisition has been sourced and delivered."
    - name: "priority"
      expr: priority
      comment: "Requisition priority (e.g., urgent, normal, low) for workload prioritization and SLA tracking."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag for emergency requisitions that bypass standard lead times, indicating planning failures."
    - name: "requester_department"
      expr: requester_department
      comment: "Department originating the requisition for demand analysis by organizational unit."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost estimate metrics."
    - name: "safety_review_status"
      expr: safety_review_status
      comment: "Safety review status for hazardous material requisitions — compliance gate tracking."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of material requisitions. Baseline demand volume metric for procurement capacity planning."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of materials requested across all requisitions. Drives procurement volume planning and supplier capacity negotiations."
    - name: "total_cost_estimate_gross"
      expr: SUM(CAST(cost_estimate_gross AS DOUBLE))
      comment: "Total gross cost estimate for all requisitions. Primary budget commitment indicator — used to assess procurement spend pipeline against project budgets."
    - name: "total_cost_estimate_net"
      expr: SUM(CAST(cost_estimate_net AS DOUBLE))
      comment: "Total net cost estimate (excluding tax). Used for budget variance analysis and cost-to-complete forecasting."
    - name: "total_cost_estimate_tax"
      expr: SUM(CAST(cost_estimate_tax AS DOUBLE))
      comment: "Total estimated tax on requisitions. Required for tax planning and cash flow forecasting."
    - name: "emergency_requisition_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN 1 END)
      comment: "Number of emergency requisitions. High emergency counts signal poor material planning, leading to premium procurement costs and schedule risk."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'PENDING' THEN 1 END)
      comment: "Number of requisitions awaiting approval. Approval backlog directly delays procurement and can cause project material shortages."
    - name: "avg_cost_estimate_gross"
      expr: AVG(CAST(cost_estimate_gross AS DOUBLE))
      comment: "Average gross cost estimate per requisition. Benchmarks typical procurement transaction size and identifies outliers requiring additional approval scrutiny."
    - name: "distinct_materials_requested"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct materials being requisitioned. Indicates procurement complexity and potential for consolidation to achieve volume discounts."
    - name: "stock_available_requisition_count"
      expr: COUNT(CASE WHEN is_stock_available = TRUE THEN 1 END)
      comment: "Number of requisitions where stock is already available in warehouse. High ratio indicates over-requisitioning and poor inventory visibility."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_physical_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count accuracy and variance metrics. Tracks discrepancies between system book quantities and physical counts, driving inventory accuracy improvement and loss prevention."
  source: "`vibe_construction_v1`.`material`.`physical_inventory`"
  dimensions:
    - name: "physical_inventory_status"
      expr: physical_inventory_status
      comment: "Status of the physical inventory count (e.g., in-progress, completed, posted) for count cycle management."
    - name: "count_type"
      expr: count_type
      comment: "Type of inventory count (e.g., cycle count, full count, spot check) for methodology analysis."
    - name: "recount_flag"
      expr: recount_flag
      comment: "Flag indicating a recount was required, signaling initial count discrepancies."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity variance metrics."
    - name: "warehouse_code"
      expr: warehouse_code
      comment: "Warehouse code for location-level inventory accuracy analysis."
    - name: "location_code"
      expr: location_code
      comment: "Storage location code for granular accuracy tracking within warehouses."
  measures:
    - name: "total_inventory_counts"
      expr: COUNT(1)
      comment: "Total number of physical inventory count records. Baseline metric for count activity volume and coverage."
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physical quantity counted. Compared against system book quantity to compute overall inventory accuracy."
    - name: "total_system_book_quantity"
      expr: SUM(CAST(system_book_quantity AS DOUBLE))
      comment: "Total system-recorded quantity at time of count. Denominator for inventory accuracy rate calculations."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (counted minus book). Positive variance indicates unrecorded receipts; negative indicates losses, theft, or recording errors."
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Total financial value of inventory variance. The primary financial risk metric for inventory — large variances trigger audit and loss investigation."
    - name: "recount_required_count"
      expr: COUNT(CASE WHEN recount_flag = TRUE THEN 1 END)
      comment: "Number of count records requiring a recount. High recount rates indicate counting process quality issues or systemic inventory discrepancies."
    - name: "avg_variance_quantity"
      expr: AVG(CAST(variance_quantity AS DOUBLE))
      comment: "Average quantity variance per count record. Benchmarks typical discrepancy size and tracks improvement over time."
    - name: "avg_variance_value"
      expr: AVG(CAST(variance_value AS DOUBLE))
      comment: "Average financial variance per count record. Used to prioritize high-value discrepancy investigation and set materiality thresholds."
    - name: "zero_variance_count"
      expr: COUNT(CASE WHEN variance_quantity = 0 THEN 1 END)
      comment: "Number of count records with zero variance (perfect accuracy). Used to compute inventory accuracy rate — target is typically 95%+ for construction materials."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_mto_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material take-off (MTO) line metrics tracking design-to-procurement quantity accuracy, cost estimation, and material planning efficiency. Critical for project cost control and procurement scheduling."
  source: "`vibe_construction_v1`.`material`.`mto_line`"
  dimensions:
    - name: "mto_status"
      expr: mto_status
      comment: "Status of the MTO line (e.g., draft, approved, procured) for pipeline tracking."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline (e.g., civil, mechanical, electrical) for cross-discipline material demand analysis."
    - name: "procurement_status"
      expr: procurement_status
      comment: "Procurement status of the MTO line for supply chain pipeline visibility."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical path materials where procurement delays directly impact project schedule."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Hazardous material flag for safety and compliance planning."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity metrics."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost metrics."
  measures:
    - name: "total_mto_lines"
      expr: COUNT(1)
      comment: "Total number of MTO lines. Baseline metric for material planning scope and complexity."
    - name: "total_design_quantity"
      expr: SUM(CAST(design_quantity AS DOUBLE))
      comment: "Total design-specified quantity across all MTO lines. Represents the theoretical material demand from engineering design."
    - name: "total_net_required_quantity"
      expr: SUM(CAST(net_required_quantity AS DOUBLE))
      comment: "Total net quantity required after accounting for stock on hand and committed quantities. The actual procurement demand figure."
    - name: "total_actual_received_quantity"
      expr: SUM(CAST(actual_received_quantity AS DOUBLE))
      comment: "Total quantity actually received against MTO lines. Compared against net required to compute procurement fulfillment rate."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all MTO lines. Primary budget commitment metric for material procurement planning."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost variance between estimated and actual material costs. Negative variance indicates cost overrun — a key project financial health indicator."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between design and actual received quantities. Indicates design accuracy and procurement efficiency."
    - name: "avg_wastage_factor"
      expr: AVG(CAST(wastage_factor AS DOUBLE))
      comment: "Average wastage factor applied to MTO lines. Benchmarks material efficiency assumptions — high factors inflate procurement costs unnecessarily."
    - name: "critical_line_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical path MTO lines. Procurement delays on these lines directly impact project completion date — requires priority monitoring."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across MTO lines. Used for cost benchmarking and identifying lines where actual prices deviate significantly from estimates."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_conformance_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material conformance and quality certification metrics. Tracks test results, compliance rates, and certificate validity to ensure materials meet project specifications and regulatory requirements."
  source: "`vibe_construction_v1`.`material`.`conformance_certificate`"
  dimensions:
    - name: "conformance_certificate_status"
      expr: conformance_certificate_status
      comment: "Status of the conformance certificate (e.g., active, expired, revoked) for validity tracking."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the tested material for regulatory and specification adherence tracking."
    - name: "test_result"
      expr: test_result
      comment: "Test result (e.g., pass, fail, conditional) for quality performance analysis."
    - name: "test_method"
      expr: test_method
      comment: "Testing method applied for methodology-level quality analysis."
    - name: "test_standard"
      expr: test_standard
      comment: "Standard against which the material was tested (e.g., ASTM, BS, ISO) for standards compliance tracking."
    - name: "material_type"
      expr: material_type
      comment: "Type of material tested for category-level quality analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the certificate is currently active and valid."
  measures:
    - name: "total_certificates"
      expr: COUNT(1)
      comment: "Total number of conformance certificates. Baseline metric for quality documentation volume and testing activity."
    - name: "pass_count"
      expr: COUNT(CASE WHEN test_result = 'PASS' THEN 1 END)
      comment: "Number of materials that passed conformance testing. Numerator for pass rate calculation — the primary material quality KPI."
    - name: "fail_count"
      expr: COUNT(CASE WHEN test_result = 'FAIL' THEN 1 END)
      comment: "Number of materials that failed conformance testing. Failed materials must be rejected or remediated — high counts indicate supplier quality issues."
    - name: "active_certificate_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active and valid conformance certificates. Ensures project materials have current quality documentation."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured test value across conformance tests. Tracks material property trends against specification thresholds."
    - name: "avg_temperature_recorded"
      expr: AVG(CAST(temperature_recorded AS DOUBLE))
      comment: "Average temperature recorded during testing. Environmental conditions affect test validity — used for quality assurance process monitoring."
    - name: "avg_humidity_recorded"
      expr: AVG(CAST(humidity_recorded AS DOUBLE))
      comment: "Average humidity recorded during testing. Tracks environmental test conditions for quality process compliance."
    - name: "distinct_materials_tested"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of distinct materials with conformance certificates. Indicates breadth of quality testing coverage across the material portfolio."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_hazmat_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous material management and compliance metrics. Tracks hazmat inventory, inspection compliance, and regulatory status to manage safety and environmental risk on construction sites."
  source: "`vibe_construction_v1`.`material`.`hazmat_register`"
  dimensions:
    - name: "hazmat_register_status"
      expr: hazmat_register_status
      comment: "Current status of the hazmat register entry for lifecycle management."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the hazardous material for risk-tiered management and reporting."
    - name: "un_hazard_class"
      expr: un_hazard_class
      comment: "UN hazard classification for regulatory compliance and transport documentation."
    - name: "material_type"
      expr: material_type
      comment: "Type of hazardous material for category-level risk analysis."
    - name: "hse_notification_status"
      expr: hse_notification_status
      comment: "HSE notification status for regulatory authority reporting compliance."
    - name: "is_flammable"
      expr: is_flammable
      comment: "Flammable material flag for fire risk management."
    - name: "is_toxic"
      expr: is_toxic
      comment: "Toxic material flag for health risk management and PPE requirements."
    - name: "storage_temperature_controlled"
      expr: storage_temperature_controlled
      comment: "Flag indicating temperature-controlled storage requirement for compliance monitoring."
  measures:
    - name: "total_hazmat_entries"
      expr: COUNT(1)
      comment: "Total number of hazardous material register entries. Baseline metric for hazmat inventory scope and regulatory reporting volume."
    - name: "total_quantity_on_site"
      expr: SUM(CAST(quantity_on_site AS DOUBLE))
      comment: "Total quantity of hazardous materials on site. Regulatory threshold metric — exceeding permitted quantities triggers mandatory authority notification."
    - name: "avg_quantity_on_site"
      expr: AVG(CAST(quantity_on_site AS DOUBLE))
      comment: "Average quantity of hazardous material per register entry. Benchmarks typical hazmat holding levels for risk assessment."
    - name: "overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due < CURRENT_DATE THEN 1 END)
      comment: "Number of hazmat entries with overdue inspections. A critical safety compliance metric — overdue inspections represent regulatory violations and safety risk."
    - name: "flammable_material_count"
      expr: COUNT(CASE WHEN is_flammable = TRUE THEN 1 END)
      comment: "Number of flammable hazmat entries on site. Used for fire risk assessment and emergency response planning."
    - name: "toxic_material_count"
      expr: COUNT(CASE WHEN is_toxic = TRUE THEN 1 END)
      comment: "Number of toxic hazmat entries. Drives health risk assessment, PPE requirements, and medical surveillance programs."
    - name: "radioactive_material_count"
      expr: COUNT(CASE WHEN is_radioactive = TRUE THEN 1 END)
      comment: "Number of radioactive material entries. Highest-risk category requiring specialist regulatory compliance and radiation protection measures."
    - name: "explosive_material_count"
      expr: COUNT(CASE WHEN is_explosive = TRUE THEN 1 END)
      comment: "Number of explosive material entries. Requires specialist storage, handling, and security measures — tracked for site safety compliance."
    - name: "environmentally_hazardous_count"
      expr: COUNT(CASE WHEN is_environmentally_hazardous = TRUE THEN 1 END)
      comment: "Number of environmentally hazardous material entries. Drives environmental risk management and spill response planning."
$$;


CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-warehouse stock transfer efficiency metrics. Tracks material movement between project sites and warehouses, enabling logistics optimization and material availability management."
  source: "`vibe_construction_v1`.`material`.`stock_transfer`"
  dimensions:
    - name: "stock_transfer_status"
      expr: stock_transfer_status
      comment: "Current status of the stock transfer (e.g., pending, in-transit, completed, cancelled) for pipeline management."
    - name: "transfer_reason"
      expr: transfer_reason
      comment: "Business reason for the transfer (e.g., project demand, rebalancing, return) for logistics analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the transfer for logistics cost and lead time analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity metrics."
  measures:
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of stock transfer transactions. Baseline metric for inter-site material movement activity."
    - name: "total_quantity_transferred"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of materials transferred between warehouses. Measures material rebalancing activity and logistics throughput."
    - name: "avg_quantity_per_transfer"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity per transfer transaction. Benchmarks transfer batch sizes for logistics efficiency optimization."
    - name: "in_transit_transfer_count"
      expr: COUNT(CASE WHEN stock_transfer_status = 'IN_TRANSIT' THEN 1 END)
      comment: "Number of transfers currently in transit. Tracks material pipeline between sites — critical for project material availability forecasting."
    - name: "completed_transfer_count"
      expr: COUNT(CASE WHEN stock_transfer_status = 'COMPLETED' THEN 1 END)
      comment: "Number of completed transfers. Used to compute transfer completion rate and logistics performance."
$$;
