-- Schema for Domain: guest | Business: Restaurants | Version: v2_mvm
-- Generated on: 2026-07-10 20:02:54

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`guest` COMMENT 'Single source of truth for customer identity, profiles, preferences, demographics, segments, loyalty membership, and guest engagement across all channels (dine-in, drive-thru, online ordering). Manages CSAT, NPS, lifetime value, and consent/privacy management. Master record for WHO the business serves.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique surrogate key for the guest profile record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Corporate accounts are a B2B guest entity; linking profile to corporate_account enables reporting of corporate guest activity and eliminates the isolated corporate_account table.',
    `location_profile_id` BIGINT COMMENT 'Identifier of the location the guest most frequently visits.',
    `program_id` BIGINT COMMENT 'Identifier of the loyalty program membership associated with the guest.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: guest.profile carries a denormalized loyalty_tier label. A proper FK to loyalty.tier enforces referential integrity and enables tier-based profile segmentation reports (e.g., active profiles by tie',
    `unit_id` BIGINT COMMENT 'Identifier of the specific store the guest prefers.',
    `profile_unit_id` BIGINT COMMENT 'Identifier of the specific store the guest prefers.',
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
    `state` STRING COMMENT 'State or province of the guests mailing address.',
    `total_lifetime_visits` STRING COMMENT 'Cumulative count of all visits (in‑store, drive‑thru, online) made by the guest.',
    `total_spent` DECIMAL(18,2) COMMENT 'Aggregate monetary amount the guest has spent across all transactions.',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Master record for every guest identity across all service channels (dine-in, drive-thru, OLO, 3PD). Single source of truth for WHO the business serves — captures full identity and demographic attributes including name, contact details, date of birth, language preference, age band, gender identity, household income band, education level, employment status, geographic market classification, demographic data source (self-declared vs. third-party enrichment), enrichment provider and date. Also owns digital account attributes: username, account status (active/suspended/deactivated), registration date, registration channel, last login timestamp, device type, app version, two-factor authentication status, and account tier. Sourced primarily from Salesforce CRM, Olo Digital Ordering Platform, and brand mobile app. This is the anchor entity for the entire guest domain.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`address` (
    `address_id` BIGINT COMMENT 'System-generated unique identifier for the address record.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this address belongs.',
    `address_profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this address belongs.',
    `owner_profile_id` BIGINT COMMENT 'Identifier of the owning entity (guest, restaurant, etc.).',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Delivery routing and franchise territory management require knowing which restaurant unit serves a specific guest address. Used in delivery radius matching, local marketing geo-targeting, and order ro',
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
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: In multi-brand restaurant groups, guest preferences (dietary restrictions, service channel, daypart) are brand-specific. Brand-level preference segmentation drives targeted marketing campaigns and bra',
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
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Consent records are frequently program-scoped — a guest consents to marketing specifically for a loyalty program. GDPR/CCPA compliance requires program-specific consent audit trails. Loyalty program m',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: GDPR/CCPA compliance requires knowing WHERE consent was captured (in-store kiosk, POS sign-up). Regulatory audits and data residency reporting depend on tracing consent records to the specific restaur',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to restaurant.pos_terminal. Business justification: PCI DSS and privacy compliance audits require tracing consent capture to the specific POS terminal (kiosk, register). The existing `device_code` plain attribute is a denormalized reference; a proper F',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest to whom this consent applies.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` (
    `satisfaction_survey_id` BIGINT COMMENT 'Unique identifier for each satisfaction survey instance.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to restaurant.pos_terminal. Business justification: Surveys triggered via POS receipt QR codes or kiosk prompts must be attributed to the specific terminal for terminal-level CSAT/NPS reporting. This supports equipment performance analysis and identifi',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who received the survey.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the guest experience occurred.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for Service Quality Dashboard linking survey scores to the serving employee, supporting performance coaching and bonus calculations.',
    `guest_order_id` BIGINT COMMENT 'Foreign key linking to order.guest_order. Business justification: Post-transaction CSAT/NPS surveys are triggered by specific orders. Operations teams run survey-to-order reconciliation to tie satisfaction scores to order type, channel, daypart, and server. guest_vi',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Shift-level CSAT/NPS reporting is a standard restaurant operations KPI. Linking a satisfaction survey to the shift during which the guest experience occurred enables direct correlation of staffing lev',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Loyalty programs trigger post-visit surveys for enrolled members. Linking survey to member enables NPS/CSAT by loyalty tier reporting and member-level survey deduplication — a standard loyalty analy',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Post-purchase satisfaction surveys are frequently triggered by a specific menu item (LTO launch tracking, new product NPS). Menu engineering and product development teams require item-level CSAT/NPS d',
    `tertiary_satisfaction_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the guest experience occurred.',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: A satisfaction survey is always triggered by and associated with a specific guest visit. Adding guest_visit_id to satisfaction_survey creates a direct structural link between the feedback record and t',
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
    CONSTRAINT pk_satisfaction_survey PRIMARY KEY(`satisfaction_survey_id`)
) COMMENT 'Records guest satisfaction survey instances with full question-level response detail. Captures survey type (CSAT, NPS, post-delivery, post-visit), delivery channel (email, SMS, in-app, receipt QR), delivery timestamp, completion status, NPS score (0-10), CSAT score, restaurant unit, daypart, and respondent profile. Includes granular question-level data: question text, question type (rating, open-text, multiple-choice), response value, response timestamp, and sentiment classification for open-text responses. Sourced from Salesforce CRM and Olo guest feedback flows. Enables CSAT/NPS driver analysis at both survey and question level, supporting operational improvement across FOH and BOH.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`complaint` (
    `complaint_id` BIGINT COMMENT 'System-generated unique identifier for the complaint record.',
    `allergen_declaration_id` BIGINT COMMENT 'Foreign key linking to menu.allergen_declaration. Business justification: Allergen-related guest complaints require direct reference to the active allergen declaration for the implicated item to support regulatory compliance, food safety incident investigation, and legal de',
    `allergen_incident_id` BIGINT COMMENT 'Foreign key linking to foodsafety.allergen_incident. Business justification: When a guest reports an allergic reaction, both a complaint record and an allergen_incident record are created. Linking them enables FDA MedWatch traceability, legal resolution tracking, and regulator',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Loyalty member complaints trigger member-specific resolution workflows — compensatory points awards, tier protection, escalation rules by tier. Complaints by tier is a standard loyalty operations re',
    `profile_id` BIGINT COMMENT 'Unique identifier of the guest who raised the complaint.',
    `complaint_profile_id` BIGINT COMMENT 'Unique identifier of the guest who raised the complaint.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the complaint originated.',
    `complaint_unit_id` BIGINT COMMENT 'Identifier of the restaurant location where the complaint originated.',
    `equipment_asset_id` BIGINT COMMENT 'Foreign key linking to restaurant.equipment_asset. Business justification: HACCP and food safety regulations require linking food quality/safety complaints to the specific equipment implicated (e.g., malfunctioning fryer, broken refrigeration unit). Supports regulatory inves',
    `guest_order_id` BIGINT COMMENT 'Identifier of the order associated with the complaint, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Complaint Resolution Report that assigns a responsible employee to each complaint, enabling accountability and SLA tracking.',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Needed for food safety incident tracking: associating complaints with the specific ingredient allows root‑cause analysis, recall decisions, and FDA reporting.',
    `ingredient_lot_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient_lot. Business justification: Food safety complaint traceability: when a guest reports illness or allergen reaction, regulators (FDA FSMA) require identifying the exact ingredient lot/batch served. This FK enables recall managemen',
    `order_item_id` BIGINT COMMENT 'Foreign key linking to order.order_item. Business justification: Food safety and quality complaints are item-specific (allergen incident, foreign object, wrong item). Item-level complaint tracking enables PMIX-level quality reports and ingredient-lot traceability f',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to restaurant.pos_terminal. Business justification: Complaints about transaction errors, payment failures, or order inaccuracies are traced to the originating POS terminal for root cause analysis. Terminal-level complaint clustering identifies malfunct',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Complaint-by-shift analysis is a core restaurant operations report used to identify understaffing events, crew performance issues, and high-incident shifts. Linking a complaint to the shift during whi',
    `stock_item_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_item. Business justification: Food safety complaint management requires linking guest complaints to specific inventory SKUs for HACCP traceability, recall investigations, and regulatory reporting. A restaurant operations expert ex',
    `visit_id` BIGINT COMMENT 'Foreign key linking to guest.guest_visit. Business justification: A guest complaint is frequently raised about a specific visit experience (wrong order, service failure, food quality issue during a dine-in or drive-thru visit). Linking complaint to guest_visit via g',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: In‑Restaurant Interaction Log tracks the employee handling each guest interaction, required for training effectiveness and KPI reporting.',
    `guest_order_id` BIGINT COMMENT 'Foreign key linking to order.guest_order. Business justification: CRM service-recovery and loyalty interactions are triggered by specific orders. Linking interaction to guest_order enables interaction-to-order attribution for marketing ROI reporting and service reco',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Marketing interactions (email, push, SMS) are member-targeted in loyalty programs. Linking interaction to member enables member-level campaign response tracking, opt-out compliance per member account,',
    `profile_id` BIGINT COMMENT 'Surrogate identifier of the guest who generated the interaction.',
    `interaction_profile_id` BIGINT COMMENT 'Surrogate identifier of the guest who generated the interaction.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the interaction took place, if applicable.',
    `interaction_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where the interaction took place, if applicable.',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Guest digital interactions (menu browsing, item inquiry, promotional click-through) are tied to specific menu items for personalization engines, targeted marketing campaigns, and digital engagement an',
    `offer_id` BIGINT COMMENT 'Foreign key linking to loyalty.offer. Business justification: Guest interactions (email sends, push notifications) are frequently tied to specific loyalty offers. Linking interaction to offer enables offer-response rate tracking and campaign attribution reportin',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to restaurant.pos_terminal. Business justification: Loyalty scans, kiosk engagements, and digital interactions occur at specific POS terminals. Terminal-level engagement analytics and channel attribution reporting require linking interactions to the or',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Marketing effectiveness analysis attributes guest interactions to the franchisee that ran the campaign.',
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

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`guest`.`visit` (
    `visit_id` BIGINT COMMENT 'Unique identifier for the guest_visit data product (auto-inserted pre-linking).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Guest Flow Management records which host/hostess greeted the guest, essential for staffing analysis and guest experience metrics.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to restaurant.pos_terminal. Business justification: Guest visits are recorded at check-in or transaction at a specific POS terminal. Terminal-level visit attribution supports loyalty check-in analytics, throughput reporting per terminal, and dwell time',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: guest_visit must reference the guest profile to associate each visit with a guest.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to workforce.shift. Business justification: Visit-volume-per-shift is a foundational restaurant labor analytics metric used to optimize staffing. Linking guest_visit to the shift during which it occurred enables covers-per-labor-hour, average c',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Visit analytics require linking each guest visit to the exact restaurant unit for performance dashboards and service‑speed KPI calculations.',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Visit records for loyalty members are the basis for points accrual and tier qualification (visit-count thresholds). Linking guest_visit to member enables visits per member per period reporting and a',
    CONSTRAINT pk_visit PRIMARY KEY(`visit_id`)
) COMMENT 'Captures each confirmed guest visit to a restaurant unit across all service modes (dine-in, DT, OLO, 3PD). Distinct from the order domains order transaction — this is the guest-centric visit record that may span multiple orders or be a zero-spend visit (e.g., complaint resolution visit). Captures visit date, daypart, service mode, restaurant unit, party size (cover count), table number (dine-in), DT lane (drive-thru), visit duration, and whether the visit was incentivized by a promotion.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_address_profile_id` FOREIGN KEY (`address_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ADD CONSTRAINT `fk_guest_address_owner_profile_id` FOREIGN KEY (`owner_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_preference_profile_id` FOREIGN KEY (`preference_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`visit`(`visit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_complaint_profile_id` FOREIGN KEY (`complaint_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`visit`(`visit_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ADD CONSTRAINT `fk_guest_interaction_interaction_profile_id` FOREIGN KEY (`interaction_profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_restaurants_v1`.`guest`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`guest` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_restaurants_v1`.`guest` SET TAGS ('dbx_domain' = 'guest');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `location_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Location Identifier (PREFERRED_LOCATION_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Identifier (LOYALTY_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Loyalty Tier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store Identifier (PREFERRED_STORE_ID)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `profile_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Store Identifier (PREFERRED_STORE_ID)');
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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_lifetime_visits` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Visits (LIFETIME_VISITS)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_business_glossary_term' = 'Total Lifetime Spend (TOTAL_SPENT)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`profile` ALTER COLUMN `total_spent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` SET TAGS ('dbx_subdomain' = 'guest_identity');
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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`address` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Unit Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`preference` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Program Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`consent_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` SET TAGS ('dbx_subdomain' = 'engagement_feedback');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Survey ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Server Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Guest Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyed Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyed Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `tertiary_satisfaction_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`satisfaction_survey` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` SET TAGS ('dbx_subdomain' = 'engagement_feedback');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `allergen_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `allergen_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Incident Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Complaining Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `complaint_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `equipment_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Asset Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `ingredient_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `order_item_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Order Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `stock_item_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Stock Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`complaint` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Visit Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` SET TAGS ('dbx_subdomain' = 'engagement_feedback');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction ID');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `guest_order_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Guest Order Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Interacted Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `interaction_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit Identifier');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Offer Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`interaction` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
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
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` SET TAGS ('dbx_subdomain' = 'engagement_feedback');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for guest_visit');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Host Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Shift Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Visiting Member Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`guest`.`visit` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
