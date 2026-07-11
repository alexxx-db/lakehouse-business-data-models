-- Schema for Domain: loyalty | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`loyalty` COMMENT 'Manages guest loyalty program enrollment, membership tiers, points accrual and redemption, rewards catalog, promotional offers, personalized campaigns, member engagement, and loyalty analytics. Drives repeat visits, ACV lift, and customer lifetime value through targeted incentives and gamification across OLO and POS channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`member` (
    `member_id` BIGINT COMMENT 'Unique identifier for the loyalty program member. Primary key for the member entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for assigning a dedicated employee to manage high‑value members, enabling personalized service and performance reporting.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Acquisition Campaign Attribution report requires linking each new member to the marketing campaign that drove the sign‑up, enabling ROI calculation of acquisition spend.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Supports franchisee‑level loyalty analytics by linking each member to the owning franchisee, used in franchise performance dashboards.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Member activity must be consolidated under the owning legal entity (franchise) for statutory financial statements.',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the guest domain master record. Links loyalty membership to the guest profile system of record.',
    `unit_id` BIGINT COMMENT 'Restaurant location that the member visits most frequently or has designated as their preferred location. Used for personalized offers and location-based campaigns.',
    `member_profile_id` BIGINT COMMENT 'Foreign key reference to the guest domain master record. Links loyalty membership to the guest profile system of record.',
    `member_unit_id` BIGINT COMMENT 'Restaurant location where the member enrolled, if enrollment occurred at a physical location. Null for digital enrollments.',
    `primary_member_preferred_location_unit_id` BIGINT COMMENT 'Restaurant location that the member visits most frequently or has designated as their preferred location. Used for personalized offers and location-based campaigns.',
    `referred_by_member_id` BIGINT COMMENT 'Member ID of the existing member who referred this member to the loyalty program. Null if member enrolled without a referral.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Needed for site‑specific loyalty marketing and reporting; members are assigned a primary restaurant site.',
    `account_closure_date` DATE COMMENT 'Date when the loyalty membership was closed or terminated. Null for active memberships. Used for retention analysis and right-to-be-forgotten compliance.',
    `account_closure_reason` STRING COMMENT 'Business reason for account closure. Examples: member request, fraud, inactivity, duplicate account, policy violation, data privacy request.',
    `account_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the loyalty member record was first created in the system. Audit field for data lineage and compliance.',
    `account_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the loyalty member record was last modified. Audit field for data lineage and change tracking.',
    `badges_earned` STRING COMMENT 'Total number of achievement badges earned by the member through gamification activities, challenges, and milestones.',
    `birthday_month` STRING COMMENT 'Month of the members birthday (1-12). Stored without year or day for privacy. Used for birthday reward campaigns and personalized offers.',
    `current_points_balance` BIGINT COMMENT 'Current available points balance that the member can redeem. Calculated as lifetime earned minus lifetime redeemed minus expired points.',
    `current_tier` STRING COMMENT 'Current membership tier level in the loyalty program hierarchy. Determines benefits, rewards multipliers, and exclusive offers available to the member.. Valid values are `bronze|silver|gold|platinum|diamond|vip`',
    `data_privacy_consent_date` DATE COMMENT 'Date when the member provided explicit consent for data collection, processing, and storage under applicable privacy regulations.',
    `direct_mail_opt_in` BOOLEAN COMMENT 'Indicates whether the member has consented to receive physical direct mail offers and communications. True if opted in, False if opted out.',
    `email_opt_in` BOOLEAN COMMENT 'Indicates whether the member has consented to receive promotional and transactional emails. True if opted in, False if opted out.',
    `enrollment_channel` STRING COMMENT 'Channel through which the guest enrolled in the loyalty program. OLO (Online Ordering), POS (Point of Sale), mobile app, website, in-restaurant kiosk, or call center.. Valid values are `OLO|POS|mobile_app|website|in_restaurant|call_center`',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` (
    `tier_history_id` BIGINT COMMENT 'Unique identifier for each tier change event in the loyalty program. Primary key for the tier history transactional audit log.',
    `guest_order_id` BIGINT COMMENT 'Reference to the specific order, purchase, or points transaction that triggered this tier change event. Null for manual adjustments or scheduled reviews.',
    `member_id` BIGINT COMMENT 'Reference to the loyalty program member who experienced this tier change event.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that granted this promotional tier upgrade. Null for non-promotional tier changes.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location where the triggering transaction occurred. Null for tier changes not associated with a specific location (e.g., scheduled reviews, manual adjustments).',
    `tier_unit_id` BIGINT COMMENT 'Reference to the restaurant location where the triggering transaction occurred. Null for tier changes not associated with a specific location (e.g., scheduled reviews, manual adjustments).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tier history record was first created in the data platform. Used for data lineage and audit tracking.',
    `effective_date` DATE COMMENT 'The date when the new tier status became active and the member began receiving benefits associated with the new tier level.',
    `expiry_date` DATE COMMENT 'The date when this tier status is scheduled to expire, requiring re-qualification or resulting in tier review. Null indicates indefinite or lifetime tier status.',
    `is_manual_override` BOOLEAN COMMENT 'Indicates whether this tier change was manually processed by an administrator or customer service representative rather than automatically triggered by system rules. True for manual adjustments, false for automated changes.',
    `is_promotional_tier` BOOLEAN COMMENT 'Indicates whether this tier change was the result of a promotional campaign or marketing offer rather than organic qualification. True for promotional upgrades, false for earned tier changes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this tier history record was most recently modified in the data platform. Used for change tracking and data quality monitoring.',
    `new_tier_benefits_activated_flag` BOOLEAN COMMENT 'Indicates whether benefits associated with the new tier were immediately activated and available for member use. Used for benefit provisioning tracking.',
    `new_tier_code` STRING COMMENT 'The loyalty tier code the member transitioned to as a result of this change event (e.g., BRONZE, SILVER, GOLD, PLATINUM).',
    `notification_channel` STRING COMMENT 'The communication channel used to notify the member of this tier change: email, SMS, push notification, in-app message, physical mail, or none if no notification was sent.. Valid values are `email|sms|push_notification|in_app|mail|none`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a tier change notification was successfully sent to the member via email, mobile app push, or other communication channel. Used for member engagement tracking.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'The date and time when the tier change notification was sent to the member. Used for communication audit and member experience analytics.',
    `override_authorized_by` STRING COMMENT 'The name or employee identifier of the administrator who authorized a manual tier override. Required for audit compliance when is_manual_override is true.',
    `override_justification` STRING COMMENT 'Business justification and approval notes for manual tier overrides, required for regulatory audit trails and program fairness documentation.',
    `previous_tier_benefits_revoked_flag` BOOLEAN COMMENT 'Indicates whether benefits associated with the previous tier were immediately revoked upon tier change. Used for benefit lifecycle management and member experience tracking.',
    `previous_tier_code` STRING COMMENT 'The loyalty tier code the member held immediately before this change event (e.g., BRONZE, SILVER, GOLD, PLATINUM).',
    `processing_channel` STRING COMMENT 'The channel through which this tier change was processed: POS (Point of Sale), OLO (Online Ordering), mobile app, web portal, call center, or admin portal. Used for channel analytics.. Valid values are `pos|olo|mobile_app|web|call_center|admin_portal`',
    `qualification_period_end_date` DATE COMMENT 'The ending date of the measurement period used to evaluate tier qualification criteria.',
    `qualification_period_start_date` DATE COMMENT 'The beginning date of the measurement period used to evaluate tier qualification criteria (e.g., rolling 12 months, calendar year).',
    `qualifying_points_balance` BIGINT COMMENT 'The total loyalty points balance at the time of tier change that contributed to qualification or demotion decision.',
    `qualifying_spend_amount` DECIMAL(18,2) COMMENT 'The cumulative spend amount that qualified the member for this tier change, measured in the programs base currency. Used for tier progression analytics.',
    `qualifying_visit_count` STRING COMMENT 'The number of restaurant visits or transactions during the qualification period that contributed to this tier change.',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this tier change record in the source operational system, used for data reconciliation and troubleshooting.',
    `tier_change_notes` STRING COMMENT 'Additional free-text notes or comments about this tier change event, used for customer service context and audit documentation.',
    `tier_change_number` STRING COMMENT 'Business-readable identifier for this tier change event, used for customer service reference and audit tracking.',
    `tier_change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the tier change: qualification (earned through spend/visits), demotion (failed to maintain requirements), manual_override (customer service adjustment), promotional_upgrade (marketing campaign), anniversary_renewal (annual tier review), points_threshold (points-based qualification), spend_threshold (spend-based qualification), visit_threshold (frequency-based qualification).',
    `tier_change_reason_description` STRING COMMENT 'Detailed human-readable explanation of why this tier change occurred, providing context for customer service and audit purposes.',
    `tier_change_timestamp` TIMESTAMP COMMENT 'The precise date and time when the tier change event was processed and recorded in the loyalty system.',
    `tier_change_type` STRING COMMENT 'Classification of the tier movement direction and nature: upgrade (promotion to higher tier), downgrade (demotion to lower tier), lateral (same tier level renewal), initial_enrollment (first tier assignment), reinstatement (reactivation after lapse), manual_adjustment (administrative override).. Valid values are `upgrade|downgrade|lateral|initial_enrollment|reinstatement|manual_adjustment`',
    `tier_duration_days` STRING COMMENT 'The number of days this tier status is valid, calculated as the difference between effective date and expiry date. Used for tier lifecycle analytics.',
    `triggering_transaction_reference` STRING COMMENT 'Business-readable reference number of the transaction that triggered this tier change, used for customer service inquiries and audit trails.',
    CONSTRAINT pk_tier_history PRIMARY KEY(`tier_history_id`)
) COMMENT 'Transactional audit of every tier change event for a loyalty member — captures previous tier, new tier, effective date, expiry date, reason code (qualification, demotion, manual override, promotional upgrade), and the triggering transaction reference. Enables tier progression analytics, member lifecycle tracking, and regulatory audit trails for program fairness.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` (
    `points_ledger_id` BIGINT COMMENT 'Unique identifier for each points transaction record in the loyalty ledger. Serves as the immutable primary key for this financial-grade system of record.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign or promotional offer that triggered this points transaction. Populated for bonus awards, multiplier events, or targeted incentives. Null for standard earn/redeem transactions not tied to a specific campaign.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for accounting of each points accrual/redemption to the appropriate GL account per financial reporting standards.',
    `member_id` BIGINT COMMENT 'Unique identifier of the loyalty program member whose points balance is affected by this transaction. Links to the member master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or customer service agent who authorized and executed the manual adjustment or reversal. Populated for adjust and reversal transactions. Critical for SOX compliance and fraud prevention.',
    `points_employee_id` BIGINT COMMENT 'Identifier of the system user or customer service agent who authorized and executed the manual adjustment or reversal. Populated for adjust and reversal transactions. Critical for SOX compliance and fraud prevention.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchise entity that owns or operates the restaurant where this transaction occurred. Used for royalty calculations and franchise performance analytics. Null for company-owned locations or non-location transactions.',
    `points_franchisee_id` BIGINT COMMENT 'Identifier of the franchise entity that owns or operates the restaurant where this transaction occurred. Used for royalty calculations and franchise performance analytics. Null for company-owned locations or non-location transactions.',
    `guest_order_id` BIGINT COMMENT 'Reference to the originating order transaction that triggered this points movement. Populated for earn and redeem transactions tied to guest purchases. Null for non-order events such as bonus awards, expirations, or manual adjustments.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where this points transaction originated. Populated for POS and kiosk transactions. Null for OLO, mobile app, or admin transactions not tied to a specific physical location.',
    `points_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where this points transaction originated. Populated for POS and kiosk transactions. Null for OLO, mobile app, or admin transactions not tied to a specific physical location.',
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
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Allows franchisees to manage their own reward catalog, needed for localized promotions and compliance reporting.',
    `menu_item_id` BIGINT COMMENT 'Reference to the specific menu item associated with this reward (for food and beverage rewards). Links to the menu item master catalog. Null for non-menu rewards.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Campaign‑Reward mapping needed for tracking which marketing campaign created a specific reward, supporting performance analysis of campaign‑driven incentives.',
    `supply_supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Needed for Reward‑Supplier cost tracking and compliance; loyalty rewards are sourced from suppliers, and reporting requires linking each reward to its supplying supplier.',
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
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that drove this redemption, if the reward was part of a targeted promotional campaign.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who processed the redemption transaction at the POS, if applicable to in-store redemptions.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Redemption creates expense/revenue entries; linking to GL account enables accurate journal posting and audit trails.',
    `guest_order_id` BIGINT COMMENT 'Reference to the order transaction where the reward was applied and redeemed.',
    `member_id` BIGINT COMMENT 'Reference to the loyalty program member who redeemed the reward.',
    `menu_item_id` BIGINT COMMENT 'Reference to the specific menu item that was redeemed or discounted through this reward, if applicable to item-specific rewards.',
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
    `campaign_id` BIGINT COMMENT 'Marketing campaign identifier if this accrual rule is part of a promotional campaign. Null for evergreen base earning rules. Used for campaign performance tracking and ROI analysis.',
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
    `menu_item_scope` STRING COMMENT 'Comma-separated list of specific menu item codes to which this rule applies. Empty or null = applies to all items within category scope. Used for item-specific promotions.',
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
    `campaign_id` BIGINT COMMENT 'Foreign key to the parent marketing campaign in Salesforce CRM that this offer is part of. Null for standalone offers not tied to a campaign.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links each promotional offer to the employee who created it, supporting audit trails, attribution, and marketing performance analysis.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Links offers to the franchisee that runs them, required for franchise‑specific marketing ROI analysis.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Offers are often site‑specific; linking enables eligibility checks and site‑level offer performance reporting.',
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
    `eligible_member_segments` STRING COMMENT 'Comma-separated list of member segment codes targeted for this offer (e.g., lapsed_guests, high_frequency, new_members). Null if offer is mass-distributed.',
    `eligible_member_tiers` STRING COMMENT 'Comma-separated list of loyalty membership tier codes eligible to receive this offer (e.g., silver, gold, platinum). Null if offer is available to all tiers.',
    `eligible_menu_items` STRING COMMENT 'Comma-separated list of menu item SKUs or category codes that qualify for the offer. Null if offer applies to entire menu or transaction total.',
    `end_date` DATE COMMENT 'Date when the offer expires and is no longer redeemable. Null for evergreen offers without a fixed expiration.',
    `estimated_cost_per_redemption` DECIMAL(18,2) COMMENT 'Estimated financial cost to the business for each redemption of this offer, including discount value and incremental COGS. Used for campaign budget planning and ROI analysis.',
    `excluded_menu_items` STRING COMMENT 'Comma-separated list of menu item SKUs or category codes explicitly excluded from the offer (e.g., alcohol, LTO items). Null if no exclusions.',
    `free_item_sku` STRING COMMENT 'Menu item SKU that is provided at no charge when the offer is redeemed. Applicable to free_item and bogo offer types. Null for other offer types.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` (
    `offer_assignment_id` BIGINT COMMENT 'Unique identifier for the offer assignment record. Primary key for the offer assignment entity.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign under which this offer assignment was distributed.',
    `member_id` BIGINT COMMENT 'Reference to the loyalty program member receiving this offer assignment.',
    `offer_id` BIGINT COMMENT 'Reference to the specific loyalty offer being assigned to the member.',
    `loyalty_segment_id` BIGINT COMMENT 'Reference to the member segment used for this assignment if the offer was distributed to a segment rather than an individual member.',
    `ab_test_variant` STRING COMMENT 'Identifier for the A/B test or multivariate test variant this offer assignment belongs to. Supports controlled experimentation and offer optimization.',
    `assignment_channel` STRING COMMENT 'The channel through which the offer assignment was delivered to the member: email, SMS (Short Message Service), push notification, in-app message, POS (Point of Sale) terminal, or web portal.. Valid values are `email|sms|push_notification|in_app|pos|web`',
    `assignment_reason_code` STRING COMMENT 'A code or identifier explaining why this offer was assigned to this member (e.g., birthday, win-back, high-value, new-member-welcome, lapsed-reactivation). Supports offer attribution and effectiveness analysis.',
    `assignment_source` STRING COMMENT 'The system or process that created this offer assignment: CRM (Customer Relationship Management) automation, loyalty engine rule, manual admin action, API (Application Programming Interface) integration, or batch job.. Valid values are `crm_automation|loyalty_engine|manual_admin|api_integration|batch_job`',
    `assignment_timestamp` TIMESTAMP COMMENT 'The date and time when the offer was assigned to the member or segment. Represents the business event time of offer distribution.',
    `assignment_type` STRING COMMENT 'Classification of how the offer was assigned: personalized (individual-level targeting), mass-distributed (broadcast to all members), segment-targeted (distributed to a defined segment), triggered (event-based automation), or manual (operator-assigned).. Valid values are `personalized|mass_distributed|segment_targeted|triggered|manual`',
    `clicked_timestamp` TIMESTAMP COMMENT 'The date and time when the member clicked through or engaged with the offer assignment (applicable for digital channels with trackable links).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this offer assignment record was first created in the system. Audit trail for record creation.',
    `delivery_status` STRING COMMENT 'Current delivery status of the offer assignment: pending (queued for delivery), sent (transmitted to channel), delivered (confirmed receipt), opened (member viewed), clicked (member engaged), failed (delivery error), or bounced (rejected by recipient system). [ENUM-REF-CANDIDATE: pending|sent|delivered|opened|clicked|failed|bounced — 7 candidates stripped; promote to reference product]',
    `delivery_timestamp` TIMESTAMP COMMENT 'The date and time when the offer was successfully delivered to the member through the assignment channel.',
    `effective_start_date` DATE COMMENT 'The date from which this offer assignment becomes active and eligible for redemption by the member.',
    `expiry_date` DATE COMMENT 'The date on which this specific members instance of the offer expires and can no longer be redeemed. May differ from the offers global expiry if personalized extension or early expiration rules apply.',
    `first_redemption_timestamp` TIMESTAMP COMMENT 'The date and time when the member first redeemed this offer assignment.',
    `is_wallet_visible` BOOLEAN COMMENT 'Boolean flag indicating whether this offer assignment is currently visible in the members digital offer wallet (OLO, mobile app). False indicates the offer is assigned but hidden (e.g., surprise-and-delight offers revealed at checkout).',
    `last_redemption_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent redemption of this offer assignment by the member.',
    `max_redemption_count` STRING COMMENT 'The maximum number of times this member can redeem this specific offer assignment. Null indicates unlimited redemptions within the validity period.',
    `notification_preference_honored` BOOLEAN COMMENT 'Boolean flag indicating whether the members communication preferences were honored when delivering this offer assignment. Supports compliance with opt-in/opt-out regulations.',
    `opened_timestamp` TIMESTAMP COMMENT 'The date and time when the member first opened or viewed the offer assignment (applicable for email, push, in-app channels).',
    `personalization_score` DECIMAL(18,2) COMMENT 'A numeric score (0.00 to 100.00) indicating the degree of personalization applied to this offer assignment based on member behavior, preferences, and predictive models. Higher scores indicate more tailored offers.',
    `priority_rank` STRING COMMENT 'The display priority or ranking of this offer within the members offer wallet. Lower numbers indicate higher priority for presentation in OLO (Online Ordering) and POS (Point of Sale) interfaces.',
    `redemption_count` STRING COMMENT 'The number of times this offer assignment has been redeemed by the member. Supports multi-use offers with redemption limits.',
    `redemption_status` STRING COMMENT 'Current redemption status of the assigned offer: available (active and unused), redeemed (member has used the offer), expired (past expiry date), revoked (administratively cancelled), or pending (awaiting activation).. Valid values are `available|redeemed|expired|revoked|pending`',
    `revocation_reason` STRING COMMENT 'Free-text explanation or code describing why this offer assignment was revoked (e.g., member request, fraud detection, offer recall, system error correction).',
    `revocation_timestamp` TIMESTAMP COMMENT 'The date and time when this offer assignment was revoked or cancelled, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this offer assignment record was last modified. Audit trail for record updates.',
    `wallet_display_start_timestamp` TIMESTAMP COMMENT 'The date and time when this offer assignment becomes visible in the members offer wallet. Supports delayed reveal strategies.',
    CONSTRAINT pk_offer_assignment PRIMARY KEY(`offer_assignment_id`)
) COMMENT 'Association record linking a specific loyalty offer to a specific member or member segment, capturing the assignment channel, assignment timestamp, delivery status (sent, delivered, opened, clicked), expiry date for that members instance of the offer, and whether the offer was personalized or mass-distributed. Enables offer delivery tracking and member-level offer wallet management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` (
    `offer_redemption_id` BIGINT COMMENT 'Unique identifier for the offer redemption transaction. Primary key for the offer redemption record.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that distributed this offer. Used to track campaign effectiveness and ROI (Return on Investment).',
    `guest_order_id` BIGINT COMMENT 'Reference to the order transaction associated with this offer redemption.',
    `member_id` BIGINT COMMENT 'Reference to the loyalty program member who redeemed the offer.',
    `franchisee_id` BIGINT COMMENT 'Reference to the franchise entity that owns the restaurant unit where redemption occurred. Used for franchise-level redemption analytics and royalty calculations.',
    `offer_franchisee_id` BIGINT COMMENT 'Reference to the franchise entity that owns the restaurant unit where redemption occurred. Used for franchise-level redemption analytics and royalty calculations.',
    `offer_id` BIGINT COMMENT 'Reference to the specific loyalty offer that was redeemed.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal or device where the redemption was processed. Applicable for in-store and drive-thru redemptions.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who processed the redemption transaction at the POS. Null for digital channels.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location where the offer was redeemed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this redemption record was first created in the data platform. Audit field for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary amounts in this redemption transaction.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time-of-day segment when the offer was redeemed. Used to analyze redemption patterns by daypart and optimize offer targeting.. Valid values are `breakfast|lunch|afternoon|dinner|late_night`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied to the order as a result of the offer redemption. Expressed in local currency.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied when discount_type is percentage. Null for non-percentage discount types.',
    `discount_type` STRING COMMENT 'Type of discount applied through the offer. Percentage for percent-off discounts, fixed_amount for dollar-off discounts, bogo for buy-one-get-one offers, free_item for complimentary items, combo_upgrade for meal upgrades, points_multiplier for accelerated points accrual.. Valid values are `percentage|fixed_amount|bogo|free_item|combo_upgrade|points_multiplier`',
    `final_order_amount` DECIMAL(18,2) COMMENT 'Total order amount after the offer discount was applied. Represents the actual amount paid by the member.',
    `is_duplicate_attempt` BOOLEAN COMMENT 'Boolean flag indicating whether this redemption was flagged as a duplicate attempt (member trying to redeem same offer multiple times).',
    `is_first_redemption` BOOLEAN COMMENT 'Boolean flag indicating whether this is the members first-ever offer redemption in the loyalty program. Used for new member engagement analytics.',
    `member_tier` STRING COMMENT 'Loyalty program tier of the member at the time of redemption. Captured for historical tracking of tier-specific redemption behavior.. Valid values are `bronze|silver|gold|platinum|vip`',
    `offer_distribution_channel` STRING COMMENT 'Channel through which the offer was originally distributed to the member. Distinct from redemption_channel which captures where it was redeemed. [ENUM-REF-CANDIDATE: email|sms|push_notification|in_app|direct_mail|receipt_print|social_media — 7 candidates stripped; promote to reference product]',
    `offer_expiration_date` DATE COMMENT 'Date when the offer expires and can no longer be redeemed. Captured at redemption time for historical tracking.',
    `original_order_amount` DECIMAL(18,2) COMMENT 'Total order amount before the offer discount was applied. Used to calculate discount impact and ACV (Average Check Value) lift.',
    `points_earned` STRING COMMENT 'Number of loyalty points earned by the member on this transaction after the offer discount was applied. May be zero if offer disqualifies points accrual.',
    `points_multiplier_applied` DECIMAL(18,2) COMMENT 'Points multiplier applied to this transaction if the offer included accelerated points accrual (e.g., 2x points, 3x points). Default is 1.0 for standard accrual.',
    `redemption_channel` STRING COMMENT 'Channel through which the offer was redeemed. POS (Point of Sale) for in-store counter, OLO (Online Ordering) for web/app orders, drive_thru for drive-through lane, kiosk for self-service terminals, mobile_app for native app, third_party_delivery for 3PD (Third-Party Delivery) platforms.. Valid values are `pos|olo|drive_thru|kiosk|mobile_app|third_party_delivery`',
    `redemption_code` STRING COMMENT 'Unique alphanumeric code presented by the member to redeem the offer. May be system-generated or campaign-specific.. Valid values are `^[A-Z0-9]{6,20}$`',
    `redemption_status` STRING COMMENT 'Current status of the offer redemption. Fulfilled indicates successful redemption and discount applied, voided indicates redemption was reversed, duplicate_attempt indicates member tried to redeem same offer multiple times, expired indicates offer was past validity period, invalid indicates offer code was not recognized, pending indicates redemption is awaiting validation.. Valid values are `fulfilled|voided|duplicate_attempt|expired|invalid|pending`',
    `redemption_timestamp` TIMESTAMP COMMENT 'Date and time when the offer was redeemed by the member at the restaurant unit. Represents the business event time of the redemption transaction.',
    `transaction_reference_number` STRING COMMENT 'External transaction reference number from the POS or OLO system. Used for reconciliation and audit trail.. Valid values are `^[A-Z0-9]{8,30}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this redemption record was last modified in the data platform. Audit field for change tracking.',
    `validation_method` STRING COMMENT 'Method used to validate and apply the offer at redemption. Barcode_scan for scanning printed or digital barcodes, manual_entry for cashier-entered codes, qr_code for QR code scanning, nfc_tap for near-field communication, api_validation for system-to-system validation, loyalty_card_swipe for physical card swipe.. Valid values are `barcode_scan|manual_entry|qr_code|nfc_tap|api_validation|loyalty_card_swipe`',
    `void_reason` STRING COMMENT 'Free-text explanation for why the redemption was voided. Null if redemption was not voided.',
    `void_timestamp` TIMESTAMP COMMENT 'Date and time when the redemption was voided. Null if redemption was not voided.',
    CONSTRAINT pk_offer_redemption PRIMARY KEY(`offer_redemption_id`)
) COMMENT 'Transactional record of every loyalty offer redeemed by a member at a restaurant unit. Captures member reference, offer reference, redemption channel (POS, OLO, drive-thru), restaurant unit, order reference, redemption timestamp, discount value applied, and redemption status (fulfilled, voided, duplicate_attempt). Distinct from reward redemption — offers are push-distributed incentives while rewards are pull-selected from the catalog.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` (
    `challenge_id` BIGINT COMMENT 'Unique identifier for the loyalty program challenge. Primary key.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Connects challenges to the franchisee that creates them, enabling franchise‑level challenge participation tracking and budgeting.',
    `program_id` BIGINT COMMENT 'add column program_id (BIGINT) with FK to loyalty.program.program_id - challenges must belong to a specific loyalty program',
    `approved_by` STRING COMMENT 'Username or identifier of the manager or director who approved this challenge for activation. Required for governance and compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this challenge was approved for launch. Null if still in draft status awaiting approval.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Total marketing budget allocated for this challenge in dollars, including reward costs and promotional expenses. Used for Return on Investment (ROI) and Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) impact analysis.',
    `challenge_status` STRING COMMENT 'Current lifecycle state of the challenge: draft (being configured), active (live and available to members), paused (temporarily suspended), completed (ended successfully), cancelled (terminated early).. Valid values are `draft|active|paused|completed|cancelled`',
    `challenge_type` STRING COMMENT 'Category of gamification challenge: visit_streak (consecutive visits), spend_milestone (cumulative spend target), item_discovery (try new menu items), referral (invite friends), social_engagement (social media interaction), daypart_challenge (visit during specific daypart).. Valid values are `visit_streak|spend_milestone|item_discovery|referral|social_engagement|daypart_challenge`',
    `channel_availability` STRING COMMENT 'Comma-separated list of channels where challenge progress can be earned: POS (in-store Point of Sale), OLO (Online Ordering), DT (Drive-Thru), 3PD (Third-Party Delivery). [ENUM-REF-CANDIDATE: POS|OLO|DT|3PD|KIOSK|MOBILE_APP|CATERING — promote to reference product]',
    `challenge_code` STRING COMMENT 'Internal system code for the challenge used for tracking and integration across Point of Sale (POS) and Online Ordering (OLO) channels.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `completion_count` STRING COMMENT 'Total number of members who have successfully completed this challenge. Used for performance analytics and Return on Investment (ROI) measurement.',
    `completion_window_days` STRING COMMENT 'Number of days members have to complete the challenge from their enrollment or start date. Defines the time constraint for achievement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this challenge record was first created in the loyalty system. Used for audit trail and lifecycle tracking.',
    `current_participants` STRING COMMENT 'Current number of loyalty members enrolled in this challenge. Updated in real-time as members join. Used to enforce max_participants cap.',
    `challenge_description` STRING COMMENT 'Detailed description of the challenge rules, objectives, and how members can participate. Displayed in loyalty app and Online Ordering (OLO) platform.',
    `eligibility_scope` STRING COMMENT 'Defines which loyalty members can participate: all_members (open to everyone), tier_specific (restricted to certain membership tiers), segment_specific (targeted customer segments), invite_only (by invitation).. Valid values are `all_members|tier_specific|segment_specific|invite_only`',
    `eligible_segment` STRING COMMENT 'Customer segment code eligible for this challenge when eligibility_scope is segment_specific (e.g., HIGH_FREQUENCY, LAPSED_GUEST). Null if not segment-restricted.',
    `eligible_tier` STRING COMMENT 'Specific membership tier(s) eligible for this challenge when eligibility_scope is tier_specific (e.g., Gold, Platinum). Null if open to all tiers.',
    `end_date` DATE COMMENT 'Date when the challenge expires and is no longer available for new enrollments or progress tracking. Existing participants may have additional time to complete based on completion_window_days.',
    `estimated_cost_per_completion` DECIMAL(18,2) COMMENT 'Projected cost in dollars to the business for each member who completes the challenge, including reward value and operational costs. Used for Cost of Goods Sold (COGS) and profitability modeling.',
    `image_url` STRING COMMENT 'URL to the promotional image or badge graphic for this challenge. Displayed in loyalty app, Online Ordering (OLO) platform, and marketing communications.',
    `is_repeatable` BOOLEAN COMMENT 'Indicates whether a member can complete this challenge multiple times (True) or only once (False). Drives repeat engagement behavior.',
    `max_participants` STRING COMMENT 'Maximum number of loyalty members who can enroll in this challenge. Null indicates unlimited participation. Used for limited-availability or exclusive challenges.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this challenge configuration. Used for change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this challenge record was last updated. Tracks the most recent configuration change for audit and version control.',
    `challenge_name` STRING COMMENT 'Marketing name of the gamification challenge displayed to loyalty members (e.g., Weekend Warrior, 5-Day Streak, Menu Explorer).',
    `notes` STRING COMMENT 'Free-form internal notes for the marketing and loyalty operations teams. May include campaign context, learnings from previous iterations, or operational reminders.',
    `priority_rank` STRING COMMENT 'Display priority for this challenge in loyalty app and Online Ordering (OLO) interfaces. Lower numbers indicate higher priority. Used for featured placement.',
    `repeat_frequency_days` STRING COMMENT 'Minimum number of days a member must wait before re-enrolling in a repeatable challenge. Null if is_repeatable is False or no waiting period applies.',
    `reward_description` STRING COMMENT 'Human-readable description of the reward displayed to members (e.g., 500 Bonus Points, Free Medium Fries, 20% Off Next Order).',
    `reward_type` STRING COMMENT 'Type of reward granted upon challenge completion: points (loyalty points added to balance), free_item (complimentary menu item), discount (percentage or dollar off), tier_bonus (tier status boost), badge (digital achievement).. Valid values are `points|free_item|discount|tier_bonus|badge`',
    `reward_value` DECIMAL(18,2) COMMENT 'Numeric value of the reward (e.g., 500 points, $5 discount, 1 free item). Interpretation depends on reward_type.',
    `start_date` DATE COMMENT 'Date when the challenge becomes active and available for member enrollment. Members can begin participating on or after this date.',
    `target_acv_lift` DECIMAL(18,2) COMMENT 'Target percentage increase in Average Check Value (ACV) for participating members during the challenge period. Measures incremental spend impact (e.g., 10.00 represents 10% lift).',
    `target_criteria` STRING COMMENT 'Specific completion criteria for the challenge (e.g., Visit 5 times in 30 days, Spend $50 in one week, Order 3 different Limited Time Offer (LTO) items). Defines the measurable goal.',
    `target_frequency_lift` DECIMAL(18,2) COMMENT 'Target percentage increase in visit frequency for participating members compared to baseline. Key performance indicator for challenge effectiveness (e.g., 15.00 represents 15% lift).',
    `target_quantity` DECIMAL(18,2) COMMENT 'Numeric target value for challenge completion (e.g., 5 visits, $50 spend, 3 items). Used for progress tracking and validation.',
    `target_unit` STRING COMMENT 'Unit of measurement for the target quantity: visits (transaction count), dollars (spend amount), items (menu items ordered), days (consecutive days), points (loyalty points earned), referrals (friends invited).. Valid values are `visits|dollars|items|days|points|referrals`',
    `terms_and_conditions` STRING COMMENT 'Legal terms and conditions governing challenge participation, reward redemption, and member obligations. Must be accepted by member upon enrollment.',
    `created_by` STRING COMMENT 'Username or identifier of the marketing or loyalty team member who created this challenge in the system.',
    CONSTRAINT pk_challenge PRIMARY KEY(`challenge_id`)
) COMMENT 'Master record for gamification challenges within the loyalty program — visit streaks, spend milestones, menu exploration challenges, and social engagement tasks. Captures challenge name, challenge type (visit_streak, spend_milestone, item_discovery, referral, social), target criteria (e.g., visit 5 times in 30 days), reward upon completion (points, free item, tier bonus), eligibility scope (all members, specific tier, specific segment), start/end dates, and challenge status. Drives member engagement and frequency lift.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` (
    `challenge_enrollment_id` BIGINT COMMENT 'Unique identifier for the challenge enrollment record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that promoted this challenge, if applicable.',
    `challenge_id` BIGINT COMMENT 'Reference to the loyalty challenge that the member enrolled in.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant location where the enrollment occurred, if applicable.',
    `challenge_unit_id` BIGINT COMMENT 'Reference to the restaurant location where the enrollment occurred, if applicable.',
    `member_id` BIGINT COMMENT 'Reference to the loyalty program member who enrolled in this challenge.',
    `cancellation_date` DATE COMMENT 'Date when the member cancelled their enrollment in the challenge. Null if not cancelled.',
    `cancellation_reason` STRING COMMENT 'Reason for challenge enrollment cancellation (member request, ineligible, duplicate, system error, policy violation, other).. Valid values are `member_request|ineligible|duplicate|system_error|policy_violation|other`',
    `challenge_enrollment_status` STRING COMMENT 'Current status of the challenge enrollment (in_progress, completed, expired, abandoned, disqualified, cancelled).. Valid values are `in_progress|completed|expired|abandoned|disqualified|cancelled`',
    `completion_date` DATE COMMENT 'Date when the member completed the challenge requirements. Null if not yet completed.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the member completed the challenge, including time zone information. Null if not yet completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system.',
    `days_remaining` STRING COMMENT 'Number of days remaining until the challenge end date. Calculated as end_date minus current date.',
    `days_to_completion` STRING COMMENT 'Number of days between enrollment and completion. Null if not yet completed.',
    `disqualification_reason` STRING COMMENT 'Free-text explanation of why the member was disqualified from the challenge. Null if not disqualified.',
    `end_date` DATE COMMENT 'Date when the challenge period ends for this enrollment.',
    `enrollment_channel` STRING COMMENT 'Channel through which the member enrolled in the challenge (mobile app, web portal, POS, email campaign, push notification, SMS).. Valid values are `mobile_app|web_portal|pos|email_campaign|push_notification|sms`',
    `enrollment_date` DATE COMMENT 'Date when the member enrolled in the challenge.',
    `enrollment_number` STRING COMMENT 'Business-facing unique identifier for the challenge enrollment, formatted as CE- followed by 10 digits.. Valid values are `^CE-[0-9]{10}$`',
    `enrollment_source` STRING COMMENT 'Source or trigger that led to the enrollment (organic member action, promotional offer, referral, auto-enrollment, gamification, targeted campaign).. Valid values are `organic|promotional_offer|referral|auto_enrolled|gamification|targeted_campaign`',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the member enrolled in the challenge, including time zone information.',
    `last_activity_date` DATE COMMENT 'Date of the most recent activity that contributed to challenge progress.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Precise timestamp of the most recent activity that contributed to challenge progress.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the challenge enrollment.',
    `notification_enabled_flag` BOOLEAN COMMENT 'Indicates whether the member has enabled progress notifications for this challenge (True/False).',
    `opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member explicitly opted in to the challenge (True) or was auto-enrolled (False).',
    `progress_percentage` DECIMAL(18,2) COMMENT 'Percentage of challenge completion calculated as (progress_value / target_value) * 100.',
    `progress_unit` STRING COMMENT 'Unit of measurement for progress tracking (visits, transactions, points, dollars spent, items purchased, days active).. Valid values are `visits|transactions|points|dollars_spent|items_purchased|days_active`',
    `progress_value` DECIMAL(18,2) COMMENT 'Current progress value toward challenge completion (e.g., number of visits completed, points earned, transactions made).',
    `reward_issued_date` DATE COMMENT 'Date when the completion reward was issued to the member. Null if reward not yet issued.',
    `reward_issued_flag` BOOLEAN COMMENT 'Indicates whether the completion reward has been issued to the member (True/False).',
    `reward_type` STRING COMMENT 'Type of reward earned upon challenge completion (points, discount, free item, bonus multiplier, tier upgrade, badge).. Valid values are `points|discount|free_item|bonus_multiplier|tier_upgrade|badge`',
    `reward_value` DECIMAL(18,2) COMMENT 'Numeric value of the reward earned (e.g., 500 points, 10 dollar discount, 2x multiplier).',
    `start_date` DATE COMMENT 'Date when the challenge period begins for this enrollment.',
    `target_value` DECIMAL(18,2) COMMENT 'Target value required to complete the challenge (e.g., 10 visits, 500 points, 5 transactions).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last updated in the system.',
    CONSTRAINT pk_challenge_enrollment PRIMARY KEY(`challenge_enrollment_id`)
) COMMENT 'Tracks each members enrollment and progress in a loyalty challenge. Captures member reference, challenge reference, enrollment date, current progress value (e.g., visits completed out of target), completion status (in_progress, completed, expired, abandoned), completion date, and reward issued flag. Enables real-time progress tracking for member-facing app displays and completion trigger processing.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier for the loyalty program. Primary key.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` (
    `enrollment_event_id` BIGINT COMMENT 'Unique identifier for the loyalty program enrollment event. Primary key for the enrollment event transaction.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that drove the enrollment. Null if enrollment was not campaign-driven. Enables campaign ROI analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the staff member who assisted with the enrollment. Null for self-service enrollments. Used for staff performance tracking.',
    `guest_order_id` BIGINT COMMENT 'Original transaction identifier from the source system. Used for reconciliation and traceability back to the source system.',
    `unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the enrollment occurred. Null for digital-only enrollments without a specific unit association.',
    `tier_id` BIGINT COMMENT 'Reference to the membership tier assigned at enrollment. Typically the base tier for new members, but may be elevated tier for transfer or upgrade enrollments.',
    `member_id` BIGINT COMMENT 'Reference to the loyalty program member who enrolled. Links to the member master record.',
    `primary_enrollment_restaurant_unit_id` BIGINT COMMENT 'Reference to the restaurant unit where the enrollment occurred. Null for digital-only enrollments without a specific unit association.',
    `primary_enrollment_staff_employee_id` BIGINT COMMENT 'Reference to the staff member who assisted with the enrollment. Null for self-service enrollments. Used for staff performance tracking.',
    `primary_enrollment_transaction_guest_order_id` BIGINT COMMENT 'Original transaction identifier from the source system. Used for reconciliation and traceability back to the source system.',
    `program_id` BIGINT COMMENT 'Reference to the loyalty program the member enrolled in. Supports multi-program environments.',
    `offer_id` BIGINT COMMENT 'Reference to the specific welcome offer or promotional reward issued at enrollment. Null if no offer was issued.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment event record was first created in the data platform. System audit field for data lineage.',
    `email_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member opted in to receive email communications at enrollment. Required for CAN-SPAM compliance.',
    `enrollment_channel` STRING COMMENT 'Channel through which the enrollment occurred. OLO (Online Ordering) for web/app orders, POS (Point of Sale) for in-restaurant, mobile_app for native app, kiosk for self-service terminals, staff_assisted for employee-facilitated, web for website.. Valid values are `olo|pos|mobile_app|kiosk|staff_assisted|web`',
    `enrollment_country_code` STRING COMMENT 'Country where the enrollment occurred. ISO 3166-1 alpha-3 three-letter country codes. Used for geographic segmentation and compliance. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|AUS|JPN|CHN|BRA — 10 candidates stripped; promote to reference product]',
    `enrollment_device_type` STRING COMMENT 'Type of device used to complete the enrollment. Supports channel and user experience analysis.. Valid values are `mobile|tablet|desktop|kiosk|pos_terminal|unknown`',
    `enrollment_geolocation` STRING COMMENT 'Geographic coordinates (latitude, longitude) of the enrollment location if captured. Format: latitude,longitude. Used for location-based analytics.',
    `enrollment_ip_address` STRING COMMENT 'IP address from which the enrollment was initiated. Used for fraud detection and geographic analysis. May be considered PII in some jurisdictions.',
    `enrollment_language` STRING COMMENT 'Language preference selected by the member at enrollment. ISO 639-2 three-letter language codes. Used for personalized communications. [ENUM-REF-CANDIDATE: eng|spa|fra|deu|ita|por|zho|jpn|kor — 9 candidates stripped; promote to reference product]',
    `enrollment_notes` STRING COMMENT 'Free-text notes or comments about the enrollment event. Used for special circumstances, exceptions, or customer service annotations.',
    `enrollment_number` STRING COMMENT 'Business-facing unique enrollment transaction number. Format: ENR followed by 10 digits. Used for customer service and audit tracking.. Valid values are `^ENR[0-9]{10}$`',
    `enrollment_source_system` STRING COMMENT 'Name of the source system that captured the enrollment event. Examples: Olo, Oracle MICROS, Salesforce CRM, Mobile App. Used for data lineage and troubleshooting.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment event. Completed indicates successful enrollment; pending indicates awaiting verification; failed indicates enrollment did not complete; cancelled indicates member-initiated cancellation; reversed indicates system or compliance reversal.. Valid values are `completed|pending|failed|cancelled|reversed`',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Date and time when the enrollment event occurred in the source system. Represents the real-world business event time, distinct from record audit timestamps.',
    `enrollment_type` STRING COMMENT 'Type of enrollment action. New indicates first-time enrollment; re_enrollment indicates returning member; transfer indicates program migration; upgrade indicates tier promotion enrollment.. Valid values are `new|re_enrollment|transfer|upgrade`',
    `fraud_check_status` STRING COMMENT 'Status of fraud detection checks performed at enrollment. Passed indicates clean enrollment; failed indicates suspected fraud; pending indicates checks in progress; not_required indicates no checks were performed.. Valid values are `passed|failed|pending|not_required`',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numeric fraud risk score assigned to the enrollment event by fraud detection systems. Range typically 0-100, with higher scores indicating higher risk. Null if fraud checking was not performed.',
    `initial_points_awarded` STRING COMMENT 'Number of loyalty points awarded to the member at enrollment as a sign-up bonus. Zero if no points were awarded.',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member opted in to receive marketing communications at enrollment. True if opted in; False if declined.',
    `push_notification_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member opted in to receive mobile app push notifications at enrollment.',
    `referral_code` STRING COMMENT 'Specific referral or campaign code used during enrollment. Enables attribution tracking for member-get-member programs and promotional campaigns.',
    `referral_source` STRING COMMENT 'Source that drove the enrollment. Organic for unprompted; referral_code for member referral; campaign for marketing campaign; social_media for social channels; email for email marketing; in_store for restaurant promotion; partner for third-party partner. [ENUM-REF-CANDIDATE: organic|referral_code|campaign|social_media|email|in_store|partner — 7 candidates stripped; promote to reference product]',
    `sms_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the member opted in to receive SMS/text message communications at enrollment. Required for TCPA compliance.',
    `terms_accepted_flag` BOOLEAN COMMENT 'Indicates whether the member accepted the loyalty program terms and conditions at enrollment. Required for compliance and legal purposes.',
    `terms_version` STRING COMMENT 'Version identifier of the terms and conditions accepted by the member at enrollment. Enables tracking of which terms version the member agreed to.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this enrollment event record was last modified in the data platform. System audit field for change tracking.',
    `verification_completed_flag` BOOLEAN COMMENT 'Indicates whether required verification has been completed. True if completed; False if pending or not completed.',
    `verification_completed_timestamp` TIMESTAMP COMMENT 'Date and time when enrollment verification was completed. Null if verification is not required or not yet completed.',
    `verification_required_flag` BOOLEAN COMMENT 'Indicates whether the enrollment requires additional verification (e.g., email verification, identity verification). True if verification is required; False if not required.',
    `welcome_offer_issued_flag` BOOLEAN COMMENT 'Indicates whether a welcome offer or sign-up bonus was issued to the member upon enrollment. True if issued; False if not issued.',
    CONSTRAINT pk_enrollment_event PRIMARY KEY(`enrollment_event_id`)
) COMMENT 'Transactional record of every loyalty program enrollment action — new enrollments, re-enrollments, and program transfers. Captures member reference, program reference, enrollment channel (OLO, POS, in-app, kiosk, staff-assisted), enrollment restaurant unit, enrollment timestamp, referral source (organic, referral_code, campaign), welcome offer issued flag, and enrollment status. Feeds acquisition funnel analysis and channel attribution for the loyalty program.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`referral` (
    `referral_id` BIGINT COMMENT 'Unique identifier for the referral event. Primary key.',
    `campaign_id` BIGINT COMMENT 'Identifier for the marketing campaign or promotional period under which this referral was created. Supports campaign-level ROI analysis.',
    `member_id` BIGINT COMMENT 'Loyalty member ID assigned to the referred guest upon successful enrollment conversion. Null if referral has not yet converted.',
    `unit_id` BIGINT COMMENT 'Restaurant location where the referred guest completed enrollment. Null for online enrollments. Supports location-level referral performance tracking.',
    `profile_id` BIGINT COMMENT 'Guest who received the referral invitation. May be pre-enrollment or post-enrollment guest identifier.',
    `referral_referred_guest_profile_id` BIGINT COMMENT 'Guest who received the referral invitation. May be pre-enrollment or post-enrollment guest identifier.',
    `referral_unit_id` BIGINT COMMENT 'Restaurant location where the referred guest completed enrollment. Null for online enrollments. Supports location-level referral performance tracking.',
    `channel` STRING COMMENT 'Channel through which the referral invitation was shared. Supports attribution of viral growth mechanics across digital and physical touchpoints.. Valid values are `app_share|email|sms|social_media|qr_code|in_store`',
    `referral_code` STRING COMMENT 'Unique alphanumeric code used by the referring member to track the referral. Generated by the loyalty platform and shared via referral channels.. Valid values are `^[A-Z0-9]{6,12}$`',
    `conversion_date` DATE COMMENT 'Date when the referred guest successfully enrolled in the loyalty program and the referral converted. Null if referral has not yet converted.',
    `conversion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the referred guest completed enrollment and the referral status changed to converted. Null if not yet converted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this referral record was first created in the loyalty system. Audit trail for record creation.',
    `expiration_date` DATE COMMENT 'Date when the referral code expires and can no longer be used for enrollment. Supports time-bound referral campaigns and urgency mechanics.',
    `first_transaction_amount` DECIMAL(18,2) COMMENT 'Total amount of the referred member first purchase. Supports Average Check Value (ACV) lift analysis for referred members.',
    `first_transaction_date` DATE COMMENT 'Date of the referred member first purchase transaction after enrollment. Used to measure referral quality and time-to-first-purchase.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this referral was flagged as fraudulent by automated or manual review. True if fraudulent activity detected.',
    `fraud_reason` STRING COMMENT 'Description of the fraud detection reason if fraud_flag is true. Examples include duplicate device, self-referral, velocity abuse, or manual review findings.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this referral record was last updated. Supports change tracking and audit compliance.',
    `message` STRING COMMENT 'Optional personalized message included by the referring member when sharing the referral. Supports engagement analysis and sentiment tracking.',
    `modified_by_user` STRING COMMENT 'User ID or system identifier that last modified this referral record. Supports audit trail and accountability.',
    `referral_date` DATE COMMENT 'Date when the referring member initiated the referral event. Represents the business event timestamp for referral creation.',
    `referral_status` STRING COMMENT 'Current lifecycle status of the referral. Pending indicates awaiting conversion; converted indicates successful enrollment; expired indicates referral window closed; fraudulent indicates detected abuse; cancelled indicates referrer or system cancellation.. Valid values are `pending|converted|expired|fraudulent|cancelled`',
    `referral_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the referral was created in the loyalty system. Supports detailed event sequencing and time-of-day analysis.',
    `referred_bonus_awarded_date` DATE COMMENT 'Date when the referred member bonus points were credited to the new member account. Null if bonus not yet awarded.',
    `referred_bonus_points` STRING COMMENT 'Loyalty points awarded to the referred member upon successful enrollment. Incentivizes new member acquisition and first-transaction engagement.',
    `referrer_bonus_awarded_date` DATE COMMENT 'Date when the referrer bonus points were credited to the referring member account. Null if bonus not yet awarded.',
    `referrer_bonus_points` STRING COMMENT 'Loyalty points awarded to the referring member upon successful referral conversion. Supports referral program ROI measurement and member incentive tracking.',
    `source_platform` STRING COMMENT 'Digital platform or system where the referral was initiated. Supports omnichannel referral attribution and platform performance analysis.. Valid values are `mobile_app|web|pos|kiosk|third_party`',
    `terms_version` STRING COMMENT 'Version of the referral program terms and conditions accepted by the referring member at the time of referral creation. Supports compliance and audit trails.. Valid values are `^v[0-9]+.[0-9]+$`',
    CONSTRAINT pk_referral PRIMARY KEY(`referral_id`)
) COMMENT 'Tracks member-to-member referral events within the loyalty program. Captures referring member, referred guest (pre-enrollment), referral code used, referral channel (app share, email, social), referral date, referred member enrollment date (if converted), referral status (pending, converted, expired, fraudulent), and bonus points awarded to referrer upon successful conversion. Supports viral growth mechanics and referral program ROI measurement.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` (
    `loyalty_segment_id` BIGINT COMMENT 'Unique identifier for the segment data product (auto-inserted pre-linking).',
    `employee_id` BIGINT COMMENT 'User identifier of the CRM or marketing team member responsible for managing this segment. Used for accountability, access control, and workflow routing.',
    `owner_user_employee_id` BIGINT COMMENT 'User identifier of the CRM or marketing team member responsible for managing this segment. Used for accountability, access control, and workflow routing.',
    `trade_area_id` BIGINT COMMENT 'Foreign key linking to realestate.trade_area. Business justification: Segments are defined by trade‑area demographics; linking allows segment performance analysis by trade area.',
    `activation_date` DATE COMMENT 'Date when the segment was first activated and made available for campaign use. Used for segment lifecycle tracking and historical analysis.',
    `acv_max_threshold` DECIMAL(18,2) COMMENT 'Maximum Average Check Value in USD for segment qualification. Used to define value-based cohorts and target budget-conscious guests with appropriate offers.',
    `acv_min_threshold` DECIMAL(18,2) COMMENT 'Minimum Average Check Value in USD required for a member to qualify for this segment. Used to identify high-value guests for premium offers and personalized campaigns.',
    `campaign_usage_count` STRING COMMENT 'Number of active marketing campaigns currently using this segment for offer distribution or personalized messaging. Used to assess segment utilization and prevent accidental deletion of in-use segments.',
    `channel_preference` STRING COMMENT 'Primary ordering channel used by members in this segment. POS: in-store counter. OLO: online ordering (web/app). Drive-Thru: DT lane. 3PD: third-party delivery. Kiosk: self-service terminal. Used for channel-specific offer distribution.. Valid values are `pos|olo|drive_thru|3pd|kiosk`',
    `control_group_flag` BOOLEAN COMMENT 'Indicates whether this segment serves as a control group (holdout) for campaign effectiveness measurement. True: control group, no offers sent. False: treatment group. Used for incrementality analysis and ROI measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment record was first created in the system. Used for audit trail and segment lifecycle tracking.',
    `current_tier_filter` STRING COMMENT 'Comma-separated list of loyalty tier codes that qualify for this segment. Used for tier-based segmentation to target premium or entry-level members with tier-appropriate offers. Null if segment is not tier-specific.',
    `daypart_preference` STRING COMMENT 'Primary daypart during which members in this segment typically visit. Used to target time-of-day specific offers and LTO promotions. Null if segment is not daypart-specific.. Valid values are `breakfast|lunch|dinner|late_night|all_day`',
    `deactivation_date` DATE COMMENT 'Date when the segment was deactivated or archived. Null if segment is currently active. Used for segment lifecycle tracking and campaign history analysis.',
    `definition_criteria` STRING COMMENT 'Structured or free-text representation of the business rules and thresholds used to assign members to this segment. Examples: visit_frequency >= 8 per month AND ACV >= $12; daypart = breakfast AND menu_category = coffee; tier = gold OR platinum; last_visit_days > 90.',
    `exclusion_segment_ids` STRING COMMENT 'Comma-separated list of segment IDs whose members should be excluded from this segment. Used for negative targeting and campaign suppression logic. Null if no exclusions apply.',
    `geographic_scope` STRING COMMENT 'Geographic coverage level of the segment. National: all locations. Regional: multi-state region. Market: DMA or metro area. Restaurant: single location. Used to control offer distribution and campaign reach.. Valid values are `national|regional|market|restaurant`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment record was last updated. Includes changes to definition criteria, status, or metadata. Used for audit trail and change tracking.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent segment membership refresh execution. Segment membership is recalculated periodically based on definition criteria. Used to monitor data freshness and refresh cadence.',
    `lifetime_points_min` BIGINT COMMENT 'Minimum cumulative loyalty points earned over the member lifetime required for segment qualification. Used to identify long-term high-engagement members.',
    `member_count` BIGINT COMMENT 'Current number of active loyalty members assigned to this segment. Updated during segment refresh process. Used for campaign reach estimation and segment size monitoring.',
    `menu_affinity_category` STRING COMMENT 'Primary menu category or product line that members in this segment have high purchase affinity for. Examples: coffee, breakfast sandwiches, salads, value menu, premium burgers. Used for product-specific campaign targeting.',
    `modified_by_user` STRING COMMENT 'User identifier of the person who last modified the segment record. Used for audit trail, accountability, and change management.',
    `next_refresh_date` DATE COMMENT 'Scheduled date for the next segment membership refresh execution. Calculated as last_refresh_timestamp + refresh_frequency_days. Used for operational planning and monitoring.',
    `notes` STRING COMMENT 'Free-text field for operational notes, business context, campaign history, or special handling instructions related to this segment. Used by CRM and marketing teams for knowledge sharing.',
    `owner_team` STRING COMMENT 'Business team or department responsible for this segment. Used for organizational reporting and cross-functional collaboration.. Valid values are `crm|marketing|loyalty|analytics|franchise`',
    `predicted_incremental_revenue` DECIMAL(18,2) COMMENT 'Machine learning model predicted incremental revenue in USD per member when this segment is targeted with offers, compared to control group baseline. Used for campaign ROI forecasting. Null if predictive model not applied.',
    `predicted_response_rate` DECIMAL(18,2) COMMENT 'Machine learning model predicted response rate (0.0000 to 1.0000) for members in this segment when targeted with offers. Used for campaign ROI forecasting and segment prioritization. Null if predictive model not applied.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking used when a member qualifies for multiple segments and campaign assignment logic requires a single segment selection. Lower values indicate higher priority. Used in offer conflict resolution.',
    `recency_days_max` STRING COMMENT 'Maximum number of days since last visit for segment qualification. Used to define active or highly engaged member cohorts. Null if recency is not a defining criterion.',
    `recency_days_min` STRING COMMENT 'Minimum number of days since last visit for segment qualification. Used in RFM segmentation to identify lapsed or at-risk members. Null if recency is not a defining criterion.',
    `refresh_frequency_days` STRING COMMENT 'Number of days between scheduled segment membership refresh executions. Common values: 1 (daily), 7 (weekly), 30 (monthly). Used to control segment data freshness and computational load.',
    `segment_code` STRING COMMENT 'Short alphanumeric code used to identify the segment in operational systems and reporting. Must be unique and human-readable for campaign execution workflows.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `segment_description` STRING COMMENT 'Detailed narrative description of the segment purpose, target audience, and business rationale. Used by marketing and CRM teams to understand segment intent and usage.',
    `segment_name` STRING COMMENT 'Business-friendly name of the loyalty segment used in marketing campaigns and reporting dashboards. Examples: High-Value Breakfast Loyalists, Lapsed Drive-Thru Users, New Member Onboarding.',
    `segment_status` STRING COMMENT 'Current operational status of the segment. Active: available for campaign assignment. Inactive: temporarily disabled. Draft: under development. Archived: historical, no longer used. Scheduled: configured but not yet active.. Valid values are `active|inactive|draft|archived|scheduled`',
    `segment_type` STRING COMMENT 'Classification of the segmentation methodology used to define member inclusion. Behavioral: visit frequency, menu affinity, daypart preference. Demographic: age, income, household. Tier-based: current loyalty tier. RFM: recency, frequency, monetary analysis. Lifecycle: new, active, at-risk, lapsed. Geographic: region, market, trade area. Channel preference: OLO, POS, 3PD. [ENUM-REF-CANDIDATE: behavioral|demographic|tier_based|rfm|lifecycle|geographic|channel_preference — 7 candidates stripped; promote to reference product]',
    `target_market_codes` STRING COMMENT 'Comma-separated list of market or DMA codes where this segment is active. Used for geo-targeted campaigns and regional offer distribution. Null if segment is national or not geographically constrained.',
    `test_segment_flag` BOOLEAN COMMENT 'Indicates whether this segment is used for A/B testing, pilot campaigns, or experimental offer strategies. True: test segment. False: production segment. Used to isolate test populations and measure incremental lift.',
    `visit_frequency_threshold` STRING COMMENT 'Minimum number of visits within the qualification period required for a member to qualify for this segment. Used for behavioral segmentation based on transaction count.',
    CONSTRAINT pk_loyalty_segment PRIMARY KEY(`loyalty_segment_id`)
) COMMENT 'Master record for loyalty member segments used for targeted offer distribution, personalized campaigns, and cohort analysis. Captures segment name, segment type (behavioral, demographic, tier-based, RFM, lifecycle), definition criteria (visit frequency, ACV ranges, daypart preferences, menu affinity), segment size, last refresh timestamp, refresh frequency, and active status. Also owns the member-segment assignment detail: each member assignment captures assignment date, removal date, assignment method (rule-based, manual, ML-model), segment version at assignment, and assignment source system. Managed by CRM/marketing team and consumed by offer distribution and campaign execution workflows. Supports temporal segment membership queries and before/after campaign cohort comparisons.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment_membership` (
    `loyalty_segment_membership_id` BIGINT COMMENT 'Unique identifier for the loyalty_segment_membership data product (auto-inserted pre-linking).',
    `loyalty_segment_id` BIGINT COMMENT 'Foreign key linking to loyalty.segment. Business justification: Segment membership must reference the loyalty segment it assigns.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Segment membership must reference the member it applies to.',
    CONSTRAINT pk_loyalty_segment_membership PRIMARY KEY(`loyalty_segment_membership_id`)
) COMMENT 'Association table linking loyalty members to their assigned segments at a point in time. Captures member reference, segment reference, assignment date, removal date, assignment method (rule-based, manual, ML-model), and the segment version at time of assignment. Supports temporal segment membership queries and enables before/after campaign cohort comparisons.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` (
    `loyalty_visit_id` BIGINT COMMENT 'Unique identifier for the loyalty_visit data product (auto-inserted pre-linking).',
    `guest_order_id` BIGINT COMMENT 'add column guest_order_id (BIGINT) with FK to order.guest_order.guest_order_id - loyalty visits should link to the transaction that triggered the visit record',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: A loyalty visit records which member performed the visit.',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - loyalty visits must record which restaurant location was visited',
    CONSTRAINT pk_loyalty_visit PRIMARY KEY(`loyalty_visit_id`)
) COMMENT 'Transactional record of each qualifying restaurant visit by a loyalty member that is recognized and attributed to their loyalty account — whether via POS scan, OLO order, or card-linked payment match. Captures member reference, restaurant unit, visit date, visit channel (dine-in, drive-thru, OLO, 3PD, kiosk), daypart (breakfast, lunch, dinner, late-night), order reference, check value (ACV), points earned on visit, and visit sequence number (lifetime visit count at time of visit). Core input for visit-frequency-based tier qualification and challenge progress.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` (
    `loyalty_adjustment_id` BIGINT COMMENT 'Unique identifier for the loyalty_adjustment data product (auto-inserted pre-linking).',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Loyalty adjustments must be tied to the member whose points are adjusted; adding loyalty_member_id FK eliminates the silo and enables reporting of adjustments per member.',
    `program_id` BIGINT COMMENT 'add column program_id (BIGINT) with FK to loyalty.program.program_id - adjustments need program context for multi-program environments',
    CONSTRAINT pk_loyalty_adjustment PRIMARY KEY(`loyalty_adjustment_id`)
) COMMENT 'Operational record of manual or system-initiated points adjustments made to a members loyalty account outside of normal earn/redeem flows — covering goodwill credits, dispute resolutions, system error corrections, promotional credits, and fraud-related reversals. Captures member reference, adjustment type, points delta, monetary equivalent, reason code, authorizing agent or system, approval status, and adjustment timestamp. Provides full auditability for program integrity and member dispute resolution.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` (
    `program_campaign_allocation_id` BIGINT COMMENT 'Primary key for the ProgramCampaignAllocation association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign',
    `program_id` BIGINT COMMENT 'Foreign key linking to the loyalty program',
    `budget_allocation` DECIMAL(18,2) COMMENT 'Budget amount allocated to the program for this campaign',
    `target_audience` STRING COMMENT 'Guest segment targeted by the campaign within the program',
    CONSTRAINT pk_program_campaign_allocation PRIMARY KEY(`program_campaign_allocation_id`)
) COMMENT 'This association product captures the allocation of marketing budget and target audience for each pairing of a loyalty program and a marketing campaign. Each record links one program to one campaign and stores attributes that exist only in the context of this relationship.. Existence Justification: Loyalty programs are actively linked to marketing campaigns; each link is created and maintained by marketing teams to specify how much budget is allocated and which guest segment is targeted. A single program can be promoted by many campaigns, and a single campaign can target multiple programs, with the association carrying its own data.';

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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ADD CONSTRAINT `fk_loyalty_offer_assignment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ADD CONSTRAINT `fk_loyalty_offer_assignment_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ADD CONSTRAINT `fk_loyalty_offer_assignment_loyalty_segment_id` FOREIGN KEY (`loyalty_segment_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`loyalty_segment`(`loyalty_segment_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ADD CONSTRAINT `fk_loyalty_challenge_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ADD CONSTRAINT `fk_loyalty_challenge_enrollment_challenge_id` FOREIGN KEY (`challenge_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`challenge`(`challenge_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ADD CONSTRAINT `fk_loyalty_challenge_enrollment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`program`(`program_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ADD CONSTRAINT `fk_loyalty_referral_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment_membership` ADD CONSTRAINT `fk_loyalty_loyalty_segment_membership_loyalty_segment_id` FOREIGN KEY (`loyalty_segment_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`loyalty_segment`(`loyalty_segment_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment_membership` ADD CONSTRAINT `fk_loyalty_loyalty_segment_membership_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ADD CONSTRAINT `fk_loyalty_loyalty_visit_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ADD CONSTRAINT `fk_loyalty_loyalty_adjustment_member_id` FOREIGN KEY (`member_id`) REFERENCES `vibe_restaurants_v1`.`loyalty`.`member`(`member_id`);
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Location ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `member_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Location ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `primary_member_preferred_location_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Location ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referred_by_member_id` SET TAGS ('dbx_business_glossary_term' = 'Referred By Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referred_by_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `referred_by_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `account_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closure Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `account_closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Account Closure Reason');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `account_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `account_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `badges_earned` SET TAGS ('dbx_business_glossary_term' = 'Badges Earned');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `birthday_month` SET TAGS ('dbx_business_glossary_term' = 'Birthday Month');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `birthday_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `current_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Points Balance');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `current_tier` SET TAGS ('dbx_business_glossary_term' = 'Current Tier');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `current_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|diamond|vip');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `data_privacy_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Consent Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `direct_mail_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Direct Mail Opt-In');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-In');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`member` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'OLO|POS|mobile_app|website|in_restaurant|call_center');
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier` SET TAGS ('dbx_subdomain' = 'program_management');
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `tier_history_id` SET TAGS ('dbx_business_glossary_term' = 'Tier History ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Transaction ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `tier_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Effective Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Override Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `is_promotional_tier` SET TAGS ('dbx_business_glossary_term' = 'Is Promotional Tier Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `new_tier_benefits_activated_flag` SET TAGS ('dbx_business_glossary_term' = 'New Tier Benefits Activated Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `new_tier_code` SET TAGS ('dbx_business_glossary_term' = 'New Tier Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|in_app|mail|none');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `override_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Override Authorized By');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `override_justification` SET TAGS ('dbx_business_glossary_term' = 'Override Justification');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `previous_tier_benefits_revoked_flag` SET TAGS ('dbx_business_glossary_term' = 'Previous Tier Benefits Revoked Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `previous_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Previous Tier Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `processing_channel` SET TAGS ('dbx_business_glossary_term' = 'Processing Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `processing_channel` SET TAGS ('dbx_value_regex' = 'pos|olo|mobile_app|web|call_center|admin_portal');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `qualification_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `qualification_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `qualifying_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Points Balance');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `qualifying_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Spend Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `qualifying_visit_count` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Visit Count');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_notes` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Notes');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_number` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Number');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Reason Description');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_type` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `tier_change_type` SET TAGS ('dbx_value_regex' = 'upgrade|downgrade|lateral|initial_enrollment|reinstatement|manual_adjustment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `tier_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Tier Duration Days');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`tier_history` ALTER COLUMN `triggering_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Triggering Transaction Reference');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` SET TAGS ('dbx_subdomain' = 'points_rewards');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Points Ledger ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted By User ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adjusted By User ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Source Order ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`points_ledger` ALTER COLUMN `points_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` SET TAGS ('dbx_subdomain' = 'points_rewards');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `reward_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Identifier (ID)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`reward` ALTER COLUMN `supply_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` SET TAGS ('dbx_subdomain' = 'points_rewards');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`redemption` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item ID');
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `accrual_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Rule ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`accrual_rule` ALTER COLUMN `menu_item_scope` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Scope');
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `eligible_member_segments` SET TAGS ('dbx_business_glossary_term' = 'Eligible Member Segments');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `eligible_member_tiers` SET TAGS ('dbx_business_glossary_term' = 'Eligible Member Tiers');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `eligible_menu_items` SET TAGS ('dbx_business_glossary_term' = 'Eligible Menu Items');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Offer End Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `estimated_cost_per_redemption` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Per Redemption');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `estimated_cost_per_redemption` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `excluded_menu_items` SET TAGS ('dbx_business_glossary_term' = 'Excluded Menu Items');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer` ALTER COLUMN `free_item_sku` SET TAGS ('dbx_business_glossary_term' = 'Free Item SKU (Stock Keeping Unit)');
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `offer_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Assignment ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Offer ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `loyalty_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Segment ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `assignment_channel` SET TAGS ('dbx_business_glossary_term' = 'Assignment Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `assignment_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|in_app|pos|web');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `assignment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'crm_automation|loyalty_engine|manual_admin|api_integration|batch_job');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'personalized|mass_distributed|segment_targeted|triggered|manual');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `clicked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clicked Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `first_redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Redemption Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `is_wallet_visible` SET TAGS ('dbx_business_glossary_term' = 'Is Wallet Visible');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `last_redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Redemption Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `max_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Count');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `notification_preference_honored` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference Honored');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `personalization_score` SET TAGS ('dbx_business_glossary_term' = 'Personalization Score');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'available|redeemed|expired|revoked|pending');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revocation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_assignment` ALTER COLUMN `wallet_display_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wallet Display Start Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `offer_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Redemption ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `offer_franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'POS (Point of Sale) Terminal ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|afternoon|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|bogo|free_item|combo_upgrade|points_multiplier');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `final_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Order Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `is_duplicate_attempt` SET TAGS ('dbx_business_glossary_term' = 'Is Duplicate Attempt Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `is_first_redemption` SET TAGS ('dbx_business_glossary_term' = 'Is First Redemption Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `member_tier` SET TAGS ('dbx_business_glossary_term' = 'Member Tier');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `member_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|vip');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `offer_distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Offer Distribution Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `offer_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `original_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Order Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `points_earned` SET TAGS ('dbx_business_glossary_term' = 'Points Earned');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `points_multiplier_applied` SET TAGS ('dbx_business_glossary_term' = 'Points Multiplier Applied');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_value_regex' = 'pos|olo|drive_thru|kiosk|mobile_app|third_party_delivery');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `redemption_code` SET TAGS ('dbx_business_glossary_term' = 'Redemption Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `redemption_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'fulfilled|voided|duplicate_attempt|expired|invalid|pending');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `validation_method` SET TAGS ('dbx_business_glossary_term' = 'Validation Method');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `validation_method` SET TAGS ('dbx_value_regex' = 'barcode_scan|manual_entry|qr_code|nfc_tap|api_validation|loyalty_card_swipe');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`offer_redemption` ALTER COLUMN `void_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Void Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `challenge_id` SET TAGS ('dbx_business_glossary_term' = 'Challenge ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `challenge_status` SET TAGS ('dbx_business_glossary_term' = 'Challenge Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `challenge_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|completed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `challenge_type` SET TAGS ('dbx_business_glossary_term' = 'Challenge Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `challenge_type` SET TAGS ('dbx_value_regex' = 'visit_streak|spend_milestone|item_discovery|referral|social_engagement|daypart_challenge');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Channel Availability');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `challenge_code` SET TAGS ('dbx_business_glossary_term' = 'Challenge Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `challenge_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `completion_count` SET TAGS ('dbx_business_glossary_term' = 'Completion Count');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `completion_window_days` SET TAGS ('dbx_business_glossary_term' = 'Completion Window Days');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `current_participants` SET TAGS ('dbx_business_glossary_term' = 'Current Participant Count');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `challenge_description` SET TAGS ('dbx_business_glossary_term' = 'Challenge Description');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `eligibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Scope');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `eligibility_scope` SET TAGS ('dbx_value_regex' = 'all_members|tier_specific|segment_specific|invite_only');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `eligible_segment` SET TAGS ('dbx_business_glossary_term' = 'Eligible Customer Segment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `eligible_tier` SET TAGS ('dbx_business_glossary_term' = 'Eligible Membership Tier');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge End Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `estimated_cost_per_completion` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Per Completion');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `estimated_cost_per_completion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `image_url` SET TAGS ('dbx_business_glossary_term' = 'Challenge Image URL');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `is_repeatable` SET TAGS ('dbx_business_glossary_term' = 'Is Repeatable Challenge');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `max_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `challenge_name` SET TAGS ('dbx_business_glossary_term' = 'Challenge Name');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `repeat_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Repeat Frequency Days');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `reward_description` SET TAGS ('dbx_business_glossary_term' = 'Reward Description');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'points|free_item|discount|tier_bonus|badge');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `reward_value` SET TAGS ('dbx_business_glossary_term' = 'Reward Value');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge Start Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `target_acv_lift` SET TAGS ('dbx_business_glossary_term' = 'Target Average Check Value (ACV) Lift Percentage');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `target_criteria` SET TAGS ('dbx_business_glossary_term' = 'Target Criteria');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `target_frequency_lift` SET TAGS ('dbx_business_glossary_term' = 'Target Frequency Lift Percentage');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit of Measure');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `target_unit` SET TAGS ('dbx_value_regex' = 'visits|dollars|items|days|points|referrals');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `challenge_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Challenge Enrollment ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `challenge_id` SET TAGS ('dbx_business_glossary_term' = 'Challenge ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `challenge_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'member_request|ineligible|duplicate|system_error|policy_violation|other');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `challenge_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `challenge_enrollment_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|expired|abandoned|disqualified|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `days_remaining` SET TAGS ('dbx_business_glossary_term' = 'Days Remaining');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `days_to_completion` SET TAGS ('dbx_business_glossary_term' = 'Days to Completion');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge End Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web_portal|pos|email_campaign|push_notification|sms');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^CE-[0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'organic|promotional_offer|referral|auto_enrolled|gamification|targeted_campaign');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `notification_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Enabled Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Progress Percentage');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `progress_unit` SET TAGS ('dbx_business_glossary_term' = 'Progress Unit');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `progress_unit` SET TAGS ('dbx_value_regex' = 'visits|transactions|points|dollars_spent|items_purchased|days_active');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `progress_value` SET TAGS ('dbx_business_glossary_term' = 'Progress Value');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `reward_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Reward Issued Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `reward_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Reward Issued Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'points|discount|free_item|bonus_multiplier|tier_upgrade|badge');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `reward_value` SET TAGS ('dbx_business_glossary_term' = 'Reward Value');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge Start Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`challenge_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
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
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_event_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Staff ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Transaction ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Initial Tier ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `primary_enrollment_restaurant_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `primary_enrollment_staff_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Staff ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `primary_enrollment_staff_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `primary_enrollment_staff_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `primary_enrollment_transaction_guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Transaction ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Welcome Offer ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-In Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'olo|pos|mobile_app|kiosk|staff_assisted|web');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_country_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Country Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_device_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Device Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|kiosk|pos_terminal|unknown');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_geolocation` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Geolocation');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_geolocation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_geolocation` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Enrollment IP Address');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_language` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Language');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^ENR[0-9]{10}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source System');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed|cancelled|reversed');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'new|re_enrollment|transfer|upgrade');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Check Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `initial_points_awarded` SET TAGS ('dbx_business_glossary_term' = 'Initial Points Awarded');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `push_notification_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Opt-In Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `sms_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'SMS Opt-In Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `terms_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Terms Accepted Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `terms_version` SET TAGS ('dbx_business_glossary_term' = 'Terms Version');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `verification_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Completed Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `verification_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Completed Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Required Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`enrollment_event` ALTER COLUMN `welcome_offer_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Welcome Offer Issued Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Referred Member ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Location ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Referred Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referral_referred_guest_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Referred Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referral_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Location ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Referral Channel');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'app_share|email|sms|social_media|qr_code|in_store');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referral_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Expiration Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `first_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'First Transaction Amount');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `first_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'First Transaction Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `fraud_reason` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `message` SET TAGS ('dbx_business_glossary_term' = 'Referral Message');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'pending|converted|expired|fraudulent|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referral_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referred_bonus_awarded_date` SET TAGS ('dbx_business_glossary_term' = 'Referred Bonus Awarded Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referred_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Referred Bonus Points');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referrer_bonus_awarded_date` SET TAGS ('dbx_business_glossary_term' = 'Referrer Bonus Awarded Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `referrer_bonus_points` SET TAGS ('dbx_business_glossary_term' = 'Referrer Bonus Points');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `source_platform` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Platform');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `source_platform` SET TAGS ('dbx_value_regex' = 'mobile_app|web|pos|kiosk|third_party');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `terms_version` SET TAGS ('dbx_business_glossary_term' = 'Terms Version');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`referral` ALTER COLUMN `terms_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `loyalty_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for segment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `trade_area_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Activation Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `acv_max_threshold` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (ACV) Maximum Threshold');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `acv_min_threshold` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (ACV) Minimum Threshold');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `campaign_usage_count` SET TAGS ('dbx_business_glossary_term' = 'Campaign Usage Count');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `channel_preference` SET TAGS ('dbx_business_glossary_term' = 'Channel Preference');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `channel_preference` SET TAGS ('dbx_value_regex' = 'pos|olo|drive_thru|3pd|kiosk');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `control_group_flag` SET TAGS ('dbx_business_glossary_term' = 'Control Group Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `current_tier_filter` SET TAGS ('dbx_business_glossary_term' = 'Current Tier Filter');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `daypart_preference` SET TAGS ('dbx_business_glossary_term' = 'Daypart Preference');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `daypart_preference` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Deactivation Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `definition_criteria` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Criteria');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `exclusion_segment_ids` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Segment IDs');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|market|restaurant');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `lifetime_points_min` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Minimum Threshold');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `menu_affinity_category` SET TAGS ('dbx_business_glossary_term' = 'Menu Affinity Category');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `next_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Next Refresh Date');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Segment Notes');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `owner_team` SET TAGS ('dbx_value_regex' = 'crm|marketing|loyalty|analytics|franchise');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `predicted_incremental_revenue` SET TAGS ('dbx_business_glossary_term' = 'Predicted Incremental Revenue');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `predicted_response_rate` SET TAGS ('dbx_business_glossary_term' = 'Predicted Response Rate');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `recency_days_max` SET TAGS ('dbx_business_glossary_term' = 'Recency Days Maximum');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `recency_days_min` SET TAGS ('dbx_business_glossary_term' = 'Recency Days Minimum');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `refresh_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency Days');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|scheduled');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `target_market_codes` SET TAGS ('dbx_business_glossary_term' = 'Target Market Codes');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `test_segment_flag` SET TAGS ('dbx_business_glossary_term' = 'Test Segment Flag');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment` ALTER COLUMN `visit_frequency_threshold` SET TAGS ('dbx_business_glossary_term' = 'Visit Frequency Threshold');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment_membership` SET TAGS ('dbx_subdomain' = 'member_engagement');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment_membership` ALTER COLUMN `loyalty_segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for loyalty_segment_membership');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment_membership` ALTER COLUMN `loyalty_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Segment Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment_membership` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment_membership` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_segment_membership` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` SET TAGS ('dbx_subdomain' = 'points_rewards');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ALTER COLUMN `loyalty_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for loyalty_visit');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_visit` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` SET TAGS ('dbx_subdomain' = 'points_rewards');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ALTER COLUMN `loyalty_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for loyalty_adjustment');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`loyalty_adjustment` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` SET TAGS ('dbx_subdomain' = 'offer_campaigns');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` SET TAGS ('dbx_association_edges' = 'loyalty.program,marketing.campaign');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` ALTER COLUMN `program_campaign_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Programcampaignallocation - Allocation Id');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Programcampaignallocation - Campaign Id');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Programcampaignallocation - Program Id');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_business_glossary_term' = 'Programcampaignallocation - Budget Allocation');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Programcampaignallocation - Target Audience');
ALTER TABLE `vibe_restaurants_v1`.`loyalty`.`program_campaign_allocation` ALTER COLUMN `target_audience` SET TAGS ('dbx_marketing' = 'true');
