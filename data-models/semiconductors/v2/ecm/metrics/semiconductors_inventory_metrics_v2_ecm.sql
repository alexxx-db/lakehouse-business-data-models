-- Metric views for domain: inventory | Business: Semiconductors | Version: 2 | Generated on: 2026-06-28 00:14:33

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_consignment_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consignment inventory metrics tracking consigned quantities, consumed quantities, valuation, and settlement status. Used by supply chain, finance, and procurement to manage vendor-owned inventory liability, consumption rates, and settlement obligations."
  source: "`vibe_semiconductors_v1`.`inventory`.`consignment_stock`"
  dimensions:
    - name: "consignment_status"
      expr: consignment_status
      comment: "Current status of the consignment arrangement for lifecycle management."
    - name: "consignment_type"
      expr: consignment_type
      comment: "Type of consignment (vendor-managed, customer-managed) for ownership and liability analysis."
    - name: "consignment_stock_status"
      expr: consignment_stock_status
      comment: "Operational status of the consignment stock record for inventory management."
    - name: "ownership"
      expr: ownership
      comment: "Ownership party of the consignment stock for liability and balance sheet treatment."
    - name: "kgd_status"
      expr: kgd_status
      comment: "KGD status of consigned die inventory for quality-segmented analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the consignment valuation for multi-currency financial reporting."
    - name: "consignment_start_month"
      expr: DATE_TRUNC('month', consignment_start_date)
      comment: "Month the consignment arrangement started for aging and trend analysis."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status of consigned inventory for regulatory reporting."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance monitoring of consigned inventory."
  measures:
    - name: "total_consigned_quantity"
      expr: SUM(CAST(consigned_quantity AS DOUBLE))
      comment: "Total quantity of inventory held on consignment. Measures vendor-owned inventory liability on customer premises."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available quantity from consignment stock. Drives ATP calculations for consignment-sourced fulfillment."
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total quantity consumed from consignment. Drives settlement billing and replenishment trigger decisions."
    - name: "total_returned_quantity"
      expr: SUM(CAST(returned_quantity AS DOUBLE))
      comment: "Total quantity returned to consignment supplier. Tracks return rates for vendor performance and contract compliance."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total consignment quantity currently in transit. Provides supply chain visibility for replenishment planning."
    - name: "total_consignment_value_usd"
      expr: SUM(CAST(consignment_value_usd AS DOUBLE))
      comment: "Total value of consignment inventory in USD. Measures off-balance-sheet inventory liability for financial risk management."
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount of consignment stock. Used for settlement calculation and financial reporting."
    - name: "total_total_valuation_amount"
      expr: SUM(CAST(total_valuation_amount AS DOUBLE))
      comment: "Total aggregate valuation amount across all consignment records. Comprehensive consignment liability metric."
    - name: "consumption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(consumed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(consigned_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of consigned inventory consumed. Low rates indicate excess consignment stock; high rates signal replenishment urgency."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per consignment stock record. Benchmarks consignment unit economics for procurement negotiations."
    - name: "qty_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity on hand in consignment locations. Real-time availability metric for consignment-sourced fulfillment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_die_bank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Die bank inventory metrics tracking known good die quantities, quality status, and valuation"
  source: "`vibe_semiconductors_v1`.`inventory`.`die_bank`"
  dimensions:
    - name: "die_bank_status"
      expr: die_bank_status
      comment: "Current status of the die bank"
    - name: "bank_status"
      expr: bank_status
      comment: "Bank availability status"
    - name: "disposition_status"
      expr: disposition_status
      comment: "Quality disposition status"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die certification status"
    - name: "kgd_certified_flag"
      expr: kgd_certified_flag
      comment: "KGD certification flag"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Quality hold flag"
    - name: "quality_hold_reason"
      expr: quality_hold_reason
      comment: "Reason for quality hold"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification for die quality grading"
    - name: "is_engineering_sample"
      expr: is_engineering_sample
      comment: "Engineering sample flag"
    - name: "is_consignment"
      expr: is_consignment
      comment: "Consignment inventory flag"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag"
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "MSL rating for moisture sensitivity"
    - name: "process_node"
      expr: process_node
      comment: "Technology node of the die"
    - name: "entry_month"
      expr: DATE_TRUNC('MONTH', entry_date)
      comment: "Month when die entered the bank"
  measures:
    - name: "total_die_banks"
      expr: COUNT(DISTINCT die_bank_id)
      comment: "Total number of unique die bank records"
    - name: "total_die_count"
      expr: SUM(CAST(total_die_count AS DOUBLE))
      comment: "Total number of die across all banks"
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total number of known good die"
    - name: "total_die_value"
      expr: SUM(CAST(die_value_usd AS DOUBLE))
      comment: "Total value of die inventory in USD"
    - name: "total_inventory_value"
      expr: SUM(CAST(inventory_value_usd AS DOUBLE))
      comment: "Total inventory valuation in USD"
    - name: "avg_die_size"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in square millimeters"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per die"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per die"
    - name: "avg_wafer_probe_yield"
      expr: AVG(CAST(wafer_probe_yield_pct AS DOUBLE))
      comment: "Average wafer probe yield percentage"
    - name: "kgd_certified_banks"
      expr: SUM(CASE WHEN kgd_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of KGD-certified die banks"
    - name: "banks_on_hold"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of die banks on quality hold"
    - name: "die_yield_rate"
      expr: ROUND(100.0 * SUM(CAST(good_die_count AS DOUBLE)) / NULLIF(SUM(CAST(total_die_count AS DOUBLE)), 0), 2)
      comment: "Percentage of good die to total die"
    - name: "kgd_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN kgd_certified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of die banks that are KGD certified"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_finished_good`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Finished goods inventory metrics tracking stock levels, quality status, compliance, and valuation"
  source: "`vibe_semiconductors_v1`.`inventory`.`finished_good`"
  dimensions:
    - name: "finished_good_status"
      expr: finished_good_status
      comment: "Current status of the finished good"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory availability status"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle stage (e.g., active, EOL)"
    - name: "quality_status"
      expr: quality_status
      comment: "Quality disposition status"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the finished good is on quality hold"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag"
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag"
    - name: "aec_q_qualified"
      expr: aec_q_qualified
      comment: "AEC-Q automotive qualification flag"
    - name: "moisture_sensitivity_level"
      expr: moisture_sensitivity_level
      comment: "MSL rating for moisture sensitivity"
    - name: "package_type"
      expr: package_type
      comment: "Package type of the finished good"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the product was manufactured"
    - name: "manufacture_month"
      expr: DATE_TRUNC('MONTH', manufacture_date)
      comment: "Month of manufacture"
  measures:
    - name: "total_finished_goods"
      expr: COUNT(DISTINCT finished_good_id)
      comment: "Total number of unique finished good SKUs in inventory"
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of finished goods on hand"
    - name: "total_inventory_value"
      expr: SUM(CAST(inventory_value_usd AS DOUBLE))
      comment: "Total inventory value in USD"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost_usd AS DOUBLE))
      comment: "Average standard cost per finished good unit"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost_usd AS DOUBLE))
      comment: "Total standard cost across all finished goods"
    - name: "goods_on_hold"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of finished goods currently on quality hold"
    - name: "rohs_compliant_count"
      expr: SUM(CASE WHEN rohs_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Number of RoHS compliant finished goods"
    - name: "itar_controlled_count"
      expr: SUM(CASE WHEN itar_controlled = TRUE THEN 1 ELSE 0 END)
      comment: "Number of ITAR-controlled finished goods"
    - name: "aec_qualified_count"
      expr: SUM(CASE WHEN aec_q_qualified = TRUE THEN 1 ELSE 0 END)
      comment: "Number of AEC-Q qualified automotive products"
    - name: "hold_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of finished goods on quality hold"
    - name: "rohs_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rohs_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory that is RoHS compliant"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods movement metrics tracking inventory transactions, movement types, quantities, and values"
  source: "`vibe_semiconductors_v1`.`inventory`.`goods_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of goods movement (e.g., receipt, issue, transfer)"
    - name: "document_type"
      expr: document_type
      comment: "Source document type triggering the movement"
    - name: "movement_status"
      expr: movement_status
      comment: "Status of the goods movement transaction"
    - name: "goods_movement_status"
      expr: goods_movement_status
      comment: "Overall goods movement status"
    - name: "movement_reason_code"
      expr: movement_reason_code
      comment: "Reason code for the movement"
    - name: "reason_code"
      expr: reason_code
      comment: "Additional reason classification"
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock being moved"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Special stock indicator (e.g., consignment, project)"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates if this is a reversal transaction"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification of moved goods"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', movement_date)
      comment: "Month of the goods movement"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the movement was posted"
  measures:
    - name: "total_movements"
      expr: COUNT(DISTINCT goods_movement_id)
      comment: "Total number of unique goods movement transactions"
    - name: "total_movement_quantity"
      expr: SUM(CAST(movement_quantity AS DOUBLE))
      comment: "Total quantity moved across all transactions"
    - name: "total_movement_value"
      expr: SUM(CAST(movement_value_usd AS DOUBLE))
      comment: "Total value of goods movements in USD"
    - name: "total_valuation_amount"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total valuation amount for all movements"
    - name: "avg_movement_quantity"
      expr: AVG(CAST(movement_quantity AS DOUBLE))
      comment: "Average quantity per movement transaction"
    - name: "avg_movement_value"
      expr: AVG(CAST(movement_value_usd AS DOUBLE))
      comment: "Average value per movement transaction in USD"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversal transactions"
    - name: "reversal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of movements that are reversals"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_kgd_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Known Good Die certification metrics tracking certification rates, yield, DPPM, and test coverage. Used by quality, test engineering, and sales operations to manage KGD supply quality, customer qualification compliance, and die reliability."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_kgd_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (certified, pending, expired, failed) for supply qualification analysis."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard applied (JEDEC, AEC-Q, customer-specific) for compliance segmentation."
    - name: "kgd_grade"
      expr: kgd_grade
      comment: "KGD quality grade for premium vs. standard die supply segmentation."
    - name: "packaging_application"
      expr: packaging_application
      comment: "Target packaging application for the certified die for market segment analysis."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export compliance monitoring of certified die."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Quality hold indicator for certifications under review or suspension."
    - name: "reliability_qualified_flag"
      expr: reliability_qualified_flag
      comment: "Reliability qualification status for high-reliability application segmentation."
    - name: "burn_in_completed_flag"
      expr: burn_in_completed_flag
      comment: "Burn-in completion status for screening process compliance monitoring."
    - name: "certification_month"
      expr: DATE_TRUNC('month', certification_date)
      comment: "Month of certification for trend analysis of KGD certification throughput."
  measures:
    - name: "total_certified_quantity"
      expr: SUM(CAST(certified_quantity AS DOUBLE))
      comment: "Total quantity of KGD-certified die. Primary supply availability metric for high-reliability customer commitments."
    - name: "avg_probe_yield_pct"
      expr: AVG(CAST(probe_yield_pct AS DOUBLE))
      comment: "Average probe yield percentage across KGD certifications. Key quality metric; yield improvements directly reduce KGD unit cost."
    - name: "avg_electrical_test_pass_rate_pct"
      expr: AVG(CAST(electrical_test_pass_rate_pct AS DOUBLE))
      comment: "Average electrical test pass rate for KGD certifications. Measures test quality and die reliability for customer qualification."
    - name: "avg_dppm_level"
      expr: AVG(CAST(dppm_level AS DOUBLE))
      comment: "Average DPPM level across KGD certifications. Core quality KPI for customer agreements and reliability commitments."
    - name: "avg_test_coverage_percent"
      expr: AVG(CAST(test_coverage_percent AS DOUBLE))
      comment: "Average test coverage percentage. Measures thoroughness of KGD screening; low coverage increases field failure risk."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average overall yield percentage for KGD certifications. Tracks die quality trends and cost efficiency of KGD process."
    - name: "certifications_on_quality_hold"
      expr: COUNT(CASE WHEN quality_hold_flag = TRUE THEN inventory_kgd_certification_id END)
      comment: "Number of KGD certifications currently on quality hold. Directly constrains certified die supply for customer shipments."
    - name: "reliability_qualified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reliability_qualified_flag = TRUE THEN inventory_kgd_certification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KGD certifications with reliability qualification. Measures readiness for automotive and high-reliability markets."
    - name: "burn_in_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN burn_in_completed_flag = TRUE THEN inventory_kgd_certification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KGD certifications with completed burn-in screening. Tracks screening process compliance for reliability-critical applications."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_lot_genealogy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory lot genealogy metrics tracking material transformation yields, scrap rates, and traceability completeness. Used by quality, operations, and compliance teams to manage lot traceability, yield loss attribution, and regulatory reporting."
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_lot_genealogy`"
  dimensions:
    - name: "genealogy_type"
      expr: genealogy_type
      comment: "Type of genealogy relationship (split, merge, transform, rework) for material flow analysis."
    - name: "genealogy_status"
      expr: genealogy_status
      comment: "Status of the genealogy record for traceability completeness monitoring."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transformation transaction for process step analysis."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Parent-child relationship type for genealogy tree analysis."
    - name: "kgd_status"
      expr: kgd_status
      comment: "KGD status at transformation point for quality lineage tracking."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Quality hold flag at transformation for hold impact on genealogy."
    - name: "merge_indicator"
      expr: merge_indicator
      comment: "Indicates lot merge events for consolidation tracking."
    - name: "transformation_month"
      expr: DATE_TRUNC('month', transformation_date)
      comment: "Month of the lot transformation for yield trend analysis."
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Indicates transformations requiring customer notification for compliance and change management."
  measures:
    - name: "total_quantity_in"
      expr: SUM(CAST(quantity_in AS DOUBLE))
      comment: "Total input quantity across all lot transformations. Measures material throughput entering transformation steps."
    - name: "total_quantity_out"
      expr: SUM(CAST(quantity_out AS DOUBLE))
      comment: "Total output quantity across all lot transformations. Measures material throughput exiting transformation steps."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total quantity scrapped during lot transformations. Directly measures material loss and cost of poor quality."
    - name: "avg_yield_at_transformation_pct"
      expr: AVG(CAST(yield_at_transformation_pct AS DOUBLE))
      comment: "Average yield percentage at transformation steps. Key process efficiency metric; yield improvements reduce unit cost and increase supply."
    - name: "scrap_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity_in AS DOUBLE)), 0), 2)
      comment: "Percentage of input material scrapped during transformations. Measures material efficiency and cost of quality across the supply chain."
    - name: "customer_notification_required_count"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN inventory_lot_genealogy_id END)
      comment: "Number of transformations requiring customer notification. Tracks change management obligations and compliance workload."
    - name: "total_genealogy_records"
      expr: COUNT(1)
      comment: "Total number of genealogy records. Measures traceability coverage and completeness of lot history."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_lot_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory lot hold metrics tracking quality holds, hold reasons, duration, and resolution"
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_lot_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (e.g., active, released, expired)"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (e.g., quality, engineering, regulatory)"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for the hold"
    - name: "hold_reason_description"
      expr: hold_reason_description
      comment: "Detailed description of hold reason"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the held lot"
    - name: "hold_disposition"
      expr: hold_disposition
      comment: "Final disposition of the hold"
    - name: "hold_priority"
      expr: hold_priority
      comment: "Priority level of the hold"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the hold"
    - name: "is_regulatory_hold"
      expr: is_regulatory_hold
      comment: "Regulatory hold flag"
    - name: "mrb_required_flag"
      expr: mrb_required_flag
      comment: "Material Review Board required flag"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for the hold"
    - name: "hold_month"
      expr: DATE_TRUNC('MONTH', CAST(hold_date AS DATE))
      comment: "Month when the hold was placed"
  measures:
    - name: "total_holds"
      expr: COUNT(DISTINCT inventory_lot_hold_id)
      comment: "Total number of unique lot hold records"
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of inventory affected by holds"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total number of defects causing holds"
    - name: "avg_dppm"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average defects per million parts"
    - name: "regulatory_holds"
      expr: SUM(CASE WHEN is_regulatory_hold = TRUE THEN 1 ELSE 0 END)
      comment: "Number of regulatory holds"
    - name: "mrb_required_holds"
      expr: SUM(CASE WHEN mrb_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds requiring MRB review"
    - name: "regulatory_hold_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_regulatory_hold = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds that are regulatory"
    - name: "mrb_escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN mrb_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of holds requiring MRB escalation"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core wafer lot inventory metrics tracking lot status, cycle time, yield, and valuation across the fab"
  source: "`vibe_semiconductors_v1`.`inventory`.`inventory_wafer_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the wafer lot (e.g., in-process, hold, complete)"
    - name: "lot_type"
      expr: lot_type
      comment: "Type classification of the lot (e.g., production, engineering, qualification)"
    - name: "process_stage"
      expr: process_stage
      comment: "Current process stage in the fabrication flow"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority tier for scheduling and resource allocation"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the lot is currently on hold"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for lot hold status"
    - name: "process_node"
      expr: process_node
      comment: "Technology node for the wafer lot"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology used (e.g., DUV, EUV)"
    - name: "lot_start_month"
      expr: DATE_TRUNC('MONTH', lot_start_date)
      comment: "Month when the lot was started"
    - name: "target_completion_month"
      expr: DATE_TRUNC('MONTH', target_completion_date)
      comment: "Target month for lot completion"
  measures:
    - name: "total_wafer_lots"
      expr: COUNT(DISTINCT inventory_wafer_lot_id)
      comment: "Total number of unique wafer lots in inventory"
    - name: "total_wafer_count"
      expr: SUM(CAST(wafer_count AS DOUBLE))
      comment: "Total number of wafers across all lots"
    - name: "total_good_wafers"
      expr: SUM(CAST(good_wafer_count AS DOUBLE))
      comment: "Total number of good wafers passing quality criteria"
    - name: "total_scrap_wafers"
      expr: SUM(CAST(scrap_wafer_count AS DOUBLE))
      comment: "Total number of scrapped wafers"
    - name: "avg_wafers_per_lot"
      expr: AVG(CAST(wafer_count AS DOUBLE))
      comment: "Average number of wafers per lot"
    - name: "total_inventory_value"
      expr: SUM(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Total inventory valuation amount across all wafer lots"
    - name: "avg_inventory_value_per_lot"
      expr: AVG(CAST(inventory_valuation_amount AS DOUBLE))
      comment: "Average inventory valuation per wafer lot"
    - name: "lots_on_hold"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lots currently on hold"
    - name: "wafer_yield_rate"
      expr: ROUND(100.0 * SUM(CAST(good_wafer_count AS DOUBLE)) / NULLIF(SUM(CAST(wafer_count AS DOUBLE)), 0), 2)
      comment: "Percentage of good wafers to total wafers started"
    - name: "lot_hold_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots currently on hold"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_photomask_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Photomask asset metrics tracking asset value, usage, defect status, and lifecycle. Used by fab operations, finance, and design engineering to manage mask asset utilization, replacement planning, and NRE cost recovery."
  source: "`vibe_semiconductors_v1`.`inventory`.`photomask_asset`"
  dimensions:
    - name: "mask_status"
      expr: mask_status
      comment: "Current status of the photomask (active, retired, quarantine, inspection) for asset lifecycle management."
    - name: "photomask_asset_status"
      expr: photomask_asset_status
      comment: "Operational status of the photomask asset record for inventory management."
    - name: "mask_type"
      expr: mask_type
      comment: "Type of photomask (reticle, pellicle, binary, PSM) for technology and cost segmentation."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology (EUV, DUV, i-line) for capacity and cost analysis."
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for mask asset analysis by process generation."
    - name: "is_mpw_mask"
      expr: is_mpw_mask
      comment: "Indicates multi-project wafer masks for cost-sharing and utilization analysis."
    - name: "pellicle_present"
      expr: pellicle_present
      comment: "Pellicle presence flag for mask protection and maintenance planning."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR control flag for export compliance monitoring of mask assets."
    - name: "acquisition_month"
      expr: DATE_TRUNC('month', acquisition_date)
      comment: "Month of mask acquisition for capex trend and asset aging analysis."
  measures:
    - name: "total_acquisition_cost_usd"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Total acquisition cost of photomask assets in USD. Tracks NRE and capex investment in mask infrastructure."
    - name: "total_net_book_value_usd"
      expr: SUM(CAST(net_book_value_usd AS DOUBLE))
      comment: "Total net book value of photomask assets. Balance sheet metric for fixed asset reporting and depreciation planning."
    - name: "total_asset_valuation_usd"
      expr: SUM(CAST(asset_valuation_usd AS DOUBLE))
      comment: "Total current valuation of photomask assets. Used for insurance, replacement planning, and asset management decisions."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total NRE cost associated with photomask assets. Tracks non-recurring engineering investment for cost recovery analysis."
    - name: "avg_cd_uniformity_nm"
      expr: AVG(CAST(cd_uniformity_nm AS DOUBLE))
      comment: "Average critical dimension uniformity in nanometers. Quality metric for mask performance; degradation signals replacement need."
    - name: "avg_registration_error_nm"
      expr: AVG(CAST(registration_error_nm AS DOUBLE))
      comment: "Average mask registration error in nanometers. Process quality metric; high values indicate mask degradation impacting yield."
    - name: "avg_meef_value"
      expr: AVG(CAST(meef_value AS DOUBLE))
      comment: "Average Mask Error Enhancement Factor. Lithography quality metric; high MEEF values increase process sensitivity and yield risk."
    - name: "avg_mask_size_mm"
      expr: AVG(CAST(mask_size_mm AS DOUBLE))
      comment: "Average mask size in millimeters. Tracks mask format distribution for scanner compatibility and cost planning."
    - name: "avg_storage_humidity_pct"
      expr: AVG(CAST(storage_humidity_pct AS DOUBLE))
      comment: "Average storage humidity for photomask assets. Monitors storage condition compliance to prevent mask degradation."
    - name: "total_mask_assets"
      expr: COUNT(1)
      comment: "Total number of photomask assets in inventory. Baseline asset count for capacity and replacement planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_physical_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count metrics tracking count accuracy, variances, and cycle count performance"
  source: "`vibe_semiconductors_v1`.`inventory`.`physical_inventory`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the physical count (e.g., planned, in-progress, completed)"
    - name: "count_type"
      expr: count_type
      comment: "Type of count (e.g., full, cycle, spot)"
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (e.g., manual, barcode, RFID)"
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Indicates if recount is required"
    - name: "recount_flag"
      expr: recount_flag
      comment: "Indicates if this is a recount"
    - name: "variance_exceeds_tolerance_flag"
      expr: variance_exceeds_tolerance_flag
      comment: "Indicates if variance exceeds acceptable tolerance"
    - name: "adjustment_posted_flag"
      expr: adjustment_posted_flag
      comment: "Indicates if adjustment has been posted"
    - name: "freeze_flag"
      expr: freeze_flag
      comment: "Inventory freeze flag during count"
    - name: "consignment_flag"
      expr: consignment_flag
      comment: "Consignment inventory flag"
    - name: "inventory_category"
      expr: inventory_category
      comment: "Category of inventory counted"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification of counted items"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_date)
      comment: "Month when the count was performed"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the count"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the count"
  measures:
    - name: "total_counts"
      expr: COUNT(DISTINCT physical_inventory_id)
      comment: "Total number of unique physical inventory count records"
    - name: "total_book_quantity"
      expr: SUM(CAST(book_quantity AS DOUBLE))
      comment: "Total book quantity from system records"
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physically counted quantity"
    - name: "total_system_quantity"
      expr: SUM(CAST(system_quantity AS DOUBLE))
      comment: "Total system quantity before count"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance quantity (counted minus book)"
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value_usd AS DOUBLE))
      comment: "Total variance value in USD"
    - name: "avg_variance_percent"
      expr: AVG(CAST(variance_percent AS DOUBLE))
      comment: "Average variance percentage across all counts"
    - name: "recounts_required"
      expr: SUM(CASE WHEN recount_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of counts requiring recount"
    - name: "variances_exceeding_tolerance"
      expr: SUM(CASE WHEN variance_exceeds_tolerance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of counts with variance exceeding tolerance"
    - name: "adjustments_posted"
      expr: SUM(CASE WHEN adjustment_posted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of counts with adjustments posted"
    - name: "count_accuracy_rate"
      expr: ROUND(100.0 * (COUNT(1) - SUM(CASE WHEN variance_exceeds_tolerance_flag = TRUE THEN 1 ELSE 0 END)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts within acceptable tolerance"
    - name: "recount_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recount_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring recount"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_raw_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Raw material inventory metrics tracking stock levels, cost, compliance, and shelf life. Used by procurement, supply chain, and quality to manage material availability, supplier performance, and regulatory compliance for fab inputs."
  source: "`vibe_semiconductors_v1`.`inventory`.`raw_material`"
  dimensions:
    - name: "raw_material_status"
      expr: raw_material_status
      comment: "Current status of the raw material (available, quarantine, expired, blocked) for supply planning."
    - name: "material_type"
      expr: material_type
      comment: "Type of raw material (wafer, chemical, gas, substrate) for category-level analysis."
    - name: "material_class"
      expr: material_class
      comment: "Material classification for procurement and inventory management segmentation."
    - name: "material_group"
      expr: material_group
      comment: "Material group for spend and inventory analysis by commodity."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Supplier qualification status for approved vendor list compliance monitoring."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for regulatory inventory segmentation."
    - name: "reach_svhc_flag"
      expr: reach_svhc_flag
      comment: "REACH SVHC flag for hazardous substance compliance monitoring."
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Hazardous material flag for safety and regulatory compliance segmentation."
    - name: "wafer_type"
      expr: wafer_type
      comment: "Wafer substrate type for silicon material inventory analysis."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of material receipt for inventory build and consumption trend analysis."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total raw material quantity on hand. Primary supply availability metric for production planning and procurement decisions."
    - name: "total_standard_price_value"
      expr: SUM(CAST(standard_price AS DOUBLE))
      comment: "Total standard price value of raw material inventory. Working capital metric for procurement and finance leadership."
    - name: "avg_moving_avg_price"
      expr: AVG(CAST(moving_avg_price AS DOUBLE))
      comment: "Average moving average price per raw material record. Tracks actual procurement cost trends vs. standard for variance analysis."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost_usd AS DOUBLE))
      comment: "Average unit cost in USD across raw materials. Benchmarks material cost efficiency and supports procurement negotiations."
    - name: "avg_purity_pct"
      expr: AVG(CAST(purity_pct AS DOUBLE))
      comment: "Average material purity percentage. Quality metric for process-critical materials; purity deviations impact fab yield."
    - name: "avg_wafer_diameter_mm"
      expr: AVG(CAST(wafer_diameter_mm AS DOUBLE))
      comment: "Average wafer diameter of raw wafer inventory. Tracks wafer substrate mix for capacity and cost planning."
    - name: "total_safety_stock_qty"
      expr: SUM(CAST(safety_stock_qty AS DOUBLE))
      comment: "Total safety stock quantity across raw materials. Measures buffer inventory adequacy against supply disruption risk."
    - name: "total_reorder_point_qty"
      expr: SUM(CAST(reorder_point_qty AS DOUBLE))
      comment: "Total reorder point quantity across raw materials. Tracks replenishment trigger levels for procurement planning."
    - name: "below_safety_stock_count"
      expr: COUNT(CASE WHEN quantity_on_hand < safety_stock_qty THEN raw_material_id END)
      comment: "Number of raw materials below safety stock level. Critical supply risk metric; triggers emergency procurement actions."
    - name: "reach_svhc_material_count"
      expr: COUNT(CASE WHEN reach_svhc_flag = TRUE THEN raw_material_id END)
      comment: "Number of raw materials containing REACH SVHC substances. Regulatory compliance metric for product declarations and market access."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory reservation metrics tracking reserved quantities, fulfillment, and reservation status"
  source: "`vibe_semiconductors_v1`.`inventory`.`reservation`"
  dimensions:
    - name: "reservation_status"
      expr: reservation_status
      comment: "Current status of the reservation"
    - name: "reservation_type"
      expr: reservation_type
      comment: "Type of reservation (e.g., sales order, project, transfer)"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status of reserved items"
    - name: "priority"
      expr: priority
      comment: "Priority level of the reservation"
    - name: "reason"
      expr: reason
      comment: "Reason for the reservation"
    - name: "reference_document_type"
      expr: reference_document_type
      comment: "Type of document triggering the reservation"
    - name: "auto_release_flag"
      expr: auto_release_flag
      comment: "Automatic release flag"
    - name: "is_kgd"
      expr: is_kgd
      comment: "Known Good Die flag"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification of reserved items"
    - name: "reservation_month"
      expr: DATE_TRUNC('MONTH', reservation_date)
      comment: "Month when the reservation was created"
    - name: "required_month"
      expr: DATE_TRUNC('MONTH', required_date)
      comment: "Month when the reserved items are required"
  measures:
    - name: "total_reservations"
      expr: COUNT(DISTINCT reservation_id)
      comment: "Total number of unique reservation records"
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved across all reservations"
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity fulfilled from reservations"
    - name: "avg_reserved_quantity"
      expr: AVG(CAST(reserved_quantity AS DOUBLE))
      comment: "Average quantity per reservation"
    - name: "avg_fulfilled_quantity"
      expr: AVG(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Average fulfilled quantity per reservation"
    - name: "kgd_reservations"
      expr: SUM(CASE WHEN is_kgd = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reservations for Known Good Die"
    - name: "auto_release_reservations"
      expr: SUM(CASE WHEN auto_release_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reservations with auto-release enabled"
    - name: "reservation_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(fulfilled_quantity AS DOUBLE)) / NULLIF(SUM(CAST(reserved_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of reserved quantity that has been fulfilled"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_stock_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock balance metrics tracking on-hand, reserved, blocked, and in-transit inventory quantities and values"
  source: "`vibe_semiconductors_v1`.`inventory`.`stock_balance`"
  dimensions:
    - name: "stock_type"
      expr: stock_type
      comment: "Type of stock (e.g., unrestricted, blocked, quality inspection)"
    - name: "balance_type"
      expr: balance_type
      comment: "Balance classification type"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die certification status"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification for quality grading"
    - name: "special_stock_indicator"
      expr: special_stock_indicator
      comment: "Indicator for special stock types (e.g., consignment, project)"
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Export control restriction flag"
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance flag"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Hazardous material flag"
    - name: "slow_moving_flag"
      expr: slow_moving_flag
      comment: "Slow-moving inventory flag"
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (e.g., FIFO, weighted average)"
    - name: "balance_month"
      expr: DATE_TRUNC('MONTH', balance_date)
      comment: "Month of the stock balance snapshot"
  measures:
    - name: "total_stock_records"
      expr: COUNT(DISTINCT stock_balance_id)
      comment: "Total number of unique stock balance records"
    - name: "total_qty_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all stock locations"
    - name: "total_qty_available"
      expr: SUM(CAST(qty_available AS DOUBLE))
      comment: "Total quantity available for use (unrestricted)"
    - name: "total_qty_reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total quantity reserved for orders or projects"
    - name: "total_qty_blocked"
      expr: SUM(CAST(qty_blocked AS DOUBLE))
      comment: "Total quantity blocked from use (quality hold, etc.)"
    - name: "total_qty_in_transit"
      expr: SUM(CAST(qty_in_transit AS DOUBLE))
      comment: "Total quantity in transit between locations"
    - name: "total_qty_in_wip"
      expr: SUM(CAST(qty_in_wip AS DOUBLE))
      comment: "Total quantity in work-in-process"
    - name: "total_stock_value"
      expr: SUM(CAST(total_value_usd AS DOUBLE))
      comment: "Total inventory value in USD"
    - name: "avg_stock_value"
      expr: AVG(CAST(total_value_usd AS DOUBLE))
      comment: "Average stock value per balance record"
    - name: "inventory_availability_rate"
      expr: ROUND(100.0 * SUM(CAST(qty_available AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available for use"
    - name: "inventory_blocked_rate"
      expr: ROUND(100.0 * SUM(CAST(qty_blocked AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is blocked"
    - name: "inventory_reservation_rate"
      expr: ROUND(100.0 * SUM(CAST(qty_reserved AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is reserved"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_stock_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock valuation metrics tracking inventory value, cost components, and valuation methods"
  source: "`vibe_semiconductors_v1`.`inventory`.`stock_valuation`"
  dimensions:
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method (e.g., standard cost, moving average)"
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record"
    - name: "valuation_type"
      expr: valuation_type
      comment: "Type of valuation (e.g., periodic, perpetual)"
    - name: "valuation_class"
      expr: valuation_class
      comment: "Valuation class for accounting purposes"
    - name: "inventory_category"
      expr: inventory_category
      comment: "Category of inventory being valued"
    - name: "is_consignment"
      expr: is_consignment
      comment: "Consignment inventory flag"
    - name: "revaluation_flag"
      expr: revaluation_flag
      comment: "Indicates if revaluation has occurred"
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for audit compliance"
    - name: "bin_classification"
      expr: bin_classification
      comment: "Bin classification for quality grading"
    - name: "kgd_status"
      expr: kgd_status
      comment: "Known Good Die status"
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag"
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag"
    - name: "valuation_month"
      expr: DATE_TRUNC('MONTH', valuation_date)
      comment: "Month of valuation"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the valuation"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the valuation"
  measures:
    - name: "total_valuation_records"
      expr: COUNT(DISTINCT stock_valuation_id)
      comment: "Total number of unique stock valuation records"
    - name: "total_stock_value"
      expr: SUM(CAST(total_stock_value AS DOUBLE))
      comment: "Total stock value across all records"
    - name: "total_value_usd"
      expr: SUM(CAST(total_value_usd AS DOUBLE))
      comment: "Total inventory value in USD"
    - name: "total_quantity_valued"
      expr: SUM(CAST(quantity_valued AS DOUBLE))
      comment: "Total quantity of inventory valued"
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost component"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost component"
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost AS DOUBLE))
      comment: "Total overhead cost component"
    - name: "total_nre_allocation"
      expr: SUM(CAST(nre_cost_allocation AS DOUBLE))
      comment: "Total NRE cost allocation"
    - name: "total_obsolescence_reserve"
      expr: SUM(CAST(obsolescence_reserve_usd AS DOUBLE))
      comment: "Total obsolescence reserve in USD"
    - name: "total_write_down"
      expr: SUM(CAST(write_down_amount_usd AS DOUBLE))
      comment: "Total inventory write-down amount in USD"
    - name: "total_price_variance"
      expr: SUM(CAST(price_variance_usd AS DOUBLE))
      comment: "Total price variance in USD"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost_usd AS DOUBLE))
      comment: "Average standard cost per unit"
    - name: "avg_moving_average_cost"
      expr: AVG(CAST(moving_average_cost_usd AS DOUBLE))
      comment: "Average moving average cost per unit"
    - name: "material_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(material_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_value_usd AS DOUBLE)), 0), 2)
      comment: "Material cost as percentage of total inventory value"
    - name: "labor_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(labor_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_value_usd AS DOUBLE)), 0), 2)
      comment: "Labor cost as percentage of total inventory value"
    - name: "overhead_cost_ratio"
      expr: ROUND(100.0 * SUM(CAST(overhead_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_value_usd AS DOUBLE)), 0), 2)
      comment: "Overhead cost as percentage of total inventory value"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`inventory_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage location capacity and compliance metrics tracking utilization, environmental conditions, and certification status. Used by facilities, supply chain, and compliance teams to manage storage capacity, environmental compliance, and regulatory certifications."
  source: "`vibe_semiconductors_v1`.`inventory`.`storage_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location (warehouse, cleanroom, vault, staging) for capacity planning segmentation."
    - name: "location_status"
      expr: location_status
      comment: "Operational status of the storage location for availability management."
    - name: "storage_location_status"
      expr: storage_location_status
      comment: "Current status of the storage location record for operational monitoring."
    - name: "facility_type"
      expr: facility_type
      comment: "Facility type for location categorization and capacity planning."
    - name: "cleanroom_iso_class"
      expr: cleanroom_iso_class
      comment: "ISO cleanroom classification for contamination-sensitive storage compliance."
    - name: "kgd_storage_certified"
      expr: kgd_storage_certified
      comment: "KGD storage certification flag for high-reliability die storage compliance."
    - name: "esd_protected_flag"
      expr: esd_protected_flag
      comment: "ESD protection flag for electrostatic-sensitive device storage compliance."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR control flag for export-controlled item storage compliance."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Temperature control flag for environmentally sensitive material storage."
    - name: "is_active"
      expr: is_active
      comment: "Active status flag for operational vs. decommissioned location analysis."
  measures:
    - name: "avg_utilization_pct"
      expr: AVG(CAST(current_utilization_pct AS DOUBLE))
      comment: "Average storage utilization percentage across locations. Primary capacity management KPI; high utilization signals need for expansion."
    - name: "max_utilization_pct"
      expr: MAX(current_utilization_pct)
      comment: "Maximum storage utilization percentage. Identifies critically full locations requiring immediate capacity action."
    - name: "total_weight_capacity_kg"
      expr: SUM(CAST(weight_capacity_kg AS DOUBLE))
      comment: "Total weight capacity across storage locations. Measures aggregate storage infrastructure capacity for planning."
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum temperature setting across controlled storage locations. Monitors environmental compliance for temperature-sensitive materials."
    - name: "avg_max_humidity_pct"
      expr: AVG(CAST(max_humidity_pct AS DOUBLE))
      comment: "Average maximum humidity setting across controlled storage locations. Monitors moisture control compliance for MSD and photomask storage."
    - name: "kgd_certified_location_count"
      expr: COUNT(CASE WHEN kgd_storage_certified = TRUE THEN storage_location_id END)
      comment: "Number of KGD-certified storage locations. Measures certified storage capacity for high-reliability die inventory."
    - name: "active_location_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN storage_location_id END)
      comment: "Number of active storage locations. Baseline capacity metric for warehouse network planning."
    - name: "itar_controlled_location_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN storage_location_id END)
      comment: "Number of ITAR-controlled storage locations. Compliance metric for export-controlled inventory segregation requirements."
$$;
