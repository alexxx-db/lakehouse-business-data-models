-- Metric views for domain: supply | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 18:21:26

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for inbound goods receipts — tracks receiving volume, cost, temperature compliance, and cold-chain integrity to steer supplier delivery quality and food-safety posture."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Current status of the goods receipt (e.g. pending, accepted, rejected) — used to filter active vs. closed receipts."
    - name: "receiving_method"
      expr: receiving_method
      comment: "Method used to receive goods (e.g. dock, direct-store) — supports analysis of receiving efficiency by channel."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which receipt costs are denominated — required for multi-currency cost analysis."
    - name: "condition"
      expr: condition
      comment: "Physical condition of goods at receipt (e.g. good, damaged, partial) — key quality dimension."
    - name: "temperature_deviation_flag"
      expr: temperature_deviation_flag
      comment: "Indicates whether a temperature deviation was recorded at receipt — critical food-safety dimension."
    - name: "is_cold_chain_compliant"
      expr: is_cold_chain_compliant
      comment: "Whether the cold chain was maintained end-to-end for this receipt — regulatory and food-safety dimension."
    - name: "receipt_date"
      expr: DATE_TRUNC('day', receipt_timestamp)
      comment: "Calendar day of receipt — enables daily and weekly receiving trend analysis."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Calendar month of receipt — supports monthly receiving volume and cost trending."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt events — baseline volume KPI for receiving operations."
    - name: "total_received_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of goods received across all receipts — measures inbound supply volume."
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all goods received — primary cost-of-goods input for supply chain finance."
    - name: "avg_receipt_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per goods receipt event — benchmarks typical receipt size for budget planning."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average recorded temperature at receipt — monitors cold-chain compliance and food-safety risk."
    - name: "temperature_deviation_receipt_count"
      expr: COUNT(CASE WHEN temperature_deviation_flag = TRUE THEN 1 END)
      comment: "Number of receipts with a recorded temperature deviation — direct food-safety risk indicator."
    - name: "cold_chain_non_compliant_count"
      expr: COUNT(CASE WHEN is_cold_chain_compliant = FALSE THEN 1 END)
      comment: "Number of receipts where cold-chain compliance was not maintained — triggers supplier corrective action."
    - name: "cold_chain_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cold_chain_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipts that maintained full cold-chain compliance — executive food-safety KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_goods_receipt_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level receiving quality and variance KPIs — tracks accepted vs. rejected quantities, cost variances, quality scores, and inspection outcomes to drive supplier accountability."
  source: "`vibe_restaurants_v1`.`supply`.`goods_receipt_line`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Result of the line-level inspection (e.g. passed, failed, pending) — primary quality dimension."
    - name: "recall_status"
      expr: recall_status
      comment: "Whether this receipt line is subject to an active recall — critical food-safety and compliance dimension."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Whether the received item is perishable — drives cold-chain and shelf-life analysis."
    - name: "is_returned"
      expr: is_returned
      comment: "Whether the line item was returned to the supplier — measures return rate and supplier quality."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the line passed all compliance checks — regulatory and quality gate dimension."
    - name: "temperature_control_required"
      expr: temperature_control_required
      comment: "Whether temperature control was required for this line — used to segment cold-chain analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of line-level cost — required for multi-currency cost analysis."
    - name: "received_month"
      expr: DATE_TRUNC('month', received_timestamp)
      comment: "Month goods were received — supports monthly quality and variance trending."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of goods accepted at line level — primary inbound volume measure."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at receipt — measures supplier quality failure volume."
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)) + SUM(CAST(rejected_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of inbound quantity rejected — key supplier quality KPI used in performance reviews."
    - name: "total_line_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of goods received at line level — feeds COGS and procurement spend analysis."
    - name: "total_cogs_amount"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost-of-goods-sold amount from received lines — direct input to margin calculations."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance between PO price and actual receipt cost — measures procurement pricing accuracy."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between ordered and received — measures supplier fill-rate accuracy."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across received lines — composite supplier quality indicator for scorecards."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price paid across receipt lines — benchmarks against contract prices for compliance."
    - name: "return_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_returned = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipt lines that were returned to supplier — measures supplier delivery quality."
    - name: "compliance_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of receipt lines passing all compliance checks — regulatory and food-safety KPI."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound logistics KPIs — tracks on-time delivery, freight cost, shipment exceptions, and temperature compliance to optimize carrier performance and supply chain reliability."
  source: "`vibe_restaurants_v1`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment (e.g. in-transit, delivered, delayed) — primary logistics dimension."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g. truck, rail, air) — used to analyze cost and reliability by carrier type."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier — enables carrier-level performance benchmarking."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (e.g. FOB, CIF) — affects cost allocation and liability analysis."
    - name: "temperature_control_flag"
      expr: temperature_control_flag
      comment: "Whether temperature control was required for this shipment — segments cold-chain analysis."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Whether the shipment was expedited — used to measure and control premium freight spend."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the freight invoice — tracks outstanding freight payables."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Status of customs clearance — critical for international supply chain compliance tracking."
    - name: "scheduled_arrival_month"
      expr: DATE_TRUNC('month', scheduled_arrival_timestamp)
      comment: "Month of scheduled arrival — supports monthly inbound volume and on-time delivery trending."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of freight cost — required for multi-currency freight spend analysis."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of inbound shipments — baseline logistics volume KPI."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all inbound shipments — primary logistics cost KPI for budget management."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment — benchmarks carrier pricing and identifies cost outliers."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total inbound weight in kilograms — measures physical supply volume for capacity planning."
    - name: "total_volume_cubic_m"
      expr: SUM(CAST(volume_cubic_m AS DOUBLE))
      comment: "Total inbound volume in cubic meters — supports DC capacity and dock scheduling decisions."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_arrival_timestamp <= scheduled_arrival_timestamp THEN 1 END)
      comment: "Number of shipments that arrived on or before scheduled time — measures carrier reliability."
    - name: "on_time_delivery_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_timestamp <= scheduled_arrival_timestamp THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments delivered on time — top-tier carrier performance KPI for executive scorecards."
    - name: "expedited_shipment_count"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Number of expedited shipments — measures premium freight usage; high values signal supply chain stress."
    - name: "expedited_freight_cost"
      expr: SUM(CASE WHEN is_expedited = TRUE THEN freight_cost ELSE 0 END)
      comment: "Total freight cost attributable to expedited shipments — quantifies premium freight spend for cost reduction."
    - name: "avg_temperature_max_c"
      expr: AVG(CAST(temperature_max_c AS DOUBLE))
      comment: "Average maximum recorded temperature across temperature-controlled shipments — food-safety compliance indicator."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply quality inspection KPIs — tracks inspection pass/fail rates, corrective action requirements, defect categories, and quality scores to manage food safety and supplier compliance."
  source: "`vibe_restaurants_v1`.`supply`.`quality_inspection`"
  dimensions:
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Current status of the quality inspection (e.g. pass, fail, pending) — primary quality gate dimension."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g. incoming, periodic, HACCP) — segments quality analysis by inspection program."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (e.g. visual, lab, sensor) — supports methodology effectiveness analysis."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the inspection (e.g. pass, fail, conditional) — key quality outcome dimension."
    - name: "defect_category"
      expr: defect_category
      comment: "Category of defect identified (e.g. temperature, contamination, packaging) — drives root-cause analysis."
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken on failed items (e.g. reject, quarantine, accept-with-deviation) — measures response severity."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether a corrective action was required — flags systemic supplier quality issues."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the inspection result was compliant with regulatory standards — regulatory reporting dimension."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of inspection — supports monthly quality trend analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of quality inspections performed — baseline quality program volume KPI."
    - name: "pass_count"
      expr: COUNT(CASE WHEN inspection_result = 'pass' THEN 1 END)
      comment: "Number of inspections with a passing result — measures quality acceptance volume."
    - name: "fail_count"
      expr: COUNT(CASE WHEN inspection_result = 'fail' THEN 1 END)
      comment: "Number of inspections with a failing result — primary quality failure volume KPI."
    - name: "inspection_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections passing — top-level supplier quality KPI for executive scorecards and QBRs."
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring corrective action — measures systemic quality failure frequency."
    - name: "total_rejection_quantity"
      expr: SUM(CAST(rejection_quantity AS DOUBLE))
      comment: "Total quantity rejected across all quality inspections — measures physical waste from quality failures."
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average temperature recorded during inspections — monitors cold-chain and storage compliance."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity recorded during inspections — monitors storage environment compliance."
    - name: "compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections meeting all regulatory compliance requirements — regulatory reporting KPI."
    - name: "distinct_suppliers_inspected"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers with quality inspections in the period — measures breadth of quality program coverage."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier scorecard KPIs — aggregates on-time delivery, fill rate, quality rejection, invoice accuracy, and food-safety compliance scores to drive supplier selection, development, and contract decisions."
  source: "`vibe_restaurants_v1`.`supply`.`supplier_performance`"
  dimensions:
    - name: "rating_tier"
      expr: rating_tier
      comment: "Supplier performance tier (e.g. preferred, approved, probation) — primary segmentation for supplier management."
    - name: "contract_compliance_flag"
      expr: contract_compliance_flag
      comment: "Whether the supplier met contract compliance requirements in the period — contract management dimension."
    - name: "corrective_action_flag"
      expr: corrective_action_flag
      comment: "Whether a corrective action was issued to the supplier in the period — quality escalation dimension."
    - name: "measurement_period_start"
      expr: DATE_TRUNC('month', measurement_period_start)
      comment: "Start of the measurement period — enables time-series trending of supplier performance."
    - name: "measurement_period_end"
      expr: DATE_TRUNC('month', measurement_period_end)
      comment: "End of the measurement period — supports period-over-period supplier performance comparison."
  measures:
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across suppliers — primary logistics reliability KPI for supplier scorecards."
    - name: "avg_fill_rate"
      expr: AVG(CAST(fill_rate AS DOUBLE))
      comment: "Average fill rate across suppliers — measures supplier ability to fulfill ordered quantities; low values signal supply risk."
    - name: "avg_quality_rejection_rate"
      expr: AVG(CAST(quality_rejection_rate AS DOUBLE))
      comment: "Average quality rejection rate across suppliers — key quality KPI; high values trigger supplier development programs."
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate — measures billing compliance; low values increase AP processing cost."
    - name: "avg_food_safety_compliance_score"
      expr: AVG(CAST(food_safety_compliance_score AS DOUBLE))
      comment: "Average food safety compliance score across suppliers — regulatory and brand-risk KPI for executive review."
    - name: "avg_lead_time_days"
      expr: AVG(CAST(average_lead_time_days AS DOUBLE))
      comment: "Average supplier lead time in days — measures supply chain responsiveness and inventory planning accuracy."
    - name: "total_orders_evaluated"
      expr: SUM(CAST(total_orders_evaluated AS DOUBLE))
      comment: "Total number of orders evaluated in supplier performance measurement — provides statistical confidence context."
    - name: "total_invoices_evaluated"
      expr: SUM(CAST(total_invoices_evaluated AS DOUBLE))
      comment: "Total number of invoices evaluated — supports invoice accuracy rate significance assessment."
    - name: "corrective_action_supplier_count"
      expr: COUNT(CASE WHEN corrective_action_flag = TRUE THEN 1 END)
      comment: "Number of supplier-period records with an active corrective action — measures breadth of quality escalations."
    - name: "preferred_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN rating_tier = 'preferred' THEN procurement_supplier_id END)
      comment: "Number of distinct suppliers in the preferred tier — tracks strategic supplier base health."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_recall_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety recall KPIs — tracks recall volume, severity, cost, regulatory compliance, and closure rates to manage brand risk, regulatory obligations, and supply chain integrity."
  source: "`vibe_restaurants_v1`.`supply`.`recall_event`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall (e.g. active, closed, monitoring) — primary recall management dimension."
    - name: "recall_class"
      expr: recall_class
      comment: "FDA recall class (I, II, III) — indicates severity and regulatory urgency of the recall."
    - name: "recall_severity"
      expr: recall_severity
      comment: "Business-defined severity level of the recall — used to prioritize response resources."
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g. voluntary, mandatory, market withdrawal) — affects regulatory reporting requirements."
    - name: "recall_reason"
      expr: recall_reason
      comment: "Root cause of the recall (e.g. contamination, mislabeling, allergen) — drives preventive action programs."
    - name: "product_category"
      expr: product_category
      comment: "Category of the recalled product — enables category-level risk analysis."
    - name: "compliance_fda"
      expr: compliance_fda
      comment: "Whether FDA notification requirements were met — regulatory compliance dimension."
    - name: "compliance_usda"
      expr: compliance_usda
      comment: "Whether USDA notification requirements were met — regulatory compliance dimension."
    - name: "recall_initiation_month"
      expr: DATE_TRUNC('month', recall_initiation_timestamp)
      comment: "Month recall was initiated — supports trend analysis of recall frequency over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of recall cost — required for multi-currency financial impact analysis."
  measures:
    - name: "total_recall_events"
      expr: COUNT(1)
      comment: "Total number of recall events — baseline food safety risk volume KPI for executive and regulatory reporting."
    - name: "active_recall_count"
      expr: COUNT(CASE WHEN recall_status = 'active' THEN 1 END)
      comment: "Number of currently active recalls — real-time brand and regulatory risk indicator."
    - name: "total_quantity_recalled"
      expr: SUM(CAST(quantity_recalled AS DOUBLE))
      comment: "Total quantity of product recalled — measures physical scale of supply chain disruption."
    - name: "total_recall_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total financial cost of recall events — quantifies brand and operational impact for executive review."
    - name: "avg_recall_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per recall event — benchmarks recall response efficiency and severity."
    - name: "class_one_recall_count"
      expr: COUNT(CASE WHEN recall_class = 'I' THEN 1 END)
      comment: "Number of Class I (highest severity) recalls — most critical food safety KPI for board-level reporting."
    - name: "fda_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_fda = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recalls meeting FDA notification compliance — regulatory obligation KPI."
    - name: "distinct_suppliers_with_recalls"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers involved in recall events — identifies high-risk supplier concentration."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_ingredient_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ingredient lot traceability and yield KPIs — tracks lot quality, waste, yield, recall exposure, and cost to optimize ingredient procurement and food safety traceability programs."
  source: "`vibe_restaurants_v1`.`supply`.`ingredient_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the ingredient lot (e.g. available, quarantine, consumed, disposed) — primary lot management dimension."
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot (e.g. production, purchased, returned) — segments lot analysis by origin."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status of the lot — food safety gate dimension."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether this lot is subject to an active recall — critical food safety and traceability dimension."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Whether the lot is certified organic — supports premium ingredient sourcing analysis."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether the lot requires temperature control — cold-chain compliance dimension."
    - name: "ingredient_category"
      expr: ingredient_category
      comment: "Category of the ingredient — enables category-level cost and quality analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the ingredient was produced — supports origin-based compliance and risk analysis."
    - name: "received_month"
      expr: DATE_TRUNC('month', received_date)
      comment: "Month the lot was received — supports monthly inbound ingredient volume trending."
  measures:
    - name: "total_lots"
      expr: COUNT(1)
      comment: "Total number of ingredient lots — baseline traceability program volume KPI."
    - name: "total_lot_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity across all ingredient lots — measures physical ingredient inventory volume."
    - name: "total_lot_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all ingredient lots — primary ingredient procurement spend KPI."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across ingredient lots — benchmarks ingredient pricing for procurement negotiations."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across ingredient lots — composite ingredient quality indicator."
    - name: "avg_waste_percentage"
      expr: AVG(CAST(waste_percentage AS DOUBLE))
      comment: "Average waste percentage across ingredient lots — measures ingredient utilization efficiency; drives cost reduction."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across ingredient lots — measures usable output per lot; key for recipe costing accuracy."
    - name: "recalled_lot_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of lots subject to an active recall — food safety risk volume KPI for regulatory reporting."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average storage temperature across lots — monitors cold-chain and storage compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier contract portfolio KPIs — tracks contract value, rebate exposure, exclusivity, compliance status, and renewal pipeline to manage procurement risk and commercial terms."
  source: "`vibe_restaurants_v1`.`supply`.`supplier_contract`"
  dimensions:
    - name: "supplier_contract_status"
      expr: supplier_contract_status
      comment: "Current status of the supplier contract (e.g. active, expired, terminated) — primary contract portfolio dimension."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g. master, spot, framework) — segments contract analysis by commercial structure."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the contract — identifies contracts at risk of breach or regulatory non-compliance."
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of the contract — tracks audit completion and findings for governance reporting."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of contract renewal (e.g. auto-renew, manual, evergreen) — supports renewal pipeline management."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Whether the contract includes an exclusivity clause — measures supplier lock-in risk."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method specified in the contract — supports AP and cash flow analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the contract — required for multi-currency contract value analysis."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the contract became effective — supports contract vintage and cohort analysis."
    - name: "effective_until_month"
      expr: DATE_TRUNC('month', effective_until)
      comment: "Month the contract expires — enables renewal pipeline and expiry risk analysis."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of supplier contracts — baseline contract portfolio volume KPI."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN supplier_contract_status = 'active' THEN 1 END)
      comment: "Number of currently active supplier contracts — measures active commercial relationship coverage."
    - name: "total_default_price"
      expr: SUM(CAST(default_price AS DOUBLE))
      comment: "Sum of default contract prices — approximates total contracted spend commitment across the portfolio."
    - name: "avg_default_price"
      expr: AVG(CAST(default_price AS DOUBLE))
      comment: "Average default contract price — benchmarks contract pricing for negotiation and renewal planning."
    - name: "total_liability_limit"
      expr: SUM(CAST(liability_limit AS DOUBLE))
      comment: "Total liability limit exposure across all contracts — measures maximum financial risk from supplier failures."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across contracts — measures commercial benefit from volume commitments."
    - name: "total_rebate_threshold"
      expr: SUM(CAST(rebate_threshold_amount AS DOUBLE))
      comment: "Total rebate threshold amount across contracts — measures spend required to unlock rebate benefits."
    - name: "exclusivity_contract_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Number of contracts with exclusivity clauses — measures supplier lock-in concentration risk."
    - name: "non_compliant_contract_count"
      expr: COUNT(CASE WHEN compliance_status != 'compliant' THEN 1 END)
      comment: "Number of contracts not in full compliance — flags procurement governance risk for executive review."
    - name: "distinct_suppliers_under_contract"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of distinct suppliers with active contracts — measures breadth of contracted supplier base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_distribution_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution center capacity and compliance KPIs — tracks storage utilization, HACCP compliance, inspection scores, and facility characteristics to optimize DC network performance."
  source: "`vibe_restaurants_v1`.`supply`.`distribution_center`"
  dimensions:
    - name: "distribution_center_status"
      expr: distribution_center_status
      comment: "Operational status of the DC (e.g. active, closed, under-renovation) — primary facility dimension."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g. ambient, refrigerated, frozen) — segments capacity analysis by storage type."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Whether the DC is owned, leased, or 3PL-operated — affects cost structure and strategic flexibility."
    - name: "region"
      expr: region
      comment: "Geographic region of the DC — enables regional supply chain coverage and cost analysis."
    - name: "country"
      expr: country
      comment: "Country where the DC is located — supports international supply chain compliance analysis."
    - name: "haccp_compliant"
      expr: haccp_compliant
      comment: "Whether the DC is HACCP compliant — food safety regulatory compliance dimension."
    - name: "cross_dock_enabled"
      expr: cross_dock_enabled
      comment: "Whether the DC supports cross-docking — affects throughput capacity and logistics network design."
    - name: "third_party_logistics_flag"
      expr: third_party_logistics_flag
      comment: "Whether the DC is operated by a third-party logistics provider — affects cost and control analysis."
    - name: "refrigeration_type"
      expr: refrigeration_type
      comment: "Type of refrigeration system — supports cold-chain capability and compliance analysis."
  measures:
    - name: "total_distribution_centers"
      expr: COUNT(1)
      comment: "Total number of distribution centers in the network — baseline DC network coverage KPI."
    - name: "total_storage_capacity_cubic_meters"
      expr: SUM(CAST(storage_capacity_cubic_meters AS DOUBLE))
      comment: "Total storage capacity across all DCs in cubic meters — measures network-wide storage capacity for planning."
    - name: "avg_storage_capacity_cubic_meters"
      expr: AVG(CAST(storage_capacity_cubic_meters AS DOUBLE))
      comment: "Average storage capacity per DC — benchmarks facility sizing for network optimization."
    - name: "avg_cost_per_square_meter"
      expr: AVG(CAST(cost_per_square_meter AS DOUBLE))
      comment: "Average cost per square meter across DCs — benchmarks facility cost efficiency for lease negotiations."
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average inspection score across DCs — composite facility compliance and quality KPI."
    - name: "haccp_compliant_dc_count"
      expr: COUNT(CASE WHEN haccp_compliant = TRUE THEN 1 END)
      comment: "Number of HACCP-compliant DCs — measures food safety regulatory coverage across the DC network."
    - name: "haccp_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN haccp_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DCs that are HACCP compliant — executive food safety network KPI."
    - name: "third_party_dc_count"
      expr: COUNT(CASE WHEN third_party_logistics_flag = TRUE THEN 1 END)
      comment: "Number of DCs operated by third-party logistics providers — measures outsourcing exposure in the DC network."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`supply_commodity_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity category spend and risk KPIs — tracks average cost, spend concentration, lead times, and strategic sourcing tiers to inform category management and procurement strategy."
  source: "`vibe_restaurants_v1`.`supply`.`commodity_category`"
  dimensions:
    - name: "commodity_category_status"
      expr: commodity_category_status
      comment: "Status of the commodity category (e.g. active, deprecated) — filters analysis to active categories."
    - name: "category_type"
      expr: category_type
      comment: "Type of category (e.g. direct, indirect, perishable) — primary category management dimension."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity (e.g. protein, produce, dairy) — enables commodity-level spend and risk analysis."
    - name: "strategic_sourcing_tier"
      expr: strategic_sourcing_tier
      comment: "Strategic sourcing tier (e.g. strategic, leverage, bottleneck, non-critical) — Kraljic matrix dimension for procurement strategy."
    - name: "risk_level"
      expr: risk_level
      comment: "Supply risk level of the category — prioritizes risk mitigation investment."
    - name: "is_perishable"
      expr: is_perishable
      comment: "Whether the category contains perishable items — drives cold-chain and inventory policy decisions."
    - name: "is_leaf_category"
      expr: is_leaf_category
      comment: "Whether this is a leaf-level category in the hierarchy — filters to most granular category level for analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the category hierarchy — supports hierarchical roll-up and drill-down analysis."
    - name: "compliance_fda"
      expr: compliance_fda
      comment: "FDA compliance requirement for the category — regulatory dimension for sourcing decisions."
  measures:
    - name: "total_categories"
      expr: COUNT(1)
      comment: "Total number of commodity categories — baseline category portfolio size KPI."
    - name: "total_spend_percentage"
      expr: SUM(CAST(spend_percentage AS DOUBLE))
      comment: "Sum of spend percentage across categories — measures spend concentration for Pareto analysis."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(average_cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across commodity categories — benchmarks category pricing for procurement strategy."
    - name: "avg_typical_cogs_percent"
      expr: AVG(CAST(typical_cogs_percent AS DOUBLE))
      comment: "Average typical COGS percentage across categories — informs menu pricing and margin management decisions."
    - name: "high_risk_category_count"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN 1 END)
      comment: "Number of high-risk commodity categories — measures supply chain vulnerability concentration."
    - name: "strategic_category_count"
      expr: COUNT(CASE WHEN strategic_sourcing_tier = 'strategic' THEN 1 END)
      comment: "Number of categories in the strategic sourcing tier — measures scope of strategic procurement programs."
    - name: "perishable_category_count"
      expr: COUNT(CASE WHEN is_perishable = TRUE THEN 1 END)
      comment: "Number of perishable commodity categories — measures cold-chain dependency in the supply base."
$$;