-- Metric views for domain: supply | Business: Ngo | Version: 2 | Generated on: 2026-07-03 06:15:30

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_procurement_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement pipeline metrics tracking request volumes, cost estimates, urgency distribution, and approval cycle efficiency to steer sourcing decisions and budget planning."
  source: "`vibe_ngo_v1`.`supply`.`procurement_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current lifecycle status of the procurement request (e.g. Draft, Submitted, Approved, Rejected) for pipeline stage analysis."
    - name: "request_type"
      expr: request_type
      comment: "Type of procurement request (e.g. goods, services, works) enabling category-level spend analysis."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the request (e.g. Routine, Urgent, Emergency) for prioritisation and resource allocation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the estimated cost is denominated, enabling multi-currency spend analysis."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Calendar month the request was raised, used for trend and seasonality analysis."
    - name: "approval_level_required"
      expr: approval_level_required
      comment: "Approval authority level required for the request, indicating governance complexity."
    - name: "local_procurement_preference"
      expr: local_procurement_preference
      comment: "Flag indicating whether local sourcing is preferred, supporting localisation strategy tracking."
    - name: "compliance_check_required"
      expr: compliance_check_required
      comment: "Flag indicating whether a compliance check is mandatory, used for regulatory oversight reporting."
  measures:
    - name: "total_procurement_requests"
      expr: COUNT(1)
      comment: "Total number of procurement requests raised; baseline volume KPI for pipeline sizing and workload management."
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Sum of estimated total costs across all procurement requests; primary spend-pipeline indicator for budget holders."
    - name: "avg_estimated_unit_cost"
      expr: AVG(CAST(estimated_unit_cost AS DOUBLE))
      comment: "Average estimated unit cost per procurement request line; benchmarks unit pricing against market rates."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity_requested AS DOUBLE))
      comment: "Total quantity of goods or services requested across all procurement requests; drives demand forecasting."
    - name: "approved_requests_count"
      expr: COUNT(CASE WHEN request_status = 'Approved' THEN 1 END)
      comment: "Number of procurement requests that have been approved; measures throughput of the approval pipeline."
    - name: "rejected_requests_count"
      expr: COUNT(CASE WHEN request_status = 'Rejected' THEN 1 END)
      comment: "Number of procurement requests rejected; high rejection rates signal quality or compliance issues upstream."
    - name: "emergency_requests_count"
      expr: COUNT(CASE WHEN urgency_level = 'Emergency' THEN 1 END)
      comment: "Count of emergency-classified procurement requests; elevated levels indicate supply chain stress or planning gaps."
    - name: "avg_days_to_required_delivery"
      expr: AVG(CAST(DATEDIFF(required_delivery_date, request_date) AS DOUBLE))
      comment: "Average lead time window (days) between request date and required delivery date; informs procurement scheduling and vendor SLA setting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order financial and operational metrics covering committed spend, delivery performance, procurement method mix, and vendor payment exposure to support financial governance and supply chain oversight."
  source: "`vibe_ngo_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g. Open, Closed, Cancelled) for pipeline and commitment tracking."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g. Standard, Framework, Emergency) enabling procurement strategy analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g. Open Tender, Direct Procurement, Framework Agreement) for compliance and value-for-money reporting."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Category of goods or services procured; enables spend analysis by commodity type."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order for multi-currency financial reporting."
    - name: "po_month"
      expr: DATE_TRUNC('month', po_date)
      comment: "Calendar month the purchase order was issued; used for spend trend and budget burn-rate analysis."
    - name: "emergency_flag"
      expr: emergency_flag
      comment: "Indicates whether the PO was raised under emergency conditions; tracks unplanned procurement spend."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of goods receipt against the PO; identifies open commitments and delivery gaps."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms governing delivery responsibility; affects logistics cost allocation."
    - name: "approval_workflow_status"
      expr: approval_workflow_status
      comment: "Current approval workflow status of the PO; tracks governance compliance and bottlenecks."
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued; baseline volume metric for procurement activity."
    - name: "total_committed_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders; primary financial exposure metric for budget management."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-freight subtotals; used to isolate goods/services cost from logistics and tax."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs across all POs; key logistics cost driver for supply chain cost optimisation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charges across all POs; required for financial reporting and tax compliance."
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value; benchmarks order sizing and identifies outliers requiring additional scrutiny."
    - name: "emergency_po_count"
      expr: COUNT(CASE WHEN emergency_flag = TRUE THEN 1 END)
      comment: "Number of emergency purchase orders; elevated counts signal reactive procurement and potential value-for-money risk."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, po_date) AS DOUBLE))
      comment: "Average days from PO issuance to actual delivery; core vendor performance and supply chain efficiency KPI."
    - name: "overdue_pos_count"
      expr: COUNT(CASE WHEN actual_delivery_date > expected_delivery_date THEN 1 END)
      comment: "Number of POs where actual delivery exceeded expected delivery date; measures vendor on-time delivery compliance."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt quality and quantity metrics tracking receipt accuracy, rejection rates, cold chain integrity, and inspection outcomes to govern inbound supply quality and vendor accountability."
  source: "`vibe_ngo_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the goods receipt (e.g. Pending, Accepted, Rejected) for inbound pipeline tracking."
    - name: "quality_check_status"
      expr: quality_check_status
      comment: "Outcome of quality inspection at receipt; drives supplier quality scorecards."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the formal inspection process for received goods; tracks compliance with quality protocols."
    - name: "condition_on_arrival"
      expr: condition_on_arrival
      comment: "Physical condition of goods upon arrival; key indicator of transport and handling quality."
    - name: "cold_chain_intact_flag"
      expr: cold_chain_intact_flag
      comment: "Whether the cold chain was maintained during transit; critical for vaccine and pharmaceutical supply integrity."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates a quantity or quality discrepancy between ordered and received goods; triggers supplier dispute processes."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Calendar month of goods receipt; used for inbound volume trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt transaction for financial reconciliation."
    - name: "vvm_status_on_arrival"
      expr: vvm_status_on_arrival
      comment: "Vaccine Vial Monitor status at the time of receipt; critical quality indicator for vaccine cold chain compliance."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipts processed; baseline inbound supply activity metric."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of goods received across all receipts; measures inbound supply volume."
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS DOUBLE))
      comment: "Total quantity of goods rejected at receipt; high values indicate supplier quality or cold chain failures."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity ordered per receipt lines; used as denominator for fill-rate and receipt accuracy calculations."
    - name: "total_receipt_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all goods received; primary inbound spend metric for financial reconciliation."
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charges AS DOUBLE))
      comment: "Total freight charges incurred on goods receipts; key logistics cost component for supply chain cost analysis."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of received goods; benchmarks against PO unit prices to detect pricing discrepancies."
    - name: "receipts_with_discrepancy_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of receipts with recorded discrepancies; drives supplier accountability and dispute resolution."
    - name: "cold_chain_breach_count"
      expr: COUNT(CASE WHEN cold_chain_intact_flag = FALSE THEN 1 END)
      comment: "Number of receipts where cold chain integrity was not maintained; critical risk indicator for vaccine and pharmaceutical programmes."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory position and valuation metrics tracking stock availability, quarantine levels, transit quantities, and total asset value to support stock management, replenishment decisions, and donor reporting."
  source: "`vibe_ngo_v1`.`supply`.`inventory_balance`"
  dimensions:
    - name: "country_code"
      expr: country_code
      comment: "Country where the inventory is held; enables geographic stock distribution analysis."
    - name: "warehouse_location"
      expr: warehouse_location
      comment: "Physical location within the warehouse; supports granular stock positioning analysis."
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition category (e.g. ambient, refrigerated, frozen); critical for cold chain inventory management."
    - name: "pipeline_status"
      expr: pipeline_status
      comment: "Pipeline status of the inventory (e.g. In Pipeline, Available, Depleted); tracks supply readiness."
    - name: "donor_restriction_flag"
      expr: donor_restriction_flag
      comment: "Indicates whether the stock is restricted to specific donor-funded programmes; affects allocation flexibility."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates whether the inventory was received as an in-kind donation; required for donor reporting."
    - name: "vvm_stage"
      expr: vvm_stage
      comment: "Vaccine Vial Monitor stage of the inventory batch; critical for vaccine usability and wastage management."
    - name: "snapshot_month"
      expr: DATE_TRUNC('month', snapshot_date)
      comment: "Month of the inventory snapshot; enables period-over-period stock level trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the inventory valuation; required for multi-currency financial reporting."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical stock on hand across all inventory records; primary stock position KPI for replenishment decisions."
    - name: "total_quantity_available"
      expr: SUM(CAST(quantity_available AS DOUBLE))
      comment: "Total quantity available for allocation (on hand minus reserved and quarantined); drives distribution planning."
    - name: "total_quantity_reserved"
      expr: SUM(CAST(quantity_reserved AS DOUBLE))
      comment: "Total quantity reserved for pending orders; measures committed stock and allocation pipeline."
    - name: "total_quantity_quarantined"
      expr: SUM(CAST(quantity_quarantined AS DOUBLE))
      comment: "Total quantity held in quarantine; elevated levels signal quality issues or cold chain failures requiring investigation."
    - name: "total_quantity_in_transit"
      expr: SUM(CAST(quantity_in_transit AS DOUBLE))
      comment: "Total quantity currently in transit between warehouses or to distribution points; tracks pipeline supply flow."
    - name: "total_inventory_valuation"
      expr: SUM(CAST(total_valuation AS DOUBLE))
      comment: "Total monetary value of inventory on hand; primary asset valuation metric for financial statements and donor reporting."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of inventory items; used for cost benchmarking and valuation consistency checks."
    - name: "stock_below_reorder_level_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_level THEN 1 END)
      comment: "Number of inventory records where stock on hand is below the reorder threshold; triggers replenishment action."
    - name: "stock_above_maximum_count"
      expr: COUNT(CASE WHEN quantity_on_hand > maximum_stock_level THEN 1 END)
      comment: "Number of inventory records where stock exceeds maximum levels; identifies overstock and wastage risk."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock movement throughput and cost metrics tracking inbound, outbound, and transfer flows by type, commodity, and location to support supply chain visibility, loss detection, and logistics cost management."
  source: "`vibe_ngo_v1`.`supply`.`stock_movement`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of stock movement (e.g. Receipt, Issue, Transfer, Adjustment, Loss); fundamental dimension for supply flow analysis."
    - name: "movement_status"
      expr: movement_status
      comment: "Current status of the stock movement (e.g. Pending, Completed, Cancelled); tracks pipeline completeness."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the movement (e.g. Road, Air, Sea); enables logistics cost and lead time analysis by mode."
    - name: "quality_inspection_status"
      expr: quality_inspection_status
      comment: "Quality inspection outcome for the movement; tracks compliance with quality assurance protocols."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the stock movement (e.g. Expiry, Damage, Distribution); enables root cause analysis of losses."
    - name: "in_kind_donation_flag"
      expr: in_kind_donation_flag
      comment: "Indicates whether the movement relates to in-kind donated goods; required for donor accountability reporting."
    - name: "movement_month"
      expr: DATE_TRUNC('month', movement_date)
      comment: "Calendar month of the stock movement; used for throughput trend and seasonality analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the movement cost valuation for financial reporting."
  measures:
    - name: "total_movements"
      expr: COUNT(1)
      comment: "Total number of stock movements recorded; baseline throughput metric for supply chain activity monitoring."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of goods moved across all movement records; measures supply chain throughput volume."
    - name: "total_movement_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all stock movements; primary logistics and handling cost KPI for supply chain financial management."
    - name: "avg_unit_movement_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per stock movement; benchmarks handling efficiency and identifies cost outliers."
    - name: "loss_adjustment_count"
      expr: COUNT(CASE WHEN movement_type IN ('Loss', 'Adjustment', 'Write-off') THEN 1 END)
      comment: "Number of loss or adjustment movements; elevated counts signal wastage, theft, or inventory management failures."
    - name: "total_loss_quantity"
      expr: SUM(CASE WHEN movement_type IN ('Loss', 'Adjustment', 'Write-off') THEN CAST(quantity AS DOUBLE) ELSE 0 END)
      comment: "Total quantity lost or written off; critical KPI for supply chain integrity and donor accountability."
    - name: "distinct_commodities_moved"
      expr: COUNT(DISTINCT commodity_id)
      comment: "Number of distinct commodities with stock movements in the period; measures supply chain breadth and diversity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_distribution_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution order execution metrics tracking delivery performance, beneficiary reach, transport costs, and order fulfilment status to steer last-mile supply chain effectiveness and humanitarian response."
  source: "`vibe_ngo_v1`.`supply`.`distribution_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the distribution order (e.g. Planned, Dispatched, Delivered, Cancelled); tracks fulfilment pipeline."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution (e.g. Direct, Partner-led, Mobile); enables modality performance comparison."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the distribution order; drives logistics cost and lead time analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the distribution order (e.g. Routine, Urgent, Emergency); supports triage and resource allocation."
    - name: "emergency_response_flag"
      expr: emergency_response_flag
      comment: "Indicates whether the order is part of an emergency response; tracks humanitarian surge capacity."
    - name: "cold_chain_required_flag"
      expr: cold_chain_required_flag
      comment: "Indicates whether cold chain logistics are required; critical for vaccine and pharmaceutical distribution planning."
    - name: "vaccine_distribution_flag"
      expr: vaccine_distribution_flag
      comment: "Indicates whether the order includes vaccine commodities; enables vaccine programme supply tracking."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Calendar month the distribution order was placed; used for distribution volume trend analysis."
  measures:
    - name: "total_distribution_orders"
      expr: COUNT(1)
      comment: "Total number of distribution orders; baseline metric for distribution activity and operational tempo."
    - name: "total_quantity_distributed"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of commodities distributed across all orders; primary output metric for programme delivery."
    - name: "total_estimated_value_usd"
      expr: SUM(CAST(estimated_value_usd AS DOUBLE))
      comment: "Total estimated value of distributed commodities in USD; measures programme delivery investment and donor accountability."
    - name: "total_transport_cost_usd"
      expr: SUM(CAST(transport_cost_usd AS DOUBLE))
      comment: "Total transport cost across all distribution orders; key logistics cost KPI for supply chain efficiency."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of goods distributed in kilograms; used for logistics capacity planning and transport cost benchmarking."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume of goods distributed in cubic metres; drives warehouse and vehicle capacity planning."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= scheduled_delivery_date THEN 1 END)
      comment: "Number of distribution orders delivered on or before the scheduled date; measures last-mile delivery reliability."
    - name: "avg_delivery_lead_time_days"
      expr: AVG(CAST(DATEDIFF(actual_delivery_date, order_date) AS DOUBLE))
      comment: "Average days from order placement to actual delivery; core last-mile supply chain performance KPI."
    - name: "emergency_orders_count"
      expr: COUNT(CASE WHEN emergency_response_flag = TRUE THEN 1 END)
      comment: "Number of emergency response distribution orders; tracks humanitarian surge demand and reactive supply capacity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_distribution_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution planning metrics tracking planned coverage, budget allocation, beneficiary targets, and plan execution status to support programme design, resource mobilisation, and strategic coverage decisions."
  source: "`vibe_ngo_v1`.`supply`.`distribution_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the distribution plan (e.g. Draft, Approved, Active, Completed); tracks planning pipeline maturity."
    - name: "distribution_type"
      expr: distribution_type
      comment: "Type of distribution modality planned (e.g. Direct, Partner-led); enables modality mix analysis."
    - name: "distribution_modality"
      expr: distribution_modality
      comment: "Specific distribution modality (e.g. Fixed Point, Mobile, Door-to-Door); informs operational design decisions."
    - name: "geographic_coverage_country"
      expr: geographic_coverage_country
      comment: "Country covered by the distribution plan; enables geographic programme coverage analysis."
    - name: "geographic_coverage_admin1"
      expr: geographic_coverage_admin1
      comment: "First administrative level (e.g. province/state) covered; supports sub-national coverage gap analysis."
    - name: "beneficiary_category"
      expr: beneficiary_category
      comment: "Category of beneficiaries targeted (e.g. IDPs, Refugees, Host Community); enables equity and targeting analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk classification of the distribution plan (e.g. Low, Medium, High); informs risk-adjusted resource allocation."
    - name: "vaccine_campaign_flag"
      expr: vaccine_campaign_flag
      comment: "Indicates whether the plan is for a vaccine campaign; enables vaccine programme planning metrics."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Planned start month of the distribution; used for programme pipeline and resource scheduling analysis."
    - name: "coordination_cluster"
      expr: coordination_cluster
      comment: "Humanitarian coordination cluster the plan is aligned to (e.g. Health, Nutrition, Logistics); enables cluster-level reporting."
  measures:
    - name: "total_distribution_plans"
      expr: COUNT(1)
      comment: "Total number of distribution plans; baseline metric for programme planning activity."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total quantity of commodities planned for distribution; primary supply demand signal for procurement and inventory planning."
    - name: "total_estimated_budget"
      expr: SUM(CAST(estimated_budget_amount AS DOUBLE))
      comment: "Total estimated budget across all distribution plans; primary financial planning KPI for resource mobilisation."
    - name: "total_target_beneficiaries"
      expr: SUM(CAST(target_beneficiary_count_for_commodity AS DOUBLE))
      comment: "Total number of beneficiaries targeted across all distribution plans; measures programme reach and coverage ambition."
    - name: "total_estimated_volume_m3"
      expr: SUM(CAST(estimated_total_volume_m3 AS DOUBLE))
      comment: "Total estimated volume of commodities to be distributed; drives logistics and warehouse capacity planning."
    - name: "total_estimated_weight_kg"
      expr: SUM(CAST(estimated_total_weight_kg AS DOUBLE))
      comment: "Total estimated weight of commodities to be distributed; informs transport fleet and load planning."
    - name: "approved_plans_count"
      expr: COUNT(CASE WHEN plan_status = 'Approved' THEN 1 END)
      comment: "Number of distribution plans with approved status; measures planning pipeline readiness for execution."
    - name: "high_risk_plans_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk distribution plans; triggers risk mitigation review and additional resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor qualification, performance, and risk metrics tracking prequalification status, performance scores, blacklist exposure, and cold chain capability to govern supplier selection and relationship management."
  source: "`vibe_ngo_v1`.`supply`.`vendor`"
  dimensions:
    - name: "vendor_status"
      expr: vendor_status
      comment: "Current operational status of the vendor (e.g. Active, Suspended, Deregistered); primary vendor eligibility dimension."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g. Manufacturer, Distributor, Transporter); enables category-specific performance analysis."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Vendor prequalification status (e.g. Prequalified, Pending, Expired); governs procurement eligibility."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification of the vendor (e.g. Tier 1, Tier 2, Tier 3); drives preferred vendor selection."
    - name: "country_of_operation"
      expr: country_of_operation
      comment: "Country where the vendor primarily operates; enables geographic supplier base analysis."
    - name: "cold_chain_certified_flag"
      expr: cold_chain_certified_flag
      comment: "Indicates whether the vendor holds cold chain certification; critical for vaccine and pharmaceutical procurement eligibility."
    - name: "blacklist_flag"
      expr: blacklist_flag
      comment: "Indicates whether the vendor is currently blacklisted; mandatory compliance dimension for procurement governance."
    - name: "who_pq_manufacturer_flag"
      expr: who_pq_manufacturer_flag
      comment: "Indicates whether the vendor is a WHO prequalified manufacturer; critical for vaccine and essential medicine procurement."
    - name: "gmp_certification_flag"
      expr: gmp_certification_flag
      comment: "Indicates whether the vendor holds Good Manufacturing Practice certification; quality assurance governance dimension."
  measures:
    - name: "total_vendors"
      expr: COUNT(1)
      comment: "Total number of vendors in the supplier registry; baseline metric for supplier base size and diversity."
    - name: "active_vendors_count"
      expr: COUNT(CASE WHEN vendor_status = 'Active' THEN 1 END)
      comment: "Number of currently active vendors; measures available supplier pool for procurement operations."
    - name: "prequalified_vendors_count"
      expr: COUNT(CASE WHEN prequalification_status = 'Prequalified' THEN 1 END)
      comment: "Number of prequalified vendors; measures the qualified supplier pool available for competitive procurement."
    - name: "blacklisted_vendors_count"
      expr: COUNT(CASE WHEN blacklist_flag = TRUE THEN 1 END)
      comment: "Number of blacklisted vendors; compliance KPI ensuring debarred suppliers are excluded from procurement."
    - name: "avg_performance_score"
      expr: AVG(CAST(last_performance_score AS DOUBLE))
      comment: "Average vendor performance score across the supplier base; tracks overall supplier quality and relationship health."
    - name: "cold_chain_certified_vendors_count"
      expr: COUNT(CASE WHEN cold_chain_certified_flag = TRUE THEN 1 END)
      comment: "Number of cold chain certified vendors; measures cold chain supplier capacity for vaccine and pharmaceutical programmes."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms (days) across vendors; informs cash flow planning and working capital management."
    - name: "avg_warehouse_capacity_sqm"
      expr: AVG(CAST(warehouse_capacity_sqm AS DOUBLE))
      comment: "Average warehouse capacity (sqm) of vendors with storage facilities; assesses vendor logistics infrastructure."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity, cold chain capability, and operational readiness metrics to support infrastructure planning, cold chain network assessment, and storage gap analysis for humanitarian supply operations."
  source: "`vibe_ngo_v1`.`supply`.`warehouse`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the warehouse (e.g. Active, Inactive, Under Renovation); tracks usable storage network."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of warehouse facility (e.g. Central, Regional, Field); enables tiered storage network analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model of the warehouse (e.g. Owned, Leased, Partner); informs asset vs. cost strategy decisions."
    - name: "country_code"
      expr: country_code
      comment: "Country where the warehouse is located; enables geographic storage capacity distribution analysis."
    - name: "admin_level_1"
      expr: admin_level_1
      comment: "First administrative level of the warehouse location; supports sub-national storage network planning."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Indicates whether the warehouse has temperature-controlled storage; critical for cold chain network mapping."
    - name: "vaccine_storage_certified_flag"
      expr: vaccine_storage_certified_flag
      comment: "Indicates whether the warehouse is certified for vaccine storage; governs vaccine supply chain routing."
    - name: "vaccine_storage_tier"
      expr: vaccine_storage_tier
      comment: "Vaccine storage tier classification (e.g. Tier 1, Tier 2); used for EPI cold chain network design."
    - name: "hazmat_certified"
      expr: hazmat_certified
      comment: "Indicates whether the warehouse is certified for hazardous materials storage; required for certain commodity categories."
    - name: "security_level"
      expr: security_level
      comment: "Security classification of the warehouse; informs risk assessment for high-value or sensitive commodity storage."
  measures:
    - name: "total_warehouses"
      expr: COUNT(1)
      comment: "Total number of warehouses in the network; baseline metric for storage infrastructure footprint."
    - name: "total_storage_capacity_m3"
      expr: SUM(CAST(storage_capacity_m3 AS DOUBLE))
      comment: "Total storage capacity in cubic metres across all warehouses; primary infrastructure capacity KPI for supply chain planning."
    - name: "total_cold_chain_capacity_liters"
      expr: SUM(CAST(cold_chain_capacity_liters AS DOUBLE))
      comment: "Total cold chain storage capacity in litres; critical KPI for vaccine and pharmaceutical supply chain network adequacy."
    - name: "total_freezer_capacity_liters"
      expr: SUM(CAST(freezer_capacity_liters AS DOUBLE))
      comment: "Total freezer capacity in litres across the warehouse network; measures ultra-cold supply chain capability for mRNA vaccines."
    - name: "total_ultra_cold_capacity_liters"
      expr: SUM(CAST(ultra_cold_capacity_liters AS DOUBLE))
      comment: "Total ultra-cold storage capacity in litres; measures network readiness for ultra-cold chain commodities."
    - name: "avg_evm_score"
      expr: AVG(CAST(evm_score AS DOUBLE))
      comment: "Average Effective Vaccine Management (EVM) score across warehouses; measures cold chain system quality against WHO standards."
    - name: "avg_cold_chain_functional_pct"
      expr: AVG(CAST(cold_chain_functional_percentage AS DOUBLE))
      comment: "Average percentage of cold chain equipment in functional condition; tracks cold chain operational readiness."
    - name: "vaccine_certified_warehouses_count"
      expr: COUNT(CASE WHEN vaccine_storage_certified_flag = TRUE THEN 1 END)
      comment: "Number of vaccine-certified warehouses; measures certified cold chain storage node availability for EPI programmes."
    - name: "active_warehouses_count"
      expr: COUNT(CASE WHEN operational_status = 'Active' THEN 1 END)
      comment: "Number of currently active warehouses; measures usable storage network capacity for operational planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`supply_waybill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waybill shipment tracking and logistics performance metrics covering delivery accuracy, cold chain compliance, discrepancy rates, and transport costs to govern last-mile logistics quality and accountability."
  source: "`vibe_ngo_v1`.`supply`.`waybill`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (e.g. In Transit, Delivered, Returned); tracks last-mile delivery pipeline."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (e.g. Inbound, Outbound, Transfer); enables directional logistics flow analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the waybill shipment; supports triage and expediting decisions."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the shipment required temperature-controlled transport; critical for cold chain compliance tracking."
    - name: "vaccine_transport_flag"
      expr: vaccine_transport_flag
      comment: "Indicates whether the waybill covers vaccine transport; enables vaccine-specific logistics performance reporting."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Indicates whether the shipment contains hazardous materials; required for regulatory compliance tracking."
    - name: "seal_intact_flag"
      expr: seal_intact_flag
      comment: "Indicates whether the shipment seal was intact on arrival; key security and tamper-evidence indicator."
    - name: "dispatch_month"
      expr: DATE_TRUNC('month', dispatch_date)
      comment: "Calendar month of shipment dispatch; used for logistics throughput trend analysis."
  measures:
    - name: "total_waybills"
      expr: COUNT(1)
      comment: "Total number of waybills processed; baseline logistics throughput metric."
    - name: "total_dispatched_quantity"
      expr: SUM(CAST(total_dispatched_quantity AS DOUBLE))
      comment: "Total quantity dispatched across all waybills; measures outbound supply flow volume."
    - name: "total_received_quantity"
      expr: SUM(CAST(total_received_quantity AS DOUBLE))
      comment: "Total quantity received at destination across all waybills; measures actual delivery fulfilment."
    - name: "total_discrepancy_quantity"
      expr: SUM(CAST(discrepancy_quantity AS DOUBLE))
      comment: "Total quantity discrepancy between dispatched and received; measures supply chain loss and accountability gaps."
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost_amount AS DOUBLE))
      comment: "Total transport cost across all waybills; primary logistics expenditure KPI for cost efficiency analysis."
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average shipment distance in kilometres; used for transport cost per km benchmarking and route optimisation."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= estimated_delivery_date THEN 1 END)
      comment: "Number of waybills delivered on or before the estimated delivery date; measures carrier on-time performance."
    - name: "seal_breach_count"
      expr: COUNT(CASE WHEN seal_intact_flag = FALSE THEN 1 END)
      comment: "Number of shipments with broken seals on arrival; critical security and supply integrity KPI."
    - name: "waybills_with_discrepancy_count"
      expr: COUNT(CASE WHEN discrepancy_quantity > 0 THEN 1 END)
      comment: "Number of waybills with a recorded quantity discrepancy; measures supply chain loss frequency for accountability reporting."
$$;