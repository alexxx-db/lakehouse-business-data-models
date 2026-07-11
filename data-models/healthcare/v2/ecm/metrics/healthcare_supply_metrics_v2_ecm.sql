-- Metric views for domain: supply | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement KPIs over purchase orders: spend, order value, emergency/contract compliance, and match rates that drive strategic sourcing and cost control decisions."
  source: "`vibe_healthcare_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Purchase order lifecycle status (open, closed, cancelled)."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order for spend categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state used to monitor procurement governance."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment progress of the order."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status for AP control and audit."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Order month for spend trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend reporting."
  measures:
    - name: "Purchase Order Count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — baseline procurement volume."
    - name: "Total Net Spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net procurement spend — core cost-management KPI for sourcing decisions."
    - name: "Total Gross Spend"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross spend before discounts/taxes for budget reconciliation."
    - name: "Total Freight Cost"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight cost — logistics cost driver for negotiation."
    - name: "Total Discount Captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts captured — measures sourcing savings performance."
    - name: "Avg Order Net Value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average PO net value — indicates purchasing consolidation efficiency."
    - name: "Emergency Order Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_emergency_order THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of orders flagged emergency — signals supply chain disruption and premium cost risk."
    - name: "Contract Compliant Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_contract_compliant THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of contract-compliant POs — measures maverick spend leakage."
    - name: "Capital Expenditure Order Count"
      expr: SUM(CASE WHEN is_capital_expenditure THEN 1 ELSE 0 END)
      comment: "Count of capital POs — capital planning oversight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving KPIs measuring quantity accuracy, discrepancies, recalls, cold-chain excursions, and receipt value for supply chain quality and integrity."
  source: "`vibe_healthcare_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt for receiving throughput analysis."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of receiving discrepancy for root-cause analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match outcome at receipt for AP controls."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement classification of the receipt."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Receipt month for receiving trend analysis."
  measures:
    - name: "Goods Receipt Count"
      expr: COUNT(1)
      comment: "Total goods receipts — baseline receiving volume."
    - name: "Total Receipt Value"
      expr: SUM(CAST(total_receipt_value AS DOUBLE))
      comment: "Total value of goods received — inbound spend realization."
    - name: "Total Quantity Received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total units received for volume/throughput analysis."
    - name: "Total Quantity Ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total ordered quantity for fill-rate comparison in BI."
    - name: "Discrepancy Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN discrepancy_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of receipts with discrepancies — supplier quality and receiving accuracy KPI."
    - name: "Recall Receipt Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recall_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of receipts flagged for recall — patient safety and traceability risk."
    - name: "Temperature Excursion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_excursion_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of receipts with cold-chain excursions — product integrity and compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory position KPIs: on-hand value, stockouts, reorder exposure, and expiration risk to steer working capital and availability decisions."
  source: "`vibe_healthcare_v1`.`supply`.`inventory_balance`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current inventory status for availability analysis."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for inventory prioritization."
    - name: "item_category"
      expr: item_category
      comment: "Item category for spend-by-category views."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model (owned vs consignment) for capital analysis."
    - name: "last_movement_month"
      expr: DATE_TRUNC('MONTH', last_movement_date)
      comment: "Month of last movement for slow-mover detection."
  measures:
    - name: "Inventory Line Count"
      expr: COUNT(1)
      comment: "Count of inventory balance records — baseline SKU-location coverage."
    - name: "Total On Hand Value"
      expr: SUM(CAST(qty_on_hand * unit_cost AS DOUBLE))
      comment: "Total on-hand inventory value — working-capital tied up in stock."
    - name: "Total Qty On Hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total units on hand across locations."
    - name: "Total Qty Reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total reserved units — committed but not yet consumed."
    - name: "Total Qty Quarantine"
      expr: SUM(CAST(qty_quarantine AS DOUBLE))
      comment: "Total quarantined units — non-usable stock exposure."
    - name: "Below Reorder Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN below_reorder_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of items below reorder point — replenishment risk KPI."
    - name: "Stockout Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN stockout_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of items in stockout — clinical availability risk."
    - name: "Recall Exposure Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recall_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of inventory flagged in recall — patient-safety exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_inventory_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory movement KPIs measuring consumption value, count variance, and reversal quality for supply chain accuracy and shrinkage control."
  source: "`vibe_healthcare_v1`.`supply`.`inventory_transaction`"
  dimensions:
    - name: "movement_category"
      expr: movement_category
      comment: "High-level movement category (issue, receipt, transfer, adjustment)."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Transaction status for processing quality."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for adjustments/waste root-cause analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting month for movement trend analysis."
  measures:
    - name: "Transaction Count"
      expr: COUNT(1)
      comment: "Total inventory transactions — baseline movement volume."
    - name: "Total Extended Cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total extended cost of movements — consumption/cost flow value."
    - name: "Total Quantity Moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units moved across transactions."
    - name: "Total Count Variance Value"
      expr: SUM(CAST(count_variance_value AS DOUBLE))
      comment: "Total cycle-count variance value — shrinkage and accuracy KPI."
    - name: "Reversal Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_reversal THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of reversal transactions — data-entry/process quality indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance and risk KPIs: delivery reliability, fill rate, ratings, diversity, and compliance exclusions to steer supplier management."
  source: "`vibe_healthcare_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Vendor lifecycle status for active-supplier analysis."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Vendor type/classification for spend segmentation."
    - name: "contract_tier"
      expr: contract_tier
      comment: "Contract tier for strategic supplier segmentation."
    - name: "diversity_classification"
      expr: diversity_classification
      comment: "Supplier diversity classification for diversity-spend goals."
    - name: "country_code"
      expr: country_code
      comment: "Vendor country for geographic risk analysis."
  measures:
    - name: "Vendor Count"
      expr: COUNT(1)
      comment: "Total vendor records — supplier base size."
    - name: "Avg On Time Delivery Rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate — core supplier reliability KPI."
    - name: "Avg Fill Rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average order fill rate — supplier fulfillment performance."
    - name: "Avg Performance Rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average vendor performance rating — scorecard KPI."
    - name: "OIG Excluded Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN oig_excluded_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of OIG-excluded vendors — regulatory compliance risk."
    - name: "Preferred Vendor Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN preferred_vendor_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of preferred vendors — sourcing consolidation indicator."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_recall_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recall management KPIs: patient impact, quarantine/destruction volumes, financial credit recovery, and regulatory reporting timeliness for patient-safety governance."
  source: "`vibe_healthcare_v1`.`supply`.`recall_notice`"
  dimensions:
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall class for severity prioritization."
    - name: "recall_status"
      expr: recall_status
      comment: "Current recall handling status."
    - name: "recall_type"
      expr: recall_type
      comment: "Recall type for categorization."
    - name: "fda_notice_month"
      expr: DATE_TRUNC('MONTH', fda_notice_date)
      comment: "FDA notice month for recall trend analysis."
  measures:
    - name: "Recall Notice Count"
      expr: COUNT(1)
      comment: "Total recall notices — recall workload and exposure baseline."
    - name: "Total Credit Amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total expected/received financial credit from recalls — cost recovery KPI."
    - name: "Patient Notification Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_notification_required THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of recalls requiring patient notification — patient-safety impact."
    - name: "Implantable Recall Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN implantable_device_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of recalls involving implantable devices — high-severity clinical risk."
    - name: "Regulatory Report Submitted Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_report_submitted THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent with regulatory reports submitted — compliance completeness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_case_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OR case cart KPIs: supply cost per case, waste, substitutions, missing items, and sterility verification for surgical supply chain performance."
  source: "`vibe_healthcare_v1`.`supply`.`case_cart`"
  dimensions:
    - name: "cart_status"
      expr: cart_status
      comment: "Case cart lifecycle status."
    - name: "assembly_status"
      expr: assembly_status
      comment: "Assembly completion status for OR readiness."
    - name: "procedure_type"
      expr: procedure_type
      comment: "Procedure type for surgical supply segmentation."
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority for prioritization analysis."
    - name: "scheduled_procedure_month"
      expr: DATE_TRUNC('MONTH', scheduled_procedure_date)
      comment: "Scheduled procedure month for trend analysis."
  measures:
    - name: "Case Cart Count"
      expr: COUNT(1)
      comment: "Total case carts — surgical case supply volume baseline."
    - name: "Total Supply Cost"
      expr: SUM(CAST(total_supply_cost AS DOUBLE))
      comment: "Total surgical supply cost — OR cost-management KPI."
    - name: "Total Waste Cost"
      expr: SUM(CAST(waste_cost AS DOUBLE))
      comment: "Total supply waste cost — waste-reduction target."
    - name: "Avg Supply Cost Per Cart"
      expr: AVG(CAST(total_supply_cost AS DOUBLE))
      comment: "Average supply cost per case — case-level efficiency benchmark."
    - name: "Missing Item Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN missing_item_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of carts with missing items — OR readiness and delay risk."
    - name: "Substitution Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN substitution_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of carts requiring substitutions — supply availability indicator."
    - name: "Sterility Verified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sterility_verified_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of carts with verified sterility — patient-safety compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Requisition KPIs measuring demand cost accuracy, PAR-triggered vs manual demand, capital requests, and approval throughput for procurement planning."
  source: "`vibe_healthcare_v1`.`supply`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Requisition lifecycle status."
    - name: "requisition_type"
      expr: requisition_type
      comment: "Requisition type for demand segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval state for governance monitoring."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency level for expedite analysis."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Requisition creation month for demand trends."
  measures:
    - name: "Requisition Count"
      expr: COUNT(1)
      comment: "Total requisitions — demand request volume baseline."
    - name: "Total Estimated Cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated requisition cost — demand planning value."
    - name: "Total Actual Cost"
      expr: SUM(CAST(actual_total_cost AS DOUBLE))
      comment: "Total actual requisition cost for estimate-vs-actual analysis."
    - name: "PAR Triggered Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_par_triggered THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent PAR-triggered — automation vs manual demand indicator."
    - name: "Capital Expense Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_capital_expense THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent capital-expense requisitions — capital planning oversight."
    - name: "Recall Related Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_recall_related THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of recall-related requisitions — recall remediation workload."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_sterile_processing_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sterile processing KPIs: cycle quality (BI/chemical indicators), immediate-use rates, reprocessing burden, and release quality for infection-control compliance."
  source: "`vibe_healthcare_v1`.`supply`.`sterile_processing_record`"
  dimensions:
    - name: "cycle_type"
      expr: cycle_type
      comment: "Sterilization cycle type."
    - name: "sterilization_method"
      expr: sterilization_method
      comment: "Sterilization method for method-level quality analysis."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the sterilized load."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Inspection outcome for quality tracking."
    - name: "sterilization_month"
      expr: DATE_TRUNC('MONTH', sterilization_timestamp)
      comment: "Sterilization month for trend analysis."
  measures:
    - name: "Sterile Processing Record Count"
      expr: COUNT(1)
      comment: "Total sterile processing records — SPD throughput baseline."
    - name: "Immediate Use Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN immediate_use_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent immediate-use (IUSS) cycles — infection-control risk indicator to minimize."
    - name: "QA Reviewed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_assurance_reviewed_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of loads QA-reviewed — quality-assurance compliance KPI."
    - name: "Recall Flagged Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recall_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of records flagged in recall — traceability exposure."
    - name: "Avg Exposure Temperature C"
      expr: AVG(CAST(exposure_temperature_c AS DOUBLE))
      comment: "Average exposure temperature — sterilization process control benchmark."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_udi_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Implantable device UDI KPIs: implant volume, explant tracking, MDR reportability, and recall status for device traceability and patient-safety compliance."
  source: "`vibe_healthcare_v1`.`supply`.`udi_record`"
  dimensions:
    - name: "implant_status"
      expr: implant_status
      comment: "Implant status of the tracked device."
    - name: "recall_class"
      expr: recall_class
      comment: "Recall class for severity prioritization."
    - name: "recall_remediation_status"
      expr: recall_remediation_status
      comment: "Recall remediation status for closure tracking."
    - name: "issuing_agency"
      expr: issuing_agency
      comment: "UDI issuing agency for standard compliance."
    - name: "implant_month"
      expr: DATE_TRUNC('MONTH', implant_date)
      comment: "Implant month for device utilization trends."
  measures:
    - name: "UDI Record Count"
      expr: COUNT(1)
      comment: "Total UDI records — device tracking volume baseline."
    - name: "Implantable Device Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN implantable_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent implantable — implant tracking focus indicator."
    - name: "MDR Reportable Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN mdr_reportable_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent MDR-reportable — regulatory adverse-event reporting exposure."
    - name: "Recall Flagged Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recall_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of UDI records flagged for recall — patient-safety recall exposure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`supply_vendor_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs: committed value, rebates, diversity spend, and sole-source exposure to steer contract negotiation and compliance."
  source: "`vibe_healthcare_v1`.`supply`.`vendor_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Contract lifecycle status."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type for portfolio segmentation."
    - name: "product_category"
      expr: product_category
      comment: "Product category covered by contract."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Renewal type for expiration/renewal planning."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Contract effective year for cohort analysis."
  measures:
    - name: "Contract Count"
      expr: COUNT(1)
      comment: "Total vendor contracts — portfolio size baseline."
    - name: "Total Contract Value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted value — committed spend under contract."
    - name: "Total Annual Commitment"
      expr: SUM(CAST(annual_commitment_amount AS DOUBLE))
      comment: "Total annual commitment amount for budget planning."
    - name: "Avg Rebate Pct"
      expr: AVG(CAST(rebate_pct AS DOUBLE))
      comment: "Average rebate percent — savings recovery KPI."
    - name: "Diversity Spend Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_diversity_spend THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of contracts flagged diversity-spend — supplier diversity goal tracking."
    - name: "Sole Source Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_sole_source_justified THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent sole-source justified — supply risk concentration indicator."
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