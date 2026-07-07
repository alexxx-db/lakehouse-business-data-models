-- Metric views for domain: consumer | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-27 07:41:37

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_shopper`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the shopper master entity — acquisition health, lifecycle distribution, consent posture, and lifetime value. Used by CMO, CX, and Data Governance teams to steer acquisition investment, retention programmes, and regulatory compliance."
  source: "`vibe_consumer_goods_v1`.`consumer`.`shopper`"
  dimensions:
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the shopper was acquired (e.g. web, store, social). Enables channel-level ROI analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the shopper (e.g. active, lapsed, churned). Drives retention segmentation."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty programme tier of the shopper. Used to stratify value-based KPIs."
    - name: "consumer_type"
      expr: consumer_type
      comment: "Classification of the shopper (e.g. individual, business). Supports B2C vs B2B analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the shopper. Enables geographic performance breakdowns."
    - name: "gender"
      expr: gender
      comment: "Self-reported gender of the shopper. Used for demographic segmentation."
    - name: "shopper_status"
      expr: shopper_status
      comment: "Operational status of the shopper record (e.g. active, inactive, suspended)."
    - name: "acquisition_year_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of shopper acquisition. Enables cohort and trend analysis."
    - name: "first_purchase_year_month"
      expr: DATE_TRUNC('MONTH', first_purchase_date)
      comment: "Month of first purchase. Used to measure time-to-first-purchase and conversion velocity."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the shopper has opted in to marketing communications. Critical for consent-based campaign targeting."
    - name: "email_opt_in"
      expr: email_opt_in
      comment: "Whether the shopper has opted in to email communications."
    - name: "gdpr_subject"
      expr: gdpr_subject
      comment: "Whether the shopper is subject to GDPR. Required for regulatory reporting."
  measures:
    - name: "total_active_shoppers"
      expr: COUNT(CASE WHEN is_active = TRUE THEN shopper_id END)
      comment: "Count of shoppers with active status. Core audience-size KPI used in reach and penetration reporting."
    - name: "total_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Total unique shoppers in the platform. Baseline for all per-shopper ratio metrics."
    - name: "total_lifetime_value"
      expr: SUM(CAST(lifetime_value AS DOUBLE))
      comment: "Sum of lifetime value across all shoppers. Indicates total monetisable consumer asset value."
    - name: "avg_lifetime_value"
      expr: AVG(CAST(lifetime_value AS DOUBLE))
      comment: "Average lifetime value per shopper. Key metric for acquisition cost benchmarking and segment valuation."
    - name: "total_loyalty_points_balance"
      expr: SUM(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Total outstanding loyalty points balance across all shoppers. Represents programme liability and engagement depth."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in = TRUE THEN shopper_id END) / NULLIF(COUNT(shopper_id), 0), 2)
      comment: "Percentage of shoppers opted in to marketing. Governs addressable audience size for campaigns."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_opt_in = TRUE THEN shopper_id END) / NULLIF(COUNT(shopper_id), 0), 2)
      comment: "Percentage of shoppers opted in to email. Directly constrains email campaign reach."
    - name: "identity_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN identity_verified = TRUE THEN shopper_id END) / NULLIF(COUNT(shopper_id), 0), 2)
      comment: "Percentage of shoppers with verified identity. Indicates data quality and fraud-risk posture."
    - name: "loyalty_enrolled_shoppers"
      expr: COUNT(CASE WHEN loyalty_enrollment_date IS NOT NULL THEN shopper_id END)
      comment: "Count of shoppers enrolled in the loyalty programme. Measures programme penetration."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_dtc_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct-to-consumer order performance metrics covering revenue, fulfilment efficiency, returns, and channel mix. Primary dashboard for DTC General Manager, VP eCommerce, and CFO revenue reporting."
  source: "`vibe_consumer_goods_v1`.`consumer`.`dtc_order`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Sales channel of the DTC order (e.g. web, mobile app, social commerce). Enables channel-level revenue attribution."
    - name: "channel_code"
      expr: channel_code
      comment: "Coded version of the sales channel. Used for system-level channel segmentation."
    - name: "dtc_order_status"
      expr: dtc_order_status
      comment: "Current status of the DTC order (e.g. placed, shipped, delivered, cancelled). Drives fulfilment funnel analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfilment status of the order. Used to identify fulfilment bottlenecks."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. credit card, PayPal, BNPL). Informs payment mix and risk analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment (e.g. paid, pending, failed). Critical for revenue recognition and cash flow."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order. Required for multi-currency revenue reporting."
    - name: "ip_country_code"
      expr: ip_country_code
      comment: "Country inferred from the shopper IP at order time. Enables geographic demand analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device used to place the order (e.g. mobile, desktop, tablet). Informs UX investment decisions."
    - name: "order_year_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the order was placed. Enables monthly revenue trend and seasonality analysis."
    - name: "subscription_order_flag"
      expr: subscription_order_flag
      comment: "Whether the order originated from a subscription. Distinguishes recurring vs one-time revenue."
    - name: "gift_order_flag"
      expr: gift_order_flag
      comment: "Whether the order is a gift. Used for gifting programme analysis."
    - name: "return_flag"
      expr: return_flag
      comment: "Whether the order has been returned. Drives return rate and reverse logistics KPIs."
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country for the shipment. Enables international shipping performance analysis."
  measures:
    - name: "total_orders"
      expr: COUNT(DISTINCT dtc_order_id)
      comment: "Total number of distinct DTC orders placed. Baseline volume KPI for the DTC channel."
    - name: "total_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue from DTC orders. Primary top-line revenue KPI for the DTC business."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of order subtotals before tax and shipping. Used to isolate product revenue from fulfilment charges."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across DTC orders. Measures promotional spend and margin erosion."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on DTC orders. Required for tax compliance and remittance reporting."
    - name: "total_shipping_amount"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping revenue collected. Used to assess shipping cost recovery."
    - name: "avg_order_value"
      expr: ROUND(SUM(CAST(total_amount AS DOUBLE)) / NULLIF(COUNT(DISTINCT dtc_order_id), 0), 2)
      comment: "Average order value (AOV). Core DTC efficiency KPI — rising AOV indicates upsell/cross-sell effectiveness."
    - name: "return_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN return_flag = TRUE THEN dtc_order_id END) / NULLIF(COUNT(DISTINCT dtc_order_id), 0), 2)
      comment: "Percentage of orders that were returned. High return rates signal product-fit or quality issues."
    - name: "subscription_order_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN subscription_order_flag = TRUE THEN dtc_order_id END) / NULLIF(COUNT(DISTINCT dtc_order_id), 0), 2)
      comment: "Percentage of orders originating from subscriptions. Measures recurring revenue penetration in DTC."
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Tracks promotional intensity and margin risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_dtc_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level DTC order metrics enabling SKU-level revenue, margin, returns, and discount analysis. Used by Merchandising, Category Management, and Finance for product P&L and assortment decisions."
  source: "`vibe_consumer_goods_v1`.`consumer`.`dtc_order_line`"
  dimensions:
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category of the line item. Enables category-level revenue and margin analysis."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the line item. Supports brand-level P&L reporting."
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel for the line item. Enables channel-level product performance analysis."
    - name: "dtc_order_line_status"
      expr: dtc_order_line_status
      comment: "Status of the order line (e.g. fulfilled, cancelled, returned). Drives line-level fulfilment KPIs."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfilment status of the line. Used to identify SKU-level fulfilment issues."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item. Required for multi-currency product revenue reporting."
    - name: "subscription_flag"
      expr: subscription_flag
      comment: "Whether the line item is part of a subscription order. Distinguishes recurring vs one-time product demand."
    - name: "is_returned"
      expr: is_returned
      comment: "Whether the line item was returned. Drives SKU-level return rate analysis."
    - name: "gift_flag"
      expr: gift_flag
      comment: "Whether the line item is a gift. Used for gifting programme product analysis."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Whether the line item contains hazardous materials. Required for regulatory and logistics compliance."
    - name: "actual_ship_year_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Month the line item was shipped. Enables monthly shipment volume and revenue trend analysis."
    - name: "promotion_code"
      expr: promotion_code
      comment: "Promotion applied to the line item. Enables promotion-level ROI and discount analysis."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue from DTC order lines. SKU-level top-line revenue KPI."
    - name: "total_line_net_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Total net revenue after discounts at line level. Used for net revenue and margin analysis."
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total COGS across DTC order lines. Required for gross margin calculation."
    - name: "total_line_discount_amount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discount value applied at line level. Measures promotional spend by SKU and category."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units ordered across DTC order lines. Core demand volume metric for supply planning."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per unit. Tracks pricing effectiveness and mix shift."
    - name: "gross_margin_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE) - CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Gross margin in absolute terms (net revenue minus COGS). Primary product profitability KPI."
    - name: "line_return_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_returned = TRUE THEN dtc_order_line_id END) / NULLIF(COUNT(DISTINCT dtc_order_line_id), 0), 2)
      comment: "Percentage of order lines returned. High rates by SKU/category signal quality or expectation-gap issues."
    - name: "avg_line_discount_pct"
      expr: AVG(CAST(line_discount_pct AS DOUBLE))
      comment: "Average discount percentage applied at line level. Tracks promotional depth by product and channel."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at line level. Required for tax compliance and product-level tax reporting."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_loyalty_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty programme health metrics covering enrolment, tier distribution, points liability, and engagement. Used by Loyalty Programme Manager, CMO, and Finance to manage programme economics and member engagement."
  source: "`vibe_consumer_goods_v1`.`consumer`.`loyalty_account`"
  dimensions:
    - name: "membership_tier"
      expr: membership_tier
      comment: "Current membership tier of the loyalty account (e.g. Bronze, Silver, Gold, Platinum). Enables tier-level KPI stratification."
    - name: "account_status"
      expr: account_status
      comment: "Operational status of the loyalty account (e.g. active, suspended, closed). Drives active member counts."
    - name: "loyalty_account_status"
      expr: loyalty_account_status
      comment: "Programme-specific status of the loyalty account. Used for programme health monitoring."
    - name: "account_type"
      expr: account_type
      comment: "Type of loyalty account (e.g. standard, premium, employee). Supports account-type segmentation."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (e.g. web, store, app). Measures enrolment channel effectiveness."
    - name: "country_code"
      expr: country_code
      comment: "Country of the loyalty account. Enables geographic programme performance analysis."
    - name: "cltv_segment"
      expr: cltv_segment
      comment: "Customer lifetime value segment assigned to the account. Drives value-based programme investment decisions."
    - name: "enrollment_year_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of loyalty programme enrolment. Enables enrolment cohort and growth trend analysis."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the account has been flagged for fraud. Required for programme integrity monitoring."
    - name: "consent_marketing"
      expr: consent_marketing
      comment: "Whether the member has consented to marketing. Governs addressable loyalty audience."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'active' THEN loyalty_account_id END)
      comment: "Count of active loyalty accounts. Core programme size KPI."
    - name: "total_points_balance"
      expr: SUM(CAST(points_balance AS DOUBLE))
      comment: "Total outstanding points balance across all accounts. Represents programme financial liability."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total points ever earned across all accounts. Measures cumulative programme engagement and earn activity."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Total points ever redeemed across all accounts. Measures redemption activity and programme value delivery."
    - name: "total_lifetime_points_expired"
      expr: SUM(CAST(lifetime_points_expired AS DOUBLE))
      comment: "Total points expired across all accounts. High expiry rates indicate low engagement or poor programme design."
    - name: "redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of earned points that have been redeemed. Key programme health indicator — low rates signal disengagement."
    - name: "points_expiry_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_expired AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of earned points that have expired. High rates indicate member disengagement or poor programme UX."
    - name: "total_tier_qualification_spend"
      expr: SUM(CAST(tier_qualification_spend AS DOUBLE))
      comment: "Total qualifying spend used for tier assessment. Measures revenue contribution from loyalty members."
    - name: "avg_points_balance"
      expr: AVG(CAST(points_balance AS DOUBLE))
      comment: "Average points balance per loyalty account. Indicates typical member engagement level."
    - name: "fraud_flagged_account_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN loyalty_account_id END) / NULLIF(COUNT(DISTINCT loyalty_account_id), 0), 2)
      comment: "Percentage of loyalty accounts flagged for fraud. Critical for programme integrity and financial risk management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_loyalty_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty transaction-level metrics covering earn, redemption, monetary value, and fraud. Used by Loyalty Operations, Finance, and Fraud teams to monitor programme economics and transaction integrity."
  source: "`vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of loyalty transaction (e.g. earn, redeem, adjust, expire). Primary dimension for transaction-type analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the loyalty transaction (e.g. posted, pending, reversed). Drives valid transaction filtering."
    - name: "loyalty_transaction_status"
      expr: loyalty_transaction_status
      comment: "Programme-specific status of the transaction. Used for operational monitoring."
    - name: "channel"
      expr: channel
      comment: "Channel through which the transaction was triggered (e.g. store, web, app). Enables channel-level earn/redeem analysis."
    - name: "points_direction"
      expr: points_direction
      comment: "Direction of points movement (credit/debit). Used to separate earn from redemption flows."
    - name: "country_code"
      expr: country_code
      comment: "Country of the transaction. Enables geographic programme economics analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the monetary value. Required for multi-currency financial reporting."
    - name: "is_bonus_transaction"
      expr: is_bonus_transaction
      comment: "Whether the transaction is a bonus earn event. Used to measure bonus programme cost."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether the transaction has been flagged for fraud. Required for programme integrity monitoring."
    - name: "transaction_year_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the loyalty transaction. Enables monthly earn/redeem trend analysis."
    - name: "trigger_event"
      expr: trigger_event
      comment: "Business event that triggered the transaction (e.g. purchase, referral, birthday). Measures earn trigger effectiveness."
    - name: "program_year"
      expr: program_year
      comment: "Programme year of the transaction. Supports annual programme performance comparison."
  measures:
    - name: "total_transactions"
      expr: COUNT(DISTINCT loyalty_transaction_id)
      comment: "Total number of loyalty transactions. Baseline activity volume KPI."
    - name: "total_points_transacted"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Total points moved across all transactions. Measures overall programme activity volume."
    - name: "total_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value associated with loyalty transactions. Measures financial scale of programme activity."
    - name: "total_qualifying_spend"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Total qualifying spend that triggered loyalty earn events. Measures revenue driven through the loyalty programme."
    - name: "total_redemption_value"
      expr: SUM(CAST(redemption_value AS DOUBLE))
      comment: "Total monetary value of points redeemed. Represents programme cost and member value delivery."
    - name: "avg_earn_rate"
      expr: AVG(CAST(earn_rate AS DOUBLE))
      comment: "Average earn rate across transactions. Tracks programme generosity and cost per dollar spent."
    - name: "avg_bonus_multiplier"
      expr: AVG(CAST(bonus_multiplier AS DOUBLE))
      comment: "Average bonus multiplier applied. Measures promotional earn intensity and associated programme cost."
    - name: "fraud_transaction_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN loyalty_transaction_id END) / NULLIF(COUNT(DISTINCT loyalty_transaction_id), 0), 2)
      comment: "Percentage of loyalty transactions flagged as fraudulent. Critical risk KPI for programme integrity."
    - name: "avg_points_per_transaction"
      expr: ROUND(SUM(CAST(points_amount AS DOUBLE)) / NULLIF(COUNT(DISTINCT loyalty_transaction_id), 0), 2)
      comment: "Average points per transaction. Measures earn density and programme engagement depth."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription programme metrics covering active subscriber base, recurring revenue, churn, trial conversion, and pause behaviour. Used by Subscription GM, CFO, and Product teams to manage recurring revenue growth."
  source: "`vibe_consumer_goods_v1`.`consumer`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (e.g. active, paused, cancelled, trial). Primary dimension for subscriber funnel analysis."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (e.g. replenishment, curated box, membership). Enables product-type revenue analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cadence (e.g. monthly, quarterly, annual). Drives recurring revenue forecasting."
    - name: "delivery_frequency"
      expr: delivery_frequency
      comment: "Delivery cadence of the subscription. Used for supply planning and logistics scheduling."
    - name: "channel"
      expr: channel
      comment: "Acquisition channel for the subscription. Enables channel-level subscriber acquisition analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subscription. Required for multi-currency MRR reporting."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type (e.g. credit card, bank transfer). Informs payment failure risk analysis."
    - name: "trial_flag"
      expr: trial_flag
      comment: "Whether the subscription is in a trial period. Used to measure trial-to-paid conversion."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the subscription auto-renews. High auto-renew rates indicate strong retention."
    - name: "pause_flag"
      expr: pause_flag
      comment: "Whether the subscription is currently paused. Paused subscribers are at churn risk."
    - name: "acquisition_source"
      expr: acquisition_source
      comment: "Source that drove the subscription acquisition. Enables acquisition channel ROI analysis."
    - name: "start_year_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the subscription started. Enables cohort-based retention and churn analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for subscription cancellation. Drives product and service improvement decisions."
  measures:
    - name: "total_active_subscriptions"
      expr: COUNT(CASE WHEN subscription_status = 'active' THEN subscription_id END)
      comment: "Count of currently active subscriptions. Core subscriber base KPI for recurring revenue forecasting."
    - name: "total_subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Total subscriptions ever created. Baseline for conversion and churn rate calculations."
    - name: "total_recurring_amount"
      expr: SUM(CAST(recurring_amount AS DOUBLE))
      comment: "Total recurring revenue amount across active subscriptions. Proxy for Monthly/Annual Recurring Revenue (MRR/ARR)."
    - name: "avg_price_per_cycle"
      expr: AVG(CAST(price_per_cycle AS DOUBLE))
      comment: "Average price per billing cycle. Tracks ARPU (Average Revenue Per User) for the subscription business."
    - name: "total_net_price"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net price across subscriptions after discounts. Used for net recurring revenue reporting."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_pct AS DOUBLE))
      comment: "Average discount percentage applied to subscriptions. Tracks promotional depth and margin impact."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN subscription_status = 'cancelled' THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions that have been cancelled. Core churn KPI for subscription business health."
    - name: "trial_conversion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN trial_flag = FALSE AND subscription_status = 'active' THEN subscription_id END) / NULLIF(COUNT(CASE WHEN trial_flag = TRUE THEN subscription_id END), 0), 2)
      comment: "Percentage of trial subscriptions that converted to paid active status. Critical growth KPI for subscription acquisition."
    - name: "pause_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pause_flag = TRUE THEN subscription_id END) / NULLIF(COUNT(CASE WHEN subscription_status = 'active' OR pause_flag = TRUE THEN subscription_id END), 0), 2)
      comment: "Percentage of active/paused subscriptions currently paused. High pause rates are a leading indicator of churn."
    - name: "auto_renew_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renew_flag = TRUE THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions with auto-renew enabled. High rates indicate strong retention and predictable revenue."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consent management metrics covering opt-in rates, consent type distribution, double opt-in compliance, and withdrawal trends. Used by Data Privacy Officer, Legal, and Marketing Compliance teams for GDPR/CCPA governance."
  source: "`vibe_consumer_goods_v1`.`consumer`.`consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent captured (e.g. marketing, data sharing, profiling). Primary dimension for consent coverage analysis."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g. given, withdrawn, expired). Drives active consent counts."
    - name: "consent_record_status"
      expr: consent_record_status
      comment: "Operational status of the consent record. Used for data quality and completeness monitoring."
    - name: "channel"
      expr: channel
      comment: "Channel through which consent was captured (e.g. web, store, email). Enables channel-level consent analysis."
    - name: "capture_method"
      expr: capture_method
      comment: "Method used to capture consent (e.g. checkbox, signature, verbal). Required for consent validity auditing."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for processing (e.g. consent, legitimate interest, contract). Critical for GDPR compliance reporting."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the consent (e.g. EU, CA, UK). Enables jurisdiction-level compliance reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country of the consent record. Required for geographic regulatory compliance analysis."
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of the consent (e.g. email, SMS, all channels). Drives channel-specific addressable audience sizing."
    - name: "consent_year_month"
      expr: DATE_TRUNC('MONTH', consent_date)
      comment: "Month consent was captured. Enables consent volume trend and regulatory deadline tracking."
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Whether double opt-in was completed. Required for email marketing compliance in certain jurisdictions."
    - name: "parental_consent_flag"
      expr: parental_consent_flag
      comment: "Whether parental consent was obtained. Required for COPPA and minor-protection compliance."
    - name: "third_party_sharing_flag"
      expr: third_party_sharing_flag
      comment: "Whether consent covers third-party data sharing. Critical for data partnership and monetisation compliance."
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total consent records captured. Baseline volume KPI for consent programme coverage."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN consent_given = TRUE AND consent_status = 'active' THEN consent_record_id END)
      comment: "Count of currently active, given consent records. Defines the legally addressable audience for marketing."
    - name: "consent_given_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_given = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records where consent was given. Core compliance KPI — low rates restrict marketing reach."
    - name: "double_opt_in_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN double_opt_in_flag = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records with double opt-in completed. Required for email compliance in GDPR jurisdictions."
    - name: "withdrawal_count"
      expr: COUNT(CASE WHEN withdrawal_timestamp IS NOT NULL THEN consent_record_id END)
      comment: "Count of consent withdrawals. Rising withdrawals signal brand trust issues or regulatory pressure."
    - name: "withdrawal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN withdrawal_timestamp IS NOT NULL THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records that have been withdrawn. Key indicator of consumer trust and regulatory risk."
    - name: "re_consent_required_count"
      expr: COUNT(CASE WHEN re_consent_required_flag = TRUE THEN consent_record_id END)
      comment: "Count of consent records requiring re-consent. Drives re-consent campaign prioritisation and regulatory deadline management."
    - name: "third_party_sharing_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN third_party_sharing_flag = TRUE AND consent_given = TRUE THEN consent_record_id END) / NULLIF(COUNT(CASE WHEN consent_given = TRUE THEN consent_record_id END), 0), 2)
      comment: "Percentage of given consents that include third-party sharing. Governs data monetisation and partnership programme scope."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household-level consumer metrics covering loyalty penetration, digital engagement, income segmentation, and NPS. Used by Consumer Insights, Category Management, and Retail Strategy teams for household-level targeting and investment decisions."
  source: "`vibe_consumer_goods_v1`.`consumer`.`household`"
  dimensions:
    - name: "household_status"
      expr: household_status
      comment: "Operational status of the household record (e.g. active, dissolved, merged). Drives active household counts."
    - name: "household_type"
      expr: household_type
      comment: "Type of household (e.g. single, family, multi-generational). Enables household-type segmentation."
    - name: "income_band"
      expr: income_band
      comment: "Income band of the household. Drives value-based targeting and assortment decisions."
    - name: "income_bracket"
      expr: income_bracket
      comment: "Finer income bracket classification. Used for precision targeting and pricing strategy."
    - name: "life_stage"
      expr: life_stage
      comment: "Life stage of the household (e.g. young family, empty nester, retiree). Enables life-stage marketing."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the household in the brand relationship. Drives retention and win-back strategies."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the household. Enables tier-based household value analysis."
    - name: "cltv_band"
      expr: cltv_band
      comment: "Customer lifetime value band of the household. Primary dimension for value-based investment decisions."
    - name: "country_code"
      expr: country_code
      comment: "Country of the household. Enables geographic market analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the household. Supports regional performance and investment analysis."
    - name: "dwelling_type"
      expr: dwelling_type
      comment: "Type of dwelling (e.g. house, apartment, condo). Used for channel and format targeting."
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary shopping channel of the household. Drives channel investment and omnichannel strategy."
    - name: "has_children"
      expr: has_children
      comment: "Whether the household has children. Key demographic dimension for family-oriented product targeting."
    - name: "formation_year_month"
      expr: DATE_TRUNC('MONTH', formation_date)
      comment: "Month the household was formed/identified. Enables household acquisition cohort analysis."
  measures:
    - name: "total_active_households"
      expr: COUNT(CASE WHEN household_status = 'active' THEN household_id END)
      comment: "Count of active households. Core audience size KPI for household-level marketing and targeting."
    - name: "total_households"
      expr: COUNT(DISTINCT household_id)
      comment: "Total unique households in the platform. Baseline for penetration and reach calculations."
    - name: "total_loyalty_points_balance"
      expr: SUM(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Total loyalty points balance across households. Measures household-level programme engagement and liability."
    - name: "avg_loyalty_points_balance"
      expr: AVG(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Average loyalty points balance per household. Indicates typical household engagement level."
    - name: "loyalty_enrolled_household_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN loyalty_enrollment_date IS NOT NULL THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households enrolled in the loyalty programme. Measures loyalty programme penetration across the consumer base."
    - name: "digital_engagement_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN digital_engagement_flag = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households with digital engagement. Measures digital channel adoption and omnichannel reach."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in_flag = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households opted in to marketing. Governs addressable household audience for campaigns."
    - name: "private_label_buyer_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN private_label_buyer_flag = TRUE THEN household_id END) / NULLIF(COUNT(DISTINCT household_id), 0), 2)
      comment: "Percentage of households that purchase private label products. Measures private label penetration and brand loyalty."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer segment definition metrics covering segment size, CLTV thresholds, ML model coverage, and activation eligibility. Used by Consumer Insights, Marketing Strategy, and Data Science teams to govern segment quality and activation readiness."
  source: "`vibe_consumer_goods_v1`.`consumer`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (e.g. behavioural, demographic, predictive). Enables segment-type portfolio analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Operational status of the segment (e.g. active, draft, archived). Drives active segment inventory management."
    - name: "activation_channel"
      expr: activation_channel
      comment: "Channel through which the segment is activated (e.g. email, paid media, push). Enables channel-level segment activation analysis."
    - name: "owning_business_unit"
      expr: owning_business_unit
      comment: "Business unit that owns the segment. Supports segment governance and accountability."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment. Enables regional segment coverage analysis."
    - name: "loyalty_tier_scope"
      expr: loyalty_tier_scope
      comment: "Loyalty tier scope of the segment. Used to understand tier-based targeting coverage."
    - name: "is_active"
      expr: is_active
      comment: "Whether the segment is currently active. Primary filter for active segment inventory."
    - name: "personalization_eligible"
      expr: personalization_eligible
      comment: "Whether the segment is eligible for personalisation. Governs personalisation programme reach."
    - name: "trade_promotion_eligible"
      expr: trade_promotion_eligible
      comment: "Whether the segment is eligible for trade promotions. Drives trade promotion targeting decisions."
    - name: "consent_required"
      expr: consent_required
      comment: "Whether consent is required to activate this segment. Critical for compliance-gated activation."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How frequently the segment membership is refreshed. Indicates segment data freshness and operational cost."
    - name: "ml_model_code"
      expr: ml_model_code
      comment: "ML model used to define the segment. Enables model-level segment performance tracking."
  measures:
    - name: "total_active_segments"
      expr: COUNT(CASE WHEN is_active = TRUE THEN segment_id END)
      comment: "Count of currently active segments. Measures the active segment portfolio available for marketing activation."
    - name: "total_target_audience_size"
      expr: SUM(CAST(target_audience_size AS DOUBLE))
      comment: "Total target audience size across all segments. Measures total addressable audience across the segment portfolio."
    - name: "avg_target_audience_size"
      expr: AVG(CAST(target_audience_size AS DOUBLE))
      comment: "Average audience size per segment. Indicates typical segment scale for campaign planning."
    - name: "avg_cltv_min_value"
      expr: AVG(CAST(cltv_min_value AS DOUBLE))
      comment: "Average minimum CLTV threshold across segments. Indicates the value floor of the segment portfolio."
    - name: "avg_cltv_max_value"
      expr: AVG(CAST(cltv_max_value AS DOUBLE))
      comment: "Average maximum CLTV threshold across segments. Indicates the value ceiling of the segment portfolio."
    - name: "personalization_eligible_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN personalization_eligible = TRUE THEN segment_id END) / NULLIF(COUNT(DISTINCT segment_id), 0), 2)
      comment: "Percentage of segments eligible for personalisation. Measures personalisation programme coverage across the segment portfolio."
    - name: "consent_required_segment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_required = TRUE THEN segment_id END) / NULLIF(COUNT(DISTINCT segment_id), 0), 2)
      comment: "Percentage of segments requiring consent for activation. Indicates compliance complexity of the segment portfolio."
    - name: "avg_min_confidence_score"
      expr: AVG(CAST(min_confidence_score AS DOUBLE))
      comment: "Average minimum confidence score threshold across ML-driven segments. Measures model quality standards applied to the segment portfolio."
$$;