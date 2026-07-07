-- Schema for Domain: guest | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`guest` COMMENT 'Single source of truth for guest identity, profiles, preferences, contact information, demographics, stay history, and segmentation across all properties and brands. Manages individual travelers, corporate accounts, group contacts, and VIP profiles. Supports FIT, corporate, and group guest types. Integrates with CRM (Salesforce) and loyalty platforms for unified guest view and lifetime value tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` (
    `profile_id` BIGINT COMMENT 'Unique surrogate identifier for the guest master profile record in the lakehouse silver layer. This is the primary key and golden record anchor for all guest identity resolution across properties and brands. Role: MASTER_PARTY.',
    `merged_into_profile_id` BIGINT COMMENT 'When profile_status = merged, this field references the survivor profile_id into which this record was consolidated. Enables audit trail of merge lineage and supports identity resolution queries across the guest domain.',
    `predictive_score_id` BIGINT COMMENT '',
    `accessibility_needs` STRING COMMENT 'Free-text or coded description of the guests accessibility requirements (e.g., wheelchair accessible room, roll-in shower, hearing loop, visual impairment aids). Drives ADA-compliant room assignment and service delivery. Treated as sensitive personal data.',
    `address` STRING COMMENT 'The address of the profile.',
    `birth_date` DATE COMMENT 'The guests date of birth in ISO 8601 format (yyyy-MM-dd). Used for age verification, birthday recognition programs, loyalty tier benefits, and regulatory identity verification at check-in.',
    `company_name` STRING COMMENT 'The name of the company or corporate account associated with this guest profile. Used for corporate rate eligibility, billing to master accounts, and corporate segment analytics. Applicable primarily to CORPORATE guest type.',
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
    `preferred_room_type` STRING COMMENT 'The guests stated or historically derived preferred room type (e.g., King Deluxe, Suite, Double Queen). Stored as a room type code from the PMS room type configuration. Used by front desk for pre-arrival room assignment and upsell targeting.',
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
    `employee_id` BIGINT COMMENT 'Reference to the staff member who captured or last updated this preference record. Supports accountability tracking and training analytics for preference capture quality.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile to whom this preference record belongs. Links the preference to the unified guest identity in the guest domain.',
    `property_id` BIGINT COMMENT 'Reference to the property at which this preference was captured or is applicable. A null value indicates the preference applies globally across all properties for the guest.',
    `stay_history_id` BIGINT COMMENT 'Reference to the specific stay or reservation during which this preference was captured or last confirmed. Enables preference-to-stay linkage for analytics on preference fulfillment rates and guest satisfaction correlation.',
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
    `credit_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the credit limit and billing amounts are denominated for this corporate account (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
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
    `market_segment_code` STRING COMMENT 'Market segment code assigned to this corporate account in the Revenue Management System (RMS) and PMS. Used for STR benchmarking, RevPAR analysis, and demand forecasting segmentation (e.g., CORP, GOVT, CONSOR).',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` (
    `guest_group_block_id` BIGINT COMMENT 'Unique surrogate identifier for the guest group block record in the lakehouse silver layer. Primary key. Entity role: MASTER_AGREEMENT — represents a contracted room block allocation binding the property to a group organizer for a defined stay window.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Group blocks are frequently generated by marketing campaigns (wedding packages, conference promotions, corporate incentive programs). Group sales teams track campaign attribution for ROI measurement, ',
    `corporate_account_id` BIGINT COMMENT 'Reference to the accounts receivable (AR) master account or corporate billing account to which the group master folio charges are posted. Sourced from OPERA PMS AR module.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile of the primary group leader or organizer responsible for the block. Sourced from OPERA PMS guest profile or Salesforce CRM contact.',
    `employee_id` BIGINT COMMENT 'Reference to the internal hotel employee or sales coordinator assigned to manage this group block from the property side.',
    `property_id` BIGINT COMMENT 'Reference to the property at which the group room block is contracted. Links to the property master in the property domain.',
    `reservation_group_block_id` BIGINT COMMENT '',
    `accessible_rooms_requested` STRING COMMENT 'Number of ADA-compliant accessible rooms requested within the group block. Tracked for ADA compliance and pre-assignment planning.',
    `arrival_date` DATE COMMENT 'The first date of the contracted room block period — the date the group is scheduled to begin checking in. Serves as EFFECTIVE_FROM for this agreement.',
    `attrition_pct` DECIMAL(18,2) COMMENT 'Contractual minimum pickup percentage the group must achieve to avoid attrition penalties. Expressed as a percentage (e.g., 80.00 means the group must pick up at least 80% of contracted rooms). Aligns with revenue.wash_factor domain.',
    `billing_master_folio_instructions` STRING COMMENT 'Free-text instructions governing how charges are routed and settled for the group block master folio (e.g., Room and tax to master; incidentals to individual guest folio, All F&B charges to master account). Sourced from OPERA PMS cashiering module.',
    `block_status` STRING COMMENT 'Current lifecycle state of the group room block. Tentative indicates a hold pending contract execution; Definite indicates a signed/confirmed block; Cancelled indicates the block was released; Closed indicates the group has departed and the block is reconciled. Serves as the LIFECYCLE_STATUS for this MASTER_AGREEMENT entity.. Valid values are `tentative|definite|cancelled|closed|waitlist`',
    `cancellation_date` DATE COMMENT 'The date on which the group block was cancelled, if applicable. Null for active or closed blocks. Used for attrition penalty calculation and revenue recovery tracking.',
    `cancellation_policy_code` STRING COMMENT 'Code referencing the cancellation and penalty policy applicable to this group block contract. Governs financial penalties if the group cancels after the cutoff date.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `complimentary_rooms_contracted` STRING COMMENT 'Number of complimentary (comp) rooms included in the group block contract, typically awarded on a ratio basis (e.g., 1 comp per 40 paid rooms). Tracked separately for revenue accounting under USALI.',
    `contracted_date` DATE COMMENT 'The date on which the group block contract was formally executed and the block status moved to Definite. Represents the BUSINESS_EVENT_TIMESTAMP for the agreement lifecycle.',
    `contracted_rate_amount` DECIMAL(18,2) COMMENT 'Negotiated room rate per night per room agreed in the group block contract. Expressed in the propertys operating currency. Confidential commercial term.',
    `contracted_room_nights` STRING COMMENT 'Total number of room nights committed in the group block contract across all room types and all nights of the block period. Primary quantitative measure of block size.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the group block record was first created in the source system (OPERA PMS or Delphi). Serves as RECORD_AUDIT_CREATED for this entity.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values on this group block record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cutoff_date` DATE COMMENT 'The contractual deadline by which individual reservations must be made against the block at the contracted group rate. Rooms not picked up by this date are released back to general inventory per the attrition policy.',
    `delphi_opportunity_reference` STRING COMMENT 'Source system identifier from Delphi by Amadeus event sales platform linking this group block to the originating sales opportunity or group proposal. Enables cross-system traceability.',
    `departure_date` DATE COMMENT 'The last date of the contracted room block period — the date the group is scheduled to check out. Serves as EFFECTIVE_UNTIL for this agreement.',
    `deposit_due_date` DATE COMMENT 'Contractual deadline by which the group deposit must be received to maintain the block in Definite status.',
    `deposit_received_amount` DECIMAL(18,2) COMMENT 'Actual deposit amount received from the group organizer to date. Compared against deposit_required_amount to determine outstanding deposit balance.',
    `deposit_required_amount` DECIMAL(18,2) COMMENT 'Contractual deposit amount required from the group to confirm the block. Expressed in the currency defined by currency_code.',
    `group_code` STRING COMMENT 'Externally-known alphanumeric code used to identify the group block across systems (OPERA PMS, CRS, OTA channels). Used by guests and agents to associate individual reservations to the block. Serves as the BUSINESS_IDENTIFIER for this agreement.. Valid values are `^[A-Z0-9]{3,20}$`',
    `group_name` STRING COMMENT 'Human-readable name of the group (e.g., Smith Wedding Party, Acme Corp Q3 Sales Conference, Chicago Bulls Away Team). Displayed on folios, rooming lists, and internal reports.',
    `group_notes` STRING COMMENT 'Free-text operational notes and special instructions for the group block (e.g., VIP handling requirements, early check-in requests, amenity preferences, security arrangements). Sourced from OPERA PMS group block notes field.',
    `group_rate_code` STRING COMMENT 'Rate plan code applied to individual reservations made under this group block. Links to the negotiated group rate in the revenue rate plan. Sourced from OPERA PMS and distributed via SynXis CRS. Natural key normalized; resolve via revenue.rate_plan reference. Denormalized natural key normalized via FK relationship.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `group_type` STRING COMMENT 'Categorical classification of the group travel party type. Drives billing rules, rate eligibility, and operational handling. [ENUM-REF-CANDIDATE: tour|corporate|wedding|sports_team|airline_crew|government|other — promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the group block record in the source system. Serves as RECORD_AUDIT_UPDATED for this entity. Used for incremental ETL processing.',
    `market_segment_code` STRING COMMENT 'Revenue management market segment classification assigned to this group block (e.g., GRP-CORP, GRP-LEISURE, GRP-CREW). Used for USALI-compliant revenue reporting and STR benchmarking segmentation.. Valid values are `^[A-Z0-9_]{2,15}$`',
    `opera_block_reference` STRING COMMENT 'Native block identifier from Oracle OPERA PMS Group Blocks module. Used for reconciliation and lineage tracing between the lakehouse silver layer and the operational source system.',
    `peak_block_rooms` STRING COMMENT 'Maximum number of rooms blocked on any single night within the group block period. Used for capacity planning, displacement analysis, and revenue management evaluation.',
    `repeat_group_flag` BOOLEAN COMMENT 'Indicates whether this group has stayed at the property in a prior year or period. Used for loyalty recognition, preferential rate negotiation, and retention analytics.',
    `rooming_list_due_date` DATE COMMENT 'Contractual deadline by which the group organizer must submit the complete rooming list with individual guest names and room type preferences.',
    `rooming_list_status` STRING COMMENT 'Current status of the rooming list submission for this group block. Tracks whether the group organizer has provided individual guest names and room assignments required for pre-arrival processing.. Valid values are `not_received|partial|complete|finalized`',
    `rooms_picked_up` STRING COMMENT 'Current count of individual reservations made against the group block (actual pickup). Compared against contracted_room_nights to calculate pickup rate and attrition exposure.',
    `source_of_business_code` STRING COMMENT 'Code identifying the channel or origin through which the group business was sourced (e.g., direct sales, GDS, OTA, travel agent, repeat group). Used for channel contribution analysis.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `suite_block_rooms` STRING COMMENT 'Number of suite-category rooms included in the contracted block. Tracked separately from standard rooms for inventory management and upsell reporting.',
    `vip_flag` BOOLEAN COMMENT 'Indicates whether this group block has been designated as VIP, triggering elevated service protocols, dedicated concierge assignment, and executive-level attention.',
    `wash_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of contracted rooms expected to be released back to general inventory based on historical pickup patterns for this group type. Used by revenue management for net block sizing and forecasting.',
    CONSTRAINT pk_guest_group_block PRIMARY KEY(`guest_group_block_id`)
) COMMENT 'Single source of truth is reservation.reservation_group_block. Group guest block master representing organized group travel parties (tour groups, corporate meetings, wedding parties, sports teams, airline crew). Captures group name, group type classification, group leader/contact profile reference, contracted room block size, pickup rate tracking, group code, cut-off date, billing master folio instructions, rooming list status, group coordinator assignment, and wash/attrition percentage thresholds. Distinct from MICE event management in the event domain — this focuses on room block allocation, guest-facing group identity, and rooming list management. Sourced from OPERA PMS Group Blocks and Delphi/Salesforce. SSOT: defers to reservation.reservation_group_block (MVM).reservation_group_block as single source of truth]event_group_block. [SSOT:group_block] Domain-specific specialization of the group_block concept; canonical SSOT owner is event.event_group_block. SSOT: defers to canonical reservation.reservation_group_block (MVM cross-domain dedup).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` (
    `vip_designation_id` BIGINT COMMENT 'Unique surrogate identifier for each VIP designation record in the silver layer lakehouse. Primary key for the vip_designation data product. Sourced from Oracle OPERA PMS VIP code assignments and Salesforce CRM VIP profile records.',
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account record when the VIP designation is granted based on a corporate relationship (e.g., key account executive, contracted corporate partner). Null for individual leisure VIP guests. Sourced from Salesforce CRM account object.',
    `member_id` BIGINT COMMENT 'Reference to the loyalty program membership record associated with this VIP guest. Links VIP designation entitlements with loyalty tier benefits to ensure non-duplication and correct benefit stacking. Sourced from Salesforce CRM loyalty management module.',
    `employee_id` BIGINT COMMENT 'Reference to the workforce employee record for the dedicated property host, butler, or guest relations manager assigned to personally manage this VIP guests experience. Drives pre-arrival communication and on-property service coordination.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile record for whom this VIP designation is assigned. Links to the master guest profile in the guest domain. A single guest may hold multiple concurrent VIP designations across brand and property levels.',
    `property_id` BIGINT COMMENT 'Reference to the property at which this VIP designation applies. A designation may be property-specific (e.g., Celebrity at a single resort) or brand-wide (null indicates brand-level designation). Sourced from Oracle OPERA PMS property configuration.',
    `tertiary_vip_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee record of the senior leader (e.g., General Manager, Regional VP) who provided final approval for this VIP designation. May differ from designated_by_employee_id when a two-step approval workflow is required for high-tier designations.',
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
    `corporate_account_id` BIGINT COMMENT 'Reference to the corporate account associated with this stay, applicable when guest_type is corporate. Links to negotiated rate agreements and corporate travel program tracking. Sourced from Oracle OPERA PMS accounts receivable module.',
    `guest_group_block_id` BIGINT COMMENT 'Reference to the group block associated with this stay, applicable when guest_type is group. Links to group contract, pickup tracking, and group revenue attribution. Sourced from Oracle OPERA PMS group module.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile record representing the primary registered guest for this stay. Supports Lifetime Value (LTV) calculation, segmentation, and personalization across all properties.',
    `property_id` BIGINT COMMENT 'Reference to the property where the stay occurred. Enables property-level performance analytics including ADR, RevPAR, and OCC reporting per USALI standards.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the originating reservation record from which this stay history was created upon checkout. Links stay history back to the reservation domain for full booking-to-stay traceability.',
    `adr` DECIMAL(18,2) COMMENT 'Average Daily Rate (ADR) for the stay, calculated as total room revenue divided by the number of occupied room nights. A primary KPI per USALI and STR STAR Report standards. Expressed in the propertys local currency. Used for RevPAR computation and competitive benchmarking via STR. [v2 note: this is ADR not RevPAR; canonical RevPAR is in the revenue domain.]',
    `ancillary_revenue` DECIMAL(18,2) COMMENT 'Total ancillary charges posted to the guest folio during the stay, including spa, parking, laundry, telephone, and other non-room, non-F&B charges. Sourced from Oracle OPERA PMS. Contributes to TRevPAR and GOPPAR calculations per USALI.',
    `arrival_date` DATE COMMENT 'Actual date the guest checked in to the property (yyyy-MM-dd). May differ from the originally reserved arrival date in cases of early arrival or late arrival. Used as the principal business event date for stay analytics and STR benchmarking.',
    `booking_channel_code` STRING COMMENT 'Code identifying the distribution channel through which the reservation was originally made (e.g., direct_web, ota, gds, voice, walk_in, corporate_direct). Sourced from Sabre SynXis CRS channel mapping. Used for channel contribution and OTA partnership analysis.',
    `booking_date` DATE COMMENT 'Date on which the reservation was originally created (yyyy-MM-dd). Used to calculate booking lead time (days between booking_date and arrival_date), a key input for demand forecasting and pickup report analysis.',
    `checkin_timestamp` TIMESTAMP COMMENT 'Exact date and time the guest completed the check-in process at the front desk or via mobile/digital check-in (yyyy-MM-ddTHH:mm:ss.SSSXXX). Sourced from Oracle OPERA PMS front desk module. Used for operational SLA tracking and guest experience analytics.',
    `checkout_timestamp` TIMESTAMP COMMENT 'Exact date and time the guest completed the checkout process (yyyy-MM-ddTHH:mm:ss.SSSXXX). Sourced from Oracle OPERA PMS cashiering module. Marks the point at which the stay record is finalized and posted to the stay history.',
    `complimentary_flag` BOOLEAN COMMENT 'Indicates whether the stay was provided on a complimentary (no-charge) basis (True = complimentary; False = revenue-generating stay). Sourced from Oracle OPERA PMS. Used for USALI complimentary room reporting and GOP calculation.',
    `confirmation_number` STRING COMMENT 'Externally-known alphanumeric confirmation number assigned by the Central Reservation System (CRS) or Property Management System (PMS) at time of booking. Used by guests and agents to reference the stay. Sourced from Sabre SynXis CRS or Oracle OPERA PMS.. Valid values are `^[A-Z0-9]{6,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stay history record was first created in the silver layer lakehouse, typically upon post-checkout processing from Oracle OPERA PMS (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trail, and ETL pipeline monitoring.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts on this stay record are denominated (e.g., USD, EUR, GBP). Required for multi-currency properties and international financial reporting under IFRS/GAAP.. Valid values are `^[A-Z]{3}$`',
    `departure_date` DATE COMMENT 'Actual date the guest checked out of the property (yyyy-MM-dd). May differ from the originally reserved departure date in cases of early departure or extended stay. Used in conjunction with arrival_date to compute Length of Stay (LOS).',
    `do_not_disturb_flag` BOOLEAN COMMENT 'Indicates whether the guest activated Do Not Disturb (DND) status during the stay (True = DND activated at any point; False = DND not activated). Sourced from Oracle OPERA PMS housekeeping module. Used for housekeeping scheduling and guest preference analytics.',
    `fb_revenue` DECIMAL(18,2) COMMENT 'Total Food and Beverage (F&B) charges posted to the guest folio during the stay, including restaurant, bar, room service, and minibar charges. Sourced from Oracle Hospitality MICROS POS. Contributes to TRevPAR calculation.',
    `gss_score` DECIMAL(18,2) COMMENT 'Overall Guest Satisfaction Score (GSS) for the stay as captured by Medallia post-stay survey, typically on a scale of 1-10 or 1-100 depending on survey instrument. Distinct from NPS; measures overall satisfaction rather than likelihood to recommend. Used for Satisfaction and Loyalty Tracking (SALT) reporting.',
    `guest_type` STRING COMMENT 'Classification of the guest stay by traveler category. fit (Free Independent Traveler) indicates leisure individual; corporate indicates business traveler under a negotiated account; group indicates part of a group block; crew indicates airline or transport crew; complimentary indicates no-charge stay. Drives segmentation and LTV modeling.. Valid values are `fit|corporate|group|crew|complimentary`',
    `length_of_stay` STRING COMMENT 'The length of stay for stay history in the guest domain.',
    `length_of_stay_nights` STRING COMMENT '',
    `los_nights` STRING COMMENT 'Actual number of nights the guest stayed at the property, computed as departure_date minus arrival_date. A core metric for Average Length of Stay (ALOS) analysis, revenue management, and demand forecasting in IDeaS G3 RMS.',
    `loyalty_member_number` STRING COMMENT 'Loyalty program membership number associated with the guest for this stay. Used to post loyalty points, track qualifying nights, and calculate tier status. Sourced from Salesforce CRM loyalty management module. Subject to GDPR and CCPA privacy regulations.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the guest for this stay, based on the applicable earning rate for the rate plan, room type, and member tier. Sourced from Salesforce CRM loyalty management. Used for loyalty program liability accrual and member engagement analytics.',
    `loyalty_tier_at_stay` STRING COMMENT 'The guests loyalty program tier level at the time of the stay (e.g., Silver, Gold, Platinum, Diamond). Captured as a snapshot to preserve historical tier context for LTV analysis and personalization, independent of the guests current tier. [ENUM-REF-CANDIDATE: promote to reference product as tiers vary by brand]',
    `market_segment_code` STRING COMMENT 'Market segment classification assigned to the stay per USALI and STR reporting standards (e.g., transient, group, contract, wholesale). Used for Revenue Management System (RMS) demand forecasting and STR STAR Report benchmarking.',
    `nps_score` STRING COMMENT 'Net Promoter Score (NPS) provided by the guest for this stay, on a scale of 0-10. Sourced from Medallia post-stay survey. Used for Guest Satisfaction Score (GSS) tracking, service recovery identification, and experience analytics. Null if guest did not respond to survey.',
    `num_adults` STRING COMMENT 'Count of adult guests (18 years and older) registered for the stay as recorded in Oracle OPERA PMS. Used for occupancy reporting, F&B revenue forecasting, and capacity planning.',
    `num_children` STRING COMMENT 'Count of child guests (under 18 years) registered for the stay as recorded in Oracle OPERA PMS. Used for family segment analytics, amenity planning, and F&B revenue forecasting.',
    `original_arrival_date` DATE COMMENT 'The arrival date as originally reserved at time of booking, before any modifications. Used to measure early arrival or late arrival deviations and to support wash factor analysis in IDeaS G3 RMS.',
    `original_departure_date` DATE COMMENT 'The departure date as originally reserved at time of booking, before any modifications. Used to identify early departure and extended stay patterns for demand forecasting and wash factor analysis in IDeaS G3 RMS.',
    `payment_method` STRING COMMENT 'Primary payment instrument used to settle the guest folio at checkout. Sourced from Oracle OPERA PMS cashiering module. Used for payment mix analysis and PCI DSS compliance reporting. [ENUM-REF-CANDIDATE: credit_card|debit_card|cash|direct_bill|loyalty_points|bank_transfer|voucher|cryptocurrency — promote to reference product]. Valid values are `credit_card|debit_card|cash|direct_bill|loyalty_points|bank_transfer`',
    `qualifying_nights` STRING COMMENT 'Number of nights from this stay that count toward the guests loyalty program tier qualification. May differ from los_nights if the rate plan is non-qualifying (e.g., wholesale, complimentary). Sourced from Salesforce CRM loyalty management.',
    `rate_plan_code` STRING COMMENT 'Code identifying the rate plan under which the stay was booked (e.g., BAR, LRA, NRR, corporate negotiated, package). Sourced from Oracle OPERA PMS and Sabre SynXis CRS. Critical for revenue management analysis and channel contribution reporting.',
    `room_number` STRING COMMENT 'Physical room number assigned to the guest for the duration of the stay as recorded in Oracle OPERA PMS. Supports housekeeping scheduling, maintenance tracking, and room-level revenue attribution.',
    `room_revenue` DECIMAL(18,2) COMMENT 'Total room charges posted to the guest folio for the entire stay, excluding taxes, fees, and ancillary charges. Sourced from Oracle OPERA PMS cashiering module. Core component of RevPAR and TRevPAR calculations per USALI.',
    `room_type_code` STRING COMMENT 'Standardized code identifying the room type category occupied during the stay (e.g., KING, DBLQ, SUITE, DLXK). Sourced from Oracle OPERA PMS room inventory. Used for room type mix analysis, upsell tracking, and RevPAR decomposition. [v2 note: this is ADR not RevPAR; canonical RevPAR is in the revenue domain.]',
    `rooms_sold` STRING COMMENT 'Number of rooms sold recorded in the guest stay history.',
    `service_recovery_flag` BOOLEAN COMMENT 'Indicates whether a service recovery action was initiated during or after this stay (True = service recovery case opened; False = no service recovery). Sourced from Medallia or Salesforce CRM case management. Used for Guest Recovery Rate (GRR) calculation and experience analytics.',
    `stay_status` STRING COMMENT 'Outcome status of the guest stay upon checkout processing. completed indicates normal checkout on scheduled departure date; early_departure indicates guest checked out before scheduled departure; extended indicates stay was prolonged beyond original departure date; no_show indicates reservation was not cancelled but guest never arrived; cancelled indicates reservation was cancelled post-check-in processing.. Valid values are `completed|early_departure|extended|no_show|cancelled`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charges applied to the guest folio for the stay, including occupancy tax, VAT, city tax, and other applicable levies. Sourced from Oracle OPERA PMS cashiering. Required for IFRS/GAAP financial reporting and SOX compliance.',
    `total_folio_amount` DECIMAL(18,2) COMMENT 'Total amount charged to the guest folio for the entire stay, inclusive of room revenue, F&B revenue, ancillary revenue, and taxes. Represents the gross billing amount settled at checkout. Sourced from Oracle OPERA PMS cashiering module.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this stay history record was last modified in the silver layer lakehouse (yyyy-MM-ddTHH:mm:ss.SSSXXX). Captures post-checkout adjustments such as folio corrections, survey score updates, or loyalty point recalculations. Used for data lineage and audit compliance.',
    `vip_code` STRING COMMENT 'VIP designation code assigned to the guest for this stay in Oracle OPERA PMS (e.g., VIP1, VIP2, VVIP, CELEB). Drives special handling, amenity delivery, and management attention protocols. Null if guest has no VIP designation.',
    CONSTRAINT pk_stay_history PRIMARY KEY(`stay_history_id`)
) COMMENT 'Consolidated historical record of all completed guest stays across all properties and brands. Captures arrival date, departure date, property, room type, room number, rate plan, ADR, total revenue (rooms + F&B + ancillary), LOS, number of guests, booking channel, and stay outcome (completed, early departure, extended). Sourced from OPERA PMS post-checkout records. Foundational for LTV calculation, segmentation, and personalization. Distinct from active reservations managed in the reservation domain. ADR (RevPAR lives in revenue domain) measure removed/renamed: prior definition divided room_revenue by occupied room nights which yields ADR not ADR (RevPAR lives in revenue domain); canonical ADR (RevPAR lives in revenue domain) is owned by the revenue domain. The ECM ADR (RevPAR lives in revenue domain) measure that divided room revenue by occupied room nights was actually ADR; it has been renamed/removed because true ADR (RevPAR lives in revenue domain) is owned by the revenue domain. RevPAR measure removed from guest metrics (was actually ADR = revenue / occupied room nights); canonical RevPAR lives in the revenue domain. Incorrect RevPAR measure removed; correct RevPAR lives in revenue domain.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`note` (
    `note_id` BIGINT COMMENT 'Unique surrogate identifier for each guest note or alert record in the system. Primary key for the guest_note data product.',
    `event_booking_id` BIGINT COMMENT 'Foreign key linking to event.event_booking. Business justification: Guest notes frequently reference event-related special requests, VIP event attendee handling instructions, or event-specific service recovery issues. Front desk, concierge, and event coordinators need',
    `service_case_id` BIGINT COMMENT 'Reference identifier to a formal service recovery case in Salesforce CRM or the experience domain, if this note escalated into a tracked case. Null if no formal case was raised. Provides cross-domain traceability between informal notes and formal service recovery.',
    `employee_id` BIGINT COMMENT 'Reference to the specific staff member assigned to action or follow up on this note. Null if assigned to a department rather than an individual.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile to which this note is attached. Links the note to the unified guest identity record.',
    `property_id` BIGINT COMMENT 'Reference to the property at which this note was created. Used to determine property-specific vs. chain-wide scope of the note.',
    `tertiary_note_resolved_by_staff_employee_id` BIGINT COMMENT 'Reference to the staff member who marked the note as resolved. Enables accountability and service recovery performance measurement.',
    `action_date` DATE COMMENT 'The specific hotel business date on which the note action or trace is scheduled to be executed (e.g., the date a pre-arrival amenity should be placed). Distinct from expiry_date which governs visibility.',
    `assigned_department` STRING COMMENT 'The department responsible for actioning this note. May differ from the authoring department (e.g., Front Desk authors a note assigned to Housekeeping). Drives departmental task routing in OPERA. [ENUM-REF-CANDIDATE: front_desk|housekeeping|food_and_beverage|concierge|security|guest_relations|reservations|engineering|spa — promote to reference product]',
    `authoring_department` STRING COMMENT 'The hotel department that created the note (e.g., Front Desk, Housekeeping, Food and Beverage, Concierge, Revenue Management, Security, Guest Relations). Used for departmental accountability and routing of action items. [ENUM-REF-CANDIDATE: front_desk|housekeeping|food_and_beverage|concierge|revenue_management|security|guest_relations|reservations|engineering — promote to reference product]',
    `note_category` STRING COMMENT 'Secondary classification providing finer-grained grouping within a note type (e.g., Room Preference, Dietary Restriction, Billing Alert, VIP Protocol, Housekeeping Instruction, Security Alert). Sourced from OPERA trace/alert category codes. [ENUM-REF-CANDIDATE: room_preference|dietary|billing|vip_protocol|housekeeping|security|loyalty|accessibility|transport — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Exact date and time when the note record was first created in the system. Provides precise audit trail for note origination.',
    `data_retention_category` STRING COMMENT 'Classification governing how long this note record must be retained per data governance policy. Standard follows default retention schedules; extended applies to VIP or legal-relevant notes; legal_hold prevents deletion during litigation; purge_eligible marks records ready for deletion.. Valid values are `standard|extended|legal_hold|purge_eligible`',
    `display_on_checkin` BOOLEAN COMMENT 'Indicates whether this note should be automatically surfaced to front desk staff during the guest check-in process. True = display at check-in; False = do not auto-display. Supports pre-arrival briefing and service personalization.',
    `display_on_checkout` BOOLEAN COMMENT 'Indicates whether this note should be surfaced to front desk staff during the guest check-out process. True = display at check-out; False = do not auto-display. Useful for billing alerts or follow-up actions at departure.',
    `display_on_reservation` BOOLEAN COMMENT 'Indicates whether this note should be surfaced to reservations agents when a new booking is made for this guest. True = display during reservation creation; False = do not auto-display. Supports proactive service planning.',
    `expiry_date` DATE COMMENT 'The date after which the note is no longer considered active or actionable. Null indicates the note has no expiry and remains permanently active. Used to auto-expire time-bound traces and alerts.',
    `extracted_topics` STRING COMMENT 'The extracted topics for the note record in the guest domain.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the guest has provided consent for this type of personal preference data to be stored and processed under GDPR Article 6. True = consent obtained; False = consent not obtained or withdrawn. Critical for EU/EEA guest data compliance.',
    `guest_segment` STRING COMMENT 'The guest segment classification at the time the note was created. Free Independent Traveler (FIT), corporate, group, VIP, loyalty elite, or airline crew. Supports segment-specific service delivery and analytics.. Valid values are `fit|corporate|group|vip|loyalty_elite|crew`',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the note content is restricted to management-level staff only and should not be visible to all front-line employees. True = management-only visibility; False = visible to all authorized staff.',
    `is_vip_alert` BOOLEAN COMMENT 'Indicates whether this note is specifically flagged as a VIP protocol alert requiring elevated service standards. True = VIP alert; False = standard note. Drives VIP pre-arrival briefing workflows.',
    `language_code` STRING COMMENT 'ISO 639-1 language code indicating the language in which the note text was authored (e.g., en, fr, de, zh-CN). Supports multilingual property operations and translation workflows.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the note was most recently updated by any staff member. Supports audit trail and change detection in the Silver layer ETL pipeline.',
    `loyalty_member_number` STRING COMMENT 'The guests loyalty program membership number at the time the note was created. Captured denormalized to support loyalty-aware pre-arrival briefing and cross-property service continuity without requiring a join to the loyalty profile.',
    `note_date` DATE COMMENT 'The business date on which the note was created, aligned to the hotel operational date (which may differ from the calendar date for overnight shifts). Used for daily operations reporting (DOR) and pre-arrival briefing.',
    `note_status` STRING COMMENT 'Current lifecycle state of the note. Active notes are visible and actionable; resolved notes have been actioned; expired notes have passed their expiry date; cancelled notes were voided by staff; pending notes are awaiting review or approval.. Valid values are `active|resolved|expired|cancelled|pending`',
    `note_type` STRING COMMENT 'Classification of the note indicating its business purpose. Preference captures guest likes/dislikes; complaint records a service failure; compliment records positive feedback; alert flags an operational action required; trace is a time-bound task or follow-up; general is unclassified. [ENUM-REF-CANDIDATE: preference|complaint|compliment|alert|trace|general — promote to reference product if additional types are needed]. Valid values are `preference|complaint|compliment|alert|trace|general`',
    `opera_trace_reference` STRING COMMENT 'Source system identifier for the trace or alert record as assigned by Oracle OPERA PMS. Used for reconciliation and lineage tracing back to the operational system of record.',
    `primary_topic` STRING COMMENT '',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether this note is marked as high priority, requiring immediate staff attention or pre-arrival action. True = high priority; False = standard priority.',
    `priority_level` STRING COMMENT 'Graduated priority ranking of the note for staff triage and pre-arrival briefing. Critical notes require immediate escalation; high notes require same-day action; medium notes are addressed during the stay; low notes are informational.. Valid values are `critical|high|medium|low`',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this note should automatically recur on every future stay for this guest (True) or is a one-time note (False). Supports persistent preference management for repeat guests.',
    `recurrence_pattern` STRING COMMENT 'Defines the frequency at which a recurring note is re-activated. Every_stay applies on each new reservation; annual applies once per calendar year; seasonal applies during defined seasonal periods; one_time applies only once. Null if recurrence_flag is False.. Valid values are `every_stay|annual|seasonal|one_time`',
    `resolution_notes` STRING COMMENT 'Freeform text describing the action taken to resolve or address the note. Captures what was done, by whom, and any follow-up required. Classified as confidential as it may contain sensitive guest interaction details.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the note was marked as resolved or actioned by staff. Null if the note has not yet been resolved. Supports service recovery tracking and staff performance analytics.',
    `scope` STRING COMMENT 'Defines whether the note is visible only at the originating property (property) or across all properties in the chain (chain). Chain-wide notes support cross-property service continuity for loyalty and VIP guests.. Valid values are `property|chain`',
    `sentiment_score` DECIMAL(18,2) COMMENT '',
    `source_channel` STRING COMMENT 'The channel or interface through which the note was originally captured (e.g., PMS front desk terminal, CRM, mobile app, web portal, voice call, email, in-person interaction). Supports omnichannel guest profile analytics. [ENUM-REF-CANDIDATE: pms|crm|mobile_app|web|voice|email|in_person — 7 candidates stripped; promote to reference product]',
    `stay_date_context` DATE COMMENT 'The specific stay date or arrival date to which this note is contextually relevant. Used for time-bound notes that apply only during a particular stay window rather than the guests entire profile history.',
    `text` STRING COMMENT 'Full freeform text body of the note or alert as entered by property staff. Contains the detailed narrative, instruction, or observation. Classified as confidential as it may contain sensitive guest behavioral or preference information.',
    `topic_confidence_score` DECIMAL(18,2) COMMENT '',
    `topic_extraction_model_version` STRING COMMENT '',
    `topic_extraction_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_note PRIMARY KEY(`note_id`)
) COMMENT 'Freeform and structured notes and alerts attached to guest profiles by property staff. Captures note type (preference, complaint, compliment, alert, trace), note text, authoring department, property scope (property-specific vs. chain-wide), expiry date, and priority flag. Sourced from OPERA PMS Guest Traces and Alerts. Enables cross-property service continuity and pre-arrival briefing. Distinct from formal service recovery cases managed in the experience domain.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` (
    `communication_consent_id` BIGINT COMMENT 'Unique identifier for the communication consent record. Primary key.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who provided or withdrew consent. Links to the guest master record in CRM.',
    `privacy_request_id` BIGINT COMMENT 'Reference to a data subject access request (DSAR) or right-to-erasure request that triggered this consent record update. Null if not related to a DSAR.',
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
    `employee_id` BIGINT COMMENT 'Reference to the staff member who performed the identity document verification. Links to workforce/staff master data. Null if verification was automated.',
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
    `guest_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.guest_segment. Business justification: Properties cross-reference booking market segments (transient, group, contract) with marketing behavioral segments (high-value leisure, business road warrior) for campaign eligibility rules, personali',
    `parent_segment_id` BIGINT COMMENT 'Reference to the parent segment in the hierarchy for roll-up aggregation. Null for top-level segments.',
    `primary_superseded_by_assignment_segment_id` BIGINT COMMENT 'Reference to the segment assignment record that supersedes this one. Used for tracking segment migration history and maintaining assignment lineage.',
    `profile_id` BIGINT COMMENT 'Reference to the individual guest profile for guest-to-segment assignment records. Null for segment master definition records.',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` (
    `profile_merge_history_id` BIGINT COMMENT 'Unique identifier for the profile merge event record. Primary key for the profile merge history audit trail.',
    `employee_id` BIGINT COMMENT 'The system user identifier or staff ID of the person who initiated or approved the merge operation. May be system account for automated merges.',
    `property_id` BIGINT COMMENT 'The property identifier where the merge operation was initiated or where the profiles were primarily associated. May be null for enterprise-level merges.',
    `profile_id` BIGINT COMMENT 'The non-surviving guest profile identifier that was merged into the target profile. This profile is deactivated after the merge.',
    `target_profile_id` BIGINT COMMENT 'The surviving guest profile identifier that received all data from the source profile. This becomes the golden record after merge.',
    `contact_info_migrated_count` STRING COMMENT 'The total number of contact information records (email, phone, address) that were transferred from the source profile to the target profile.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this merge history record was first created in the system. Typically matches merge_timestamp but may differ if recorded asynchronously.',
    `data_retention_category` STRING COMMENT 'The data retention classification assigned to this merge audit record, determining how long the record must be preserved per regulatory and business requirements.',
    `error_message` STRING COMMENT 'Technical error message or exception details captured if the merge operation failed or encountered issues during execution.',
    `gdpr_consent_retained` BOOLEAN COMMENT 'Indicates whether marketing and data processing consent flags were preserved during the merge operation in compliance with GDPR requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this merge history record was last updated, such as when validation status or rollback status changed.',
    `loyalty_points_transferred` DECIMAL(18,2) COMMENT 'The total number of loyalty program points or rewards that were consolidated from the source profile into the target profile during the merge.',
    `matching_confidence_score` DECIMAL(18,2) COMMENT 'A numerical score (0.00 to 100.00) representing the algorithmic confidence level that the source and target profiles represent the same guest. Higher scores indicate stronger match certainty.',
    `matching_criteria` STRING COMMENT 'The specific data elements used to identify the profiles as duplicates, such as name+DOB, email+phone, loyalty ID, or combination of multiple attributes.',
    `merge_batch_code` STRING COMMENT 'The batch identifier for bulk merge operations, grouping multiple profile merges that were executed together as part of a single data quality initiative.',
    `merge_comments` STRING COMMENT 'Free-text comments or notes entered by the operator documenting the reason for the merge, special circumstances, or additional context.',
    `merge_method` STRING COMMENT 'The technical method or process used to execute the profile merge. Distinguishes between automated matching algorithms, manual operator review, and batch processing.. Valid values are `automatic_fuzzy_match|manual_review|bulk_batch|api_triggered|crm_deduplication|pms_merge_utility`',
    `merge_reason` STRING COMMENT 'The business reason or trigger that initiated the profile merge operation. Indicates whether the merge was system-detected, guest-requested, or operationally driven.. Valid values are `duplicate_detected|guest_requested_consolidation|property_initiated_cleanup|system_automated_deduplication|loyalty_consolidation|data_quality_initiative`',
    `merge_status` STRING COMMENT 'The current status of the merge operation indicating whether it completed successfully, failed, is pending, or was subsequently rolled back.. Valid values are `completed|pending|failed|rolled_back|partially_completed`',
    `merge_timestamp` TIMESTAMP COMMENT 'The exact date and time when the profile merge operation was executed and committed to the system.',
    `notes_migrated_count` STRING COMMENT 'The total number of guest notes, traces, and alerts that were transferred from the source profile to the target profile during the merge operation.',
    `operator_department` STRING COMMENT 'The organizational department or functional area of the operator who performed the merge, such as Front Desk, CRM Team, IT Data Quality, or System Automation.',
    `operator_name` STRING COMMENT 'The full name of the staff member or system account that executed the merge operation for audit and accountability purposes.',
    `preferences_migrated_count` STRING COMMENT 'The total number of guest preference records (room type, floor, amenities, etc.) that were transferred from the source profile to the target profile.',
    `reservations_migrated_count` STRING COMMENT 'The total number of reservation records that were transferred from the source profile to the target profile during the merge operation.',
    `rollback_eligible_flag` BOOLEAN COMMENT 'Indicates whether this merge operation can be reversed or undone. True if rollback is technically possible, False if the merge is permanent or rollback window has expired.',
    `rollback_expiry_date` DATE COMMENT 'The date after which the merge operation can no longer be reversed. Defines the time window during which rollback is permitted per data governance policy.',
    `stays_migrated_count` STRING COMMENT 'The total number of historical stay records that were transferred from the source profile to the target profile during the merge operation.',
    `validation_notes` STRING COMMENT 'Free-text notes documenting the validation process, any issues identified, or confirmation of successful data integrity checks.',
    `validation_status` STRING COMMENT 'Indicates whether the merge operation has been validated for data integrity and business rule compliance after execution.. Valid values are `validated|pending_validation|validation_failed|validation_not_required`',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when the merge operation was validated for data integrity and completeness.',
    CONSTRAINT pk_profile_merge_history PRIMARY KEY(`profile_merge_history_id`)
) COMMENT 'Audit trail of guest profile merge and deduplication events recording when duplicate profiles are identified and consolidated into a single golden record. Captures source (non-surviving) profile ID, target (surviving) profile ID, merge timestamp, merge reason (duplicate detected, guest-requested consolidation, property-initiated cleanup), merge method (automatic fuzzy match, manual review, bulk batch), matching criteria used (name+DOB, email+phone, loyalty ID), matching confidence score, operator/system ID, affected child record counts (reservations, stays, preferences migrated), and rollback eligibility flag. Critical for MDM data quality governance, GDPR right-to-erasure audit compliance, CRM data integrity, and loyalty points consolidation verification. Sourced from OPERA PMS Profile Merge utility and Salesforce CRM deduplication workflows.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` (
    `lifetime_value_id` BIGINT COMMENT 'Unique identifier for the guest lifetime value record. Primary key.',
    `predictive_score_id` BIGINT COMMENT '',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile for whom this lifetime value is calculated. Links to the guest master record in OPERA PMS and Salesforce CRM.',
    `property_id` BIGINT COMMENT 'Reference to the property where the guest has stayed most frequently. Used for targeted marketing and personalized offers.',
    `average_daily_rate` DECIMAL(18,2) COMMENT 'The guests average daily rate across all stays, calculated as total room revenue divided by total room nights. Key pricing metric for guest segmentation.',
    `average_gss_score` DECIMAL(18,2) COMMENT 'The guests average Guest Satisfaction Score across all completed satisfaction surveys. Typically measured on a 1-10 scale. Key quality metric.',
    `average_length_of_stay` DECIMAL(18,2) COMMENT 'The guests average length of stay in nights, calculated as total room nights divided by total stays. Indicates booking behavior pattern.',
    `average_nps_score` DECIMAL(18,2) COMMENT 'The guests average Net Promoter Score across all completed NPS surveys. Ranges from -100.00 to 100.00. Measures guest satisfaction and advocacy.',
    `average_revenue_per_stay` DECIMAL(18,2) COMMENT 'The guests average total revenue per stay, calculated as total revenue divided by total stays. Measures spend intensity per visit.',
    `calculation_date` DATE COMMENT 'The date on which this lifetime value calculation was performed. Represents the as-of date for all cumulative metrics.',
    `calculation_method` STRING COMMENT 'The methodology used to calculate this LTV record: historical (cumulative actuals only), predictive (forecast-based), or hybrid (actuals plus forecast).. Valid values are `historical|predictive|hybrid`',
    `churn_risk_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) signaling whether the guest is at risk of churn based on declining engagement, negative feedback, or extended time since last stay.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Numeric score (0.0000 to 1.0000) quantifying the probability of guest churn within the next 12 months. Higher scores indicate higher churn risk.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LTV record was first created in the lakehouse. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all revenue amounts are denominated. Typically the reporting currency of the enterprise.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score (0.00 to 100.00) representing the completeness and accuracy of the underlying guest data used in this LTV calculation. Higher scores indicate higher confidence.',
    `days_since_last_stay` STRING COMMENT 'Number of days elapsed between the most recent stay date and the LTV calculation date. Recency metric used in churn risk assessment.',
    `first_stay_date` DATE COMMENT 'The date of the guests first recorded stay across all properties and brands. Marks the beginning of the guest relationship lifecycle.',
    `guest_tenure_days` STRING COMMENT 'Number of days between the first stay date and the LTV calculation date. Represents the total duration of the guest relationship.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this LTV record. Tracks data freshness and supports incremental refresh logic.',
    `loyalty_member_number` STRING COMMENT 'The guests loyalty program membership number. Links LTV to loyalty tier and rewards fulfillment. Personally identifiable.',
    `loyalty_tier_code` STRING COMMENT 'Current loyalty program tier of the guest (e.g., member, silver, gold, platinum, ambassador). Influenced by LTV tier and total stays.',
    `ltv_score` DECIMAL(18,2) COMMENT 'Numeric score representing the guests lifetime value, calculated using a proprietary algorithm combining historical revenue, recency, frequency, and predicted future value.',
    `ltv_tier` STRING COMMENT 'Classification tier assigned to the guest based on total revenue and engagement metrics. Drives VIP designation and loyalty program benefits.. Valid values are `platinum|gold|silver|bronze|standard|inactive`',
    `market_segment_code` STRING COMMENT 'Primary market segment classification for this guest based on booking patterns (FIT, corporate, group, leisure, business). Aligns with revenue management segmentation.',
    `most_recent_stay_date` DATE COMMENT 'The date of the guests most recent completed stay across all properties and brands. Used to calculate recency metrics.',
    `next_best_offer_code` STRING COMMENT 'The next best offer code for lifetime value.',
    `next_stay_propensity_score` DECIMAL(18,2) COMMENT 'Predictive score (0.0000 to 1.0000) indicating the likelihood that the guest will book another stay within the next 12 months. Generated by CRM predictive analytics.',
    `preferred_brand_code` STRING COMMENT 'Code representing the brand (luxury, premium, select-service) where the guest has generated the most revenue or stays. Drives brand affinity analysis.',
    `projected_12m_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue expected from this guest over the next 12 months, calculated using predictive models based on historical patterns and propensity scores.',
    `total_ancillary_revenue` DECIMAL(18,2) COMMENT 'Cumulative ancillary revenue from spa, golf, parking, resort fees, and other non-room, non-F&B services purchased by this guest.',
    `total_complaints` STRING COMMENT 'Cumulative count of formal complaints or service recovery cases logged for this guest across all properties. Impacts churn risk and service recovery prioritization.',
    `total_fb_revenue` DECIMAL(18,2) COMMENT 'Cumulative food and beverage revenue generated by this guest across all properties, including restaurants, bars, room service, and banquets.',
    `total_revenue` DECIMAL(18,2) COMMENT 'Cumulative total revenue generated by this guest across all revenue streams (rooms, F&B, ancillary). Sum of total_room_revenue, total_fb_revenue, and total_ancillary_revenue.',
    `total_room_nights` STRING COMMENT 'Cumulative count of room nights consumed by this guest across all properties and brands. Key volume metric for LTV calculation.',
    `total_room_revenue` DECIMAL(18,2) COMMENT 'Cumulative room revenue generated by this guest across all properties and brands, excluding taxes and fees. Primary revenue component of LTV.',
    `total_stays` STRING COMMENT 'Cumulative count of completed stays by this guest across all properties and brands since first stay date.',
    `vip_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) designating whether the guest has been granted VIP status based on LTV tier, loyalty tier, or special designation.',
    CONSTRAINT pk_lifetime_value PRIMARY KEY(`lifetime_value_id`)
) COMMENT 'Calculated and tracked guest lifetime value (LTV) records representing the cumulative and projected revenue contribution of each guest across all properties and brands. Captures total historical revenue (rooms, F&B, spa, ancillary), total stay nights, ALOS, average ADR, total visits, first stay date, most recent stay date, LTV tier classification, and next-stay propensity score. Sourced from OPERA PMS stay history aggregation and Salesforce CRM. Drives loyalty tier decisions and VIP designation.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` (
    `relationship_id` BIGINT COMMENT 'Unique identifier for the guest-to-guest relationship record. Primary key.',
    `corporate_account_id` BIGINT COMMENT 'Identifier of the corporate account associated with this relationship. Used for corporate travel program management and booker-to-traveler attribution.',
    `household_id` BIGINT COMMENT 'Identifier for the household or family unit to which both guests belong. Used for household-level Lifetime Value (LTV) aggregation and family recognition programs.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member who created this relationship record. Null if created through an automated process or API import.',
    `profile_id` BIGINT COMMENT 'Identifier of the primary guest in the relationship. The guest from whom the relationship originates.',
    `tertiary_relationship_last_modified_by_staff_employee_id` BIGINT COMMENT 'Identifier of the staff member who last modified this relationship record. Null if modified through an automated process.',
    `billing_authority_flag` BOOLEAN COMMENT 'Indicates whether the related guest has authority to handle billing and payment matters for the primary guest.',
    `booking_authority_flag` BOOLEAN COMMENT 'Indicates whether the related guest has authority to make bookings on behalf of the primary guest. Used for assistant-mediated booking and corporate travel coordinator scenarios.',
    `consent_date` DATE COMMENT 'Date when consent was obtained from both guests for this relationship record. Required for data privacy compliance.',
    `consent_flag` BOOLEAN COMMENT 'Indicates whether both guests have provided consent for this relationship to be recorded and used for service personalization. Required for General Data Protection Regulation (GDPR) and California Consumer Privacy Act (CCPA) compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this relationship record was first created in the system. Used for audit trail and data lineage.',
    `data_retention_expiry_date` DATE COMMENT 'Date when this relationship record is scheduled for deletion or archival per data retention policies. Required for GDPR right to erasure compliance.',
    `direction` STRING COMMENT 'Indicates whether the relationship is bidirectional (mutual, both guests recognize the relationship) or unidirectional (one-way, only the primary guest recognizes the relationship).. Valid values are `bidirectional|unidirectional`',
    `emergency_contact_flag` BOOLEAN COMMENT 'Indicates whether the related guest is designated as an emergency contact for the primary guest.',
    `end_date` DATE COMMENT 'Date when the relationship ended or is scheduled to end. Null for ongoing relationships.',
    `gdpr_lawful_basis` STRING COMMENT 'The lawful basis under GDPR Article 6 for processing this relationship data. Typically consent or legitimate interest for guest relationship management.. Valid values are `consent|contract|legitimate_interest|vital_interest|legal_obligation|public_task`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this relationship record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the relationship. Used for service personalization and special handling instructions.',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether the related guest is the primary contact for the primary guest. Used for assistant-mediated booking attribution and corporate travel coordinator visibility.',
    `priority` STRING COMMENT 'Numeric priority ranking of this relationship relative to other relationships for the same primary guest. Lower numbers indicate higher priority. Used when multiple relationships exist and one must be selected (e.g., primary emergency contact).',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the relationship. Active relationships are used for service personalization and household-level aggregation.. Valid values are `active|inactive|pending|terminated`',
    `relationship_type` STRING COMMENT 'Type of relationship between the two guests. Defines the nature of the association (e.g., spouse/partner, parent/child, executive assistant, corporate booker-to-traveler, travel companion).. Valid values are `spouse|partner|parent|child|sibling|assistant`',
    `shared_preference_inheritance_flag` BOOLEAN COMMENT 'Indicates whether preferences should be inherited or shared between the two guests. Enables family recognition programs (e.g., greeting children by name based on parent preferences).',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this relationship record in the source system. Used for data lineage and reconciliation.',
    `start_date` DATE COMMENT 'Date when the relationship became effective. Used for historical tracking and lifecycle management.',
    `verified_date` DATE COMMENT 'Date when the relationship was verified. Null if not yet verified.',
    `verified_flag` BOOLEAN COMMENT 'Indicates whether the relationship has been verified by staff or through a validation process. Unverified relationships may be self-reported or imported without confirmation.',
    CONSTRAINT pk_relationship PRIMARY KEY(`relationship_id`)
) COMMENT 'Guest-to-guest relationship records capturing known associations between guest profiles for household-level service personalization and corporate travel program management. Captures relationship type (spouse/partner, parent/child, executive assistant, corporate booker-to-traveler, travel companion), relationship direction (bidirectional or unidirectional), start date, end date, primary contact designation, and shared preference inheritance flag. Enables family recognition programs (e.g., greeting children by name), household-level LTV aggregation, assistant-mediated booking attribution, and corporate travel coordinator visibility. Sourced from Salesforce CRM relationship objects and front desk manual entry.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` (
    `privacy_request_id` BIGINT COMMENT 'Unique identifier for the guest data privacy request record.',
    `employee_id` BIGINT COMMENT 'Reference to the data privacy officer or staff member assigned to process this request.',
    `profile_id` BIGINT COMMENT 'Reference to the guest profile who submitted the privacy request.',
    `assigned_handler_email` STRING COMMENT 'Email address of the assigned handler for guest communication regarding the privacy request.',
    `assigned_handler_name` STRING COMMENT 'Full name of the data privacy officer or staff member assigned to process this request.',
    `completion_date` DATE COMMENT 'Date when the privacy request was fully fulfilled and closed.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the privacy request fulfillment was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the privacy request record was first created in the data platform.',
    `crm_case_reference` STRING COMMENT 'Reference to the associated case record in Salesforce CRM for tracking guest communications and service recovery.',
    `data_format` STRING COMMENT 'File format used for data portability or access requests when delivering guest data.. Valid values are `JSON|CSV|PDF|XML`',
    `data_scope` STRING COMMENT 'Description of the scope of personal data covered by the request (e.g., all data, specific properties, specific date range).',
    `delivery_method` STRING COMMENT 'Method used to deliver the privacy request response or data export to the guest.. Valid values are `secure_download|email|postal_mail|in_person|api`',
    `extended_due_date` DATE COMMENT 'New response deadline if an extension was granted (up to additional 60 days under GDPR, 45 days under CCPA).',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicates whether a time extension was granted for complex or voluminous requests.',
    `extension_reason` STRING COMMENT 'Business justification for granting a time extension to fulfill the privacy request.',
    `guest_comments` STRING COMMENT 'Additional comments or context provided by the guest when submitting the privacy request.',
    `guest_communication_sent_count` STRING COMMENT 'Number of communications sent to the guest regarding this privacy request (acknowledgments, status updates, completion notices).',
    `guest_country_code` STRING COMMENT 'Three-letter ISO country code of the guests primary residence at time of request submission.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the privacy request record was last updated.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether guest data is subject to legal hold or litigation, preventing fulfillment of erasure requests.',
    `legal_hold_reason` STRING COMMENT 'Explanation of the legal basis for maintaining data despite an erasure request (e.g., pending litigation, regulatory investigation).',
    `outcome` STRING COMMENT 'Final outcome of the privacy request after processing.. Valid values are `fulfilled|partially_fulfilled|rejected|withdrawn_by_guest|expired`',
    `property_scope` STRING COMMENT 'Indicates whether the privacy request applies to guest data across all properties or specific properties only.. Valid values are `all_properties|specific_properties|single_property`',
    `records_accessed_count` STRING COMMENT 'Number of data records accessed or retrieved to fulfill a right-to-access or right-to-portability request.',
    `records_deleted_count` STRING COMMENT 'Number of data records permanently deleted to fulfill a right-to-erasure request.',
    `records_rectified_count` STRING COMMENT 'Number of data records corrected or updated to fulfill a right-to-rectification request.',
    `regulatory_jurisdiction` STRING COMMENT 'Primary data protection regulation governing this privacy request based on guest location and applicable law.. Valid values are `GDPR|CCPA|LGPD|PIPEDA|APPI|PDPA`',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the privacy request was rejected, including legal basis for refusal.',
    `request_notes` STRING COMMENT 'Internal notes and comments regarding the processing of the privacy request, including special handling instructions or escalations.',
    `request_reference_number` STRING COMMENT 'Externally-visible unique reference number provided to the guest for tracking their privacy request.',
    `request_status` STRING COMMENT 'Current lifecycle status of the privacy request in the fulfillment workflow. [ENUM-REF-CANDIDATE: submitted|under_review|identity_verification_pending|in_progress|completed|rejected|withdrawn|expired — 8 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Type of data subject privacy request submitted by the guest under applicable data protection regulations. [ENUM-REF-CANDIDATE: right_to_access|right_to_erasure|right_to_rectification|right_to_portability|right_to_restriction|right_to_object|withdraw_consent — 7 candidates stripped; promote to reference product]',
    `response_due_date` DATE COMMENT 'Regulatory deadline by which the organization must respond to the privacy request (typically 30 days from submission under GDPR, 45 days under CCPA).',
    `submission_channel` STRING COMMENT 'Channel through which the guest submitted the privacy request. [ENUM-REF-CANDIDATE: web_portal|mobile_app|email|phone|in_person|postal_mail|crm_case — 7 candidates stripped; promote to reference product]',
    `submission_date` DATE COMMENT 'Date when the guest submitted the privacy request.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the privacy request was received by the system.',
    `systems_impacted` STRING COMMENT 'Comma-separated list of operational systems where guest data was accessed, modified, or deleted to fulfill the request (e.g., OPERA PMS, Salesforce CRM, Medallia).',
    `third_party_notification_required` BOOLEAN COMMENT 'Indicates whether third-party data processors or recipients must be notified of the privacy request action (e.g., erasure, rectification).',
    `third_party_notification_status` STRING COMMENT 'Status of notifications sent to third-party data processors or recipients regarding the privacy request.. Valid values are `not_required|pending|completed|failed`',
    `verification_method` STRING COMMENT 'Method used to verify the identity of the guest submitting the privacy request.. Valid values are `email_confirmation|loyalty_account|two_factor_authentication|government_id|knowledge_based|manual_review`',
    `verification_status` STRING COMMENT 'Status of guest identity verification process required before fulfilling the privacy request.. Valid values are `not_started|pending|verified|failed|manual_review_required`',
    `verified_timestamp` TIMESTAMP COMMENT 'Timestamp when guest identity was successfully verified for the privacy request.',
    CONSTRAINT pk_privacy_request PRIMARY KEY(`privacy_request_id`)
) COMMENT 'Formal guest data privacy request records tracking GDPR, CCPA, and other regulatory data subject requests including right-to-access, right-to-erasure (right-to-be-forgotten), data portability, and processing restriction requests. Captures request type, submission date, submission channel, verification status, assigned handler, regulatory jurisdiction, response due date, completion date, and outcome. Mandatory for GDPR Article 17 and CCPA Section 1798.105 compliance.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` (
    `corporate_property_contract_id` BIGINT COMMENT 'Primary key for the corporate_property_contract association',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to the corporate account that negotiated this property-specific contract',
    `property_id` BIGINT COMMENT 'Foreign key linking to the specific property covered by this contract',
    `annual_revenue_target` DECIMAL(18,2) COMMENT 'Property-specific total revenue target (rooms, F&B, events) expected from this corporate account at this property. Varies by property size and account usage patterns.',
    `annual_room_night_target` STRING COMMENT 'Property-specific annual room night volume commitment. Targets allocated across properties based on corporate client travel patterns and property capacity.',
    `blackout_dates_policy` STRING COMMENT 'Property-specific blackout dates or periods when negotiated rates are not available (e.g., peak season, special events). Blackout policies vary by property based on local demand patterns.',
    `contract_end_date` DATE COMMENT 'Date on which this property-specific contract expires. Renewal cycles vary by property based on local market conditions and negotiation timing.',
    `contract_start_date` DATE COMMENT 'Date on which this property-specific contract becomes effective. Each property contract has independent validity periods.',
    `contract_status` STRING COMMENT 'Current lifecycle status of this property-specific contract. Contracts managed independently per property with distinct activation and termination cycles.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance permitted for this corporate account at this specific property. Credit limits allocated across properties based on usage forecasts and risk assessment.',
    `direct_billing_enabled` BOOLEAN COMMENT 'Indicates whether direct billing is approved for this corporate account at this specific property. Billing privileges granted property-by-property based on credit approval and operational capability.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount off BAR or rack rate granted at this specific property. Discount levels vary by property based on volume commitments and competitive dynamics.',
    `last_pickup_review_date` DATE COMMENT 'Date of the most recent pickup review meeting for this property-specific contract. Revenue management teams review actual vs. target room nights quarterly or monthly per property.',
    `los_minimum_nights` STRING COMMENT 'Minimum length of stay restriction for negotiated rate usage at this property. LOS requirements vary by property based on demand calendar and rate protection strategies.',
    `negotiated_rate_code` STRING COMMENT 'Property-specific rate code assigned in the Central Reservation System for this corporate account at this property. Rate codes vary by property based on local competitive positioning.',
    `payment_terms` STRING COMMENT 'Property-specific payment terms for direct billing invoices. Terms may vary by property based on local AR policies and account credit standing.',
    `property_account_manager_email` STRING COMMENT 'Email of the property-level account manager. Property-level contacts manage day-to-day contract execution and pickup tracking.',
    `property_account_manager_name` STRING COMMENT 'Name of the property-level sales manager or DOS responsible for managing this corporate account relationship at this specific property.',
    `rate_program_type` STRING COMMENT 'Type of rate program governing this property-specific contract (LRA, FIXED, DISCOUNT_PERCENT, TIERED). Program type negotiated independently per property based on demand patterns.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last modified.',
    CONSTRAINT pk_corporate_property_contract PRIMARY KEY(`corporate_property_contract_id`)
) COMMENT 'This association product represents the Contract between corporate_account and property. It captures property-specific negotiated rate agreements, billing arrangements, and room night commitments that exist only in the context of a specific corporate account contracting with a specific hotel property. Each record links one corporate account to one property with contract terms, performance targets, and payment arrangements that are negotiated and managed independently per property.. Existence Justification: Corporate accounts negotiate independent contracts with each property in the hotel portfolio. A national corporate account (e.g., Accenture, Deloitte) contracts with 50+ properties across the portfolio, and each property has contracts with dozens of local, regional, and national corporate accounts. Each contract is negotiated separately with property-specific rate codes, discount levels, room night targets, payment terms, and blackout dates. Sales teams manage these contracts property-by-property, and revenue management systems track pickup against contracted room nights per property.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` (
    `group_function_space_booking_id` BIGINT COMMENT 'Unique surrogate identifier for this group function space booking record. Primary key.',
    `guest_group_block_id` BIGINT COMMENT 'Foreign key linking to the guest group block that is booking this function space',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to the meeting space being reserved for this group function',
    `actual_attendance` STRING COMMENT 'Actual number of attendees who participated in this function. Captured post-event for reconciliation against guaranteed attendance.',
    `av_requirements` STRING COMMENT 'Audio-visual equipment and technical requirements specific to this group function (projector, microphones, video conferencing, lighting). Drives AV labor and rental charges.',
    `booking_date` DATE COMMENT 'Date when this function space was reserved for the group block. Tracks when the booking commitment was made.',
    `booking_status` STRING COMMENT 'Current lifecycle status of this function space booking (tentative, definite, cancelled, completed). Tracks progression from hold to confirmed to executed.',
    `catering_minimum_met` BOOLEAN COMMENT 'Indicates whether the contractual minimum catering spend for this meeting space was met by the group function. Null if no minimum applies.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for rental_amount and other monetary values on this booking record.',
    `event_end_datetime` TIMESTAMP COMMENT 'Scheduled end date and time for the group function or event in this meeting space. Used for space turnover planning and billing.',
    `event_start_datetime` TIMESTAMP COMMENT 'Scheduled start date and time for the group function or event in this meeting space. Critical for space scheduling and setup coordination.',
    `guaranteed_attendance` STRING COMMENT 'Number of attendees the group has guaranteed for this function. Used for catering billing and minimum charges even if actual attendance is lower.',
    `rental_amount` DECIMAL(18,2) COMMENT 'Meeting space rental charge for this specific function booking. May vary based on duration, setup complexity, and negotiated group rates.',
    `setup_type` STRING COMMENT 'Room setup configuration requested for this specific group function (theater, classroom, banquet, reception, u-shape, hollow square, boardroom, custom). Determines labor requirements and capacity.',
    `special_setup_notes` STRING COMMENT 'Free-text notes capturing special setup instructions, décor requirements, accessibility needs, or other function-specific details for operations and banquet teams.',
    CONSTRAINT pk_group_function_space_booking PRIMARY KEY(`group_function_space_booking_id`)
) COMMENT 'This association product represents the event booking relationship between guest group blocks and meeting spaces. It captures the operational assignment of specific function spaces to group events, including setup requirements, attendance guarantees, rental charges, and catering commitments. Each record links one guest group block to one meeting space for a specific event or function within the groups stay, enabling detailed function space inventory management and BEO (Banquet Event Order) execution.. Existence Justification: In travel hospitality operations, group blocks routinely reserve multiple meeting spaces for their events (e.g., a corporate conference books a ballroom for general sessions plus three breakout rooms and a boardroom for executive meetings). Simultaneously, high-demand meeting spaces like ballrooms host dozens of different group blocks throughout the year. Event coordinators actively manage these bookings in Delphi/OPERA with detailed function-specific data including setup type, timing, attendance guarantees, AV needs, and rental charges that belong to neither the group block nor the meeting space alone.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` (
    `guest_enrollment_id` BIGINT COMMENT 'Primary key for guest_enrollment',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the guest profile who enrolled in the promotion',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to the loyalty promotion in which the member is enrolled',
    `award_date` DATE COMMENT 'The date on which the bonus was posted to the members loyalty account. Null if bonus_awarded_flag is false. Used to track fulfillment SLA compliance.',
    `bonus_awarded_flag` BOOLEAN COMMENT 'Indicates whether the promotion bonus (points, nights, or other reward) has been posted to the members loyalty account. True once fulfillment is complete.',
    `channel` STRING COMMENT 'The channel through which the member enrolled in the promotion. Values: Email, Mobile App, Website, Property Front Desk, Call Center, Auto-Enrolled. Used for channel effectiveness analysis.',
    `completion_date` DATE COMMENT 'The date on which the member successfully met all qualifying criteria for this promotion. Null if not yet completed or if promotion expired before completion.',
    `enrollment_reference` BIGINT COMMENT 'Unique surrogate identifier for this promotion enrollment record. Primary key.',
    `guest_enrollment_date` DATE COMMENT 'The date on which the member enrolled or was auto-enrolled in this promotion. Used to determine eligibility window and track campaign velocity.',
    `guest_enrollment_status` STRING COMMENT 'Current lifecycle state of this members participation in the promotion. Values: enrolled (registered but no qualifying activity yet), in-progress (actively working toward criteria), completed (met all criteria, awaiting award), expired (promotion ended before completion), awarded (bonus posted to account), opted-out (member withdrew from promotion).',
    `opt_out_date` DATE COMMENT 'The date on which the member explicitly opted out or withdrew from this promotion. Null if member has not opted out. Used for preference management and campaign suppression.',
    `progress_value` DECIMAL(18,2) COMMENT 'Current progress toward the promotions qualifying criteria. Interpretation depends on promotion type: for minimum_nights promotions, this is nights earned; for minimum_spend promotions, this is spend accumulated. Null if promotion does not track incremental progress.',
    CONSTRAINT pk_guest_enrollment PRIMARY KEY(`guest_enrollment_id`)
) COMMENT 'This association product represents the enrollment event between a guest profile and a loyalty promotion. It captures the members participation lifecycle in a specific promotional offer, including enrollment channel, progress toward qualifying criteria, completion status, and bonus award fulfillment. Each record links one guest profile to one promotion with attributes that exist only in the context of this participation relationship.. Existence Justification: In travel hospitality loyalty programs, promotion enrollments represent a true many-to-many operational relationship. A single guest profile enrolls in multiple active promotions simultaneously (e.g., Double Points Summer, Stay 3 Get Bonus, Birthday Bonus), and each promotion has thousands of enrolled members. The business actively manages these enrollments as distinct entities, tracking enrollment-specific data such as progress toward qualifying criteria, completion status, and bonus award fulfillment that belongs neither to the profile nor the promotion alone.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` (
    `segment_membership_id` BIGINT COMMENT 'Unique surrogate identifier for this guest-to-segment membership record. Primary key.',
    `guest_segment_id` BIGINT COMMENT 'Foreign key linking to the marketing segment definition',
    `profile_id` BIGINT COMMENT 'Foreign key linking to the guest master profile record',
    `assignment_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.0 to 1.0) indicating the strength of the segment assignment, particularly relevant for ML-model-based assignments. Captured from the detection phase as relationship data.',
    `assignment_date` DATE COMMENT 'The date on which this guest was assigned to this segment. Captured from the detection phase as relationship data.',
    `assignment_effective_date` DATE COMMENT 'The date from which this segment membership became active and eligible for campaign targeting. Supports point-in-time segment membership queries. Captured from the detection phase as relationship data.',
    `assignment_expiry_date` DATE COMMENT 'The date on which this segment membership expired or was removed. Null for currently active memberships. Supports historical segment membership tracking. Captured from the detection phase as relationship data.',
    `assignment_method` STRING COMMENT 'Method by which this guest was assigned to this segment: rule-based (business rules engine), manual (marketing team override), or ml-model (machine learning prediction). Captured from the detection phase as relationship data.',
    `assignment_reason_code` STRING COMMENT 'Coded reason or business rule identifier explaining why this guest was assigned to this segment. Supports audit trail and segment definition refinement. Captured from the detection phase as relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment membership record was created in the system.',
    `last_refresh_date` DATE COMMENT 'Date when this specific membership record was last evaluated and confirmed during segment refresh cycles. Enables tracking of stale memberships.',
    `membership_status` STRING COMMENT 'Current lifecycle status of this segment membership: active (in use for campaigns), inactive (temporarily disabled), expired (past expiry date), suspended (manually paused by marketing team).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment membership record was last updated.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this segment membership record. Supports audit trail for manual assignments.',
    CONSTRAINT pk_segment_membership PRIMARY KEY(`segment_membership_id`)
) COMMENT 'This association product represents the assignment of guest profiles to marketing segments for campaign targeting and personalization. It captures the many-to-many relationship between guest profiles and marketing segments, where a single guest can belong to multiple segments simultaneously (e.g., High-Value Leisure + Spa Enthusiast + West Coast Traveler), and each segment contains thousands of guest profiles. Each record links one profile to one segment with assignment metadata including confidence scores, effective dates, assignment methods (rule-based vs ML-predicted), and reason codes that exist only in the context of this membership relationship.. Existence Justification: In the travel hospitality business, guest profiles are simultaneously assigned to multiple marketing segments for campaign targeting and personalization (e.g., a single guest can be tagged as High-Value Leisure + Spa Enthusiast + West Coast Traveler), and each segment contains thousands of guest profiles. Marketing teams actively manage these multi-segment memberships with assignment confidence scores, effective dates, assignment methods (rule-based vs ML-predicted), and reason codes. This is an operational many-to-many relationship that the business actively creates, updates, and queries for campaign audience list generation.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`household` (
    `household_id` BIGINT COMMENT 'Primary key for household',
    `property_id` BIGINT COMMENT 'Reference to the property most frequently visited or designated as preferred by the household.',
    `primary_merged_household_id` BIGINT COMMENT 'Self-referencing FK on household (merged_household_id)',
    `profile_id` BIGINT COMMENT 'Reference to the primary guest who represents or manages the household account.',
    `address_line_1` STRING COMMENT 'First line of the households primary mailing or residential address.',
    `address_line_2` STRING COMMENT 'Second line of the households address (apartment, suite, unit number, etc.).',
    `adult_count` STRING COMMENT 'Number of adult members (typically 18+ years) in the household.',
    `average_daily_rate` DECIMAL(18,2) COMMENT 'Average daily rate paid by the household across all historical stays, used for segmentation and pricing strategies.',
    `child_count` STRING COMMENT 'Number of child members (typically under 18 years) in the household.',
    `city` STRING COMMENT 'City or municipality of the households primary address.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the households primary address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was first created in the system.',
    `crm_account_code` STRING COMMENT 'External identifier linking this household to the corresponding account in the CRM system (e.g., Salesforce).',
    `external_reference_code` STRING COMMENT 'External or third-party identifier for the household used for integration with partner systems or external platforms.',
    `household_status` STRING COMMENT 'Current lifecycle status of the household record (active, inactive, merged into another household, or archived).',
    `household_type` STRING COMMENT 'Classification of the household structure (e.g., family, couple, single traveler, group, corporate).',
    `last_stay_date` DATE COMMENT 'Date of the most recent stay by any member of the household at any property.',
    `lifetime_nights` STRING COMMENT 'Total cumulative number of nights stayed across all household members and all properties.',
    `lifetime_revenue` DECIMAL(18,2) COMMENT 'Total cumulative revenue generated by the household across all bookings, stays, and ancillary services.',
    `loyalty_tier` STRING COMMENT 'Current loyalty program tier or status level for the household based on cumulative stay activity and spend.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicator whether the household has consented to receive marketing communications and promotional offers.',
    `member_count` STRING COMMENT 'Total number of individual guests associated with this household.',
    `merge_date` DATE COMMENT 'Date when this household record was merged into another household.',
    `household_name` STRING COMMENT 'The name or label assigned to the household for identification purposes.',
    `next_stay_date` DATE COMMENT 'Date of the next confirmed or upcoming stay by any member of the household at any property.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the households primary address.',
    `preferred_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the households preferred billing and transaction currency.',
    `preferred_language` STRING COMMENT 'Two-letter ISO 639-1 language code representing the households preferred communication language.',
    `preferred_room_type` STRING COMMENT 'Room type preference for the household (e.g., king bed, double queen, suite, accessible room).',
    `primary_email` STRING COMMENT 'Primary email address for household communications and correspondence.',
    `primary_phone` STRING COMMENT 'Primary contact phone number for the household.',
    `special_requests` STRING COMMENT 'Free-text field capturing recurring special requests or preferences for the household (e.g., high floor, near elevator, hypoallergenic bedding).',
    `state_province` STRING COMMENT 'State, province, or region of the households primary address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was last modified or updated.',
    `vip_flag` BOOLEAN COMMENT 'Indicator whether the household is designated as VIP, requiring special handling and elevated service standards.',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Master reference table for household. Referenced by household_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` (
    `predictive_score_id` BIGINT COMMENT '',
    `campaign_offer_id` BIGINT COMMENT '',
    `property_id` BIGINT COMMENT 'add column property_id (BIGINT) with FK to property.property.property_id - predictive scores (churn, upsell, NBO) are scoped to property context for property-level activation.',
    `churn_risk_score` STRING COMMENT 'The churn risk score for predictive score in the guest domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `expires_at_timestamp` TIMESTAMP COMMENT 'The expires at timestamp for predictive score.',
    `feature_vector_ref` STRING COMMENT '',
    `model_run_code` BIGINT COMMENT '',
    `model_version` STRING COMMENT '',
    `next_best_offer_code` STRING COMMENT '',
    `next_best_offer_score` DECIMAL(18,2) COMMENT 'Confidence score for the next-best-offer recommendation',
    `prediction_date` DATE COMMENT '',
    `profile_id` BIGINT COMMENT '',
    `score_confidence` STRING COMMENT '',
    `score_type` STRING COMMENT '',
    `score_value` DECIMAL(18,2) COMMENT '',
    `scored_at_timestamp` TIMESTAMP COMMENT '',
    `scored_timestamp` TIMESTAMP COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `upsell_propensity_score` STRING COMMENT '',
    CONSTRAINT pk_predictive_score PRIMARY KEY(`predictive_score_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_merged_into_profile_id` FOREIGN KEY (`merged_into_profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_predictive_score_id` FOREIGN KEY (`predictive_score_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`predictive_score`(`predictive_score_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` ADD CONSTRAINT `fk_guest_contact_info_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_stay_history_id` FOREIGN KEY (`stay_history_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`stay_history`(`stay_history_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ADD CONSTRAINT `fk_guest_guest_group_block_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ADD CONSTRAINT `fk_guest_vip_designation_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ADD CONSTRAINT `fk_guest_stay_history_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ADD CONSTRAINT `fk_guest_note_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ADD CONSTRAINT `fk_guest_communication_consent_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ADD CONSTRAINT `fk_guest_communication_consent_privacy_request_id` FOREIGN KEY (`privacy_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`privacy_request`(`privacy_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ADD CONSTRAINT `fk_guest_identity_document_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_parent_segment_id` FOREIGN KEY (`parent_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_primary_superseded_by_assignment_segment_id` FOREIGN KEY (`primary_superseded_by_assignment_segment_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`segment`(`segment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ADD CONSTRAINT `fk_guest_profile_merge_history_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ADD CONSTRAINT `fk_guest_profile_merge_history_target_profile_id` FOREIGN KEY (`target_profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ADD CONSTRAINT `fk_guest_lifetime_value_predictive_score_id` FOREIGN KEY (`predictive_score_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`predictive_score`(`predictive_score_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ADD CONSTRAINT `fk_guest_lifetime_value_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ADD CONSTRAINT `fk_guest_relationship_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ADD CONSTRAINT `fk_guest_relationship_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`household`(`household_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ADD CONSTRAINT `fk_guest_relationship_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ADD CONSTRAINT `fk_guest_privacy_request_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ADD CONSTRAINT `fk_guest_corporate_property_contract_corporate_account_id` FOREIGN KEY (`corporate_account_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`corporate_account`(`corporate_account_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ADD CONSTRAINT `fk_guest_group_function_space_booking_guest_group_block_id` FOREIGN KEY (`guest_group_block_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`guest_group_block`(`guest_group_block_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ADD CONSTRAINT `fk_guest_guest_enrollment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ADD CONSTRAINT `fk_guest_segment_membership_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ADD CONSTRAINT `fk_guest_household_primary_merged_household_id` FOREIGN KEY (`primary_merged_household_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`household`(`household_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ADD CONSTRAINT `fk_guest_household_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `vibe_travel_hospitality_v1`.`guest`.`profile`(`profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`guest` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`guest` SET TAGS ('dbx_domain' = 'guest');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `merged_into_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Merged Into Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `predictive_score_id` SET TAGS ('dbx_business_glossary_term' = 'Predictive Score Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `predictive_score_id` SET TAGS ('dbx_ml_link' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `company_name` SET TAGS ('dbx_business_glossary_term' = 'Guest Associated Company Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `company_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `company_name` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `preferred_room_type` SET TAGS ('dbx_business_glossary_term' = 'Guest Preferred Room Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile Lifecycle Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|suspended|deceased');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `smoking_preference` SET TAGS ('dbx_business_glossary_term' = 'Guest Smoking Preference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `smoking_preference` SET TAGS ('dbx_value_regex' = 'NON_SMOKING|SMOKING|NO_PREFERENCE');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `sms_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Guest SMS Marketing Opt-In Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `vip_status` SET TAGS ('dbx_business_glossary_term' = 'Guest VIP Status Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile` ALTER COLUMN `vip_status` SET TAGS ('dbx_value_regex' = 'NONE|VIP1|VIP2|VIP3|VVIP|BLACKLIST');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`contact_info` SET TAGS ('dbx_structure_preserved' = 'v2');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Preference ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Captured By Staff ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`preference` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay ID');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` SET TAGS ('dbx_subdomain' = 'relationship_value');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Event Account Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `credit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Currency Code (ISO 4217)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `credit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_account` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_subdomain' = 'group_enrollment');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_ssot_reference' = 'reservation.reservation_group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_mvm_ssot_role' = 'referencing');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_ssot_concept' = 'group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_ssot_references' = 'reservation.reservation_group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_ssot_duplicate' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_ssot' = 'alias');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_ssot_authority_defer_to' = 'reservation.reservation_group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_ssot_ref' = 'reservation.reservation_group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_ssot_group' = 'group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_ssot_canonical' = 'reservation.reservation_group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `guest_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Group Block ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Group Leader Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Group Coordinator Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_ssot_owner' = 'reservation.reservation_group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `reservation_group_block_id` SET TAGS ('dbx_ssot_entity' = 'group_block');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `accessible_rooms_requested` SET TAGS ('dbx_business_glossary_term' = 'Accessible Rooms Requested');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Group Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `attrition_pct` SET TAGS ('dbx_business_glossary_term' = 'Attrition Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `billing_master_folio_instructions` SET TAGS ('dbx_business_glossary_term' = 'Billing Master Folio Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `billing_master_folio_instructions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Group Block Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'tentative|definite|cancelled|closed|waitlist');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Group Block Cancellation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `complimentary_rooms_contracted` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Rooms Contracted');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `contracted_date` SET TAGS ('dbx_business_glossary_term' = 'Group Block Contracted Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `contracted_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Group Rate Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `contracted_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `contracted_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Contracted Room Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Group Block Cut-Off Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `delphi_opportunity_reference` SET TAGS ('dbx_business_glossary_term' = 'Delphi Opportunity ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `departure_date` SET TAGS ('dbx_business_glossary_term' = 'Group Departure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `deposit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `deposit_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Received Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `deposit_received_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `deposit_required_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Required Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `deposit_required_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `group_code` SET TAGS ('dbx_business_glossary_term' = 'Group Block Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `group_name` SET TAGS ('dbx_business_glossary_term' = 'Group Block Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `group_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `group_notes` SET TAGS ('dbx_business_glossary_term' = 'Group Block Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `group_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Group Rate Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `group_rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `group_rate_code` SET TAGS ('dbx_normalization' = 'natural_key_resolved');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `group_rate_code` SET TAGS ('dbx_denormalized_natural_key' = 'resolved');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Group Type Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `opera_block_reference` SET TAGS ('dbx_business_glossary_term' = 'OPERA PMS Block ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `peak_block_rooms` SET TAGS ('dbx_business_glossary_term' = 'Peak Block Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `repeat_group_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Group Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `rooming_list_due_date` SET TAGS ('dbx_business_glossary_term' = 'Rooming List Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `rooming_list_status` SET TAGS ('dbx_business_glossary_term' = 'Rooming List Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `rooming_list_status` SET TAGS ('dbx_value_regex' = 'not_received|partial|complete|finalized');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `rooms_picked_up` SET TAGS ('dbx_business_glossary_term' = 'Rooms Picked Up');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `source_of_business_code` SET TAGS ('dbx_business_glossary_term' = 'Source of Business Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `source_of_business_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `suite_block_rooms` SET TAGS ('dbx_business_glossary_term' = 'Suite Block Rooms');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP Group Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_group_block` ALTER COLUMN `wash_pct` SET TAGS ('dbx_business_glossary_term' = 'Wash Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` SET TAGS ('dbx_subdomain' = 'relationship_value');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `vip_designation_id` SET TAGS ('dbx_business_glossary_term' = 'VIP Designation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Property Host ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `tertiary_vip_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `tertiary_vip_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`vip_designation` ALTER COLUMN `tertiary_vip_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` SET TAGS ('dbx_subdomain' = 'stay_analytics');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` SET TAGS ('dbx_revpar_adr_fix' = 'resolved');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` SET TAGS ('dbx_revpar_mislabel_fixed' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` SET TAGS ('dbx_revpar_metric_fix' = 'removed_mislabeled_adr_as_revpar');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` SET TAGS ('dbx_revpar_fix' = 'renamed_misnamed_revpar_to_adr; correct_revpar_in_revenue_domain');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `guest_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Block ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `adr` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Rate (ADR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `adr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `adr` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `ancillary_revenue` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `ancillary_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `ancillary_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `booking_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `checkin_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `checkout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-Out Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `complimentary_flag` SET TAGS ('dbx_business_glossary_term' = 'Complimentary Stay Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `loyalty_tier_at_stay` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier at Stay');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `num_adults` SET TAGS ('dbx_business_glossary_term' = 'Number of Adults');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `num_children` SET TAGS ('dbx_business_glossary_term' = 'Number of Children');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `original_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Original Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `original_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Original Departure Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|cash|direct_bill|loyalty_points|bank_transfer');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `qualifying_nights` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `room_revenue` SET TAGS ('dbx_business_glossary_term' = 'Room Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `room_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `room_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`stay_history` ALTER COLUMN `room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Room Type Code');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` SET TAGS ('dbx_subdomain' = 'stay_analytics');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Note ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Case ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Staff ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `tertiary_note_resolved_by_staff_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By Staff ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `tertiary_note_resolved_by_staff_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `tertiary_note_resolved_by_staff_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `authoring_department` SET TAGS ('dbx_business_glossary_term' = 'Authoring Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `note_category` SET TAGS ('dbx_business_glossary_term' = 'Guest Note Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `data_retention_category` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `data_retention_category` SET TAGS ('dbx_value_regex' = 'standard|extended|legal_hold|purge_eligible');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `data_retention_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `display_on_checkin` SET TAGS ('dbx_business_glossary_term' = 'Display on Check-In Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `display_on_checkout` SET TAGS ('dbx_business_glossary_term' = 'Display on Check-Out Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `display_on_reservation` SET TAGS ('dbx_business_glossary_term' = 'Display on Reservation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Note Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `extracted_topics` SET TAGS ('dbx_business_glossary_term' = 'Extracted Topics');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `guest_segment` SET TAGS ('dbx_value_regex' = 'fit|corporate|group|vip|loyalty_elite|crew');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `guest_segment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Note Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `is_vip_alert` SET TAGS ('dbx_business_glossary_term' = 'VIP Alert Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `note_date` SET TAGS ('dbx_business_glossary_term' = 'Note Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `note_status` SET TAGS ('dbx_business_glossary_term' = 'Guest Note Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `note_status` SET TAGS ('dbx_value_regex' = 'active|resolved|expired|cancelled|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `note_type` SET TAGS ('dbx_business_glossary_term' = 'Guest Note Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `note_type` SET TAGS ('dbx_value_regex' = 'preference|complaint|compliment|alert|trace|general');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `opera_trace_reference` SET TAGS ('dbx_business_glossary_term' = 'Oracle OPERA PMS (Property Management System) Trace ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `opera_trace_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `primary_topic` SET TAGS ('dbx_business_glossary_term' = 'Primary Topic');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'every_stay|annual|seasonal|one_time');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Note Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'property|chain');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Note Source Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `stay_date_context` SET TAGS ('dbx_business_glossary_term' = 'Stay Date Context');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `text` SET TAGS ('dbx_business_glossary_term' = 'Guest Note Text');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `text` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `topic_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Topic Confidence Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `topic_extraction_model_version` SET TAGS ('dbx_business_glossary_term' = 'Topic Extraction Model Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`note` ALTER COLUMN `topic_extraction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Topic Extraction Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `communication_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Consent ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `communication_consent_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`communication_consent` ALTER COLUMN `privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request ID');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `identity_document_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Document ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `identity_document_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Staff ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`identity_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` SET TAGS ('dbx_subdomain' = 'stay_analytics');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Guest Segment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `parent_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Segment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `primary_superseded_by_assignment_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Assignment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `profile_merge_history_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Merge History ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Source Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `target_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Target Profile ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `contact_info_migrated_count` SET TAGS ('dbx_business_glossary_term' = 'Contact Information Migrated Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `contact_info_migrated_count` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `data_retention_category` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `data_retention_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `error_message` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `gdpr_consent_retained` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Retained');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `gdpr_consent_retained` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `gdpr_consent_retained` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `loyalty_points_transferred` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Transferred');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `matching_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Matching Confidence Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `matching_criteria` SET TAGS ('dbx_business_glossary_term' = 'Matching Criteria');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `merge_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Merge Batch ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `merge_comments` SET TAGS ('dbx_business_glossary_term' = 'Merge Comments');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `merge_method` SET TAGS ('dbx_business_glossary_term' = 'Merge Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `merge_method` SET TAGS ('dbx_value_regex' = 'automatic_fuzzy_match|manual_review|bulk_batch|api_triggered|crm_deduplication|pms_merge_utility');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `merge_reason` SET TAGS ('dbx_business_glossary_term' = 'Merge Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `merge_reason` SET TAGS ('dbx_value_regex' = 'duplicate_detected|guest_requested_consolidation|property_initiated_cleanup|system_automated_deduplication|loyalty_consolidation|data_quality_initiative');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `merge_status` SET TAGS ('dbx_business_glossary_term' = 'Merge Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `merge_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed|rolled_back|partially_completed');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `merge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Merge Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `notes_migrated_count` SET TAGS ('dbx_business_glossary_term' = 'Notes Migrated Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `operator_department` SET TAGS ('dbx_business_glossary_term' = 'Operator Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `preferences_migrated_count` SET TAGS ('dbx_business_glossary_term' = 'Preferences Migrated Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `reservations_migrated_count` SET TAGS ('dbx_business_glossary_term' = 'Reservations Migrated Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `rollback_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `rollback_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rollback Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `stays_migrated_count` SET TAGS ('dbx_business_glossary_term' = 'Stays Migrated Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending_validation|validation_failed|validation_not_required');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`profile_merge_history` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` SET TAGS ('dbx_subdomain' = 'relationship_value');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `lifetime_value_id` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value (LTV) ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `predictive_score_id` SET TAGS ('dbx_business_glossary_term' = 'Predictive Score Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `predictive_score_id` SET TAGS ('dbx_ml_link' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Rate (ADR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_daily_rate` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_gss_score` SET TAGS ('dbx_business_glossary_term' = 'Average Guest Satisfaction Score (GSS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_gss_score` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Average Length of Stay (ALOS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_length_of_stay` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_nps_score` SET TAGS ('dbx_business_glossary_term' = 'Average Net Promoter Score (NPS)');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_nps_score` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_revenue_per_stay` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per Stay');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `average_revenue_per_stay` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value (LTV) Calculation Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value (LTV) Calculation Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'historical|predictive|hybrid');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `churn_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `days_since_last_stay` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Stay');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `first_stay_date` SET TAGS ('dbx_business_glossary_term' = 'First Stay Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `guest_tenure_days` SET TAGS ('dbx_business_glossary_term' = 'Guest Tenure Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `loyalty_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `loyalty_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `ltv_score` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value (LTV) Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `ltv_tier` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value (LTV) Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `ltv_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard|inactive');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `market_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `most_recent_stay_date` SET TAGS ('dbx_business_glossary_term' = 'Most Recent Stay Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `next_best_offer_code` SET TAGS ('dbx_business_glossary_term' = 'Next Best Offer Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `next_best_offer_code` SET TAGS ('dbx_pii' = 'false');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `next_best_offer_code` SET TAGS ('dbx_ml_feature' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `next_stay_propensity_score` SET TAGS ('dbx_business_glossary_term' = 'Next Stay Propensity Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `preferred_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Brand Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `projected_12m_revenue` SET TAGS ('dbx_business_glossary_term' = 'Projected 12-Month Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `total_ancillary_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Ancillary Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `total_complaints` SET TAGS ('dbx_business_glossary_term' = 'Total Complaints');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `total_fb_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Food and Beverage (F&B) Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `total_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `total_room_nights` SET TAGS ('dbx_business_glossary_term' = 'Total Room Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `total_room_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Room Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `total_stays` SET TAGS ('dbx_business_glossary_term' = 'Total Number of Stays');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`lifetime_value` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'Very Important Person (VIP) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` SET TAGS ('dbx_subdomain' = 'relationship_value');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `tertiary_relationship_last_modified_by_staff_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Staff ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `tertiary_relationship_last_modified_by_staff_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `tertiary_relationship_last_modified_by_staff_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `billing_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Authority Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `booking_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Booking Authority Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `consent_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `consent_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Relationship Direction');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'bidirectional|unidirectional');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `emergency_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `emergency_contact_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Lawful Basis');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legitimate_interest|vital_interest|legal_obligation|public_task');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `gdpr_lawful_basis` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Relationship Priority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'spouse|partner|parent|child|sibling|assistant');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `shared_preference_inheritance_flag` SET TAGS ('dbx_business_glossary_term' = 'Shared Preference Inheritance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `verified_date` SET TAGS ('dbx_business_glossary_term' = 'Verified Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`relationship` ALTER COLUMN `verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Verified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Handler ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `assigned_handler_email` SET TAGS ('dbx_business_glossary_term' = 'Assigned Handler Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `assigned_handler_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `assigned_handler_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `assigned_handler_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `assigned_handler_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Handler Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `assigned_handler_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `crm_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Case ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `data_format` SET TAGS ('dbx_business_glossary_term' = 'Data Format');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `data_format` SET TAGS ('dbx_value_regex' = 'JSON|CSV|PDF|XML');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `data_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'secure_download|email|postal_mail|in_person|api');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `extended_due_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `guest_comments` SET TAGS ('dbx_business_glossary_term' = 'Guest Comments');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `guest_comments` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `guest_communication_sent_count` SET TAGS ('dbx_business_glossary_term' = 'Guest Communication Sent Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `guest_country_code` SET TAGS ('dbx_business_glossary_term' = 'Guest Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `guest_country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `legal_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `legal_hold_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Request Outcome');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'fulfilled|partially_fulfilled|rejected|withdrawn_by_guest|expired');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `property_scope` SET TAGS ('dbx_business_glossary_term' = 'Property Scope');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `property_scope` SET TAGS ('dbx_value_regex' = 'all_properties|specific_properties|single_property');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `records_accessed_count` SET TAGS ('dbx_business_glossary_term' = 'Records Accessed Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `records_deleted_count` SET TAGS ('dbx_business_glossary_term' = 'Records Deleted Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `records_rectified_count` SET TAGS ('dbx_business_glossary_term' = 'Records Rectified Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|LGPD|PIPEDA|APPI|PDPA');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `request_notes` SET TAGS ('dbx_business_glossary_term' = 'Request Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `request_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `request_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Request Reference Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `systems_impacted` SET TAGS ('dbx_business_glossary_term' = 'Systems Impacted');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `third_party_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Third Party Notification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `third_party_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Third Party Notification Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `third_party_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|failed');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'email_confirmation|loyalty_account|two_factor_authentication|government_id|knowledge_based|manual_review');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|verified|failed|manual_review_required');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`privacy_request` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` SET TAGS ('dbx_subdomain' = 'relationship_value');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` SET TAGS ('dbx_association_edges' = 'guest.corporate_account,property.property');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `corporate_property_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Property Contract - Corporate Property Contract Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Property Contract - Corporate Account Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Property Contract - Hotel Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `annual_room_night_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Room Night Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `blackout_dates_policy` SET TAGS ('dbx_business_glossary_term' = 'Blackout Dates Policy');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `direct_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Direct Billing Enabled');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `last_pickup_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Pickup Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `los_minimum_nights` SET TAGS ('dbx_business_glossary_term' = 'Minimum Length of Stay');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `negotiated_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Rate Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `property_account_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Property Account Manager Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `property_account_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `property_account_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `property_account_manager_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `property_account_manager_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `property_account_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Property Account Manager Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `property_account_manager_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `property_account_manager_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `rate_program_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Program Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`corporate_property_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` SET TAGS ('dbx_subdomain' = 'group_enrollment');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` SET TAGS ('dbx_association_edges' = 'guest.guest_group_block,property.meeting_space');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `group_function_space_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Group Function Space Booking ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `guest_group_block_id` SET TAGS ('dbx_business_glossary_term' = 'Group Function Space Booking - Guest Group Block Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Group Function Space Booking - Meeting Space Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `av_requirements` SET TAGS ('dbx_business_glossary_term' = 'AV Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `booking_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `catering_minimum_met` SET TAGS ('dbx_business_glossary_term' = 'Catering Minimum Met');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `event_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Event End Date Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `event_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Event Start Date Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `guaranteed_attendance` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `rental_amount` SET TAGS ('dbx_business_glossary_term' = 'Rental Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `setup_type` SET TAGS ('dbx_business_glossary_term' = 'Setup Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`group_function_space_booking` ALTER COLUMN `special_setup_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Setup Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` SET TAGS ('dbx_subdomain' = 'group_enrollment');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` SET TAGS ('dbx_association_edges' = 'guest.profile,loyalty.promotion');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `guest_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'guest_enrollment Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Profile Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Promotion Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `bonus_awarded_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Awarded Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `enrollment_reference` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `guest_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `guest_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`guest_enrollment` ALTER COLUMN `progress_value` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Activity Progress');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` SET TAGS ('dbx_subdomain' = 'stay_analytics');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` SET TAGS ('dbx_association_edges' = 'guest.profile,marketing.guest_segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership - Guest Segment Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership - Profile Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `assignment_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Assignment Confidence Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Assignment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `assignment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `assignment_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `assignment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Membership Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `last_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Last Refresh Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Membership Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`segment_membership` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Membership Created By');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` SET TAGS ('dbx_subdomain' = 'relationship_value');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_merged_household_id` SET TAGS ('dbx_business_glossary_term' = 'Merged Household Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_merged_household_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `adult_count` SET TAGS ('dbx_business_glossary_term' = 'Adult Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `average_daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `average_daily_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `average_daily_rate` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `child_count` SET TAGS ('dbx_business_glossary_term' = 'Child Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_business_glossary_term' = 'Crm Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_business_glossary_term' = 'Household Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_business_glossary_term' = 'Household Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `last_stay_date` SET TAGS ('dbx_business_glossary_term' = 'Last Stay Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `lifetime_nights` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Nights');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `lifetime_revenue` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Revenue');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `lifetime_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt In');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `merge_date` SET TAGS ('dbx_business_glossary_term' = 'Merge Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_business_glossary_term' = 'Household Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `next_stay_date` SET TAGS ('dbx_business_glossary_term' = 'Next Stay Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `preferred_language` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `preferred_room_type` SET TAGS ('dbx_business_glossary_term' = 'Preferred Room Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `special_requests` SET TAGS ('dbx_business_glossary_term' = 'Special Requests');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`household` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'Vip Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` SET TAGS ('dbx_subdomain' = 'stay_analytics');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `predictive_score_id` SET TAGS ('dbx_business_glossary_term' = 'Predictive Score Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `next_best_offer_code` SET TAGS ('dbx_business_glossary_term' = 'Next Best Offer Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `next_best_offer_score` SET TAGS ('dbx_business_glossary_term' = 'Next Best Offer Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `score_value` SET TAGS ('dbx_business_glossary_term' = 'Score Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `score_value` SET TAGS ('dbx_reviewer_directive' = 'VREQ-024');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `score_value` SET TAGS ('dbx_supreme_authority' = 'section_2_reviewer_comments');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `score_value` SET TAGS ('dbx_governance' = 'claude_md_section_3c_user_vibes_rule');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `scored_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scored Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`guest`.`predictive_score` ALTER COLUMN `upsell_propensity_score` SET TAGS ('dbx_business_glossary_term' = 'Upsell Propensity Score');
