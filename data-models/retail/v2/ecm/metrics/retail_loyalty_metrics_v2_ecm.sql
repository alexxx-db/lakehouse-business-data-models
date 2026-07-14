-- Metric views for domain: loyalty | Business: Retail | Version: 2 | Generated on: 2026-07-12 14:06:09

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core membership health and value metrics tracking active member base, spend, points economics, and tier distribution — the primary KPI layer for the loyalty program P&L."
  source: "`vibe_retail_v1`.`loyalty`.`loyalty_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the membership (active, suspended, closed, etc.) for cohort filtering."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled (in-store, online, mobile app, etc.) for acquisition channel analysis."
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for cohort and trend analysis of member acquisition."
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year of enrollment for annual cohort comparisons."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether the member holds VIP status, enabling VIP vs. standard member segmentation."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the membership has been flagged for fraudulent activity."
    - name: "language_preference"
      expr: language_preference
      comment: "Member's preferred language for localization and regional analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the member's spend and points are denominated."
    - name: "last_activity_month"
      expr: DATE_TRUNC('MONTH', last_activity_date)
      comment: "Month of last recorded activity for recency segmentation and churn risk analysis."
    - name: "tier_expiry_month"
      expr: DATE_TRUNC('MONTH', tier_expiry_date)
      comment: "Month when the current tier qualification expires, used for proactive retention campaigns."
  measures:
    - name: "total_active_members"
      expr: COUNT(CASE WHEN membership_status = 'active' THEN loyalty_membership_id END)
      comment: "Count of currently active loyalty members. Core KPI for program scale and health."
    - name: "total_members"
      expr: COUNT(loyalty_membership_id)
      comment: "Total count of all loyalty memberships regardless of status. Used for gross enrollment reporting."
    - name: "total_lifetime_spend"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Sum of total lifetime spend across all members. Directly measures the revenue contribution of the loyalty program."
    - name: "avg_lifetime_spend_per_member"
      expr: AVG(CAST(total_spend_amount AS DOUBLE))
      comment: "Average lifetime spend per loyalty member. Key indicator of member value and program ROI."
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total points ever earned across all members. Measures program engagement volume and liability accrual."
    - name: "total_lifetime_points_redeemed"
      expr: SUM(CAST(lifetime_points_redeemed AS DOUBLE))
      comment: "Total points ever redeemed across all members. Measures redemption activity and breakage baseline."
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Sum of outstanding points balances across all active members. Represents total unredeemed points liability."
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average outstanding points balance per member. Indicates engagement depth and potential redemption pressure."
    - name: "points_redemption_rate"
      expr: ROUND(100.0 * SUM(CAST(lifetime_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of earned points that have been redeemed. High rates indicate strong engagement; low rates indicate breakage opportunity or poor redemption UX."
    - name: "total_points_expiring_soon"
      expr: SUM(CAST(points_expiring_soon AS DOUBLE))
      comment: "Total points at risk of expiry in the near term. Drives urgency campaigns to stimulate redemption before breakage."
    - name: "vip_member_count"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN loyalty_membership_id END)
      comment: "Count of VIP-flagged members. VIP members typically drive disproportionate revenue and require dedicated retention investment."
    - name: "fraud_flagged_member_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN loyalty_membership_id END)
      comment: "Count of memberships flagged for fraud. Monitors program integrity and financial exposure from fraudulent point accrual."
    - name: "avg_points_expiring_soon_per_member"
      expr: AVG(CAST(points_expiring_soon AS DOUBLE))
      comment: "Average points expiring soon per member. Helps calibrate the scale of expiry-driven re-engagement campaigns."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular points economics metrics covering earn, burn, adjustments, and liability — the financial ledger of the loyalty program."
  source: "`vibe_retail_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points ledger entry (earn, redeem, adjust, expire, reverse) for transaction-type segmentation."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the ledger transaction (posted, pending, reversed) for reconciliation filtering."
    - name: "channel"
      expr: channel
      comment: "Channel through which the points transaction occurred (in-store, online, mobile, partner) for omnichannel analysis."
    - name: "is_promotional"
      expr: is_promotional
      comment: "Indicates whether the points were awarded under a promotional rule, enabling promotional vs. base earn analysis."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the points transaction for trend and seasonality analysis."
    - name: "transaction_year"
      expr: YEAR(transaction_timestamp)
      comment: "Year of the points transaction for annual comparison."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month when the points are set to expire, used for forward-looking liability management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the underlying transaction for multi-currency program analysis."
    - name: "source_reference_type"
      expr: source_reference_type
      comment: "Type of source event that triggered the points entry (order, partner transaction, adjustment, etc.)."
  measures:
    - name: "total_points_awarded"
      expr: SUM(CASE WHEN transaction_type = 'earn' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points awarded to members. Measures program generosity and accrual velocity."
    - name: "total_points_redeemed"
      expr: SUM(CASE WHEN transaction_type = 'redeem' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points redeemed by members. Measures redemption activity and member engagement with rewards."
    - name: "total_points_expired"
      expr: SUM(CASE WHEN transaction_type = 'expire' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points expired without redemption. Represents breakage — a direct financial benefit to the program but a risk to member satisfaction."
    - name: "total_points_adjusted"
      expr: SUM(CASE WHEN transaction_type = 'adjust' THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Total points added or removed via manual adjustments. High values may indicate operational issues or fraud remediation."
    - name: "total_points_liability_amount"
      expr: SUM(CAST(points_liability_amount AS DOUBLE))
      comment: "Total monetary liability represented by outstanding points. Critical for financial reporting and balance sheet provisioning."
    - name: "total_qualifying_spend"
      expr: SUM(CAST(qualifying_spend_amount AS DOUBLE))
      comment: "Total spend that qualified for points accrual. Measures the revenue base driving loyalty program engagement."
    - name: "avg_earn_multiplier"
      expr: AVG(CAST(earn_multiplier AS DOUBLE))
      comment: "Average earn multiplier applied across transactions. Indicates the blended generosity of the points program relative to base earn rate."
    - name: "avg_redemption_value_per_point"
      expr: AVG(CAST(redemption_value_per_point AS DOUBLE))
      comment: "Average monetary value delivered per point redeemed. Key metric for assessing reward value proposition and cost efficiency."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total transaction value in base currency across all ledger entries. Used for program-level revenue attribution."
    - name: "total_qualifying_points"
      expr: SUM(CAST(qualifying_points_amount AS DOUBLE))
      comment: "Total points that count toward tier qualification. Drives tier upgrade and maintenance decisions."
    - name: "breakage_rate_avg"
      expr: AVG(CAST(breakage_rate AS DOUBLE))
      comment: "Average breakage rate across ledger entries. Breakage is the proportion of points never redeemed — a key financial planning input."
    - name: "promotional_points_awarded"
      expr: SUM(CASE WHEN is_promotional = TRUE THEN CAST(points_amount AS DOUBLE) ELSE 0 END)
      comment: "Points awarded under promotional rules. Measures the incremental cost of promotional campaigns vs. base program earn."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption activity metrics measuring member reward utilization, monetary value delivered, fraud exposure, and fulfillment efficiency."
  source: "`vibe_retail_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "redemption_type"
      expr: redemption_type
      comment: "Type of redemption (points-for-discount, free-product, gift-card, partner-reward, etc.) for reward mix analysis."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Current status of the redemption (completed, cancelled, pending, reversed) for operational monitoring."
    - name: "channel"
      expr: channel
      comment: "Channel where the redemption occurred (in-store, online, mobile) for omnichannel redemption analysis."
    - name: "fulfillment_method"
      expr: fulfillment_method
      comment: "How the reward was fulfilled (instant, shipped, digital-delivery) for fulfillment cost and speed analysis."
    - name: "tier_at_redemption"
      expr: tier_at_redemption
      comment: "Member tier at the time of redemption. Enables tier-level redemption behavior analysis."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Indicates whether the redemption was determined to be fraudulent. Used for fraud rate monitoring."
    - name: "redemption_month"
      expr: DATE_TRUNC('MONTH', redemption_timestamp)
      comment: "Month of redemption for trend and seasonality analysis."
    - name: "redemption_year"
      expr: YEAR(redemption_timestamp)
      comment: "Year of redemption for annual comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the redemption transaction for multi-currency analysis."
  measures:
    - name: "total_redemptions"
      expr: COUNT(redemption_id)
      comment: "Total number of redemption events. Baseline measure of reward utilization activity."
    - name: "total_points_redeemed"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points consumed through redemptions. Measures the scale of reward delivery and liability drawdown."
    - name: "total_monetary_value_delivered"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of rewards delivered to members. Represents the direct cost of the rewards program."
    - name: "avg_monetary_value_per_redemption"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per redemption event. Indicates the typical reward size and member value perception."
    - name: "avg_points_per_redemption"
      expr: AVG(CAST(points_redeemed AS DOUBLE))
      comment: "Average points consumed per redemption. Helps calibrate redemption threshold settings and reward catalog pricing."
    - name: "fraudulent_redemption_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN redemption_id END)
      comment: "Count of redemptions flagged as fraudulent. Monitors program integrity and financial loss from fraud."
    - name: "fraud_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraudulent = TRUE THEN redemption_id END) / NULLIF(COUNT(redemption_id), 0), 2)
      comment: "Percentage of redemptions that are fraudulent. Key risk metric for program security investment decisions."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN redemption_status = 'cancelled' THEN redemption_id END) / NULLIF(COUNT(redemption_id), 0), 2)
      comment: "Percentage of redemptions that were cancelled. High cancellation rates indicate friction in the redemption experience."
    - name: "avg_fraud_detection_score"
      expr: AVG(CAST(fraud_detection_score AS DOUBLE))
      comment: "Average fraud detection score across redemptions. Tracks the risk profile of redemption activity over time."
    - name: "unique_redeeming_members"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Count of distinct members who redeemed in the period. Measures breadth of redemption engagement across the member base."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_engagement_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty engagement campaign performance metrics measuring enrollment, participation, spend lift, and tier upgrade outcomes against targets."
  source: "`vibe_retail_v1`.`loyalty`.`engagement_campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of engagement campaign (bonus-points, tier-accelerator, spend-challenge, referral, etc.) for campaign mix analysis."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (draft, active, completed, cancelled) for pipeline and performance filtering."
    - name: "channel_email_flag"
      expr: channel_email_flag
      comment: "Indicates whether the campaign used the email channel, enabling channel mix analysis."
    - name: "channel_sms_flag"
      expr: channel_sms_flag
      comment: "Indicates whether the campaign used the SMS channel."
    - name: "channel_push_flag"
      expr: channel_push_flag
      comment: "Indicates whether the campaign used push notifications."
    - name: "channel_in_store_flag"
      expr: channel_in_store_flag
      comment: "Indicates whether the campaign had an in-store activation component."
    - name: "personalization_enabled_flag"
      expr: personalization_enabled_flag
      comment: "Indicates whether personalization was applied to the campaign, enabling personalized vs. broadcast performance comparison."
    - name: "opt_in_required_flag"
      expr: opt_in_required_flag
      comment: "Indicates whether explicit opt-in was required, affecting eligible audience size."
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started for trend and seasonality analysis."
    - name: "campaign_start_year"
      expr: YEAR(start_date)
      comment: "Year the campaign started for annual comparison."
  measures:
    - name: "total_campaigns"
      expr: COUNT(engagement_campaign_id)
      comment: "Total number of engagement campaigns. Baseline measure of campaign activity volume."
    - name: "total_actual_incremental_spend"
      expr: SUM(CAST(actual_incremental_spend_amount AS DOUBLE))
      comment: "Total incremental spend generated by engagement campaigns. The primary revenue impact measure of the loyalty campaign portfolio."
    - name: "total_target_incremental_spend"
      expr: SUM(CAST(target_incremental_spend_amount AS DOUBLE))
      comment: "Total targeted incremental spend across campaigns. Used as the denominator for spend attainment rate."
    - name: "incremental_spend_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_incremental_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_incremental_spend_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of targeted incremental spend actually achieved. Core campaign effectiveness KPI for executive review."
    - name: "avg_actual_participation_rate_pct"
      expr: AVG(CAST(actual_participation_rate_pct AS DOUBLE))
      comment: "Average actual participation rate across campaigns. Measures how effectively campaigns engage the targeted member base."
    - name: "participation_rate_vs_target_pct"
      expr: ROUND(AVG(CAST(actual_participation_rate_pct AS DOUBLE)) - AVG(CAST(target_participation_rate_pct AS DOUBLE)), 2)
      comment: "Difference between actual and target participation rates. Positive values indicate campaigns outperforming expectations."
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier offered across campaigns. Indicates the generosity level of the campaign portfolio and its cost implications."
    - name: "avg_qualifying_spend_threshold"
      expr: AVG(CAST(qualifying_spend_threshold AS DOUBLE))
      comment: "Average minimum spend required to qualify for campaign rewards. Informs threshold calibration for future campaigns."
    - name: "total_campaign_budget"
      expr: COUNT(CASE WHEN finance_budget_id IS NOT NULL THEN engagement_campaign_id END)
      comment: "Count of campaigns with an assigned budget. Measures budget governance coverage across the campaign portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_partner_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner program transaction metrics measuring points flow, settlement economics, and reconciliation health across coalition and co-branded loyalty partnerships."
  source: "`vibe_retail_v1`.`loyalty`.`partner_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of partner transaction (earn, redeem, reversal, adjustment) for transaction mix analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the partner transaction (posted, pending, disputed, reversed) for reconciliation monitoring."
    - name: "transaction_channel"
      expr: transaction_channel
      comment: "Channel through which the partner transaction occurred for omnichannel partner analysis."
    - name: "partner_category"
      expr: partner_category
      comment: "Category of the partner (travel, dining, fuel, retail, financial services) for portfolio mix analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the transaction (reconciled, unreconciled, disputed) for financial close monitoring."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the transaction is under dispute. Used for dispute rate monitoring and partner relationship management."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the partner transaction for trend analysis."
    - name: "transaction_year"
      expr: YEAR(transaction_timestamp)
      comment: "Year of the partner transaction for annual comparison."
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Currency of the partner transaction for multi-currency settlement analysis."
    - name: "member_tier_at_transaction"
      expr: member_tier_at_transaction
      comment: "Member tier at the time of the partner transaction. Enables tier-level partner engagement analysis."
  measures:
    - name: "total_partner_transactions"
      expr: COUNT(partner_transaction_id)
      comment: "Total number of partner transactions. Baseline measure of partner program activity volume."
    - name: "total_points_awarded_by_partners"
      expr: SUM(CAST(points_awarded AS DOUBLE))
      comment: "Total points awarded through partner transactions. Measures the contribution of partner earn to overall program liability."
    - name: "total_points_redeemed_at_partners"
      expr: SUM(CAST(points_redeemed AS DOUBLE))
      comment: "Total points redeemed through partner channels. Measures partner redemption utilization and settlement obligations."
    - name: "total_bonus_points_from_partners"
      expr: SUM(CAST(bonus_points AS DOUBLE))
      comment: "Total bonus points awarded through partner promotions. Measures incremental liability from partner promotional activity."
    - name: "total_partner_commission_cost"
      expr: SUM(CAST(partner_commission_amount AS DOUBLE))
      comment: "Total commission paid to partners. Direct cost measure for partner program P&L management."
    - name: "avg_partner_commission_per_transaction"
      expr: AVG(CAST(partner_commission_amount AS DOUBLE))
      comment: "Average commission cost per partner transaction. Used to benchmark partner cost efficiency and renegotiate contracts."
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary value of partner transactions. Measures the revenue base flowing through partner channels."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN partner_transaction_id END) / NULLIF(COUNT(partner_transaction_id), 0), 2)
      comment: "Percentage of partner transactions under dispute. High rates signal partner data quality or contractual alignment issues."
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier applied in partner transactions. Indicates the blended earn rate generosity across partner agreements."
    - name: "unique_members_transacting_with_partners"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Count of distinct members who transacted through partner channels. Measures partner program reach within the member base."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral program performance metrics measuring acquisition efficiency, conversion rates, reward economics, and viral growth contribution."
  source: "`vibe_retail_v1`.`loyalty`.`referral`"
  dimensions:
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of the referral conversion (pending, converted, expired, disqualified) for funnel stage analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the referral was made (email, social, in-app, in-store) for channel attribution."
    - name: "source"
      expr: source
      comment: "Source of the referral (organic, campaign-driven, associate-assisted) for acquisition source analysis."
    - name: "qualification_met_flag"
      expr: qualification_met_flag
      comment: "Indicates whether the referral met qualification criteria for reward payout."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the referral was flagged as fraudulent. Used for program integrity monitoring."
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month the referral was made for trend and seasonality analysis."
    - name: "referral_year"
      expr: YEAR(referral_date)
      comment: "Year the referral was made for annual comparison."
    - name: "referee_reward_type"
      expr: referee_reward_type
      comment: "Type of reward given to the referred new member (points, discount, gift) for reward mix analysis."
    - name: "referrer_reward_type"
      expr: referrer_reward_type
      comment: "Type of reward given to the referring member for reward mix analysis."
  measures:
    - name: "total_referrals"
      expr: COUNT(referral_id)
      comment: "Total number of referrals generated. Baseline measure of referral program activity."
    - name: "total_converted_referrals"
      expr: COUNT(CASE WHEN conversion_status = 'converted' THEN referral_id END)
      comment: "Total referrals that resulted in a successful new member enrollment. Core acquisition KPI for the referral program."
    - name: "referral_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN conversion_status = 'converted' THEN referral_id END) / NULLIF(COUNT(referral_id), 0), 2)
      comment: "Percentage of referrals that converted to enrolled members. Primary efficiency metric for the referral acquisition channel."
    - name: "total_first_purchase_amount"
      expr: SUM(CAST(first_purchase_amount AS DOUBLE))
      comment: "Total first-purchase revenue generated by referred new members. Measures the immediate revenue impact of the referral program."
    - name: "avg_first_purchase_amount"
      expr: AVG(CAST(first_purchase_amount AS DOUBLE))
      comment: "Average first purchase value of referred members. Indicates the quality of referred customers vs. other acquisition channels."
    - name: "total_referrer_reward_value"
      expr: SUM(CAST(referrer_reward_value AS DOUBLE))
      comment: "Total reward value paid out to referring members. Represents the direct cost of the referral incentive program."
    - name: "total_referee_reward_value"
      expr: SUM(CAST(referee_reward_value AS DOUBLE))
      comment: "Total reward value paid out to referred new members. Represents the welcome incentive cost of the referral program."
    - name: "fraud_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN referral_id END) / NULLIF(COUNT(referral_id), 0), 2)
      comment: "Percentage of referrals flagged as fraudulent. High rates indicate self-referral abuse or organized fraud requiring program rule tightening."
    - name: "avg_viral_coefficient_contribution"
      expr: AVG(CAST(viral_coefficient_contribution AS DOUBLE))
      comment: "Average viral coefficient contribution per referral. Measures the organic growth multiplier effect of the referral program."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_member_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member segment health and value metrics measuring segment size, spend potential, and lifecycle distribution to guide targeted loyalty investment."
  source: "`vibe_retail_v1`.`loyalty`.`member_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of member segment (behavioral, demographic, value-based, lifecycle) for segmentation strategy analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (active, archived, draft) for operational filtering."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of members in the segment (new, growing, loyal, at-risk, lapsed) for retention strategy alignment."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign members to the segment (rule-based, ML-model, manual) for model governance analysis."
    - name: "campaign_eligibility_flag"
      expr: campaign_eligibility_flag
      comment: "Indicates whether the segment is eligible for campaign targeting."
    - name: "offer_eligibility_flag"
      expr: offer_eligibility_flag
      comment: "Indicates whether the segment is eligible for personalized offer targeting."
    - name: "tier_qualification_flag"
      expr: tier_qualification_flag
      comment: "Indicates whether the segment is used for tier qualification logic."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Indicates whether membership in this segment is mutually exclusive with other segments."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the segment became effective for temporal analysis of segment portfolio evolution."
  measures:
    - name: "total_segments"
      expr: COUNT(member_segment_id)
      comment: "Total number of member segments defined. Measures the breadth of the segmentation strategy."
    - name: "total_member_count_across_segments"
      expr: SUM(CAST(member_count AS DOUBLE))
      comment: "Sum of member counts across all segments. Indicates total addressable audience for targeted loyalty programs."
    - name: "avg_member_count_per_segment"
      expr: AVG(CAST(member_count AS DOUBLE))
      comment: "Average number of members per segment. Helps assess segment granularity and targeting precision."
    - name: "total_target_member_count"
      expr: SUM(CAST(target_member_count AS DOUBLE))
      comment: "Sum of target member counts across segments. Used to measure segment coverage attainment."
    - name: "segment_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(member_count AS DOUBLE)) / NULLIF(SUM(CAST(target_member_count AS DOUBLE)), 0), 2)
      comment: "Percentage of target member count achieved across segments. Measures how well the segmentation model is populating intended audiences."
    - name: "avg_annual_spend_per_segment"
      expr: AVG(CAST(average_annual_spend AS DOUBLE))
      comment: "Average of the per-segment average annual spend values. Indicates the revenue potential of the segment portfolio."
    - name: "avg_ltv_per_segment"
      expr: AVG(CAST(average_ltv AS DOUBLE))
      comment: "Average lifetime value across segments. Key input for loyalty investment prioritization and budget allocation."
    - name: "avg_points_balance_per_segment"
      expr: AVG(CAST(average_points_balance AS DOUBLE))
      comment: "Average points balance across segments. Indicates engagement depth and redemption propensity by segment."
    - name: "avg_minimum_confidence_score"
      expr: AVG(CAST(minimum_confidence_score AS DOUBLE))
      comment: "Average minimum confidence score across ML-driven segments. Monitors model quality and segment reliability."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_clienteling_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clienteling interaction metrics measuring associate-driven customer engagement quality, purchase conversion, and follow-up effectiveness."
  source: "`vibe_retail_v1`.`loyalty`.`clienteling_interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of clienteling interaction (consultation, styling, product demo, follow-up call) for interaction mix analysis."
    - name: "interaction_channel"
      expr: interaction_channel
      comment: "Channel of the interaction (in-store, phone, video, messaging) for omnichannel engagement analysis."
    - name: "interaction_outcome"
      expr: interaction_outcome
      comment: "Outcome of the interaction (purchase, no-purchase, appointment-booked, follow-up-required) for conversion analysis."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (completed, pending-follow-up, cancelled) for operational monitoring."
    - name: "purchase_made_flag"
      expr: purchase_made_flag
      comment: "Indicates whether a purchase was made during or following the interaction. Core conversion indicator."
    - name: "follow_up_action_required"
      expr: follow_up_action_required
      comment: "Indicates whether a follow-up action was required after the interaction."
    - name: "follow_up_completed_flag"
      expr: follow_up_completed_flag
      comment: "Indicates whether the required follow-up was completed. Measures associate follow-through discipline."
    - name: "interaction_initiated_by"
      expr: interaction_initiated_by
      comment: "Whether the interaction was initiated by the associate or the customer. Informs proactive vs. reactive engagement strategy."
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_date)
      comment: "Month of the interaction for trend analysis."
    - name: "vip_tier_at_interaction"
      expr: vip_tier_at_interaction
      comment: "Member tier at the time of interaction. Enables tier-level clienteling investment analysis."
    - name: "customer_sentiment"
      expr: customer_sentiment
      comment: "Recorded customer sentiment during the interaction (positive, neutral, negative) for satisfaction trend analysis."
  measures:
    - name: "total_interactions"
      expr: COUNT(clienteling_interaction_id)
      comment: "Total number of clienteling interactions. Baseline measure of associate engagement activity."
    - name: "purchase_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN purchase_made_flag = TRUE THEN clienteling_interaction_id END) / NULLIF(COUNT(clienteling_interaction_id), 0), 2)
      comment: "Percentage of clienteling interactions that resulted in a purchase. Primary effectiveness KPI for the clienteling program."
    - name: "total_interaction_value"
      expr: SUM(CAST(total_interaction_value_amount AS DOUBLE))
      comment: "Total monetary value generated through clienteling interactions. Measures the direct revenue contribution of the clienteling program."
    - name: "avg_interaction_value"
      expr: AVG(CAST(total_interaction_value_amount AS DOUBLE))
      comment: "Average value per clienteling interaction. Benchmarks associate productivity and interaction quality."
    - name: "follow_up_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_completed_flag = TRUE THEN clienteling_interaction_id END) / NULLIF(COUNT(CASE WHEN follow_up_action_required = TRUE THEN clienteling_interaction_id END), 0), 2)
      comment: "Percentage of required follow-ups that were completed. Measures associate discipline and customer relationship management quality."
    - name: "appointment_scheduled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_scheduled_flag = TRUE THEN clienteling_interaction_id END) / NULLIF(COUNT(clienteling_interaction_id), 0), 2)
      comment: "Percentage of interactions that resulted in a scheduled appointment. Indicates pipeline building effectiveness."
    - name: "unique_members_engaged"
      expr: COUNT(DISTINCT loyalty_membership_id)
      comment: "Count of distinct loyalty members engaged through clienteling. Measures the reach of the clienteling program across the member base."
    - name: "unique_associates_active"
      expr: COUNT(DISTINCT associate_id)
      comment: "Count of distinct associates conducting clienteling interactions. Measures program adoption among the associate workforce."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual rule configuration metrics measuring the structure, generosity, and coverage of the points earning rule portfolio."
  source: "`vibe_retail_v1`.`loyalty`.`accrual_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Type of accrual rule (base-earn, bonus, category-specific, partner, promotional) for rule portfolio analysis."
    - name: "accrual_rule_status"
      expr: accrual_rule_status
      comment: "Current status of the accrual rule (active, inactive, pending-approval) for active rule set monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rule (approved, pending, rejected) for governance workflow monitoring."
    - name: "applicable_channel"
      expr: applicable_channel
      comment: "Channel(s) to which the rule applies (in-store, online, mobile, all) for channel coverage analysis."
    - name: "stacking_allowed_flag"
      expr: stacking_allowed_flag
      comment: "Indicates whether this rule can stack with other rules. Affects liability exposure from combined promotions."
    - name: "earning_basis"
      expr: earning_basis
      comment: "Basis on which points are earned (spend-amount, transaction-count, units-purchased) for rule design analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the rule became effective for rule lifecycle analysis."
    - name: "member_tier_eligibility"
      expr: member_tier_eligibility
      comment: "Tier(s) eligible for this accrual rule. Enables tier-differentiated earn rate analysis."
  measures:
    - name: "total_active_rules"
      expr: COUNT(CASE WHEN accrual_rule_status = 'active' THEN accrual_rule_id END)
      comment: "Count of currently active accrual rules. Measures the complexity and breadth of the earn rule portfolio."
    - name: "avg_points_per_unit"
      expr: AVG(CAST(points_per_unit AS DOUBLE))
      comment: "Average points awarded per unit across all active rules. Indicates the blended generosity of the earn program."
    - name: "avg_bonus_multiplier"
      expr: AVG(CAST(bonus_multiplier AS DOUBLE))
      comment: "Average bonus multiplier across rules. Measures the incremental earn uplift offered through bonus rules."
    - name: "avg_minimum_spend_threshold"
      expr: AVG(CAST(minimum_spend_threshold AS DOUBLE))
      comment: "Average minimum spend required to trigger accrual rules. Informs threshold calibration for basket size optimization."
    - name: "stacking_allowed_rule_count"
      expr: COUNT(CASE WHEN stacking_allowed_flag = TRUE THEN accrual_rule_id END)
      comment: "Count of rules that allow stacking with other promotions. High counts increase liability exposure from combined promotional events."
    - name: "stacking_allowed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN stacking_allowed_flag = TRUE THEN accrual_rule_id END) / NULLIF(COUNT(accrual_rule_id), 0), 2)
      comment: "Percentage of accrual rules that permit stacking. Monitors promotional liability risk from rule combinability."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_member_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member offer performance metrics tracking personalization effectiveness and redemption rates"
  source: "`vibe_retail_v1`.`loyalty`.`member_offer`"
  dimensions:
    - name: "offer_status"
      expr: offer_status
      comment: "Status of the member offer (Active, Redeemed, Expired, Cancelled, etc.)"
    - name: "offer_type"
      expr: offer_type
      comment: "Type of offer (Discount, Bonus Points, Free Product, etc.)"
    - name: "offer_source"
      expr: offer_source
      comment: "Source of the offer (Campaign, Triggered, Personalized, etc.)"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount (Percentage, Fixed Amount, BOGO, etc.)"
    - name: "trigger_type"
      expr: trigger_type
      comment: "Event that triggered the offer (Birthday, Anniversary, Spend Threshold, etc.)"
    - name: "channel_applicability"
      expr: channel_applicability
      comment: "Channels where offer can be used (In-Store, Online, Mobile, Omnichannel, etc.)"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when offer became valid"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year when offer became valid"
  measures:
    - name: "total_offers"
      expr: COUNT(member_offer_id)
      comment: "Total number of member offers issued"
    - name: "total_redemptions"
      expr: SUM(CAST(REGEXP_REPLACE(redemption_count, '[^0-9]', '') AS BIGINT))
      comment: "Total number of offer redemptions"
    - name: "redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(REGEXP_REPLACE(redemption_count, '[^0-9]', '') AS BIGINT)) / NULLIF(COUNT(member_offer_id), 0), 2)
      comment: "Percentage of offers that were redeemed (engagement effectiveness)"
    - name: "total_discount_value"
      expr: SUM(CAST(discount_value AS DOUBLE))
      comment: "Total discount value offered across all offers"
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value per offer"
    - name: "total_estimated_liability"
      expr: SUM(CAST(estimated_liability_amount AS DOUBLE))
      comment: "Total estimated financial liability from outstanding offers"
    - name: "avg_personalization_score"
      expr: AVG(CAST(personalization_score AS DOUBLE))
      comment: "Average personalization score across offers (targeting quality)"
    - name: "avg_points_multiplier"
      expr: AVG(CAST(points_multiplier AS DOUBLE))
      comment: "Average points multiplier offered"
    - name: "avg_minimum_spend"
      expr: AVG(CAST(minimum_spend_amount AS DOUBLE))
      comment: "Average minimum spend threshold required for offer"
    - name: "redeemed_offer_count"
      expr: COUNT(CASE WHEN offer_status = 'Redeemed' THEN member_offer_id END)
      comment: "Count of offers that have been redeemed"
    - name: "expired_offer_count"
      expr: COUNT(CASE WHEN offer_status = 'Expired' THEN member_offer_id END)
      comment: "Count of offers that expired without redemption (waste indicator)"
    - name: "expiry_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN offer_status = 'Expired' THEN member_offer_id END) / NULLIF(COUNT(member_offer_id), 0), 2)
      comment: "Percentage of offers that expired without redemption"
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`loyalty_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier structure and performance metrics tracking tier economics and member progression"
  source: "`vibe_retail_v1`.`loyalty`.`tier`"
  dimensions:
    - name: "tier_status"
      expr: tier_status
      comment: "Status of the tier (Active, Inactive, Deprecated, etc.)"
    - name: "tier_name"
      expr: tier_name
      comment: "Name of the loyalty tier (Bronze, Silver, Gold, Platinum, etc.)"
    - name: "tier_code"
      expr: tier_code
      comment: "Code identifier for the tier"
    - name: "qualification_threshold_type"
      expr: qualification_threshold_type
      comment: "Type of threshold for tier qualification (Spend, Points, Transactions, etc.)"
    - name: "invitation_only_flag"
      expr: invitation_only_flag
      comment: "Whether tier is invitation-only"
    - name: "lifetime_tier_flag"
      expr: lifetime_tier_flag
      comment: "Whether tier is lifetime (no downgrade)"
  measures:
    - name: "total_tiers"
      expr: COUNT(tier_id)
      comment: "Total number of loyalty tiers defined"
    - name: "active_tier_count"
      expr: COUNT(CASE WHEN tier_status = 'Active' THEN tier_id END)
      comment: "Count of currently active tiers"
    - name: "avg_qualification_threshold"
      expr: AVG(CAST(qualification_threshold_value AS DOUBLE))
      comment: "Average qualification threshold value across tiers"
    - name: "avg_maintenance_threshold"
      expr: AVG(CAST(maintenance_threshold_value AS DOUBLE))
      comment: "Average maintenance threshold value to retain tier"
    - name: "avg_points_earning_multiplier"
      expr: AVG(CAST(points_earning_multiplier AS DOUBLE))
      comment: "Average points earning multiplier across tiers (benefit value)"
    - name: "avg_redemption_discount_pct"
      expr: AVG(CAST(points_redemption_discount_pct AS DOUBLE))
      comment: "Average redemption discount percentage across tiers (benefit value)"
    - name: "invitation_only_tier_count"
      expr: COUNT(CASE WHEN invitation_only_flag = TRUE THEN tier_id END)
      comment: "Count of invitation-only tiers (exclusivity indicator)"
    - name: "lifetime_tier_count"
      expr: COUNT(CASE WHEN lifetime_tier_flag = TRUE THEN tier_id END)
      comment: "Count of lifetime tiers (retention strategy indicator)"
$$;