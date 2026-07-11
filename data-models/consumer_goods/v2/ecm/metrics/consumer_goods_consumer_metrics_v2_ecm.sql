-- Metric views for domain: consumer | Business: Consumer_Goods | Version: 2 | Generated on: 2026-07-10 13:28:51

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_shopper`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shopper acquisition, engagement, and loyalty KPIs. Drives decisions on consumer acquisition investment, lifecycle management, and loyalty program ROI."
  source: "`vibe_consumer_goods_v1`.`consumer`.`shopper`"
  dimensions:
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the shopper was acquired (e.g. DTC, retail, digital). Used to evaluate channel-level acquisition efficiency."
    - name: "consumer_type"
      expr: consumer_type
      comment: "Classification of the consumer (e.g. individual, household head). Enables segmentation of KPIs by consumer archetype."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the shopper (active, lapsed, churned). Critical for retention and reactivation strategy."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Current loyalty tier of the shopper. Used to evaluate tier distribution and tier-level value contribution."
    - name: "cltv_segment"
      expr: cltv_segment
      comment: "Customer lifetime value segment assigned to the shopper. Enables value-based segmentation of all KPIs."
    - name: "country_code"
      expr: country_code
      comment: "Country of the shopper. Enables geographic breakdown of acquisition and engagement metrics."
    - name: "gender"
      expr: gender
      comment: "Self-reported gender of the shopper. Used for demographic segmentation of consumer KPIs."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Preferred communication language. Used to size localization investment needs."
    - name: "acquisition_date_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of shopper acquisition. Enables cohort-based acquisition trend analysis."
    - name: "loyalty_enrollment_date_month"
      expr: DATE_TRUNC('MONTH', loyalty_enrollment_date)
      comment: "Month of loyalty program enrollment. Used to track loyalty enrollment velocity over time."
  measures:
    - name: "total_shoppers"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Total number of unique shoppers. Baseline KPI for consumer base sizing and growth tracking."
    - name: "loyalty_enrolled_shoppers"
      expr: COUNT(DISTINCT CASE WHEN loyalty_enrollment_date IS NOT NULL THEN shopper_id END)
      comment: "Number of shoppers enrolled in a loyalty program. Measures loyalty program reach and penetration."
    - name: "loyalty_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_enrollment_date IS NOT NULL THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of shoppers enrolled in a loyalty program. Key indicator of loyalty program adoption health."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN email_opt_in = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of shoppers opted in to email communications. Drives email channel reach and marketing ROI decisions."
    - name: "sms_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sms_opt_in = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of shoppers opted in to SMS communications. Informs SMS channel investment and compliance posture."
    - name: "push_notification_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN push_notification_opt_in = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of shoppers opted in to push notifications. Measures mobile engagement channel reach."
    - name: "avg_loyalty_points_balance"
      expr: AVG(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Average loyalty points balance per shopper. Indicates unredeemed loyalty liability and engagement depth."
    - name: "total_loyalty_points_balance"
      expr: SUM(CAST(loyalty_points_balance AS DOUBLE))
      comment: "Total outstanding loyalty points balance across all shoppers. Represents aggregate loyalty liability on the balance sheet."
    - name: "identity_verified_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN identity_verified = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of shoppers with verified identity. Measures data quality and fraud risk exposure in the consumer base."
    - name: "gdpr_subject_count"
      expr: COUNT(DISTINCT CASE WHEN gdpr_subject = TRUE THEN shopper_id END)
      comment: "Number of shoppers subject to GDPR. Quantifies regulatory compliance scope for data governance decisions."
    - name: "ccpa_subject_count"
      expr: COUNT(DISTINCT CASE WHEN ccpa_subject = TRUE THEN shopper_id END)
      comment: "Number of shoppers subject to CCPA. Quantifies California privacy compliance scope."
    - name: "data_sharing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN data_sharing_consent = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of shoppers who have consented to data sharing. Critical for addressable audience sizing in data monetization and personalization."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_dtc_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct-to-consumer order performance KPIs covering revenue, fulfillment, returns, and channel mix. Note: per VREQ-028 the procurement_purchase_order_id FK has been removed as DTC orders should not reference procurement POs. Per VREQ-029 the sustainability_carbon_emission_id FK has been removed as emissions are calculated aggregates."
  source: "`vibe_consumer_goods_v1`.`consumer`.`dtc_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the DTC order (e.g. pending, shipped, delivered, cancelled). Used to track order pipeline health."
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel through which the order was placed (e.g. web, mobile, app). Enables channel-level revenue and conversion analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment state of the order. Used to monitor operational fulfillment performance."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the order. Informs payment mix strategy and fraud risk profiling."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the order. Used to track revenue collection and payment failure rates."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order was transacted. Enables multi-currency revenue normalization."
    - name: "ship_to_country_code"
      expr: ship_to_country_code
      comment: "Destination country of the order. Enables geographic revenue and logistics analysis."
    - name: "device_type"
      expr: device_type
      comment: "Device type used to place the order (e.g. mobile, desktop). Informs UX investment and channel optimization."
    - name: "subscription_order_flag"
      expr: subscription_order_flag
      comment: "Indicates whether the order originated from a subscription. Used to separate recurring vs. one-time revenue streams."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement. Enables monthly revenue trend and seasonality analysis."
    - name: "return_flag"
      expr: return_flag
      comment: "Indicates whether the order has been returned. Used to calculate return rates and net revenue."
  measures:
    - name: "total_orders"
      expr: COUNT(DISTINCT dtc_order_id)
      comment: "Total number of DTC orders placed. Baseline volume KPI for DTC channel performance."
    - name: "total_order_revenue"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total gross revenue from DTC orders. Primary top-line revenue KPI for the DTC channel."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-shipping subtotal revenue. Used to isolate product revenue from fees and taxes."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across DTC orders. Measures promotional spend and margin erosion from discounting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on DTC orders. Required for tax compliance reporting and financial reconciliation."
    - name: "total_shipping_revenue"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping charges collected. Used to evaluate shipping cost recovery and pricing strategy."
    - name: "avg_order_value"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order value per DTC transaction. Key efficiency KPI — rising AOV indicates upsell/cross-sell effectiveness."
    - name: "return_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN return_flag = TRUE THEN dtc_order_id END) / NULLIF(COUNT(DISTINCT dtc_order_id), 0), 2)
      comment: "Percentage of DTC orders that were returned. High return rates signal product quality, sizing, or expectation-setting issues."
    - name: "gift_order_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gift_order_flag = TRUE THEN dtc_order_id END) / NULLIF(COUNT(DISTINCT dtc_order_id), 0), 2)
      comment: "Percentage of orders flagged as gifts. Informs gifting season strategy and packaging investment."
    - name: "subscription_order_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN subscription_order_flag = TRUE THEN dtc_order_id END) / NULLIF(COUNT(DISTINCT dtc_order_id), 0), 2)
      comment: "Percentage of orders from subscriptions. Measures recurring revenue penetration in the DTC channel."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Measures promotional intensity and its impact on net revenue."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_dtc_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DTC order line-level KPIs for product revenue, margin, returns, and fulfillment. Note: per VREQ-001 dtc_return_id FK has been linked to consumer.dtc_return. Per VREQ-030 sustainability_carbon_emission_id FK removed as emissions are calculated aggregates, not 1:1 line references."
  source: "`vibe_consumer_goods_v1`.`consumer`.`dtc_order_line`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the order line. Used to track line-level delivery performance."
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel for the order line. Enables channel-level product revenue analysis."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand associated with the ordered SKU. Enables brand-level revenue and return analysis."
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category of the ordered item. Enables category-level performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the line. Enables multi-currency revenue normalization."
    - name: "is_returned"
      expr: is_returned
      comment: "Indicates whether this line item was returned. Used to calculate line-level return rates."
    - name: "subscription_flag"
      expr: subscription_flag
      comment: "Indicates whether this line is part of a subscription order. Separates recurring from one-time product revenue."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Indicates whether the line item contains hazardous materials. Used for regulatory and logistics compliance reporting."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Indicates whether the line is under a regulatory hold. Used to quantify revenue at risk from compliance issues."
    - name: "actual_ship_date_month"
      expr: DATE_TRUNC('MONTH', actual_ship_date)
      comment: "Month of actual shipment. Enables monthly shipped revenue trend analysis."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total gross revenue across all DTC order lines. Primary product-level revenue KPI."
    - name: "total_net_revenue"
      expr: SUM(CAST(line_net_amount AS DOUBLE))
      comment: "Total net revenue after discounts at line level. Measures true product revenue contribution."
    - name: "total_cost_of_goods_sold"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total COGS across DTC order lines. Required for gross margin calculation and product profitability analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(line_discount_amount AS DOUBLE))
      comment: "Total discount value applied at line level. Measures promotional spend by product and category."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per unit across order lines. Tracks price realization and pricing strategy effectiveness."
    - name: "avg_line_discount_pct"
      expr: AVG(CAST(line_discount_pct AS DOUBLE))
      comment: "Average discount percentage applied at line level. Measures average promotional depth per transaction."
    - name: "gross_margin_amount"
      expr: SUM(CAST(line_net_amount AS DOUBLE) - CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Gross margin in absolute terms (net revenue minus COGS). Core profitability KPI for product and category management."
    - name: "return_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_returned = TRUE THEN dtc_order_line_id END) / NULLIF(COUNT(DISTINCT dtc_order_line_id), 0), 2)
      comment: "Percentage of order lines that were returned. Signals product quality, description accuracy, and customer satisfaction issues."
    - name: "regulatory_hold_revenue"
      expr: SUM(CASE WHEN regulatory_hold_flag = TRUE THEN CAST(line_total_amount AS DOUBLE) ELSE 0 END)
      comment: "Revenue value of lines under regulatory hold. Quantifies revenue at risk from compliance and recall events."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at line level. Used for tax compliance and financial reconciliation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_loyalty_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty account health, points economics, and tier distribution KPIs. Drives loyalty program investment, tier strategy, and liability management decisions. Per VREQ-070 referral_account_id is the self-referencing FK (vs PK loyalty_account_id)."
  source: "`vibe_consumer_goods_v1`.`consumer`.`loyalty_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the loyalty account (active, suspended, closed). Used to track active account base and churn."
    - name: "membership_tier"
      expr: membership_tier
      comment: "Current loyalty tier of the account. Enables tier-level KPI analysis and tier migration tracking."
    - name: "account_type"
      expr: account_type
      comment: "Type of loyalty account (e.g. standard, premium, corporate). Enables account-type segmentation."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the loyalty account was enrolled. Measures channel-level enrollment efficiency."
    - name: "country_code"
      expr: country_code
      comment: "Country of the loyalty account. Enables geographic loyalty performance analysis."
    - name: "cltv_segment"
      expr: cltv_segment
      comment: "CLTV segment of the loyalty account holder. Enables value-based loyalty analysis."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the account has been flagged for fraud. Used to quantify fraud exposure in the loyalty program."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of loyalty account enrollment. Enables enrollment cohort and velocity analysis."
    - name: "points_currency_code"
      expr: points_currency_code
      comment: "Currency denomination of loyalty points. Used for multi-currency loyalty liability reporting."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'active' THEN loyalty_account_id END)
      comment: "Total number of active loyalty accounts. Primary KPI for loyalty program reach and health."
    - name: "total_points_balance"
      expr: SUM(CAST(points_balance AS DOUBLE))
      comment: "Total outstanding points balance across all loyalty accounts. Represents aggregate loyalty liability."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total points ever earned across all accounts. Measures cumulative loyalty program engagement."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Total points ever redeemed. Measures loyalty program utilization and redemption health."
    - name: "total_lifetime_points_expired"
      expr: SUM(CAST(lifetime_points_expired AS DOUBLE))
      comment: "Total points expired without redemption. High expiry indicates low engagement or poor redemption UX."
    - name: "points_redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of earned points that have been redeemed. Key loyalty health metric — low rates signal disengagement or redemption friction."
    - name: "points_expiry_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_expired AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of earned points that expired unredeemed. High expiry rates may indicate poor program design or member disengagement."
    - name: "avg_points_balance"
      expr: AVG(CAST(points_balance AS DOUBLE))
      comment: "Average outstanding points balance per loyalty account. Indicates average unredeemed value per member."
    - name: "avg_tier_qualification_spend"
      expr: AVG(CAST(tier_qualification_spend AS DOUBLE))
      comment: "Average spend required to qualify for current tier. Used to calibrate tier thresholds and program economics."
    - name: "fraud_flagged_account_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN loyalty_account_id END) / NULLIF(COUNT(DISTINCT loyalty_account_id), 0), 2)
      comment: "Percentage of loyalty accounts flagged for fraud. Measures fraud exposure and program integrity risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_loyalty_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty transaction economics KPIs covering points earn/burn, monetary value, and fraud. Drives loyalty program financial management and fraud control decisions."
  source: "`vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of loyalty transaction (earn, redeem, adjust, expire). Enables analysis by transaction category."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the loyalty transaction. Used to track pending vs. settled loyalty economics."
    - name: "points_direction"
      expr: points_direction
      comment: "Direction of points movement (credit/debit). Enables earn vs. burn analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the loyalty transaction occurred. Enables channel-level loyalty engagement analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the monetary value associated with the transaction. Enables multi-currency loyalty economics."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the transaction was flagged for fraud. Used to quantify fraudulent loyalty activity."
    - name: "is_bonus_transaction"
      expr: is_bonus_transaction
      comment: "Indicates whether the transaction includes a bonus multiplier. Used to measure promotional points cost."
    - name: "transaction_timestamp_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the loyalty transaction. Enables monthly earn/burn trend analysis."
    - name: "trigger_event"
      expr: trigger_event
      comment: "Business event that triggered the loyalty transaction (e.g. purchase, referral, birthday). Enables event-level loyalty ROI analysis."
  measures:
    - name: "total_points_transacted"
      expr: SUM(CAST(points_amount AS DOUBLE))
      comment: "Total points volume across all loyalty transactions. Measures overall loyalty program activity."
    - name: "total_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value associated with loyalty transactions. Measures the financial scale of loyalty-linked purchases."
    - name: "total_redemption_value"
      expr: SUM(CAST(redemption_value AS DOUBLE))
      comment: "Total monetary value of points redeemed. Represents the cost of loyalty redemptions to the business."
    - name: "total_qualifying_spend"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Total qualifying spend that generated loyalty points. Measures loyalty-driven revenue contribution."
    - name: "avg_earn_rate"
      expr: AVG(CAST(earn_rate AS DOUBLE))
      comment: "Average points earn rate per transaction. Used to evaluate program generosity and cost calibration."
    - name: "avg_bonus_multiplier"
      expr: AVG(CASE WHEN is_bonus_transaction = TRUE THEN CAST(bonus_multiplier AS DOUBLE) END)
      comment: "Average bonus multiplier on bonus transactions. Measures promotional points cost per bonus event."
    - name: "fraud_transaction_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN loyalty_transaction_id END) / NULLIF(COUNT(DISTINCT loyalty_transaction_id), 0), 2)
      comment: "Percentage of loyalty transactions flagged as fraudulent. Key risk KPI for loyalty program integrity."
    - name: "avg_points_balance_after"
      expr: AVG(CAST(points_balance_after AS DOUBLE))
      comment: "Average post-transaction points balance. Indicates average member engagement depth after each transaction."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Promoter Score response KPIs for consumer satisfaction measurement and closed-loop action tracking. Per VREQ-004 sku_code has been removed as redundant (sku_id FK is the canonical reference)."
  source: "`vibe_consumer_goods_v1`.`consumer`.`nps_response`"
  dimensions:
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the NPS survey was delivered (email, in-app, SMS). Enables channel-level response quality analysis."
    - name: "respondent_category"
      expr: respondent_category
      comment: "Category of the respondent (promoter, passive, detractor). Core NPS segmentation dimension."
    - name: "consumer_segment"
      expr: consumer_segment
      comment: "Consumer segment of the respondent. Enables segment-level NPS analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the NPS respondent. Enables geographic NPS benchmarking."
    - name: "product_category"
      expr: product_category
      comment: "Product category referenced in the NPS response. Enables category-level satisfaction analysis."
    - name: "purchase_channel"
      expr: purchase_channel
      comment: "Channel through which the respondent made their purchase. Enables channel-level NPS analysis."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Indicates whether the respondent is a loyalty program member. Enables loyalty vs. non-loyalty NPS comparison."
    - name: "closed_loop_status"
      expr: closed_loop_status
      comment: "Status of closed-loop follow-up action on the NPS response. Measures operational responsiveness to detractors."
    - name: "response_timestamp_month"
      expr: DATE_TRUNC('MONTH', response_timestamp)
      comment: "Month of NPS response submission. Enables monthly NPS trend analysis."
    - name: "survey_trigger_event"
      expr: survey_trigger_event
      comment: "Business event that triggered the NPS survey (e.g. post-purchase, post-return). Enables event-level satisfaction analysis."
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification of the verbatim response (positive, neutral, negative). Enables qualitative NPS enrichment."
  measures:
    - name: "total_responses"
      expr: COUNT(DISTINCT nps_response_id)
      comment: "Total number of NPS responses received. Baseline volume KPI for survey reach and statistical confidence."
    - name: "promoter_count"
      expr: COUNT(DISTINCT CASE WHEN respondent_category = 'promoter' THEN nps_response_id END)
      comment: "Number of promoter responses (NPS score 9-10). Used to calculate NPS and measure brand advocacy."
    - name: "detractor_count"
      expr: COUNT(DISTINCT CASE WHEN respondent_category = 'detractor' THEN nps_response_id END)
      comment: "Number of detractor responses (NPS score 0-6). Used to calculate NPS and identify at-risk consumers."
    - name: "net_promoter_score"
      expr: ROUND(100.0 * (COUNT(DISTINCT CASE WHEN respondent_category = 'promoter' THEN nps_response_id END) - COUNT(DISTINCT CASE WHEN respondent_category = 'detractor' THEN nps_response_id END)) / NULLIF(COUNT(DISTINCT nps_response_id), 0), 1)
      comment: "Net Promoter Score: (promoters - detractors) / total responses * 100. The primary consumer satisfaction KPI used in executive reporting."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from NLP analysis of verbatim comments. Enriches NPS with qualitative signal for product and service improvement."
    - name: "closed_loop_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN closed_loop_status = 'completed' THEN nps_response_id END) / NULLIF(COUNT(DISTINCT CASE WHEN respondent_category = 'detractor' THEN nps_response_id END), 0), 2)
      comment: "Percentage of detractor responses that received a completed closed-loop follow-up. Measures operational responsiveness to dissatisfied consumers."
    - name: "repeat_buyer_response_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN repeat_buyer_flag = TRUE THEN nps_response_id END) / NULLIF(COUNT(DISTINCT nps_response_id), 0), 2)
      comment: "Percentage of NPS responses from repeat buyers. Indicates whether loyal customers are being surveyed and their satisfaction levels."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_cltv_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Lifetime Value scoring KPIs for consumer value segmentation, churn risk, and revenue prediction. Drives investment allocation across consumer segments."
  source: "`vibe_consumer_goods_v1`.`consumer`.`cltv_record`"
  dimensions:
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "CLTV tier assigned to the consumer (e.g. platinum, gold, silver, bronze). Primary segmentation dimension for value-based decisions."
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of the CLTV calculation (active, pending, stale). Used to filter for current, reliable CLTV scores."
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary purchase channel of the consumer. Enables channel-level CLTV analysis."
    - name: "primary_brand_code"
      expr: primary_brand_code
      comment: "Primary brand affinity of the consumer. Enables brand-level CLTV analysis."
    - name: "primary_category_code"
      expr: primary_category_code
      comment: "Primary product category of the consumer. Enables category-level CLTV analysis."
    - name: "tier_change_flag"
      expr: tier_change_flag
      comment: "Indicates whether the consumer changed CLTV tier in the latest calculation. Used to track tier migration velocity."
    - name: "personalization_eligible"
      expr: personalization_eligible
      comment: "Indicates whether the consumer is eligible for personalization. Measures addressable personalization audience size."
    - name: "calculation_date_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month of CLTV calculation. Enables monthly CLTV trend and model refresh analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of CLTV monetary values. Enables multi-currency CLTV normalization."
  measures:
    - name: "total_consumers_scored"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Total number of unique consumers with a CLTV score. Measures CLTV model coverage across the consumer base."
    - name: "avg_cltv_score"
      expr: AVG(CAST(cltv_score AS DOUBLE))
      comment: "Average CLTV score across all scored consumers. Tracks overall consumer base value trajectory."
    - name: "total_predicted_revenue_12m"
      expr: SUM(CAST(predicted_revenue_12m AS DOUBLE))
      comment: "Total predicted revenue from all consumers over the next 12 months. Key forward-looking revenue planning KPI."
    - name: "total_predicted_revenue_24m"
      expr: SUM(CAST(predicted_revenue_24m AS DOUBLE))
      comment: "Total predicted revenue from all consumers over the next 24 months. Used for long-range revenue planning and investment sizing."
    - name: "avg_churn_probability"
      expr: AVG(CAST(churn_probability AS DOUBLE))
      comment: "Average churn probability across scored consumers. Measures aggregate churn risk in the consumer base."
    - name: "high_churn_risk_consumer_count"
      expr: COUNT(DISTINCT CASE WHEN CAST(churn_probability AS DOUBLE) >= 0.7 THEN shopper_id END)
      comment: "Number of consumers with churn probability >= 70%. Quantifies the at-risk consumer population requiring retention intervention."
    - name: "avg_aov"
      expr: AVG(CAST(aov AS DOUBLE))
      comment: "Average order value per consumer from CLTV model inputs. Used to calibrate CLTV model assumptions and validate predictions."
    - name: "avg_purchase_frequency"
      expr: AVG(CAST(purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency per consumer. Key input to CLTV model and indicator of consumer engagement depth."
    - name: "total_historical_revenue_12m"
      expr: SUM(CAST(revenue_12m_historical AS DOUBLE))
      comment: "Total actual revenue from consumers over the trailing 12 months. Used to benchmark predicted vs. actual revenue."
    - name: "avg_model_confidence_score"
      expr: AVG(CAST(model_confidence_score AS DOUBLE))
      comment: "Average model confidence score across CLTV predictions. Measures CLTV model reliability and data quality."
    - name: "tier_upgrade_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN tier_change_flag = TRUE AND cltv_tier > previous_cltv_tier THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of consumers who upgraded their CLTV tier in the latest calculation. Measures upward value migration in the consumer base."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_dtc_return`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DTC return processing KPIs covering return volume, refund economics, fraud, and quality signals. Drives return policy, fraud controls, and product quality decisions."
  source: "`vibe_consumer_goods_v1`.`consumer`.`dtc_return`"
  dimensions:
    - name: "return_status"
      expr: return_status
      comment: "Current status of the return (pending, approved, rejected, completed). Used to track return pipeline health."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return. Enables root-cause analysis of return drivers."
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which the return was initiated (online, in-store, phone). Enables channel-level return cost analysis."
    - name: "return_method"
      expr: return_method
      comment: "Method used to return the item (mail, drop-off, pickup). Informs return logistics cost optimization."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (original payment, store credit, points). Enables refund method mix analysis."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition of the returned item (restock, destroy, donate). Informs reverse logistics and inventory recovery decisions."
    - name: "fraud_review_flag"
      expr: fraud_review_flag
      comment: "Indicates whether the return was flagged for fraud review. Used to quantify return fraud exposure."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates whether the return involved a safety incident. Used for regulatory reporting and product safety monitoring."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of return request. Enables monthly return volume trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the refund. Enables multi-currency return economics analysis."
  measures:
    - name: "total_returns"
      expr: COUNT(DISTINCT dtc_return_id)
      comment: "Total number of DTC returns processed. Baseline return volume KPI."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total gross refund value issued. Measures the financial cost of returns to the business."
    - name: "total_net_refund_amount"
      expr: SUM(CAST(net_refund_amount AS DOUBLE))
      comment: "Total net refund value after restocking fees. Measures actual cash outflow from return processing."
    - name: "total_restocking_fee_revenue"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected. Measures cost recovery from return processing."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund value per return. Used to benchmark return economics and detect anomalous refund patterns."
    - name: "fraud_review_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN fraud_review_flag = TRUE THEN dtc_return_id END) / NULLIF(COUNT(DISTINCT dtc_return_id), 0), 2)
      comment: "Percentage of returns flagged for fraud review. Measures return fraud risk exposure."
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score across all returns. Tracks aggregate fraud risk level in the return population."
    - name: "safety_incident_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN safety_incident_flag = TRUE THEN dtc_return_id END) / NULLIF(COUNT(DISTINCT dtc_return_id), 0), 2)
      comment: "Percentage of returns involving a safety incident. Critical product safety KPI for regulatory reporting and recall decisions."
    - name: "return_window_eligible_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN return_window_eligible = TRUE THEN dtc_return_id END) / NULLIF(COUNT(DISTINCT dtc_return_id), 0), 2)
      comment: "Percentage of returns that were within the eligible return window. Measures policy compliance and out-of-window return exception rate."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_consent_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer consent coverage and compliance KPIs. Drives GDPR/CCPA compliance posture, data governance decisions, and addressable audience sizing."
  source: "`vibe_consumer_goods_v1`.`consumer`.`consent_record`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (active, withdrawn, expired). Primary dimension for consent coverage analysis."
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, data processing, profiling, third-party sharing). Enables consent-type coverage analysis."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (consent, legitimate interest, contract). Required for regulatory compliance reporting."
    - name: "country_code"
      expr: country_code
      comment: "Country of the consent record. Enables jurisdiction-level compliance analysis."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory framework governing the consent (GDPR, CCPA, LGPD). Enables framework-level compliance reporting."
    - name: "capture_method"
      expr: capture_method
      comment: "Method used to capture consent (web form, in-store, phone). Enables capture method quality analysis."
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Indicates whether double opt-in was used. Measures consent quality and regulatory robustness."
    - name: "is_current_record"
      expr: is_current_record
      comment: "Indicates whether this is the current active consent record. Used to filter for current consent state."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month consent became effective. Enables consent acquisition trend analysis."
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total number of consent records. Baseline KPI for consent management scale."
    - name: "active_consent_count"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN consent_record_id END)
      comment: "Number of currently active consent records. Measures the addressable consented audience."
    - name: "consent_active_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records that are currently active. Key compliance health KPI — declining rates signal consent erosion."
    - name: "double_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN double_opt_in_flag = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records captured via double opt-in. Measures consent quality and regulatory defensibility."
    - name: "profiling_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN profiling_consent_flag = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consumers who have consented to profiling. Measures addressable personalization and AI/ML audience size."
    - name: "third_party_sharing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN third_party_sharing_flag = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consumers who have consented to third-party data sharing. Measures data monetization and partnership audience size."
    - name: "re_consent_required_count"
      expr: COUNT(DISTINCT CASE WHEN re_consent_required_flag = TRUE THEN consent_record_id END)
      comment: "Number of consent records requiring re-consent. Quantifies compliance remediation workload and at-risk audience."
    - name: "parental_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN parental_consent_flag = TRUE THEN consent_record_id END) / NULLIF(COUNT(DISTINCT consent_record_id), 0), 2)
      comment: "Percentage of consent records with parental consent. Measures compliance with minor data protection requirements."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer subscription health, revenue, and churn KPIs. Drives subscription program investment, pricing, and retention strategy decisions."
  source: "`vibe_consumer_goods_v1`.`consumer`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (active, paused, cancelled, trial). Primary dimension for subscription health analysis."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (replenishment, curated, bundle). Enables subscription model mix analysis."
    - name: "channel"
      expr: channel
      comment: "Acquisition channel for the subscription. Enables channel-level subscription economics analysis."
    - name: "frequency"
      expr: frequency
      comment: "Delivery frequency of the subscription (weekly, monthly, quarterly). Enables frequency-level revenue and churn analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the subscription price. Enables multi-currency subscription revenue analysis."
    - name: "trial_flag"
      expr: trial_flag
      comment: "Indicates whether the subscription is in a trial period. Used to track trial-to-paid conversion."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Indicates whether the subscription auto-renews. Measures auto-renewal adoption and its impact on retention."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type for the subscription. Enables payment failure analysis by method."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month of subscription start. Enables subscription cohort and acquisition trend analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for subscription cancellation. Enables root-cause analysis of churn drivers."
  measures:
    - name: "total_active_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN subscription_status = 'active' THEN subscription_id END)
      comment: "Total number of active subscriptions. Primary KPI for subscription program scale and health."
    - name: "total_subscription_revenue"
      expr: SUM(CAST(price AS DOUBLE))
      comment: "Total subscription price value across all subscriptions. Measures gross subscription revenue potential."
    - name: "total_net_subscription_revenue"
      expr: SUM(CAST(net_price AS DOUBLE))
      comment: "Total net subscription revenue after discounts. Measures actual subscription revenue contribution."
    - name: "avg_subscription_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average subscription price per subscriber. Used to track pricing strategy effectiveness and ARPU."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied to subscriptions. Measures promotional depth in subscription acquisition."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN subscription_status = 'cancelled' THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions that have been cancelled. Primary churn KPI for subscription program health."
    - name: "trial_conversion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN trial_flag = FALSE AND subscription_status = 'active' THEN subscription_id END) / NULLIF(COUNT(DISTINCT CASE WHEN trial_flag = TRUE THEN subscription_id END), 0), 2)
      comment: "Percentage of trial subscriptions that converted to paid active status. Measures trial program effectiveness."
    - name: "paused_subscription_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN subscription_status = 'paused' THEN subscription_id END) / NULLIF(COUNT(DISTINCT subscription_id), 0), 2)
      comment: "Percentage of subscriptions currently paused. High pause rates may indicate price sensitivity or lifecycle friction."
    - name: "avg_failed_payment_count"
      expr: AVG(CAST(failed_payment_count AS DOUBLE))
      comment: "Average number of failed payments per subscription. Measures payment failure risk and involuntary churn exposure."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer interaction (contact center, digital, in-store) KPIs for service quality, escalation, and resolution performance. Per VREQ-003 trade_account_id FK correctly points to sales.trade_account."
  source: "`vibe_consumer_goods_v1`.`consumer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of consumer interaction (complaint, inquiry, feedback, return). Enables interaction-type volume and quality analysis."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (open, resolved, escalated). Used to track service queue health."
    - name: "channel"
      expr: channel
      comment: "Channel through which the interaction occurred (phone, chat, email, in-store). Enables channel-level service cost and quality analysis."
    - name: "contact_reason_code"
      expr: contact_reason_code
      comment: "Reason code for the consumer contact. Enables root-cause analysis of contact drivers."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution applied to the interaction. Measures resolution method mix and effectiveness."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the interaction was escalated. Used to track escalation rates and service quality."
    - name: "is_bot_handled"
      expr: is_bot_handled
      comment: "Indicates whether the interaction was handled by a bot. Measures automation rate and bot deflection effectiveness."
    - name: "adverse_event_flag"
      expr: adverse_event_flag
      comment: "Indicates whether the interaction involved an adverse event. Used for regulatory reporting and product safety monitoring."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the interaction breached SLA. Measures service level compliance."
    - name: "interaction_timestamp_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month of the interaction. Enables monthly contact volume and service quality trend analysis."
    - name: "sentiment_label"
      expr: sentiment_label
      comment: "Sentiment classification of the interaction (positive, neutral, negative). Enables sentiment-based service quality analysis."
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of consumer interactions. Baseline contact volume KPI for service capacity planning."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions that were escalated. High escalation rates signal service quality or complexity issues."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions that breached SLA. Primary service level compliance KPI."
    - name: "bot_deflection_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_bot_handled = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions handled by bots without human escalation. Measures automation ROI and cost-per-contact reduction."
    - name: "adverse_event_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN adverse_event_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions involving adverse events. Critical product safety and regulatory reporting KPI."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across consumer interactions. Tracks overall consumer satisfaction in service touchpoints."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target hours across interactions. Used to benchmark service level commitments by channel and type."
    - name: "repeat_contact_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN repeat_contact_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions from consumers who contacted again for the same issue. Measures first-contact resolution failure rate."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`consumer_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer segment membership KPIs for audience sizing, activation, and personalization eligibility. Drives marketing investment allocation and segment strategy decisions."
  source: "`vibe_consumer_goods_v1`.`consumer`.`segment_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the segment membership (active, expired, suppressed). Used to track active audience size per segment."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the consumer to the segment (rule-based, ML model, manual). Enables assignment method quality analysis."
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "CLTV tier of the segment member. Enables value-based segment composition analysis."
    - name: "channel"
      expr: channel
      comment: "Activation channel for the segment membership. Enables channel-level audience analysis."
    - name: "personalization_eligible"
      expr: personalization_eligible
      comment: "Indicates whether the member is eligible for personalization. Measures addressable personalization audience within each segment."
    - name: "is_control_group"
      expr: is_control_group
      comment: "Indicates whether the member is in a control group. Used to separate test and control populations for campaign measurement."
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Indicates whether the member is suppressed from activation. Measures suppression rate and its impact on addressable audience."
    - name: "assignment_date_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month of segment assignment. Enables monthly audience growth and refresh trend analysis."
    - name: "product_category_code"
      expr: product_category_code
      comment: "Product category scope of the segment membership. Enables category-level audience analysis."
  measures:
    - name: "total_segment_members"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Total unique consumers across all segment memberships. Measures total addressable audience in the segmentation model."
    - name: "active_segment_memberships"
      expr: COUNT(DISTINCT CASE WHEN membership_status = 'active' THEN segment_membership_id END)
      comment: "Total active segment memberships. Measures current activated audience size across all segments."
    - name: "personalization_eligible_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN personalization_eligible = TRUE THEN shopper_id END) / NULLIF(COUNT(DISTINCT shopper_id), 0), 2)
      comment: "Percentage of segment members eligible for personalization. Measures addressable personalization audience as a share of total."
    - name: "suppression_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN suppression_flag = TRUE THEN segment_membership_id END) / NULLIF(COUNT(DISTINCT segment_membership_id), 0), 2)
      comment: "Percentage of segment memberships suppressed from activation. High suppression rates reduce effective audience and marketing ROI."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average model confidence score for segment assignments. Measures segment assignment quality and ML model reliability."
    - name: "control_group_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_control_group = TRUE THEN segment_membership_id END) / NULLIF(COUNT(DISTINCT segment_membership_id), 0), 2)
      comment: "Percentage of segment memberships in control groups. Ensures adequate holdout for campaign measurement and incrementality testing."
$$;