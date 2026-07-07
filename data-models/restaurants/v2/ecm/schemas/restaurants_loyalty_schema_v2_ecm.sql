-- Schema for Domain: loyalty | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`loyalty` COMMENT 'Manages guest loyalty program enrollment, membership tiers, points accrual and redemption, rewards catalog, promotional offers, personalized campaigns, member engagement, and loyalty analytics. Drives repeat visits, ACV lift, and customer lifetime value through targeted incentives and gamification across OLO and POS channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`member` (
    `member_id` BIGINT COMMENT 'Unique identifier for the loyalty member',
    `employee_id` BIGINT COMMENT 'Employee managing this member account',
    `campaign_id` BIGINT COMMENT 'Campaign that acquired this member',
    `franchisee_id` BIGINT COMMENT 'Franchisee associated with member enrollment',
    `legal_entity_id` BIGINT COMMENT 'Legal entity owning the program',
    `profile_id` BIGINT COMMENT 'Guest profile linked to this member',
    `unit_id` BIGINT COMMENT 'Preferred location unit',
    `member_profile_id` BIGINT COMMENT 'Guest profile reference',
    `member_unit_id` BIGINT COMMENT 'Restaurant unit reference',
    `primary_member_preferred_location_unit_id` BIGINT COMMENT 'Member preferred restaurant location',
    `referred_by_member_id` BIGINT COMMENT 'Member who referred this member',
    `account_closure_date` DATE COMMENT 'Date the member account was closed',
    `account_closure_reason` STRING COMMENT 'Reason for account closure',
    `account_created_timestamp` TIMESTAMP COMMENT 'Timestamp when account was created',
    `account_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last account update',
    `badges_earned` STRING COMMENT 'Total gamification badges earned',
    `birthday_month` STRING COMMENT 'Birth month for birthday rewards',
    `current_points_balance` DECIMAL(18,2) COMMENT 'Current available points balance',
    `current_tier` STRING COMMENT 'Current loyalty tier name',
    `data_privacy_consent_date` DATE COMMENT 'Date privacy consent was given',
    `direct_mail_opt_in` BOOLEAN COMMENT 'Whether member opted in to direct mail',
    `email_opt_in` BOOLEAN COMMENT 'Whether member opted in to email',
    `enrollment_channel` STRING COMMENT 'Channel through which member enrolled',
    `enrollment_date` DATE COMMENT 'Date of enrollment',
    `gamification_level` STRING COMMENT 'Current gamification level',
    `last_activity_date` DATE COMMENT 'Date of last loyalty activity',
    `last_transaction_date` DATE COMMENT 'Date of last qualifying transaction',
    `lifetime_points_earned` BIGINT COMMENT 'Total points earned over lifetime',
    `lifetime_points_redeemed` BIGINT COMMENT 'Total points redeemed over lifetime',
    `membership_number` STRING COMMENT 'External-facing membership number',
    `next_expiration_date` DECIMAL(18,2) COMMENT 'Next date points will expire',
    `nps_score` DECIMAL(18,2) COMMENT 'Latest Net Promoter Score',
    `nps_survey_date` DATE COMMENT 'Date of last NPS survey',
    `points_expiring_soon` BIGINT COMMENT 'Points expiring within next period',
    `preferred_language` STRING COMMENT 'Member preferred language',
    `program_status` STRING COMMENT 'Current membership status',
    `push_notification_opt_in` BOOLEAN COMMENT 'Whether member opted in to push notifications',
    `referral_code` STRING COMMENT 'Unique referral code for this member',
    `sms_opt_in` BOOLEAN COMMENT 'Whether member opted in to SMS',
    `status_reason` STRING COMMENT 'Reason for current status',
    `terms_accepted_date` DATE COMMENT 'Date terms were accepted',
    `terms_version` STRING COMMENT 'Version of terms accepted',
    `third_party_sharing_opt_in` BOOLEAN COMMENT 'Whether member opted in to third party sharing',
    `tier_effective_date` DATE COMMENT 'Date current tier became effective',
    `tier_expiration_date` DECIMAL(18,2) COMMENT 'Date current tier expires',
    `total_visits` STRING COMMENT 'Total qualifying visits',
    CONSTRAINT pk_member PRIMARY KEY(`member_id`)
) COMMENT 'Loyalty program member profile linking guest identity to program participation';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`tier` (
    `tier_id` BIGINT COMMENT 'Unique identifier for the tier',
    `program_id` BIGINT COMMENT 'Program this tier belongs to',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Annual fee for this tier',
    `benefits_summary` STRING COMMENT 'Summary of tier benefits',
    `birthday_reward_eligible` BOOLEAN COMMENT 'Whether tier gets birthday rewards',
    `tier_code` STRING COMMENT 'Short code for tier',
    `color_code` STRING COMMENT 'Display color code for tier',
    `created_timestamp` TIMESTAMP COMMENT 'When tier was created',
    `tier_description` STRING COMMENT 'Description of tier',
    `downgrade_threshold` DECIMAL(18,2) COMMENT 'Threshold below which member downgrades',
    `early_access_lto` BOOLEAN COMMENT 'Whether tier gets early LTO access',
    `effective_end_date` DATE COMMENT 'End date of tier validity',
    `effective_start_date` DATE COMMENT 'Start date of tier validity',
    `exclusive_offers_eligible` BOOLEAN COMMENT 'Whether tier gets exclusive offers',
    `free_delivery_eligible` BOOLEAN COMMENT 'Whether tier gets free delivery',
    `grace_period_days` STRING COMMENT 'Grace period before downgrade',
    `icon_url` STRING COMMENT 'URL for tier icon',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp',
    `launch_date` DATE COMMENT 'Date tier was launched',
    `max_redemption_discount_pct` DECIMAL(18,2) COMMENT 'Max redemption discount percentage',
    `modified_by_user` STRING COMMENT 'User who last modified',
    `tier_name` STRING COMMENT 'Display name of tier',
    `points_multiplier` DECIMAL(18,2) COMMENT 'Points earning multiplier for tier',
    `priority_support_eligible` BOOLEAN COMMENT 'Whether tier gets priority support',
    `qualification_metric` STRING COMMENT 'Metric used for qualification',
    `qualification_period_days` STRING COMMENT 'Period over which qualification is measured',
    `qualification_threshold` DECIMAL(18,2) COMMENT 'Threshold to qualify for tier',
    `referral_bonus_points` STRING COMMENT 'Bonus points for referrals at this tier',
    `rollover_points_allowed` BOOLEAN COMMENT 'Whether points roll over',
    `sort_order` STRING COMMENT 'Display sort order',
    `target_member_segment` STRING COMMENT 'Target segment for this tier',
    `tier_status` STRING COMMENT 'Active/inactive status',
    `upgrade_notification` BOOLEAN COMMENT 'Whether upgrade notifications are sent',
    `validity_days` STRING COMMENT 'Days tier remains valid',
    `welcome_bonus_points` STRING COMMENT 'Bonus points on tier entry',
    CONSTRAINT pk_tier PRIMARY KEY(`tier_id`)
) COMMENT 'Loyalty program tier definitions with qualification criteria and benefits';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` (
    `tier_history_id` BIGINT COMMENT 'Unique identifier',
    `guest_order_id` BIGINT COMMENT 'Order that triggered tier change',
    `member_id` BIGINT COMMENT 'Member whose tier changed',
    `campaign_id` BIGINT COMMENT 'Campaign if promotional tier',
    `unit_id` BIGINT COMMENT 'Unit where change occurred',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Date tier change takes effect',
    `expiry_date` DATE COMMENT 'Date new tier expires',
    `is_manual_override` BOOLEAN COMMENT 'Whether change was manual',
    `is_promotional_tier` BOOLEAN COMMENT 'Whether tier is promotional',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `new_tier_benefits_activated_flag` BOOLEAN COMMENT 'Whether new benefits activated',
    `new_tier_code` STRING COMMENT 'Code of new tier',
    `notification_channel` STRING COMMENT 'Channel used for notification',
    `notification_sent_flag` BOOLEAN COMMENT 'Whether notification was sent',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'When notification was sent',
    `override_authorized_by` STRING COMMENT 'Who authorized override',
    `override_justification` STRING COMMENT 'Justification for override',
    `previous_tier_benefits_revoked_flag` BOOLEAN COMMENT 'Whether previous benefits revoked',
    `previous_tier_code` STRING COMMENT 'Code of previous tier',
    `processing_channel` STRING COMMENT 'Channel that processed change',
    `qualification_period_end_date` DATE COMMENT 'End of qualification period',
    `qualification_period_start_date` DATE COMMENT 'Start of qualification period',
    `qualifying_points_balance` DECIMAL(18,2) COMMENT 'Points at time of change',
    `qualifying_spend_amount` DECIMAL(18,2) COMMENT 'Spend at time of change',
    `qualifying_visit_count` STRING COMMENT 'Visits at time of change',
    `source_system_record_code` STRING COMMENT 'A standardized code representing the source system record classification for this tier history',
    `tier_change_notes` STRING COMMENT 'Notes about the change',
    `tier_change_number` STRING COMMENT 'Sequential change number',
    `tier_change_reason_code` STRING COMMENT 'Reason code',
    `tier_change_reason_description` STRING COMMENT 'Reason description',
    `tier_change_timestamp` TIMESTAMP COMMENT 'Timestamp of change',
    `tier_change_type` STRING COMMENT 'Type of change (upgrade/downgrade)',
    `tier_duration_days` DECIMAL(18,2) COMMENT 'Days spent in previous tier',
    `triggering_transaction_reference` STRING COMMENT 'Transaction that triggered change',
    CONSTRAINT pk_tier_history PRIMARY KEY(`tier_history_id`)
) COMMENT 'Historical record of member tier changes including upgrades, downgrades, and manual overrides';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` (
    `points_ledger_id` BIGINT COMMENT 'Unique identifier',
    `campaign_id` BIGINT COMMENT 'Associated campaign',
    `gl_account_id` BIGINT COMMENT 'GL account for liability',
    `member_id` BIGINT COMMENT 'Member who owns points',
    `employee_id` BIGINT COMMENT 'Employee who made adjustment',
    `points_employee_id` BIGINT COMMENT 'Employee reference',
    `franchisee_id` BIGINT COMMENT 'Franchisee reference',
    `points_franchisee_id` BIGINT COMMENT 'Franchisee',
    `guest_order_id` BIGINT COMMENT 'Associated order',
    `unit_id` BIGINT COMMENT 'Restaurant unit',
    `points_unit_id` BIGINT COMMENT 'Unit reference',
    `reversal_of_transaction_points_ledger_id` BIGINT COMMENT 'Points ledger entry being reversed',
    `reward_id` BIGINT COMMENT 'Associated reward',
    `source_transaction_guest_order_id` BIGINT COMMENT 'Source transaction order',
    `tier_id` BIGINT COMMENT 'Tier at time of transaction',
    `adjustment_reason_code` STRING COMMENT 'Reason code for adjustment',
    `adjustment_reason_notes` STRING COMMENT 'Notes for adjustment',
    `batch_reference` STRING COMMENT 'Batch processing reference',
    `fiscal_period` STRING COMMENT 'The fiscal period attribute value for this points ledger record in the loyalty domain',
    `fiscal_year` STRING COMMENT 'The fiscal year attribute value for this points ledger record in the loyalty domain',
    `is_voided` BOOLEAN COMMENT 'Whether entry is voided',
    `order_currency_code` STRING COMMENT 'Currency of order',
    `order_total_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for order total in this points ledger',
    `points_balance_after` DECIMAL(18,2) COMMENT 'Balance after transaction',
    `points_delta` STRING COMMENT 'Points change amount',
    `points_earn_rate` DECIMAL(18,2) COMMENT 'Earn rate applied',
    `points_expiry_date` DATE COMMENT 'Date these points expire',
    `processed_timestamp` TIMESTAMP COMMENT 'When processed',
    `restaurant_number` STRING COMMENT 'The restaurant number attribute value for this points ledger record in the loyalty domain',
    `source_channel` STRING COMMENT 'The source channel attribute value for this points ledger record in the loyalty domain',
    `source_order_number` STRING COMMENT 'The source order number attribute value for this points ledger record in the loyalty domain',
    `source_system_code` STRING COMMENT 'Source system',
    `transaction_timestamp` TIMESTAMP COMMENT 'The transaction timestamp attribute value for this points ledger record in the loyalty domain',
    `transaction_type` STRING COMMENT 'Type of transaction',
    `voided_timestamp` TIMESTAMP COMMENT 'When voided',
    CONSTRAINT pk_points_ledger PRIMARY KEY(`points_ledger_id`)
) COMMENT 'Detailed ledger of all points transactions including earnings, redemptions, adjustments, and expirations';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`reward` (
    `reward_id` BIGINT COMMENT 'Unique identifier',
    `franchisee_id` BIGINT COMMENT 'Franchisee sponsoring reward',
    `menu_item_id` BIGINT COMMENT 'Menu item for reward',
    `campaign_id` BIGINT COMMENT 'Campaign that created reward',
    `availability_end_date` DATE COMMENT 'End of availability',
    `availability_start_date` DATE COMMENT 'Start of availability',
    `reward_code` STRING COMMENT 'A standardized code representing the reward classification for this reward',
    `combinable_with_other_offers` BOOLEAN COMMENT 'Whether combinable with other offers',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'COGS for reward',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `daypart_restriction` STRING COMMENT 'Daypart restrictions',
    `reward_description` STRING COMMENT 'The reward description attribute value for this reward record in the loyalty domain',
    `discount_type` STRING COMMENT 'Type of discount',
    `discount_value` DECIMAL(18,2) COMMENT 'The discount value attribute value for this reward record in the loyalty domain',
    `featured_flag` BOOLEAN COMMENT 'Whether featured',
    `format_restriction_list` STRING COMMENT 'Format restrictions',
    `image_url` STRING COMMENT 'Reward image URL',
    `market_restriction_list` STRING COMMENT 'Market restrictions',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum purchase required',
    `modified_by` STRING COMMENT 'Who modified',
    `modified_timestamp` TIMESTAMP COMMENT 'When modified',
    `monetary_value` DECIMAL(18,2) COMMENT 'Monetary value of reward',
    `reward_name` STRING COMMENT 'The display name or label for the reward in this reward',
    `partner_name` STRING COMMENT 'The display name or label for the partner in this reward',
    `partner_offer_code` STRING COMMENT 'A standardized code representing the partner offer classification for this reward',
    `points_cost` DECIMAL(18,2) COMMENT 'Points required',
    `quantity_limit_per_member` STRING COMMENT 'Max per member',
    `redemption_channel_app` BOOLEAN COMMENT 'Available on app',
    `redemption_channel_drive_thru` BOOLEAN COMMENT 'Available at drive-thru',
    `redemption_channel_olo` BOOLEAN COMMENT 'Available for OLO',
    `redemption_channel_pos` BOOLEAN COMMENT 'Available at POS',
    `redemption_channel_third_party_delivery` BOOLEAN COMMENT 'Available on 3PD',
    `redemption_count` BIGINT COMMENT 'Total redemptions',
    `restaurant_applicability_scope` STRING COMMENT 'Restaurant scope',
    `reward_status` STRING COMMENT 'The current status of the reward for this reward',
    `reward_type` STRING COMMENT 'Type of reward',
    `tax_treatment` STRING COMMENT 'The tax treatment attribute value for this reward record in the loyalty domain',
    `terms_and_conditions` STRING COMMENT 'The terms and conditions attribute value for this reward record in the loyalty domain',
    `tier_eligibility` STRING COMMENT 'Eligible tiers',
    `total_quantity_limit` STRING COMMENT 'The total quantity limit attribute value for this reward record in the loyalty domain',
    `created_by` STRING COMMENT 'Created by user',
    CONSTRAINT pk_reward PRIMARY KEY(`reward_id`)
) COMMENT 'Catalog of rewards available for redemption by loyalty members';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` (
    `redemption_id` BIGINT COMMENT 'Unique identifier',
    `campaign_id` BIGINT COMMENT 'Associated campaign',
    `employee_id` BIGINT COMMENT 'Employee who processed',
    `gl_account_id` BIGINT COMMENT 'GL account',
    `guest_order_id` BIGINT COMMENT 'Associated order',
    `member_id` BIGINT COMMENT 'Member redeeming',
    `menu_item_id` BIGINT COMMENT 'Menu item redeemed',
    `pos_terminal_id` BIGINT COMMENT 'POS terminal',
    `unit_id` BIGINT COMMENT 'Restaurant unit',
    `redemption_unit_id` BIGINT COMMENT 'Unit reference',
    `reward_id` BIGINT COMMENT 'Reward redeemed',
    `channel` STRING COMMENT 'Redemption channel',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this redemption',
    `daypart` STRING COMMENT 'Daypart of redemption',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for discount in this redemption',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date and time when the expiration event occurred for this redemption',
    `fraud_flag` BOOLEAN COMMENT 'Boolean indicator flag for fraud flag status in this redemption',
    `fraud_score` DECIMAL(18,2) COMMENT 'The fraud score attribute value for this redemption record in the loyalty domain',
    `fulfillment_code` STRING COMMENT 'A standardized code representing the fulfillment classification for this redemption',
    `member_tier` STRING COMMENT 'Member tier at time',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this redemption',
    `order_total_after_discount` DECIMAL(18,2) COMMENT 'The order total after discount attribute value for this redemption record in the loyalty domain',
    `order_total_before_discount` DECIMAL(18,2) COMMENT 'The order total before discount attribute value for this redemption record in the loyalty domain',
    `points_balance_after` DECIMAL(18,2) COMMENT 'The points balance after attribute value for this redemption record in the loyalty domain',
    `points_balance_before` DECIMAL(18,2) COMMENT 'The points balance before attribute value for this redemption record in the loyalty domain',
    `points_deducted` STRING COMMENT 'The points deducted attribute value for this redemption record in the loyalty domain',
    `redemption_number` STRING COMMENT 'The redemption number attribute value for this redemption record in the loyalty domain',
    `redemption_status` STRING COMMENT 'The current status of the redemption for this redemption',
    `redemption_timestamp` TIMESTAMP COMMENT 'The redemption timestamp attribute value for this redemption record in the loyalty domain',
    `reversal_reason` STRING COMMENT 'The reversal reason attribute value for this redemption record in the loyalty domain',
    `reversal_timestamp` TIMESTAMP COMMENT 'The reversal timestamp attribute value for this redemption record in the loyalty domain',
    `reward_type` STRING COMMENT 'The classification type for reward in this redemption',
    `source` STRING COMMENT 'The source attribute value for this redemption record in the loyalty domain',
    `third_party_delivery_partner` STRING COMMENT '3PD partner',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this redemption record in the loyalty domain',
    CONSTRAINT pk_redemption PRIMARY KEY(`redemption_id`)
) COMMENT 'Record of reward redemptions by loyalty members';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` (
    `accrual_rule_id` BIGINT COMMENT 'Unique identifier',
    `campaign_id` BIGINT COMMENT 'Associated campaign',
    `program_id` BIGINT COMMENT 'Program this rule belongs to',
    `approved_by` STRING COMMENT 'The approved by attribute value for this accrual rule record in the loyalty domain',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp',
    `channel_scope` STRING COMMENT 'Applicable channels',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `daypart_scope` STRING COMMENT 'Applicable dayparts',
    `earning_basis` STRING COMMENT 'Basis for earning',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this accrual rule',
    `effective_start_date` DATE COMMENT 'Start date',
    `exclusion_list` STRING COMMENT 'Excluded items',
    `fixed_points_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for fixed points in this accrual rule',
    `franchise_id_list` STRING COMMENT 'Applicable franchisees',
    `franchise_scope` STRING COMMENT 'The franchise scope attribute value for this accrual rule record in the loyalty domain',
    `geographic_scope` STRING COMMENT 'The geographic scope attribute value for this accrual rule record in the loyalty domain',
    `maximum_points_per_day` STRING COMMENT 'The maximum points per day attribute value for this accrual rule record in the loyalty domain',
    `maximum_points_per_member` STRING COMMENT 'Member cap',
    `maximum_points_per_transaction` STRING COMMENT 'Transaction cap',
    `member_tier_scope` STRING COMMENT 'Applicable tiers',
    `menu_category_scope` STRING COMMENT 'The menu category scope attribute value for this accrual rule record in the loyalty domain',
    `menu_item_scope` STRING COMMENT 'The menu item scope attribute value for this accrual rule record in the loyalty domain',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum purchase',
    `modified_by` STRING COMMENT 'The modified by attribute value for this accrual rule record in the loyalty domain',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp attribute value for this accrual rule record in the loyalty domain',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this accrual rule',
    `points_expiration_days` DECIMAL(18,2) COMMENT 'Days until points expire',
    `points_per_unit` DECIMAL(18,2) COMMENT 'The points per unit attribute value for this accrual rule record in the loyalty domain',
    `requires_opt_in` BOOLEAN COMMENT 'Whether opt-in required',
    `rule_code` STRING COMMENT 'A standardized code representing the rule classification for this accrual rule',
    `rule_description` STRING COMMENT 'The rule description attribute value for this accrual rule record in the loyalty domain',
    `rule_name` STRING COMMENT 'The display name or label for the rule in this accrual rule',
    `rule_priority` STRING COMMENT 'The rule priority attribute value for this accrual rule record in the loyalty domain',
    `rule_status` STRING COMMENT 'The current status of the rule for this accrual rule',
    `rule_type` STRING COMMENT 'The classification type for rule in this accrual rule',
    `stackable` BOOLEAN COMMENT 'Whether stackable',
    `tier_multiplier_applicable` DECIMAL(18,2) COMMENT 'Whether tier multiplier applies',
    `version_number` STRING COMMENT 'The version number attribute value for this accrual rule record in the loyalty domain',
    `created_by` STRING COMMENT 'The created by attribute value for this accrual rule record in the loyalty domain',
    CONSTRAINT pk_accrual_rule PRIMARY KEY(`accrual_rule_id`)
) COMMENT 'Rules governing how loyalty points are earned across channels, dayparts, and member tiers';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`offer` (
    `offer_id` BIGINT COMMENT 'Unique identifier',
    `campaign_id` BIGINT COMMENT 'Associated campaign',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the created by employee associated with this offer record',
    `franchisee_id` BIGINT COMMENT 'Franchisee',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this offer',
    `approved_by_user` STRING COMMENT 'The approved by user attribute value for this offer record in the loyalty domain',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp',
    `auto_apply_flag` BOOLEAN COMMENT 'Auto-apply',
    `bonus_points_value` DECIMAL(18,2) COMMENT 'Bonus points',
    `offer_code` STRING COMMENT 'A standardized code representing the offer classification for this offer',
    `created_by_user` STRING COMMENT 'Created by',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this offer record in the loyalty domain',
    `day_of_week_restriction` STRING COMMENT 'Day restrictions',
    `daypart_restriction` STRING COMMENT 'Daypart restrictions',
    `offer_description` STRING COMMENT 'The offer description attribute value for this offer record in the loyalty domain',
    `discount_type` STRING COMMENT 'The classification type for discount in this offer',
    `discount_value` DECIMAL(18,2) COMMENT 'The discount value attribute value for this offer record in the loyalty domain',
    `distribution_channel` STRING COMMENT 'The distribution channel attribute value for this offer record in the loyalty domain',
    `eligible_member_segments` STRING COMMENT 'Eligible segments',
    `eligible_member_tiers` STRING COMMENT 'Eligible tiers',
    `eligible_menu_items` STRING COMMENT 'Eligible items',
    `end_date` DATE COMMENT 'The date and time when the end event occurred for this offer',
    `estimated_cost_per_redemption` DECIMAL(18,2) COMMENT 'Estimated cost',
    `excluded_menu_items` STRING COMMENT 'Excluded items',
    `free_item_sku` STRING COMMENT 'The free item sku attribute value for this offer record in the loyalty domain',
    `geographic_restriction` STRING COMMENT 'The geographic restriction attribute value for this offer record in the loyalty domain',
    `image_url` STRING COMMENT 'The URL link to the image resource associated with this offer',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum purchase',
    `minimum_visit_frequency` STRING COMMENT 'Min visit frequency',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp attribute value for this offer record in the loyalty domain',
    `offer_name` STRING COMMENT 'The display name or label for the offer in this offer',
    `offer_status` STRING COMMENT 'The current status of the offer for this offer',
    `offer_type` STRING COMMENT 'The classification type for offer in this offer',
    `personalized_flag` BOOLEAN COMMENT 'Personalized',
    `points_multiplier` DECIMAL(18,2) COMMENT 'The points multiplier attribute value for this offer record in the loyalty domain',
    `priority_rank` STRING COMMENT 'The priority rank attribute value for this offer record in the loyalty domain',
    `redemption_channel` STRING COMMENT 'The redemption channel attribute value for this offer record in the loyalty domain',
    `redemption_count` STRING COMMENT 'The count or quantity of redemption items in this offer',
    `redemption_limit_per_member` STRING COMMENT 'Limit per member',
    `stackable_flag` BOOLEAN COMMENT 'Boolean indicator flag for stackable flag status in this offer',
    `start_date` DATE COMMENT 'The date and time when the start event occurred for this offer',
    `target_redemption_count` STRING COMMENT 'Target redemptions',
    `terms_and_conditions` STRING COMMENT 'The terms and conditions attribute value for this offer record in the loyalty domain',
    `total_redemption_limit` STRING COMMENT 'Total limit',
    CONSTRAINT pk_offer PRIMARY KEY(`offer_id`)
) COMMENT 'Targeted offers available to loyalty members based on segments, tiers, and behavior';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` (
    `offer_assignment_id` BIGINT COMMENT 'Unique identifier',
    `campaign_id` BIGINT COMMENT 'Associated campaign',
    `member_id` BIGINT COMMENT 'Member assigned',
    `offer_id` BIGINT COMMENT 'Offer assigned',
    `loyalty_segment_id` BIGINT COMMENT 'Unique identifier for the loyalty segment associated with this offer assignment',
    `ab_test_variant` STRING COMMENT 'A/B test variant',
    `assignment_channel` STRING COMMENT 'The assignment channel attribute value for this offer assignment record in the loyalty domain',
    `assignment_reason_code` STRING COMMENT 'Reason code',
    `assignment_source` STRING COMMENT 'The assignment source attribute value for this offer assignment record in the loyalty domain',
    `assignment_timestamp` TIMESTAMP COMMENT 'Assignment time',
    `assignment_type` STRING COMMENT 'The classification type for assignment in this offer assignment',
    `clicked_timestamp` TIMESTAMP COMMENT 'Click time',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this offer assignment record in the loyalty domain',
    `delivery_status` STRING COMMENT 'The current status of the delivery for this offer assignment',
    `delivery_timestamp` TIMESTAMP COMMENT 'Delivery time',
    `effective_start_date` DATE COMMENT 'Start date',
    `expiry_date` DATE COMMENT 'The date and time when the expiry event occurred for this offer assignment',
    `first_redemption_timestamp` TIMESTAMP COMMENT 'First redemption',
    `is_wallet_visible` BOOLEAN COMMENT 'Wallet visible',
    `last_redemption_timestamp` TIMESTAMP COMMENT 'Last redemption',
    `max_redemption_count` STRING COMMENT 'Max redemptions',
    `notification_preference_honored` BOOLEAN COMMENT 'Notification pref honored',
    `opened_timestamp` TIMESTAMP COMMENT 'Opened time',
    `personalization_score` DECIMAL(18,2) COMMENT 'The personalization score attribute value for this offer assignment record in the loyalty domain',
    `priority_rank` STRING COMMENT 'The priority rank attribute value for this offer assignment record in the loyalty domain',
    `redemption_count` STRING COMMENT 'The count or quantity of redemption items in this offer assignment',
    `redemption_status` STRING COMMENT 'The current status of the redemption for this offer assignment',
    `revocation_reason` STRING COMMENT 'The revocation reason attribute value for this offer assignment record in the loyalty domain',
    `revocation_timestamp` TIMESTAMP COMMENT 'Revocation time',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this offer assignment record in the loyalty domain',
    `wallet_display_start_timestamp` TIMESTAMP COMMENT 'Wallet display start',
    CONSTRAINT pk_offer_assignment PRIMARY KEY(`offer_assignment_id`)
) COMMENT 'Assignment of offers to individual loyalty members with tracking of delivery and redemption status';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` (
    `offer_redemption_id` BIGINT COMMENT 'Unique identifier',
    `campaign_id` BIGINT COMMENT 'Unique identifier for the campaign associated with this offer redemption',
    `guest_order_id` BIGINT COMMENT 'Unique identifier for the guest order associated with this offer redemption',
    `member_id` BIGINT COMMENT 'Unique identifier for the member associated with this offer redemption',
    `offer_id` BIGINT COMMENT 'Unique identifier for the offer associated with this offer redemption',
    `pos_terminal_id` BIGINT COMMENT 'POS terminal',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the primary offer cashier employee associated with this offer redemption record',
    `unit_id` BIGINT COMMENT 'Unique identifier for the restaurant unit associated with this offer redemption',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this offer redemption record in the loyalty domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this offer redemption',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this offer redemption',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for discount in this offer redemption',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Discount pct',
    `discount_type` STRING COMMENT 'The classification type for discount in this offer redemption',
    `final_order_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for final order in this offer redemption',
    `is_duplicate_attempt` BOOLEAN COMMENT 'Duplicate attempt',
    `is_first_redemption` BOOLEAN COMMENT 'First redemption',
    `member_tier` STRING COMMENT 'The member tier attribute value for this offer redemption record in the loyalty domain',
    `offer_distribution_channel` STRING COMMENT 'Distribution channel',
    `offer_expiration_date` DECIMAL(18,2) COMMENT 'Expiration',
    `original_order_amount` DECIMAL(18,2) COMMENT 'Original order',
    `points_earned` STRING COMMENT 'The points earned attribute value for this offer redemption record in the loyalty domain',
    `points_multiplier_applied` DECIMAL(18,2) COMMENT 'Multiplier applied',
    `redemption_channel` STRING COMMENT 'The redemption channel attribute value for this offer redemption record in the loyalty domain',
    `redemption_code` STRING COMMENT 'A standardized code representing the redemption classification for this offer redemption',
    `redemption_status` STRING COMMENT 'The current status of the redemption for this offer redemption',
    `redemption_timestamp` TIMESTAMP COMMENT 'The redemption timestamp attribute value for this offer redemption record in the loyalty domain',
    `transaction_reference_number` STRING COMMENT 'Transaction ref',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this offer redemption record in the loyalty domain',
    `validation_method` STRING COMMENT 'The validation method attribute value for this offer redemption record in the loyalty domain',
    `void_reason` STRING COMMENT 'The void reason attribute value for this offer redemption record in the loyalty domain',
    `void_timestamp` TIMESTAMP COMMENT 'The void timestamp attribute value for this offer redemption record in the loyalty domain',
    CONSTRAINT pk_offer_redemption PRIMARY KEY(`offer_redemption_id`)
) COMMENT 'Record of offer redemptions by loyalty members at restaurant units';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` (
    `challenge_id` BIGINT COMMENT 'Unique identifier',
    `franchisee_id` BIGINT COMMENT 'Franchisee',
    `site_id` BIGINT COMMENT 'Unique identifier for the site associated with this challenge',
    `approved_by` STRING COMMENT 'The approved by attribute value for this challenge record in the loyalty domain',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval time',
    `budget_allocated` DECIMAL(18,2) COMMENT 'The budget allocated attribute value for this challenge record in the loyalty domain',
    `challenge_status` STRING COMMENT 'The current status of the challenge for this challenge',
    `challenge_type` STRING COMMENT 'The classification type for challenge in this challenge',
    `channel_availability` STRING COMMENT 'The channel availability attribute value for this challenge record in the loyalty domain',
    `challenge_code` STRING COMMENT 'A standardized code representing the challenge classification for this challenge',
    `completion_count` STRING COMMENT 'Completions',
    `completion_window_days` STRING COMMENT 'Window days',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this challenge record in the loyalty domain',
    `current_participants` STRING COMMENT 'The current participants attribute value for this challenge record in the loyalty domain',
    `challenge_description` STRING COMMENT 'The challenge description attribute value for this challenge record in the loyalty domain',
    `eligibility_scope` STRING COMMENT 'Eligibility',
    `eligible_segment` STRING COMMENT 'The eligible segment attribute value for this challenge record in the loyalty domain',
    `eligible_tier` STRING COMMENT 'The eligible tier attribute value for this challenge record in the loyalty domain',
    `end_date` DATE COMMENT 'The date and time when the end event occurred for this challenge',
    `estimated_cost_per_completion` DECIMAL(18,2) COMMENT 'Cost per completion',
    `image_url` STRING COMMENT 'The URL link to the image resource associated with this challenge',
    `is_repeatable` BOOLEAN COMMENT 'Repeatable',
    `max_participants` STRING COMMENT 'The max participants attribute value for this challenge record in the loyalty domain',
    `modified_by` STRING COMMENT 'The modified by attribute value for this challenge record in the loyalty domain',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp attribute value for this challenge record in the loyalty domain',
    `challenge_name` STRING COMMENT 'The display name or label for the challenge in this challenge',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this challenge',
    `priority_rank` STRING COMMENT 'The priority rank attribute value for this challenge record in the loyalty domain',
    `repeat_frequency_days` STRING COMMENT 'Repeat frequency',
    `reward_description` STRING COMMENT 'The reward description attribute value for this challenge record in the loyalty domain',
    `reward_type` STRING COMMENT 'The classification type for reward in this challenge',
    `reward_value` DECIMAL(18,2) COMMENT 'The reward value attribute value for this challenge record in the loyalty domain',
    `start_date` DATE COMMENT 'The date and time when the start event occurred for this challenge',
    `target_acv_lift` DECIMAL(18,2) COMMENT 'The target acv lift attribute value for this challenge record in the loyalty domain',
    `target_criteria` STRING COMMENT 'The target criteria attribute value for this challenge record in the loyalty domain',
    `target_frequency_lift` DECIMAL(18,2) COMMENT 'The target frequency lift attribute value for this challenge record in the loyalty domain',
    `target_quantity` DECIMAL(18,2) COMMENT 'The count or quantity of target items in this challenge',
    `target_unit` STRING COMMENT 'The target unit attribute value for this challenge record in the loyalty domain',
    `terms_and_conditions` STRING COMMENT 'The terms and conditions attribute value for this challenge record in the loyalty domain',
    `created_by` STRING COMMENT 'The created by attribute value for this challenge record in the loyalty domain',
    CONSTRAINT pk_challenge PRIMARY KEY(`challenge_id`)
) COMMENT 'Gamification challenges that incentivize specific member behaviors';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` (
    `challenge_enrollment_id` BIGINT COMMENT 'Unique identifier',
    `campaign_id` BIGINT COMMENT 'Unique identifier for the campaign associated with this challenge enrollment',
    `challenge_id` BIGINT COMMENT 'Unique identifier for the challenge associated with this challenge enrollment',
    `unit_id` BIGINT COMMENT 'Unique identifier for the challenge restaurant unit associated with this challenge enrollment',
    `challenge_unit_id` BIGINT COMMENT 'Unique identifier for the challenge unit associated with this challenge enrollment',
    `member_id` BIGINT COMMENT 'Unique identifier for the loyalty member associated with this challenge enrollment',
    `cancellation_date` DATE COMMENT 'The date and time when the cancellation event occurred for this challenge enrollment',
    `cancellation_reason` STRING COMMENT 'The cancellation reason attribute value for this challenge enrollment record in the loyalty domain',
    `challenge_enrollment_status` STRING COMMENT 'The current status of the challenge enrollment for this challenge enrollment',
    `completion_date` DATE COMMENT 'The date and time when the completion event occurred for this challenge enrollment',
    `completion_timestamp` TIMESTAMP COMMENT 'Completion time',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this challenge enrollment record in the loyalty domain',
    `days_remaining` STRING COMMENT 'The days remaining attribute value for this challenge enrollment record in the loyalty domain',
    `days_to_completion` STRING COMMENT 'The days to completion attribute value for this challenge enrollment record in the loyalty domain',
    `disqualification_reason` STRING COMMENT 'The disqualification reason attribute value for this challenge enrollment record in the loyalty domain',
    `end_date` DATE COMMENT 'The date and time when the end event occurred for this challenge enrollment',
    `enrollment_channel` STRING COMMENT 'The enrollment channel attribute value for this challenge enrollment record in the loyalty domain',
    `enrollment_date` DATE COMMENT 'The date and time when the enrollment event occurred for this challenge enrollment',
    `enrollment_number` STRING COMMENT 'The enrollment number attribute value for this challenge enrollment record in the loyalty domain',
    `enrollment_source` STRING COMMENT 'The enrollment source attribute value for this challenge enrollment record in the loyalty domain',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Enrollment time',
    `last_activity_date` DATE COMMENT 'Last activity',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Last activity time',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this challenge enrollment',
    `notification_enabled_flag` BOOLEAN COMMENT 'Notifications enabled',
    `opt_in_flag` BOOLEAN COMMENT 'Boolean indicator flag for opt in flag status in this challenge enrollment',
    `progress_percentage` DECIMAL(18,2) COMMENT 'Progress pct',
    `progress_unit` STRING COMMENT 'The progress unit attribute value for this challenge enrollment record in the loyalty domain',
    `progress_value` DECIMAL(18,2) COMMENT 'The progress value attribute value for this challenge enrollment record in the loyalty domain',
    `reward_issued_date` DATE COMMENT 'The date and time when the reward issued event occurred for this challenge enrollment',
    `reward_issued_flag` BOOLEAN COMMENT 'Reward issued',
    `reward_type` STRING COMMENT 'The classification type for reward in this challenge enrollment',
    `reward_value` DECIMAL(18,2) COMMENT 'The reward value attribute value for this challenge enrollment record in the loyalty domain',
    `start_date` DATE COMMENT 'The date and time when the start event occurred for this challenge enrollment',
    `target_value` DECIMAL(18,2) COMMENT 'The target value attribute value for this challenge enrollment record in the loyalty domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this challenge enrollment record in the loyalty domain',
    CONSTRAINT pk_challenge_enrollment PRIMARY KEY(`challenge_enrollment_id`)
) COMMENT 'Member enrollment and progress tracking for loyalty challenges';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier',
    `birthday_bonus_points` STRING COMMENT 'Birthday bonus',
    `program_code` STRING COMMENT 'A standardized code representing the program classification for this program',
    `country_codes` STRING COMMENT 'The country codes attribute value for this program record in the loyalty domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this program record in the loyalty domain',
    `currency_name` STRING COMMENT 'Points currency name',
    `program_description` STRING COMMENT 'The program description attribute value for this program record in the loyalty domain',
    `dollar_per_point` DECIMAL(18,2) COMMENT 'The dollar per point attribute value for this program record in the loyalty domain',
    `end_date` DATE COMMENT 'The date and time when the end event occurred for this program',
    `enrollment_bonus_points` STRING COMMENT 'Enrollment bonus',
    `enrollment_channels` STRING COMMENT 'The enrollment channels attribute value for this program record in the loyalty domain',
    `gamification_enabled_flag` BOOLEAN COMMENT 'Gamification enabled',
    `geographic_scope` STRING COMMENT 'The geographic scope attribute value for this program record in the loyalty domain',
    `launch_date` DATE COMMENT 'The date and time when the launch event occurred for this program',
    `manager_email` STRING COMMENT 'Program manager email',
    `manager_name` STRING COMMENT 'Program manager name',
    `minimum_redemption_points` STRING COMMENT 'Min redemption points',
    `modified_timestamp` TIMESTAMP COMMENT 'The modified timestamp attribute value for this program record in the loyalty domain',
    `program_name` STRING COMMENT 'The display name or label for the program in this program',
    `olo_integration_enabled_flag` DECIMAL(18,2) COMMENT 'OLO integration',
    `ownership_model` STRING COMMENT 'The ownership model attribute value for this program record in the loyalty domain',
    `personalization_enabled_flag` BOOLEAN COMMENT 'Personalization',
    `points_expiration_months` DECIMAL(18,2) COMMENT 'Months until expiration',
    `points_per_dollar` DECIMAL(18,2) COMMENT 'The points per dollar attribute value for this program record in the loyalty domain',
    `pos_integration_enabled_flag` DECIMAL(18,2) COMMENT 'POS integration',
    `privacy_policy_url` STRING COMMENT 'The URL link to the privacy policy resource associated with this program',
    `program_status` STRING COMMENT 'The current status of the program for this program',
    `program_type` STRING COMMENT 'The classification type for program in this program',
    `referral_bonus_points` STRING COMMENT 'Referral bonus',
    `restaurant_formats` STRING COMMENT 'The restaurant formats attribute value for this program record in the loyalty domain',
    `subscription_fee_amount` DECIMAL(18,2) COMMENT 'Subscription fee',
    `subscription_fee_frequency` STRING COMMENT 'Fee frequency',
    `target_audience` STRING COMMENT 'The target audience attribute value for this program record in the loyalty domain',
    `terms_and_conditions_url` STRING COMMENT 'The URL link to the terms and conditions resource associated with this program',
    `third_party_delivery_enabled_flag` BOOLEAN COMMENT '3PD enabled',
    `tier_enabled_flag` BOOLEAN COMMENT 'Tiers enabled',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Loyalty program configuration including earning rules, tiers, and program-level settings';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` (
    `enrollment_event_id` BIGINT COMMENT 'Unique identifier',
    `campaign_id` BIGINT COMMENT 'Unique identifier for the enrollment campaign associated with this enrollment event',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the enrollment employee associated with this enrollment event record',
    `guest_order_id` BIGINT COMMENT 'Unique identifier for the enrollment guest order associated with this enrollment event',
    `unit_id` BIGINT COMMENT 'Unique identifier for the enrollment unit associated with this enrollment event',
    `tier_id` BIGINT COMMENT 'Initial tier',
    `member_id` BIGINT COMMENT 'Unique identifier for the primary enrollment member associated with this enrollment event',
    `program_id` BIGINT COMMENT 'Unique identifier for the program associated with this enrollment event',
    `offer_id` BIGINT COMMENT 'Welcome offer',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this enrollment event record in the loyalty domain',
    `email_opt_in_flag` BOOLEAN COMMENT 'Email opt-in',
    `enrollment_channel` STRING COMMENT 'The enrollment channel attribute value for this enrollment event record in the loyalty domain',
    `enrollment_country_code` STRING COMMENT 'A standardized code representing the enrollment country classification for this enrollment event',
    `enrollment_device_type` STRING COMMENT 'The classification type for enrollment device in this enrollment event',
    `enrollment_geolocation` STRING COMMENT 'Geolocation',
    `enrollment_ip_address` STRING COMMENT 'IP address',
    `enrollment_language` STRING COMMENT 'The enrollment language attribute value for this enrollment event record in the loyalty domain',
    `enrollment_notes` STRING COMMENT 'The enrollment notes attribute value for this enrollment event record in the loyalty domain',
    `enrollment_number` STRING COMMENT 'The enrollment number attribute value for this enrollment event record in the loyalty domain',
    `enrollment_source_system` STRING COMMENT 'Source system',
    `enrollment_status` STRING COMMENT 'The current status of the enrollment for this enrollment event',
    `enrollment_timestamp` TIMESTAMP COMMENT 'The enrollment timestamp attribute value for this enrollment event record in the loyalty domain',
    `enrollment_type` STRING COMMENT 'The classification type for enrollment in this enrollment event',
    `fraud_check_status` STRING COMMENT 'Fraud check',
    `fraud_score` DECIMAL(18,2) COMMENT 'The fraud score attribute value for this enrollment event record in the loyalty domain',
    `initial_points_awarded` STRING COMMENT 'Initial points',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Marketing opt-in',
    `push_notification_opt_in_flag` BOOLEAN COMMENT 'Push opt-in',
    `referral_code` STRING COMMENT 'A standardized code representing the referral classification for this enrollment event',
    `referral_source` STRING COMMENT 'The referral source attribute value for this enrollment event record in the loyalty domain',
    `sms_opt_in_flag` BOOLEAN COMMENT 'SMS opt-in',
    `terms_accepted_flag` BOOLEAN COMMENT 'Terms accepted',
    `terms_version` STRING COMMENT 'The terms version attribute value for this enrollment event record in the loyalty domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this enrollment event record in the loyalty domain',
    `verification_completed_flag` BOOLEAN COMMENT 'Verification completed',
    `verification_completed_timestamp` TIMESTAMP COMMENT 'Verification time',
    `verification_required_flag` BOOLEAN COMMENT 'Verification required',
    `welcome_offer_issued_flag` BOOLEAN COMMENT 'Welcome offer issued',
    CONSTRAINT pk_enrollment_event PRIMARY KEY(`enrollment_event_id`)
) COMMENT 'Record of member enrollment events with channel, verification, and opt-in details';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`referral` (
    `referral_id` BIGINT COMMENT 'Unique identifier',
    `campaign_id` BIGINT COMMENT 'Unique identifier for the campaign associated with this referral',
    `member_id` BIGINT COMMENT 'Referred member',
    `unit_id` BIGINT COMMENT 'Enrollment location',
    `profile_id` BIGINT COMMENT 'Guest profile',
    `referral_referred_guest_profile_id` BIGINT COMMENT 'Referred guest',
    `referral_unit_id` BIGINT COMMENT 'Unique identifier for the referral unit associated with this referral',
    `channel` STRING COMMENT 'The channel attribute value for this referral record in the loyalty domain',
    `referral_code` STRING COMMENT 'A standardized code representing the referral classification for this referral',
    `conversion_date` DATE COMMENT 'The date and time when the conversion event occurred for this referral',
    `conversion_timestamp` TIMESTAMP COMMENT 'Conversion time',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this referral record in the loyalty domain',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration',
    `first_transaction_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for first transaction in this referral',
    `first_transaction_date` DATE COMMENT 'The date and time when the first transaction event occurred for this referral',
    `fraud_flag` BOOLEAN COMMENT 'Boolean indicator flag for fraud flag status in this referral',
    `fraud_reason` STRING COMMENT 'The fraud reason attribute value for this referral record in the loyalty domain',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified',
    `message` STRING COMMENT 'The message attribute value for this referral record in the loyalty domain',
    `modified_by_user` STRING COMMENT 'Modified by',
    `referral_date` DATE COMMENT 'The date and time when the referral event occurred for this referral',
    `referral_status` STRING COMMENT 'The current status of the referral for this referral',
    `referral_timestamp` TIMESTAMP COMMENT 'The referral timestamp attribute value for this referral record in the loyalty domain',
    `referred_bonus_awarded_date` DATE COMMENT 'Referred bonus date',
    `referred_bonus_points` STRING COMMENT 'The referred bonus points attribute value for this referral record in the loyalty domain',
    `referrer_bonus_awarded_date` DATE COMMENT 'Referrer bonus date',
    `referrer_bonus_points` STRING COMMENT 'The referrer bonus points attribute value for this referral record in the loyalty domain',
    `source_platform` STRING COMMENT 'The source platform attribute value for this referral record in the loyalty domain',
    `terms_version` STRING COMMENT 'The terms version attribute value for this referral record in the loyalty domain',
    CONSTRAINT pk_referral PRIMARY KEY(`referral_id`)
) COMMENT 'Member-to-member referral tracking with bonus point awards';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` (
    `loyalty_segment_id` BIGINT COMMENT 'Unique identifier',
    `employee_id` BIGINT COMMENT 'Owner employee',
    `owner_user_employee_id` BIGINT COMMENT 'Owner user',
    `guest_segment_id` BIGINT COMMENT 'Guest segment cross-reference',
    `activation_date` DATE COMMENT 'The date and time when the activation event occurred for this loyalty segment',
    `acv_max_threshold` DECIMAL(18,2) COMMENT 'Max ACV threshold',
    `acv_min_threshold` DECIMAL(18,2) COMMENT 'Min ACV threshold',
    `campaign_usage_count` STRING COMMENT 'The count or quantity of campaign usage items in this loyalty segment',
    `channel_preference` STRING COMMENT 'The channel preference attribute value for this loyalty segment record in the loyalty domain',
    `control_group_flag` BOOLEAN COMMENT 'Control group',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this loyalty segment record in the loyalty domain',
    `current_tier_filter` STRING COMMENT 'Tier filter',
    `daypart_preference` STRING COMMENT 'The daypart preference attribute value for this loyalty segment record in the loyalty domain',
    `deactivation_date` DATE COMMENT 'The date and time when the deactivation event occurred for this loyalty segment',
    `definition_criteria` STRING COMMENT 'The definition criteria attribute value for this loyalty segment record in the loyalty domain',
    `exclusion_segment_ids` STRING COMMENT 'Exclusion segments',
    `geographic_scope` STRING COMMENT 'The geographic scope attribute value for this loyalty segment record in the loyalty domain',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Last refresh',
    `lifetime_points_min` BIGINT COMMENT 'Min lifetime points',
    `member_count` BIGINT COMMENT 'The count or quantity of member items in this loyalty segment',
    `menu_affinity_category` STRING COMMENT 'Menu affinity',
    `modified_by_user` STRING COMMENT 'Modified by',
    `next_refresh_date` DATE COMMENT 'Next refresh',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this loyalty segment',
    `owner_team` STRING COMMENT 'The owner team attribute value for this loyalty segment record in the loyalty domain',
    `predicted_incremental_revenue` DECIMAL(18,2) COMMENT 'Predicted revenue',
    `predicted_response_rate` DECIMAL(18,2) COMMENT 'The predicted response rate attribute value for this loyalty segment record in the loyalty domain',
    `priority_rank` STRING COMMENT 'The priority rank attribute value for this loyalty segment record in the loyalty domain',
    `recency_days_max` STRING COMMENT 'Max recency days',
    `recency_days_min` STRING COMMENT 'Min recency days',
    `refresh_frequency_days` STRING COMMENT 'Refresh frequency',
    `segment_code` STRING COMMENT 'A standardized code representing the segment classification for this loyalty segment',
    `segment_description` STRING COMMENT 'The segment description attribute value for this loyalty segment record in the loyalty domain',
    `segment_name` STRING COMMENT 'The display name or label for the segment in this loyalty segment',
    `segment_status` STRING COMMENT 'The current status of the segment for this loyalty segment',
    `segment_type` STRING COMMENT 'The classification type for segment in this loyalty segment',
    `target_market_codes` STRING COMMENT 'Target markets',
    `test_segment_flag` BOOLEAN COMMENT 'Test segment',
    `visit_frequency_threshold` STRING COMMENT 'The visit frequency threshold attribute value for this loyalty segment record in the loyalty domain',
    CONSTRAINT pk_loyalty_segment PRIMARY KEY(`loyalty_segment_id`)
) COMMENT 'Behavioral and value-based segments for targeting loyalty members';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` (
    `loyalty_visit_id` BIGINT COMMENT 'Unique identifier',
    `guest_order_id` BIGINT COMMENT 'Unique identifier for the guest order associated with this loyalty visit',
    `guest_visit_id` BIGINT COMMENT 'Guest visit cross-ref',
    `member_id` BIGINT COMMENT 'Unique identifier for the member associated with this loyalty visit',
    `unit_id` BIGINT COMMENT 'Restaurant unit',
    `channel` STRING COMMENT 'The channel attribute value for this loyalty visit record in the loyalty domain',
    `check_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for check in this loyalty visit',
    `created_at` TIMESTAMP COMMENT 'The date and time when the created event occurred for this loyalty visit',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this loyalty visit record in the loyalty domain',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this loyalty visit',
    `is_qualifying_visit` BOOLEAN COMMENT 'Qualifying visit',
    `points_earned` STRING COMMENT 'The points earned attribute value for this loyalty visit record in the loyalty domain',
    `points_redeemed` STRING COMMENT 'The points redeemed attribute value for this loyalty visit record in the loyalty domain',
    `spend_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for spend in this loyalty visit',
    `visit_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for visit in this loyalty visit',
    `visit_channel` STRING COMMENT 'The visit channel attribute value for this loyalty visit record in the loyalty domain',
    `visit_date` DATE COMMENT 'The date and time when the visit event occurred for this loyalty visit',
    `visit_time` TIMESTAMP COMMENT 'The visit time attribute value for this loyalty visit record in the loyalty domain',
    `visit_timestamp` TIMESTAMP COMMENT 'The visit timestamp attribute value for this loyalty visit record in the loyalty domain',
    CONSTRAINT pk_loyalty_visit PRIMARY KEY(`loyalty_visit_id`)
) COMMENT 'Loyalty-qualifying visits by members linked to orders and restaurant units';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` (
    `loyalty_adjustment_id` BIGINT COMMENT 'Unique identifier',
    `member_id` BIGINT COMMENT 'Member ref',
    `primary_loyalty_member_id` BIGINT COMMENT 'Unique identifier for the primary loyalty member associated with this loyalty adjustment',
    `program_id` BIGINT COMMENT 'Unique identifier for the program associated with this loyalty adjustment',
    `adjusted_at` TIMESTAMP COMMENT 'The date and time when the adjusted event occurred for this loyalty adjustment',
    `adjusted_by` STRING COMMENT 'The adjusted by attribute value for this loyalty adjustment record in the loyalty domain',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for adjustment in this loyalty adjustment',
    `adjustment_date` DATE COMMENT 'The date and time when the adjustment event occurred for this loyalty adjustment',
    `adjustment_reason` STRING COMMENT 'The adjustment reason attribute value for this loyalty adjustment record in the loyalty domain',
    `adjustment_type` STRING COMMENT 'The classification type for adjustment in this loyalty adjustment',
    `approved_by` STRING COMMENT 'The approved by attribute value for this loyalty adjustment record in the loyalty domain',
    `authorized_by` STRING COMMENT 'The authorized by attribute value for this loyalty adjustment record in the loyalty domain',
    `created_at` TIMESTAMP COMMENT 'The date and time when the created event occurred for this loyalty adjustment',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this loyalty adjustment record in the loyalty domain',
    `is_reversal` BOOLEAN COMMENT 'Boolean indicator flag for is reversal status in this loyalty adjustment',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this loyalty adjustment',
    `points_adjusted` STRING COMMENT 'The points adjusted attribute value for this loyalty adjustment record in the loyalty domain',
    `points_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for points in this loyalty adjustment',
    `points_delta` STRING COMMENT 'The points delta attribute value for this loyalty adjustment record in the loyalty domain',
    `reason` STRING COMMENT 'The reason attribute value for this loyalty adjustment record in the loyalty domain',
    `reason_code` STRING COMMENT 'A standardized code representing the reason classification for this loyalty adjustment',
    `reason_description` STRING COMMENT 'The reason description attribute value for this loyalty adjustment record in the loyalty domain',
    `reference_note` STRING COMMENT 'The reference note attribute value for this loyalty adjustment record in the loyalty domain',
    `reference_number` BIGINT COMMENT 'Reference ID',
    `loyalty_adjustment_status` STRING COMMENT 'The current status of the loyalty adjustment for this loyalty adjustment',
    CONSTRAINT pk_loyalty_adjustment PRIMARY KEY(`loyalty_adjustment_id`)
) COMMENT 'Manual and system-initiated adjustments to member point balances';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` (
    `program_campaign_allocation_id` BIGINT COMMENT 'Unique identifier',
    `campaign_id` BIGINT COMMENT 'Unique identifier for the campaign associated with this program campaign allocation',
    `program_id` BIGINT COMMENT 'Unique identifier for the program associated with this program campaign allocation',
    `allocated_budget` DECIMAL(18,2) COMMENT 'The allocated budget attribute value for this program campaign allocation record in the loyalty domain',
    `allocation_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for allocation in this program campaign allocation',
    `allocation_date` DATE COMMENT 'The date and time when the allocation event occurred for this program campaign allocation',
    `allocation_end_date` DATE COMMENT 'The date and time when the allocation end event occurred for this program campaign allocation',
    `allocation_percent` DECIMAL(18,2) COMMENT 'The allocation percent attribute value for this program campaign allocation record in the loyalty domain',
    `allocation_start_date` DATE COMMENT 'Start date',
    `allocation_status` STRING COMMENT 'The current status of the allocation for this program campaign allocation',
    `budget_allocation` DECIMAL(18,2) COMMENT 'The budget allocation attribute value for this program campaign allocation record in the loyalty domain',
    `created_at` TIMESTAMP COMMENT 'The date and time when the created event occurred for this program campaign allocation',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this program campaign allocation record in the loyalty domain',
    `currency` STRING COMMENT 'The currency attribute value for this program campaign allocation record in the loyalty domain',
    `end_date` DATE COMMENT 'The date and time when the end event occurred for this program campaign allocation',
    `start_date` DATE COMMENT 'The date and time when the start event occurred for this program campaign allocation',
    `program_campaign_allocation_status` STRING COMMENT 'The current status of the program campaign allocation for this program campaign allocation',
    `target_audience` STRING COMMENT 'The target audience attribute value for this program campaign allocation record in the loyalty domain',
    CONSTRAINT pk_program_campaign_allocation PRIMARY KEY(`program_campaign_allocation_id`)
) COMMENT 'Budget and resource allocation from loyalty programs to marketing campaigns';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_referred_by_member_id` FOREIGN KEY (`referred_by_member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ADD CONSTRAINT `fk_loyalty_tier_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_reversal_of_transaction_points_ledger_id` FOREIGN KEY (`reversal_of_transaction_points_ledger_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`points_ledger`(`points_ledger_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`reward`(`reward_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`reward`(`reward_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ADD CONSTRAINT `fk_loyalty_offer_assignment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ADD CONSTRAINT `fk_loyalty_offer_assignment_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ADD CONSTRAINT `fk_loyalty_offer_assignment_loyalty_segment_id` FOREIGN KEY (`loyalty_segment_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`loyalty_segment`(`loyalty_segment_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ADD CONSTRAINT `fk_loyalty_challenge_enrollment_challenge_id` FOREIGN KEY (`challenge_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`challenge`(`challenge_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ADD CONSTRAINT `fk_loyalty_challenge_enrollment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ADD CONSTRAINT `fk_loyalty_referral_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ADD CONSTRAINT `fk_loyalty_loyalty_visit_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ADD CONSTRAINT `fk_loyalty_loyalty_adjustment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ADD CONSTRAINT `fk_loyalty_loyalty_adjustment_primary_loyalty_member_id` FOREIGN KEY (`primary_loyalty_member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ADD CONSTRAINT `fk_loyalty_loyalty_adjustment_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` ADD CONSTRAINT `fk_loyalty_program_campaign_allocation_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`loyalty` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`loyalty` SET TAGS ('dbx_domain' = 'loyalty');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `primary_member_preferred_location_unit_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referred_by_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referred_by_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `birthday_month` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `birthday_month` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `birthday_reward_eligible` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `birthday_reward_eligible` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `tier_history_id` SET TAGS ('dbx_business_glossary_term' = 'Tier History ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` SET TAGS ('dbx_subdomain' = 'points_rewards');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Points Ledger ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` SET TAGS ('dbx_subdomain' = 'points_rewards');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `partner_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` SET TAGS ('dbx_subdomain' = 'points_rewards');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `accrual_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `offer_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Assignment ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `offer_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Redemption ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `challenge_id` SET TAGS ('dbx_business_glossary_term' = 'Challenge ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `challenge_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `challenge_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Challenge Enrollment ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `country_codes` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `currency_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `manager_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_geolocation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_geolocation` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_ip_address` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` SET TAGS ('dbx_ssot_deprecated_duplicate' = 'guest.guest_segment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `loyalty_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Segment ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` SET TAGS ('dbx_ssot_deprecated_duplicate' = 'guest.guest_visit');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ALTER COLUMN `loyalty_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Visit ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` SET TAGS ('dbx_subdomain' = 'points_rewards');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` SET TAGS ('dbx_ssot_deprecated_duplicate' = 'inventory.inventory_adjustment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ALTER COLUMN `loyalty_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Adjustment ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ALTER COLUMN `primary_loyalty_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ALTER COLUMN `primary_loyalty_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` SET TAGS ('dbx_association_edges' = 'loyalty.program,marketing.campaign');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` ALTER COLUMN `program_campaign_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Program Campaign Allocation ID');
