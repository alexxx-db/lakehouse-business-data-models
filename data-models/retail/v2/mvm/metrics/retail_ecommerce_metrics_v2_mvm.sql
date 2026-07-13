-- Metric views for domain: ecommerce | Business: Retail | Version: 2 | Generated on: 2026-07-12 15:23:39

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_cart`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shopping cart performance metrics including abandonment, conversion, and revenue potential"
  source: "`vibe_retail_v1`.`ecommerce`.`cart`"
  dimensions:
    - name: "cart_status"
      expr: cart_status
      comment: "Current status of the shopping cart (active, abandoned, converted)"
    - name: "channel"
      expr: channel
      comment: "Sales channel where cart was created (web, mobile app, tablet)"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for cart creation (desktop, mobile, tablet)"
    - name: "fulfillment_type"
      expr: fulfillment_type
      comment: "Fulfillment method selected (ship to home, BOPIS, ROPIS)"
    - name: "is_abandoned"
      expr: is_abandoned
      comment: "Flag indicating whether cart was abandoned"
    - name: "is_guest_cart"
      expr: is_guest_cart
      comment: "Flag indicating guest checkout vs authenticated user"
    - name: "abandonment_reason"
      expr: abandonment_reason
      comment: "Reason for cart abandonment if captured"
    - name: "coupon_redemption_status"
      expr: coupon_redemption_status
      comment: "Status of coupon redemption attempt"
    - name: "utm_source"
      expr: utm_source
      comment: "Marketing source attribution"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "Marketing campaign attribution"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date cart was created"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month cart was created"
  measures:
    - name: "total_carts"
      expr: COUNT(1)
      comment: "Total number of shopping carts created"
    - name: "abandoned_carts"
      expr: SUM(CASE WHEN is_abandoned = TRUE THEN 1 ELSE 0 END)
      comment: "Number of carts abandoned before checkout"
    - name: "converted_carts"
      expr: SUM(CASE WHEN cart_status = 'converted' THEN 1 ELSE 0 END)
      comment: "Number of carts successfully converted to orders"
    - name: "cart_abandonment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_abandoned = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carts abandoned - key conversion funnel metric"
    - name: "cart_conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cart_status = 'converted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carts converted to orders - primary ecommerce KPI"
    - name: "total_cart_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross merchandise value across all carts"
    - name: "total_cart_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total cart subtotal before shipping and tax"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across all carts"
    - name: "avg_cart_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average cart value - key revenue per cart metric"
    - name: "avg_items_per_cart"
      expr: AVG(CAST(item_count AS DOUBLE))
      comment: "Average number of items per cart - basket size indicator"
    - name: "discount_penetration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(discount_amount AS DOUBLE) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carts with discounts applied - promotional effectiveness"
    - name: "avg_discount_per_cart"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per cart"
    - name: "guest_cart_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_guest_cart = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guest checkouts vs authenticated - impacts customer acquisition"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_checkout`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checkout funnel performance metrics tracking conversion, abandonment, and friction points"
  source: "`vibe_retail_v1`.`ecommerce`.`checkout`"
  dimensions:
    - name: "checkout_status"
      expr: checkout_status
      comment: "Current status of checkout process"
    - name: "channel"
      expr: channel
      comment: "Sales channel for checkout"
    - name: "device_type"
      expr: device_type
      comment: "Device type used during checkout"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method selected"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment processing status"
    - name: "current_step"
      expr: current_step
      comment: "Current step in checkout funnel"
    - name: "abandonment_step"
      expr: abandonment_step
      comment: "Step where checkout was abandoned - identifies friction points"
    - name: "is_guest_checkout"
      expr: is_guest_checkout
      comment: "Guest vs authenticated checkout flag"
    - name: "fulfillment_mode"
      expr: fulfillment_mode
      comment: "Fulfillment method selected"
    - name: "shipping_method_name"
      expr: shipping_method_name
      comment: "Shipping method chosen"
    - name: "initiated_date"
      expr: DATE_TRUNC('day', initiated_timestamp)
      comment: "Date checkout was initiated"
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month checkout was initiated"
  measures:
    - name: "total_checkouts_initiated"
      expr: COUNT(1)
      comment: "Total number of checkout sessions initiated"
    - name: "completed_checkouts"
      expr: SUM(CASE WHEN checkout_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Number of successfully completed checkouts"
    - name: "abandoned_checkouts"
      expr: SUM(CASE WHEN abandoned_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of abandoned checkout sessions"
    - name: "checkout_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN checkout_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checkouts completed - critical conversion metric"
    - name: "checkout_abandonment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN abandoned_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checkouts abandoned - identifies friction and revenue leakage"
    - name: "total_checkout_value"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total order value across all checkout sessions"
    - name: "total_checkout_subtotal"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total subtotal before shipping and tax"
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected"
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected"
    - name: "total_discount_applied"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied at checkout"
    - name: "avg_order_value"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value at checkout - key revenue metric"
    - name: "avg_shipping_per_order"
      expr: AVG(CAST(shipping_amount AS DOUBLE))
      comment: "Average shipping charge per checkout"
    - name: "discount_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as percentage of subtotal - promotional impact on margin"
    - name: "shipping_to_subtotal_ratio"
      expr: ROUND(100.0 * SUM(CAST(shipping_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Shipping revenue as percentage of subtotal"
    - name: "guest_checkout_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_guest_checkout = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guest checkouts - impacts customer data capture"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_digital_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing performance metrics including authorization rates, fraud, and payment method mix"
  source: "`vibe_retail_v1`.`ecommerce`.`digital_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment processing status"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Type of payment method used"
    - name: "payment_gateway"
      expr: payment_gateway
      comment: "Payment gateway provider"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel where payment was processed"
    - name: "card_network"
      expr: card_network
      comment: "Card network for card payments (Visa, MC, Amex, etc.)"
    - name: "wallet_provider"
      expr: wallet_provider
      comment: "Digital wallet provider if applicable"
    - name: "fraud_screening_result"
      expr: fraud_screening_result
      comment: "Result of fraud screening check"
    - name: "three_ds_status"
      expr: three_ds_status
      comment: "3D Secure authentication status"
    - name: "avs_result_code"
      expr: avs_result_code
      comment: "Address verification system result"
    - name: "cvv_result_code"
      expr: cvv_result_code
      comment: "CVV verification result"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Billing address country"
    - name: "initiated_date"
      expr: DATE_TRUNC('day', initiated_timestamp)
      comment: "Date payment was initiated"
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month payment was initiated"
  measures:
    - name: "total_payment_attempts"
      expr: COUNT(1)
      comment: "Total number of payment attempts"
    - name: "authorized_payments"
      expr: SUM(CASE WHEN authorization_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of successfully authorized payments"
    - name: "captured_payments"
      expr: SUM(CASE WHEN capture_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of payments captured (funds settled)"
    - name: "authorization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN authorization_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment attempts authorized - critical payment success metric"
    - name: "capture_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN capture_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN authorization_timestamp IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of authorized payments captured - settlement efficiency"
    - name: "total_payment_volume"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment volume processed"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after fees"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount processed"
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected through payments"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment transaction size"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across payments"
    - name: "high_fraud_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(fraud_score AS DOUBLE) > 50 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments flagged as high fraud risk - security monitoring"
    - name: "refund_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN refund_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments refunded - customer satisfaction and returns indicator"
    - name: "three_ds_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN three_ds_status IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments using 3D Secure - security compliance metric"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_web_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Web session engagement and conversion metrics tracking visitor behavior and funnel progression"
  source: "`vibe_retail_v1`.`ecommerce`.`web_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Current session status"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for session"
    - name: "browser_name"
      expr: browser_name
      comment: "Browser used for session"
    - name: "operating_system"
      expr: operating_system
      comment: "Operating system of visitor"
    - name: "visitor_type"
      expr: visitor_type
      comment: "Visitor type (new, returning, etc.)"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Geographic country of visitor"
    - name: "utm_source"
      expr: utm_source
      comment: "Marketing source attribution"
    - name: "utm_medium"
      expr: utm_medium
      comment: "Marketing medium attribution"
    - name: "utm_campaign"
      expr: utm_campaign
      comment: "Marketing campaign attribution"
    - name: "referral_source"
      expr: referral_source
      comment: "Referral source category"
    - name: "is_bounce"
      expr: is_bounce
      comment: "Flag indicating single-page bounce session"
    - name: "is_bot"
      expr: is_bot
      comment: "Flag indicating bot traffic"
    - name: "session_start_date"
      expr: DATE_TRUNC('day', session_start_timestamp)
      comment: "Date session started"
    - name: "session_start_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Month session started"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of web sessions"
    - name: "sessions_with_cart"
      expr: SUM(CASE WHEN is_cart_created = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sessions where cart was created"
    - name: "sessions_with_checkout"
      expr: SUM(CASE WHEN is_checkout_initiated = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sessions where checkout was initiated"
    - name: "sessions_with_order"
      expr: SUM(CASE WHEN is_order_placed = TRUE THEN 1 ELSE 0 END)
      comment: "Number of sessions resulting in order placement"
    - name: "bounce_sessions"
      expr: SUM(CASE WHEN is_bounce = TRUE THEN 1 ELSE 0 END)
      comment: "Number of single-page bounce sessions"
    - name: "session_to_cart_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_cart_created = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions creating a cart - top-of-funnel conversion"
    - name: "session_to_checkout_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_checkout_initiated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions initiating checkout - mid-funnel conversion"
    - name: "session_to_order_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_order_placed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions placing an order - overall session conversion rate"
    - name: "cart_to_checkout_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_checkout_initiated = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_cart_created = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of cart sessions proceeding to checkout - cart abandonment inverse"
    - name: "checkout_to_order_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_order_placed = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_checkout_initiated = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of checkouts completing order - checkout conversion efficiency"
    - name: "bounce_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_bounce = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of single-page bounce sessions - engagement quality metric"
    - name: "avg_page_views_per_session"
      expr: AVG(CAST(page_view_count AS DOUBLE))
      comment: "Average number of page views per session - engagement depth"
    - name: "avg_session_duration_seconds"
      expr: AVG(CAST(session_duration_seconds AS DOUBLE))
      comment: "Average session duration in seconds - engagement time metric"
    - name: "avg_searches_per_session"
      expr: AVG(CAST(search_query_count AS DOUBLE))
      comment: "Average number of searches per session - search engagement"
    - name: "bot_traffic_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_bot = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bot traffic - traffic quality monitoring"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_product_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product review quality and sentiment metrics driving merchandising and customer trust"
  source: "`vibe_retail_v1`.`ecommerce`.`product_review`"
  dimensions:
    - name: "moderation_status"
      expr: moderation_status
      comment: "Review moderation status"
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification (positive, negative, neutral)"
    - name: "is_verified_purchase"
      expr: is_verified_purchase
      comment: "Flag indicating verified purchase review"
    - name: "is_incentivized"
      expr: is_incentivized
      comment: "Flag indicating incentivized review"
    - name: "has_media"
      expr: has_media
      comment: "Flag indicating review includes media (photo/video)"
    - name: "fit_feedback"
      expr: fit_feedback
      comment: "Product fit feedback (runs small, true to size, runs large)"
    - name: "purchase_channel"
      expr: purchase_channel
      comment: "Channel where product was purchased"
    - name: "review_language_code"
      expr: review_language_code
      comment: "Language of review"
    - name: "syndication_source"
      expr: syndication_source
      comment: "Source of syndicated review if applicable"
    - name: "submission_date"
      expr: DATE_TRUNC('day', submission_timestamp)
      comment: "Date review was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month review was submitted"
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of product reviews submitted"
    - name: "published_reviews"
      expr: SUM(CASE WHEN moderation_status = 'published' THEN 1 ELSE 0 END)
      comment: "Number of reviews published and visible to customers"
    - name: "verified_purchase_reviews"
      expr: SUM(CASE WHEN is_verified_purchase = TRUE THEN 1 ELSE 0 END)
      comment: "Number of verified purchase reviews - high trust signal"
    - name: "reviews_with_media"
      expr: SUM(CASE WHEN has_media = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews with photo or video content"
    - name: "positive_sentiment_reviews"
      expr: SUM(CASE WHEN sentiment_label = 'positive' THEN 1 ELSE 0 END)
      comment: "Number of reviews with positive sentiment"
    - name: "negative_sentiment_reviews"
      expr: SUM(CASE WHEN sentiment_label = 'negative' THEN 1 ELSE 0 END)
      comment: "Number of reviews with negative sentiment"
    - name: "review_publish_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN moderation_status = 'published' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews published - moderation efficiency and quality"
    - name: "verified_purchase_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_verified_purchase = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of verified purchase reviews - trust and authenticity metric"
    - name: "media_attachment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN has_media = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with media - content richness indicator"
    - name: "positive_sentiment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sentiment_label = 'positive' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of positive sentiment reviews - product satisfaction metric"
    - name: "negative_sentiment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sentiment_label = 'negative' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of negative sentiment reviews - quality issue indicator"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across reviews - overall product perception"
    - name: "avg_helpful_votes"
      expr: AVG(CAST(helpful_vote_count AS DOUBLE))
      comment: "Average helpful votes per review - review utility metric"
    - name: "avg_media_attachments"
      expr: AVG(CAST(media_attachment_count AS DOUBLE))
      comment: "Average number of media attachments per review"
    - name: "incentivized_review_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_incentivized = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incentivized reviews - bias monitoring metric"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_digital_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital catalog content quality and merchandising effectiveness metrics"
  source: "`vibe_retail_v1`.`ecommerce`.`digital_catalog`"
  dimensions:
    - name: "publication_status"
      expr: publication_status
      comment: "Publication status of catalog item"
    - name: "is_online_available"
      expr: is_online_available
      comment: "Flag indicating item is available for online purchase"
    - name: "is_featured"
      expr: is_featured
      comment: "Flag indicating featured/promoted item"
    - name: "is_searchable"
      expr: is_searchable
      comment: "Flag indicating item is searchable on site"
    - name: "has_video"
      expr: has_video
      comment: "Flag indicating item has video content"
    - name: "is_private_label"
      expr: is_private_label
      comment: "Flag indicating private label product"
    - name: "is_drop_ship_eligible"
      expr: is_drop_ship_eligible
      comment: "Flag indicating drop ship eligibility"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Flag indicating hazardous material"
    - name: "locale_code"
      expr: locale_code
      comment: "Locale/language of catalog content"
    - name: "age_restriction"
      expr: age_restriction
      comment: "Age restriction category if applicable"
    - name: "publish_start_date"
      expr: publish_start_date
      comment: "Date item became available online"
    - name: "publish_start_month"
      expr: DATE_TRUNC('month', publish_start_date)
      comment: "Month item became available online"
  measures:
    - name: "total_catalog_items"
      expr: COUNT(1)
      comment: "Total number of digital catalog items"
    - name: "published_items"
      expr: SUM(CASE WHEN publication_status = 'published' THEN 1 ELSE 0 END)
      comment: "Number of published catalog items"
    - name: "online_available_items"
      expr: SUM(CASE WHEN is_online_available = TRUE THEN 1 ELSE 0 END)
      comment: "Number of items available for online purchase"
    - name: "featured_items"
      expr: SUM(CASE WHEN is_featured = TRUE THEN 1 ELSE 0 END)
      comment: "Number of featured/promoted items"
    - name: "items_with_video"
      expr: SUM(CASE WHEN has_video = TRUE THEN 1 ELSE 0 END)
      comment: "Number of items with video content"
    - name: "online_availability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_online_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catalog items available online - assortment breadth"
    - name: "video_content_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN has_video = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of items with video - content richness metric"
    - name: "avg_content_completeness_score"
      expr: AVG(CAST(content_completeness_score AS DOUBLE))
      comment: "Average content completeness score - catalog quality metric"
    - name: "avg_rating"
      expr: AVG(CAST(rating_average AS DOUBLE))
      comment: "Average customer rating across catalog items"
    - name: "avg_review_count"
      expr: AVG(CAST(review_count AS DOUBLE))
      comment: "Average number of reviews per catalog item"
    - name: "avg_image_count"
      expr: AVG(CAST(image_count AS DOUBLE))
      comment: "Average number of images per catalog item - visual content depth"
    - name: "private_label_mix"
      expr: ROUND(100.0 * SUM(CASE WHEN is_private_label = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of private label items - margin opportunity indicator"
    - name: "drop_ship_eligible_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_drop_ship_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drop ship eligible items - fulfillment flexibility"
    - name: "searchable_item_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_searchable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of searchable items - discoverability metric"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`ecommerce_marketplace_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketplace listing performance metrics tracking competitive positioning and sales effectiveness"
  source: "`vibe_retail_v1`.`ecommerce`.`marketplace_listing`"
  dimensions:
    - name: "listing_status"
      expr: listing_status
      comment: "Current listing status on marketplace"
    - name: "marketplace_platform"
      expr: marketplace_platform
      comment: "Marketplace platform (Amazon, eBay, Walmart, etc.)"
    - name: "is_buy_box_owner"
      expr: is_buy_box_owner
      comment: "Flag indicating buy box ownership - critical for marketplace sales"
    - name: "prime_eligible_flag"
      expr: prime_eligible_flag
      comment: "Flag indicating Prime eligibility"
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "Fulfillment method (FBA, FBM, etc.)"
    - name: "content_compliance_flag"
      expr: content_compliance_flag
      comment: "Flag indicating content compliance with marketplace rules"
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Flag indicating hazardous material"
    - name: "is_private_label"
      expr: is_private_label
      comment: "Flag indicating private label product"
    - name: "country_code"
      expr: country_code
      comment: "Country marketplace"
    - name: "suppression_reason"
      expr: suppression_reason
      comment: "Reason for listing suppression if applicable"
    - name: "listed_date"
      expr: DATE_TRUNC('day', listed_timestamp)
      comment: "Date listing went live"
    - name: "listed_month"
      expr: DATE_TRUNC('month', listed_timestamp)
      comment: "Month listing went live"
  measures:
    - name: "total_listings"
      expr: COUNT(1)
      comment: "Total number of marketplace listings"
    - name: "active_listings"
      expr: SUM(CASE WHEN listing_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of active marketplace listings"
    - name: "buy_box_listings"
      expr: SUM(CASE WHEN is_buy_box_owner = TRUE THEN 1 ELSE 0 END)
      comment: "Number of listings owning the buy box"
    - name: "prime_eligible_listings"
      expr: SUM(CASE WHEN prime_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of Prime-eligible listings"
    - name: "suppressed_listings"
      expr: SUM(CASE WHEN suppression_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of suppressed listings"
    - name: "buy_box_win_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_buy_box_owner = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of listings owning buy box - critical marketplace competitiveness metric"
    - name: "prime_eligibility_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN prime_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of Prime-eligible listings - conversion advantage indicator"
    - name: "listing_suppression_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN suppression_reason IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suppressed listings - compliance and quality issue indicator"
    - name: "content_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN content_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of listings meeting content compliance - listing quality metric"
    - name: "avg_listing_quality_score"
      expr: AVG(CAST(listing_quality_score AS DOUBLE))
      comment: "Average listing quality score - marketplace algorithm favorability"
    - name: "avg_marketplace_price"
      expr: AVG(CAST(marketplace_price AS DOUBLE))
      comment: "Average marketplace listing price"
    - name: "avg_marketplace_rating"
      expr: AVG(CAST(marketplace_rating AS DOUBLE))
      comment: "Average marketplace customer rating"
    - name: "avg_review_count"
      expr: AVG(CAST(review_count AS DOUBLE))
      comment: "Average number of reviews per listing"
    - name: "avg_sell_through_rate"
      expr: AVG(CAST(sell_through_rate AS DOUBLE))
      comment: "Average sell-through rate - inventory velocity metric"
    - name: "avg_inventory_quantity"
      expr: AVG(CAST(inventory_quantity AS DOUBLE))
      comment: "Average inventory quantity per listing"
$$;