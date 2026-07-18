-- Metric views for domain: sales | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:12:43

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order performance metrics including revenue, volume, and order fulfillment efficiency"
  source: "`food_beverage_ecm`.`sales`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the sales order (e.g., pending, confirmed, shipped, delivered, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., standard, rush, promotional, sample)"
    - name: "channel"
      expr: channel
      comment: "Sales channel through which the order was placed (e.g., retail, foodservice, direct-to-consumer, e-commerce)"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for the order"
    - name: "order_source"
      expr: order_source
      comment: "Source system or method of order entry (e.g., EDI, web portal, sales rep, phone)"
    - name: "order_year"
      expr: YEAR(placed_timestamp)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', placed_timestamp)
      comment: "Month the order was placed, truncated to first day of month"
    - name: "order_quarter"
      expr: CONCAT('Q', QUARTER(placed_timestamp), '-', YEAR(placed_timestamp))
      comment: "Fiscal quarter when order was placed"
    - name: "is_backorder"
      expr: is_backorder
      comment: "Flag indicating whether the order is a backorder"
    - name: "priority_flag"
      expr: priority_flag
      comment: "Flag indicating whether the order has priority status"
    - name: "trade_allowance_flag"
      expr: trade_allowance_flag
      comment: "Flag indicating whether trade allowances apply to this order"
  measures:
    - name: "total_order_count"
      expr: COUNT(DISTINCT order_id)
      comment: "Total number of unique sales orders"
    - name: "gross_revenue"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross revenue before discounts and deductions"
    - name: "net_revenue"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net revenue after all discounts and deductions"
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total value of discounts applied across all orders"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount collected on orders"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_amount AS DOUBLE)), 0), 2)
      comment: "Average discount rate as percentage of gross revenue"
    - name: "avg_order_value_gross"
      expr: AVG(CAST(total_gross_amount AS DOUBLE))
      comment: "Average gross order value per order"
    - name: "avg_order_value_net"
      expr: AVG(CAST(total_net_amount AS DOUBLE))
      comment: "Average net order value per order after discounts"
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(total_volume_cu_m AS DOUBLE))
      comment: "Total order volume in cubic meters for logistics planning"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total order weight in kilograms for freight cost estimation"
    - name: "unique_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts placing orders"
    - name: "unique_ship_to_locations"
      expr: COUNT(DISTINCT ship_to_location_id)
      comment: "Number of unique delivery locations served"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice and accounts receivable metrics tracking billing, payment performance, and revenue recognition"
  source: "`food_beverage_ecm`.`sales`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., draft, issued, paid, overdue, cancelled)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., standard, credit memo, debit memo, prepayment)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice (e.g., unpaid, partial, paid, written off)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., wire transfer, check, credit card, ACH)"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category for financial reporting and analysis"
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Flag indicating whether this is a credit memo (return/adjustment)"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued, truncated to first day of month"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "posted_to_ledger_flag"
      expr: posted_to_ledger_flag
      comment: "Flag indicating whether invoice has been posted to general ledger"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Total number of unique invoices issued"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced amount including all charges and taxes"
    - name: "subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total invoice subtotal before taxes and freight"
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected on invoices"
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight and shipping charges invoiced"
    - name: "total_trade_discounts"
      expr: SUM(CAST(trade_discount_amount AS DOUBLE))
      comment: "Total trade discounts applied to invoices"
    - name: "avg_invoice_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice value across all invoices"
    - name: "avg_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Average effective tax rate as percentage of subtotal"
    - name: "freight_as_pct_of_subtotal"
      expr: ROUND(100.0 * SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Freight charges as percentage of invoice subtotal"
    - name: "unique_customers_invoiced"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers invoiced in the period"
    - name: "unique_bill_to_locations"
      expr: COUNT(DISTINCT bill_to_location_id)
      comment: "Number of unique billing locations"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale transaction metrics for retail sell-through analysis, promotional effectiveness, and consumer demand patterns"
  source: "`food_beverage_ecm`.`sales`.`pos_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the point-of-sale transaction"
    - name: "transaction_year"
      expr: YEAR(transaction_date)
      comment: "Year of the transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction, truncated to first day of month"
    - name: "transaction_day_of_week"
      expr: transaction_day_of_week
      comment: "Day of week when transaction occurred"
    - name: "transaction_week"
      expr: transaction_week
      comment: "Week number of the transaction"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel where the sale occurred (e.g., in-store, online, mobile)"
    - name: "retailer_banner"
      expr: retailer_banner
      comment: "Retail banner or chain name"
    - name: "store_format"
      expr: store_format
      comment: "Format of the retail store (e.g., supermarket, convenience, club, drug)"
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Flag indicating whether the product was on promotion"
    - name: "feature_flag"
      expr: feature_flag
      comment: "Flag indicating whether the product was featured in retailer advertising"
    - name: "display_flag"
      expr: display_flag
      comment: "Flag indicating whether the product had special in-store display"
    - name: "price_type"
      expr: price_type
      comment: "Type of pricing (e.g., regular, promotional, clearance)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (e.g., completed, voided, returned)"
  measures:
    - name: "total_transaction_count"
      expr: COUNT(DISTINCT pos_transaction_id)
      comment: "Total number of unique POS transactions"
    - name: "total_dollar_sales"
      expr: SUM(CAST(dollar_sales AS DOUBLE))
      comment: "Total retail sales value at point of sale"
    - name: "avg_transaction_value"
      expr: AVG(CAST(dollar_sales AS DOUBLE))
      comment: "Average dollar value per transaction"
    - name: "avg_price_per_unit"
      expr: AVG(CAST(average_price AS DOUBLE))
      comment: "Average retail price per unit sold"
    - name: "unique_stores_selling"
      expr: COUNT(DISTINCT store_id)
      comment: "Number of unique retail stores with sales"
    - name: "unique_skus_sold"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs sold in the period"
    - name: "unique_receipts"
      expr: COUNT(DISTINCT receipt_number)
      comment: "Number of unique customer receipts (basket count)"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales contract and customer agreement metrics tracking commitments, performance against contracted volumes, and contract economics"
  source: "`food_beverage_ecm`.`sales`.`contract`"
  dimensions:
    - name: "sales_contract_status"
      expr: sales_contract_status
      comment: "Current status of the sales contract (e.g., draft, active, expired, terminated)"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., volume commitment, exclusive supply, promotional, distribution)"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the contract is currently active"
    - name: "exclusive_flag"
      expr: exclusive_flag
      comment: "Flag indicating whether this is an exclusive supply contract"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Flag indicating whether the contract auto-renews"
    - name: "edlp_tier"
      expr: edlp_tier
      comment: "Everyday Low Price tier classification"
    - name: "contract_year"
      expr: YEAR(effective_start_date)
      comment: "Year the contract became effective"
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the contract became effective"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which contract values are denominated"
    - name: "volume_uom"
      expr: volume_uom
      comment: "Unit of measure for contracted volume commitments"
  measures:
    - name: "total_contract_count"
      expr: COUNT(DISTINCT contract_id)
      comment: "Total number of unique sales contracts"
    - name: "total_committed_volume"
      expr: SUM(CAST(total_committed_volume AS DOUBLE))
      comment: "Total volume committed across all contracts"
    - name: "avg_committed_volume"
      expr: AVG(CAST(total_committed_volume AS DOUBLE))
      comment: "Average committed volume per contract"
    - name: "total_slotting_fees"
      expr: SUM(CAST(slotting_fee_total AS DOUBLE))
      comment: "Total slotting fees committed by retailers for shelf space"
    - name: "total_rsp_commitment"
      expr: SUM(CAST(rsp_commitment AS DOUBLE))
      comment: "Total recommended selling price commitments"
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across contracts"
    - name: "avg_fee_per_store"
      expr: AVG(CAST(fee_per_store AS DOUBLE))
      comment: "Average fee per store for distribution contracts"
    - name: "unique_customers_contracted"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique retail customers with active contracts"
    - name: "unique_skus_contracted"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs covered by contracts"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_rebate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade rebate and customer incentive metrics tracking rebate commitments, accruals, and settlement performance"
  source: "`food_beverage_ecm`.`sales`.`rebate_agreement`"
  dimensions:
    - name: "rebate_agreement_status"
      expr: rebate_agreement_status
      comment: "Current status of the rebate agreement (e.g., active, pending, expired, settled)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of rebate agreement (e.g., volume-based, growth-based, promotional, loyalty)"
    - name: "tiered_flag"
      expr: tiered_flag
      comment: "Flag indicating whether the rebate has tiered thresholds"
    - name: "accrual_method"
      expr: accrual_method
      comment: "Method used to accrue rebate liability (e.g., invoice-based, shipment-based, payment-based)"
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "Frequency of rebate settlement payments (e.g., monthly, quarterly, annually)"
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method of rebate settlement (e.g., check, credit memo, wire transfer)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel to which the rebate agreement applies"
    - name: "region"
      expr: region
      comment: "Geographic region covered by the rebate agreement"
    - name: "agreement_year"
      expr: YEAR(effective_from)
      comment: "Year the rebate agreement became effective"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which rebate amounts are denominated"
  measures:
    - name: "total_rebate_agreement_count"
      expr: COUNT(DISTINCT rebate_agreement_id)
      comment: "Total number of unique rebate agreements"
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across all agreements"
    - name: "total_max_rebate_exposure"
      expr: SUM(CAST(max_rebate_amount AS DOUBLE))
      comment: "Total maximum rebate exposure across all agreements"
    - name: "total_min_rebate_commitment"
      expr: SUM(CAST(min_rebate_amount AS DOUBLE))
      comment: "Total minimum rebate commitment across all agreements"
    - name: "avg_threshold_quantity"
      expr: AVG(CAST(threshold_quantity AS DOUBLE))
      comment: "Average volume threshold quantity to qualify for rebates"
    - name: "unique_customers_with_rebates"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customers with rebate agreements"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_distribution_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product distribution and availability metrics tracking numeric and ACV-weighted distribution, velocity, and market coverage"
  source: "`food_beverage_ecm`.`sales`.`distribution_point`"
  dimensions:
    - name: "distribution_status"
      expr: distribution_status
      comment: "Current distribution status (e.g., active, discontinued, pending, out-of-stock)"
    - name: "classification_type"
      expr: classification_type
      comment: "Classification of the distribution point (e.g., core, seasonal, promotional, test market)"
    - name: "in_stock_flag"
      expr: in_stock_flag
      comment: "Flag indicating whether the product is currently in stock at this point"
    - name: "retailer_banner"
      expr: retailer_banner
      comment: "Retail banner or chain name"
    - name: "period_type"
      expr: period_type
      comment: "Type of measurement period (e.g., weekly, monthly, quarterly)"
    - name: "snapshot_year"
      expr: YEAR(snapshot_date)
      comment: "Year of the distribution snapshot"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of the distribution snapshot"
    - name: "data_source"
      expr: data_source
      comment: "Source of distribution data (e.g., syndicated data provider, retailer feed, field audit)"
  measures:
    - name: "total_distribution_points"
      expr: COUNT(DISTINCT distribution_point_id)
      comment: "Total number of unique distribution points measured"
    - name: "avg_numeric_distribution_pct"
      expr: AVG(CAST(numeric_distribution_pct AS DOUBLE))
      comment: "Average numeric distribution percentage (percent of stores carrying the product)"
    - name: "avg_acv_weighted_distribution_pct"
      expr: AVG(CAST(acv_weighted_distribution_pct AS DOUBLE))
      comment: "Average ACV-weighted distribution percentage (percent of category sales in stores carrying the product)"
    - name: "avg_velocity_units_per_point"
      expr: AVG(CAST(velocity_units_per_point AS DOUBLE))
      comment: "Average sales velocity in units per distribution point"
    - name: "avg_tdp_contribution_pct"
      expr: AVG(CAST(tdp_contribution_pct AS DOUBLE))
      comment: "Average total distribution point contribution percentage"
    - name: "avg_numeric_distribution_change_pct"
      expr: AVG(CAST(numeric_distribution_change_pct AS DOUBLE))
      comment: "Average period-over-period change in numeric distribution"
    - name: "avg_acv_change_pct"
      expr: AVG(CAST(acv_change_pct AS DOUBLE))
      comment: "Average period-over-period change in ACV-weighted distribution"
    - name: "unique_stores_measured"
      expr: COUNT(DISTINCT store_id)
      comment: "Number of unique retail stores measured for distribution"
    - name: "unique_skus_tracked"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs tracked for distribution metrics"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales quota and target metrics for performance management, territory planning, and incentive compensation"
  source: "`food_beverage_ecm`.`sales`.`quota`"
  dimensions:
    - name: "quota_status"
      expr: quota_status
      comment: "Current status of the quota (e.g., draft, approved, active, closed)"
    - name: "quota_type"
      expr: quota_type
      comment: "Type of quota (e.g., revenue, volume, new accounts, market share)"
    - name: "period_type"
      expr: period_type
      comment: "Time period type for the quota (e.g., monthly, quarterly, annual)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the quota"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for the quota"
    - name: "region"
      expr: region
      comment: "Geographic region for the quota"
    - name: "target_confidence"
      expr: target_confidence
      comment: "Confidence level in achieving the target (e.g., conservative, realistic, stretch)"
    - name: "target_measurement_method"
      expr: target_measurement_method
      comment: "Method used to measure quota achievement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which quota targets are denominated"
  measures:
    - name: "total_quota_count"
      expr: COUNT(DISTINCT quota_id)
      comment: "Total number of unique quota assignments"
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total target value across all quotas"
    - name: "total_stretch_target_value"
      expr: SUM(CAST(stretch_target_value AS DOUBLE))
      comment: "Total stretch target value (aspirational goals beyond base quota)"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average quota target value per assignment"
    - name: "avg_stretch_target_value"
      expr: AVG(CAST(stretch_target_value AS DOUBLE))
      comment: "Average stretch target value per assignment"
    - name: "stretch_uplift_pct"
      expr: ROUND(100.0 * (SUM(CAST(stretch_target_value AS DOUBLE)) - SUM(CAST(target_value AS DOUBLE))) / NULLIF(SUM(CAST(target_value AS DOUBLE)), 0), 2)
      comment: "Percentage uplift from base target to stretch target"
    - name: "unique_sales_reps_with_quota"
      expr: COUNT(DISTINCT rep_id)
      comment: "Number of unique sales representatives with assigned quotas"
    - name: "unique_territories_with_quota"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories with assigned quotas"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales representative performance and capacity metrics for workforce planning and sales force effectiveness"
  source: "`food_beverage_ecm`.`sales`.`rep`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (e.g., active, on leave, terminated)"
    - name: "rep_type"
      expr: rep_type
      comment: "Type of sales representative (e.g., field, inside, key account, distributor)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Primary sales channel the rep covers"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region assigned to the rep"
    - name: "sales_district"
      expr: sales_district
      comment: "Sales district assigned to the rep"
    - name: "compensation_plan"
      expr: compensation_plan
      comment: "Compensation plan type (e.g., salary plus commission, commission only, salary only)"
    - name: "certification_status"
      expr: certification_status
      comment: "Certification or training status of the rep"
    - name: "is_remote_worker"
      expr: is_remote_worker
      comment: "Flag indicating whether the rep works remotely"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year the rep was hired"
  measures:
    - name: "total_rep_count"
      expr: COUNT(DISTINCT rep_id)
      comment: "Total number of unique sales representatives"
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate percentage across all reps"
    - name: "total_annual_revenue_quota"
      expr: SUM(CAST(quota_annual_revenue AS DOUBLE))
      comment: "Total annual revenue quota assigned to all reps"
    - name: "total_annual_cases_quota"
      expr: SUM(CAST(quota_annual_cases AS DOUBLE))
      comment: "Total annual case volume quota assigned to all reps"
    - name: "avg_annual_revenue_quota"
      expr: AVG(CAST(quota_annual_revenue AS DOUBLE))
      comment: "Average annual revenue quota per rep"
    - name: "avg_annual_cases_quota"
      expr: AVG(CAST(quota_annual_cases AS DOUBLE))
      comment: "Average annual case volume quota per rep"
    - name: "unique_territories_covered"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories covered by the sales force"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_store`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail store and outlet metrics for customer coverage analysis, store performance benchmarking, and market penetration"
  source: "`food_beverage_ecm`.`sales`.`store`"
  dimensions:
    - name: "store_status"
      expr: store_status
      comment: "Current operational status of the store (e.g., active, temporarily closed, permanently closed, under renovation)"
    - name: "store_type"
      expr: store_type
      comment: "Type of store (e.g., company-owned, franchise, distributor, independent)"
    - name: "format"
      expr: format
      comment: "Store format classification (e.g., supermarket, hypermarket, convenience, club, drug, dollar)"
    - name: "cluster"
      expr: cluster
      comment: "Store cluster or segmentation group for targeted strategies"
    - name: "region"
      expr: region
      comment: "Geographic region where the store is located"
    - name: "district"
      expr: district
      comment: "Sales district where the store is located"
    - name: "is_franchise"
      expr: is_franchise
      comment: "Flag indicating whether the store is a franchise location"
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the store opened"
    - name: "country"
      expr: country
      comment: "Country where the store is located"
    - name: "state"
      expr: state
      comment: "State or province where the store is located"
  measures:
    - name: "total_store_count"
      expr: COUNT(DISTINCT store_id)
      comment: "Total number of unique retail stores"
    - name: "total_sales_area_sqft"
      expr: SUM(CAST(sales_area_sqft AS DOUBLE))
      comment: "Total sales floor area across all stores in square feet"
    - name: "avg_sales_area_sqft"
      expr: AVG(CAST(sales_area_sqft AS DOUBLE))
      comment: "Average sales floor area per store in square feet"
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total building square footage across all stores"
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average building square footage per store"
    - name: "unique_accounts_served"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts associated with stores"
    - name: "unique_territories_with_stores"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique sales territories containing stores"
$$;


CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sales_broker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker and sales agent performance metrics for indirect channel management, commission tracking, and broker network optimization"
  source: "`food_beverage_ecm`.`sales`.`broker`"
  dimensions:
    - name: "broker_status"
      expr: broker_status
      comment: "Current status of the broker relationship (e.g., active, inactive, suspended, terminated)"
    - name: "broker_type"
      expr: broker_type
      comment: "Type of broker (e.g., independent, manufacturer rep, distributor, agent)"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification (e.g., platinum, gold, silver, bronze)"
    - name: "commission_basis"
      expr: commission_basis
      comment: "Basis for commission calculation (e.g., gross sales, net sales, margin, volume)"
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the broker contract (e.g., active, pending renewal, expired)"
    - name: "country"
      expr: country
      comment: "Country where the broker operates"
    - name: "state"
      expr: state
      comment: "State or province where the broker is based"
    - name: "contract_year"
      expr: YEAR(contract_effective_from)
      comment: "Year the broker contract became effective"
  measures:
    - name: "total_broker_count"
      expr: COUNT(DISTINCT broker_id)
      comment: "Total number of unique brokers in the network"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across all brokers"
    - name: "unique_territories_covered"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of unique territories covered by the broker network"
    - name: "unique_accounts_served"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts served by brokers"
$$;
