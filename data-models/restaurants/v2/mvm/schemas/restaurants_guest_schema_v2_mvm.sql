-- Schema for Domain: guest | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-02 04:02:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`guest` COMMENT 'Single source of truth for customer identity, profiles, preferences, demographics, segments, loyalty membership, and guest engagement across all channels (dine-in, drive-thru, online ordering). Manages CSAT, NPS, lifetime value, and consent/privacy management. Master record for WHO the business serves.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`profile` (
    `profile_id` BIGINT COMMENT 'Primary key for guest profile',
    `location_profile_id` BIGINT COMMENT 'Preferred location profile',
    `program_id` BIGINT COMMENT 'Enrolled loyalty program',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: loyalty.profile has a denormalized loyalty_tier string. Replacing it with a FK to loyalty.tier enables tier-based profile queries, tier benefit lookups, and referential integrity for tier-driven persona',
    `menu_item_id` BIGINT COMMENT 'Favorite menu item',
    `unit_id` BIGINT COMMENT 'Preferred restaurant unit',
    `profile_unit_id` BIGINT COMMENT 'Home restaurant unit',
    `address_line1` STRING COMMENT 'Primary address line 1',
    `address_line2` STRING COMMENT 'Primary address line 2',
    `average_check_value` DECIMAL(18,2) COMMENT 'Average transaction amount',
    `birthday_day` STRING COMMENT 'Day of birth for birthday rewards',
    `birthday_month` STRING COMMENT 'Month of birth for birthday rewards',
    `city` STRING COMMENT 'City of residence',
    `consent_email` BOOLEAN COMMENT 'Email marketing consent flag',
    `consent_privacy` BOOLEAN COMMENT 'Privacy policy consent flag',
    `consent_sms` BOOLEAN COMMENT 'SMS marketing consent flag',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this profile',
    `data_source` STRING COMMENT 'Source system for profile data',
    `data_source_code` STRING COMMENT 'Source system code',
    `date_of_birth` DATE COMMENT 'Guest date of birth',
    `email_address` STRING COMMENT 'Primary email address',
    `first_name` STRING COMMENT 'Guest first name',
    `full_name` STRING COMMENT 'Guest full name',
    `gender` STRING COMMENT 'Guest gender',
    `guest_type` STRING COMMENT 'Type of guest (individual, corporate, etc.)',
    `last_name` STRING COMMENT 'Guest last name',
    `last_visit_timestamp` TIMESTAMP COMMENT 'Timestamp of most recent visit',
    `marketing_opt_in` BOOLEAN COMMENT 'Marketing opt-in flag',
    `marketing_source` STRING COMMENT 'Marketing acquisition source',
    `notes` STRING COMMENT 'Free-form notes about guest',
    `phone_number` STRING COMMENT 'Primary phone number',
    `picture_url` STRING COMMENT 'Profile picture URL',
    `postal_code` STRING COMMENT 'Postal/ZIP code',
    `preferred_language` STRING COMMENT 'Preferred language for communications',
    `primary_contact_method` STRING COMMENT 'Preferred contact method',
    `profile_status` STRING COMMENT 'Profile status (active, inactive, etc.)',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record last update timestamp',
    `state` STRING COMMENT 'State/province',
    `total_lifetime_visits` DECIMAL(18,2) COMMENT 'Total number of visits',
    `total_spent` DECIMAL(18,2) COMMENT 'Total lifetime spend',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Core guest profile containing personal information, contact details, preferences, and loyalty status';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`address` (
    `address_id` BIGINT COMMENT 'Primary key',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `address_profile_id` BIGINT COMMENT 'Profile link',
    `delivery_order_id` BIGINT COMMENT 'Foreign key linking to order.delivery_order. Business justification: Delivery operations require linking the canonical guest address record to each delivery order for address validation, delivery zone analytics, and repeat-delivery route optimization. delivery_order cu',
    `owner_profile_id` BIGINT COMMENT 'Owner profile',
    `address_status` STRING COMMENT 'The current status of the address for this address',
    `address_type` STRING COMMENT 'Type (home, work, delivery)',
    `building_name` STRING COMMENT 'The display name or label for the building in this address',
    `city` STRING COMMENT 'The city attribute value for this address record in the guest domain',
    `country_code` STRING COMMENT 'A standardized code representing the country classification for this address',
    `county` STRING COMMENT 'The county attribute value for this address record in the guest domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this address record in the guest domain',
    `delivery_instructions` STRING COMMENT 'The delivery instructions attribute value for this address record in the guest domain',
    `district` STRING COMMENT 'The district attribute value for this address record in the guest domain',
    `geocode_accuracy` STRING COMMENT 'Geocode accuracy level',
    `is_primary` BOOLEAN COMMENT 'Is primary address',
    `landmark` STRING COMMENT 'Nearby landmark',
    `last_verified` DATE COMMENT 'Last verification date',
    `latitude` DOUBLE COMMENT 'Latitude coordinate',
    `line1` STRING COMMENT 'Address line 1',
    `line2` STRING COMMENT 'Address line 2',
    `longitude` DOUBLE COMMENT 'Longitude coordinate',
    `natural_key` STRING COMMENT 'Natural key for address',
    `owner_type` STRING COMMENT 'The classification type for owner in this address',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification for this address',
    `region` STRING COMMENT 'The region attribute value for this address record in the guest domain',
    `state_province` STRING COMMENT 'State or province',
    `suite_number` STRING COMMENT 'The suite number attribute value for this address record in the guest domain',
    `time_zone` STRING COMMENT 'The time zone attribute value for this address record in the guest domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this address record in the guest domain',
    `validation_status` STRING COMMENT 'The current status of the validation for this address',
    `validation_timestamp` TIMESTAMP COMMENT 'The validation timestamp attribute value for this address record in the guest domain',
    `validity_flag` BOOLEAN COMMENT 'Is address valid',
    `verification_method` STRING COMMENT 'The verification method attribute value for this address record in the guest domain',
    `verification_score` DECIMAL(18,2) COMMENT 'The verification score attribute value for this address record in the guest domain',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Guest addresses for delivery, billing, and correspondence';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`preference` (
    `preference_id` BIGINT COMMENT 'Primary key',
    `menu_item_id` BIGINT COMMENT 'Favorite menu item',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Guest preferences are tier-gated in restaurant loyalty (Gold members get LTO early access, Platinum gets free delivery). Replacing the denormalized loyalty_tier string with a proper FK to loyalty.tier',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `preference_profile_id` BIGINT COMMENT 'Profile link',
    `communication_channel_preference` STRING COMMENT 'Preferred communication channel',
    `consent_given` BOOLEAN COMMENT 'Consent given flag',
    `consent_timestamp` TIMESTAMP COMMENT 'The consent timestamp attribute value for this preference record in the guest domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this preference record in the guest domain',
    `data_source_timestamp` TIMESTAMP COMMENT 'The data source timestamp attribute value for this preference record in the guest domain',
    `device_preference` STRING COMMENT 'The device preference attribute value for this preference record in the guest domain',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `favorite_cuisine` STRING COMMENT 'Favorite cuisine type',
    `has_dairy_allergy` BOOLEAN COMMENT 'Boolean indicator flag for has dairy allergy status in this preference',
    `has_gluten_allergy` BOOLEAN COMMENT 'Boolean indicator flag for has gluten allergy status in this preference',
    `has_nut_allergy` BOOLEAN COMMENT 'Boolean indicator flag for has nut allergy status in this preference',
    `is_active` BOOLEAN COMMENT 'Is preference active',
    `is_halal` BOOLEAN COMMENT 'Requires halal',
    `is_kosher` BOOLEAN COMMENT 'Requires kosher',
    `is_vegan` BOOLEAN COMMENT 'Boolean indicator flag for is vegan status in this preference',
    `is_vegetarian` BOOLEAN COMMENT 'Boolean indicator flag for is vegetarian status in this preference',
    `language_preference` STRING COMMENT 'The language preference attribute value for this preference record in the guest domain',
    `marketing_opt_in` BOOLEAN COMMENT 'Marketing opt-in',
    `marketing_opt_out_reason` STRING COMMENT 'Opt-out reason',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this preference',
    `origin` STRING COMMENT 'Origin of preference',
    `preference_status` STRING COMMENT 'The current status of the preference for this preference',
    `preference_type` STRING COMMENT 'Type of preference',
    `preferred_daypart` STRING COMMENT 'The preferred daypart attribute value for this preference record in the guest domain',
    `preferred_payment_method` STRING COMMENT 'The preferred payment method attribute value for this preference record in the guest domain',
    `preferred_seating` STRING COMMENT 'The preferred seating attribute value for this preference record in the guest domain',
    `preferred_service_channel` STRING COMMENT 'The preferred service channel attribute value for this preference record in the guest domain',
    `privacy_consent_version` STRING COMMENT 'The privacy consent version attribute value for this preference record in the guest domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this preference record in the guest domain',
    `value` DECIMAL(18,2) COMMENT 'Preference value',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Guest preferences for dietary restrictions, communication, and service';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Primary key',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: GDPR and CCPA compliance require brand-scoped consent records in a multi-brand enterprise — a guest may consent to marketing from Brand A but not Brand B. Regulatory consent audits and data subject ac',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: GDPR/CCPA compliance requires consent records scoped to the specific loyalty program whose data processing they authorize. Linking consent_record to program enables program-specific consent audits and',
    `consent_expiry_date` DATE COMMENT 'The date and time when the consent expiry event occurred for this consent record',
    `consent_language` STRING COMMENT 'Language of consent',
    `consent_method` STRING COMMENT 'Method of consent capture',
    `consent_purpose` STRING COMMENT 'Purpose of consent',
    `consent_revoked_reason` STRING COMMENT 'Reason for revocation',
    `consent_revoked_timestamp` TIMESTAMP COMMENT 'Revocation timestamp',
    `consent_source_channel` STRING COMMENT 'Source channel',
    `consent_status` STRING COMMENT 'The current status of the consent for this consent record',
    `consent_timestamp` TIMESTAMP COMMENT 'The consent timestamp attribute value for this consent record record in the guest domain',
    `consent_type` STRING COMMENT 'Type of consent',
    `consent_version` STRING COMMENT 'The consent version attribute value for this consent record record in the guest domain',
    `created` TIMESTAMP COMMENT 'Created timestamp',
    `data_processing_scope` STRING COMMENT 'The data processing scope attribute value for this consent record record in the guest domain',
    `data_sharing_consent` BOOLEAN COMMENT 'The data sharing consent attribute value for this consent record record in the guest domain',
    `device_code` STRING COMMENT 'A standardized code representing the device classification for this consent record',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `email_consent` BOOLEAN COMMENT 'The email consent attribute value for this consent record record in the guest domain',
    `ip_address` STRING COMMENT 'The ip address attribute value for this consent record record in the guest domain',
    `marketing_consent` BOOLEAN COMMENT 'The marketing consent attribute value for this consent record record in the guest domain',
    `privacy_notice_version` STRING COMMENT 'The privacy notice version attribute value for this consent record record in the guest domain',
    `sms_consent` BOOLEAN COMMENT 'The sms consent attribute value for this consent record record in the guest domain',
    `third_party_consent` BOOLEAN COMMENT 'The third party consent attribute value for this consent record record in the guest domain',
    `updated` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Records of guest consent for marketing, data processing, and privacy';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`segment` (
    `segment_id` BIGINT COMMENT 'Primary key',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: In a multi-brand restaurant enterprise, guest segments are brand-scoped (e.g., Lapsed Burger Brand Loyalists). Brand-level CRM reporting, targeted marketing campaigns, and loyalty program management',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Guest segments in restaurant loyalty are scoped to a specific program (e.g., Gold members in Program X inactive 30 days). Linking segment to program enables program-specific segmentation reporting, ',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: Many restaurant loyalty segments are tier-defined (e.g., all Silver tier members). Linking guest_segment to loyalty.tier enables tier-based segment definition, tier upgrade campaign targeting, and t',
    `avg_check_amount` DECIMAL(18,2) COMMENT 'Average check amount',
    `avg_lifetime_value` DECIMAL(18,2) COMMENT 'Average lifetime value',
    `avg_visit_frequency` DECIMAL(18,2) COMMENT 'Average visit frequency',
    `segment_category` STRING COMMENT 'The segment category attribute value for this guest segment record in the guest domain',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'The churn risk score attribute value for this guest segment record in the guest domain',
    `segment_code` STRING COMMENT 'A standardized code representing the segment classification for this guest segment',
    `created_at` TIMESTAMP COMMENT 'Created at timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this guest segment record in the guest domain',
    `criteria_definition` STRING COMMENT 'The criteria definition attribute value for this guest segment record in the guest domain',
    `definition_rule` STRING COMMENT 'The definition rule attribute value for this guest segment record in the guest domain',
    `segment_description` STRING COMMENT 'The segment description attribute value for this guest segment record in the guest domain',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this guest segment',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this guest segment',
    `effective_until` DATE COMMENT 'Effective until date',
    `estimated_member_count` STRING COMMENT 'The count or quantity of estimated member items in this guest segment',
    `guest_segment_description` STRING COMMENT 'The guest segment description attribute value for this guest segment record in the guest domain',
    `guest_segment_status` STRING COMMENT 'The current status of the guest segment for this guest segment',
    `is_active` BOOLEAN COMMENT 'Is segment active',
    `is_dynamic` BOOLEAN COMMENT 'Is dynamically updated',
    `last_refreshed_timestamp` TIMESTAMP COMMENT 'Last refresh timestamp',
    `member_count` STRING COMMENT 'Current member count',
    `segment_name` STRING COMMENT 'The display name or label for the segment in this guest segment',
    `owner` STRING COMMENT 'The owner attribute value for this guest segment record in the guest domain',
    `owner_team` STRING COMMENT 'The owner team attribute value for this guest segment record in the guest domain',
    `priority_rank` STRING COMMENT 'The priority rank attribute value for this guest segment record in the guest domain',
    `refresh_frequency` STRING COMMENT 'The refresh frequency attribute value for this guest segment record in the guest domain',
    `segment_type` STRING COMMENT 'The classification type for segment in this guest segment',
    `segmentation_method` STRING COMMENT 'The segmentation method attribute value for this guest segment record in the guest domain',
    `source_system_code` STRING COMMENT 'A standardized code representing the source system classification for this guest segment',
    `target_channel` STRING COMMENT 'The target channel attribute value for this guest segment record in the guest domain',
    `updated_at` TIMESTAMP COMMENT 'Updated at timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this guest segment record in the guest domain',
    `created_by` STRING COMMENT 'Created by user',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Guest segments for targeted marketing and personalization';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`segment_membership` (
    `segment_membership_id` BIGINT COMMENT 'Primary key',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Loyalty member segmentation drives targeted campaigns and tier-upgrade nudges. guest_segment_membership must reference the loyalty member (not just guest profile) to enable points-based segmentation l',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `segment_id` BIGINT COMMENT 'Segment link',
    `added_date` DATE COMMENT 'The date and time when the added event occurred for this guest segment membership',
    `assigned_date` DATE COMMENT 'The date and time when the assigned event occurred for this guest segment membership',
    `assignment_method` STRING COMMENT 'The assignment method attribute value for this guest segment membership record in the guest domain',
    `assignment_reason` STRING COMMENT 'The assignment reason attribute value for this guest segment membership record in the guest domain',
    `assignment_score` DECIMAL(18,2) COMMENT 'The assignment score attribute value for this guest segment membership record in the guest domain',
    `assignment_source` STRING COMMENT 'The assignment source attribute value for this guest segment membership record in the guest domain',
    `confidence_score` DECIMAL(18,2) COMMENT 'The confidence score attribute value for this guest segment membership record in the guest domain',
    `created_at` TIMESTAMP COMMENT 'Created at timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this guest segment membership record in the guest domain',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this guest segment membership',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this guest segment membership',
    `exited_at` TIMESTAMP COMMENT 'Exited at timestamp',
    `exited_date` DATE COMMENT 'The date and time when the exited event occurred for this guest segment membership',
    `is_active` BOOLEAN COMMENT 'Boolean indicator flag for is active status in this guest segment membership',
    `joined_at` TIMESTAMP COMMENT 'Joined at timestamp',
    `joined_date` DATE COMMENT 'The date and time when the joined event occurred for this guest segment membership',
    `match_score` DECIMAL(18,2) COMMENT 'The match score attribute value for this guest segment membership record in the guest domain',
    `membership_score` DECIMAL(18,2) COMMENT 'The membership score attribute value for this guest segment membership record in the guest domain',
    `membership_source` STRING COMMENT 'The membership source attribute value for this guest segment membership record in the guest domain',
    `membership_status` STRING COMMENT 'The current status of the membership for this guest segment membership',
    `removed_at` TIMESTAMP COMMENT 'Removed at timestamp',
    `removed_date` DATE COMMENT 'The date and time when the removed event occurred for this guest segment membership',
    `score` DECIMAL(18,2) COMMENT 'The score attribute value for this guest segment membership record in the guest domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this guest segment membership record in the guest domain',
    CONSTRAINT pk_segment_membership PRIMARY KEY(`segment_membership_id`)
) COMMENT 'Guest membership in segments with assignment details and scores';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` (
    `satisfaction_survey_id` BIGINT COMMENT 'Primary key',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Loyalty programs use NPS/CSAT scores to trigger tier reviews, issue recovery points, and personalize outreach. Linking surveys directly to the loyalty member enables NPS by tier reporting and point',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `unit_id` BIGINT COMMENT 'Unique identifier for the satisfaction unit associated with this satisfaction survey',
    `employee_id` BIGINT COMMENT 'Server employee link',
    `guest_order_id` BIGINT COMMENT 'Foreign key linking to order.guest_order. Business justification: Post-transaction survey programs (CSAT/NPS) are triggered by specific orders. Guest experience analysts must join survey scores to the originating order for root-cause analysis, server performance rev',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Menu engineering and quality management require linking CSAT/NPS scores to specific menu items. Restaurant ops teams run item-level satisfaction reports to identify underperforming items for reformula',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: A satisfaction survey is fundamentally about a specific guest visit experience. Linking satisfaction_survey to guest_visit allows the business to correlate NPS/CSAT scores directly with the visit that',
    `comments` STRING COMMENT 'Survey comments',
    `completion_status` STRING COMMENT 'The current status of the completion for this satisfaction survey',
    `consent_given` BOOLEAN COMMENT 'The consent given attribute value for this satisfaction survey record in the guest domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this satisfaction survey record in the guest domain',
    `csat_score` DECIMAL(18,2) COMMENT 'The csat score attribute value for this satisfaction survey record in the guest domain',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this satisfaction survey',
    `delivery_channel` STRING COMMENT 'The delivery channel attribute value for this satisfaction survey record in the guest domain',
    `delivery_timestamp` TIMESTAMP COMMENT 'The delivery timestamp attribute value for this satisfaction survey record in the guest domain',
    `language` STRING COMMENT 'The language attribute value for this satisfaction survey record in the guest domain',
    `nps_score` DECIMAL(18,2) COMMENT 'The nps score attribute value for this satisfaction survey record in the guest domain',
    `response_timestamp` TIMESTAMP COMMENT 'The response timestamp attribute value for this satisfaction survey record in the guest domain',
    `satisfaction_survey_status` STRING COMMENT 'Survey status',
    `survey_type` STRING COMMENT 'The classification type for survey in this satisfaction survey',
    `survey_version` STRING COMMENT 'The survey version attribute value for this satisfaction survey record in the guest domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this satisfaction survey record in the guest domain',
    `visit_date` DATE COMMENT 'The date and time when the visit event occurred for this satisfaction survey',
    `visit_timestamp` TIMESTAMP COMMENT 'The visit timestamp attribute value for this satisfaction survey record in the guest domain',
    CONSTRAINT pk_satisfaction_survey PRIMARY KEY(`satisfaction_survey_id`)
) COMMENT 'Guest satisfaction surveys with NPS and CSAT scores';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`complaint` (
    `complaint_id` BIGINT COMMENT 'Primary key',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Food safety, quality assurance, and menu management require tracking complaints by specific menu item — enabling complaint frequency reports per item, allergen incident tracking, and menu item recall ',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `complaint_profile_id` BIGINT COMMENT 'Profile link',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: Food safety complaints (temperature abuse, equipment malfunction causing illness) must be traceable to a specific equipment asset for HACCP compliance and health authority regulatory reporting. Compla',
    `guest_order_id` BIGINT COMMENT 'Order link',
    `employee_id` BIGINT COMMENT 'Handling employee link',
    `ingredient_id` BIGINT COMMENT 'Ingredient link',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: HACCP and FDA FSMA corrective-action reporting requires linking a guest food-safety complaint (illness, allergen reaction, foreign object) to the specific ingredient lot served. Existing complaint.ing',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: High-tier loyalty members receive priority complaint resolution and compensatory points. Linking complaints to the loyalty member enables tier-aware escalation routing, recovery points issuance, and l',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to order.order_item. Business justification: Food safety, quality assurance, and guest recovery processes require linking complaints to the specific order item implicated (e.g., wrong preparation, allergen incident, foreign object). The existing',
    `unit_id` BIGINT COMMENT 'Restaurant unit link',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Food safety and allergen incident response: when a guest complaint involves a specific ingredient (foreign object, spoilage, allergen reaction), operations must trace the exact stock item — including ',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: A complaint is typically raised about a specific guest visit experience (wrong order, poor service, food quality issue during a visit). Linking complaint to guest_visit via complaint_guest_visit_id al',
    `complaint_category` STRING COMMENT 'The complaint category attribute value for this complaint record in the guest domain',
    `channel` STRING COMMENT 'Complaint channel',
    `complaint_number` STRING COMMENT 'The complaint number attribute value for this complaint record in the guest domain',
    `complaint_status` STRING COMMENT 'The current status of the complaint for this complaint',
    `complaint_timestamp` TIMESTAMP COMMENT 'The complaint timestamp attribute value for this complaint record in the guest domain',
    `consent_given` BOOLEAN COMMENT 'The consent given attribute value for this complaint record in the guest domain',
    `csat_score` DECIMAL(18,2) COMMENT 'The csat score attribute value for this complaint record in the guest domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this complaint',
    `complaint_description` STRING COMMENT 'The complaint description attribute value for this complaint record in the guest domain',
    `escalated_to` BIGINT COMMENT 'Escalated to employee ID',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator flag for escalation flag status in this complaint',
    `feedback_comments` STRING COMMENT 'The feedback comments attribute value for this complaint record in the guest domain',
    `nps_score` DECIMAL(18,2) COMMENT 'The nps score attribute value for this complaint record in the guest domain',
    `privacy_consent_timestamp` TIMESTAMP COMMENT 'The privacy consent timestamp attribute value for this complaint record in the guest domain',
    `record_created_at` TIMESTAMP COMMENT 'The date and time when the record created event occurred for this complaint',
    `record_updated_at` TIMESTAMP COMMENT 'The date and time when the record updated event occurred for this complaint',
    `resolution_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for resolution in this complaint',
    `resolution_status` STRING COMMENT 'The current status of the resolution for this complaint',
    `resolution_timestamp` TIMESTAMP COMMENT 'The resolution timestamp attribute value for this complaint record in the guest domain',
    `resolution_type` STRING COMMENT 'The classification type for resolution in this complaint',
    `severity_level` STRING COMMENT 'The severity level attribute value for this complaint record in the guest domain',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Guest complaints and resolution tracking';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Employee link',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Digital engagement analytics and personalization engines track which menu items a guest viewed, clicked, or added to cart during app/kiosk interactions. This drives recommendation algorithms and item-',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `interaction_profile_id` BIGINT COMMENT 'Profile link',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Loyalty member interactions (app opens, push notification responses, offer views) are tracked to measure engagement and trigger automated loyalty journeys. Linking interactions to the loyalty member e',
    `unit_id` BIGINT COMMENT 'Restaurant unit link',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: Guest interactions (touchpoints across channels) can be directly associated with a specific guest visit — for example, a post-visit survey delivery interaction, a loyalty points notification during a ',
    `channel` STRING COMMENT 'Interaction channel',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this interaction record in the guest domain',
    `device_code` STRING COMMENT 'A standardized code representing the device classification for this interaction',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp attribute value for this interaction record in the guest domain',
    `interaction_type` STRING COMMENT 'The classification type for interaction in this interaction',
    `is_test` BOOLEAN COMMENT 'Is test interaction',
    `outcome` STRING COMMENT 'Interaction outcome',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this interaction record in the guest domain',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Guest interactions across all touchpoints';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`visit` (
    `visit_id` BIGINT COMMENT 'Primary key',
    `guest_order_id` BIGINT COMMENT 'Guest order link',
    `labor_forecast_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_forecast. Business justification: Restaurants measure forecast accuracy by comparing projected_cover_count in labor_forecast against actual guest visits for the same date/daypart/unit. This forecast-vs-actual reconciliation is a named',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Visit-level loyalty tracking is fundamental to restaurant operations — each visit must link to the loyalty member to award points, track visit streaks, and validate tier qualification thresholds. The ',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to restaurant.pos_terminal. Business justification: Every counter or dine-in visit is processed on a specific POS terminal. POS audit trails, fraud detection, speed-of-service reporting, and PCI compliance investigations all require linking a guest vis',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the employee associated with this guest visit record',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Restaurant operations track labor cost per cover and shift performance by linking actual guest visits to the active shift. This enables covers-per-shift, revenue-per-labor-hour, and shift-level CSAT r',
    `unit_id` BIGINT COMMENT 'Restaurant unit link',
    `visit_guest_unit_id` BIGINT COMMENT 'Unique identifier for the guest unit associated with this guest visit',
    `visit_host_employee_id` BIGINT COMMENT 'Host employee link',
    `visit_profile_id` BIGINT COMMENT 'Profile link',
    `amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for visit in this guest visit',
    `channel` STRING COMMENT 'The visit channel attribute value for this guest visit record in the guest domain',
    `check_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for check in this guest visit',
    `check_total` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for check in this guest visit',
    `created_at` TIMESTAMP COMMENT 'Created at timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this guest visit record in the guest domain',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this guest visit',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Visit duration in minutes',
    `dwell_minutes` STRING COMMENT 'The dwell minutes attribute value for this guest visit record in the guest domain',
    `dwell_time_minutes` STRING COMMENT 'Dwell time in minutes',
    `is_loyalty_visit` BOOLEAN COMMENT 'Boolean indicator flag for is loyalty visit status in this guest visit',
    `is_repeat_visit` BOOLEAN COMMENT 'Boolean indicator flag for is repeat visit status in this guest visit',
    `item_count` STRING COMMENT 'The count or quantity of item items in this guest visit',
    `party_size` STRING COMMENT 'The party size attribute value for this guest visit record in the guest domain',
    `satisfaction_rating` STRING COMMENT 'The satisfaction rating attribute value for this guest visit record in the guest domain',
    `satisfaction_score` DECIMAL(18,2) COMMENT 'The satisfaction score attribute value for this guest visit record in the guest domain',
    `spend_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for spend in this guest visit',
    `table_number` STRING COMMENT 'The table number attribute value for this guest visit record in the guest domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this guest visit record in the guest domain',
    `visit_date` DATE COMMENT 'The date and time when the visit event occurred for this guest visit',
    `visit_time` TIMESTAMP COMMENT 'The visit time attribute value for this guest visit record in the guest domain',
    `visit_timestamp` TIMESTAMP COMMENT 'The visit timestamp attribute value for this guest visit record in the guest domain',
    `visit_type` STRING COMMENT 'The classification type for visit in this guest visit',
    CONSTRAINT pk_visit PRIMARY KEY(`visit_id`)
) COMMENT 'Guest visit records with transaction and experience details';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`digital_account` (
    `digital_account_id` BIGINT COMMENT 'Primary key',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: In a multi-brand restaurant enterprise, a digital account is registered under a specific brands app (e.g., Brand A loyalty app vs Brand B app). Brand-scoped digital account reporting, app personaliza',
    `member_id` BIGINT COMMENT 'Member link',
    `profile_id` BIGINT COMMENT 'Profile link',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: A digital account is enrolled in a specific loyalty program in multi-program restaurant brands. Linking digital_account to program enables program-specific app feature gating, enrollment validation, a',
    `account_number` STRING COMMENT 'The account number attribute value for this digital account record in the guest domain',
    `account_tier` STRING COMMENT 'The account tier attribute value for this digital account record in the guest domain',
    `app_version` STRING COMMENT 'The app version attribute value for this digital account record in the guest domain',
    `consent_marketing` BOOLEAN COMMENT 'Marketing consent',
    `consent_third_party` BOOLEAN COMMENT 'Third party consent',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this digital account record in the guest domain',
    `device_type` STRING COMMENT 'The classification type for device in this digital account',
    `digital_account_status` STRING COMMENT 'Account status',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `email` STRING COMMENT 'The email attribute value for this digital account record in the guest domain',
    `failed_login_attempts` STRING COMMENT 'The failed login attempts attribute value for this digital account record in the guest domain',
    `last_login_timestamp` TIMESTAMP COMMENT 'The last login timestamp attribute value for this digital account record in the guest domain',
    `lockout_timestamp` TIMESTAMP COMMENT 'The lockout timestamp attribute value for this digital account record in the guest domain',
    `password_last_changed` DATE COMMENT 'The password last changed attribute value for this digital account record in the guest domain',
    `phone_number` STRING COMMENT 'The phone number attribute value for this digital account record in the guest domain',
    `privacy_opt_out` BOOLEAN COMMENT 'Privacy opt-out',
    `registration_channel` DECIMAL(18,2) COMMENT 'The registration channel attribute value for this digital account record in the guest domain',
    `two_factor_enabled` DECIMAL(18,2) COMMENT 'The two factor enabled attribute value for this digital account record in the guest domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this digital account record in the guest domain',
    `username` STRING COMMENT 'The username attribute value for this digital account record in the guest domain',
    CONSTRAINT pk_digital_account PRIMARY KEY(`digital_account_id`)
) COMMENT 'Guest digital accounts for app and online ordering';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_address_profile_id` FOREIGN KEY (`address_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_owner_profile_id` FOREIGN KEY (`owner_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_preference_profile_id` FOREIGN KEY (`preference_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment_membership` ADD CONSTRAINT `fk_guest_segment_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment_membership` ADD CONSTRAINT `fk_guest_segment_membership_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`visit`(`visit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_complaint_profile_id` FOREIGN KEY (`complaint_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`visit`(`visit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_interaction_profile_id` FOREIGN KEY (`interaction_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`visit`(`visit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_visit_profile_id` FOREIGN KEY (`visit_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ADD CONSTRAINT `fk_guest_digital_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`guest` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`guest` SET TAGS ('dbx_domain' = 'guest');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `location_profile_id` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_day` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_day` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_month` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_month` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_email` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_email` SET TAGS ('dbx_denormalization_addressed' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_profile_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `delivery_order_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `county` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `natural_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `natural_key` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `suite_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_dairy_allergy` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_gluten_allergy` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_nut_allergy` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment` SET TAGS ('dbx_subdomain' = 'marketing_personalization');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment_membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment_membership` SET TAGS ('dbx_subdomain' = 'marketing_personalization');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment_membership` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment_membership` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`segment_membership` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` SET TAGS ('dbx_subdomain' = 'experience_feedback');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Guest Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyed Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` SET TAGS ('dbx_subdomain' = 'experience_feedback');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Complained Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Equipment Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Order Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Guest Visit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` SET TAGS ('dbx_subdomain' = 'experience_feedback');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Interacted Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` SET TAGS ('dbx_subdomain' = 'experience_feedback');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `labor_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Forecast Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `visit_host_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `visit_host_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` SET TAGS ('dbx_subdomain' = 'marketing_personalization');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `failed_login_attempts` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `password_last_changed` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `username` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `username` SET TAGS ('dbx_pii_detected' = 'true');
