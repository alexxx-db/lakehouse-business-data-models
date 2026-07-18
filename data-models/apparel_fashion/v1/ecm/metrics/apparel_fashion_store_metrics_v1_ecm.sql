-- Metric views for domain: store | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale transaction metrics for revenue, tender mix, and transaction performance analysis"
  source: "`apparel_fashion_ecm`.`store`.`pos_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: business_date
      comment: "Business date of the transaction for daily trend analysis"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', business_date)
      comment: "Month of transaction for monthly aggregation"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (sale, return, exchange, void)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (completed, pending, cancelled)"
    - name: "channel_type"
      expr: channel_type
      comment: "Channel through which transaction occurred (in-store, online, mobile)"
    - name: "receipt_delivery_method"
      expr: receipt_delivery_method
      comment: "Method of receipt delivery (printed, email, SMS, none)"
    - name: "manager_override_flag"
      expr: manager_override_flag
      comment: "Whether transaction required manager override"
    - name: "price_override_flag"
      expr: price_override_flag
      comment: "Whether transaction included price override"
    - name: "rfid_verified_flag"
      expr: rfid_verified_flag
      comment: "Whether transaction items were RFID verified"
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of POS transactions"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross transaction amount before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net transaction amount after discounts before taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all transactions"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all transactions"
    - name: "avg_transaction_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net transaction value (basket size)"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount rate as percentage of gross sales"
    - name: "total_cash_tender"
      expr: SUM(CAST(tender_cash_amount AS DOUBLE))
      comment: "Total cash tender amount"
    - name: "total_credit_tender"
      expr: SUM(CAST(tender_credit_amount AS DOUBLE))
      comment: "Total credit card tender amount"
    - name: "total_debit_tender"
      expr: SUM(CAST(tender_debit_amount AS DOUBLE))
      comment: "Total debit card tender amount"
    - name: "total_gift_card_tender"
      expr: SUM(CAST(tender_gift_card_amount AS DOUBLE))
      comment: "Total gift card tender amount"
    - name: "total_mobile_wallet_tender"
      expr: SUM(CAST(tender_mobile_wallet_amount AS DOUBLE))
      comment: "Total mobile wallet tender amount"
    - name: "cash_tender_mix_pct"
      expr: ROUND(100.0 * SUM(CAST(tender_cash_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Cash tender as percentage of total net sales"
    - name: "digital_tender_mix_pct"
      expr: ROUND(100.0 * (SUM(CAST(tender_credit_amount AS DOUBLE)) + SUM(CAST(tender_debit_amount AS DOUBLE)) + SUM(CAST(tender_mobile_wallet_amount AS DOUBLE))) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Digital tender (credit + debit + mobile wallet) as percentage of total net sales"
    - name: "total_loyalty_points_earned"
      expr: SUM(CAST(loyalty_points_earned AS BIGINT))
      comment: "Total loyalty points earned across all transactions"
    - name: "total_loyalty_points_redeemed"
      expr: SUM(CAST(loyalty_points_redeemed AS BIGINT))
      comment: "Total loyalty points redeemed across all transactions"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers transacting"
    - name: "unique_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores with transactions"
    - name: "unique_registers"
      expr: COUNT(DISTINCT register_id)
      comment: "Number of unique registers used"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_pos_transaction_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level transaction metrics for product sales, margin, and markdown analysis"
  source: "`apparel_fashion_ecm`.`store`.`pos_transaction_line`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the transaction line"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for monthly aggregation"
    - name: "line_type"
      expr: line_type
      comment: "Type of transaction line (sale, return, discount, adjustment)"
    - name: "department_code"
      expr: department_code
      comment: "Department code for merchandise hierarchy analysis"
    - name: "class_code"
      expr: class_code
      comment: "Class code for merchandise hierarchy analysis"
    - name: "subclass_code"
      expr: subclass_code
      comment: "Subclass code for merchandise hierarchy analysis"
    - name: "season_code"
      expr: season_code
      comment: "Season code for seasonal analysis"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment type (in-store, BOPIS, ship-from-store)"
    - name: "is_clearance_item"
      expr: is_clearance_item
      comment: "Whether item is on clearance"
    - name: "is_markdown_item"
      expr: is_markdown_item
      comment: "Whether item is marked down"
    - name: "is_rfid_scanned"
      expr: is_rfid_scanned
      comment: "Whether item was RFID scanned"
  measures:
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total number of transaction lines"
    - name: "total_units_sold"
      expr: SUM(CAST(quantity_sold AS BIGINT))
      comment: "Total units sold across all lines"
    - name: "total_extended_amount"
      expr: SUM(CAST(line_extended_amount AS DOUBLE))
      comment: "Total extended line amount (quantity × unit price)"
    - name: "total_line_discount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discount amount at line level"
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total markdown amount applied to lines"
    - name: "total_cogs"
      expr: SUM(CAST(cogs AS DOUBLE))
      comment: "Total cost of goods sold"
    - name: "total_gross_margin"
      expr: SUM((CAST(line_extended_amount AS DOUBLE)) - (CAST(cogs AS DOUBLE)))
      comment: "Total gross margin (extended amount minus COGS)"
    - name: "gross_margin_pct"
      expr: ROUND(100.0 * (SUM(CAST(line_extended_amount AS DOUBLE)) - SUM(CAST(cogs AS DOUBLE))) / NULLIF(SUM(CAST(line_extended_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin percentage"
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average unit retail price across all lines"
    - name: "avg_imu_pct"
      expr: AVG(CAST(imu_pct AS DOUBLE))
      comment: "Average initial markup percentage"
    - name: "avg_mmu_pct"
      expr: AVG(CAST(mmu_pct AS DOUBLE))
      comment: "Average maintained markup percentage"
    - name: "units_per_transaction"
      expr: SUM(CAST(quantity_sold AS BIGINT)) / NULLIF(COUNT(DISTINCT pos_transaction_id), 0)
      comment: "Average units per transaction"
    - name: "unique_skus_sold"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs sold"
    - name: "unique_transactions"
      expr: COUNT(DISTINCT pos_transaction_id)
      comment: "Number of unique transactions"
    - name: "unique_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores with sales"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_daily_sales_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily store-level sales performance metrics for comp sales, traffic conversion, and tender analysis"
  source: "`apparel_fashion_ecm`.`store`.`daily_sales_summary`"
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the sales summary"
    - name: "business_month"
      expr: DATE_TRUNC('MONTH', business_date)
      comment: "Business month for monthly aggregation"
    - name: "summary_status"
      expr: summary_status
      comment: "Status of the daily summary (draft, finalized, adjusted)"
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Whether the daily summary has been reconciled"
    - name: "is_adjusted"
      expr: is_adjusted
      comment: "Whether the daily summary has been adjusted"
  measures:
    - name: "store_day_count"
      expr: COUNT(1)
      comment: "Total number of store-days in the period"
    - name: "total_gross_sales"
      expr: SUM(CAST(gross_sales_amount AS DOUBLE))
      comment: "Total gross sales before returns and discounts"
    - name: "total_net_sales"
      expr: SUM(CAST(net_sales_amount AS DOUBLE))
      comment: "Total net sales after returns and discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied"
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total markdown amount applied"
    - name: "total_returns_amount"
      expr: SUM(CAST(returns_amount AS DOUBLE))
      comment: "Total returns amount"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected"
    - name: "total_shrinkage_amount"
      expr: SUM(CAST(shrinkage_amount AS DOUBLE))
      comment: "Total shrinkage amount"
    - name: "total_transactions"
      expr: SUM(CAST(transaction_count AS BIGINT))
      comment: "Total number of transactions"
    - name: "total_units_sold"
      expr: SUM(CAST(units_sold AS BIGINT))
      comment: "Total units sold"
    - name: "total_units_returned"
      expr: SUM(CAST(units_returned AS BIGINT))
      comment: "Total units returned"
    - name: "total_customer_traffic"
      expr: SUM(CAST(customer_traffic_count AS BIGINT))
      comment: "Total customer traffic count"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate (transactions / traffic)"
    - name: "avg_asp"
      expr: AVG(CAST(asp AS DOUBLE))
      comment: "Average selling price per unit"
    - name: "avg_aur"
      expr: AVG(CAST(aur AS DOUBLE))
      comment: "Average unit retail price"
    - name: "avg_units_per_transaction"
      expr: AVG(CAST(units_per_transaction AS DOUBLE))
      comment: "Average units per transaction"
    - name: "return_rate"
      expr: ROUND(100.0 * SUM(CAST(returns_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Return rate as percentage of gross sales"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Discount rate as percentage of gross sales"
    - name: "markdown_rate"
      expr: ROUND(100.0 * SUM(CAST(markdown_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Markdown rate as percentage of gross sales"
    - name: "shrinkage_rate"
      expr: ROUND(100.0 * SUM(CAST(shrinkage_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_sales_amount AS DOUBLE)), 0), 2)
      comment: "Shrinkage rate as percentage of gross sales"
    - name: "total_card_tender"
      expr: SUM(CAST(card_tender_amount AS DOUBLE))
      comment: "Total card tender amount"
    - name: "total_cash_tender"
      expr: SUM(CAST(cash_tender_amount AS DOUBLE))
      comment: "Total cash tender amount"
    - name: "total_digital_tender"
      expr: SUM(CAST(digital_tender_amount AS DOUBLE))
      comment: "Total digital tender amount"
    - name: "total_gift_card_tender"
      expr: SUM(CAST(gift_card_tender_amount AS DOUBLE))
      comment: "Total gift card tender amount"
    - name: "unique_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores reporting"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_return_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return transaction metrics for return rate, disposition, and loss prevention analysis"
  source: "`apparel_fashion_ecm`.`store`.`return_transaction`"
  dimensions:
    - name: "return_date"
      expr: business_date
      comment: "Business date of the return"
    - name: "return_month"
      expr: DATE_TRUNC('MONTH', business_date)
      comment: "Month of return for monthly aggregation"
    - name: "return_status"
      expr: return_status
      comment: "Status of the return (pending, approved, rejected, completed)"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return"
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which return was processed"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition code for returned merchandise"
    - name: "item_condition_code"
      expr: item_condition_code
      comment: "Condition code of returned item"
    - name: "refund_method"
      expr: refund_method
      comment: "Method of refund (original tender, store credit, exchange)"
    - name: "receipt_presented_flag"
      expr: receipt_presented_flag
      comment: "Whether receipt was presented"
    - name: "manager_override_flag"
      expr: manager_override_flag
      comment: "Whether manager override was required"
    - name: "loss_prevention_flag"
      expr: loss_prevention_flag
      comment: "Whether return was flagged for loss prevention"
    - name: "serial_returner_flag"
      expr: serial_returner_flag
      comment: "Whether customer is flagged as serial returner"
    - name: "rfid_verified_flag"
      expr: rfid_verified_flag
      comment: "Whether return was RFID verified"
  measures:
    - name: "return_count"
      expr: COUNT(1)
      comment: "Total number of return transactions"
    - name: "total_return_gross_amount"
      expr: SUM(CAST(return_gross_amount AS DOUBLE))
      comment: "Total gross return amount before adjustments"
    - name: "total_return_net_amount"
      expr: SUM(CAST(return_net_amount AS DOUBLE))
      comment: "Total net return amount after adjustments"
    - name: "total_return_discount"
      expr: SUM(CAST(return_discount_amount AS DOUBLE))
      comment: "Total discount amount on returns"
    - name: "total_return_tax"
      expr: SUM(CAST(return_tax_amount AS DOUBLE))
      comment: "Total tax amount refunded"
    - name: "total_quantity_returned"
      expr: SUM(CAST(quantity_returned AS BIGINT))
      comment: "Total quantity of items returned"
    - name: "avg_return_value"
      expr: AVG(CAST(return_net_amount AS DOUBLE))
      comment: "Average net return value per transaction"
    - name: "avg_days_since_purchase"
      expr: AVG(CAST(days_since_purchase AS BIGINT))
      comment: "Average days between purchase and return"
    - name: "unique_customers_returning"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers making returns"
    - name: "unique_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores processing returns"
    - name: "unique_skus_returned"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs returned"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_bopis_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buy-online-pickup-in-store order metrics for fulfillment speed, SLA compliance, and omnichannel performance"
  source: "`apparel_fashion_ecm`.`store`.`bopis_order`"
  dimensions:
    - name: "order_placed_date"
      expr: DATE(order_placed_timestamp)
      comment: "Date the BOPIS order was placed"
    - name: "order_placed_month"
      expr: DATE_TRUNC('MONTH', order_placed_timestamp)
      comment: "Month the BOPIS order was placed"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the BOPIS order"
    - name: "pickup_location_type"
      expr: pickup_location_type
      comment: "Type of pickup location (store, curbside, locker)"
    - name: "curbside_flag"
      expr: curbside_flag
      comment: "Whether order was curbside pickup"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Whether order was flagged as priority"
    - name: "sla_met_flag"
      expr: sla_met_flag
      comment: "Whether order met SLA target"
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify customer (SMS, email, app)"
    - name: "pickup_verification_method"
      expr: pickup_verification_method
      comment: "Method used to verify pickup (barcode, ID, PIN)"
  measures:
    - name: "bopis_order_count"
      expr: COUNT(1)
      comment: "Total number of BOPIS orders"
    - name: "total_order_value"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total order value across all BOPIS orders"
    - name: "avg_order_value"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value per BOPIS order"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOPIS orders meeting SLA target"
    - name: "avg_pick_time_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(pick_complete_timestamp) - UNIX_TIMESTAMP(pick_start_timestamp)) / 60 AS DOUBLE))
      comment: "Average time in minutes from pick start to pick complete"
    - name: "avg_ready_to_pickup_time_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(ready_for_pickup_timestamp) - UNIX_TIMESTAMP(order_placed_timestamp)) / 60 AS DOUBLE))
      comment: "Average time in minutes from order placed to ready for pickup"
    - name: "unique_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers placing BOPIS orders"
    - name: "unique_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores fulfilling BOPIS orders"
    - name: "unique_pickers"
      expr: COUNT(DISTINCT associate_id)
      comment: "Number of unique associates picking BOPIS orders"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_ship_from_store`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ship-from-store fulfillment metrics for on-time delivery, OTIF performance, and omnichannel efficiency"
  source: "`apparel_fashion_ecm`.`store`.`ship_from_store`"
  dimensions:
    - name: "request_date"
      expr: business_date
      comment: "Business date of the ship-from-store request"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', business_date)
      comment: "Month of the ship-from-store request"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the ship-from-store order"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Type of fulfillment (standard, expedited, same-day)"
    - name: "carrier_code"
      expr: carrier_code
      comment: "Carrier code for shipment"
    - name: "carrier_service_level"
      expr: carrier_service_level
      comment: "Service level of carrier (ground, 2-day, overnight)"
    - name: "on_time_flag"
      expr: on_time_flag
      comment: "Whether shipment was on time"
    - name: "in_full_flag"
      expr: in_full_flag
      comment: "Whether shipment was fulfilled in full"
    - name: "otif_flag"
      expr: otif_flag
      comment: "Whether shipment was on-time and in-full"
    - name: "partial_fulfillment_flag"
      expr: partial_fulfillment_flag
      comment: "Whether shipment was partially fulfilled"
    - name: "rfid_verified_flag"
      expr: rfid_verified_flag
      comment: "Whether shipment was RFID verified"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country code"
  measures:
    - name: "ship_from_store_count"
      expr: COUNT(1)
      comment: "Total number of ship-from-store orders"
    - name: "total_retail_value"
      expr: SUM(CAST(retail_value_amount AS DOUBLE))
      comment: "Total retail value of ship-from-store orders"
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total shipping cost for ship-from-store orders"
    - name: "avg_shipping_cost"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per order"
    - name: "shipping_cost_pct_of_retail"
      expr: ROUND(100.0 * SUM(CAST(shipping_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(retail_value_amount AS DOUBLE)), 0), 2)
      comment: "Shipping cost as percentage of retail value"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS BIGINT))
      comment: "Total quantity ordered"
    - name: "total_picked_quantity"
      expr: SUM(CAST(picked_quantity AS BIGINT))
      comment: "Total quantity picked"
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS BIGINT))
      comment: "Total quantity shipped"
    - name: "fill_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS BIGINT)) / NULLIF(SUM(CAST(ordered_quantity AS BIGINT)), 0), 2)
      comment: "Fill rate (shipped / ordered) as percentage"
    - name: "on_time_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "On-time delivery rate as percentage"
    - name: "in_full_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN in_full_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "In-full delivery rate as percentage"
    - name: "otif_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "On-time-in-full (OTIF) rate as percentage"
    - name: "avg_package_weight_kg"
      expr: AVG(CAST(package_weight_kg AS DOUBLE))
      comment: "Average package weight in kilograms"
    - name: "unique_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores fulfilling ship-from-store orders"
    - name: "unique_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs shipped from store"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_shrinkage_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shrinkage and loss prevention metrics for theft, damage, and inventory variance analysis"
  source: "`apparel_fashion_ecm`.`store`.`shrinkage_incident`"
  dimensions:
    - name: "incident_date"
      expr: incident_date
      comment: "Date of the shrinkage incident"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month of the shrinkage incident"
    - name: "shrinkage_type"
      expr: shrinkage_type
      comment: "Type of shrinkage (theft, damage, administrative, vendor fraud)"
    - name: "incident_status"
      expr: incident_status
      comment: "Status of the incident (open, investigating, resolved, closed)"
    - name: "discovery_method"
      expr: discovery_method
      comment: "Method by which shrinkage was discovered"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution (recovered, written off, insurance claim)"
    - name: "apprehension_made"
      expr: apprehension_made
      comment: "Whether an apprehension was made"
    - name: "organized_retail_crime_flag"
      expr: organized_retail_crime_flag
      comment: "Whether incident is flagged as organized retail crime"
    - name: "eas_alarm_triggered"
      expr: eas_alarm_triggered
      comment: "Whether EAS alarm was triggered"
    - name: "video_evidence_flag"
      expr: video_evidence_flag
      comment: "Whether video evidence exists"
    - name: "rfid_exception_flag"
      expr: rfid_exception_flag
      comment: "Whether RFID exception was flagged"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of shrinkage incidents"
    - name: "total_retail_value_lost"
      expr: SUM(CAST(retail_value_lost AS DOUBLE))
      comment: "Total retail value lost to shrinkage"
    - name: "total_cost_value_lost"
      expr: SUM(CAST(cost_value_lost AS DOUBLE))
      comment: "Total cost value lost to shrinkage"
    - name: "total_quantity_lost"
      expr: SUM(CAST(quantity_lost AS BIGINT))
      comment: "Total quantity of items lost"
    - name: "total_recovery_value"
      expr: SUM(CAST(recovery_value AS DOUBLE))
      comment: "Total value of recovered merchandise"
    - name: "total_recovery_quantity"
      expr: SUM(CAST(recovery_quantity AS BIGINT))
      comment: "Total quantity of recovered items"
    - name: "recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(recovery_value AS DOUBLE)) / NULLIF(SUM(CAST(retail_value_lost AS DOUBLE)), 0), 2)
      comment: "Recovery rate as percentage of retail value lost"
    - name: "avg_incident_value"
      expr: AVG(CAST(retail_value_lost AS DOUBLE))
      comment: "Average retail value per shrinkage incident"
    - name: "unique_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores with shrinkage incidents"
    - name: "unique_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs involved in shrinkage"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory cycle count metrics for accuracy, variance, and inventory control analysis"
  source: "`apparel_fashion_ecm`.`store`.`store_cycle_count`"
  dimensions:
    - name: "count_date"
      expr: count_date
      comment: "Date of the cycle count"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_date)
      comment: "Month of the cycle count"
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count (scheduled, in-progress, completed, cancelled)"
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (full, partial, spot, blind)"
    - name: "count_method"
      expr: count_method
      comment: "Method used for counting (manual, RFID, barcode)"
    - name: "location_type"
      expr: location_type
      comment: "Type of location counted (sales floor, stockroom, receiving)"
    - name: "recount_required_flag"
      expr: recount_required_flag
      comment: "Whether recount was required"
    - name: "adjustment_posted_flag"
      expr: adjustment_posted_flag
      comment: "Whether inventory adjustment was posted"
    - name: "rfid_verified_flag"
      expr: rfid_verified_flag
      comment: "Whether count was RFID verified"
    - name: "department_code"
      expr: department_code
      comment: "Department code for merchandise hierarchy"
  measures:
    - name: "count_event_count"
      expr: COUNT(1)
      comment: "Total number of cycle count events"
    - name: "total_system_on_hand"
      expr: SUM(CAST(system_on_hand_qty AS BIGINT))
      comment: "Total system on-hand quantity"
    - name: "total_physical_count"
      expr: SUM(CAST(physical_count_qty AS BIGINT))
      comment: "Total physical count quantity"
    - name: "total_variance_qty"
      expr: SUM(CAST(variance_qty AS BIGINT))
      comment: "Total variance quantity (physical - system)"
    - name: "total_variance_retail_value"
      expr: SUM(CAST(variance_retail_value AS DOUBLE))
      comment: "Total variance retail value"
    - name: "total_variance_cost_value"
      expr: SUM(CAST(variance_cost_value AS DOUBLE))
      comment: "Total variance cost value"
    - name: "inventory_accuracy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(variance_qty AS BIGINT) = 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Inventory accuracy rate (percentage of counts with zero variance)"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage"
    - name: "unique_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores with cycle counts"
    - name: "unique_skus_counted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs counted"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_retail_store`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail store master metrics for store portfolio, format, and capability analysis"
  source: "`apparel_fashion_ecm`.`store`.`retail_store`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the store (open, closed, remodeling, planned)"
    - name: "store_format"
      expr: store_format
      comment: "Format of the store (flagship, standard, outlet, pop-up)"
    - name: "trading_area_classification"
      expr: trading_area_classification
      comment: "Trading area classification (urban, suburban, rural)"
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone of the store location"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the store"
    - name: "region_name"
      expr: region_name
      comment: "Region name of the store"
    - name: "is_bopis_enabled"
      expr: is_bopis_enabled
      comment: "Whether store is BOPIS enabled"
    - name: "is_ship_from_store_enabled"
      expr: is_ship_from_store_enabled
      comment: "Whether store is ship-from-store enabled"
    - name: "is_rfid_enabled"
      expr: is_rfid_enabled
      comment: "Whether store is RFID enabled"
    - name: "rent_structure_type"
      expr: rent_structure_type
      comment: "Rent structure type (fixed, percentage, hybrid)"
  measures:
    - name: "store_count"
      expr: COUNT(1)
      comment: "Total number of stores"
    - name: "total_gross_selling_sqft"
      expr: SUM(CAST(gross_selling_sqft AS DOUBLE))
      comment: "Total gross selling square footage"
    - name: "total_net_selling_sqft"
      expr: SUM(CAST(net_selling_sqft AS DOUBLE))
      comment: "Total net selling square footage"
    - name: "total_stockroom_sqft"
      expr: SUM(CAST(stockroom_sqft AS DOUBLE))
      comment: "Total stockroom square footage"
    - name: "avg_gross_selling_sqft"
      expr: AVG(CAST(gross_selling_sqft AS DOUBLE))
      comment: "Average gross selling square footage per store"
    - name: "avg_net_selling_sqft"
      expr: AVG(CAST(net_selling_sqft AS DOUBLE))
      comment: "Average net selling square footage per store"
    - name: "total_annual_base_rent"
      expr: SUM(CAST(annual_base_rent AS DOUBLE))
      comment: "Total annual base rent across all stores"
    - name: "avg_annual_base_rent"
      expr: AVG(CAST(annual_base_rent AS DOUBLE))
      comment: "Average annual base rent per store"
    - name: "avg_rent_per_sqft"
      expr: SUM(CAST(annual_base_rent AS DOUBLE)) / NULLIF(SUM(CAST(gross_selling_sqft AS DOUBLE)), 0)
      comment: "Average rent per square foot"
    - name: "unique_districts"
      expr: COUNT(DISTINCT district_id)
      comment: "Number of unique districts"
    - name: "unique_store_clusters"
      expr: COUNT(DISTINCT store_cluster_id)
      comment: "Number of unique store clusters"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_traffic_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store traffic and conversion metrics for customer flow, dwell time, and conversion analysis"
  source: "`apparel_fashion_ecm`.`store`.`traffic_count`"
  dimensions:
    - name: "count_date"
      expr: count_date
      comment: "Date of the traffic count"
    - name: "count_month"
      expr: DATE_TRUNC('MONTH', count_date)
      comment: "Month of the traffic count"
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for traffic pattern analysis"
    - name: "count_hour"
      expr: count_hour
      comment: "Hour of day for traffic pattern analysis"
    - name: "count_period_type"
      expr: count_period_type
      comment: "Period type (hourly, daily, weekly)"
    - name: "is_holiday"
      expr: is_holiday
      comment: "Whether count date is a holiday"
    - name: "is_promotional_period"
      expr: is_promotional_period
      comment: "Whether count date is during promotional period"
    - name: "is_store_open"
      expr: is_store_open
      comment: "Whether store was open during count period"
    - name: "peak_hour_flag"
      expr: peak_hour_flag
      comment: "Whether count period is peak hour"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during count period"
    - name: "sensor_type"
      expr: sensor_type
      comment: "Type of sensor used for counting"
  measures:
    - name: "traffic_count_records"
      expr: COUNT(1)
      comment: "Total number of traffic count records"
    - name: "total_entry_count"
      expr: SUM(CAST(entry_count AS BIGINT))
      comment: "Total customer entry count"
    - name: "total_exit_count"
      expr: SUM(CAST(exit_count AS BIGINT))
      comment: "Total customer exit count"
    - name: "total_passing_traffic"
      expr: SUM(CAST(passing_traffic_count AS BIGINT))
      comment: "Total passing traffic count"
    - name: "total_transactions"
      expr: SUM(CAST(transaction_count AS BIGINT))
      comment: "Total transaction count"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate (transactions / entries)"
    - name: "avg_capture_rate"
      expr: AVG(CAST(capture_rate AS DOUBLE))
      comment: "Average capture rate (entries / passing traffic)"
    - name: "avg_bounce_rate"
      expr: AVG(CAST(bounce_rate AS DOUBLE))
      comment: "Average bounce rate (exits without transaction)"
    - name: "avg_dwell_time_seconds"
      expr: AVG(CAST(avg_dwell_time_seconds AS BIGINT))
      comment: "Average dwell time in seconds"
    - name: "total_bopis_orders"
      expr: SUM(CAST(bopis_order_count AS BIGINT))
      comment: "Total BOPIS order count"
    - name: "total_ship_from_store"
      expr: SUM(CAST(ship_from_store_count AS BIGINT))
      comment: "Total ship-from-store count"
    - name: "avg_sensor_uptime_pct"
      expr: AVG(CAST(sensor_uptime_pct AS DOUBLE))
      comment: "Average sensor uptime percentage"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score"
    - name: "unique_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores with traffic counts"
$$;


CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_shift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store associate shift metrics for labor cost, schedule adherence, and productivity analysis"
  source: "`apparel_fashion_ecm`.`store`.`shift`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift"
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the shift"
    - name: "shift_status"
      expr: shift_status
      comment: "Status of the shift (scheduled, completed, no-show, cancelled)"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (opening, closing, mid, overnight)"
    - name: "role_during_shift"
      expr: role_during_shift
      comment: "Role performed during shift"
    - name: "department_code"
      expr: department_code
      comment: "Department code for shift assignment"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Whether associate was a no-show"
    - name: "early_departure_flag"
      expr: early_departure_flag
      comment: "Whether associate departed early"
    - name: "manager_override_flag"
      expr: manager_override_flag
      comment: "Whether shift required manager override"
    - name: "training_shift_flag"
      expr: training_shift_flag
      comment: "Whether shift was a training shift"
    - name: "omnichannel_fulfillment_flag"
      expr: omnichannel_fulfillment_flag
      comment: "Whether shift included omnichannel fulfillment duties"
  measures:
    - name: "shift_count"
      expr: COUNT(1)
      comment: "Total number of shifts"
    - name: "total_scheduled_hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours"
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost across all shifts"
    - name: "avg_labor_cost_per_hour"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours_worked AS DOUBLE)), 0)
      comment: "Average labor cost per hour worked"
    - name: "schedule_adherence_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_hours_worked AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_hours AS DOUBLE)), 0), 2)
      comment: "Schedule adherence rate (actual / scheduled hours)"
    - name: "overtime_rate"
      expr: ROUND(100.0 * SUM(CAST(overtime_hours AS DOUBLE)) / NULLIF(SUM(CAST(actual_hours_worked AS DOUBLE)), 0), 2)
      comment: "Overtime rate as percentage of actual hours"
    - name: "no_show_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "No-show rate as percentage of scheduled shifts"
    - name: "unique_associates"
      expr: COUNT(DISTINCT associate_id)
      comment: "Number of unique associates working shifts"
    - name: "unique_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores with shifts"
$$;
