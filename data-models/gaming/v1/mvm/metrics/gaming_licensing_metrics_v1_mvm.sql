-- Metric views for domain: licensing | Business: Gaming | Version: 1 | Generated on: 2026-05-08 09:42:21

CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_iap_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-app purchase transaction metrics tracking revenue, conversion, and player monetization behavior across platforms and content releases"
  source: "`gaming_ecm`.`licensing`.`iap_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', purchased_at)
      comment: "Day of purchase transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', purchased_at)
      comment: "Month of purchase transaction"
    - name: "platform"
      expr: platform
      comment: "Platform where transaction occurred (iOS, Android, PC, Console)"
    - name: "item_type"
      expr: item_type
      comment: "Type of item purchased (currency, cosmetic, battle_pass, loot_box, etc.)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of transaction (completed, pending, refunded, failed)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (credit_card, paypal, mobile_carrier, etc.)"
    - name: "player_country_code"
      expr: player_country_code
      comment: "Country code of purchasing player"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code of transaction"
    - name: "is_first_purchase"
      expr: is_first_purchase
      comment: "Flag indicating if this is player's first purchase"
    - name: "is_f2p_conversion"
      expr: is_f2p_conversion
      comment: "Flag indicating if this purchase converted a free-to-play player"
    - name: "is_whale"
      expr: is_whale
      comment: "Flag indicating if player is classified as high-value whale"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for purchase"
  measures:
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue from IAP transactions before platform fees and taxes"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_proceeds_amount AS DOUBLE))
      comment: "Total net revenue after platform fees and deductions"
    - name: "total_platform_fees"
      expr: SUM(CAST(platform_fee_amount AS DOUBLE))
      comment: "Total platform fees paid to storefronts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on transactions"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to transactions"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of IAP transactions"
    - name: "unique_purchasers"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Count of unique players who made purchases"
    - name: "avg_transaction_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross transaction value per purchase"
    - name: "avg_net_transaction_value"
      expr: AVG(CAST(net_proceeds_amount AS DOUBLE))
      comment: "Average net transaction value after fees"
    - name: "avg_platform_fee_rate"
      expr: AVG(CAST(platform_fee_rate AS DOUBLE))
      comment: "Average platform fee rate as percentage"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied to transactions"
    - name: "first_purchase_count"
      expr: SUM(CASE WHEN is_first_purchase = TRUE THEN 1 ELSE 0 END)
      comment: "Count of first-time purchase transactions"
    - name: "f2p_conversion_count"
      expr: SUM(CASE WHEN is_f2p_conversion = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions that converted free-to-play players"
    - name: "whale_transaction_count"
      expr: SUM(CASE WHEN is_whale = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions from high-value whale players"
    - name: "refund_count"
      expr: SUM(CASE WHEN transaction_status = 'refunded' THEN 1 ELSE 0 END)
      comment: "Count of refunded transactions"
    - name: "total_virtual_currency_awarded"
      expr: SUM(CAST(virtual_currency_awarded AS DOUBLE))
      comment: "Total virtual currency awarded across all transactions"
    - name: "total_bonus_virtual_currency"
      expr: SUM(CAST(bonus_virtual_currency AS DOUBLE))
      comment: "Total bonus virtual currency awarded as promotions"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_royalty_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty reporting metrics tracking IP licensing revenue, royalty calculations, and payment obligations to licensors"
  source: "`gaming_ecm`.`licensing`.`royalty_report`"
  dimensions:
    - name: "reporting_period_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Month of royalty reporting period"
    - name: "reporting_period_quarter"
      expr: DATE_TRUNC('quarter', reporting_period_start_date)
      comment: "Quarter of royalty reporting period"
    - name: "report_status"
      expr: report_status
      comment: "Status of royalty report (draft, submitted, approved, disputed, paid)"
    - name: "report_type"
      expr: report_type
      comment: "Type of royalty report (quarterly, annual, milestone, etc.)"
    - name: "platform"
      expr: platform
      comment: "Platform for which royalties are reported"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for royalty amounts"
    - name: "audit_flag"
      expr: audit_flag
      comment: "Flag indicating if report is flagged for audit"
  measures:
    - name: "total_reported_gross_revenue"
      expr: SUM(CAST(reported_gross_revenue AS DOUBLE))
      comment: "Total gross revenue reported for royalty calculation"
    - name: "total_reported_net_revenue"
      expr: SUM(CAST(reported_net_revenue AS DOUBLE))
      comment: "Total net revenue after deductions for royalty calculation"
    - name: "total_reported_deductions"
      expr: SUM(CAST(reported_deductions AS DOUBLE))
      comment: "Total deductions applied to gross revenue"
    - name: "total_calculated_royalty"
      expr: SUM(CAST(calculated_royalty_amount AS DOUBLE))
      comment: "Total royalty amount calculated based on applicable rates"
    - name: "total_minimum_guarantee_credit"
      expr: SUM(CAST(minimum_guarantee_credit AS DOUBLE))
      comment: "Total minimum guarantee credits applied against royalties"
    - name: "total_net_royalty_payable"
      expr: SUM(CAST(net_royalty_payable AS DOUBLE))
      comment: "Total net royalty amount payable after all adjustments"
    - name: "total_unit_sales"
      expr: SUM(CAST(reported_unit_sales AS DOUBLE))
      comment: "Total unit sales reported across all royalty reports"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(applicable_royalty_rate AS DOUBLE))
      comment: "Average royalty rate percentage applied"
    - name: "report_count"
      expr: COUNT(1)
      comment: "Total number of royalty reports"
    - name: "unique_ip_agreements"
      expr: COUNT(DISTINCT ip_agreement_id)
      comment: "Count of unique IP agreements with royalty reports"
    - name: "unique_licensees"
      expr: COUNT(DISTINCT licensee_id)
      comment: "Count of unique licensees with royalty reports"
    - name: "audit_flagged_count"
      expr: SUM(CASE WHEN audit_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reports flagged for audit review"
    - name: "disputed_report_count"
      expr: SUM(CASE WHEN report_status = 'disputed' THEN 1 ELSE 0 END)
      comment: "Count of disputed royalty reports"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_virtual_currency_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Virtual currency economy metrics tracking earn, spend, and balance flows across player accounts and game systems"
  source: "`gaming_ecm`.`licensing`.`virtual_currency_ledger`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Day of virtual currency transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of virtual currency transaction"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of ledger entry (earn, spend, grant, refund, expiry, etc.)"
    - name: "transaction_source"
      expr: transaction_source
      comment: "Source system or feature that generated the transaction"
    - name: "transaction_source_category"
      expr: transaction_source_category
      comment: "Category of transaction source (gameplay, purchase, promotion, etc.)"
    - name: "currency_type"
      expr: currency_type
      comment: "Type of virtual currency (premium, soft, event, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code identifier"
    - name: "player_segment"
      expr: player_segment
      comment: "Player segment at time of transaction"
    - name: "country_code"
      expr: country_code
      comment: "Country code of player"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for transaction"
    - name: "is_first_purchase"
      expr: is_first_purchase
      comment: "Flag indicating if transaction is player's first purchase"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag indicating if transaction is a reversal"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Flag indicating potential fraud"
    - name: "ledger_entry_status"
      expr: ledger_entry_status
      comment: "Status of ledger entry (posted, pending, reversed, etc.)"
  measures:
    - name: "total_currency_earned"
      expr: SUM(CASE WHEN CAST(delta_amount AS DOUBLE) > 0 THEN CAST(delta_amount AS DOUBLE) ELSE 0 END)
      comment: "Total virtual currency earned (positive deltas only)"
    - name: "total_currency_spent"
      expr: SUM(CASE WHEN CAST(delta_amount AS DOUBLE) < 0 THEN ABS(CAST(delta_amount AS DOUBLE)) ELSE 0 END)
      comment: "Total virtual currency spent (absolute value of negative deltas)"
    - name: "net_currency_flow"
      expr: SUM(CAST(delta_amount AS DOUBLE))
      comment: "Net virtual currency flow (earned minus spent)"
    - name: "total_bonus_currency"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total bonus virtual currency awarded"
    - name: "total_real_money_value"
      expr: SUM(CAST(real_money_amount AS DOUBLE))
      comment: "Total real money value associated with virtual currency transactions"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of virtual currency ledger entries"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Count of unique players with virtual currency transactions"
    - name: "unique_currency_accounts"
      expr: COUNT(DISTINCT virtual_currency_account_id)
      comment: "Count of unique virtual currency accounts with activity"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(delta_amount AS DOUBLE))
      comment: "Average virtual currency amount per transaction"
    - name: "avg_balance_after"
      expr: AVG(CAST(balance_after AS DOUBLE))
      comment: "Average player balance after transactions"
    - name: "avg_exchange_rate_to_usd"
      expr: AVG(CAST(exchange_rate_to_usd AS DOUBLE))
      comment: "Average exchange rate of virtual currency to USD"
    - name: "first_purchase_transaction_count"
      expr: SUM(CASE WHEN is_first_purchase = TRUE THEN 1 ELSE 0 END)
      comment: "Count of first purchase transactions"
    - name: "reversal_count"
      expr: SUM(CASE WHEN is_reversal = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversal transactions"
    - name: "fraud_flagged_count"
      expr: SUM(CASE WHEN fraud_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions flagged for fraud"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_battle_pass_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Battle pass engagement and monetization metrics tracking player progression, completion, and premium conversion"
  source: "`gaming_ecm`.`licensing`.`battle_pass_entitlement`"
  dimensions:
    - name: "purchase_date"
      expr: DATE_TRUNC('day', purchase_timestamp)
      comment: "Day of battle pass purchase"
    - name: "purchase_month"
      expr: DATE_TRUNC('month', purchase_timestamp)
      comment: "Month of battle pass purchase"
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Status of battle pass entitlement (active, expired, completed, refunded)"
    - name: "track_type"
      expr: track_type
      comment: "Type of battle pass track (free, premium, premium_plus)"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which battle pass was acquired"
    - name: "country_code"
      expr: country_code
      comment: "Country code of player"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code of purchase"
    - name: "is_premium_active"
      expr: is_premium_active
      comment: "Flag indicating if premium track is active"
    - name: "is_completed"
      expr: is_completed
      comment: "Flag indicating if battle pass is completed"
    - name: "is_gifted"
      expr: is_gifted
      comment: "Flag indicating if battle pass was gifted"
    - name: "auto_renew_enabled"
      expr: auto_renew_enabled
      comment: "Flag indicating if auto-renewal is enabled"
    - name: "refund_status"
      expr: refund_status
      comment: "Refund status of battle pass"
  measures:
    - name: "total_purchase_revenue"
      expr: SUM(CAST(purchase_price_amount AS DOUBLE))
      comment: "Total revenue from battle pass purchases"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_purchase_amount AS DOUBLE))
      comment: "Total net revenue after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to purchases"
    - name: "total_tier_skip_spend"
      expr: SUM(CAST(tier_skip_spend_amount AS DOUBLE))
      comment: "Total revenue from tier skip purchases"
    - name: "entitlement_count"
      expr: COUNT(1)
      comment: "Total number of battle pass entitlements"
    - name: "unique_players"
      expr: COUNT(DISTINCT player_account_id)
      comment: "Count of unique players with battle pass entitlements"
    - name: "premium_entitlement_count"
      expr: SUM(CASE WHEN is_premium_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active premium battle pass entitlements"
    - name: "completed_pass_count"
      expr: SUM(CASE WHEN is_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of completed battle passes"
    - name: "gifted_pass_count"
      expr: SUM(CASE WHEN is_gifted = TRUE THEN 1 ELSE 0 END)
      comment: "Count of gifted battle passes"
    - name: "auto_renew_count"
      expr: SUM(CASE WHEN auto_renew_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of battle passes with auto-renewal enabled"
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price_amount AS DOUBLE))
      comment: "Average battle pass purchase price"
    - name: "avg_tier_skip_spend"
      expr: AVG(CAST(tier_skip_spend_amount AS DOUBLE))
      comment: "Average tier skip spending per entitlement"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_offer_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional campaign performance metrics tracking offer effectiveness, conversion, and revenue impact"
  source: "`gaming_ecm`.`licensing`.`offer_campaign`"
  dimensions:
    - name: "campaign_start_date"
      expr: DATE_TRUNC('day', campaign_start_timestamp)
      comment: "Day campaign started"
    - name: "campaign_start_month"
      expr: DATE_TRUNC('month', campaign_start_timestamp)
      comment: "Month campaign started"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Status of offer campaign (draft, active, paused, completed, cancelled)"
    - name: "offer_type"
      expr: offer_type
      comment: "Type of offer (discount, bundle, limited_time, flash_sale, etc.)"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (percentage, fixed_amount, bogo, etc.)"
    - name: "target_player_segment"
      expr: target_player_segment
      comment: "Player segment targeted by campaign"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for campaign"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating if campaign is recurring"
    - name: "compliance_review_status"
      expr: compliance_review_status
      comment: "Compliance review status of campaign"
    - name: "ab_test_variant"
      expr: ab_test_variant
      comment: "A/B test variant identifier"
  measures:
    - name: "total_campaign_revenue"
      expr: SUM(CAST(total_revenue_generated AS DOUBLE))
      comment: "Total revenue generated by offer campaigns"
    - name: "total_campaign_budget"
      expr: SUM(CAST(campaign_budget AS DOUBLE))
      comment: "Total budget allocated to campaigns"
    - name: "total_impressions"
      expr: SUM(CAST(total_impressions AS DOUBLE))
      comment: "Total impressions across all campaigns"
    - name: "total_redemptions"
      expr: SUM(CAST(total_redemptions AS DOUBLE))
      comment: "Total redemptions across all campaigns"
    - name: "avg_conversion_rate"
      expr: AVG(CAST(conversion_rate AS DOUBLE))
      comment: "Average conversion rate across campaigns"
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value offered"
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of offer campaigns"
    - name: "active_campaign_count"
      expr: SUM(CASE WHEN campaign_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active campaigns"
    - name: "recurring_campaign_count"
      expr: SUM(CASE WHEN is_recurring = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recurring campaigns"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_ip_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP licensing agreement metrics tracking contract value, royalty terms, and partnership performance"
  source: "`gaming_ecm`.`licensing`.`ip_agreement`"
  dimensions:
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month agreement became effective"
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month agreement expires"
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of IP agreement (draft, active, expired, terminated, renewed)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of IP agreement (brand_license, middleware, music, engine, etc.)"
    - name: "brand_partnership_type"
      expr: brand_partnership_type
      comment: "Type of brand partnership"
    - name: "royalty_structure_type"
      expr: royalty_structure_type
      comment: "Structure of royalty payments"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of royalty payments"
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Flag indicating if agreement is exclusive"
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Jurisdiction governing the agreement"
    - name: "renewal_negotiation_status"
      expr: renewal_negotiation_status
      comment: "Status of renewal negotiations"
  measures:
    - name: "total_minimum_guarantee"
      expr: SUM(CAST(minimum_guarantee_amount AS DOUBLE))
      comment: "Total minimum guarantee amounts across all agreements"
    - name: "avg_royalty_rate"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across agreements"
    - name: "agreement_count"
      expr: COUNT(1)
      comment: "Total number of IP agreements"
    - name: "active_agreement_count"
      expr: SUM(CASE WHEN agreement_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active agreements"
    - name: "exclusive_agreement_count"
      expr: SUM(CASE WHEN exclusivity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of exclusive agreements"
    - name: "unique_licensors"
      expr: COUNT(DISTINCT licensor_name)
      comment: "Count of unique licensors"
    - name: "unique_licensed_ips"
      expr: COUNT(DISTINCT licensed_ip_id)
      comment: "Count of unique licensed IPs"
$$;


CREATE OR REPLACE VIEW `gaming_ecm`.`_metrics`.`licensing_mtx_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Microtransaction catalog metrics tracking SKU performance, pricing, and lifecycle management"
  source: "`gaming_ecm`.`licensing`.`mtx_catalog`"
  dimensions:
    - name: "release_month"
      expr: DATE_TRUNC('month', release_date)
      comment: "Month SKU was released"
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month SKU became effective"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of SKU (active, deprecated, retired, etc.)"
    - name: "item_type"
      expr: item_type
      comment: "Type of microtransaction item"
    - name: "platform_availability"
      expr: platform_availability
      comment: "Platforms where item is available"
    - name: "is_giftable"
      expr: is_giftable
      comment: "Flag indicating if item can be gifted"
    - name: "is_sale_eligible"
      expr: is_sale_eligible
      comment: "Flag indicating if item is eligible for sales"
    - name: "loot_box_disclosure_required"
      expr: loot_box_disclosure_required
      comment: "Flag indicating if loot box disclosure is required"
    - name: "content_rating_esrb"
      expr: content_rating_esrb
      comment: "ESRB content rating"
    - name: "promo_discount_type"
      expr: promo_discount_type
      comment: "Type of promotional discount"
  measures:
    - name: "avg_base_price_usd"
      expr: AVG(CAST(base_price_usd AS DOUBLE))
      comment: "Average base price in USD across catalog items"
    - name: "avg_virtual_currency_cost"
      expr: AVG(CAST(virtual_currency_cost AS DOUBLE))
      comment: "Average virtual currency cost across items"
    - name: "avg_platform_fee_pct"
      expr: AVG(CAST(platform_fee_pct AS DOUBLE))
      comment: "Average platform fee percentage"
    - name: "avg_promo_discount_pct"
      expr: AVG(CAST(promo_discount_pct AS DOUBLE))
      comment: "Average promotional discount percentage"
    - name: "catalog_item_count"
      expr: COUNT(1)
      comment: "Total number of catalog items"
    - name: "active_item_count"
      expr: SUM(CASE WHEN lifecycle_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active catalog items"
    - name: "giftable_item_count"
      expr: SUM(CASE WHEN is_giftable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of giftable items"
    - name: "sale_eligible_item_count"
      expr: SUM(CASE WHEN is_sale_eligible = TRUE THEN 1 ELSE 0 END)
      comment: "Count of items eligible for sales"
    - name: "loot_box_item_count"
      expr: SUM(CASE WHEN loot_box_disclosure_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of items requiring loot box disclosure"
$$;
