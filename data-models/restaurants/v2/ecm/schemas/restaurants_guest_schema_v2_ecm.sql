-- Schema for Domain: guest | Business:  | Version: v2_ecm
-- Generated on: 2026-07-02 03:00:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`guest` COMMENT 'Single source of truth for customer identity, profiles, preferences, demographics, segments, loyalty membership, and guest engagement across all channels (dine-in, drive-thru, online ordering). Manages CSAT, NPS, lifetime value, and consent/privacy management. Master record for WHO the business serves.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`profile` (
    `profile_id` BIGINT COMMENT 'Primary key for guest profile',
    `corporate_account_id` DECIMAL(18,2) COMMENT 'Link to corporate account if business guest',
    `location_profile_id` BIGINT COMMENT 'Preferred location profile',
    `program_id` BIGINT COMMENT 'Enrolled loyalty program',
    `menu_item_id` BIGINT COMMENT 'Favorite menu item',
    `unit_id` BIGINT COMMENT 'Preferred restaurant unit',
    `profile_unit_id` BIGINT COMMENT 'Home restaurant unit',
    `profit_center_id` BIGINT COMMENT 'Profit center for reporting',
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
    `loyalty_tier` STRING COMMENT 'Current loyalty tier',
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
    `secondary_phone` STRING COMMENT 'Secondary phone number',
    `state` STRING COMMENT 'State/province',
    `total_lifetime_visits` DECIMAL(18,2) COMMENT 'Total number of visits',
    `total_spent` DECIMAL(18,2) COMMENT 'Total lifetime spend',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Core guest profile containing personal information, contact details, preferences, and loyalty status';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` (
    `identity_resolution_id` BIGINT COMMENT 'Primary key',
    `profile_id` BIGINT COMMENT 'Golden record profile ID',
    `identity_profile_id` BIGINT COMMENT 'Source profile ID',
    `member_id` BIGINT COMMENT 'Linked loyalty member',
    `address_line1` STRING COMMENT 'Address for matching',
    `city` STRING COMMENT 'City for matching',
    `consent_status` STRING COMMENT 'The current status of the consent for this identity resolution',
    `country` STRING COMMENT 'The country attribute value for this identity resolution record in the guest domain',
    `csat_score` DECIMAL(18,2) COMMENT 'Customer satisfaction score',
    `data_source_confidence_score` DECIMAL(18,2) COMMENT 'Data source confidence',
    `date_of_birth` DATE COMMENT 'Date of birth for matching',
    `duplicate_flag` BOOLEAN COMMENT 'Indicates potential duplicate',
    `full_name` STRING COMMENT 'Full name for matching',
    `gender` STRING COMMENT 'The gender attribute value for this identity resolution record in the guest domain',
    `golden_record_flag` BOOLEAN COMMENT 'Is this the golden record',
    `guest_status` STRING COMMENT 'The current status of the guest for this identity resolution',
    `guest_type` STRING COMMENT 'The classification type for guest in this identity resolution',
    `last_interaction_timestamp` TIMESTAMP COMMENT 'Last interaction time',
    `lifecycle_status` STRING COMMENT 'The current status of the lifecycle for this identity resolution',
    `loyalty_tier` STRING COMMENT 'The loyalty tier attribute value for this identity resolution record in the guest domain',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'The match confidence score attribute value for this identity resolution record in the guest domain',
    `match_event_reason` STRING COMMENT 'Reason for match',
    `match_method` STRING COMMENT 'Method used for matching',
    `merge_event_timestamp` TIMESTAMP COMMENT 'When merge occurred',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this identity resolution',
    `nps_score` DECIMAL(18,2) COMMENT 'Net promoter score',
    `postal_code` STRING COMMENT 'Postal code for matching',
    `preferred_communication_channel` STRING COMMENT 'Preferred channel',
    `preferred_language` STRING COMMENT 'The preferred language attribute value for this identity resolution record in the guest domain',
    `primary_email` STRING COMMENT 'Primary email for matching',
    `primary_phone` STRING COMMENT 'Primary phone for matching',
    `privacy_opt_out` BOOLEAN COMMENT 'Privacy opt-out flag',
    `record_audit_created` TIMESTAMP COMMENT 'Record creation timestamp',
    `record_audit_updated` TIMESTAMP COMMENT 'Record update timestamp',
    `segment` STRING COMMENT 'Guest segment',
    `source_record_reference` STRING COMMENT 'The source record reference attribute value for this identity resolution record in the guest domain',
    `source_system_timestamp` TIMESTAMP COMMENT 'The source system timestamp attribute value for this identity resolution record in the guest domain',
    `state` STRING COMMENT 'State for matching',
    `total_lifetime_spend` DECIMAL(18,2) COMMENT 'The total lifetime spend attribute value for this identity resolution record in the guest domain',
    CONSTRAINT pk_identity_resolution PRIMARY KEY(`identity_resolution_id`)
) COMMENT 'Identity resolution records for matching and merging guest profiles across systems';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`address` (
    `address_id` BIGINT COMMENT 'Primary key',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `address_profile_id` BIGINT COMMENT 'Profile link',
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
    `loyalty_tier` STRING COMMENT 'The loyalty tier attribute value for this preference record in the guest domain',
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
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `consent_policy_id` BIGINT COMMENT 'Consent policy link',
    `consent_profile_id` BIGINT COMMENT 'Profile link',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`guest_segment` (
    `guest_segment_id` BIGINT COMMENT 'Primary key',
    `loyalty_segment_id` BIGINT COMMENT 'Linked loyalty segment',
    `avg_check_amount` DECIMAL(18,2) COMMENT 'Average check amount',
    `avg_lifetime_value` DECIMAL(18,2) COMMENT 'Average lifetime value',
    `avg_visit_frequency` DECIMAL(18,2) COMMENT 'Average visit frequency',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'The churn risk score attribute value for this guest segment record in the guest domain',
    `created_at` TIMESTAMP COMMENT 'Created at timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this guest segment record in the guest domain',
    `criteria_definition` STRING COMMENT 'The criteria definition attribute value for this guest segment record in the guest domain',
    `definition_rule` STRING COMMENT 'The definition rule attribute value for this guest segment record in the guest domain',
    `guest_segment_description` STRING COMMENT 'The guest segment description attribute value for this guest segment record in the guest domain',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this guest segment',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this guest segment',
    `effective_until` DATE COMMENT 'Effective until date',
    `estimated_member_count` STRING COMMENT 'The count or quantity of estimated member items in this guest segment',
    `is_active` BOOLEAN COMMENT 'Is segment active',
    `is_dynamic` BOOLEAN COMMENT 'Is dynamically updated',
    `last_refreshed_timestamp` TIMESTAMP COMMENT 'Last refresh timestamp',
    `member_count` STRING COMMENT 'Current member count',
    `owner` STRING COMMENT 'The owner attribute value for this guest segment record in the guest domain',
    `owner_team` STRING COMMENT 'The owner team attribute value for this guest segment record in the guest domain',
    `priority_rank` STRING COMMENT 'The priority rank attribute value for this guest segment record in the guest domain',
    `refresh_frequency` STRING COMMENT 'The refresh frequency attribute value for this guest segment record in the guest domain',
    `segment_category` STRING COMMENT 'The segment category attribute value for this guest segment record in the guest domain',
    `segment_code` STRING COMMENT 'A standardized code representing the segment classification for this guest segment',
    `segment_description` STRING COMMENT 'The segment description attribute value for this guest segment record in the guest domain',
    `segment_name` STRING COMMENT 'The display name or label for the segment in this guest segment',
    `segment_type` STRING COMMENT 'The classification type for segment in this guest segment',
    `segmentation_method` STRING COMMENT 'The segmentation method attribute value for this guest segment record in the guest domain',
    `source_system_code` STRING COMMENT 'A standardized code representing the source system classification for this guest segment',
    `guest_segment_status` STRING COMMENT 'The current status of the guest segment for this guest segment',
    `target_channel` STRING COMMENT 'The target channel attribute value for this guest segment record in the guest domain',
    `updated_at` TIMESTAMP COMMENT 'Updated at timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this guest segment record in the guest domain',
    `created_by` STRING COMMENT 'Created by user',
    CONSTRAINT pk_guest_segment PRIMARY KEY(`guest_segment_id`)
) COMMENT 'Guest segments for targeted marketing and personalization';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` (
    `guest_segment_membership_id` BIGINT COMMENT 'Primary key',
    `guest_segment_id` BIGINT COMMENT 'Segment link',
    `primary_guest_profile_id` BIGINT COMMENT 'Guest profile link',
    `profile_id` BIGINT COMMENT 'Profile link',
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
    CONSTRAINT pk_guest_segment_membership PRIMARY KEY(`guest_segment_membership_id`)
) COMMENT 'Guest membership in segments with assignment details and scores';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`household` (
    `household_id` BIGINT COMMENT 'Primary key',
    `address_id` BIGINT COMMENT 'Address link',
    `member_id` BIGINT COMMENT 'Primary member link',
    `profile_id` BIGINT COMMENT 'Profile link',
    `address_verification_date` DATE COMMENT 'The date and time when the address verification event occurred for this household',
    `address_verified` BOOLEAN COMMENT 'Address verified flag',
    `average_check_value` DECIMAL(18,2) COMMENT 'The average check value attribute value for this household record in the guest domain',
    `average_transaction_count` STRING COMMENT 'The count or quantity of average transaction items in this household',
    `consent_privacy` BOOLEAN COMMENT 'Privacy consent',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this household record in the guest domain',
    `dissolution_date` DATE COMMENT 'The date and time when the dissolution event occurred for this household',
    `estimated_income_band` STRING COMMENT 'The estimated income band attribute value for this household record in the guest domain',
    `formation_date` DATE COMMENT 'The date and time when the formation event occurred for this household',
    `household_status` STRING COMMENT 'The current status of the household for this household',
    `household_type` STRING COMMENT 'The classification type for household in this household',
    `last_transaction_date` DATE COMMENT 'The date and time when the last transaction event occurred for this household',
    `last_update_timestamp` TIMESTAMP COMMENT 'The last update timestamp attribute value for this household record in the guest domain',
    `loyalty_enrolled` BOOLEAN COMMENT 'Loyalty enrolled flag',
    `loyalty_tier` STRING COMMENT 'The loyalty tier attribute value for this household record in the guest domain',
    `marketing_opt_in` BOOLEAN COMMENT 'Marketing opt-in',
    `household_name` STRING COMMENT 'The display name or label for the household in this household',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this household',
    `preferred_channel` STRING COMMENT 'The preferred channel attribute value for this household record in the guest domain',
    `primary_contact_method` STRING COMMENT 'The primary contact method attribute value for this household record in the guest domain',
    `primary_email` STRING COMMENT 'The primary email attribute value for this household record in the guest domain',
    `primary_phone` STRING COMMENT 'The primary phone attribute value for this household record in the guest domain',
    `segment` STRING COMMENT 'The segment attribute value for this household record in the guest domain',
    `size` STRING COMMENT 'Household size',
    `total_spend` DECIMAL(18,2) COMMENT 'The total spend attribute value for this household record in the guest domain',
    `total_transactions` DECIMAL(18,2) COMMENT 'The total transactions attribute value for this household record in the guest domain',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Household groupings of guest profiles for family marketing';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`household_member` (
    `household_member_id` BIGINT COMMENT 'Primary key',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `household_id` BIGINT COMMENT 'Household link',
    `household_profile_id` BIGINT COMMENT 'Profile link',
    `birthdate` DATE COMMENT 'The birthdate attribute value for this household member record in the guest domain',
    `consent_opt_in` BOOLEAN COMMENT 'Consent opt-in',
    `consent_opt_in_timestamp` TIMESTAMP COMMENT 'Consent timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this household member record in the guest domain',
    `departure_date` DATE COMMENT 'The date and time when the departure event occurred for this household member',
    `gender` STRING COMMENT 'The gender attribute value for this household member record in the guest domain',
    `is_primary_loyalty_holder` BOOLEAN COMMENT 'Boolean indicator flag for is primary loyalty holder status in this household member',
    `join_date` DATE COMMENT 'The date and time when the join event occurred for this household member',
    `loyalty_points_balance` DECIMAL(18,2) COMMENT 'The loyalty points balance attribute value for this household member record in the guest domain',
    `loyalty_tier` STRING COMMENT 'The loyalty tier attribute value for this household member record in the guest domain',
    `member_status` STRING COMMENT 'The current status of the member for this household member',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this household member',
    `relationship_type` STRING COMMENT 'The classification type for relationship in this household member',
    `role` STRING COMMENT 'Role in household',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this household member record in the guest domain',
    CONSTRAINT pk_household_member PRIMARY KEY(`household_member_id`)
) COMMENT 'Individual members within a household';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` (
    `lifetime_value_id` BIGINT COMMENT 'Primary key',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `lifetime_profile_id` BIGINT COMMENT 'Profile link',
    `average_check_value` DECIMAL(18,2) COMMENT 'The average check value attribute value for this lifetime value record in the guest domain',
    `average_transactions_per_month` DECIMAL(18,2) COMMENT 'The average transactions per month attribute value for this lifetime value record in the guest domain',
    `consent_opt_in` BOOLEAN COMMENT 'Consent opt-in',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this lifetime value record in the guest domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this lifetime value',
    `data_refresh_cycle` STRING COMMENT 'The data refresh cycle attribute value for this lifetime value record in the guest domain',
    `days_since_last_visit` STRING COMMENT 'The days since last visit attribute value for this lifetime value record in the guest domain',
    `first_visit_date` DATE COMMENT 'The date and time when the first visit event occurred for this lifetime value',
    `loyalty_member_flag` BOOLEAN COMMENT 'Is loyalty member',
    `ltv_calculation_date` DATE COMMENT 'The date and time when the ltv calculation event occurred for this lifetime value',
    `ltv_last_updated` TIMESTAMP COMMENT 'The ltv last updated attribute value for this lifetime value record in the guest domain',
    `ltv_status` STRING COMMENT 'The current status of the ltv for this lifetime value',
    `ltv_tier` STRING COMMENT 'The ltv tier attribute value for this lifetime value record in the guest domain',
    `most_recent_visit_date` DATE COMMENT 'The date and time when the most recent visit event occurred for this lifetime value',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this lifetime value',
    `predicted_future_value` DECIMAL(18,2) COMMENT 'The predicted future value attribute value for this lifetime value record in the guest domain',
    `segment` STRING COMMENT 'The segment attribute value for this lifetime value record in the guest domain',
    `total_historical_spend` DECIMAL(18,2) COMMENT 'The total historical spend attribute value for this lifetime value record in the guest domain',
    `total_visits` STRING COMMENT 'The total visits attribute value for this lifetime value record in the guest domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this lifetime value record in the guest domain',
    CONSTRAINT pk_lifetime_value PRIMARY KEY(`lifetime_value_id`)
) COMMENT 'Guest lifetime value calculations and predictions';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` (
    `satisfaction_survey_id` BIGINT COMMENT 'Primary key',
    `franchisee_id` BIGINT COMMENT 'Franchisee link',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `satisfaction_profile_id` BIGINT COMMENT 'Profile link',
    `unit_id` BIGINT COMMENT 'Unique identifier for the satisfaction unit associated with this satisfaction survey',
    `employee_id` BIGINT COMMENT 'Server employee link',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`survey_response` (
    `survey_response_id` BIGINT COMMENT 'Primary key',
    `satisfaction_survey_id` BIGINT COMMENT 'Survey link',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `survey_profile_id` BIGINT COMMENT 'Profile link',
    `survey_question_id` BIGINT COMMENT 'Question link',
    `unit_id` BIGINT COMMENT 'Unique identifier for the survey unit associated with this survey response',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this survey response record in the guest domain',
    `device_code` STRING COMMENT 'A standardized code representing the device classification for this survey response',
    `ip_address` STRING COMMENT 'The ip address attribute value for this survey response record in the guest domain',
    `is_anonymous` BOOLEAN COMMENT 'Boolean indicator flag for is anonymous status in this survey response',
    `is_test_response` BOOLEAN COMMENT 'Boolean indicator flag for is test response status in this survey response',
    `open_text` STRING COMMENT 'Open text response',
    `rating_scale_max` STRING COMMENT 'The rating scale max attribute value for this survey response record in the guest domain',
    `rating_score` DECIMAL(18,2) COMMENT 'The rating score attribute value for this survey response record in the guest domain',
    `response_channel` STRING COMMENT 'The response channel attribute value for this survey response record in the guest domain',
    `response_language` STRING COMMENT 'The response language attribute value for this survey response record in the guest domain',
    `response_sequence` STRING COMMENT 'The response sequence attribute value for this survey response record in the guest domain',
    `response_status` STRING COMMENT 'The current status of the response for this survey response',
    `response_timestamp` TIMESTAMP COMMENT 'The response timestamp attribute value for this survey response record in the guest domain',
    `response_type` STRING COMMENT 'The classification type for response in this survey response',
    `response_value` DECIMAL(18,2) COMMENT 'The response value attribute value for this survey response record in the guest domain',
    `selected_option` STRING COMMENT 'The selected option attribute value for this survey response record in the guest domain',
    `sentiment_label` STRING COMMENT 'The sentiment label attribute value for this survey response record in the guest domain',
    `sentiment_score` DECIMAL(18,2) COMMENT 'The sentiment score attribute value for this survey response record in the guest domain',
    `survey_version` STRING COMMENT 'The survey version attribute value for this survey response record in the guest domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this survey response record in the guest domain',
    CONSTRAINT pk_survey_response PRIMARY KEY(`survey_response_id`)
) COMMENT 'Individual responses to survey questions';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`complaint` (
    `complaint_id` BIGINT COMMENT 'Primary key',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `complaint_profile_id` BIGINT COMMENT 'Profile link',
    `unit_id` BIGINT COMMENT 'Restaurant unit link',
    `franchisee_id` BIGINT COMMENT 'Franchisee link',
    `guest_order_id` BIGINT COMMENT 'Order link',
    `employee_id` BIGINT COMMENT 'Handling employee link',
    `ingredient_id` BIGINT COMMENT 'Ingredient link',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier link',
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
    `campaign_id` BIGINT COMMENT 'Campaign link',
    `employee_id` BIGINT COMMENT 'Employee link',
    `franchisee_id` BIGINT COMMENT 'Franchisee link',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `interaction_profile_id` BIGINT COMMENT 'Profile link',
    `unit_id` BIGINT COMMENT 'Restaurant unit link',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` (
    `channel_identity_id` BIGINT COMMENT 'Primary key',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `channel_profile_id` BIGINT COMMENT 'Profile link',
    `channel_identity_status` STRING COMMENT 'Identity status',
    `channel_name` STRING COMMENT 'The display name or label for the channel in this channel identity',
    `channel_user_email` STRING COMMENT 'The channel user email attribute value for this channel identity record in the guest domain',
    `channel_user_name` STRING COMMENT 'The display name or label for the channel user in this channel identity',
    `channel_user_phone` STRING COMMENT 'The channel user phone attribute value for this channel identity record in the guest domain',
    `consent_opt_in` BOOLEAN COMMENT 'Consent opt-in',
    `created_by_system` STRING COMMENT 'The created by system attribute value for this channel identity record in the guest domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this channel identity record in the guest domain',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `external_identifier` STRING COMMENT 'The external identifier attribute value for this channel identity record in the guest domain',
    `identifier_type` STRING COMMENT 'The classification type for identifier in this channel identity',
    `is_active` BOOLEAN COMMENT 'Boolean indicator flag for is active status in this channel identity',
    `is_primary` BOOLEAN COMMENT 'Is primary identity',
    `is_test_account` BOOLEAN COMMENT 'Boolean indicator flag for is test account status in this channel identity',
    `last_updated_by_system` STRING COMMENT 'The last updated by system attribute value for this channel identity record in the guest domain',
    `last_verified_timestamp` TIMESTAMP COMMENT 'The last verified timestamp attribute value for this channel identity record in the guest domain',
    `loyalty_tier` STRING COMMENT 'The loyalty tier attribute value for this channel identity record in the guest domain',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this channel identity',
    `privacy_status` STRING COMMENT 'The current status of the privacy for this channel identity',
    `record_status` STRING COMMENT 'The current status of the record for this channel identity',
    `record_version` STRING COMMENT 'The record version attribute value for this channel identity record in the guest domain',
    `source_system_created_timestamp` TIMESTAMP COMMENT 'The source system created timestamp attribute value for this channel identity record in the guest domain',
    `source_system_updated_timestamp` TIMESTAMP COMMENT 'The source system updated timestamp attribute value for this channel identity record in the guest domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this channel identity record in the guest domain',
    `verification_method` STRING COMMENT 'The verification method attribute value for this channel identity record in the guest domain',
    CONSTRAINT pk_channel_identity PRIMARY KEY(`channel_identity_id`)
) COMMENT 'Guest identities across different channels and platforms';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`communication` (
    `communication_id` BIGINT COMMENT 'Primary key',
    `campaign_id` BIGINT COMMENT 'Campaign link',
    `consent_record_id` BIGINT COMMENT 'Consent record link',
    `communication_consent_record_id` BIGINT COMMENT 'Consent record link',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `communication_profile_id` BIGINT COMMENT 'Profile link',
    `content_template_id` BIGINT COMMENT 'Content template link',
    `unit_id` BIGINT COMMENT 'Unique identifier for the unit associated with this communication',
    `channel` STRING COMMENT 'Communication channel',
    `click_status` STRING COMMENT 'The current status of the click for this communication',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this communication record in the guest domain',
    `delivery_status` STRING COMMENT 'The current status of the delivery for this communication',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp attribute value for this communication record in the guest domain',
    `language_code` STRING COMMENT 'A standardized code representing the language classification for this communication',
    `message_body_preview` STRING COMMENT 'The message body preview attribute value for this communication record in the guest domain',
    `open_status` STRING COMMENT 'The current status of the open for this communication',
    `priority` STRING COMMENT 'The priority attribute value for this communication record in the guest domain',
    `recipient_email` STRING COMMENT 'The recipient email attribute value for this communication record in the guest domain',
    `recipient_phone` STRING COMMENT 'The recipient phone attribute value for this communication record in the guest domain',
    `scheduled_send_timestamp` TIMESTAMP COMMENT 'The scheduled send timestamp attribute value for this communication record in the guest domain',
    `send_attempt_count` STRING COMMENT 'The count or quantity of send attempt items in this communication',
    `subject` STRING COMMENT 'The subject attribute value for this communication record in the guest domain',
    `suppression_flag` BOOLEAN COMMENT 'Boolean indicator flag for suppression flag status in this communication',
    `tracking_url` STRING COMMENT 'The URL link to the tracking resource associated with this communication',
    `trigger_source` STRING COMMENT 'The trigger source attribute value for this communication record in the guest domain',
    `unsubscribe_flag` BOOLEAN COMMENT 'Boolean indicator flag for unsubscribe flag status in this communication',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this communication record in the guest domain',
    CONSTRAINT pk_communication PRIMARY KEY(`communication_id`)
) COMMENT 'Communications sent to guests across channels';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`demographic` (
    `demographic_id` BIGINT COMMENT 'Primary key',
    `profile_id` BIGINT COMMENT 'Guest profile link',
    `demographic_profile_id` BIGINT COMMENT 'Profile link',
    `age_band` STRING COMMENT 'The age band attribute value for this demographic record in the guest domain',
    `consent_opt_in` BOOLEAN COMMENT 'Consent opt-in',
    `consent_opt_out` BOOLEAN COMMENT 'Consent opt-out',
    `data_source` STRING COMMENT 'The data source attribute value for this demographic record in the guest domain',
    `demographic_type` STRING COMMENT 'The classification type for demographic in this demographic',
    `education_level` STRING COMMENT 'The education level attribute value for this demographic record in the guest domain',
    `email_address` STRING COMMENT 'The email address attribute value for this demographic record in the guest domain',
    `employment_status` STRING COMMENT 'The current status of the employment for this demographic',
    `enrichment_date` DATE COMMENT 'The date and time when the enrichment event occurred for this demographic',
    `enrichment_provider` STRING COMMENT 'The enrichment provider attribute value for this demographic record in the guest domain',
    `ethnicity` STRING COMMENT 'The ethnicity attribute value for this demographic record in the guest domain',
    `ethnicity_source` STRING COMMENT 'The ethnicity source attribute value for this demographic record in the guest domain',
    `full_name` STRING COMMENT 'The display name or label for the full in this demographic',
    `gender_identity` STRING COMMENT 'The gender identity attribute value for this demographic record in the guest domain',
    `geographic_market` STRING COMMENT 'The geographic market attribute value for this demographic record in the guest domain',
    `household_income_band` STRING COMMENT 'The household income band attribute value for this demographic record in the guest domain',
    `language_preference` STRING COMMENT 'The language preference attribute value for this demographic record in the guest domain',
    `marital_status` STRING COMMENT 'The current status of the marital for this demographic',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this demographic',
    `number_of_children` STRING COMMENT 'The number of children attribute value for this demographic record in the guest domain',
    `phone_number` STRING COMMENT 'The phone number attribute value for this demographic record in the guest domain',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created attribute value for this demographic record in the guest domain',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated attribute value for this demographic record in the guest domain',
    `record_status` STRING COMMENT 'The current status of the record for this demographic',
    CONSTRAINT pk_demographic PRIMARY KEY(`demographic_id`)
) COMMENT 'Guest demographic information for segmentation and analytics';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` (
    `guest_visit_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Unique identifier referencing the employee associated with this guest visit record',
    `guest_order_id` BIGINT COMMENT 'Guest order link',
    `unit_id` BIGINT COMMENT 'Restaurant unit link',
    `guest_unit_id` BIGINT COMMENT 'Unique identifier for the guest unit associated with this guest visit',
    `host_employee_id` BIGINT COMMENT 'Host employee link',
    `primary_guest_profile_id` BIGINT COMMENT 'Guest profile link',
    `profile_id` BIGINT COMMENT 'Profile link',
    `channel` STRING COMMENT 'Visit channel',
    `check_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for check in this guest visit',
    `check_total` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for check in this guest visit',
    `created_at` TIMESTAMP COMMENT 'Created at timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this guest visit record in the guest domain',
    `daypart` STRING COMMENT 'The daypart segment (e.g., breakfast, lunch, dinner) applicable to this guest visit',
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
    `visit_amount` DECIMAL(18,2) COMMENT 'The monetary or numeric amount for visit in this guest visit',
    `visit_channel` STRING COMMENT 'The visit channel attribute value for this guest visit record in the guest domain',
    `visit_date` DATE COMMENT 'The date and time when the visit event occurred for this guest visit',
    `visit_duration_minutes` DECIMAL(18,2) COMMENT 'Visit duration in minutes',
    `visit_time` TIMESTAMP COMMENT 'The visit time attribute value for this guest visit record in the guest domain',
    `visit_timestamp` TIMESTAMP COMMENT 'The visit timestamp attribute value for this guest visit record in the guest domain',
    `visit_type` STRING COMMENT 'The classification type for visit in this guest visit',
    CONSTRAINT pk_guest_visit PRIMARY KEY(`guest_visit_id`)
) COMMENT 'Guest visit records with transaction and experience details';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` (
    `guest_allergen_profile_id` BIGINT COMMENT 'Primary key',
    `foodsafety_allergen_profile_id` BIGINT COMMENT 'Food safety allergen profile link',
    `ingredient_id` BIGINT COMMENT 'Ingredient link',
    `primary_guest_profile_id` BIGINT COMMENT 'Guest profile link',
    `profile_id` BIGINT COMMENT 'Profile link',
    `allergen_name` STRING COMMENT 'The display name or label for the allergen in this guest allergen profile',
    `allergen_type` STRING COMMENT 'The classification type for allergen in this guest allergen profile',
    `created_at` TIMESTAMP COMMENT 'Created at timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this guest allergen profile record in the guest domain',
    `diagnosed_date` DATE COMMENT 'The date and time when the diagnosed event occurred for this guest allergen profile',
    `diagnosis` STRING COMMENT 'The diagnosis attribute value for this guest allergen profile record in the guest domain',
    `effective_date` DATE COMMENT 'The date and time when the effective event occurred for this guest allergen profile',
    `is_active` BOOLEAN COMMENT 'Boolean indicator flag for is active status in this guest allergen profile',
    `is_life_threatening` BOOLEAN COMMENT 'Boolean indicator flag for is life threatening status in this guest allergen profile',
    `is_self_reported` BOOLEAN COMMENT 'Boolean indicator flag for is self reported status in this guest allergen profile',
    `is_verified` BOOLEAN COMMENT 'Boolean indicator flag for is verified status in this guest allergen profile',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this guest allergen profile',
    `reaction_description` STRING COMMENT 'The reaction description attribute value for this guest allergen profile record in the guest domain',
    `reaction_notes` STRING COMMENT 'The reaction notes attribute value for this guest allergen profile record in the guest domain',
    `reaction_type` STRING COMMENT 'The classification type for reaction in this guest allergen profile',
    `recorded_at` TIMESTAMP COMMENT 'Recorded at timestamp',
    `reported_at` TIMESTAMP COMMENT 'Reported at timestamp',
    `reported_date` DATE COMMENT 'The date and time when the reported event occurred for this guest allergen profile',
    `self_reported` BOOLEAN COMMENT 'The self reported attribute value for this guest allergen profile record in the guest domain',
    `self_reported_flag` BOOLEAN COMMENT 'Boolean indicator flag for self reported flag status in this guest allergen profile',
    `severity` STRING COMMENT 'The severity attribute value for this guest allergen profile record in the guest domain',
    `severity_level` STRING COMMENT 'The severity level attribute value for this guest allergen profile record in the guest domain',
    `source` STRING COMMENT 'The source attribute value for this guest allergen profile record in the guest domain',
    `updated_at` TIMESTAMP COMMENT 'Updated at timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this guest allergen profile record in the guest domain',
    `verified_at` TIMESTAMP COMMENT 'Verified at timestamp',
    `verified_by_guest` BOOLEAN COMMENT 'The verified by guest attribute value for this guest allergen profile record in the guest domain',
    `verified_date` DATE COMMENT 'The date and time when the verified event occurred for this guest allergen profile',
    `verified_flag` BOOLEAN COMMENT 'Boolean indicator flag for verified flag status in this guest allergen profile',
    CONSTRAINT pk_guest_allergen_profile PRIMARY KEY(`guest_allergen_profile_id`)
) COMMENT 'Guest allergen profiles for food safety and personalization';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`digital_account` (
    `digital_account_id` BIGINT COMMENT 'Primary key',
    `member_id` BIGINT COMMENT 'Member link',
    `profile_id` BIGINT COMMENT 'Profile link',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` (
    `consent_policy_id` BIGINT COMMENT 'Primary key',
    `superseded_consent_policy_id` BIGINT COMMENT 'Superseded policy link',
    `analytics_opt_in_allowed` BOOLEAN COMMENT 'Analytics opt-in allowed',
    `consent_channel` STRING COMMENT 'The consent channel attribute value for this consent policy record in the guest domain',
    `consent_expiry_date` DATE COMMENT 'The date and time when the consent expiry event occurred for this consent policy',
    `consent_mechanism` STRING COMMENT 'The consent mechanism attribute value for this consent policy record in the guest domain',
    `consent_revocation_timestamp` TIMESTAMP COMMENT 'The consent revocation timestamp attribute value for this consent policy record in the guest domain',
    `consent_source` STRING COMMENT 'The consent source attribute value for this consent policy record in the guest domain',
    `consent_status` STRING COMMENT 'The current status of the consent for this consent policy',
    `data_processing_purpose` STRING COMMENT 'The data processing purpose attribute value for this consent policy record in the guest domain',
    `data_retention_period_days` STRING COMMENT 'Data retention period in days',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `jurisdiction` STRING COMMENT 'The jurisdiction attribute value for this consent policy record in the guest domain',
    `legal_basis` STRING COMMENT 'The legal basis attribute value for this consent policy record in the guest domain',
    `marketing_opt_in_allowed` BOOLEAN COMMENT 'Marketing opt-in allowed',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this consent policy',
    `policy_category` STRING COMMENT 'The policy category attribute value for this consent policy record in the guest domain',
    `policy_description` STRING COMMENT 'The policy description attribute value for this consent policy record in the guest domain',
    `policy_name` STRING COMMENT 'The display name or label for the policy in this consent policy',
    `policy_type` STRING COMMENT 'The classification type for policy in this consent policy',
    `privacy_law` STRING COMMENT 'The privacy law attribute value for this consent policy record in the guest domain',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created attribute value for this consent policy record in the guest domain',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated attribute value for this consent policy record in the guest domain',
    `consent_policy_status` STRING COMMENT 'The current status of the consent policy for this consent policy',
    `third_party_sharing_allowed` BOOLEAN COMMENT 'The third party sharing allowed attribute value for this consent policy record in the guest domain',
    `version_number` STRING COMMENT 'The version number attribute value for this consent policy record in the guest domain',
    CONSTRAINT pk_consent_policy PRIMARY KEY(`consent_policy_id`)
) COMMENT 'Consent policies defining data processing rules and permissions';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`survey_question` (
    `survey_question_id` BIGINT COMMENT 'Primary key',
    `parent_survey_question_id` BIGINT COMMENT 'Parent question link',
    `survey_question_category` STRING COMMENT 'Question category',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this survey question record in the guest domain',
    `display_order` STRING COMMENT 'The display order attribute value for this survey question record in the guest domain',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `is_anonymous` BOOLEAN COMMENT 'Boolean indicator flag for is anonymous status in this survey question',
    `is_required` BOOLEAN COMMENT 'Boolean indicator flag for is required status in this survey question',
    `language` STRING COMMENT 'The language attribute value for this survey question record in the guest domain',
    `max_response_length` STRING COMMENT 'The max response length attribute value for this survey question record in the guest domain',
    `question_text` STRING COMMENT 'The question text attribute value for this survey question record in the guest domain',
    `question_type` STRING COMMENT 'The classification type for question in this survey question',
    `response_options` STRING COMMENT 'The response options attribute value for this survey question record in the guest domain',
    `response_scale` STRING COMMENT 'The response scale attribute value for this survey question record in the guest domain',
    `survey_question_status` STRING COMMENT 'The current status of the survey question for this survey question',
    `subcategory` STRING COMMENT 'The subcategory attribute value for this survey question record in the guest domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this survey question record in the guest domain',
    `version` STRING COMMENT 'The version attribute value for this survey question record in the guest domain',
    CONSTRAINT pk_survey_question PRIMARY KEY(`survey_question_id`)
) COMMENT 'Survey questions for guest feedback collection';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` (
    `corporate_account_id` DECIMAL(18,2) COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Account manager employee link',
    `parent_corporate_account_id` DECIMAL(18,2) COMMENT 'Parent account link',
    `account_name` STRING COMMENT 'The display name or label for the account in this corporate account',
    `account_number` STRING COMMENT 'The account number attribute value for this corporate account record in the guest domain',
    `account_type` STRING COMMENT 'The classification type for account in this corporate account',
    `address_line1` STRING COMMENT 'Address line 1',
    `address_line2` STRING COMMENT 'Address line 2',
    `annual_spend_estimate` DECIMAL(18,2) COMMENT 'The annual spend estimate attribute value for this corporate account record in the guest domain',
    `billing_address_line1` STRING COMMENT 'Billing address line 1',
    `billing_city` STRING COMMENT 'The billing city attribute value for this corporate account record in the guest domain',
    `billing_country` STRING COMMENT 'The billing country attribute value for this corporate account record in the guest domain',
    `billing_postal_code` STRING COMMENT 'A standardized code representing the billing postal classification for this corporate account',
    `billing_state` STRING COMMENT 'The billing state attribute value for this corporate account record in the guest domain',
    `city` STRING COMMENT 'The city attribute value for this corporate account record in the guest domain',
    `consent_opt_in` BOOLEAN COMMENT 'Consent opt-in',
    `contact_email` STRING COMMENT 'The contact email attribute value for this corporate account record in the guest domain',
    `contact_name` STRING COMMENT 'The display name or label for the contact in this corporate account',
    `contact_phone` STRING COMMENT 'The contact phone attribute value for this corporate account record in the guest domain',
    `country` STRING COMMENT 'The country attribute value for this corporate account record in the guest domain',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute value for this corporate account record in the guest domain',
    `credit_limit` DECIMAL(18,2) COMMENT 'The credit limit attribute value for this corporate account record in the guest domain',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification for this corporate account',
    `effective_end_date` DATE COMMENT 'The date and time when the effective end event occurred for this corporate account',
    `effective_start_date` DATE COMMENT 'The date and time when the effective start event occurred for this corporate account',
    `industry_code` STRING COMMENT 'A standardized code representing the industry classification for this corporate account',
    `last_activity_timestamp` TIMESTAMP COMMENT 'The last activity timestamp attribute value for this corporate account record in the guest domain',
    `loyalty_program_enrolled` BOOLEAN COMMENT 'The loyalty program enrolled attribute value for this corporate account record in the guest domain',
    `marketing_opt_in` BOOLEAN COMMENT 'Marketing opt-in',
    `notes` STRING COMMENT 'Free-text notes field providing additional context for this corporate account',
    `number_of_locations` STRING COMMENT 'The number of locations attribute value for this corporate account record in the guest domain',
    `parent_company_name` STRING COMMENT 'The display name or label for the parent company in this corporate account',
    `payment_terms` STRING COMMENT 'The payment terms attribute value for this corporate account record in the guest domain',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification for this corporate account',
    `shipping_address_line1` STRING COMMENT 'Shipping address line 1',
    `shipping_city` STRING COMMENT 'The shipping city attribute value for this corporate account record in the guest domain',
    `shipping_country` STRING COMMENT 'The shipping country attribute value for this corporate account record in the guest domain',
    `shipping_postal_code` STRING COMMENT 'A standardized code representing the shipping postal classification for this corporate account',
    `shipping_state` STRING COMMENT 'The shipping state attribute value for this corporate account record in the guest domain',
    `state` STRING COMMENT 'The state attribute value for this corporate account record in the guest domain',
    `corporate_account_status` STRING COMMENT 'The current status of the corporate account for this corporate account',
    `tax_identifier` STRING COMMENT 'The tax identifier attribute value for this corporate account record in the guest domain',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute value for this corporate account record in the guest domain',
    CONSTRAINT pk_corporate_account PRIMARY KEY(`corporate_account_id`)
) COMMENT 'Corporate accounts for business guests and catering';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ADD CONSTRAINT `fk_guest_identity_resolution_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ADD CONSTRAINT `fk_guest_identity_resolution_identity_profile_id` FOREIGN KEY (`identity_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_address_profile_id` FOREIGN KEY (`address_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_owner_profile_id` FOREIGN KEY (`owner_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_preference_profile_id` FOREIGN KEY (`preference_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_consent_policy_id` FOREIGN KEY (`consent_policy_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_consent_profile_id` FOREIGN KEY (`consent_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` ADD CONSTRAINT `fk_guest_guest_segment_membership_guest_segment_id` FOREIGN KEY (`guest_segment_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`guest_segment`(`guest_segment_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` ADD CONSTRAINT `fk_guest_guest_segment_membership_primary_guest_profile_id` FOREIGN KEY (`primary_guest_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` ADD CONSTRAINT `fk_guest_guest_segment_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ADD CONSTRAINT `fk_guest_household_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`address`(`address_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ADD CONSTRAINT `fk_guest_household_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ADD CONSTRAINT `fk_guest_household_member_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ADD CONSTRAINT `fk_guest_household_member_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`household`(`household_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ADD CONSTRAINT `fk_guest_household_member_household_profile_id` FOREIGN KEY (`household_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ADD CONSTRAINT `fk_guest_lifetime_value_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ADD CONSTRAINT `fk_guest_lifetime_value_lifetime_profile_id` FOREIGN KEY (`lifetime_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_satisfaction_profile_id` FOREIGN KEY (`satisfaction_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ADD CONSTRAINT `fk_guest_survey_response_satisfaction_survey_id` FOREIGN KEY (`satisfaction_survey_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`satisfaction_survey`(`satisfaction_survey_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ADD CONSTRAINT `fk_guest_survey_response_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ADD CONSTRAINT `fk_guest_survey_response_survey_profile_id` FOREIGN KEY (`survey_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ADD CONSTRAINT `fk_guest_survey_response_survey_question_id` FOREIGN KEY (`survey_question_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`survey_question`(`survey_question_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_complaint_profile_id` FOREIGN KEY (`complaint_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_interaction_profile_id` FOREIGN KEY (`interaction_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ADD CONSTRAINT `fk_guest_channel_identity_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ADD CONSTRAINT `fk_guest_channel_identity_channel_profile_id` FOREIGN KEY (`channel_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` ADD CONSTRAINT `fk_guest_communication_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` ADD CONSTRAINT `fk_guest_communication_communication_consent_record_id` FOREIGN KEY (`communication_consent_record_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` ADD CONSTRAINT `fk_guest_communication_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` ADD CONSTRAINT `fk_guest_communication_communication_profile_id` FOREIGN KEY (`communication_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ADD CONSTRAINT `fk_guest_demographic_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ADD CONSTRAINT `fk_guest_demographic_demographic_profile_id` FOREIGN KEY (`demographic_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ADD CONSTRAINT `fk_guest_guest_visit_primary_guest_profile_id` FOREIGN KEY (`primary_guest_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ADD CONSTRAINT `fk_guest_guest_visit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ADD CONSTRAINT `fk_guest_guest_allergen_profile_primary_guest_profile_id` FOREIGN KEY (`primary_guest_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ADD CONSTRAINT `fk_guest_guest_allergen_profile_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ADD CONSTRAINT `fk_guest_digital_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ADD CONSTRAINT `fk_guest_consent_policy_superseded_consent_policy_id` FOREIGN KEY (`superseded_consent_policy_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ADD CONSTRAINT `fk_guest_survey_question_parent_survey_question_id` FOREIGN KEY (`parent_survey_question_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`survey_question`(`survey_question_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_parent_corporate_account_id` FOREIGN KEY (`parent_corporate_account_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`corporate_account`(`corporate_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`guest` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`guest` SET TAGS ('dbx_domain' = 'guest');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `location_profile_id` SET TAGS ('dbx_pii_detected' = 'true');
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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `country` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `gender` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `primary_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `primary_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_profile_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_profile_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` SET TAGS ('dbx_subdomain' = 'engagement_insights');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_dairy_allergy` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_gluten_allergy` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_nut_allergy` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` SET TAGS ('dbx_subdomain' = 'engagement_insights');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment` SET TAGS ('dbx_subdomain' = 'engagement_insights');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment` SET TAGS ('dbx_ssot_canonical' = 'loyalty.loyalty_segment');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` SET TAGS ('dbx_subdomain' = 'engagement_insights');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` SET TAGS ('dbx_ssot_canonical' = 'loyalty.loyalty_segment_membership');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verification_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verified` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `estimated_income_band` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `birthdate` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `gender` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` SET TAGS ('dbx_subdomain' = 'engagement_insights');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` SET TAGS ('dbx_subdomain' = 'feedback_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` SET TAGS ('dbx_subdomain' = 'feedback_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `ip_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` SET TAGS ('dbx_subdomain' = 'feedback_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` SET TAGS ('dbx_subdomain' = 'feedback_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` SET TAGS ('dbx_subdomain' = 'feedback_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`communication` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `age_band` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity_source` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity_source` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity_source` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `gender_identity` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `household_income_band` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` SET TAGS ('dbx_subdomain' = 'feedback_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` SET TAGS ('dbx_ssot_deprecated' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` SET TAGS ('dbx_ssot_canonical' = 'loyalty.loyalty_visit');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ALTER COLUMN `host_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ALTER COLUMN `host_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` SET TAGS ('dbx_subdomain' = 'engagement_insights');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` SET TAGS ('dbx_ssot_canonical' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` SET TAGS ('dbx_ssot_deprecated_duplicate' = 'foodsafety.foodsafety_allergen_profile');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ALTER COLUMN `allergen_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ALTER COLUMN `diagnosis` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ALTER COLUMN `diagnosis` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ALTER COLUMN `diagnosis` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` SET TAGS ('dbx_subdomain' = 'engagement_insights');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` SET TAGS ('dbx_subdomain' = 'feedback_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_country` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `country` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_city` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_country` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `state` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
