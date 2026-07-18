-- Metric views for domain: pricing | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for coupon portfolio management — tracks discount exposure, coupon mix, and financial liability from active promotional instruments."
  source: "`ecommerce_ecm`.`pricing`.`coupon`"
  dimensions:
    - name: "coupon_type"
      expr: coupon_type
      comment: "Type of coupon (e.g., percentage, fixed-amount, BOGO) used to segment discount strategy."
    - name: "discount_type"
      expr: discount_type
      comment: "Mechanism of the discount (e.g., flat, percentage) for financial exposure analysis."
    - name: "coupon_status"
      expr: coupon_status
      comment: "Lifecycle status of the coupon (active, expired, suspended) for portfolio health monitoring."
    - name: "issuance_channel"
      expr: issuance_channel
      comment: "Channel through which the coupon was distributed (email, app, in-store) for channel effectiveness analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the coupon discount for multi-currency financial reporting."
    - name: "is_stackable"
      expr: is_stackable
      comment: "Whether the coupon can be combined with other promotions — flags compounding discount risk."
    - name: "is_one_time_use"
      expr: is_one_time_use
      comment: "Whether the coupon is single-use, informing redemption velocity expectations."
    - name: "coupon_start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the coupon became active, used for cohort and seasonality analysis."
    - name: "coupon_expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_timestamp)
      comment: "Month the coupon expires, used to forecast discount liability runoff."
  measures:
    - name: "total_active_coupons"
      expr: COUNT(CASE WHEN coupon_status = 'active' THEN coupon_id END)
      comment: "Count of currently active coupons — baseline measure of live promotional exposure."
    - name: "total_discount_amount_exposure"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total fixed discount amount across all coupons — measures maximum financial liability from flat-value coupons."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average fixed discount value per coupon — benchmarks generosity of discount offers."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average percentage discount across coupons — key indicator of margin erosion risk from promotional activity."
    - name: "total_max_discount_cap_exposure"
      expr: SUM(CAST(max_discount_amount AS DOUBLE))
      comment: "Sum of maximum discount caps across all coupons — upper-bound financial liability for percentage-based coupons."
    - name: "avg_min_order_threshold"
      expr: AVG(CAST(min_order_amount AS DOUBLE))
      comment: "Average minimum order value required to redeem a coupon — measures how well coupons are gating basket size uplift."
    - name: "stackable_coupon_count"
      expr: COUNT(CASE WHEN is_stackable = TRUE THEN coupon_id END)
      comment: "Number of stackable coupons — high values indicate compounding discount risk requiring governance review."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_coupon_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for coupon redemption activity — tracks redemption volume, discount value delivered, fraud exposure, and channel performance."
  source: "`ecommerce_ecm`.`pricing`.`coupon_redemption`"
  dimensions:
    - name: "coupon_redemption_status"
      expr: coupon_redemption_status
      comment: "Status of the redemption event (successful, reversed, pending) for operational quality monitoring."
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (online, in-store, app) for channel attribution analysis."
    - name: "channel"
      expr: channel
      comment: "Sales channel where the coupon was redeemed — used to evaluate channel-level promotional ROI."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption discount for multi-currency financial reporting."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the redemption was flagged as potentially fraudulent — critical for risk management."
    - name: "source_system"
      expr: source_system
      comment: "Originating system of the redemption record for data lineage and reconciliation."
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of redemption for trend analysis and promotional campaign performance tracking."
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of coupon redemption events — baseline volume metric for promotional uptake."
    - name: "total_discount_delivered"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value delivered through coupon redemptions — direct measure of promotional cost to the business."
    - name: "avg_discount_per_redemption"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per redemption event — benchmarks per-transaction promotional generosity."
    - name: "fraudulent_redemption_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN coupon_redemption_id END)
      comment: "Number of redemptions flagged as fraudulent — key risk metric for coupon abuse governance."
    - name: "fraud_redemption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN coupon_redemption_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of redemptions flagged as fraudulent — executive risk indicator for coupon program integrity."
    - name: "distinct_customers_redeeming"
      expr: COUNT(DISTINCT customer_profile_id)
      comment: "Number of unique customers who redeemed a coupon — measures promotional reach and customer engagement breadth."
    - name: "distinct_coupons_redeemed"
      expr: COUNT(DISTINCT coupon_id)
      comment: "Number of distinct coupon instruments redeemed — indicates breadth of active promotional portfolio utilization."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_dynamic_price_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governance and performance KPIs for dynamic pricing rules — tracks rule coverage, price band configuration, compliance posture, and elasticity-driven pricing strategy."
  source: "`ecommerce_ecm`.`pricing`.`dynamic_price_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Classification of the dynamic pricing rule (e.g., competitive, demand-based) for strategy segmentation."
    - name: "rule_status"
      expr: rule_status
      comment: "Lifecycle status of the rule (active, draft, archived) for operational governance."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of price adjustment (increase, decrease, fixed) applied by the rule."
    - name: "adjustment_unit"
      expr: adjustment_unit
      comment: "Unit of the adjustment (percentage, absolute) for financial impact classification."
    - name: "rule_category"
      expr: rule_category
      comment: "Business category of the rule (e.g., clearance, competitive response) for portfolio segmentation."
    - name: "is_active"
      expr: is_active
      comment: "Whether the rule is currently active — used to filter live pricing logic from historical rules."
    - name: "is_experimental"
      expr: is_experimental
      comment: "Flags rules in A/B test or experimental mode — important for separating production from test pricing."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether the rule has passed compliance review — critical for regulatory and legal risk management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency context of the pricing rule for multi-market analysis."
    - name: "rule_effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the rule became effective — used for rule lifecycle and adoption trend analysis."
  measures:
    - name: "total_active_rules"
      expr: COUNT(CASE WHEN is_active = TRUE THEN dynamic_price_rule_id END)
      comment: "Count of currently active dynamic pricing rules — baseline measure of live pricing automation coverage."
    - name: "avg_price_floor"
      expr: AVG(CAST(floor_price AS DOUBLE))
      comment: "Average floor price across dynamic pricing rules — indicates the minimum price protection level across the portfolio."
    - name: "avg_price_ceiling"
      expr: AVG(CAST(ceiling_price AS DOUBLE))
      comment: "Average ceiling price across dynamic pricing rules — indicates the maximum price cap protecting customer trust."
    - name: "avg_price_band_width"
      expr: AVG(CAST(ceiling_price AS DOUBLE) - CAST(floor_price AS DOUBLE))
      comment: "Average width of the price band (ceiling minus floor) per rule — wider bands indicate greater pricing flexibility and volatility risk."
    - name: "avg_adjustment_value"
      expr: AVG(CAST(adjustment_value AS DOUBLE))
      comment: "Average adjustment value applied by dynamic pricing rules — measures typical magnitude of automated price changes."
    - name: "total_rule_executions"
      expr: SUM(CAST(execution_count AS DOUBLE))
      comment: "Total number of times dynamic pricing rules have been executed — measures automation throughput and rule utilization."
    - name: "avg_price_elasticity_score"
      expr: AVG(CAST(price_elasticity_score AS DOUBLE))
      comment: "Average price elasticity score across rules — higher scores indicate rules targeting more elastic demand segments."
    - name: "non_compliant_rule_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN dynamic_price_rule_id END)
      comment: "Number of dynamic pricing rules failing compliance checks — critical governance metric for regulatory risk."
    - name: "experimental_rule_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_experimental = TRUE THEN dynamic_price_rule_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rules in experimental/test mode — high values may indicate insufficient production-grade pricing coverage."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_price_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price change analytics KPIs — tracks frequency, magnitude, and direction of price movements to inform pricing strategy, volatility governance, and manual override risk."
  source: "`ecommerce_ecm`.`pricing`.`price_history`"
  dimensions:
    - name: "price_change_type"
      expr: price_change_type
      comment: "Type of price change event (increase, decrease, correction) for directional trend analysis."
    - name: "change_reason"
      expr: change_reason
      comment: "Business reason for the price change (e.g., competitive response, cost increase) for root-cause analysis."
    - name: "is_manual_override"
      expr: is_manual_override
      comment: "Flags manually overridden prices vs. system-driven changes — key governance dimension for pricing discipline."
    - name: "initiated_by_system"
      expr: initiated_by_system
      comment: "System that triggered the price change — used for attribution and automation coverage analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price change for multi-market financial reporting."
    - name: "price_change_month"
      expr: DATE_TRUNC('MONTH', effective_timestamp)
      comment: "Month the price change took effect — used for trend and seasonality analysis of pricing activity."
  measures:
    - name: "total_price_changes"
      expr: COUNT(1)
      comment: "Total number of price change events — baseline measure of pricing activity volume and volatility."
    - name: "total_price_change_amount"
      expr: SUM(CAST(price_change_amount AS DOUBLE))
      comment: "Net sum of all price change amounts — positive values indicate net price inflation; negative values indicate net deflation across the portfolio."
    - name: "avg_price_change_amount"
      expr: AVG(CAST(price_change_amount AS DOUBLE))
      comment: "Average magnitude of price changes — benchmarks typical price adjustment size for volatility governance."
    - name: "avg_price_before"
      expr: AVG(CAST(price_before AS DOUBLE))
      comment: "Average pre-change price across all price history records — baseline for measuring pricing level trends."
    - name: "avg_price_after"
      expr: AVG(CAST(price_after AS DOUBLE))
      comment: "Average post-change price across all price history records — compared with avg_price_before to assess net pricing direction."
    - name: "manual_override_count"
      expr: COUNT(CASE WHEN is_manual_override = TRUE THEN price_history_id END)
      comment: "Number of price changes driven by manual overrides — high counts signal governance risk and potential pricing inconsistency."
    - name: "manual_override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual_override = TRUE THEN price_history_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of price changes that are manual overrides — executive KPI for pricing automation maturity and governance discipline."
    - name: "distinct_skus_repriced"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs that experienced a price change — measures breadth of pricing activity across the product catalog."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_price_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price list portfolio KPIs — tracks pricing tier coverage, discount allowance, elasticity configuration, and price range governance across market segments."
  source: "`ecommerce_ecm`.`pricing`.`price_list`"
  dimensions:
    - name: "price_list_status"
      expr: price_list_status
      comment: "Lifecycle status of the price list (active, draft, expired) for portfolio health monitoring."
    - name: "price_type"
      expr: price_type
      comment: "Type of pricing (retail, wholesale, promotional) for segment-level pricing strategy analysis."
    - name: "price_tier"
      expr: price_tier
      comment: "Pricing tier (e.g., standard, premium, budget) for tiered pricing strategy governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price list for multi-currency market analysis."
    - name: "region"
      expr: region
      comment: "Geographic region the price list applies to — used for regional pricing strategy comparison."
    - name: "discount_allowed_flag"
      expr: discount_allowed_flag
      comment: "Whether discounts are permitted on this price list — governs promotional eligibility."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Indicates whether the price list is promotional in nature — used to separate baseline from promotional pricing."
    - name: "tax_included_flag"
      expr: tax_included_flag
      comment: "Whether prices on this list are tax-inclusive — critical for revenue recognition and compliance reporting."
    - name: "price_source"
      expr: price_source
      comment: "Origin of the pricing data (e.g., cost-plus, market-based) for pricing methodology governance."
    - name: "price_list_effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the price list became effective — used for pricing lifecycle and adoption trend analysis."
  measures:
    - name: "total_active_price_lists"
      expr: COUNT(CASE WHEN price_list_status = 'active' THEN price_list_id END)
      comment: "Count of currently active price lists — baseline measure of live pricing configuration coverage."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across all price lists — benchmarks the central pricing level across the portfolio."
    - name: "avg_min_price"
      expr: AVG(CAST(min_price AS DOUBLE))
      comment: "Average minimum allowable price across price lists — measures floor price protection across the portfolio."
    - name: "avg_max_price"
      expr: AVG(CAST(max_price AS DOUBLE))
      comment: "Average maximum allowable price across price lists — measures ceiling price governance across the portfolio."
    - name: "avg_price_range_width"
      expr: AVG(CAST(max_price AS DOUBLE) - CAST(min_price AS DOUBLE))
      comment: "Average width of the allowed price range (max minus min) per price list — wider ranges indicate greater pricing flexibility and volatility risk."
    - name: "avg_price_elasticity"
      expr: AVG(CAST(price_elasticity AS DOUBLE))
      comment: "Average price elasticity configured across price lists — informs demand sensitivity assumptions embedded in pricing strategy."
    - name: "discount_eligible_price_list_count"
      expr: COUNT(CASE WHEN discount_allowed_flag = TRUE THEN price_list_id END)
      comment: "Number of price lists where discounting is permitted — measures promotional exposure breadth across the pricing portfolio."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_price_list_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level pricing KPIs — tracks base price levels, promotional pricing, bundle discounts, volume incentives, and tax configuration across individual price list entries."
  source: "`ecommerce_ecm`.`pricing`.`price_list_item`"
  dimensions:
    - name: "price_list_item_status"
      expr: price_list_item_status
      comment: "Lifecycle status of the price list item (active, expired, draft) for catalog pricing health monitoring."
    - name: "price_type"
      expr: price_type
      comment: "Type of price (retail, wholesale, promotional) for pricing strategy segmentation at SKU level."
    - name: "price_source"
      expr: price_source
      comment: "Origin of the price (cost-plus, market, manual) for pricing methodology governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price list item for multi-currency financial reporting."
    - name: "is_promotional"
      expr: is_promotional
      comment: "Whether the item is priced promotionally — used to separate baseline from promotional pricing in margin analysis."
    - name: "tax_inclusive"
      expr: tax_inclusive
      comment: "Whether the price includes tax — critical for revenue recognition and compliance reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the priced item — used for price-per-unit normalization and comparability."
    - name: "price_change_reason"
      expr: price_change_reason
      comment: "Reason for the most recent price change on this item — used for root-cause analysis of pricing movements."
    - name: "item_effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the price list item became effective — used for pricing lifecycle trend analysis."
  measures:
    - name: "total_priced_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with an active price list entry — measures catalog pricing coverage."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across all price list items — benchmarks the central pricing level across the SKU catalog."
    - name: "avg_tier_price"
      expr: AVG(CAST(tier_price AS DOUBLE))
      comment: "Average tier price across price list items — measures the typical price point for volume-tiered customers."
    - name: "avg_bundle_discount_pct"
      expr: AVG(CAST(bundle_discount_percent AS DOUBLE))
      comment: "Average bundle discount percentage across price list items — measures the typical incentive offered for bundle purchases."
    - name: "avg_volume_discount_pct"
      expr: AVG(CAST(volume_discount_percent AS DOUBLE))
      comment: "Average volume discount percentage — measures the typical incentive for bulk purchasing across the catalog."
    - name: "avg_tax_rate_pct"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average tax rate applied across price list items — used for tax liability estimation and compliance reporting."
    - name: "avg_price_elasticity_score"
      expr: AVG(CAST(price_elasticity_score AS DOUBLE))
      comment: "Average price elasticity score at SKU level — informs demand sensitivity and optimal pricing decisions per product."
    - name: "promotional_item_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_promotional = TRUE THEN price_list_item_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of price list items currently priced promotionally — measures promotional depth across the catalog."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_price_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price override governance KPIs — tracks frequency, magnitude, and approval posture of manual price overrides to manage pricing discipline and compliance risk."
  source: "`ecommerce_ecm`.`pricing`.`price_override`"
  dimensions:
    - name: "override_type"
      expr: override_type
      comment: "Type of price override (customer-specific, order-level, SKU-level) for governance segmentation."
    - name: "price_override_status"
      expr: price_override_status
      comment: "Status of the override (pending, approved, rejected) for approval workflow monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval decision on the override — used to track compliance with pricing authorization policies."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the override (e.g., competitive match, error correction) for root-cause analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the override for multi-currency financial reporting."
    - name: "is_active"
      expr: is_active
      comment: "Whether the override is currently in effect — used to filter live overrides from historical records."
    - name: "scope"
      expr: scope
      comment: "Scope of the override (global, regional, customer-specific) for impact assessment."
    - name: "source_system"
      expr: source_system
      comment: "System that originated the override request — used for data lineage and process attribution."
    - name: "override_applied_month"
      expr: DATE_TRUNC('MONTH', applied_timestamp)
      comment: "Month the override was applied — used for trend analysis of manual pricing intervention frequency."
  measures:
    - name: "total_price_overrides"
      expr: COUNT(1)
      comment: "Total number of price override events — baseline measure of manual pricing intervention volume."
    - name: "total_price_reduction_from_overrides"
      expr: SUM(CAST(price_change_amount AS DOUBLE))
      comment: "Net sum of price change amounts from overrides — negative values indicate net revenue leakage from manual discounting."
    - name: "avg_override_discount_amount"
      expr: AVG(CAST(price_change_amount AS DOUBLE))
      comment: "Average price change per override event — benchmarks the typical magnitude of manual pricing interventions."
    - name: "avg_override_discount_pct"
      expr: AVG(CAST(price_change_percentage AS DOUBLE))
      comment: "Average percentage price change per override — measures typical depth of manual discounting relative to original price."
    - name: "avg_original_price"
      expr: AVG(CAST(original_price AS DOUBLE))
      comment: "Average original price before override — provides baseline context for assessing override magnitude."
    - name: "avg_overridden_price"
      expr: AVG(CAST(overridden_price AS DOUBLE))
      comment: "Average price after override — compared with avg_original_price to assess net pricing impact of overrides."
    - name: "pending_approval_override_count"
      expr: COUNT(CASE WHEN approval_status = 'pending' THEN price_override_id END)
      comment: "Number of overrides awaiting approval — operational metric for pricing governance queue management."
    - name: "override_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'approved' THEN price_override_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of price overrides that received approval — measures pricing governance effectiveness and policy adherence."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_promotional_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotional campaign financial and operational KPIs — tracks budget deployment, discount value, redemption utilization, and GMV target attainment across campaigns."
  source: "`ecommerce_ecm`.`pricing`.`promotional_campaign`"
  dimensions:
    - name: "promotional_campaign_status"
      expr: promotional_campaign_status
      comment: "Lifecycle status of the campaign (active, completed, paused) for portfolio health monitoring."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of promotional campaign (flash sale, loyalty, seasonal) for strategy segmentation."
    - name: "discount_type"
      expr: discount_type
      comment: "Mechanism of the campaign discount (percentage, fixed, BOGO) for financial impact classification."
    - name: "channel"
      expr: channel
      comment: "Sales channel the campaign targets (email, app, web) for channel-level ROI analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the campaign (global, regional, local) for market-level performance analysis."
    - name: "region_code"
      expr: region_code
      comment: "Region code for the campaign — used for regional promotional spend and performance comparison."
    - name: "is_a_b_test"
      expr: is_a_b_test
      comment: "Whether the campaign is an A/B test — used to separate experimental from production campaigns in reporting."
    - name: "owning_business_unit"
      expr: owning_business_unit
      comment: "Business unit responsible for the campaign — used for cost allocation and accountability reporting."
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the campaign started — used for cohort and seasonality analysis of promotional activity."
  measures:
    - name: "total_campaign_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total promotional budget committed across campaigns — measures total financial investment in promotional activity."
    - name: "avg_campaign_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per promotional campaign — benchmarks typical campaign investment size for planning."
    - name: "total_gmv_target"
      expr: SUM(CAST(gmv_target AS DOUBLE))
      comment: "Total GMV target across all campaigns — measures the aggregate revenue ambition of the promotional portfolio."
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Total discount value committed across campaigns — measures aggregate promotional cost liability."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per campaign — benchmarks typical promotional generosity for margin impact assessment."
    - name: "total_usage_count"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Total redemption/usage count across all campaigns — measures aggregate promotional uptake volume."
    - name: "total_redemption_limit"
      expr: SUM(CAST(redemption_total_limit AS DOUBLE))
      comment: "Total redemption capacity committed across campaigns — used to assess promotional supply vs. demand balance."
    - name: "redemption_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(usage_count AS DOUBLE)) / NULLIF(SUM(CAST(redemption_total_limit AS DOUBLE)), 0), 2)
      comment: "Percentage of total redemption capacity that has been utilized — key efficiency KPI for promotional campaign performance."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN promotional_campaign_status = 'active' THEN promotional_campaign_id END)
      comment: "Number of currently active promotional campaigns — baseline measure of live promotional portfolio size."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_promotion_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion rule effectiveness KPIs — tracks discount configuration, redemption utilization, and rule coverage across the promotional rules engine."
  source: "`ecommerce_ecm`.`pricing`.`promotion_rule`"
  dimensions:
    - name: "promotion_rule_status"
      expr: promotion_rule_status
      comment: "Lifecycle status of the promotion rule (active, expired, draft) for portfolio governance."
    - name: "rule_type"
      expr: rule_type
      comment: "Type of promotion rule (cart-level, SKU-level, category-level) for strategy segmentation."
    - name: "discount_unit"
      expr: discount_unit
      comment: "Unit of the discount (percentage, absolute) for financial impact classification."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the rule is exclusive (cannot be combined with other promotions) — governs stacking risk."
    - name: "stackable"
      expr: stackable
      comment: "Whether the rule can be stacked with other promotions — high stackable counts indicate compounding discount risk."
    - name: "rule_effective_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the promotion rule became effective — used for rule lifecycle and adoption trend analysis."
  measures:
    - name: "total_active_promotion_rules"
      expr: COUNT(CASE WHEN promotion_rule_status = 'active' THEN promotion_rule_id END)
      comment: "Count of currently active promotion rules — baseline measure of live promotional rules engine coverage."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value configured across promotion rules — benchmarks typical promotional generosity."
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Total discount value configured across all promotion rules — measures aggregate promotional liability from the rules engine."
    - name: "avg_minimum_cart_value"
      expr: AVG(CAST(minimum_cart_value AS DOUBLE))
      comment: "Average minimum cart value required to trigger a promotion rule — measures how well rules are gating basket size uplift."
    - name: "stackable_rule_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stackable = TRUE THEN promotion_rule_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of promotion rules that are stackable — high values indicate compounding discount risk requiring governance review."
    - name: "distinct_campaigns_covered"
      expr: COUNT(DISTINCT promotional_campaign_id)
      comment: "Number of distinct promotional campaigns covered by promotion rules — measures rules engine breadth across the campaign portfolio."
$$;


CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`pricing_markdown_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown schedule KPIs — tracks markdown depth, schedule coverage, and execution frequency to govern clearance and promotional markdown strategy."
  source: "`ecommerce_ecm`.`pricing`.`markdown_schedule`"
  dimensions:
    - name: "markdown_schedule_status"
      expr: markdown_schedule_status
      comment: "Lifecycle status of the markdown schedule (active, completed, cancelled) for portfolio health monitoring."
    - name: "markdown_type"
      expr: markdown_type
      comment: "Type of markdown (clearance, seasonal, promotional) for strategy segmentation."
    - name: "channel"
      expr: channel
      comment: "Sales channel the markdown applies to — used for channel-level markdown impact analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Specific sales channel for the markdown — provides granular channel attribution for markdown ROI analysis."
    - name: "market_region"
      expr: market_region
      comment: "Market region the markdown applies to — used for regional markdown strategy comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the markdown value for multi-currency financial reporting."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the markdown is exclusive to a specific segment or channel — governs promotional stacking risk."
    - name: "is_test"
      expr: is_test
      comment: "Whether the markdown schedule is a test run — used to separate experimental from production markdowns."
    - name: "markdown_effective_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the markdown schedule became effective — used for seasonality and trend analysis of markdown activity."
  measures:
    - name: "total_active_markdown_schedules"
      expr: COUNT(CASE WHEN markdown_schedule_status = 'active' THEN markdown_schedule_id END)
      comment: "Count of currently active markdown schedules — baseline measure of live markdown coverage across the catalog."
    - name: "avg_markdown_value"
      expr: AVG(CAST(markdown_value AS DOUBLE))
      comment: "Average markdown value (discount amount or percentage) across schedules — benchmarks typical markdown depth for margin impact assessment."
    - name: "total_markdown_value"
      expr: SUM(CAST(markdown_value AS DOUBLE))
      comment: "Total markdown value committed across all schedules — measures aggregate financial exposure from markdown activity."
    - name: "distinct_price_lists_marked_down"
      expr: COUNT(DISTINCT price_list_id)
      comment: "Number of distinct price lists with an active markdown schedule — measures breadth of markdown coverage across the pricing portfolio."
    - name: "test_markdown_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_test = TRUE THEN markdown_schedule_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of markdown schedules that are test runs — high values may indicate insufficient production markdown deployment."
$$;
