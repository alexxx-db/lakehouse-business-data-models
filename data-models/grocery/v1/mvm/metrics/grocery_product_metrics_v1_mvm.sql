-- Metric views for domain: product | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core order transaction metrics covering revenue, basket economics, discount impact, and fulfillment channel mix. Primary steering dashboard for GMV, average order value, and promotional spend effectiveness."
  source: "`grocery_ecm`.`product`.`order_header`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Calendar date the order was placed, used for daily/weekly/monthly trend analysis."
    - name: "fulfillment_date"
      expr: fulfillment_date
      comment: "Date the order was fulfilled, used to align revenue to fulfillment timing."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. placed, fulfilled, cancelled) for funnel and completion analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (e.g. in-store, online, pickup, delivery) enabling omnichannel revenue segmentation."
    - name: "source_system"
      expr: source_system
      comment: "Originating system (POS, OMS, app) for channel attribution and data quality monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order was transacted, supporting multi-currency reporting."
    - name: "self_checkout"
      expr: self_checkout
      comment: "Flag indicating whether the order was processed via self-checkout, used for labor and throughput analysis."
    - name: "loyalty_card_scanned"
      expr: loyalty_card_scanned
      comment: "Indicates whether a loyalty card was scanned, enabling loyalty attach rate analysis."
    - name: "ebt_snap_wic_used"
      expr: ebt_snap_wic_used
      comment: "Indicates use of EBT/SNAP/WIC tender, supporting government assistance program reporting."
    - name: "pharmacy_rx_flag"
      expr: pharmacy_rx_flag
      comment: "Flags orders containing pharmacy prescriptions, enabling pharmacy vs. general merchandise segmentation."
    - name: "substitution_allowed"
      expr: substitution_allowed
      comment: "Whether the shopper permitted item substitutions, relevant to fulfillment quality and OOS impact analysis."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of orders placed. Baseline volume KPI for trend and capacity planning."
    - name: "gross_merchandise_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue across all orders including taxes and fees. Primary top-line GMV metric for executive reporting."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-fee order subtotals. Used to isolate merchandise revenue from ancillary charges."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total promotional and coupon discounts applied across all orders. Measures promotional spend and margin erosion."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all orders. Required for tax liability and compliance reporting."
    - name: "total_delivery_fees"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE))
      comment: "Total delivery fees charged to customers. Measures delivery revenue contribution and fee recovery rate."
    - name: "total_bag_fees"
      expr: SUM(CAST(bag_fee_amount AS DOUBLE))
      comment: "Total bag fees collected. Tracks sustainability fee compliance and ancillary revenue."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total order value. Core basket economics KPI used to track shopper spending trends and promotional effectiveness."
    - name: "avg_subtotal_per_order"
      expr: AVG(CAST(subtotal_amount AS DOUBLE))
      comment: "Average merchandise subtotal per order, excluding taxes and fees. Cleaner signal for basket size trends."
    - name: "avg_discount_per_order"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per order. Measures promotional depth and its impact on basket economics."
    - name: "distinct_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Count of unique shoppers who placed orders. Measures active customer base size for retention and acquisition analysis."
    - name: "distinct_stores"
      expr: COUNT(DISTINCT store_location_id)
      comment: "Count of distinct store locations generating orders. Used for store-level coverage and performance benchmarking."
    - name: "loyalty_attach_rate_orders"
      expr: SUM(CASE WHEN loyalty_card_scanned = TRUE THEN 1 ELSE 0 END)
      comment: "Number of orders where a loyalty card was scanned. Numerator for loyalty attach rate; divide by total_orders in BI layer."
    - name: "cancelled_orders"
      expr: SUM(CASE WHEN order_status = 'CANCELLED' THEN 1 ELSE 0 END)
      comment: "Count of cancelled orders. Tracks cancellation volume for operational and customer experience management."
    - name: "delivery_orders"
      expr: SUM(CASE WHEN transaction_type = 'DELIVERY' THEN 1 ELSE 0 END)
      comment: "Count of delivery orders. Measures delivery channel adoption and capacity demand."
    - name: "pickup_orders"
      expr: SUM(CASE WHEN transaction_type = 'PICKUP' THEN 1 ELSE 0 END)
      comment: "Count of pickup (BOPIS/curbside) orders. Measures pickup channel adoption and slot utilization demand."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level order metrics enabling SKU, category, and brand performance analysis. Drives merchandising decisions on revenue contribution, promotional effectiveness, substitution rates, and margin by item."
  source: "`grocery_ecm`.`product`.`product_order_line`"
  filter: void_flag = FALSE
  dimensions:
    - name: "item_description"
      expr: item_description
      comment: "Human-readable product description for item-level performance reporting."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g. fulfilled, substituted, cancelled, voided) for line-level funnel analysis."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "How the line item was fulfilled (delivery, pickup, in-store) for channel-level item performance."
    - name: "promo_applied_flag"
      expr: promo_applied_flag
      comment: "Indicates whether a promotion was applied to this line. Enables promotional lift and cannibalization analysis."
    - name: "substitution_flag"
      expr: substitution_flag
      comment: "Indicates whether this line was fulfilled via substitution. Tracks OOS-driven substitution rates."
    - name: "return_flag"
      expr: return_flag
      comment: "Indicates whether this line was returned. Used for return rate and shrink analysis."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Flags private label items. Enables private label penetration and margin premium analysis."
    - name: "organic_flag"
      expr: organic_flag
      comment: "Flags organic items. Supports organic category performance and premium pricing analysis."
    - name: "snap_eligible_flag"
      expr: snap_eligible_flag
      comment: "Indicates SNAP-eligible items. Required for SNAP redemption reporting and compliance."
    - name: "perishable_flag"
      expr: perishable_flag
      comment: "Flags perishable items. Used for shrink, waste, and cold chain performance analysis."
    - name: "bogo_flag"
      expr: bogo_flag
      comment: "Indicates buy-one-get-one promotional lines. Measures BOGO promotional volume and margin impact."
    - name: "tpr_flag"
      expr: tpr_flag
      comment: "Temporary price reduction flag. Tracks TPR promotional activity and its revenue impact."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the line item (each, lb, oz) for accurate quantity aggregation."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax classification code for the line item. Supports tax compliance and category-level tax analysis."
    - name: "wic_eligible_flag"
      expr: wic_eligible_flag
      comment: "Indicates WIC-eligible items. Required for WIC program compliance and redemption reporting."
  measures:
    - name: "total_line_items"
      expr: COUNT(1)
      comment: "Total number of order line items. Baseline volume metric for item-level throughput analysis."
    - name: "total_extended_revenue"
      expr: SUM(CAST(extended_price AS DOUBLE))
      comment: "Total extended price (unit_price × quantity) across all lines. Primary item-level revenue KPI for merchandising."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts at line level. Measures true merchandise revenue contribution."
    - name: "total_line_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at line level. Measures promotional spend and margin erosion by item."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at line level. Supports item-level tax liability reporting."
    - name: "total_units_sold"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total units ordered across all lines. Core volume metric for velocity, replenishment, and demand planning."
    - name: "total_weight_sold"
      expr: SUM(CAST(weight_actual AS DOUBLE))
      comment: "Total actual weight sold across weighted items. Used for catch-weight and produce category analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per unit. Tracks price realization and promotional price depth."
    - name: "avg_extended_price_per_line"
      expr: AVG(CAST(extended_price AS DOUBLE))
      comment: "Average extended price per order line. Measures per-line revenue contribution for basket composition analysis."
    - name: "promo_lines"
      expr: SUM(CASE WHEN promo_applied_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lines with a promotion applied. Numerator for promotional penetration rate."
    - name: "substituted_lines"
      expr: SUM(CASE WHEN substitution_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of lines fulfilled via substitution. Measures OOS-driven substitution volume and customer experience impact."
    - name: "returned_lines"
      expr: SUM(CASE WHEN return_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of returned line items. Tracks return volume for quality, shrink, and customer satisfaction analysis."
    - name: "private_label_lines"
      expr: SUM(CASE WHEN private_label_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of private label line items sold. Numerator for private label penetration rate."
    - name: "private_label_revenue"
      expr: SUM(CASE WHEN private_label_flag = TRUE THEN CAST(net_amount AS DOUBLE) ELSE 0 END)
      comment: "Net revenue from private label items. Measures private label revenue contribution and margin premium opportunity."
    - name: "distinct_skus_sold"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs sold. Measures assortment breadth and long-tail vs. core item contribution."
    - name: "distinct_orders_with_lines"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Count of distinct orders containing at least one line. Used to validate order-to-line relationship integrity."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_item_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor cost and margin metrics at the SKU level. Enables procurement, category management, and finance teams to monitor cost trends, allowance capture, and dead-net cost performance."
  source: "`grocery_ecm`.`product`.`item_cost`"
  filter: cost_status = 'ACTIVE'
  dimensions:
    - name: "cost_type"
      expr: cost_type
      comment: "Classification of the cost record (e.g. base, promotional, contract) for cost structure analysis."
    - name: "cost_basis"
      expr: cost_basis
      comment: "Basis on which cost is calculated (e.g. per unit, per case) for accurate cost comparison."
    - name: "cost_status"
      expr: cost_status
      comment: "Current status of the cost record (active, expired, pending) for cost governance."
    - name: "cost_approval_status"
      expr: cost_approval_status
      comment: "Approval workflow status of the cost record. Tracks unapproved costs that may impact margin calculations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost record for multi-currency procurement analysis."
    - name: "is_primary_vendor"
      expr: is_primary_vendor
      comment: "Flags whether this cost is from the primary vendor. Enables primary vs. secondary vendor cost comparison."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date from which this cost record is effective. Used for cost trend and contract period analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Date on which this cost record expires. Used to identify upcoming cost changes."
    - name: "cost_source"
      expr: cost_source
      comment: "Source system or process that generated the cost record (EDI, manual, contract) for data lineage."
  measures:
    - name: "total_cost_records"
      expr: COUNT(1)
      comment: "Total number of active cost records. Baseline for cost catalog coverage analysis."
    - name: "avg_base_unit_cost"
      expr: AVG(CAST(base_unit_cost AS DOUBLE))
      comment: "Average base unit cost across SKUs. Tracks cost inflation trends and vendor negotiation outcomes."
    - name: "avg_dead_net_cost"
      expr: AVG(CAST(dead_net_cost AS DOUBLE))
      comment: "Average dead-net cost (after all allowances) per SKU. Primary cost metric for margin modeling and pricing decisions."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all cost records. Measures supply chain logistics cost burden."
    - name: "total_handling_cost"
      expr: SUM(CAST(handling_cost AS DOUBLE))
      comment: "Total handling cost across all cost records. Tracks warehouse and DC handling expense."
    - name: "total_billback_allowance"
      expr: SUM(CAST(billback_allowance AS DOUBLE))
      comment: "Total billback allowances captured from vendors. Measures vendor funding recovery performance."
    - name: "total_off_invoice_allowance"
      expr: SUM(CAST(off_invoice_allowance AS DOUBLE))
      comment: "Total off-invoice allowances received. Tracks immediate vendor discount capture."
    - name: "total_scan_based_trading_allowance"
      expr: SUM(CAST(scan_based_trading_allowance AS DOUBLE))
      comment: "Total scan-based trading allowances. Measures SBT program financial benefit."
    - name: "total_slotting_fee_amortization"
      expr: SUM(CAST(slotting_fee_amortization AS DOUBLE))
      comment: "Total slotting fee amortization across SKUs. Tracks shelf placement cost recovery over time."
    - name: "avg_cost_variance"
      expr: AVG(CAST(cost_variance_amount AS DOUBLE))
      comment: "Average cost variance from expected cost. Identifies systematic cost discrepancies requiring vendor or procurement action."
    - name: "distinct_skus_with_costs"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with active cost records. Measures cost catalog completeness for pricing and margin management."
    - name: "distinct_suppliers_on_cost"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of distinct suppliers with active cost records. Measures vendor portfolio breadth in cost management."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_order_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund and return metrics tracking financial exposure, fraud risk, and customer satisfaction from post-transaction reversals. Critical for loss prevention, customer experience, and financial reconciliation."
  source: "`grocery_ecm`.`product`.`order_refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (approved, denied, pending, processed) for refund pipeline management."
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (return, price adjustment, damage, etc.) for root cause categorization."
    - name: "refund_reason_code"
      expr: refund_reason_code
      comment: "Coded reason for the refund. Drives root cause analysis and policy improvement decisions."
    - name: "refund_channel"
      expr: refund_channel
      comment: "Channel through which the refund was initiated (in-store, online, call center) for channel-level refund analysis."
    - name: "inventory_disposition"
      expr: inventory_disposition
      comment: "How returned inventory was handled (restocked, discarded, donated). Impacts shrink and recovery calculations."
    - name: "policy_exception_flag"
      expr: policy_exception_flag
      comment: "Flags refunds that required a policy exception. Tracks exception volume for policy governance."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flags refunds identified as fraudulent. Critical for loss prevention and fraud program effectiveness."
    - name: "shrink_flag"
      expr: shrink_flag
      comment: "Indicates whether the refund contributed to shrink. Used for shrink rate and inventory loss reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the refund transaction for multi-currency financial reconciliation."
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of refund transactions. Baseline volume metric for refund rate calculation."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total monetary value of all refunds. Primary financial exposure metric for loss prevention and P&L impact."
    - name: "total_refund_subtotal"
      expr: SUM(CAST(refund_subtotal AS DOUBLE))
      comment: "Total merchandise subtotal refunded, excluding tax. Measures merchandise return value."
    - name: "total_refund_tax"
      expr: SUM(CAST(refund_tax_amount AS DOUBLE))
      comment: "Total tax refunded. Required for tax liability reconciliation and compliance reporting."
    - name: "total_restocking_fees"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected on returns. Measures cost recovery from return processing."
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total return shipping costs incurred. Tracks logistics cost of reverse supply chain."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per transaction. Tracks refund depth and identifies high-value refund patterns."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across refund transactions. Monitors overall fraud risk exposure in the refund portfolio."
    - name: "fraudulent_refunds"
      expr: SUM(CASE WHEN is_fraudulent = TRUE THEN 1 ELSE 0 END)
      comment: "Count of refunds flagged as fraudulent. Numerator for fraud rate; drives loss prevention investment decisions."
    - name: "policy_exception_refunds"
      expr: SUM(CASE WHEN policy_exception_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of refunds requiring policy exceptions. Tracks exception volume for policy tightening decisions."
    - name: "shrink_refunds"
      expr: SUM(CASE WHEN shrink_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of refunds contributing to shrink. Numerator for shrink-driven refund rate."
    - name: "distinct_shoppers_refunded"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Count of distinct shoppers who received refunds. Identifies repeat refund customers for fraud and policy review."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment operational metrics covering throughput, SLA compliance, substitution rates, and pick quality. Drives operational efficiency decisions for fulfillment centers, dark stores, and MFC operations."
  source: "`grocery_ecm`.`product`.`order_fulfillment`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current status of the fulfillment job (picking, packed, dispatched, complete) for pipeline monitoring."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Method of fulfillment (manual pick, MFC, automated) for efficiency benchmarking across fulfillment modes."
    - name: "fulfillment_location_type"
      expr: fulfillment_location_type
      comment: "Type of fulfillment location (store, DC, MFC, dark store) for location-type performance comparison."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the fulfillment (ambient, chilled, frozen) for cold chain compliance analysis."
    - name: "quality_check_flag"
      expr: quality_check_flag
      comment: "Indicates whether a quality check was performed. Tracks quality assurance coverage rate."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for fulfillment cancellation. Drives root cause analysis for cancellation reduction."
    - name: "staging_area"
      expr: staging_area
      comment: "Physical staging area used for the fulfillment. Supports space utilization and throughput analysis."
  measures:
    - name: "total_fulfillments"
      expr: COUNT(1)
      comment: "Total number of fulfillment jobs processed. Baseline throughput metric for capacity planning."
    - name: "total_units_picked"
      expr: SUM(CAST(total_units_picked AS DOUBLE))
      comment: "Total units picked across all fulfillment jobs. Core throughput metric for picker productivity and labor planning."
    - name: "total_weight_fulfilled_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight fulfilled in kilograms. Used for logistics capacity and vehicle load planning."
    - name: "total_volume_fulfilled_liters"
      expr: SUM(CAST(total_volume_liters AS DOUBLE))
      comment: "Total volume fulfilled in liters. Supports container and vehicle capacity utilization analysis."
    - name: "avg_units_per_fulfillment"
      expr: AVG(CAST(total_units_picked AS DOUBLE))
      comment: "Average units picked per fulfillment job. Measures fulfillment density and picker efficiency."
    - name: "quality_checked_fulfillments"
      expr: SUM(CASE WHEN quality_check_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fulfillments that received a quality check. Numerator for quality check coverage rate."
    - name: "distinct_fulfillment_nodes"
      expr: COUNT(DISTINCT node_id)
      comment: "Count of distinct fulfillment nodes active in the period. Measures fulfillment network utilization."
    - name: "distinct_orders_fulfilled"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Count of distinct orders fulfilled. Validates fulfillment-to-order ratio and detects multi-shipment patterns."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional discount metrics tracking discount depth, funding source mix, and promotional stack effectiveness. Enables marketing and finance to evaluate promotional ROI and margin impact."
  source: "`grocery_ecm`.`product`.`order_discount`"
  filter: discount_status = 'APPLIED'
  dimensions:
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount applied (coupon, loyalty, markdown, BOGO) for promotional mix analysis."
    - name: "discount_scope"
      expr: discount_scope
      comment: "Scope of the discount (line, order, category) for understanding promotional breadth."
    - name: "discount_reason_code"
      expr: discount_reason_code
      comment: "Coded reason for the discount. Enables root cause analysis of discount drivers."
    - name: "funding_source"
      expr: funding_source
      comment: "Who funds the discount (vendor, retailer, loyalty program). Critical for P&L allocation and vendor funding recovery."
    - name: "channel"
      expr: channel
      comment: "Channel where the discount was applied (in-store, online, app). Enables channel-level promotional effectiveness analysis."
    - name: "discount_status"
      expr: discount_status
      comment: "Status of the discount application (applied, reversed, pending). Used for discount reconciliation."
    - name: "snap_eligible_flag"
      expr: snap_eligible_flag
      comment: "Indicates SNAP-eligible discounts. Required for government assistance program compliance reporting."
    - name: "wic_eligible_flag"
      expr: wic_eligible_flag
      comment: "Indicates WIC-eligible discounts. Required for WIC program compliance reporting."
    - name: "promotion_start_date"
      expr: promotion_start_date
      comment: "Start date of the promotion. Used to align discount metrics to promotional calendar periods."
    - name: "promotion_end_date"
      expr: promotion_end_date
      comment: "End date of the promotion. Used to measure promotional duration and discount concentration."
    - name: "tax_treatment"
      expr: tax_treatment
      comment: "Tax treatment applied to the discount. Supports tax compliance and discount tax liability analysis."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Flags discounts requiring manager approval. Tracks exception discount volume for governance."
  measures:
    - name: "total_discount_events"
      expr: COUNT(1)
      comment: "Total number of discount events applied. Baseline promotional activity volume metric."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total monetary value of discounts applied. Primary promotional spend metric for marketing ROI and margin impact."
    - name: "total_original_price"
      expr: SUM(CAST(original_price AS DOUBLE))
      comment: "Total original price before discounts. Used as denominator for discount penetration rate calculations."
    - name: "total_final_price"
      expr: SUM(CAST(final_price AS DOUBLE))
      comment: "Total final price after discounts. Measures net revenue realization after promotional activity."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per event. Measures promotional depth and identifies outlier discount events."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied. Tracks promotional depth trends and vendor funding adequacy."
    - name: "approval_required_discounts"
      expr: SUM(CASE WHEN approval_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of discounts requiring manager approval. Tracks exception volume for discount governance."
    - name: "distinct_promo_offers"
      expr: COUNT(DISTINCT promo_offer_id)
      comment: "Count of distinct promotional offers applied. Measures promotional portfolio breadth and offer utilization."
    - name: "distinct_orders_discounted"
      expr: COUNT(DISTINCT order_header_id)
      comment: "Count of distinct orders receiving at least one discount. Numerator for order-level promotional penetration rate."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product master metrics covering assortment health, private label penetration, compliance coverage, and item attribute completeness. Enables category management and merchandising decisions on assortment strategy."
  source: "`grocery_ecm`.`product`.`product_item`"
  filter: item_status = 'ACTIVE'
  dimensions:
    - name: "item_type"
      expr: item_type
      comment: "Type of product item (grocery, produce, pharmacy, fuel) for category-level assortment analysis."
    - name: "item_status"
      expr: item_status
      comment: "Lifecycle status of the item (active, discontinued, pending) for assortment health monitoring."
    - name: "temperature_class"
      expr: temperature_class
      comment: "Temperature handling class (ambient, chilled, frozen) for cold chain assortment analysis."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Flags private label items. Enables private label vs. national brand assortment mix analysis."
    - name: "organic_certified_flag"
      expr: organic_certified_flag
      comment: "Flags organically certified items. Supports organic assortment growth and premium positioning strategy."
    - name: "snap_eligible_flag"
      expr: snap_eligible_flag
      comment: "Indicates SNAP-eligible items. Required for SNAP assortment compliance and program reporting."
    - name: "wic_eligible_flag"
      expr: wic_eligible_flag
      comment: "Indicates WIC-eligible items. Required for WIC program assortment compliance."
    - name: "taxable_flag"
      expr: taxable_flag
      comment: "Indicates taxable items. Supports tax compliance and taxable vs. non-taxable assortment analysis."
    - name: "age_restricted_flag"
      expr: age_restricted_flag
      comment: "Flags age-restricted items (alcohol, tobacco). Supports compliance and age-verification process management."
    - name: "fda_labeling_required_flag"
      expr: fda_labeling_required_flag
      comment: "Flags items requiring FDA labeling. Tracks regulatory compliance coverage in the assortment."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the item. Supports COOL compliance reporting and sourcing diversification analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the item. Used for accurate volume and weight-based assortment analysis."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date the item became effective in the assortment. Used for new item introduction trend analysis."
  measures:
    - name: "total_active_items"
      expr: COUNT(1)
      comment: "Total number of active product items in the assortment. Core assortment breadth metric for category management."
    - name: "avg_suggested_retail_price"
      expr: AVG(CAST(suggested_retail_price AS DOUBLE))
      comment: "Average suggested retail price across active items. Tracks price positioning and inflation trends in the assortment."
    - name: "avg_cost_of_goods_sold"
      expr: AVG(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Average COGS per item. Baseline for gross margin modeling and cost trend monitoring."
    - name: "avg_weight_pounds"
      expr: AVG(CAST(weight_pounds AS DOUBLE))
      comment: "Average item weight in pounds. Used for logistics cost modeling and shipping rate analysis."
    - name: "private_label_item_count"
      expr: SUM(CASE WHEN private_label_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of private label items in the active assortment. Numerator for private label penetration rate."
    - name: "organic_item_count"
      expr: SUM(CASE WHEN organic_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of organically certified items. Measures organic assortment depth for premium category strategy."
    - name: "snap_eligible_item_count"
      expr: SUM(CASE WHEN snap_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of SNAP-eligible items. Tracks SNAP assortment coverage for program compliance."
    - name: "age_restricted_item_count"
      expr: SUM(CASE WHEN age_restricted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of age-restricted items. Supports compliance monitoring and age-verification process scoping."
    - name: "fda_labeling_required_count"
      expr: SUM(CASE WHEN fda_labeling_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of items requiring FDA labeling. Tracks regulatory compliance exposure in the assortment."
    - name: "distinct_brands"
      expr: COUNT(DISTINCT brand_id)
      comment: "Count of distinct brands in the active assortment. Measures brand portfolio breadth for category management."
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of distinct primary suppliers. Measures supplier diversification and single-source risk exposure."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_order_substitution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Substitution quality and customer acceptance metrics. Enables fulfillment operations and category management to reduce OOS-driven substitutions, improve substitution quality, and protect customer satisfaction."
  source: "`grocery_ecm`.`product`.`order_substitution`"
  dimensions:
    - name: "substitution_type"
      expr: substitution_type
      comment: "Type of substitution (brand swap, size swap, category swap) for substitution quality categorization."
    - name: "substitution_reason_code"
      expr: substitution_reason_code
      comment: "Coded reason for the substitution (OOS, damaged, expired). Drives root cause analysis for OOS reduction."
    - name: "customer_acceptance_status"
      expr: customer_acceptance_status
      comment: "Whether the customer accepted or rejected the substitution. Primary customer satisfaction signal for substitution quality."
    - name: "brand_match_flag"
      expr: brand_match_flag
      comment: "Indicates whether the substitute is the same brand. Measures brand loyalty preservation in substitutions."
    - name: "category_match_flag"
      expr: category_match_flag
      comment: "Indicates whether the substitute is in the same category. Measures category relevance of substitutions."
    - name: "size_match_flag"
      expr: size_match_flag
      comment: "Indicates whether the substitute is the same size. Measures size equivalence quality in substitutions."
    - name: "price_protection_applied_flag"
      expr: price_protection_applied_flag
      comment: "Flags substitutions where price protection was applied. Tracks price protection cost and customer fairness."
    - name: "refund_issued_flag"
      expr: refund_issued_flag
      comment: "Indicates whether a refund was issued due to the substitution. Tracks substitution-driven refund volume."
    - name: "customer_notification_method"
      expr: customer_notification_method
      comment: "How the customer was notified of the substitution (app, SMS, email). Measures notification channel effectiveness."
  measures:
    - name: "total_substitutions"
      expr: COUNT(1)
      comment: "Total number of substitution events. Baseline OOS and substitution volume metric."
    - name: "accepted_substitutions"
      expr: SUM(CASE WHEN customer_acceptance_status = 'ACCEPTED' THEN 1 ELSE 0 END)
      comment: "Count of substitutions accepted by customers. Numerator for substitution acceptance rate — key customer satisfaction KPI."
    - name: "rejected_substitutions"
      expr: SUM(CASE WHEN customer_acceptance_status = 'REJECTED' THEN 1 ELSE 0 END)
      comment: "Count of substitutions rejected by customers. Tracks substitution quality failures and refund exposure."
    - name: "avg_substitution_quality_score"
      expr: AVG(CAST(substitution_quality_score AS DOUBLE))
      comment: "Average quality score of substitutions. Composite measure of substitution relevance used to benchmark picker and algorithm performance."
    - name: "total_price_difference"
      expr: SUM(CAST(price_difference_amount AS DOUBLE))
      comment: "Total price difference between original and substitute items. Measures financial impact of substitutions on customers and margin."
    - name: "total_refund_from_substitutions"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued due to substitutions. Measures financial cost of substitution rejections."
    - name: "brand_match_substitutions"
      expr: SUM(CASE WHEN brand_match_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of substitutions where the brand was preserved. Numerator for brand match rate — measures substitution quality."
    - name: "avg_original_unit_price"
      expr: AVG(CAST(original_unit_price AS DOUBLE))
      comment: "Average unit price of original items that were substituted. Identifies price tier of OOS items."
    - name: "avg_substitute_unit_price"
      expr: AVG(CAST(substitute_unit_price AS DOUBLE))
      comment: "Average unit price of substitute items. Compared against original price to assess substitution value equivalence."
    - name: "distinct_original_items_substituted"
      expr: COUNT(DISTINCT original_sku)
      comment: "Count of distinct original SKUs that were substituted. Identifies breadth of OOS exposure across the assortment."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-mile delivery performance metrics covering cost, SLA compliance, reattempt rates, and contactless adoption. Drives delivery operations efficiency and customer experience decisions."
  source: "`grocery_ecm`.`product`.`delivery_order`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (scheduled, in-transit, delivered, failed) for delivery pipeline monitoring."
    - name: "delivery_type"
      expr: delivery_type
      comment: "Type of delivery (standard, express, same-day) for SLA tier and cost analysis."
    - name: "failure_reason_code"
      expr: failure_reason_code
      comment: "Coded reason for delivery failure. Drives root cause analysis for delivery success rate improvement."
    - name: "contactless_delivery_flag"
      expr: contactless_delivery_flag
      comment: "Indicates contactless delivery. Tracks contactless adoption rate and operational compliance."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flags temperature-controlled deliveries. Supports cold chain compliance and premium delivery cost analysis."
    - name: "proof_of_delivery_method"
      expr: proof_of_delivery_method
      comment: "Method used to confirm delivery (photo, signature, PIN). Tracks POD compliance and dispute resolution readiness."
    - name: "scheduled_delivery_date"
      expr: scheduled_delivery_date
      comment: "Scheduled delivery date. Used for daily delivery volume planning and SLA window analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the delivery transaction for financial reporting."
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Total number of delivery orders. Baseline delivery volume metric for capacity and route planning."
    - name: "total_delivery_fee_revenue"
      expr: SUM(CAST(delivery_fee_amount AS DOUBLE))
      comment: "Total delivery fees collected. Measures delivery revenue contribution and fee recovery against delivery cost."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amounts collected. Tracks driver compensation supplementation and customer satisfaction signal."
    - name: "total_distance_miles"
      expr: SUM(CAST(distance_miles AS DOUBLE))
      comment: "Total delivery distance in miles. Used for fuel cost modeling and route efficiency analysis."
    - name: "avg_delivery_fee"
      expr: AVG(CAST(delivery_fee_amount AS DOUBLE))
      comment: "Average delivery fee per order. Tracks fee pricing effectiveness and competitive positioning."
    - name: "avg_distance_per_delivery"
      expr: AVG(CAST(distance_miles AS DOUBLE))
      comment: "Average delivery distance in miles. Measures route efficiency and delivery zone optimization opportunity."
    - name: "failed_deliveries"
      expr: SUM(CASE WHEN delivery_status = 'FAILED' THEN 1 ELSE 0 END)
      comment: "Count of failed deliveries. Numerator for delivery failure rate — critical customer experience and cost metric."
    - name: "contactless_deliveries"
      expr: SUM(CASE WHEN contactless_delivery_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contactless deliveries. Tracks contactless adoption rate for operational and safety compliance."
    - name: "temperature_controlled_deliveries"
      expr: SUM(CASE WHEN temperature_controlled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of temperature-controlled deliveries. Measures cold chain delivery volume and associated cost exposure."
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Count of distinct carriers used. Measures carrier diversification and single-carrier dependency risk."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_item_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category and hierarchy performance metrics covering margin targets, space allocation, shrink rates, and assortment structure. Enables category management and space planning decisions."
  source: "`grocery_ecm`.`product`.`item_hierarchy`"
  filter: node_status = 'ACTIVE'
  dimensions:
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the product hierarchy (department, category, subcategory, item) for hierarchical drill-down analysis."
    - name: "hierarchy_level_name"
      expr: hierarchy_level_name
      comment: "Name of the hierarchy level for business-readable category reporting."
    - name: "node_name"
      expr: node_name
      comment: "Name of the hierarchy node. Used as the primary label in category performance reports."
    - name: "node_status"
      expr: node_status
      comment: "Status of the hierarchy node (active, inactive, pending). Used for assortment health monitoring."
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone of the category (ambient, chilled, frozen). Supports cold chain category analysis."
    - name: "perishable_flag"
      expr: perishable_flag
      comment: "Flags perishable categories. Used for shrink, waste, and cold chain investment prioritization."
    - name: "private_label_flag"
      expr: private_label_flag
      comment: "Flags categories with private label presence. Enables private label strategy by category."
    - name: "snap_eligible_flag"
      expr: snap_eligible_flag
      comment: "Indicates SNAP-eligible categories. Required for SNAP program assortment compliance."
    - name: "promotional_category_flag"
      expr: promotional_category_flag
      comment: "Flags categories designated as promotional. Supports promotional calendar and space planning."
    - name: "leaf_node_flag"
      expr: leaf_node_flag
      comment: "Indicates leaf nodes (lowest level) in the hierarchy. Used to filter to item-level analysis."
    - name: "seasonality_pattern"
      expr: seasonality_pattern
      comment: "Seasonality pattern of the category. Supports seasonal assortment planning and inventory positioning."
  measures:
    - name: "total_hierarchy_nodes"
      expr: COUNT(1)
      comment: "Total number of active hierarchy nodes. Measures assortment structure complexity and taxonomy breadth."
    - name: "avg_target_gross_margin_pct"
      expr: AVG(CAST(target_gross_margin_percentage AS DOUBLE))
      comment: "Average target gross margin percentage across categories. Tracks margin ambition by category for financial planning."
    - name: "avg_gmroi_target"
      expr: AVG(CAST(gmroi_target_percentage AS DOUBLE))
      comment: "Average GMROI target across categories. Measures return on inventory investment targets for category prioritization."
    - name: "avg_shrink_rate_pct"
      expr: AVG(CAST(shrink_rate_percentage AS DOUBLE))
      comment: "Average shrink rate percentage across categories. Identifies high-shrink categories requiring loss prevention focus."
    - name: "avg_space_allocation_pct"
      expr: AVG(CAST(space_allocation_percentage AS DOUBLE))
      comment: "Average space allocation percentage across categories. Supports space productivity and planogram optimization decisions."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(average_unit_retail_price AS DOUBLE))
      comment: "Average unit retail price across hierarchy nodes. Tracks price positioning by category for competitive analysis."
    - name: "perishable_category_count"
      expr: SUM(CASE WHEN perishable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of perishable categories. Measures cold chain and shrink management scope."
    - name: "private_label_category_count"
      expr: SUM(CASE WHEN private_label_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of categories with private label presence. Measures private label strategy breadth across the assortment."
    - name: "promotional_category_count"
      expr: SUM(CASE WHEN promotional_category_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of promotional categories. Measures promotional assortment scope for marketing planning."
$$;


CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`product_rx_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pharmacy prescription fulfillment metrics covering dispensing volume, copay revenue, insurance reimbursement, and controlled substance compliance. Enables pharmacy operations and finance to manage Rx business performance."
  source: "`grocery_ecm`.`product`.`rx_order`"
  dimensions:
    - name: "fill_status"
      expr: fill_status
      comment: "Status of the prescription fill (filled, rejected, pending, transferred) for Rx pipeline monitoring."
    - name: "fill_type"
      expr: fill_type
      comment: "Type of fill (new, refill, transfer) for Rx volume mix analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the prescription was delivered (pickup, mail, drive-through) for Rx channel analysis."
    - name: "controlled_substance_flag"
      expr: controlled_substance_flag
      comment: "Flags controlled substance prescriptions. Required for DEA compliance and controlled substance volume monitoring."
    - name: "dea_schedule"
      expr: dea_schedule
      comment: "DEA schedule classification of the drug. Supports controlled substance compliance reporting by schedule."
    - name: "substitution_allowed_flag"
      expr: substitution_allowed_flag
      comment: "Indicates whether generic substitution was permitted. Measures generic substitution opportunity."
    - name: "substitution_occurred_flag"
      expr: substitution_occurred_flag
      comment: "Indicates whether generic substitution occurred. Measures generic dispensing rate and cost savings."
    - name: "prescription_written_date"
      expr: prescription_written_date
      comment: "Date the prescription was written. Used for Rx lag time and prescription-to-fill cycle analysis."
    - name: "fill_timestamp"
      expr: fill_timestamp
      comment: "Timestamp when the prescription was filled. Used for daily Rx volume and throughput analysis."
  measures:
    - name: "total_rx_fills"
      expr: COUNT(1)
      comment: "Total number of prescription fills. Core Rx volume metric for pharmacy capacity and staffing planning."
    - name: "total_copay_revenue"
      expr: SUM(CAST(copay_amount AS DOUBLE))
      comment: "Total copay revenue collected from patients. Measures patient out-of-pocket contribution to Rx revenue."
    - name: "total_insurance_paid"
      expr: SUM(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Total insurance reimbursement received. Primary Rx revenue metric for pharmacy financial performance."
    - name: "total_rx_revenue"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total Rx revenue (copay + insurance). Top-line pharmacy revenue metric for P&L reporting."
    - name: "total_dispensing_fees"
      expr: SUM(CAST(dispensing_fee AS DOUBLE))
      comment: "Total dispensing fees collected. Measures pharmacy service fee revenue stream."
    - name: "total_units_dispensed"
      expr: SUM(CAST(quantity_dispensed AS DOUBLE))
      comment: "Total units dispensed across all fills. Measures Rx throughput volume for inventory and procurement planning."
    - name: "avg_copay_per_fill"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay per prescription fill. Tracks patient cost burden trends and insurance plan mix impact."
    - name: "avg_insurance_reimbursement"
      expr: AVG(CAST(insurance_paid_amount AS DOUBLE))
      comment: "Average insurance reimbursement per fill. Monitors reimbursement rate trends for contract negotiation."
    - name: "controlled_substance_fills"
      expr: SUM(CASE WHEN controlled_substance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of controlled substance fills. Required for DEA compliance reporting and controlled substance volume monitoring."
    - name: "generic_substitution_fills"
      expr: SUM(CASE WHEN substitution_occurred_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fills where generic substitution occurred. Numerator for generic dispensing rate — measures cost savings opportunity."
    - name: "distinct_patients"
      expr: COUNT(DISTINCT rx_patient_id)
      comment: "Count of distinct patients with Rx fills. Measures active pharmacy patient base for retention and adherence programs."
    - name: "distinct_drugs_dispensed"
      expr: COUNT(DISTINCT drug_id)
      comment: "Count of distinct drugs dispensed. Measures pharmacy formulary utilization breadth."
$$;
