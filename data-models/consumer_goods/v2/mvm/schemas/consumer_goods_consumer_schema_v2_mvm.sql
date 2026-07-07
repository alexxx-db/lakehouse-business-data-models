-- Schema for Domain: consumer | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-27 07:48:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`consumer` COMMENT 'SSOT for all end consumers, shoppers, households, and loyalty program members in B2C and DTC channels. Manages consumer profiles, preferences, purchase history, segmentation, NPS scores, CLTV calculations, consent and privacy preferences (GDPR/CCPA), and contact data. Supports CRM, personalization, and consumer engagement programs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` (
    `shopper_id` BIGINT COMMENT 'Unique surrogate identifier for every end consumer and shopper record in the Consumer Goods golden master. This is the anchor primary key for the entire consumer domain — all other consumer entities reference this record. Role: MASTER_PARTY.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Shopper-to-segment assignment drives personalization, campaign targeting, and CLTV modeling. Marketing teams must know which consumer segment each shopper belongs to for 1:1 campaign execution and seg',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: CPG consumer profiles track a shoppers preferred/home store for personalization, store-level marketing, and loyalty program management. `preferred_store_banner` is a denormalized text field; replacin',
    `acquisition_channel` STRING COMMENT 'The channel through which the consumer was first acquired or registered. Supports marketing attribution, channel ROI analysis, and consumer journey analytics. Aligns with DTC, POS, and loyalty enrollment touchpoints. [ENUM-REF-CANDIDATE: dtc_web|dtc_mobile|retail_pos|loyalty_enrollment|social_media|event|referral|wholesale — promote to reference product]',
    `acquisition_date` DATE COMMENT 'The date on which the consumer was first acquired or registered in the system (yyyy-MM-dd). Used for cohort analysis, consumer tenure calculations, and lifecycle marketing programs.',
    `age_verified` BOOLEAN COMMENT 'Indicates whether the consumer has passed age verification for access to age-restricted products (e.g., alcohol, tobacco, certain health products). TRUE = age verified; FALSE = not verified. Required for regulatory compliance with FDA and CPSC age-restriction mandates.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the shopper record',
    `birth_date` DATE COMMENT 'The consumers date of birth in ISO 8601 format (yyyy-MM-dd). Used for age verification (e.g., age-restricted products), lifecycle segmentation, birthday loyalty rewards, and regulatory compliance.',
    `ccpa_subject` BOOLEAN COMMENT 'Indicates whether this consumer is a California resident subject to CCPA protections. TRUE = CCPA applies; FALSE = not a CCPA subject. Drives opt-out of sale workflows, data deletion requests, and disclosure obligations.',
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
    `primary_address_code` BIGINT COMMENT 'The primary address id of the shopper record',
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
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Household-level segmentation is standard in consumer goods for trade promotion targeting, media planning, and panel analysis. The existing market_segment text field is a denormalized segment label; re',
    `merged_from_household_id` BIGINT COMMENT 'Reference to the source household record that was merged into this household during deduplication or household consolidation. Null if no merge has occurred. Supports data lineage and audit trails.',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Loyalty accounts are created or tier-upgraded via specific enrollment campaigns. Tracking which campaign drove loyalty enrollment is required for loyalty program growth reporting, campaign ROI, and ac',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Loyalty bonus-point events are triggered by specific marketing campaigns (double-points promotions, campaign earn events). Linking loyalty_transaction to campaign enables campaign ROI measurement via ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Loyalty program cost attribution: earn and redemption transactions generate costs (points liability, redemption fulfillment) allocated to loyalty program cost centers. Consumer goods finance teams req',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for accounting loyalty point expense; loyalty_transaction must post expense to a GL account for financial statements.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Loyalty points liability accounting: under IFRS 15/ASC 606, loyalty points are deferred revenue requiring journal entries at earn and redemption. Consumer goods auditors and finance teams require dire',
    `loyalty_account_id` BIGINT COMMENT 'Reference to the loyalty program account against which this points movement is recorded. Links the transaction to the members running balance and tier status.',
    `order_id` BIGINT COMMENT 'Reference to the originating sales order or DTC purchase that triggered an earn or redemption event. Null for non-purchase-triggered transactions such as birthday bonuses, referral awards, or manual adjustments.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Loyalty earn and redemption events occur at specific retail stores. Store-level loyalty analytics — which stores drive highest earn rates, redemption patterns by store — is a core CPG retail execution',
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
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Operational consumer segments (loyalty/DTC targeting) must reconcile with marketing-defined consumer segments for campaign planning alignment. This cross-domain segment mapping is a data governance an',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'Unique surrogate identifier for each consent record in the Consumer Goods consumer privacy system. Primary key for the consent_record data product, serving as the SSOT for GDPR Article 7 and CCPA compliance audits.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing or re-consent campaign that prompted this consent record creation or update. Enables campaign-level consent conversion tracking and supports Trade Promotion Management (TPM) and consumer engagement analytics.',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` (
    `dtc_order_id` BIGINT COMMENT 'Unique surrogate identifier for each Direct-to-Consumer (DTC) order record in the Silver layer lakehouse. Primary key for this entity. Role: TRANSACTION_HEADER.',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: DTC order-to-cash cycle: each DTC order generates an AR invoice for collections, dispute management, and revenue recognition under IFRS 15/ASC 606. Consumer goods DTC finance teams require this link f',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Order‑to‑Campaign linkage enables ROI analysis by attributing direct‑to‑consumer orders to the marketing campaign that generated the purchase.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Multi-entity DTC operations: consumer goods companies operating across legal entities require each DTC order attributed to a company code for statutory financial reporting, VAT/tax compliance, and int',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Order processing costs are allocated to internal cost centers for budgeting and variance analysis.',
    `distribution_facility_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_facility. Business justification: Order fulfillment report requires order-level DC assignment for shipping cost, OTIF metrics, and inventory allocation.',
    `distribution_shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_shipment. Business justification: DTC last-mile delivery tracking: links a consumer DTC order to its distribution shipment for delivery performance reporting, customer shipment notifications, and carrier OTIF compliance. Distinct from',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: DTC orders are fulfilled from a specific supply network node (DC/fulfillment center). Supply network allocation reporting and node-level capacity planning require knowing which network node fulfilled ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Drop-ship DTC fulfillment requires tracking which supplier fulfilled each order for supplier OTIF performance reporting, cost allocation, and compliance audits. A consumer goods domain expert expects ',
    `loyalty_account_id` BIGINT COMMENT 'Foreign key linking to consumer.loyalty_account. Business justification: A DTC order earns and redeems loyalty points (loyalty_points_earned, loyalty_points_redeemed columns exist on dtc_order). Linking dtc_order directly to loyalty_account enables direct reconciliation of',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Required for consolidated revenue reporting across channels; DTC orders must be reconciled with central sales order for finance.',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to distribution.outbound_order. Business justification: DTC order fulfillment process: each consumer DTC order generates a distribution outbound_order for warehouse execution. Operations and customer service teams track which outbound_order fulfills which ',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to sales.price_list. Business justification: DTC orders in CPG are priced against a specific consumer price list (DTC channel price list, promotional price list, loyalty tier price list). This FK enables DTC pricing audit, margin analysis by pri',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: DTC channel P&L reporting: consumer goods companies track DTC as a distinct profit center. Each DTC order must be attributed to a profit center for channel-level revenue and margin reporting, a standa',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Omnichannel CPG DTC orders are frequently initiated in-store (endless aisle, ship-from-store, click-and-collect). Linking DTC orders to the originating retail store enables omnichannel attribution rep',
    `address_id` BIGINT COMMENT 'The shipping address id of the dtc order record',
    `shopper_id` BIGINT COMMENT 'Reference to the consumer (shopper) who placed this DTC order. Links to the consumer master profile in the Consumer domain SSOT, enabling CLTV analysis, loyalty program attribution, and personalization. Satisfies TRANSACTION_HEADER PARTY_REFERENCE category.',
    `subscription_id` BIGINT COMMENT 'Reference to the consumer subscription plan that generated this DTC order, when subscription_order_flag is True. Links to the subscription master for recurring order management, churn analysis, and subscription revenue reporting.',
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
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: DTC order line actuals are reconciled against demand plan buckets to measure forecast accuracy (MAPE/bias). Demand planners attribute actual DTC sales to specific plan versions for variance analysis. ',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the fulfillment warehouse or distribution center from which this order line was or will be shipped. Supports Distribution Requirements Planning (DRP) and warehouse performance analytics.',
    `dtc_order_id` BIGINT COMMENT 'Foreign key reference to the parent DTC order header. Establishes the header/detail relationship for this line item. Satisfies TRANSACTION_LINE HEADER_REFERENCE category.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue recognition at line level: DTC order lines post to specific GL accounts by product category (e.g., food vs. personal care revenue accounts). Consumer goods finance requires line-level GL attri',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to sales.price_list_item. Business justification: Each DTC order line is priced against a specific price list item (SKU-level price). This FK supports DTC line-level pricing audit, promotional price validation, margin-per-SKU reporting, and price com',
    `shopper_id` BIGINT COMMENT 'Reference to the end consumer or shopper who placed the DTC order. Enables consumer-level purchase history, CLTV analysis, and personalization. Satisfies TRANSACTION_LINE PARTY_REFERENCE category.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU purchased on this line. Enables SKU-level purchase analysis, product affinity modeling, and replenishment triggers. Satisfies TRANSACTION_LINE RESOURCE_REFERENCE category.',
    `subscription_id` BIGINT COMMENT 'Reference to the consumer subscription record that triggered this order line, when subscription_flag is True. Enables subscription lifecycle analysis and recurring revenue reporting.',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` (
    `subscription_id` BIGINT COMMENT 'Primary key for subscription',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Subscription billing generates recurring AR invoices independently of individual orders (annual/quarterly billing cycles). Consumer goods subscription finance requires direct subscription-to-AR-invoic',
    `address_id` BIGINT COMMENT 'The billing address id of the subscription record',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Subscriptions are acquired through specific marketing campaigns. Knowing which campaign drove subscription acquisition is essential for campaign ROI, customer acquisition cost reporting, and subscript',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Subscription program cost management: subscription fulfillment operations (pick/pack, customer service, churn management) are tracked to dedicated cost centers. Consumer goods finance teams require th',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Subscription recurring demand is a committed baseline input to demand planning. Supply planners use subscription cohort volumes as a known demand signal in statistical baseline forecasting and S&OP. A',
    `distribution_facility_id` BIGINT COMMENT 'Reference to the warehouse or distribution center assigned to fulfill this subscriptions orders. Supports DRP (Distribution Requirements Planning) and inventory allocation across the supply chain network.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Subscriptions are assigned to a designated supply network node for recurring fulfillment planning. Node-level capacity and replenishment planning for subscription volumes requires this assignment. Rol',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_brand. Business justification: Subscriptions in consumer goods are brand-specific (e.g., a brands replenishment subscription program). Linking subscription to marketing_brand enables brand-level subscription analytics, renewal rat',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to sales.price_list. Business justification: CPG subscription pricing is governed by a specific price list (subscriber discount tier, promotional rate, renewal price). Linking subscription to price_list enables subscription pricing governance, r',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Subscription channel revenue reporting: recurring subscription revenue is attributed to profit centers for channel P&L. Consumer goods companies with DTC subscription models (e.g., replenishment progr',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` (
    `segment_membership_id` BIGINT COMMENT 'Primary key for the segment_membership association',
    `segment_id` BIGINT COMMENT 'Foreign key linking to the segment definition that this shopper is assigned to.',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to the shopper (end consumer) who is a member of this segment.',
    `assignment_date` DATE COMMENT 'The calendar date on which this shopper was formally assigned to this segment. May differ from effective_from if assignments are pre-scheduled or back-dated.',
    `assignment_method` STRING COMMENT 'The method by which this specific shopper was assigned to this segment for this membership record. Values: rule_based (deterministic criteria), ml_model (probabilistic scoring), manual (human override), imported (external system feed). Belongs to the membership, not the segment definition or the shopper identity.',
    `cltv_segment` STRING COMMENT 'The consumers current CLTV (Customer Lifetime Value) segment classification derived from purchase history and predictive modeling. Used for resource allocation in marketing, personalization prioritization, and retention investment decisions. Segment label, not a calculated metric. [Moved from shopper: This is a denormalized CLTV segment label on the shopper record. In the correct model, CLTV segment membership is represented as a segment_membership record linking the shopper to the appropriate CLTV-type segment. The label on shopper is redundant and creates a maintenance inconsistency — it should be removed in favor of querying the membership association.]. Valid values are `high_value|mid_value|low_value|at_risk|churned`',
    `confidence_score` DECIMAL(18,2) COMMENT 'The ML model confidence score (0.0000–1.0000) for this specific shopper-segment assignment. Distinct from the segment-level min_confidence_score threshold — this is the actual score achieved by this shopper at the time of assignment. Only meaningful in the context of this individual membership record.',
    `effective_from` DATE COMMENT 'The date on which this shoppers membership in this segment became active. Enables time-variant membership tracking and point-in-time segment reconstruction for campaign attribution.',
    `effective_until` DATE COMMENT 'The date on which this shoppers membership in this segment expires or was terminated. Null indicates an open-ended active membership. Supports segment churn analysis and re-entry tracking.',
    `exit_reason` STRING COMMENT 'The reason this shoppers membership in this segment ended. Populated when effective_until is set. Supports segment lifecycle analysis and suppression management.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this specific shopper-segment membership is currently active. Derived from effective_from/effective_until but maintained as an explicit flag for query performance in CRM activation pipelines.',
    CONSTRAINT pk_segment_membership PRIMARY KEY(`segment_membership_id`)
) COMMENT 'This association product represents the Segment Membership between a shopper and a consumer segment. It captures the operational record of a specific shopper being assigned to a specific segment within a CPG CRM or CDP system, including the method of assignment, ML confidence score, effective date range, and exit reason. Each record links one shopper to one segment and carries attributes that exist only in the context of this individual membership — they cannot reside on the shopper record (which is identity-level) or the segment record (which is definition-level). Supports time-variant membership tracking, personalization activation, and campaign targeting across CPG brands.. Existence Justification: In CPG consumer data platforms, a single shopper is actively assigned to multiple segments simultaneously (e.g., a High-Value RFM segment AND a Millennial Demographic segment AND a Lapsed Buyer behavioral segment), and each segment contains thousands of shoppers. This is not an analytical correlation — CRM and CDP systems actively create, update, and expire individual membership records as part of campaign targeting and personalization workflows. The relationship is a recognized operational entity called segment membership with its own lifecycle data (assignment method, confidence score, effective dates, exit reason) that cannot reside on either the shopper or segment record alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ADD CONSTRAINT `fk_consumer_household_merged_from_household_id` FOREIGN KEY (`merged_from_household_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`household`(`household_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ADD CONSTRAINT `fk_consumer_household_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ADD CONSTRAINT `fk_consumer_address_household_id` FOREIGN KEY (`household_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`household`(`household_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` ADD CONSTRAINT `fk_consumer_address_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ADD CONSTRAINT `fk_consumer_loyalty_account_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_loyalty_account_id` FOREIGN KEY (`loyalty_account_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_account`(`loyalty_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_reversal_reference_loyalty_transaction_id` FOREIGN KEY (`reversal_reference_loyalty_transaction_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction`(`loyalty_transaction_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ADD CONSTRAINT `fk_consumer_loyalty_transaction_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ADD CONSTRAINT `fk_consumer_segment_parent_segment_id` FOREIGN KEY (`parent_segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ADD CONSTRAINT `fk_consumer_consent_record_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_loyalty_account_id` FOREIGN KEY (`loyalty_account_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`loyalty_account`(`loyalty_account_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`address`(`address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ADD CONSTRAINT `fk_consumer_dtc_order_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_dtc_order_id` FOREIGN KEY (`dtc_order_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`dtc_order`(`dtc_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ADD CONSTRAINT `fk_consumer_dtc_order_line_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`subscription`(`subscription_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_address_id` FOREIGN KEY (`address_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`address`(`address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`address`(`address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ADD CONSTRAINT `fk_consumer_subscription_subscription_delivery_address_id` FOREIGN KEY (`subscription_delivery_address_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`address`(`address_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`segment`(`segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ADD CONSTRAINT `fk_consumer_segment_membership_shopper_id` FOREIGN KEY (`shopper_id`) REFERENCES `vibe_consumer_goods_v1`.`consumer`.`shopper`(`shopper_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`consumer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`consumer` SET TAGS ('dbx_domain' = 'consumer');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` SET TAGS ('dbx_subdomain' = 'consumer_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Consumer Acquisition Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `age_verified` SET TAGS ('dbx_business_glossary_term' = 'Age Verification Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `ccpa_subject` SET TAGS ('dbx_business_glossary_term' = 'California Consumer Privacy Act (CCPA) Subject Flag');
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
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `primary_address_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `primary_address_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`shopper` ALTER COLUMN `primary_address_code` SET TAGS ('dbx_classification' = 'restricted');
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
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` SET TAGS ('dbx_subdomain' = 'consumer_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `household_id` SET TAGS ('dbx_business_glossary_term' = 'Household ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`household` ALTER COLUMN `merged_from_household_id` SET TAGS ('dbx_business_glossary_term' = 'Merged From Household ID');
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
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`address` SET TAGS ('dbx_subdomain' = 'consumer_identity');
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
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` SET TAGS ('dbx_subdomain' = 'loyalty_engagement');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_account` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Campaign Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` SET TAGS ('dbx_subdomain' = 'loyalty_engagement');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `loyalty_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Transaction ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`loyalty_transaction` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` SET TAGS ('dbx_subdomain' = 'consumer_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` SET TAGS ('dbx_subdomain' = 'consumer_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`consent_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
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
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` SET TAGS ('dbx_subdomain' = 'direct_commerce');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `dtc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `distribution_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Supplier Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `loyalty_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
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
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `dtc_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Order Line ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `dtc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Direct-to-Consumer (DTC) Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`dtc_order_line` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
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
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` SET TAGS ('dbx_subdomain' = 'direct_commerce');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Warehouse ID');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`subscription` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` SET TAGS ('dbx_subdomain' = 'consumer_identity');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` SET TAGS ('dbx_association_edges' = 'consumer.shopper,consumer.segment');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `segment_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership - Segment Membership Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership - Segment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Membership - Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_value_regex' = 'high_value|mid_value|low_value|at_risk|churned');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Membership Confidence Score');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Membership Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Membership Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Membership Exit Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`consumer`.`segment_membership` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Membership Active Flag');
