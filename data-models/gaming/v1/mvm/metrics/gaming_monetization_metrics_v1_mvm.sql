-- Metric views for domain: monetization | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:42:21

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_ad_impression`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad monetization performance metrics tracking impressions, revenue, viewability, and fraud across ad networks, formats, and player segments"
  source: "`gaming_ecm`.`monetization`.`ad_impression`"
  dimensions:
    - name: "impression_date"
      expr: impression_date
      comment: "Date of ad impression for daily trend analysis"
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format type (banner, interstitial, rewarded video, native)"
    - name: "ad_network"
      expr: ad_network
      comment: "Ad network provider serving the impression"
    - name: "country_code"
      expr: country_code
      comment: "Country where impression occurred for geographic revenue analysis"
    - name: "is_rewarded"
      expr: is_rewarded
      comment: "Whether impression was for a rewarded ad (player receives in-game reward)"
    - name: "impression_status"
      expr: impression_status
      comment: "Status of impression (completed, skipped, error)"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether impression was flagged as fraudulent"
    - name: "viewability_flag"
      expr: viewability_flag
      comment: "Whether impression met viewability standards (MRC compliant)"
    - name: "days_since_install"
      expr: days_since_install
      comment: "Player tenure cohort at time of impression"
    - name: "player_level_at_impression"
      expr: player_level_at_impression
      comment: "Player progression level when ad was shown"
  measures:
    - name: "total_impressions"
      expr: COUNT(1)
      comment: "Total number of ad impressions served"
    - name: "total_ad_revenue_usd"
      expr: SUM(CAST(revenue_usd AS DOUBLE))
      comment: "Total ad revenue in USD across all impressions"
    - name: "total_ecpm_revenue"
      expr: SUM(CAST(ecpm_revenue AS DOUBLE))
      comment: "Total eCPM-based revenue across impressions"
    - name: "avg_ecpm_usd"
      expr: AVG(CAST(ecpm_revenue AS DOUBLE))
      comment: "Average effective cost per mille (eCPM) per impression"
    - name: "viewable_impressions"
      expr: SUM(CASE WHEN viewability_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of impressions meeting viewability standards"
    - name: "fraud_impressions"
      expr: SUM(CASE WHEN fraud_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of impressions flagged as fraudulent"
    - name: "rewarded_impressions"
      expr: SUM(CASE WHEN is_rewarded = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rewarded ad impressions where player received in-game reward"
    - name: "completed_impressions"
      expr: SUM(CASE WHEN impression_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of impressions completed by player (not skipped or errored)"
    - name: "avg_watch_completion_pct"
      expr: AVG(CAST(watch_completion_percentage AS DOUBLE))
      comment: "Average percentage of video ad watched by players"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Distinct players who received ad impressions"
    - name: "unique_sessions"
      expr: COUNT(DISTINCT session_id)
      comment: "Distinct sessions containing ad impressions"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_storefront_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-app purchase and storefront transaction metrics tracking revenue, conversion, player spending behavior, and fraud across items and payment methods"
  source: "`gaming_ecm`.`monetization`.`storefront_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE(transaction_timestamp)
      comment: "Date of transaction for daily revenue tracking"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of transaction (completed, pending, failed, refunded)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (purchase, refund, chargeback)"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method used (credit card, PayPal, mobile carrier, etc.)"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling the transaction"
    - name: "country_code"
      expr: country_code
      comment: "Country where transaction originated for geographic revenue analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of transaction"
    - name: "is_first_purchase"
      expr: is_first_purchase
      comment: "Whether this was player's first purchase (conversion event)"
    - name: "is_whale_transaction"
      expr: is_whale_transaction
      comment: "Whether transaction qualifies as high-value whale spending"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Whether transaction was flagged as potentially fraudulent"
    - name: "days_since_install"
      expr: days_since_install
      comment: "Player tenure at time of transaction for cohort monetization analysis"
    - name: "player_level"
      expr: player_level
      comment: "Player progression level at time of purchase"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of storefront transactions"
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue before fees and taxes"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after platform fees and taxes"
    - name: "total_platform_fees"
      expr: SUM(CAST(platform_fee_amount AS DOUBLE))
      comment: "Total platform fees paid to storefronts (Apple, Google, Steam, etc.)"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on transactions"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to transactions"
    - name: "avg_transaction_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross transaction value (average order value)"
    - name: "completed_transactions"
      expr: SUM(CASE WHEN transaction_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed transactions"
    - name: "refunded_transactions"
      expr: SUM(CASE WHEN transaction_type = 'refund' THEN 1 ELSE 0 END)
      comment: "Count of refunded transactions"
    - name: "first_purchase_transactions"
      expr: SUM(CASE WHEN is_first_purchase = TRUE THEN 1 ELSE 0 END)
      comment: "Count of first-time purchase conversions"
    - name: "whale_transactions"
      expr: SUM(CASE WHEN is_whale_transaction = TRUE THEN 1 ELSE 0 END)
      comment: "Count of high-value whale transactions"
    - name: "fraud_transactions"
      expr: SUM(CASE WHEN fraud_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions flagged as fraudulent"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_player_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription business metrics tracking recurring revenue, churn, retention, trial conversion, and subscriber lifetime value"
  source: "`gaming_ecm`.`monetization`.`player_subscription`"
  dimensions:
    - name: "subscription_start_date"
      expr: subscription_start_date
      comment: "Date subscription began for cohort analysis"
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of subscription (active, cancelled, expired, suspended)"
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Subscription tier or plan level"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cycle frequency (monthly, quarterly, annual)"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which subscription was acquired"
    - name: "auto_renewal_enabled"
      expr: auto_renewal_enabled
      comment: "Whether subscription is set to auto-renew"
    - name: "trial_used"
      expr: trial_used
      comment: "Whether player used a trial period before subscribing"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for subscription cancellation"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling recurring billing"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of subscription pricing"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of subscription records"
    - name: "active_subscriptions"
      expr: SUM(CASE WHEN subscription_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active subscriptions"
    - name: "cancelled_subscriptions"
      expr: SUM(CASE WHEN subscription_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled subscriptions"
    - name: "total_subscription_revenue"
      expr: SUM(CAST(lifetime_revenue AS DOUBLE))
      comment: "Total lifetime revenue from all subscriptions"
    - name: "avg_subscription_price"
      expr: AVG(CAST(subscription_price AS DOUBLE))
      comment: "Average subscription price per billing cycle"
    - name: "avg_lifetime_revenue"
      expr: AVG(CAST(lifetime_revenue AS DOUBLE))
      comment: "Average lifetime revenue per subscription (subscriber LTV)"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to subscriptions"
    - name: "subscriptions_with_discount"
      expr: SUM(CASE WHEN discount_applied = TRUE THEN 1 ELSE 0 END)
      comment: "Count of subscriptions with active discount"
    - name: "trial_subscriptions"
      expr: SUM(CASE WHEN trial_used = TRUE THEN 1 ELSE 0 END)
      comment: "Count of subscriptions that used trial period"
    - name: "auto_renew_enabled_count"
      expr: SUM(CASE WHEN auto_renewal_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of subscriptions with auto-renewal enabled"
    - name: "payment_failures"
      expr: SUM(CAST(payment_failure_count AS BIGINT))
      comment: "Total count of payment failures across all subscriptions"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_player_ltv_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Player lifetime value segmentation metrics tracking predicted LTV, spending behavior, churn risk, and monetization potential across player cohorts"
  source: "`gaming_ecm`.`monetization`.`player_ltv_segment`"
  dimensions:
    - name: "segment_assignment_date"
      expr: segment_assignment_date
      comment: "Date player was assigned to current LTV segment"
    - name: "segment_status"
      expr: segment_status
      comment: "Status of segment assignment (active, expired, recalculated)"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for regional LTV analysis"
    - name: "is_dap"
      expr: is_dap
      comment: "Whether player is a Daily Active Payer (DAP)"
    - name: "preferred_payment_method"
      expr: preferred_payment_method
      comment: "Player's preferred payment method"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for LTV calculations"
    - name: "days_since_last_purchase"
      expr: days_since_last_purchase
      comment: "Days since player's last purchase (recency indicator)"
    - name: "segment_change_reason"
      expr: segment_change_reason
      comment: "Reason for most recent segment change"
  measures:
    - name: "total_players_segmented"
      expr: COUNT(1)
      comment: "Total number of players with LTV segmentation"
    - name: "total_iap_spend"
      expr: SUM(CAST(total_iap_spend AS DOUBLE))
      comment: "Total in-app purchase spend across all segmented players"
    - name: "total_ad_revenue"
      expr: SUM(CAST(total_ad_revenue AS DOUBLE))
      comment: "Total ad revenue generated by segmented players"
    - name: "avg_predicted_ltv_30d"
      expr: AVG(CAST(predicted_ltv_30d AS DOUBLE))
      comment: "Average predicted 30-day lifetime value per player"
    - name: "avg_predicted_ltv_90d"
      expr: AVG(CAST(predicted_ltv_90d AS DOUBLE))
      comment: "Average predicted 90-day lifetime value per player"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across all players"
    - name: "avg_arppu"
      expr: AVG(CAST(arppu AS DOUBLE))
      comment: "Average revenue per paying user"
    - name: "avg_transaction_value"
      expr: AVG(CAST(average_transaction_value AS DOUBLE))
      comment: "Average transaction value per player"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score (0-1 scale, higher = more likely to churn)"
    - name: "avg_conversion_probability"
      expr: AVG(CAST(conversion_probability_score AS DOUBLE))
      comment: "Average probability of non-payer converting to payer"
    - name: "high_churn_risk_players"
      expr: SUM(CASE WHEN CAST(churn_risk_score AS DOUBLE) > 0.7 THEN 1 ELSE 0 END)
      comment: "Count of players with high churn risk (score > 0.7)"
    - name: "daily_active_payers"
      expr: SUM(CASE WHEN is_dap = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Daily Active Payers (DAP)"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Distinct players in LTV segmentation"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_storefront_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storefront catalog performance metrics tracking item sales, revenue, pricing effectiveness, and inventory across item types and categories"
  source: "`gaming_ecm`.`monetization`.`storefront_item`"
  dimensions:
    - name: "item_type"
      expr: item_type
      comment: "Type of storefront item (consumable, durable, currency, subscription, etc.)"
    - name: "item_category"
      expr: item_category
      comment: "Category of item for merchandising analysis"
    - name: "item_rarity"
      expr: item_rarity
      comment: "Rarity tier of item (common, rare, epic, legendary)"
    - name: "is_bundle"
      expr: is_bundle
      comment: "Whether item is a bundle of multiple items"
    - name: "is_featured"
      expr: is_featured
      comment: "Whether item is currently featured in storefront"
    - name: "is_time_limited"
      expr: is_time_limited
      comment: "Whether item is available for limited time only"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of item (active, deprecated, seasonal)"
    - name: "monetization_model"
      expr: monetization_model
      comment: "Monetization model for item (premium, freemium, gacha, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Real-money currency for item pricing"
    - name: "virtual_currency_type"
      expr: virtual_currency_type
      comment: "Virtual currency type accepted for item"
  measures:
    - name: "total_items"
      expr: COUNT(1)
      comment: "Total number of storefront items in catalog"
    - name: "total_item_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE))
      comment: "Total revenue generated by all items"
    - name: "total_item_sales"
      expr: SUM(CAST(total_sales_count AS BIGINT))
      comment: "Total number of item sales across catalog"
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across all items"
    - name: "avg_discounted_price"
      expr: AVG(CAST(discounted_price AS DOUBLE))
      comment: "Average discounted price for items with active discounts"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to items"
    - name: "featured_items"
      expr: SUM(CASE WHEN is_featured = TRUE THEN 1 ELSE 0 END)
      comment: "Count of items currently featured in storefront"
    - name: "time_limited_items"
      expr: SUM(CASE WHEN is_time_limited = TRUE THEN 1 ELSE 0 END)
      comment: "Count of time-limited availability items"
    - name: "bundle_items"
      expr: SUM(CASE WHEN is_bundle = TRUE THEN 1 ELSE 0 END)
      comment: "Count of bundle items in catalog"
    - name: "active_items"
      expr: SUM(CASE WHEN lifecycle_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of items with active lifecycle status"
    - name: "total_stock_quantity"
      expr: SUM(CAST(stock_quantity AS BIGINT))
      comment: "Total stock quantity across all items (for limited inventory items)"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_dlc_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downloadable content entitlement metrics tracking DLC ownership, activation, download completion, and revocation across player base"
  source: "`gaming_ecm`.`monetization`.`dlc_entitlement`"
  dimensions:
    - name: "acquisition_date"
      expr: DATE(acquisition_timestamp)
      comment: "Date DLC entitlement was acquired"
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of entitlement (active, expired, revoked, pending)"
    - name: "acquisition_method"
      expr: acquisition_method
      comment: "Method by which entitlement was acquired (purchase, bundle, promotion, etc.)"
    - name: "download_status"
      expr: download_status
      comment: "Status of DLC download (completed, in_progress, failed, not_started)"
    - name: "is_revoked"
      expr: is_revoked
      comment: "Whether entitlement has been revoked"
    - name: "is_transferable"
      expr: is_transferable
      comment: "Whether entitlement can be transferred to another account"
    - name: "region_code"
      expr: region_code
      comment: "Region code for entitlement (for region-locked content)"
    - name: "purchase_currency_code"
      expr: purchase_currency_code
      comment: "Currency used for DLC purchase"
    - name: "revocation_reason"
      expr: revocation_reason
      comment: "Reason for entitlement revocation (refund, fraud, violation, etc.)"
  measures:
    - name: "total_entitlements"
      expr: COUNT(1)
      comment: "Total number of DLC entitlements granted"
    - name: "active_entitlements"
      expr: SUM(CASE WHEN entitlement_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active DLC entitlements"
    - name: "revoked_entitlements"
      expr: SUM(CASE WHEN is_revoked = TRUE THEN 1 ELSE 0 END)
      comment: "Count of revoked entitlements"
    - name: "completed_downloads"
      expr: SUM(CASE WHEN download_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of entitlements with completed downloads"
    - name: "total_dlc_revenue"
      expr: SUM(CAST(purchase_price_amount AS DOUBLE))
      comment: "Total revenue from DLC purchases"
    - name: "avg_dlc_price"
      expr: AVG(CAST(purchase_price_amount AS DOUBLE))
      comment: "Average purchase price per DLC entitlement"
    - name: "unique_dlc_owners"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Distinct players who own at least one DLC entitlement"
    - name: "unique_active_dlc_owners"
      expr: COUNT(DISTINCT CASE WHEN entitlement_status = 'active' THEN player_account_id END)
      comment: "Distinct players with at least one active DLC entitlement"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`monetization_ad_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ad placement configuration and performance metrics tracking placement effectiveness, fill rates, eCPM, and lifetime revenue by context and format"
  source: "`gaming_ecm`.`monetization`.`ad_placement`"
  dimensions:
    - name: "ad_format"
      expr: ad_format
      comment: "Ad format configured for placement (banner, interstitial, rewarded, native)"
    - name: "placement_status"
      expr: placement_status
      comment: "Current status of ad placement (active, paused, archived)"
    - name: "trigger_context"
      expr: trigger_context
      comment: "Game context that triggers ad placement (level_complete, game_over, store_visit, etc.)"
    - name: "mediation_enabled"
      expr: mediation_enabled
      comment: "Whether ad mediation is enabled for placement"
    - name: "coppa_compliant"
      expr: coppa_compliant
      comment: "Whether placement is COPPA compliant for child-directed content"
    - name: "exclude_paying_players"
      expr: exclude_paying_players
      comment: "Whether placement excludes paying players from seeing ads"
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward granted for rewarded ad placements"
    - name: "geographic_availability"
      expr: geographic_availability
      comment: "Geographic regions where placement is available"
  measures:
    - name: "total_placements"
      expr: COUNT(1)
      comment: "Total number of ad placements configured"
    - name: "active_placements"
      expr: SUM(CASE WHEN placement_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active ad placements"
    - name: "total_lifetime_impressions"
      expr: SUM(CAST(lifetime_impressions AS BIGINT))
      comment: "Total lifetime impressions across all placements"
    - name: "total_lifetime_clicks"
      expr: SUM(CAST(lifetime_clicks AS BIGINT))
      comment: "Total lifetime clicks across all placements"
    - name: "total_lifetime_revenue_usd"
      expr: SUM(CAST(lifetime_revenue_usd AS DOUBLE))
      comment: "Total lifetime revenue in USD across all placements"
    - name: "avg_ecpm_usd"
      expr: AVG(CAST(average_ecpm_usd AS DOUBLE))
      comment: "Average eCPM in USD across placements"
    - name: "avg_ctr_pct"
      expr: AVG(CAST(average_ctr_pct AS DOUBLE))
      comment: "Average click-through rate percentage across placements"
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_pct AS DOUBLE))
      comment: "Average fill rate target percentage for placements"
    - name: "mediation_enabled_placements"
      expr: SUM(CASE WHEN mediation_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of placements with ad mediation enabled"
    - name: "coppa_compliant_placements"
      expr: SUM(CASE WHEN coppa_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of COPPA-compliant placements"
$$;
