-- Schema for Domain: consumer | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`consumer` COMMENT 'SSOT for all end consumers, shoppers, households, and loyalty program members in B2C and DTC channels. Manages consumer profiles, preferences, purchase history, segmentation, NPS scores, CLTV calculations, consent and privacy preferences (GDPR/CCPA), and contact data. Supports CRM, personalization, and consumer engagement programs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` (
    `shopper_id` BIGINT COMMENT 'Unique surrogate identifier for every end consumer and shopper record in the Consumer Goods golden master. This is the anchor primary key for the entire consumer domain — all other consumer entities reference this record. Role: MASTER_PARTY.',
    `household_id` BIGINT COMMENT 'An identifier linking this consumer to a household grouping. Multiple individual shoppers may share the same household_id, enabling household-level purchase analysis, co-habitation segmentation, and family-targeted promotions. Used in Nielsen IQ Consumer Panel household modeling.',
    `loyalty_program_id` BIGINT COMMENT 'The externally-visible loyalty program membership identifier assigned to the consumer upon enrollment. Used as the primary cross-channel identifier for loyalty point accrual, redemption, and tier management in CRM and POS systems.',
    `address_id` BIGINT COMMENT 'The primary address id of the shopper record',
    `acquisition_channel` STRING COMMENT 'The channel through which the consumer was first acquired or registered. Supports marketing attribution, channel ROI analysis, and consumer journey analytics. Aligns with DTC, POS, and loyalty enrollment touchpoints. [ENUM-REF-CANDIDATE: dtc_web|dtc_mobile|retail_pos|loyalty_enrollment|social_media|event|referral|wholesale — promote to reference product]',
    `acquisition_date` DATE COMMENT 'The date on which the consumer was first acquired or registered in the system (yyyy-MM-dd). Used for cohort analysis, consumer tenure calculations, and lifecycle marketing programs.',
    `age_verified` BOOLEAN COMMENT 'Indicates whether the consumer has passed age verification for access to age-restricted products (e.g., alcohol, tobacco, certain health products). TRUE = age verified; FALSE = not verified. Required for regulatory compliance with FDA and CPSC age-restriction mandates.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the shopper record',
    `birth_date` DATE COMMENT 'The consumers date of birth in ISO 8601 format (yyyy-MM-dd). Used for age verification (e.g., age-restricted products), lifecycle segmentation, birthday loyalty rewards, and regulatory compliance.',
    `ccpa_subject` BOOLEAN COMMENT 'Indicates whether this consumer is a California resident subject to CCPA protections. TRUE = CCPA applies; FALSE = not a CCPA subject. Drives opt-out of sale workflows, data deletion requests, and disclosure obligations.',
    `cltv_segment` STRING COMMENT 'The consumers current CLTV (Customer Lifetime Value) segment classification derived from purchase history and predictive modeling. Used for resource allocation in marketing, personalization prioritization, and retention investment decisions. Segment label, not a calculated metric.. Valid values are `high_value|mid_value|low_value|at_risk|churned`',
    `shopper_code` STRING COMMENT 'The shopper code of the shopper record',
    `consent_timestamp` TIMESTAMP COMMENT 'The exact date and time (ISO 8601 with timezone) when the consumer last provided or updated their privacy consent. Provides the auditable consent record required by GDPR Article 7 and CCPA. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `consent_version` STRING COMMENT 'The version identifier of the privacy policy and consent notice that the consumer accepted (e.g., v2.3, 2024-01). Used to track consent currency and trigger re-consent workflows when policy versions are updated.',
    `consumer_type` STRING COMMENT 'Categorical classification of the shopper record distinguishing individual consumers, household accounts, small business buyers, enrolled loyalty program members, and guest/anonymous shoppers. Drives CRM segmentation and personalization strategy.. Valid values are `individual|household|business_buyer|loyalty_member|guest`',
    `country_code` STRING COMMENT 'The consumers country of residence in ISO 3166-1 alpha-3 format (e.g., USA, GBR, DEU). Determines applicable regulatory framework (GDPR for EU, CCPA for California), tax jurisdiction, and localized product availability.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The exact date and time (ISO 8601 with timezone) when this shopper record was first created in the Consumer Goods data platform. Serves as the authoritative audit trail for record creation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'The currency code of the shopper record',
    `data_sharing_consent` BOOLEAN COMMENT 'Indicates whether the consumer has consented to sharing their personal data with third-party partners (e.g., retail partners, market research firms such as Nielsen IQ). TRUE = consented; FALSE = not consented. Critical for GDPR Article 6 lawful basis and CCPA opt-out compliance.',
    `date_of_birth` DATE COMMENT 'The date of birth of the shopper record',
    `shopper_description` STRING COMMENT 'The shopper description of the shopper record',
    `display_name` STRING COMMENT 'The consumers preferred display name or alias used in digital channels, loyalty portals, and personalized marketing communications. May differ from legal name.',
    `effective_from` DATE COMMENT 'The effective from of the shopper record',
    `effective_until` DATE COMMENT 'The effective until of the shopper record',
    `email` STRING COMMENT 'The email of the shopper record',
    `email_opt_in` BOOLEAN COMMENT 'Indicates whether the consumer has provided explicit opt-in consent to receive email marketing communications. TRUE = consented; FALSE = not consented or withdrawn. Mandatory suppression flag for GDPR/CCPA compliance in all outbound email campaigns.',
    `family_name` STRING COMMENT 'The consumers legal family name (surname) as captured at registration or identity verification. Combined with given_name to form the full legal identity for CRM, personalization, and regulatory compliance.',
    `first_name` STRING COMMENT 'The first name of the shopper record',
    `first_purchase_date` DATE COMMENT 'The first purchase date of the shopper record',
    `gdpr_subject` BOOLEAN COMMENT 'Indicates whether this consumer is a GDPR data subject (i.e., located in the EU/EEA and subject to GDPR protections). TRUE = GDPR applies; FALSE = not a GDPR subject. Drives data processing lawful basis checks, right-to-erasure workflows, and data portability requests.',
    `gender` STRING COMMENT 'The consumers self-reported gender identity. Used for consumer segmentation, personalized product recommendations, and inclusive marketing. Collected with explicit consent per GDPR/CCPA.. Valid values are `male|female|non_binary|prefer_not_to_say|other`',
    `given_name` STRING COMMENT 'The consumers legal given name (first name) as captured at registration or identity verification. Used for personalized communications, CRM, and regulatory subject identification under GDPR/CCPA.',
    `identity_verification_date` DATE COMMENT 'The date on which the consumers identity was most recently verified (yyyy-MM-dd). Used to assess verification recency and trigger re-verification workflows for high-risk transactions or regulatory audits.',
    `identity_verified` BOOLEAN COMMENT 'Indicates whether the consumers identity has been formally verified through an identity verification process (e.g., email confirmation, document verification, phone OTP). TRUE = verified; FALSE = unverified. Affects eligibility for high-value loyalty redemptions and DTC account features.',
    `is_active` BOOLEAN COMMENT 'The is active of the shopper record',
    `language_preference` STRING COMMENT 'The language preference of the shopper record',
    `last_activity_timestamp` TIMESTAMP COMMENT 'The last activity timestamp of the shopper record',
    `last_name` STRING COMMENT 'The last name of the shopper record',
    `last_purchase_date` DATE COMMENT 'The date of the consumers most recent confirmed purchase transaction across any channel (DTC, retail POS, e-commerce). Used for recency scoring in RFM (Recency, Frequency, Monetary) analysis, churn prediction, and re-engagement campaign triggers.',
    `lifecycle_status` STRING COMMENT 'Current state of the consumer record in the lifecycle. active = engaged consumer; inactive = no activity within defined period; opted_out = consumer has withdrawn consent and must not be contacted; suspended = account temporarily restricted; pending_verification = identity not yet confirmed. Drives GDPR/CCPA suppression logic.. Valid values are `active|inactive|opted_out|suspended|pending_verification`',
    `lifetime_value` DECIMAL(18,2) COMMENT 'The lifetime value of the shopper record',
    `loyalty_enrollment_date` DATE COMMENT 'The date the consumer formally enrolled in the loyalty program (yyyy-MM-dd). Used to calculate loyalty tenure, anniversary rewards, and cohort-based loyalty analytics.',
    `loyalty_points_balance` DECIMAL(18,2) COMMENT 'The current redeemable loyalty points balance held by the consumer. This is the raw operational balance as recorded in the loyalty system — not a calculated aggregate. Used for redemption eligibility checks and consumer-facing balance display.',
    `loyalty_status` STRING COMMENT 'The loyalty status of the shopper record',
    `loyalty_tier` STRING COMMENT 'The consumers current tier within the loyalty program (e.g., Bronze, Silver, Gold, Platinum). Determines benefit entitlements, promotional eligibility, and personalized offer thresholds. Recalculated periodically based on purchase activity.. Valid values are `bronze|silver|gold|platinum`',
    `marketing_opt_in` BOOLEAN COMMENT 'The marketing opt in of the shopper record',
    `shopper_name` STRING COMMENT 'The shopper name of the shopper record',
    `notes` STRING COMMENT 'The notes of the shopper record',
    `nps_score` STRING COMMENT 'The most recently recorded Net Promoter Score (NPS) for this consumer, on a scale of 0–10. NPS is the industry-standard metric for measuring consumer loyalty and likelihood to recommend. Supports consumer satisfaction analytics and brand health reporting.',
    `nps_survey_date` DATE COMMENT 'The date on which the most recent NPS survey response was recorded for this consumer. Used to assess recency of satisfaction data and trigger re-survey workflows.',
    `phone` STRING COMMENT 'The phone of the shopper record',
    `postal_code` STRING COMMENT 'The consumers residential postal or ZIP code. Used for geographic segmentation, regional marketing campaigns, distribution territory assignment, and retail proximity analysis (OSA, planogram relevance).',
    `preferred_currency` STRING COMMENT 'The consumers preferred transaction currency in ISO 4217 three-letter code (e.g., USD, EUR, GBP). Used for DTC pricing display, loyalty point valuation, and cross-border e-commerce personalization.. Valid values are `^[A-Z]{3}$`',
    `preferred_language` STRING COMMENT 'The consumers preferred communication language in IETF BCP 47 format (e.g., en-US, fr-FR, es-MX). Drives localization of marketing communications, product labels, and digital experience personalization.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `preferred_store_banner` STRING COMMENT 'The consumers self-reported or behaviorally-inferred preferred retail store banner or chain (e.g., Walmart, Target, Kroger). Used for retail execution targeting, trade promotion personalization, and channel affinity analytics in Salesforce Consumer Goods Cloud.',
    `primary_email` STRING COMMENT 'The primary email address used for all consumer communications, loyalty program enrollment, DTC order confirmations, and digital marketing. Serves as the principal digital identity key in CRM and Salesforce Consumer Goods Cloud.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'The consumers primary contact phone number in E.164 international format. Used for SMS marketing, two-factor authentication, consumer care, and DTC order notifications.. Valid values are `^+?[1-9]d{6,14}$`',
    `push_notification_opt_in` BOOLEAN COMMENT 'Indicates whether the consumer has opted in to receive push notifications via the brands mobile application. TRUE = opted in; FALSE = opted out or not set. Drives mobile engagement campaign eligibility.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the shopper record',
    `record_source_system` STRING COMMENT 'The record source system of the shopper record',
    `registration_source_url` STRING COMMENT 'The URL or digital touchpoint from which the consumer completed their registration (e.g., brand website landing page, DTC checkout, loyalty sign-up page). Supports digital marketing attribution and campaign source tracking.',
    `shopper_status` STRING COMMENT 'The shopper status of the shopper record',
    `sms_opt_in` BOOLEAN COMMENT 'Indicates whether the consumer has provided explicit opt-in consent to receive SMS/text marketing communications. TRUE = consented; FALSE = not consented or withdrawn. Required for TCPA compliance in the US and equivalent regulations globally.',
    `source_system_code` STRING COMMENT 'The source system code of the shopper record',
    `source_system_consumer_ref` STRING COMMENT 'The consumers unique identifier as recorded in the originating source system (e.g., SAP Business Partner ID, Salesforce Contact ID, DTC platform user ID). Enables cross-system reconciliation, MDM golden record matching, and audit traceability back to the system of record.',
    `uom` STRING COMMENT 'The uom of the shopper record',
    `updated_timestamp` TIMESTAMP COMMENT 'The exact date and time (ISO 8601 with timezone) when this shopper record was most recently modified. Used for change data capture (CDC), incremental ETL processing, and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_shopper PRIMARY KEY(`shopper_id`)
) COMMENT 'Golden master record for every end consumer and shopper across B2C and DTC channels. Stores consumer identity (full name, date of birth, gender), contact details (primary email, phone), language and currency preferences, acquisition metadata (channel, date), consumer lifecycle status (active/inactive/opted-out), identity verification status, and source system references. This is the single anchor entity for the consumer domain — all other consumer entities reference this record via shopper_id. Supports CRM, personalization, regulatory compliance (GDPR/CCPA subject identification), and consumer 360-degree view.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`household` (
    `household_id` BIGINT COMMENT 'Unique surrogate identifier for the household record in the Consumer Goods lakehouse. Primary key for all household-level analytics, loyalty pooling, and basket analysis.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program under which this household is enrolled for points pooling and reward redemption.',
    `merged_from_household_id` BIGINT COMMENT 'Reference to the source household record that was merged into this household during deduplication or household consolidation. Null if no merge has occurred. Supports data lineage and audit trails.',
    `panel_id` BIGINT COMMENT 'External identifier assigned to the household by the consumer research panel provider (e.g., Nielsen IQ). Used for cross-referencing panel purchase diary data with internal CRM and loyalty records.',
    `shopper_id` BIGINT COMMENT 'Reference to the designated primary shopper or head-of-household consumer profile. Used to anchor loyalty program pooling and personalization targeting.',
    `address_summary` STRING COMMENT 'The address summary of the household record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the household record',
    `brand_affinity_flag` BOOLEAN COMMENT 'Indicates whether the household has demonstrated strong brand loyalty to the companys portfolio based on repeat purchase patterns and SOV (Share of Voice) analysis. Used for brand marketing investment decisions.',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the household has exercised the right to opt out of the sale of personal information under CCPA (California Consumer Privacy Act). Mandatory compliance field for California-resident households.',
    `children_present_flag` BOOLEAN COMMENT 'Indicates whether children under 18 are present in the household. Key trigger for cross-sell targeting of baby, child health, and family-oriented CPG/FMCG product categories.',
    `cltv_band` STRING COMMENT 'Categorical CLTV (Customer Lifetime Value) band assigned to the household based on historical purchase behavior and predictive modeling. Used for investment prioritization in trade promotion and personalization.. Valid values are `low|medium|high|very_high`',
    `household_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the household, used in CRM, loyalty, and DTC channel communications. Distinct from the surrogate primary key.. Valid values are `^HH-[A-Z0-9]{8,16}$`',
    `consent_last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any consent or privacy preference for the household. Critical for GDPR/CCPA audit trails and demonstrating lawful basis for data processing.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country of the households primary residence. Used for regulatory compliance (GDPR, CCPA) and international market segmentation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was first created in the system. Used for data lineage, audit trails, and GDPR/CCPA compliance reporting.',
    `currency_code` STRING COMMENT 'The currency code of the household record',
    `data_source` STRING COMMENT 'Originating system or channel from which the household record was first created or last enriched. Used for data lineage, quality scoring, and source system reconciliation in the lakehouse. [ENUM-REF-CANDIDATE: crm|loyalty_program|ecommerce|panel|pos|dtc|manual — 7 candidates stripped; promote to reference product]',
    `household_description` STRING COMMENT 'The household description of the household record',
    `digital_engagement_flag` BOOLEAN COMMENT 'Indicates whether the household actively engages with the brand through digital channels (e-commerce, mobile app, social media). Used for DTC (Direct to Consumer) channel strategy and omnichannel personalization.',
    `dissolution_date` DATE COMMENT 'Date on which the household was dissolved, merged, or deactivated. Null for active households. Used for lifecycle reporting and GDPR/CCPA data retention compliance.',
    `dwelling_type` STRING COMMENT 'Type of residential dwelling occupied by the household. Used for product category targeting (e.g., home care, cleaning products) and basket size normalization in CPG analytics.. Valid values are `house|apartment|condo|townhouse|mobile_home|other`',
    `effective_from` DATE COMMENT 'The effective from of the household record',
    `effective_until` DATE COMMENT 'The effective until of the household record',
    `estimated_size` STRING COMMENT 'Estimated number of individuals residing in the household. Used for basket size normalization, per-capita consumption analysis, and product volume forecasting in S&OP (Sales and Operations Planning).',
    `formation_date` DATE COMMENT 'Date on which the household record was first established in the system, representing when the household unit was recognized as a distinct entity for loyalty and analytics purposes.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the household has provided valid consent for data processing under GDPR (General Data Protection Regulation). Mandatory for EU-resident households before any marketing or analytics processing.',
    `geographic_region` STRING COMMENT 'Broad geographic region of the households residence (e.g., Northeast, Southeast, Midwest, West, Southwest). Used for regional demand planning and distribution channel management.',
    `has_children` BOOLEAN COMMENT 'The has children of the household record',
    `household_status` STRING COMMENT 'Current lifecycle state of the household record. merged indicates consolidation with another household; dissolved indicates the household no longer exists as a unit.. Valid values are `active|inactive|suspended|merged|dissolved`',
    `household_type` STRING COMMENT 'Categorical classification of the household composition used for segmentation and cross-sell targeting in CPG/FMCG analytics. [ENUM-REF-CANDIDATE: single|couple|family|multi_generational|shared_living|other — promote to reference product if values expand]. Valid values are `single|couple|family|multi_generational|shared_living|other`',
    `income_band` STRING COMMENT 'Estimated annual household income bracket used for consumer segmentation, RSP (Recommended Selling Price) sensitivity analysis, and premium product targeting. Derived from third-party panel data or self-reported.. Valid values are `low|lower_middle|middle|upper_middle|high`',
    `income_bracket` STRING COMMENT 'The income bracket of the household record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the household record. Used for change data capture (CDC) in the Databricks lakehouse Silver layer and data freshness monitoring.',
    `life_stage` STRING COMMENT 'Life stage classification of the household used for targeted marketing and NPD (New Product Development) insights (e.g., young_single, young_couple_no_children, family_with_young_children, family_with_teens, empty_nester, retired). Enables cross-sell triggers such as recommending baby products when life stage transitions. [ENUM-REF-CANDIDATE: young_single|young_couple_no_children|family_with_young_children|family_with_teens|empty_nester|retired|other — promote to reference product]',
    `lifecycle_stage` STRING COMMENT 'The lifecycle stage of the household record',
    `loyalty_enrollment_date` DATE COMMENT 'Date on which the household was enrolled in the loyalty program. Used to calculate loyalty tenure, tier progression timelines, and CLTV (Customer Lifetime Value) cohort analysis.',
    `loyalty_points_balance` DECIMAL(18,2) COMMENT 'Current unredeemed loyalty points balance accumulated at the household level across all member consumers. Supports household-level pooling for CPG/FMCG loyalty programs.',
    `loyalty_tier` STRING COMMENT 'Current loyalty program tier of the household based on cumulative purchase activity. Drives reward multipliers, exclusive offers, and CLTV (Customer Lifetime Value) segmentation.. Valid values are `bronze|silver|gold|platinum`',
    `market_segment` STRING COMMENT 'Strategic consumer market segment assigned to the household for brand marketing and consumer engagement programs (e.g., health_conscious, value_seeker, premium_buyer, eco_friendly). [ENUM-REF-CANDIDATE: health_conscious|value_seeker|premium_buyer|eco_friendly|convenience_driven|brand_loyal — promote to reference product]',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the household has opted in to receive marketing communications (email, SMS, push notifications) from the brand. Governs eligibility for trade promotion and consumer engagement campaigns.',
    `household_name` STRING COMMENT 'Human-readable label for the household, typically the primary shoppers surname or a family name used for display in CRM and loyalty program communications.',
    `notes` STRING COMMENT 'The notes of the household record',
    `nps_score` STRING COMMENT 'Most recent NPS (Net Promoter Score) recorded for the household, ranging from 0 to 10. Used to classify households as Promoters (9-10), Passives (7-8), or Detractors (0-6) for consumer engagement programs.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS (Net Promoter Score) survey response was recorded for the household. Used to assess recency of satisfaction data for consumer engagement decisions.',
    `number_of_children` STRING COMMENT 'The number of children of the household record',
    `panel_member_flag` BOOLEAN COMMENT 'Indicates whether the household is an active member of a consumer research panel (e.g., Nielsen IQ Consumer Panel). Panel households provide purchase diary data used for market intelligence and SOM (Share of Market) analysis.',
    `pet_owner_flag` BOOLEAN COMMENT 'Indicates whether the household owns pets. Used for targeted marketing of pet care product categories and cross-sell recommendations within the CPG/FMCG portfolio.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the households primary residence. Used for geographic clustering, DRP (Distribution Requirements Planning), and localized trade promotion targeting.',
    `preferred_language` STRING COMMENT 'BCP 47 language tag representing the households preferred communication language (e.g., en-US, es-MX, fr-FR). Used for localized marketing content, product labeling compliance, and consumer engagement personalization.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `primary_channel` STRING COMMENT 'The dominant channel through which the household makes purchases. Used for DTC (Direct to Consumer) strategy, channel mix analysis, and trade promotion targeting.. Valid values are `retail|ecommerce|dtc|wholesale|omnichannel`',
    `primary_retailer_banner` STRING COMMENT 'The retail banner or chain where the household conducts the majority of its grocery or consumer goods shopping (e.g., Walmart, Target, Kroger). Used for OSA (On Shelf Availability) and POG (Planogram) analytics.',
    `private_label_buyer_flag` BOOLEAN COMMENT 'Indicates whether the household regularly purchases private label or store-brand products in addition to or instead of branded CPG products. Used for competitive analysis and brand switching risk assessment.',
    `purchase_frequency_band` STRING COMMENT 'Categorical band representing how frequently the household makes purchases across CPG/FMCG categories. Derived from POS (Point of Sale) transaction history and used for demand sensing and replenishment planning.. Valid values are `occasional|regular|frequent|very_frequent`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the household record',
    `record_source_system` STRING COMMENT 'The record source system of the household record',
    `region` STRING COMMENT 'The region of the household record',
    `size` STRING COMMENT 'The size of the household record',
    `source_system_code` STRING COMMENT 'The source system code of the household record',
    `tenure_type` STRING COMMENT 'Indicates whether the household owns or rents their residence. Used for home improvement and home care product category targeting and consumer segmentation.. Valid values are `owner|renter|other`',
    `uom` STRING COMMENT 'The uom of the household record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the household record',
    CONSTRAINT pk_household PRIMARY KEY(`household_id`)
) COMMENT 'Household unit grouping multiple shoppers who share a residence and purchasing decisions. Captures household demographics (estimated size, income band, life stage), formation date, status, and primary shopper designation. Enables household-level basket analysis, cross-sell targeting (e.g., recommending baby products when life stage changes), and loyalty program household pooling for CPG/FMCG brands.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`address` (
    `address_id` BIGINT COMMENT 'Unique surrogate identifier for each consumer address record in the Consumer Goods DTC/B2C platform. Primary key for the consumer_address data product.',
    `household_id` BIGINT COMMENT 'The household id of the address record',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer/shopper profile this address belongs to. Links the address record to the master consumer party in the CRM and DTC systems.',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record. Active addresses are eligible for order fulfillment and marketing. Inactive addresses are retained for historical reporting. Deleted status supports GDPR right-to-erasure soft-delete workflows.. Valid values are `active|inactive|deleted|pending_review`',
    `address_type` STRING COMMENT 'Classification of the address by its business purpose. Billing addresses are used for invoicing and financial compliance; shipping addresses drive DTC order fulfillment and last-mile logistics; home and work addresses support personalized marketing and consumer segmentation.. Valid values are `billing|shipping|home|work|preferred`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the address record',
    `census_tract` STRING COMMENT 'U.S. Census Bureau census tract code for the address location. Enables demographic overlay analysis, market penetration reporting by socioeconomic segment, and trade area planning for consumer goods distribution.',
    `city` STRING COMMENT 'City or municipality of the consumers address. Used for geographic segmentation, regional marketing campaigns, distribution zone assignment, and regulatory data residency tracking.',
    `address_code` STRING COMMENT 'The address code of the address record',
    `consent_captured` BOOLEAN COMMENT 'Indicates whether explicit consumer consent was obtained for storing and processing this address record under applicable privacy regulations (GDPR/CCPA). True indicates consent is on file; False requires consent collection before marketing use.',
    `consent_date` DATE COMMENT 'Date on which the consumer provided consent for storage and processing of this address record. Required for GDPR Article 7 compliance documentation and CCPA opt-in audit trails.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the consumers address (e.g., USA, GBR, DEU). Drives GDPR/CCPA data residency compliance, international shipping eligibility, tax jurisdiction, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this address record was first created in the system. Supports GDPR Article 30 records of processing activities, data lineage tracking, and audit trail requirements for consumer data governance.',
    `currency_code` STRING COMMENT 'The currency code of the address record',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `data_residency_region` STRING COMMENT 'Geographic data residency classification for this address record, indicating the regulatory jurisdiction governing data storage and processing. Drives GDPR (EU), CCPA (US/CA), and other regional privacy law compliance for data localization requirements.. Valid values are `EU|US|APAC|LATAM|MEA|CA`',
    `deliverability_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) representing the likelihood that a physical shipment or direct mail piece will be successfully delivered to this address. Derived from address validation provider output. Supports carrier selection and DTC fulfillment risk management.',
    `address_description` STRING COMMENT 'The address description of the address record',
    `dma_code` STRING COMMENT 'Nielsen Designated Market Area (DMA) code for the address location. Used for media planning, Share of Voice (SOV) analysis, and regional brand marketing investment allocation in consumer goods trade promotion programs.',
    `do_not_mail` BOOLEAN COMMENT 'Indicates whether the consumer has opted out of physical direct mail marketing to this address. When True, this address must be suppressed from direct mail campaign execution lists. Supports GDPR right-to-object and CCPA opt-out compliance.',
    `dpv_confirmation` STRING COMMENT 'USPS Delivery Point Validation confirmation code indicating the deliverability of the address. Y=Confirmed deliverable, S=Confirmed deliverable (secondary info missing), D=Confirmed deliverable (secondary info present but unneeded), N=Not confirmed. Critical for DTC fulfillment and direct mail campaigns.. Valid values are `Y|S|D|N`',
    `effective_date` DATE COMMENT 'The date from which this address record is considered valid and active for business use. Supports bi-temporal data modeling, address history tracking, and GDPR right-to-erasure compliance by enabling point-in-time address reconstruction.',
    `effective_from` DATE COMMENT 'The effective from of the address record',
    `effective_until` DATE COMMENT 'The effective until of the address record',
    `expiry_date` DATE COMMENT 'The date after which this address record is no longer valid for business use. Null indicates an open-ended active address. Used for address lifecycle management, historical reporting, and GDPR data minimization compliance.',
    `format_type` STRING COMMENT 'Classification of the address format to guide formatting, validation, and carrier routing logic. PO Box addresses may not be eligible for certain DTC carriers; military addresses (APO/FPO/DPO) require specific handling; rural route addresses may have extended delivery windows.. Valid values are `domestic|international|po_box|military|rural_route`',
    `geocoding_accuracy` STRING COMMENT 'Precision level of the geocoded latitude/longitude coordinates for this address. Rooftop indicates exact parcel-level geocoding; range_interpolated indicates interpolation between street numbers; geometric_center indicates centroid of a polygon. Impacts reliability of proximity-based analytics.. Valid values are `rooftop|range_interpolated|geometric_center|approximate|failed`',
    `is_active` BOOLEAN COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `is_default_billing` BOOLEAN COMMENT 'Indicates whether this address is the consumers default billing address for payment processing and invoice generation. Used in DTC checkout flows and financial compliance reporting.',
    `is_default_shipping` BOOLEAN COMMENT 'Indicates whether this address is the consumers default shipping destination for DTC orders. Distinct from is_primary as a consumer may have a primary home address but a different default shipping address (e.g., workplace).',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the consumers primary address record for the given address type. When True, this address is used as the default for order fulfillment, marketing communications, and regulatory correspondence.',
    `is_validated` BOOLEAN COMMENT 'The is validated of the address record',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the consumers address in decimal degrees (WGS84 datum). Enables geocoded proximity analysis, delivery zone optimization, and location-based personalized marketing.',
    `line_1` STRING COMMENT 'Primary street address line including house/building number and street name. Core component of the consumers physical location used for DTC order fulfillment, direct mail marketing, and GDPR/CCPA data residency compliance.',
    `line_2` STRING COMMENT 'Secondary address line for apartment, suite, unit, floor, or building designations. Supplements address_line_1 to ensure complete and accurate delivery routing for DTC shipments.',
    `line_3` STRING COMMENT 'Tertiary address line for additional location details such as neighborhood, district, or care-of designations. Used in international address formats where three address lines are required.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the consumers address in decimal degrees (WGS84 datum). Used alongside latitude for geocoded proximity analysis, store locator features, and last-mile delivery optimization.',
    `address_name` STRING COMMENT 'The address name of the address record',
    `notes` STRING COMMENT 'The notes of the address record',
    `plus4_code` STRING COMMENT 'The four-digit USPS ZIP+4 extension code that narrows delivery to a specific block face or building. Enables postal presort discounts for direct mail campaigns and improves delivery precision for DTC shipments within the United States.. Valid values are `^[0-9]{4}$`',
    `postal_code` STRING COMMENT 'ZIP or postal code of the consumers address. Used for last-mile delivery routing, trade area analysis, demographic segmentation, and carrier rate determination in DTC fulfillment.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the address record',
    `record_source_system` STRING COMMENT 'The record source system of the address record',
    `residential_indicator` STRING COMMENT 'Classification of the address as residential or commercial. Impacts carrier surcharge calculations (UPS/FedEx residential delivery fees), marketing segmentation, and DTC fulfillment cost modeling.. Valid values are `residential|commercial|mixed|unknown`',
    `source` STRING COMMENT 'The originating channel or system through which this address was captured. Supports data lineage, source quality scoring, and GDPR/CCPA consent audit trails. [ENUM-REF-CANDIDATE: crm|dtc_checkout|loyalty_enrollment|call_center|mobile_app|web_portal|third_party|manual_entry — promote to reference product]',
    `source_record_code` STRING COMMENT 'Conformed governance attribute source_record_id.',
    `source_system_code` STRING COMMENT 'The native record identifier from the originating operational system of record (e.g., Salesforce Consumer Goods Cloud Contact Address ID, SAP S/4HANA Business Partner Address GUID). Enables cross-system reconciliation and data lineage tracing in the Silver Layer.',
    `standardized_address` STRING COMMENT 'The full address formatted as a single standardized string per USPS/UPU postal standards after address validation and normalization (e.g., 123 MAIN ST APT 4B, CHICAGO IL 60601-1234). Used as the canonical address for carrier label generation and deduplication.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the consumers address using ISO 3166-2 subdivision codes (e.g., US-CA, CA-ON). Supports tax jurisdiction determination, regional compliance, and territory-based sales reporting.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., America/New_York, Europe/London). Used for scheduling personalized marketing communications at optimal local times and for regulatory compliance with time-sensitive consumer notifications.',
    `uom` STRING COMMENT 'The uom of the address record',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this address record was last modified. Used for change data capture (CDC) in the Databricks Silver Layer pipeline, data freshness monitoring, and GDPR data accuracy compliance tracking.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `valid_to_timestamp` TIMESTAMP COMMENT 'Governance/lineage metadata added in v2 rebuild for ECM/MVM completeness.',
    `validation_provider` STRING COMMENT 'Name of the third-party address validation service used to verify this address (e.g., USPS CASS, SmartyStreets, Loqate, Google Maps API). Supports audit trails for data quality governance and vendor performance tracking.',
    `validation_status` STRING COMMENT 'Current validation state of the address record as determined by address verification services (e.g., USPS CASS, SmartyStreets, Loqate). Validated addresses reduce failed DTC deliveries and return-to-sender costs. Failed addresses require consumer outreach before order fulfillment.. Valid values are `validated|unvalidated|failed|corrected|pending`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the address was last validated by the address verification service. Used to determine if re-validation is needed based on data freshness policies and to support data quality SLA reporting.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and digital address records associated with a consumer/shopper. Stores address type (billing, shipping, home, work), street lines, city, state/province, postal code, country, geocoordinates (latitude/longitude), address validation status, address source, effective date, and expiry date. Supports DTC order fulfillment, personalized marketing, and regulatory compliance for GDPR/CCPA data residency requirements.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` (
    `loyalty_account_id` BIGINT COMMENT 'Loyalty account ID of the existing member who referred this consumer to the program. Used for referral reward attribution, viral growth tracking, and network-effect analysis in consumer retention programs.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program definition under which this account was created (e.g., brand-specific rewards program, coalition program).',
    `loyalty_tier_id` BIGINT COMMENT 'The loyalty tier id of the loyalty account record',
    `primary_loyalty_program_id` BIGINT COMMENT 'The primary loyalty program id of the loyalty account record',
    `retail_store_id` BIGINT COMMENT 'Reference to the consumers preferred or most frequently visited retail store location. Used for store-level loyalty analytics, On Shelf Availability (OSA) correlation, and localized promotion targeting.',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer profile who owns this loyalty account. Links to the consumer master record in the Consumer domain.',
    `account_number` STRING COMMENT 'Externally visible, human-readable membership number assigned to the consumer at enrollment. Printed on loyalty cards, referenced in consumer communications, and used for in-store identification. Serves as the BUSINESS_IDENTIFIER for this MASTER_AGREEMENT entity.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle state of the loyalty account. active = fully operational; suspended = temporarily restricted (e.g., fraud review); closed = permanently deactivated; pending = enrollment not yet confirmed; frozen = points locked pending investigation. Serves as the LIFECYCLE_STATUS for this MASTER_AGREEMENT entity.. Valid values are `active|suspended|closed|pending|frozen`',
    `account_type` STRING COMMENT 'Classification of the loyalty account indicating whether it belongs to an individual consumer, a household unit, a small business buyer, or a coalition partner program. Drives eligibility rules and benefit structures.. Valid values are `individual|household|business|coalition`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the loyalty account record',
    `cltv_segment` STRING COMMENT 'Consumers current Customer Lifetime Value (CLTV) segment classification derived from purchase history, points activity, and predictive modeling. Used for personalized promotion targeting, retention investment prioritization, and Trade Promotion Optimization (TPO). Not a calculated metric — this is a segment label assigned by the analytics/ML pipeline.. Valid values are `high_value|mid_value|low_value|at_risk|lapsed`',
    `loyalty_account_code` STRING COMMENT 'The loyalty account code of the loyalty account record',
    `communication_preference` STRING COMMENT 'Consumers preferred channel for receiving loyalty program communications (e.g., points balance updates, tier change notifications, promotional offers). Drives outbound communication channel selection in CRM and marketing automation.. Valid values are `email|sms|push|post|none`',
    `consent_data_sharing` BOOLEAN COMMENT 'Indicates whether the consumer has consented to sharing their loyalty data with third-party partners (e.g., retail partners, coalition program members). Required for GDPR and CCPA compliance. True = consented; False = not consented.',
    `consent_marketing` BOOLEAN COMMENT 'Indicates whether the consumer has provided explicit opt-in consent to receive marketing communications related to the loyalty program. Required for GDPR Article 6 lawful basis and CCPA compliance. True = consented; False = not consented.',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp at which the consumers most recent consent preferences were captured or last updated. Required for GDPR audit trail demonstrating when consent was obtained. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code representing the country in which the loyalty account is registered. Determines applicable regulatory framework (GDPR, CCPA, etc.), program rules, and currency.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp at which this loyalty account record was first created in the system. Serves as the RECORD_AUDIT_CREATED field for this MASTER_AGREEMENT entity. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'The currency code of the loyalty account record',
    `loyalty_account_description` STRING COMMENT 'The loyalty account description of the loyalty account record',
    `effective_from` DATE COMMENT 'The effective from of the loyalty account record',
    `effective_until` DATE COMMENT 'The effective until of the loyalty account record',
    `enrollment_channel` STRING COMMENT 'Channel through which the consumer enrolled in the loyalty program (e.g., web, mobile app, in-store, call center, partner, Direct-to-Consumer (DTC) platform). Used for channel attribution and acquisition cost analysis.. Valid values are `web|mobile_app|in_store|call_center|partner|dtc`',
    `enrollment_date` DATE COMMENT 'Calendar date on which the consumer formally enrolled in the loyalty program. Used to calculate membership tenure, anniversary rewards, and cohort-based retention analytics. Serves as EFFECTIVE_FROM for this MASTER_AGREEMENT entity.',
    `enrollment_source_code` STRING COMMENT 'Campaign or promotion source code associated with the consumers enrollment event (e.g., a Trade Promotion Management (TPM) campaign code, QR code identifier, or referral code). Used for acquisition attribution and Trade Promotion Optimization (TPO) ROI analysis.',
    `expiry_date` DATE COMMENT 'Date on which the loyalty account is scheduled to expire or become inactive if no qualifying activity occurs. Nullable for open-ended programs. Serves as EFFECTIVE_UNTIL for this MASTER_AGREEMENT entity. Used for points liability forecasting and consumer re-engagement campaigns.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this loyalty account has been flagged for suspected fraudulent activity (e.g., points manipulation, account takeover, synthetic identity). True = flagged for review; False = no fraud concern. Triggers account suspension workflow.',
    `fraud_review_date` DATE COMMENT 'Date on which the most recent fraud review was conducted or scheduled for this account. Nullable if no fraud review has occurred. Used by the fraud operations team to track investigation timelines.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code (optionally with ISO 3166-1 country subtag) representing the consumers preferred language for loyalty program communications (e.g., en, fr, es-MX). Supports multilingual global loyalty programs.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_activity_date` DATE COMMENT 'Date of the most recent qualifying activity (purchase, redemption, or engagement event) on this loyalty account. Used to determine account dormancy, trigger re-engagement campaigns, and apply activity-based points expiry policies.',
    `last_earn_date` DATE COMMENT 'Date of the most recent points earn event on this account. Used to assess earn recency for RFM (Recency, Frequency, Monetary) segmentation and to trigger earn-reminder communications.',
    `last_redemption_date` DATE COMMENT 'Date of the most recent points redemption event on this account. Used to assess redemption engagement, identify high-value redeemers, and support personalized redemption offer targeting.',
    `lifetime_points_earned` DECIMAL(18,2) COMMENT 'Cumulative total of all points ever earned on this account since enrollment, including base earn, bonus earn, and promotional earn events. Never decremented by redemptions or expirations. Used for Customer Lifetime Value (CLTV) calculation and tier qualification history.',
    `lifetime_points_expired` DECIMAL(18,2) COMMENT 'Cumulative total of all points that have expired on this account due to inactivity or program rules. Used for points liability release reporting in finance and consumer re-engagement analysis.',
    `lifetime_points_redeemed` DECIMAL(18,2) COMMENT 'Cumulative total of all points ever redeemed on this account since enrollment. Used for redemption rate analysis, points liability reconciliation, and CLTV modeling.',
    `linked_card_token` STRING COMMENT 'Tokenized reference to the consumers linked payment card used for automatic points earn at point-of-sale (POS). Stored as a PCI-compliant token — never the raw card number. Enables card-linked offer (CLO) programs and automatic earn without physical loyalty card presentation.',
    `loyalty_account_status` STRING COMMENT 'The loyalty account status of the loyalty account record',
    `membership_tier` STRING COMMENT 'Current loyalty tier of the account reflecting the consumers engagement and spend level (e.g., Standard, Silver, Gold, Platinum, Elite). Determines benefit multipliers, exclusive offers, and service levels. Reviewed periodically against tier_qualification_spend.. Valid values are `standard|silver|gold|platinum|elite`',
    `loyalty_account_name` STRING COMMENT 'The loyalty account name of the loyalty account record',
    `notes` STRING COMMENT 'The notes of the loyalty account record',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) survey response from this consumer (0–10 scale). Used to segment consumers into Promoters (9–10), Passives (7–8), and Detractors (0–6) for loyalty program health monitoring and consumer engagement strategy.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS survey response was captured for this consumer. Used to assess NPS data freshness and schedule next survey cadence.',
    `opt_out_date` DATE COMMENT 'Date on which the consumer formally opted out of the loyalty program or withdrew consent for data processing. Nullable if the consumer has not opted out. Required for GDPR right-to-erasure and CCPA opt-out compliance tracking.',
    `points_balance` DECIMAL(18,2) COMMENT 'Current redeemable points balance on the loyalty account as of the last transaction processing. Represents the net of all earned, redeemed, adjusted, and expired points. Used for consumer-facing balance display and finance points liability reporting.',
    `points_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the monetary currency in which tier_qualification_spend and redemption values are denominated (e.g., USD, EUR, GBP). Supports multi-currency global loyalty programs.. Valid values are `^[A-Z]{3}$`',
    `points_expiry_policy` STRING COMMENT 'Policy governing when unredeemed points on this account expire. Options include rolling 12-month inactivity, annual calendar expiry, never-expire, program-end expiry, or activity-based reset. Drives points liability forecasting and consumer communication triggers.. Valid values are `rolling_12_months|annual|never|program_end|activity_based`',
    `points_lifetime_earned` STRING COMMENT 'The points lifetime earned of the loyalty account record',
    `preferred_redemption_type` STRING COMMENT 'Consumers stated or inferred preferred method of redeeming loyalty points. Used for personalized redemption offer targeting and program design optimization. [ENUM-REF-CANDIDATE: discount|free_product|gift_card|charity|cashback|experience|travel|merchandise — promote to reference product if additional types are needed]. Valid values are `discount|free_product|gift_card|charity|cashback|experience`',
    `previous_tier` STRING COMMENT 'The membership tier held by the consumer immediately before the most recent tier change. Used for tier transition analysis, win-back campaigns, and understanding tier migration patterns.. Valid values are `standard|silver|gold|platinum|elite`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the loyalty account record',
    `record_source_system` STRING COMMENT 'The record source system of the loyalty account record',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this loyalty account record originated (e.g., Salesforce Consumer Goods Cloud (SFCGC), SAP S/4HANA). Used for data lineage tracking and Silver Layer reconciliation in the Databricks Lakehouse.. Valid values are `SFCGC|SAP_S4|ORACLE_ERP|CUSTOM_CRM|TRADEEDGE`',
    `tier_effective_date` DATE COMMENT 'Date on which the current membership tier became effective. Used to calculate tier tenure, assess tier stability, and trigger tier-anniversary benefits.',
    `tier_qualification_spend` DECIMAL(18,2) COMMENT 'Cumulative qualifying purchase spend (in program currency) accumulated within the current tier review period. Compared against tier thresholds to determine tier upgrade, maintenance, or downgrade at the next tier review date.',
    `tier_review_date` DATE COMMENT 'Scheduled date on which the consumers membership tier will be evaluated against tier_qualification_spend thresholds for potential upgrade, maintenance, or downgrade. Drives proactive consumer engagement campaigns before review.',
    `uom` STRING COMMENT 'The uom of the loyalty account record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp at which this loyalty account record was most recently modified. Used for incremental data pipeline processing, change data capture (CDC), and audit trail maintenance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_loyalty_account PRIMARY KEY(`loyalty_account_id`)
) COMMENT 'Loyalty program membership account and transaction history for a consumer enrolled in a CPG brand loyalty or rewards program. Captures account master (program name, membership tier, enrollment date, points balance, lifetime points earned/redeemed, tier qualification spend, tier review date, status) and individual points movement events (earn, redeem, adjust, expire — with points amount, triggering event, associated order reference, balance snapshot, processing status, timestamp). Supports CLTV calculation, personalized promotions, consumer retention programs, and points liability reporting required by finance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` (
    `loyalty_transaction_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for each loyalty points movement event. Serves as the primary key for the loyalty_transaction data product and enables precise audit trail reconciliation of all points currency activity.',
    `employee_id` BIGINT COMMENT 'The user ID or name of the agent, supervisor, or automated system that authorized a manual adjustment or high-value redemption transaction. Supports segregation-of-duties controls and SOX audit requirements.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for accounting loyalty point expense; loyalty_transaction must post expense to a GL account for financial statements.',
    `loyalty_account_id` BIGINT COMMENT 'Reference to the loyalty program account against which this points movement is recorded. Links the transaction to the members running balance and tier status.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the specific loyalty program under which this transaction was recorded. Supports enterprises operating multiple loyalty programs (e.g., brand-specific, retailer co-branded, DTC) with separate earn/redeem rules.',
    `loyalty_tier_id` BIGINT COMMENT 'Reference to the loyalty program tier (e.g., Silver, Gold, Platinum) that was active on the consumers account at the time of this transaction. Tier determines earn rate multipliers and redemption eligibility.',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order or DTC purchase that triggered an earn or redemption event. Null for non-purchase-triggered transactions such as birthday bonuses, referral awards, or manual adjustments.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the Trade Promotion Management (TPM) promotion or loyalty campaign that triggered a bonus points award. Null when the transaction is not promotion-driven.',
    `reversal_reference_loyalty_transaction_id` BIGINT COMMENT 'For reversal-type transactions, the loyalty_transaction_id of the original transaction being reversed. Enables bidirectional audit trail linking between original and reversal entries for points reconciliation.',
    `shopper_id` BIGINT COMMENT 'Reference to the end consumer or shopper who owns the loyalty account. Supports GDPR/CCPA data subject requests and consumer-level analytics across the CRM platform.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU (Stock Keeping Unit) purchased or redeemed in this transaction. Populated for purchase-triggered earn events and product-reward redemptions. Enables product-level loyalty attribution and NPD performance analysis.',
    `adjustment_notes` STRING COMMENT 'Free-text narrative entered by a customer service agent or system process explaining the rationale for a manual points adjustment or reversal. Supports audit review and consumer dispute resolution.',
    `adjustment_reason_code` STRING COMMENT 'Standardized code identifying the business reason for manual point adjustments or reversals (e.g., GOODWILL, DATA_CORRECTION, FRAUD_REVERSAL, SYSTEM_ERROR, PROMOTION_CORRECTION). Populated only for adjust and reversal transaction types. [ENUM-REF-CANDIDATE: GOODWILL|DATA_CORRECTION|FRAUD_REVERSAL|SYSTEM_ERROR|PROMOTION_CORRECTION|COMPLAINT_RESOLUTION — promote to reference product]',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the loyalty transaction record',
    `bonus_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base earn rate for bonus transactions (e.g., 2.0 for double points, 1.5 for 50% bonus). Null for non-bonus transactions. Used to decompose total points awarded into base and bonus components for TPM ROI analysis.',
    `channel` STRING COMMENT 'The consumer engagement channel through which the triggering event occurred: ecommerce (third-party online), mobile_app (brand app), retail_store (physical POS), dtc_website (Direct-to-Consumer website), call_centre (agent-assisted), or kiosk (in-store self-service). Supports omnichannel loyalty analytics and channel attribution reporting.. Valid values are `ecommerce|mobile_app|retail_store|dtc_website|call_centre|kiosk`',
    `loyalty_transaction_code` STRING COMMENT 'The loyalty transaction code of the loyalty transaction record',
    `consent_verified` BOOLEAN COMMENT 'Indicates whether the consumers active consent for loyalty program participation and data processing was verified at the time of this transaction. Supports GDPR Article 7 and CCPA consent audit requirements.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the market in which this loyalty transaction occurred (e.g., USA, GBR, DEU). Supports multi-market loyalty program reporting, regulatory compliance (GDPR for EU markets), and geographic performance analytics.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this loyalty transaction record was first created in the source system. Serves as the system audit creation timestamp for data lineage, reconciliation, and SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary_value field (e.g., USD, EUR, GBP). Supports multi-currency loyalty programs operating across international markets.. Valid values are `^[A-Z]{3}$`',
    `data_retention_flag` BOOLEAN COMMENT 'Indicates whether this transaction record is subject to a data retention hold, preventing deletion or anonymization beyond the standard retention period. Set to True for records under legal hold, active fraud investigation, or regulatory audit. Supports GDPR right-to-erasure compliance.',
    `loyalty_transaction_description` STRING COMMENT 'The loyalty transaction description of the loyalty transaction record',
    `earn_rate` DECIMAL(18,2) COMMENT 'The points-per-currency-unit rate applied to calculate the points_amount for earn transactions (e.g., 1.5 points per USD spent). Captures the rate in effect at the time of the transaction for historical accuracy and program performance analysis.',
    `effective_from` DATE COMMENT 'The effective from of the loyalty transaction record',
    `effective_until` DATE COMMENT 'The effective until of the loyalty transaction record',
    `expiry_date` DATE COMMENT 'The expiry date of the loyalty transaction record',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this transaction has been flagged by the fraud detection system as potentially fraudulent or suspicious. Flagged transactions are held for review before points are posted. Supports loyalty program integrity and financial controls.',
    `fraud_review_status` STRING COMMENT 'The outcome of the fraud review process for transactions flagged by the fraud detection system: not_reviewed (default), under_review (investigation in progress), cleared (confirmed legitimate), or confirmed_fraud (fraudulent transaction confirmed and reversed).. Valid values are `not_reviewed|under_review|cleared|confirmed_fraud`',
    `is_bonus_transaction` BOOLEAN COMMENT 'Indicates whether this earn transaction includes a bonus points multiplier applied on top of the base earn rate (e.g., double-points promotion, birthday bonus, new member bonus). Enables separation of base earn from promotional bonus in program cost analysis.',
    `loyalty_transaction_status` STRING COMMENT 'The loyalty transaction status of the loyalty transaction record',
    `monetary_value` DECIMAL(18,2) COMMENT 'The monetary equivalent value of the points moved in this transaction, expressed in the programs base currency. Used for points liability valuation on the balance sheet and for calculating the cost of loyalty rewards in COGS reporting.',
    `loyalty_transaction_name` STRING COMMENT 'The loyalty transaction name of the loyalty transaction record',
    `notes` STRING COMMENT 'The notes of the loyalty transaction record',
    `points_amount` DECIMAL(18,2) COMMENT 'The absolute number of loyalty points moved in this transaction. Always stored as a positive value regardless of direction; the transaction_type field determines whether points are added or subtracted from the account balance. Supports fractional points for precision in tiered earn-rate calculations.',
    `points_balance_after` DECIMAL(18,2) COMMENT 'Snapshot of the loyalty accounts total available points balance immediately after this transaction was applied. Together with points_balance_before, provides the complete before/after audit trail for each points movement event.',
    `points_balance_before` DECIMAL(18,2) COMMENT 'Snapshot of the loyalty accounts total available points balance immediately before this transaction was applied. Critical for audit trail completeness and points liability reconciliation required by finance.',
    `points_direction` STRING COMMENT 'Indicates whether the points_amount increases (credit) or decreases (debit) the loyalty account balance. Enables double-entry-style reconciliation of the points ledger for finance liability reporting.. Valid values are `credit|debit`',
    `points_expiry_date` DATE COMMENT 'The date on which the points awarded in this earn transaction are scheduled to expire per the loyalty programs currency expiration policy. Null for non-earn transactions. Drives the points liability aging schedule reported to finance.',
    `points_liability_flag` BOOLEAN COMMENT 'Indicates whether this transaction contributes to the outstanding points liability on the companys balance sheet (True for unspent earned points, False for redeemed or expired points). Supports finances points liability reserve calculation under GAAP/IFRS.',
    `processing_timestamp` TIMESTAMP COMMENT 'The date and time at which the loyalty transaction was processed and posted to the account balance by the loyalty engine. May differ from transaction_timestamp due to batch processing windows or pending verification holds.',
    `program_year` STRING COMMENT 'The fiscal or calendar year of the loyalty program in which this transaction occurred. Used for annual points balance resets, year-over-year program performance reporting, and points expiration policy enforcement.',
    `qualifying_spend_amount` DECIMAL(18,2) COMMENT 'The net purchase amount (after discounts, excluding taxes) on the triggering order that qualified for points earning. Used to verify earn rate calculations and supports COGS and loyalty cost-per-transaction reporting.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the loyalty transaction record',
    `record_source_system` STRING COMMENT 'The record source system of the loyalty transaction record',
    `redemption_value` DECIMAL(18,2) COMMENT 'The monetary discount or reward value applied to the consumers order when points are redeemed. Populated only for redeem-type transactions. Used to calculate the effective discount rate and redemption liability release in financial reporting.',
    `reference_number` STRING COMMENT 'The reference number of the loyalty transaction record',
    `source_system_code` STRING COMMENT 'The source system code of the loyalty transaction record',
    `source_transaction_ref` STRING COMMENT 'The native transaction identifier from the originating source system (e.g., Salesforce record ID, SAP document number, POS receipt number). Enables cross-system reconciliation and traceability back to the system of record.',
    `transaction_date` TIMESTAMP COMMENT 'The transaction date of the loyalty transaction record',
    `transaction_number` STRING COMMENT 'Human-readable, externally referenceable business identifier for the loyalty transaction, formatted as LT-{YYYY}-{sequence}. Used in consumer-facing communications, call-centre lookups, and points dispute resolution.. Valid values are `^LT-[0-9]{4}-[0-9]{8}$`',
    `transaction_status` STRING COMMENT 'Current workflow state of the loyalty transaction reflecting its processing lifecycle: pending (awaiting confirmation), processed (successfully posted to account), reversed (cancelled after posting), failed (processing error), or cancelled (voided before posting).. Valid values are `pending|processed|reversed|failed|cancelled`',
    `transaction_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone offset) at which the loyalty points movement event occurred in the real world — i.e., when the triggering business event (purchase, referral, etc.) was confirmed and points were posted. This is the principal business event timestamp, distinct from system audit timestamps.',
    `transaction_type` STRING COMMENT 'Categorical discriminator identifying the nature of the points movement: earn (points awarded), redeem (points consumed), adjust (manual correction), expire (points lapsed per program rules), transfer (inter-account movement), or reversal (cancellation of a prior transaction). [ENUM-REF-CANDIDATE: earn|redeem|adjust|expire|transfer|reversal — promote to reference product]. Valid values are `earn|redeem|adjust|expire|transfer|reversal`',
    `trigger_event` STRING COMMENT 'The specific business event that initiated this points movement, such as purchase, referral, product_review, birthday_bonus, promotion_bonus, account_registration, social_share, or survey_completion. Drives attribution analysis and program ROI reporting. [ENUM-REF-CANDIDATE: purchase|referral|product_review|birthday_bonus|promotion_bonus|account_registration|social_share|survey_completion — promote to reference product]',
    `uom` STRING COMMENT 'The uom of the loyalty transaction record',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this loyalty transaction record was last modified in the source system. Tracks reversals, status changes, and manual adjustments for audit and data quality monitoring.',
    CONSTRAINT pk_loyalty_transaction PRIMARY KEY(`loyalty_transaction_id`)
) COMMENT 'Individual points movement event within a loyalty account — earn, redeem, adjust, or expire. Records points amount, triggering event (purchase, referral, review, birthday bonus, promotion), associated order reference, balance snapshot (before/after), processing status, and transaction timestamp. Provides the complete audit trail for loyalty currency reconciliation and supports points liability reporting required by finance.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique surrogate identifier for each consumer segment definition record in the Consumer Goods lakehouse silver layer. Serves as the primary key for all segment definition and membership records.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Report: Segment Ownership Report requires linking each consumer segment to its owning brand for brand‑level performance analysis.',
    `parent_segment_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent segment when this segment is a sub-segment or child in a hierarchical segmentation structure (e.g., High-Value Loyalists as a child of Loyalty Program Members). Null for top-level segments.',
    `activation_channel` STRING COMMENT 'The primary marketing activation channel for which this segment is designed (e.g., email campaigns, SMS, push notifications, paid media audiences, in-store promotions). Drives channel-specific audience export configurations in Salesforce Consumer Goods Cloud and CRM platforms.. Valid values are `email|sms|push_notification|paid_media|in_store|all`',
    `age_range_max` STRING COMMENT 'For demographic segments, the maximum consumer age (in years) defining the upper bound for segment inclusion. Used alongside age_range_min to define age-banded demographic segments (e.g., Millennials: 28–43).',
    `age_range_min` STRING COMMENT 'For demographic segments, the minimum consumer age (in years) required for segment inclusion. Used in age-gated product targeting (e.g., health supplements, alcohol-adjacent personal care) and regulatory compliance with COPPA for under-13 restrictions.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the segment record',
    `assignment_method` STRING COMMENT 'Method by which consumers are assigned to this segment. rule_based uses deterministic business rules (e.g., purchase frequency thresholds); ml_model uses a trained machine learning classifier; manual indicates analyst-driven assignment; hybrid combines rule-based and ML approaches.. Valid values are `rule_based|ml_model|manual|hybrid`',
    `channel_scope` STRING COMMENT 'The distribution or engagement channel(s) for which this segment is applicable. dtc (Direct to Consumer) segments target consumers via owned digital channels; retail targets in-store shoppers; ecommerce targets online platform shoppers; omnichannel applies across all channels.. Valid values are `dtc|retail|ecommerce|wholesale|omnichannel`',
    `cltv_max_value` DECIMAL(18,2) COMMENT 'For CLTV (Customer Lifetime Value)-based segments, the maximum predicted CLTV value defining the upper bound of this segment tier. Used to create banded CLTV segments (e.g., mid-value tier: CLTV between $500 and $2000). Null if no upper bound applies.',
    `cltv_min_value` DECIMAL(18,2) COMMENT 'For CLTV (Customer Lifetime Value)-based segments, the minimum predicted CLTV score or monetary value required for a consumer to qualify for segment membership. Enables tiered loyalty and high-value consumer targeting strategies. Null for non-CLTV segment types.',
    `segment_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the segment, used in CRM campaign targeting, trade promotion management (TPM) systems, and Salesforce Consumer Goods Cloud audience configurations. Unique per segment version.. Valid values are `^[A-Z0-9_]{3,30}$`',
    `consent_basis` STRING COMMENT 'The legal basis under GDPR Article 6 or CCPA for processing consumer data within this segment. consent requires explicit opt-in; legitimate_interest applies where the business has a justified interest; contract applies for contractual necessity; not_required for non-personal aggregate segments.. Valid values are `consent|legitimate_interest|contract|legal_obligation|not_required`',
    `consent_required` BOOLEAN COMMENT 'Indicates whether explicit consumer consent is required before a consumer can be assigned to or activated within this segment. True for segments used in direct marketing, personalization, or profiling activities subject to GDPR Article 6 or CCPA opt-in requirements.',
    `created_date` DATE COMMENT 'The created date of the segment record',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this segment definition record was first created in the Consumer Goods lakehouse silver layer. Serves as the audit trail creation marker for data governance and lineage tracking.',
    `criteria_definition` STRING COMMENT 'The criteria definition of the segment record',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to monetary thresholds defined in this segment (e.g., rfm_monetary_min, cltv_min_value). Ensures consistent monetary comparisons across geographies and DTC channels.. Valid values are `^[A-Z]{3}$`',
    `definition_logic` STRING COMMENT 'The definition logic of the segment record',
    `segment_description` STRING COMMENT 'Detailed narrative description of the segments defining characteristics, inclusion criteria, and intended business use (e.g., targeting strategy, personalization approach, or trade promotion eligibility). Authored by the owning brand or business unit.',
    `effective_end_date` DATE COMMENT 'The date on which this segment definition expires and is no longer eligible for active targeting. Null indicates an open-ended segment with no planned expiry. Used for time-variant segment membership tracking and historical analysis.',
    `effective_from` DATE COMMENT 'The effective from of the segment record',
    `effective_start_date` DATE COMMENT 'The date from which this segment definition becomes valid and eligible for use in CRM targeting, personalization, and trade promotion activation. Supports time-variant segment tracking and bi-temporal data modeling in the silver layer.',
    `effective_until` DATE COMMENT 'The effective until of the segment record',
    `geographic_scope` STRING COMMENT 'ISO 3166-1 alpha-3 country code(s) or region identifiers defining the geographic boundary of this segment (e.g., USA, GBR, DEU). Supports multi-country CPG brand activation and ensures GDPR/CCPA-compliant targeting within applicable jurisdictions.',
    `is_active` BOOLEAN COMMENT 'The is active of the segment record',
    `is_suppression_segment` BOOLEAN COMMENT 'Indicates whether this segment is a suppression list used to exclude consumers from campaigns (e.g., opted-out consumers, recent purchasers, regulatory exclusions). True means consumers in this segment are excluded from targeted marketing activations.',
    `last_refresh_timestamp` TIMESTAMP COMMENT 'The date and time when the segment membership was last recalculated and updated. Used to assess data freshness for CRM targeting and to trigger refresh workflows when the segment is stale relative to its defined refresh frequency.',
    `loyalty_tier_scope` STRING COMMENT 'The loyalty program tier(s) targeted by this segment. Enables differentiated engagement strategies for loyalty program members (e.g., exclusive offers for Platinum tier, win-back campaigns for Bronze tier). all indicates the segment applies across all loyalty tiers.. Valid values are `bronze|silver|gold|platinum|all`',
    `min_confidence_score` DECIMAL(18,2) COMMENT 'The minimum ML model confidence score (0.0000 to 1.0000) required for a consumer to be assigned to this segment when using ML-based assignment. Consumers with scores below this threshold are excluded. Null for rule-based or manual segments.',
    `ml_model_code` STRING COMMENT 'Identifier of the machine learning model used to generate or score this segment, when assignment_method is ml_model or hybrid. Enables traceability to the model registry for audit, retraining, and explainability purposes. Null for rule_based or manual segments.',
    `model_version` STRING COMMENT 'Version identifier of the segmentation model or rule set that produced this segment definition (e.g., v1.0, v2.3). Enables traceability of segment membership changes across model iterations and supports A/B testing of segmentation approaches.. Valid values are `^vd+.d+(.d+)?$`',
    `segment_name` STRING COMMENT 'Human-readable business name of the consumer segment (e.g., High-Value Loyalists, Lapsed Shoppers, Health-Conscious Millennials). Used in marketing activation, CRM dashboards, and trade promotion targeting.',
    `notes` STRING COMMENT 'The notes of the segment record',
    `nps_score_max` STRING COMMENT 'For NPS (Net Promoter Score)-based segments, the maximum NPS score (0–10 scale) defining the upper bound for segment inclusion. Used in conjunction with nps_score_min to define NPS-banded segments (e.g., detractors: 0–6).',
    `nps_score_min` STRING COMMENT 'For NPS (Net Promoter Score)-based segments, the minimum NPS score (0–10 scale) required for segment inclusion. Enables targeting of promoters (9–10), passives (7–8), or detractors (0–6) for tailored consumer engagement programs.',
    `owning_business_unit` STRING COMMENT 'The business unit (BU) within Consumer Goods responsible for this segments definition, governance, and activation (e.g., Personal Care, Home Care, Health & Wellness). Used for segment ownership reporting and cross-BU deduplication governance.',
    `personalization_eligible` BOOLEAN COMMENT 'Indicates whether consumers in this segment are eligible for personalized content, product recommendations, or pricing in DTC (Direct to Consumer) and e-commerce channels. Requires valid consent_basis when consent_required is True.',
    `priority` STRING COMMENT 'Numeric priority rank used to resolve conflicts when a consumer qualifies for multiple overlapping segments. Lower values indicate higher priority. Used by CRM and personalization engines to determine which segments rules take precedence for offer assignment.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the segment record',
    `record_source_system` STRING COMMENT 'The record source system of the segment record',
    `refresh_frequency` STRING COMMENT 'How frequently the segment membership is recalculated and updated. Determines the cadence at which consumer assignments are re-evaluated against the segments rules or ML model. Impacts CRM campaign freshness and personalization accuracy.. Valid values are `daily|weekly|monthly|quarterly|on_demand`',
    `rfm_frequency_min` STRING COMMENT 'For RFM (Recency, Frequency, Monetary)-based segments, the minimum number of purchase transactions required within the recency window for a consumer to qualify for the frequency criterion. Null for non-RFM segment types.',
    `rfm_monetary_min` DECIMAL(18,2) COMMENT 'For RFM (Recency, Frequency, Monetary)-based segments, the minimum cumulative spend amount (in the segments currency) required within the recency window for a consumer to qualify for the monetary criterion. Null for non-RFM segment types.',
    `rfm_recency_days` STRING COMMENT 'For RFM (Recency, Frequency, Monetary)-based segments, the number of days used to define the recency window (e.g., last 90 days). Consumers with a purchase within this window qualify for the recency criterion. Null for non-RFM segment types.',
    `segment_status` STRING COMMENT 'Current lifecycle state of the segment definition. active segments are available for CRM targeting and trade promotion activation; draft segments are under construction; archived segments are retained for historical analysis but no longer used in campaigns.. Valid values are `active|inactive|draft|archived|under_review`',
    `segment_type` STRING COMMENT 'Classification of the segmentation methodology applied to define this segment. Behavioral segments are based on purchase patterns; demographic on age/gender/income; psychographic on lifestyle/values; RFM (Recency, Frequency, Monetary) on transactional scoring; CLTV (Customer Lifetime Value)-based on predicted long-term value; geographic on location.. Valid values are `behavioral|demographic|psychographic|rfm|cltv_based|geographic`',
    `source_segment_code` STRING COMMENT 'The native identifier of this segment in the originating operational system (e.g., Salesforce Consumer Goods Cloud segment ID, Nielsen IQ panel group code). Enables cross-system reconciliation and data lineage tracing back to the system of record.',
    `source_system_code` STRING COMMENT 'The source system code of the segment record',
    `target_audience_size` BIGINT COMMENT 'The estimated or actual count of unique consumers assigned to this segment at the time of last refresh. Used for campaign planning, media budget allocation, and share of voice (SOV) estimation. Not a real-time count — reflects the last segment refresh cycle.',
    `trade_promotion_eligible` BOOLEAN COMMENT 'Indicates whether this consumer segment is eligible for trade promotion targeting within the Trade Promotion Management (TPM) system. True enables the segment to be used in TPM/TPO campaign audience configurations in Salesforce Consumer Goods Cloud.',
    `uom` STRING COMMENT 'The uom of the segment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this segment definition record was most recently modified. Used for incremental data pipeline processing, change data capture (CDC), and audit trail compliance in the Databricks lakehouse silver layer.',
    `version` STRING COMMENT 'Integer version number of this segment definition record, incremented each time the segments criteria, model, or metadata is materially updated. Supports bi-temporal tracking and enables comparison of segment membership across definition versions.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Consumer segmentation classification and membership records used for targeting, personalization, and marketing activation. Stores segment definition (name, code, model version, type — behavioral/demographic/psychographic/RFM/CLTV-based, description, effective date range, owning brand/BU) and individual membership assignments (shopper reference, assignment date, expiry date, assignment method — rule-based/ML/manual, confidence score, segment version). Enables time-variant segment membership tracking, CRM-driven personalization, and trade promotion targeting across CPG brands.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` (
    `segment_membership_id` BIGINT COMMENT 'Unique surrogate identifier for each segment membership association record in the consumer domain. Primary key for the segment_membership data product.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign or trade promotion for which this segment membership was created or activated. Links segment membership to specific campaign execution context.',
    `consent_record_id` BIGINT COMMENT 'The unique identifier of the consent record that authorizes the use of this consumers data for segment assignment and targeting. Provides an auditable link to the consent management system for GDPR and CCPA compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Marketing segment campaigns are budgeted to cost centers; linking enables expense tracking per segment.',
    `employee_id` BIGINT COMMENT 'The identifier of the business user or analyst who manually assigned or overrode the segment membership. Populated when assignment_method is manual. Supports audit trail and accountability for manual interventions.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program under which this segment membership was generated or is applicable. Supports loyalty-driven segmentation and personalized reward targeting.',
    `segment_id` BIGINT COMMENT 'Reference to the consumer segment definition to which this consumer is assigned. Identifies the target segment for personalization, campaign targeting, and analytics.',
    `shopper_id` BIGINT COMMENT 'Reference to the individual shopper, household, or loyalty program member who is assigned to this segment. Links to the consumer master record in the SSOT consumer profile.',
    `activation_count` STRING COMMENT 'The number of times this segment membership has been activated or used in campaign targeting or personalization executions. Supports frequency capping and engagement fatigue management.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the segment membership record',
    `assigned_date` DATE COMMENT 'The assigned date of the segment membership record',
    `assignment_date` DATE COMMENT 'The calendar date on which the consumer was assigned or enrolled into this segment. Marks the start of the membership period for time-variant tracking.',
    `assignment_method` STRING COMMENT 'The mechanism by which the consumer was assigned to this segment. Rule-based uses deterministic business logic; ml_model uses a trained machine learning classifier; manual indicates analyst-driven override; propensity_score uses a scored threshold; lookalike uses similarity modeling.. Valid values are `rule_based|ml_model|manual|propensity_score|lookalike`',
    `brand_affinity_code` STRING COMMENT 'Code identifying the specific brand or brand portfolio for which this segment membership is relevant. Enables brand-level personalization and targeted engagement within a multi-brand consumer goods portfolio.',
    `channel` STRING COMMENT 'The commerce or engagement channel context in which this segment membership is applicable. Direct-to-Consumer (DTC), e-commerce, retail, wholesale, loyalty program, or social commerce. Supports channel-specific personalization and campaign targeting.. Valid values are `dtc|ecommerce|retail|wholesale|loyalty|social`',
    `cltv_tier` STRING COMMENT 'The Customer Lifetime Value (CLTV) tier of the consumer at the time of segment assignment. Captures the consumers value classification to support premium targeting and differentiated engagement strategies.. Valid values are `platinum|gold|silver|bronze|unclassified`',
    `segment_membership_code` STRING COMMENT 'The segment membership code of the segment membership record',
    `confidence_score` DECIMAL(18,2) COMMENT 'A numeric probability or confidence value (0.0000 to 1.0000) indicating the certainty of the segment assignment, particularly relevant for ML model and propensity-score assignment methods. Higher values indicate stronger segment fit.',
    `consent_status` STRING COMMENT 'The consent status of the consumer for use of their data in this segment assignment and associated targeting activities. Granted indicates valid consent; withdrawn indicates consent has been revoked and the membership should not be used for targeting. Mandatory for GDPR and CCPA compliance.. Valid values are `granted|withdrawn|pending|not_required`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this segment membership record was first created in the data platform. Supports audit trail, data lineage, and GDPR data retention management.',
    `currency_code` STRING COMMENT 'The currency code of the segment membership record',
    `data_processing_basis` STRING COMMENT 'The legal basis under which the consumers personal data is processed for this segment assignment. Required for GDPR Article 6 compliance documentation. Consent indicates explicit opt-in; legitimate_interest indicates business interest basis; contract indicates processing necessary for contract performance.. Valid values are `consent|legitimate_interest|contract|legal_obligation`',
    `segment_membership_description` STRING COMMENT 'The segment membership description of the segment membership record',
    `effective_from` DATE COMMENT 'The effective from of the segment membership record',
    `effective_from_timestamp` TIMESTAMP COMMENT 'The precise date and time from which this segment membership record is considered effective. Supports bi-temporal data modeling and time-variant segment tracking at sub-day precision for real-time personalization.',
    `effective_until` DATE COMMENT 'The effective until of the segment membership record',
    `effective_until_timestamp` TIMESTAMP COMMENT 'The precise date and time until which this segment membership record is considered effective. Null indicates the record is currently active with no defined end. Supports bi-temporal data modeling and SCD Type 2 history tracking.',
    `evaluation_frequency` STRING COMMENT 'The cadence at which this segment membership is re-evaluated and potentially updated. Real-time indicates event-driven evaluation; daily/weekly/monthly/quarterly indicate batch evaluation schedules.. Valid values are `real_time|daily|weekly|monthly|quarterly`',
    `expiry_date` DATE COMMENT 'The calendar date on which this segment membership expires or becomes invalid. Null indicates an open-ended membership with no defined expiry. Supports time-variant segment tracking for campaign targeting.',
    `geographic_scope` STRING COMMENT 'The ISO 3166-1 alpha-3 country code representing the geographic scope for which this segment membership is applicable. Supports region-specific campaign targeting and regulatory compliance (e.g., GDPR for EU consumers).. Valid values are `^[A-Z]{3}$`',
    `is_active` BOOLEAN COMMENT 'The is active of the segment membership record',
    `is_control_group` BOOLEAN COMMENT 'Flag indicating whether the consumer is assigned to a holdout or control group within this segment for A/B testing or campaign measurement purposes. True indicates the consumer is in the control group and should not receive targeted communications.',
    `is_primary_segment` BOOLEAN COMMENT 'Flag indicating whether this segment is the primary or dominant segment for the consumer when multiple segment memberships exist simultaneously. True indicates this is the primary segment used for default personalization.',
    `last_activation_date` DATE COMMENT 'The most recent date on which this segment membership was used to activate a campaign, promotion, or personalization event. Supports recency analysis and frequency capping in campaign management.',
    `last_evaluated_timestamp` TIMESTAMP COMMENT 'The date and time when the segment membership was last re-evaluated by the segmentation engine or rule processor. Indicates freshness of the assignment and supports refresh scheduling.',
    `membership_score` DECIMAL(18,2) COMMENT 'The membership score of the segment membership record',
    `membership_status` STRING COMMENT 'Current lifecycle status of the segment membership record. Active indicates the consumer is currently a member of the segment; expired indicates the membership period has lapsed; suspended indicates temporary hold.. Valid values are `active|inactive|pending|expired|suspended`',
    `ml_model_code` STRING COMMENT 'Identifier of the ML model instance used to generate this segment assignment when assignment_method is ml_model or propensity_score. Enables model lineage tracking and reproducibility audits.',
    `segment_membership_name` STRING COMMENT 'The segment membership name of the segment membership record',
    `notes` STRING COMMENT 'The notes of the segment membership record',
    `nps_score_at_assignment` STRING COMMENT 'The Net Promoter Score (NPS) of the consumer at the time of segment assignment. Captured as a point-in-time snapshot to contextualize the segmentation decision and support consumer satisfaction analytics.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the consumer has exercised their right to opt out of data-driven segmentation and targeted marketing under CCPA or GDPR. True means the consumer has opted out and this membership must not be used for targeting.',
    `override_reason` STRING COMMENT 'Free-text description of the business justification for a manual segment assignment or override. Populated when assignment_method is manual. Required for audit compliance and governance review.',
    `personalization_eligible` BOOLEAN COMMENT 'Indicates whether the consumer is eligible to receive personalized content, offers, or recommendations based on this segment membership. Combines consent, suppression, and opt-out status into a single actionable flag for downstream personalization engines.',
    `product_category_code` STRING COMMENT 'The product category code for which this segment membership is specifically applicable. Enables category-level targeting (e.g., personal care, household, health) within broader consumer segmentation strategies.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the segment membership record',
    `record_source_system` STRING COMMENT 'The record source system of the segment membership record',
    `review_date` DATE COMMENT 'The scheduled date for periodic review or re-evaluation of this segment membership. Supports governance processes ensuring segment assignments remain accurate and consent remains valid.',
    `rule_set_code` STRING COMMENT 'Identifier of the business rule set applied when assignment_method is rule_based. Enables traceability of which rule definition produced the membership assignment.',
    `score` DECIMAL(18,2) COMMENT 'The score of the segment membership record',
    `segment_membership_status` STRING COMMENT 'The segment membership status of the segment membership record',
    `segment_priority` STRING COMMENT 'Numeric priority rank for this segment membership when a consumer belongs to multiple overlapping segments. Lower values indicate higher priority. Used to resolve conflicts in personalization and campaign targeting logic.',
    `segment_version` STRING COMMENT 'The version identifier of the segment definition that was active at the time of assignment. Enables tracking of membership against evolving segment criteria and supports reproducibility of historical targeting decisions.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `source_record_ref` STRING COMMENT 'The native identifier of this segment membership record in the originating source system. Enables cross-system reconciliation and traceability back to the system of record.',
    `source_system_code` STRING COMMENT 'The source system code of the segment membership record',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this consumer should be suppressed from communications or activations associated with this segment, despite being a member. True means the consumer is suppressed. Used for do-not-contact lists, regulatory holds, or competitive exclusions.',
    `suppression_reason` STRING COMMENT 'The reason code explaining why the consumer is suppressed from segment activations. Populated only when suppression_flag is True. Supports compliance audit trails for GDPR and CCPA suppression requests.. Valid values are `gdpr_request|ccpa_opt_out|do_not_contact|regulatory_hold|deceased|duplicate`',
    `uom` STRING COMMENT 'The uom of the segment membership record',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this segment membership record was last modified. Supports change tracking, incremental data processing, and audit trail requirements.',
    CONSTRAINT pk_segment_membership PRIMARY KEY(`segment_membership_id`)
) COMMENT 'Association record linking an individual shopper/consumer to one or more consumer segments at a point in time. Captures shopper reference, segment reference, assignment date, expiry date, assignment method (rule-based, ML model, manual), confidence score, and segment version. Enables time-variant segment membership tracking for personalization and campaign targeting.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` (
    `preference_id` BIGINT COMMENT 'Unique surrogate identifier for each consumer preference record in the Consumer Goods lakehouse silver layer. Primary key for the preference data product.',
    `consent_record_id` BIGINT COMMENT 'Reference to the formal consent record that authorizes the collection and use of this preference. Links to the consent management system to ensure every preference is backed by a valid, auditable consent event as required by GDPR and CCPA.',
    `household_id` BIGINT COMMENT 'Reference to the household entity this consumer belongs to, enabling household-level preference aggregation for CPG targeting and personalization programs.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program membership associated with this preference record, used to align preferences with loyalty tier benefits and targeted offers.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the CPG brand for which this preference applies. Enables brand-level preference overrides and brand-specific personalization within a multi-brand portfolio.',
    `packaging_profile_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_profile. Business justification: Links consumer packaging preferences to specific packaging profiles to guide sustainable packaging design decisions.',
    `preference_center_id` BIGINT COMMENT 'The preference center id of the preference record',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer profile who owns this preference record. Links to the consumer master in the CRM/DTC system (Salesforce Consumer Goods Cloud).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the preference record',
    `brand_override_flag` BOOLEAN COMMENT 'Indicates whether this preference record has been overridden at the brand level, superseding the consumers global preference. When True, the brand_id field identifies which brand applied the override. Enables brand-specific preference management within a multi-brand CPG portfolio.',
    `brand_override_reason` STRING COMMENT 'The business reason for the brand-level preference override when brand_override_flag is True. Used for audit trails and compliance reporting, particularly for regulatory restrictions (e.g., FDA, CPSC product safety communications).. Valid values are `regulatory_restriction|brand_policy|consumer_request|loyalty_program_rule|campaign_exclusion`',
    `preference_category` STRING COMMENT 'High-level classification of the preference type. Defines what dimension of consumer behavior or communication this preference record governs. [ENUM-REF-CANDIDATE: product_category|brand|flavor_fragrance|pack_size|channel|communication_channel|contact_frequency|preferred_time_of_day|preferred_language — promote to reference product]',
    `channel` STRING COMMENT 'The channel of the preference record',
    `cltv_tier` STRING COMMENT 'The consumers CLTV (Customer Lifetime Value) tier at the time this preference was recorded. Enables preference prioritization and investment decisions — high-CLTV consumers may receive more personalized preference-driven experiences and premium engagement programs.. Valid values are `platinum|gold|silver|bronze|unclassified`',
    `preference_code` STRING COMMENT 'The preference code of the preference record',
    `confidence_score` DECIMAL(18,2) COMMENT 'Numeric confidence level (0.0000 to 1.0000) assigned to this preference record, particularly relevant for ML-inferred preferences. A score of 1.0 indicates absolute certainty (typically for declared preferences); lower scores indicate inferred preferences with varying degrees of model confidence. Used by recommendation systems to weight preference signals.',
    `consent_basis` STRING COMMENT 'The GDPR lawful basis under which this preference data is collected and processed. explicit_consent is the most common basis for CPG consumer preference programs. Required for GDPR Article 6 compliance documentation.. Valid values are `explicit_consent|legitimate_interest|contractual_necessity|legal_obligation|vital_interest|public_task`',
    `created_timestamp` TIMESTAMP COMMENT 'The ISO 8601 timestamp when this preference record was first captured in the system. Serves as the audit creation timestamp and is used for GDPR consent audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'The currency code of the preference record',
    `data_subject_request_flag` BOOLEAN COMMENT 'Indicates whether this preference record is subject to an active Data Subject Request (DSR) under GDPR or CCPA (e.g., right to erasure, right to access, right to portability). When True, downstream systems must apply appropriate data handling restrictions.',
    `preference_description` STRING COMMENT 'The preference description of the preference record',
    `effective_date` DATE COMMENT 'The date from which this preference record becomes valid and actionable for personalization, communication orchestration, and recommendation systems. Aligns with GDPR consent effective date requirements.',
    `effective_from` DATE COMMENT 'The effective from of the preference record',
    `effective_until` DATE COMMENT 'The effective until of the preference record',
    `expiry_date` DATE COMMENT 'The date after which this preference record is no longer valid. Nullable for open-ended preferences. Used to enforce time-bound consent periods and seasonal preference windows. When expired, preference_status transitions to expired.',
    `flavor_fragrance_preference` STRING COMMENT 'The consumers preferred flavor (for food/beverage/oral care) or fragrance (for personal care/household products). Drives variant-level recommendations and new product development (NPD) consumer insights. Aligns with INCI nomenclature for fragrance ingredients.',
    `geographic_scope` STRING COMMENT 'The ISO 3166-1 alpha-3 country code indicating the geographic jurisdiction in which this preference is valid. Enables country-specific preference management for global CPG brands operating under different regulatory frameworks (e.g., GDPR in EU, CCPA in USA).. Valid values are `^[A-Z]{3}$`',
    `inference_basis` STRING COMMENT 'The data signal or behavioral evidence used to infer this preference when preference_source is ML-inferred. Provides transparency into the inference methodology for model explainability and GDPR Article 22 automated decision-making compliance.. Valid values are `purchase_history|browsing_behavior|survey_response|loyalty_redemption|pos_transaction|panel_data`',
    `inference_model_version` STRING COMMENT 'The version identifier of the ML model used to infer this preference when preference_source is inferred_ml or inferred_purchase_history. Enables model governance, A/B testing of recommendation algorithms, and reproducibility of inferred preferences for audit purposes.',
    `is_global_preference` BOOLEAN COMMENT 'Indicates whether this preference applies globally across all brands in the CPG portfolio (True) or is specific to a single brand identified by brand_id (False). Global preferences serve as the default when no brand-specific preference exists.',
    `key` STRING COMMENT 'The key of the preference record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The ISO 8601 timestamp of the most recent update to this preference record, whether from a consumer-declared change, a system re-inference, or an administrative override. Critical for freshness scoring in personalization engines and GDPR audit trails.',
    `preference_name` STRING COMMENT 'The preference name of the preference record',
    `notes` STRING COMMENT 'Free-text field for additional context or qualifications about this preference record, such as special instructions captured during a call-center interaction or notes from a consumer survey. Used by CRM agents and consumer engagement teams.',
    `nps_segment` STRING COMMENT 'The consumers NPS (Net Promoter Score) segment classification at the time this preference was captured. Used to contextualize preference data — promoters may have stronger brand preferences while detractors may have channel avoidance preferences. Supports consumer engagement strategy.. Valid values are `promoter|passive|detractor|unknown`',
    `opt_in_status` BOOLEAN COMMENT 'Indicates whether the consumer has opted in (True) or opted out (False) for this specific preference category. Critical for GDPR/CCPA compliance — a False value means the consumer must NOT be targeted via this preference dimension.',
    `opt_status` STRING COMMENT 'The opt status of the preference record',
    `pack_size_preference` STRING COMMENT 'The consumers preferred pack size or format (e.g., travel_size, standard, family_size, bulk, subscription_bundle). Used to tailor product recommendations and promotional offers to the consumers typical purchase behavior.',
    `preference_status` STRING COMMENT 'Current lifecycle state of the preference record. active means the preference is valid and in use by personalization engines; suppressed means the preference is overridden by a brand-level or regulatory rule; expired means the preference has passed its effective end date.. Valid values are `active|inactive|pending_verification|suppressed|expired`',
    `preference_type` STRING COMMENT 'The preference type of the preference record',
    `preferred_channel` STRING COMMENT 'The consumers preferred channel for receiving brand communications, promotions, and personalized content. Drives communication orchestration in Salesforce Consumer Goods Cloud and DTC engagement programs. none indicates the consumer has opted out of all outbound communications. [ENUM-REF-CANDIDATE: email|sms|push_notification|direct_mail|in_app|whatsapp|none — 7 candidates stripped; promote to reference product]',
    `preferred_contact_frequency` STRING COMMENT 'The consumers declared preference for how often they wish to receive brand communications. Used by communication orchestration engines to enforce contact frequency caps and prevent consumer fatigue in CPG engagement programs. [ENUM-REF-CANDIDATE: daily|weekly|bi_weekly|monthly|quarterly|as_needed|never — 7 candidates stripped; promote to reference product]',
    `preferred_language` STRING COMMENT 'The consumers preferred language for communications, expressed as an IETF BCP 47 language tag (e.g., en-US, fr-FR, es-MX). Used by communication orchestration platforms to deliver brand content in the consumers preferred language.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `preferred_time_of_day` STRING COMMENT 'The consumers preferred time window for receiving communications and push notifications. Used by send-time optimization algorithms in CPG personalization engines to maximize open rates and engagement.. Valid values are `morning|afternoon|evening|night|no_preference`',
    `preferred_timezone` STRING COMMENT 'The IANA timezone identifier for the consumers preferred timezone (e.g., America/New_York, Europe/London). Used in conjunction with preferred_time_of_day to schedule communications at the correct local time for global CPG consumer bases.',
    `product_category_preference` STRING COMMENT 'The specific CPG product category this consumer prefers (e.g., oral_care, hair_care, skin_care, household_cleaning, personal_hygiene). Drives product recommendation engines and category-level targeted promotions. Populated when preference_category = product_category.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the preference record',
    `rank` STRING COMMENT 'Ordinal ranking of this preference value relative to other values within the same category for the same consumer. Rank 1 indicates the most preferred option. Enables ranked preference lists for recommendation engines (e.g., first, second, third flavor choice).',
    `record_source_system` STRING COMMENT 'The record source system of the preference record',
    `retail_channel_preference` STRING COMMENT 'The consumers preferred retail channel for purchasing CPG products. Used for channel-specific targeting, trade promotion alignment, and omnichannel engagement strategies. Supports DSD (Direct Store Delivery) and DTC channel optimization. [ENUM-REF-CANDIDATE: ecommerce|grocery|mass_retail|pharmacy|dtc|club_store|convenience|specialty — 8 candidates stripped; promote to reference product]',
    `sku_preference` STRING COMMENT 'The specific SKU (Stock Keeping Unit) code that the consumer has declared or demonstrated a preference for. Enables SKU-level personalization and targeted replenishment reminders in DTC and e-commerce channels. Aligns with SAP S/4HANA MM material master.',
    `source` STRING COMMENT 'Origin of the preference record indicating whether it was explicitly declared by the consumer through a digital or physical touchpoint, or inferred by an ML model or behavioral analysis. Declared preferences carry higher trust weight in personalization engines. [ENUM-REF-CANDIDATE: declared_web|declared_app|declared_call_center|declared_in_store|inferred_ml|inferred_purchase_history|inferred_survey — promote to reference product]',
    `source_system_code` STRING COMMENT 'The source system code of the preference record',
    `source_system_preference_ref` STRING COMMENT 'The native identifier of this preference record in the originating source system (e.g., Salesforce Consumer Goods Cloud preference record ID). Enables cross-system reconciliation and EDI-based data exchange between CPG operational systems.',
    `subcategory` STRING COMMENT 'Granular sub-classification within the preference category. For example, within product_category the subcategory may be hair_care or oral_care; within communication_channel it may be email or push_notification. Enables multi-level preference taxonomy for CPG personalization engines.',
    `suppression_reason` STRING COMMENT 'The reason this preference record has been suppressed when preference_status = suppressed. Critical for GDPR right-to-erasure (Article 17) and CCPA opt-out compliance documentation. Ensures downstream systems do not act on suppressed preferences.. Valid values are `gdpr_erasure|ccpa_opt_out|consumer_request|regulatory_hold|fraud_flag|deceased`',
    `uom` STRING COMMENT 'The uom of the preference record',
    `updated_at_timestamp` TIMESTAMP COMMENT 'The updated at timestamp of the preference record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the preference record',
    `value` DECIMAL(18,2) COMMENT 'The specific declared or inferred preference value within the category and subcategory. Examples: mint for flavor, English for language, morning for time of day, weekly for contact frequency, email for communication channel. Free-form string to accommodate diverse CPG preference dimensions.',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Unified consumer preference profile capturing product, brand, channel, and communication preferences. Stores preference category (product category, brand, flavor, fragrance, pack size, channel, communication channel, contact frequency, preferred time of day, preferred language), preference value, opt-in/opt-out status, preference source (declared via web/app/call-center vs. inferred by ML model), confidence level, effective date, brand-level overrides, and last updated timestamp. Drives personalization engines, recommendation systems, communication orchestration, and targeted consumer engagement programs for CPG brands. This is the SSOT for all consumer preference data — both product/brand preferences and communication/contact preferences.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique surrogate identifier for each consent record in the Consumer Goods consumer privacy system. Primary key for the consent_record data product, serving as the SSOT for GDPR Article 7 and CCPA compliance audits.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing or re-consent campaign that prompted this consent record creation or update. Enables campaign-level consent conversion tracking and supports Trade Promotion Management (TPM) and consumer engagement analytics.',
    `channel_classification_id` BIGINT COMMENT 'Reference to the distribution or engagement channel (e.g., DTC e-commerce, retail loyalty, mobile app) through which the consumer relationship was established and consent was captured. Supports channel-level consent analytics.',
    `data_subject_request_id` BIGINT COMMENT 'Reference identifier of the Data Subject Access Request (DSAR) or right-to-erasure request that triggered a consent status change, if applicable. Links consent changes to formal regulatory requests for audit traceability under GDPR Articles 15-22.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Data privacy compliance mandates mapping each consent record to its governing jurisdiction for regulatory reporting.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program associated with this consent record, if the consumer is a loyalty program member. Consent for loyalty program data processing is tracked separately from general marketing consent.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the Consumer Goods brand for which this consent was captured. Enables brand-level consent reporting and ensures that consent granted for one brand is not incorrectly applied to another brand within the same corporate portfolio.',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer profile record for whom this consent record applies. Links the consent record to the consumer master in the CRM/DTC system (Salesforce Consumer Goods Cloud).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the consent record record',
    `capture_method` STRING COMMENT 'Channel or mechanism through which the consumers consent was captured. Identifies whether consent was obtained via a web form, mobile app, in-store interaction, call center agent, paper form, or email link. Required for GDPR proof-of-consent obligations.. Valid values are `web_form|mobile_app|in_store|call_center|paper_form|email_link`',
    `capture_timestamp` TIMESTAMP COMMENT 'Exact date and time (with timezone offset) when the consumers consent action was recorded in the system. This is the principal business event timestamp for the consent record and is immutable once set. Required for GDPR Article 7 audit trail.',
    `change_trigger` STRING COMMENT 'The business reason or event that triggered the most recent change to the consent status. Distinguishes consumer-initiated changes from system-driven expirations, administrative overrides, legal requests (e.g., right to erasure), or re-consent campaigns.. Valid values are `consumer_action|system_expiry|admin_override|legal_request|data_breach|re_consent_campaign`',
    `channel` STRING COMMENT 'The channel of the consent record record',
    `consent_record_code` STRING COMMENT 'The consent record code of the consent record record',
    `consent_date` DATE COMMENT 'The consent date of the consent record record',
    `consent_given` BOOLEAN COMMENT 'The consent given of the consent record record',
    `consent_language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 country subtag) of the language in which the consent notice was presented to the consumer (e.g., en, fr, de, es-MX). Required to confirm consent was given in an intelligible form per GDPR Article 7.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `consent_proof_reference` STRING COMMENT 'Reference identifier or URL pointing to the stored proof-of-consent artifact (e.g., screenshot, signed form scan, call recording reference, Veeva Vault document ID). Supports GDPR Article 7(1) obligation to demonstrate that consent was given.',
    `consent_record_status` STRING COMMENT 'The consent record status of the consent record record',
    `consent_scope` STRING COMMENT 'Defines the breadth of the consent grant — whether it applies globally across all Consumer Goods brands and products, is restricted to a specific brand, product category, or a single campaign. Enables granular consent management across the product portfolio.. Valid values are `global|brand_specific|product_category|campaign_specific`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent record indicating whether the consumer has actively granted, withdrawn, or is pending confirmation of consent, or whether the consent has expired past its validity period.. Valid values are `granted|withdrawn|pending|expired`',
    `consent_text_snapshot` STRING COMMENT 'Verbatim text or reference hash of the consent notice, privacy policy excerpt, or opt-in language presented to the consumer at the time of consent capture. Immutable record of what the consumer agreed to, required for GDPR Article 7 proof-of-consent.',
    `consent_timestamp` TIMESTAMP COMMENT 'The consent timestamp of the consent record record',
    `consent_type` STRING COMMENT 'Category of consent being captured, defining the specific processing activity for which the consumer has provided or withheld consent. Covers marketing email, SMS, push notification, data sharing, profiling, and cookies as required by GDPR and CCPA.. Valid values are `marketing_email|sms|push_notification|data_sharing|profiling|cookies`',
    `consent_version` STRING COMMENT 'Version identifier of the consent notice, privacy policy, or terms document presented to the consumer at the time of consent capture. Enables tracking of which policy version was in effect when consent was given, critical for GDPR Article 7 compliance.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `cookie_consent_categories` STRING COMMENT 'Comma-separated list of cookie categories for which the consumer has granted consent (e.g., functional,analytics,marketing). Captures granular cookie preferences as required by the ePrivacy Directive and GDPR for digital channels. [ENUM-REF-CANDIDATE: necessary|functional|analytics|marketing|social_media|personalization|advertising — promote to reference product]',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the consumers country of residence at the time of consent capture. Determines applicable privacy regulation (e.g., GDPR for EU countries, CCPA for USA/California). Critical for multi-jurisdiction compliance management.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was first created in the Consumer Goods data platform (Silver Layer). Distinct from capture_timestamp which records the business event time. Supports data lineage and audit trail requirements.',
    `currency_code` STRING COMMENT 'The currency code of the consent record record',
    `consent_record_description` STRING COMMENT 'The consent record description of the consent record record',
    `device_type` STRING COMMENT 'Type of device used by the consumer when providing consent in digital channels. Supports forensic audit trails and UX analysis of consent capture flows.. Valid values are `desktop|mobile|tablet|kiosk|other`',
    `double_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the consumer completed a double opt-in confirmation process (e.g., clicked a confirmation link in a verification email) in addition to the initial consent action. Double opt-in provides stronger proof of consent for marketing communications under GDPR.',
    `double_opt_in_timestamp` TIMESTAMP COMMENT 'Exact date and time when the consumer completed the double opt-in confirmation step. Null if double opt-in was not required or not yet completed. Provides the definitive timestamp for consent activation in double opt-in workflows.',
    `effective_from` DATE COMMENT 'Date from which this consent record is considered active and binding. Typically aligns with the capture date but may differ for backdated or scheduled consent activations. Supports MASTER_AGREEMENT role effective-period tracking.',
    `effective_until` DATE COMMENT 'The effective until of the consent record record',
    `expiry_date` DATE COMMENT 'Date on which this consent record expires and must be renewed or re-confirmed by the consumer. Null indicates open-ended consent with no defined expiry. Used to trigger consent renewal workflows and ensure ongoing compliance with GDPRs requirement for time-limited consent.',
    `ip_address` STRING COMMENT 'IP address of the device from which the consumer submitted their consent. Captured for digital consent channels (web form, mobile app, email link) as evidence of consent origin. May be considered PII under GDPR in some EU jurisdictions.',
    `is_current_record` BOOLEAN COMMENT 'Indicates whether this row represents the current active consent record for the consumer-consent_type combination. Supports Slowly Changing Dimension (SCD Type 2) pattern in the Silver Layer, where historical consent versions are retained for audit purposes and this flag identifies the latest version.',
    `legal_basis` STRING COMMENT 'The lawful basis under GDPR Article 6 or equivalent regulation for processing the consumers personal data. Consent is one of six legal bases; this field distinguishes consent-based processing from other lawful bases to support compliance reporting.. Valid values are `consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task`',
    `minor_age_threshold` STRING COMMENT 'Age threshold (in years) used to determine whether parental consent was required for this consent record, based on the applicable jurisdictions rules (e.g., 16 for GDPR default, 13 for COPPA, 13-16 for EU member state variations). Null if consumer is not a minor.',
    `consent_record_name` STRING COMMENT 'The consent record name of the consent record record',
    `notes` STRING COMMENT 'The notes of the consent record record',
    `parental_consent_flag` BOOLEAN COMMENT 'Indicates whether parental or guardian consent was obtained for a minor consumer. Required under GDPR Article 8 for children under 16 (or lower age threshold set by member state) and COPPA for US consumers under 13.',
    `prior_consent_status` STRING COMMENT 'The consent status immediately before the most recent status change. Enables point-in-time audit reconstruction and supports the immutable event log requirement for GDPR Article 7 compliance audits without requiring a separate history table join.. Valid values are `granted|withdrawn|pending|expired|none`',
    `processing_agent` STRING COMMENT 'Identifier of the system, application, or human agent (call center representative ID or system name) that processed and recorded the consent event. Supports accountability requirements under GDPR Article 5(2) and provides an audit trail of who or what captured the consent.',
    `profiling_consent_flag` BOOLEAN COMMENT 'Indicates whether the consumer has consented to automated profiling and decision-making activities, including personalization algorithms, NPS scoring, CLTV modeling, and segmentation. Required under GDPR Article 22 for automated decision-making with significant effects.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the consent record record',
    `re_consent_deadline` DATE COMMENT 'Date by which the consumer must re-confirm their consent before the current consent record is automatically withdrawn or expired. Null if re-consent is not required. Used to drive automated consent renewal campaigns.',
    `re_consent_required_flag` BOOLEAN COMMENT 'Indicates whether this consent record requires re-confirmation from the consumer due to a material change in the privacy policy, consent notice, or processing purpose. Triggers re-consent outreach workflows in the CRM system.',
    `record_source_system` STRING COMMENT 'The record source system of the consent record record',
    `record_version` STRING COMMENT 'Sequential version number of this consent record for the consumer-consent_type combination. Increments with each status change or update, enabling full audit history reconstruction. Version 1 is the initial consent capture; subsequent versions reflect changes.',
    `regulatory_jurisdiction` STRING COMMENT 'The applicable privacy regulation or jurisdiction framework under which this consent record was created and must be managed. Determines the legal basis, retention rules, and consumer rights applicable to this record (e.g., GDPR for EU consumers, CCPA for California residents).. Valid values are `GDPR|CCPA|LGPD|PIPEDA|PDPA|OTHER`',
    `retention_period_days` STRING COMMENT 'Number of days this consent record must be retained for compliance purposes after the consent is withdrawn or expires. Determined by applicable regulatory requirements (e.g., GDPR Article 5(1)(e) storage limitation, CCPA). Drives automated data lifecycle management.',
    `source_channel` STRING COMMENT 'The source channel of the consent record record',
    `source_system_code` STRING COMMENT 'The source system code of the consent record record',
    `third_party_sharing_flag` BOOLEAN COMMENT 'Indicates whether the consumer has explicitly consented to their personal data being shared with third-party partners (e.g., retail partners, data brokers, analytics providers). Distinct from general data sharing consent; specifically governs external data transfers.',
    `uom` STRING COMMENT 'The uom of the consent record record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this consent record in the data platform. Used for incremental data processing, change data capture (CDC), and audit trail maintenance in the Databricks Lakehouse Silver Layer.',
    `withdrawal_method` STRING COMMENT 'Channel or mechanism through which the consumer withdrew their consent. Null if consent has not been withdrawn. Required to demonstrate that withdrawal was as easy as giving consent per GDPR Article 7(3).. Valid values are `web_form|mobile_app|in_store|call_center|email_link|automated_expiry`',
    `withdrawal_timestamp` TIMESTAMP COMMENT 'Exact date and time when the consumer withdrew their consent. Null if consent has not been withdrawn. GDPR Article 7(3) requires that withdrawal be as easy as giving consent; this timestamp documents the withdrawal event for audit purposes.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Formal consent and privacy preference record for a consumer capturing GDPR, CCPA, and other regulatory consent obligations, including full audit history of all consent changes. Stores consent type (marketing email, SMS, push notification, data sharing, profiling, cookies), current consent status (granted, withdrawn, pending), consent version, capture method (web form, app, in-store, call center), capture timestamp, IP address, regulatory jurisdiction, expiry date, and immutable event log of every status change (prior status, new status, change trigger, channel, processing agent/system). This is the SSOT for consumer privacy compliance and provides the complete consent history required for GDPR Article 7 and CCPA compliance audits.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` (
    `consent_event_id` BIGINT COMMENT 'Unique surrogate identifier for each immutable consent status change event record in the audit log. Primary key of the consent_event table.',
    `consent_record_id` BIGINT COMMENT 'Reference to the parent consent record that this event modifies. Links the event to the current state of the consumers consent agreement managed in the consent master table.',
    `consent_session_id` BIGINT COMMENT 'Unique identifier of the web or mobile application session during which the consent event was captured. Enables cross-referencing with session analytics and digital behavior logs for audit trail completeness.',
    `data_subject_request_id` BIGINT COMMENT 'Reference identifier of the formal Data Subject Access Request (DSAR), right-to-erasure request, or opt-out request that triggered this consent event. Populated when change_trigger is regulatory_request. Links the event to the formal rights management workflow.',
    `employee_id` BIGINT COMMENT 'Identifier of the human agent (e.g., call center representative, CRM user) or automated system that processed and recorded this consent change event. Supports accountability tracing required by GDPR Article 5(2).',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Regulatory reporting of consent changes must reference the jurisdiction that governs the consent.',
    `preference_center_id` BIGINT COMMENT 'Reference to the specific preference center or consent management portal instance through which this consent event was captured. Supports multi-brand and multi-region preference center deployments.',
    `reversal_event_consent_event_id` BIGINT COMMENT 'Reference to the consent event that reversed or corrected this event, if applicable. Populated when event_status is reversed. Maintains the immutable audit chain while flagging erroneous records.',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer whose consent status changed. Identifies the data subject for GDPR/CCPA audit trail purposes.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the consent event record',
    `brand_code` STRING COMMENT 'Code identifying the Consumer Goods brand or product line in whose context the consent was collected (e.g., a specific personal care or household brand). Supports brand-level consent segmentation and multi-brand CRM programs.',
    `change_channel` STRING COMMENT 'The interaction channel through which the consent change was submitted or processed. Supports channel-level compliance reporting and consumer journey analytics. [ENUM-REF-CANDIDATE: web|mobile_app|call_center|in_store|email|postal|crm_agent|api — promote to reference product]',
    `change_trigger` STRING COMMENT 'The initiating cause of the consent status change. consumer_action = consumer explicitly acted; system_expiry = automated expiry rule fired; regulatory_request = GDPR/CCPA erasure or opt-out request; admin_override = internal compliance team action; data_import = bulk migration or integration import.. Valid values are `consumer_action|system_expiry|regulatory_request|admin_override|data_import`',
    `channel` STRING COMMENT 'The channel of the consent event record',
    `consent_event_code` STRING COMMENT 'The consent event code of the consent event record',
    `consent_event_status` STRING COMMENT 'The consent event status of the consent event record',
    `consent_expiry_date` DATE COMMENT 'The date on which the consent granted in this event is scheduled to expire and require renewal. Supports automated consent refresh workflows and ensures time-limited consent is not used beyond its valid period.',
    `consent_language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 country subtag) of the language in which the consent notice was presented to the consumer (e.g., en, en-US, fr-FR). Supports multilingual compliance documentation.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `consent_purpose_code` STRING COMMENT 'Standardized code identifying the specific processing purpose for which consent was changed (e.g., MARKETING_EMAIL, PERSONALIZATION, ANALYTICS, THIRD_PARTY_SHARING, LOYALTY_PROGRAM). Aligns with the consent purpose taxonomy defined under GDPR Article 5(1)(b) and CCPA categories.',
    `consent_purpose_name` STRING COMMENT 'Human-readable name of the processing purpose for which consent was changed. Provides business-friendly label alongside the consent_purpose_code for reporting and consumer-facing disclosures.',
    `consent_text_snapshot` STRING COMMENT 'Verbatim or summarized text of the consent notice or opt-in/opt-out statement presented to the consumer at the time of this event. Immutable snapshot stored for evidentiary purposes under GDPR Article 7(1) and CCPA audit requirements.',
    `consent_version` STRING COMMENT 'Version identifier of the consent notice, privacy policy, or terms document that was presented to the consumer at the time of this consent event. Required to demonstrate that consent was informed under GDPR Article 7(1).',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the consent event record',
    `currency_code` STRING COMMENT 'The currency code of the consent event record',
    `consent_event_description` STRING COMMENT 'The consent event description of the consent event record',
    `double_opt_in_flag` BOOLEAN COMMENT 'Indicates whether this consent grant was confirmed via a double opt-in mechanism (True), where the consumer confirmed their consent through a secondary verification step such as an email confirmation link. Relevant for email marketing compliance.',
    `double_opt_in_timestamp` TIMESTAMP COMMENT 'Date and time when the consumer completed the double opt-in confirmation step (e.g., clicked the email verification link). Null if double_opt_in_flag is False or not applicable.',
    `effective_from` DATE COMMENT 'The effective from of the consent event record',
    `effective_until` DATE COMMENT 'The effective until of the consent event record',
    `event_status` STRING COMMENT 'Processing status of this consent event record. processed = successfully applied to the consumers consent profile; pending = awaiting confirmation (e.g., double opt-in); failed = processing error; reversed = event was reversed due to error correction.. Valid values are `processed|pending|failed|reversed`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) when the consent status change event occurred. This is the authoritative business event time used for GDPR Article 7 and CCPA compliance audits, distinct from the record ingestion timestamp.',
    `event_type` STRING COMMENT 'Discriminator classifying the kind of consent change event. grant = consumer actively provided consent; withdraw = consumer revoked consent; update = scope or preferences modified; expire = consent lapsed due to time limit; regulatory_erasure = right-to-be-forgotten request; system_expiry = automated system-driven expiry. [ENUM-REF-CANDIDATE: grant|withdraw|update|expire|regulatory_erasure|system_expiry — promote to reference product]. Valid values are `grant|withdraw|update|expire|regulatory_erasure|system_expiry`',
    `ip_address` STRING COMMENT 'IP address of the consumers device at the time of the consent event submission. Captured as evidentiary proof of consent origin for GDPR Article 7 compliance. May be considered PII in certain jurisdictions.',
    `legal_basis_code` STRING COMMENT 'GDPR Article 6 lawful basis under which personal data processing is authorized at the time of this event. consent is the primary basis for marketing; other bases apply to operational processing. Required for GDPR Article 30 Records of Processing Activities.. Valid values are `consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task`',
    `minor_flag` BOOLEAN COMMENT 'Indicates whether the consumer was identified as a minor (under 16 years for GDPR, under 13 for COPPA) at the time of this consent event. Triggers parental consent verification workflows and restricts certain processing activities.',
    `consent_event_name` STRING COMMENT 'The consent event name of the consent event record',
    `new_consent_status` STRING COMMENT 'The consent status of the consumer immediately after this event was processed. Together with prior_consent_status, provides the complete state transition record for regulatory audit purposes.. Valid values are `granted|withdrawn|pending|expired|not_set`',
    `notes` STRING COMMENT 'Free-text field for compliance officers or CRM agents to record additional context, observations, or exceptions related to this consent event. Not used for structured data; intended for human-readable audit annotations.',
    `opt_in_flag` BOOLEAN COMMENT 'Indicates whether the resulting consent status after this event represents an active opt-in (True) or opt-out/withdrawal (False). Provides a simple boolean signal for downstream marketing suppression lists and CRM segmentation.',
    `parental_consent_flag` BOOLEAN COMMENT 'Indicates whether parental or guardian consent was obtained for this consent event, applicable when minor_flag is True. Required for GDPR Article 8 and COPPA compliance for processing data of minors.',
    `prior_consent_status` STRING COMMENT 'The consent status of the consumer immediately before this event was processed. Captured as an immutable snapshot to enable full before/after audit trail required by GDPR Article 7 compliance reviews.. Valid values are `granted|withdrawn|pending|expired|not_set`',
    `processing_system` STRING COMMENT 'Name or identifier of the operational system that processed and recorded this consent event (e.g., Salesforce Consumer Goods Cloud, CRM Portal, Preference Center API). Provides system-level audit trail for data lineage.',
    `profiling_consent_flag` BOOLEAN COMMENT 'Indicates whether the consumer has consented to automated profiling and personalization activities (True = profiling consented; False = profiling not consented or withdrawn). Relevant for GDPR Article 22 automated decision-making compliance.',
    `proof_of_consent_reference` STRING COMMENT 'Reference identifier or document path pointing to the stored evidence of consent (e.g., signed form scan, recorded call reference, screenshot archive, Veeva Vault document ID). Supports GDPR Article 7(1) burden-of-proof requirements.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the consent event record',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this consent event record was first ingested and persisted in the data platform (Silver Layer). Distinct from event_timestamp which captures the real-world business event time. Used for data lineage and SLA monitoring.',
    `record_source_system` STRING COMMENT 'The record source system of the consent event record',
    `regulatory_framework` STRING COMMENT 'The specific data protection regulatory framework under which this consent event is governed and must be reported. Enables framework-specific compliance reporting and audit filtering.. Valid values are `GDPR|CCPA|UK_GDPR|PIPEDA|LGPD|OTHER`',
    `source_channel` STRING COMMENT 'The source channel of the consent event record',
    `source_system_code` STRING COMMENT 'The source system code of the consent event record',
    `source_url` STRING COMMENT 'The web URL or deep-link of the page, form, or digital touchpoint where the consumer submitted the consent change (e.g., preference center URL, checkout page, registration form). Provides evidence of the consent collection point for GDPR Article 7 accountability.',
    `third_party_sharing_flag` BOOLEAN COMMENT 'Indicates whether this consent event includes or affects the consumers consent for sharing their personal data with third-party partners, retailers, or data brokers (True = sharing consented; False = sharing not consented or withdrawn).',
    `uom` STRING COMMENT 'The uom of the consent event record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the consent event record',
    `user_agent` STRING COMMENT 'Browser or application user-agent string captured at the time of the consent event. Provides technical evidence of the device and browser environment used when consent was given, supporting GDPR Article 7 proof-of-consent requirements.',
    `withdrawal_reason_code` STRING COMMENT 'Standardized code capturing the consumers stated reason for withdrawing consent (e.g., TOO_FREQUENT, NOT_RELEVANT, PRIVACY_CONCERN, UNSUBSCRIBE_ALL). Null for non-withdrawal events. Supports consumer experience analytics and suppression management.',
    `withdrawal_reason_text` STRING COMMENT 'Free-text description provided by the consumer or agent explaining the reason for consent withdrawal. Supplements withdrawal_reason_code with verbatim consumer feedback for qualitative analysis.',
    CONSTRAINT pk_consent_event PRIMARY KEY(`consent_event_id`)
) COMMENT 'Immutable audit log of every consent status change event for a consumer. Records the prior consent status, new consent status, change timestamp, change trigger (consumer action, system expiry, regulatory request), channel of change, agent or system that processed the change, and associated consent record reference. Provides the full consent history required for GDPR Article 7 and CCPA compliance audits.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` (
    `dtc_order_id` BIGINT COMMENT 'Unique surrogate identifier for each Direct-to-Consumer (DTC) order record in the Silver layer lakehouse. Primary key for this entity. Role: TRANSACTION_HEADER.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Order‑to‑Campaign linkage enables ROI analysis by attributing direct‑to‑consumer orders to the marketing campaign that generated the purchase.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Order processing costs are allocated to internal cost centers for budgeting and variance analysis.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Order fulfillment report requires order-level DC assignment for shipping cost, OTIF metrics, and inventory allocation.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Order fulfillment tracking report requires linking each consumer order to the shipment that delivers it, a standard operational need in consumer goods.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Required for consolidated revenue reporting across channels; DTC orders must be reconciled with central sales order for finance.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Required for Order Fulfillment Tracking report linking each consumer DTC order to the procurement purchase order that supplied the goods.',
    `address_id` BIGINT COMMENT 'The shipping address id of the dtc order record',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer (shopper) who placed this DTC order. Links to the consumer master profile in the Consumer domain SSOT, enabling CLTV analysis, loyalty program attribution, and personalization. Satisfies TRANSACTION_HEADER PARTY_REFERENCE category.',
    `subscription_id` BIGINT COMMENT 'Reference to the consumer subscription plan that generated this DTC order, when subscription_order_flag is True. Links to the subscription master for recurring order management, churn analysis, and subscription revenue reporting.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Corporate purchase orders placed by trade accounts for end consumers require linking dtc_order to trade_account for spend reporting and invoicing.',
    `actual_delivery_date` DATE COMMENT 'The date the shipment was confirmed as delivered to the consumer. Compared against promised_delivery_date to calculate OTIF performance and identify late delivery patterns for carrier SLA management.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the dtc order record',
    `billing_address_same_flag` BOOLEAN COMMENT 'Indicates whether the billing address is identical to the shipping address for this order. When False, a separate billing address record is maintained. Used for payment processing and fraud risk scoring.',
    `carrier_code` STRING COMMENT 'Code identifying the shipping carrier assigned to deliver this DTC order (e.g., UPS, FedEx, USPS, DHL). Used for carrier performance analysis, SLA tracking, and logistics cost allocation.',
    `channel` STRING COMMENT 'The channel of the dtc order record',
    `channel_code` STRING COMMENT 'The specific owned DTC channel through which the order was placed (e.g., brand website, mobile app, social commerce). Enables channel-level performance analysis, attribution modeling, and Share of Voice (SOV) reporting across DTC touchpoints.. Valid values are `brand_website|mobile_app|social_commerce|voice_commerce|dtc_subscription`',
    `dtc_order_code` STRING COMMENT 'The dtc order code of the dtc order record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DTC order record was first ingested and created in the Silver layer lakehouse. Used for data lineage, audit trails, and ETL reconciliation. Satisfies TRANSACTION_HEADER RECORD_AUDIT_CREATED category.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this order (e.g., USD, EUR, GBP). Required for multi-currency financial consolidation, FX reporting, and EBITDA calculations. Part of TRANSACTION_HEADER MONETARY_TRIPLET.. Valid values are `^[A-Z]{3}$`',
    `dtc_order_description` STRING COMMENT 'The dtc order description of the dtc order record',
    `device_type` STRING COMMENT 'Type of device used by the consumer to place this DTC order. Used for UX optimization, mobile commerce analytics, and channel attribution modeling to improve conversion rates across device types.. Valid values are `desktop|mobile|tablet|smart_tv|voice_assistant`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total monetary discount applied at the order header level, including promotional codes, loyalty redemptions, and trade promotion discounts. Used for Trade Promotion Management (TPM) ROI analysis and net revenue reporting. Part of TRANSACTION_HEADER MONETARY_TRIPLET adjustment.',
    `dtc_order_status` STRING COMMENT 'The dtc order status of the dtc order record',
    `effective_from` DATE COMMENT 'The effective from of the dtc order record',
    `effective_until` DATE COMMENT 'The effective until of the dtc order record',
    `fulfillment_ref` STRING COMMENT 'External reference number linking this DTC order to the fulfillment system (e.g., Blue Yonder WMS warehouse order, 3PL fulfillment reference, or SAP WM transfer order). Enables end-to-end order-to-delivery traceability and OTIF measurement.',
    `fulfillment_status` STRING COMMENT 'Current fulfillment state of the DTC order at the header level, indicating whether all line items have been picked, packed, and shipped. Used for OTIF (On Time In Full) KPI reporting and supply chain performance dashboards.. Valid values are `unfulfilled|partially_fulfilled|fulfilled|cancelled`',
    `gift_order_flag` BOOLEAN COMMENT 'Indicates whether this DTC order was placed as a gift, triggering gift wrapping, suppression of price information on packing slips, and gift message inclusion. Used for seasonal demand analysis and consumer gifting behavior modeling.',
    `ip_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code derived from the consumers IP address at the time of order placement. Used for fraud detection, geo-restriction compliance, and cross-border commerce analytics. Classified as potentially PII under GDPR.. Valid values are `^[A-Z]{3}$`',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the consumer for this DTC order, based on the order total and applicable loyalty tier multipliers. Feeds into CLTV calculations and loyalty program engagement analytics.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the consumer as a discount on this DTC order. Used for loyalty liability accounting, redemption rate analysis, and consumer engagement reporting.',
    `dtc_order_name` STRING COMMENT 'The dtc order name of the dtc order record',
    `notes` STRING COMMENT 'The notes of the dtc order record',
    `order_date` TIMESTAMP COMMENT 'The exact date and time (UTC) when the consumer submitted the order through the DTC e-commerce or brand website channel. This is the principal business event timestamp used for demand planning, daily sales reporting, and S&OP inputs. Satisfies TRANSACTION_HEADER BUSINESS_EVENT_TIMESTAMP category.',
    `order_status` STRING COMMENT 'Current lifecycle state of the DTC order, tracking progression from placement through fulfillment or cancellation. Used for order management dashboards, OTIF reporting, and consumer communication triggers. Satisfies TRANSACTION_HEADER LIFECYCLE_STATUS category. [ENUM-REF-CANDIDATE: pending|confirmed|processing|shipped|delivered|cancelled|returned — promote to reference product]',
    `order_timestamp` TIMESTAMP COMMENT 'The order timestamp of the dtc order record',
    `order_total_amount` DECIMAL(18,2) COMMENT 'The final net amount charged to the consumer, calculated as subtotal minus discounts plus shipping plus tax. This is the authoritative revenue figure for DTC channel financial reporting and EBITDA contribution analysis. Satisfies TRANSACTION_HEADER MONETARY_TRIPLET net total.',
    `payment_method` STRING COMMENT 'The payment instrument type used by the consumer to complete this DTC order (e.g., credit card, PayPal, digital wallet). Used for payment analytics, fraud detection, and consumer payment preference reporting. Note: No raw card data is stored; only the instrument type.. Valid values are `credit_card|debit_card|paypal|apple_pay|google_pay|gift_card`',
    `payment_status` STRING COMMENT 'Current status of the payment transaction associated with this DTC order, tracking authorization through capture or refund. Critical for revenue recognition, accounts receivable (DSO), and consumer dispute resolution.. Valid values are `pending|authorized|captured|failed|refunded|partially_refunded`',
    `payment_transaction_ref` STRING COMMENT 'External payment gateway transaction reference or authorization code for this order. Used for payment reconciliation, chargeback management, and financial audit trails. Does not contain sensitive card data (PCI DSS compliant tokenized reference only).',
    `promised_delivery_date` DATE COMMENT 'The delivery date committed to the consumer at the time of order placement, based on Available to Promise (ATP) or Capable to Promise (CTP) logic. Used for SLA compliance measurement and consumer expectation management.',
    `promotion_code` STRING COMMENT 'Promotional or coupon code entered by the consumer at checkout, linking this order to a specific Trade Promotion Management (TPM) campaign. Enables TPM ROI measurement, promotional lift analysis, and Trade Promotion Optimization (TPO) modeling.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the dtc order record',
    `record_source_system` STRING COMMENT 'The record source system of the dtc order record',
    `return_flag` BOOLEAN COMMENT 'Indicates whether any item in this DTC order has been returned or a return has been initiated. Used for return rate analysis, product quality monitoring, and consumer satisfaction (NPS) correlation studies.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for the order return (e.g., defective product, wrong item, consumer changed mind). Populated when return_flag is True. Used for quality defect analysis, product improvement, and COGS impact reporting. [ENUM-REF-CANDIDATE: defective|wrong_item|not_as_described|changed_mind|damaged_in_transit|late_delivery|other — promote to reference product]',
    `ship_to_address_line1` STRING COMMENT 'Primary street address line for the shipping destination of this DTC order. Used for carrier routing, last-mile delivery, and geographic sales analysis. Classified as PII under GDPR and CCPA.',
    `ship_to_city` STRING COMMENT 'City of the shipping destination for this DTC order. Used for geographic demand analysis, Distribution Requirements Planning (DRP), and regional marketing segmentation.',
    `ship_to_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the shipping destination. Drives international shipping compliance, customs documentation, import/export regulatory requirements, and multi-country revenue reporting.. Valid values are `^[A-Z]{3}$`',
    `ship_to_name` STRING COMMENT 'Full name of the recipient at the shipping address for this DTC order. May differ from the ordering consumer (e.g., gift orders). Required for carrier label generation and last-mile delivery. Classified as PII under GDPR and CCPA.',
    `ship_to_postal_code` STRING COMMENT 'Postal or ZIP code of the shipping destination. Used for carrier rate calculation, geographic clustering, and micro-market demand analysis.',
    `ship_to_state_province` STRING COMMENT 'State or province of the shipping destination. Used for tax jurisdiction determination, regional sales reporting, and regulatory compliance (e.g., state-level FDA or EPA requirements).',
    `shipped_date` DATE COMMENT 'The date the order was physically dispatched from the fulfillment center or warehouse. Used for lead time analysis, carrier handoff tracking, and revenue recognition timing under ASC 606.',
    `shipping_amount` DECIMAL(18,2) COMMENT 'Shipping and handling charges billed to the consumer for this DTC order. Used for logistics cost analysis, free-shipping threshold reporting, and net revenue calculations.',
    `source_system_code` STRING COMMENT 'The source system code of the dtc order record',
    `source_system_order_ref` STRING COMMENT 'The native order identifier from the originating e-commerce platform or ERP system (e.g., Salesforce Commerce Cloud order ID, SAP SD sales order number). Used for cross-system reconciliation, EDI integration, and data lineage tracing back to the system of record.',
    `subscription_order_flag` BOOLEAN COMMENT 'Indicates whether this DTC order was generated as part of a recurring subscription (subscribe-and-save) program. Used to distinguish subscription revenue from one-time purchase revenue for CLTV modeling and replenishment trigger analysis.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'The gross merchandise value of all line items before discounts, shipping charges, and taxes are applied. Used as the base for promotional discount calculations, COGS analysis, and gross margin reporting. Part of TRANSACTION_HEADER MONETARY_TRIPLET.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax or VAT charged on this DTC order, calculated based on the shipping destination jurisdiction. Required for financial reporting, tax compliance, and SOX audit trails. Part of TRANSACTION_HEADER MONETARY_TRIPLET adjustment.',
    `total_amount` DECIMAL(18,2) COMMENT 'The total amount of the dtc order record',
    `tracking_number` STRING COMMENT 'Carrier-assigned tracking number for the shipment associated with this DTC order. Provided to the consumer for last-mile visibility and used internally for delivery confirmation and OTIF measurement.',
    `uom` STRING COMMENT 'The uom of the dtc order record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this DTC order record in the Silver layer, capturing status changes, address corrections, or payment updates. Supports change data capture and audit compliance. Satisfies TRANSACTION_HEADER RECORD_AUDIT_UPDATED category.',
    CONSTRAINT pk_dtc_order PRIMARY KEY(`dtc_order_id`)
) COMMENT 'Direct-to-Consumer (DTC) order with line-item detail placed by a shopper through owned e-commerce or brand website channels. Captures order header (order number, date, status, channel, shipping/billing address, payment method, subtotal, discount, shipping cost, tax, total, currency, fulfillment reference) and line items (SKU/GTIN, product name, quantity ordered/shipped, unit price, line discount, line total, promotion code, fulfillment status, return flag). This is the SSOT for DTC channel order transactions and enables SKU-level purchase analysis, replenishment triggers, and product affinity modeling.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` (
    `dtc_order_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual line item within a DTC order. Primary key for this entity. Role: TRANSACTION_LINE.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Line‑level attribution assigns each ordered SKU to the campaign that promoted it, supporting product‑level campaign performance reporting.',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the fulfillment warehouse or distribution center from which this order line was or will be shipped. Supports Distribution Requirements Planning (DRP) and warehouse performance analytics.',
    `dtc_order_id` BIGINT COMMENT 'Foreign key reference to the parent DTC order header. Establishes the header/detail relationship for this line item. Satisfies TRANSACTION_LINE HEADER_REFERENCE category.',
    `logistics_shipment_id` BIGINT COMMENT 'Reference to the outbound shipment record associated with this order line. Enables traceability from order line to physical shipment for OTIF tracking and logistics cost allocation.',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: Recall effectiveness analysis needs to associate each order line with the recall that affected the SKU.',
    `promotion_event_id` BIGINT COMMENT 'Reference to the trade promotion or marketing campaign that generated the discount applied to this line. Links to the promotion master for Trade Promotion Optimization (TPO) and ROI measurement.',
    `shopper_id` BIGINT COMMENT 'Reference to the end consumer or shopper who placed the DTC order. Enables consumer-level purchase history, CLTV analysis, and personalization. Satisfies TRANSACTION_LINE PARTY_REFERENCE category.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU purchased on this line. Enables SKU-level purchase analysis, product affinity modeling, and replenishment triggers. Satisfies TRANSACTION_LINE RESOURCE_REFERENCE category.',
    `stock_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_movement. Business justification: Shipment tracking process ties each order line to the inventory movement record that shipped the product.',
    `subscription_id` BIGINT COMMENT 'Reference to the consumer subscription record that triggered this order line, when subscription_flag is True. Enables subscription lifecycle analysis and recurring revenue reporting.',
    `atp_record_id` BIGINT COMMENT 'Foreign key linking to supply.atp_record. Business justification: REQUIRED: Order line allocation references the ATP record used for inventory commitment; this link supports order‑to‑inventory reconciliation and fulfillment reporting.',
    `dtc_return_id` BIGINT COMMENT 'Reference to the consumer return record associated with this order line when a return has been initiated. Enables end-to-end return lifecycle tracking and refund reconciliation.',
    `actual_delivery_date` DATE COMMENT 'Date on which the order line was confirmed as delivered to the consumer. Used for OTIF calculation, consumer satisfaction analysis, and carrier performance reporting.',
    `actual_ship_date` DATE COMMENT 'Date on which the order line was physically dispatched from the fulfillment warehouse. Used to calculate On Time In Full (OTIF) performance and carrier SLA adherence.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the dtc order line record',
    `brand_code` STRING COMMENT 'Code identifying the brand under which the product on this order line is marketed. Supports brand-level revenue reporting, Share of Market (SOM) analysis, and brand portfolio performance tracking.',
    `channel_code` STRING COMMENT 'Identifies the specific DTC sub-channel through which this order line was placed (e.g., brand website, mobile app, subscription program, social commerce). Supports channel-level revenue attribution and consumer journey analytics.. Valid values are `DTC_WEB|DTC_MOBILE|DTC_APP|DTC_SUBSCRIPTION|DTC_SOCIAL`',
    `dtc_order_line_code` STRING COMMENT 'The dtc order line code of the dtc order line record',
    `cost_of_goods_sold` DECIMAL(18,2) COMMENT 'Standard cost of goods for the units on this order line at time of sale. Used for gross margin calculation, DTC channel profitability analysis, and EBITDA reporting. Classified confidential as it reveals internal cost structure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for data lineage and SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts on this order line are denominated (e.g., USD, EUR, GBP). Supports multi-currency DTC operations and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `dtc_order_line_description` STRING COMMENT 'The dtc order line description of the dtc order line record',
    `dtc_order_line_status` STRING COMMENT 'The dtc order line status of the dtc order line record',
    `effective_from` DATE COMMENT 'The effective from of the dtc order line record',
    `effective_until` DATE COMMENT 'The effective until of the dtc order line record',
    `fulfillment_status` STRING COMMENT 'Current fulfillment lifecycle state of this order line. Tracks progression from order confirmation through warehouse picking, packing, shipment, and delivery. Supports On Time In Full (OTIF) monitoring and consumer communication. [ENUM-REF-CANDIDATE: pending|confirmed|picking|packed|shipped|delivered|cancelled|backordered — promote to reference product]',
    `gift_flag` BOOLEAN COMMENT 'Indicates whether this order line was designated as a gift by the consumer. True when the consumer selected gift options (e.g., gift wrapping, gift message). Supports gifting program analytics and packaging operations.',
    `gtin` STRING COMMENT 'GS1-standard Global Trade Item Number for the product on this line. Enables cross-retailer product identification, barcode scanning, and regulatory traceability. Conforms to GS1 GTIN-8, GTIN-12 (UPC), GTIN-13 (EAN), or GTIN-14 formats.. Valid values are `^[0-9]{8,14}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the product on this order line is classified as a hazardous material requiring special handling, packaging, or shipping restrictions. True for products subject to DOT, IATA, or EPA hazmat regulations. Critical for carrier compliance and Safety Data Sheet (SDS) requirements.',
    `is_returned` BOOLEAN COMMENT 'Indicates whether this order line has been subject to a consumer return. True when a return has been initiated or completed. Enables return rate analysis by SKU, category, and consumer segment for product quality and consumer experience programs.',
    `line_discount_amount` DECIMAL(18,2) COMMENT 'Total monetary discount applied to this order line, including promotional discounts, coupon redemptions, and loyalty rewards. Used for Trade Promotion Management (TPM) analysis and margin reporting.',
    `line_discount_pct` DECIMAL(18,2) COMMENT 'Discount rate applied to this order line expressed as a percentage of the gross unit price. Enables promotional effectiveness analysis and margin impact assessment without requiring price recalculation.',
    `line_net_amount` DECIMAL(18,2) COMMENT 'Net monetary value of this order line after all discounts have been applied but before tax. Core revenue recognition field for DTC channel P&L reporting and COGS analysis. Satisfies TRANSACTION_LINE LINE_VALUE_OR_RESULT monetary component.',
    `line_number` STRING COMMENT 'Sequential position of this line item within the parent DTC order. Used for ordering, display, and reconciliation of multi-line orders. Satisfies TRANSACTION_LINE LINE_SEQUENCE category.',
    `line_subtotal` DECIMAL(18,2) COMMENT 'Gross line value before tax, calculated as unit_price multiplied by quantity_ordered. Represents the pre-discount, pre-tax revenue contribution of this line item.',
    `line_total` DECIMAL(18,2) COMMENT 'The line total of the dtc order line record',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Final total amount for this order line inclusive of all discounts and taxes. Represents the actual amount charged to the consumer for this line item. Used for revenue reporting and consumer billing reconciliation.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the consumer for purchasing this order line. Supports loyalty program accrual tracking, Consumer Lifetime Value (CLTV) modeling, and consumer engagement analytics.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the consumer as a discount on this order line. Enables loyalty redemption rate analysis and program liability management.',
    `dtc_order_line_name` STRING COMMENT 'The dtc order line name of the dtc order line record',
    `notes` STRING COMMENT 'The notes of the dtc order line record',
    `product_category_code` STRING COMMENT 'Hierarchical product category classification code for the SKU on this line (e.g., Personal Care > Hair Care > Shampoo). Enables category-level sales analysis, assortment planning, and consumer purchase pattern segmentation.',
    `product_name` STRING COMMENT 'Commercial name of the product SKU as displayed to the consumer at time of purchase. Captured at order time to preserve historical accuracy independent of future product name changes.',
    `promised_delivery_date` DATE COMMENT 'Date communicated to the consumer as the expected delivery date for this order line. Drives consumer expectation management, NPS impact analysis, and carrier performance benchmarking.',
    `promised_ship_date` DATE COMMENT 'Date on which the order line was committed to ship to the consumer at time of order placement. Basis for Available to Promise (ATP) and Service Level Agreement (SLA) compliance measurement.',
    `promotion_code` STRING COMMENT 'Promotional or coupon code applied by the consumer at checkout that triggered a discount on this order line. Enables Trade Promotion Management (TPM) redemption tracking, campaign ROI analysis, and fraud detection.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the dtc order line record',
    `quantity_cancelled` STRING COMMENT 'Number of units cancelled on this order line, either by the consumer or due to inventory unavailability. Supports cancellation rate analysis and demand signal correction.',
    `quantity_ordered` STRING COMMENT 'Number of units of the SKU ordered by the consumer on this line. Basis for demand planning, inventory reservation, and fulfillment processing. Satisfies TRANSACTION_LINE LINE_QUANTITY category.',
    `quantity_shipped` STRING COMMENT 'Actual number of units of the SKU dispatched to the consumer for this line. May differ from quantity_ordered due to partial fulfillment, Out of Stock (OOS) situations, or split shipments. Key metric for On Time In Full (OTIF) measurement.',
    `record_source_system` STRING COMMENT 'The record source system of the dtc order line record',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether this order line is subject to a regulatory hold preventing fulfillment (e.g., FDA product recall, CPSC safety alert, EU REACH restriction). True when a hold is active. Supports compliance-driven order management and consumer safety programs.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the reason for the consumer return of this order line. Supports product quality analysis, Quality Control (QC) escalation, and consumer experience improvement. [ENUM-REF-CANDIDATE: DEFECTIVE|WRONG_ITEM|NOT_AS_DESCRIBED|CHANGED_MIND|DAMAGED_IN_TRANSIT|LATE_DELIVERY|DUPLICATE_ORDER|OTHER — promote to reference product]',
    `source_system_code` STRING COMMENT 'The source system code of the dtc order line record',
    `subscription_flag` BOOLEAN COMMENT 'Indicates whether this order line was generated as part of a recurring subscription program (e.g., Subscribe & Save). True for subscription-triggered lines. Enables subscription revenue tracking and replenishment program analysis.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to this order line, including applicable sales tax, VAT, or GST based on consumer jurisdiction. Required for tax compliance reporting and financial reconciliation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure in which the SKU quantity is expressed on this order line (e.g., EA=Each, CS=Case, PK=Pack). Aligns with GS1 and SAP UOM standards for consistent quantity interpretation. [ENUM-REF-CANDIDATE: EA|CS|PK|BX|KG|LB|OZ|L|ML — 9 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Gross selling price per unit of the SKU at the time of order placement, before any discounts or promotions. Represents the consumer-facing price (RSP/MSRP or DTC-specific price). Satisfies TRANSACTION_LINE LINE_VALUE_OR_RESULT category.',
    `uom` STRING COMMENT 'The uom of the dtc order line record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this order line record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change data capture (CDC), audit trails, and Silver layer incremental processing in the Databricks Lakehouse.',
    CONSTRAINT pk_dtc_order_line PRIMARY KEY(`dtc_order_line_id`)
) COMMENT 'Individual line item within a DTC order representing a single SKU purchased. Stores order reference, SKU/GTIN, product name, quantity ordered, quantity shipped, unit price, line discount, line total, promotion code applied, fulfillment status, and return flag. Enables SKU-level purchase analysis, replenishment triggers, and product affinity modeling for CPG DTC channels.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` (
    `dtc_return_id` BIGINT COMMENT 'Unique surrogate identifier for a DTC return or refund request record. Primary key of this entity.',
    `dtc_order_id` BIGINT COMMENT 'The dtc order id of the dtc return record',
    `dtc_order_line_id` BIGINT COMMENT 'Renamed to describe business role.',
    `employee_id` BIGINT COMMENT 'Reference to the customer service agent who processed or approved the return request. Used for agent performance analytics, quality assurance, and audit trail. Sourced from Salesforce Consumer Goods Cloud case management.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Return investigation workflow uses inspection lot data to determine defect source and regulatory hold decisions.',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Return processing workflow needs the original shipment reference to manage reverse logistics, refunds, and OTIF metrics.',
    `order_id` BIGINT COMMENT 'Reference to the original DTC order against which this return is raised. Links the return to the parent sales transaction for financial reconciliation and consumer satisfaction tracking.',
    `order_line_id` BIGINT COMMENT 'Reference to the specific order line item being returned within the original DTC order. Enables line-level return tracking and partial-order return scenarios.',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_recall. Business justification: Recall management report requires linking each consumer return to the associated product recall record to track recall effectiveness.',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer profile who initiated the return request. Links to the SSOT consumer master record for CRM, loyalty, and consumer satisfaction analytics.',
    `sku_id` BIGINT COMMENT 'Reference to the product (SKU) being returned. Enables product-level return rate analysis, quality feedback loops, and defect trending by SKU.',
    `stock_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_movement. Business justification: Return movement tracking links each return to the inventory movement that records the inbound return flow.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Return processing records which stock position the returned SKU is returned to for inventory reconciliation.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the dtc return record',
    `approval_date` DATE COMMENT 'Date on which the return request was approved by the consumer service team or automated system. Used for SLA tracking and return processing time analytics.',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number of the returned product unit. Critical for Good Manufacturing Practice (GMP) traceability, product recall management, and quality defect root cause analysis. Sourced from product packaging or consumer-provided information.',
    `carrier_name` STRING COMMENT 'Name of the shipping carrier handling the return shipment (e.g., UPS, FedEx, USPS, DHL). Used for carrier performance analysis, reverse logistics cost allocation, and carrier claims for damaged-in-transit returns.',
    `case_number` STRING COMMENT 'Customer service case or ticket number associated with this return request in the CRM system. Enables cross-referencing between the return record and the consumer service interaction history in Salesforce Consumer Goods Cloud.',
    `dtc_return_code` STRING COMMENT 'The dtc return code of the dtc return record',
    `consumer_satisfaction_score` STRING COMMENT 'Post-return consumer satisfaction rating collected via survey (typically 1–5 or 1–10 scale). Used as an input to Net Promoter Score (NPS) calculations and consumer experience improvement programs. Collected via Salesforce Consumer Goods Cloud post-return survey.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this return record was first created in the data platform. Used for audit trail, data lineage, and Silver layer ingestion tracking. Distinct from request_timestamp which captures the business event time.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this return record (refund_amount, restocking_fee_amount, net_refund_amount). Supports multi-currency DTC operations across global markets.. Valid values are `^[A-Z]{3}$`',
    `dtc_return_description` STRING COMMENT 'The dtc return description of the dtc return record',
    `disposition_code` STRING COMMENT 'Final disposition decision for the returned product after quality inspection. Drives inventory management, COGS impact, and regulatory compliance for product destruction. Valid values: restock (return to sellable inventory), refurbish (rework required), destroy (product destroyed per policy), return_to_vendor (sent back to supplier), quarantine (held pending investigation).. Valid values are `restock|refurbish|destroy|return_to_vendor|quarantine`',
    `dtc_return_status` STRING COMMENT 'The dtc return status of the dtc return record',
    `effective_from` DATE COMMENT 'The effective from of the dtc return record',
    `effective_until` DATE COMMENT 'The effective until of the dtc return record',
    `expiry_date` DATE COMMENT 'Expiration or best-before date printed on the returned product. Used for FEFO compliance validation, quality assessment of returned goods, and regulatory reporting for expired product returns.',
    `fraud_review_flag` BOOLEAN COMMENT 'Indicates whether this return has been flagged for manual fraud review based on fraud_risk_score or other risk signals. Supports loss prevention workflows and return abuse management.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0.00–100.00) assigned by the fraud detection system to assess the likelihood of return fraud. Drives manual review routing and automated rejection thresholds. Supports loss prevention analytics.',
    `loyalty_points_refunded` STRING COMMENT 'Number of loyalty program points credited back to the consumers account as part of the refund. Populated when refund_method is loyalty_points or when loyalty points were originally redeemed on the order. Supports loyalty program financial reconciliation.',
    `dtc_return_name` STRING COMMENT 'The dtc return name of the dtc return record',
    `net_refund_amount` DECIMAL(18,2) COMMENT 'Net monetary amount actually refunded to the consumer after deducting any restocking fees or adjustments from the gross refund amount. Used for financial settlement and consumer account reconciliation.',
    `notes` STRING COMMENT 'The notes of the dtc return record',
    `product_condition_code` STRING COMMENT 'Assessed condition of the returned product upon receipt at the warehouse. Determines disposition (restock, refurbish, destroy) and impacts inventory valuation. Assessed by warehouse quality inspection team per GMP guidelines.. Valid values are `unopened|opened_unused|used|damaged|destroyed`',
    `quality_defect_code` STRING COMMENT 'Standardized quality defect classification code assigned when the return reason indicates a product quality issue (defective, damaged). Feeds into the Quality Management (QM) system for defect trending, root cause analysis, and regulatory reporting. Sourced from SAP QM or Siemens Opcenter MES quality module.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the dtc return record',
    `received_date` DATE COMMENT 'Date on which the returned product was physically received at the warehouse or returns processing center. Triggers refund processing and inventory restock workflows. Sourced from Blue Yonder WMS goods receipt.',
    `record_source_system` STRING COMMENT 'The record source system of the dtc return record',
    `refund_amount` DECIMAL(18,2) COMMENT 'Gross monetary amount to be refunded or already refunded to the consumer, in the transaction currency. Represents the base refund before any deductions such as restocking fees. Used for financial reconciliation and COGS impact reporting.',
    `refund_issued_date` DATE COMMENT 'Date on which the refund was issued to the consumer. Used for financial reconciliation, Days Sales Outstanding (DSO) adjustment, and consumer satisfaction SLA measurement.',
    `refund_method` STRING COMMENT 'Method by which the refund is issued to the consumer. Drives financial processing workflows and consumer communication. Valid values: original_payment (refund to original payment instrument), store_credit (credit to consumer account), loyalty_points (converted to loyalty program points), bank_transfer (direct bank transfer), gift_card (issued as gift card value).. Valid values are `original_payment|store_credit|loyalty_points|bank_transfer|gift_card`',
    `regulatory_report_required` BOOLEAN COMMENT 'Indicates whether this return requires submission of a regulatory report to a governing body (FDA, CPSC, EPA). Driven by safety_incident_flag, product category, and jurisdiction. Supports compliance workflow automation and audit readiness.',
    `rejection_date` DATE COMMENT 'Date on which the return request was rejected. Populated only when return_status is rejected. Used for consumer communication SLA tracking and dispute resolution analytics.',
    `rejection_reason` STRING COMMENT 'Reason code explaining why the return request was rejected. Populated only when return_status is rejected. Supports consumer dispute resolution and return policy analytics.. Valid values are `outside_return_window|policy_violation|non_returnable_item|fraud_suspected|incomplete_return`',
    `request_date` DATE COMMENT 'Calendar date on which the consumer submitted the return request. Used for SLA measurement, return window eligibility validation, and trend reporting.',
    `request_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) when the consumer submitted the return request. Used for SLA measurement at sub-day granularity and audit trail purposes.',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee deducted from the refund amount to cover reverse logistics and restocking costs, where applicable per return policy. Used for net refund calculation and cost recovery reporting.',
    `return_channel` STRING COMMENT 'Digital or service channel through which the consumer initiated the return request. Distinct from return method (physical logistics). Used for channel analytics and consumer experience optimization.. Valid values are `web|mobile_app|customer_service|email|chat`',
    `return_date` DATE COMMENT 'The return date of the dtc return record',
    `return_label_tracking_number` STRING COMMENT 'Carrier tracking number assigned to the prepaid return shipping label issued to the consumer. Enables reverse logistics tracking and proof-of-return verification. Sourced from Blue Yonder WMS or carrier integration.',
    `return_method` STRING COMMENT 'Physical method by which the consumer returns the product. Determines logistics handling, prepaid label issuance, and reverse logistics cost allocation. Valid values: mail_in (consumer ships via postal/courier), drop_off (consumer drops at designated location), carrier_pickup (carrier collects from consumer address), in_store (returned at retail partner location).. Valid values are `mail_in|drop_off|carrier_pickup|in_store`',
    `return_number` STRING COMMENT 'Externally-visible, human-readable Return Merchandise Authorization (RMA) number assigned to this return request. Used in consumer communications, shipping labels, and customer service interactions. Sourced from Salesforce Consumer Goods Cloud or SAP SD returns order.. Valid values are `^RTN-[0-9]{10}$`',
    `return_policy_version` STRING COMMENT 'Version identifier of the return policy that was in effect at the time the return was requested. Ensures consistent policy application and supports audit trails for policy change impact analysis.',
    `return_quantity` STRING COMMENT 'Number of units of the product being returned in this return request. Used for inventory restock planning, refund calculation, and return rate KPI computation.',
    `return_reason` STRING COMMENT 'The return reason of the dtc return record',
    `return_reason_code` STRING COMMENT 'Standardized reason code explaining why the consumer is returning the product. Drives quality feedback loops, product improvement, and carrier claims. Valid values: defective (product malfunction), wrong_item (incorrect item shipped), changed_mind (consumer preference change), damaged_in_transit (carrier damage), not_as_described (product mismatch), missing_parts (incomplete product). [ENUM-REF-CANDIDATE: defective|wrong_item|changed_mind|damaged_in_transit|not_as_described|missing_parts — promote to reference product]. Valid values are `defective|wrong_item|changed_mind|damaged_in_transit|not_as_described|missing_parts`',
    `return_reason_description` STRING COMMENT 'Free-text narrative provided by the consumer describing the specific reason for the return. Supplements the standardized return reason code with qualitative detail for quality analysis and consumer service resolution.',
    `return_status` STRING COMMENT 'Current lifecycle state of the return request. Tracks the return workflow from initial consumer request through final resolution. Valid values: requested (consumer submitted), approved (return authorized), received (item received at warehouse), refunded (refund issued), rejected (return denied), cancelled (consumer cancelled). [ENUM-REF-CANDIDATE: requested|approved|received|refunded|rejected|cancelled — promote to reference product]. Valid values are `requested|approved|received|refunded|rejected|cancelled`',
    `return_window_eligible` BOOLEAN COMMENT 'Indicates whether the return request was submitted within the brands published return policy window (e.g., 30 days from delivery). Drives automated approval/rejection workflows and consumer communication.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether the return involves a consumer safety incident (e.g., injury, adverse reaction, product hazard). When true, triggers mandatory regulatory reporting workflows to FDA, CPSC, or EPA as applicable. Critical for product safety compliance and recall management.',
    `source_system_code` STRING COMMENT 'The source system code of the dtc return record',
    `uom` STRING COMMENT 'The uom of the dtc return record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this return record was last modified in the data platform. Used for incremental data processing, change data capture (CDC), and audit trail maintenance.',
    CONSTRAINT pk_dtc_return PRIMARY KEY(`dtc_return_id`)
) COMMENT 'Consumer return or refund request for a DTC order. Captures return request date, return reason code (defective, wrong item, changed mind, damaged in transit), return status (requested, approved, received, refunded, rejected), return method (mail-in, drop-off), refund amount, refund method (original payment, store credit, loyalty points), and associated order and order line references. Supports consumer satisfaction tracking and product quality feedback loops.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` (
    `nps_response_id` BIGINT COMMENT 'Unique surrogate identifier for each NPS survey response record in the Consumer Goods consumer feedback system. Primary key for the nps_response data product.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: NPS Survey Attribution ties each NPS response to the marketing campaign that triggered the survey for campaign effectiveness measurement.',
    `employee_id` BIGINT COMMENT 'Identifier of the consumer service agent or CRM user responsible for the closed-loop follow-up action on this NPS response. Enables agent-level performance tracking for consumer feedback management programs.',
    `interaction_id` BIGINT COMMENT 'The interaction id of the nps response record',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the CPG brand being evaluated in this NPS survey response. Enables brand health tracking and sentiment analysis at the brand level across the product portfolio.',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer or shopper who submitted the NPS survey response. Links to the consumer master profile in the SSOT consumer domain for CRM and personalization use cases.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU or product being evaluated in this NPS survey response. Nullable when the survey targets a brand or category rather than a specific product.',
    `survey_id` BIGINT COMMENT 'Reference to the NPS survey definition or campaign that triggered this response. Links to the survey master record defining the questionnaire, target audience, and campaign parameters.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the nps response record',
    `brand_name` STRING COMMENT 'Name of the CPG brand being evaluated in this NPS survey response. Stored denormalized for direct use in brand health reporting and consumer sentiment dashboards without requiring a join to the brand master.',
    `channel` STRING COMMENT 'The channel of the nps response record',
    `closed_loop_action_date` DATE COMMENT 'Date on which the closed-loop follow-up action was completed or resolved for this NPS response. Used to measure response time SLA compliance for consumer feedback management programs.',
    `closed_loop_status` STRING COMMENT 'Status of the closed-loop consumer feedback management action triggered by this NPS response. Tracks whether a follow-up action has been initiated, is in progress, resolved, or escalated — particularly critical for Detractor responses to recover consumer relationships.. Valid values are `Pending|In Progress|Resolved|Escalated|No Action`',
    `nps_response_code` STRING COMMENT 'The nps response code of the nps response record',
    `consent_flag` BOOLEAN COMMENT 'Indicates whether the consumer provided valid consent for their NPS survey response data to be collected, stored, and used for brand analytics and personalization purposes. Mandatory for GDPR and CCPA compliance in consumer data processing.',
    `consent_version` STRING COMMENT 'Version identifier of the privacy consent notice or terms accepted by the consumer at the time of survey submission. Required for GDPR and CCPA audit trails to demonstrate lawful basis for processing consumer feedback data.',
    `consumer_segment` STRING COMMENT 'Marketing segmentation label assigned to the consumer at the time of survey dispatch (e.g., Loyalist, Occasional Buyer, Lapsed, New Consumer). Enables NPS analysis by consumer segment for targeted closed-loop follow-up and personalization programs.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the consumer is located or where the purchase was made. Enables geographic NPS benchmarking and compliance with regional data privacy regulations (GDPR, CCPA).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NPS response record was first created in the Consumer Goods data platform (Databricks Silver Layer). Supports audit trail, data lineage, and GDPR data retention management.',
    `currency_code` STRING COMMENT 'The currency code of the nps response record',
    `data_source_system` STRING COMMENT 'Identifies the operational system of record from which this NPS response was ingested into the Databricks Silver Layer (e.g., Salesforce Consumer Goods Cloud, SAP S/4HANA, TradeEdge, Nielsen IQ, Custom Survey Platform, Third-Party Panel). Supports data lineage and audit traceability.. Valid values are `Salesforce|SAP|TradeEdge|Nielsen|Custom|Third-Party`',
    `nps_response_description` STRING COMMENT 'The nps response description of the nps response record',
    `device_type` STRING COMMENT 'Type of device used by the consumer to complete the NPS survey (Mobile, Desktop, Tablet, Smart TV, Other). Enables device-level response quality analysis and optimization of survey UX for digital consumer engagement programs.. Valid values are `Mobile|Desktop|Tablet|Smart TV|Other`',
    `effective_from` DATE COMMENT 'The effective from of the nps response record',
    `effective_until` DATE COMMENT 'The effective until of the nps response record',
    `follow_up_required_flag` BOOLEAN COMMENT 'The follow up required flag of the nps response record',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional BCP-47 region subtag) of the language in which the NPS survey was presented and the verbatim comment was captured. Required for multilingual text analytics and NLP processing of consumer verbatim feedback.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `loyalty_member_flag` BOOLEAN COMMENT 'Indicates whether the consumer who submitted this NPS response is an active member of the brands loyalty program at the time of survey. Enables comparison of NPS scores between loyalty members and non-members for CLTV and retention analysis.',
    `nps_response_name` STRING COMMENT 'The nps response name of the nps response record',
    `notes` STRING COMMENT 'The notes of the nps response record',
    `nps_category` STRING COMMENT 'The nps category of the nps response record',
    `nps_response_status` STRING COMMENT 'The nps response status of the nps response record',
    `nps_score` STRING COMMENT 'The consumers likelihood-to-recommend score on the standard NPS scale of 0 to 10, where 0 = extremely unlikely and 10 = extremely likely. This is the core quantitative measurement of consumer loyalty and brand advocacy for CPG brands.',
    `product_category` STRING COMMENT 'The consumer goods product category associated with the surveyed product or brand (e.g., Personal Care, Household Cleaning, Health & Wellness, Food & Beverage). Enables NPS benchmarking and brand health analysis at the category level for portfolio management.',
    `purchase_channel` STRING COMMENT 'The retail or distribution channel through which the consumer purchased the product prior to receiving this NPS survey (e.g., E-Commerce, Retail Store, DTC, Wholesale, DSD, Pharmacy). Enables channel-level NPS benchmarking for distribution and channel management strategy.. Valid values are `E-Commerce|Retail Store|DTC|Wholesale|DSD|Pharmacy`',
    `purchase_order_reference` STRING COMMENT 'Reference to the consumers purchase transaction (order number or POS transaction ID) that triggered this post-purchase NPS survey. Enables linkage of NPS scores to specific purchase events for CLTV and consumer journey analytics.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the nps response record',
    `record_source_system` STRING COMMENT 'The record source system of the nps response record',
    `repeat_buyer_flag` BOOLEAN COMMENT 'Indicates whether the consumer had made more than one purchase of the brand or product prior to submitting this NPS response. Enables differentiation of NPS scores between first-time and repeat buyers for consumer retention and NPD analytics.',
    `respondent_category` STRING COMMENT 'Classification of the consumer based on their NPS score: Promoter (score 9-10), Passive (score 7-8), or Detractor (score 0-6). Derived classification stored for direct use in brand health dashboards, consumer segmentation, and closed-loop follow-up prioritization.. Valid values are `Promoter|Passive|Detractor`',
    `response_date` DATE COMMENT 'The response date of the nps response record',
    `response_reference_number` STRING COMMENT 'Externally visible alphanumeric reference number assigned to this NPS survey response, used for closed-loop follow-up, consumer service case creation, and cross-system traceability (e.g., CRM ticket linkage).',
    `response_status` STRING COMMENT 'Current lifecycle status of the NPS survey response record: Submitted (complete response received), Partial (survey started but not completed), Abandoned (survey opened but no score entered), Invalid (failed validation rules), Closed (response processed and closed-loop action completed).. Valid values are `Submitted|Partial|Abandoned|Invalid|Closed`',
    `response_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) at which the consumer submitted the NPS survey response. Enables intraday analysis, response latency measurement, and audit trail for closed-loop feedback management.',
    `retailer_name` STRING COMMENT 'Name of the retail account or e-commerce platform where the consumer purchased the product. Enables retailer-level NPS analysis to support trade promotion management (TPM) and retail execution decisions.',
    `sentiment_label` STRING COMMENT 'Categorical sentiment classification derived from NLP analysis of the verbatim comment (Positive, Neutral, Negative, Mixed). Complements the numeric sentiment score for business-friendly reporting and consumer feedback dashboards.. Valid values are `Positive|Neutral|Negative|Mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Numeric sentiment polarity score derived from NLP analysis of the verbatim comment, ranging from -1.0 (most negative) to +1.0 (most positive). Stored as a business attribute to enable sentiment trend analysis and AI/ML consumer intelligence without re-processing raw text.',
    `source_response_ref` STRING COMMENT 'The native identifier of this NPS response record in the originating operational system of record (e.g., Salesforce Survey Response ID, SAP interaction record ID). Enables cross-system traceability and deduplication during Silver Layer ingestion.',
    `source_system_code` STRING COMMENT 'The source system code of the nps response record',
    `survey_channel` STRING COMMENT 'The communication channel through which the NPS survey was delivered to the consumer (e.g., Email, In-App, SMS, Post-Purchase, Web, IVR). Enables channel-level response rate analysis and omnichannel consumer engagement optimization. [ENUM-REF-CANDIDATE: Email|In-App|SMS|Post-Purchase|Web|IVR — promote to reference product]. Valid values are `Email|In-App|SMS|Post-Purchase|Web|IVR`',
    `survey_date` DATE COMMENT 'Calendar date on which the consumer submitted the NPS survey response. Used as the primary business event date for brand health trend analysis, period-over-period NPS reporting, and S&OP consumer sentiment inputs.',
    `survey_trigger_event` STRING COMMENT 'The business event that triggered the dispatch of this NPS survey to the consumer (e.g., Post-Purchase, Post-Delivery, Post-Support interaction, Periodic relationship survey, Event-Based, Onboarding). Enables analysis of NPS scores by consumer journey touchpoint.. Valid values are `Post-Purchase|Post-Delivery|Post-Support|Periodic|Event-Based|Onboarding`',
    `survey_version` STRING COMMENT 'Version identifier of the NPS survey questionnaire used to capture this response. Ensures comparability of NPS scores across survey redesigns and supports longitudinal brand health trend analysis.',
    `topic_tags` STRING COMMENT 'Comma-separated list of business topic labels extracted from the verbatim comment via NLP text classification (e.g., packaging,scent,value-for-money,availability). Enables topic-level consumer feedback analysis for product development, quality, and marketing teams.',
    `touchpoint` STRING COMMENT 'The touchpoint of the nps response record',
    `uom` STRING COMMENT 'The uom of the nps response record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this NPS response record was last modified in the Consumer Goods data platform. Tracks updates from closed-loop status changes, sentiment scoring, or data quality corrections. Supports audit trail and GDPR data accuracy requirements.',
    `verbatim_comment` STRING COMMENT 'Free-text open-ended comment provided by the consumer explaining their NPS score. Contains qualitative consumer sentiment, product feedback, and brand perception insights used for text analytics, sentiment analysis, and AI/ML-driven consumer intelligence programs.',
    CONSTRAINT pk_nps_response PRIMARY KEY(`nps_response_id`)
) COMMENT 'Net Promoter Score (NPS) survey response captured from a consumer. Stores survey date, survey channel (email, in-app, SMS, post-purchase), NPS score (0-10), promoter/passive/detractor classification, verbatim comment, product or brand surveyed, survey campaign reference, and response status. Enables brand health tracking, consumer sentiment analysis, and closed-loop consumer feedback management for CPG brands.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Unique surrogate identifier for each consumer interaction record in the silver layer lakehouse. Primary key for this data product.',
    `account_call_id` BIGINT COMMENT 'Foreign key linking to sales.account_call. Business justification: Customer service interactions often trigger sales account calls; linking allows tracking follow‑up actions and performance metrics.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Customer Service Attribution links interactions to the originating marketing campaign to evaluate campaign‑driven support volume.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Support interactions incur costs that must be charged to a cost center for service‑cost analysis.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Customer service logs need to reference the DC responsible for a delivery issue to drive escalation and performance tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the human agent or bot/automation entity currently assigned to handle this interaction. Supports workload balancing, agent performance analytics, and escalation tracking.',
    `environmental_incident_id` BIGINT COMMENT 'Foreign key linking to sustainability.environmental_incident. Business justification: Captures consumer‑reported product incidents and ties them to environmental incident tracking for compliance and remediation.',
    `household_id` BIGINT COMMENT 'The household id of the interaction record',
    `interaction_session_id` BIGINT COMMENT 'The interaction session id of the interaction record',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Customer service interactions about delivery status must reference the specific shipment to provide accurate updates and log issues.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program membership associated with the consumer at the time of interaction. Enables loyalty-tier-based service differentiation and CLTV-linked interaction analysis.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand associated with this consumer interaction. Enables brand-level aggregation of consumer sentiment, complaint volumes, and NPS impact analysis.',
    `parent_interaction_id` BIGINT COMMENT 'Self-referencing identifier linking this interaction to a parent case when it is a follow-up, escalation, or sub-case of a prior interaction. Enables interaction hierarchy and repeat-contact chain analysis.',
    `product_complaint_id` BIGINT COMMENT 'Foreign key linking to quality.product_complaint. Business justification: Customer service process records each interaction against the specific product complaint it addresses for root‑cause tracking.',
    `retail_store_id` BIGINT COMMENT 'Reference to the retail account or store where the consumer purchased the product referenced in this interaction. Supports retail execution quality analysis, DSD complaint tracking, and trade partner performance reporting.',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer profile record who initiated or is associated with this interaction. Links to the consumer master data product.',
    `sku_id` BIGINT COMMENT 'Reference to the specific product (SKU) associated with this consumer interaction, such as the product being complained about, inquired about, or referenced in a feedback submission.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Support interactions tied to a specific trade account enable account‑level SLA tracking and issue resolution reporting.',
    `adverse_event_flag` BOOLEAN COMMENT 'Indicates whether this interaction has been classified as an adverse event report (e.g., allergic reaction, injury, illness linked to product use). Triggers mandatory regulatory reporting workflows under FDA, CPSC, and EU REACH regulations.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the interaction record',
    `batch_number` STRING COMMENT 'Manufacturing batch or lot number of the product referenced in this interaction, as reported by the consumer. Critical for adverse event investigations, product recalls, and GMP traceability under FDA and ISO 22716 requirements.',
    `case_number` STRING COMMENT 'Externally visible, human-readable case or ticket reference number assigned by the CRM system (e.g., Salesforce Consumer Goods Cloud) at the time the interaction is logged. Used for consumer-facing communication and SLA tracking.. Valid values are `^[A-Z]{2,4}-[0-9]{6,12}$`',
    `channel` STRING COMMENT 'The consumer-facing touchpoint channel through which this interaction was initiated. Supports omnichannel analytics and channel performance reporting. [ENUM-REF-CANDIDATE: call_center|live_chat|email|social_media|in_app|retail|web_form — promote to reference product]',
    `interaction_code` STRING COMMENT 'The interaction code of the interaction record',
    `consumer_consent_flag` BOOLEAN COMMENT 'Indicates whether the consumer provided explicit consent for their interaction data to be used for quality improvement, marketing analytics, or regulatory reporting purposes at the time of the interaction.',
    `contact_reason_code` STRING COMMENT 'Standardized code categorizing the specific reason for consumer contact (e.g., product defect, packaging issue, allergic reaction, pricing query, loyalty redemption). Enables granular root cause analysis and product quality reporting. [ENUM-REF-CANDIDATE: promote to reference product with full taxonomy]',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country from which the consumer interaction originated. Used for jurisdictional compliance routing (GDPR vs CCPA), regulatory reporting, and geographic performance analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this interaction record was first persisted in the system of record. May differ from interaction_timestamp if the case was logged retrospectively.',
    `currency_code` STRING COMMENT 'The currency code of the interaction record',
    `data_retention_expiry_date` DATE COMMENT 'The date after which this interaction record must be purged or anonymized in compliance with GDPR right-to-erasure and CCPA data retention policies. Calculated based on interaction type and applicable jurisdiction.',
    `interaction_description` STRING COMMENT 'Full narrative text of the consumer interaction as captured by the agent or automated system. Contains the consumers verbatim concern, inquiry, or feedback. Classified confidential due to potential inclusion of personal context.',
    `device_type` STRING COMMENT 'The device type of the interaction record',
    `direction` STRING COMMENT 'The direction of the interaction record',
    `duration_seconds` STRING COMMENT 'Total duration of the consumer interaction in seconds, applicable primarily to real-time channels (call center, live chat). Used for agent efficiency KPIs, average handle time (AHT) reporting, and capacity planning.',
    `effective_from` DATE COMMENT 'The effective from of the interaction record',
    `effective_until` DATE COMMENT 'The effective until of the interaction record',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this interaction was escalated to a higher-tier support team, supervisor, or regulatory body during its lifecycle. Drives escalation workflow reporting and quality management reviews.',
    `escalation_reason` STRING COMMENT 'Categorical reason why the interaction was escalated. Null if escalation_flag is False. Supports root cause analysis and process improvement initiatives. [ENUM-REF-CANDIDATE: sla_breach|consumer_request|regulatory_requirement|repeat_contact|safety_concern|management_review — promote to reference product]. Valid values are `sla_breach|consumer_request|regulatory_requirement|repeat_contact|safety_concern|management_review`',
    `interaction_status` STRING COMMENT 'Current lifecycle state of the interaction within the CRM case management workflow. Drives SLA monitoring, escalation triggers, and operational dashboards.. Valid values are `new|in_progress|pending_consumer|resolved|closed|escalated`',
    `interaction_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consumer interaction was initiated or first recorded. This is the principal real-world event time used for SLA calculation, trend analysis, and regulatory reporting.',
    `interaction_type` STRING COMMENT 'Classification of the nature of the consumer touchpoint. Drives routing, SLA assignment, and regulatory reporting workflows. adverse_event_report triggers mandatory escalation per FDA/CPSC requirements.. Valid values are `inquiry|complaint|compliment|product_feedback|adverse_event_report|return_request`',
    `is_bot_handled` BOOLEAN COMMENT 'Indicates whether this interaction was fully or partially handled by an automated bot or virtual assistant without human agent involvement. Used to measure automation rate and bot containment KPIs.',
    `language_code` STRING COMMENT 'BCP 47 language code indicating the language in which the consumer interaction was conducted (e.g., en-US, fr-FR, es-MX). Drives multilingual routing, translation workflows, and regional analytics.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Audit timestamp of the most recent update to this interaction record. Used for incremental data pipeline processing and change tracking in the silver layer.',
    `interaction_name` STRING COMMENT 'The interaction name of the interaction record',
    `notes` STRING COMMENT 'The notes of the interaction record',
    `nps_score` STRING COMMENT 'Net Promoter Score (NPS) rating provided by the consumer following interaction resolution, on a scale of 0-10. Used to calculate brand NPS, track consumer loyalty, and measure service quality outcomes.',
    `outcome` STRING COMMENT 'The outcome of the interaction record',
    `priority_level` STRING COMMENT 'Business priority assigned to the interaction, determining routing urgency and SLA tier. Critical priority is automatically assigned to adverse event reports and regulatory complaints per CPSC and FDA guidelines.. Valid values are `critical|high|medium|low`',
    `purchase_date` DATE COMMENT 'Date on which the consumer purchased the product referenced in this interaction, as reported by the consumer or verified via POS/loyalty data. Used for warranty validation, product age assessment, and adverse event timeline analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the interaction record',
    `record_source_system` STRING COMMENT 'The record source system of the interaction record',
    `regulatory_report_number` STRING COMMENT 'Reference number assigned when this interaction triggers a mandatory regulatory submission (e.g., FDA MedWatch report number, CPSC incident report ID). Null if no regulatory report was filed.',
    `repeat_contact_flag` BOOLEAN COMMENT 'Indicates whether this interaction is a follow-up or repeat contact from the same consumer regarding the same issue within a defined lookback window. Key metric for first-contact resolution (FCR) KPI measurement.',
    `resolution_notes` STRING COMMENT 'Agent-authored narrative documenting the resolution actions taken, root cause identified, and outcome communicated to the consumer. Supports quality audits and repeat-contact analysis.',
    `resolution_status` STRING COMMENT 'The resolution status of the interaction record',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the consumer interaction was formally resolved or closed. Used to calculate actual resolution time against SLA targets and for consumer satisfaction measurement.',
    `resolution_type` STRING COMMENT 'Categorical classification of the resolution action taken to close this interaction. Drives cost-of-service analytics, consumer satisfaction correlation, and resolution effectiveness reporting. [ENUM-REF-CANDIDATE: refund|replacement|coupon|apology|information_provided|no_action_required|regulatory_referral — promote to reference product]',
    `sentiment_label` STRING COMMENT 'Categorical sentiment classification derived from the sentiment_score or manual agent tagging. Used for quick-filter reporting and consumer satisfaction trend analysis.. Valid values are `positive|neutral|negative|mixed`',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Numeric sentiment classification score derived from NLP analysis of the interaction text, ranging from -1.0 (most negative) to +1.0 (most positive). Feeds consumer sentiment dashboards and brand health monitoring.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the interaction exceeded its defined SLA target resolution time. True if resolution_timestamp minus interaction_timestamp exceeds sla_target_hours. Drives escalation and quality reporting.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'The contracted or policy-defined maximum number of hours within which this interaction must be resolved, based on interaction type and channel. Used for SLA compliance reporting and KPI dashboards.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this interaction record was ingested into the silver layer lakehouse. Supports data lineage, reconciliation, and multi-system deduplication.. Valid values are `SFDC_CGC|SAP_S4|ORACLE_CX|SOCIAL_LISTENER|IN_APP|EMAIL_GATEWAY`',
    `subject` STRING COMMENT 'Brief, structured subject line or title summarizing the consumer interaction. Used for case categorization, search, and reporting in CRM systems.',
    `touchpoint` STRING COMMENT 'The touchpoint of the interaction record',
    `uom` STRING COMMENT 'The uom of the interaction record',
    `upc_code` STRING COMMENT 'The Universal Product Code (UPC) or GTIN of the product as reported or scanned by the consumer. Enables precise product identification when the consumer provides packaging information, supporting recall and quality investigations.. Valid values are `^[0-9]{12,14}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the interaction record',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Record of every consumer touchpoint across service and engagement channels (call center, live chat, email, social media, in-app, retail). Captures interaction type (inquiry, complaint, compliment, product feedback, adverse event report), resolution workflow (status, resolution date, assigned agent/bot), sentiment classification, and referenced product/brand. Serves as the operational backbone for CRM case management, SLA tracking, consumer satisfaction measurement, and escalation workflows.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` (
    `subscription_id` BIGINT COMMENT 'Primary key for subscription',
    `address_id` BIGINT COMMENT 'The billing address id of the subscription record',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center assigned to fulfill this subscriptions orders. Supports DRP (Distribution Requirements Planning) and inventory allocation across the supply chain network.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program membership associated with this subscription, enabling loyalty points accrual on subscription orders and subscriber-exclusive rewards. Links subscription revenue to CLTV (Customer Lifetime Value) calculations.',
    `shipping_address_id` BIGINT COMMENT 'The shipping address id of the subscription record',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer profile who owns this subscription. Links to the SSOT consumer master record for CRM and personalization.',
    `sku_id` BIGINT COMMENT 'Reference to the primary SKU enrolled in this subscription. Identifies the specific product variant (size, flavor, format) the consumer has subscribed to for auto-replenishment.',
    `subscription_delivery_address_id` BIGINT COMMENT 'Reference to the consumers preferred delivery address for subscription fulfillment. Links to the address master for DSD (Direct Store Delivery) routing and last-mile logistics planning via Blue Yonder WMS.',
    `acquisition_source` STRING COMMENT 'Marketing source or campaign that drove the consumer to subscribe (e.g., email campaign code, paid search, influencer referral, loyalty program). Used for marketing ROI (Return on Investment) attribution and SOV (Share of Voice) analysis.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the subscription record',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the subscription is configured to automatically renew at the end of each billing cycle (True) or requires explicit consumer action to continue (False). Governs recurring revenue recognition and consumer notification obligations.',
    `billing_cycle_day` STRING COMMENT 'Day of the month (1–31) on which the subscription billing charge is processed. Governs the recurring payment schedule and aligns with the consumers preferred billing date. Used in accounts receivable and DSO (Days Sales Outstanding) reporting.',
    `billing_frequency` STRING COMMENT 'The billing frequency of the subscription record',
    `cancellation_date` DATE COMMENT 'Calendar date on which the consumer formally cancelled the subscription. Distinct from end_date (which may be a future scheduled end). Used in churn cohort analysis and subscription tenure reporting.',
    `cancellation_reason` STRING COMMENT 'Consumer-stated or system-derived reason for cancelling the subscription. Populated when subscription_status transitions to cancelled. Critical input for churn analysis, NPS (Net Promoter Score) correlation, and consumer retention strategy.. Valid values are `price_too_high|product_dissatisfaction|found_alternative|no_longer_needed|financial_hardship|other`',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the consumer has exercised their CCPA right to opt out of the sale or sharing of personal data associated with this subscription (True = opted out). Mandatory for California consumers. Drives data sharing restrictions downstream.',
    `channel` STRING COMMENT 'Sales channel through which the subscription was originally acquired (e.g., dtc_web, dtc_mobile). Supports DTC (Direct to Consumer) channel performance analysis, attribution reporting, and consumer acquisition cost tracking.. Valid values are `dtc_web|dtc_mobile|dtc_app|retail_partner|voice_assistant`',
    `subscription_code` STRING COMMENT 'The subscription code of the subscription record',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the subscription record was first created in the platform. Represents RECORD_AUDIT_CREATED. Used for data lineage, audit trails, and subscription cohort analysis.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the subscription billing currency (e.g., USD, EUR, GBP). Required for multi-currency DTC operations and financial consolidation reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_frequency` STRING COMMENT 'The delivery frequency of the subscription record',
    `subscription_description` STRING COMMENT 'The subscription description of the subscription record',
    `discount_pct` DECIMAL(18,2) COMMENT 'The discount pct of the subscription record',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the subscription price per billing cycle, expressed as a decimal (e.g., 0.1500 = 15%). Reflects subscriber loyalty pricing, promotional offers, or TPM (Trade Promotion Management) funded discounts.',
    `effective_from` DATE COMMENT 'The effective from of the subscription record',
    `effective_until` DATE COMMENT 'The effective until of the subscription record',
    `end_date` DATE COMMENT 'Calendar date on which the subscription is scheduled to end or was terminated. Null for open-ended subscriptions. Represents EFFECTIVE_UNTIL for this agreement. Populated on cancellation or plan expiry.',
    `failed_payment_count` STRING COMMENT 'Cumulative number of failed payment attempts on this subscription since inception. Used to trigger dunning workflows, payment retry logic, and subscription suspension rules. Key indicator for revenue leakage management.',
    `frequency` STRING COMMENT 'Cadence at which the subscription order is automatically triggered and fulfilled. Drives the replenishment schedule and next order date calculation. Key input for demand planning and S&OP forecasting.. Valid values are `weekly|bi_weekly|monthly|bi_monthly|quarterly`',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the consumer has provided explicit GDPR-compliant consent for data processing associated with this subscription (True) or not (False). Mandatory for EU consumers. Supports regulatory compliance and data governance audits.',
    `last_order_date` DATE COMMENT 'Calendar date of the most recently fulfilled subscription order. Used to validate subscription activity, detect stalled subscriptions, and support FEFO (First Expired First Out) inventory allocation for replenishment.',
    `subscription_name` STRING COMMENT 'The subscription name of the subscription record',
    `net_price` DECIMAL(18,2) COMMENT 'Actual amount charged to the consumer per billing cycle after applying the discount rate. Equals subscription_price × (1 - discount_rate). Used in revenue recognition, COGS (Cost of Goods Sold) analysis, and financial reporting.',
    `next_billing_date` DATE COMMENT 'The next billing date of the subscription record',
    `next_delivery_date` DATE COMMENT 'The next delivery date of the subscription record',
    `next_order_date` DATE COMMENT 'Scheduled calendar date for the next automatic order generation under this subscription. Used by fulfillment systems for ATP (Available to Promise) checks and demand sensing. Updated after each successful order cycle.',
    `next_renewal_date` DATE COMMENT 'The next renewal date of the subscription record',
    `notes` STRING COMMENT 'The notes of the subscription record',
    `nps_score` STRING COMMENT 'Most recent NPS (Net Promoter Score) survey response from the subscriber, on a scale of 0–10. Used to correlate subscription satisfaction with churn risk and to segment consumers for retention and advocacy programs.',
    `pause_end_date` DATE COMMENT 'Calendar date on which the subscription pause is scheduled to end and auto-replenishment is set to resume. Null if the pause is indefinite. Used in demand forecasting to anticipate reactivation volumes.',
    `pause_flag` BOOLEAN COMMENT 'The pause flag of the subscription record',
    `pause_reason` STRING COMMENT 'Consumer-stated reason for pausing the subscription. Populated when subscription_status transitions to paused. Used in consumer retention analysis and proactive re-engagement campaign targeting.. Valid values are `financial_hardship|travel|product_overstock|temporary_unavailability|other`',
    `pause_start_date` DATE COMMENT 'Calendar date on which the consumer-initiated subscription pause became effective. Used to calculate pause duration and adjust next_order_date upon resumption. Supports consumer retention lifecycle tracking.',
    `payment_method` STRING COMMENT 'The payment method of the subscription record',
    `payment_method_type` STRING COMMENT 'Category of payment instrument used for recurring subscription billing (e.g., credit_card, digital_wallet). Stored as a type reference only — no raw card or account data is stored here per PCI DSS compliance. Supports payment failure analysis and retry logic.. Valid values are `credit_card|debit_card|digital_wallet|bank_transfer|gift_card`',
    `payment_token_reference` STRING COMMENT 'Tokenized reference identifier for the consumers stored payment method, issued by the payment processor vault. Never contains raw card or bank account data. Used to initiate recurring charges without storing PCI-sensitive data. Compliant with PCI DSS tokenization requirements.',
    `plan_name` STRING COMMENT 'The plan name of the subscription record',
    `price` DECIMAL(18,2) COMMENT 'Gross price charged to the consumer per billing cycle before any discounts are applied. Expressed in the subscriptions billing currency. Used in subscription revenue forecasting and CLTV (Customer Lifetime Value) calculations.',
    `price_per_cycle` DECIMAL(18,2) COMMENT 'The price per cycle of the subscription record',
    `promotion_code` STRING COMMENT 'Trade promotion or marketing coupon code applied at subscription enrollment that governs the discount_rate or introductory pricing. Ties the subscription to a TPM (Trade Promotion Management) campaign for ROI measurement.',
    `quantity` STRING COMMENT 'Number of units of the subscribed SKU to be fulfilled per order cycle. Drives replenishment volume, inventory reservation, and demand planning inputs for S&OP (Sales and Operations Planning).',
    `record_source_system` STRING COMMENT 'The record source system of the subscription record',
    `recurring_amount` DECIMAL(18,2) COMMENT 'The recurring amount of the subscription record',
    `source_system_code` STRING COMMENT 'The source system code of the subscription record',
    `start_date` DATE COMMENT 'Calendar date on which the subscription became effective and the first order cycle was initiated. Represents EFFECTIVE_FROM for this agreement. Used in cohort analysis and subscription tenure calculations.',
    `subscription_number` STRING COMMENT 'Externally visible, human-readable subscription reference number communicated to the consumer in confirmation emails, invoices, and customer service interactions. Serves as the BUSINESS_IDENTIFIER for this agreement.. Valid values are `^SUB-[A-Z0-9]{8,16}$`',
    `subscription_status` STRING COMMENT 'Current lifecycle state of the subscription. active = fulfilling orders; paused = consumer-initiated hold; cancelled = permanently terminated; pending = awaiting first payment confirmation; expired = plan term ended without renewal. Drives LIFECYCLE_STATUS for this MASTER_AGREEMENT entity.. Valid values are `active|paused|cancelled|pending|expired`',
    `subscription_type` STRING COMMENT 'Classification of the subscription program type. auto_replenishment covers single-SKU DTC replenishment; subscription_box covers curated multi-product boxes; bundle covers fixed product bundles; trial covers introductory trial subscriptions.. Valid values are `auto_replenishment|subscription_box|bundle|trial`',
    `total_orders_fulfilled` STRING COMMENT 'Cumulative count of successfully fulfilled subscription orders since the subscription start date. Non-derived operational counter maintained by the fulfillment system. Used in subscription tenure analysis and OTIF (On Time In Full) performance tracking.',
    `trial_end_date` DATE COMMENT 'Calendar date on which the trial period ends and standard subscription billing commences. Null for non-trial subscriptions. Used to trigger trial-to-paid conversion communications and revenue recognition timing.',
    `trial_flag` BOOLEAN COMMENT 'Indicates whether this subscription was initiated as a trial or introductory offer (True) or as a standard paid subscription (False). Used to segment trial-to-paid conversion analytics and NPD (New Product Development) launch performance.',
    `uom` STRING COMMENT 'The uom of the subscription record',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to the subscription record. Represents RECORD_AUDIT_UPDATED. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit compliance.',
    CONSTRAINT pk_subscription PRIMARY KEY(`subscription_id`)
) COMMENT 'Consumer subscription record for DTC auto-replenishment or subscription box programs. Stores subscription plan name, subscribed SKU(s), subscription frequency (weekly, monthly, bi-monthly), subscription status (active, paused, cancelled), start date, next order date, billing cycle, subscription price, discount rate, payment method reference, and cancellation reason if applicable. Enables subscription revenue forecasting and consumer retention management for CPG DTC channels.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` (
    `cltv_record_id` BIGINT COMMENT 'Unique surrogate identifier for each Customer Lifetime Value (CLTV) record. Primary key for this entity in the Silver Layer lakehouse.',
    `household_id` BIGINT COMMENT 'The household id of the cltv record record',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program in which this consumer is enrolled at the time of CLTV calculation. Loyalty membership status is a key behavioral modifier in CLTV model inputs.',
    `marketing_brand_id` BIGINT COMMENT 'The marketing brand id of the cltv record record',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer profile for whom this CLTV record is calculated. Links to the SSOT consumer master in the Consumer domain.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the cltv record record',
    `aov` DECIMAL(18,2) COMMENT 'Average net revenue per transaction for this consumer, calculated over the historical observation window used in the CLTV model. Key behavioral input metric reflecting per-transaction spending level.',
    `calculation_date` DATE COMMENT 'The business date on which this CLTV record was computed. Used to track the temporal snapshot of the consumers economic value and to support trend analysis over time.',
    `calculation_method` STRING COMMENT 'The calculation method of the cltv record record',
    `calculation_status` STRING COMMENT 'Lifecycle status of this CLTV record indicating whether the calculation completed successfully, is pending, failed validation, or has been superseded by a newer calculation for the same consumer.. Valid values are `completed|pending|failed|superseded`',
    `churn_probability` DECIMAL(18,2) COMMENT 'Model-estimated probability (0.0000–1.0000) that this consumer will cease purchasing within the next 12 months. Used to identify at-risk consumers for retention campaigns and to discount future revenue predictions.',
    `cltv_band` STRING COMMENT 'The cltv band of the cltv record record',
    `cltv_record_status` STRING COMMENT 'The cltv record status of the cltv record record',
    `cltv_score` DECIMAL(18,2) COMMENT 'The composite CLTV monetary value representing the net present value of all future cash flows attributed to this consumer relationship, as computed by the CLTV model. Primary metric for consumer investment prioritization.',
    `cltv_segment` STRING COMMENT 'The cltv segment of the cltv record record',
    `cltv_tier` STRING COMMENT 'Categorical tier classifying the consumers economic value relative to the overall consumer base. Used for investment prioritization, personalized engagement strategy, and resource allocation across CRM and trade promotion programs.. Valid values are `high|medium|low`',
    `cltv_value` DECIMAL(18,2) COMMENT 'The cltv value of the cltv record record',
    `cltv_record_code` STRING COMMENT 'The cltv record code of the cltv record record',
    `confidence_score` DECIMAL(18,2) COMMENT 'The confidence score of the cltv record record',
    `consent_status` STRING COMMENT 'Current consent status of the consumer for use of their personal data in CLTV modeling and personalized engagement. Ensures CLTV-driven activation complies with GDPR and CCPA consent requirements.. Valid values are `granted|withdrawn|pending|not_required`',
    `consumer_tenure_days` STRING COMMENT 'Number of days between the consumers first purchase date and the CLTV calculation date. Represents the length of the consumer relationship and is used to normalize lifetime revenue metrics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CLTV record was first written to the Silver Layer. Provides the audit trail creation anchor for data lineage and compliance purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary CLTV values (historical revenue, predicted revenue, AOV, CLTV score) are expressed. Supports multi-currency consumer bases across global markets.. Valid values are `^[A-Z]{3}$`',
    `data_completeness_score` DECIMAL(18,2) COMMENT 'Score (0.0000–1.0000) reflecting the proportion of required CLTV model input fields that were available and valid for this consumer at calculation time. Supports data quality monitoring and model input auditability.',
    `data_processing_basis` STRING COMMENT 'Legal basis under GDPR Article 6 for processing this consumers personal data in CLTV calculations. Required for regulatory compliance documentation and data subject rights management.. Valid values are `consent|legitimate_interest|contract|legal_obligation`',
    `days_since_last_purchase` STRING COMMENT 'Number of days elapsed between the consumers last purchase date and the CLTV calculation date. Primary recency metric used in churn probability modeling and re-engagement targeting.',
    `cltv_record_description` STRING COMMENT 'The cltv record description of the cltv record record',
    `discount_rate` DECIMAL(18,2) COMMENT 'Annual discount rate (0.0000–1.0000) applied in the net present value calculation of future consumer cash flows within the CLTV model. Reflects the time value of money and cost of capital assumptions.',
    `effective_from` DATE COMMENT 'The effective from of the cltv record record',
    `effective_from_timestamp` TIMESTAMP COMMENT 'Timestamp from which this CLTV record is considered the current active record for the consumer. Supports slowly changing dimension (SCD) Type 2 history management in the Silver Layer.',
    `effective_until` DATE COMMENT 'The effective until of the cltv record record',
    `effective_until_timestamp` TIMESTAMP COMMENT 'Timestamp until which this CLTV record is considered active. Null indicates the current active record. Supports SCD Type 2 history management and point-in-time querying in the Silver Layer.',
    `first_purchase_date` DATE COMMENT 'Date of the consumers first recorded purchase transaction. Used to calculate consumer tenure, cohort assignment, and to contextualize lifetime revenue figures.',
    `historical_value` DECIMAL(18,2) COMMENT 'The historical value of the cltv record record',
    `input_data_summary` STRING COMMENT 'Human-readable summary of the key data sources and input signals used in this CLTV calculation (e.g., POS transactions, loyalty events, NPS surveys). Supports auditability and model explainability for business stakeholders.',
    `last_purchase_date` DATE COMMENT 'Date of the consumers most recent purchase transaction prior to the calculation date. Key recency signal used in churn probability estimation and RFM (Recency, Frequency, Monetary) analysis.',
    `model_confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence score (0.0000–1.0000) assigned by the CLTV model to this records predictions, reflecting data completeness and model certainty. Low-confidence records may be flagged for manual review or excluded from activation.',
    `model_version` STRING COMMENT 'Version identifier of the CLTV predictive model used to generate this record (e.g., v1.0, v2.3). Enables model governance, reproducibility, and comparison across model iterations.. Valid values are `^vd+.d+(.d+)?$`',
    `cltv_record_name` STRING COMMENT 'The cltv record name of the cltv record record',
    `notes` STRING COMMENT 'The notes of the cltv record record',
    `nps_category` STRING COMMENT 'NPS classification of the consumer based on their most recent NPS score: Promoter (9–10), Passive (7–8), or Detractor (0–6). Used in consumer engagement strategy and churn risk segmentation.. Valid values are `promoter|passive|detractor`',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) recorded for this consumer at or prior to the calculation date, on a scale of 0–10. Used as a satisfaction and advocacy signal that modulates churn probability and CLTV tier assignment.',
    `observation_window_months` STRING COMMENT 'Number of months of historical transaction data used as the lookback period for computing behavioral inputs (AOV, purchase frequency) in this CLTV calculation. Governs the scope of historical data ingested.',
    `personalization_eligible` BOOLEAN COMMENT 'Indicates whether this consumer is eligible for CLTV-driven personalized marketing and engagement activation, based on consent status, suppression flags, and data quality thresholds.',
    `predicted_cltv` DECIMAL(18,2) COMMENT 'The predicted cltv of the cltv record record',
    `predicted_horizon_months` STRING COMMENT 'The predicted horizon months of the cltv record record',
    `predicted_revenue_12m` DECIMAL(18,2) COMMENT 'Model-predicted net revenue expected from this consumer over the next 12 months from the calculation date. Core output of the CLTV model used for short-term investment and engagement decisions.',
    `predicted_revenue_24m` DECIMAL(18,2) COMMENT 'Model-predicted net revenue expected from this consumer over the next 24 months from the calculation date. Supports medium-term consumer investment planning and loyalty program design.',
    `prediction_horizon_months` STRING COMMENT 'Number of months into the future for which the CLTV model projects consumer revenue. Defines the forward-looking scope of the CLTV score and predicted revenue fields.',
    `previous_cltv_score` DECIMAL(18,2) COMMENT 'The CLTV score from the immediately preceding calculation run for this consumer. Enables trend analysis, score movement tracking, and tier transition monitoring over time.',
    `previous_cltv_tier` STRING COMMENT 'The CLTV tier assigned in the immediately preceding calculation run for this consumer. Used to detect tier upgrades or downgrades and trigger corresponding engagement or retention actions.. Valid values are `high|medium|low`',
    `primary_brand_code` STRING COMMENT 'Code identifying the brand with the highest share of this consumers historical spend. Used to align CLTV-driven investment decisions with brand-level marketing and trade promotion strategies.',
    `primary_category_code` STRING COMMENT 'Code identifying the product category (e.g., personal care, household, health) representing the largest share of this consumers historical spend. Supports category-level personalization and NPD targeting.',
    `primary_channel` STRING COMMENT 'The dominant channel through which this consumer makes purchases, as determined over the historical observation window. Supports channel-specific engagement strategy and DTC vs. retail investment decisions. [ENUM-REF-CANDIDATE: dtc|ecommerce|retail|wholesale|loyalty_app|other — promote to reference product if channel taxonomy expands]. Valid values are `dtc|ecommerce|retail|wholesale|loyalty_app|other`',
    `purchase_frequency` DECIMAL(18,2) COMMENT 'Average number of purchase transactions made by this consumer per year over the historical observation window. Core behavioral driver in the CLTV model alongside AOV and churn probability.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the cltv record record',
    `record_source_system` STRING COMMENT 'The record source system of the cltv record record',
    `revenue_12m_historical` DECIMAL(18,2) COMMENT 'Total net revenue generated by this consumer in the trailing 12-month period prior to the calculation date. Sourced from POS and DTC transaction records. Used as a key input to CLTV model training and validation.',
    `revenue_24m_historical` DECIMAL(18,2) COMMENT 'Total net revenue generated by this consumer in the trailing 24-month period prior to the calculation date. Provides a longer-horizon view of consumer spending behavior for model calibration.',
    `revenue_lifetime_historical` DECIMAL(18,2) COMMENT 'Total net revenue generated by this consumer since their first recorded transaction with the business. Represents the full realized economic value of the consumer relationship to date.',
    `source_system_code` STRING COMMENT 'The source system code of the cltv record record',
    `tier_change_flag` BOOLEAN COMMENT 'Indicates whether this consumers CLTV tier has changed compared to the previous calculation run. Triggers downstream CRM workflows for tier-transition communications and loyalty reward adjustments.',
    `transaction_count_lifetime` STRING COMMENT 'Total number of purchase transactions recorded for this consumer since their first transaction. Used as a behavioral richness indicator and model input for purchase frequency normalization.',
    `uom` STRING COMMENT 'The uom of the cltv record record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this CLTV record in the Silver Layer. Used for incremental processing, data freshness monitoring, and audit trail completeness.',
    CONSTRAINT pk_cltv_record PRIMARY KEY(`cltv_record_id`)
) COMMENT 'Calculated Customer Lifetime Value (CLTV) record for a consumer capturing the current and projected economic value of the consumer relationship. Stores CLTV calculation date, CLTV model version, historical revenue (12-month, 24-month, lifetime), predicted future revenue (12-month, 24-month), average order value (AOV), purchase frequency, churn probability, CLTV tier (high, medium, low), and data inputs summary. Supports consumer investment prioritization and personalized engagement strategy.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` (
    `communication_preference_id` BIGINT COMMENT 'Unique surrogate identifier for each consumer communication preference record in the Consumer Goods lakehouse silver layer. Serves as the primary key for this entity.',
    `consent_record_id` BIGINT COMMENT 'Reference to the associated legal consent record in the consent_record product. This preference record captures the consumers desired engagement experience; the consent_record captures the legal basis. These are distinct but linked. Null if no formal consent record is linked.',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program associated with this communication preference. Enables loyalty-program-specific communication preferences, such as points balance alerts or tier upgrade notifications, distinct from general brand communications.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the specific brand for which this communication preference applies. Enables brand-level preference management across a multi-brand Consumer Goods portfolio.',
    `preference_center_id` BIGINT COMMENT 'The preference center id of the communication preference record',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer profile who owns this communication preference record. Links to the consumer master in the Consumer domain.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the communication preference record',
    `campaign_exclusion_flag` BOOLEAN COMMENT 'Indicates whether the consumer has requested exclusion from all campaign-based communications (True) while still receiving transactional messages. Distinct from global opt-out — the consumer remains reachable for order confirmations, recalls, and service messages.',
    `capture_touchpoint` STRING COMMENT 'The consumer-facing touchpoint or interaction channel through which this preference was originally captured. Distinct from source_system (which is the back-end system). Used for consumer journey analytics and preference capture optimization. [ENUM-REF-CANDIDATE: website|mobile_app|in_store|call_center|loyalty_enrollment|promotion|qr_code — 7 candidates stripped; promote to reference product]',
    `channel` STRING COMMENT 'The channel of the communication preference record',
    `channel_type` STRING COMMENT 'The communication channel to which this preference record applies. Governs how the brand may contact the consumer. Examples include email, SMS, push notification, direct mail, phone, and in-app messaging. [ENUM-REF-CANDIDATE: email|sms|push_notification|direct_mail|phone|in_app|whatsapp|social_media — promote to reference product if additional channels are added]. Valid values are `email|sms|push_notification|direct_mail|phone|in_app`',
    `communication_preference_code` STRING COMMENT 'The communication preference code of the communication preference record',
    `communication_category` STRING COMMENT 'The category of communication content to which this preference applies. Allows consumers to opt in or out at a granular content level (e.g., opt out of promotional emails but remain opted in for transactional and product recall notifications). [ENUM-REF-CANDIDATE: promotional|transactional|loyalty|product_recall|survey|newsletter|event|regulatory — promote to reference product]. Valid values are `promotional|transactional|loyalty|product_recall|survey|newsletter`',
    `communication_preference_status` STRING COMMENT 'The communication preference status of the communication preference record',
    `confirmation_sent_flag` BOOLEAN COMMENT 'Indicates whether a confirmation message has been sent to the consumer acknowledging their preference update (True) or not yet sent (False). Required for double opt-in workflows and regulatory compliance confirmation obligations.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'The date and time when the consumer confirmed their preference (e.g., clicked the confirmation link in a double opt-in email). Null if confirmation has not yet been received or if single opt-in was used. Critical for GDPR double opt-in audit trails.',
    `consent_basis` STRING COMMENT 'The consent basis of the communication preference record',
    `contact_time_zone` STRING COMMENT 'IANA time zone identifier (e.g., America/New_York, Europe/London) representing the consumers local time zone. Used in conjunction with preferred_time_of_day and preferred_day_of_week to schedule communications at the correct local time.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the consumers country of residence at the time this preference was recorded. Determines applicable regulatory framework (e.g., GDPR for EU, CCPA for California, CASL for Canada) governing this preference.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this communication preference record was first created in the system. Provides the baseline for preference lifecycle tracking and regulatory audit trails.',
    `currency_code` STRING COMMENT 'The currency code of the communication preference record',
    `communication_preference_description` STRING COMMENT 'The communication preference description of the communication preference record',
    `double_opt_in_flag` BOOLEAN COMMENT 'The double opt in flag of the communication preference record',
    `double_opt_in_timestamp` TIMESTAMP COMMENT 'The double opt in timestamp of the communication preference record',
    `effective_date` DATE COMMENT 'The effective date of the communication preference record',
    `effective_from` DATE COMMENT 'The effective from of the communication preference record',
    `effective_from_date` DATE COMMENT 'The date from which this communication preference record is effective and should be honored by outbound communication systems. Supports time-bound preference management and scheduled preference changes.',
    `effective_until` DATE COMMENT 'The effective until of the communication preference record',
    `effective_until_date` DATE COMMENT 'The date until which this communication preference record is effective. Null indicates an open-ended preference with no expiry. Supports time-limited preferences such as seasonal opt-ins or promotional campaign-specific preferences.',
    `expiry_date` DATE COMMENT 'The expiry date of the communication preference record',
    `frequency` STRING COMMENT 'The frequency of the communication preference record',
    `frequency_cap` STRING COMMENT 'The frequency cap of the communication preference record',
    `frequency_preference` STRING COMMENT 'The frequency preference of the communication preference record',
    `is_global_opt_out` BOOLEAN COMMENT 'Indicates whether this record represents a global opt-out across all channels and brands (True) rather than a channel-specific preference (False). When True, all outbound marketing communications to this consumer must be suppressed regardless of other preference records.',
    `last_opt_change_timestamp` TIMESTAMP COMMENT 'The last opt change timestamp of the communication preference record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this communication preference record was most recently modified by the consumer or an authorized system. Critical for GDPR/CCPA audit trails and for determining the most current preference when multiple records exist.',
    `max_messages_per_week` STRING COMMENT 'Consumer-specified maximum number of non-transactional messages they are willing to receive per week via this channel. A null value indicates no consumer-specified cap. Used by CRM contact frequency management to prevent over-communication.',
    `communication_preference_name` STRING COMMENT 'The communication preference name of the communication preference record',
    `notes` STRING COMMENT 'Free-text field for capturing additional context or special instructions related to this communication preference record. May include agent notes from call center interactions, special consumer requests, or escalation context. Not used for automated processing.',
    `opt_in_flag` BOOLEAN COMMENT 'The opt in flag of the communication preference record',
    `opt_in_method` STRING COMMENT 'The mechanism by which the consumer provided their opt-in or opt-out for this channel. Double opt-in requires email confirmation; single opt-in is a direct checkbox; paper form is a physical sign-up; verbal is a call-center capture; imported is from a legacy or third-party system.. Valid values are `double_opt_in|single_opt_in|paper_form|verbal|imported|default`',
    `opt_in_status` BOOLEAN COMMENT 'Indicates whether the consumer has opted in (True) or opted out (False) for communications via the specified channel. Distinct from legal consent — this captures the consumers desired engagement experience.',
    `opt_in_timestamp` TIMESTAMP COMMENT 'The opt in timestamp of the communication preference record',
    `opt_out_reason` STRING COMMENT 'The opt out reason of the communication preference record',
    `opt_out_timestamp` TIMESTAMP COMMENT 'The opt out timestamp of the communication preference record',
    `opt_status` STRING COMMENT 'The opt status of the communication preference record',
    `opted_in` BOOLEAN COMMENT 'The opted in of the communication preference record',
    `personalization_eligible` BOOLEAN COMMENT 'Indicates whether the consumer has consented to receiving personalized communications (True) or prefers generic/non-personalized messaging (False) via this channel. Drives personalization engine inclusion/exclusion in CRM and DTC marketing programs.',
    `preference_source` STRING COMMENT 'The preference source of the communication preference record',
    `preference_status` STRING COMMENT 'Current lifecycle status of this communication preference record. active means the preference is in effect; inactive means the consumer has deactivated it; pending means awaiting confirmation; suspended means temporarily paused.. Valid values are `active|inactive|pending|suspended`',
    `preference_version` STRING COMMENT 'Monotonically incrementing version number for this communication preference record. Incremented each time the preference is updated. Supports optimistic concurrency control and preference history reconstruction for audit purposes.',
    `preferred_day_of_week` STRING COMMENT 'Consumers preferred day of the week for receiving non-transactional communications such as newsletters, promotions, and product updates. Supports send-time optimization in CRM and marketing automation platforms. [ENUM-REF-CANDIDATE: monday|tuesday|wednesday|thursday|friday|saturday|sunday — 7 candidates stripped; promote to reference product]',
    `preferred_frequency` STRING COMMENT 'Consumers preferred frequency for receiving communications via this channel. transactional_only means the consumer only wants order confirmations, shipping updates, and similar transactional messages. Used by CRM and marketing automation to throttle outbound contact.. Valid values are `daily|weekly|monthly|transactional_only|real_time`',
    `preferred_language` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 alpha-2 country subtag, e.g., en-US, fr-FR) representing the consumers preferred language for all communications via this channel. Drives content localization in CRM and personalization engines.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `preferred_time_of_day` STRING COMMENT 'Consumers preferred time window for receiving communications. Used by marketing automation and CRM to schedule outbound messages at the consumers preferred time, improving engagement rates.. Valid values are `morning|afternoon|evening|no_preference`',
    `product_category_preference` STRING COMMENT 'Consumer-specified product category or categories for which they wish to receive communications (e.g., personal_care, household_cleaning, health_nutrition). Free-text or comma-separated category codes aligned to the Consumer Goods product taxonomy. Null means no category restriction.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the communication preference record',
    `record_source_system` STRING COMMENT 'The record source system of the communication preference record',
    `regulatory_framework` STRING COMMENT 'The primary privacy and data protection regulatory framework governing this communication preference record, determined by the consumers country of residence. Drives compliance workflows and audit requirements. Examples: GDPR (EU), CCPA (California), CASL (Canada), PDPA (Thailand/Singapore), LGPD (Brazil).. Valid values are `GDPR|CCPA|CASL|PDPA|LGPD|OTHER`',
    `resubscribe_timestamp` TIMESTAMP COMMENT 'The date and time when the consumer most recently re-opted in to this communication channel after a prior unsubscribe. Null if the consumer has never resubscribed. Supports win-back campaign analytics and preference lifecycle reporting.',
    `retailer_banner_preference` STRING COMMENT 'Consumers preferred retail banner or channel through which they prefer to receive offers and promotions (e.g., walmart, target, amazon, dtc_website). Used to route trade promotion communications and personalized offers through the consumers preferred retail touchpoint.',
    `source_record_ref` STRING COMMENT 'The native record identifier from the source system (e.g., Salesforce Contact ID, SAP Business Partner number) that corresponds to this communication preference. Enables cross-system reconciliation and data lineage tracing.',
    `source_system_code` STRING COMMENT 'The source system code of the communication preference record',
    `subscription_status` STRING COMMENT 'The subscription status of the communication preference record',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this consumer is suppressed from all communications on this channel regardless of opt-in status. True means the consumer must not be contacted via this channel (e.g., due to a legal hold, complaint, or regulatory requirement). Overrides opt_in_status.',
    `suppression_reason` STRING COMMENT 'The reason why the suppression_flag has been set to True for this consumer and channel. Null when suppression_flag is False. Used for compliance audit trails and operational reporting.. Valid values are `legal_hold|consumer_complaint|regulatory_order|deceased|undeliverable|fraud_flag`',
    `third_party_sharing_flag` BOOLEAN COMMENT 'Indicates whether the consumer has consented (True) to their communication preferences and contact data being shared with authorized third-party partners (e.g., retail partners, co-marketing partners) for outbound communications. False means data must not be shared.',
    `topic` STRING COMMENT 'The topic of the communication preference record',
    `unsubscribe_timestamp` TIMESTAMP COMMENT 'The date and time when the consumer most recently unsubscribed or opted out from this communication channel. Null if the consumer has never unsubscribed. Provides a precise audit trail for regulatory compliance and suppression list management.',
    `uom` STRING COMMENT 'The uom of the communication preference record',
    `updated_at_timestamp` TIMESTAMP COMMENT 'The updated at timestamp of the communication preference record',
    `updated_by_actor` STRING COMMENT 'Identifies the type of actor who last updated this preference record. consumer_self_service means the consumer updated it directly via a portal or app; brand_agent means a call center or field agent updated it on behalf of the consumer; system_automated means an automated process applied the change.. Valid values are `consumer_self_service|brand_agent|system_automated|data_migration|legal_team`',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the communication preference record',
    CONSTRAINT pk_communication_preference PRIMARY KEY(`communication_preference_id`)
) COMMENT 'Consumer-managed communication channel and frequency preferences governing how and when the brand may contact them. Stores channel type (email, SMS, push notification, direct mail, phone), opt-in status, preferred frequency (daily, weekly, monthly, transactional only), preferred time of day, preferred language, brand-level preference, and last updated timestamp. Distinct from consent_record (legal compliance) — this captures the consumers desired engagement experience.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` (
    `identity_link_id` BIGINT COMMENT 'Unique surrogate primary key for each identity link record in the cross-channel identity resolution graph. Uniquely identifies a single identity token linked to a unified consumer profile.',
    `consent_record_id` BIGINT COMMENT 'The unique identifier of the consent record in the consent management platform (CMP) that authorizes the processing of this identity token. Provides a traceable link to the specific consent event, consent version, and legal basis documentation required for GDPR Article 7 demonstrability and CCPA audit trails.',
    `household_id` BIGINT COMMENT 'Reference to the household entity to which the resolved consumer belongs. Supports household-level analytics, co-habitation identity clustering, and family-unit targeting in CPG trade promotion and shopper marketing programs.',
    `loyalty_account_id` BIGINT COMMENT 'The loyalty account id of the identity link record',
    `loyalty_program_id` BIGINT COMMENT 'Reference to the loyalty program associated with this identity token when identity_type is loyalty_card. Links the identity token to the specific loyalty scheme (e.g., brand loyalty club, retailer coalition program) for points accrual, tier management, and loyalty-driven personalization in CPG consumer engagement programs.',
    `shopper_id` BIGINT COMMENT 'Reference to the unified consumer profile (golden record) to which this identity token is resolved. The anchor entity in the identity graph that all linked identities converge upon.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the identity link record',
    `channel` STRING COMMENT 'The consumer engagement channel through which this identity token was first captured or observed. DTC (Direct to Consumer): brand-owned digital or physical touchpoint. Retail: captured at point of sale via retailer loyalty or POS system. Ecommerce: captured via online storefront. Loyalty: captured via loyalty program enrollment. Social: captured via social media interaction or login. CRM: captured via customer service or outbound marketing. Wholesale: captured via B2B2C channel partner. Supports omnichannel reach measurement and channel attribution analytics. [ENUM-REF-CANDIDATE: dtc|retail|ecommerce|loyalty|social|crm|wholesale — 7 candidates stripped; promote to reference product]',
    `identity_link_code` STRING COMMENT 'The identity link code of the identity link record',
    `consent_status` STRING COMMENT 'The current consent status governing the use of this identity token for marketing, personalization, and analytics processing. Granted: consumer has provided explicit consent. Withdrawn: consumer has revoked consent (triggers suppression). Pending: consent collection in progress. Not_required: identity token is used under a legitimate interest or contractual basis not requiring explicit consent. Mandatory for GDPR Article 6 lawful basis enforcement and CCPA opt-out compliance.. Valid values are `granted|withdrawn|pending|not_required`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code representing the geographic jurisdiction in which this identity token was captured or is primarily associated. Drives jurisdiction-specific privacy regulation enforcement (GDPR for EU countries, CCPA for USA-California, LGPD for BRA, PIPL for CHN) and regional data residency requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this identity link record was first created in the Databricks Silver layer. Serves as the immutable audit creation marker for data lineage, GDPR Article 30 Records of Processing Activities, and SOX data governance audit trails.',
    `cross_device_cluster_ref` STRING COMMENT 'Identifier of the cross-device cluster or device graph node to which this identity token belongs. Groups multiple device_id and cookie_id tokens that are probabilistically inferred to belong to the same physical consumer. Enables cross-device journey stitching, frequency capping, and reach deduplication in digital advertising and personalization campaigns.',
    `currency_code` STRING COMMENT 'The currency code of the identity link record',
    `data_processing_basis` STRING COMMENT 'The GDPR Article 6 lawful basis under which this identity token is processed. Consent: explicit opt-in. Contract: processing necessary for contract performance (e.g., DTC order fulfillment). Legal_obligation: required by law. Vital_interest: life-or-death necessity. Public_task: public authority function. Legitimate_interest: business interest that does not override consumer rights. Required for GDPR Article 30 Records of Processing Activities documentation.. Valid values are `consent|contract|legal_obligation|vital_interest|public_task|legitimate_interest`',
    `identity_link_description` STRING COMMENT 'The identity link description of the identity link record',
    `effective_date` DATE COMMENT 'The effective date of the identity link record',
    `effective_from` DATE COMMENT 'The effective from of the identity link record',
    `effective_from_date` DATE COMMENT 'The effective from date of the identity link record',
    `effective_from_timestamp` TIMESTAMP COMMENT 'The timestamp from which this identity link record is considered valid and active in the Slowly Changing Dimension (SCD Type 2) history pattern. Supports temporal queries, point-in-time identity graph reconstruction, and regulatory audit trails requiring historical state of consumer identity linkages.',
    `effective_until` DATE COMMENT 'The effective until of the identity link record',
    `effective_until_date` DATE COMMENT 'The effective until date of the identity link record',
    `effective_until_timestamp` TIMESTAMP COMMENT 'The timestamp at which this identity link record ceased to be valid, supporting SCD Type 2 history tracking. NULL indicates the record is currently active. Populated when a link is superseded by a new resolution run, when a consumer requests identity unlinking, or when a probabilistic link falls below the confidence threshold upon re-scoring.',
    `expiry_date` DATE COMMENT 'The date on which this identity link is scheduled to expire and require re-validation or automatic deactivation. Applicable to cookie-based identities (browser cookie expiry), device advertising IDs (consent refresh cycles), and probabilistic links subject to periodic re-scoring. Supports GDPR Article 5(1)(e) storage limitation and consent lifecycle management.',
    `external_id_value` DECIMAL(18,2) COMMENT 'The external id value of the identity link record',
    `external_identifier` STRING COMMENT 'The external identifier of the identity link record',
    `first_seen_timestamp` TIMESTAMP COMMENT 'The first seen timestamp of the identity link record',
    `fraud_risk_flag` BOOLEAN COMMENT 'Boolean flag indicating that this identity token has been flagged as potentially fraudulent, synthetic, or associated with account takeover activity. Flagged identities are quarantined from loyalty program accrual, promotional redemption, and DTC account access pending investigation. Supports CPG brand protection and loyalty fraud prevention programs.',
    `identifier_type` STRING COMMENT 'The identifier type of the identity link record',
    `identifier_value` DECIMAL(18,2) COMMENT 'The identifier value of the identity link record',
    `identifier_value_hash` STRING COMMENT 'The identifier value hash of the identity link record',
    `identity_link_status` STRING COMMENT 'The identity link status of the identity link record',
    `identity_provider` STRING COMMENT 'The specific identity provider or platform that issued or validated this identity credential. For social_id type: the OAuth provider (e.g., Google, Facebook, Apple). For loyalty_card type: the loyalty program operator. For device_id type: the device ecosystem (e.g., Apple IDFA, Google GAID). For email/phone: the CRM or DTC platform. Critical for federated identity governance and third-party data processor agreements under GDPR Article 28.',
    `identity_type` STRING COMMENT 'Categorical classification of the identity token being linked. Defines the channel or credential class: email (email address), phone (mobile/landline number), device_id (mobile or connected device identifier), social_id (social login from OAuth provider), loyalty_card (loyalty program card number), cookie_id (browser or app cookie identifier). Drives resolution logic and PII handling rules per GDPR/CCPA.. Valid values are `email|phone|device_id|social_id|loyalty_card|cookie_id`',
    `identity_value` DECIMAL(18,2) COMMENT 'The actual tokenized or hashed value of the identity credential (e.g., SHA-256 hashed email address, masked phone number, device advertising ID, loyalty card number). Raw PII values must be hashed or tokenized before storage in the Silver layer per GDPR Article 25 data minimization and CCPA privacy-by-design requirements. Supports deterministic matching in identity resolution pipelines.',
    `identity_value_hash` STRING COMMENT 'SHA-256 cryptographic hash of the raw identity value, used for deterministic matching without exposing the underlying PII. Enables privacy-safe identity resolution joins across systems (e.g., hashed email matching with retail partners, clean room environments). Mandatory for cross-partner data collaboration under GDPR Article 28 data processor agreements.. Valid values are `^[a-fA-F0-9]{64}$`',
    `is_golden_record` BOOLEAN COMMENT 'The is golden record of the identity link record',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this identity token is the designated primary identity of its type for the consumer profile. Only one identity per identity_type per consumer_id should have is_primary = TRUE at any point in time. Used to select the single canonical contact point for each channel in CRM outreach, loyalty communications, and personalization engines.',
    `is_primary_identity` BOOLEAN COMMENT 'The is primary identity of the identity link record',
    `is_verified_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the consumer has completed a double opt-in or confirmed opt-in verification for this specific identity token (e.g., email click-through confirmation, SMS reply confirmation). Verified opt-in identities are eligible for direct marketing communications under GDPR Article 7 and CAN-SPAM / TCPA regulatory requirements.',
    `last_seen_timestamp` TIMESTAMP COMMENT 'The most recent date and time this identity token was observed or validated as active across any consumer touchpoint. Used to assess identity freshness, detect stale or abandoned identities, and trigger re-validation workflows. Critical for probabilistic link decay models and identity graph maintenance.',
    `link_confidence_score` DECIMAL(18,2) COMMENT 'Numeric probability score between 0.0000 and 1.0000 representing the confidence that this identity token correctly belongs to the resolved consumer profile. Scores above 0.9 indicate high-confidence deterministic matches; scores between 0.5 and 0.9 indicate probabilistic matches requiring periodic re-evaluation. Used to filter identity links for high-stakes personalization, regulatory consent enforcement, and omnichannel reach deduplication.',
    `link_date` DATE COMMENT 'The calendar date on which this identity token was first linked to the unified consumer profile. Used for identity graph aging analysis, link freshness scoring, and regulatory retention period calculations under GDPR Article 5(1)(e) storage limitation principle.',
    `link_method` STRING COMMENT 'The algorithmic or operational method used to establish the link between this identity token and the unified consumer profile. Deterministic: exact match on a shared identifier (e.g., email). Probabilistic: statistical inference based on behavioral signals, device graphs, or ML models. Federated: identity asserted by a trusted third-party identity provider (e.g., OAuth, SAML). Manual: link established by a human operator or customer service agent override.. Valid values are `deterministic|probabilistic|federated|manual`',
    `link_status` STRING COMMENT 'Current lifecycle status of the identity link record. Active: the identity is currently associated with the consumer profile. Inactive: the identity is no longer in use but retained for audit. Pending: awaiting validation or confirmation. Suppressed: excluded from processing due to consumer opt-out or regulatory hold. Revoked: explicitly removed following a consumer deletion request (GDPR Right to Erasure / CCPA Right to Delete).. Valid values are `active|inactive|pending|suppressed|revoked`',
    `link_timestamp` TIMESTAMP COMMENT 'The precise date and time (with timezone offset) at which this identity token was linked to the unified consumer profile. Provides millisecond-level audit precision required for GDPR Article 30 processing records and real-time identity resolution event logging in the Databricks Silver layer.',
    `link_type` STRING COMMENT 'The link type of the identity link record',
    `match_confidence` DECIMAL(18,2) COMMENT 'The match confidence of the identity link record',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'The match confidence score of the identity link record',
    `match_method` STRING COMMENT 'The match method of the identity link record',
    `ml_model_code` STRING COMMENT 'Identifier of the ML model version used to generate a probabilistic identity link. Applicable only when link_method is probabilistic. Enables model governance, link quality auditing, and re-scoring when a new model version is deployed. Supports AI/ML explainability requirements and model drift monitoring in the Databricks MLflow model registry.',
    `identity_link_name` STRING COMMENT 'The identity link name of the identity link record',
    `notes` STRING COMMENT 'The notes of the identity link record',
    `priority_rank` STRING COMMENT 'Ordinal ranking of this identity token relative to other identities linked to the same consumer profile, within the same identity_type. Rank 1 indicates the primary or most trusted identity of that type. Used to select the canonical identity for outbound communications, personalization targeting, and consumer reach deduplication in omnichannel campaign execution.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the identity link record',
    `record_source_system` STRING COMMENT 'The record source system of the identity link record',
    `resolution_run_ref` STRING COMMENT 'Identifier of the identity resolution batch or streaming job execution that created or last updated this link. Enables full data lineage tracing from the Silver layer back to the specific ETL/ELT pipeline run, supporting audit, debugging, and regulatory data provenance requirements.',
    `source_identifier` STRING COMMENT 'The source identifier of the identity link record',
    `source_record_ref` STRING COMMENT 'The native primary key or record identifier of this identity token in the originating source system. Enables bi-directional traceability between the Silver layer identity graph and the upstream system of record for reconciliation, debugging, and regulatory audit purposes.',
    `source_system_code` STRING COMMENT 'The source system code of the identity link record',
    `source_system_identifier` STRING COMMENT 'The source system identifier of the identity link record',
    `source_system_identity_ref` STRING COMMENT 'The source system identity ref of the identity link record',
    `suppression_flag` BOOLEAN COMMENT 'Boolean flag indicating that this identity token must be excluded from all outbound marketing, personalization, and data sharing activities. Set to TRUE upon consumer opt-out, GDPR erasure request, CCPA deletion request, or regulatory hold. Overrides all campaign targeting and identity resolution outputs for this token.',
    `suppression_reason` STRING COMMENT 'The business reason for suppressing this identity token from processing and outbound use. GDPR_erasure: Right to Erasure request under GDPR Article 17. CCPA_deletion: deletion request under CCPA Section 1798.105. Opt_out: consumer marketing opt-out. Fraud: identity flagged as fraudulent or synthetic. Duplicate: superseded by a higher-confidence identity of the same type. Deceased: consumer confirmed deceased.. Valid values are `gdpr_erasure|ccpa_deletion|opt_out|fraud|duplicate|deceased`',
    `uom` STRING COMMENT 'The uom of the identity link record',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this identity link record was most recently modified in the Databricks Silver layer. Tracks the last update event for change data capture (CDC), incremental processing pipelines, and audit trail completeness per GDPR Article 5(1)(d) accuracy principle.',
    `validation_status` STRING COMMENT 'Indicates whether the identity token has been verified as belonging to the consumer through an active validation step (e.g., email click-through verification, SMS OTP confirmation, loyalty card PIN validation). Validated identities carry higher confidence and are eligible for regulated communications. Unvalidated identities may be used for probabilistic matching only.. Valid values are `validated|unvalidated|failed|expired`',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time at which the identity token was last successfully validated. Provides an audit trail for identity assurance level claims and supports re-validation scheduling based on configurable validation TTL (time-to-live) policies.',
    `verification_date` DATE COMMENT 'The verification date of the identity link record',
    `verified_flag` BOOLEAN COMMENT 'The verified flag of the identity link record',
    CONSTRAINT pk_identity_link PRIMARY KEY(`identity_link_id`)
) COMMENT 'Cross-channel identity resolution record linking a single consumers multiple digital and physical identities (email addresses, device IDs, loyalty card numbers, social login IDs, phone numbers) into a unified consumer profile. Stores identity type (email, phone, device_id, social_id, loyalty_card, cookie_id), identity value, identity source system, link confidence score, link method (deterministic, probabilistic), link date, and active flag. Enables omnichannel personalization and accurate consumer reach measurement.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` (
    `referral_id` BIGINT COMMENT 'Unique system-generated identifier for each consumer referral record in the CPG brands Direct to Consumer (DTC) or loyalty referral program. Serves as the primary key for this entity.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing or trade promotion campaign that triggered or is associated with this referral. Enables Trade Promotion Management (TPM) attribution and Return on Investment (ROI) measurement.',
    `consent_record_id` BIGINT COMMENT 'External reference identifier linking to the consent management record that captures the referred consumers data processing consent for this referral event. Supports General Data Protection Regulation (GDPR) and California Consumer Privacy Act (CCPA) audit trails.',
    `dtc_order_id` BIGINT COMMENT 'Identifier of the first qualifying purchase order placed by the referred consumer that triggered the referral conversion. Null if conversion was not purchase-based.',
    `loyalty_program_id` BIGINT COMMENT 'Identifier of the loyalty program under which this referral was issued. Determines reward rules, eligibility criteria, and program-specific tracking.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the Consumer Packaged Goods (CPG) brand associated with this referral program. Enables brand-level referral performance reporting and word-of-mouth acquisition attribution.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Referral program generates sales opportunities; linking referral to opportunity enables attribution and pipeline forecasting.',
    `shopper_id` BIGINT COMMENT 'Identifier of the new consumer (referee) who was referred. Populated upon registration or conversion; may be null if the referred party has not yet created an account.',
    `program_id` BIGINT COMMENT 'Identifier of the specific referral program configuration under which this referral was created. Determines reward rules, expiry windows, eligible channels, and conversion criteria.',
    `referral_referred_shopper_id` BIGINT COMMENT 'The referral referred shopper id of the referral record',
    `referral_referrer_shopper_id` BIGINT COMMENT 'The referral referrer shopper id of the referral record',
    `acquisition_channel` STRING COMMENT 'The business channel through which the referral program is operating — Direct to Consumer (DTC), loyalty app, e-commerce, or mobile app. Supports channel-level acquisition performance analysis.. Valid values are `dtc|loyalty_app|ecommerce|mobile_app`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the referral record',
    `attempt_number` STRING COMMENT 'Sequential count of referral attempts made by the same referrer within the same program period. Supports referral frequency capping and reward abuse detection.',
    `ccpa_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the referred consumer has exercised their California Consumer Privacy Act (CCPA) right to opt out of the sale or sharing of personal data collected through the referral program.',
    `channel` STRING COMMENT 'The distribution channel through which the referral was shared by the referrer. Supports word-of-mouth acquisition channel attribution analysis.. Valid values are `email|social_share|referral_link|sms|in_app`',
    `click_timestamp` TIMESTAMP COMMENT 'Timestamp when the referred consumer first clicked or opened the referral link. Null if the referral has not been clicked. Used to measure referral engagement latency.',
    `referral_code` STRING COMMENT 'Unique alphanumeric code assigned to this referral event, shared by the referrer with the prospective consumer via email, social share, or referral link. Acts as the externally-known business identifier for the referral.. Valid values are `^[A-Z0-9]{6,20}$`',
    `conversion_date` DATE COMMENT 'The date on which the referred consumer completed the qualifying conversion action (e.g., first purchase, loyalty enrollment). Null if not yet converted. Key metric for referral program Return on Investment (ROI) measurement.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the market in which the referral was issued. Used for geographic segmentation, regulatory compliance scoping, and regional program performance reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this referral record was first created in the data platform. Serves as the audit creation timestamp for data lineage and Silver layer governance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to monetary reward values (referrer_reward_value, referred_reward_value) when reward type is cash-based. Null for points-only programs.. Valid values are `^[A-Z]{3}$`',
    `data_processing_basis` STRING COMMENT 'The legal basis under General Data Protection Regulation (GDPR) Article 6 for processing the referred consumers personal data in the context of this referral record.. Valid values are `consent|legitimate_interest|contract|legal_obligation`',
    `days_to_convert` STRING COMMENT 'Number of calendar days elapsed between the referral_date and the conversion_date. Null if not yet converted. Stored as an operational field in the referral management system to support referral velocity and program effectiveness analytics without requiring real-time calculation.',
    `referral_description` STRING COMMENT 'The referral description of the referral record',
    `effective_from` DATE COMMENT 'The effective from of the referral record',
    `effective_until` DATE COMMENT 'The effective until of the referral record',
    `expiry_date` DATE COMMENT 'The date after which the referral code is no longer valid for conversion. Determined by program rules at the time of referral issuance.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this referral record has been flagged for suspected fraudulent activity (e.g., self-referral, synthetic accounts, reward abuse). Triggers fraud review workflow.',
    `fraud_review_status` STRING COMMENT 'Current status of the fraud investigation for this referral record. Populated when fraud_flag is True. Determines whether rewards are held, released, or reversed.. Valid values are `not_reviewed|under_review|cleared|confirmed_fraud`',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the referred consumer provided valid General Data Protection Regulation (GDPR) consent for their personal data to be processed as part of the referral program. Mandatory for EU-resident referred consumers.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this referral record in the data platform. Used for incremental load processing and audit trail maintenance in the Databricks Silver layer.',
    `medium` STRING COMMENT 'The media classification of the referral distribution (organic, paid, owned, earned). Supports Share of Voice (SOV) and word-of-mouth acquisition analytics.. Valid values are `organic|paid|owned|earned`',
    `referral_name` STRING COMMENT 'The referral name of the referral record',
    `notes` STRING COMMENT 'The notes of the referral record',
    `qualifying_action_type` STRING COMMENT 'The specific consumer action required for the referral to be counted as converted. Defines the conversion event tracked against the referral record.. Valid values are `first_purchase|loyalty_enrollment|dtc_registration|subscription_start`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the referral record',
    `record_source_system` STRING COMMENT 'The record source system of the referral record',
    `referral_date` TIMESTAMP COMMENT 'The principal business event timestamp recording when the referral was initiated by the referrer. Used as the primary event time for referral program performance reporting.',
    `referral_status` STRING COMMENT 'Current lifecycle state of the referral record. sent = referral issued but not yet acted upon; clicked = referred party opened the referral link; converted = referred party completed the qualifying action; expired = referral window elapsed without conversion; cancelled = referral voided by program rules or fraud review.. Valid values are `sent|clicked|converted|expired|cancelled`',
    `referred_reward_amount` DECIMAL(18,2) COMMENT 'The referred reward amount of the referral record',
    `referred_reward_status` STRING COMMENT 'Current fulfillment status of the reward owed to the referred consumer. Tracks the reward lifecycle from pending issuance through redemption or expiry.. Valid values are `pending|issued|redeemed|expired|reversed`',
    `referred_reward_type` STRING COMMENT 'The type of reward earned by the referred (new) consumer upon completing the qualifying conversion action. Incentivizes the referred party to complete the sign-up or first purchase.. Valid values are `points|discount_voucher|cash_back|free_product|gift_card`',
    `referred_reward_value` DECIMAL(18,2) COMMENT 'The monetary or points value of the reward earned by the referred consumer upon conversion. Expressed in the programs reward currency (points or monetary unit per currency_code).',
    `referrer_reward_amount` DECIMAL(18,2) COMMENT 'The referrer reward amount of the referral record',
    `referrer_reward_status` STRING COMMENT 'Current fulfillment status of the reward owed to the referrer. Tracks the reward lifecycle from pending issuance through redemption or expiry.. Valid values are `pending|issued|redeemed|expired|reversed`',
    `referrer_reward_type` STRING COMMENT 'The type of reward earned by the referrer upon successful conversion of the referred consumer. Determines how the reward is fulfilled within the loyalty or Direct to Consumer (DTC) platform.. Valid values are `points|discount_voucher|cash_back|free_product|gift_card`',
    `referrer_reward_value` DECIMAL(18,2) COMMENT 'The monetary or points value of the reward earned by the referrer upon successful referral conversion. Expressed in the programs reward currency (points or monetary unit per currency_code).',
    `reminder_sent_flag` BOOLEAN COMMENT 'Indicates whether a follow-up reminder communication was sent to the referred consumer to encourage conversion before the referral expiry date.',
    `reminder_sent_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent reminder communication sent to the referred consumer. Null if no reminder has been sent.',
    `reward_amount` DECIMAL(18,2) COMMENT 'The reward amount of the referral record',
    `reward_currency_code` STRING COMMENT 'The reward currency code of the referral record',
    `reward_points` DECIMAL(18,2) COMMENT 'The reward points of the referral record',
    `reward_status` STRING COMMENT 'The reward status of the referral record',
    `reward_type` STRING COMMENT 'The reward type of the referral record',
    `self_referral_flag` BOOLEAN COMMENT 'Indicates whether the referrer and referred consumer are determined to be the same individual (e.g., same device, same email domain, same household). Used to detect and suppress reward abuse.',
    `social_platform` STRING COMMENT 'The specific social media platform used when channel is social_share. Enables platform-level referral performance benchmarking. [ENUM-REF-CANDIDATE: facebook|instagram|twitter_x|whatsapp|tiktok|pinterest|snapchat|linkedin|other — promote to reference product]. Valid values are `facebook|instagram|twitter_x|whatsapp|tiktok|other`',
    `source_record_ref` STRING COMMENT 'The native identifier of this referral record in the originating source system (e.g., Salesforce record ID). Enables traceability and reconciliation between the Databricks Lakehouse Silver layer and the system of record.',
    `source_system_code` STRING COMMENT 'The source system code of the referral record',
    `source_url` STRING COMMENT 'The URL or deep link used by the referrer to share the referral. Captures the originating digital touchpoint for channel attribution and link performance analysis.',
    `uom` STRING COMMENT 'The uom of the referral record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the referral record',
    CONSTRAINT pk_referral PRIMARY KEY(`referral_id`)
) COMMENT 'Consumer referral program record tracking when an existing consumer refers a new consumer to a CPG brands DTC or loyalty program. Stores referral date, referrer shopper reference, referred shopper reference, referral channel (email, social share, referral link), referral status (sent, clicked, converted, expired), reward earned by referrer, reward earned by referred consumer, and conversion date. Enables referral program performance tracking and word-of-mouth acquisition measurement.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` (
    `research_participation_id` BIGINT COMMENT 'Primary key for the research_participation association',
    `consent_record_id` BIGINT COMMENT 'Identifier of the consent record associated with this participation',
    `consumer_test_id` BIGINT COMMENT 'The consumer test id of the research participation record',
    `market_research_study_id` BIGINT COMMENT 'The market research study id of the research participation record',
    `marketing_brand_id` BIGINT COMMENT 'The marketing brand id of the research participation record',
    `panel_id` BIGINT COMMENT 'Panel participated in.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to R&D project',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to shopper',
    `survey_id` BIGINT COMMENT 'The survey id of the research participation record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the research participation record',
    `research_participation_code` STRING COMMENT 'The research participation code of the research participation record',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary compensation paid to the shopper for participation',
    `compensation_currency` STRING COMMENT 'The compensation currency of the research participation record',
    `compensation_type` STRING COMMENT 'The compensation type of the research participation record',
    `completion_date` DATE COMMENT 'The completion date of the research participation record',
    `completion_flag` BOOLEAN COMMENT 'The completion flag of the research participation record',
    `completion_status` STRING COMMENT 'The completion status of the research participation record',
    `consent_flag` BOOLEAN COMMENT 'The consent flag of the research participation record',
    `consent_obtained` BOOLEAN COMMENT 'Whether consent was obtained.',
    `consent_obtained_flag` BOOLEAN COMMENT 'The consent obtained flag of the research participation record',
    `consent_status` STRING COMMENT 'The consent status of the research participation record',
    `consent_version` STRING COMMENT 'The consent version of the research participation record',
    `country_code` STRING COMMENT 'The country code of the research participation record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the research participation record',
    `currency_code` STRING COMMENT 'The currency code of the research participation record',
    `data_use_scope` STRING COMMENT 'The data use scope of the research participation record',
    `research_participation_description` STRING COMMENT 'The research participation description of the research participation record',
    `effective_from` DATE COMMENT 'The effective from of the research participation record',
    `effective_until` DATE COMMENT 'The effective until of the research participation record',
    `eligibility_flag` BOOLEAN COMMENT 'The eligibility flag of the research participation record',
    `eligibility_status` STRING COMMENT 'The eligibility status of the research participation record',
    `enrollment_date` DATE COMMENT 'The enrollment date of the research participation record',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Incentive paid.',
    `incentive_currency_code` STRING COMMENT 'The incentive currency code of the research participation record',
    `incentive_paid_flag` BOOLEAN COMMENT 'The incentive paid flag of the research participation record',
    `incentive_status` STRING COMMENT 'The incentive status of the research participation record',
    `incentive_type` STRING COMMENT 'The incentive type of the research participation record',
    `invitation_date` DATE COMMENT 'The invitation date of the research participation record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the research participation record',
    `research_participation_name` STRING COMMENT 'The research participation name of the research participation record',
    `notes` STRING COMMENT 'The notes of the research participation record',
    `opt_out_date` DATE COMMENT 'The opt out date of the research participation record',
    `opt_out_flag` BOOLEAN COMMENT 'The opt out flag of the research participation record',
    `participation_code` STRING COMMENT 'The participation code of the research participation record',
    `participation_date` DATE COMMENT 'Date the shopper participated in the project',
    `participation_status` STRING COMMENT 'Status of participation.',
    `participation_type` STRING COMMENT 'The participation type of the research participation record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the research participation record',
    `record_source_system` STRING COMMENT 'The record source system of the research participation record',
    `recruitment_channel` STRING COMMENT 'The recruitment channel of the research participation record',
    `recruitment_date` DATE COMMENT 'The recruitment date of the research participation record',
    `recruitment_source` STRING COMMENT 'The recruitment source of the research participation record',
    `research_participation_status` STRING COMMENT 'The research participation status of the research participation record',
    `response_quality_flag` STRING COMMENT 'The response quality flag of the research participation record',
    `response_quality_score` DECIMAL(18,2) COMMENT 'The response quality score of the research participation record',
    `screening_result` STRING COMMENT 'The screening result of the research participation record',
    `session_count` STRING COMMENT 'The session count of the research participation record',
    `session_duration_minutes` STRING COMMENT 'The session duration minutes of the research participation record',
    `source_system_code` STRING COMMENT 'The source system code of the research participation record',
    `study_code` STRING COMMENT 'The study code of the research participation record',
    `study_name` STRING COMMENT 'Research study name.',
    `study_role` STRING COMMENT 'The study role of the research participation record',
    `study_type` STRING COMMENT 'The study type of the research participation record',
    `uom` STRING COMMENT 'The uom of the research participation record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the research participation record',
    `withdrawal_date` DATE COMMENT 'The withdrawal date of the research participation record',
    CONSTRAINT pk_research_participation PRIMARY KEY(`research_participation_id`)
) COMMENT 'Represents the participation of a shopper in an R&D project. Each record links one shopper to one R&D project and captures participation-specific data.. Existence Justification: Shoppers (consumers) are actively recruited to take part in R&D projects, and each R&D project can involve many shoppers. The business records participation details such as the date of participation, compensation amount, and consent record for each shopper‑project pair, which are managed as a standalone entity.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` (
    `loyalty_program_id` BIGINT COMMENT 'Primary key for loyalty_program',
    `gl_account_id` BIGINT COMMENT 'The gl account id of the loyalty program record',
    `marketing_brand_id` BIGINT COMMENT 'The loyalty marketing brand id of the loyalty program record',
    `loyalty_owning_marketing_brand_id` BIGINT COMMENT 'add column owning_marketing_brand_id (BIGINT) with FK to marketing.marketing_brand.marketing_brand_id - loyalty programs are owned by a brand (existing FK already correct, but ensure linkage; flag if missing in v2)',
    `employee_id` BIGINT COMMENT 'The owner employee id of the loyalty program record',
    `predecessor_loyalty_program_id` BIGINT COMMENT 'Self-referencing FK on loyalty_program (predecessor_loyalty_program_id)',
    `jurisdiction_id` BIGINT COMMENT 'add column terms_jurisdiction_id (BIGINT) with FK to regulatory.jurisdiction.jurisdiction_id - loyalty programs have jurisdiction-specific terms',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the loyalty program record',
    `base_earn_rate` DECIMAL(18,2) COMMENT 'The base earn rate of the loyalty program record',
    `cltv_estimate` DECIMAL(18,2) COMMENT 'Projected lifetime value of members participating in this program.',
    `loyalty_program_code` STRING COMMENT 'The loyalty program code of the loyalty program record',
    `consent_required_flag` BOOLEAN COMMENT 'The consent required flag of the loyalty program record',
    `consent_status` STRING COMMENT 'Current consent status of members for data processing under privacy regulations.',
    `country_code` STRING COMMENT 'The country code of the loyalty program record',
    `country_scope` STRING COMMENT 'The country scope of the loyalty program record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the loyalty program record',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values associated with the program.',
    `currency_unit` STRING COMMENT 'The currency unit of the loyalty program record',
    `loyalty_program_description` STRING COMMENT 'The loyalty program description of the loyalty program record',
    `earn_currency_code` STRING COMMENT 'The earn currency code of the loyalty program record',
    `earn_rate` DECIMAL(18,2) COMMENT 'The earn rate of the loyalty program record',
    `effective_from` DATE COMMENT 'Date when the loyalty program becomes active and binding.',
    `effective_until` DATE COMMENT 'Date when the loyalty program ends or is scheduled to expire; null for open‑ended programs.',
    `end_date` DATE COMMENT 'The end date of the loyalty program record',
    `enrollment_channel` STRING COMMENT 'Channel through which members can enroll in the program.',
    `enrollment_count` BIGINT COMMENT 'The enrollment count of the loyalty program record',
    `enrollment_date` DATE COMMENT 'Date when the program was first made available to members.',
    `enrollment_fee` DECIMAL(18,2) COMMENT 'The enrollment fee of the loyalty program record',
    `enrollment_method` STRING COMMENT 'The enrollment method of the loyalty program record',
    `launch_date` DATE COMMENT 'The launch date of the loyalty program record',
    `loyalty_program_status` STRING COMMENT 'Current lifecycle status of the program.',
    `loyalty_program_name` STRING COMMENT 'The loyalty program name of the loyalty program record',
    `notes` STRING COMMENT 'The notes of the loyalty program record',
    `nps_score` STRING COMMENT 'Average NPS rating collected from program participants.',
    `points_balance` DECIMAL(18,2) COMMENT 'Current outstanding points available for redemption across all members.',
    `points_currency_name` STRING COMMENT 'The points currency name of the loyalty program record',
    `points_earned` DECIMAL(18,2) COMMENT 'Total loyalty points earned by members under this program to date.',
    `points_expiration_date` DATE COMMENT 'Date on which earned points expire if not redeemed.',
    `points_expiry_months` STRING COMMENT 'The points expiry months of the loyalty program record',
    `points_expiry_policy` STRING COMMENT 'The points expiry policy of the loyalty program record',
    `privacy_opt_in` BOOLEAN COMMENT 'Indicates whether members have opted in to receive marketing communications.',
    `program_code` STRING COMMENT 'External business code used to reference the loyalty program in marketing and partner systems.',
    `program_description` STRING COMMENT 'Detailed description of the programs purpose, benefits, and rules.',
    `program_name` STRING COMMENT 'Human‑readable name of the loyalty program.',
    `program_status` STRING COMMENT 'The program status of the loyalty program record',
    `program_type` STRING COMMENT 'Category of the loyalty program indicating the reward mechanism.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the loyalty program record',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the loyalty program record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the loyalty program record.',
    `record_source_system` STRING COMMENT 'The record source system of the loyalty program record',
    `redemption_rate` DECIMAL(18,2) COMMENT 'The redemption rate of the loyalty program record',
    `reward_rate` DECIMAL(18,2) COMMENT 'Rate at which points or cash back are earned per monetary unit spent.',
    `source_system_code` STRING COMMENT 'The source system code of the loyalty program record',
    `terms_version` STRING COMMENT 'The terms version of the loyalty program record',
    `tier_level` STRING COMMENT 'Tier or level designation within the program (e.g., Silver, Gold, Platinum).',
    `uom` STRING COMMENT 'The uom of the loyalty program record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the loyalty program record',
    CONSTRAINT pk_loyalty_program PRIMARY KEY(`loyalty_program_id`)
) COMMENT 'Master reference table for loyalty_program. Referenced by loyalty_program_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` (
    `consent_session_id` BIGINT COMMENT 'Primary key for consent_session',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the consent session record',
    `preference_center_id` BIGINT COMMENT 'The preference center id of the consent session record',
    `renewed_consent_session_id` BIGINT COMMENT 'Self-referencing FK on consent_session (renewed_consent_session_id)',
    `shopper_id` BIGINT COMMENT 'Shopper this consent session belongs to.',
    `address_line` STRING COMMENT 'Street address of the consumer at the time consent was recorded.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the consent session record',
    `channel` STRING COMMENT 'Channel through which the consent was captured (e.g., website, mobile app, in‑store kiosk, call center).',
    `consent_session_code` STRING COMMENT 'The consent session code of the consent session record',
    `consent_collected_count` STRING COMMENT 'The consent collected count of the consent session record',
    `consent_count` STRING COMMENT 'The consent count of the consent session record',
    `consent_framework` STRING COMMENT 'The consent framework of the consent session record',
    `consent_given` BOOLEAN COMMENT 'Indicates whether the consumer actively gave consent (true) or not (false).',
    `consent_outcome` STRING COMMENT 'The consent outcome of the consent session record',
    `consent_purpose` STRING COMMENT 'Free‑text description of the purpose(s) for which consent was obtained.',
    `consent_scope` STRING COMMENT 'Defines the data categories or processing activities covered by the consent.',
    `consent_session_status` STRING COMMENT 'Current lifecycle status of the consent session.',
    `consent_timestamp` TIMESTAMP COMMENT 'Date and time when the consent was given (effective start).',
    `consent_type` STRING COMMENT 'Category of consent granted (e.g., marketing, analytics, third‑party sharing, service, research).',
    `country_code` STRING COMMENT 'The country code of the consent session record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent session record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the consent session record',
    `consent_session_description` STRING COMMENT 'The consent session description of the consent session record',
    `device_code` STRING COMMENT 'Unique identifier of the consumers device used during consent capture.',
    `device_type` STRING COMMENT 'The device type of the consent session record',
    `effective_from` DATE COMMENT 'The effective from of the consent session record',
    `effective_until` DATE COMMENT 'The effective until of the consent session record',
    `email` STRING COMMENT 'Email address of the consumer associated with the consent session.',
    `end_timestamp` TIMESTAMP COMMENT 'The end timestamp of the consent session record',
    `ended_timestamp` TIMESTAMP COMMENT 'The ended timestamp of the consent session record',
    `events_count` STRING COMMENT 'The events count of the consent session record',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the consent expires or becomes invalid (nullable for indefinite consents).',
    `ip_address` STRING COMMENT 'IP address of the device from which consent was captured.',
    `language` STRING COMMENT 'Two‑letter ISO language code representing the language used for the consent interaction.',
    `language_code` STRING COMMENT 'The language code of the consent session record',
    `locale` STRING COMMENT 'The locale of the consent session record',
    `method` STRING COMMENT 'Method used to capture consent (opt‑in or opt‑out).',
    `consent_session_name` STRING COMMENT 'The consent session name of the consent session record',
    `notes` STRING COMMENT 'The notes of the consent session record',
    `phone_number` STRING COMMENT 'Phone number of the consumer used for contact and consent verification.',
    `privacy_policy_version` STRING COMMENT 'Version of the privacy policy that was presented to the consumer at consent time.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the consent session record',
    `record_source_system` STRING COMMENT 'The record source system of the consent session record',
    `revocation_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumer withdrew or revoked the consent.',
    `session_code` STRING COMMENT 'Business-facing code or token that identifies the consent session for external reference.',
    `session_end_timestamp` TIMESTAMP COMMENT 'The session end timestamp of the consent session record',
    `session_start_timestamp` TIMESTAMP COMMENT 'The session start timestamp of the consent session record',
    `session_status` STRING COMMENT 'The session status of the consent session record',
    `session_token` STRING COMMENT 'The session token of the consent session record',
    `session_type` STRING COMMENT 'The session type of the consent session record',
    `source_system_code` STRING COMMENT 'The source system code of the consent session record',
    `source_url` STRING COMMENT 'The source url of the consent session record',
    `start_timestamp` TIMESTAMP COMMENT 'The start timestamp of the consent session record',
    `started_timestamp` TIMESTAMP COMMENT 'The started timestamp of the consent session record',
    `uom` STRING COMMENT 'The uom of the consent session record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent session record.',
    `user_agent` STRING COMMENT 'Browser or application user‑agent string reported at the time of consent.',
    `version` STRING COMMENT 'Version identifier of the consent form or policy at the time of capture.',
    CONSTRAINT pk_consent_session PRIMARY KEY(`consent_session_id`)
) COMMENT 'Master reference table for consent_session. Referenced by session_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` (
    `preference_center_id` BIGINT COMMENT 'Primary key for preference_center',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the preference center record',
    `loyalty_program_id` BIGINT COMMENT 'The loyalty program id of the preference center record',
    `marketing_brand_id` BIGINT COMMENT 'The marketing brand id of the preference center record',
    `previous_preference_center_id` BIGINT COMMENT 'Self-referencing FK on preference_center (previous_preference_center_id)',
    `shopper_id` BIGINT COMMENT 'Unique identifier of the consumer to whom the preferences apply.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the preference center record',
    `ccpa_opt_out` BOOLEAN COMMENT 'Indicates consumers CCPA opt‑out from data sale.',
    `center_code` STRING COMMENT 'The center code of the preference center record',
    `center_name` STRING COMMENT 'The center name of the preference center record',
    `center_status` STRING COMMENT 'The center status of the preference center record',
    `center_type` STRING COMMENT 'The center type of the preference center record',
    `center_url` STRING COMMENT 'The center url of the preference center record',
    `center_version` STRING COMMENT 'The center version of the preference center record',
    `channel` STRING COMMENT 'The channel of the preference center record',
    `preference_center_code` STRING COMMENT 'The preference center code of the preference center record',
    `consent_expiration_date` DATE COMMENT 'Date when the current consent expires, if applicable.',
    `consent_framework` STRING COMMENT 'The consent framework of the preference center record',
    `consent_given_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumer initially provided consent.',
    `consent_review_date` DATE COMMENT 'Date scheduled for periodic review of the consumers consent status.',
    `consent_revoked_timestamp` TIMESTAMP COMMENT 'Timestamp when the consumer withdrew consent; null if still active.',
    `consent_source` STRING COMMENT 'Channel through which consent was obtained.',
    `country_code` STRING COMMENT 'The country code of the preference center record',
    `country_scope` STRING COMMENT 'The country scope of the preference center record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the preference record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the preference center record',
    `data_processing_consent` BOOLEAN COMMENT 'Flag indicating consent for processing personal data under applicable privacy laws.',
    `data_sharing_scope` STRING COMMENT 'Level of data sharing the consumer permits with partners.',
    `default_language_code` STRING COMMENT 'The default language code of the preference center record',
    `preference_center_description` STRING COMMENT 'The preference center description of the preference center record',
    `do_not_call` BOOLEAN COMMENT 'Indicates whether the consumer has opted out of phone calls.',
    `do_not_mail` BOOLEAN COMMENT 'Indicates whether the consumer has opted out of postal mail.',
    `do_not_sell_data` BOOLEAN COMMENT 'CCPA flag indicating the consumer does not want personal data sold.',
    `double_opt_in_enabled` BOOLEAN COMMENT 'The double opt in enabled of the preference center record',
    `effective_date` DATE COMMENT 'The effective date of the preference center record',
    `effective_from` DATE COMMENT 'Date when the preference becomes effective.',
    `effective_from_date` DATE COMMENT 'The effective from date of the preference center record',
    `effective_until` DATE COMMENT 'Date when the preference expires or is superseded; null if open-ended.',
    `effective_until_date` DATE COMMENT 'The effective until date of the preference center record',
    `email_opt_in` BOOLEAN COMMENT 'Flag indicating whether the consumer has opted in to receive email communications.',
    `gdpr_consent` BOOLEAN COMMENT 'Indicates GDPR-compliant consent for data processing.',
    `is_active` BOOLEAN COMMENT 'The is active of the preference center record',
    `is_complete` BOOLEAN COMMENT 'The is complete of the preference center record',
    `is_test_account` BOOLEAN COMMENT 'Flag indicating the record belongs to a test or sandbox consumer.',
    `last_preference_update` TIMESTAMP COMMENT 'Timestamp of the most recent change to any preference field.',
    `last_visited_timestamp` TIMESTAMP COMMENT 'The last visited timestamp of the preference center record',
    `launch_date` DATE COMMENT 'The launch date of the preference center record',
    `locale` STRING COMMENT 'The locale of the preference center record',
    `marketing_category` STRING COMMENT 'Consumers preferred marketing category for targeted campaigns.',
    `preference_center_name` STRING COMMENT 'The preference center name of the preference center record',
    `notes` STRING COMMENT 'Free‑form notes entered by support staff regarding the consumers preferences.',
    `phone_opt_in` BOOLEAN COMMENT 'Flag indicating whether the consumer has opted in to receive phone call communications.',
    `platform` STRING COMMENT 'The platform of the preference center record',
    `postal_mail_opt_in` BOOLEAN COMMENT 'Flag indicating whether the consumer has opted in to receive postal mail.',
    `preference_center_status` STRING COMMENT 'Current lifecycle status of the preference record.',
    `preference_code` STRING COMMENT 'External reference code for the preference record, used in reporting and audits.',
    `preference_status_reason` STRING COMMENT 'Free‑text reason explaining the current status of the preference record.',
    `preference_type` STRING COMMENT 'Category of preference (e.g., marketing, transactional, service, research).',
    `preferred_communication_channel` STRING COMMENT 'Consumers preferred primary channel for outreach.',
    `preferred_language` STRING COMMENT 'Consumers preferred language for communications.',
    `privacy_policy_version` STRING COMMENT 'Version identifier of the privacy policy under which consent was obtained.',
    `push_opt_in` BOOLEAN COMMENT 'Flag indicating whether the consumer has opted in to receive push notifications.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the preference center record',
    `record_source_system` STRING COMMENT 'The record source system of the preference center record',
    `sms_opt_in` BOOLEAN COMMENT 'Flag indicating whether the consumer has opted in to receive SMS messages.',
    `source_system_code` STRING COMMENT 'The source system code of the preference center record',
    `supported_channels` STRING COMMENT 'The supported channels of the preference center record',
    `third_party_sharing_opt_in` BOOLEAN COMMENT 'Flag indicating whether the consumer consents to share data with third parties.',
    `uom` STRING COMMENT 'The uom of the preference center record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the preference record.',
    `url` STRING COMMENT 'The url of the preference center record',
    `version` STRING COMMENT 'The version of the preference center record',
    CONSTRAINT pk_preference_center PRIMARY KEY(`preference_center_id`)
) COMMENT 'Master reference table for preference_center. Referenced by preference_center_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` (
    `data_subject_request_id` BIGINT COMMENT 'Primary key for data_subject_request',
    `employee_id` BIGINT COMMENT 'The data assigned employee id of the data subject request record',
    `data_employee_id` BIGINT COMMENT 'The data employee id of the data subject request record',
    `data_handled_by_employee_id` BIGINT COMMENT 'The data handled by employee id of the data subject request record',
    `jurisdiction_id` BIGINT COMMENT 'The jurisdiction id of the data subject request record',
    `original_data_subject_request_id` BIGINT COMMENT 'Self-referencing FK on data_subject_request (original_data_subject_request_id)',
    `shopper_id` BIGINT COMMENT 'Unique identifier of the consumer (person, household, or loyalty member) who submitted the request.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the data subject request record',
    `data_subject_request_code` STRING COMMENT 'The data subject request code of the data subject request record',
    `completed_date` DATE COMMENT 'The completed date of the data subject request record',
    `completed_timestamp` TIMESTAMP COMMENT 'The completed timestamp of the data subject request record',
    `completion_date` DATE COMMENT 'The completion date of the data subject request record',
    `completion_timestamp` TIMESTAMP COMMENT 'The completion timestamp of the data subject request record',
    `country_code` STRING COMMENT 'The country code of the data subject request record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the data subject request record',
    `currency_code` STRING COMMENT 'The currency code of the data subject request record',
    `data_category_requested` STRING COMMENT 'Specific categories of personal data the consumer is requesting access to, delete, or correct. [ENUM-REF-CANDIDATE: personal|financial|health|location|behavioral|communication — promote to reference product]',
    `data_retention_expiration_date` DATE COMMENT 'Date when the retained data is scheduled for deletion.',
    `data_retention_period_days` STRING COMMENT 'Number of days personal data will be retained after request fulfillment, per policy.',
    `data_scope` STRING COMMENT 'The data scope of the data subject request record',
    `data_subject_request_status` STRING COMMENT 'The data subject request status of the data subject request record',
    `data_subject_request_description` STRING COMMENT 'The data subject request description of the data subject request record',
    `due_date` DATE COMMENT 'The due date of the data subject request record',
    `effective_from` DATE COMMENT 'The effective from of the data subject request record',
    `effective_until` DATE COMMENT 'The effective until of the data subject request record',
    `escalated_flag` BOOLEAN COMMENT 'The escalated flag of the data subject request record',
    `escalation_flag` BOOLEAN COMMENT 'The escalation flag of the data subject request record',
    `fulfillment_date` DATE COMMENT 'The fulfillment date of the data subject request record',
    `fulfillment_notes` STRING COMMENT 'The fulfillment notes of the data subject request record',
    `identity_verification_method` STRING COMMENT 'The identity verification method of the data subject request record',
    `identity_verified_flag` BOOLEAN COMMENT 'The identity verified flag of the data subject request record',
    `is_sensitive_data` BOOLEAN COMMENT 'Indicates whether the request involves special category (sensitive) personal data.',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the consumers identity has been successfully verified.',
    `legal_basis` STRING COMMENT 'Legal justification for processing the request under privacy law.',
    `data_subject_request_name` STRING COMMENT 'The data subject request name of the data subject request record',
    `notes` STRING COMMENT 'Free‑form notes added by compliance or support staff regarding the request.',
    `outcome` STRING COMMENT 'Final outcome of the request after processing.',
    `outcome_reason` STRING COMMENT 'Explanation for the request outcome (e.g., legal exemption, data not found).',
    `privacy_policy_version` STRING COMMENT 'Version identifier of the privacy policy in effect at request time.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the data subject request record',
    `received_date` DATE COMMENT 'The received date of the data subject request record',
    `received_timestamp` TIMESTAMP COMMENT 'The received timestamp of the data subject request record',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the request record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the request record.',
    `record_source_system` STRING COMMENT 'The record source system of the data subject request record',
    `regulation` STRING COMMENT 'The regulation of the data subject request record',
    `regulation_basis` STRING COMMENT 'The regulation basis of the data subject request record',
    `regulatory_framework` STRING COMMENT 'The regulatory framework of the data subject request record',
    `rejection_reason` STRING COMMENT 'The rejection reason of the data subject request record',
    `request_channel` STRING COMMENT 'Origin channel through which the request was received.',
    `request_code` STRING COMMENT 'The request code of the data subject request record',
    `request_date` DATE COMMENT 'The request date of the data subject request record',
    `request_deadline_timestamp` TIMESTAMP COMMENT 'Regulatory deadline by which the request must be addressed (e.g., 30‑day window).',
    `request_effective_date` DATE COMMENT 'Date on which the request becomes effective for processing.',
    `request_fulfilled_timestamp` TIMESTAMP COMMENT 'Date‑time when the request was fully satisfied or closed.',
    `request_number` STRING COMMENT 'The request number of the data subject request record',
    `request_received_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the request was initially recorded.',
    `request_source_system` STRING COMMENT 'Name of the source system where the request originated (e.g., CRM, web portal).',
    `request_status` STRING COMMENT 'Current lifecycle status of the request.',
    `request_type` STRING COMMENT 'Category of data subject request (e.g., access, deletion, correction, data portability, processing restriction).',
    `requester_email` STRING COMMENT 'The requester email of the data subject request record',
    `resolution_summary` STRING COMMENT 'The resolution summary of the data subject request record',
    `response_method` STRING COMMENT 'The response method of the data subject request record',
    `sla_breach_flag` BOOLEAN COMMENT 'The sla breach flag of the data subject request record',
    `sla_days` STRING COMMENT 'The sla days of the data subject request record',
    `source_system_code` STRING COMMENT 'The source system code of the data subject request record',
    `uom` STRING COMMENT 'The uom of the data subject request record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the data subject request record',
    `verification_method` STRING COMMENT 'Method used to verify the consumers identity.',
    `verification_status` STRING COMMENT 'The verification status of the data subject request record',
    CONSTRAINT pk_data_subject_request PRIMARY KEY(`data_subject_request_id`)
) COMMENT 'Master reference table for data_subject_request. Referenced by data_subject_request_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` (
    `panel_id` BIGINT COMMENT 'Primary key for panel',
    `loyalty_program_id` BIGINT COMMENT 'Identifier of the loyalty program the consumer belongs to.',
    `marketing_brand_id` BIGINT COMMENT 'The marketing brand id of the panel record',
    `employee_id` BIGINT COMMENT 'The owner employee id of the panel record',
    `parent_panel_id` BIGINT COMMENT 'Self-referencing FK on panel (parent_panel_id)',
    `household_id` BIGINT COMMENT 'Identifier linking the consumer to a household grouping.',
    `address_line1` STRING COMMENT 'First line of the consumers street address.',
    `address_line2` STRING COMMENT 'Second line of the consumers street address (optional).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the panel record',
    `city` STRING COMMENT 'City of the consumers residence.',
    `cltv` DECIMAL(18,2) COMMENT 'Estimated total revenue expected from the consumer over the relationship.',
    `panel_code` STRING COMMENT 'The panel code of the panel record',
    `consent_basis` STRING COMMENT 'The consent basis of the panel record',
    `consent_status` STRING COMMENT 'Consumers consent status for marketing communications.',
    `consumer_type` STRING COMMENT 'Classification of the consumer within the panel.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the consumers primary residence.',
    `country_scope` STRING COMMENT 'The country scope of the panel record',
    `created_date` DATE COMMENT 'The created date of the panel record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the panel record was first created.',
    `currency_code` STRING COMMENT 'The currency code of the panel record',
    `current_size` STRING COMMENT 'The current size of the panel record',
    `data_source` STRING COMMENT 'System of record or source from which the consumer data originated.',
    `date_of_birth` DATE COMMENT 'Consumers birth date.',
    `death_date` DATE COMMENT 'Date on which the consumer passed away, if applicable.',
    `demographic_criteria` STRING COMMENT 'The demographic criteria of the panel record',
    `panel_description` STRING COMMENT 'The panel description of the panel record',
    `do_not_call` BOOLEAN COMMENT 'Indicates whether the consumer is on a do‑not‑call list.',
    `effective_from` DATE COMMENT 'The effective from of the panel record',
    `effective_until` DATE COMMENT 'The effective until of the panel record',
    `email` STRING COMMENT 'Primary email address for consumer communications.',
    `end_date` DATE COMMENT 'The end date of the panel record',
    `ethnicity` STRING COMMENT 'Self‑identified ethnicity of the consumer. [ENUM-REF-CANDIDATE: asian|black|hispanic|white|other|prefer_not_to_say — promote to reference product]',
    `first_name` STRING COMMENT 'Given name of the consumer.',
    `full_name` STRING COMMENT 'Complete legal name of the consumer.',
    `gender` STRING COMMENT 'Self‑identified gender of the consumer.',
    `geographic_scope` STRING COMMENT 'The geographic scope of the panel record',
    `household_income` DECIMAL(18,2) COMMENT 'Estimated annual household income of the consumer.',
    `incentive_model` STRING COMMENT 'The incentive model of the panel record',
    `incentive_type` STRING COMMENT 'The incentive type of the panel record',
    `is_deceased` BOOLEAN COMMENT 'True if the consumer is recorded as deceased.',
    `language_preference` STRING COMMENT 'Preferred language for communications.',
    `last_name` STRING COMMENT 'Family name of the consumer.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase made by the consumer.',
    `launch_date` DATE COMMENT 'The launch date of the panel record',
    `loyalty_tier` STRING COMMENT 'Current tier level of the consumer within the loyalty program.',
    `marital_status` STRING COMMENT 'Current marital status of the consumer.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the consumer has opted in to receive marketing communications.',
    `member_count` BIGINT COMMENT 'The member count of the panel record',
    `panel_name` STRING COMMENT 'The panel name of the panel record',
    `notes` STRING COMMENT 'The notes of the panel record',
    `nps_score` STRING COMMENT 'Latest NPS rating provided by the consumer (0‑10).',
    `panel_status` STRING COMMENT 'Current lifecycle status of the consumer record.',
    `panel_type` STRING COMMENT 'The panel type of the panel record',
    `phone_number` STRING COMMENT 'Primary telephone number for the consumer.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the consumers address.',
    `preferred_channel` STRING COMMENT 'Consumers preferred sales or service channel.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for contacting the consumer.',
    `privacy_opt_in_date` DATE COMMENT 'Date when the consumer gave privacy consent.',
    `provider` STRING COMMENT 'The provider of the panel record',
    `provider_name` STRING COMMENT 'The provider name of the panel record',
    `purchase_count` STRING COMMENT 'Number of distinct purchase transactions recorded for the consumer.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the panel record',
    `record_source_system` STRING COMMENT 'Name of the upstream system that supplied this panel record.',
    `recruitment_method` STRING COMMENT 'The recruitment method of the panel record',
    `recruitment_start_date` DATE COMMENT 'The recruitment start date of the panel record',
    `segment` STRING COMMENT 'Marketing segment classification for the consumer. [ENUM-REF-CANDIDATE: value_seeker|brand_loyalist|price_sensitive|premium|occasional|new_customer — promote to reference product]',
    `size` STRING COMMENT 'The size of the panel record',
    `source_system_code` STRING COMMENT 'The source system code of the panel record',
    `start_date` DATE COMMENT 'The start date of the panel record',
    `state` STRING COMMENT 'State or province of the consumers residence.',
    `target_size` STRING COMMENT 'The target size of the panel record',
    `total_purchase_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all purchases made by the consumer.',
    `uom` STRING COMMENT 'The uom of the panel record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the panel record.',
    `vendor_name` STRING COMMENT 'The vendor name of the panel record',
    CONSTRAINT pk_panel PRIMARY KEY(`panel_id`)
) COMMENT 'Master reference table for panel. Referenced by panel_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` (
    `loyalty_tier_id` BIGINT COMMENT 'Primary key for loyalty_tier',
    `loyalty_program_id` BIGINT COMMENT 'Loyalty program this tier belongs to.',
    `next_loyalty_tier_id` BIGINT COMMENT 'Self-referencing FK on loyalty_tier (next_loyalty_tier_id)',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the loyalty tier record',
    `benefit_description` STRING COMMENT 'The benefit description of the loyalty tier record',
    `benefit_multiplier` DECIMAL(18,2) COMMENT 'The benefit multiplier of the loyalty tier record',
    `benefits_description` STRING COMMENT 'Narrative description of the benefits associated with the tier.',
    `loyalty_tier_code` STRING COMMENT 'The loyalty tier code of the loyalty tier record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tier record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the loyalty tier record',
    `loyalty_tier_description` STRING COMMENT 'The loyalty tier description of the loyalty tier record',
    `discount_percent` DECIMAL(18,2) COMMENT 'Standard discount percentage applied to purchases for members in this tier.',
    `earn_multiplier` DECIMAL(18,2) COMMENT 'The earn multiplier of the loyalty tier record',
    `effective_date` DATE COMMENT 'The effective date of the loyalty tier record',
    `effective_from` DATE COMMENT 'Date when the tier becomes valid for members.',
    `effective_from_date` DATE COMMENT 'The effective from date of the loyalty tier record',
    `effective_until` DATE COMMENT 'Date when the tier expires or is superseded; null for open‑ended.',
    `effective_until_date` DATE COMMENT 'The effective until date of the loyalty tier record',
    `eligibility_criteria` STRING COMMENT 'Detailed rules that define how members qualify for the tier beyond points/spend thresholds.',
    `exclusive_offers` BOOLEAN COMMENT 'Indicates whether the tier grants access to exclusive promotions.',
    `expiration_policy` STRING COMMENT 'Policy governing how tier status expires or rolls over.',
    `expiry_date` DATE COMMENT 'The expiry date of the loyalty tier record',
    `free_shipping` BOOLEAN COMMENT 'Indicates whether the tier includes complimentary shipping.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this tier is the default assignment for new members.',
    `loyalty_tier_status` STRING COMMENT 'Current lifecycle state of the tier.',
    `max_points_per_year` BIGINT COMMENT 'Cap on the number of points a member can earn in a calendar year while in this tier.',
    `min_points_threshold` STRING COMMENT 'The min points threshold of the loyalty tier record',
    `min_qualifying_points` DECIMAL(18,2) COMMENT 'The min qualifying points of the loyalty tier record',
    `min_qualifying_spend` DECIMAL(18,2) COMMENT 'The min qualifying spend of the loyalty tier record',
    `loyalty_tier_name` STRING COMMENT 'The loyalty tier name of the loyalty tier record',
    `notes` STRING COMMENT 'The notes of the loyalty tier record',
    `points_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to earned points for members in this tier.',
    `priority_support` BOOLEAN COMMENT 'Indicates whether members receive priority customer support.',
    `promotional_code` STRING COMMENT 'Optional code used in marketing campaigns to reference the tier.',
    `qualification_metric` STRING COMMENT 'The qualification metric of the loyalty tier record',
    `qualification_period_months` STRING COMMENT 'The qualification period months of the loyalty tier record',
    `qualification_points_min` DECIMAL(18,2) COMMENT 'The qualification points min of the loyalty tier record',
    `qualification_spend_min` DECIMAL(18,2) COMMENT 'The qualification spend min of the loyalty tier record',
    `qualification_threshold` DECIMAL(18,2) COMMENT 'The qualification threshold of the loyalty tier record',
    `qualifying_threshold` DECIMAL(18,2) COMMENT 'The qualifying threshold of the loyalty tier record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the loyalty tier record',
    `record_source_system` STRING COMMENT 'The record source system of the loyalty tier record',
    `required_points` BIGINT COMMENT 'Number of loyalty points a member must accumulate to qualify for this tier.',
    `required_spend_usd` DECIMAL(18,2) COMMENT 'Monetary spend threshold (in USD) required to reach the tier.',
    `retention_threshold` DECIMAL(18,2) COMMENT 'The retention threshold of the loyalty tier record',
    `reward_points_per_dollar` DECIMAL(18,2) COMMENT 'Number of loyalty points earned for each dollar spent by members in this tier.',
    `source_system_code` STRING COMMENT 'The source system code of the loyalty tier record',
    `spend_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to spend calculations for tier‑based rewards.',
    `tier_code` STRING COMMENT 'External code used to reference the loyalty tier in marketing and systems.',
    `tier_level` STRING COMMENT 'The tier level of the loyalty tier record',
    `tier_name` STRING COMMENT 'Human‑readable name of the loyalty tier (e.g., Gold, Platinum).',
    `tier_rank` STRING COMMENT 'Numeric rank used to order tiers from lowest to highest.',
    `tier_status` STRING COMMENT 'The tier status of the loyalty tier record',
    `tier_type` STRING COMMENT 'Classification of the tier based on the underlying qualification model.',
    `uom` STRING COMMENT 'The uom of the loyalty tier record',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the tier record.',
    `validity_period_months` STRING COMMENT 'The validity period months of the loyalty tier record',
    CONSTRAINT pk_loyalty_tier PRIMARY KEY(`loyalty_tier_id`)
) COMMENT 'Master reference table for loyalty_tier. Referenced by tier_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` (
    `survey_id` BIGINT COMMENT 'Primary key for survey',
    `campaign_id` BIGINT COMMENT 'The campaign id of the survey record',
    `marketing_brand_id` BIGINT COMMENT 'Brand associated with this survey.',
    `employee_id` BIGINT COMMENT 'The owner employee id of the survey record',
    `panel_id` BIGINT COMMENT 'The panel id of the survey record',
    `revised_survey_id` BIGINT COMMENT 'Self-referencing FK on survey (revised_survey_id)',
    `actual_response_count` STRING COMMENT 'The actual response count of the survey record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the survey record',
    `survey_category` STRING COMMENT 'Business category of the survey for reporting and analytics.',
    `channel` STRING COMMENT 'The channel of the survey record',
    `close_date` DATE COMMENT 'The close date of the survey record',
    `survey_code` STRING COMMENT 'The survey code of the survey record',
    `compliance_ccpa` BOOLEAN COMMENT 'True if the survey complies with CCPA requirements.',
    `compliance_gdpr` BOOLEAN COMMENT 'True if the survey complies with GDPR requirements.',
    `consent_basis` STRING COMMENT 'The consent basis of the survey record',
    `consent_required` BOOLEAN COMMENT 'Indicates whether respondent consent is mandatory before participation.',
    `consent_required_flag` BOOLEAN COMMENT 'The consent required flag of the survey record',
    `country_code` STRING COMMENT 'The country code of the survey record',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the survey record was first created.',
    `currency_code` STRING COMMENT 'The currency code of the survey record',
    `data_privacy_level` STRING COMMENT 'Classification of survey data handling requirements.',
    `delivery_channel` STRING COMMENT 'Channel through which the survey is distributed to respondents.',
    `survey_description` STRING COMMENT 'Detailed description of the survey purpose, scope and content.',
    `effective_from` DATE COMMENT 'Date when the survey becomes active and available to respondents.',
    `effective_until` DATE COMMENT 'Date when the survey is retired or no longer available (nullable for open‑ended surveys).',
    `end_date` DATE COMMENT 'The end date of the survey record',
    `estimated_completion_minutes` STRING COMMENT 'The estimated completion minutes of the survey record',
    `expiration_date` DATE COMMENT 'Date after which the survey is no longer accepted.',
    `incentive_offered_flag` BOOLEAN COMMENT 'The incentive offered flag of the survey record',
    `is_anonymous` BOOLEAN COMMENT 'Specifies if responses are collected without identifying the respondent.',
    `is_multilingual` BOOLEAN COMMENT 'Indicates whether the survey is offered in multiple languages.',
    `language` STRING COMMENT 'Primary language in which the survey is delivered.',
    `language_code` STRING COMMENT 'The language code of the survey record',
    `last_published_timestamp` TIMESTAMP COMMENT 'Date and time when the survey was most recently made live.',
    `launch_date` DATE COMMENT 'The launch date of the survey record',
    `length_minutes` STRING COMMENT 'Estimated time required for a respondent to complete the survey.',
    `logo_url` STRING COMMENT 'Link to the logo image displayed on the survey landing page.',
    `method` STRING COMMENT 'The method of the survey record',
    `methodology` STRING COMMENT 'The methodology of the survey record',
    `survey_name` STRING COMMENT 'The survey name of the survey record',
    `notes` STRING COMMENT 'Free‑form notes or comments about the survey.',
    `objective` STRING COMMENT 'The objective of the survey record',
    `owner_contact_email` STRING COMMENT 'Email address of the primary contact for the survey.',
    `owner_contact_phone` STRING COMMENT 'Phone number of the primary contact for the survey.',
    `owner_department` STRING COMMENT 'Internal department responsible for the survey design and execution.',
    `provider` STRING COMMENT 'The provider of the survey record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the survey record',
    `question_count` STRING COMMENT 'Total count of distinct questions in the survey.',
    `record_source_system` STRING COMMENT 'The record source system of the survey record',
    `response_count` STRING COMMENT 'The response count of the survey record',
    `response_rate` DECIMAL(18,2) COMMENT 'The response rate of the survey record',
    `response_rate_actual` DECIMAL(18,2) COMMENT 'Observed percentage of respondents who completed the survey.',
    `response_rate_target` DECIMAL(18,2) COMMENT 'Planned percentage of invited respondents to complete the survey.',
    `response_target` STRING COMMENT 'The response target of the survey record',
    `source_system_code` STRING COMMENT 'The source system code of the survey record',
    `start_date` DATE COMMENT 'The start date of the survey record',
    `survey_status` STRING COMMENT 'Current lifecycle state of the survey.',
    `survey_type` STRING COMMENT 'Classification of the survey based on the respondent group.',
    `target_audience` STRING COMMENT 'Intended respondent segment for the survey.',
    `target_response_count` STRING COMMENT 'The target response count of the survey record',
    `title` STRING COMMENT 'Human‑readable title of the survey presented to respondents.',
    `trigger_event` STRING COMMENT 'The trigger event of the survey record',
    `uom` STRING COMMENT 'The uom of the survey record',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the survey record.',
    `url` STRING COMMENT 'Web address where respondents can access the survey.',
    `version` STRING COMMENT 'The version of the survey record',
    `version_number` STRING COMMENT 'Version identifier for the survey definition.',
    CONSTRAINT pk_survey PRIMARY KEY(`survey_id`)
) COMMENT 'Master reference table for survey. Referenced by survey_id.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` (
    `interaction_session_id` BIGINT COMMENT 'Primary key for interaction_session',
    `employee_id` BIGINT COMMENT 'Reference to the customer service agent or store associate who handled this session, applicable for call_center or in_store channel sessions. Null for self-service digital sessions.',
    `loyalty_account_id` BIGINT COMMENT 'Reference to the loyalty program membership record associated with this session, if the consumer is enrolled in a loyalty program at the time of interaction.',
    `order_id` BIGINT COMMENT 'Reference to the sales order placed during this session, if a purchase conversion occurred. Null if no order was placed. Links the session to the transactional order record for revenue attribution.',
    `parent_interaction_session_id` BIGINT COMMENT 'Self-referencing FK on interaction_session (parent_interaction_session_id)',
    `retail_store_id` BIGINT COMMENT 'Reference to the physical retail store associated with this session, applicable for in-store interaction sessions. Null for digital channel sessions.',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer or shopper who initiated this interaction session. Links to the master consumer profile in the consumer domain.',
    `ab_test_variant` STRING COMMENT 'The A/B or multivariate test variant identifier assigned to this session. Used to attribute session outcomes to specific experience variants for experimentation and CRO analysis.',
    `app_version` STRING COMMENT 'The version of the mobile application or digital platform used during this session (e.g., 4.2.1). Used for version-level performance analysis and to correlate session quality with app release cycles.',
    `browser_type` STRING COMMENT 'The web browser or application client used during the session (e.g., Chrome, Safari, Firefox, Edge, native_app). Relevant for digital channel sessions to support UX and compatibility analysis.',
    `campaign_code` STRING COMMENT 'The marketing campaign identifier (UTM campaign parameter or internal campaign code) associated with this session. Used to attribute sessions to specific promotional or advertising campaigns.',
    `cart_value_amount` DECIMAL(18,2) COMMENT 'The total monetary value of items added to the shopping cart during this session, in the transaction currency. Represents the gross basket value before any discounts or checkout completion.',
    `channel_type` STRING COMMENT 'The consumer engagement channel through which this interaction session occurred. Supports omnichannel analytics and channel attribution reporting. [ENUM-REF-CANDIDATE: web|mobile_app|in_store|call_center|social_media|email|chatbot|kiosk — promote to reference product if additional channels are added]',
    `consent_status` STRING COMMENT 'The consumers data processing consent status captured at the start of this session, reflecting GDPR/CCPA compliance requirements. granted indicates full consent; partial indicates selective consent (e.g., analytics only); denied indicates no consent; not_collected indicates consent was not solicited.',
    `consent_version` STRING COMMENT 'The version identifier of the consent notice or cookie banner presented to the consumer during this session. Used to track which consent framework version was in effect at the time of data collection.',
    `conversion_type` STRING COMMENT 'The specific type of conversion goal achieved during this session, if is_converted is True. Null if no conversion occurred. [ENUM-REF-CANDIDATE: purchase|registration|loyalty_enrollment|newsletter_signup|sample_request|app_download|coupon_claim — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this interaction session record was first captured and persisted in the data platform. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code applicable to monetary values in this session record (e.g., USD, EUR, GBP). Supports multi-currency reporting for global Consumer Goods operations.',
    `data_source_system` STRING COMMENT 'The name of the operational system of record that originated this interaction session record (e.g., Salesforce_Commerce_Cloud, Adobe_Analytics, SAP_CX, In_Store_POS). Used for data lineage and source system traceability.',
    `device_os` STRING COMMENT 'The operating system of the device used during the session (e.g., iOS, Android, Windows, macOS, ChromeOS). Used for technical compatibility and consumer experience analytics.',
    `device_type` STRING COMMENT 'The category of device used by the consumer during this interaction session. Supports device-level analytics and responsive experience optimization.',
    `duration_seconds` STRING COMMENT 'The total elapsed time of the interaction session measured in seconds, calculated as the difference between session_end_timestamp and session_start_timestamp. Used for engagement depth analysis.',
    `error_count` STRING COMMENT 'The number of application or system errors encountered by the consumer during this session (e.g., page load failures, checkout errors, API timeouts). Used for digital experience quality monitoring.',
    `event_count` STRING COMMENT 'The total number of discrete interaction events (clicks, taps, form submissions, product views, add-to-cart actions) recorded within this session. Used for behavioral analytics.',
    `exit_page_url` STRING COMMENT 'The URL of the last page or screen the consumer viewed before ending the session. Used for exit-point analysis and funnel drop-off identification.',
    `geo_country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code representing the geographic location of the consumer during the session, derived from IP geolocation or device locale. Used for regional analytics and compliance jurisdiction determination.',
    `geo_region` STRING COMMENT 'The sub-national region or state/province of the consumer during the session (e.g., California, Bavaria, Ontario). Used for regional sales and marketing analytics.',
    `interaction_type` STRING COMMENT 'The primary nature or purpose of the consumer interaction session. Classifies the session for segmentation, personalization, and engagement analytics. [ENUM-REF-CANDIDATE: browse|purchase|support|loyalty_redemption|product_review|complaint|survey|onboarding — promote to reference product]',
    `ip_address` STRING COMMENT 'The IP address of the consumers device at the time of the session. Used for geolocation inference, fraud detection, and security monitoring. May be considered PII under GDPR/CCPA in some jurisdictions.',
    `is_authenticated` BOOLEAN COMMENT 'Indicates whether the consumer was authenticated (logged in) during this session. Authenticated sessions enable personalization and loyalty tracking; unauthenticated sessions are anonymous.',
    `is_bounced` BOOLEAN COMMENT 'Indicates whether the consumer left the session after viewing only a single page or screen without any further interaction. A bounce session signals low engagement and is a key digital performance metric.',
    `is_converted` BOOLEAN COMMENT 'Indicates whether the consumer completed a defined conversion goal (e.g., purchase, registration, loyalty enrollment) during this session. Used for conversion rate optimization and funnel analysis.',
    `is_new_consumer` BOOLEAN COMMENT 'Indicates whether this session represents the first-ever interaction of this consumer with the brand across any channel. Used for new vs. returning consumer segmentation and acquisition analytics.',
    `landing_page_url` STRING COMMENT 'The URL of the first page or screen the consumer viewed when entering this session. Used for entry-point analysis and campaign landing page performance measurement.',
    `nps_score` STRING COMMENT 'The Net Promoter Score (NPS) rating provided by the consumer during or immediately following this session, on a scale of 0–10. Null if no NPS survey was presented or completed during this session.',
    `page_view_count` STRING COMMENT 'The total number of distinct pages or screens viewed by the consumer during this session. Indicates engagement depth and browsing behavior for digital sessions.',
    `personalization_segment_code` STRING COMMENT 'The consumer segment code applied to this session for real-time personalization and content targeting purposes. Derived from the consumers profile and behavioral history at session initiation.',
    `referrer_url` STRING COMMENT 'The URL of the page or external source that referred the consumer to this session. Used for traffic source analysis and marketing attribution in digital channels.',
    `satisfaction_rating` STRING COMMENT 'The consumer satisfaction rating (CSAT) provided during or after this session, typically on a 1–5 scale. Distinct from NPS; captures immediate transactional satisfaction rather than overall brand loyalty.',
    `session_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consumer interaction session was closed, completed, or expired. Null if the session is still active.',
    `session_language_code` STRING COMMENT 'The BCP 47 language code representing the language in which the consumer interacted during this session (e.g., en-US, fr-FR, de-DE). Used for localization analytics and multilingual support reporting.',
    `session_medium` STRING COMMENT 'The marketing medium associated with the session source (e.g., cpc, organic, email, referral, none). Complements session_source for UTM-based campaign attribution.',
    `session_quality_score` DECIMAL(18,2) COMMENT 'A composite quality score (0.00–100.00) assigned to this session based on engagement signals such as duration, page views, and interaction events. Used for consumer engagement benchmarking and experience optimization.',
    `session_source` STRING COMMENT 'The originating traffic source or referral medium that initiated this session (e.g., organic_search, paid_search, email_campaign, direct, social_referral). Used for marketing attribution and campaign performance analysis.',
    `session_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the consumer interaction session was initiated. This is the principal real-world event time for the session lifecycle.',
    `session_status` STRING COMMENT 'Current lifecycle state of the interaction session. active indicates an ongoing session; completed indicates a natural close; abandoned indicates the consumer left without completing an action; expired indicates timeout; terminated indicates a forced close.',
    `session_token` STRING COMMENT 'Externally-known unique alphanumeric token assigned to this interaction session, used for cross-system correlation and session continuity tracking across touchpoints.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this interaction session record was last modified in the data platform. Used for change tracking and incremental processing.',
    CONSTRAINT pk_interaction_session PRIMARY KEY(`interaction_session_id`)
) COMMENT 'Master reference table for interaction_session. Referenced by session_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ADD CONSTRAINT `fk_consumer_shopper_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`household`(`household_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ADD CONSTRAINT `fk_consumer_shopper_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ADD CONSTRAINT `fk_consumer_shopper_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`address`(`address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ADD CONSTRAINT `fk_consumer_household_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ADD CONSTRAINT `fk_consumer_household_merged_from_household_id` FOREIGN KEY (`merged_from_household_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`household`(`household_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ADD CONSTRAINT `fk_consumer_household_panel_id` FOREIGN KEY (`panel_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`panel`(`panel_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ADD CONSTRAINT `fk_consumer_household_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ADD CONSTRAINT `fk_consumer_address_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`household`(`household_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ADD CONSTRAINT `fk_consumer_address_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ADD CONSTRAINT `fk_consumer_loyalty_account_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ADD CONSTRAINT `fk_consumer_loyalty_account_loyalty_tier_id` FOREIGN KEY (`loyalty_tier_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier`(`loyalty_tier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ADD CONSTRAINT `fk_consumer_loyalty_account_primary_loyalty_program_id` FOREIGN KEY (`primary_loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ADD CONSTRAINT `fk_consumer_loyalty_account_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_loyalty_account_id` FOREIGN KEY (`loyalty_account_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_account`(`loyalty_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_loyalty_tier_id` FOREIGN KEY (`loyalty_tier_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier`(`loyalty_tier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_reversal_reference_loyalty_transaction_id` FOREIGN KEY (`reversal_reference_loyalty_transaction_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction`(`loyalty_transaction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ADD CONSTRAINT `fk_consumer_segment_parent_segment_id` FOREIGN KEY (`parent_segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`household`(`household_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_preference_center_id` FOREIGN KEY (`preference_center_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`preference_center`(`preference_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ADD CONSTRAINT `fk_consumer_preference_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ADD CONSTRAINT `fk_consumer_consent_event_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ADD CONSTRAINT `fk_consumer_consent_event_consent_session_id` FOREIGN KEY (`consent_session_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`consent_session`(`consent_session_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ADD CONSTRAINT `fk_consumer_consent_event_data_subject_request_id` FOREIGN KEY (`data_subject_request_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ADD CONSTRAINT `fk_consumer_consent_event_preference_center_id` FOREIGN KEY (`preference_center_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`preference_center`(`preference_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ADD CONSTRAINT `fk_consumer_consent_event_reversal_event_consent_event_id` FOREIGN KEY (`reversal_event_consent_event_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`consent_event`(`consent_event_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ADD CONSTRAINT `fk_consumer_consent_event_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`address`(`address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_dtc_order_id` FOREIGN KEY (`dtc_order_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`dtc_order`(`dtc_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_dtc_return_id` FOREIGN KEY (`dtc_return_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`dtc_return`(`dtc_return_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_dtc_order_id` FOREIGN KEY (`dtc_order_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`dtc_order`(`dtc_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_dtc_order_line_id` FOREIGN KEY (`dtc_order_line_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line`(`dtc_order_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line`(`dtc_order_line_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ADD CONSTRAINT `fk_consumer_dtc_return_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`interaction`(`interaction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ADD CONSTRAINT `fk_consumer_nps_response_survey_id` FOREIGN KEY (`survey_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`survey`(`survey_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`household`(`household_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_interaction_session_id` FOREIGN KEY (`interaction_session_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`interaction_session`(`interaction_session_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_parent_interaction_id` FOREIGN KEY (`parent_interaction_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`interaction`(`interaction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ADD CONSTRAINT `fk_consumer_interaction_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`address`(`address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`address`(`address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_subscription_delivery_address_id` FOREIGN KEY (`subscription_delivery_address_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`address`(`address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ADD CONSTRAINT `fk_consumer_cltv_record_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`household`(`household_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ADD CONSTRAINT `fk_consumer_cltv_record_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ADD CONSTRAINT `fk_consumer_cltv_record_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ADD CONSTRAINT `fk_consumer_communication_preference_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ADD CONSTRAINT `fk_consumer_communication_preference_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ADD CONSTRAINT `fk_consumer_communication_preference_preference_center_id` FOREIGN KEY (`preference_center_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`preference_center`(`preference_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ADD CONSTRAINT `fk_consumer_communication_preference_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ADD CONSTRAINT `fk_consumer_identity_link_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ADD CONSTRAINT `fk_consumer_identity_link_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`household`(`household_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ADD CONSTRAINT `fk_consumer_identity_link_loyalty_account_id` FOREIGN KEY (`loyalty_account_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_account`(`loyalty_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ADD CONSTRAINT `fk_consumer_identity_link_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ADD CONSTRAINT `fk_consumer_identity_link_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_dtc_order_id` FOREIGN KEY (`dtc_order_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`dtc_order`(`dtc_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_program_id` FOREIGN KEY (`program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_referral_referred_shopper_id` FOREIGN KEY (`referral_referred_shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ADD CONSTRAINT `fk_consumer_referral_referral_referrer_shopper_id` FOREIGN KEY (`referral_referrer_shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_consent_record_id` FOREIGN KEY (`consent_record_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`consent_record`(`consent_record_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_panel_id` FOREIGN KEY (`panel_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`panel`(`panel_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ADD CONSTRAINT `fk_consumer_research_participation_survey_id` FOREIGN KEY (`survey_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`survey`(`survey_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ADD CONSTRAINT `fk_consumer_loyalty_program_predecessor_loyalty_program_id` FOREIGN KEY (`predecessor_loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ADD CONSTRAINT `fk_consumer_consent_session_preference_center_id` FOREIGN KEY (`preference_center_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`preference_center`(`preference_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ADD CONSTRAINT `fk_consumer_consent_session_renewed_consent_session_id` FOREIGN KEY (`renewed_consent_session_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`consent_session`(`consent_session_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ADD CONSTRAINT `fk_consumer_consent_session_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ADD CONSTRAINT `fk_consumer_preference_center_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ADD CONSTRAINT `fk_consumer_preference_center_previous_preference_center_id` FOREIGN KEY (`previous_preference_center_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`preference_center`(`preference_center_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ADD CONSTRAINT `fk_consumer_preference_center_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ADD CONSTRAINT `fk_consumer_data_subject_request_original_data_subject_request_id` FOREIGN KEY (`original_data_subject_request_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`data_subject_request`(`data_subject_request_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ADD CONSTRAINT `fk_consumer_data_subject_request_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ADD CONSTRAINT `fk_consumer_panel_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ADD CONSTRAINT `fk_consumer_panel_parent_panel_id` FOREIGN KEY (`parent_panel_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`panel`(`panel_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ADD CONSTRAINT `fk_consumer_panel_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`household`(`household_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ADD CONSTRAINT `fk_consumer_loyalty_tier_loyalty_program_id` FOREIGN KEY (`loyalty_program_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_program`(`loyalty_program_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ADD CONSTRAINT `fk_consumer_loyalty_tier_next_loyalty_tier_id` FOREIGN KEY (`next_loyalty_tier_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier`(`loyalty_tier_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ADD CONSTRAINT `fk_consumer_survey_panel_id` FOREIGN KEY (`panel_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`panel`(`panel_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ADD CONSTRAINT `fk_consumer_survey_revised_survey_id` FOREIGN KEY (`revised_survey_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`survey`(`survey_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ADD CONSTRAINT `fk_consumer_interaction_session_loyalty_account_id` FOREIGN KEY (`loyalty_account_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_account`(`loyalty_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ADD CONSTRAINT `fk_consumer_interaction_session_parent_interaction_session_id` FOREIGN KEY (`parent_interaction_session_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`interaction_session`(`interaction_session_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ADD CONSTRAINT `fk_consumer_interaction_session_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`consumer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`consumer` SET TAGS ('dbx_domain' = 'consumer');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `household_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `household_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Member ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `address_id` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Consumer Acquisition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `age_verified` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `ccpa_subject` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Subject Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_value_regex' = 'high_value|mid_value|low_value|at_risk|churned');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `shopper_code` SET TAGS ('dbx_business_glossary_term' = 'Shopper Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `consumer_type` SET TAGS ('dbx_business_glossary_term' = 'Consumer Type Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `consumer_type` SET TAGS ('dbx_value_regex' = 'individual|household|business_buyer|loyalty_member|guest');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Residence Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `data_sharing_consent` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Data Sharing Consent');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date Of Birth');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `shopper_description` SET TAGS ('dbx_business_glossary_term' = 'Shopper Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Display Name (Preferred Name)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `display_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Email Marketing Opt-In Consent');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Family Name (Last Name / Surname)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `first_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `first_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'First Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `gdpr_subject` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Subject Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender Identity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Given Name (First Name)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `identity_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `identity_verified` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `last_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Consumer Lifecycle Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|opted_out|suspended|pending_verification');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `lifetime_value` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `loyalty_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Enrollment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `loyalty_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Balance');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `loyalty_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt In');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `shopper_name` SET TAGS ('dbx_business_glossary_term' = 'Shopper Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `phone` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `phone` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal / ZIP Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code (ISO 4217)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `preferred_store_banner` SET TAGS ('dbx_business_glossary_term' = 'Preferred Retail Store Banner');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `primary_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{6,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `push_notification_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Opt-In Consent');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `registration_source_url` SET TAGS ('dbx_business_glossary_term' = 'Registration Source URL');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `shopper_status` SET TAGS ('dbx_business_glossary_term' = 'Shopper Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `sms_opt_in` SET TAGS ('dbx_business_glossary_term' = 'SMS Marketing Opt-In Consent');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `source_system_consumer_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Consumer Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `source_system_consumer_ref` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `source_system_consumer_ref` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `merged_from_household_id` SET TAGS ('dbx_business_glossary_term' = 'Merged From Household ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `panel_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Panel ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `address_summary` SET TAGS ('dbx_business_glossary_term' = 'Address Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `address_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `address_summary` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `brand_affinity_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Affinity Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'CCPA Opt-Out Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `children_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Children Present Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `cltv_band` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Band');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `cltv_band` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_code` SET TAGS ('dbx_business_glossary_term' = 'Household Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_code` SET TAGS ('dbx_value_regex' = '^HH-[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `consent_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_description` SET TAGS ('dbx_business_glossary_term' = 'Household Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `digital_engagement_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Engagement Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Household Dissolution Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `dwelling_type` SET TAGS ('dbx_business_glossary_term' = 'Dwelling Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `dwelling_type` SET TAGS ('dbx_value_regex' = 'house|apartment|condo|townhouse|mobile_home|other');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `estimated_size` SET TAGS ('dbx_business_glossary_term' = 'Estimated Household Size');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `formation_date` SET TAGS ('dbx_business_glossary_term' = 'Household Formation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `geographic_region` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `geographic_region` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `has_children` SET TAGS ('dbx_business_glossary_term' = 'Has Children');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_business_glossary_term' = 'Household Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|merged|dissolved');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_business_glossary_term' = 'Household Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_type` SET TAGS ('dbx_value_regex' = 'single|couple|family|multi_generational|shared_living|other');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `income_band` SET TAGS ('dbx_business_glossary_term' = 'Household Income Band');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `income_band` SET TAGS ('dbx_value_regex' = 'low|lower_middle|middle|upper_middle|high');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `income_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `income_bracket` SET TAGS ('dbx_business_glossary_term' = 'Income Bracket');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `life_stage` SET TAGS ('dbx_business_glossary_term' = 'Household Life Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `loyalty_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Enrollment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `loyalty_points_balance` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Balance');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_business_glossary_term' = 'Household Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `number_of_children` SET TAGS ('dbx_business_glossary_term' = 'Number Of Children');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `panel_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Panel Member Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `pet_owner_flag` SET TAGS ('dbx_business_glossary_term' = 'Pet Owner Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `primary_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Purchase Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `primary_channel` SET TAGS ('dbx_value_regex' = 'retail|ecommerce|dtc|wholesale|omnichannel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `primary_retailer_banner` SET TAGS ('dbx_business_glossary_term' = 'Primary Retailer Banner');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `private_label_buyer_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Buyer Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `purchase_frequency_band` SET TAGS ('dbx_business_glossary_term' = 'Purchase Frequency Band');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `purchase_frequency_band` SET TAGS ('dbx_value_regex' = 'occasional|regular|frequent|very_frequent');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Size');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `tenure_type` SET TAGS ('dbx_business_glossary_term' = 'Dwelling Tenure Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `tenure_type` SET TAGS ('dbx_value_regex' = 'owner|renter|other');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` SET TAGS ('dbx_natural_key_normalized' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Address ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_natural_key' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `household_id` SET TAGS ('dbx_ssot_join_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `household_id` SET TAGS ('dbx_natural_key_resolution' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `household_id` SET TAGS ('dbx_natural_key_source' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `shopper_id` SET TAGS ('dbx_ssot_join_key' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `shopper_id` SET TAGS ('dbx_natural_key_resolution' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `shopper_id` SET TAGS ('dbx_natural_key_source' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted|pending_review');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'billing|shipping|home|work|preferred');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_code` SET TAGS ('dbx_business_glossary_term' = 'Address Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `consent_captured` SET TAGS ('dbx_business_glossary_term' = 'Address Consent Captured Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Address Consent Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `data_residency_region` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Region');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `data_residency_region` SET TAGS ('dbx_value_regex' = 'EU|US|APAC|LATAM|MEA|CA');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `data_residency_region` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `data_residency_region` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `deliverability_score` SET TAGS ('dbx_business_glossary_term' = 'Address Deliverability Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_description` SET TAGS ('dbx_business_glossary_term' = 'Address Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_description` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `do_not_mail` SET TAGS ('dbx_business_glossary_term' = 'Do Not Mail Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `dpv_confirmation` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Validation (DPV) Confirmation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `dpv_confirmation` SET TAGS ('dbx_value_regex' = 'Y|S|D|N');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `dpv_confirmation` SET TAGS ('dbx_derived_from' = 'validation_provider');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Address Format Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'domestic|international|po_box|military|rural_route');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Accuracy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_value_regex' = 'rooftop|range_interpolated|geometric_center|approximate|failed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `geocoding_accuracy` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `is_default_billing` SET TAGS ('dbx_business_glossary_term' = 'Is Default Billing Address Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `is_default_shipping` SET TAGS ('dbx_business_glossary_term' = 'Is Default Shipping Address Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Address Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `is_validated` SET TAGS ('dbx_business_glossary_term' = 'Is Validated');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_name` SET TAGS ('dbx_business_glossary_term' = 'Address Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `address_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `plus4_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP+4 Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `plus4_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `residential_indicator` SET TAGS ('dbx_business_glossary_term' = 'Residential Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `residential_indicator` SET TAGS ('dbx_value_regex' = 'residential|commercial|mixed|unknown');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Address Source');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `source` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `source_record_code` SET TAGS ('dbx_governance' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key' = 'source-composite');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `source_system_code` SET TAGS ('dbx_natural_key_role' = 'source_system_metadata');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `source_system_code` SET TAGS ('dbx_denormalized' = 'false');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_business_glossary_term' = 'Standardized Address');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `standardized_address` SET TAGS ('dbx_derived_from' = 'validation_provider');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `valid_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid To Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `validation_provider` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Provider');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `validation_provider` SET TAGS ('dbx_natural_key_role' = 'validation_source');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `validation_provider` SET TAGS ('dbx_denormalized' = 'false');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed|corrected|pending');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_derived_from' = 'validation_provider');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_derived_from' = 'validation_provider');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` SET TAGS ('dbx_subdomain' = 'loyalty_programs');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `loyalty_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `primary_loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Home Store ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending|frozen');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'individual|household|business|coalition');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_value_regex' = 'high_value|mid_value|low_value|at_risk|lapsed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `loyalty_account_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|sms|push|post|none');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `consent_data_sharing` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `consent_marketing` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `loyalty_account_description` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|in_store|call_center|partner|dtc');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `enrollment_source_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Account Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `fraud_review_date` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `last_earn_date` SET TAGS ('dbx_business_glossary_term' = 'Last Points Earn Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `last_redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Last Points Redemption Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `lifetime_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Earned');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `lifetime_points_expired` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Expired');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `lifetime_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Points Redeemed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `linked_card_token` SET TAGS ('dbx_business_glossary_term' = 'Linked Payment Card Token');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `linked_card_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `linked_card_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `loyalty_account_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `membership_tier` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `membership_tier` SET TAGS ('dbx_value_regex' = 'standard|silver|gold|platinum|elite');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `loyalty_account_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Program Opt-Out Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `points_balance` SET TAGS ('dbx_business_glossary_term' = 'Points Balance');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `points_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Points Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `points_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Policy');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_value_regex' = 'rolling_12_months|annual|never|program_end|activity_based');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `points_lifetime_earned` SET TAGS ('dbx_business_glossary_term' = 'Points Lifetime Earned');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `preferred_redemption_type` SET TAGS ('dbx_business_glossary_term' = 'Preferred Redemption Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `preferred_redemption_type` SET TAGS ('dbx_value_regex' = 'discount|free_product|gift_card|charity|cashback|experience');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `previous_tier` SET TAGS ('dbx_business_glossary_term' = 'Previous Membership Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `previous_tier` SET TAGS ('dbx_value_regex' = 'standard|silver|gold|platinum|elite');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SFCGC|SAP_S4|ORACLE_ERP|CUSTOM_CRM|TRADEEDGE');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `tier_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `tier_qualification_spend` SET TAGS ('dbx_business_glossary_term' = 'Tier Qualification Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `tier_review_date` SET TAGS ('dbx_business_glossary_term' = 'Tier Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` SET TAGS ('dbx_subdomain' = 'loyalty_programs');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `loyalty_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `loyalty_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `reversal_reference_loyalty_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reference Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `adjustment_notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `bonus_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Bonus Points Multiplier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'ecommerce|mobile_app|retail_store|dtc_website|call_centre|kiosk');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `loyalty_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Consent Verified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `data_retention_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `loyalty_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `earn_rate` SET TAGS ('dbx_business_glossary_term' = 'Earn Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|under_review|cleared|confirmed_fraud');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `is_bonus_transaction` SET TAGS ('dbx_business_glossary_term' = 'Is Bonus Transaction Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `loyalty_transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `monetary_value` SET TAGS ('dbx_business_glossary_term' = 'Monetary Value');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `monetary_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `monetary_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `loyalty_transaction_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `points_amount` SET TAGS ('dbx_business_glossary_term' = 'Points Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `points_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Points Balance After Transaction');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `points_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Points Balance Before Transaction');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `points_direction` SET TAGS ('dbx_business_glossary_term' = 'Points Direction');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `points_direction` SET TAGS ('dbx_value_regex' = 'credit|debit');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `points_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `points_liability_flag` SET TAGS ('dbx_business_glossary_term' = 'Points Liability Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `program_year` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Year');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `qualifying_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `qualifying_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `qualifying_spend_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `redemption_value` SET TAGS ('dbx_business_glossary_term' = 'Redemption Value');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `redemption_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `redemption_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `source_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^LT-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|processed|reversed|failed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'earn|redeem|adjust|expire|transfer|reversal');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Trigger Event');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `parent_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Segment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `activation_channel` SET TAGS ('dbx_business_glossary_term' = 'Activation Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `activation_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|paid_media|in_store|all');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `age_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Range');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `age_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Range');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|manual|hybrid');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `channel_scope` SET TAGS ('dbx_value_regex' = 'dtc|retail|ecommerce|wholesale|omnichannel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `cltv_max_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Customer Lifetime Value (CLTV) Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `cltv_min_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Customer Lifetime Value (CLTV) Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `consent_basis` SET TAGS ('dbx_business_glossary_term' = 'Consent Legal Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `consent_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `consent_required` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `criteria_definition` SET TAGS ('dbx_business_glossary_term' = 'Criteria Definition');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `definition_logic` SET TAGS ('dbx_business_glossary_term' = 'Definition Logic');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `is_suppression_segment` SET TAGS ('dbx_business_glossary_term' = 'Suppression Segment Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `last_refresh_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Segment Refresh Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `loyalty_tier_scope` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `loyalty_tier_scope` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|all');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `min_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Confidence Score Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `ml_model_code` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Model Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^vd+.d+(.d+)?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `nps_score_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Net Promoter Score (NPS) Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `nps_score_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Net Promoter Score (NPS) Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit (BU)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `personalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Personalization Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Segment Refresh Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `rfm_frequency_min` SET TAGS ('dbx_business_glossary_term' = 'RFM Minimum Purchase Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `rfm_monetary_min` SET TAGS ('dbx_business_glossary_term' = 'RFM Minimum Monetary Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `rfm_recency_days` SET TAGS ('dbx_business_glossary_term' = 'RFM Recency Window (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'behavioral|demographic|psychographic|rfm|cltv_based|geographic');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `source_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Segment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `target_audience_size` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Size');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `trade_promotion_eligible` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion (TPM) Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Segment Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Consent Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `activation_count` SET TAGS ('dbx_business_glossary_term' = 'Segment Activation Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|manual|propensity_score|lookalike');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `brand_affinity_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Affinity Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Consumer Engagement Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'dtc|ecommerce|retail|wholesale|loyalty|social');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `cltv_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `cltv_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|unclassified');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `segment_membership_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Segment Assignment Confidence Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consumer Consent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `data_processing_basis` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Legal Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `data_processing_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `segment_membership_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `effective_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Membership Effective From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `effective_until_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Membership Effective Until Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Segment Evaluation Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `is_control_group` SET TAGS ('dbx_business_glossary_term' = 'Control Group Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `is_primary_segment` SET TAGS ('dbx_business_glossary_term' = 'Primary Segment Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `last_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Segment Activation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `last_evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `membership_score` SET TAGS ('dbx_business_glossary_term' = 'Membership Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `ml_model_code` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `segment_membership_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `nps_score_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) at Assignment');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Opt-Out Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `personalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Personalization Eligibility Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `rule_set_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Rule Set ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `segment_membership_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `segment_priority` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `segment_version` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `segment_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `source_record_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Segment Suppression Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_value_regex' = 'gdpr_request|ccpa_opt_out|do_not_contact|regulatory_hold|deceased|duplicate');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Preference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preference_center_id` SET TAGS ('dbx_business_glossary_term' = 'Preference Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `brand_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand-Level Override Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `brand_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Brand Override Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `brand_override_reason` SET TAGS ('dbx_value_regex' = 'regulatory_restriction|brand_policy|consumer_request|loyalty_program_rule|campaign_exclusion');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preference_category` SET TAGS ('dbx_business_glossary_term' = 'Preference Category');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `cltv_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `cltv_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|unclassified');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preference_code` SET TAGS ('dbx_business_glossary_term' = 'Preference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Preference Confidence Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `consent_basis` SET TAGS ('dbx_business_glossary_term' = 'Consent Legal Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `consent_basis` SET TAGS ('dbx_value_regex' = 'explicit_consent|legitimate_interest|contractual_necessity|legal_obligation|vital_interest|public_task');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `data_subject_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preference_description` SET TAGS ('dbx_business_glossary_term' = 'Preference Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `flavor_fragrance_preference` SET TAGS ('dbx_business_glossary_term' = 'Flavor / Fragrance Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `inference_basis` SET TAGS ('dbx_business_glossary_term' = 'Preference Inference Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `inference_basis` SET TAGS ('dbx_value_regex' = 'purchase_history|browsing_behavior|survey_response|loyalty_redemption|pos_transaction|panel_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `inference_model_version` SET TAGS ('dbx_business_glossary_term' = 'Inference Model Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `is_global_preference` SET TAGS ('dbx_business_glossary_term' = 'Global Preference Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `key` SET TAGS ('dbx_business_glossary_term' = 'Key');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preference_name` SET TAGS ('dbx_business_glossary_term' = 'Preference Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `nps_segment` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `nps_segment` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor|unknown');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `opt_in_status` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `opt_status` SET TAGS ('dbx_business_glossary_term' = 'Opt Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `pack_size_preference` SET TAGS ('dbx_business_glossary_term' = 'Pack Size Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_verification|suppressed|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preference_type` SET TAGS ('dbx_business_glossary_term' = 'Preference Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preferred_contact_frequency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_business_glossary_term' = 'Preferred Time of Day');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|night|no_preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `preferred_timezone` SET TAGS ('dbx_business_glossary_term' = 'Preferred Timezone');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `product_category_preference` SET TAGS ('dbx_business_glossary_term' = 'Product Category Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `rank` SET TAGS ('dbx_business_glossary_term' = 'Preference Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `retail_channel_preference` SET TAGS ('dbx_business_glossary_term' = 'Retail Channel Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `sku_preference` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Preference Source');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `source_system_preference_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Preference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Preference Subcategory');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Preference Suppression Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_value_regex' = 'gdpr_erasure|ccpa_opt_out|consumer_request|regulatory_hold|fraud_flag|deceased');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `updated_at_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated At Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference` ALTER COLUMN `value` SET TAGS ('dbx_business_glossary_term' = 'Preference Value');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `channel_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `shopper_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `shopper_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `capture_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `capture_method` SET TAGS ('dbx_value_regex' = 'web_form|mobile_app|in_store|call_center|paper_form|email_link');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `change_trigger` SET TAGS ('dbx_business_glossary_term' = 'Consent Change Trigger');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `change_trigger` SET TAGS ('dbx_value_regex' = 'consumer_action|system_expiry|admin_override|legal_request|data_breach|re_consent_campaign');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_record_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_language_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_proof_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Proof Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_record_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_scope` SET TAGS ('dbx_value_regex' = 'global|brand_specific|product_category|campaign_specific');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_text_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Consent Notice Text Snapshot');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing_email|sms|push_notification|data_sharing|profiling|cookies');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `cookie_consent_categories` SET TAGS ('dbx_business_glossary_term' = 'Cookie Consent Categories');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Consumer Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_record_description` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Device Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|kiosk|other');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `double_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `double_opt_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture IP Address');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `is_current_record` SET TAGS ('dbx_business_glossary_term' = 'Is Current Record Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `minor_age_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minor Age Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_record_name` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `parental_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `prior_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Consent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `prior_consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|expired|none');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `processing_agent` SET TAGS ('dbx_business_glossary_term' = 'Consent Processing Agent');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `profiling_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Profiling and Automated Decision-Making Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `re_consent_deadline` SET TAGS ('dbx_business_glossary_term' = 'Re-Consent Deadline Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `re_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Consent Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|LGPD|PIPEDA|PDPA|OTHER');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Retention Period (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `third_party_sharing_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Data Sharing Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `withdrawal_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `withdrawal_method` SET TAGS ('dbx_value_regex' = 'web_form|mobile_app|in_store|call_center|email_link|automated_expiry');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `withdrawal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_event_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Agent ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `preference_center_id` SET TAGS ('dbx_business_glossary_term' = 'Preference Center ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `reversal_event_consent_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `shopper_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `shopper_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `change_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Change Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `change_trigger` SET TAGS ('dbx_business_glossary_term' = 'Consent Change Trigger');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `change_trigger` SET TAGS ('dbx_value_regex' = 'consumer_action|system_expiry|regulatory_request|admin_override|data_import');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_event_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_event_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_language_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_purpose_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_purpose_name` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_text_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Consent Text Snapshot');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Notice Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_event_description` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `double_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `double_opt_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Double Opt-In Confirmation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Processing Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'processed|pending|failed|reversed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'grant|withdraw|update|expire|regulatory_erasure|system_expiry');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Consumer IP Address');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `legal_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `legal_basis_code` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|vital_interest|public_task');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `minor_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Consumer Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `consent_event_name` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `new_consent_status` SET TAGS ('dbx_business_glossary_term' = 'New Consent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `new_consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|expired|not_set');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Event Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `parental_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `prior_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Consent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `prior_consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|expired|not_set');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `processing_system` SET TAGS ('dbx_business_glossary_term' = 'Processing System Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `profiling_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Profiling Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `proof_of_consent_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof of Consent Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|UK_GDPR|PIPEDA|LGPD|OTHER');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Consent Source URL');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `third_party_sharing_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Data Sharing Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'Consumer User Agent String');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `withdrawal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_event` ALTER COLUMN `withdrawal_reason_text` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason Text');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` SET TAGS ('dbx_subdomain' = 'direct_commerce');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `dtc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `billing_address_same_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Same as Shipping Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `billing_address_same_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `billing_address_same_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'DTC Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'brand_website|mobile_app|social_commerce|voice_commerce|dtc_subscription');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `dtc_order_code` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `dtc_order_description` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Consumer Device Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|smart_tv|voice_assistant');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `dtc_order_status` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `fulfillment_ref` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'unfulfilled|partially_fulfilled|fulfilled|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `gift_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Order Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ip_country_code` SET TAGS ('dbx_business_glossary_term' = 'IP Geolocation Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ip_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ip_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ip_country_code` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `dtc_order_name` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'DTC Order Placement Date and Time');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'DTC Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `order_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `order_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `order_total_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|paypal|apple_pay|google_pay|gift_card');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|captured|failed|refunded|partially_refunded');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `payment_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `return_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_business_glossary_term' = 'Ship-To City');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_name` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Recipient Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_business_glossary_term' = 'Ship-To State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `shipped_date` SET TAGS ('dbx_business_glossary_term' = 'Order Shipped Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `shipping_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Shipping Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `shipping_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `shipping_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `source_system_order_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Order Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `subscription_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Subscription Order Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Subtotal Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` SET TAGS ('dbx_subdomain' = 'direct_commerce');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `dtc_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Order Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `dtc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `atp_record_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Atp Record Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `dtc_return_id` SET TAGS ('dbx_business_glossary_term' = 'Return ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Channel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'DTC_WEB|DTC_MOBILE|DTC_APP|DTC_SUBSCRIPTION|DTC_SOCIAL');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `dtc_order_line_code` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Line Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `cost_of_goods_sold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `dtc_order_line_description` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Line Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `dtc_order_line_status` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Line Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `gift_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Order Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `is_returned` SET TAGS ('dbx_business_glossary_term' = 'Return Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Line Discount Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Order Line Discount Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Line Net Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Order Line Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_subtotal` SET TAGS ('dbx_business_glossary_term' = 'Order Line Subtotal');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_subtotal` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_subtotal` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_total` SET TAGS ('dbx_business_glossary_term' = 'Line Total');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Line Total Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `dtc_order_line_name` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Line Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `promised_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `quantity_cancelled` SET TAGS ('dbx_business_glossary_term' = 'Quantity Cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `quantity_shipped` SET TAGS ('dbx_business_glossary_term' = 'Quantity Shipped');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `subscription_flag` SET TAGS ('dbx_business_glossary_term' = 'Subscription Order Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` SET TAGS ('dbx_subdomain' = 'direct_commerce');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `dtc_return_id` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Return ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `dtc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `dtc_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Dtc Order Line Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Agent ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'DTC Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'DTC Order Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Return Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Product Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Return Carrier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Case Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `dtc_return_code` SET TAGS ('dbx_business_glossary_term' = 'Dtc Return Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `consumer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Consumer Satisfaction Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `dtc_return_description` SET TAGS ('dbx_business_glossary_term' = 'Dtc Return Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Return Disposition Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'restock|refurbish|destroy|return_to_vendor|quarantine');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `dtc_return_status` SET TAGS ('dbx_business_glossary_term' = 'Dtc Return Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Product Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `fraud_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Return Fraud Risk Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `loyalty_points_refunded` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Refunded');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `dtc_return_name` SET TAGS ('dbx_business_glossary_term' = 'Dtc Return Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `net_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Refund Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `net_refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `net_refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `product_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Returned Product Condition Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `product_condition_code` SET TAGS ('dbx_value_regex' = 'unopened|opened_unused|used|damaged|destroyed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `quality_defect_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Return Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `refund_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Issued Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original_payment|store_credit|loyalty_points|bank_transfer|gift_card');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `regulatory_report_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `regulatory_report_required` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `regulatory_report_required` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Return Rejection Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Return Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_value_regex' = 'outside_return_window|policy_violation|non_returnable_item|fraud_suspected|incomplete_return');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Return Request Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Request Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_channel` SET TAGS ('dbx_business_glossary_term' = 'Return Initiation Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|customer_service|email|chat');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_label_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Label Tracking Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_method` SET TAGS ('dbx_business_glossary_term' = 'Return Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_method` SET TAGS ('dbx_value_regex' = 'mail_in|drop_off|carrier_pickup|in_store');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_number` SET TAGS ('dbx_value_regex' = '^RTN-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_quantity` SET TAGS ('dbx_business_glossary_term' = 'Return Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_reason` SET TAGS ('dbx_business_glossary_term' = 'Return Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'defective|wrong_item|changed_mind|damaged_in_transit|not_as_described|missing_parts');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_status` SET TAGS ('dbx_value_regex' = 'requested|approved|received|refunded|rejected|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `return_window_eligible` SET TAGS ('dbx_business_glossary_term' = 'Return Window Eligibility Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_return` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` SET TAGS ('dbx_subdomain' = 'research_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `nps_response_id` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Response ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Agent ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `closed_loop_action_date` SET TAGS ('dbx_business_glossary_term' = 'Closed-Loop Action Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `closed_loop_status` SET TAGS ('dbx_business_glossary_term' = 'Closed-Loop Follow-Up Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `closed_loop_status` SET TAGS ('dbx_value_regex' = 'Pending|In Progress|Resolved|Escalated|No Action');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `nps_response_code` SET TAGS ('dbx_business_glossary_term' = 'Nps Response Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consumer Consent Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'Salesforce|SAP|TradeEdge|Nielsen|Custom|Third-Party');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `nps_response_description` SET TAGS ('dbx_business_glossary_term' = 'Nps Response Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Device Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'Mobile|Desktop|Tablet|Smart TV|Other');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `loyalty_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Member Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `nps_response_name` SET TAGS ('dbx_business_glossary_term' = 'Nps Response Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `nps_category` SET TAGS ('dbx_business_glossary_term' = 'Nps Category');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `nps_response_status` SET TAGS ('dbx_business_glossary_term' = 'Nps Response Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `purchase_channel` SET TAGS ('dbx_business_glossary_term' = 'Purchase Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `purchase_channel` SET TAGS ('dbx_value_regex' = 'E-Commerce|Retail Store|DTC|Wholesale|DSD|Pharmacy');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `purchase_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `repeat_buyer_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Buyer Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `respondent_category` SET TAGS ('dbx_business_glossary_term' = 'NPS Respondent Category');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `respondent_category` SET TAGS ('dbx_value_regex' = 'Promoter|Passive|Detractor');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `response_reference_number` SET TAGS ('dbx_business_glossary_term' = 'NPS Response Reference Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'NPS Response Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'Submitted|Partial|Abandoned|Invalid|Closed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'NPS Response Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `retailer_name` SET TAGS ('dbx_business_glossary_term' = 'Retailer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Sentiment Label');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_value_regex' = 'Positive|Neutral|Negative|Mixed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Sentiment Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `source_response_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Response ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `survey_channel` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `survey_channel` SET TAGS ('dbx_value_regex' = 'Email|In-App|SMS|Post-Purchase|Web|IVR');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Response Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `survey_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Trigger Event');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `survey_trigger_event` SET TAGS ('dbx_value_regex' = 'Post-Purchase|Post-Delivery|Post-Support|Periodic|Event-Based|Onboarding');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'NPS Survey Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `topic_tags` SET TAGS ('dbx_business_glossary_term' = 'NPS Verbatim Topic Tags');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `touchpoint` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_business_glossary_term' = 'NPS Verbatim Comment');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`nps_response` ALTER COLUMN `verbatim_comment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` SET TAGS ('dbx_subdomain' = 'research_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Interaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `account_call_id` SET TAGS ('dbx_business_glossary_term' = 'Account Call Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `environmental_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `interaction_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `parent_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Interaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `product_complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Product Complaint Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retailer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `adverse_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `interaction_code` SET TAGS ('dbx_business_glossary_term' = 'Interaction Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `consumer_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `contact_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `interaction_description` SET TAGS ('dbx_business_glossary_term' = 'Interaction Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `interaction_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Direction');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration (Seconds)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_value_regex' = 'sla_breach|consumer_request|regulatory_requirement|repeat_contact|safety_concern|management_review');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'new|in_progress|pending_consumer|resolved|closed|escalated');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'inquiry|complaint|compliment|product_feedback|adverse_event_report|return_request');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `is_bot_handled` SET TAGS ('dbx_business_glossary_term' = 'Bot Handled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `interaction_name` SET TAGS ('dbx_business_glossary_term' = 'Interaction Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `regulatory_report_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `regulatory_report_number` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `regulatory_report_number` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `repeat_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Contact Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Label');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|mixed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SFDC_CGC|SAP_S4|ORACLE_CX|SOCIAL_LISTENER|IN_APP|EMAIL_GATEWAY');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `touchpoint` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `upc_code` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `upc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` SET TAGS ('dbx_subdomain' = 'direct_commerce');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Warehouse ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `shipping_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_delivery_address_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_delivery_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_delivery_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `acquisition_source` SET TAGS ('dbx_business_glossary_term' = 'Subscription Acquisition Source');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `billing_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Cancellation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Subscription Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'price_too_high|product_dissatisfaction|found_alternative|no_longer_needed|financial_hardship|other');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'CCPA Opt-Out Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Subscription Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'dtc_web|dtc_mobile|dtc_app|retail_partner|voice_assistant');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_code` SET TAGS ('dbx_business_glossary_term' = 'Subscription Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_business_glossary_term' = 'Delivery Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_description` SET TAGS ('dbx_business_glossary_term' = 'Subscription Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Subscription Discount Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `discount_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `failed_payment_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Payment Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Subscription Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|monthly|bi_monthly|quarterly');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_name` SET TAGS ('dbx_business_glossary_term' = 'Subscription Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Subscription Price');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `net_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `next_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Billing Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `next_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Next Delivery Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `next_order_date` SET TAGS ('dbx_business_glossary_term' = 'Next Order Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `pause_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pause End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `pause_flag` SET TAGS ('dbx_business_glossary_term' = 'Pause Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `pause_reason` SET TAGS ('dbx_business_glossary_term' = 'Subscription Pause Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `pause_reason` SET TAGS ('dbx_value_regex' = 'financial_hardship|travel|product_overstock|temporary_unavailability|other');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `pause_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pause Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|digital_wallet|bank_transfer|gift_card');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `payment_token_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Token Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `payment_token_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `payment_token_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Subscription Price');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `price_per_cycle` SET TAGS ('dbx_business_glossary_term' = 'Price Per Cycle');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Subscription Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `recurring_amount` SET TAGS ('dbx_business_glossary_term' = 'Recurring Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_business_glossary_term' = 'Subscription Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_value_regex' = '^SUB-[A-Z0-9]{8,16}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_value_regex' = 'active|paused|cancelled|pending|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_business_glossary_term' = 'Subscription Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_value_regex' = 'auto_replenishment|subscription_box|bundle|trial');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `total_orders_fulfilled` SET TAGS ('dbx_business_glossary_term' = 'Total Orders Fulfilled');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Trial End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `trial_flag` SET TAGS ('dbx_business_glossary_term' = 'Trial Subscription Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` SET TAGS ('dbx_subdomain' = 'loyalty_programs');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_record_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `aov` SET TAGS ('dbx_business_glossary_term' = 'Average Order Value (AOV)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `aov` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `aov` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'CLTV Calculation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `calculation_date` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `calculation_date` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `calculation_method` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `calculation_method` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'CLTV Calculation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `calculation_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed|superseded');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `calculation_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `calculation_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `churn_probability` SET TAGS ('dbx_business_glossary_term' = 'Churn Probability');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_band` SET TAGS ('dbx_business_glossary_term' = 'Cltv Band');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_record_status` SET TAGS ('dbx_business_glossary_term' = 'Cltv Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_business_glossary_term' = 'Cltv Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_value` SET TAGS ('dbx_business_glossary_term' = 'Cltv Value');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_record_code` SET TAGS ('dbx_business_glossary_term' = 'Cltv Record Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `consumer_tenure_days` SET TAGS ('dbx_business_glossary_term' = 'Consumer Tenure (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `data_completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Data Completeness Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `data_processing_basis` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Legal Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `data_processing_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `days_since_last_purchase` SET TAGS ('dbx_business_glossary_term' = 'Days Since Last Purchase');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_record_description` SET TAGS ('dbx_business_glossary_term' = 'Cltv Record Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `effective_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `effective_until_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `first_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'First Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `historical_value` SET TAGS ('dbx_business_glossary_term' = 'Historical Value');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `input_data_summary` SET TAGS ('dbx_business_glossary_term' = 'CLTV Input Data Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `model_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'CLTV Model Confidence Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'CLTV Model Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^vd+.d+(.d+)?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `cltv_record_name` SET TAGS ('dbx_business_glossary_term' = 'Cltv Record Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `nps_category` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Category');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `nps_category` SET TAGS ('dbx_value_regex' = 'promoter|passive|detractor');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `observation_window_months` SET TAGS ('dbx_business_glossary_term' = 'Observation Window (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `personalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Personalization Eligibility Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `predicted_cltv` SET TAGS ('dbx_business_glossary_term' = 'Predicted Cltv');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `predicted_horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Predicted Horizon Months');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `predicted_revenue_12m` SET TAGS ('dbx_business_glossary_term' = 'Predicted Future Revenue — 12-Month');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `predicted_revenue_12m` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `predicted_revenue_12m` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `predicted_revenue_24m` SET TAGS ('dbx_business_glossary_term' = 'Predicted Future Revenue — 24-Month');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `predicted_revenue_24m` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `predicted_revenue_24m` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `prediction_horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Prediction Horizon (Months)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `previous_cltv_score` SET TAGS ('dbx_business_glossary_term' = 'Previous CLTV Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `previous_cltv_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `previous_cltv_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `previous_cltv_tier` SET TAGS ('dbx_business_glossary_term' = 'Previous Customer Lifetime Value (CLTV) Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `previous_cltv_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `primary_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `primary_category_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Category Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `primary_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Purchase Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `primary_channel` SET TAGS ('dbx_value_regex' = 'dtc|ecommerce|retail|wholesale|loyalty_app|other');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `purchase_frequency` SET TAGS ('dbx_business_glossary_term' = 'Purchase Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `revenue_12m_historical` SET TAGS ('dbx_business_glossary_term' = 'Historical Revenue — 12-Month');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `revenue_12m_historical` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `revenue_12m_historical` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `revenue_24m_historical` SET TAGS ('dbx_business_glossary_term' = 'Historical Revenue — 24-Month');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `revenue_24m_historical` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `revenue_24m_historical` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `revenue_lifetime_historical` SET TAGS ('dbx_business_glossary_term' = 'Historical Revenue — Lifetime');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `revenue_lifetime_historical` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `revenue_lifetime_historical` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `tier_change_flag` SET TAGS ('dbx_business_glossary_term' = 'CLTV Tier Change Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `transaction_count_lifetime` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Transaction Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`cltv_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `communication_preference_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preference_center_id` SET TAGS ('dbx_business_glossary_term' = 'Preference Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `campaign_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Campaign Exclusion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `capture_touchpoint` SET TAGS ('dbx_business_glossary_term' = 'Preference Capture Touchpoint');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'email|sms|push_notification|direct_mail|phone|in_app');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `communication_preference_code` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `communication_category` SET TAGS ('dbx_business_glossary_term' = 'Communication Category');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `communication_category` SET TAGS ('dbx_value_regex' = 'promotional|transactional|loyalty|product_recall|survey|newsletter');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `communication_preference_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `confirmation_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Preference Confirmation Sent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Confirmation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `consent_basis` SET TAGS ('dbx_business_glossary_term' = 'Consent Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `contact_time_zone` SET TAGS ('dbx_business_glossary_term' = 'Consumer Contact Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `communication_preference_description` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `double_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Double Opt In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `double_opt_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Double Opt In Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective Until Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `frequency_cap` SET TAGS ('dbx_business_glossary_term' = 'Frequency Cap');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `frequency_preference` SET TAGS ('dbx_business_glossary_term' = 'Frequency Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `is_global_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Global Opt-Out Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `last_opt_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Opt Change Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `max_messages_per_week` SET TAGS ('dbx_business_glossary_term' = 'Maximum Messages Per Week');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `communication_preference_name` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `opt_in_method` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `opt_in_method` SET TAGS ('dbx_value_regex' = 'double_opt_in|single_opt_in|paper_form|verbal|imported|default');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `opt_in_status` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `opt_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opt In Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `opt_out_reason` SET TAGS ('dbx_business_glossary_term' = 'Opt Out Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `opt_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opt Out Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `opt_status` SET TAGS ('dbx_business_glossary_term' = 'Opt Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `opted_in` SET TAGS ('dbx_business_glossary_term' = 'Opted In');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `personalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Personalization Eligible Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preference_source` SET TAGS ('dbx_business_glossary_term' = 'Preference Source');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preference_version` SET TAGS ('dbx_business_glossary_term' = 'Preference Record Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preferred_day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Preferred Day of Week');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preferred_frequency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preferred_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|transactional_only|real_time');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Language');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_business_glossary_term' = 'Preferred Time of Day');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|no_preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `product_category_preference` SET TAGS ('dbx_business_glossary_term' = 'Product Category Communication Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|CASL|PDPA|LGPD|OTHER');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `resubscribe_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resubscribe Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `retailer_banner_preference` SET TAGS ('dbx_business_glossary_term' = 'Retailer Banner Communication Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `source_record_ref` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_value_regex' = 'legal_hold|consumer_complaint|regulatory_order|deceased|undeliverable|fraud_flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `third_party_sharing_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Data Sharing Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `topic` SET TAGS ('dbx_business_glossary_term' = 'Topic');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `unsubscribe_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Unsubscribe Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `updated_at_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated At Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `updated_by_actor` SET TAGS ('dbx_business_glossary_term' = 'Updated By Actor');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `updated_by_actor` SET TAGS ('dbx_value_regex' = 'consumer_self_service|brand_agent|system_automated|data_migration|legal_team');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`communication_preference` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_link_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Link ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `shopper_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `shopper_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_link_code` SET TAGS ('dbx_business_glossary_term' = 'Identity Link Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|not_required');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `cross_device_cluster_ref` SET TAGS ('dbx_business_glossary_term' = 'Cross-Device Cluster ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `data_processing_basis` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Legal Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `data_processing_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|vital_interest|public_task|legitimate_interest');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_link_description` SET TAGS ('dbx_business_glossary_term' = 'Identity Link Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `effective_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `effective_until_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Link Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `external_id_value` SET TAGS ('dbx_business_glossary_term' = 'External Id Value');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `external_identifier` SET TAGS ('dbx_business_glossary_term' = 'External Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `first_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Seen Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `fraud_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identifier_value` SET TAGS ('dbx_business_glossary_term' = 'Identifier Value');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identifier_value_hash` SET TAGS ('dbx_business_glossary_term' = 'Identifier Value Hash');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_link_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Link Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_provider` SET TAGS ('dbx_business_glossary_term' = 'Identity Provider');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_type` SET TAGS ('dbx_business_glossary_term' = 'Identity Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_type` SET TAGS ('dbx_value_regex' = 'email|phone|device_id|social_id|loyalty_card|cookie_id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_value` SET TAGS ('dbx_business_glossary_term' = 'Identity Value');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_value_hash` SET TAGS ('dbx_business_glossary_term' = 'Identity Value Hash');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_value_hash` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_value_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_value_hash` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `is_golden_record` SET TAGS ('dbx_business_glossary_term' = 'Is Golden Record');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Identity Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `is_primary_identity` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Identity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `is_verified_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Verified Opt-In Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `last_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Identity Last Seen Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `link_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Identity Link Confidence Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `link_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Link Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `link_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Link Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `link_method` SET TAGS ('dbx_value_regex' = 'deterministic|probabilistic|federated|manual');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `link_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Link Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `link_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suppressed|revoked');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `link_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Identity Link Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `link_type` SET TAGS ('dbx_business_glossary_term' = 'Link Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `match_confidence` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `match_method` SET TAGS ('dbx_business_glossary_term' = 'Match Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `ml_model_code` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning Model ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `identity_link_name` SET TAGS ('dbx_business_glossary_term' = 'Identity Link Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Identity Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `resolution_run_ref` SET TAGS ('dbx_business_glossary_term' = 'Identity Resolution Run ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `source_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `source_record_ref` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `source_system_identity_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Identity Ref');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_value_regex' = 'gdpr_erasure|ccpa_deletion|opt_out|fraud|duplicate|deceased');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Validation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Identity Validation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`identity_link` ALTER COLUMN `verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Verified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` SET TAGS ('dbx_subdomain' = 'loyalty_programs');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referral_id` SET TAGS ('dbx_business_glossary_term' = 'Referral ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `dtc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Referred Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Program ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referral_referred_shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Referred Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referral_referrer_shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Referrer Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_value_regex' = 'dtc|loyalty_app|ecommerce|mobile_app');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Attempt Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `ccpa_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Opt-Out Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Referral Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|social_share|referral_link|sms|in_app');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `click_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Click Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referral_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Conversion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `data_processing_basis` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Legal Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `data_processing_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `days_to_convert` SET TAGS ('dbx_business_glossary_term' = 'Referral Days to Convert');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referral_description` SET TAGS ('dbx_business_glossary_term' = 'Referral Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|under_review|cleared|confirmed_fraud');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `medium` SET TAGS ('dbx_business_glossary_term' = 'Referral Medium');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `medium` SET TAGS ('dbx_value_regex' = 'organic|paid|owned|earned');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referral_name` SET TAGS ('dbx_business_glossary_term' = 'Referral Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `qualifying_action_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Action Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `qualifying_action_type` SET TAGS ('dbx_value_regex' = 'first_purchase|loyalty_enrollment|dtc_registration|subscription_start');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'sent|clicked|converted|expired|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referred_reward_amount` SET TAGS ('dbx_business_glossary_term' = 'Referred Reward Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referred_reward_status` SET TAGS ('dbx_business_glossary_term' = 'Referred Consumer Reward Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referred_reward_status` SET TAGS ('dbx_value_regex' = 'pending|issued|redeemed|expired|reversed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referred_reward_type` SET TAGS ('dbx_business_glossary_term' = 'Referred Consumer Reward Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referred_reward_type` SET TAGS ('dbx_value_regex' = 'points|discount_voucher|cash_back|free_product|gift_card');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referred_reward_value` SET TAGS ('dbx_business_glossary_term' = 'Referred Consumer Reward Value');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referred_reward_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referrer_reward_amount` SET TAGS ('dbx_business_glossary_term' = 'Referrer Reward Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referrer_reward_status` SET TAGS ('dbx_business_glossary_term' = 'Referrer Reward Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referrer_reward_status` SET TAGS ('dbx_value_regex' = 'pending|issued|redeemed|expired|reversed');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referrer_reward_type` SET TAGS ('dbx_business_glossary_term' = 'Referrer Reward Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referrer_reward_type` SET TAGS ('dbx_value_regex' = 'points|discount_voucher|cash_back|free_product|gift_card');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referrer_reward_value` SET TAGS ('dbx_business_glossary_term' = 'Referrer Reward Value');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `referrer_reward_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `reminder_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Reminder Sent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `reminder_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Reminder Sent Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `reward_amount` SET TAGS ('dbx_business_glossary_term' = 'Reward Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `reward_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reward Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `reward_points` SET TAGS ('dbx_business_glossary_term' = 'Reward Points');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `reward_status` SET TAGS ('dbx_business_glossary_term' = 'Reward Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `self_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Referral Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `social_platform` SET TAGS ('dbx_business_glossary_term' = 'Social Platform');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `social_platform` SET TAGS ('dbx_value_regex' = 'facebook|instagram|twitter_x|whatsapp|tiktok|other');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `social_platform` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `social_platform` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `source_record_ref` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Referral Source URL');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`referral` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` SET TAGS ('dbx_subdomain' = 'research_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` SET TAGS ('dbx_association_edges' = 'consumer.shopper,research.rd_project');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `research_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Participation - Research Participation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `consumer_test_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Test Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `market_research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Market Research Study Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `panel_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Participation - Rd Project Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Research Participation - Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `research_participation_code` SET TAGS ('dbx_business_glossary_term' = 'Research Participation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `compensation_type` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Completion Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `data_use_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Use Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `research_participation_description` SET TAGS ('dbx_business_glossary_term' = 'Research Participation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `incentive_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Incentive Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `incentive_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Paid Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `incentive_status` SET TAGS ('dbx_business_glossary_term' = 'Incentive Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `invitation_date` SET TAGS ('dbx_business_glossary_term' = 'Invitation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `research_participation_name` SET TAGS ('dbx_business_glossary_term' = 'Research Participation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Opt Out Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt Out Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `participation_code` SET TAGS ('dbx_business_glossary_term' = 'Participation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `participation_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `participation_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `recruitment_channel` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `recruitment_date` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `recruitment_source` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Source');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `research_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Research Participation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `response_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Quality Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `response_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Response Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `screening_result` SET TAGS ('dbx_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `session_count` SET TAGS ('dbx_business_glossary_term' = 'Session Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `session_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Duration Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Study Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `study_role` SET TAGS ('dbx_business_glossary_term' = 'Study Role');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`research_participation` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` SET TAGS ('dbx_subdomain' = 'loyalty_programs');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `predecessor_loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Loyalty Program Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `predecessor_loyalty_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `base_earn_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Earn Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `cltv_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cltv Estimate');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `loyalty_program_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `country_scope` SET TAGS ('dbx_business_glossary_term' = 'Country Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `currency_unit` SET TAGS ('dbx_business_glossary_term' = 'Currency Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `loyalty_program_description` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `earn_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Earn Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `earn_rate` SET TAGS ('dbx_business_glossary_term' = 'Earn Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `enrollment_fee` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Fee');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `loyalty_program_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `loyalty_program_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Nps Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `points_balance` SET TAGS ('dbx_business_glossary_term' = 'Points Balance');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `points_currency_name` SET TAGS ('dbx_business_glossary_term' = 'Points Currency Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `points_earned` SET TAGS ('dbx_business_glossary_term' = 'Points Earned');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `points_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Points Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `points_expiry_months` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Months');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `points_expiry_policy` SET TAGS ('dbx_business_glossary_term' = 'Points Expiry Policy');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `privacy_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Privacy Opt In');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `redemption_rate` SET TAGS ('dbx_business_glossary_term' = 'Redemption Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `reward_rate` SET TAGS ('dbx_business_glossary_term' = 'Reward Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `terms_version` SET TAGS ('dbx_business_glossary_term' = 'Terms Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_session_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Session Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `preference_center_id` SET TAGS ('dbx_business_glossary_term' = 'Preference Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `renewed_consent_session_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Consent Session Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `renewed_consent_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `address_line` SET TAGS ('dbx_business_glossary_term' = 'Address Line');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `address_line` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `address_line` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_session_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Session Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_collected_count` SET TAGS ('dbx_business_glossary_term' = 'Consent Collected Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_count` SET TAGS ('dbx_business_glossary_term' = 'Consent Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_framework` SET TAGS ('dbx_business_glossary_term' = 'Consent Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_given` SET TAGS ('dbx_business_glossary_term' = 'Consent Given');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_outcome` SET TAGS ('dbx_business_glossary_term' = 'Consent Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_purpose` SET TAGS ('dbx_business_glossary_term' = 'Consent Purpose');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_session_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_session_description` SET TAGS ('dbx_business_glossary_term' = 'Consent Session Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `ended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ended Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `events_count` SET TAGS ('dbx_business_glossary_term' = 'Events Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Ip Address');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `consent_session_name` SET TAGS ('dbx_business_glossary_term' = 'Consent Session Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `privacy_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revocation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `session_token` SET TAGS ('dbx_business_glossary_term' = 'Session Token');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Source Url');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Started Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_session` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `preference_center_id` SET TAGS ('dbx_business_glossary_term' = 'Preference Center Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `previous_preference_center_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Preference Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `previous_preference_center_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `ccpa_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Ccpa Opt Out');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `center_code` SET TAGS ('dbx_business_glossary_term' = 'Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `center_name` SET TAGS ('dbx_business_glossary_term' = 'Center Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `center_status` SET TAGS ('dbx_business_glossary_term' = 'Center Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `center_type` SET TAGS ('dbx_business_glossary_term' = 'Center Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `center_url` SET TAGS ('dbx_business_glossary_term' = 'Center Url');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `center_version` SET TAGS ('dbx_business_glossary_term' = 'Center Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `preference_center_code` SET TAGS ('dbx_business_glossary_term' = 'Preference Center Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `consent_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `consent_framework` SET TAGS ('dbx_business_glossary_term' = 'Consent Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `consent_given_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Given Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `consent_review_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `consent_revoked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Revoked Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `consent_source` SET TAGS ('dbx_business_glossary_term' = 'Consent Source');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `country_scope` SET TAGS ('dbx_business_glossary_term' = 'Country Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `data_processing_consent` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `data_sharing_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `default_language_code` SET TAGS ('dbx_business_glossary_term' = 'Default Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `preference_center_description` SET TAGS ('dbx_business_glossary_term' = 'Preference Center Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `do_not_call` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `do_not_mail` SET TAGS ('dbx_business_glossary_term' = 'Do Not Mail');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `do_not_sell_data` SET TAGS ('dbx_business_glossary_term' = 'Do Not Sell Data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `double_opt_in_enabled` SET TAGS ('dbx_business_glossary_term' = 'Double Opt In Enabled');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Email Opt In');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `gdpr_consent` SET TAGS ('dbx_business_glossary_term' = 'Gdpr Consent');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `is_complete` SET TAGS ('dbx_business_glossary_term' = 'Is Complete');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `is_test_account` SET TAGS ('dbx_business_glossary_term' = 'Is Test Account');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `last_preference_update` SET TAGS ('dbx_business_glossary_term' = 'Last Preference Update');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `last_visited_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Visited Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `locale` SET TAGS ('dbx_business_glossary_term' = 'Locale');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `marketing_category` SET TAGS ('dbx_business_glossary_term' = 'Marketing Category');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `preference_center_name` SET TAGS ('dbx_business_glossary_term' = 'Preference Center Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `phone_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Phone Opt In');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `phone_opt_in` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `phone_opt_in` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `platform` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `platform` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `postal_mail_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Postal Mail Opt In');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `preference_center_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `preference_code` SET TAGS ('dbx_business_glossary_term' = 'Preference Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `preference_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Preference Status Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `preference_type` SET TAGS ('dbx_business_glossary_term' = 'Preference Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `privacy_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `push_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Push Opt In');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `sms_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Sms Opt In');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `supported_channels` SET TAGS ('dbx_business_glossary_term' = 'Supported Channels');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `third_party_sharing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Third Party Sharing Opt In');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Url');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`preference_center` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` SET TAGS ('dbx_subdomain' = 'engagement_preferences');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_handled_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handled By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_handled_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_handled_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `original_data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Original Data Subject Request Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `original_data_subject_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `shopper_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `shopper_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_subject_request_code` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_category_requested` SET TAGS ('dbx_business_glossary_term' = 'Data Category Requested');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_subject_request_status` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_subject_request_description` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalated Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `fulfillment_notes` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `identity_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Identity Verified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `is_sensitive_data` SET TAGS ('dbx_business_glossary_term' = 'Is Sensitive Data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `data_subject_request_name` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `outcome_reason` SET TAGS ('dbx_business_glossary_term' = 'Outcome Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `privacy_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `regulation` SET TAGS ('dbx_business_glossary_term' = 'Regulation');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `regulation` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `regulation` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `regulation_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulation Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `regulation_basis` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `regulation_basis` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_business_glossary_term' = 'Request Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `request_code` SET TAGS ('dbx_business_glossary_term' = 'Request Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `request_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Deadline Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `request_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Request Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `request_fulfilled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Fulfilled Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `request_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Received Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `request_source_system` SET TAGS ('dbx_business_glossary_term' = 'Request Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_business_glossary_term' = 'Requester Email');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `requester_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `resolution_summary` SET TAGS ('dbx_business_glossary_term' = 'Resolution Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `response_method` SET TAGS ('dbx_business_glossary_term' = 'Response Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Sla Breach Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `sla_days` SET TAGS ('dbx_business_glossary_term' = 'Sla Days');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`data_subject_request` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` SET TAGS ('dbx_subdomain' = 'research_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `panel_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `parent_panel_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Panel Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `parent_panel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `cltv` SET TAGS ('dbx_business_glossary_term' = 'Cltv');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `cltv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `cltv` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `panel_code` SET TAGS ('dbx_business_glossary_term' = 'Panel Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `consent_basis` SET TAGS ('dbx_business_glossary_term' = 'Consent Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `consumer_type` SET TAGS ('dbx_business_glossary_term' = 'Consumer Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `country_scope` SET TAGS ('dbx_business_glossary_term' = 'Country Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `current_size` SET TAGS ('dbx_business_glossary_term' = 'Current Size');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date Of Birth');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `death_date` SET TAGS ('dbx_business_glossary_term' = 'Death Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `demographic_criteria` SET TAGS ('dbx_business_glossary_term' = 'Demographic Criteria');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `panel_description` SET TAGS ('dbx_business_glossary_term' = 'Panel Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `do_not_call` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `ethnicity` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `gender` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `gender` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `household_income` SET TAGS ('dbx_business_glossary_term' = 'Household Income');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `household_income` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `household_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `incentive_model` SET TAGS ('dbx_business_glossary_term' = 'Incentive Model');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `is_deceased` SET TAGS ('dbx_business_glossary_term' = 'Is Deceased');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `loyalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `marital_status` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt In');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `panel_name` SET TAGS ('dbx_business_glossary_term' = 'Panel Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Nps Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `panel_type` SET TAGS ('dbx_business_glossary_term' = 'Panel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `preferred_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `privacy_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Privacy Opt In Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `provider` SET TAGS ('dbx_business_glossary_term' = 'Provider');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `purchase_count` SET TAGS ('dbx_business_glossary_term' = 'Purchase Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `recruitment_method` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `recruitment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Size');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `target_size` SET TAGS ('dbx_business_glossary_term' = 'Target Size');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `total_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `total_purchase_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `total_purchase_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`panel` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` SET TAGS ('dbx_subdomain' = 'loyalty_programs');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `loyalty_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `loyalty_program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `next_loyalty_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Next Loyalty Tier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `next_loyalty_tier_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `benefit_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `benefit_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Benefit Multiplier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `benefits_description` SET TAGS ('dbx_business_glossary_term' = 'Benefits Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `loyalty_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `loyalty_tier_description` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `earn_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Earn Multiplier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `exclusive_offers` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Offers');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `expiration_policy` SET TAGS ('dbx_business_glossary_term' = 'Expiration Policy');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `free_shipping` SET TAGS ('dbx_business_glossary_term' = 'Free Shipping');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `loyalty_tier_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `max_points_per_year` SET TAGS ('dbx_business_glossary_term' = 'Max Points Per Year');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `min_points_threshold` SET TAGS ('dbx_business_glossary_term' = 'Min Points Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `min_qualifying_points` SET TAGS ('dbx_business_glossary_term' = 'Min Qualifying Points');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `min_qualifying_spend` SET TAGS ('dbx_business_glossary_term' = 'Min Qualifying Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `loyalty_tier_name` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `points_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Points Multiplier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `priority_support` SET TAGS ('dbx_business_glossary_term' = 'Priority Support');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `promotional_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `qualification_metric` SET TAGS ('dbx_business_glossary_term' = 'Qualification Metric');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `qualification_period_months` SET TAGS ('dbx_business_glossary_term' = 'Qualification Period Months');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `qualification_points_min` SET TAGS ('dbx_business_glossary_term' = 'Qualification Points Min');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `qualification_spend_min` SET TAGS ('dbx_business_glossary_term' = 'Qualification Spend Min');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `qualification_threshold` SET TAGS ('dbx_business_glossary_term' = 'Qualification Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `qualifying_threshold` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `required_points` SET TAGS ('dbx_business_glossary_term' = 'Required Points');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `required_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Required Spend Usd');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `retention_threshold` SET TAGS ('dbx_business_glossary_term' = 'Retention Threshold');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `reward_points_per_dollar` SET TAGS ('dbx_business_glossary_term' = 'Reward Points Per Dollar');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `spend_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Spend Multiplier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `tier_rank` SET TAGS ('dbx_business_glossary_term' = 'Tier Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_business_glossary_term' = 'Tier Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_tier` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Months');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` SET TAGS ('dbx_subdomain' = 'research_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` SET TAGS ('dbx_reviewer_note_status' = 'no_verbatim_notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` SET TAGS ('dbx_reviewed' = 'consumer_goods_v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` SET TAGS ('dbx_reviewer_notes' = 'none_for_consumer_goods');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `panel_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `revised_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Revised Survey Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `revised_survey_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `actual_response_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Response Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `survey_category` SET TAGS ('dbx_business_glossary_term' = 'Survey Category');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Close Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `survey_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `compliance_ccpa` SET TAGS ('dbx_business_glossary_term' = 'Compliance Ccpa');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `compliance_gdpr` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gdpr');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `consent_basis` SET TAGS ('dbx_business_glossary_term' = 'Consent Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `consent_required` SET TAGS ('dbx_business_glossary_term' = 'Consent Required');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `data_privacy_level` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Level');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `survey_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `estimated_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `incentive_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Offered Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Is Anonymous');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `is_multilingual` SET TAGS ('dbx_business_glossary_term' = 'Is Multilingual');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `last_published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Published Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Length Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `logo_url` SET TAGS ('dbx_business_glossary_term' = 'Survey Logo Url');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Name');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Phone');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `provider` SET TAGS ('dbx_business_glossary_term' = 'Provider');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `question_count` SET TAGS ('dbx_business_glossary_term' = 'Question Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `response_count` SET TAGS ('dbx_business_glossary_term' = 'Response Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `response_rate` SET TAGS ('dbx_business_glossary_term' = 'Response Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `response_rate_actual` SET TAGS ('dbx_business_glossary_term' = 'Response Rate Actual');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `response_rate_target` SET TAGS ('dbx_business_glossary_term' = 'Response Rate Target');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `response_target` SET TAGS ('dbx_business_glossary_term' = 'Response Target');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `target_response_count` SET TAGS ('dbx_business_glossary_term' = 'Target Response Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Survey Url');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`survey` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` SET TAGS ('dbx_subdomain' = 'research_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `interaction_session_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Session Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `parent_interaction_session_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Interaction Session Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `parent_interaction_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'Ab Test Variant');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `app_version` SET TAGS ('dbx_business_glossary_term' = 'App Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `browser_type` SET TAGS ('dbx_business_glossary_term' = 'Browser Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `cart_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Cart Value Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `cart_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `cart_value_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `conversion_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `device_os` SET TAGS ('dbx_business_glossary_term' = 'Device Os');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `event_count` SET TAGS ('dbx_business_glossary_term' = 'Event Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `exit_page_url` SET TAGS ('dbx_business_glossary_term' = 'Exit Page Url');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geo Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geo Region');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `geo_region` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `geo_region` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Ip Address');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `is_authenticated` SET TAGS ('dbx_business_glossary_term' = 'Is Authenticated');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `is_bounced` SET TAGS ('dbx_business_glossary_term' = 'Is Bounced');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `is_converted` SET TAGS ('dbx_business_glossary_term' = 'Is Converted');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `is_new_consumer` SET TAGS ('dbx_business_glossary_term' = 'Is New Consumer');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page Url');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Nps Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `page_view_count` SET TAGS ('dbx_business_glossary_term' = 'Page View Count');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `personalization_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Personalization Segment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer Url');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `session_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `session_language_code` SET TAGS ('dbx_business_glossary_term' = 'Session Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `session_medium` SET TAGS ('dbx_business_glossary_term' = 'Session Medium');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `session_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Session Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `session_source` SET TAGS ('dbx_business_glossary_term' = 'Session Source');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `session_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `session_token` SET TAGS ('dbx_business_glossary_term' = 'Session Token');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `session_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`interaction_session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
