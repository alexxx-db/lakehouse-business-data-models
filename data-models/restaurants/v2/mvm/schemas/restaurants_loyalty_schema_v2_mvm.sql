-- Schema for Domain: loyalty | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-02 04:02:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`loyalty` COMMENT 'Manages guest loyalty program enrollment, membership tiers, points accrual and redemption, rewards catalog, promotional offers, personalized campaigns, member engagement, and loyalty analytics. Drives repeat visits, ACV lift, and customer lifetime value through targeted incentives and gamification across OLO and POS channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`member` (
    `member_id` BIGINT COMMENT 'Unique identifier for the loyalty member',
    `employee_id` BIGINT COMMENT 'Employee managing this member account',
    `profile_id` BIGINT COMMENT 'Guest profile linked to this member',
    `unit_id` BIGINT COMMENT 'Preferred location unit',
    `member_profile_id` BIGINT COMMENT 'Guest profile reference',
    `member_unit_id` BIGINT COMMENT 'Restaurant unit reference',
    `primary_member_preferred_location_unit_id` BIGINT COMMENT 'Member preferred restaurant location',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: A loyalty member must belong to a specific loyalty program. The member table currently has no FK to program, yet program is the top-level configuration entity governing all member behavior, earning ru',
    `referred_by_member_id` BIGINT COMMENT 'Member who referred this member',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: The member table stores current_tier as a denormalized STRING. Normalizing this to a FK (member_tier_id -> loyalty.tier.tier_id) allows proper joins to tier benefits, qualification thresholds, and mul',
    `account_closure_date` DATE COMMENT 'Date the member account was closed',
    `account_closure_reason` STRING COMMENT 'Reason for account closure',
    `account_created_timestamp` TIMESTAMP COMMENT 'Timestamp when account was created',
    `account_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last account update',
    `badges_earned` STRING COMMENT 'Total gamification badges earned',
    `birthday_month` STRING COMMENT 'Birth month for birthday rewards',
    `current_points_balance` DECIMAL(18,2) COMMENT 'Current available points balance',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` (
    `points_ledger_id` BIGINT COMMENT 'Unique identifier',
    `accrual_rule_id` BIGINT COMMENT 'Foreign key linking to loyalty.accrual_rule. Business justification: Points ledger entries for earnings are governed by specific accrual rules. Recording which accrual rule triggered a points earning event is essential for audit, dispute resolution, and rule effectiven',
    `enrollment_event_id` BIGINT COMMENT 'Foreign key linking to loyalty.enrollment_event. Business justification: When a member enrolls and receives an enrollment bonus (initial_points_awarded on enrollment_event), a points credit entry is created in the points_ledger. Linking the ledger entry to the enrollment_e',
    `member_id` BIGINT COMMENT 'Member who owns points',
    `offer_redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.offer_redemption. Business justification: When a member redeems an offer that awards bonus points (e.g., double points offer), a points credit entry is created in the points_ledger. Linking the ledger entry to the offer_redemption event (poin',
    `employee_id` BIGINT COMMENT 'Employee who made adjustment',
    `guest_order_id` BIGINT COMMENT 'Associated order',
    `unit_id` BIGINT COMMENT 'Restaurant unit',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.redemption. Business justification: When a member redeems a reward, a points debit entry is created in the points_ledger. Linking the ledger debit entry to the redemption event (points_ledger_redemption_id -> loyalty.redemption.redempti',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Rewards are brand-specific in multi-brand portfolios (e.g., a free item reward valid only at Brand X). Loyalty marketing teams scope rewards by brand for campaign management and P&L attribution. The e',
    `menu_item_id` BIGINT COMMENT 'Menu item for reward',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Rewards are defined within the context of a loyalty program. A reward catalog entry belongs to one program (e.g., a franchise-specific program may have different rewards than a national program). Addi',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Supplier-sponsored rewards (co-branded promotions where a supplier funds a loyalty reward) are a real restaurant loyalty business process. partner_name and partner_offer_code are denormalized supplier',
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
    `points_cost` DECIMAL(18,2) COMMENT 'Points required',
    `quantity_limit_per_member` STRING COMMENT 'Max per member',
    `redemption_channel_app` BOOLEAN COMMENT 'Available on app',
    `redemption_channel_drive_thru` BOOLEAN COMMENT 'Available at drive-thru',
    `redemption_channel_olo` BOOLEAN COMMENT 'Available for OLO',
    `redemption_channel_pos` BOOLEAN COMMENT 'Available at POS',
    `redemption_channel_third_party_delivery` BOOLEAN COMMENT 'Available on 3PD',
    `redemption_count` BIGINT COMMENT 'Total redemptions',
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
    `employee_id` BIGINT COMMENT 'Employee who processed',
    `guest_order_id` BIGINT COMMENT 'Associated order',
    `member_id` BIGINT COMMENT 'Member redeeming',
    `menu_item_id` BIGINT COMMENT 'Menu item redeemed',
    `pos_terminal_id` BIGINT COMMENT 'POS terminal',
    `unit_id` BIGINT COMMENT 'Restaurant unit',
    `redemption_unit_id` BIGINT COMMENT 'Unit reference',
    `reward_id` BIGINT COMMENT 'Reward redeemed',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: The redemption table stores member_tier as a STRING snapshot of the tier at redemption time. Adding redemption_tier_id -> loyalty.tier.tier_id provides a proper FK reference to the tier entity, enabli',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Accrual rules are frequently brand-scoped in multi-brand enterprises (e.g., Brand X earns 2x points). Loyalty operations teams configure and audit earning rules per brand. Current franchise_id_list ',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Points accrual rule scoping: loyalty operations configure which specific menu items qualify for point earning (e.g., premium items earn 2x points). A direct FK to menu_item enables rule validation, me',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Promotional offers in multi-brand restaurant groups are brand-scoped (e.g., Double points at Brand X this weekend). Marketing and loyalty teams configure, target, and measure offer performance by br',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the created by employee associated with this offer record',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Free-item offer configuration: when an offer awards a specific free menu item, operations and marketing must link the offer to the exact menu_item for POS fulfillment, cost tracking, and offer perform',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Targeted offers are created and governed within a loyalty program context. The offer table has no FK to program, yet offers are program-specific (e.g., a birthday offer belongs to a specific programs',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` (
    `offer_redemption_id` BIGINT COMMENT 'Unique identifier',
    `guest_order_id` BIGINT COMMENT 'Unique identifier for the guest order associated with this offer redemption',
    `member_id` BIGINT COMMENT 'Unique identifier for the member associated with this offer redemption',
    `offer_id` BIGINT COMMENT 'Unique identifier for the offer associated with this offer redemption',
    `pos_terminal_id` BIGINT COMMENT 'POS terminal',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the primary offer cashier employee associated with this offer redemption record',
    `unit_id` BIGINT COMMENT 'Unique identifier for the restaurant unit associated with this offer redemption',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: The offer_redemption table stores member_tier as a STRING snapshot of the tier at offer redemption time. Adding offer_redemption_tier_id -> loyalty.tier.tier_id provides a proper FK reference enabling',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: In multi-brand restaurant enterprises, each loyalty program belongs to a specific brand (e.g., Brand X Rewards). Brand managers and loyalty directors need to configure, report, and govern programs b',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_referred_by_member_id` FOREIGN KEY (`referred_by_member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ADD CONSTRAINT `fk_loyalty_tier_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_accrual_rule_id` FOREIGN KEY (`accrual_rule_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`accrual_rule`(`accrual_rule_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_enrollment_event_id` FOREIGN KEY (`enrollment_event_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`enrollment_event`(`enrollment_event_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_offer_redemption_id` FOREIGN KEY (`offer_redemption_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer_redemption`(`offer_redemption_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`redemption`(`redemption_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_reversal_of_transaction_points_ledger_id` FOREIGN KEY (`reversal_of_transaction_points_ledger_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`points_ledger`(`points_ledger_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`reward`(`reward_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`reward`(`reward_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`loyalty` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`loyalty` SET TAGS ('dbx_domain' = 'loyalty');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` SET TAGS ('dbx_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `unit_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `primary_member_preferred_location_unit_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Member Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referred_by_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referred_by_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Member Tier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `birthday_month` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `birthday_month` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `birthday_reward_eligible` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `birthday_reward_eligible` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` SET TAGS ('dbx_subdomain' = 'points_activity');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Points Ledger ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `accrual_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Points Ledger Accrual Rule Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `enrollment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Points Ledger Enrollment Event Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `offer_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Points Ledger Offer Redemption Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Points Ledger Redemption Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` SET TAGS ('dbx_subdomain' = 'points_activity');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` SET TAGS ('dbx_subdomain' = 'points_activity');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Tier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `accrual_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Scope Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` SET TAGS ('dbx_subdomain' = 'offer_engagement');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Free Item Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `image_url` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` SET TAGS ('dbx_subdomain' = 'offer_engagement');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `offer_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Redemption ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Redemption Tier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` SET TAGS ('dbx_subdomain' = 'member_enrollment');
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
