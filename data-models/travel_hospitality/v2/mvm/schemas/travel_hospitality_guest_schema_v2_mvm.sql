-- Schema for Domain: guest | Business: Travel_Hospitality | Version: v2_mvm
-- Generated on: 2026-06-27 02:37:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`guest` COMMENT 'Single source of truth for guest identity, profiles, preferences, contact information, demographics, stay history, and segmentation across all properties and brands. Manages individual travelers, corporate accounts, group contacts, and VIP profiles. Supports FIT, corporate, and group guest types. Integrates with CRM (Salesforce) and loyalty platforms for unified guest view and lifetime value tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique surrogate identifier for the guest master profile record in the lakehouse silver layer. This is the primary key and golden record anchor for all guest identity resolution across properties and brands. Role: MASTER_PARTY.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to guest.corporate_account. Business justification: A guest profile representing a corporate traveler belongs to one corporate account. Adding corporate_account_id to profile normalizes the company affiliation — the existing company_name string on prof',
    `merged_into_profile_id` BIGINT COMMENT 'When profile_status = merged, this field references the survivor profile_id into which this record was consolidated. Enables audit trail of merge lineage and supports identity resolution queries across the guest domain.',
    `accessibility_needs` STRING COMMENT 'Free-text or coded description of the guests accessibility requirements (e.g., wheelchair accessible room, roll-in shower, hearing loop, visual impairment aids). Drives ADA-compliant room assignment and service delivery. Treated as sensitive personal data.',
    `address` STRING COMMENT 'The address of the profile.',
    `birth_date` DATE COMMENT 'The guests date of birth in ISO 8601 format (yyyy-MM-dd). Used for age verification, birthday recognition programs, loyalty tier benefits, and regulatory identity verification at check-in.',
    `country_of_residence_code` STRING COMMENT 'The guests country of permanent residence as an ISO 3166-1 alpha-3 code. Distinct from nationality; used for geographic segmentation, GDPR/CCPA jurisdiction determination, and source market analytics.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the guest master profile record was first created in the source system of record (Oracle OPERA PMS or Salesforce CRM). Expressed in ISO 8601 format with timezone offset. Satisfies RECORD_AUDIT_CREATED requirement for MASTER_PARTY role.',
    `creation_property_code` STRING COMMENT 'The property code (hotel/resort identifier) at which this guest profile was originally created in the PMS. Used for cross-property profile governance, data stewardship assignment, and origin analytics.',
    `crm_contact_reference` STRING COMMENT 'The native contact identifier assigned by Salesforce CRM for this guest. Enables bi-directional synchronization between the PMS golden record and the CRM guest profile for marketing, loyalty, and case management workflows.',
    `data_privacy_consent_date` DATE COMMENT 'The date on which the guest provided or last renewed their data privacy consent. Required for GDPR and CCPA compliance audit trails, consent expiry management, and regulatory reporting.',
    `email` STRING COMMENT 'The primary email address for the guest used for reservation confirmations, pre-arrival communications, loyalty program notifications, and post-stay surveys via Medallia. Subject to GDPR and CCPA consent management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_opt_in` BOOLEAN COMMENT 'Granular consent flag specifically for email marketing communications, separate from the overall marketing opt-in. Supports channel-specific consent management as required by GDPR, CCPA, and CAN-SPAM regulations.',
    `family_name` STRING COMMENT 'The guests legal family name (surname) as captured at check-in or profile creation. Used for identity verification, folio generation, and cross-property guest recognition.',
    `gdpr_erasure_requested` BOOLEAN COMMENT 'Indicates whether the guest has submitted a GDPR Article 17 Right to Erasure (Right to be Forgotten) request. True = erasure request received and pending or in-process. Triggers data suppression workflows and prevents further marketing processing.',
    `gender` STRING COMMENT 'The guests self-identified gender code: M=Male, F=Female, X=Non-binary/Other, U=Undisclosed. Used for personalization, regulatory reporting in certain jurisdictions, and demographic analytics.. Valid values are `M|F|X|U`',
    `given_name` STRING COMMENT 'The guests legal given name (first name) as captured at check-in or profile creation. Used for personalized guest recognition, folios, and correspondence across all properties.',
    `guest_type` STRING COMMENT 'Classification of the guest by travel purpose and booking relationship: FIT (Free Independent Traveler), CORPORATE (business traveler under corporate account), GROUP (group block participant), CREW (airline/transport crew), TRAVEL_AGENT, VIP. Drives rate eligibility, service protocols, and reporting segmentation. [ENUM-REF-CANDIDATE: FIT|CORPORATE|GROUP|CREW|TRAVEL_AGENT|VIP|WHOLESALE|GOVERNMENT — promote to reference product]. Valid values are `FIT|CORPORATE|GROUP|CREW|TRAVEL_AGENT|VIP`',
    `is_merge_survivor` BOOLEAN COMMENT 'Indicates whether this profile record is the surviving (golden) record following a guest profile merge operation. True = this is the authoritative survivor record; False = this is a source or non-survivor record. Critical for identity resolution and deduplication governance.',
    `job_title` STRING COMMENT 'The professional job title of the guest as provided during profile creation or CRM synchronization. Supports corporate account management, MICE event coordination, and personalized service delivery for business travelers.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to the guest profile record in the source system. Used for change data capture (CDC), ETL incremental loads, and audit trail compliance.',
    `loyalty_enrollment_date` DATE COMMENT 'The date on which the guest enrolled in the loyalty program. Used to calculate member tenure, tier qualification windows, and anniversary recognition benefits.',
    `loyalty_member_number` STRING COMMENT 'The guests loyalty program membership number assigned by the central loyalty platform (Salesforce CRM / loyalty engine). The primary identifier linking the guest profile to loyalty tier, points balance, and rewards history.',
    `loyalty_tier` STRING COMMENT 'The guests current loyalty program tier level, determining benefit eligibility, upgrade priority, and service recognition protocols. Tiers progress from NONE (non-member) through SILVER, GOLD, PLATINUM, to DIAMOND (highest).. Valid values are `NONE|SILVER|GOLD|PLATINUM|DIAMOND`',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the guest has provided explicit consent to receive marketing communications (email, SMS, direct mail). True = opted in; False = opted out or no consent given. Mandatory for GDPR and CCPA compliance in marketing campaign execution.',
    `middle_name` STRING COMMENT 'The guests middle name or initial as provided. Supports full legal name matching for identity verification, passport validation, and regulatory compliance.',
    `mobile_phone` STRING COMMENT 'The guests mobile/cell phone number in E.164 format. Used for SMS pre-arrival messaging, mobile check-in notifications, and digital key delivery.. Valid values are `^+?[1-9]d{1,14}$`',
    `name_prefix` STRING COMMENT 'Honorific or salutation prefix for the guest (e.g., Mr, Mrs, Dr). Used in personalized correspondence, folio headers, and VIP recognition communications. [ENUM-REF-CANDIDATE: Mr|Mrs|Ms|Miss|Dr|Prof|Sir|Rev — 8 candidates stripped; promote to reference product]',
    `name_suffix` STRING COMMENT 'Name suffix for the guest (e.g., Jr., Sr., III, PhD). Supports full legal name representation for identity documents and formal correspondence.',
    `nationality_country_code` STRING COMMENT 'The guests nationality expressed as an ISO 3166-1 alpha-3 three-letter country code (e.g., USA, GBR, DEU). Required for regulatory reporting, visa compliance, and international guest analytics.. Valid values are `^[A-Z]{3}$`',
    `opera_profile_reference` STRING COMMENT 'The native guest profile identifier assigned by Oracle OPERA Property Management System (PMS). Used for cross-system reconciliation and source-system traceability back to the PMS guest profile record.',
    `passport_expiry_date` DATE COMMENT 'The expiration date of the guests passport document. Used to validate document currency at check-in and for regulatory compliance in jurisdictions requiring valid travel document verification.',
    `passport_issuing_country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code of the authority that issued the guests passport. Required for immigration compliance and international guest regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `passport_number` STRING COMMENT 'The guests passport document number as presented at check-in. Required for international guest identity verification, regulatory reporting to local authorities, and compliance with immigration laws in applicable jurisdictions.',
    `phone` STRING COMMENT 'The primary contact phone number for the guest in E.164 international format. Used for reservation confirmations, pre-arrival contact, and service recovery outreach.. Valid values are `^+?[1-9]d{1,14}$`',
    `preferred_bed_type` STRING COMMENT 'The guests preferred bed configuration for room assignment: KING, QUEEN, DOUBLE, TWIN, or SINGLE. Used during pre-arrival room blocking and at check-in to maximize guest satisfaction.. Valid values are `KING|QUEEN|DOUBLE|TWIN|SINGLE`',
    `preferred_floor` STRING COMMENT 'The guests preferred floor level or floor range for room assignment (e.g., high floor, low floor, specific floor number). Captured from guest preferences in OPERA PMS and used during pre-arrival room blocking.',
    `preferred_language_code` STRING COMMENT 'The guests preferred communication language expressed as an ISO 639-1 two-letter language code (e.g., en, fr, de, zh). Drives language selection for folios, correspondence, digital communications, and on-property service delivery.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `profile_status` STRING COMMENT 'Current lifecycle state of the guest master profile: active (in use), inactive (dormant, no recent stays), merged (absorbed into a survivor record), suspended (temporarily blocked), deceased (confirmed deceased, retained for audit). Governs record visibility and processing eligibility.. Valid values are `active|inactive|merged|suspended|deceased`',
    `smoking_preference` STRING COMMENT 'The guests smoking preference for room assignment: NON_SMOKING, SMOKING (where available), or NO_PREFERENCE. Used during pre-arrival room blocking and check-in assignment to comply with guest preferences and property smoking policies.. Valid values are `NON_SMOKING|SMOKING|NO_PREFERENCE`',
    `sms_opt_in` BOOLEAN COMMENT 'Granular consent flag specifically for SMS/text message marketing communications. Supports channel-specific consent management as required by GDPR, CCPA, and TCPA (Telephone Consumer Protection Act) regulations.',
    `vip_status` STRING COMMENT 'The VIP designation level assigned to the guest in Oracle OPERA PMS, indicating the tier of elevated service protocols to apply at check-in and throughout the stay. NONE=standard guest, VIP1-VIP3=escalating VIP tiers, VVIP=highest recognition, BLACKLIST=do-not-accommodate flag.. Valid values are `NONE|VIP1|VIP2|VIP3|VVIP|BLACKLIST`',
    CONSTRAINT pk_profile PRIMARY KEY(`profile_id`)
) COMMENT 'Single source of truth for guest identity and master profile data across all properties and brands. Captures individual traveler identity including full name, date of birth, nationality, passport/ID details, gender, language preference, and VIP status flag. Stores profile source system origin, creation property, last-updated timestamp, merge survivor status, and active/inactive lifecycle state. Sourced from Oracle OPERA PMS (Guest Profiles) and Salesforce CRM. Serves FIT, corporate, and group guest types. The authoritative golden record for all guest identity resolution, cross-property recognition, and lifetime value tracking. All other guest-domain products reference this entity as their parent.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` (
    `contact_info_id` BIGINT COMMENT 'Unique surrogate identifier for each guest contact information record in the Silver Layer lakehouse. Primary key for the contact_info data product. Sourced from Salesforce CRM and Oracle OPERA PMS guest profile modules.',
    `profile_id` BIGINT COMMENT 'Reference to the parent guest profile record to which this contact information belongs. Supports multiple contact records per guest (primary, secondary, work, home). Sourced from Oracle OPERA PMS guest profile and Salesforce CRM.',
    `address_line1` STRING COMMENT 'Primary street address line for the guests mailing, billing, or home address. Includes street number and street name. Used for billing correspondence, loyalty program mailings, and address validation. Sourced from OPERA PMS and Salesforce CRM.',
    `address_line2` STRING COMMENT 'Secondary street address line for the guests postal address. Captures apartment number, suite, floor, building name, or other secondary address components. Optional field used when the primary address line is insufficient.',
    `address_type` STRING COMMENT 'Classification of the postal address indicating its purpose: home residence, billing address for invoices and folios, mailing address for correspondence, or work/corporate address. Determines which address is used for loyalty program mailings and billing statements.. Valid values are `home|billing|mailing|work|other`',
    `address_validated_date` DATE COMMENT 'Date on which the postal address was last validated against an authoritative address verification service. Used to determine whether re-validation is required based on data freshness policies and returned mail events.',
    `address_validation_status` STRING COMMENT 'Status of the postal address validation check performed against authoritative address databases (e.g., USPS, Royal Mail, Canada Post). Validated addresses improve direct mail deliverability and reduce returned loyalty program correspondence.. Valid values are `validated|unvalidated|failed|corrected`',
    `bounce_reason` STRING COMMENT 'Reason code for why a contact record has been marked as bounced or undeliverable. Hard bounces indicate permanent delivery failures (invalid email/address); soft bounces indicate temporary failures. Used to maintain list hygiene and comply with email deliverability best practices.. Valid values are `hard_bounce|soft_bounce|spam_complaint|invalid_address|unsubscribed`',
    `city` STRING COMMENT 'City or municipality of the guests postal address. Used for geographic segmentation, demand forecasting by feeder market, and targeted marketing campaigns. Part of the full international address structure.',
    `contact_channel` STRING COMMENT 'The communication channel category this contact record represents: email, phone, postal address, social media handle, or digital messaging platform. Enables multi-channel guest communication strategy and analytics.. Valid values are `email|phone|postal|social|messaging`',
    `contact_status` STRING COMMENT 'Current lifecycle status of this contact record. Active records are used for communications; bounced or undeliverable records indicate failed delivery attempts; suppressed records are excluded from all outbound communications per regulatory or guest request. Sourced from Salesforce CRM and OPERA PMS.. Valid values are `active|inactive|bounced|undeliverable|suppressed`',
    `contact_type` STRING COMMENT 'Classification of the contact record indicating its role relative to the guest profile. Determines which record is used for reservation confirmations, marketing communications, billing, and emergency notifications. [ENUM-REF-CANDIDATE: primary|secondary|work|home|billing|emergency — promote to reference product if additional types are required]. Valid values are `primary|secondary|work|home|billing|emergency`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the guests address (e.g., USA, GBR, DEU). Used for international address formatting, GDPR/CCPA jurisdiction determination, feeder market analytics, and channel distribution reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact information record was first created in the system of record. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, GDPR consent audit trails, and data quality monitoring.',
    `data_retention_expiry_date` DATE COMMENT 'Date on which this contact record is scheduled for deletion or anonymization per the applicable data retention policy. Calculated based on the last guest interaction date plus the retention period defined by GDPR, CCPA, or local data protection regulations. Supports automated data lifecycle management.',
    `do_not_contact` BOOLEAN COMMENT 'Indicates that the guest has explicitly requested no contact via this channel, regardless of opt-in status. Overrides all marketing and transactional communication flags. Must be honored immediately upon receipt per GDPR Article 21 (right to object) and CCPA.',
    `email_address` STRING COMMENT 'Guest email address used for reservation confirmations, pre-arrival communications, loyalty program notifications, and marketing campaigns. Sourced from Salesforce CRM and OPERA PMS. Subject to GDPR, CCPA opt-in/opt-out controls.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_type` STRING COMMENT 'Classification of the email address indicating whether it is a personal, work/corporate, or other email account. Supports segmentation for FIT versus corporate guest communications and loyalty program targeting.. Valid values are `personal|work|other`',
    `gdpr_lawful_basis` STRING COMMENT 'The GDPR Article 6 lawful basis under which this contact record is processed. Required for all guest contact data belonging to EU/EEA residents. Consent is the most common basis for marketing; contract is the basis for transactional communications related to reservations.. Valid values are `consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests`',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this contact record is the designated primary contact for the guest within its channel type. Only one record per guest per channel should be flagged as primary. Used by CRS and PMS for reservation confirmations and pre-arrival communications.',
    `is_verified` BOOLEAN COMMENT 'Indicates whether this contact record has been verified through a confirmation process (e.g., email verification link, phone OTP, address validation). Verified contacts have higher data quality confidence and are preferred for critical communications such as reservation confirmations.',
    `language_code` STRING COMMENT 'IETF BCP 47 language tag indicating the guests preferred language for communications sent to this contact address (e.g., en-US, fr-FR, zh-CN). Drives localized email templates, pre-arrival messaging, and loyalty program communications.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the guests postal address in decimal degrees (WGS 84 datum). Supports geocoded feeder market analysis, drive-time radius marketing campaigns, and property proximity analytics for targeted offers.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the guests postal address in decimal degrees (WGS 84 datum). Used in conjunction with latitude for geocoded feeder market analysis, proximity-based marketing, and demand origin mapping.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the guest has provided explicit consent to receive marketing communications via this contact channel. True = opted in; False = opted out or no consent given. Mandatory for GDPR and CCPA compliance. Drives suppression lists in Salesforce CRM marketing campaigns.',
    `marketing_opt_in_date` DATE COMMENT 'Date on which the guest provided explicit consent to receive marketing communications via this contact channel. Required for GDPR audit trail and consent management. Stored to demonstrate lawful basis for processing under GDPR Article 6.',
    `marketing_opt_out_date` DATE COMMENT 'Date on which the guest withdrew consent or opted out of marketing communications via this contact channel. Required for GDPR and CCPA compliance audit trail. Once set, this contact record must be excluded from all outbound marketing campaigns.',
    `messaging_handle` STRING COMMENT 'Guests account identifier or phone number on the specified digital messaging platform. Used to initiate pre-arrival, in-stay, and post-stay communications via messaging channels. Subject to GDPR and CCPA as a digital contact identifier.',
    `messaging_platform` STRING COMMENT 'Digital messaging platform through which the guest can be contacted (e.g., WhatsApp, WeChat, LINE, SMS). Supports pre-arrival messaging, in-stay service requests, and post-stay follow-up communications per guest opt-in preferences.. Valid values are `whatsapp|wechat|line|sms|other`',
    `opt_in_source` STRING COMMENT 'The channel or touchpoint through which the guest provided their marketing or transactional communication consent. Used for consent audit trails and channel attribution analysis. [ENUM-REF-CANDIDATE: web|mobile_app|front_desk|call_center|ota|loyalty_enrollment|other — promote to reference product if additional sources are required]',
    `phone_country_code` STRING COMMENT 'International dialing country code prefix for the guest phone number (e.g., +1 for USA, +44 for UK). Stored separately to support international call routing and country-level analytics. Conforms to ITU-T E.164 country code standards.. Valid values are `^+[1-9]d{0,3}$`',
    `phone_number` STRING COMMENT 'Guest phone number in E.164 international format. Used for reservation confirmations, pre-arrival calls, service recovery, and emergency contact. Sourced from OPERA PMS and Salesforce CRM. Subject to GDPR and CCPA data protection requirements.. Valid values are `^+?[1-9]d{1,14}$`',
    `phone_type` STRING COMMENT 'Classification of the phone number indicating whether it is a mobile, home, work, or fax number. Determines eligibility for SMS marketing communications and pre-arrival text notifications per guest opt-in preferences.. Valid values are `mobile|home|work|fax`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the guests address. Supports address validation, geographic clustering for feeder market analysis, and targeted direct mail campaigns. Format varies by country (e.g., 5-digit US ZIP, alphanumeric UK postcode).',
    `social_handle` STRING COMMENT 'Guests username or handle on the specified social media platform. Used for social CRM engagement, service recovery via social channels, and digital marketing personalization. Subject to GDPR and CCPA as a digital identifier.',
    `social_platform` STRING COMMENT 'Name of the social media platform associated with the guests social handle or digital identity record. Used for social CRM integration, guest experience personalization, and digital marketing channel attribution. [ENUM-REF-CANDIDATE: twitter|instagram|facebook|linkedin|wechat|line|tiktok|other — promote to reference product if additional platforms are required]. Valid values are `twitter|instagram|facebook|linkedin|wechat|other`',
    `source_system_record_code` STRING COMMENT 'The native identifier of this contact record in the originating operational system (e.g., Salesforce Contact ID, OPERA profile contact sequence number). Enables bidirectional traceability between the Silver Layer lakehouse and source systems for reconciliation and data quality audits.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the guests postal address per ISO 3166-2 subdivision codes. Used for regional marketing segmentation, tax jurisdiction determination, and CCPA compliance scope identification.',
    `transactional_opt_in` BOOLEAN COMMENT 'Indicates whether the guest has consented to receive transactional communications (reservation confirmations, folio receipts, check-in instructions) via this contact channel. Distinct from marketing opt-in; transactional messages may have a separate legal basis under GDPR.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact information record was last modified in the system of record. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC), ETL incremental loads, and data freshness monitoring in the Silver Layer.',
    `verified_date` DATE COMMENT 'Date on which this contact record was last verified through a confirmation process. Used to assess data freshness and trigger re-verification workflows when contact data exceeds the data quality policy threshold.',
    CONSTRAINT pk_contact_info PRIMARY KEY(`contact_info_id`)
) COMMENT 'Authoritative repository of all guest contact details and postal addresses associated with a guest profile. Stores email addresses, phone numbers, mailing/billing/home addresses (with full international address structure including city, state, postal code, country per ISO 3166), and digital contact channels (social handles, messaging IDs). Supports multiple records per guest with type classification (primary, secondary, work, home), opt-in/opt-out flags for marketing communications, address validation status, and geocoordinates. Sourced from Salesforce CRM and OPERA PMS.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` (
    `preference_id` BIGINT COMMENT 'Unique surrogate identifier for a guest preference record in the Silver Layer lakehouse. Primary key for the preference data product within the guest domain.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile to whom this preference record belongs. Links the preference to the unified guest identity in the guest domain.',
    `property_id` BIGINT COMMENT 'Reference to the property at which this preference was captured or is applicable. A null value indicates the preference applies globally across all properties for the guest.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Pre-arrival fulfillment operations require pulling guest preferences against an active booking before stay_history exists (stay_history is post-checkout). Front desk and housekeeping systems query pre',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Pre-arrival room assignment and preference fulfillment processes require matching guest preferences (bed_type_preference, view_type_preference, room_floor_preference) to specific room types. Front off',
    `stay_history_id` BIGINT COMMENT 'Reference to the specific stay or reservation during which this preference was captured or last confirmed. Enables preference-to-stay linkage for analytics on preference fulfillment rates and guest satisfaction correlation.',
    `treatment_id` BIGINT COMMENT 'Foreign key linking to spa.treatment. Business justification: Pre-arrival spa personalization process: guest preference profiles drive automatic treatment suggestions and pre-booking for VIP/loyalty guests. A domain expert expects preference records to reference',
    `allergy_detail` STRING COMMENT 'Specific description of the guests food or environmental allergy (e.g., severe peanut allergy - anaphylactic, shellfish allergy, latex allergy). Classified as restricted health information under GDPR and CCPA. Triggers mandatory F&B and housekeeping alerts. Only populated when is_allergy = True.',
    `amenity_preferences` STRING COMMENT 'Guests stated preferences for in-room amenities and welcome items (e.g., extra towels, foam bath products, specific brand toiletries, fruit basket, champagne on arrival). Free-form text to accommodate the wide variety of amenity requests. Communicated to housekeeping and concierge for pre-arrival setup.',
    `bed_type_preference` STRING COMMENT 'Guests stated preference for bed configuration in their room. Sourced from OPERA PMS guest profile and used during room assignment to match available inventory. Supports pre-arrival preparation and upsell opportunity identification. [ENUM-REF-CANDIDATE: king|queen|double|twin|single|rollaway|no_preference — 7 candidates stripped; promote to reference product]',
    `preference_category` STRING COMMENT 'High-level category classifying the type of guest preference. Drives routing to the appropriate operational team (e.g., housekeeping, F&B, front desk). [ENUM-REF-CANDIDATE: room|bed|pillow|amenity|dietary|housekeeping|temperature|newspaper|accessibility|fnb|transportation|communication|loyalty|spa — promote to reference product]',
    `preference_code` STRING COMMENT 'Standardized alphanumeric code representing the preference value as defined in the Property Management System (OPERA PMS) preference code table. Used for system-to-system integration and operational workflow routing (e.g., KGBED, NONSM, OCNVW, VEGAN).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `communication_channel_preference` STRING COMMENT 'Guests preferred channel for receiving hotel communications including pre-arrival messages, in-stay notifications, and post-stay follow-up. Drives marketing and operational communication routing in Salesforce CRM. Supports GDPR and CCPA consent management.. Valid values are `email|sms|phone|app_push|whatsapp|no_contact`',
    `consent_date` DATE COMMENT 'Date on which the guest provided consent for collection and use of this preference data. Required for GDPR and CCPA audit trails. Null if consent_given is False or consent was not explicitly recorded.',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the guest has provided explicit consent for the collection and use of this preference data (True). Required for GDPR Article 7 and CCPA compliance. Preferences captured without consent must not be used for marketing personalization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this preference record was first created in the Silver Layer lakehouse. Supports audit trail, data lineage, and GDPR Article 30 records of processing activities compliance.',
    `data_classification` STRING COMMENT 'Data governance classification level for this preference record, aligned with the enterprise data classification policy. restricted for health/allergy data, confidential for personal preferences, internal for operational preferences. Drives access control and data handling policies.. Valid values are `restricted|confidential|internal|public`',
    `dietary_restriction` STRING COMMENT 'Guests stated dietary restriction or special dietary requirement (e.g., vegetarian, vegan, halal, kosher, gluten-free, lactose-free, diabetic). Communicated to F&B operations via MICROS POS and Delphi for event catering. [ENUM-REF-CANDIDATE: vegetarian|vegan|halal|kosher|gluten_free|lactose_free|diabetic|low_sodium|nut_free|shellfish_free — promote to reference product]',
    `fulfillment_notes` STRING COMMENT 'Free-text notes from operational staff regarding the fulfillment of this preference, including reasons for non-fulfillment, substitutions made, or special circumstances. Supports service recovery workflows and guest history documentation.',
    `fulfillment_status` STRING COMMENT 'Operational status indicating whether this preference was fulfilled during the most recent stay. pending = not yet actioned; fulfilled = successfully delivered; partially_fulfilled = partially met; not_available = could not be accommodated (e.g., room type unavailable); waived = guest waived the preference on arrival.. Valid values are `pending|fulfilled|partially_fulfilled|not_available|waived`',
    `housekeeping_schedule_preference` STRING COMMENT 'Guests preferred timing and frequency for housekeeping service. Communicated to the housekeeping management system to schedule room servicing. do_not_disturb and checkout_only options support sustainability programs and guest privacy preferences.. Valid values are `morning|afternoon|evening|do_not_disturb|every_other_day|checkout_only`',
    `is_ada_requirement` BOOLEAN COMMENT 'Indicates whether this preference represents an ADA-mandated accessibility accommodation (True), such as roll-in shower, hearing-accessible room, visual alert devices, or accessible room location. ADA requirements carry legal compliance obligations and must be fulfilled without substitution.',
    `is_allergy` BOOLEAN COMMENT 'Indicates whether this preference record represents a food or environmental allergy (True). Allergy records trigger mandatory F&B and housekeeping alerts and are subject to heightened fulfillment controls per ISO 22000 food safety standards.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this preference is a hard requirement that must be fulfilled (True) or a soft preference that should be accommodated when possible (False). Mandatory preferences include ADA accessibility requirements, severe food allergies, and medically necessary accommodations.',
    `language_preference` STRING COMMENT 'Guests preferred language for communications, in-room materials, and staff interactions. Stored as BCP 47 language tag (e.g., en, fr, es, zh-CN, de). Used to personalize pre-arrival communications, in-room collateral, and staff greeting protocols.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `last_confirmed_date` DATE COMMENT 'Date on which the guest most recently confirmed this preference remains accurate and current. Used to identify stale preferences that may need re-validation during pre-arrival contact or check-in. Supports GDPR data accuracy principle.',
    `loyalty_tier_at_capture` STRING COMMENT 'The guests loyalty program tier at the time this preference was captured (e.g., Silver, Gold, Platinum, Diamond). Provides context for preference prioritization and fulfillment SLA — higher-tier guests may receive elevated preference fulfillment commitments.',
    `newspaper_preference` STRING COMMENT 'Guests preferred newspaper or publication for complimentary delivery (e.g., The Wall Street Journal, The New York Times, Financial Times, USA Today, local paper). Used by front desk and concierge for pre-arrival preparation and morning delivery scheduling.',
    `pillow_type_preference` STRING COMMENT 'Guests stated preference for pillow type and firmness. Sourced from OPERA PMS guest profile and communicated to housekeeping for pre-arrival room preparation. Hypoallergenic pillow requests may overlap with allergy flags. [ENUM-REF-CANDIDATE: firm|soft|medium|feather|hypoallergenic|foam|no_preference — 7 candidates stripped; promote to reference product]',
    `preference_status` STRING COMMENT 'Current lifecycle status of the preference record. active indicates the preference is valid and should be honored; inactive indicates it has been withdrawn or expired; pending_verification indicates it requires staff confirmation; superseded indicates it has been replaced by a newer preference record.. Valid values are `active|inactive|pending_verification|superseded`',
    `preference_type` STRING COMMENT 'Specific type of preference within the category (e.g., floor_level, bed_type, smoking_status, view_type, pillow_firmness, dietary_restriction, allergy, newspaper_title, housekeeping_time, room_temperature). Provides granular classification for operational fulfillment and personalization analytics.',
    `priority_rank` STRING COMMENT 'Numeric rank indicating the relative importance of this preference when multiple preferences of the same type exist for a guest. Lower values indicate higher priority (1 = highest). Used by pre-arrival preparation workflows to resolve conflicts.',
    `room_floor_preference` STRING COMMENT 'Guests stated preference for the floor level of their room assignment. Used by front desk and room assignment workflows in OPERA PMS to optimize room allocation during check-in and pre-arrival room blocking.. Valid values are `low|mid|high|top|no_preference`',
    `room_temperature_celsius` DECIMAL(18,2) COMMENT 'Guests preferred room temperature setting in degrees Celsius. Used for pre-arrival room preparation and smart room automation where available. Stored in Celsius for standardization; display conversion to Fahrenheit handled at the presentation layer.',
    `smoking_preference` STRING COMMENT 'Guests preference for smoking or non-smoking room designation. Critical for room assignment compliance and property policy adherence. Most properties are entirely non-smoking; this field captures exceptions and guest-stated preferences for reporting.. Valid values are `non_smoking|smoking|no_preference`',
    `source` STRING COMMENT 'Indicates how the preference was captured: stated (guest explicitly requested), inferred (derived from stay history patterns), observed (noted by staff during stay), crm_imported (sourced from Salesforce CRM), loyalty_profile (from loyalty program record), survey (from Medallia feedback), service_recovery (captured during a service recovery interaction). [ENUM-REF-CANDIDATE: stated|inferred|observed|crm_imported|loyalty_profile|survey|service_recovery — 7 candidates stripped; promote to reference product]',
    `source_record_reference` STRING COMMENT 'The native identifier of this preference record in the originating source system (e.g., OPERA PMS preference record ID, Salesforce CRM preference object ID). Enables traceability back to the system of record for reconciliation and audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this preference record was most recently modified in the Silver Layer lakehouse. Supports change tracking, data freshness monitoring, and audit compliance.',
    `valid_until` DATE COMMENT 'Date after which this preference record expires and should no longer be honored. Null indicates the preference is open-ended with no expiry. Supports GDPR data minimisation requirements by enabling automatic expiry of time-limited preferences.',
    `value` DECIMAL(18,2) COMMENT 'The stated or inferred value of the preference (e.g., high floor, king bed, non-smoking, ocean view, firm pillow, vegetarian, gluten-free, The Wall Street Journal, do not disturb before 10am, 72°F). Free-form string to accommodate the wide variety of preference types.',
    `view_type_preference` STRING COMMENT 'Guests stated preference for the type of view from their room. Used during room assignment and pre-arrival blocking to enhance guest satisfaction. Supports upsell workflows when preferred view type is available at a premium. [ENUM-REF-CANDIDATE: ocean|pool|garden|city|mountain|courtyard|no_preference — 7 candidates stripped; promote to reference product]',
    `valid_from` DATE COMMENT 'Date from which this preference record is effective and should be honored during guest stays. Supports time-bound preferences (e.g., a temporary dietary restriction during a medical recovery period) and preference versioning.',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Guest preference records capturing stated and inferred preferences across all hospitality touchpoints. Includes room preferences (floor level, bed type, smoking/non-smoking, view type), pillow type, amenity preferences, F&B dietary restrictions and allergies, newspaper preferences, housekeeping schedule preferences, temperature settings, and special accommodation needs (ADA requirements). Sourced from OPERA PMS and Salesforce CRM. Critical for personalized service delivery and pre-arrival preparation.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` (
    `corporate_account_id` BIGINT COMMENT 'Unique surrogate identifier for the corporate account record in the Silver Layer lakehouse. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to event.event_account. Business justification: Corporate accounts often have both transient room business (guest domain) and MICE business (event domain). Account managers need unified view of total account revenue, consolidated billing, and integ',
    `cancellation_policy_id` BIGINT COMMENT 'Foreign key linking to reservation.cancellation_policy. Business justification: Corporate contract management: corporate accounts negotiate specific cancellation policies (cancellation_policy.applies_to_corporate_bookings). Linking corporate_account to their contracted cancellati',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Corporate accounts have a defined billing/credit currency for invoicing, credit limits, and direct billing. Normalizing credit_currency_code to a FK against the currency reference table ensures consis',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to property.hierarchy. Business justification: Corporate rate agreements and account management are negotiated at regional/brand hierarchy nodes (e.g., a national account covering all properties in a region). Revenue managers and account managers ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to guest.segment. Business justification: corporate_account stores market_segment_code as a free-text string (e.g., CORPORATE, MICE, GOVERNMENT). The segment table is the authoritative master for these definitions. Adding market_segment',
    `account_manager_email` STRING COMMENT 'Internal email address of the hotel groups account manager assigned to this corporate account. Used for escalation routing, contract renewal notifications, and CRM workflow automation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `account_manager_name` STRING COMMENT 'Full name of the hotel groups internal account manager or sales manager responsible for managing the corporate relationship, contract renewals, and production performance.',
    `account_status` STRING COMMENT 'Current lifecycle status of the corporate account. Controls rate eligibility, direct billing access, and CRM engagement workflows. Active accounts are eligible for negotiated rates and direct billing.. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `account_type` STRING COMMENT 'Classification of the corporate account by the nature of the client relationship. Drives rate eligibility, billing rules, and reporting segmentation. [ENUM-REF-CANDIDATE: corporate|government|consortium|travel_management_company|wholesale|other — promote to reference product if additional types are required]. Valid values are `corporate|government|consortium|travel_management_company|wholesale|other`',
    `annual_revenue_target` DECIMAL(18,2) COMMENT 'Target total revenue (rooms, Food and Beverage (F&B), events) expected from this corporate account in the contract year. Used for account manager performance tracking and revenue budget planning per USALI standards.',
    `annual_room_night_target` STRING COMMENT 'Contracted or projected annual room night volume committed by the corporate client. Used for account tiering, rate negotiation leverage, and production performance tracking against actuals.',
    `billing_address_city` STRING COMMENT 'City component of the corporate clients billing address. Used for invoice generation, tax jurisdiction determination, and geographic segmentation reporting.',
    `billing_address_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the corporate clients billing address. Drives tax treatment, currency defaults, and regulatory compliance requirements (GDPR for EU entities).. Valid values are `^[A-Z]{3}$`',
    `billing_address_line1` STRING COMMENT 'First line of the corporate clients official billing address used for invoice generation and accounts receivable correspondence in SAP S/4HANA.',
    `billing_instruction` STRING COMMENT 'Free-text billing instruction specifying which charges (room, tax, incidentals, F&B) are to be direct-billed to the corporate account versus charged to the individual guest. Applied automatically at check-in in OPERA PMS.',
    `blackout_dates_policy` STRING COMMENT 'Description or reference code for blackout date restrictions applicable to this corporate accounts negotiated rates. Specifies periods (e.g., peak demand, special events) when contracted rates are not available.',
    `company_name` STRING COMMENT 'Full legal registered name of the corporate client organization as it appears on contracts, invoices, and billing documents.',
    `contract_end_date` DATE COMMENT 'Date on which the negotiated rate agreement and corporate account contract expires. Nullable for open-ended agreements. Rate eligibility ceases after this date unless renewed.',
    `contract_start_date` DATE COMMENT 'Date on which the negotiated rate agreement and corporate account contract becomes effective. Reservations made on or after this date are eligible for contracted rates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corporate account record was first created in the source system. Used for audit trail, data lineage, and compliance reporting. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance permitted on the corporate accounts direct billing (city ledger) facility in the OPERA AR module. Enforced at check-in and during reservation creation to prevent credit overexposure.',
    `crm_account_reference` STRING COMMENT 'External account identifier from Salesforce CRM, used to cross-reference the corporate account record with the CRM system of record for guest profiles and marketing campaigns.',
    `data_privacy_consent` BOOLEAN COMMENT 'Indicates whether the corporate contact has provided consent for processing of their personal data in accordance with GDPR and CCPA requirements. Required for marketing communications and data sharing with third-party partners.',
    `direct_billing_enabled` BOOLEAN COMMENT 'Indicates whether this corporate account is approved for direct billing (city ledger) to the hotel group. When true, eligible charges are posted to the AR account rather than requiring individual guest payment at checkout.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount off the Best Available Rate (BAR) or rack rate granted to this corporate account under the negotiated agreement. Used by the Revenue Management System (RMS) for displacement analysis and yield optimization.',
    `gdpr_data_subject_region` STRING COMMENT 'Regulatory jurisdiction applicable to the corporate contacts personal data. Determines which privacy regulations govern data handling, retention, and subject rights requests (GDPR for EU/UK, CCPA for California).. Valid values are `eu|uk|california|other`',
    `industry_naics_code` STRING COMMENT 'Six-digit NAICS code providing a more granular industry classification for the corporate client, used alongside SIC for regulatory reporting, procurement analysis, and revenue segmentation.. Valid values are `^[0-9]{6}$`',
    `industry_sic_code` STRING COMMENT 'Four-digit Standard Industrial Classification (SIC) code identifying the primary industry sector of the corporate client. Used for market segmentation, demand analysis, and MICE opportunity targeting.. Valid values are `^[0-9]{4}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the corporate account record in the source system. Used for incremental ETL processing, change data capture, and audit trail maintenance in the Silver Layer.',
    `los_minimum_nights` STRING COMMENT 'Minimum Length of Stay (LOS) requirement in nights applicable to this corporate accounts negotiated rate. A value of 1 indicates no minimum stay restriction.',
    `loyalty_program_eligible` BOOLEAN COMMENT 'Indicates whether individual travelers booking under this corporate account are eligible to earn loyalty program points. Some negotiated rate codes exclude loyalty accrual per program terms.',
    `mice_eligible` BOOLEAN COMMENT 'Indicates whether this corporate account is eligible for MICE (Meetings, Incentives, Conferences, Exhibitions) group rates and event space allocations managed through Delphi by Amadeus.',
    `negotiated_rate_code` STRING COMMENT 'Primary negotiated rate code assigned to this corporate account in the Central Reservation System (CRS) and Property Management System (PMS). Used for Best Available Rate (BAR) eligibility verification and rate distribution across channels. Natural key normalized; resolve via revenue.rate_plan reference.',
    `opera_ar_account_number` STRING COMMENT 'Accounts Receivable account number assigned in Oracle OPERA PMS AR module, used for direct billing, city ledger management, and credit limit enforcement at the property level.',
    `payment_terms` STRING COMMENT 'Agreed payment terms for direct billing invoices issued to this corporate account. Determines invoice due dates and triggers accounts receivable aging in SAP S/4HANA.. Valid values are `net_30|net_45|net_60|immediate|prepaid`',
    `preferred_property_codes` STRING COMMENT 'Comma-separated list of hotel property codes (from OPERA PMS) designated as preferred properties for this corporate account. Drives rate availability, inventory allocation, and channel distribution priority.',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary corporate contact. Used for contract communications, rate confirmations, and program updates. Subject to GDPR and CCPA data subject rights.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary travel coordinator or procurement contact at the corporate client organization responsible for managing the hotel program and employee travel bookings.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary corporate contact. Used for urgent communications regarding reservations, billing disputes, and contract negotiations.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `rate_program_type` STRING COMMENT 'Type of negotiated rate program governing this corporate account. LRA (Last Room Availability) guarantees rate access even at high occupancy. NRR (Non-Refundable Rate) offers deeper discounts with cancellation restrictions. Drives Revenue Management System (RMS) displacement analysis.. Valid values are `lra|nrr|bar_discount|fixed_rate|dynamic`',
    `tax_exempt_status` STRING COMMENT 'Tax exemption classification for this corporate account. Government and qualifying non-profit accounts may be fully or partially exempt from occupancy and sales taxes. Drives tax posting rules in OPERA PMS and SAP S/4HANA.. Valid values are `exempt|partial|taxable`',
    `tax_exemption_certificate` STRING COMMENT 'Official tax exemption certificate number issued by the relevant tax authority for this corporate account. Required for audit compliance when applying tax-exempt billing. Stored for SOX and USALI audit trail purposes.',
    `trading_name` STRING COMMENT 'Doing-business-as (DBA) or brand name of the corporate client if different from the legal registered company name. Used for correspondence and guest-facing communications.',
    `vip_tier` STRING COMMENT 'VIP tier classification assigned to this corporate account based on production volume, strategic importance, and revenue contribution. Drives service recovery priority, amenity entitlements, and account manager assignment level.. Valid values are `standard|preferred|key|strategic`',
    CONSTRAINT pk_corporate_account PRIMARY KEY(`corporate_account_id`)
) COMMENT 'Corporate client account master representing companies and organizations that negotiate rates and manage employee travel programs with the hotel group. Captures company name, industry classification (SIC/NAICS), negotiated rate codes, credit terms, billing instructions, account manager assignment, annual room night production targets, contract validity periods, and preferred properties. Links to individual guest profiles via corporate affiliation for rate eligibility verification. Sourced from Salesforce CRM and OPERA PMS AR module.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` (
    `vip_designation_id` BIGINT COMMENT 'Unique surrogate identifier for each VIP designation record in the silver layer lakehouse. Primary key for the vip_designation data product. Sourced from Oracle OPERA PMS VIP code assignments and Salesforce CRM VIP profile records.',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account record when the VIP designation is granted based on a corporate relationship (e.g., key account executive, contracted corporate partner). Null for individual leisure VIP guests. Sourced from Salesforce CRM account object.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to property.hierarchy. Business justification: VIP designations can be scoped chain-wide or regionally (e.g., VIP at all properties in APAC region), not just at a single property. The existing property_id covers property-level scope; hierarchy_id ',
    `member_id` BIGINT COMMENT 'Reference to the loyalty program membership record associated with this VIP guest. Links VIP designation entitlements with loyalty tier benefits to ensure non-duplication and correct benefit stacking. Sourced from Salesforce CRM loyalty management module.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile record for whom this VIP designation is assigned. Links to the master guest profile in the guest domain. A single guest may hold multiple concurrent VIP designations across brand and property levels.',
    `property_id` BIGINT COMMENT 'Reference to the property at which this VIP designation applies. A designation may be property-specific (e.g., Celebrity at a single resort) or brand-wide (null indicates brand-level designation). Sourced from Oracle OPERA PMS property configuration.',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: VIP pre-arrival protocols require designating a preferred or guaranteed room type for VIP guests (upgrade_eligible, room_assignment_priority). Front office VIP handling and pre-arrival checklists depe',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: VIP designations in hospitality are frequently triggered by or aligned with loyalty tier thresholds (e.g., Platinum members auto-qualify for VIP handling). This FK supports auditing which tier level t',
    `airport_transfer_required` BOOLEAN COMMENT 'Indicates whether a complimentary or arranged airport transfer service is required for this VIP guest as part of their designation entitlements. Triggers coordination with the concierge and transportation team during pre-arrival preparation.',
    `alias_name` STRING COMMENT 'Pseudonym or alias name used for incognito check-in and reservation bookings to protect the identity of high-profile guests. Used in place of the guests legal name on folios, room assignments, and staff communications when incognito_checkin is true.',
    `amenity_tier_code` STRING COMMENT 'Code referencing the amenity entitlement package associated with this VIP level. Determines the standard amenity setup (e.g., welcome fruit basket, champagne, floral arrangement, personalized stationery) to be prepared prior to guest arrival. Sourced from OPERA PMS amenity configuration.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `concurrent_designation_count` STRING COMMENT 'Number of active VIP designations currently held by this guest across all scopes (brand and property level). Supports operational awareness that a guest may hold multiple concurrent designations (e.g., VIP3 at brand level and Celebrity at property level) and ensures all applicable protocols are honored.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VIP designation record was first created in the silver layer lakehouse. Represents the audit trail creation event. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per platform conventions.',
    `designation_code` STRING COMMENT 'Externally-known alphanumeric code identifying this VIP designation record, as assigned in Oracle OPERA PMS VIP code table (e.g., VIP1, VIP3, CELEB, ROYAL, OWNER). Used for cross-system reference and pre-arrival checklist triggers.. Valid values are `^[A-Z0-9]{2,20}$`',
    `designation_notes` STRING COMMENT 'Internal narrative notes providing additional context about the VIP designation, such as the relationship history, specific events that triggered the designation, or instructions for the guest relations team. Visible only to authorized staff. Sourced from Salesforce CRM case notes.',
    `designation_reason` STRING COMMENT 'Business rationale for granting the VIP designation. Revenue threshold indicates the guest meets a minimum annual spend threshold. Corporate relationship indicates a key account or contracted corporate partner. Public figure, diplomatic, and celebrity reasons trigger additional privacy protocols. [ENUM-REF-CANDIDATE: revenue_threshold|corporate_relationship|public_figure|loyalty_elite|owner|board_member|celebrity|diplomatic|media|government — promote to reference product]',
    `designation_scope` STRING COMMENT 'Indicates whether the VIP designation applies across the entire brand portfolio, is restricted to a specific property, or applies to a regional cluster of properties. Drives which properties must honor the designation during pre-arrival preparation.. Valid values are `brand|property|regional`',
    `designation_status` STRING COMMENT 'Current lifecycle state of the VIP designation record. Active designations drive pre-arrival checklists and upgrade eligibility. Suspended designations are temporarily paused. Revoked designations have been withdrawn due to policy violation or relationship change.. Valid values are `active|suspended|expired|revoked|pending_review`',
    `do_not_disturb` BOOLEAN COMMENT 'Indicates that the guest has a standing do-not-disturb preference that must be honored by housekeeping, engineering, and all operational departments unless a safety emergency arises. Overrides standard housekeeping scheduling in Oracle OPERA PMS.',
    `effective_from` DATE COMMENT 'Calendar date on which the VIP designation becomes active and service protocols are triggered. Used to schedule pre-arrival preparation and amenity entitlements. Aligns with OPERA PMS VIP code validity start date.',
    `effective_until` DATE COMMENT 'Calendar date on which the VIP designation expires and service protocols are deactivated. Null indicates an open-ended designation with no planned expiry. Annual review cycles typically reset this date. Aligns with OPERA PMS VIP code validity end date.',
    `gm_greeting_required` BOOLEAN COMMENT 'Indicates whether the General Manager (GM) or designated senior property leader is required to personally greet this VIP guest upon arrival. Triggers a GM greeting task in the pre-arrival preparation checklist within Oracle OPERA PMS.',
    `incognito_checkin` BOOLEAN COMMENT 'Indicates that the guest requires a discreet, incognito check-in process to protect their identity and privacy. When true, the front desk must use a private check-in area, suppress the guest name from public-facing displays, and limit staff awareness of the guests presence. Critical for celebrity and diplomatic guests.',
    `last_stay_date` DATE COMMENT 'Date of the guests most recent completed stay at any property under this VIP designations scope. Used during annual VIP review cycles to assess continued eligibility based on recency of engagement. Sourced from Oracle OPERA PMS reservation history.',
    `media_blackout` BOOLEAN COMMENT 'Indicates that all media inquiries, press requests, and social media references related to this guests stay must be suppressed and escalated to the Director of Communications. Distinct from no_photo_policy as it governs external communications rather than on-property photography.',
    `no_photo_policy` BOOLEAN COMMENT 'Indicates that the guest has explicitly prohibited photography, video recording, or any visual documentation of their presence on property. Staff must be briefed on this restriction during pre-arrival preparation. Applies to celebrity, royalty, and diplomatic designations.',
    `pre_arrival_checklist_template` STRING COMMENT 'Code identifying the standardized pre-arrival preparation checklist template to be activated for this VIP designation. Templates define the sequence of tasks (amenity setup, room inspection, GM briefing, transportation coordination) required before the guests arrival.. Valid values are `^[A-Z0-9_]{2,50}$`',
    `revenue_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum annual revenue contribution (in USD) that qualified this guest for the VIP designation based on the revenue threshold reason. Used for annual VIP eligibility reviews and LTV (Lifetime Value) analysis. Sourced from OPERA PMS revenue history and SAP S/4HANA financial records.',
    `revenue_threshold_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the revenue_threshold_amount field. Ensures correct currency context for multi-currency properties and international guests. Defaults to USD for US-based properties.. Valid values are `^[A-Z]{3}$`',
    `review_date` DATE COMMENT 'Scheduled date for the next periodic review of this VIP designation to confirm continued eligibility based on revenue thresholds, relationship status, or public figure standing. Supports annual VIP audit processes managed by the guest relations team.',
    `revocation_reason` STRING COMMENT 'Reason code explaining why a VIP designation was revoked or suspended. Populated only when designation_status is revoked or suspended. Supports audit trail requirements and VIP eligibility governance reviews. Sourced from Salesforce CRM case closure reason.. Valid values are `revenue_below_threshold|relationship_ended|policy_violation|guest_request|duplicate_record|other`',
    `room_assignment_priority` STRING COMMENT 'Numeric priority rank (lower value = higher priority) used by the front desk and revenue management systems to sequence room assignment and upgrade eligibility for this VIP guest relative to other arriving guests. Integrates with IDeaS G3 RMS inventory controls.',
    `security_escort_required` BOOLEAN COMMENT 'Indicates whether a dedicated security escort or personal protection detail coordination is required for this VIP guest during their stay. Triggers security briefing and coordination protocols with the property security team and any external protection services.',
    `service_recovery_escalation_level` STRING COMMENT 'Defines the escalation path and response urgency for service recovery incidents involving this VIP guest. Immediate_gm requires the General Manager to be notified within minutes of any complaint. Drives Medallia case routing and Salesforce CRM service recovery workflows.. Valid values are `standard|elevated|executive|immediate_gm`',
    `source_system_vip_code` STRING COMMENT 'The native VIP code or identifier as stored in the originating source system (Oracle OPERA PMS or Salesforce CRM). Retained for traceability and reconciliation between the lakehouse silver layer and the operational system of record.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `special_handling_notes` STRING COMMENT 'Free-text field capturing bespoke service instructions specific to this VIP designation, such as preferred room temperature, dietary restrictions for amenity setup, security escort requirements, or specific staff interaction protocols. Sourced from Salesforce CRM case notes and OPERA PMS profile remarks.',
    `total_stays_in_period` STRING COMMENT 'Count of completed stays by the guest within the current designation validity period (effective_from to effective_until). Used to validate continued VIP eligibility at review date and to support LTV (Lifetime Value) reporting. Sourced from Oracle OPERA PMS stay history.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this VIP designation record in the silver layer lakehouse. Tracks changes to designation status, special handling instructions, privacy flags, or host assignments. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per platform conventions.',
    `upgrade_eligible` BOOLEAN COMMENT 'Indicates whether this VIP designation entitles the guest to complimentary room category upgrades subject to availability at check-in. When true, the front desk system surfaces upgrade options during the check-in workflow in Oracle OPERA PMS.',
    `vip_level` STRING COMMENT 'Tiered classification of the VIP designation indicating the service protocol level assigned to the guest. VIP1 is entry-level recognition; VIP5 is the highest standard tier. Celebrity, Royalty, Owner, and Board Member are special-class designations. [ENUM-REF-CANDIDATE: VIP1|VIP2|VIP3|VIP4|VIP5|Celebrity|Royalty|Owner|Board Member — promote to reference product]',
    CONSTRAINT pk_vip_designation PRIMARY KEY(`vip_designation_id`)
) COMMENT 'VIP classification and designation records for high-value guests requiring elevated service protocols. Captures VIP level/tier (VIP1 through VIP5, Celebrity, Royalty, Owner, Board Member), designation reason (revenue threshold, corporate relationship, public figure status), assigned property host or butler, special handling instructions (amenity setup, GM greeting, airport transfer), amenity entitlements per tier, privacy flags (do-not-disturb, incognito check-in, no-photo policy), and designation validity period. One guest may hold multiple concurrent designations (e.g., VIP3 at brand level + Celebrity at property level). Sourced from OPERA PMS VIP codes and Salesforce CRM. Drives pre-arrival preparation checklists, room assignment priority, upgrade eligibility, and service recovery escalation paths.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` (
    `stay_history_id` BIGINT COMMENT 'Unique surrogate identifier for each completed guest stay record in the silver layer lakehouse. Primary key for the stay_history data product. Sourced from Oracle OPERA PMS post-checkout records.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Channel contribution analysis per guest — identifying which distribution channels produce high-value, loyal guests — is a core hospitality revenue and marketing process. Replacing the denormalized bo',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account associated with this stay, applicable when guest_type is corporate. Links to negotiated rate agreements and corporate travel program tracking. Sourced from Oracle OPERA PMS accounts receivable module.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to property.currency. Business justification: Stay history records revenue figures (ADR, room revenue, total folio) in a specific currency. Normalizing currency_code to a FK against the currency reference table enables accurate multi-currency rev',
    `event_booking_id` BIGINT COMMENT 'Foreign key linking to event.event_booking. Business justification: MICE revenue attribution and event P&L reporting require linking guest stay records directly to the event booking that generated the room demand. Enables direct group room revenue reporting per event ',
    `segment_id` BIGINT COMMENT 'Foreign key linking to guest.segment. Business justification: stay_history currently stores market_segment_code as a free-text string. The segment table is the authoritative master for market segment definitions (segment_code, segment_name, segment_type, etc.). ',
    `member_id` BIGINT COMMENT 'Foreign key linking to loyalty.member. Business justification: Loyalty points posting, qualifying-night calculation, and tier progression all require joining stay history directly to the loyalty member record. A domain expert would expect stay_history to carry me',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile record representing the primary registered guest for this stay. Supports Lifetime Value (LTV) calculation, segmentation, and personalization across all properties.',
    `property_id` BIGINT COMMENT 'Reference to the property where the stay occurred. Enables property-level performance analytics including ADR, RevPAR, and OCC reporting per USALI standards.',
    `reservation_rate_plan_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_rate_plan. Business justification: Revenue management rate plan performance reporting by stay requires linking stay_history to the structured reservation_rate_plan entity. rate_plan_code is currently denormalized on stay_history; norma',
    `room_id` BIGINT COMMENT 'Foreign key linking to inventory.room. Business justification: Room-level performance reporting, repeat-guest room assignment, and maintenance impact analysis require linking each stay to the specific physical room occupied. Housekeeping and asset management team',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Post-stay analytics and revenue reporting require linking stay history to room type entities to calculate ADR, RevPAR, NPS, and loyalty points by room type. room_type_code is a denormalized representa',
    `adr` DECIMAL(18,2) COMMENT 'Average Daily Rate (ADR) for the stay, calculated as total room revenue divided by the number of occupied room nights. A primary KPI per USALI and STR STAR Report standards. Expressed in the propertys local currency. Used for RevPAR computation and competitive benchmarking via STR. [v2 note: this is ADR not RevPAR; canonical RevPAR is in the revenue domain.]',
    `ancillary_revenue` DECIMAL(18,2) COMMENT 'Total ancillary charges posted to the guest folio during the stay, including spa, parking, laundry, telephone, and other non-room, non-F&B charges. Sourced from Oracle OPERA PMS. Contributes to TRevPAR and GOPPAR calculations per USALI.',
    `arrival_date` DATE COMMENT 'Actual date the guest checked in to the property (yyyy-MM-dd). May differ from the originally reserved arrival date in cases of early arrival or late arrival. Used as the principal business event date for stay analytics and STR benchmarking.',
    `booking_date` DATE COMMENT 'Date on which the reservation was originally created (yyyy-MM-dd). Used to calculate booking lead time (days between booking_date and arrival_date), a key input for demand forecasting and pickup report analysis.',
    `checkin_timestamp` TIMESTAMP COMMENT 'Exact date and time the guest completed the check-in process at the front desk or via mobile/digital check-in (yyyy-MM-ddTHH:mm:ss.SSSXXX). Sourced from Oracle OPERA PMS front desk module. Used for operational SLA tracking and guest experience analytics.',
    `checkout_timestamp` TIMESTAMP COMMENT 'Exact date and time the guest completed the checkout process (yyyy-MM-ddTHH:mm:ss.SSSXXX). Sourced from Oracle OPERA PMS cashiering module. Marks the point at which the stay record is finalized and posted to the stay history.',
    `complimentary_flag` BOOLEAN COMMENT 'Indicates whether the stay was provided on a complimentary (no-charge) basis (True = complimentary; False = revenue-generating stay). Sourced from Oracle OPERA PMS. Used for USALI complimentary room reporting and GOP calculation.',
    `confirmation_number` STRING COMMENT 'Externally-known alphanumeric confirmation number assigned by the Central Reservation System (CRS) or Property Management System (PMS) at time of booking. Used by guests and agents to reference the stay. Sourced from Sabre SynXis CRS or Oracle OPERA PMS.. Valid values are `^[A-Z0-9]{6,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stay history record was first created in the silver layer lakehouse, typically upon post-checkout processing from Oracle OPERA PMS (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trail, and ETL pipeline monitoring.',
    `departure_date` DATE COMMENT 'Actual date the guest checked out of the property (yyyy-MM-dd). May differ from the originally reserved departure date in cases of early departure or extended stay. Used in conjunction with arrival_date to compute Length of Stay (LOS).',
    `do_not_disturb_flag` BOOLEAN COMMENT 'Indicates whether the guest activated Do Not Disturb (DND) status during the stay (True = DND activated at any point; False = DND not activated). Sourced from Oracle OPERA PMS housekeeping module. Used for housekeeping scheduling and guest preference analytics.',
    `fb_revenue` DECIMAL(18,2) COMMENT 'Total Food and Beverage (F&B) charges posted to the guest folio during the stay, including restaurant, bar, room service, and minibar charges. Sourced from Oracle Hospitality MICROS POS. Contributes to TRevPAR calculation.',
    `gss_score` DECIMAL(18,2) COMMENT 'Overall Guest Satisfaction Score (GSS) for the stay as captured by Medallia post-stay survey, typically on a scale of 1-10 or 1-100 depending on survey instrument. Distinct from NPS; measures overall satisfaction rather than likelihood to recommend. Used for Satisfaction and Loyalty Tracking (SALT) reporting.',
    `guest_type` STRING COMMENT 'Classification of the guest stay by traveler category. fit (Free Independent Traveler) indicates leisure individual; corporate indicates business traveler under a negotiated account; group indicates part of a group block; crew indicates airline or transport crew; complimentary indicates no-charge stay. Drives segmentation and LTV modeling.. Valid values are `fit|corporate|group|crew|complimentary`',
    `length_of_stay` STRING COMMENT 'The length of stay for stay history in the guest domain.',
    `length_of_stay_nights` STRING COMMENT '',
    `los_nights` STRING COMMENT 'Actual number of nights the guest stayed at the property, computed as departure_date minus arrival_date. A core metric for Average Length of Stay (ALOS) analysis, revenue management, and demand forecasting in IDeaS G3 RMS.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for this stay, based on the applicable earning rate for the rate plan, room type, and member tier. Sourced from Salesforce CRM loyalty management. Used for loyalty program liability accrual and member engagement analytics.',
    `loyalty_tier_at_stay` STRING COMMENT 'The guests loyalty program tier level at the time of the stay (e.g., Silver, Gold, Platinum, Diamond). Captured as a snapshot to preserve historical tier context for LTV analysis and personalization, independent of the guests current tier. [ENUM-REF-CANDIDATE: promote to reference product as tiers vary by brand]',
    `nps_score` STRING COMMENT 'Net Promoter Score (NPS) provided by the guest for this stay, on a scale of 0-10. Sourced from Medallia post-stay survey. Used for Guest Satisfaction Score (GSS) tracking, service recovery identification, and experience analytics. Null if guest did not respond to survey.',
    `num_adults` STRING COMMENT 'Count of adult guests (18 years and older) registered for the stay as recorded in Oracle OPERA PMS. Used for occupancy reporting, F&B revenue forecasting, and capacity planning.',
    `num_children` STRING COMMENT 'Count of child guests (under 18 years) registered for the stay as recorded in Oracle OPERA PMS. Used for family segment analytics, amenity planning, and F&B revenue forecasting.',
    `original_arrival_date` DATE COMMENT 'The arrival date as originally reserved at time of booking, before any modifications. Used to measure early arrival or late arrival deviations and to support wash factor analysis in IDeaS G3 RMS.',
    `original_departure_date` DATE COMMENT 'The departure date as originally reserved at time of booking, before any modifications. Used to identify early departure and extended stay patterns for demand forecasting and wash factor analysis in IDeaS G3 RMS.',
    `payment_method` STRING COMMENT 'Primary payment instrument used to settle the guest folio at checkout. Sourced from Oracle OPERA PMS cashiering module. Used for payment mix analysis and PCI DSS compliance reporting. [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|direct_bill|loyalty_points|bank_transfer|voucher|cryptocurrency — promote to reference product]. Valid values are `credit_card|debit_card|cash|direct_bill|loyalty_points|bank_transfer`',
    `qualifying_nights` STRING COMMENT 'Number of nights from this stay that count toward the guests loyalty program tier qualification. May differ from los_nights if the rate plan is non-qualifying (e.g., wholesale, complimentary). Sourced from Salesforce CRM loyalty management.',
    `room_revenue` DECIMAL(18,2) COMMENT 'Total room charges posted to the guest folio for the entire stay, excluding taxes, fees, and ancillary charges. Sourced from Oracle OPERA PMS cashiering module. Core component of RevPAR and TRevPAR calculations per USALI.',
    `rooms_sold` STRING COMMENT 'Number of rooms sold recorded in the guest stay history.',
    `service_recovery_flag` BOOLEAN COMMENT 'Indicates whether a service recovery action was initiated during or after this stay (True = service recovery case opened; False = no service recovery). Sourced from Medallia or Salesforce CRM case management. Used for Guest Recovery Rate (GRR) calculation and experience analytics.',
    `stay_status` STRING COMMENT 'Outcome status of the guest stay upon checkout processing. completed indicates normal checkout on scheduled departure date; early_departure indicates guest checked out before scheduled departure; extended indicates stay was prolonged beyond original departure date; no_show indicates reservation was not cancelled but guest never arrived; cancelled indicates reservation was cancelled post-check-in processing.. Valid values are `completed|early_departure|extended|no_show|cancelled`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charges applied to the guest folio for the stay, including occupancy tax, VAT, city tax, and other applicable levies. Sourced from Oracle OPERA PMS cashiering. Required for IFRS/GAAP financial reporting and SOX compliance.',
    `total_folio_amount` DECIMAL(18,2) COMMENT 'Total amount charged to the guest folio for the entire stay, inclusive of room revenue, F&B revenue, ancillary revenue, and taxes. Represents the gross billing amount settled at checkout. Sourced from Oracle OPERA PMS cashiering module.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this stay history record was last modified in the silver layer lakehouse (yyyy-MM-ddTHH:mm:ss.SSSXXX). Captures post-checkout adjustments such as folio corrections, survey score updates, or loyalty point recalculations. Used for data lineage and audit compliance.',
    `vip_code` STRING COMMENT 'VIP designation code assigned to the guest for this stay in Oracle OPERA PMS (e.g., VIP1, VIP2, VVIP, CELEB). Drives special handling, amenity delivery, and management attention protocols. Null if guest has no VIP designation.',
    CONSTRAINT pk_stay_history PRIMARY KEY(`stay_history_id`)
) COMMENT 'Consolidated historical record of all completed guest stays across all properties and brands. Captures arrival date, departure date, property, room type, room number, rate plan, ADR, total revenue (rooms + F&B + ancillary), LOS, number of guests, booking channel, and stay outcome (completed, early departure, extended). Sourced from OPERA PMS post-checkout records. Foundational for LTV calculation, segmentation, and personalization. Distinct from active reservations managed in the reservation domain. ADR (RevPAR lives in revenue domain) measure removed/renamed: prior definition divided room_revenue by occupied room nights which yields ADR not ADR (RevPAR lives in revenue domain); canonical ADR (RevPAR lives in revenue domain) is owned by the revenue domain. The ECM ADR (RevPAR lives in revenue domain) measure that divided room revenue by occupied room nights was actually ADR; it has been renamed/removed because true ADR (RevPAR lives in revenue domain) is owned by the revenue domain. RevPAR measure removed from guest metrics (was actually ADR = revenue / occupied room nights); canonical RevPAR lives in the revenue domain. Incorrect RevPAR measure removed; correct RevPAR lives in revenue domain.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` (
    `communication_consent_id` BIGINT COMMENT 'Unique identifier for the communication consent record. Primary key.',
    `property_id` BIGINT COMMENT 'Foreign key linking to property.property. Business justification: GDPR and privacy regulations require knowing which property captured a guests consent (jurisdiction, lawful basis, and data controller identity vary by property location). Compliance audits and conse',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who provided or withdrew consent. Links to the guest master record in CRM.',
    `consent_audit_trail` STRING COMMENT 'Structured or semi-structured audit trail capturing the history of consent changes, including who made changes, when, and why. May be JSON or delimited text format.',
    `consent_capture_url` STRING COMMENT 'The URL of the web page or application screen where the consent was captured. Helps trace back to the exact consent form version and context.',
    `consent_expiry_date` DATE COMMENT 'The date on which the consent expires and must be re-confirmed. Null for consents without expiration. Some jurisdictions and internal policies require periodic re-consent.',
    `consent_granted_date` DATE COMMENT 'The date on which the guest provided explicit consent for the specified communication type and purpose. Critical for GDPR and CCPA compliance audit trails.',
    `consent_granted_timestamp` TIMESTAMP COMMENT 'Precise timestamp when consent was granted, including time zone information. Provides granular audit trail for regulatory compliance.',
    `consent_language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the consent was presented and captured. Required for demonstrating informed consent in the guest native language.. Valid values are `^[a-z]{2}$`',
    `consent_method` STRING COMMENT 'The mechanism by which consent was captured. Distinguishes between explicit opt-in (GDPR-compliant), implicit opt-in, pre-checked box (non-compliant in many jurisdictions), verbal consent, written consent, or electronic signature.. Valid values are `explicit_opt_in|implicit_opt_in|pre_checked_box|verbal|written|electronic_signature`',
    `consent_notes` STRING COMMENT 'Free-text notes providing additional context about the consent record. May include details about special circumstances, guest requests, or staff observations during consent capture.',
    `consent_purpose` STRING COMMENT 'The business purpose for which the communication consent applies. Examples include marketing campaigns, promotional offers, transactional notifications, service updates, loyalty program communications, and guest satisfaction surveys.. Valid values are `marketing|promotional|transactional|service_updates|loyalty_program|surveys`',
    `consent_source` STRING COMMENT 'The channel or touchpoint through which the guest provided or withdrew consent. Examples include web form, mobile app, front desk during check-in, call center, email preference link, CRM manual entry by staff, loyalty program enrollment, or booking engine. [ENUM-REF-CANDIDATE: web_form|mobile_app|front_desk|call_center|email_link|crm_manual_entry|loyalty_enrollment|booking_engine — 8 candidates stripped; promote to reference product]',
    `consent_status` STRING COMMENT 'Current status of the guest consent. Indicates whether the guest has opted in, opted out, has a pending consent request, or if consent has expired or been revoked.. Valid values are `opted_in|opted_out|pending|expired|revoked`',
    `consent_text_version` STRING COMMENT 'Version identifier of the consent text or privacy policy that was presented to the guest at the time of consent. Enables audit trail of what terms the guest agreed to.',
    `consent_type` STRING COMMENT 'The communication channel or method for which consent is being tracked. Distinguishes between marketing email, transactional email, SMS, push notifications, postal mail, and phone calls.. Valid values are `marketing_email|transactional_email|sms|push_notification|postal_mail|phone_call`',
    `consent_withdrawn_date` DATE COMMENT 'The date on which the guest withdrew or revoked their consent. Null if consent has not been withdrawn. Required for right-to-withdraw compliance under GDPR Article 7(3).',
    `consent_withdrawn_timestamp` TIMESTAMP COMMENT 'Precise timestamp when consent was withdrawn, including time zone information. Null if consent remains active. Critical for immediate suppression of communications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was first created in the data platform. Part of standard audit trail for data lineage and compliance.',
    `crm_consent_reference` STRING COMMENT 'The unique consent record identifier from the source CRM system (Salesforce). Used for traceability and reconciliation with the operational system of record.',
    `double_opt_in_confirmed_timestamp` TIMESTAMP COMMENT 'Timestamp when the guest confirmed their consent via double opt-in mechanism (e.g., clicked email confirmation link). Null if double opt-in was not used or not yet confirmed.',
    `double_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the consent was confirmed through a double opt-in process (e.g., email confirmation link). True if double opt-in was completed, False otherwise. Best practice for email marketing consent.',
    `guest_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the guest primary country of residence at the time consent was captured. Used to determine applicable privacy regulations.. Valid values are `^[A-Z]{3}$`',
    `ip_address` STRING COMMENT 'The IP address from which the consent was submitted. Used as part of the audit trail to demonstrate consent authenticity. May be considered PII in some jurisdictions.',
    `jurisdiction` STRING COMMENT 'The primary privacy regulation or jurisdiction governing this consent record. Examples include GDPR (EU), CCPA (California), CASL (Canada), LGPD (Brazil), PIPEDA (Canada federal), APPI (Japan), POPIA (South Africa). [ENUM-REF-CANDIDATE: GDPR|CCPA|CASL|LGPD|PIPEDA|APPI|POPIA — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was last updated in the data platform. Tracks the most recent change for audit and reconciliation purposes.',
    `legal_basis` STRING COMMENT 'The lawful basis under GDPR Article 6 for processing the guest personal data for this communication purpose. Options include consent, legitimate interest, contract fulfillment, legal obligation, vital interest, or public task.. Valid values are `consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task`',
    `marketing_cloud_subscriber_key` STRING COMMENT 'The subscriber key from Salesforce Marketing Cloud or equivalent marketing automation platform. Links consent records to email marketing subscriber profiles for suppression list management.',
    `profiling_consent_flag` BOOLEAN COMMENT 'Indicates whether the guest has consented to automated profiling and decision-making for personalized marketing and offers. Required under GDPR Article 22.',
    `record_active_flag` BOOLEAN COMMENT 'Indicates whether this consent record is currently active and should be used for consent enforcement. False if the record has been superseded or logically deleted.',
    `suppression_list_flag` BOOLEAN COMMENT 'Indicates whether this guest and communication type combination is currently on the suppression list (opted out or consent withdrawn). True if suppressed, False if active consent.',
    `third_party_sharing_consent_flag` BOOLEAN COMMENT 'Indicates whether the guest has consented to sharing their personal data with third-party partners (e.g., OTA partners, co-branded loyalty programs). True if consented, False otherwise.',
    `user_agent` STRING COMMENT 'The browser or application user agent string captured at the time of consent submission. Provides additional context for consent authenticity verification.',
    CONSTRAINT pk_communication_consent PRIMARY KEY(`communication_consent_id`)
) COMMENT 'Guest communication consent and privacy preference records tracking opt-in/opt-out status for each communication channel and purpose. Captures consent type (marketing email, SMS, push notification, postal mail, phone), consent status, consent date, withdrawal date, consent source (web, front desk, CRM), jurisdiction (GDPR, CCPA, CASL), and legal basis for processing. Sourced from Salesforce CRM. Mandatory for regulatory compliance with GDPR and CCPA. Distinct from general contact info.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` (
    `identity_document_id` BIGINT COMMENT 'Unique identifier for the guest identity document record. Primary key for the identity document entity.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who owns this identity document. Links to the guest master record in the guest domain.',
    `property_id` BIGINT COMMENT 'Reference to the property where this identity document was captured or verified during check-in. Links to property master data.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the reservation during which this identity document was captured. May be null for documents captured outside of a specific reservation context.',
    `capture_channel` STRING COMMENT 'Channel or touchpoint through which the identity document was captured. Values: front_desk (traditional check-in), mobile_checkin (mobile app), kiosk (self-service kiosk), online_precheckin (web portal), concierge (concierge desk).. Valid values are `front_desk|mobile_checkin|kiosk|online_precheckin|concierge`',
    `capture_timestamp` TIMESTAMP COMMENT 'Date and time when the identity document information was first captured into the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Represents the business event time of document capture.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this document record meets all regulatory compliance requirements for the jurisdiction. True if compliant, False if additional documentation or verification is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this identity document record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field for record creation.',
    `data_retention_category` STRING COMMENT 'Data retention classification for this identity document record. Determines how long the record must be retained per regulatory and business requirements. Values: standard (normal retention period), extended (longer retention for compliance), legal_hold (litigation hold), purge_eligible (eligible for deletion).. Valid values are `standard|extended|legal_hold|purge_eligible`',
    `date_of_birth` DATE COMMENT 'Guest date of birth as recorded on the identity document. Format: yyyy-MM-dd. Used for age verification and compliance.',
    `document_number` STRING COMMENT 'The unique identification number printed on the identity document. This is the primary identifier on the document itself (e.g., passport number, national ID number, drivers license number).',
    `document_scan_reference` STRING COMMENT 'Reference identifier or file path to the scanned image or digital copy of the identity document stored in the document management system. Used for audit and compliance verification.',
    `document_scan_timestamp` TIMESTAMP COMMENT 'Date and time when the identity document was scanned or digitally captured. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `document_type` STRING COMMENT 'Type of identity document presented by the guest. Standard types include passport, national ID card, drivers license, visa, residence permit, and military ID.. Valid values are `passport|national_id|drivers_license|visa|residence_permit|military_id`',
    `expiry_date` DATE COMMENT 'Date on which the identity document expires and is no longer valid for identification purposes. Format: yyyy-MM-dd. Null for documents with no expiration.',
    `full_name_on_document` STRING COMMENT 'Complete legal name as printed on the identity document. Used for verification and compliance purposes to match against guest profile name.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the guest has provided explicit consent for the collection and processing of their identity document data under GDPR. True if consent obtained, False otherwise.',
    `gender` STRING COMMENT 'Gender marker as recorded on the identity document. Values: M (Male), F (Female), X (Unspecified/Non-binary), U (Unknown/Not stated).. Valid values are `M|F|X|U`',
    `government_report_status` STRING COMMENT 'Status of government reporting submission for this identity document. Values: not_required (no reporting obligation), pending (awaiting submission), submitted (sent to authorities), confirmed (acknowledged by authorities), failed (submission error).. Valid values are `not_required|pending|submitted|confirmed|failed`',
    `government_report_timestamp` TIMESTAMP COMMENT 'Date and time when the identity document information was reported to government authorities. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if not yet reported or not required.',
    `government_reporting_required` BOOLEAN COMMENT 'Boolean flag indicating whether this identity document record must be reported to government authorities per local regulations (e.g., police registration, immigration reporting). True if reporting is required, False otherwise.',
    `is_primary_document` BOOLEAN COMMENT 'Boolean flag indicating whether this is the primary identity document on file for the guest. True if this is the main document used for identification, False otherwise.',
    `issue_date` DATE COMMENT 'Date on which the identity document was issued by the issuing authority. Format: yyyy-MM-dd.',
    `issuing_authority` STRING COMMENT 'Name of the government agency or authority that issued the identity document (e.g., U.S. Department of State, UK Home Office, Ministry of Interior).',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country or jurisdiction that issued the identity document.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this identity document record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Audit trail field for record modification.',
    `nationality_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the guests nationality as stated on the identity document.. Valid values are `^[A-Z]{3}$`',
    `place_of_birth` STRING COMMENT 'City and country of birth as recorded on the identity document. Used for enhanced identity verification in some jurisdictions.',
    `verification_method` STRING COMMENT 'Method used to verify the authenticity of the identity document. Values: manual (staff visual inspection), automated (OCR/document scanner), biometric (facial recognition or fingerprint match), third_party (external verification service).. Valid values are `manual|automated|biometric|third_party`',
    `verification_notes` STRING COMMENT 'Free-text notes recorded by staff during the verification process. May include observations about document condition, discrepancies, or reasons for rejection.',
    `verification_status` STRING COMMENT 'Current verification status of the identity document. Indicates whether the document has been validated by staff or automated systems. Values: pending (awaiting verification), verified (validated and accepted), rejected (invalid or fraudulent), expired (document past expiry date), flagged (requires additional review).. Valid values are `pending|verified|rejected|expired|flagged`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the identity document verification was completed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `visa_entry_type` STRING COMMENT 'Entry type permitted by the visa. Values: single (one entry only), multiple (multiple entries allowed), transit (transit visa). Null for non-visa documents.. Valid values are `single|multiple|transit`',
    `visa_type` STRING COMMENT 'Type or category of visa if the document is a visa (e.g., tourist, business, student, work). Null for non-visa documents.',
    CONSTRAINT pk_identity_document PRIMARY KEY(`identity_document_id`)
) COMMENT 'Guest identity document records capturing passport, national ID, drivers license, and visa details required for check-in compliance and international travel regulations. Captures document type, document number, issuing country, issue date, expiry date, scan/image reference, and verification status. Sourced from OPERA PMS check-in capture. Required for AML compliance, international property operations, and government reporting in applicable jurisdictions.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique identifier for the guest market segment record. Primary key for both segment master definitions and individual guest-to-segment assignment records.',
    `parent_segment_id` BIGINT COMMENT 'Reference to the parent segment in the hierarchy for roll-up aggregation. Null for top-level segments.',
    `primary_superseded_by_assignment_segment_id` BIGINT COMMENT 'Reference to the segment assignment record that supersedes this one. Used for tracking segment migration history and maintaining assignment lineage.',
    `property_id` BIGINT COMMENT 'Foreign key linking to property.property. Business justification: Market segments in hospitality revenue management are defined and managed at the property level. Property-specific segment definitions drive rate strategy, displacement analysis, and RevPAR contributi',
    `adr_index_vs_property` DECIMAL(18,2) COMMENT 'Average Daily Rate index for this segment relative to property-wide ADR. 1.0 = at property average, >1.0 = premium segment, <1.0 = discount segment. Used for segment mix optimization.',
    `advance_booking_window_days` STRING COMMENT 'Typical advance booking window in days for this segment. Used for demand forecasting and pickup analysis. Transient segments typically 0-30 days, Group segments 90-365 days.',
    `ancillary_revenue_per_stay` DECIMAL(18,2) COMMENT 'Average ancillary revenue (F&B, spa, parking, resort fees, etc.) per stay for this segment. Used for total revenue forecasting and TRevPAR optimization.',
    `assignment_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.000 to 1.000) for ML-inferred segment assignments. Higher scores indicate greater model certainty. Null for rule-based and manual assignments.',
    `assignment_date` DATE COMMENT 'Date when the guest was assigned to this segment. Used for tracking segment migration and guest lifecycle analysis.',
    `assignment_effective_date` DATE COMMENT 'Date from which this segment assignment is effective for the guest. Used for time-bound segment membership (e.g., corporate contract validity period).',
    `assignment_expiry_date` DATE COMMENT 'Date when this segment assignment expires for the guest. Null for indefinite assignments. Used for contract-based and time-limited segment memberships.',
    `assignment_method` STRING COMMENT 'Method used to assign the guest to this segment. Rule-based uses business rules (e.g., booking channel, rate code), ML-inferred uses machine learning models for predictive segmentation, Manual-override represents analyst or sales manager assignment, Reservation-based inherits from reservation market segment code.. Valid values are `rule_based|ml_inferred|manual_override|reservation_based`',
    `assignment_notes` STRING COMMENT 'Free-text notes explaining the rationale for manual segment assignments or overrides. Used for audit trail and knowledge transfer.',
    `assignment_reason_code` STRING COMMENT 'Code indicating the business reason for this segment assignment (e.g., CORP_CONTRACT, BOOKING_CHANNEL, STAY_PATTERN, SALES_OVERRIDE, LTV_TIER). Used for assignment audit and quality control.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `average_los_days` DECIMAL(18,2) COMMENT 'Historical average Length of Stay in days for guests in this segment. Used for demand forecasting and inventory optimization.',
    `cancellation_policy_code` STRING COMMENT 'Code identifying the cancellation and modification policy applicable to this segment (e.g., 24HR, 72HR, NRR for Non-Refundable Rate, FLEX).. Valid values are `^[A-Z0-9]{2,6}$`',
    `segment_category` STRING COMMENT 'Broader business category for revenue and demand analysis. Used for RevPAR (Revenue Per Available Room) decomposition and TRevPAR (Total Revenue Per Available Room) attribution.. Valid values are `leisure|business|group|contract|other`',
    `segment_code` STRING COMMENT 'Short alphanumeric code identifying the market segment (e.g., TRANS, GRP, CORP, WHSL, COMP, CREW). Sourced from OPERA PMS Market Segment codes and IDeaS G3 RMS segment taxonomy.. Valid values are `^[A-Z0-9]{2,10}$`',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether bookings in this segment are eligible for travel agent or OTA commission payments.',
    `commission_rate_pct` DECIMAL(18,2) COMMENT 'Standard commission percentage paid to intermediaries for bookings in this segment. Null if commission_eligible is False.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the lakehouse. Used for data lineage and audit trail.',
    `displacement_analysis_eligible` BOOLEAN COMMENT 'Indicates whether group bookings in this segment should undergo displacement analysis to compare group revenue against potential transient revenue. Used for group evaluation and acceptance decisions.',
    `effective_end_date` DATE COMMENT 'Date when this segment definition was retired or superseded. Null for currently active segments.',
    `effective_start_date` DATE COMMENT 'Date when this segment definition became effective. Used for historical segment analysis and time-travel queries.',
    `fb_attachment_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of guests in this segment who purchase F&B services during their stay. Used for TRevPAR analysis and ancillary revenue forecasting.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the segment hierarchy for roll-up reporting. Level 1 is top-level (e.g., Transient), Level 2 is sub-segment (e.g., Qualified Corporate), Level 3 is micro-segment (e.g., Tech Industry Corporate).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was last updated. Used for change tracking and incremental processing.',
    `loyalty_points_eligible` BOOLEAN COMMENT 'Indicates whether stays booked under this segment earn loyalty program points and elite night credits.',
    `loyalty_points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base points earning for this segment. Standard is 1.0, promotional segments may have higher multipliers (e.g., 1.5x, 2.0x).',
    `lra_eligible` BOOLEAN COMMENT 'Indicates whether this segment has Last Room Availability commitment, meaning inventory is available at the contracted rate even when the property is sold out. Typically True for top-tier corporate contracts and loyalty elite members.',
    `modified_by_user` STRING COMMENT 'Username or system identifier of the user or process that last modified this record. Used for audit trail and accountability.',
    `segment_name` STRING COMMENT 'Full descriptive name of the market segment (e.g., Transient, Group, Corporate Negotiated, Wholesale, Complimentary, Airline Crew).',
    `rate_strategy_type` STRING COMMENT 'Pricing strategy applicable to this segment. Dynamic uses RMS (Revenue Management System) optimization, Fixed uses BAR (Best Available Rate) or published rates, Negotiated uses contracted rates, Promotional uses discount codes, Opaque uses non-branded OTA channels.. Valid values are `dynamic|fixed|negotiated|promotional|opaque`',
    `revpar_contribution_pct` DECIMAL(18,2) COMMENT 'Historical percentage contribution of this segment to total property RevPAR. Sum across all segments equals 100%. Used for strategic segment mix planning.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment definition. Active segments are available for assignment and reporting, Inactive segments are hidden from selection but retained for historical analysis, Deprecated segments are being phased out, Pending segments are awaiting approval.. Valid values are `active|inactive|deprecated|pending`',
    `segment_type` STRING COMMENT 'High-level classification of the segment type. Transient represents FIT (Free Independent Traveler) guests, Group represents MICE (Meetings Incentives Conferences Exhibitions) and leisure groups, Contract represents negotiated corporate accounts, Wholesale represents OTA (Online Travel Agency) and tour operator bookings, Complimentary represents comp stays and employee rates, Crew represents airline and travel industry staff.. Valid values are `transient|group|contract|wholesale|complimentary|crew`',
    `source_system_code` STRING COMMENT 'Unique identifier of this segment in the source system. Used for data reconciliation and lineage tracking.',
    `usali_mapping_code` STRING COMMENT 'Standard USALI account code for financial reporting and GOP (Gross Operating Profit) attribution. Ensures consistent revenue classification across properties.. Valid values are `^[A-Z0-9]{2,6}$`',
    `yield_management_flag` BOOLEAN COMMENT 'Indicates whether this segment is subject to dynamic yield optimization and inventory controls by the RMS. True for transient and qualified segments, False for contracted and complimentary segments.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Guest market segmentation master definitions and individual guest-to-segment assignment records. The master component defines business segments (transient, group, contract, wholesale, complimentary, crew) with segment code, name, hierarchy level, USALI mapping, and applicable rate strategy. The assignment component tracks individual guest-to-segment associations including assignment date, assignment method (rule-based, ML-inferred, manual override), confidence score, validity period, and superseding assignment reference. Sourced from OPERA PMS Market Segment codes, IDeaS G3 RMS, and Salesforce CRM segmentation. Used for RevPAR analysis, demand forecasting, targeted marketing, rate fence enforcement, and LTV-based prioritization. Note: this product contains both reference definitions and transactional assignments — the master definitions change infrequently while assignments are high-volume.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_merged_into_profile_id` FOREIGN KEY (`merged_into_profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ADD CONSTRAINT `fk_guest_contact_info_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ADD CONSTRAINT `fk_guest_corporate_account_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ADD CONSTRAINT `fk_guest_communication_consent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_parent_segment_id` FOREIGN KEY (`parent_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_primary_superseded_by_assignment_segment_id` FOREIGN KEY (`primary_superseded_by_assignment_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`guest` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`guest` SET TAGS ('dbx_domain' = 'guest');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `merged_into_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Merged Into Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `accessibility_needs` SET TAGS ('dbx_business_glossary_term' = 'Guest Accessibility Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `accessibility_needs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `address` SET TAGS ('dbx_pii_classification' = 'PII');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `address` SET TAGS ('dbx_sensitivity' = 'confidential');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Guest Date of Birth');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_classification' = 'PII');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `birth_date` SET TAGS ('dbx_sensitivity' = 'confidential');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `country_of_residence_code` SET TAGS ('dbx_business_glossary_term' = 'Guest Country of Residence Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `country_of_residence_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `country_of_residence_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `country_of_residence_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile Record Creation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `creation_property_code` SET TAGS ('dbx_business_glossary_term' = 'Profile Creation Property Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `crm_contact_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Contact ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `crm_contact_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `crm_contact_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `data_privacy_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Guest Data Privacy Consent Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `data_privacy_consent_date` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `data_privacy_consent_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Guest Primary Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_pii_classification' = 'PII');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'confidential');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Guest Email Marketing Opt-In Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Family Name (Last Name)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `family_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `gdpr_erasure_requested` SET TAGS ('dbx_business_glossary_term' = 'GDPR Right to Erasure Request Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `gdpr_erasure_requested` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `gdpr_erasure_requested` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Guest Gender');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'M|F|X|U');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Given Name (First Name)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `given_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `guest_type` SET TAGS ('dbx_business_glossary_term' = 'Guest Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `guest_type` SET TAGS ('dbx_value_regex' = 'FIT|CORPORATE|GROUP|CREW|TRAVEL_AGENT|VIP');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `is_merge_survivor` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile Merge Survivor Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Guest Job Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `job_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `loyalty_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Enrollment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Member Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'NONE|SILVER|GOLD|PLATINUM|DIAMOND');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Guest Marketing Communications Opt-In Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Middle Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Guest Mobile Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_classification' = 'PII');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_sensitivity' = 'confidential');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `name_prefix` SET TAGS ('dbx_business_glossary_term' = 'Guest Name Prefix (Salutation)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `name_prefix` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `name_prefix` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `name_suffix` SET TAGS ('dbx_business_glossary_term' = 'Guest Name Suffix');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `name_suffix` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_business_glossary_term' = 'Guest Nationality Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `opera_profile_reference` SET TAGS ('dbx_business_glossary_term' = 'Oracle OPERA PMS Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `opera_profile_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `opera_profile_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Guest Passport Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Guest Passport Issuing Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_issuing_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_issuing_country_code` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_issuing_country_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_issuing_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Guest Passport Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_classification' = 'PII');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `passport_number` SET TAGS ('dbx_sensitivity' = 'restricted');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Guest Primary Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_pii_classification' = 'PII');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `phone` SET TAGS ('dbx_sensitivity' = 'confidential');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `preferred_bed_type` SET TAGS ('dbx_business_glossary_term' = 'Guest Preferred Bed Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `preferred_bed_type` SET TAGS ('dbx_value_regex' = 'KING|QUEEN|DOUBLE|TWIN|SINGLE');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `preferred_floor` SET TAGS ('dbx_business_glossary_term' = 'Guest Preferred Floor');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Guest Preferred Language Code (ISO 639-1)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile Lifecycle Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|suspended|deceased');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `smoking_preference` SET TAGS ('dbx_business_glossary_term' = 'Guest Smoking Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `smoking_preference` SET TAGS ('dbx_value_regex' = 'NON_SMOKING|SMOKING|NO_PREFERENCE');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `sms_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Guest SMS Marketing Opt-In Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `vip_status` SET TAGS ('dbx_business_glossary_term' = 'Guest VIP Status Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `vip_status` SET TAGS ('dbx_value_regex' = 'NONE|VIP1|VIP2|VIP3|VVIP|BLACKLIST');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `contact_info_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Information ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `contact_info_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|billing|mailing|work|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_validated_date` SET TAGS ('dbx_business_glossary_term' = 'Address Validated Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_validated_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_validated_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_validated_date` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_validated_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed|corrected');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `address_validation_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `bounce_reason` SET TAGS ('dbx_business_glossary_term' = 'Bounce Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `bounce_reason` SET TAGS ('dbx_value_regex' = 'hard_bounce|soft_bounce|spam_complaint|invalid_address|unsubscribed');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `contact_channel` SET TAGS ('dbx_business_glossary_term' = 'Contact Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `contact_channel` SET TAGS ('dbx_value_regex' = 'email|phone|postal|social|messaging');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `contact_channel` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|bounced|undeliverable|suppressed');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `contact_status` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|work|home|billing|emergency');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `contact_type` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `email_type` SET TAGS ('dbx_business_glossary_term' = 'Email Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `email_type` SET TAGS ('dbx_value_regex' = 'personal|work|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `email_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `email_type` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Lawful Basis');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interests|public_task|legitimate_interests');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Contact Verified Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `latitude` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `longitude` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `marketing_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `marketing_opt_in_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `marketing_opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-Out Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `marketing_opt_out_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `messaging_handle` SET TAGS ('dbx_business_glossary_term' = 'Messaging Platform ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `messaging_handle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `messaging_handle` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `messaging_handle` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `messaging_handle` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `messaging_platform` SET TAGS ('dbx_business_glossary_term' = 'Messaging Platform');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `messaging_platform` SET TAGS ('dbx_value_regex' = 'whatsapp|wechat|line|sms|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `opt_in_source` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_country_code` SET TAGS ('dbx_business_glossary_term' = 'Phone Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_country_code` SET TAGS ('dbx_value_regex' = '^+[1-9]d{0,3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_country_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_country_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_type` SET TAGS ('dbx_business_glossary_term' = 'Phone Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_type` SET TAGS ('dbx_value_regex' = 'mobile|home|work|fax');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_type` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `phone_type` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `social_handle` SET TAGS ('dbx_business_glossary_term' = 'Social Media Handle');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `social_handle` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `social_handle` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `social_handle` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `social_handle` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `social_platform` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platform');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `social_platform` SET TAGS ('dbx_value_regex' = 'twitter|instagram|facebook|linkedin|wechat|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `social_platform` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `transactional_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Transactional Communication Opt-In Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Verified Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` SET TAGS ('dbx_subdomain' = 'stay_engagement');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Preference ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `treatment_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `treatment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `treatment_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `allergy_detail` SET TAGS ('dbx_business_glossary_term' = 'Allergy Detail');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `allergy_detail` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `allergy_detail` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `amenity_preferences` SET TAGS ('dbx_business_glossary_term' = 'Amenity Preferences');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `bed_type_preference` SET TAGS ('dbx_business_glossary_term' = 'Bed Type Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `preference_category` SET TAGS ('dbx_business_glossary_term' = 'Preference Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `preference_code` SET TAGS ('dbx_business_glossary_term' = 'Preference Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `preference_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `communication_channel_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `communication_channel_preference` SET TAGS ('dbx_value_regex' = 'email|sms|phone|app_push|whatsapp|no_contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Consent Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `consent_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Preference Data Consent Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `consent_given` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `data_classification` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `dietary_restriction` SET TAGS ('dbx_business_glossary_term' = 'Dietary Restriction');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `fulfillment_notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Fulfillment Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Fulfillment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'pending|fulfilled|partially_fulfilled|not_available|waived');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `housekeeping_schedule_preference` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Schedule Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `housekeeping_schedule_preference` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|do_not_disturb|every_other_day|checkout_only');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `is_ada_requirement` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Requirement Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `is_allergy` SET TAGS ('dbx_business_glossary_term' = 'Allergy Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Preference Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `last_confirmed_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Last Confirmed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `loyalty_tier_at_capture` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier at Capture');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `newspaper_preference` SET TAGS ('dbx_business_glossary_term' = 'Newspaper Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `pillow_type_preference` SET TAGS ('dbx_business_glossary_term' = 'Pillow Type Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_verification|superseded');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `preference_type` SET TAGS ('dbx_business_glossary_term' = 'Preference Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Preference Priority Rank');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `room_floor_preference` SET TAGS ('dbx_business_glossary_term' = 'Room Floor Level Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `room_floor_preference` SET TAGS ('dbx_value_regex' = 'low|mid|high|top|no_preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `room_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Room Temperature Preference (Celsius)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `smoking_preference` SET TAGS ('dbx_business_glossary_term' = 'Smoking Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `smoking_preference` SET TAGS ('dbx_value_regex' = 'non_smoking|smoking|no_preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Preference Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Preference Valid Until Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Preference Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `view_type_preference` SET TAGS ('dbx_business_glossary_term' = 'Room View Type Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Preference Valid From Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` SET TAGS ('dbx_subdomain' = 'corporate_segmentation');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Event Account Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `cancellation_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_manager_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_manager_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'corporate|government|consortium|travel_management_company|wholesale|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `annual_room_night_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Room Night Production Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `annual_room_night_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_city` SET TAGS ('dbx_business_glossary_term' = 'Billing Address City');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_city` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_city` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_country_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_instruction` SET TAGS ('dbx_business_glossary_term' = 'Billing Instruction');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `billing_instruction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `blackout_dates_policy` SET TAGS ('dbx_business_glossary_term' = 'Blackout Dates Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `company_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Direct Billing Credit Limit');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `crm_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `data_privacy_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Consent Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `data_privacy_consent` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `data_privacy_consent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `direct_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Direct Billing Enabled Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Discount Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `discount_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `gdpr_data_subject_region` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Data Subject Region');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `gdpr_data_subject_region` SET TAGS ('dbx_value_regex' = 'eu|uk|california|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `gdpr_data_subject_region` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `gdpr_data_subject_region` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `industry_naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `industry_naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `industry_sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `industry_sic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `los_minimum_nights` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay (LOS) Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `loyalty_program_eligible` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `mice_eligible` SET TAGS ('dbx_business_glossary_term' = 'Meetings Incentives Conferences Exhibitions (MICE) Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `negotiated_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Rate Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `negotiated_rate_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `negotiated_rate_code` SET TAGS ('dbx_normalization' = 'natural_key_resolved');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `negotiated_rate_code` SET TAGS ('dbx_denormalized_natural_key' = 'resolved');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `opera_ar_account_number` SET TAGS ('dbx_business_glossary_term' = 'Oracle OPERA Accounts Receivable (AR) Account Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `opera_ar_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `opera_ar_account_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `opera_ar_account_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|immediate|prepaid');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `preferred_property_codes` SET TAGS ('dbx_business_glossary_term' = 'Preferred Property Codes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Corporate Contact Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Corporate Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Corporate Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `rate_program_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Program Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `rate_program_type` SET TAGS ('dbx_value_regex' = 'lra|nrr|bar_discount|fixed_rate|dynamic');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `tax_exempt_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `tax_exempt_status` SET TAGS ('dbx_value_regex' = 'exempt|partial|taxable');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `tax_exempt_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `tax_exemption_certificate` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `tax_exemption_certificate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `tax_exemption_certificate` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `tax_exemption_certificate` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Company Trading Name (DBA)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `trading_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `trading_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `vip_tier` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account VIP Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `vip_tier` SET TAGS ('dbx_value_regex' = 'standard|preferred|key|strategic');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` SET TAGS ('dbx_subdomain' = 'stay_engagement');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `vip_designation_id` SET TAGS ('dbx_business_glossary_term' = 'VIP Designation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `airport_transfer_required` SET TAGS ('dbx_business_glossary_term' = 'Airport Transfer Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `alias_name` SET TAGS ('dbx_business_glossary_term' = 'VIP Guest Alias Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `alias_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `alias_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `alias_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `amenity_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Amenity Tier Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `amenity_tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `concurrent_designation_count` SET TAGS ('dbx_business_glossary_term' = 'Concurrent Designation Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `designation_code` SET TAGS ('dbx_business_glossary_term' = 'VIP Designation Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `designation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `designation_notes` SET TAGS ('dbx_business_glossary_term' = 'VIP Designation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `designation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `designation_reason` SET TAGS ('dbx_business_glossary_term' = 'VIP Designation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `designation_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `designation_scope` SET TAGS ('dbx_business_glossary_term' = 'VIP Designation Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `designation_scope` SET TAGS ('dbx_value_regex' = 'brand|property|regional');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `designation_status` SET TAGS ('dbx_business_glossary_term' = 'VIP Designation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `designation_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|pending_review');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `do_not_disturb` SET TAGS ('dbx_business_glossary_term' = 'Do Not Disturb (DND) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'VIP Designation Effective From Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'VIP Designation Effective Until Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `gm_greeting_required` SET TAGS ('dbx_business_glossary_term' = 'General Manager (GM) Greeting Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `incognito_checkin` SET TAGS ('dbx_business_glossary_term' = 'Incognito Check-In Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `incognito_checkin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `last_stay_date` SET TAGS ('dbx_business_glossary_term' = 'Last Stay Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `media_blackout` SET TAGS ('dbx_business_glossary_term' = 'Media Blackout Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `media_blackout` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `no_photo_policy` SET TAGS ('dbx_business_glossary_term' = 'No Photo Policy Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `no_photo_policy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `pre_arrival_checklist_template` SET TAGS ('dbx_business_glossary_term' = 'Pre-Arrival Checklist Template Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `pre_arrival_checklist_template` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,50}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `revenue_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'VIP Revenue Threshold Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `revenue_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `revenue_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Threshold Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `revenue_threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'VIP Designation Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'VIP Designation Revocation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_value_regex' = 'revenue_below_threshold|relationship_ended|policy_violation|guest_request|duplicate_record|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `room_assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Room Assignment Priority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `security_escort_required` SET TAGS ('dbx_business_glossary_term' = 'Security Escort Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `security_escort_required` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `service_recovery_escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Escalation Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `service_recovery_escalation_level` SET TAGS ('dbx_value_regex' = 'standard|elevated|executive|immediate_gm');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `source_system_vip_code` SET TAGS ('dbx_business_glossary_term' = 'Source System VIP Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `source_system_vip_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `total_stays_in_period` SET TAGS ('dbx_business_glossary_term' = 'Total Stays in Designation Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `upgrade_eligible` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `vip_level` SET TAGS ('dbx_business_glossary_term' = 'VIP Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` SET TAGS ('dbx_subdomain' = 'stay_engagement');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Member Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `reservation_rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Rate Plan Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `adr` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Rate (ADR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `adr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `adr` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `ancillary_revenue` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `ancillary_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `ancillary_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `checkin_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `checkout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-Out Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `complimentary_flag` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Stay Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Departure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `do_not_disturb_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Disturb Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `fb_revenue` SET TAGS ('dbx_business_glossary_term' = 'Food and Beverage (F&B) Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `fb_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `fb_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `gss_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score (GSS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `guest_type` SET TAGS ('dbx_business_glossary_term' = 'Guest Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `guest_type` SET TAGS ('dbx_value_regex' = 'fit|corporate|group|crew|complimentary');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Length Of Stay');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `los_nights` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (LOS) Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `loyalty_tier_at_stay` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier at Stay');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `num_adults` SET TAGS ('dbx_business_glossary_term' = 'Number of Adults');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `num_children` SET TAGS ('dbx_business_glossary_term' = 'Number of Children');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `original_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Original Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `original_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Original Departure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|cash|direct_bill|loyalty_points|bank_transfer');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `qualifying_nights` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `room_revenue` SET TAGS ('dbx_business_glossary_term' = 'Room Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `room_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `room_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `rooms_sold` SET TAGS ('dbx_business_glossary_term' = 'Rooms Sold');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `service_recovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Recovery Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `stay_status` SET TAGS ('dbx_business_glossary_term' = 'Stay Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `stay_status` SET TAGS ('dbx_value_regex' = 'completed|early_departure|extended|no_show|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `total_folio_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Folio Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `total_folio_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `total_folio_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `vip_code` SET TAGS ('dbx_business_glossary_term' = 'VIP Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `communication_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Consent ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `communication_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Property Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Consent Audit Trail');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_audit_trail` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_capture_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_capture_url` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_granted_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Granted Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_granted_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_granted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Granted Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_granted_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_language_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_language_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_language_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_value_regex' = 'explicit_opt_in|implicit_opt_in|pre_checked_box|verbal|written|electronic_signature');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_method` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_notes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_value_regex' = 'marketing|promotional|transactional|service_updates|loyalty_program|surveys');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_source` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'opted_in|opted_out|pending|expired|revoked');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_text_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Text Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_text_version` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing_email|transactional_email|sms|push_notification|postal_mail|phone_call');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_withdrawn_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawn Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_withdrawn_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_withdrawn_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawn Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `consent_withdrawn_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `crm_consent_reference` SET TAGS ('dbx_business_glossary_term' = 'CRM (Customer Relationship Management) Consent ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `crm_consent_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `double_opt_in_confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `double_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `guest_country_code` SET TAGS ('dbx_business_glossary_term' = 'Guest Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `guest_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `guest_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Privacy Jurisdiction');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `marketing_cloud_subscriber_key` SET TAGS ('dbx_business_glossary_term' = 'Marketing Cloud Subscriber Key');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `profiling_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Profiling Consent Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `profiling_consent_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `suppression_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression List Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `third_party_sharing_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Sharing Consent Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `third_party_sharing_consent_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` SET TAGS ('dbx_subdomain' = 'guest_identity');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `identity_document_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Document ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `identity_document_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `capture_channel` SET TAGS ('dbx_business_glossary_term' = 'Capture Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `capture_channel` SET TAGS ('dbx_value_regex' = 'front_desk|mobile_checkin|kiosk|online_precheckin|concierge');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Capture Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `data_retention_category` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `data_retention_category` SET TAGS ('dbx_value_regex' = 'standard|extended|legal_hold|purge_eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `data_retention_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `document_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `document_scan_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Scan Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `document_scan_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `document_scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Scan Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'passport|national_id|drivers_license|visa|residence_permit|military_id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `full_name_on_document` SET TAGS ('dbx_business_glossary_term' = 'Full Name on Document');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `full_name_on_document` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `full_name_on_document` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `full_name_on_document` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Consent Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'M|F|X|U');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `gender` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `government_report_status` SET TAGS ('dbx_business_glossary_term' = 'Government Report Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `government_report_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|confirmed|failed');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `government_report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Government Report Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `government_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Government Reporting Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `is_primary_document` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Document Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `nationality_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `nationality_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `nationality_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `nationality_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `place_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Place of Birth');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `place_of_birth` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `place_of_birth` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'manual|automated|biometric|third_party');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `verification_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|expired|flagged');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `visa_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Entry Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `visa_entry_type` SET TAGS ('dbx_value_regex' = 'single|multiple|transit');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `visa_type` SET TAGS ('dbx_business_glossary_term' = 'Visa Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` SET TAGS ('dbx_subdomain' = 'corporate_segmentation');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `parent_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Segment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `primary_superseded_by_assignment_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Assignment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `adr_index_vs_property` SET TAGS ('dbx_business_glossary_term' = 'ADR (Average Daily Rate) Index vs Property');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `advance_booking_window_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Booking Window Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `ancillary_revenue_per_stay` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Revenue Per Stay');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `assignment_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Assignment Confidence Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `assignment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `assignment_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_inferred|manual_override|reservation_based');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `assignment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `assignment_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `average_los_days` SET TAGS ('dbx_business_glossary_term' = 'Average LOS (Length of Stay) Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `average_los_days` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_category` SET TAGS ('dbx_business_glossary_term' = 'Segment Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_category` SET TAGS ('dbx_value_regex' = 'leisure|business|group|contract|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `commission_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `displacement_analysis_eligible` SET TAGS ('dbx_business_glossary_term' = 'Displacement Analysis Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `fb_attachment_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'F&B (Food and Beverage) Attachment Rate Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `loyalty_points_eligible` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `loyalty_points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Multiplier');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `lra_eligible` SET TAGS ('dbx_business_glossary_term' = 'LRA (Last Room Availability) Eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `rate_strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Strategy Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `rate_strategy_type` SET TAGS ('dbx_value_regex' = 'dynamic|fixed|negotiated|promotional|opaque');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `revpar_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'RevPAR (Revenue Per Available Room) Contribution Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'transient|group|contract|wholesale|complimentary|crew');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `usali_mapping_code` SET TAGS ('dbx_business_glossary_term' = 'USALI (Uniform System of Accounts for the Lodging Industry) Mapping Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `usali_mapping_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `yield_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Yield Management Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `yield_management_flag` SET TAGS ('dbx_pii_tracked' = 'true');
