-- Metric views for domain: loyalty | Business: Restaurants | Version: 2 | Generated on: 2026-07-10 20:02:42

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual Rule business metrics"
  source: "`vibe_restaurants_v1`.`loyalty`.`accrual_rule`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Scope"
      expr: channel_scope
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Daypart Scope"
      expr: daypart_scope
    - name: "Earning Basis"
      expr: earning_basis
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusion List"
      expr: exclusion_list
    - name: "Fixed Points Amount"
      expr: fixed_points_amount
    - name: "Franchise Id List"
      expr: franchise_id_list
    - name: "Franchise Scope"
      expr: franchise_scope
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Maximum Points Per Day"
      expr: maximum_points_per_day
    - name: "Maximum Points Per Member"
      expr: maximum_points_per_member
    - name: "Maximum Points Per Transaction"
      expr: maximum_points_per_transaction
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Accrual Rule"
      expr: COUNT(DISTINCT accrual_rule_id)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
    - name: "Total Points Per Unit"
      expr: SUM(points_per_unit)
    - name: "Average Points Per Unit"
      expr: AVG(points_per_unit)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member business metrics"
  source: "`vibe_restaurants_v1`.`loyalty`.`member`"
  dimensions:
    - name: "Account Closure Date"
      expr: account_closure_date
    - name: "Account Closure Reason"
      expr: account_closure_reason
    - name: "Account Created Timestamp"
      expr: account_created_timestamp
    - name: "Account Updated Timestamp"
      expr: account_updated_timestamp
    - name: "Badges Earned"
      expr: badges_earned
    - name: "Birthday Month"
      expr: birthday_month
    - name: "Data Privacy Consent Date"
      expr: data_privacy_consent_date
    - name: "Direct Mail Opt In"
      expr: direct_mail_opt_in
    - name: "Email Opt In"
      expr: email_opt_in
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Gamification Level"
      expr: gamification_level
    - name: "Last Activity Date"
      expr: last_activity_date
    - name: "Last Transaction Date"
      expr: last_transaction_date
    - name: "Membership Number"
      expr: membership_number
    - name: "Next Expiration Date"
      expr: next_expiration_date
    - name: "Nps Score"
      expr: nps_score
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member"
      expr: COUNT(DISTINCT member_id)
    - name: "Total Current Points Balance"
      expr: SUM(current_points_balance)
    - name: "Average Current Points Balance"
      expr: AVG(current_points_balance)
    - name: "Total Lifetime Points Earned"
      expr: SUM(lifetime_points_earned)
    - name: "Average Lifetime Points Earned"
      expr: AVG(lifetime_points_earned)
    - name: "Total Lifetime Points Redeemed"
      expr: SUM(lifetime_points_redeemed)
    - name: "Average Lifetime Points Redeemed"
      expr: AVG(lifetime_points_redeemed)
    - name: "Total Points Expiring Soon"
      expr: SUM(points_expiring_soon)
    - name: "Average Points Expiring Soon"
      expr: AVG(points_expiring_soon)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_member_offer_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Offer Assignment business metrics"
  source: "`vibe_restaurants_v1`.`loyalty`.`member_offer_assignment`"
  dimensions:
    - name: "Assignment Channel"
      expr: assignment_channel
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Eligible Member Segments"
      expr: eligible_member_segments
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Notification Sent Timestamp"
      expr: notification_sent_timestamp
    - name: "Personalization Flag"
      expr: personalization_flag
    - name: "Redeemed Timestamp"
      expr: redeemed_timestamp
    - name: "Redemption Status"
      expr: redemption_status
    - name: "Viewed Flag"
      expr: viewed_flag
    - name: "Assignment Date Month"
      expr: DATE_TRUNC('MONTH', assignment_date)
    - name: "Expiry Date Month"
      expr: DATE_TRUNC('MONTH', expiry_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Offer Assignment"
      expr: COUNT(DISTINCT member_offer_assignment_id)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer business metrics"
  source: "`vibe_restaurants_v1`.`loyalty`.`offer`"
  dimensions:
    - name: "Approved By User"
      expr: approved_by_user
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Apply Flag"
      expr: auto_apply_flag
    - name: "Bonus Points Value"
      expr: bonus_points_value
    - name: "Code"
      expr: code
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Day Of Week Restriction"
      expr: day_of_week_restriction
    - name: "Daypart Restriction"
      expr: daypart_restriction
    - name: "Description"
      expr: description
    - name: "Discount Type"
      expr: discount_type
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Eligible Member Tiers"
      expr: eligible_member_tiers
    - name: "Eligible Menu Items"
      expr: eligible_menu_items
    - name: "End Date"
      expr: end_date
    - name: "Excluded Menu Items"
      expr: excluded_menu_items
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Offer"
      expr: COUNT(DISTINCT offer_id)
    - name: "Total Discount Value"
      expr: SUM(discount_value)
    - name: "Average Discount Value"
      expr: AVG(discount_value)
    - name: "Total Estimated Cost Per Redemption"
      expr: SUM(estimated_cost_per_redemption)
    - name: "Average Estimated Cost Per Redemption"
      expr: AVG(estimated_cost_per_redemption)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
    - name: "Total Points Multiplier"
      expr: SUM(points_multiplier)
    - name: "Average Points Multiplier"
      expr: AVG(points_multiplier)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points Ledger business metrics"
  source: "`vibe_restaurants_v1`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "Adjustment Reason Code"
      expr: adjustment_reason_code
    - name: "Adjustment Reason Notes"
      expr: adjustment_reason_notes
    - name: "Batch Reference"
      expr: batch_reference
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Voided"
      expr: is_voided
    - name: "Order Currency Code"
      expr: order_currency_code
    - name: "Points Balance After"
      expr: points_balance_after
    - name: "Points Delta"
      expr: points_delta
    - name: "Points Expiry Date"
      expr: points_expiry_date
    - name: "Processed Timestamp"
      expr: processed_timestamp
    - name: "Restaurant Number"
      expr: restaurant_number
    - name: "Source Channel"
      expr: source_channel
    - name: "Source Order Number"
      expr: source_order_number
    - name: "Source System Code"
      expr: source_system_code
    - name: "Transaction Timestamp"
      expr: transaction_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Points Ledger"
      expr: COUNT(DISTINCT points_ledger_id)
    - name: "Total Order Total Amount"
      expr: SUM(order_total_amount)
    - name: "Average Order Total Amount"
      expr: AVG(order_total_amount)
    - name: "Total Points Earn Rate"
      expr: SUM(points_earn_rate)
    - name: "Average Points Earn Rate"
      expr: AVG(points_earn_rate)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program business metrics"
  source: "`vibe_restaurants_v1`.`loyalty`.`program`"
  dimensions:
    - name: "Birthday Bonus Points"
      expr: birthday_bonus_points
    - name: "Code"
      expr: code
    - name: "Country Codes"
      expr: country_codes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Name"
      expr: currency_name
    - name: "Description"
      expr: description
    - name: "End Date"
      expr: end_date
    - name: "Enrollment Bonus Points"
      expr: enrollment_bonus_points
    - name: "Enrollment Channels"
      expr: enrollment_channels
    - name: "Gamification Enabled Flag"
      expr: gamification_enabled_flag
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Launch Date"
      expr: launch_date
    - name: "Manager Email"
      expr: manager_email
    - name: "Manager Name"
      expr: manager_name
    - name: "Minimum Redemption Points"
      expr: minimum_redemption_points
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program"
      expr: COUNT(DISTINCT program_id)
    - name: "Total Dollar Per Point"
      expr: SUM(dollar_per_point)
    - name: "Average Dollar Per Point"
      expr: AVG(dollar_per_point)
    - name: "Total Points Per Dollar"
      expr: SUM(points_per_dollar)
    - name: "Average Points Per Dollar"
      expr: AVG(points_per_dollar)
    - name: "Total Subscription Fee Amount"
      expr: SUM(subscription_fee_amount)
    - name: "Average Subscription Fee Amount"
      expr: AVG(subscription_fee_amount)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption business metrics"
  source: "`vibe_restaurants_v1`.`loyalty`.`redemption`"
  dimensions:
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daypart"
      expr: daypart
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fraud Flag"
      expr: fraud_flag
    - name: "Fulfillment Code"
      expr: fulfillment_code
    - name: "Member Tier"
      expr: member_tier
    - name: "Notes"
      expr: notes
    - name: "Points Balance After"
      expr: points_balance_after
    - name: "Points Balance Before"
      expr: points_balance_before
    - name: "Points Deducted"
      expr: points_deducted
    - name: "Redemption Number"
      expr: redemption_number
    - name: "Redemption Status"
      expr: redemption_status
    - name: "Redemption Timestamp"
      expr: redemption_timestamp
    - name: "Reversal Reason"
      expr: reversal_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Redemption"
      expr: COUNT(DISTINCT redemption_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Fraud Score"
      expr: SUM(fraud_score)
    - name: "Average Fraud Score"
      expr: AVG(fraud_score)
    - name: "Total Order Total After Discount"
      expr: SUM(order_total_after_discount)
    - name: "Average Order Total After Discount"
      expr: AVG(order_total_after_discount)
    - name: "Total Order Total Before Discount"
      expr: SUM(order_total_before_discount)
    - name: "Average Order Total Before Discount"
      expr: AVG(order_total_before_discount)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_reward`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reward business metrics"
  source: "`vibe_restaurants_v1`.`loyalty`.`reward`"
  dimensions:
    - name: "Availability End Date"
      expr: availability_end_date
    - name: "Availability Start Date"
      expr: availability_start_date
    - name: "Code"
      expr: code
    - name: "Combinable With Other Offers"
      expr: combinable_with_other_offers
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Daypart Restriction"
      expr: daypart_restriction
    - name: "Description"
      expr: description
    - name: "Discount Type"
      expr: discount_type
    - name: "Featured Flag"
      expr: featured_flag
    - name: "Format Restriction List"
      expr: format_restriction_list
    - name: "Image Url"
      expr: image_url
    - name: "Market Restriction List"
      expr: market_restriction_list
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Name"
      expr: name
    - name: "Partner Name"
      expr: partner_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reward"
      expr: COUNT(DISTINCT reward_id)
    - name: "Total Cost Of Goods Sold"
      expr: SUM(cost_of_goods_sold)
    - name: "Average Cost Of Goods Sold"
      expr: AVG(cost_of_goods_sold)
    - name: "Total Discount Value"
      expr: SUM(discount_value)
    - name: "Average Discount Value"
      expr: AVG(discount_value)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
    - name: "Total Monetary Value"
      expr: SUM(monetary_value)
    - name: "Average Monetary Value"
      expr: AVG(monetary_value)
    - name: "Total Redemption Count"
      expr: SUM(redemption_count)
    - name: "Average Redemption Count"
      expr: AVG(redemption_count)
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`loyalty_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier business metrics"
  source: "`vibe_restaurants_v1`.`loyalty`.`tier`"
  dimensions:
    - name: "Benefits Summary"
      expr: benefits_summary
    - name: "Birthday Reward Eligible"
      expr: birthday_reward_eligible
    - name: "Code"
      expr: code
    - name: "Color Code"
      expr: color_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Description"
      expr: description
    - name: "Early Access Lto"
      expr: early_access_lto
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusive Offers Eligible"
      expr: exclusive_offers_eligible
    - name: "Free Delivery Eligible"
      expr: free_delivery_eligible
    - name: "Grace Period Days"
      expr: grace_period_days
    - name: "Icon Url"
      expr: icon_url
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Launch Date"
      expr: launch_date
    - name: "Modified By User"
      expr: modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tier"
      expr: COUNT(DISTINCT tier_id)
    - name: "Total Annual Fee Amount"
      expr: SUM(annual_fee_amount)
    - name: "Average Annual Fee Amount"
      expr: AVG(annual_fee_amount)
    - name: "Total Downgrade Threshold"
      expr: SUM(downgrade_threshold)
    - name: "Average Downgrade Threshold"
      expr: AVG(downgrade_threshold)
    - name: "Total Max Redemption Discount Pct"
      expr: SUM(max_redemption_discount_pct)
    - name: "Average Max Redemption Discount Pct"
      expr: AVG(max_redemption_discount_pct)
    - name: "Total Points Multiplier"
      expr: SUM(points_multiplier)
    - name: "Average Points Multiplier"
      expr: AVG(points_multiplier)
    - name: "Total Qualification Threshold"
      expr: SUM(qualification_threshold)
    - name: "Average Qualification Threshold"
      expr: AVG(qualification_threshold)
$$;