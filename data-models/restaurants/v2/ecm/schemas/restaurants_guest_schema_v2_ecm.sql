-- Schema for Domain: guest | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:40

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`guest` COMMENT 'Single source of truth for customer identity, profiles, preferences, demographics, segments, loyalty membership, and guest engagement across all channels (dine-in, drive-thru, online ordering). Manages CSAT, NPS, lifetime value, and consent/privacy management. Master record for WHO the business serves.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique surrogate key for the guest profile record.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Direct‑debit setup for recurring meal subscriptions links guest profile to finance bank_account for payment processing.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: Corporate accounts are a B2B guest entity; linking profile to corporate_account enables reporting of corporate guest activity and eliminates the isolated corporate_account table.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Corporate guest expense allocation requires linking profile to finance cost_center for accurate cost accounting reports.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee‑level loyalty aggregation report needs each guest linked to the franchisee that owns their primary restaurant.',
    `location_profile_id` BIGINT COMMENT 'Identifier of the location the guest most frequently visits.',
    `program_id` BIGINT COMMENT 'Identifier of the loyalty program membership associated with the guest.',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Required for personalized marketing: the last ordered menu item is used to drive targeted offers and recommendation engines, a standard practice in restaurant loyalty programs.',
    `unit_id` BIGINT COMMENT 'Identifier of the specific store the guest prefers.',
    `profile_unit_id` BIGINT COMMENT 'Identifier of the specific store the guest prefers.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Assigning guest to a profit_center enables revenue attribution in multi‑brand restaurant profit reporting.',
    `address_line1` STRING COMMENT 'First line of the guests street address.',
    `address_line2` STRING COMMENT 'Second line of the guests street address (apartment, suite, etc.).',
    `average_check_value` DECIMAL(18,2) COMMENT 'Average monetary value per transaction for the guest.',
    `birthday_day` STRING COMMENT 'Day of month (1‑31) of the guests birth date.',
    `birthday_month` STRING COMMENT 'Numeric month (1‑12) of the guests birth date, used for birthday promotions.',
    `city` STRING COMMENT 'City component of the guests mailing address.',
    `consent_email` BOOLEAN COMMENT 'Guests consent to receive marketing emails.',
    `consent_privacy` BOOLEAN COMMENT 'Indicates whether the guest has consented to privacy policy and data processing.',
    `consent_sms` BOOLEAN COMMENT 'Guests consent to receive marketing SMS messages.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the guests residence. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|JPN|CHN|IND|BRA — 10 candidates stripped; promote to reference product]',
    `data_source` STRING COMMENT 'System of record that supplied the guest data.. Valid values are `salesforce|olo|micros|other`',
    `data_source_code` STRING COMMENT 'Original identifier of the guest in the source system.',
    `date_of_birth` DATE COMMENT 'Guests birth date for age verification and personalization.',
    `email_address` STRING COMMENT 'Primary email used for electronic communication and marketing.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `first_name` STRING COMMENT 'Given name of the guest.',
    `full_name` STRING COMMENT 'Complete legal name of the guest as stored in the master record.',
    `gender` STRING COMMENT 'Self‑declared gender of the guest for demographic analysis.. Valid values are `male|female|non_binary|prefer_not_to_say`',
    `guest_type` STRING COMMENT 'Classification of the guest based on relationship to the business.. Valid values are `guest|employee|vendor|franchisee|loyalty_member`',
    `last_name` STRING COMMENT 'Family name of the guest.',
    `last_visit_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent guest interaction.',
    `loyalty_tier` STRING COMMENT 'Current tier level of the guest within the loyalty program.. Valid values are `bronze|silver|gold|platinum`',
    `marketing_opt_in` BOOLEAN COMMENT 'Overall opt‑in flag for marketing communications across all channels.',
    `marketing_source` STRING COMMENT 'Origin channel through which the guest was first acquired.. Valid values are `in_store|online|app|third_party`',
    `notes` STRING COMMENT 'Unstructured notes entered by staff about the guest.',
    `phone_number` STRING COMMENT 'Main telephone number for SMS, voice contact, and verification.. Valid values are `^+?[0-9]{7,15}$`',
    `picture_url` STRING COMMENT 'Link to the guests profile image stored in the digital asset system.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the guests mailing address.',
    `preferred_language` STRING COMMENT 'Language the guest prefers for communications. [ENUM-REF-CANDIDATE: en|es|fr|de|zh|ja|pt — 7 candidates stripped; promote to reference product]',
    `primary_contact_method` STRING COMMENT 'Channel the guest most frequently uses for contact.. Valid values are `email|phone|sms|app_notification`',
    `profile_status` STRING COMMENT 'Current lifecycle status of the guest profile.. Valid values are `active|inactive|prospect|blocked|deceased`',
    `record_audit_created` TIMESTAMP COMMENT 'Date and time when the profile record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Date and time of the most recent modification to the profile.',
    `secondary_phone` STRING COMMENT 'Optional additional telephone number for the guest.. Valid values are `^+?[0-9]{7,15}$`',
    `state` STRING COMMENT 'State or province of the guests mailing address.',
    `total_lifetime_visits` STRING COMMENT 'Cumulative count of all visits (in‑store, drive‑thru, online) made by the guest.',
    `total_spent` DECIMAL(18,2) COMMENT 'Aggregate monetary amount the guest has spent across all transactions.',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Master record for every guest identity across all service channels (dine-in, drive-thru, OLO, 3PD). Single source of truth for WHO the business serves — captures full identity and demographic attributes including name, contact details, date of birth, language preference, age band, gender identity, household income band, education level, employment status, geographic market classification, demographic data source (self-declared vs. third-party enrichment), enrichment provider and date. Also owns digital account attributes: username, account status (active/suspended/deactivated), registration date, registration channel, last login timestamp, device type, app version, two-factor authentication status, and account tier. Sourced primarily from Salesforce CRM, Olo Digital Ordering Platform, and brand mobile app. This is the anchor entity for the entire guest domain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` (
    `identity_resolution_id` BIGINT COMMENT 'System‑generated unique identifier for each identity resolution event.',
    `profile_id` BIGINT COMMENT 'Identifier of the canonical guest profile that results from the resolution process.',
    `identity_profile_id` BIGINT COMMENT 'Identifier of the canonical guest profile that results from the resolution process.',
    `member_id` BIGINT COMMENT 'Unique identifier of the guest within the restaurant loyalty program.',
    `address_line1` STRING COMMENT 'Primary street address of the guest.',
    `city` STRING COMMENT 'City component of the guests address.',
    `consent_status` STRING COMMENT 'Guests current consent state for marketing communications (consented, revoked, pending).',
    `country` STRING COMMENT 'Three‑letter ISO country code of the guests residence.',
    `csat_score` STRING COMMENT 'Latest CSAT rating provided by the guest (0‑10).',
    `data_source_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score assigned to the source systems data quality for this record.',
    `date_of_birth` DATE COMMENT 'Guests birth date, used for age‑based offers and compliance.',
    `duplicate_flag` BOOLEAN COMMENT 'True if the source record was identified as a duplicate of an existing profile.',
    `full_name` STRING COMMENT 'Legal full name of the guest as provided in the source system.',
    `gender` STRING COMMENT 'Self‑identified gender of the guest.. Valid values are `male|female|other|prefer_not_to_say`',
    `golden_record_flag` BOOLEAN COMMENT 'Indicates whether this record is the current authoritative (golden) guest profile.',
    `guest_status` STRING COMMENT 'Operational status of the guest record (e.g., active, inactive, blacklisted).. Valid values are `active|inactive|blacklisted`',
    `guest_type` STRING COMMENT 'Classification of the party (e.g., regular guest, employee, vendor, franchisee, or anonymous visitor).. Valid values are `guest|employee|vendor|franchisee|anonymous`',
    `last_interaction_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent interaction with the guest across any channel.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the guest record within the identity resolution process.. Valid values are `active|inactive|merged|duplicate|pending`',
    `loyalty_tier` STRING COMMENT 'Current tier level of the guest in the loyalty program.. Valid values are `bronze|silver|gold|platinum`',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence (0‑100) that the source record matches the golden guest profile.',
    `match_event_reason` STRING COMMENT 'Reason why the match was performed (new record, update, or reconciliation).. Valid values are `new|update|reconcile`',
    `match_method` STRING COMMENT 'Algorithmic approach used for identity matching: deterministic (rule‑based) or probabilistic (statistical).. Valid values are `deterministic|probabilistic`',
    `merge_event_timestamp` TIMESTAMP COMMENT 'Date‑time when the source record was merged into the golden profile.',
    `notes` STRING COMMENT 'Free‑form text for manual annotations about the identity resolution event.',
    `nps_score` STRING COMMENT 'Latest NPS rating given by the guest (0‑10).',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the guests address.',
    `preferred_communication_channel` STRING COMMENT 'Channel the guest prefers for receiving messages.. Valid values are `email|sms|push|mail`',
    `preferred_language` STRING COMMENT 'Guests preferred language for communications.',
    `primary_email` STRING COMMENT 'Primary email address used for guest communication.',
    `primary_phone` STRING COMMENT 'Primary telephone number for contacting the guest.',
    `privacy_opt_out` BOOLEAN COMMENT 'True if the guest has opted out of data collection or profiling.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the identity resolution record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the identity resolution record.',
    `segment` STRING COMMENT 'Business‑defined segment to which the guest belongs for targeting purposes.',
    `source_record_reference` STRING COMMENT 'Unique identifier of the guest record in the source system.',
    `source_system_timestamp` TIMESTAMP COMMENT 'Date‑time when the source system recorded the original guest event.',
    `state` STRING COMMENT 'State or province component of the guests address.',
    `total_lifetime_spend` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all purchases attributed to the guest.',
    CONSTRAINT pk_identity_resolution PRIMARY KEY(`identity_resolution_id`)
) COMMENT 'Tracks the matching, merging, and cross-system mapping of guest identity records across channels and systems (POS, OLO, loyalty, 3PD). Stores all channel-specific guest identifiers including source system (Oracle MICROS POS, Olo, Salesforce CRM, 3PD partner, loyalty app), external identifier, identifier type (email, phone, loyalty card number, device ID, 3PD customer ID), creation date, active status, match confidence scores, merge/split events, golden record designation, and resolution method (deterministic vs. probabilistic). Enables a unified guest view by linking fragmented identities into a single canonical profile. Supports cross-channel identity stitching, deduplication, and multi-system identifier management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`address` (
    `address_id` BIGINT COMMENT 'System-generated unique identifier for the address record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this address belongs.',
    `address_profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this address belongs.',
    `owner_profile_id` BIGINT COMMENT 'Identifier of the owning entity (guest, restaurant, etc.).',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record.. Valid values are `active|inactive|invalid|pending`',
    `address_type` STRING COMMENT 'Classification of the address purpose.. Valid values are `home|work|delivery|billing|other`',
    `building_name` STRING COMMENT 'Name of the building, if applicable.',
    `city` STRING COMMENT 'City or municipality of the address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or equivalent administrative area.',
    `created_timestamp` TIMESTAMP COMMENT 'When the address record was first created in the system.',
    `delivery_instructions` STRING COMMENT 'Special instructions for delivering to this address (e.g., gate code, porch).',
    `district` STRING COMMENT 'Sub‑municipal district or neighborhood.',
    `geocode_accuracy` STRING COMMENT 'Quality level of the geocoding result.. Valid values are `high|medium|low`',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the guests primary address.',
    `landmark` STRING COMMENT 'Nearby landmark or point of reference to aid delivery.',
    `last_verified` DATE COMMENT 'Date of the most recent successful verification.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the address.',
    `line1` STRING COMMENT 'Primary street address line (e.g., house number and street name).',
    `line2` STRING COMMENT 'Secondary address information such as apartment, suite, or unit.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the address.',
    `owner_type` STRING COMMENT 'Entity type that owns or uses the address.. Valid values are `guest|restaurant|franchise|vendor`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address.. Valid values are `^[A-Za-z0-9 -]{3,10}$`',
    `region` STRING COMMENT 'Broad geographic region (e.g., Midwest, West Coast).',
    `state_province` STRING COMMENT 'State, province, or region of the address.',
    `suite_number` STRING COMMENT 'Suite, unit, or floor number within a building.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Most recent date and time the address record was modified.',
    `validation_status` STRING COMMENT 'Result of the most recent address validation attempt.. Valid values are `validated|unvalidated|failed`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the address was last validated.',
    `validity_flag` BOOLEAN COMMENT 'True if the address is currently considered valid for delivery.',
    `verification_method` STRING COMMENT 'Method used to verify the address.. Valid values are `postal|third_party|self_report`',
    `verification_score` DECIMAL(18,2) COMMENT 'Numeric confidence score (0‑100) from the verification service.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Stores all physical and delivery addresses associated with a guest profile, including home address, saved delivery addresses, and billing addresses. Captures address type, street, city, state/province, postal code, country, geolocation coordinates, delivery instructions, and validation status. Supports OLO delivery fulfillment and personalized marketing by geography.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`preference` (
    `preference_id` BIGINT COMMENT 'Primary key for preference record. _canonical_skip_reason: Entity does not fit standard master or transaction roles; treated as OTHER.',
    `menu_item_id` BIGINT COMMENT 'Identifier of the guests most frequently ordered menu item.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this preference belongs.',
    `preference_profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this preference belongs.',
    `communication_channel_preference` STRING COMMENT 'Guests preferred channel for receiving communications.. Valid values are `email|sms|push|none`',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the guest has given consent for storing this preference.',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when consent was recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the preference record was first created.',
    `data_source_timestamp` TIMESTAMP COMMENT 'Timestamp when the source system recorded the preference.',
    `device_preference` STRING COMMENT 'Preferred device type for digital interactions.. Valid values are `kiosk|mobile|tablet`',
    `effective_from` DATE COMMENT 'Date from which the preference is considered effective.',
    `effective_until` DATE COMMENT 'Date after which the preference is no longer effective (null if open-ended).',
    `favorite_cuisine` STRING COMMENT 'Guests preferred cuisine type (e.g., Italian, Mexican).',
    `has_dairy_allergy` BOOLEAN COMMENT 'Indicates if the guest has a dairy allergy.',
    `has_gluten_allergy` BOOLEAN COMMENT 'Indicates if the guest has a gluten allergy.',
    `has_nut_allergy` BOOLEAN COMMENT 'Indicates if the guest has a nut allergy.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the preference is currently active.',
    `is_halal` BOOLEAN COMMENT 'Indicates if the guest requires halal meals.',
    `is_kosher` BOOLEAN COMMENT 'Indicates if the guest requires kosher meals.',
    `is_vegan` BOOLEAN COMMENT 'Indicates if the guest prefers vegan meals.',
    `is_vegetarian` BOOLEAN COMMENT 'Indicates if the guest prefers vegetarian meals.',
    `language_preference` STRING COMMENT 'Guests preferred language for communications.',
    `loyalty_tier` STRING COMMENT 'Current loyalty program tier of the guest.. Valid values are `bronze|silver|gold|platinum`',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates if the guest has opted in to receive marketing communications.',
    `marketing_opt_out_reason` STRING COMMENT 'Reason provided by the guest for opting out of marketing communications.',
    `notes` STRING COMMENT 'Free-form notes or comments about the preference.',
    `origin` STRING COMMENT 'How the preference was captured.. Valid values are `manual|system|survey`',
    `preference_status` STRING COMMENT 'Current lifecycle status of the preference record.. Valid values are `active|inactive|archived`',
    `preference_type` STRING COMMENT 'Category of the preference indicating its domain. [ENUM-REF-CANDIDATE: dietary|cuisine|menu_item|service_channel|daypart|communication|marketing|loyalty|other — promote to reference product]',
    `preferred_daypart` STRING COMMENT 'Time of day the guest most often dines.. Valid values are `breakfast|brunch|lunch|dinner|late_night`',
    `preferred_payment_method` STRING COMMENT 'Guests favored payment method.. Valid values are `cash|card|mobilepay`',
    `preferred_seating` STRING COMMENT 'Guests favored seating location within the restaurant.. Valid values are `indoor|outdoor|bar|window`',
    `preferred_service_channel` STRING COMMENT 'Guests preferred way to receive service.. Valid values are `dine_in|drive_thru|online|delivery`',
    `privacy_consent_version` STRING COMMENT 'Version of the privacy consent agreement under which the preference was collected.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the preference record.',
    `value` DECIMAL(18,2) COMMENT 'The actual value or description of the preference, such as "no peanuts" or "Italian".',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Captures all guest-stated and inferred preferences, dietary restrictions, and food allergen declarations. Covers FDA major allergens (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame) with severity levels (intolerance vs. allergy), dietary restriction types (vegetarian, vegan, halal, kosher, gluten-free), declaration source (self-declared, healthcare provider), cuisine preferences, favorite menu items, preferred service channel (dine-in, DT, OLO), preferred daypart, communication channel preferences (email, SMS, push), and marketing opt-in/opt-out flags. Sourced from Salesforce CRM, Olo guest data, and guest self-declaration. Drives personalization, targeted marketing, and HACCP-aligned guest food safety compliance including FDA allergen labeling requirements.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'System-generated unique identifier for the consent record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this consent applies.',
    `consent_policy_id` BIGINT COMMENT 'Identifier of the privacy policy document referenced by this consent.',
    `consent_profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this consent applies.',
    `consent_expiry_date` DATE COMMENT 'Date when the consent automatically expires, if applicable.',
    `consent_language` STRING COMMENT 'Two‑letter language code of the consent notice presented to the guest.. Valid values are `^[a-z]{2}$`',
    `consent_method` STRING COMMENT 'Method by which the guest expressed consent (opt‑in, opt‑out, implied).. Valid values are `opt_in|opt_out|implied`',
    `consent_purpose` STRING COMMENT 'Free‑text description of the business purpose for which consent was obtained.',
    `consent_revoked_reason` STRING COMMENT 'Free‑text reason provided by the guest for withdrawing consent, if any.',
    `consent_revoked_timestamp` TIMESTAMP COMMENT 'Timestamp when the guest withdrew the consent.',
    `consent_source_channel` STRING COMMENT 'Channel through which the guest provided consent.. Valid values are `online|in_store|mobile_app|call_center|email`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent.. Valid values are `granted|withdrawn|expired|pending`',
    `consent_timestamp` TIMESTAMP COMMENT 'Date and time when the consent was originally given.',
    `consent_type` STRING COMMENT 'Category of consent (e.g., marketing, SMS, email, data sharing, profiling).. Valid values are `marketing|sms|email|data_sharing|profiling`',
    `consent_version` STRING COMMENT 'Version identifier of the privacy policy or consent notice at the time of consent.',
    `created` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `data_processing_scope` STRING COMMENT 'Scope of data processing covered by the consent.. Valid values are `full|limited|custom`',
    `data_sharing_consent` BOOLEAN COMMENT 'True if the guest consented to internal data sharing for analytics or personalization.',
    `device_code` STRING COMMENT 'Identifier of the device used to capture consent (e.g., mobile device ID).',
    `effective_from` DATE COMMENT 'Date from which the consent is considered active.',
    `effective_until` DATE COMMENT 'Date until which the consent remains valid (null if open‑ended).',
    `email_consent` BOOLEAN COMMENT 'True if the guest consented to receive email communications.',
    `ip_address` STRING COMMENT 'IP address from which the consent was captured.. Valid values are `^([0-9]{1,3}.){3}[0-9]{1,3}$`',
    `marketing_consent` BOOLEAN COMMENT 'True if the guest consented to receive marketing communications.',
    `privacy_notice_version` STRING COMMENT 'Identifier of the privacy notice version referenced by this consent.',
    `sms_consent` BOOLEAN COMMENT 'True if the guest consented to receive SMS messages.',
    `third_party_consent` BOOLEAN COMMENT 'True if the guest consented to share data with approved third parties.',
    `updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Authoritative record of guest consent and privacy elections per regulatory requirement (GDPR, CCPA, CAN-SPAM). Tracks consent type (marketing email, SMS, data sharing, profiling), consent status (granted/withdrawn), consent timestamp, consent source channel, consent version/policy version, and expiry date. Mandatory for compliance with FDA labeling, FTC advertising regulations, and applicable data privacy laws. Immutable audit trail of all consent changes.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`guest_segment` (
    `guest_segment_id` BIGINT COMMENT 'Unique identifier for the guest_guest_segment data product (auto-inserted pre-linking).',
    `segment_name` STRING COMMENT '',
    `segment_description` STRING COMMENT '',
    `segment_criteria` STRING COMMENT '',
    `is_active` BOOLEAN COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    `updated_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_guest_segment PRIMARY KEY(`guest_segment_id`)
) COMMENT 'Defines guest segmentation classifications used for targeted marketing, personalization, and operational planning. Captures segment name, segment type (behavioral, demographic, value-based, lifecycle stage), definition criteria, effective date range, segment owner (marketing vs. operations), and channel applicability. Examples include high-frequency QSR visitors, lapsed guests, LTO responders, and high-ACV guests. Managed in Salesforce CRM.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` (
    `guest_segment_membership_id` BIGINT COMMENT 'Unique identifier for the guest_segment_membership data product (auto-inserted pre-linking).',
    `guest_segment_id` BIGINT COMMENT 'Foreign key linking to guest.guest_guest_segment. Business justification: guest_segment_membership must reference the specific segment definition within the guest domain.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: guest_segment_membership needs to reference the guest profile to associate a segment membership with a specific guest.',
    CONSTRAINT pk_guest_segment_membership PRIMARY KEY(`guest_segment_membership_id`)
) COMMENT 'Association entity recording which guests belong to which segments at any point in time. Captures segment assignment date, expiry date, assignment method (rule-based, manual, ML-model), confidence score, and the source campaign or trigger that caused the assignment. Enables time-travel queries on segment composition and supports SSS (Same-Store Sales) cohort analysis and CSAT trending by segment.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`household` (
    `household_id` BIGINT COMMENT 'System-generated unique identifier for the household master record.',
    `address_id` BIGINT COMMENT 'FK to guest.address',
    `member_id` BIGINT COMMENT 'Identifier of the primary guest/member designated for the household.',
    `profile_id` BIGINT COMMENT 'Identifier of the primary guest/member designated for the household.',
    `address_verification_date` DATE COMMENT 'Date when the household address was last verified.',
    `address_verified` BOOLEAN COMMENT 'Indicates whether the household address has been validated.',
    `average_check_value` DECIMAL(18,2) COMMENT 'Average monetary value of transactions per visit for the household.',
    `average_transaction_count` STRING COMMENT 'Average number of transactions per defined period for the household.',
    `consent_privacy` BOOLEAN COMMENT 'Indicates whether the household has given consent for data processing under privacy regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the household record was first created.',
    `dissolution_date` DATE COMMENT 'Date when the household was closed or merged; null if still active.',
    `estimated_income_band` STRING COMMENT 'Income bracket estimate for the household used for segmentation.. Valid values are `low|medium|high|very_high`',
    `formation_date` DATE COMMENT 'Date when the household was first created in the system.',
    `household_status` STRING COMMENT 'Current lifecycle status of the household record.. Valid values are `active|inactive|closed|pending`',
    `household_type` STRING COMMENT 'Classification of the household composition.. Valid values are `family|single|group|other`',
    `last_transaction_date` DATE COMMENT 'Date of the most recent transaction recorded for the household.',
    `last_update_timestamp` TIMESTAMP COMMENT 'Date‑time when the household record was last modified.',
    `loyalty_enrolled` BOOLEAN COMMENT 'Indicates whether the household participates in the loyalty program.',
    `loyalty_tier` STRING COMMENT 'Current loyalty tier assigned to the household.. Valid values are `bronze|silver|gold|platinum`',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the household has opted in to receive marketing communications.',
    `household_name` STRING COMMENT 'Human‑readable name for the household (e.g., Smith Family, Johnson Household).',
    `notes` STRING COMMENT 'Free‑form notes or comments about the household.',
    `preferred_channel` STRING COMMENT 'Channel most frequently used by the household for ordering.. Valid values are `dine_in|drive_thru|online|mobile|third_party`',
    `primary_contact_method` STRING COMMENT 'Preferred channel for primary household communications.. Valid values are `email|phone|mail`',
    `primary_email` STRING COMMENT 'Primary email address used to contact the household.',
    `primary_phone` STRING COMMENT 'Primary telephone number for the household.',
    `segment` STRING COMMENT 'Analytical segment used for marketing and forecasting.. Valid values are `high_value|mid_value|low_value|new|churn_risk`',
    `size` STRING COMMENT 'Number of individuals associated with the household.',
    `total_spend` DECIMAL(18,2) COMMENT 'Cumulative monetary spend of the household across all channels.',
    `total_transactions` BIGINT COMMENT 'Cumulative count of all transactions associated with the household.',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Groups individual guest profiles into household units for family-level analytics, shared loyalty benefits, and targeted household marketing. Captures household name, household size, estimated household income band, residential address, and household formation/dissolution dates. Includes member-level detail: member role (primary, secondary, dependent), relationship type, join/departure dates, and primary loyalty account holder designation. Supports cover count analysis, household-level ACV/ATC calculations, multi-member loyalty benefit sharing, and household spend aggregation.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`household_member` (
    `household_member_id` BIGINT COMMENT 'Unique surrogate key for the household member record.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest (individual) linked to the household.',
    `household_id` BIGINT COMMENT 'Identifier of the household unit to which the member belongs.',
    `household_profile_id` BIGINT COMMENT 'Identifier of the guest (individual) linked to the household.',
    `birthdate` DATE COMMENT 'Members date of birth.',
    `consent_opt_in` BOOLEAN COMMENT 'Indicates whether the member has opted in to marketing communications.',
    `consent_opt_in_timestamp` TIMESTAMP COMMENT 'Timestamp when the member provided consent for marketing communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the household member record was created in the system.',
    `departure_date` DATE COMMENT 'Date when the member left the household, if applicable.',
    `gender` STRING COMMENT 'Members gender as reported.. Valid values are `male|female|nonbinary|unspecified`',
    `is_primary_loyalty_holder` BOOLEAN COMMENT 'Indicates whether the member is the primary loyalty account holder for the household.',
    `join_date` DATE COMMENT 'Date when the member was added to the household.',
    `loyalty_points_balance` DECIMAL(18,2) COMMENT 'Current balance of loyalty points for the member.',
    `loyalty_tier` STRING COMMENT 'Loyalty program tier assigned to the member within the household.. Valid values are `bronze|silver|gold|platinum`',
    `member_status` STRING COMMENT 'Current status of the household member record.. Valid values are `active|inactive|pending|terminated`',
    `notes` STRING COMMENT 'Free-text notes or comments about the household member.',
    `relationship_type` STRING COMMENT 'Type of relationship between the guest and the household (e.g., family, friend, employee).. Valid values are `family|friend|employee|other`',
    `role` STRING COMMENT 'Role of the member within the household (e.g., primary, secondary, dependent).. Valid values are `primary|secondary|dependent`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the household member record.',
    CONSTRAINT pk_household_member PRIMARY KEY(`household_member_id`)
) COMMENT 'Association entity linking individual guest profiles to a household unit. Captures member role (primary, secondary, dependent), relationship type, join date, departure date, and whether the member is the primary loyalty account holder for the household. Enables household-level spend aggregation and multi-member loyalty benefit sharing.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` (
    `lifetime_value_id` BIGINT COMMENT 'Unique identifier for the lifetime value record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this lifetime value belongs.',
    `lifetime_profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this lifetime value belongs.',
    `average_check_value` DECIMAL(18,2) COMMENT 'Average monetary value of a single transaction for the guest.',
    `average_transactions_per_month` DECIMAL(18,2) COMMENT 'Mean count of transactions the guest completes each month.',
    `consent_opt_in` BOOLEAN COMMENT 'True if the guest has opted in to data collection and marketing communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the LTV record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter currency identifier for all monetary fields.. Valid values are `[A-Z]{3}`',
    `data_refresh_cycle` STRING COMMENT 'Scheduled frequency at which the LTV metrics are recomputed.. Valid values are `daily|weekly|monthly|quarterly`',
    `days_since_last_visit` STRING COMMENT 'Number of days between today and the most recent visit date.',
    `first_visit_date` DATE COMMENT 'Calendar date of the guests inaugural purchase.',
    `loyalty_member_flag` BOOLEAN COMMENT 'True if the guest is enrolled in the restaurants loyalty program.',
    `ltv_calculation_date` DATE COMMENT 'Calendar date on which the LTV metrics were most recently refreshed.',
    `ltv_last_updated` TIMESTAMP COMMENT 'Exact moment the LTV record was last refreshed.',
    `ltv_status` STRING COMMENT 'Current lifecycle state of the LTV record.. Valid values are `active|inactive|archived`',
    `ltv_tier` STRING COMMENT 'Business‑defined tier indicating the guests overall value (e.g., platinum, gold).. Valid values are `platinum|gold|silver|bronze|standard`',
    `most_recent_visit_date` DATE COMMENT 'Calendar date of the guests latest purchase.',
    `notes` STRING COMMENT 'Additional commentary or observations about the LTV record.',
    `predicted_future_value` DECIMAL(18,2) COMMENT 'Forecasted monetary contribution of the guest over the next 12 months.',
    `segment` STRING COMMENT 'Analytical segment assigned to the guest for targeting.. Valid values are `high_value|medium_value|low_value|new|churn_risk`',
    `total_historical_spend` DECIMAL(18,2) COMMENT 'Cumulative monetary amount the guest has spent across all transactions to date.',
    `total_visits` STRING COMMENT 'Total number of distinct visits (in‑store, drive‑thru, or online) recorded for the guest.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the LTV record.',
    CONSTRAINT pk_lifetime_value PRIMARY KEY(`lifetime_value_id`)
) COMMENT 'Stores calculated and periodically refreshed guest lifetime value (LTV) metrics at the individual profile level. Captures total historical spend, visit frequency, average check value (ACV), average transaction count (ATC), predicted future value, LTV tier classification, first visit date, most recent visit date, and days since last visit. Refreshed on a scheduled cadence from order domain transactional data. Supports retention prioritization and loyalty tier management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` (
    `satisfaction_survey_id` BIGINT COMMENT 'Unique identifier for each satisfaction survey instance.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee satisfaction KPI dashboard aggregates survey results per franchisee for performance monitoring.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the guest experience occurred.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who received the survey.',
    `satisfaction_location_unit_id` BIGINT COMMENT 'Identifier of the specific physical location (store, drive‑thru, etc.) of the visit.',
    `satisfaction_profile_id` BIGINT COMMENT 'Unique identifier of the guest who received the survey.',
    `satisfaction_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the guest experience occurred.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for Service Quality Dashboard linking survey scores to the serving employee, supporting performance coaching and bonus calculations.',
    `comments` STRING COMMENT 'Free‑text comments entered by the guest.',
    `completion_status` STRING COMMENT 'Indicates whether the guest completed, partially completed, declined, or never received the survey.. Valid values are `completed|partial|declined|not_sent`',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the guest consented to be surveyed and to have their responses stored.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first created in the lakehouse.',
    `csat_score` STRING COMMENT 'CSAT rating provided by the guest, typically on a 1‑5 scale.',
    `daypart` STRING COMMENT 'Business day segment during which the visit occurred.. Valid values are `breakfast|lunch|dinner|late_night`',
    `delivery_channel` STRING COMMENT 'Channel used to deliver the survey to the guest.. Valid values are `email|sms|in_app|receipt_qr`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date‑time when the survey was sent to the guest.',
    `language` STRING COMMENT 'ISO language code of the survey presented to the guest.',
    `nps_score` STRING COMMENT 'NPS rating provided by the guest on a scale of 0‑10.',
    `response_timestamp` TIMESTAMP COMMENT 'Date‑time when the guest submitted the survey response.',
    `satisfaction_survey_status` STRING COMMENT 'Current lifecycle status of the survey record.. Valid values are `active|inactive|archived`',
    `survey_type` STRING COMMENT 'Classification of the survey (Customer Satisfaction, Net Promoter Score, or post‑delivery feedback).. Valid values are `csat|nps|post_delivery`',
    `survey_version` STRING COMMENT 'Version identifier of the survey questionnaire used.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the survey record.',
    `visit_date` DATE COMMENT 'Calendar date of the guests visit, derived from visit_timestamp.',
    `visit_timestamp` TIMESTAMP COMMENT 'Date‑time when the guests visit or order took place.',
    CONSTRAINT pk_satisfaction_survey PRIMARY KEY(`satisfaction_survey_id`)
) COMMENT 'Records guest satisfaction survey instances with full question-level response detail. Captures survey type (CSAT, NPS, post-delivery, post-visit), delivery channel (email, SMS, in-app, receipt QR), delivery timestamp, completion status, NPS score (0-10), CSAT score, restaurant unit, daypart, and respondent profile. Includes granular question-level data: question text, question type (rating, open-text, multiple-choice), response value, response timestamp, and sentiment classification for open-text responses. Sourced from Salesforce CRM and Olo guest feedback flows. Enables CSAT/NPS driver analysis at both survey and question level, supporting operational improvement across FOH and BOH.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`survey_response` (
    `survey_response_id` BIGINT COMMENT 'Unique identifier for the survey response record.',
    `satisfaction_survey_id` BIGINT COMMENT 'Identifier of the survey to which this response belongs.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who provided the response.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the survey was captured.',
    `survey_profile_id` BIGINT COMMENT 'Unique identifier of the guest who provided the response.',
    `survey_question_id` BIGINT COMMENT 'Identifier of the survey question being answered.',
    `survey_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the survey was captured.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the response record was first created in the system.',
    `device_code` STRING COMMENT 'Identifier of the device used to capture the response (e.g., tablet ID).',
    `ip_address` STRING COMMENT 'IP address of the device/network used for online responses.',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether the response was submitted anonymously.',
    `is_test_response` BOOLEAN COMMENT 'Indicates if the response is a test record used for system validation.',
    `open_text` STRING COMMENT 'Free-form text provided by the guest for open-text questions.',
    `rating_scale_max` STRING COMMENT 'Maximum possible rating value for the rating scale.',
    `rating_score` STRING COMMENT 'Numeric rating score if response_type is rating or scale.',
    `response_channel` STRING COMMENT 'Channel through which the guest submitted the survey.. Valid values are `dine_in|drive_thru|online|mobile_app|kiosk`',
    `response_language` STRING COMMENT 'ISO language code of the response text.. Valid values are `en|es|fr|de|zh|ja`',
    `response_sequence` STRING COMMENT 'Sequence number of the response within the survey for the guest.',
    `response_status` STRING COMMENT 'Current processing status of the response.. Valid values are `completed|skipped|partial|invalid`',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when the response was recorded.',
    `response_type` STRING COMMENT 'Type of the response format (e.g., rating, open text, multiple choice).. Valid values are `rating|open_text|multiple_choice|scale|yes_no`',
    `response_value` DECIMAL(18,2) COMMENT 'Raw response value as captured (e.g., rating number, selected option, free text).',
    `selected_option` STRING COMMENT 'Chosen option text for multiple-choice responses.',
    `sentiment_label` STRING COMMENT 'Categorical sentiment label derived from open-text response.. Valid values are `negative|neutral|positive`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Sentiment analysis score ranging from -1 (negative) to 1 (positive).',
    `survey_version` STRING COMMENT 'Version identifier of the survey template used.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the response record.',
    CONSTRAINT pk_survey_response PRIMARY KEY(`survey_response_id`)
) COMMENT 'Stores individual question-level responses within a guest satisfaction survey. Captures question text, question type (rating, open-text, multiple-choice), response value, response timestamp, and sentiment classification for open-text responses. Enables granular CSAT and NPS driver analysis at the question level, supporting operational improvement initiatives across FOH and BOH.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`complaint` (
    `complaint_id` BIGINT COMMENT 'System-generated unique identifier for the complaint record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who raised the complaint.',
    `complaint_profile_id` BIGINT COMMENT 'Unique identifier of the guest who raised the complaint.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the complaint originated.',
    `complaint_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the complaint originated.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchisee complaint management system tracks complaints per franchisee to meet service quality standards.',
    `guest_order_id` BIGINT COMMENT 'Identifier of the order associated with the complaint, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Complaint Resolution Report that assigns a responsible employee to each complaint, enabling accountability and SLA tracking.',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Needed for food safety incident tracking: associating complaints with the specific ingredient allows root‑cause analysis, recall decisions, and FDA reporting.',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Required for complaint resolution to identify the supplier of the product causing the complaint, enabling quality investigations and regulatory reporting.',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint reason.. Valid values are `food_quality|speed_of_service|order_accuracy|cleanliness|staff_behavior|other`',
    `channel` STRING COMMENT 'Channel through which the complaint was received.. Valid values are `in_store|drive_thru|phone|online|social_media|other`',
    `complaint_number` STRING COMMENT 'Human‑readable business identifier assigned to the complaint (e.g., C‑20231234).',
    `complaint_status` STRING COMMENT 'Current lifecycle state of the complaint.. Valid values are `open|in_progress|resolved|closed|escalated`',
    `complaint_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was initially recorded.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the guest consented to store and process their personal data for this complaint.',
    `csat_score` STRING COMMENT 'Post‑resolution CSAT rating provided by the guest (1‑10).',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the resolution amount.',
    `complaint_description` STRING COMMENT 'Free‑text description provided by the guest detailing the issue.',
    `escalated_to` BIGINT COMMENT 'Identifier of the employee or manager to whom the complaint was escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the complaint was escalated to higher management.',
    `feedback_comments` STRING COMMENT 'Additional free‑text feedback from the guest regarding the complaint handling.',
    `nps_score` STRING COMMENT 'NPS rating captured after resolution (0‑10).',
    `privacy_consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the guest provided privacy consent.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp when the complaint record was first persisted in the data lake.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the complaint record.',
    `resolution_amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the resolution (e.g., refund amount).',
    `resolution_status` STRING COMMENT 'Current status of the complaint resolution process.. Valid values are `pending|resolved|closed|escalated`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was resolved.',
    `resolution_type` STRING COMMENT 'Method used to resolve the complaint.. Valid values are `refund|replacement|apology|comp|none`',
    `severity_level` STRING COMMENT 'Business‑defined severity indicating impact on guest experience.. Valid values are `low|medium|high|critical`',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Operational record of a guest complaint or service recovery case raised through any channel (in-restaurant, phone, digital, social media). Captures complaint category (food quality, speed of service/SOS, order accuracy, cleanliness, staff behavior), severity level, channel of receipt, restaurant unit, associated order reference, resolution status, resolution type (refund, replacement, apology), resolution timestamp, and escalation flag. Managed in Salesforce CRM service cloud.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique identifier for the interaction event.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with the interaction, if any.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: In‑Restaurant Interaction Log tracks the employee handling each guest interaction, required for training effectiveness and KPI reporting.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Marketing effectiveness analysis attributes guest interactions to the franchisee that ran the campaign.',
    `profile_id` BIGINT COMMENT 'Surrogate identifier of the guest who generated the interaction.',
    `interaction_profile_id` BIGINT COMMENT 'Surrogate identifier of the guest who generated the interaction.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the interaction took place, if applicable.',
    `interaction_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the interaction took place, if applicable.',
    `channel` STRING COMMENT 'Channel through which the interaction was delivered.. Valid values are `email|push|app|drive_thru|dine_in|online`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the interaction record was first created in the lakehouse.',
    `device_code` STRING COMMENT 'Identifier of the device or terminal that recorded the interaction (e.g., POS terminal, kiosk).',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction occurred.',
    `interaction_type` STRING COMMENT 'Nature of the interaction event (e.g., email open, app click, order placement).. Valid values are `open|click|view|order|checkin|visit`',
    `is_test` BOOLEAN COMMENT 'Indicates whether the interaction is a test event (true) or a production event (false).',
    `outcome` STRING COMMENT 'Result of the interaction, indicating whether it succeeded or failed.. Valid values are `success|failure|skip|bounce|partial|unknown`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the interaction record.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Unified event stream capturing every recorded touchpoint between the brand and a guest across all channels. Covers inbound interactions (app sessions, loyalty check-ins, drive-thru visits, dine-in visits, OLO sessions, 3PD orders) and outbound communications (marketing emails, SMS messages, push notifications, direct mail). Captures interaction type, direction (inbound/outbound), channel, timestamp, restaurant unit (if applicable), campaign or trigger reference, subject/content reference, delivery status, open status, click-through status, unsubscribe action, and interaction outcome. Sourced from Salesforce CRM marketing automation, Oracle MICROS POS, and Olo. Provides the raw engagement timeline for RFM modeling, communication frequency capping, suppression list management, and guest engagement scoring.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` (
    `channel_identity_id` BIGINT COMMENT 'System-generated unique identifier for each channel identity record.',
    `profile_id` BIGINT COMMENT 'Reference to the canonical guest profile that this channel identity belongs to.',
    `channel_profile_id` BIGINT COMMENT 'Reference to the canonical guest profile that this channel identity belongs to.',
    `channel_identity_status` STRING COMMENT 'Current lifecycle status of the channel identity record.. Valid values are `active|inactive|suspended|pending`',
    `channel_name` STRING COMMENT 'Logical name of the channel source (e.g., POS, Online Ordering, CRM, Third‑Party Delivery, Loyalty App).. Valid values are `POS|OLO|Salesforce|ThirdParty|LoyaltyApp|Other`',
    `channel_user_email` STRING COMMENT 'Email address of the guest in the source channel.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `channel_user_name` STRING COMMENT 'Display name of the guest as known in the source channel.',
    `channel_user_phone` STRING COMMENT 'Phone number of the guest in the source channel.',
    `consent_opt_in` BOOLEAN COMMENT 'Guests consent to receive marketing communications via this channel.',
    `created_by_system` STRING COMMENT 'Name of the source system that initially created the channel identity record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the channel identity record was first created in the lakehouse.',
    `effective_from` DATE COMMENT 'Date when the external identifier became valid for the guest.',
    `effective_until` DATE COMMENT 'Date when the external identifier ceased to be valid (null if still active).',
    `external_identifier` STRING COMMENT 'Identifier assigned to the guest in the source system (e.g., email address, loyalty card number, device ID).',
    `identifier_type` STRING COMMENT 'Category describing the nature of the external identifier.. Valid values are `email|phone|loyalty_card|device_id|third_party_id|account_number`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the channel identity is currently active for the guest.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this channel is the primary identity source for the guest.',
    `is_test_account` BOOLEAN COMMENT 'Indicates whether the record belongs to a test or sandbox account.',
    `last_updated_by_system` STRING COMMENT 'Name of the system that performed the most recent update.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'When the external identifier was last verified as belonging to the guest.',
    `loyalty_tier` STRING COMMENT 'Guests loyalty tier as recorded in the channel (if applicable).. Valid values are `bronze|silver|gold|platinum`',
    `notes` STRING COMMENT 'Optional free‑text comments or remarks about the channel identity.',
    `privacy_status` STRING COMMENT 'Current privacy state for the channel identity (consented, revoked, unknown).',
    `record_status` STRING COMMENT 'Operational status of the record within the data lake (e.g., current, archived, deleted).. Valid values are `current|archived|deleted`',
    `record_version` STRING COMMENT 'Monotonically increasing version number for optimistic concurrency control.',
    `source_system_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the source system first created the external identifier.',
    `source_system_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent change to the external identifier in the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the channel identity record.',
    `verification_method` STRING COMMENT 'Method used to verify the external identifier.. Valid values are `email|sms|phone|in_store|none`',
    CONSTRAINT pk_channel_identity PRIMARY KEY(`channel_identity_id`)
) COMMENT 'Stores channel-specific guest identifiers that map back to the canonical guest profile. Captures the source system (Oracle MICROS POS, Olo, Salesforce CRM, 3PD partner, loyalty app), the external identifier in that system, identifier type (email, phone, loyalty card number, device ID, 3PD customer ID), creation date, and active status. Enables cross-channel identity stitching and supports the identity resolution process.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`demographic` (
    `demographic_id` BIGINT COMMENT 'Unique identifier for the demographic record.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest to which this demographic profile belongs.',
    `demographic_profile_id` BIGINT COMMENT 'Identifier of the guest to which this demographic profile belongs.',
    `age_band` STRING COMMENT 'Age range classification for the guest.',
    `consent_opt_in` BOOLEAN COMMENT 'Indicates whether the guest has opted in to marketing communications.',
    `consent_opt_out` BOOLEAN COMMENT 'Indicates whether the guest has opted out of marketing communications.',
    `data_source` STRING COMMENT 'Indicates whether the demographic data was self‑declared by the guest or supplied by a third‑party enrichment provider.. Valid values are `self_declared|third_party`',
    `demographic_type` STRING COMMENT 'High‑level classification of the guest for analytics (e.g., resident, visitor).. Valid values are `resident|visitor|tourist|employee|contractor|other`',
    `education_level` STRING COMMENT 'Highest education attained by the guest. [ENUM-REF-CANDIDATE: no_formal|high_school|some_college|bachelor|master|doctorate|other — promote to reference product]',
    `email_address` STRING COMMENT 'Primary email address for guest communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_status` STRING COMMENT 'Current employment situation of the guest.. Valid values are `employed|unemployed|student|retired|self_employed|other`',
    `enrichment_date` DATE COMMENT 'Date on which the demographic enrichment was applied.',
    `enrichment_provider` STRING COMMENT 'Name of the third‑party vendor that supplied the enriched demographic data.',
    `ethnicity` STRING COMMENT 'Ethnic background of the guest. [ENUM-REF-CANDIDATE: asian|black|hispanic|white|native_american|middle_eastern|other — promote to reference product]',
    `ethnicity_source` STRING COMMENT 'Origin of the ethnicity information.. Valid values are `self|inferred|third_party`',
    `full_name` STRING COMMENT 'Legal full name of the individual.',
    `gender_identity` STRING COMMENT 'Self‑declared gender identity of the guest.. Valid values are `male|female|nonbinary|prefer_not_to_say|other`',
    `geographic_market` STRING COMMENT 'Market classification based on the guests primary location.. Valid values are `urban|suburban|rural|airport|college_town|other`',
    `household_income_band` STRING COMMENT 'Income range of the guests household.. Valid values are `0-25k|25-50k|50-75k|75-100k|100-150k|150k+`',
    `language_preference` STRING COMMENT 'Preferred language for communications.. Valid values are `en|es|fr|de|zh|other`',
    `marital_status` STRING COMMENT 'Current marital status of the guest.. Valid values are `single|married|divorced|widowed|partnered|other`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the demographic record.',
    `number_of_children` STRING COMMENT 'Count of dependent children reported by the guest.',
    `phone_number` STRING COMMENT 'Primary telephone number for the guest.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the demographic record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the demographic record.',
    `record_status` STRING COMMENT 'Current lifecycle status of the demographic record.. Valid values are `active|inactive|archived`',
    CONSTRAINT pk_demographic PRIMARY KEY(`demographic_id`)
) COMMENT 'Stores structured demographic attributes for a guest profile including age band, gender identity, ethnicity (where permitted and consented), household income band, education level, employment status, and geographic market classification. Captures data source (self-declared vs. third-party enrichment), enrichment provider, and enrichment date. Supports targeted marketing, menu development, and site selection analytics in conjunction with the realestate domain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` (
    `guest_visit_id` BIGINT COMMENT 'Unique identifier for the guest_visit data product (auto-inserted pre-linking).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Guest Flow Management records which host/hostess greeted the guest, essential for staffing analysis and guest experience metrics.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: guest_visit must reference the guest profile to associate each visit with a guest.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Visit analytics require linking each guest visit to the exact restaurant unit for performance dashboards and service‑speed KPI calculations.',
    CONSTRAINT pk_guest_visit PRIMARY KEY(`guest_visit_id`)
) COMMENT 'Captures each confirmed guest visit to a restaurant unit across all service modes (dine-in, DT, OLO, 3PD). Distinct from the order domains order transaction — this is the guest-centric visit record that may span multiple orders or be a zero-spend visit (e.g., complaint resolution visit). Captures visit date, daypart, service mode, restaurant unit, party size (cover count), table number (dine-in), DT lane (drive-thru), visit duration, and whether the visit was incentivized by a promotion.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` (
    `guest_allergen_profile_id` BIGINT COMMENT 'Unique identifier for the guest_allergen_profile data product (auto-inserted pre-linking).',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Required for allergy compliance: linking each guests allergen profile to the ingredient master enables order screening and regulatory reporting of allergen exposure.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: guest_allergen_profile needs to be tied to the master guest profile for allergen management.',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Allergy‑management process needs to map each guests allergen profile to specific stock items containing the allergen for safe‑menu recommendations.',
    CONSTRAINT pk_guest_allergen_profile PRIMARY KEY(`guest_allergen_profile_id`)
) COMMENT 'Stores a guests declared food allergen and dietary restriction profile for use in menu personalization and food safety compliance. Captures allergen type (FDA major allergens: milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame), severity level (intolerance vs. allergy), dietary restriction type (vegetarian, vegan, halal, kosher, gluten-free), declaration date, and declaration source (self-declared, healthcare provider). Supports HACCP-aligned guest safety and FDA allergen labeling compliance.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`digital_account` (
    `digital_account_id` BIGINT COMMENT 'System-generated unique identifier for the digital account record.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Required for app login to map to loyalty member for point accrual and redemption; the restaurants loyalty program uses digital accounts to identify members during orders.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: digital_account must be linked to the guest profile to associate digital activity with the correct guest.',
    `account_number` STRING COMMENT 'External account number assigned to the digital account, used for customer service and reporting.',
    `account_tier` STRING COMMENT 'Membership tier that determines benefits and loyalty program eligibility.. Valid values are `basic|silver|gold|platinum`',
    `app_version` STRING COMMENT 'Software version of the mobile or web app used during the last login.',
    `consent_marketing` BOOLEAN COMMENT 'Guests consent to receive marketing communications.',
    `consent_third_party` BOOLEAN COMMENT 'Guests consent to share data with approved third‑party partners.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the digital account record was first inserted into the lakehouse.',
    `device_type` STRING COMMENT 'Category of device used for the last login (e.g., mobile, tablet).. Valid values are `mobile|tablet|desktop|kiosk`',
    `digital_account_status` STRING COMMENT 'Current operational state of the digital account.. Valid values are `active|suspended|deactivated|pending`',
    `effective_from` DATE COMMENT 'Date when the digital account became active.',
    `effective_until` DATE COMMENT 'Date when the digital account is scheduled to be terminated or expired; null for indefinite.',
    `email` STRING COMMENT 'Primary email address associated with the digital account for communication and password recovery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `failed_login_attempts` STRING COMMENT 'Count of consecutive unsuccessful login attempts since the last successful login.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent successful authentication to the digital account.',
    `lockout_timestamp` TIMESTAMP COMMENT 'Timestamp when the account was locked due to security policy; null if not locked.',
    `password_last_changed` DATE COMMENT 'Date when the account password was most recently updated.',
    `phone_number` STRING COMMENT 'Primary telephone number linked to the digital account for SMS alerts and two‑factor authentication.. Valid values are `^+?[0-9]{7,15}$`',
    `privacy_opt_out` BOOLEAN COMMENT 'Indicates whether the guest has opted out of data collection beyond required operational purposes.',
    `registration_channel` STRING COMMENT 'Channel through which the guest originally registered the digital account.. Valid values are `app|website|olo|kiosk|in_store`',
    `two_factor_enabled` BOOLEAN COMMENT 'Indicates whether two‑factor authentication is active for the account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the digital account record.',
    `username` STRING COMMENT 'Unique login name chosen by the guest for digital access.',
    CONSTRAINT pk_digital_account PRIMARY KEY(`digital_account_id`)
) COMMENT 'Represents a guests registered digital account on the brands owned digital channels (mobile app, website, OLO platform). Captures account username, account status (active, suspended, deactivated), registration date, registration channel, last login timestamp, device type, app version, two-factor authentication status, and account tier. Distinct from the guest profile (identity) — this is the digital access credential and session management record sourced from Olo Digital Ordering Platform.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` (
    `consent_policy_id` BIGINT COMMENT 'Primary key for consent_policy',
    `superseded_consent_policy_id` BIGINT COMMENT 'Self-referencing FK on consent_policy (superseded_consent_policy_id)',
    `analytics_opt_in_allowed` BOOLEAN COMMENT 'Flag indicating if the policy permits analytics use of the data.',
    `consent_channel` STRING COMMENT 'Communication medium used for the consent interaction.',
    `consent_expiry_date` DATE COMMENT 'Date when the granted consent automatically expires.',
    `consent_mechanism` STRING COMMENT 'Method by which consent is captured (opt‑in or opt‑out).',
    `consent_revocation_timestamp` TIMESTAMP COMMENT 'Exact timestamp when consent was withdrawn.',
    `consent_source` STRING COMMENT 'Origin channel where the consent was obtained.',
    `consent_status` STRING COMMENT 'Current state of the individuals consent.',
    `data_processing_purpose` STRING COMMENT 'Business reason for processing personal data under this consent.',
    `data_retention_period_days` STRING COMMENT 'Number of days personal data may be retained under this policy.',
    `effective_from` DATE COMMENT 'Date when the consent policy becomes binding.',
    `effective_until` DATE COMMENT 'Date when the consent policy expires or is terminated (null for open‑ended).',
    `jurisdiction` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code indicating the legal jurisdiction.',
    `legal_basis` STRING COMMENT 'Legal justification for processing under the consent policy.',
    `marketing_opt_in_allowed` BOOLEAN COMMENT 'Flag indicating if the policy permits marketing communications.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the policy.',
    `policy_category` STRING COMMENT 'Higher‑level classification used for reporting and governance.',
    `policy_description` STRING COMMENT 'Detailed description of the policy purpose and scope.',
    `policy_name` STRING COMMENT 'Human‑readable name of the consent policy.',
    `policy_type` STRING COMMENT 'Category of consent policy indicating the business function it governs.',
    `privacy_law` STRING COMMENT 'Regulatory framework governing the consent policy.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the consent policy record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent policy record.',
    `consent_policy_status` STRING COMMENT 'Current lifecycle state of the consent policy.',
    `third_party_sharing_allowed` BOOLEAN COMMENT 'Indicates whether data may be shared with third parties.',
    `version_number` STRING COMMENT 'Incremental version of the policy for change tracking.',
    CONSTRAINT pk_consent_policy PRIMARY KEY(`consent_policy_id`)
) COMMENT 'Master reference table for consent_policy. Referenced by consent_policy_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`survey_question` (
    `survey_question_id` BIGINT COMMENT 'Primary key for survey_question',
    `parent_survey_question_id` BIGINT COMMENT 'Self-referencing FK on survey_question (parent_survey_question_id)',
    `satisfaction_survey_id` BIGINT COMMENT 'add column satisfaction_survey_id (BIGINT) with FK to guest.satisfaction_survey.satisfaction_survey_id - survey questions should link to the survey template they belong to',
    `survey_question_category` STRING COMMENT 'High-level grouping of the question (e.g., Service Quality, Food Quality, Ambience).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the question record was initially created.',
    `display_order` STRING COMMENT 'Ordinal position of the question within its parent survey.',
    `effective_from` DATE COMMENT 'Date from which the question version becomes valid for use.',
    `effective_until` DATE COMMENT 'Date after which the question version is no longer valid (null if indefinite).',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether the question collects responses anonymously.',
    `is_required` BOOLEAN COMMENT 'Indicates whether a response to this question is mandatory for survey completion.',
    `language` STRING COMMENT 'ISO language code of the question text.',
    `max_response_length` STRING COMMENT 'Maximum character length allowed for open-ended responses.',
    `question_text` STRING COMMENT 'Full text of the survey question presented to respondents.',
    `question_type` STRING COMMENT 'Classification of the question format determining response handling.',
    `response_options` STRING COMMENT 'Delimited list of possible answer choices for multiple-choice questions.',
    `response_scale` STRING COMMENT 'Scale definition for rating-type questions (e.g., 1-5, 1-10, smiley faces).',
    `survey_question_status` STRING COMMENT 'Current lifecycle status of the question definition.',
    `subcategory` STRING COMMENT 'More specific grouping within the main category.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the question record.',
    `version` STRING COMMENT 'Version number of the question definition, incremented on changes.',
    CONSTRAINT pk_survey_question PRIMARY KEY(`survey_question_id`)
) COMMENT 'Master reference table for survey_question. Referenced by question_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` (
    `corporate_account_id` BIGINT COMMENT 'Primary key for corporate_account',
    `employee_id` BIGINT COMMENT 'Identifier of the internal employee responsible for the corporate account.',
    `parent_corporate_account_id` BIGINT COMMENT 'Self-referencing FK on corporate_account (parent_corporate_account_id)',
    `account_name` STRING COMMENT 'Legal name of the corporate entity associated with the account.',
    `account_number` STRING COMMENT 'External business identifier assigned to the corporate account.',
    `account_type` STRING COMMENT 'Classification of the corporate account based on relationship type.',
    `address_line1` STRING COMMENT 'Primary street address of the corporate headquarters.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `annual_spend_estimate` DECIMAL(18,2) COMMENT 'Estimated total annual spend of the corporate account with the restaurant brand.',
    `billing_address_line1` STRING COMMENT 'Primary street address for billing.',
    `billing_city` STRING COMMENT 'City for billing address.',
    `billing_country` STRING COMMENT 'Three‑letter ISO country code for billing address.',
    `billing_postal_code` STRING COMMENT 'Postal/ZIP code for billing address.',
    `billing_state` STRING COMMENT 'State or province for billing address.',
    `city` STRING COMMENT 'City of the corporate headquarters.',
    `consent_opt_in` BOOLEAN COMMENT 'Indicates whether the corporate account has consented to data processing and communications.',
    `contact_email` STRING COMMENT 'Email address of the primary contact.',
    `contact_name` STRING COMMENT 'Full name of the primary business contact for the corporate account.',
    `contact_phone` STRING COMMENT 'Phone number of the primary contact.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the corporate headquarters.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corporate account record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the corporate account.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for billing the corporate account.',
    `effective_end_date` DATE COMMENT 'Date when the corporate account ends or is terminated; null if open-ended.',
    `effective_start_date` DATE COMMENT 'Date when the corporate account became effective.',
    `industry_code` STRING COMMENT 'Standard industry code (e.g., NAICS) describing the corporate entitys primary business.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Timestamp of the last interaction or transaction associated with the corporate account.',
    `loyalty_program_enrolled` BOOLEAN COMMENT 'Flag indicating enrollment in the restaurant loyalty program.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the corporate account agrees to receive marketing communications.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or special instructions related to the corporate account.',
    `number_of_locations` STRING COMMENT 'Count of restaurant locations operated by the corporate account.',
    `parent_company_name` STRING COMMENT 'Name of the ultimate parent organization, if the corporate account is a subsidiary.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the corporate account.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the corporate headquarters.',
    `shipping_address_line1` STRING COMMENT 'Primary street address for shipping.',
    `shipping_city` STRING COMMENT 'City for shipping address.',
    `shipping_country` STRING COMMENT 'Three‑letter ISO country code for shipping address.',
    `shipping_postal_code` STRING COMMENT 'Postal/ZIP code for shipping address.',
    `shipping_state` STRING COMMENT 'State or province for shipping address.',
    `state` STRING COMMENT 'State or province of the corporate headquarters.',
    `corporate_account_status` STRING COMMENT 'Current lifecycle status of the corporate account.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identifier for the corporate entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the corporate account record.',
    CONSTRAINT pk_corporate_account PRIMARY KEY(`corporate_account_id`)
) COMMENT 'Master reference table for corporate_account. Referenced by corporate_account_id.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` (
    `guest_communication_id` BIGINT COMMENT 'System-generated unique identifier for each outbound communication record.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that generated this communication.',
    `content_template_id` BIGINT COMMENT 'Identifier of the content/template used to generate the message body.',
    `consent_record_id` BIGINT COMMENT 'Reference to the guests consent record governing this communication.',
    `guest_consent_record_id` BIGINT COMMENT 'Reference to the guests consent record governing this communication.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who received the communication.',
    `primary_guest_profile_id` BIGINT COMMENT 'Unique identifier of the guest who received the communication.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Marketing communications are often store‑specific; linking to unit enables ROI measurement per restaurant and compliance with local regulations.',
    `channel` STRING COMMENT 'Medium used to deliver the communication (e.g., email, SMS, push notification).. Valid values are `email|sms|push|direct_mail|in_app|social`',
    `click_status` STRING COMMENT 'Indicates whether the recipient clicked any link in the communication.. Valid values are `clicked|not_clicked|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this communication record was first created in the system.',
    `delivery_status` STRING COMMENT 'Final delivery outcome of the communication.. Valid values are `sent|delivered|bounced|failed`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was sent to the guest.',
    `language_code` STRING COMMENT 'ISO language code representing the language of the communication.. Valid values are `en|es|fr|de|zh|ja`',
    `message_body_preview` STRING COMMENT 'Truncated preview of the communications body content.',
    `open_status` STRING COMMENT 'Indicates whether the recipient opened the communication.. Valid values are `opened|not_opened|unknown`',
    `priority` STRING COMMENT 'Priority level assigned to the communication for processing.. Valid values are `high|medium|low`',
    `recipient_email` STRING COMMENT 'Email address of the guest who received the communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_phone` STRING COMMENT 'Phone number of the guest for SMS or voice communications.',
    `scheduled_send_timestamp` TIMESTAMP COMMENT 'Planned date and time for sending the communication, if scheduled.',
    `send_attempt_count` STRING COMMENT 'Number of attempts made to deliver the communication.',
    `subject` STRING COMMENT 'Subject line or title of the outbound message.',
    `suppression_flag` BOOLEAN COMMENT 'True if the guest was on a suppression list at send time.',
    `tracking_url` STRING COMMENT 'URL used to track click‑throughs for the communication.',
    `trigger_source` STRING COMMENT 'Business event or rule that triggered the communication.. Valid values are `order_confirmation|loyalty|promotional|transactional|survey|feedback`',
    `unsubscribe_flag` BOOLEAN COMMENT 'True if the guest unsubscribed as a result of this communication.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this communication record.',
    CONSTRAINT pk_guest_communication PRIMARY KEY(`guest_communication_id`)
) COMMENT 'Records every outbound communication sent to a guest including marketing emails, SMS messages, push notifications, and direct mail. Captures communication type, channel, subject/content reference, send timestamp, delivery status, open status, click-through status, unsubscribe action, and the campaign or trigger that initiated the communication. Sourced from Salesforce CRM marketing automation. Supports suppression list management and communication frequency capping.';

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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ADD CONSTRAINT `fk_guest_demographic_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ADD CONSTRAINT `fk_guest_demographic_demographic_profile_id` FOREIGN KEY (`demographic_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ADD CONSTRAINT `fk_guest_guest_visit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ADD CONSTRAINT `fk_guest_guest_allergen_profile_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ADD CONSTRAINT `fk_guest_digital_account_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ADD CONSTRAINT `fk_guest_consent_policy_superseded_consent_policy_id` FOREIGN KEY (`superseded_consent_policy_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`consent_policy`(`consent_policy_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ADD CONSTRAINT `fk_guest_survey_question_parent_survey_question_id` FOREIGN KEY (`parent_survey_question_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`survey_question`(`survey_question_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ADD CONSTRAINT `fk_guest_survey_question_satisfaction_survey_id` FOREIGN KEY (`satisfaction_survey_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`satisfaction_survey`(`satisfaction_survey_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_parent_corporate_account_id` FOREIGN KEY (`parent_corporate_account_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ADD CONSTRAINT `fk_guest_guest_communication_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ADD CONSTRAINT `fk_guest_guest_communication_guest_consent_record_id` FOREIGN KEY (`guest_consent_record_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ADD CONSTRAINT `fk_guest_guest_communication_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ADD CONSTRAINT `fk_guest_guest_communication_primary_guest_profile_id` FOREIGN KEY (`primary_guest_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`guest` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`guest` SET TAGS ('dbx_domain' = 'guest');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `location_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Location Identifier (PREFERRED_LOCATION_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Identifier (LOYALTY_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store Identifier (PREFERRED_STORE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `profile_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store Identifier (PREFERRED_STORE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDRESS_LINE2)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `average_check_value` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (AVG_CHECK)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `average_check_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `average_check_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_day` SET TAGS ('dbx_business_glossary_term' = 'Birthday Day (BIRTH_DAY)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_day` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_day` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_month` SET TAGS ('dbx_business_glossary_term' = 'Birthday Month (BIRTH_MONTH)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_month` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `birthday_month` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_email` SET TAGS ('dbx_business_glossary_term' = 'Email Marketing Consent (CONSENT_EMAIL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_privacy` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag (CONSENT_PRIVACY)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_privacy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS Marketing Consent (CONSENT_SMS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `consent_sms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Source System (DATA_SOURCE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'salesforce|olo|micros|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `data_source_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (DATA_SOURCE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Guest Email Address (EMAIL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Guest First Name (FIRST_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Full Name (FULL_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Guest Gender (GENDER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `guest_type` SET TAGS ('dbx_business_glossary_term' = 'Guest Type (TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `guest_type` SET TAGS ('dbx_value_regex' = 'guest|employee|vendor|franchisee|loyalty_member');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Last Name (LAST_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `last_visit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Visit Timestamp (LAST_VISIT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier (LOYALTY_TIER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'General Marketing Opt‑In (MARKETING_OPT_IN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `marketing_source` SET TAGS ('dbx_business_glossary_term' = 'Marketing Source (MARKETING_SOURCE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `marketing_source` SET TAGS ('dbx_value_regex' = 'in_store|online|app|third_party');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Free‑Form Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Guest Primary Phone Number (PHONE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `picture_url` SET TAGS ('dbx_business_glossary_term' = 'Profile Picture URL (PROFILE_PIC_URL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (POSTAL_CODE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language (LANGUAGE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method (CONTACT_METHOD)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|app_notification');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Guest Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|prospect|blocked|deceased');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_AT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_AT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_business_glossary_term' = 'Guest Secondary Phone Number (SECONDARY_PHONE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `secondary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_lifetime_visits` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Visits (LIFETIME_VISITS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Spend (TOTAL_SPENT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `identity_resolution_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Resolution Record ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Golden Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `identity_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Golden Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `member_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `member_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `data_source_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Data Source Confidence Score');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `duplicate_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Full Name');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|prefer_not_to_say');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `golden_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Golden Record Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `guest_status` SET TAGS ('dbx_business_glossary_term' = 'Guest Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `guest_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blacklisted');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `guest_type` SET TAGS ('dbx_business_glossary_term' = 'Guest Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `guest_type` SET TAGS ('dbx_value_regex' = 'guest|employee|vendor|franchisee|anonymous');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `last_interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|duplicate|pending');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `match_event_reason` SET TAGS ('dbx_business_glossary_term' = 'Match Event Reason');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `match_event_reason` SET TAGS ('dbx_value_regex' = 'new|update|reconcile');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `match_method` SET TAGS ('dbx_business_glossary_term' = 'Match Method');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `match_method` SET TAGS ('dbx_value_regex' = 'deterministic|probabilistic');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `merge_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Merge Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|mail');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `privacy_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Privacy Opt‑Out Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Marketing Segment');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `source_system_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source System Capture Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `total_lifetime_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Spend');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `total_lifetime_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`identity_resolution` ALTER COLUMN `total_lifetime_spend` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_profile_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `owner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Address Owner Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|invalid|pending');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|work|delivery|billing|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `county` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `county` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `district` SET TAGS ('dbx_business_glossary_term' = 'District');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `district` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `district` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `landmark` SET TAGS ('dbx_business_glossary_term' = 'Landmark');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `landmark` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `landmark` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `last_verified` SET TAGS ('dbx_business_glossary_term' = 'Address Last Verified Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Address Owner Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'guest|restaurant|franchise|vendor');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9 -]{3,10}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `region` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `suite_number` SET TAGS ('dbx_business_glossary_term' = 'Suite Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `suite_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `suite_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `validity_flag` SET TAGS ('dbx_business_glossary_term' = 'Address Validity Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Method');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'postal|third_party|self_report');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `verification_score` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Score');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Favorite Menu Item Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `communication_channel_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel Preference (Email, SMS, Push, None)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `communication_channel_preference` SET TAGS ('dbx_value_regex' = 'email|sms|push|none');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `data_source_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source System Timestamp for Preference Record');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `device_preference` SET TAGS ('dbx_business_glossary_term' = 'Device Preference (Kiosk, Mobile, Tablet)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `device_preference` SET TAGS ('dbx_value_regex' = 'kiosk|mobile|tablet');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `favorite_cuisine` SET TAGS ('dbx_business_glossary_term' = 'Favorite Cuisine Preference');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_dairy_allergy` SET TAGS ('dbx_business_glossary_term' = 'Dairy Allergy Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_gluten_allergy` SET TAGS ('dbx_business_glossary_term' = 'Gluten Allergy Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `has_nut_allergy` SET TAGS ('dbx_business_glossary_term' = 'Nut Allergy Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Preference Active Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `is_halal` SET TAGS ('dbx_business_glossary_term' = 'Halal Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `is_kosher` SET TAGS ('dbx_business_glossary_term' = 'Kosher Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Vegan Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `is_vegetarian` SET TAGS ('dbx_business_glossary_term' = 'Vegetarian Preference Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Level');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `marketing_opt_out_reason` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-Out Reason');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Preference Origin (Manual, System, Survey)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'manual|system|survey');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status (Active, Inactive, Archived)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_type` SET TAGS ('dbx_business_glossary_term' = 'Preference Type (e.g., Dietary, Cuisine, Menu Item, Service Channel, Daypart, Communication, Marketing, Loyalty, Other)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_daypart` SET TAGS ('dbx_business_glossary_term' = 'Preferred Daypart (Breakfast, Brunch, Lunch, Dinner, Late Night)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_daypart` SET TAGS ('dbx_value_regex' = 'breakfast|brunch|lunch|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method (Cash, Card, Mobile Pay)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_value_regex' = 'cash|card|mobilepay');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_seating` SET TAGS ('dbx_business_glossary_term' = 'Preferred Seating Preference');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_seating` SET TAGS ('dbx_value_regex' = 'indoor|outdoor|bar|window');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_service_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Service Channel (Dine-In, Drive-Thru, Online, Delivery)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preferred_service_channel` SET TAGS ('dbx_value_regex' = 'dine_in|drive_thru|online|delivery');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `privacy_consent_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Version Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `privacy_consent_version` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `privacy_consent_version` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Preference Value (raw value or description)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'opt_in|opt_out|implied');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_revoked_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Revoked Reason');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_revoked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Revoked Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_source_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Source Channel');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_source_channel` SET TAGS ('dbx_value_regex' = 'online|in_store|mobile_app|call_center|email');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|expired|pending');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing|sms|email|data_sharing|profiling');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `created` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `data_processing_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Scope');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `data_processing_scope` SET TAGS ('dbx_value_regex' = 'full|limited|custom');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_business_glossary_term' = 'Email Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `email_consent` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^([0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `marketing_consent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `privacy_notice_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Notice Version');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `sms_consent` SET TAGS ('dbx_business_glossary_term' = 'SMS Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `third_party_consent` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Data Sharing Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `updated` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for guest_guest_segment');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` ALTER COLUMN `guest_segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for guest_segment_membership');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Guest Segment Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_segment_membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Member Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Member Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verification_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verified` SET TAGS ('dbx_business_glossary_term' = 'Address Verified Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `address_verified` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `average_check_value` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (ACV)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `average_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Average Transaction Count (ATC)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `consent_privacy` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Household Dissolution Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `estimated_income_band` SET TAGS ('dbx_business_glossary_term' = 'Estimated Income Band');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `estimated_income_band` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `formation_date` SET TAGS ('dbx_business_glossary_term' = 'Household Formation Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_business_glossary_term' = 'Household Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_business_glossary_term' = 'Household Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_value_regex' = 'family|single|group|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `last_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `loyalty_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Enrolled Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt‑In Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_business_glossary_term' = 'Household Name');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Service Channel');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_value_regex' = 'dine_in|drive_thru|online|mobile|third_party');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Household Segment');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'high_value|mid_value|low_value|new|churn_risk');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `total_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Spend');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household` ALTER COLUMN `total_transactions` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Count');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_business_glossary_term' = 'Household Member ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `household_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `household_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `birthdate` SET TAGS ('dbx_business_glossary_term' = 'Birth Date (DOB)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `birthdate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `birthdate` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `consent_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Consent Opt-In Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `consent_opt_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Opt-In Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Departure Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|nonbinary|unspecified');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `is_primary_loyalty_holder` SET TAGS ('dbx_business_glossary_term' = 'Primary Loyalty Account Holder Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `join_date` SET TAGS ('dbx_business_glossary_term' = 'Join Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `loyalty_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Balance');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `member_status` SET TAGS ('dbx_business_glossary_term' = 'Member Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `member_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'family|friend|employee|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Member Role');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `role` SET TAGS ('dbx_value_regex' = 'primary|secondary|dependent');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`household_member` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `lifetime_value_id` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value Record Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `lifetime_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `lifetime_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `lifetime_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_check_value` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (USD)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_check_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_check_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_transactions_per_month` SET TAGS ('dbx_business_glossary_term' = 'Average Transactions Per Month');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `consent_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Data Consent Opt‑In Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `data_refresh_cycle` SET TAGS ('dbx_business_glossary_term' = 'Data Refresh Cycle');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `data_refresh_cycle` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `days_since_last_visit` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Visit');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `first_visit_date` SET TAGS ('dbx_business_glossary_term' = 'First Visit Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `loyalty_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `ltv_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value Calculation Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `ltv_last_updated` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `ltv_status` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `ltv_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `ltv_tier` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value Tier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `ltv_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `most_recent_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Most Recent Visit Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `predicted_future_value` SET TAGS ('dbx_business_glossary_term' = 'Predicted Future Lifetime Value (USD)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `predicted_future_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `predicted_future_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'high_value|medium_value|low_value|new|churn_risk');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `total_historical_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Historical Spend (USD)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `total_historical_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `total_historical_spend` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `total_visits` SET TAGS ('dbx_business_glossary_term' = 'Total Visits');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`lifetime_value` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` SET TAGS ('dbx_subdomain' = 'feedback_experience');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Survey ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_location_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Server Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Survey Comments');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'completed|partial|declined|not_sent');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|sms|in_app|receipt_qr');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Survey Language');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'csat|nps|post_delivery');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `visit_date` SET TAGS ('dbx_business_glossary_term' = 'Visit Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `visit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Visit Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` SET TAGS ('dbx_subdomain' = 'feedback_experience');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `survey_response_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Response ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `satisfaction_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `survey_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `survey_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `survey_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `survey_question_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Question ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `survey_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Is Anonymous');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `is_test_response` SET TAGS ('dbx_business_glossary_term' = 'Is Test Response');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `open_text` SET TAGS ('dbx_business_glossary_term' = 'Open Text Response');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `rating_scale_max` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Maximum');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `rating_score` SET TAGS ('dbx_business_glossary_term' = 'Rating Score');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_business_glossary_term' = 'Response Channel');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `response_channel` SET TAGS ('dbx_value_regex' = 'dine_in|drive_thru|online|mobile_app|kiosk');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `response_language` SET TAGS ('dbx_business_glossary_term' = 'Response Language');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `response_language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ja');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `response_sequence` SET TAGS ('dbx_business_glossary_term' = 'Response Sequence');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'completed|skipped|partial|invalid');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `response_type` SET TAGS ('dbx_business_glossary_term' = 'Response Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `response_type` SET TAGS ('dbx_value_regex' = 'rating|open_text|multiple_choice|scale|yes_no');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `response_value` SET TAGS ('dbx_business_glossary_term' = 'Response Value');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `selected_option` SET TAGS ('dbx_business_glossary_term' = 'Selected Option');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Label');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_value_regex' = 'negative|neutral|positive');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` SET TAGS ('dbx_subdomain' = 'feedback_experience');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_value_regex' = 'food_quality|speed_of_service|order_accuracy|cleanliness|staff_behavior|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Complaint Channel');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_store|drive_thru|phone|online|social_media|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Given');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `csat_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `escalated_to` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `privacy_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `record_created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `record_updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|resolved|closed|escalated');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'refund|replacement|apology|comp|none');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Complaint Severity Level');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|push|app|drive_thru|dine_in|online');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'open|click|view|order|checkin|visit');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `is_test` SET TAGS ('dbx_business_glossary_term' = 'Test Interaction Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'success|failure|skip|bounce|partial|unknown');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_identity_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identity ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_identity_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Identity Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_identity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_name` SET TAGS ('dbx_value_regex' = 'POS|OLO|Salesforce|ThirdParty|LoyaltyApp|Other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_email` SET TAGS ('dbx_business_glossary_term' = 'Channel User Email');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_name` SET TAGS ('dbx_business_glossary_term' = 'Channel User Name');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_phone` SET TAGS ('dbx_business_glossary_term' = 'Channel User Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `channel_user_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `consent_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Opt‑In');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `created_by_system` SET TAGS ('dbx_business_glossary_term' = 'Created By System');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `external_identifier` SET TAGS ('dbx_business_glossary_term' = 'External Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `external_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `external_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'email|phone|loyalty_card|device_id|third_party_id|account_number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Channel Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `is_test_account` SET TAGS ('dbx_business_glossary_term' = 'Is Test Account Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `last_updated_by_system` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By System');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Channel Identity Notes');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `privacy_status` SET TAGS ('dbx_business_glossary_term' = 'Privacy Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'current|archived|deleted');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `source_system_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source System Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `source_system_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source System Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`channel_identity` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone|in_store|none');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `demographic_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `demographic_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `age_band` SET TAGS ('dbx_business_glossary_term' = 'Age Band (AGE_BAND)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `consent_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Consent Opt‑In (CONSENT_OPT_IN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `consent_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Consent Opt‑Out (CONSENT_OPT_OUT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source (DATA_SOURCE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'self_declared|third_party');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `demographic_type` SET TAGS ('dbx_business_glossary_term' = 'Demographic Type (DEMOGRAPHIC_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `demographic_type` SET TAGS ('dbx_value_regex' = 'resident|visitor|tourist|employee|contractor|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `education_level` SET TAGS ('dbx_business_glossary_term' = 'Education Level (EDUCATION_LEVEL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL_ADDRESS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status (EMPLOYMENT_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'employed|unemployed|student|retired|self_employed|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `enrichment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrichment Date (ENRICHMENT_DATE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `enrichment_provider` SET TAGS ('dbx_business_glossary_term' = 'Enrichment Provider (ENRICHMENT_PROVIDER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity (ETHNICITY)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity_source` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity Source (ETHNICITY_SOURCE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity_source` SET TAGS ('dbx_value_regex' = 'self|inferred|third_party');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity_source` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `ethnicity_source` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name (FULL_NAME)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `gender_identity` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity (GENDER_IDENTITY)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `gender_identity` SET TAGS ('dbx_value_regex' = 'male|female|nonbinary|prefer_not_to_say|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `gender_identity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `gender_identity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Classification (GEOGRAPHIC_MARKET)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `geographic_market` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|airport|college_town|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `household_income_band` SET TAGS ('dbx_business_glossary_term' = 'Household Income Band (HOUSEHOLD_INCOME_BAND)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `household_income_band` SET TAGS ('dbx_value_regex' = '0-25k|25-50k|50-75k|75-100k|100-150k|150k+');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANGUAGE_PREFERENCE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status (MARITAL_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|partnered|other');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `number_of_children` SET TAGS ('dbx_business_glossary_term' = 'Number of Children (NUMBER_OF_CHILDREN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PHONE_NUMBER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created (RECORD_AUDIT_CREATED)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated (RECORD_AUDIT_UPDATED)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (RECORD_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`demographic` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ALTER COLUMN `guest_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for guest_visit');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Host Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_visit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ALTER COLUMN `guest_allergen_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for guest_allergen_profile');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_allergen_profile` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `digital_account_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Account ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number (ACC_NUM)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier (TIER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'basic|silver|gold|platinum');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `app_version` SET TAGS ('dbx_business_glossary_term' = 'Application Version (APP_VER)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `consent_marketing` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent (MKT_CONSENT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `consent_third_party` SET TAGS ('dbx_business_glossary_term' = 'Third‑Party Data Sharing Consent (3P_CONSENT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type (DEV_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|kiosk');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `digital_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `digital_account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|deactivated|pending');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `failed_login_attempts` SET TAGS ('dbx_business_glossary_term' = 'Failed Login Attempts (FAIL_LOGIN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp (LAST_LOGIN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `lockout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Lockout Timestamp (LOCKOUT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `password_last_changed` SET TAGS ('dbx_business_glossary_term' = 'Password Last Changed Date (PWD_CHG)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PHONE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `privacy_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Privacy Opt‑Out (PRIV_OPT_OUT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `registration_channel` SET TAGS ('dbx_business_glossary_term' = 'Registration Channel (REG_CHAN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `registration_channel` SET TAGS ('dbx_value_regex' = 'app|website|olo|kiosk|in_store');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `two_factor_enabled` SET TAGS ('dbx_business_glossary_term' = 'Two‑Factor Authentication Enabled (2FA_EN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `username` SET TAGS ('dbx_business_glossary_term' = 'Username (UN)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `username` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`digital_account` ALTER COLUMN `username` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `superseded_consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Consent Policy Id');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `superseded_consent_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `analytics_opt_in_allowed` SET TAGS ('dbx_business_glossary_term' = 'Analytics Opt In Allowed');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Channel');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `consent_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Consent Mechanism');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `consent_revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Revocation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `data_processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Purpose');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `marketing_opt_in_allowed` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt In Allowed');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `privacy_law` SET TAGS ('dbx_business_glossary_term' = 'Privacy Law');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `consent_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `third_party_sharing_allowed` SET TAGS ('dbx_business_glossary_term' = 'Third Party Sharing Allowed');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` SET TAGS ('dbx_subdomain' = 'feedback_experience');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `survey_question_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Question Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `parent_survey_question_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Survey Question Id');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `parent_survey_question_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `survey_question_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Is Anonymous');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `is_required` SET TAGS ('dbx_business_glossary_term' = 'Is Required');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `max_response_length` SET TAGS ('dbx_business_glossary_term' = 'Max Response Length');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `question_text` SET TAGS ('dbx_business_glossary_term' = 'Question Text');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `question_type` SET TAGS ('dbx_business_glossary_term' = 'Question Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `response_options` SET TAGS ('dbx_business_glossary_term' = 'Response Options');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `response_scale` SET TAGS ('dbx_business_glossary_term' = 'Response Scale');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `survey_question_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Subcategory');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`survey_question` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` SET TAGS ('dbx_subdomain' = 'engagement_analytics');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `parent_corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Corporate Account Id');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `parent_corporate_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidentiality' = 'confidential');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `annual_spend_estimate` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Estimate');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line1');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `consent_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Consent Opt In');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `industry_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `loyalty_program_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Enrolled');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt In');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `number_of_locations` SET TAGS ('dbx_business_glossary_term' = 'Number Of Locations');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line1');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_city` SET TAGS ('dbx_business_glossary_term' = 'Shipping City');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_country` SET TAGS ('dbx_business_glossary_term' = 'Shipping Country');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Postal Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_state` SET TAGS ('dbx_business_glossary_term' = 'Shipping State');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `shipping_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `corporate_account_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`corporate_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` SET TAGS ('dbx_subdomain' = 'privacy_compliance');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `guest_communication_id` SET TAGS ('dbx_business_glossary_term' = 'Communication ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `content_template_id` SET TAGS ('dbx_business_glossary_term' = 'Content Template ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `guest_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `primary_guest_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel (CHANNEL)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|direct_mail|in_app|social');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `click_status` SET TAGS ('dbx_business_glossary_term' = 'Click‑Through Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `click_status` SET TAGS ('dbx_value_regex' = 'clicked|not_clicked|unknown');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|bounced|failed');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Communication Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ja');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `message_body_preview` SET TAGS ('dbx_business_glossary_term' = 'Message Body Preview');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `open_status` SET TAGS ('dbx_business_glossary_term' = 'Open Status');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `open_status` SET TAGS ('dbx_value_regex' = 'opened|not_opened|unknown');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Communication Priority');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `scheduled_send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Send Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `send_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Send Attempt Count');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Communication Subject');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `tracking_url` SET TAGS ('dbx_business_glossary_term' = 'Tracking URL');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Trigger Source');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `trigger_source` SET TAGS ('dbx_value_regex' = 'order_confirmation|loyalty|promotional|transactional|survey|feedback');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `unsubscribe_flag` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribe Flag');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`guest_communication` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
