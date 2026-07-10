-- Metric views for domain: supply | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement KPIs for purchase orders: spend, delivery performance, contract compliance, and emergency ordering. Steers strategic sourcing and cost-control decisions."
  source: "`vibe_healthcare_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Lifecycle status of the purchase order (open, closed, cancelled)."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, capital)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the PO."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status indicating delivery progress."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (PO, receipt, invoice) driving AP accuracy."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month bucket of PO order date for trend analysis."
  measures:
    - name: "Purchase Order Count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — procurement volume baseline."
    - name: "Total PO Net Amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net purchasing spend — top-line procurement cost driver."
    - name: "Total PO Gross Amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross PO amount before discounts."
    - name: "Total Freight Amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight cost — logistics cost visibility."
    - name: "Total Discount Amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total negotiated discounts captured — savings realization."
    - name: "Avg PO Net Amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average PO value — order sizing and consolidation insight."
    - name: "Emergency Order Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency_order = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of POs flagged emergency — supply chain resilience/planning gap indicator."
    - name: "Contract Compliant PO Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_contract_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of POs compliant with contracts — GPO/contract leakage control."
    - name: "Capital Expenditure PO Count"
      expr: COUNT(CASE WHEN is_capital_expenditure = TRUE THEN 1 END)
      comment: "Count of capital-expenditure POs — capital spend governance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving KPIs: quantity accepted vs rejected, discrepancies, temperature excursions, and three-way match — steers vendor quality and receiving accuracy decisions."
  source: "`vibe_healthcare_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection outcome status on receipt."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of receiving discrepancy identified."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status at receipt."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month bucket of receipt date for trend analysis."
  measures:
    - name: "Goods Receipt Count"
      expr: COUNT(1)
      comment: "Total goods receipts processed — receiving throughput baseline."
    - name: "Total Quantity Received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received across all receipts."
    - name: "Total Quantity Accepted"
      expr: SUM(CAST(quantity_accepted AS DOUBLE))
      comment: "Total quantity accepted into inventory."
    - name: "Total Quantity Rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity rejected — vendor quality/defect volume."
    - name: "Total Receipt Value"
      expr: SUM(CAST(total_receipt_value AS DOUBLE))
      comment: "Total monetary value of goods received."
    - name: "Discrepancy Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of receipts with discrepancies — receiving/vendor accuracy KPI."
    - name: "Temperature Excursion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN temperature_excursion_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of receipts with temperature excursions — cold chain integrity risk."
    - name: "Recall Flagged Receipt Count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Count of receipts flagged against a recall — patient safety exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory position KPIs: on-hand value, stockouts, below-reorder, expiring/recalled stock — steers working capital and availability decisions."
  source: "`vibe_healthcare_v1`.`supply`.`inventory_balance`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of the inventory balance record."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for inventory prioritization."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (owned vs consignment)."
    - name: "item_category"
      expr: item_category
      comment: "Item category grouping for inventory analysis."
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', balance_snapshot_timestamp)
      comment: "Month bucket of the balance snapshot for trend analysis."
  measures:
    - name: "Inventory Line Count"
      expr: COUNT(1)
      comment: "Number of inventory balance lines — SKU-location breadth."
    - name: "Total On Hand Value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total on-hand inventory value — working capital tied up in stock."
    - name: "Total Qty On Hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total on-hand quantity across locations."
    - name: "Total Qty Available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total available (unreserved) quantity."
    - name: "Total Qty Reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total reserved quantity — committed but not consumed stock."
    - name: "Stockout Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stockout_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of inventory lines in stockout — availability/service level risk."
    - name: "Below Reorder Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN below_reorder_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of lines below reorder point — replenishment action trigger."
    - name: "Recall Flagged Inventory Count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Count of inventory lines flagged for recall — safety remediation scope."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_inventory_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement KPIs: consumption value, count variances, reversals — steers utilization, shrinkage, and count-accuracy decisions."
  source: "`vibe_healthcare_v1`.`supply`.`inventory_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of inventory transaction (issue, receipt, adjustment)."
    - name: "movement_category"
      expr: movement_category
      comment: "Movement category grouping for transaction analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the inventory transaction."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the movement (e.g., waste, adjustment)."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month bucket of posting date for movement trend analysis."
  measures:
    - name: "Transaction Count"
      expr: COUNT(1)
      comment: "Total inventory transactions — movement volume baseline."
    - name: "Total Movement Quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity moved across transactions."
    - name: "Total Extended Cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost of movements — consumption/spend value."
    - name: "Total Count Variance Value"
      expr: SUM(CAST(count_variance_value AS DOUBLE))
      comment: "Total monetary count variance — shrinkage/accuracy loss exposure."
    - name: "Reversal Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_reversal = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of transactions that are reversals — process/data quality indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance and compliance KPIs: fill rate, on-time delivery, OIG exclusion, diversity spend — steers supplier management and risk decisions."
  source: "`vibe_healthcare_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Vendor lifecycle status (active, inactive, suspended)."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type/classification of vendor."
    - name: "contract_tier"
      expr: contract_tier
      comment: "Contract tier for the vendor."
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Supplier diversity classification for diversity spend tracking."
    - name: "gpo_affiliation"
      expr: gpo_affiliation
      comment: "GPO affiliation of the vendor."
  measures:
    - name: "Vendor Count"
      expr: COUNT(1)
      comment: "Total vendors — supplier base breadth."
    - name: "Active Vendor Count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active vendors — actively engaged supplier base."
    - name: "Avg Fill Rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average vendor fill rate — order fulfillment reliability."
    - name: "Avg On Time Delivery Rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate — supply chain reliability KPI."
    - name: "Avg Performance Rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average vendor performance rating — supplier scorecard driver."
    - name: "OIG Excluded Vendor Count"
      expr: COUNT(CASE WHEN oig_excluded_flag = TRUE THEN 1 END)
      comment: "Count of OIG-excluded vendors — compliance/legal risk exposure."
    - name: "GPO Contracted Vendor Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_gpo_contracted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of vendors under GPO contracts — sourcing leverage/savings potential."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs: committed vs actual spend, rebates, compliance, sole-source risk — steers contract negotiation and savings decisions."
  source: "`vibe_healthcare_v1`.`supply`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the vendor contract."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of vendor contract."
    - name: "contract_tier"
      expr: contract_tier
      comment: "Tier classification of the contract."
    - name: "product_category"
      expr: product_category
      comment: "Product category covered by the contract."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month bucket of contract expiration for renewal planning."
  measures:
    - name: "Contract Count"
      expr: COUNT(1)
      comment: "Total vendor contracts — portfolio size baseline."
    - name: "Total Contract Value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total committed contract value — spend under management."
    - name: "Total Committed Spend"
      expr: SUM(CAST(committed_spend_amount AS DOUBLE))
      comment: "Total committed spend across contracts."
    - name: "Total Actual Spend"
      expr: SUM(CAST(actual_spend_amount AS DOUBLE))
      comment: "Total actual spend — used to assess commitment attainment."
    - name: "Avg Rebate Pct"
      expr: AVG(CAST(rebate_pct AS DOUBLE))
      comment: "Average rebate percentage — negotiated savings lever."
    - name: "Compliant Contract Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of compliant contracts — contract governance KPI."
    - name: "Sole Source Contract Count"
      expr: COUNT(CASE WHEN is_sole_source_justified = TRUE THEN 1 END)
      comment: "Count of sole-source contracts — supply risk concentration."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_case_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OR case cart KPIs: supply cost, waste, substitutions, missing items, sterility — steers perioperative supply efficiency and safety decisions."
  source: "`vibe_healthcare_v1`.`supply`.`case_cart`"
  dimensions:
    - name: "cart_status"
      expr: cart_status
      comment: "Status of the case cart."
    - name: "case_cart_type"
      expr: case_cart_type
      comment: "Type of case cart."
    - name: "assembly_status"
      expr: assembly_status
      comment: "Assembly status of the cart."
    - name: "procedure_type"
      expr: procedure_type
      comment: "Procedure type the cart supports."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_case_date)
      comment: "Month bucket of scheduled case date for trend analysis."
  measures:
    - name: "Case Cart Count"
      expr: COUNT(1)
      comment: "Total case carts — perioperative supply volume baseline."
    - name: "Total Supply Cost"
      expr: SUM(CAST(total_supply_cost AS DOUBLE))
      comment: "Total supply cost across case carts — perioperative cost driver."
    - name: "Total Waste Cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total waste cost — surgical supply waste reduction target."
    - name: "Total Used Quantity"
      expr: SUM(CAST(used_quantity AS DOUBLE))
      comment: "Total quantity used across carts."
    - name: "Total Returned Quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total quantity returned unused — picking accuracy insight."
    - name: "Missing Item Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN missing_item_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of carts with missing items — OR delay/quality risk KPI."
    - name: "Substitution Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN substitution_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of carts with substitutions — standardization/formulary adherence."
    - name: "Sterility Verified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sterility_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of carts with verified sterility — patient safety compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_recall_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product recall KPIs: patient impact, resolution, credits, regulatory reporting — steers patient safety and remediation decisions."
  source: "`vibe_healthcare_v1`.`supply`.`recall_notice`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Status of the recall notice."
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall class (I/II/III) severity grouping."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Disposition status of affected product."
    - name: "notification_month"
      expr: DATE_TRUNC('MONTH', notification_date)
      comment: "Month bucket of recall notification for trend analysis."
  measures:
    - name: "Recall Notice Count"
      expr: COUNT(1)
      comment: "Total recall notices — recall activity volume baseline."
    - name: "Total Quantity Affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity affected by recalls — exposure scope."
    - name: "Total Quantity Recovered"
      expr: SUM(CAST(quantity_recovered AS DOUBLE))
      comment: "Total quantity recovered — remediation effectiveness."
    - name: "Total Credit Amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total vendor credit expected/received — financial recovery."
    - name: "Patient Impact Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of recalls with patient impact — safety escalation KPI."
    - name: "Resolved Recall Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_resolved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of recalls resolved — remediation closure rate."
    - name: "Regulatory Reportable Recall Count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of regulatory-reportable recalls — MDR/FDA compliance obligation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_sterile_processing_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sterile processing KPIs: cycle outcomes, immediate-use rate, QA review, biological indicator results — steers SPD quality and infection-control decisions."
  source: "`vibe_healthcare_v1`.`supply`.`sterile_processing_record`"
  dimensions:
    - name: "processing_status"
      expr: processing_status
      comment: "Processing status of the sterilization record."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the processed set."
    - name: "sterilization_method"
      expr: sterilization_method
      comment: "Sterilization method used."
    - name: "cycle_type"
      expr: cycle_type
      comment: "Sterilization cycle type."
    - name: "cycle_month"
      expr: DATE_TRUNC('MONTH', cycle_timestamp)
      comment: "Month bucket of sterilization cycle for trend analysis."
  measures:
    - name: "Sterile Processing Record Count"
      expr: COUNT(1)
      comment: "Total sterile processing records — SPD throughput baseline."
    - name: "Avg Exposure Temperature C"
      expr: AVG(CAST(exposure_temperature_c AS DOUBLE))
      comment: "Average exposure temperature — process parameter monitoring."
    - name: "Avg Exposure Time Minutes"
      expr: AVG(CAST(exposure_time_minutes AS DOUBLE))
      comment: "Average exposure time — cycle validation insight."
    - name: "Immediate Use Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN immediate_use_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of immediate-use (IUSS) cycles — infection control risk KPI."
    - name: "QA Reviewed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_assurance_reviewed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of records QA-reviewed — sterility assurance compliance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Requisition KPIs: estimated vs actual cost, capital and recall-related requests, approvals — steers demand planning and cost control decisions."
  source: "`vibe_healthcare_v1`.`supply`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Status of the requisition."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Type of requisition."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the requisition."
    - name: "priority"
      expr: priority
      comment: "Priority level of the requisition."
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month bucket of request date for demand trend analysis."
  measures:
    - name: "Requisition Count"
      expr: COUNT(1)
      comment: "Total requisitions — demand volume baseline."
    - name: "Total Estimated Cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated requisition cost — planned spend."
    - name: "Total Actual Cost"
      expr: SUM(CAST(actual_total_cost AS DOUBLE))
      comment: "Total actual requisition cost — realized spend vs plan."
    - name: "Total Amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total requisition amount."
    - name: "Recall Related Requisition Count"
      expr: COUNT(CASE WHEN is_recall_related = TRUE THEN 1 END)
      comment: "Count of recall-driven requisitions — safety replacement activity."
    - name: "Capital Expense Requisition Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_capital_expense = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of capital-expense requisitions — capital demand governance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_location_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory location audit KPIs: count accuracy, variance value, expired/recalled findings, corrective actions — steers compliance and shrinkage decisions."
  source: "`vibe_healthcare_v1`.`supply`.`location_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of location audit."
    - name: "audit_result"
      expr: audit_result
      comment: "Outcome result of the audit."
    - name: "location_audit_status"
      expr: location_audit_status
      comment: "Status of the location audit."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of audit findings."
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month bucket of audit date for compliance trend analysis."
  measures:
    - name: "Location Audit Count"
      expr: COUNT(1)
      comment: "Total location audits performed — audit coverage baseline."
    - name: "Avg Count Accuracy Rate"
      expr: AVG(CAST(count_accuracy_rate AS DOUBLE))
      comment: "Average count accuracy rate — inventory data integrity KPI."
    - name: "Avg Compliance Score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across audits — governance quality."
    - name: "Total Variance Value"
      expr: SUM(CAST(total_variance_value AS DOUBLE))
      comment: "Total monetary variance found — shrinkage exposure."
    - name: "Total Expired Items Value"
      expr: SUM(CAST(expired_items_value AS DOUBLE))
      comment: "Total value of expired items found — waste and safety loss."
    - name: "Corrective Action Required Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of audits requiring corrective action — remediation workload driver."
    - name: "Compliance Pass Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_pass_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of audits passing compliance — regulatory readiness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_material_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Item master KPIs: catalog vs contract pricing, formulary status, controlled/implantable/recall counts — steers standardization and cost decisions."
  source: "`vibe_healthcare_v1`.`supply`.`material_master`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Status of the material master item."
    - name: "item_type"
      expr: item_type
      comment: "Type/classification of the item."
    - name: "material_category"
      expr: material_category
      comment: "Material category grouping."
    - name: "formulary_status"
      expr: formulary_status
      comment: "Formulary status of the item."
    - name: "recall_status"
      expr: recall_status
      comment: "Recall status of the item."
  measures:
    - name: "Material Item Count"
      expr: COUNT(1)
      comment: "Total item master records — catalog breadth baseline."
    - name: "Active Item Count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active items — usable catalog size."
    - name: "Avg Unit Cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average item unit cost — pricing benchmark."
    - name: "Avg Contract Price"
      expr: AVG(CAST(contract_price AS DOUBLE))
      comment: "Average contracted price — negotiated pricing benchmark."
    - name: "Avg Lead Time Days"
      expr: AVG(CAST(lead_time_days AS DOUBLE))
      comment: "Average procurement lead time in days — supply planning KPI."
    - name: "Controlled Substance Item Count"
      expr: COUNT(CASE WHEN is_controlled_substance = TRUE THEN 1 END)
      comment: "Count of controlled-substance items — DEA compliance scope."
    - name: "Implantable Item Count"
      expr: COUNT(CASE WHEN is_implantable = TRUE THEN 1 END)
      comment: "Count of implantable items — UDI tracking scope."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_udi_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "UDI/implant tracking KPIs: implant volume, MDR reportable devices, recall-flagged implants — steers device safety and traceability decisions."
  source: "`vibe_healthcare_v1`.`supply`.`udi_record`"
  dimensions:
    - name: "implant_status"
      expr: implant_status
      comment: "Implant status of the device."
    - name: "recall_class"
      expr: recall_class
      comment: "Recall class of the device if recalled."
    - name: "recall_remediation_status"
      expr: recall_remediation_status
      comment: "Recall remediation status."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "UDI issuing agency (GS1, HIBCC, etc.)."
    - name: "implant_month"
      expr: DATE_TRUNC('MONTH', implant_date)
      comment: "Month bucket of implant date for trend analysis."
  measures:
    - name: "UDI Record Count"
      expr: COUNT(1)
      comment: "Total UDI records — device traceability volume baseline."
    - name: "Implantable Device Count"
      expr: COUNT(CASE WHEN is_implantable = TRUE THEN 1 END)
      comment: "Count of implantable devices tracked — patient safety scope."
    - name: "MDR Reportable Device Count"
      expr: COUNT(CASE WHEN mdr_reportable_flag = TRUE THEN 1 END)
      comment: "Count of MDR-reportable devices — FDA reporting obligation."
    - name: "Recall Flagged Device Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of devices flagged for recall — safety exposure KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_material_policy_governance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material policy governance KPIs: approval status, cost savings, exceptions, review timeliness — steers value-analysis and stewardship decisions."
  source: "`vibe_healthcare_v1`.`supply`.`material_policy_governance`"
  dimensions:
    - name: "governance_status"
      expr: governance_status
      comment: "Overall governance status of the policy."
    - name: "governance_type"
      expr: governance_type
      comment: "Type of governance action."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the material policy."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification."
    - name: "review_month"
      expr: DATE_TRUNC('MONTH', review_date)
      comment: "Month bucket of review date for governance cadence analysis."
  measures:
    - name: "Policy Governance Count"
      expr: COUNT(1)
      comment: "Total material policy governance records — governance coverage baseline."
    - name: "Total Cost Savings Amount"
      expr: SUM(CAST(cost_savings_amount AS DOUBLE))
      comment: "Total cost savings from value-analysis decisions — savings realization KPI."
    - name: "Avg Cost Effectiveness Score"
      expr: AVG(CAST(cost_effectiveness_score AS DOUBLE))
      comment: "Average cost-effectiveness score — value-analysis quality."
    - name: "Exception Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of policies with active exceptions — governance leakage indicator."
    - name: "Active Policy Count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active governance policies — current stewardship scope."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_purchase_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PO line-level KPIs: ordered vs received quantities, backorders, extended value, contract/formulary adherence — steers fulfillment and compliance decisions."
  source: "`vibe_healthcare_v1`.`supply`.`purchase_order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the PO line."
    - name: "line_type"
      expr: line_type
      comment: "Type of the PO line."
    - name: "item_category"
      expr: item_category
      comment: "Item category of the line."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the line."
    - name: "expected_delivery_month"
      expr: DATE_TRUNC('MONTH', expected_delivery_date)
      comment: "Month bucket of expected delivery for fulfillment planning."
  measures:
    - name: "PO Line Count"
      expr: COUNT(1)
      comment: "Total PO lines — line-level procurement volume baseline."
    - name: "Total Ordered Quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across lines."
    - name: "Total Received Quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received — fulfillment attainment input."
    - name: "Total Backorder Quantity"
      expr: SUM(CAST(backorder_quantity AS DOUBLE))
      comment: "Total backordered quantity — supply shortfall exposure."
    - name: "Total Extended Amount"
      expr: SUM(CAST(extended_amount AS DOUBLE))
      comment: "Total extended line amount — line-level spend."
    - name: "Contract Item Line Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_contract_item = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of lines that are contract items — contract adherence KPI."
    - name: "Formulary Item Line Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_formulary_item = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of lines that are formulary items — standardization KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_case_cart_costs`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and waste metrics for case carts, enabling cost management per care site and procedure."
  source: "`vibe_healthcare_v1`.`supply`.`case_cart`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site where the case cart is used"
    - name: "procedure_type"
      expr: procedure_type
      comment: "Type of procedure associated with the case cart"
    - name: "priority_level"
      expr: priority_level
      comment: "Clinical priority level of the case"
    - name: "cart_status"
      expr: cart_status
      comment: "Current status of the case cart"
    - name: "assembly_status"
      expr: assembly_status
      comment: "Assembly status of the case cart"
    - name: "scheduled_procedure_date"
      expr: scheduled_procedure_date
      comment: "Scheduled date of the procedure"
  measures:
    - name: "total_supply_cost_sum"
      expr: SUM(CAST(total_supply_cost AS DOUBLE))
      comment: "Total supply cost across case carts"
    - name: "waste_cost_sum"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total waste cost associated with case carts"
    - name: "case_cart_count"
      expr: COUNT(1)
      comment: "Number of case cart records"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_purchase_order_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial metrics for purchase orders to support spend analysis."
  source: "`vibe_healthcare_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site associated with the purchase order"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the goods"
    - name: "fiscal_period_id"
      expr: fiscal_period_id
      comment: "Fiscal period of the purchase order"
    - name: "order_date"
      expr: order_date
      comment: "Date the purchase order was created"
  measures:
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of purchase orders"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of purchase orders"
    - name: "purchase_order_count"
      expr: COUNT(1)
      comment: "Number of purchase order records"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_purchase_order_line_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing and quantity metrics for purchase order lines."
  source: "`vibe_healthcare_v1`.`supply`.`purchase_order_line`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site linked to the line item"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor for the line item"
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material master identifier for the item"
    - name: "line_status"
      expr: line_status
      comment: "Current status of the purchase order line"
  measures:
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across purchase order lines"
    - name: "total_line_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across lines"
    - name: "purchase_order_line_count"
      expr: COUNT(1)
      comment: "Number of purchase order line records"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_recall_incidents`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall incident metrics to monitor product safety and compliance."
  source: "`vibe_healthcare_v1`.`supply`.`recall_notice`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site impacted by the recall"
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall"
    - name: "recall_class"
      expr: recall_class
      comment: "Regulatory class of the recall"
    - name: "recall_initiation_source"
      expr: recall_initiation_source
      comment: "Source that initiated the recall"
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of recall notices"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_sterile_processing_efficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Efficiency metrics for sterile processing cycles."
  source: "`vibe_healthcare_v1`.`supply`.`sterile_processing_record`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where processing occurred"
    - name: "sterilization_method"
      expr: sterilization_method
      comment: "Method used for sterilization"
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of processing cycle"
  measures:
    - name: "avg_cycle_seconds"
      expr: AVG(UNIX_TIMESTAMP(sterilization_timestamp) - UNIX_TIMESTAMP(assembly_timestamp))
      comment: "Average cycle time in seconds from assembly to sterilization"
    - name: "total_records"
      expr: COUNT(1)
      comment: "Number of sterile processing records"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_surgical_bom_costs`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost estimation metrics for surgical bill of materials."
  source: "`vibe_healthcare_v1`.`supply`.`surgical_bom`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site associated with the BOM"
    - name: "procedure_name"
      expr: procedure_name
      comment: "Name of the surgical procedure"
  measures:
    - name: "total_estimated_supply_cost"
      expr: SUM(CAST(estimated_supply_cost AS DOUBLE))
      comment: "Total estimated supply cost for surgical BOMs"
    - name: "total_estimated_implant_cost"
      expr: SUM(CAST(estimated_implant_cost AS DOUBLE))
      comment: "Total estimated implant cost for surgical BOMs"
    - name: "bom_count"
      expr: COUNT(1)
      comment: "Number of surgical BOM records"
$$;