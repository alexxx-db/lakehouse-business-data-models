-- Metric views for domain: sales | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-27 07:41:37

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI view over sales orders. Tracks revenue performance, margin, discount impact, and order fulfilment quality across channels, account segments, and time periods. Primary steering dashboard for Sales VPs and Revenue Operations."
  source: "`vibe_consumer_goods_v1`.`sales`.`order`"
  dimensions:
    - name: "order_date"
      expr: order_date
      comment: "Calendar date the order was placed. Used for time-series trending of revenue and volume."
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. Open, Confirmed, Shipped, Cancelled). Enables funnel and fulfilment analysis."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. Standard, Rush, Promotional). Supports mix analysis and margin segmentation."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel through which the order was placed (e.g. Direct, Distributor, eCommerce). Key dimension for channel performance reporting."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel code associated with the order. Used for logistics and go-to-market segmentation."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organisation responsible for the order. Enables regional and organisational performance breakdowns."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the order. Required for multi-currency revenue reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed for the order. Supports cash-flow and DSO analysis."
    - name: "otif_status"
      expr: otif_status
      comment: "On-Time In-Full delivery status flag. Core dimension for supply chain service-level reporting."
    - name: "priority"
      expr: priority
      comment: "Order priority level. Used to assess urgency mix and resource allocation."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method selected for the order. Supports freight cost and lead-time analysis."
    - name: "requested_delivery_date"
      expr: requested_delivery_date
      comment: "Customer-requested delivery date. Used to measure on-time performance against customer expectations."
    - name: "actual_delivery_date"
      expr: actual_delivery_date
      comment: "Actual date the order was delivered. Used alongside requested_delivery_date to compute delivery variance."
    - name: "division"
      expr: division
      comment: "Business division associated with the order. Enables P&L segmentation by division."
  measures:
    - name: "total_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total billed revenue across all orders. Primary top-line revenue KPI for executive dashboards and QBRs."
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Sum of gross margin dollars across orders. Directly measures profitability and steers pricing and cost decisions."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted across orders. Tracks promotional spend and discount leakage impacting net revenue."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight cost charged on orders. Informs logistics cost management and freight recovery analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on orders. Required for tax compliance reporting and net revenue reconciliation."
    - name: "total_cogs"
      expr: SUM(CAST(cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold across orders. Core input to gross margin and profitability analysis."
    - name: "order_count"
      expr: COUNT(DISTINCT order_id)
      comment: "Count of distinct orders placed. Volume KPI used to track sales activity and demand trends."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per order. Compound KPI indicating deal size trends; a decline signals mix shift or pricing pressure."
    - name: "avg_gross_margin_per_order"
      expr: AVG(CAST(gross_margin_amount AS DOUBLE))
      comment: "Average gross margin dollars per order. Tracks profitability at the order level to identify margin dilution."
    - name: "gross_margin_rate"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of total order revenue. Strategic profitability ratio used in every executive review."
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal. Measures pricing discipline and promotional effectiveness."
    - name: "freight_as_pct_of_revenue"
      expr: ROUND(100.0 * SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Freight cost as a percentage of total revenue. Tracks logistics cost efficiency and informs freight recovery strategy."
    - name: "otif_order_count"
      expr: COUNT(DISTINCT CASE WHEN otif_status = 'OTIF' THEN order_id END)
      comment: "Count of orders delivered On-Time In-Full. Core supply chain service-level KPI tracked by operations and customer service."
    - name: "cancelled_order_count"
      expr: COUNT(DISTINCT CASE WHEN order_status = 'Cancelled' THEN order_id END)
      comment: "Count of cancelled orders. Tracks demand leakage and customer satisfaction risk."
    - name: "total_order_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units ordered. Volume metric used for demand planning, capacity management, and supply alignment."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPI view over customer invoices. Tracks billed revenue, collections performance, outstanding balances, margin, and dispute rates. Essential for Finance, Revenue Operations, and Credit Management."
  source: "`vibe_consumer_goods_v1`.`sales`.`invoice`"
  dimensions:
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued. Primary time dimension for revenue recognition and AR aging analysis."
    - name: "due_date"
      expr: due_date
      comment: "Payment due date on the invoice. Used for DSO and overdue balance tracking."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g. Open, Paid, Disputed, Cancelled). Core dimension for AR management."
    - name: "billing_type"
      expr: billing_type
      comment: "Type of billing document (e.g. Standard Invoice, Credit Memo, Debit Memo). Enables billing mix analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status (e.g. Paid, Partially Paid, Overdue). Drives collections prioritisation."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used (e.g. ACH, Wire, Check). Supports cash application and treasury analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency. Required for multi-currency AR and revenue reporting."
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel on the invoice. Enables channel-level revenue and margin analysis."
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organisation that generated the invoice. Supports regional and organisational revenue attribution."
    - name: "revenue_recognition_category"
      expr: revenue_recognition_category
      comment: "Revenue recognition classification. Required for ASC 606 / IFRS 15 compliance reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute. Used to segment disputed vs. clean AR."
    - name: "billing_period_start_date"
      expr: billing_period_start_date
      comment: "Start of the billing period covered by the invoice. Used for period-based revenue analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code on the invoice. Supports DSO benchmarking by terms bucket."
  measures:
    - name: "total_invoiced_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total invoiced revenue. Primary billed revenue KPI for Finance and Revenue Operations."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts and allowances. Core P&L revenue line used in financial reporting."
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue before deductions. Used to measure top-line billing volume."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total unpaid invoice balance. Primary AR balance KPI for credit and collections management."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected against invoices. Tracks cash collection performance."
    - name: "total_trade_discount"
      expr: SUM(CAST(trade_discount_amount AS DOUBLE))
      comment: "Total trade discount granted on invoices. Measures promotional and contractual discount spend."
    - name: "total_gross_margin"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin on invoiced sales. Profitability KPI aligned to billed revenue."
    - name: "total_cogs"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold on invoiced orders. Input to gross margin and profitability analysis."
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight charges billed on invoices. Tracks logistics cost recovery."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices. Required for tax compliance and remittance reporting."
    - name: "invoice_count"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Count of distinct invoices issued. Volume KPI for billing activity and workload tracking."
    - name: "disputed_invoice_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN invoice_id END)
      comment: "Count of invoices under dispute. Tracks dispute volume as a risk and quality indicator."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount collected. Key collections efficiency KPI for Finance and Credit teams."
    - name: "gross_margin_rate"
      expr: ROUND(100.0 * SUM(CAST(gross_margin_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Gross margin as a percentage of net invoiced revenue. Strategic profitability ratio for executive reporting."
    - name: "dispute_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN invoice_id END) / NULLIF(COUNT(DISTINCT invoice_id), 0), 2)
      comment: "Percentage of invoices under dispute. Quality KPI indicating billing accuracy and customer satisfaction risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_return_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over customer return orders. Tracks return volume, return value, credit memo issuance, restocking costs, and return reason patterns. Used by Sales, Finance, and Quality teams to manage reverse logistics and customer satisfaction."
  source: "`vibe_consumer_goods_v1`.`sales`.`order`"
  dimensions:
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel associated with the return. Enables channel-level return rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the return transaction. Required for multi-currency return value reporting."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organisation associated with the return. Enables regional return performance analysis."
  measures:
    - name: "Row Count"
      expr: COUNT(1)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_trade_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI view over trade accounts (customers). Tracks account portfolio health, credit exposure, ACV, and account lifecycle. Used by Sales leadership, Credit, and Key Account Management to manage the customer base."
  source: "`vibe_consumer_goods_v1`.`sales`.`trade_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the trade account (e.g. Active, Inactive, Suspended). Core dimension for portfolio health segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. Distributor, Retailer, Wholesaler). Enables go-to-market segmentation."
    - name: "account_tier"
      expr: account_tier
      comment: "Strategic tier of the account (e.g. Platinum, Gold, Silver). Used for key account prioritisation and resource allocation."
    - name: "trade_channel"
      expr: trade_channel
      comment: "Trade channel the account operates in (e.g. Modern Trade, Traditional Trade, eCommerce). Key dimension for channel strategy."
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country of the account headquarters. Enables geographic portfolio analysis."
    - name: "headquarters_state_province"
      expr: headquarters_state_province
      comment: "State or province of the account headquarters. Supports regional sales territory analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the trade account. Used by Finance and Credit teams to manage credit risk exposure."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code assigned to the account. Supports DSO and cash flow analysis by terms bucket."
    - name: "currency_code"
      expr: currency_code
      comment: "Primary transaction currency of the account. Required for multi-currency revenue and credit reporting."
    - name: "account_open_date"
      expr: account_open_date
      comment: "Date the account was opened. Used for cohort analysis and account tenure segmentation."
    - name: "last_order_date"
      expr: last_order_date
      comment: "Date of the most recent order from the account. Used to identify at-risk or lapsed accounts."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Indicates whether Vendor Managed Inventory is enabled for the account. Used to segment VMI vs. non-VMI account performance."
  measures:
    - name: "active_account_count"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN trade_account_id END)
      comment: "Count of active trade accounts. Core portfolio size KPI for Sales leadership and territory planning."
    - name: "total_account_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Total count of trade accounts in the portfolio. Used to track customer base size and growth."
    - name: "total_acv"
      expr: SUM(CAST(acv_total AS DOUBLE))
      comment: "Total Annual Contract Value across all trade accounts. Strategic revenue potential KPI for Sales and Finance planning."
    - name: "avg_acv_per_account"
      expr: AVG(CAST(acv_total AS DOUBLE))
      comment: "Average ACV per trade account. Indicates average account value and helps identify upsell opportunities."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all trade accounts. Measures total credit exposure for risk management."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per trade account. Used to benchmark credit policy and identify outliers."
    - name: "vmi_enabled_account_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN trade_account_id END)
      comment: "Count of accounts with VMI enabled. Tracks VMI programme adoption, which is linked to service level and inventory efficiency."
    - name: "vmi_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN trade_account_id END) / NULLIF(COUNT(DISTINCT trade_account_id), 0), 2)
      comment: "Percentage of trade accounts with VMI enabled. Strategic adoption KPI for supply chain collaboration programmes."
    - name: "inactive_account_count"
      expr: COUNT(DISTINCT CASE WHEN account_status != 'Active' THEN trade_account_id END)
      comment: "Count of non-active trade accounts. Used to track churn, dormancy, and re-activation opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_price_list_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing KPI view over price list line items. Tracks list price levels, margin percentages, promotional coverage, and pricing tier distribution. Used by Revenue Management, Trade Marketing, and Finance to govern pricing strategy."
  source: "`vibe_consumer_goods_v1`.`sales`.`price_list_item`"
  dimensions:
    - name: "price_list_item_status"
      expr: price_list_item_status
      comment: "Status of the price list item (e.g. Active, Expired, Pending). Used to filter effective pricing records."
    - name: "channel_type"
      expr: channel_type
      comment: "Sales channel the price applies to. Enables channel-specific pricing analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the price is targeted at. Supports segmented pricing strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price list item. Required for multi-currency pricing governance."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel for the price. Enables channel-level pricing mix analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the price (e.g. National, Regional). Supports geographic pricing strategy review."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Indicates whether the price is promotional. Used to segment base vs. promotional pricing."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date from which the price is effective. Used for price validity and change tracking."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Date until which the price is effective. Used to identify expiring prices requiring renewal."
    - name: "condition_type"
      expr: condition_type
      comment: "Pricing condition type (e.g. Base Price, Surcharge, Discount). Enables pricing waterfall analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price list item. Tracks governance compliance in the pricing process."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organisation the price applies to. Enables organisational pricing governance."
  measures:
    - name: "price_list_item_count"
      expr: COUNT(DISTINCT price_list_item_id)
      comment: "Count of distinct price list items. Measures the breadth of the active pricing catalogue."
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price across items. Tracks overall price level trends and supports price benchmarking."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit selling price. Measures realised price levels vs. list price to identify discount patterns."
    - name: "avg_margin_percentage"
      expr: AVG(CAST(margin_percentage AS DOUBLE))
      comment: "Average margin percentage across price list items. Core pricing profitability KPI for Revenue Management."
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average cost price across items. Used to assess cost-to-price relationships and margin floor management."
    - name: "avg_msrp_price"
      expr: AVG(CAST(msrp_price AS DOUBLE))
      comment: "Average Manufacturer Suggested Retail Price. Used to benchmark list prices against MSRP and assess channel pricing compliance."
    - name: "promotional_item_count"
      expr: COUNT(DISTINCT CASE WHEN promotional_flag = TRUE THEN price_list_item_id END)
      comment: "Count of promotional price list items. Tracks promotional pricing coverage across the catalogue."
    - name: "promotional_coverage_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN promotional_flag = TRUE THEN price_list_item_id END) / NULLIF(COUNT(DISTINCT price_list_item_id), 0), 2)
      comment: "Percentage of price list items that are promotional. Measures promotional intensity in the pricing catalogue."
    - name: "avg_price_to_cost_ratio"
      expr: ROUND(AVG(CAST(unit_price AS DOUBLE)) / NULLIF(AVG(CAST(cost_price AS DOUBLE)), 0), 4)
      comment: "Ratio of average unit price to average cost price. Compound KPI measuring pricing power and margin headroom."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_pricing_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over customer pricing agreements and contracts. Tracks contracted pricing, discount levels, rebate commitments, and agreement lifecycle. Used by Revenue Management, Key Account Management, and Finance to govern contractual pricing."
  source: "`vibe_consumer_goods_v1`.`sales`.`pricing_agreement`"
  dimensions:
    - name: "pricing_agreement_status"
      expr: pricing_agreement_status
      comment: "Current status of the pricing agreement (e.g. Active, Expired, Pending). Core dimension for agreement portfolio management."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of pricing agreement (e.g. Annual Contract, Spot, Promotional). Enables agreement mix analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the agreement. Tracks governance compliance in the contracting process."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing agreement. Required for multi-currency contract value reporting."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel covered by the agreement. Enables channel-level contract analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the agreement. Supports regional pricing governance."
    - name: "pricing_tier"
      expr: pricing_tier
      comment: "Pricing tier assigned to the agreement. Used to segment accounts by contracted price level."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the pricing agreement. Used for contract lifecycle and renewal tracking."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the pricing agreement. Used to identify agreements approaching expiry."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews. Used to manage contract renewal pipeline."
    - name: "price_protection_flag"
      expr: price_protection_flag
      comment: "Indicates whether price protection is in effect. Tracks price protection exposure for Finance."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organisation responsible for the agreement. Enables organisational contract portfolio analysis."
  measures:
    - name: "active_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN pricing_agreement_status = 'Active' THEN pricing_agreement_id END)
      comment: "Count of active pricing agreements. Measures the size of the contracted customer base."
    - name: "total_agreement_count"
      expr: COUNT(DISTINCT pricing_agreement_id)
      comment: "Total count of pricing agreements. Tracks overall contracting activity and portfolio breadth."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across pricing agreements. Measures contracted discount depth and pricing discipline."
    - name: "avg_contracted_net_price"
      expr: AVG(CAST(contracted_net_price AS DOUBLE))
      comment: "Average contracted net price across agreements. Tracks realised price levels under contract."
    - name: "total_rebate_amount"
      expr: SUM(CAST(rebate_amount AS DOUBLE))
      comment: "Total rebate commitments across pricing agreements. Measures total rebate liability for Finance accrual and planning."
    - name: "avg_rebate_percentage"
      expr: AVG(CAST(rebate_percentage AS DOUBLE))
      comment: "Average rebate percentage across agreements. Tracks rebate intensity and its impact on net revenue."
    - name: "total_promotional_allowance"
      expr: SUM(CAST(promotional_allowance AS DOUBLE))
      comment: "Total promotional allowances committed in pricing agreements. Measures trade spend commitments for Trade Marketing."
    - name: "avg_minimum_order_value"
      expr: AVG(CAST(minimum_order_value AS DOUBLE))
      comment: "Average minimum order value threshold across agreements. Used to assess order size commitments and compliance."
    - name: "price_protected_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN price_protection_flag = TRUE THEN pricing_agreement_id END)
      comment: "Count of agreements with price protection active. Tracks price protection exposure and associated financial risk."
    - name: "auto_renewal_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN pricing_agreement_id END)
      comment: "Count of agreements set to auto-renew. Used to manage contract renewal pipeline and revenue continuity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_retail_store`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI view over retail store locations. Tracks store portfolio health, OSA and OTIF targets, ACV weights, and VMI adoption. Used by Field Sales, Trade Marketing, and Supply Chain to manage retail execution and store-level performance."
  source: "`vibe_consumer_goods_v1`.`sales`.`retail_store`"
  dimensions:
    - name: "retail_store_status"
      expr: retail_store_status
      comment: "Current operational status of the retail store. Core dimension for active store portfolio analysis."
    - name: "store_format"
      expr: store_format
      comment: "Format of the retail store (e.g. Hypermarket, Supermarket, Convenience). Enables format-level performance benchmarking."
    - name: "store_tier"
      expr: store_tier
      comment: "Strategic tier of the store (e.g. A, B, C). Used for resource allocation and visit frequency planning."
    - name: "banner_name"
      expr: banner_name
      comment: "Retail banner or chain name. Enables banner-level performance analysis for Key Account Management."
    - name: "trading_area"
      expr: trading_area
      comment: "Geographic trading area of the store. Supports regional retail execution analysis."
    - name: "planogram_zone"
      expr: planogram_zone
      comment: "Planogram zone assigned to the store. Used for shelf space and merchandising compliance analysis."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Indicates whether VMI is enabled for the store. Used to segment VMI vs. non-VMI store performance."
    - name: "dsd_route_code"
      expr: dsd_route_code
      comment: "Direct Store Delivery route code. Used for DSD route planning and coverage analysis."
    - name: "open_date"
      expr: open_date
      comment: "Date the store opened. Used for store cohort analysis and new store ramp-up tracking."
    - name: "last_visit_date"
      expr: last_visit_date
      comment: "Date of the last field sales visit. Used to track visit frequency compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for store-level financial reporting."
  measures:
    - name: "active_store_count"
      expr: COUNT(DISTINCT CASE WHEN retail_store_status = 'Active' THEN retail_store_id END)
      comment: "Count of active retail stores. Core portfolio size KPI for Field Sales and Trade Marketing."
    - name: "total_store_count"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Total count of retail stores in the portfolio. Tracks distribution footprint size."
    - name: "total_acv_weight"
      expr: SUM(CAST(acv_weight AS DOUBLE))
      comment: "Total All Commodity Volume weight across stores. Measures weighted distribution coverage, a key retail execution KPI."
    - name: "avg_osa_target_pct"
      expr: AVG(CAST(osa_target_pct AS DOUBLE))
      comment: "Average On-Shelf Availability target percentage across stores. Tracks retail execution quality commitments."
    - name: "avg_otif_sla_target_pct"
      expr: AVG(CAST(otif_sla_target_pct AS DOUBLE))
      comment: "Average OTIF SLA target percentage across stores. Measures supply chain service level commitments to retail partners."
    - name: "total_tdp_weight"
      expr: SUM(CAST(tdp_weight AS DOUBLE))
      comment: "Total Total Distribution Points weight across stores. Measures product distribution breadth and shelf presence."
    - name: "vmi_enabled_store_count"
      expr: COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN retail_store_id END)
      comment: "Count of stores with VMI enabled. Tracks VMI programme adoption across the retail network."
    - name: "vmi_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN vmi_enabled_flag = TRUE THEN retail_store_id END) / NULLIF(COUNT(DISTINCT retail_store_id), 0), 2)
      comment: "Percentage of stores with VMI enabled. Strategic adoption KPI for supply chain collaboration and inventory efficiency."
$$;