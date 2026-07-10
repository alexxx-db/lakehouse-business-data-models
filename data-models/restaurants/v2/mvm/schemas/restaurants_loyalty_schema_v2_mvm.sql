-- Schema for Domain: loyalty | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-10 20:02:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`loyalty` COMMENT 'Manages guest loyalty program enrollment, membership tiers, points accrual and redemption, rewards catalog, promotional offers, personalized campaigns, member engagement, and loyalty analytics. Drives repeat visits, ACV lift, and customer lifetime value through targeted incentives and gamification across OLO and POS channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`member` (
    `member_id` BIGINT COMMENT 'Unique identifier for the loyalty program member. Primary key for the member entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for assigning a dedicated employee to manage high‑value members, enabling personalized service and performance reporting.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: member.current_tier is currently a STRING denormalization of the tier name. Adding current_tier_id as a FK to loyalty.tier.tier_id normalizes this relationship, enabling proper JOIN-based tier lookups',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.channel. Business justification: Member enrollment channel attribution is critical for loyalty program ROI analysis by channel and digital acquisition reporting. enrollment_channel is currently a plain text denormalization of the cha',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the guest domain master record. Links loyalty membership to the guest profile system of record.',
    `unit_id` BIGINT COMMENT 'Restaurant location that the member visits most frequently or has designated as their preferred location. Used for personalized offers and location-based campaigns.',
    `member_profile_id` BIGINT COMMENT 'Foreign key reference to the guest domain master record. Links loyalty membership to the guest profile system of record.',
    `member_unit_id` BIGINT COMMENT 'Restaurant location where the member enrolled, if enrollment occurred at a physical location. Null for digital enrollments.',
    `primary_member_preferred_location_unit_id` BIGINT COMMENT 'Restaurant location that the member visits most frequently or has designated as their preferred location. Used for personalized offers and location-based campaigns.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Supports franchisee‑level loyalty analytics by linking each member to the owning franchisee, used in franchise performance dashboards.',
    `referred_by_member_id` BIGINT COMMENT 'Member ID of the existing member who referred this member to the loyalty program. Null if member enrolled without a referral.',
    `account_closure_date` DATE COMMENT 'Date when the loyalty membership was closed or terminated. Null for active memberships. Used for retention analysis and right-to-be-forgotten compliance.',
    `account_closure_reason` STRING COMMENT 'Business reason for account closure. Examples: member request, fraud, inactivity, duplicate account, policy violation, data privacy request.',
    `account_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the loyalty member record was first created in the system. Audit field for data lineage and compliance.',
    `account_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the loyalty member record was last modified. Audit field for data lineage and change tracking.',
    `badges_earned` STRING COMMENT 'Total number of achievement badges earned by the member through gamification activities, challenges, and milestones.',
    `birthday_month` STRING COMMENT 'Month of the members birthday (1-12). Stored without year or day for privacy. Used for birthday reward campaigns and personalized offers.',
    `current_points_balance` BIGINT COMMENT 'Current available points balance that the member can redeem. Calculated as lifetime earned minus lifetime redeemed minus expired points.',
    `data_privacy_consent_date` DATE COMMENT 'Date when the member provided explicit consent for data collection, processing, and storage under applicable privacy regulations.',
    `direct_mail_opt_in` BOOLEAN COMMENT 'Indicates whether the member has consented to receive physical direct mail offers and communications. True if opted in, False if opted out.',
    `email_opt_in` BOOLEAN COMMENT 'Indicates whether the member has consented to receive promotional and transactional emails. True if opted in, False if opted out.',
    `enrollment_date` DATE COMMENT 'Date when the guest enrolled in the loyalty program. Marks the start of the member lifecycle.',
    `gamification_level` STRING COMMENT 'Current level in the loyalty program gamification system. Members progress through levels by completing challenges, earning badges, and accumulating points.',
    `last_activity_date` DATE COMMENT 'Date of the most recent loyalty program activity by the member, including points earned, points redeemed, or profile updates. Used for churn prediction and reactivation campaigns.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent purchase transaction where the member earned or redeemed points. Subset of last_activity_date focused on revenue-generating activity.',
    `lifetime_points_earned` BIGINT COMMENT 'Total cumulative loyalty points earned by the member since enrollment. Never decreases; used for tier qualification and lifetime value analysis.',
    `lifetime_points_redeemed` BIGINT COMMENT 'Total cumulative loyalty points redeemed by the member for rewards, discounts, or offers since enrollment.',
    `membership_number` STRING COMMENT 'Externally-facing unique membership identifier displayed on loyalty cards, mobile app, and customer communications. Human-readable alphanumeric code.. Valid values are `^[A-Z0-9]{8,16}$`',
    `next_expiration_date` DATE COMMENT 'Date when the next batch of points will expire. Null if no points are scheduled to expire.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score provided by the member, ranging from 0 (detractor) to 10 (promoter). Measures member satisfaction and likelihood to recommend.',
    `nps_survey_date` DATE COMMENT 'Date when the most recent NPS survey was completed by the member.',
    `points_expiring_soon` BIGINT COMMENT 'Number of points scheduled to expire within the next 30 days. Used for proactive member engagement and retention campaigns.',
    `preferred_language` STRING COMMENT 'Members preferred language for communications and app interface. Three-letter ISO 639-2 language code.. Valid values are `ENG|SPA|FRA|GER|CHI|JPN`',
    `program_status` STRING COMMENT 'Current lifecycle status of the loyalty membership. Active: member in good standing. Suspended: temporarily blocked due to policy violation. Churned: member opted out or account closed. Inactive: no activity for extended period. Pending: enrollment initiated but not completed.. Valid values are `active|suspended|churned|inactive|pending`',
    `push_notification_opt_in` BOOLEAN COMMENT 'Indicates whether the member has consented to receive push notifications through the mobile app. True if opted in, False if opted out.',
    `referral_code` STRING COMMENT 'Unique referral code assigned to this member for member-get-member campaigns. When shared and used by new enrollees, both parties receive bonus points.. Valid values are `^[A-Z0-9]{6,12}$`',
    `sms_opt_in` BOOLEAN COMMENT 'Indicates whether the member has consented to receive promotional and transactional SMS text messages. True if opted in, False if opted out.',
    `status_reason` STRING COMMENT 'Business reason or explanation for the current program status. Examples: fraud detection, member request, inactivity, policy violation, system migration.',
    `terms_accepted_date` DATE COMMENT 'Date when the member accepted the loyalty program terms and conditions. Required for legal compliance and dispute resolution.',
    `terms_version` STRING COMMENT 'Version number of the loyalty program terms and conditions that the member accepted. Format: v1.0, v2.1, etc.. Valid values are `^v[0-9]+.[0-9]+$`',
    `third_party_sharing_opt_in` BOOLEAN COMMENT 'Indicates whether the member has consented to sharing their data with third-party partners for marketing purposes. True if opted in, False if opted out.',
    `tier_effective_date` DATE COMMENT 'Date when the member achieved or was assigned their current tier level. Used for tier anniversary calculations and renewal cycles.',
    `tier_expiration_date` DATE COMMENT 'Date when the current tier status expires and member will be re-evaluated for tier qualification. Null for lifetime tiers.',
    `total_visits` STRING COMMENT 'Total number of restaurant visits or orders placed by the member since enrollment. Includes dine-in, drive-thru, OLO, and 3PD orders where loyalty was applied.',
    CONSTRAINT pk_member PRIMARY KEY(`member_id`)
) COMMENT 'Master record for every enrolled loyalty program member. Captures member identity linkage (guest_id FK to guest domain), enrollment channel (OLO, POS, in-app, kiosk, staff-assisted), enrollment date, current tier assignment, lifetime points earned/redeemed, opt-in preferences, program assignment, auto-accrue payment linkage flag, and program status (active, suspended, churned). This is the SSOT for loyalty membership identity — distinct from the guest profile master in the guest domain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`tier` (
    `tier_id` BIGINT COMMENT 'Unique identifier for the loyalty membership tier. Primary key.',
    `program_id` BIGINT COMMENT 'add column program_id (BIGINT) with FK to loyalty.program.program_id - tiers are meaningless without association to a loyalty program',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Annual membership fee charged to maintain this tier status, if applicable. Null or zero indicates no fee. Used for premium tier monetization.',
    `benefits_summary` STRING COMMENT 'Comma-separated or structured text summary of key benefits and perks associated with this tier (e.g., free delivery, birthday rewards, exclusive offers, priority support). Used for member communications and benefit entitlement logic.',
    `birthday_reward_eligible` BOOLEAN COMMENT 'Indicates whether members in this tier receive a special birthday reward (e.g., free item, bonus points, discount). True if eligible, false otherwise.',
    `tier_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the tier (e.g., BRONZE, SILVER, GOLD, PLATINUM). Used as business identifier in operational systems and reporting.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `color_code` STRING COMMENT 'Hexadecimal color code used for tier branding in digital channels (e.g., #CD7F32 for bronze, #C0C0C0 for silver, #FFD700 for gold). Used in mobile app, website, and marketing materials.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier record was first created in the loyalty system. Used for audit trail and data lineage.',
    `tier_description` STRING COMMENT 'Detailed description of the tier, including value proposition, benefits summary, and marketing messaging. Used in loyalty program communications and member portal.',
    `downgrade_threshold` DECIMAL(18,2) COMMENT 'Minimum threshold value required to maintain this tier status during re-evaluation period. Falling below this value triggers downgrade to lower tier. Null indicates no downgrade policy.',
    `early_access_lto` BOOLEAN COMMENT 'Indicates whether members in this tier receive early access to new Limited Time Offers (LTO) before general availability. True if eligible, false otherwise.',
    `effective_end_date` DATE COMMENT 'Date when this tier configuration was retired or replaced. Null indicates the tier is currently active. Used for tier lifecycle management and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when this tier configuration became active and available for member assignment. Used for tier lifecycle management and historical analysis.',
    `exclusive_offers_eligible` BOOLEAN COMMENT 'Indicates whether members in this tier receive access to exclusive promotional offers and Limited Time Offers (LTO) not available to lower tiers. True if eligible, false otherwise.',
    `free_delivery_eligible` BOOLEAN COMMENT 'Indicates whether members in this tier are eligible for free delivery on Online Ordering (OLO) and Third-Party Delivery (3PD) orders. True if eligible, false otherwise.',
    `grace_period_days` STRING COMMENT 'Number of days after tier expiration during which members retain tier benefits before downgrade. Used to provide buffer period for re-qualification.',
    `icon_url` STRING COMMENT 'URL path to the tier badge or icon image asset used in member portal, mobile app, and digital communications. Supports tier visual identity and gamification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tier record was last updated. Used for audit trail, change tracking, and data synchronization.',
    `launch_date` DATE COMMENT 'Date when this tier was officially launched to the market and communicated to guests. May differ from effective_start_date for soft launches or pilot programs.',
    `max_redemption_discount_pct` DECIMAL(18,2) COMMENT 'Maximum percentage discount that can be applied when redeeming points for rewards in this tier (e.g., 20.00 for 20% max discount). Used to control reward economics and prevent abuse.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this tier configuration. Used for audit trail and accountability.',
    `tier_name` STRING COMMENT 'Human-readable display name of the loyalty tier (e.g., Bronze Member, Silver Member, Gold Member, Platinum Elite). Used in guest-facing communications and marketing materials.',
    `points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base points accrual for members in this tier (e.g., 1.0 for base, 1.5 for 50% bonus, 2.0 for double points). Used to calculate accelerated points earning.',
    `priority_support_eligible` BOOLEAN COMMENT 'Indicates whether members in this tier receive priority customer support (e.g., dedicated phone line, faster response times). True if eligible, false otherwise.',
    `qualification_metric` STRING COMMENT 'The metric used to determine tier qualification (points accrued, visit count, total spend amount, or transaction count). Defines how qualification_threshold is interpreted.. Valid values are `points|visits|spend|transactions`',
    `qualification_period_days` STRING COMMENT 'Number of days over which the qualification threshold must be met (e.g., 365 for annual qualification, 90 for quarterly). Null indicates lifetime accumulation.',
    `qualification_threshold` DECIMAL(18,2) COMMENT 'Numeric threshold value required to qualify for this tier (e.g., 1000 points, 25 visits, $500 spend). Interpretation depends on qualification_metric.',
    `referral_bonus_points` STRING COMMENT 'Bonus points awarded to members in this tier for each successful referral of a new loyalty program member. Used to incentivize member acquisition through word-of-mouth.',
    `rollover_points_allowed` BOOLEAN COMMENT 'Indicates whether unused points can roll over to the next qualification period for members in this tier. True if rollover is allowed, false if points expire at period end.',
    `sort_order` STRING COMMENT 'Integer defining the hierarchical display order of tiers (e.g., 1 for Bronze, 2 for Silver, 3 for Gold, 4 for Platinum). Lower values represent entry-level tiers; higher values represent premium tiers.',
    `target_member_segment` STRING COMMENT 'Description of the target guest segment this tier is designed to attract and retain (e.g., frequent visitors, high spenders, digital-first guests, family diners). Used for marketing strategy and program design.',
    `tier_status` STRING COMMENT 'Current lifecycle status of the tier. Active tiers are available for member assignment; inactive tiers are temporarily disabled; retired tiers are no longer offered but may have legacy members; pending tiers are configured but not yet launched.. Valid values are `active|inactive|retired|pending`',
    `upgrade_notification` BOOLEAN COMMENT 'Indicates whether members should receive automated notification when they qualify for upgrade to this tier. True if notification is enabled, false otherwise.',
    `validity_days` STRING COMMENT 'Number of days a member retains this tier status after qualification before re-evaluation (e.g., 365 for annual renewal). Null indicates permanent tier assignment.',
    `welcome_bonus_points` STRING COMMENT 'One-time bonus points awarded to a member upon first achieving this tier. Used to incentivize tier progression and enhance member engagement.',
    CONSTRAINT pk_tier PRIMARY KEY(`tier_id`)
) COMMENT 'Reference catalog of all loyalty membership tiers (e.g., Bronze, Silver, Gold, Platinum) defined in the Restaurants loyalty program. Stores tier name, tier code, qualification threshold (points or visit count), tier benefits summary, tier multiplier for points accrual, tier validity period, and sort order. Drives tier assignment logic and benefit entitlement across the program.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` (
    `points_ledger_id` BIGINT COMMENT 'Unique identifier for each points transaction record in the loyalty ledger. Serves as the immutable primary key for this financial-grade system of record.',
    `accrual_rule_id` BIGINT COMMENT 'Foreign key linking to loyalty.accrual_rule. Business justification: Each points accrual entry in the ledger is generated by a specific accrual rule (e.g., base earn rate, bonus multiplier rule, birthday bonus rule). Linking points_ledger.accrual_rule_id → loyalty.accr',
    `member_id` BIGINT COMMENT 'Unique identifier of the loyalty program member whose points balance is affected by this transaction. Links to the member master record.',
    `offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.offer. Business justification: Bonus points accruals in the ledger are frequently tied to specific promotional offers (e.g., double points weekend, birthday bonus offer, new member enrollment offer). Linking points_ledger.offer_id ',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or customer service agent who authorized and executed the manual adjustment or reversal. Populated for adjust and reversal transactions. Critical for SOX compliance and fraud prevention.',
    `guest_order_id` BIGINT COMMENT 'Reference to the originating order transaction that triggered this points movement. Populated for earn and redeem transactions tied to guest purchases. Null for non-order events such as bonus awards, expirations, or manual adjustments.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where this points transaction originated. Populated for POS and kiosk transactions. Null for OLO, mobile app, or admin transactions not tied to a specific physical location.',
    `program_id` BIGINT COMMENT 'Identifier of the franchise entity that owns or operates the restaurant where this transaction occurred. Used for royalty calculations and franchise performance analytics. Null for company-owned locations or non-location transactions.',
    `reversal_of_transaction_points_ledger_id` BIGINT COMMENT 'Reference to the original points_ledger_id that this reversal transaction is canceling. Populated only for reversal transaction types. Creates an audit chain linking reversals to their source transactions.',
    `reward_id` BIGINT COMMENT 'Identifier of the specific reward item redeemed by the member. Populated only for redeem transaction types. Links to the rewards catalog to identify what was claimed (free item, discount, experience).',
    `source_transaction_guest_order_id` BIGINT COMMENT 'The unique transaction identifier from the originating source system. Enables end-to-end traceability and reconciliation between the loyalty ledger and upstream systems. Format varies by source system.',
    `tier_id` BIGINT COMMENT 'Identifier of the loyalty membership tier the member held at the time of this transaction. Used to determine earn rates, bonus multipliers, and redemption privileges. Links to tier master data.',
    `adjustment_reason_code` STRING COMMENT 'Standardized code explaining why a manual adjustment or reversal was made. Populated only for adjust and reversal transaction types. Supports audit compliance and customer service quality tracking.. Valid values are `customer_service|system_error|fraud_reversal|goodwill|migration|other`',
    `adjustment_reason_notes` STRING COMMENT 'Free-text explanation provided by the customer service representative or system administrator who initiated the adjustment. Populated for adjust and reversal transactions. Supports audit trail and dispute resolution.',
    `batch_reference` STRING COMMENT 'Identifier of the processing batch or job that created this ledger entry. Used for bulk operations such as nightly expiration runs, mass bonus awards, or system migrations. Null for real-time individual transactions.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or accounting period number) within the fiscal year when this transaction occurred. Supports monthly financial close, P&L reporting, and loyalty liability accrual tracking.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this points transaction occurred, derived from transaction_timestamp. Supports financial reporting, GAAP revenue recognition for breakage, and year-over-year loyalty program analytics.',
    `is_voided` BOOLEAN COMMENT 'Flag indicating whether this transaction has been voided or reversed by a subsequent transaction. True if a reversal exists, false otherwise. Immutable ledger entries are never deleted, only marked as voided.',
    `order_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order total amount. Supports multi-currency loyalty programs for international operations. Null for non-order transactions.. Valid values are `USD|CAD|EUR|GBP|MXN|AUD`',
    `order_total_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the order that triggered this points transaction, in the local currency. Used to calculate points earn rate and for financial reconciliation. Null for non-order transactions.',
    `points_balance_after` STRING COMMENT 'The cumulative running balance of points for this member immediately after this transaction was applied. Provides audit trail and reconciliation capability. Must equal prior balance plus points_delta.',
    `points_delta` STRING COMMENT 'The signed integer change in points balance for this transaction. Positive values represent accruals (earn, bonus), negative values represent deductions (redeem, expire, adjust downward). Zero-delta entries are not permitted.',
    `points_earn_rate` DECIMAL(18,2) COMMENT 'The rate at which points were earned per currency unit spent. Example: 1.0000 means 1 point per dollar, 2.0000 means 2 points per dollar (double points promotion). Populated for earn transactions, null otherwise.',
    `points_expiry_date` DATE COMMENT 'The date on which the points earned in this transaction will expire if not redeemed. Populated only for earn and bonus transaction types. Null for redeem, expire, and adjust transactions. Supports FIFO expiration logic and member communication.',
    `processed_timestamp` TIMESTAMP COMMENT 'The date and time when this ledger entry was committed to the loyalty system of record. May differ from transaction_timestamp for batch processing or delayed reconciliation. Used for ETL audit and SLA monitoring.',
    `restaurant_number` STRING COMMENT 'Human-readable store or unit number for the restaurant location. Denormalized for operational reporting and guest service. Null for non-location-specific transactions.',
    `source_channel` STRING COMMENT 'The originating channel or interface through which this points transaction was initiated: POS (Point of Sale in-store), OLO (Online Ordering web platform), mobile_app (native mobile application), kiosk (self-service in-store kiosk), 3PD (Third-Party Delivery partner), call_center (phone order), admin (manual back-office adjustment). [ENUM-REF-CANDIDATE: pos|olo|mobile_app|kiosk|3pd|call_center|admin — 7 candidates stripped; promote to reference product]',
    `source_order_number` STRING COMMENT 'Human-readable order number or receipt identifier from the POS or OLO system. Provides guest-facing reference for customer service inquiries. Null for non-order transactions.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that originated this points transaction. Supports multi-system integration and data lineage tracking. Examples: micros_pos (Oracle MICROS POS), olo_platform (Olo Digital Ordering), salesforce_crm (Salesforce Marketing Cloud), loyalty_engine (core loyalty platform), admin_portal (back-office admin tool).. Valid values are `micros_pos|olo_platform|salesforce_crm|loyalty_engine|admin_portal`',
    `transaction_timestamp` TIMESTAMP COMMENT 'The precise date and time when this points transaction occurred in the source system. Represents the business event time, not the ETL load time. Critical for sequencing and audit.',
    `transaction_type` STRING COMMENT 'Classification of the points movement: earn (points accrued from purchase or activity), redeem (points spent on rewards), expire (points lapsed due to inactivity or time limit), adjust (manual correction by support or system), bonus (promotional award), reversal (cancellation of prior transaction).. Valid values are `earn|redeem|expire|adjust|bonus|reversal`',
    `voided_timestamp` TIMESTAMP COMMENT 'The date and time when this transaction was voided by a reversal. Null if the transaction has not been voided. Supports audit trail and reconciliation.',
    CONSTRAINT pk_points_ledger PRIMARY KEY(`points_ledger_id`)
) COMMENT 'Immutable financial-grade ledger recording every points movement for a loyalty member — accruals, redemptions, expirations, adjustments, bonus awards, goodwill credits, promotional credits, dispute resolutions, system error corrections, and fraud reversals. Each row captures transaction type (earn, redeem, expire, adjust, bonus, goodwill, reversal, correction), points delta, running balance, source channel (POS, OLO, 3PD), source order reference, campaign reference, expiry date of earned points, adjustment reason code, adjustment category (goodwill, dispute, error_correction, promotional, fraud), authorizing agent (for manual adjustments), approval status (auto_approved, pending_review, approved, rejected), processing timestamp, and related original transaction reference (for reversals/corrections). This is the single SSOT for ALL member point balance movements — no other product in this domain records points changes of any kind.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`reward` (
    `reward_id` BIGINT COMMENT 'Unique identifier for the loyalty reward. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Rewards are brand-specific in multi-brand restaurant enterprises (e.g., free item reward valid only at Brand X). Brand-level reward catalog management and cost-of-goods reporting require a structured ',
    `combo_meal_id` BIGINT COMMENT 'Foreign key linking to menu.combo_meal. Business justification: Rewards can be redeemable combo meals (e.g., redeem 500 points for a combo meal). The reward product already links to menu_item but combo meals are a distinct product with bundle pricing and composi',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Campaign‑Reward mapping needed for tracking which marketing campaign created a specific reward, supporting performance analysis of campaign‑driven incentives.',
    `menu_item_id` BIGINT COMMENT 'Reference to the specific menu item associated with this reward (for food and beverage rewards). Links to the menu item master catalog. Null for non-menu rewards.',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Allows franchisees to manage their own reward catalog, needed for localized promotions and compliance reporting.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_contract. Business justification: Supplier-funded rewards (e.g., a supplier sponsors a free item reward for their product) require traceability to the specific supplier contract authorizing the funding. Restaurant chains use this link',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Needed for Reward‑Supplier cost tracking and compliance; loyalty rewards are sourced from suppliers, and reporting requires linking each reward to its supplying supplier.',
    `availability_end_date` DATE COMMENT 'Date when this reward is no longer available for redemption. Null for evergreen rewards with no expiration. Used for Limited Time Offer (LTO) rewards and seasonal promotions.',
    `availability_start_date` DATE COMMENT 'Date when this reward becomes available for redemption by loyalty members. Used for Limited Time Offer (LTO) rewards and seasonal promotions.',
    `reward_code` STRING COMMENT 'Externally-known unique alphanumeric code for the reward, used in Point of Sale (POS) and Online Ordering (OLO) systems for redemption lookup.. Valid values are `^[A-Z0-9]{6,12}$`',
    `combinable_with_other_offers` BOOLEAN COMMENT 'Indicates whether this reward can be combined with other promotional offers, coupons, or discounts in a single transaction. True if combinable, False if exclusive.',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'Direct cost to the business to fulfill this reward, including food cost, packaging, and direct labor. Used for profitability analysis, loyalty program Return on Investment (ROI) calculation, and financial accrual. Expressed in USD.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reward record was first created in the system. Used for audit trail and data lineage tracking.',
    `daypart_restriction` STRING COMMENT 'Specifies which daypart(s) this reward can be redeemed during: breakfast, lunch, dinner, late night, or all day. Used to manage product mix (PMIX) and drive traffic during specific service periods.. Valid values are `breakfast|lunch|dinner|late_night|all_day`',
    `reward_description` STRING COMMENT 'Detailed description of the reward, including terms, conditions, and guest-facing messaging used in marketing materials and the loyalty app.',
    `discount_type` STRING COMMENT 'Type of discount mechanism applied: percentage (e.g., 10% off), fixed amount (e.g., $5 off), free item (no charge), buy-one-get-one (BOGO), or none (for non-discount rewards like merchandise or experiences).. Valid values are `percentage|fixed_amount|free_item|bogo|none`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount. For percentage discounts, this is the percentage (e.g., 15.00 for 15%). For fixed amount discounts, this is the dollar amount (e.g., 5.00 for $5 off). Null for free items and non-discount rewards.',
    `featured_flag` BOOLEAN COMMENT 'Indicates whether this reward is featured prominently in the loyalty app and marketing campaigns. True if featured, False if standard catalog placement. Used to drive awareness and redemption of strategic rewards.',
    `format_restriction_list` STRING COMMENT 'Comma-separated list of restaurant format types where this reward is valid (e.g., QSR, casual, fine-dining, food court). Null if applicable to all formats. Used when restaurant_applicability_scope is specific_formats.',
    `image_url` STRING COMMENT 'URL path to the reward image asset displayed in the loyalty app, Online Ordering (OLO) platform, and marketing materials. Used for visual merchandising and guest engagement.',
    `market_restriction_list` STRING COMMENT 'Comma-separated list of market codes or geographic regions where this reward is valid. Null if applicable to all markets. Used when restaurant_applicability_scope is specific_markets.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount required to redeem this reward. Null if no minimum purchase is required. Used to protect Average Check Value (ACV) and prevent low-value transactions.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this reward record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this reward record was last modified. Used for audit trail, change tracking, and data synchronization across systems.',
    `monetary_value` DECIMAL(18,2) COMMENT 'Estimated dollar value equivalent of the reward for financial reporting, liability accrual, and Average Check Value (ACV) impact analysis. Expressed in USD.',
    `reward_name` STRING COMMENT 'Human-readable name of the reward displayed to guests in the loyalty app, Online Ordering (OLO) platform, and Point of Sale (POS) system.',
    `partner_name` STRING COMMENT 'Name of the third-party partner providing this reward (for partner offers). Null for internally-fulfilled rewards. Used for co-branded rewards and strategic partnerships.',
    `partner_offer_code` STRING COMMENT 'External offer code or voucher code provided by the partner for redemption tracking. Null for internally-fulfilled rewards.',
    `points_cost` STRING COMMENT 'Number of loyalty points required to redeem this reward. Used to calculate point liability and drive guest engagement.',
    `quantity_limit_per_member` STRING COMMENT 'Maximum number of times a single loyalty member can redeem this reward during the availability window. Null indicates no limit.',
    `redemption_channel_app` BOOLEAN COMMENT 'Indicates whether this reward can be redeemed exclusively through the branded mobile app (distinct from general OLO). True if eligible, False if not.',
    `redemption_channel_drive_thru` BOOLEAN COMMENT 'Indicates whether this reward can be redeemed at Drive-Thru (DT) service points. True if eligible, False if not.',
    `redemption_channel_olo` BOOLEAN COMMENT 'Indicates whether this reward can be redeemed through Online Ordering (OLO) platforms including web and mobile app. True if eligible, False if not.',
    `redemption_channel_pos` BOOLEAN COMMENT 'Indicates whether this reward can be redeemed at Point of Sale (POS) terminals in restaurant locations. True if eligible, False if not.',
    `redemption_channel_third_party_delivery` BOOLEAN COMMENT 'Indicates whether this reward can be redeemed through Third-Party Delivery (3PD) platforms such as DoorDash, Uber Eats, or Grubhub. True if eligible, False if not.',
    `redemption_count` BIGINT COMMENT 'Total number of times this reward has been redeemed by loyalty members since inception. Used for popularity analysis, inventory planning, and loyalty program performance reporting.',
    `restaurant_applicability_scope` STRING COMMENT 'Defines which restaurant units can honor this reward: all units (system-wide), specific markets (geographic regions), specific formats (Quick-Service Restaurant (QSR), casual, fine-dining), franchise only, or company-owned only.. Valid values are `all_units|specific_markets|specific_formats|franchise_only|company_owned_only`',
    `reward_status` STRING COMMENT 'Current lifecycle status of the reward: active (available for redemption), inactive (temporarily unavailable), pending (scheduled for future activation), expired (past availability end date), or discontinued (permanently removed from catalog).. Valid values are `active|inactive|pending|expired|discontinued`',
    `reward_type` STRING COMMENT 'Classification of the reward by category: food item (free menu item), beverage (free drink), discount (percentage or dollar off), merchandise (branded goods), experience (event access, VIP treatment), or partner offer (third-party rewards).. Valid values are `food_item|beverage|discount|merchandise|experience|partner_offer`',
    `tax_treatment` STRING COMMENT 'Indicates how sales tax is applied to this reward: taxable (tax calculated on reward value), non-taxable (no tax applied), or tax included (tax already embedded in points cost). Required for accurate Point of Sale (POS) processing and financial reporting.. Valid values are `taxable|non_taxable|tax_included`',
    `terms_and_conditions` STRING COMMENT 'Legal terms and conditions governing the redemption and use of this reward. Includes restrictions, exclusions, and compliance language required by Federal Trade Commission (FTC) regulations.',
    `tier_eligibility` STRING COMMENT 'Specifies which loyalty membership tier(s) are eligible to redeem this reward. Used to create tier-exclusive rewards that drive tier progression and engagement.. Valid values are `all_tiers|bronze|silver|gold|platinum`',
    `total_quantity_limit` STRING COMMENT 'Maximum total number of redemptions allowed across all loyalty members for this reward. Used for limited-supply rewards and exclusive experiences. Null indicates no limit.',
    `created_by` STRING COMMENT 'User identifier or system account that created this reward record. Used for audit trail and accountability.',
    CONSTRAINT pk_reward PRIMARY KEY(`reward_id`)
) COMMENT 'Master catalog of all redeemable rewards available in the Restaurants loyalty rewards catalog — free menu items, discounts, merchandise, experiences, and partner offers. Captures reward name, reward type (food, discount, merchandise, experience), points cost, monetary value equivalent, redemption channel eligibility (POS, OLO, app), availability window (start/end date), quantity limit, restaurant applicability scope (all units, specific markets, specific formats), and active status. Distinct from promotional offers which are push-based incentives.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` (
    `redemption_id` BIGINT COMMENT 'Unique identifier for the loyalty reward redemption transaction. Primary key.',
    `combo_meal_id` BIGINT COMMENT 'Foreign key linking to menu.combo_meal. Business justification: When a guest redeems points for a combo meal reward, the redemption event must reference the specific combo_meal redeemed. The redemption product has menu_item_id for single-item redemptions but no FK',
    `employee_id` BIGINT COMMENT 'Reference to the employee who processed the redemption transaction at the POS, if applicable to in-store redemptions.',
    `guest_order_id` BIGINT COMMENT 'Reference to the order transaction where the reward was applied and redeemed.',
    `member_id` BIGINT COMMENT 'Reference to the loyalty program member who redeemed the reward.',
    `menu_item_id` BIGINT COMMENT 'Reference to the specific menu item that was redeemed or discounted through this reward, if applicable to item-specific rewards.',
    `offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.offer. Business justification: A redemption event is frequently triggered by a specific loyalty offer (e.g., a BOGO offer, a discount offer, or a bonus points offer). Linking redemption.offer_id → loyalty.offer.offer_id enables off',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal or kiosk device where the redemption was processed, sourced from Oracle MICROS POS system.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the redemption occurred.',
    `redemption_unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the redemption occurred.',
    `reward_id` BIGINT COMMENT 'Reference to the specific reward item redeemed from the loyalty rewards catalog.',
    `channel` STRING COMMENT 'The customer-facing channel through which the reward was redeemed. POS (Point of Sale) for in-store counter, OLO (Online Ordering) for web ordering, mobile app for native app, kiosk for self-service terminal, drive-thru for drive-through window, third-party delivery for 3PD platforms.. Valid values are `pos|olo|mobile_app|kiosk|drive_thru|third_party_delivery`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was first created in the loyalty system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'The time-of-day segment when the redemption occurred, used for analyzing redemption patterns by service period.. Valid values are `breakfast|lunch|afternoon|dinner|late_night`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount value applied to the order as a result of the reward redemption, in local currency.',
    `expiration_date` DATE COMMENT 'Date on which the redeemed reward was set to expire if not used, relevant for tracking near-expiry redemption behavior.',
    `fraud_flag` BOOLEAN COMMENT 'Boolean indicator set to true if the redemption was flagged for potential fraudulent activity or policy violation.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numeric fraud risk score assigned by the loyalty platform fraud detection engine, ranging from 0.00 (low risk) to 100.00 (high risk).',
    `fulfillment_code` STRING COMMENT 'Alphanumeric confirmation code generated upon successful fulfillment of the redemption, used for audit and reconciliation.. Valid values are `^[A-Z0-9]{8,12}$`',
    `member_tier` STRING COMMENT 'Loyalty program membership tier of the member at the time of redemption, used for tier-based redemption analysis.. Valid values are `bronze|silver|gold|platinum|vip`',
    `notes` STRING COMMENT 'Free-text notes or comments captured by the employee or system regarding special circumstances or issues with the redemption.',
    `order_total_after_discount` DECIMAL(18,2) COMMENT 'Total order amount after the loyalty reward discount was applied, representing the net revenue from the transaction.',
    `order_total_before_discount` DECIMAL(18,2) COMMENT 'Total order amount before the loyalty reward discount was applied, used for calculating incremental ACV (Average Check Value) impact.',
    `points_balance_after` STRING COMMENT 'Loyalty points balance of the member immediately after this redemption transaction.',
    `points_balance_before` STRING COMMENT 'Loyalty points balance of the member immediately before this redemption transaction.',
    `points_deducted` STRING COMMENT 'Number of loyalty points deducted from the member account to redeem this reward.',
    `redemption_number` STRING COMMENT 'Externally visible unique business identifier for the redemption transaction, used for customer service and tracking.. Valid values are `^RDM-[0-9]{10}$`',
    `redemption_status` STRING COMMENT 'Current lifecycle status of the redemption transaction. Pending indicates awaiting fulfillment, fulfilled indicates successfully applied, voided indicates cancelled before fulfillment, expired indicates reward expired before use, reversed indicates post-fulfillment reversal, failed indicates technical or validation failure.. Valid values are `pending|fulfilled|voided|expired|reversed|failed`',
    `redemption_timestamp` TIMESTAMP COMMENT 'Date and time when the loyalty member initiated the reward redemption at the point of sale or online ordering platform.',
    `reversal_reason` STRING COMMENT 'Free-text explanation for why the redemption was reversed or voided, captured for customer service and fraud analysis.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when the redemption was reversed or voided, if applicable.',
    `reward_type` STRING COMMENT 'Classification of the reward redeemed. Discount for percentage or fixed amount off, free item for complimentary menu item, BOGO (Buy One Get One) for promotional offer, upgrade for size or quality enhancement, combo deal for bundled offer, birthday reward for member birthday incentive.. Valid values are `discount|free_item|bogo|upgrade|combo_deal|birthday_reward`',
    `source` STRING COMMENT 'Indicates how the redemption was initiated. Manual for member-selected reward, automatic for system-applied offer, promotional trigger for campaign-driven redemption, gamification for achievement-based reward, tier benefit for membership tier perk.. Valid values are `manual|automatic|promotional_trigger|gamification|tier_benefit`',
    `third_party_delivery_partner` STRING COMMENT 'Name of the third-party delivery platform if the redemption occurred through a 3PD channel (e.g., DoorDash, Uber Eats, Grubhub).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was last modified in the loyalty system.',
    CONSTRAINT pk_redemption PRIMARY KEY(`redemption_id`)
) COMMENT 'Transactional record of every burn event by a loyalty member — both reward catalog redemptions (member-initiated pull from rewards catalog) and offer redemptions (program-initiated push incentives). Captures member reference, redemption type (reward, offer), reward or offer reference, redemption channel (POS, OLO, drive-thru, kiosk), restaurant unit, order reference, redemption timestamp, points deducted, monetary discount applied, offer assignment reference (for offer-type), delivery confirmation details, redemption status (pending, fulfilled, voided, expired, duplicate_attempt), and fulfillment confirmation. Unified SSOT for ALL burn events — no other product in this domain records redemption transactions. Enables holistic redemption analytics, PMIX impact analysis, offer ROI measurement, and reward popularity tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` (
    `accrual_rule_id` BIGINT COMMENT 'Unique identifier for the loyalty points accrual rule. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Loyalty accrual rules are scoped to specific brands in multi-brand restaurant enterprises (e.g., Brand X double-points promotion). Brand loyalty managers configure and report on brand-specific earning',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.channel. Business justification: Accrual rules are scoped to specific channels (e.g., double points on mobile app orders only). Normalizing channel_scope to a proper FK enables accurate points calculation engine routing, channel-spec',
    `combo_meal_id` BIGINT COMMENT 'Foreign key linking to menu.combo_meal. Business justification: Accrual rules are commonly scoped to combo meal purchases (e.g., earn 3x points on any combo meal purchase). Combo meals are a primary revenue driver in QSR/fast casual restaurants and a standard ac',
    `menu_id` BIGINT COMMENT 'Foreign key linking to menu.menu. Business justification: Accrual rules are scoped to specific menus/channels (e.g., earn points only on digital menu or breakfast menu double points). Restaurant loyalty operations routinely configure channel- and menu-ve',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Loyalty program configuration requires linking earning rules to specific menu items (e.g., 2x points on premium burgers). Loyalty analysts configure item-level accrual rules daily. The existing men',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Accrual rules belong to a specific loyalty program; linking accrual_rule to program enables program‑level governance of rules.',
    `tier_id` BIGINT COMMENT 'add column tier_id (BIGINT) with FK to loyalty.tier.tier_id - accrual rules often vary by tier level',
    `approved_by` STRING COMMENT 'User ID of the loyalty program manager or business owner who approved this rule for activation. Null for draft rules. Used for governance and approval workflow tracking.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this accrual rule was approved for activation. Null for draft or unapproved rules. Part of governance audit trail.',
    `channel_scope` STRING COMMENT 'Order channel(s) where this accrual rule is active. All = applies across all channels, POS = Point of Sale (Point of Sale) in-store, OLO = Online Ordering (Online Ordering) web/app, Mobile_app = native mobile application, Kiosk = self-service kiosk, Drive_thru = drive-through lane, 3PD = Third-Party Delivery (Third-Party Delivery) platforms. [ENUM-REF-CANDIDATE: all|pos|olo|mobile_app|kiosk|drive_thru|3pd — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this accrual rule record was first created in the system. Part of audit trail.',
    `daypart_scope` STRING COMMENT 'Comma-separated list of daypart codes (e.g., breakfast, lunch, dinner, late_night) to which this rule applies. Empty or null = applies to all dayparts. Used for time-of-day promotional earning.',
    `earning_basis` STRING COMMENT 'The calculation basis for points accrual. Dollar_spent = points per currency unit, Transaction_count = points per visit, Item_count = points per menu item purchased, Fixed_event = flat points for qualifying event.. Valid values are `dollar_spent|transaction_count|item_count|fixed_event`',
    `effective_end_date` DATE COMMENT 'Date when this accrual rule expires and stops awarding points. Null = no expiration (evergreen rule). Part of the rules validity period.',
    `effective_start_date` DATE COMMENT 'Date when this accrual rule becomes active and begins awarding points. Part of the rules validity period.',
    `exclusion_list` STRING COMMENT 'Comma-separated list of menu item codes, categories, or member segments explicitly excluded from this rule. Used to carve out exceptions (e.g., alcohol, gift cards, discounted items).',
    `fixed_points_amount` STRING COMMENT 'Flat number of points awarded for qualifying events (e.g., 500 points for birthday, 100 points for survey completion). Used when earning_basis is fixed_event. Null for variable earning rules.',
    `franchise_id_list` STRING COMMENT 'Comma-separated list of franchisee IDs when franchise_scope is specific_franchisee. Null for all other franchise scopes.',
    `franchise_scope` STRING COMMENT 'Ownership model scope for this rule. All = applies to all restaurants, Company_owned = corporate locations only, Franchise = franchisee locations only, Specific_franchisee = limited to designated franchisee IDs (stored in franchise_id_list).. Valid values are `all|company_owned|franchise|specific_franchisee`',
    `geographic_scope` STRING COMMENT 'Comma-separated list of country codes, region codes, or restaurant location codes where this rule is active. Empty or null = applies globally. Used for market-specific promotions.',
    `maximum_points_per_day` STRING COMMENT 'Cap on the number of points a member can earn per calendar day under this rule. Null = no daily cap. Used for frequency-based earning controls.',
    `maximum_points_per_member` STRING COMMENT 'Lifetime or campaign-period cap on points a single member can earn under this rule. Null = no member cap. Used for limited-time offers and promotional campaigns.',
    `maximum_points_per_transaction` STRING COMMENT 'Cap on the number of points that can be earned in a single transaction under this rule. Null = no cap. Used to prevent abuse and manage liability.',
    `member_tier_scope` STRING COMMENT 'Comma-separated list of loyalty tier codes (e.g., bronze, silver, gold, platinum) eligible for this rule. Empty or null = applies to all tiers. Used for tier-exclusive earning opportunities.',
    `menu_category_scope` STRING COMMENT 'Comma-separated list of menu category codes to which this rule applies. Empty or null = applies to all categories. Used to restrict earning to specific product categories (e.g., beverages, entrees, LTO items).',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum transaction subtotal required to qualify for this accrual rule. Null = no minimum threshold. Used for spend-tier promotions.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this accrual rule. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this accrual rule record was last updated. Part of audit trail for change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional business context, implementation notes, or special instructions related to this accrual rule. Used by loyalty program managers for operational documentation.',
    `points_expiration_days` STRING COMMENT 'Number of days from earning date after which points awarded by this rule expire. Null = points do not expire. Used for promotional points with limited validity.',
    `points_per_unit` DECIMAL(18,2) COMMENT 'Number of loyalty points awarded per unit of the earning basis (e.g., 10 points per dollar spent, 50 points per transaction). Null for fixed_event earning basis.',
    `requires_opt_in` BOOLEAN COMMENT 'Indicates whether members must explicitly opt in or activate this rule to earn points. True = member action required, False = automatically applied to eligible transactions.',
    `rule_code` STRING COMMENT 'Business-readable unique code for the accrual rule (e.g., BASE_EARN, TIER_BONUS, BIRTHDAY_PROMO). Used for operational reference and system integration.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `rule_description` STRING COMMENT 'Detailed description of the accrual rule, including business logic, conditions, and intended use case.',
    `rule_name` STRING COMMENT 'Human-readable name of the accrual rule for display and reporting purposes.',
    `rule_priority` STRING COMMENT 'Numeric priority for conflict resolution when multiple accrual rules apply to the same transaction. Lower number = higher priority. Used to determine which rule takes precedence (e.g., promotional rule overrides base earning).',
    `rule_status` STRING COMMENT 'Current lifecycle state of the accrual rule. Draft = under development, Active = currently awarding points, Paused = temporarily disabled, Expired = past effective_end_date, Archived = retired and no longer in use.. Valid values are `draft|active|paused|expired|archived`',
    `rule_type` STRING COMMENT 'Category of earning trigger that activates this accrual rule. Purchase = transaction-based earning, Visit = frequency-based earning, Referral = member-get-member, Birthday = anniversary reward, Survey = feedback incentive, Signup = enrollment bonus.. Valid values are `purchase|visit|referral|birthday|survey|signup`',
    `stackable` BOOLEAN COMMENT 'Indicates whether this rule can be combined with other accrual rules in the same transaction. True = can stack with other rules, False = mutually exclusive (highest priority rule wins).',
    `tier_multiplier_applicable` BOOLEAN COMMENT 'Indicates whether member tier multipliers (e.g., Gold = 1.5x, Platinum = 2x) apply to this accrual rule. True = tier bonus applies, False = base earning only.',
    `version_number` STRING COMMENT 'Version number of this accrual rule for change tracking and auditability. Incremented each time the rule is modified. Supports rule versioning and rollback.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this accrual rule. Used for audit trail and accountability.',
    CONSTRAINT pk_accrual_rule PRIMARY KEY(`accrual_rule_id`)
) COMMENT 'Business rules governing how loyalty points are earned across channels, dayparts, menu categories, and member tiers. Each rule defines the earning trigger (purchase, visit, referral, birthday, survey), points awarded per dollar spent or per qualifying event, applicable tier multipliers, menu item or category scope, channel scope (POS, OLO, 3PD), effective date range, and rule priority for conflict resolution. Managed by the loyalty program team and versioned for auditability.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`offer` (
    `offer_id` BIGINT COMMENT 'Unique identifier for the loyalty offer. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Marketing teams create brand-specific loyalty offers in multi-brand restaurant groups (e.g., Brand X members only). Brand-scoped offer eligibility reporting and campaign management require a structu',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.channel. Business justification: Loyalty offers are restricted to specific channels (e.g., app-only offers). A proper FK to channel normalizes the text redemption_channel field, enabling channel-specific offer eligibility enforcement',
    `combo_meal_id` BIGINT COMMENT 'Foreign key linking to menu.combo_meal. Business justification: Loyalty offers are frequently structured around combo meals (e.g., buy any combo meal, earn bonus points or combo meal discount for loyalty members). Restaurant loyalty programs routinely target c',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links each promotional offer to the employee who created it, supporting audit trails, attribution, and marketing performance analysis.',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Loyalty offers grant a specific free menu item (e.g., free fries with any purchase). The existing free_item_sku is a denormalized SKU string referencing a menu_item. Role-prefix free_item_ disti',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Links offers to the franchisee that runs them, required for franchise‑specific marketing ROI analysis.',
    `approved_by_user` STRING COMMENT 'Username or user ID of the marketing manager who approved the offer for distribution. Null if offer is still in draft status.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the offer was approved for distribution. Null if offer is still in draft status.',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether the offer is automatically applied at checkout when eligibility criteria are met (True) or requires manual code entry by the member (False).',
    `bonus_points_value` STRING COMMENT 'Number of bonus loyalty points awarded when the offer is redeemed. Applicable to bonus_points and challenge offer types. Null for other offer types.',
    `offer_code` STRING COMMENT 'Externally-visible unique alphanumeric code used by members to redeem the offer at POS or OLO channels. Typically 6-12 characters.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_by_user` STRING COMMENT 'Username or user ID of the marketing team member who created the offer in Salesforce CRM.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the offer record was first created in the Salesforce CRM system.',
    `day_of_week_restriction` STRING COMMENT 'Comma-separated list of days of the week when the offer is valid (e.g., monday,tuesday,wednesday). Null if valid all days.',
    `daypart_restriction` STRING COMMENT 'Daypart(s) during which the offer is valid: breakfast, lunch, dinner, late_night, all_day. Null if no daypart restriction applies.. Valid values are `breakfast|lunch|dinner|late_night|all_day|`',
    `offer_description` STRING COMMENT 'Detailed marketing copy describing the offer terms, benefits, and redemption instructions displayed to members.',
    `discount_type` STRING COMMENT 'Mechanism of discount for discount-type offers: percentage (e.g., 20% off), fixed_amount (e.g., $5 off), free_item (specific SKU at no charge). Null for non-discount offer types.. Valid values are `percentage|fixed_amount|free_item|`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount: percentage (e.g., 20.00 for 20%), dollar amount (e.g., 5.00 for $5 off), or 0 for free_item offers. Null for non-discount offer types.',
    `distribution_channel` STRING COMMENT 'Primary channel through which the offer is communicated to members: push_notification, email, in_app (mobile app banner), sms, pos_display (printed receipt or screen), direct_mail.. Valid values are `push_notification|email|in_app|sms|pos_display|direct_mail`',
    `eligible_member_tiers` STRING COMMENT 'Comma-separated list of loyalty membership tier codes eligible to receive this offer (e.g., silver, gold, platinum). Null if offer is available to all tiers.',
    `eligible_menu_items` STRING COMMENT 'Comma-separated list of menu item SKUs or category codes that qualify for the offer. Null if offer applies to entire menu or transaction total.',
    `end_date` DATE COMMENT 'Date when the offer expires and is no longer redeemable. Null for evergreen offers without a fixed expiration.',
    `estimated_cost_per_redemption` DECIMAL(18,2) COMMENT 'Estimated financial cost to the business for each redemption of this offer, including discount value and incremental COGS. Used for campaign budget planning and ROI analysis.',
    `excluded_menu_items` STRING COMMENT 'Comma-separated list of menu item SKUs or category codes explicitly excluded from the offer (e.g., alcohol, LTO items). Null if no exclusions.',
    `geographic_restriction` STRING COMMENT 'Comma-separated list of geographic region codes, market codes, or restaurant IDs where the offer is valid. Null if valid at all locations.',
    `image_url` STRING COMMENT 'URL to the promotional image or banner displayed with the offer in mobile app, email, and digital channels.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum transaction subtotal (before tax) required to qualify for the offer. Null if no minimum purchase requirement.',
    `minimum_visit_frequency` STRING COMMENT 'Minimum number of visits in the trailing 90 days required for a member to be eligible for this offer. Null if no visit frequency requirement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the offer record was last modified in the Salesforce CRM system.',
    `offer_name` STRING COMMENT 'Marketing name of the offer displayed to loyalty members in app, email, and push notifications.',
    `offer_status` STRING COMMENT 'Current lifecycle state of the offer: draft (being designed), scheduled (approved, awaiting start date), active (live and redeemable), paused (temporarily suspended), expired (end date passed), cancelled (terminated before expiration).. Valid values are `draft|scheduled|active|paused|expired|cancelled`',
    `offer_type` STRING COMMENT 'Classification of the offer mechanism: discount (percentage or dollar off), bonus_points (accelerated points accrual), free_item (complimentary menu item), bogo (buy-one-get-one), challenge (gamification task), sweepstakes (prize drawing entry).. Valid values are `discount|bonus_points|free_item|bogo|challenge|sweepstakes`',
    `personalized_flag` BOOLEAN COMMENT 'Indicates whether this offer is personalized to individual members based on purchase history and preferences (True) or is a mass offer distributed to all eligible members (False).',
    `points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base points accrual during the offer period (e.g., 2.00 for double points, 3.00 for triple points). Applicable to bonus_points offers. Null for other offer types.',
    `priority_rank` STRING COMMENT 'Display priority ranking for this offer when multiple offers are available to a member. Lower numbers indicate higher priority (1 = highest).',
    `redemption_channel` STRING COMMENT 'Channel(s) where the offer can be redeemed: pos (in-store point of sale), olo (online ordering), mobile_app, kiosk, drive_thru, all_channels (omnichannel).. Valid values are `pos|olo|mobile_app|kiosk|drive_thru|all_channels`',
    `redemption_count` STRING COMMENT 'Current cumulative count of redemptions for this offer across all members. Updated in near-real-time from POS and OLO transaction feeds.',
    `redemption_limit_per_member` STRING COMMENT 'Maximum number of times a single loyalty member can redeem this offer during its active period. Null for unlimited redemptions.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this offer can be combined with other offers in a single transaction. True = stackable, False = exclusive.',
    `start_date` DATE COMMENT 'Date when the offer becomes active and available for redemption by eligible members.',
    `target_redemption_count` STRING COMMENT 'Marketing teams target goal for total number of redemptions during the offer period. Used for campaign performance evaluation.',
    `terms_and_conditions` STRING COMMENT 'Legal terms and conditions governing the offer, including eligibility, restrictions, expiration, and disclaimers. Required for compliance with FTC advertising regulations.',
    `total_redemption_limit` STRING COMMENT 'Maximum total number of redemptions allowed across all members for this offer (budget cap). Null for unlimited total redemptions.',
    CONSTRAINT pk_offer PRIMARY KEY(`offer_id`)
) COMMENT 'Master record for all personalized and mass loyalty offers distributed to members — targeted discounts, BOGO deals, bonus points events, LTO (Limited Time Offer) incentives, and gamification challenge rewards. Captures offer name, offer type (discount, bonus_points, free_item, challenge, sweepstakes), offer value, eligibility criteria (tier, segment, visit frequency), distribution channel (push notification, email, in-app, POS display), start/end dates, redemption limit per member, and offer status. Also owns member-level offer assignment detail: each assignment captures target member or segment, assignment channel, assignment timestamp, delivery status (sent, delivered, opened, clicked), member-specific expiry date, personalization flag, and engagement tracking. Sourced from Salesforce CRM campaign execution. Enables offer wallet management, delivery tracking, and distribution analytics.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier for the loyalty program. Primary key.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: A loyalty program is owned by and associated with a specific brand (e.g., Brand X Rewards). Brand P&L reporting and brand-level loyalty analytics require this link. unit.program_id→program exists bu',
    `birthday_bonus_points` STRING COMMENT 'Number of bonus points awarded to members on their birthday. Zero if no birthday bonus is offered.',
    `program_code` STRING COMMENT 'Externally-known unique business identifier for the loyalty program used in integrations and reporting (e.g., REWARDS_PLUS, STAR_CLUB).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where the program is available (e.g., USA,CAN,MEX). Null for global programs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `currency_name` STRING COMMENT 'Name of the loyalty currency used in the program (e.g., Stars, Points, Coins, Miles, Rewards).',
    `program_description` STRING COMMENT 'Detailed description of the loyalty program value proposition, benefits, and how it works. Used for internal reference and guest communications.',
    `dollar_per_point` DECIMAL(18,2) COMMENT 'Monetary value of each loyalty point when redeemed. Used to calculate redemption value and liability.',
    `end_date` DATE COMMENT 'Date when the loyalty program was discontinued or sunset. Null for active programs.',
    `enrollment_bonus_points` STRING COMMENT 'Number of bonus points awarded to new members upon successful enrollment. Zero if no enrollment bonus is offered.',
    `enrollment_channels` STRING COMMENT 'Comma-separated list of channels through which guests can enroll in the program (e.g., mobile_app, website, pos, kiosk, third_party).',
    `gamification_enabled_flag` BOOLEAN COMMENT 'Indicates whether the program includes gamification elements such as challenges, badges, streaks, or missions.',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the loyalty program: global (all markets), regional (multi-country region), country (single country), state (sub-national), or local (specific metro/franchise group).. Valid values are `global|regional|country|state|local`',
    `launch_date` DATE COMMENT 'Date when the loyalty program was officially launched and became available for guest enrollment.',
    `manager_email` STRING COMMENT 'Email address of the program manager for internal contact and escalation purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `manager_name` STRING COMMENT 'Name of the business owner or manager responsible for the loyalty program strategy and performance.',
    `minimum_redemption_points` STRING COMMENT 'Minimum number of points required to make a redemption. Used to prevent micro-redemptions and manage transaction costs.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was last modified in the system.',
    `program_name` STRING COMMENT 'Marketing name of the loyalty program displayed to guests (e.g., Rewards Plus, Star Club, VIP Circle).',
    `olo_integration_enabled_flag` BOOLEAN COMMENT 'Indicates whether the program is integrated with online ordering platforms for digital points accrual and redemption.',
    `ownership_model` STRING COMMENT 'Ownership structure of the loyalty program: corporate (company-owned only), franchise (franchise-owned only), or hybrid (both corporate and franchise participation).. Valid values are `corporate|franchise|hybrid`',
    `personalization_enabled_flag` BOOLEAN COMMENT 'Indicates whether the program uses guest data to deliver personalized offers, recommendations, and communications.',
    `points_expiration_months` STRING COMMENT 'Number of months after which unused loyalty points expire. Null if points never expire.',
    `points_per_dollar` DECIMAL(18,2) COMMENT 'Number of loyalty points earned per dollar spent. Used to calculate points accrual from transaction amounts.',
    `pos_integration_enabled_flag` BOOLEAN COMMENT 'Indicates whether the program is integrated with POS systems for in-store points accrual and redemption.',
    `privacy_policy_url` STRING COMMENT 'Web URL to the privacy policy explaining how member data is collected, used, and protected.. Valid values are `^https?://.*$`',
    `program_status` STRING COMMENT 'Current operational status of the loyalty program: active (accepting enrollments and transactions), inactive (not operational), suspended (temporarily paused), pilot (testing phase), or sunset (being phased out).. Valid values are `active|inactive|suspended|pilot|sunset`',
    `program_type` STRING COMMENT 'Classification of the loyalty program structure: points-based (earn and redeem points), visit-based (frequency rewards), hybrid (combination), subscription (paid membership), or tiered (status levels).. Valid values are `points_based|visit_based|hybrid|subscription|tiered`',
    `referral_bonus_points` STRING COMMENT 'Number of bonus points awarded to members who successfully refer a new member. Zero if no referral program exists.',
    `restaurant_formats` STRING COMMENT 'Comma-separated list of restaurant formats where the program is valid (e.g., QSR, casual_dining, fine_dining, food_truck, ghost_kitchen).',
    `subscription_fee_amount` DECIMAL(18,2) COMMENT 'Monthly or annual subscription fee required for paid membership programs. Null for free programs.',
    `subscription_fee_frequency` STRING COMMENT 'Billing frequency for subscription-based programs: monthly, annual, or one-time. Null for free programs.. Valid values are `monthly|annual|one_time`',
    `target_audience` STRING COMMENT 'Description of the primary guest segment the program is designed to attract and retain (e.g., frequent diners, families, business travelers, value seekers).',
    `terms_and_conditions_url` STRING COMMENT 'Web URL to the official terms and conditions document governing the loyalty program.. Valid values are `^https?://.*$`',
    `third_party_delivery_enabled_flag` BOOLEAN COMMENT 'Indicates whether the program supports points accrual and redemption through third-party delivery platforms.',
    `tier_enabled_flag` BOOLEAN COMMENT 'Indicates whether the program includes membership tiers with progressive benefits (True) or is a single-tier program (False).',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master configuration record for each loyalty program operated by Restaurants — covering program name, program type (points-based, visit-based, hybrid, subscription), currency name (e.g., Stars, Points, Coins), points-to-dollar conversion rate, program launch date, geographic scope (global, regional, country), applicable restaurant formats (QSR, casual, fine-dining), enrollment channels, and program status. Supports multi-program architectures across franchise and company-owned units.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` (
    `member_offer_assignment_id` BIGINT COMMENT 'Primary key for the member_offer_assignment association',
    `member_id` BIGINT COMMENT 'Foreign key linking to the loyalty member who received this offer assignment.',
    `offer_id` BIGINT COMMENT 'Foreign key linking to the loyalty offer that was assigned to the member.',
    `assignment_channel` STRING COMMENT 'Channel through which this specific offer was assigned and communicated to this member. May differ from the offer-level distribution_channel if the member has channel preferences or if multi-channel distribution was used.',
    `assignment_date` DATE COMMENT 'Date when the offer was assigned/distributed to this specific member. Belongs to the assignment, not the offer definition or member profile.',
    `delivery_status` STRING COMMENT 'Granular delivery tracking status for this member-offer assignment: sent (dispatched from CRM), delivered (confirmed receipt), opened (member opened notification/email), clicked (member engaged with CTA), bounced (delivery failed — invalid email/token), failed (system delivery error). Sourced from Salesforce CRM campaign execution tracking.',
    `eligible_member_segments` STRING COMMENT 'Comma-separated list of member segment codes targeted for this offer (e.g., lapsed_guests, high_frequency, new_members). Null if offer is mass-distributed. [Moved from offer: This attribute on the offer defines targeting criteria (which segments are eligible), which is correct as an offer-level attribute. However, the actual per-member assignment record (this association) captures the realized assignment — not the eligibility rule. No move needed; eligible_member_segments correctly stays on offer as a targeting definition.]',
    `expiry_date` DATE COMMENT 'Member-specific expiry date for this offer assignment. May differ from the offer-level end_date due to personalized expiry windows. Belongs to the assignment, not the offer definition.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the push notification, email, or in-app message was sent to the member for this specific offer assignment. Belongs to the delivery event of this assignment, not the offer definition.',
    `personalization_flag` BOOLEAN COMMENT 'Indicates whether this offer assignment was personalized for this specific member (e.g., customized offer value, personalized messaging, AI-driven targeting) versus a mass-distributed standard offer. Belongs to the assignment context, not the offer definition.',
    `redeemed_timestamp` TIMESTAMP COMMENT 'Timestamp when the member redeemed this specific offer assignment in a transaction. Null if not yet redeemed. Belongs to the assignment redemption event, not the offer definition or member profile.',
    `redemption_status` STRING COMMENT 'Current lifecycle state of this specific member-offer assignment: assigned (distributed but not yet delivered), delivered (confirmed received by member device/channel), viewed (member opened/saw the offer), redeemed (offer was used in a transaction), expired (passed expiry without redemption), cancelled (revoked before expiry). Belongs to the assignment lifecycle, not the offer definition.',
    `viewed_flag` BOOLEAN COMMENT 'Indicates whether the member has viewed or opened this specific offer assignment in their wallet, app, or email. Engagement tracking attribute that belongs to the member-offer interaction, not to either entity alone.',
    CONSTRAINT pk_member_offer_assignment PRIMARY KEY(`member_offer_assignment_id`)
) COMMENT 'This association product represents the Assignment event between a loyalty member and a distributed offer. It captures the operational record of each offer being assigned to a specific member — the core of offer wallet management in the loyalty program. Each record links one member to one offer and owns the full lifecycle of that assignment: from distribution through delivery, engagement, and redemption or expiry. Sourced from Salesforce CRM campaign execution and POS/app redemption events. Enables offer wallet display, delivery tracking, redemption analytics, and personalization reporting.. Existence Justification: In restaurant loyalty programs, the marketing team actively distributes offers to specific members or segments, and each member can hold multiple offers in their offer wallet simultaneously while each offer is distributed to many members. This is a core operational process — not an analytical correlation — where the business creates, tracks, and manages individual offer assignments with their own lifecycle (assigned → delivered → viewed → redeemed/expired). The relationship is explicitly recognized in loyalty platforms (Punchh, Paytronix, Olo Engage) as a first-class operational entity with its own attributes including assignment timestamp, delivery status, member-specific expiry, and redemption status.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_referred_by_member_id` FOREIGN KEY (`referred_by_member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ADD CONSTRAINT `fk_loyalty_tier_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_accrual_rule_id` FOREIGN KEY (`accrual_rule_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`accrual_rule`(`accrual_rule_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_reversal_of_transaction_points_ledger_id` FOREIGN KEY (`reversal_of_transaction_points_ledger_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`points_ledger`(`points_ledger_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`reward`(`reward_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`reward`(`reward_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ADD CONSTRAINT `fk_loyalty_member_offer_assignment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ADD CONSTRAINT `fk_loyalty_member_offer_assignment_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`loyalty` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`loyalty` SET TAGS ('dbx_domain' = 'loyalty');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` SET TAGS ('dbx_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Current Tier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Location ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Location ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `primary_member_preferred_location_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Location ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referred_by_member_id` SET TAGS ('dbx_business_glossary_term' = 'Referred By Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referred_by_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referred_by_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `account_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closure Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `account_closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Account Closure Reason');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `account_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `account_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `badges_earned` SET TAGS ('dbx_business_glossary_term' = 'Badges Earned');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `birthday_month` SET TAGS ('dbx_business_glossary_term' = 'Birthday Month');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `birthday_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `current_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Points Balance');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `data_privacy_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Consent Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `direct_mail_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Direct Mail Opt-In');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-In');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `gamification_level` SET TAGS ('dbx_business_glossary_term' = 'Gamification Level');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `lifetime_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Earned');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `lifetime_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Redeemed');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `membership_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `next_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'NPS (Net Promoter Score) Survey Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `points_expiring_soon` SET TAGS ('dbx_business_glossary_term' = 'Points Expiring Soon');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = 'ENG|SPA|FRA|GER|CHI|JPN');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|suspended|churned|inactive|pending');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `push_notification_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Opt-In');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referral_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `sms_opt_in` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Opt-In');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `terms_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Terms Accepted Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `terms_version` SET TAGS ('dbx_business_glossary_term' = 'Terms Version');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `terms_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `third_party_sharing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Sharing Opt-In');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `tier_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `tier_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `total_visits` SET TAGS ('dbx_business_glossary_term' = 'Total Visits');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` SET TAGS ('dbx_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `benefits_summary` SET TAGS ('dbx_business_glossary_term' = 'Benefits Summary');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `birthday_reward_eligible` SET TAGS ('dbx_business_glossary_term' = 'Birthday Reward Eligible');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `birthday_reward_eligible` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `birthday_reward_eligible` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Color Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `color_code` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `tier_description` SET TAGS ('dbx_business_glossary_term' = 'Tier Description');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `downgrade_threshold` SET TAGS ('dbx_business_glossary_term' = 'Downgrade Threshold');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `early_access_lto` SET TAGS ('dbx_business_glossary_term' = 'Early Access Limited Time Offer (LTO)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `exclusive_offers_eligible` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Offers Eligible');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `free_delivery_eligible` SET TAGS ('dbx_business_glossary_term' = 'Free Delivery Eligible');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `icon_url` SET TAGS ('dbx_business_glossary_term' = 'Tier Icon Uniform Resource Locator (URL)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Launch Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `max_redemption_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Discount Percentage');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Points Multiplier');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `priority_support_eligible` SET TAGS ('dbx_business_glossary_term' = 'Priority Support Eligible');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `qualification_metric` SET TAGS ('dbx_business_glossary_term' = 'Qualification Metric');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `qualification_metric` SET TAGS ('dbx_value_regex' = 'points|visits|spend|transactions');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `qualification_period_days` SET TAGS ('dbx_business_glossary_term' = 'Qualification Period Days');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `qualification_threshold` SET TAGS ('dbx_business_glossary_term' = 'Qualification Threshold');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `referral_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Referral Bonus Points');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `rollover_points_allowed` SET TAGS ('dbx_business_glossary_term' = 'Rollover Points Allowed');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `target_member_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Member Segment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `upgrade_notification` SET TAGS ('dbx_business_glossary_term' = 'Tier Upgrade Notification');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `validity_days` SET TAGS ('dbx_business_glossary_term' = 'Tier Validity Days');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` ALTER COLUMN `welcome_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Welcome Bonus Points');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` SET TAGS ('dbx_subdomain' = 'points_redemption');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Points Ledger ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `accrual_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted By User ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Source Order ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `reversal_of_transaction_points_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Of Transaction ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `source_transaction_guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'customer_service|system_error|fraud_reversal|goodwill|migration|other');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `adjustment_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Notes');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `order_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Order Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `order_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN|AUD');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `order_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Points Balance After Transaction');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_delta` SET TAGS ('dbx_business_glossary_term' = 'Points Delta');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_earn_rate` SET TAGS ('dbx_business_glossary_term' = 'Points Earn Rate');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `restaurant_number` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Number');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `source_order_number` SET TAGS ('dbx_business_glossary_term' = 'Source Order Number');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'micros_pos|olo_platform|salesforce_crm|loyalty_engine|admin_portal');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'earn|redeem|expire|adjust|bonus|reversal');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Voided Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` SET TAGS ('dbx_subdomain' = 'points_redemption');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `combo_meal_id` SET TAGS ('dbx_business_glossary_term' = 'Combo Meal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `availability_end_date` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `availability_start_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_code` SET TAGS ('dbx_business_glossary_term' = 'Reward Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `combinable_with_other_offers` SET TAGS ('dbx_business_glossary_term' = 'Combinable With Other Offers Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_business_glossary_term' = 'Daypart Restriction');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_description` SET TAGS ('dbx_business_glossary_term' = 'Reward Description');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_item|bogo|none');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `featured_flag` SET TAGS ('dbx_business_glossary_term' = 'Featured Reward Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `format_restriction_list` SET TAGS ('dbx_business_glossary_term' = 'Format Restriction List');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Image Uniform Resource Locator (URL)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `market_restriction_list` SET TAGS ('dbx_business_glossary_term' = 'Market Restriction List');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `monetary_value` SET TAGS ('dbx_business_glossary_term' = 'Monetary Value Equivalent');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_name` SET TAGS ('dbx_business_glossary_term' = 'Reward Name');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Name');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `partner_offer_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Offer Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `points_cost` SET TAGS ('dbx_business_glossary_term' = 'Points Cost');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `quantity_limit_per_member` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Per Member');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `redemption_channel_app` SET TAGS ('dbx_business_glossary_term' = 'Mobile App Redemption Channel Eligibility');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `redemption_channel_drive_thru` SET TAGS ('dbx_business_glossary_term' = 'Drive-Thru (DT) Redemption Channel Eligibility');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `redemption_channel_olo` SET TAGS ('dbx_business_glossary_term' = 'Online Ordering (OLO) Redemption Channel Eligibility');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `redemption_channel_pos` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Redemption Channel Eligibility');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `redemption_channel_third_party_delivery` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Redemption Channel Eligibility');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `restaurant_applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Applicability Scope');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `restaurant_applicability_scope` SET TAGS ('dbx_value_regex' = 'all_units|specific_markets|specific_formats|franchise_only|company_owned_only');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_status` SET TAGS ('dbx_business_glossary_term' = 'Reward Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|discontinued');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'food_item|beverage|discount|merchandise|experience|partner_offer');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_value_regex' = 'taxable|non_taxable|tax_included');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `tier_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Tier Eligibility');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `tier_eligibility` SET TAGS ('dbx_value_regex' = 'all_tiers|bronze|silver|gold|platinum');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `total_quantity_limit` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Limit');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` SET TAGS ('dbx_subdomain' = 'points_redemption');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `combo_meal_id` SET TAGS ('dbx_business_glossary_term' = 'Combo Meal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `redemption_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'pos|olo|mobile_app|kiosk|drive_thru|third_party_delivery');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|afternoon|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Reward Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `fulfillment_code` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Confirmation Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `fulfillment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_tier` SET TAGS ('dbx_business_glossary_term' = 'Member Tier');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|vip');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Redemption Notes');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `order_total_after_discount` SET TAGS ('dbx_business_glossary_term' = 'Order Total After Discount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `order_total_before_discount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Before Discount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `points_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Points Balance After Redemption');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `points_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Points Balance Before Redemption');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `points_deducted` SET TAGS ('dbx_business_glossary_term' = 'Points Deducted');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `redemption_number` SET TAGS ('dbx_business_glossary_term' = 'Redemption Number');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `redemption_number` SET TAGS ('dbx_value_regex' = '^RDM-[0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'pending|fulfilled|voided|expired|reversed|failed');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'discount|free_item|bogo|upgrade|combo_deal|birthday_reward');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Redemption Source');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'manual|automatic|promotional_trigger|gamification|tier_benefit');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `third_party_delivery_partner` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Partner');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` SET TAGS ('dbx_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `accrual_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `combo_meal_id` SET TAGS ('dbx_business_glossary_term' = 'Combo Meal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `daypart_scope` SET TAGS ('dbx_business_glossary_term' = 'Daypart Scope');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `earning_basis` SET TAGS ('dbx_business_glossary_term' = 'Earning Basis');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `earning_basis` SET TAGS ('dbx_value_regex' = 'dollar_spent|transaction_count|item_count|fixed_event');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `exclusion_list` SET TAGS ('dbx_business_glossary_term' = 'Exclusion List');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `fixed_points_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Points Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `franchise_id_list` SET TAGS ('dbx_business_glossary_term' = 'Franchise ID List');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `franchise_scope` SET TAGS ('dbx_business_glossary_term' = 'Franchise Scope');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `franchise_scope` SET TAGS ('dbx_value_regex' = 'all|company_owned|franchise|specific_franchisee');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `maximum_points_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Points Per Day');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `maximum_points_per_member` SET TAGS ('dbx_business_glossary_term' = 'Maximum Points Per Member');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `maximum_points_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Maximum Points Per Transaction');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `member_tier_scope` SET TAGS ('dbx_business_glossary_term' = 'Member Tier Scope');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `menu_category_scope` SET TAGS ('dbx_business_glossary_term' = 'Menu Category Scope');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `points_expiration_days` SET TAGS ('dbx_business_glossary_term' = 'Points Expiration Days');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `points_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Points Per Unit');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `requires_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Requires Opt-In');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|expired|archived');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'purchase|visit|referral|birthday|survey|signup');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `stackable` SET TAGS ('dbx_business_glossary_term' = 'Stackable');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `tier_multiplier_applicable` SET TAGS ('dbx_business_glossary_term' = 'Tier Multiplier Applicable');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` SET TAGS ('dbx_subdomain' = 'points_redemption');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `combo_meal_id` SET TAGS ('dbx_business_glossary_term' = 'Combo Meal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Free Item Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Apply Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `bonus_points_value` SET TAGS ('dbx_business_glossary_term' = 'Bonus Points Value');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_business_glossary_term' = 'Offer Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `day_of_week_restriction` SET TAGS ('dbx_business_glossary_term' = 'Day of Week Restriction');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_business_glossary_term' = 'Daypart Restriction');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day|');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_description` SET TAGS ('dbx_business_glossary_term' = 'Offer Description');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_item|');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'push_notification|email|in_app|sms|pos_display|direct_mail');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `eligible_member_tiers` SET TAGS ('dbx_business_glossary_term' = 'Eligible Member Tiers');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `eligible_menu_items` SET TAGS ('dbx_business_glossary_term' = 'Eligible Menu Items');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Offer End Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `estimated_cost_per_redemption` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Per Redemption');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `estimated_cost_per_redemption` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `excluded_menu_items` SET TAGS ('dbx_business_glossary_term' = 'Excluded Menu Items');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Offer Image URL (Uniform Resource Locator)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `minimum_visit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Minimum Visit Frequency');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_name` SET TAGS ('dbx_business_glossary_term' = 'Offer Name');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|expired|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'discount|bonus_points|free_item|bogo|challenge|sweepstakes');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `personalized_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalized Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Points Multiplier');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_value_regex' = 'pos|olo|mobile_app|kiosk|drive_thru|all_channels');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `redemption_limit_per_member` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Member');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Start Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `target_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Target Redemption Count');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `total_redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Limit');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` SET TAGS ('dbx_subdomain' = 'member_enrollment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Birthday Bonus Points');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `birthday_bonus_points` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Country Codes');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `currency_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Currency Name');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Description');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `dollar_per_point` SET TAGS ('dbx_business_glossary_term' = 'Dollar Per Point Redemption Rate');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `enrollment_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Bonus Points');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `enrollment_channels` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channels');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `gamification_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Gamification Enabled Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country|state|local');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Program Launch Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Email Address');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Name');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `minimum_redemption_points` SET TAGS ('dbx_business_glossary_term' = 'Minimum Redemption Points Threshold');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Name');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `olo_integration_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Ordering (OLO) Integration Enabled Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `ownership_model` SET TAGS ('dbx_business_glossary_term' = 'Program Ownership Model');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `ownership_model` SET TAGS ('dbx_value_regex' = 'corporate|franchise|hybrid');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `personalization_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalization Enabled Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `points_expiration_months` SET TAGS ('dbx_business_glossary_term' = 'Points Expiration Period (Months)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `points_per_dollar` SET TAGS ('dbx_business_glossary_term' = 'Points Per Dollar Conversion Rate');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `pos_integration_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Integration Enabled Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy URL');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pilot|sunset');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'points_based|visit_based|hybrid|subscription|tiered');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `referral_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Referral Bonus Points');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `restaurant_formats` SET TAGS ('dbx_business_glossary_term' = 'Applicable Restaurant Formats');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `subscription_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Subscription Fee Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `subscription_fee_frequency` SET TAGS ('dbx_business_glossary_term' = 'Subscription Fee Frequency');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `subscription_fee_frequency` SET TAGS ('dbx_value_regex' = 'monthly|annual|one_time');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions URL');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `third_party_delivery_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Delivery (3PD) Integration Enabled Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `tier_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Tier Enabled Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` SET TAGS ('dbx_subdomain' = 'points_redemption');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` SET TAGS ('dbx_association_edges' = 'loyalty.member,loyalty.offer');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `member_offer_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Offer Assignment - Member Offer Assignment Id');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Offer Assignment - Member Id');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Member Offer Assignment - Offer Id');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `assignment_channel` SET TAGS ('dbx_business_glossary_term' = 'Offer Assignment Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Assignment Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Delivery Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `eligible_member_segments` SET TAGS ('dbx_business_glossary_term' = 'Eligible Member Segments');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Member-Specific Offer Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Offer Notification Sent Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `personalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Personalized Offer Indicator');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `redeemed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Offer Redemption Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Redemption Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member_offer_assignment` ALTER COLUMN `viewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Offer Viewed Indicator');
