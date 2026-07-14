-- Metric views for domain: ecommerce | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_web_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Session-level engagement and conversion metrics for the e-commerce platform. Tracks traffic quality, bounce behavior, checkout initiation, and order placement rates to steer acquisition and UX investment decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`web_session`"
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront performance comparison."
    - name: "device_type"
      expr: device_type
      comment: "Device category (desktop, mobile, tablet) used during the session — critical for device-mix and responsive-design decisions."
    - name: "visitor_type"
      expr: visitor_type
      comment: "New vs. returning visitor classification — used to segment acquisition vs. retention traffic."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "ISO country code of the session origin — supports geographic performance analysis."
    - name: "referral_source"
      expr: referral_source
      comment: "Traffic referral source (organic, paid, email, direct) — used for channel attribution analysis."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign tag — links sessions to specific marketing campaigns for ROI measurement."
    - name: "utm_medium"
      expr: utm_medium
      comment: "UTM medium tag — classifies the marketing medium driving traffic."
    - name: "session_date"
      expr: DATE_TRUNC('day', session_start_timestamp)
      comment: "Session start date truncated to day — enables daily trend analysis."
    - name: "session_week"
      expr: DATE_TRUNC('week', session_start_timestamp)
      comment: "Session start date truncated to week — supports weekly traffic and conversion trend reporting."
    - name: "session_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Session start date truncated to month — supports monthly performance reviews."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment mode selected during the session (ship-to-home, BOPIS, etc.) — informs fulfillment capacity planning."
    - name: "session_status"
      expr: session_status
      comment: "Current status of the session (active, expired, completed) — used to filter valid sessions."
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of web sessions. Baseline traffic volume metric used in all conversion funnel calculations."
    - name: "unique_visitors"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct authenticated customer profiles with sessions. Measures reach of the e-commerce platform among known customers."
    - name: "bounce_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_bounce = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that ended without meaningful engagement. High bounce rate signals landing page or targeting quality issues requiring immediate action."
    - name: "cart_creation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_cart_created = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that resulted in a cart being created. Measures top-of-funnel product discovery effectiveness."
    - name: "checkout_initiation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_checkout_initiated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that initiated checkout. Key mid-funnel conversion metric — a drop signals friction in the cart-to-checkout transition."
    - name: "session_order_conversion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_order_placed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that resulted in a completed order. The primary e-commerce conversion KPI used in executive dashboards and steering meetings."
    - name: "sessions_with_order_placed"
      expr: SUM(CASE WHEN is_order_placed = TRUE THEN 1 ELSE 0 END)
      comment: "Absolute count of sessions that converted to an order. Used as the numerator for conversion rate calculations and trend analysis."
    - name: "bot_session_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_bot = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions identified as bot traffic. Elevated bot rate inflates traffic metrics and distorts conversion analysis — monitored for security and data quality."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cart-level metrics covering abandonment, recovery, and value capture for the e-commerce platform. Directly informs cart optimization, promotional strategy, and checkout UX investment."
  source: "`vibe_retail_v1`.`ecommerce`.`cart`"
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront cart performance comparison."
    - name: "device_type"
      expr: device_type
      comment: "Device type used when cart was created — identifies device-specific abandonment patterns."
    - name: "channel"
      expr: channel
      comment: "Sales channel (web, mobile app, etc.) — used to compare cart behavior across channels."
    - name: "cart_status"
      expr: cart_status
      comment: "Current cart status (active, abandoned, converted, expired) — primary lifecycle dimension."
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method selected in cart (ship-to-home, BOPIS, etc.) — informs fulfillment demand planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency revenue normalization."
    - name: "cart_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the cart was created, truncated to day — enables daily cart volume trending."
    - name: "cart_week"
      expr: DATE_TRUNC('week', created_timestamp)
      comment: "Week the cart was created — supports weekly abandonment and recovery trend analysis."
    - name: "cart_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the cart was created — used in monthly business reviews."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign associated with the cart session — links cart value to marketing campaigns."
    - name: "is_guest_cart"
      expr: is_guest_cart
      comment: "Whether the cart belongs to a guest (unauthenticated) user — guest vs. authenticated cart behavior differs significantly."
  measures:
    - name: "total_carts"
      expr: COUNT(1)
      comment: "Total number of carts created. Baseline volume metric for the shopping funnel."
    - name: "abandoned_carts"
      expr: SUM(CASE WHEN is_abandoned = TRUE THEN 1 ELSE 0 END)
      comment: "Count of carts that were abandoned without conversion. Directly quantifies lost purchase intent."
    - name: "cart_abandonment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_abandoned = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carts that were abandoned. A primary e-commerce health KPI — high abandonment triggers UX, pricing, and checkout optimization initiatives."
    - name: "total_cart_gmv"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross merchandise value across all carts (including abandoned). Represents the full demand signal captured in carts."
    - name: "abandoned_cart_gmv"
      expr: SUM(CASE WHEN is_abandoned = TRUE THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total GMV in abandoned carts. Quantifies the revenue opportunity lost to abandonment — used to size recovery program investment."
    - name: "avg_cart_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average cart value across all carts. Tracks basket size trends and the impact of upsell/cross-sell initiatives."
    - name: "avg_cart_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per cart. Monitors promotional depth and its relationship to conversion rates."
    - name: "total_cart_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across all carts. Used to measure promotional cost and margin impact."
    - name: "recovery_email_sent_count"
      expr: SUM(CASE WHEN recovery_email_sent = TRUE THEN 1 ELSE 0 END)
      comment: "Number of carts for which a recovery email was sent. Measures the reach of the abandoned cart recovery program."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_checkout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checkout funnel metrics measuring step completion, abandonment, and order value capture. Identifies friction points in the purchase flow that directly impact revenue conversion."
  source: "`vibe_retail_v1`.`ecommerce`.`checkout`"
  dimensions:
    - name: "device_type"
      expr: device_type
      comment: "Device type used during checkout — mobile checkout abandonment often differs from desktop."
    - name: "checkout_status"
      expr: checkout_status
      comment: "Current checkout status (initiated, completed, abandoned) — primary lifecycle dimension."
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Fulfillment method selected at checkout (ship-to-home, BOPIS, etc.) — informs fulfillment capacity planning."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used at checkout — identifies payment method mix and failure patterns."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment authorization status — used to identify payment failure rates by method."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency revenue analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel through which checkout was initiated."
    - name: "abandonment_step"
      expr: abandonment_step
      comment: "The checkout step at which the session was abandoned — pinpoints specific UX friction points."
    - name: "is_guest_checkout"
      expr: is_guest_checkout
      comment: "Whether the checkout was completed as a guest — guest vs. registered checkout conversion rates differ."
    - name: "checkout_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date checkout was initiated, truncated to day — enables daily funnel trend analysis."
    - name: "checkout_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month checkout was initiated — used in monthly business reviews."
  measures:
    - name: "total_checkouts_initiated"
      expr: COUNT(1)
      comment: "Total number of checkout sessions initiated. Baseline funnel entry metric."
    - name: "completed_checkouts"
      expr: SUM(CASE WHEN checkout_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of checkouts that reached completion. Directly measures purchase conversion from the checkout funnel."
    - name: "checkout_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN checkout_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of initiated checkouts that were completed. Core checkout funnel KPI — a decline triggers immediate UX and payment investigation."
    - name: "total_checkout_order_value"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total order value across all completed checkouts. Measures revenue captured through the checkout funnel."
    - name: "avg_checkout_order_value"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value at checkout. Tracks basket size and the effectiveness of upsell tactics at checkout."
    - name: "total_checkout_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied at checkout. Measures promotional cost at the point of purchase."
    - name: "total_checkout_shipping_amount"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping revenue collected at checkout. Used to evaluate shipping fee strategy and free-shipping threshold impact."
    - name: "total_checkout_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at checkout. Required for tax liability reporting and compliance."
    - name: "gift_card_redemption_amount"
      expr: SUM(CAST(gift_card_amount AS DOUBLE))
      comment: "Total gift card value redeemed at checkout. Tracks gift card liability drawdown and its impact on cash revenue."
    - name: "store_credit_redemption_amount"
      expr: SUM(CAST(store_credit_amount AS DOUBLE))
      comment: "Total store credit redeemed at checkout. Monitors store credit liability utilization."
    - name: "address_validation_failure_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN address_validation_status != 'valid' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checkouts with address validation failures. High rates indicate data quality issues that increase failed deliveries and customer service costs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_digital_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital payment transaction metrics covering authorization rates, fraud, refunds, and payment method mix. Critical for treasury, fraud operations, and payment gateway optimization decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`digital_payment`"
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront payment performance comparison."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Abstract payment method category (credit_card, debit_card, wallet, gift_card, bnpl, etc.) — used for payment mix analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment transaction status (authorized, captured, declined, refunded) — primary lifecycle dimension."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was processed — used for channel-level payment analytics."
    - name: "payment_gateway"
      expr: payment_gateway
      comment: "Payment gateway used to process the transaction — used to compare gateway performance and costs."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency financial reporting."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address — used for geographic payment analysis and fraud risk segmentation."
    - name: "wallet_provider"
      expr: wallet_provider
      comment: "Digital wallet provider used (free-form string, not constrained to specific brands) — tracks wallet adoption trends."
    - name: "three_ds_status"
      expr: three_ds_status
      comment: "3D Secure authentication status — used to measure strong customer authentication compliance and its impact on conversion."
    - name: "payment_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Payment transaction date truncated to day — enables daily payment volume and fraud trend analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Payment transaction month — used in monthly financial close and treasury reporting."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Whether the payment is a recurring charge — used to segment subscription vs. one-time payment performance."
  measures:
    - name: "total_payment_transactions"
      expr: COUNT(1)
      comment: "Total number of payment transactions processed. Baseline volume metric for payment operations."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount processed. Core revenue capture metric used in financial reporting and treasury management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after fees and adjustments. Used for net revenue reporting and gateway cost analysis."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total value of payment refunds issued. Tracks refund liability and its impact on net revenue."
    - name: "avg_transaction_value"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment transaction value. Monitors basket size trends and the impact of payment method mix on order value."
    - name: "payment_decline_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_status = 'declined' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment transactions that were declined. High decline rates indicate gateway issues, fraud rules, or card network problems — directly impacts revenue conversion."
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN refund_amount > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that resulted in a refund. Elevated refund rates signal product quality, fulfillment, or fraud issues."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across payment transactions. Monitors overall fraud risk exposure — spikes trigger fraud rule review and potential gateway configuration changes."
    - name: "high_fraud_risk_transaction_count"
      expr: SUM(CASE WHEN fraud_score > 0.7 THEN 1 ELSE 0 END)
      comment: "Count of transactions with fraud score above 0.7 threshold. Quantifies high-risk transaction volume for fraud operations prioritization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across digital payments. Required for tax compliance reporting and remittance."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_abandoned_cart_recovery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Abandoned cart recovery program metrics measuring outreach effectiveness, incentive ROI, and recovered revenue. Directly informs recovery channel strategy and promotional investment decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`abandoned_cart_recovery`"
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront recovery program performance comparison."
    - name: "recovery_channel"
      expr: recovery_channel
      comment: "Channel used for recovery outreach (email, SMS, push notification) — used to compare channel effectiveness and ROI."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Current status of the recovery attempt (sent, opened, clicked, converted, expired) — primary lifecycle dimension."
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of incentive offered in recovery message (discount, free shipping, loyalty points) — used to evaluate incentive effectiveness."
    - name: "device_type"
      expr: device_type
      comment: "Device type of the original abandoned cart — used to tailor recovery messaging by device."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency revenue analysis."
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "UTM campaign tag on the recovery message — links recovery revenue to specific campaigns."
    - name: "is_first_recovery_attempt"
      expr: is_first_recovery_attempt
      comment: "Whether this is the first recovery attempt for the cart — used to analyze first-touch vs. multi-touch recovery effectiveness."
    - name: "recovery_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the recovery attempt was created, truncated to day — enables daily recovery program trend analysis."
    - name: "recovery_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the recovery attempt was created — used in monthly program performance reviews."
  measures:
    - name: "total_recovery_attempts"
      expr: COUNT(1)
      comment: "Total number of abandoned cart recovery attempts initiated. Baseline volume metric for the recovery program."
    - name: "total_abandoned_cart_gmv"
      expr: SUM(CAST(abandoned_cart_gmv AS DOUBLE))
      comment: "Total GMV value of carts targeted for recovery. Quantifies the revenue opportunity addressed by the recovery program."
    - name: "total_recovered_gmv"
      expr: SUM(CAST(recovered_gmv AS DOUBLE))
      comment: "Total GMV successfully recovered through the recovery program. The primary revenue impact KPI for the abandoned cart recovery initiative."
    - name: "recovery_conversion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN recovery_status = 'converted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery attempts that resulted in a completed order. Core program effectiveness KPI used to justify recovery program investment."
    - name: "message_open_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN message_opened_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery messages that were opened. Measures message deliverability and subject line effectiveness."
    - name: "message_click_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN message_clicked_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery messages that were clicked. Measures message content and call-to-action effectiveness."
    - name: "incentive_redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_incentive_redeemed = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN incentive_type IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of recovery attempts with an incentive where the incentive was redeemed. Measures incentive offer effectiveness and informs promotional strategy."
    - name: "total_incentive_value_offered"
      expr: SUM(CAST(incentive_value AS DOUBLE))
      comment: "Total value of incentives offered in recovery messages. Used to calculate recovery program cost and ROI against recovered GMV."
    - name: "avg_recovered_order_net_amount"
      expr: AVG(CAST(recovered_order_net_amount AS DOUBLE))
      comment: "Average net order value of successfully recovered carts. Tracks the quality of recovered orders relative to original cart value."
    - name: "total_recovered_order_discount_amount"
      expr: SUM(CAST(recovered_order_discount_amount AS DOUBLE))
      comment: "Total discount applied on recovered orders. Measures the margin cost of recovery incentives against recovered revenue."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_product_page_view`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product page engagement metrics measuring discovery, recommendation effectiveness, and add-to-cart conversion. Informs merchandising, content, and personalization investment decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`product_page_view`"
  filter: is_bot = FALSE
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront product engagement comparison."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier — enables product-level page view and conversion analysis."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category identifier — enables category-level engagement analysis for assortment decisions."
    - name: "device_type"
      expr: device_type
      comment: "Device type used during the page view — identifies device-specific content and UX optimization opportunities."
    - name: "visitor_type"
      expr: visitor_type
      comment: "New vs. returning visitor — used to segment product discovery patterns by visitor cohort."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country of the page view — supports geographic product demand analysis."
    - name: "referral_source"
      expr: referral_source
      comment: "Traffic source driving the product page view — used for channel attribution of product discovery."
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory availability status at time of page view — used to measure lost sales from out-of-stock events."
    - name: "is_markdown_price"
      expr: is_markdown_price
      comment: "Whether the displayed price was a markdown — used to analyze markdown impact on page engagement and conversion."
    - name: "page_view_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the page view event, truncated to day — enables daily product demand trend analysis."
    - name: "page_view_week"
      expr: DATE_TRUNC('week', event_timestamp)
      comment: "Week of the page view event — supports weekly product performance reporting."
    - name: "page_view_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of the page view event — used in monthly category and product reviews."
  measures:
    - name: "total_product_page_views"
      expr: COUNT(1)
      comment: "Total number of product page views (excluding bots). Measures product discovery volume and demand signal strength."
    - name: "unique_products_viewed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs viewed. Measures breadth of product discovery and assortment engagement."
    - name: "unique_customers_viewing"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct authenticated customers who viewed products. Measures reach of product content among known customers."
    - name: "add_to_cart_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_add_to_cart = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of product page views that resulted in an add-to-cart action. Core product page conversion KPI — low rates trigger content, pricing, or availability investigations."
    - name: "wishlist_add_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_wishlist_add = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of product page views that resulted in a wishlist add. Measures deferred purchase intent — high wishlist rates with low add-to-cart may indicate price sensitivity."
    - name: "recommendation_click_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_recommendation_clicked = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_recommendation_served = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of served recommendations that were clicked. Measures recommendation algorithm effectiveness — directly informs personalization model investment."
    - name: "avg_displayed_price"
      expr: AVG(CAST(displayed_price AS DOUBLE))
      comment: "Average price displayed on product pages. Used to monitor price positioning and the impact of markdown events on displayed price levels."
    - name: "out_of_stock_view_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN inventory_status = 'out_of_stock' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of product page views where the item was out of stock. Quantifies lost sales opportunity from inventory gaps — triggers replenishment and assortment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_product_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product review quality and volume metrics measuring customer satisfaction signals, content moderation efficiency, and review program health. Informs product quality, merchandising, and content strategy decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`product_review`"
  filter: is_deleted = FALSE
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront review program comparison."
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier — enables product-level review analysis for quality and merchandising decisions."
    - name: "moderation_status"
      expr: moderation_status
      comment: "Review moderation status (approved, rejected, pending) — used to track content quality pipeline."
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification of the review (positive, neutral, negative) — used for product quality signal analysis."
    - name: "is_verified_purchase"
      expr: is_verified_purchase
      comment: "Whether the reviewer made a verified purchase — verified reviews carry higher trust weight in quality analysis."
    - name: "is_incentivized"
      expr: is_incentivized
      comment: "Whether the review was incentivized — used to segment organic vs. incentivized review quality."
    - name: "review_language_code"
      expr: review_language_code
      comment: "Language of the review — used for localization and international market quality analysis."
    - name: "purchase_channel"
      expr: purchase_channel
      comment: "Channel through which the reviewed purchase was made — used to compare review patterns across channels."
    - name: "review_date"
      expr: DATE_TRUNC('day', submission_timestamp)
      comment: "Date the review was submitted, truncated to day — enables daily review volume trend analysis."
    - name: "review_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month the review was submitted — used in monthly product quality and content reviews."
  measures:
    - name: "total_reviews_submitted"
      expr: COUNT(1)
      comment: "Total number of reviews submitted (excluding deleted). Measures review program volume and customer engagement with content generation."
    - name: "approved_reviews"
      expr: SUM(CASE WHEN moderation_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of reviews that passed moderation. Measures the volume of trust-building content available to shoppers."
    - name: "moderation_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN moderation_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submitted reviews that were approved. Low approval rates signal content quality issues or overly aggressive moderation policies."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across reviews. Tracks overall product and brand perception — a declining trend triggers product quality and customer experience investigations."
    - name: "verified_purchase_review_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_verified_purchase = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews from verified purchasers. Higher verified rates indicate more authentic review content — used to assess review program credibility."
    - name: "reviews_with_media_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN has_media = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that include media (photos/videos). Rich media reviews have higher conversion impact — used to evaluate media incentive program effectiveness."
    - name: "unique_reviewed_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs with at least one review. Measures review coverage breadth across the product catalog."
    - name: "avg_helpful_vote_count"
      expr: AVG(CAST(helpful_vote_count AS DOUBLE))
      comment: "Average number of helpful votes per review. Measures review quality and community engagement with review content."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_search_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site search performance metrics measuring search relevance, zero-result rates, and search-to-purchase conversion. Directly informs search engine configuration, catalog completeness, and merchandising decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`search_query`"
  filter: is_bot = FALSE
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront search performance comparison."
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the search — mobile search behavior and relevance differ from desktop."
    - name: "query_type"
      expr: query_type
      comment: "Type of search query (keyword, category, brand, etc.) — used to analyze search intent patterns."
    - name: "query_language_code"
      expr: query_language_code
      comment: "Language of the search query — used for localization and international search quality analysis."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country of the search session — supports geographic search demand analysis."
    - name: "is_zero_results"
      expr: is_zero_results
      comment: "Whether the search returned zero results — zero-result queries represent catalog gaps or search quality failures."
    - name: "is_spell_corrected"
      expr: is_spell_corrected
      comment: "Whether the query was spell-corrected — measures search engine tolerance for user input errors."
    - name: "query_source"
      expr: query_source
      comment: "Source of the search query (search bar, voice, suggestion, etc.) — used to analyze search entry point effectiveness."
    - name: "search_date"
      expr: DATE_TRUNC('day', query_timestamp)
      comment: "Date of the search query, truncated to day — enables daily search volume and quality trend analysis."
    - name: "search_week"
      expr: DATE_TRUNC('week', query_timestamp)
      comment: "Week of the search query — supports weekly search performance reporting."
    - name: "search_month"
      expr: DATE_TRUNC('month', query_timestamp)
      comment: "Month of the search query — used in monthly search and catalog reviews."
  measures:
    - name: "total_search_queries"
      expr: COUNT(1)
      comment: "Total number of search queries executed (excluding bots). Baseline search volume metric."
    - name: "zero_result_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_zero_results = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches returning zero results. A critical search quality KPI — high zero-result rates indicate catalog gaps, synonym deficiencies, or search engine configuration issues requiring immediate action."
    - name: "search_click_through_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_click_through = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches that resulted in a result click. Measures search relevance — low CTR indicates poor result ranking or irrelevant results."
    - name: "search_add_to_cart_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_add_to_cart = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches that led to an add-to-cart action. Measures search-to-intent conversion — a key indicator of search merchandising effectiveness."
    - name: "search_purchase_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_purchase = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches that resulted in a purchase. The ultimate search conversion KPI — directly links search quality to revenue generation."
    - name: "spell_correction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_spell_corrected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of queries that required spell correction. High rates indicate search engine is handling user input errors well; combined with zero-result rate, diagnoses search quality gaps."
    - name: "redirect_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_redirected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searches that triggered a redirect rule. Measures the coverage and effectiveness of search merchandising redirect rules."
    - name: "unique_search_sessions"
      expr: COUNT(DISTINCT web_session_id)
      comment: "Count of distinct web sessions containing at least one search query. Measures the reach of site search as a navigation tool."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_recommendation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Personalization and recommendation engine performance metrics measuring click-through, conversion, and attributed revenue. Informs algorithm selection, placement strategy, and personalization investment decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`recommendation`"
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront recommendation performance comparison."
    - name: "algorithm"
      expr: algorithm
      comment: "Recommendation algorithm used (collaborative filtering, content-based, hybrid, etc.) — used to compare algorithm performance and guide model investment."
    - name: "strategy"
      expr: strategy
      comment: "Recommendation strategy (cross-sell, upsell, trending, etc.) — used to evaluate strategy effectiveness by placement."
    - name: "placement"
      expr: placement
      comment: "Page placement of the recommendation (PDP, cart, homepage, etc.) — used to optimize recommendation placement for maximum impact."
    - name: "device_type"
      expr: device_type
      comment: "Device type on which the recommendation was served — used to optimize recommendation UX by device."
    - name: "visitor_type"
      expr: visitor_type
      comment: "New vs. returning visitor — used to compare recommendation effectiveness across visitor cohorts."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency — required for multi-currency attributed revenue analysis."
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant associated with the recommendation — used to measure algorithm and placement test outcomes."
    - name: "recommendation_date"
      expr: DATE_TRUNC('day', served_timestamp)
      comment: "Date the recommendation was served, truncated to day — enables daily recommendation performance trend analysis."
    - name: "recommendation_month"
      expr: DATE_TRUNC('month', served_timestamp)
      comment: "Month the recommendation was served — used in monthly personalization program reviews."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Whether the recommended product is a private label item — used to measure private label recommendation effectiveness."
  measures:
    - name: "total_recommendations_served"
      expr: COUNT(1)
      comment: "Total number of recommendations served. Baseline volume metric for the recommendation engine."
    - name: "recommendation_click_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_clicked = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of served recommendations that were clicked. Primary recommendation relevance KPI — low CTR triggers algorithm and placement optimization."
    - name: "recommendation_add_to_cart_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_added_to_cart = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recommendations that led to an add-to-cart action. Measures recommendation-to-intent conversion effectiveness."
    - name: "recommendation_purchase_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_purchased = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recommendations that resulted in a purchase. The ultimate recommendation conversion KPI — directly links personalization to revenue."
    - name: "total_attributed_revenue"
      expr: SUM(CAST(displayed_price AS DOUBLE) * CASE WHEN is_purchased = TRUE THEN 1 ELSE 0 END)
      comment: "Total revenue attributed to purchased recommendations (using displayed price as proxy). Quantifies the direct revenue contribution of the recommendation engine."
    - name: "avg_recommendation_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average confidence score of served recommendations. Monitors model confidence distribution — low average scores may indicate model degradation requiring retraining."
    - name: "unique_customers_served"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct customers who received recommendations. Measures the reach of the personalization program."
    - name: "unique_skus_recommended"
      expr: COUNT(DISTINCT sku_id)
      comment: "Count of distinct SKUs recommended. Measures catalog coverage of the recommendation engine — low diversity may indicate popularity bias."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_ab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A/B test program metrics measuring experiment volume, conversion lift, and statistical confidence. Enables data-driven decision-making on UX, pricing, and personalization changes across the e-commerce platform."
  source: "`vibe_retail_v1`.`ecommerce`.`ab_test`"
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront experimentation program comparison."
    - name: "test_status"
      expr: test_status
      comment: "Current test status (running, completed, paused, concluded) — primary lifecycle dimension."
    - name: "test_type"
      expr: test_type
      comment: "Type of A/B test (split, multivariate, personalized) — used to analyze experimentation program composition."
    - name: "page_type_target"
      expr: page_type_target
      comment: "Page type targeted by the test (PDP, homepage, cart, checkout) — used to analyze test distribution across the funnel."
    - name: "device_targeting"
      expr: device_targeting
      comment: "Device targeting configuration of the test — used to analyze device-specific experimentation."
    - name: "winning_variant"
      expr: winning_variant
      comment: "The variant declared as winner — used to track test outcomes and inform rollout decisions."
    - name: "conclusion_reason"
      expr: conclusion_reason
      comment: "Reason the test was concluded (significance reached, time limit, manual stop) — used to evaluate test program rigor."
    - name: "test_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the test started — used to track experimentation program velocity over time."
    - name: "is_personalized"
      expr: is_personalized
      comment: "Whether the test includes personalization — used to compare personalized vs. non-personalized test outcomes."
    - name: "is_multivariate"
      expr: is_multivariate
      comment: "Whether the test is multivariate — used to analyze complexity distribution of the experimentation program."
  measures:
    - name: "total_experiments"
      expr: COUNT(1)
      comment: "Total number of A/B tests. Measures experimentation program velocity — a key indicator of data-driven culture maturity."
    - name: "active_experiments"
      expr: SUM(CASE WHEN test_status = 'running' THEN 1 ELSE 0 END)
      comment: "Count of currently running experiments. Monitors concurrent test load — too many simultaneous tests can cause interaction effects."
    - name: "experiment_conversion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_converted = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test assignments that resulted in a conversion event. Measures overall experiment-level conversion performance."
    - name: "total_conversion_value"
      expr: SUM(CAST(conversion_value AS DOUBLE))
      comment: "Total conversion value generated across all test assignments. Quantifies the revenue impact of the experimentation program."
    - name: "avg_conversion_value"
      expr: AVG(CAST(conversion_value AS DOUBLE))
      comment: "Average conversion value per test assignment. Used to compare revenue impact across test variants and experiments."
    - name: "avg_confidence_level"
      expr: AVG(CAST(confidence_level AS DOUBLE))
      comment: "Average statistical confidence level across concluded tests. Monitors experimentation rigor — low average confidence indicates tests are being concluded prematurely."
    - name: "avg_traffic_allocation_pct"
      expr: AVG(CAST(total_traffic_allocation_pct AS DOUBLE))
      comment: "Average percentage of traffic allocated to experiments. Monitors the proportion of traffic under active experimentation."
    - name: "tests_reaching_significance"
      expr: SUM(CASE WHEN confidence_level >= 0.95 THEN 1 ELSE 0 END)
      comment: "Count of tests that reached 95% statistical significance. Measures the quality and conclusiveness of the experimentation program."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_marketplace_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketplace listing performance metrics measuring listing quality, buy-box ownership, price competitiveness, and sell-through rates. Informs marketplace channel strategy and pricing decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`marketplace_listing`"
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront marketplace performance comparison."
    - name: "marketplace_platform"
      expr: marketplace_platform
      comment: "Marketplace platform name — used to compare performance across marketplace channels."
    - name: "listing_status"
      expr: listing_status
      comment: "Current listing status (active, suppressed, inactive) — primary lifecycle dimension."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category identifier — enables category-level marketplace performance analysis."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment method for the listing (merchant-fulfilled, platform-fulfilled) — used to compare fulfillment method performance."
    - name: "country_code"
      expr: country_code
      comment: "Country of the marketplace listing — supports geographic marketplace performance analysis."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Whether the listing is for a private label product — used to compare private label vs. national brand marketplace performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Listing currency — required for multi-currency price analysis."
    - name: "listing_date"
      expr: DATE_TRUNC('day', listed_timestamp)
      comment: "Date the listing went live, truncated to day — enables listing velocity trend analysis."
    - name: "listing_month"
      expr: DATE_TRUNC('month', listed_timestamp)
      comment: "Month the listing went live — used in monthly marketplace channel reviews."
  measures:
    - name: "total_listings"
      expr: COUNT(1)
      comment: "Total number of marketplace listings. Measures marketplace catalog breadth and channel presence."
    - name: "active_listings"
      expr: SUM(CASE WHEN listing_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active marketplace listings. Measures live catalog coverage on marketplace channels."
    - name: "buy_box_ownership_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_buy_box_owner = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN listing_status = 'active' THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of active listings where we own the buy box. Critical marketplace KPI — buy box ownership directly drives the majority of marketplace sales volume."
    - name: "avg_listing_quality_score"
      expr: AVG(CAST(listing_quality_score AS DOUBLE))
      comment: "Average listing quality score across all listings. Measures content completeness and optimization — low scores correlate with reduced visibility and conversion."
    - name: "avg_marketplace_rating"
      expr: AVG(CAST(marketplace_rating AS DOUBLE))
      comment: "Average marketplace seller/product rating. Monitors brand reputation on marketplace channels — declining ratings trigger product quality and fulfillment investigations."
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate across marketplace listings. Measures inventory efficiency on marketplace channels — low rates indicate overstock or poor demand forecasting."
    - name: "price_competitiveness_ratio"
      expr: ROUND(AVG(CAST(marketplace_price AS DOUBLE)) / NULLIF(AVG(CAST(competitor_price AS DOUBLE)), 0), 4)
      comment: "Ratio of our marketplace price to average competitor price. A ratio above 1.0 indicates we are priced above competitors — used to guide dynamic pricing and buy-box strategy."
    - name: "suppressed_listing_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN listing_status = 'suppressed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of listings that are suppressed by the marketplace platform. Suppressed listings generate zero revenue — high rates require immediate content and compliance remediation."
    - name: "avg_marketplace_price"
      expr: AVG(CAST(marketplace_price AS DOUBLE))
      comment: "Average listed price across marketplace listings. Used to monitor price positioning and markdown depth on marketplace channels."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_promotion_banner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional banner performance metrics measuring impression volume, click-through rates, and attributed revenue. Informs creative strategy, placement optimization, and promotional investment decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`promotion_banner`"
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront banner performance comparison."
    - name: "banner_status"
      expr: banner_status
      comment: "Current banner status (active, scheduled, expired, paused) — primary lifecycle dimension."
    - name: "banner_type"
      expr: banner_type
      comment: "Type of promotional banner (hero, category, product, seasonal) — used to compare performance across banner formats."
    - name: "placement_zone"
      expr: placement_zone
      comment: "Page zone where the banner is displayed (homepage, category, PDP) — used to optimize placement for maximum impact."
    - name: "device_targeting"
      expr: device_targeting
      comment: "Device targeting configuration — used to analyze banner performance by device type."
    - name: "geo_targeting_country_code"
      expr: geo_targeting_country_code
      comment: "Country targeted by the banner — supports geographic promotional performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Revenue currency — required for multi-currency attributed revenue analysis."
    - name: "is_personalized"
      expr: is_personalized
      comment: "Whether the banner is personalized — used to compare personalized vs. generic banner performance."
    - name: "banner_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the banner campaign started — used in monthly promotional performance reviews."
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant for the banner — used to measure creative and copy test outcomes."
  measures:
    - name: "total_banners"
      expr: COUNT(1)
      comment: "Total number of promotional banners. Measures promotional content volume and campaign breadth."
    - name: "total_impressions"
      expr: SUM(CAST(impression_count AS DOUBLE))
      comment: "Total banner impressions served. Measures promotional reach and visibility across the e-commerce platform."
    - name: "total_clicks"
      expr: SUM(CAST(click_count AS DOUBLE))
      comment: "Total clicks on promotional banners. Measures engagement with promotional content."
    - name: "banner_click_through_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(click_count AS DOUBLE)) / NULLIF(SUM(CAST(impression_count AS DOUBLE)), 0), 2)
      comment: "Percentage of banner impressions that resulted in a click. Primary creative effectiveness KPI — low CTR triggers creative refresh and placement optimization."
    - name: "total_conversions"
      expr: SUM(CAST(conversion_count AS DOUBLE))
      comment: "Total conversions attributed to promotional banners. Measures the purchase-driving effectiveness of banner campaigns."
    - name: "banner_conversion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(conversion_count AS DOUBLE)) / NULLIF(SUM(CAST(click_count AS DOUBLE)), 0), 2)
      comment: "Percentage of banner clicks that resulted in a conversion. Measures post-click landing page and offer effectiveness."
    - name: "total_attributed_revenue"
      expr: SUM(CAST(attributed_revenue AS DOUBLE))
      comment: "Total revenue attributed to promotional banners. Quantifies the direct revenue contribution of the banner program — used to calculate banner ROI."
    - name: "revenue_per_impression"
      expr: ROUND(SUM(CAST(attributed_revenue AS DOUBLE)) / NULLIF(SUM(CAST(impression_count AS DOUBLE)), 0), 4)
      comment: "Revenue generated per banner impression. Normalizes banner revenue by reach — used to compare efficiency across banner types and placements."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_digital_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital catalog content quality and availability metrics measuring catalog completeness, publication status, and content health. Informs catalog management, SEO, and content investment decisions."
  source: "`vibe_retail_v1`.`ecommerce`.`digital_catalog`"
  dimensions:
    - name: "storefront_id"
      expr: storefront_id
      comment: "Storefront identifier — enables per-storefront catalog quality comparison."
    - name: "publication_status"
      expr: publication_status
      comment: "Current publication status of the catalog entry (published, draft, archived, suppressed) — primary lifecycle dimension."
    - name: "category_id"
      expr: category_id
      comment: "Merchandise category identifier — enables category-level catalog quality analysis."
    - name: "locale_code"
      expr: locale_code
      comment: "Locale of the catalog entry — used to analyze catalog completeness by market and language."
    - name: "is_online_available"
      expr: is_online_available
      comment: "Whether the product is currently available online — used to measure active catalog size."
    - name: "is_featured"
      expr: is_featured
      comment: "Whether the product is featured in the catalog — used to analyze featured product performance."
    - name: "is_private_label"
      expr: is_private_label
      comment: "Whether the product is a private label item — used to compare private label vs. national brand catalog metrics."
    - name: "is_drop_ship_eligible"
      expr: is_drop_ship_eligible
      comment: "Whether the product is eligible for drop-ship fulfillment — used for fulfillment capacity planning."
    - name: "catalog_publish_month"
      expr: DATE_TRUNC('month', last_published_timestamp)
      comment: "Month the catalog entry was last published — used to track catalog freshness and publication velocity."
  measures:
    - name: "total_catalog_entries"
      expr: COUNT(1)
      comment: "Total number of digital catalog entries. Measures catalog breadth and online assortment size."
    - name: "published_catalog_entries"
      expr: SUM(CASE WHEN publication_status = 'published' THEN 1 ELSE 0 END)
      comment: "Count of currently published catalog entries. Measures the live online assortment available to customers."
    - name: "catalog_publication_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN publication_status = 'published' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catalog entries that are published. Low publication rates indicate content bottlenecks delaying product launches."
    - name: "avg_content_completeness_score"
      expr: AVG(CAST(content_completeness_score AS DOUBLE))
      comment: "Average content completeness score across catalog entries. Measures overall catalog content quality — low scores correlate with reduced search visibility and conversion rates."
    - name: "avg_catalog_rating"
      expr: AVG(CAST(rating_average AS DOUBLE))
      comment: "Average customer rating across catalog entries. Monitors overall product quality perception — declining ratings trigger product quality and supplier investigations."
    - name: "catalog_entries_with_video_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN has_video = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catalog entries that include video content. Video content significantly improves conversion — used to prioritize video production investment."
    - name: "hazmat_listing_count"
      expr: SUM(CASE WHEN hazmat_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of catalog entries flagged as hazardous materials. Required for compliance monitoring and fulfillment restriction management."
    - name: "online_available_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_online_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catalog entries currently available online. Measures effective online assortment availability — gaps indicate inventory or content issues."
$$;