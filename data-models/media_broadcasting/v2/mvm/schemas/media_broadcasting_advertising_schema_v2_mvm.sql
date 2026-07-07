-- Schema for Domain: advertising | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-30 06:39:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`advertising` COMMENT 'Manages the full advertising sales and campaign lifecycle — from upfront and scatter market deal negotiation through ad order entry, trafficking (Wide Orbit), DAI (Dynamic Ad Insertion), affidavit generation, and makegood processing. Tracks CPM, GRP, TRP, SOV, reach, frequency, and CPRP metrics. Owns ISCI codes, ad pod definitions, ad inventory, pricing, and campaign performance data feeding revenue reconciliation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` (
    `ad_inventory_id` BIGINT COMMENT 'Unique identifier for the advertising inventory record. Primary key. | Column ad_inventory_id (BIGINT) in advertising.ad_inventory',
    `ad_break_id` BIGINT COMMENT 'Foreign key linking to scheduling.ad_break. Business justification: Ad traffic management allocates sold inventory units to specific scheduled ad breaks for affidavit generation, avail reconciliation, and DAI execution. Broadcast traffic managers require this link to ',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Inventory is generated from title airings. Business process: inventory forecasting by title, avails management, sell-through reporting, title-level CPM pricing, program-based inventory allocation. | Column title_id (BIGINT) in content.ad_inventory',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast or streaming channel where this inventory is available. | Column channel_id (BIGINT) in scheduling.ad_inventory',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Ad avails management for FAST channels and OTT tiers requires inventory to reference the specific delivery channel. Programmatic floor pricing, ad insertion method configuration, and avails forecastin',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Inventory is forecasted, priced, and sold by Nielsen demographic segment for yield optimization and avails management. CPM/CPRP rates and GRP/TRP estimates vary by demographic. Essential for inventory | Column demographic_segment_id (BIGINT) in audience.ad_inventory',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Ad inventory is created within specific rights grant windows that authorize content exploitation. Linking inventory to the grant enables rights compliance reporting (run count tracking, window enforce',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Inventory forecasting depends on content rights availability. Sales planning tools must filter inventory by active license windows. Prevents overselling inventory in content with upcoming rights expir | Column license_agreement_id (BIGINT) in rights.ad_inventory',
    `nielsen_rating_id` BIGINT COMMENT 'Foreign key linking to audience.nielsen_rating. Business justification: Ad inventory pricing and GRP/TRP estimates are directly derived from Nielsen rating records. Linking ad_inventory to the specific Nielsen rating record enables rate card validation, inventory audit tr',
    `production_episode_id` BIGINT COMMENT 'Foreign key linking to production.production_episode. Business justification: Ad inventory is allocated at the episode level in broadcasting (e.g., Episode 5 has 4 ad pods). Episode-level inventory management, syndication ad sales, and streaming ad insertion all require linki',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to advertising.rate_card. Business justification: ad_inventory carries denormalized rate card pricing fields (rate_card_cpm, rate_card_cprp) that reference a specific rate card definition. Adding rate_card_id FK normalizes this reference, allowing th',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Inventory is bucketed by daypart for pricing and availability management. Rate card application, proposal generation, and avail queries require linking inventory to master daypart definitions. Removes | Column scheduling_daypart_id (BIGINT) in scheduling.ad_inventory',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in advertising.ad_inventory',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in advertising.ad_inventory',
    `ad_pod_position` STRING COMMENT 'The sequential position of this inventory slot within an ad pod (group of ads in a break). Position 1 is the first ad in the break. | Column ad_pod_position (INT) in advertising.ad_inventory',
    `advertiser_restrictions` STRING COMMENT 'Comma-separated list of advertiser categories or specific advertisers that are restricted from purchasing this inventory due to content, competitive, or regulatory reasons. | Column advertiser_restrictions (STRING) in advertising.ad_inventory',
    `audience_segment_targeting` STRING COMMENT 'JSON-encoded audience segment targeting criteria for addressable/programmatic inventory',
    `blackout_markets` STRING COMMENT 'Comma-separated list of designated market areas (DMA) or geographic regions where this inventory cannot be sold due to blackout restrictions. | Column blackout_markets (STRING) in advertising.ad_inventory',
    `brand_safety_tier` STRING COMMENT 'Brand safety classification tier',
    `content_rating` STRING COMMENT 'The television content rating for the program associated with this inventory, which may restrict certain advertiser categories. | Column content_rating (STRING) in advertising.ad_inventory. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `contextual_category` STRING COMMENT 'IAB contextual category for targeting',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in advertising.ad_inventory',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory record was first created in the system. | Column created_timestamp (TIMESTAMP) in advertising.ad_inventory',
    `domain_expansion_marker` STRING COMMENT 'Marker attribute indicating advertising domain expansion',
    `effective_date` DATE COMMENT 'The date from which this inventory record and its pricing become effective for sales purposes. | Column effective_date (DATE) in advertising.ad_inventory',
    `estimated_grp` DECIMAL(18,2) COMMENT 'The estimated gross rating point (GRP) delivery for this inventory, representing the total audience reach multiplied by frequency. GRP is a standard broadcast audience measurement metric. | Column estimated_grp (DECIMAL(8,2)) in advertising.ad_inventory',
    `estimated_impressions` BIGINT COMMENT 'The projected number of advertising impressions (individual ad views) this inventory will deliver, based on historical audience data. | Column estimated_impressions (BIGINT) in advertising.ad_inventory',
    `estimated_reach` BIGINT COMMENT 'The projected unique audience count (reach) that will be exposed to advertising in this inventory slot at least once. | Column estimated_reach (BIGINT) in advertising.ad_inventory',
    `estimated_trp` DECIMAL(18,2) COMMENT 'The estimated target rating point (TRP) delivery for this inventory, representing the rating within a specific demographic target audience. TRP is used for targeted advertising campaigns. | Column estimated_trp (DECIMAL(8,2)) in advertising.ad_inventory',
    `expiration_date` DATE COMMENT 'The date after which this inventory record is no longer valid or available for sale. | Column expiration_date (DATE) in advertising.ad_inventory',
    `first_party_data_eligible_flag` BOOLEAN COMMENT 'Indicates if inventory is eligible for first-party data targeting',
    `floor_price_cpm` DECIMAL(18,2) COMMENT 'Minimum CPM floor price for programmatic bidding',
    `held_units` STRING COMMENT 'The number of advertising units currently held or reserved pending final commitment, typically during proposal negotiation. | Column held_units (INT) in advertising.ad_inventory',
    `inventory_code` STRING COMMENT 'Unique business identifier for this inventory slot, used in sales proposals and trafficking systems. | Column inventory_code (STRING) in advertising.ad_inventory. Valid values are `^[A-Z0-9]{6,20}$`',
    `inventory_date` DATE COMMENT 'The specific broadcast date for which this inventory is available. | Column inventory_date (DATE) in advertising.ad_inventory',
    `inventory_end_time` TIMESTAMP COMMENT 'The precise end time of the inventory window, including time zone information. | Column inventory_end_time (TIMESTAMP) in advertising.ad_inventory',
    `inventory_start_time` TIMESTAMP COMMENT 'The precise start time of the inventory window, including time zone information. | Column inventory_start_time (TIMESTAMP) in advertising.ad_inventory',
    `inventory_status` STRING COMMENT 'Current lifecycle status of the advertising inventory: available for sale, held pending commitment, sold and committed, preempted for higher-priority content, or blocked due to restrictions. | Column inventory_status (STRING) in advertising.ad_inventory. Valid values are `available|held|sold|preempted|blocked`',
    `inventory_type` STRING COMMENT 'Classification of the advertising inventory format: linear broadcast spot, video-on-demand (VOD) ad position, dynamic ad insertion (DAI) slot, free ad-supported streaming television (FAST) pod, or over-the-top (OTT) impression. | Column inventory_type (STRING) in advertising.ad_inventory. Valid values are `linear_spot|vod_preroll|vod_midroll|dai_slot|fast_pod|ott_impression`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory record was last updated or modified. | Column last_modified_timestamp (TIMESTAMP) in advertising.ad_inventory',
    `makegood_eligible` BOOLEAN COMMENT 'Indicates whether this inventory is eligible to be used for makegoods (compensatory ad spots provided when original spots did not air as scheduled). | Column makegood_eligible (BOOLEAN) in advertising.ad_inventory',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or contextual information about this inventory record. | Column notes (STRING) in advertising.ad_inventory',
    `preemptible` BOOLEAN COMMENT 'Indicates whether this inventory can be preempted (bumped) for higher-priority programming or advertising. Preemptible inventory is typically sold at lower rates. | Column preemptible (BOOLEAN) in advertising.ad_inventory',
    `pricing_tier` STRING COMMENT 'The pricing tier classification for this inventory based on audience quality and demand: premium (highest value), standard, value, or remnant (lowest value, unsold inventory). | Column pricing_tier (STRING) in advertising.ad_inventory. Valid values are `premium|standard|value|remnant`',
    `programmatic_eligible_flag` BOOLEAN COMMENT 'Indicates if inventory is available for programmatic buying',
    `rate_card_cpm` DECIMAL(18,2) COMMENT 'The published rate card cost per thousand impressions (CPM) for this inventory. CPM is the standard pricing metric in advertising sales. | Column rate_card_cpm (DECIMAL(12,2)) in advertising.ad_inventory',
    `rate_card_cprp` DECIMAL(18,2) COMMENT 'The published rate card cost per rating point (CPRP) for this inventory. CPRP is used in broadcast television pricing based on audience ratings. | Column rate_card_cprp (DECIMAL(12,2)) in advertising.ad_inventory',
    `remaining_avails` STRING COMMENT 'The number of advertising units still available for sale, calculated as total available minus sold and held units. | Column remaining_avails (INT) in advertising.ad_inventory',
    `sales_category` STRING COMMENT 'The sales market category for this inventory: upfront (advance sales event), scatter (last-minute sales), local, national, digital, or programmatic. | Column sales_category (STRING) in advertising.ad_inventory. Valid values are `upfront|scatter|local|national|digital|programmatic`',
    `sold_units` STRING COMMENT 'The number of advertising units that have been sold and committed to advertisers. | Column sold_units (INT) in advertising.ad_inventory',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in advertising.ad_inventory',
    `total_available_units` STRING COMMENT 'The total number of advertising units (spots or impressions) available for sale in this inventory record. | Column total_available_units (INT) in advertising.ad_inventory',
    `unit_duration_seconds` STRING COMMENT 'The standard duration in seconds for each advertising unit in this inventory (e.g., 15, 30, 60 seconds). | Column unit_duration_seconds (INT) in advertising.ad_inventory',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in advertising.ad_inventory',
    `viewability_threshold` DECIMAL(18,2) COMMENT 'Minimum viewability percentage required',
    CONSTRAINT pk_ad_inventory PRIMARY KEY(`ad_inventory_id`)
) COMMENT 'Available advertising inventory record representing sellable ad time or impression capacity for a specific channel, daypart, program, and date window. Tracks total available units (spots or impressions), sold units, remaining avails, rate card CPM/CPRP, audience delivery estimate (GRP/TRP), HUT/PUT index, blackout restrictions, and inventory status (available, held, sold, preempted). Feeds the avails system for sales proposals and scatter market pricing. | Unity Catalog table: media_broadcasting_ecm.advertising.ad_inventory';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` (
    `rate_card_id` BIGINT COMMENT 'Unique identifier for the advertising rate card. Primary key for the rate card entity. | Column rate_card_id (BIGINT) in advertising.rate_card',
    `channel_id` BIGINT COMMENT 'Identifier of the broadcast channel or streaming platform to which this rate card applies. | Column channel_id (BIGINT) in scheduling.rate_card',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Broadcast rate cards are fundamentally structured by daypart — CPM, GRP value, and pricing tiers are set per daypart period. Media sales and yield management systems require this FK to join rate_card ',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Rate cards are priced by Nielsen demographic cell (A18-49, W25-54, etc.) - fundamental to broadcast advertising economics. CPM/CPRP rates vary by demographic segment. Essential for proposal generation | Column demographic_segment_id (BIGINT) in audience.rate_card',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Broadcasting rate cards are explicitly priced by genre — sports, news, and drama command different CPMs. The existing program_genre plain string is a denormalized representation of content.genre; re',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: OTT platform-specific rate cards are standard in streaming ad sales — CPM rates differ by platform (e.g., SVOD vs. AVOD tier). Platform-scoped rate card management, programmatic floor pricing by platf',
    `panel_id` BIGINT COMMENT 'Foreign key linking to audience.panel. Business justification: Rate cards specify which measurement panel (e.g., Nielsen national people meter vs. local market panel) underpins GRP/TRP guarantees and minimum audience guarantees. This link is required for MRC-accr',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in advertising.rate_card',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in advertising.rate_card',
    `ad_pod_position` STRING COMMENT 'Position within the ad pod (group of ads in a commercial break) for which the rate applies. First and last positions typically command premium rates due to higher viewer attention. | Column ad_pod_position (STRING) in advertising.rate_card. Valid values are `first|middle|last|any`',
    `addressable_premium_pct` DECIMAL(18,2) COMMENT 'Premium percentage for addressable inventory',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the rate card was formally approved for use in ad sales and order entry. | Column approved_timestamp (TIMESTAMP) in advertising.rate_card',
    `cpm_basis` DECIMAL(18,2) COMMENT 'Cost per thousand impressions or viewers that the rate is based on. CPM is a standard metric in advertising pricing used to normalize rates across different audience sizes. | Column cpm_basis (DECIMAL(12,2)) in advertising.rate_card',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in advertising.rate_card',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the rate card record was first created in the system. | Column created_timestamp (TIMESTAMP) in advertising.rate_card',
    `ctv_rate_premium` DECIMAL(18,2) COMMENT 'Premium rate for connected TV inventory',
    `discount_eligibility` STRING COMMENT 'Description of volume discounts, frequency discounts, or package deals that can be applied to this rate card for qualifying advertisers. | Column discount_eligibility (STRING) in advertising.rate_card',
    `domain_expansion_marker` STRING COMMENT 'Marker attribute indicating advertising domain expansion',
    `effective_end_date` DATE COMMENT 'Date when the rate card expires and is no longer valid for new ad orders. Nullable for open-ended rate cards. | Column effective_end_date (DATE) in advertising.rate_card',
    `effective_start_date` DATE COMMENT 'Date when the rate card becomes active and available for use in ad order pricing and proposals. | Column effective_start_date (DATE) in advertising.rate_card',
    `frequency_cap_discount` DECIMAL(18,2) COMMENT 'Discount applied when frequency caps are accepted',
    `geographic_market` STRING COMMENT 'Geographic market or Designated Market Area (DMA) to which the rate card applies. Can be national, regional, or local market identifier. | Column geographic_market (STRING) in advertising.rate_card',
    `gross_rate` DECIMAL(18,2) COMMENT 'Published rate for the ad spot before any discounts, commissions, or agency fees are applied. This is the list price used as the baseline for negotiations. | Column gross_rate (DECIMAL(15,2)) in advertising.rate_card',
    `inventory_type` STRING COMMENT 'Type of advertising inventory covered by the rate card. Linear refers to traditional scheduled broadcast, VOD to video on demand, SVOD to subscription video on demand, AVOD to ad-supported video on demand, TVOD to transactional video on demand, OTT to over-the-top streaming, FAST to free ad-supported streaming television, and simulcast to simultaneous multi-platform broadcast. [ENUM-REF-CANDIDATE: linear|vod|svod|avod|tvod|ott|fast|simulcast — 8 candidates stripped; promote to reference product] | Column inventory_type (STRING) in advertising.rate_card',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the rate card record was last updated or modified. | Column last_modified_timestamp (TIMESTAMP) in advertising.rate_card',
    `makegood_policy` STRING COMMENT 'Policy describing conditions under which makegoods (compensatory ad spots) will be provided if audience guarantees are not met or technical issues occur. | Column makegood_policy (STRING) in advertising.rate_card',
    `minimum_audience_guarantee` STRING COMMENT 'Minimum guaranteed audience size (in thousands) for the daypart and demographic. If actual audience falls below this threshold, makegoods may be required. | Column minimum_audience_guarantee (INT) in advertising.rate_card',
    `mobile_rate_modifier` DECIMAL(18,2) COMMENT 'Rate modifier for mobile device inventory',
    `rate_card_name` STRING COMMENT 'Descriptive name of the rate card for easy identification, typically includes year and market or channel reference (e.g., 2024 Prime Time National Rate Card). | Column rate_card_name (STRING) in advertising.rate_card',
    `net_rate` DECIMAL(18,2) COMMENT 'Rate after standard agency commission (typically 15%) and other standard deductions are applied. This is the effective rate paid by the advertiser. | Column net_rate (DECIMAL(15,2)) in advertising.rate_card',
    `notes` STRING COMMENT 'Additional notes, terms, conditions, or special instructions related to the rate card, such as blackout dates, special event pricing, or advertiser category restrictions. | Column notes (STRING) in advertising.rate_card',
    `pmp_deal_rate` DECIMAL(18,2) COMMENT 'Negotiated rate for private marketplace deals',
    `preemption_priority` STRING COMMENT 'Indicates whether spots purchased at this rate can be preempted (bumped) for higher-paying advertisers. Non-preemptible rates are premium, while preemptible rates offer discounts but risk being moved or cancelled. | Column preemption_priority (STRING) in advertising.rate_card. Valid values are `non_preemptible|preemptible_with_notice|immediately_preemptible`',
    `programmatic_floor_cpm` DECIMAL(18,2) COMMENT 'Minimum CPM floor price for programmatic/RTB transactions',
    `programmatic_rate_modifier` DECIMAL(18,2) COMMENT 'Rate modifier for programmatic vs direct sales',
    `rate_card_number` STRING COMMENT 'Business identifier for the rate card, used for external reference and communication with sales teams and advertisers. Typically follows format RC-YYYYNNNN. | Column rate_card_number (STRING) in advertising.rate_card. Valid values are `^RC-[0-9]{6,10}$`',
    `rate_card_status` STRING COMMENT 'Current lifecycle status of the rate card indicating its operational state and usability for ad order entry. | Column rate_card_status (STRING) in advertising.rate_card. Valid values are `draft|pending_approval|active|superseded|expired|archived`',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate amounts (e.g., USD, GBP, EUR). | Column rate_currency_code (STRING) in advertising.rate_card. Valid values are `^[A-Z]{3}$`',
    `rate_type` STRING COMMENT 'Classification of the rate card by sales market type. Upfront rates are negotiated in advance for the broadcast year, scatter rates are for last-minute inventory, package rates bundle multiple spots, digital rates apply to OTT/streaming, sponsorship rates for integrated content, and remnant rates for unsold inventory. | Column rate_type (STRING) in advertising.rate_card. Valid values are `upfront|scatter|package|digital|sponsorship|remnant`',
    `seasonality_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to base rates to account for seasonal demand variations (e.g., 1.25 for high-demand periods like holidays, 0.85 for low-demand summer months). | Column seasonality_factor (DECIMAL(5,2)) in advertising.rate_card',
    `source_code` BIGINT COMMENT 'Medallion lineage column for _source_id | Column _source_id (STRING) in advertising.rate_card',
    `spot_length_seconds` STRING COMMENT 'Duration of the advertising spot in seconds for which the rate applies. Common lengths are 15, 30, 60, and 120 seconds. | Column spot_length_seconds (INT) in advertising.rate_card',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in advertising.rate_card',
    `version` STRING COMMENT 'Version number of the rate card to track revisions and updates. Follows semantic versioning (e.g., 1.0, 1.1, 2.0). | Column version (STRING) in advertising.rate_card. Valid values are `^[0-9]+.[0-9]+$`',
    `viewability_guarantee_premium` DECIMAL(18,2) COMMENT 'Premium for guaranteed viewability',
    CONSTRAINT pk_rate_card PRIMARY KEY(`rate_card_id`)
) COMMENT 'Advertising rate card defining the standard pricing for ad inventory by channel, daypart, spot length, and audience demographic. Captures rate card version, effective date range, channel, daypart, spot length, gross rate, net rate, CPM basis, GRP value, audience demographic target, rate type (upfront, scatter, package, digital), and approval status. Used as the pricing baseline for ad order entry and proposal generation. Distinct from negotiated deal rates on individual orders. | Unity Catalog table: media_broadcasting_ecm.advertising.rate_card';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign` (
    `advertising_campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `advertiser_id` BIGINT COMMENT 'FK to advertiser',
    `sales_campaign_id` BIGINT COMMENT 'Foreign key linking to sales.sales_campaign. Business justification: Broadcast ad trafficking requires linking the ad-server campaign to the sold sales campaign for delivery reconciliation and pacing reports. Trafficking teams map booked sales campaigns to ad-serving c',
    `campaign_code` STRING COMMENT 'Unique campaign code',
    `campaign_name` STRING COMMENT 'Campaign display name',
    `campaign_status` STRING COMMENT 'Current status (draft, active, paused, completed)',
    `campaign_type` STRING COMMENT 'Type of campaign (brand, performance, awareness)',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation time',
    `currency_code` STRING COMMENT 'Budget currency',
    `daily_budget_amount` DECIMAL(18,2) COMMENT 'Daily budget cap',
    `end_date` DATE COMMENT 'Campaign end date',
    `optimization_goal` STRING COMMENT 'Primary optimization objective',
    `pacing_type` STRING COMMENT 'Budget pacing strategy (even, accelerated, front-loaded)',
    `start_date` DATE COMMENT 'Campaign start date',
    `target_clicks` BIGINT COMMENT 'Target click count',
    `target_conversions` BIGINT COMMENT 'Target conversion count',
    `target_cpa` DECIMAL(18,2) COMMENT 'Target cost per acquisition',
    `target_cpc` DECIMAL(18,2) COMMENT 'Target cost per click',
    `target_cpm` DECIMAL(18,2) COMMENT 'Target cost per mille',
    `target_impressions` BIGINT COMMENT 'Target impression count',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total campaign budget',
    `updated_at` TIMESTAMP COMMENT 'Record update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update time',
    CONSTRAINT pk_advertising_campaign PRIMARY KEY(`advertising_campaign_id`)
) COMMENT 'Advertising campaign master record tracking campaign lifecycle, targeting, and budget allocation';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` (
    `creative_id` BIGINT COMMENT 'Primary key for creative',
    `advertiser_id` BIGINT COMMENT 'FK to advertiser',
    `advertising_campaign_id` BIGINT COMMENT 'FK to campaign',
    `rating_id` BIGINT COMMENT 'Foreign key linking to content.rating. Business justification: Ad creatives must be approved against content rating thresholds — a creative cleared for mature-rated content cannot traffic into family-rated slots. This compliance validation is a regulatory and con',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Creative versioning for demographic targeting is standard in media — different creative executions are produced for A18-49 vs. W25-54 segments. Linking creative to demographic_segment enables dynamic ',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Talent clearance and residual payment tracking require knowing which talent is featured in an advertising creative. In broadcasting, ad creatives featuring on-air talent trigger clearance verification',
    `music_sync_license_id` BIGINT COMMENT 'Foreign key linking to rights.music_sync_license. Business justification: Ad creatives containing music require a music sync license before broadcast. Legal and ad operations teams must verify which sync license covers each creative for regulatory compliance and PRO reporti',
    `approval_status` STRING COMMENT 'Approval status (pending, approved, rejected)',
    `click_through_url` STRING COMMENT 'Landing page URL',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation time',
    `creative_type` STRING COMMENT 'Type (video, display, native, audio)',
    `duration_seconds` STRING COMMENT 'Duration for video/audio creatives',
    `file_size_bytes` BIGINT COMMENT 'File size in bytes',
    `format` STRING COMMENT 'Format specification (VAST, VPAID, HTML5)',
    `height_pixels` STRING COMMENT 'Creative height in pixels',
    `is_active_flag` BOOLEAN COMMENT 'Whether creative is active',
    `creative_name` STRING COMMENT 'Creative display name',
    `updated_at` TIMESTAMP COMMENT 'Record update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update time',
    `width_pixels` STRING COMMENT 'Creative width in pixels',
    CONSTRAINT pk_creative PRIMARY KEY(`creative_id`)
) COMMENT 'Creative asset master for ad units including video, display, and native formats';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`placement` (
    `placement_id` BIGINT COMMENT 'Primary key for placement',
    `ad_break_id` BIGINT COMMENT 'Foreign key linking to scheduling.ad_break. Business justification: Ad placements in broadcast are trafficked into specific scheduled breaks. Ad operations teams link placements to ad_break records to confirm pod position, enforce max_duration_seconds constraints, and',
    `ad_inventory_id` BIGINT COMMENT 'FK to ad inventory',
    `ad_order_line_id` BIGINT COMMENT 'Foreign key linking to sales.ad_order_line. Business justification: Trafficking workflow maps each contracted order line to a placement in the ad server to fulfill delivery. This link is required for line-level delivery tracking, spot-level billing, and makegood eligi',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription_plan. Business justification: Ad placements must be scoped to eligible subscription plans (e.g., ad-supported tier only). Linking placement to subscription_plan ensures placements are only activated for qualifying plan tiers, a co',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation time',
    `floor_cpm` DECIMAL(18,2) COMMENT 'Minimum CPM for this placement',
    `is_active_flag` BOOLEAN COMMENT 'Whether placement is active',
    `is_skippable_flag` BOOLEAN COMMENT 'Whether ads can be skipped',
    `max_ad_duration_seconds` STRING COMMENT 'Maximum ad duration allowed',
    `placement_name` STRING COMMENT 'Placement display name',
    `placement_type` STRING COMMENT 'Type (pre-roll, mid-roll, post-roll, banner, interstitial)',
    `position` STRING COMMENT 'Position within content',
    `skip_offset_seconds` STRING COMMENT 'Seconds before skip is allowed',
    `supported_formats` STRING COMMENT 'Comma-separated supported formats',
    `updated_at` TIMESTAMP COMMENT 'Record update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update time',
    CONSTRAINT pk_placement PRIMARY KEY(`placement_id`)
) COMMENT 'Ad placement definition specifying where ads can appear within content or pages';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`targeting_rule` (
    `targeting_rule_id` BIGINT COMMENT 'Primary key for targeting rule',
    `advertising_campaign_id` BIGINT COMMENT 'FK to campaign',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Campaign targeting rules reference canonical demographic segment definitions for GRP/TRP planning and audience guarantee commitments. Linking targeting_rule to demographic_segment ensures targeting pa',
    `subscription_plan_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription_plan. Business justification: Ad targeting rules in OTT platforms must restrict ad delivery to specific subscription plan tiers (e.g., serve ads only to ad-supported plan subscribers). This FK enables plan-based audience targeting',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation time',
    `is_active_flag` BOOLEAN COMMENT 'Whether rule is active',
    `priority_order` STRING COMMENT 'Rule evaluation priority',
    `rule_name` STRING COMMENT 'Rule display name',
    `targeting_dimension` STRING COMMENT 'Specific dimension being targeted',
    `targeting_operator` STRING COMMENT 'Operator (include, exclude, equals)',
    `targeting_type` STRING COMMENT 'Type (demographic, geographic, behavioral, contextual, device)',
    `targeting_values` STRING COMMENT 'JSON array of target values',
    `updated_at` TIMESTAMP COMMENT 'Record update timestamp',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update time',
    CONSTRAINT pk_targeting_rule PRIMARY KEY(`targeting_rule_id`)
) COMMENT 'Targeting rule definitions for audience, geographic, contextual, and behavioral targeting';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` (
    `impression_id` BIGINT COMMENT 'Primary key for impression',
    `ad_break_id` BIGINT COMMENT 'Foreign key linking to scheduling.ad_break. Business justification: CTV/broadcast impression records must reference the specific ad break for Nielsen DAR reconciliation, break-level viewability reporting, and DAI audit trails. Broadcast ad ops engineers require impres',
    `ad_inventory_id` BIGINT COMMENT 'FK to ad inventory',
    `advertising_campaign_id` BIGINT COMMENT 'FK to campaign',
    `audience_profile_id` BIGINT COMMENT 'Foreign key linking to audience.audience_profile. Business justification: Addressable TV advertising serves impressions to specific audience profiles. Linking impression to audience_profile enables frequency capping, audience-based attribution, and lookalike modeling — core',
    `creative_id` BIGINT COMMENT 'FK to creative',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: FAST channel and OTT delivery channel-level ad revenue reporting requires attributing each impression to the specific delivery channel. Monetization model analysis, channel-level fill rate, and FAST a',
    `device_registration_id` BIGINT COMMENT 'Foreign key linking to subscriber.device_registration. Business justification: CTV/OTT device-level ad frequency capping and device-specific ad delivery reporting require linking impressions to registered devices. Enables per-device frequency management and device-type ad perfor',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Platform-level ad revenue reporting, advertiser billing reconciliation by OTT platform, and platform deal compliance (e.g., minimum impression guarantees per platform) require attributing each impress',
    `placement_id` BIGINT COMMENT 'FK to placement',
    `playback_session_id` BIGINT COMMENT 'Foreign key linking to distribution.playback_session. Business justification: DAI reconciliation and session-level ad attribution require linking each impression to the streaming playback session in which it was served. This is fundamental to OTT ad operations: viewability meas',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Authenticated OTT/streaming ad delivery requires subscriber-level frequency capping and reach/frequency reporting. Linking impression to subscriber enables per-subscriber ad exposure tracking, a core ',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscription. Business justification: Ad revenue reporting by subscription tier (ad-supported vs. premium) requires knowing which active subscription was in effect when an impression was served. Enables tier-based ad yield analysis and pl',
    `viewership_record_id` BIGINT COMMENT 'Foreign key linking to audience.viewership_record. Business justification: ACR-based and addressable TV advertising requires linking each ad impression to the viewing session context in which it was delivered. This enables audience-verified advertising, co-viewing adjustment',
    `bid_price` DECIMAL(18,2) COMMENT 'Winning bid price',
    `cost_amount` DECIMAL(18,2) COMMENT 'Cost of this impression',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Cost currency',
    `device_type` STRING COMMENT 'Device type (mobile, desktop, ctv, tablet)',
    `fraud_reason` STRING COMMENT 'Fraud detection reason if flagged',
    `geo_country` STRING COMMENT 'Country code',
    `geo_dma` STRING COMMENT 'The geo dma value recorded for each impression record within the advertising domain.',
    `geo_region` STRING COMMENT 'Region/state code',
    `impression_timestamp` TIMESTAMP COMMENT 'When impression occurred',
    `is_fraud_flag` BOOLEAN COMMENT 'Whether flagged as fraudulent',
    `platform` STRING COMMENT 'Platform (ios, android, web, roku, firetv)',
    `updated_at` TIMESTAMP COMMENT 'Record update timestamp',
    `user_id_hash` STRING COMMENT 'Hashed user identifier',
    `viewability_measured_flag` BOOLEAN COMMENT 'Whether viewability was measured',
    `viewable_flag` BOOLEAN COMMENT 'Whether impression was viewable (MRC standard)',
    `viewable_percent` DECIMAL(18,2) COMMENT 'Percentage of ad in view',
    `viewable_seconds` DECIMAL(18,2) COMMENT 'Seconds ad was in view',
    CONSTRAINT pk_impression PRIMARY KEY(`impression_id`)
) COMMENT 'Ad impression event fact table capturing each ad view with associated metrics';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`click` (
    `click_id` BIGINT COMMENT 'Primary key for click',
    `advertising_campaign_id` BIGINT COMMENT 'FK to campaign',
    `creative_id` BIGINT COMMENT 'FK to creative',
    `impression_id` BIGINT COMMENT 'FK to impression',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Authenticated subscriber click attribution is required for OTT ad conversion funnel reporting. Linking click to subscriber enables subscriber-level click-through analysis and downstream conversion att',
    `click_timestamp` TIMESTAMP COMMENT 'When click occurred',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `device_type` STRING COMMENT 'Device type',
    `fraud_reason` STRING COMMENT 'Fraud detection reason if flagged',
    `geo_country` STRING COMMENT 'Country code',
    `geo_region` STRING COMMENT 'Region/state code',
    `is_fraud_flag` BOOLEAN COMMENT 'Whether flagged as fraudulent',
    `platform` STRING COMMENT 'The platform value recorded for each click record within the advertising domain.',
    `referrer_url` STRING COMMENT 'Referring page URL',
    `time_to_click_seconds` DECIMAL(18,2) COMMENT 'Seconds from impression to click',
    `updated_at` TIMESTAMP COMMENT 'Record update timestamp',
    `url` STRING COMMENT 'Destination URL',
    `user_id_hash` STRING COMMENT 'Hashed user identifier',
    CONSTRAINT pk_click PRIMARY KEY(`click_id`)
) COMMENT 'Ad click event fact table capturing user click interactions';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` (
    `conversion_id` BIGINT COMMENT 'Primary key for conversion',
    `ad_order_id` BIGINT COMMENT 'External order/transaction ID',
    `advertising_campaign_id` BIGINT COMMENT 'FK to campaign',
    `audience_profile_id` BIGINT COMMENT 'Foreign key linking to audience.audience_profile. Business justification: Audience-based attribution analysis requires linking conversion events to the audience profile of the converter. This enables lookalike modeling, audience segment performance reporting, and ROAS analy',
    `click_id` BIGINT COMMENT 'FK to click (if click-through)',
    `impression_id` BIGINT COMMENT 'FK to impression (if view-through)',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Ad-driven subscription conversion attribution requires linking conversion events to specific subscribers. Enables reporting on which subscribers upgraded or converted due to ad campaigns, supporting a',
    `attribution_type` STRING COMMENT 'Attribution type (click-through, view-through)',
    `attribution_window_hours` STRING COMMENT 'Attribution window used',
    `conversion_timestamp` TIMESTAMP COMMENT 'When conversion occurred',
    `conversion_type` STRING COMMENT 'Type (purchase, signup, lead, install, subscription)',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Value currency',
    `is_deduplicated_flag` BOOLEAN COMMENT 'Whether conversion was deduplicated',
    `updated_at` TIMESTAMP COMMENT 'Record update timestamp',
    `user_id_hash` STRING COMMENT 'Hashed user identifier',
    `value` DECIMAL(18,2) COMMENT 'Monetary value of conversion',
    CONSTRAINT pk_conversion PRIMARY KEY(`conversion_id`)
) COMMENT 'Ad conversion event fact table capturing attributed conversions';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ADD CONSTRAINT `fk_advertising_ad_inventory_rate_card_id` FOREIGN KEY (`rate_card_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`rate_card`(`rate_card_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` ADD CONSTRAINT `fk_advertising_creative_advertising_campaign_id` FOREIGN KEY (`advertising_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign`(`advertising_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`placement` ADD CONSTRAINT `fk_advertising_placement_ad_inventory_id` FOREIGN KEY (`ad_inventory_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory`(`ad_inventory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`targeting_rule` ADD CONSTRAINT `fk_advertising_targeting_rule_advertising_campaign_id` FOREIGN KEY (`advertising_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign`(`advertising_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_ad_inventory_id` FOREIGN KEY (`ad_inventory_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory`(`ad_inventory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_advertising_campaign_id` FOREIGN KEY (`advertising_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign`(`advertising_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_creative_id` FOREIGN KEY (`creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`creative`(`creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ADD CONSTRAINT `fk_advertising_impression_placement_id` FOREIGN KEY (`placement_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`placement`(`placement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`click` ADD CONSTRAINT `fk_advertising_click_advertising_campaign_id` FOREIGN KEY (`advertising_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign`(`advertising_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`click` ADD CONSTRAINT `fk_advertising_click_creative_id` FOREIGN KEY (`creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`creative`(`creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`click` ADD CONSTRAINT `fk_advertising_click_impression_id` FOREIGN KEY (`impression_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`impression`(`impression_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ADD CONSTRAINT `fk_advertising_conversion_advertising_campaign_id` FOREIGN KEY (`advertising_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign`(`advertising_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ADD CONSTRAINT `fk_advertising_conversion_click_id` FOREIGN KEY (`click_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`click`(`click_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ADD CONSTRAINT `fk_advertising_conversion_impression_id` FOREIGN KEY (`impression_id`) REFERENCES `vibe_media_broadcasting_v1`.`advertising`.`impression`(`impression_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`advertising` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`advertising` SET TAGS ('dbx_domain' = 'advertising');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_subdomain' = 'inventory_pricing');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Inventory ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_inventory_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_inventory_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.ad_inventory_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_inventory_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.ad_inventory_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `nielsen_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `production_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Production Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `daypart_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `daypart_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.scheduling_daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `daypart_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.scheduling_daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.ad_pod_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.ad_pod_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertiser_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertiser_restrictions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertiser_restrictions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.advertiser_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertiser_restrictions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.advertiser_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `audience_segment_targeting` SET TAGS ('dbx_business_glossary_term' = 'Audience segment targeting criteria for programmatic inventory');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `blackout_markets` SET TAGS ('dbx_business_glossary_term' = 'Blackout Markets');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `blackout_markets` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `blackout_markets` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.blackout_markets');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `blackout_markets` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.blackout_markets');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `content_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `content_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `content_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.content_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `content_rating` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `effective_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `effective_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `effective_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.effective_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.estimated_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.estimated_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_impressions` SET TAGS ('dbx_business_glossary_term' = 'Estimated Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_impressions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_impressions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.estimated_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_impressions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.estimated_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.estimated_reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.estimated_reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_trp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Target Rating Point (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_trp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_trp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.estimated_trp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_trp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.estimated_trp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.expiration_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `first_party_data_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'First party data eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `held_units` SET TAGS ('dbx_business_glossary_term' = 'Held Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `held_units` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `held_units` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.held_units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `held_units` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.held_units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.inventory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.inventory_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.inventory_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.inventory_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inventory End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_end_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_end_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.inventory_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_end_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.inventory_end_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inventory Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_start_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_start_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.inventory_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_start_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.inventory_start_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|held|sold|preempted|blocked');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.inventory_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.inventory_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type` SET TAGS ('dbx_value_regex' = 'linear_spot|vod_preroll|vod_midroll|dai_slot|fast_pod|ott_impression');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.inventory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.inventory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `makegood_eligible` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `makegood_eligible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `makegood_eligible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.makegood_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `makegood_eligible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.makegood_eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `preemptible` SET TAGS ('dbx_business_glossary_term' = 'Preemptible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `preemptible` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `preemptible` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.preemptible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `preemptible` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.preemptible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|value|remnant');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.pricing_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.pricing_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.rate_card_cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.rate_card_cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.rate_card_cprp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.rate_card_cprp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `remaining_avails` SET TAGS ('dbx_business_glossary_term' = 'Remaining Avails');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `remaining_avails` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `remaining_avails` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.remaining_avails');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `remaining_avails` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.remaining_avails');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category` SET TAGS ('dbx_business_glossary_term' = 'Sales Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category` SET TAGS ('dbx_value_regex' = 'upfront|scatter|local|national|digital|programmatic');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.sales_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.sales_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sold_units` SET TAGS ('dbx_business_glossary_term' = 'Sold Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sold_units` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sold_units` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.sold_units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sold_units` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.sold_units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `total_available_units` SET TAGS ('dbx_business_glossary_term' = 'Total Available Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `total_available_units` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `total_available_units` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.total_available_units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `total_available_units` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.total_available_units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `unit_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Unit Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `unit_duration_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `unit_duration_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.unit_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `unit_duration_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.unit_duration_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.ad_inventory.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.ad_inventory.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_subdomain' = 'inventory_pricing');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.rate_card_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.rate_card_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `panel_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_value_regex' = 'first|middle|last|any');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.ad_pod_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.ad_pod_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `cpm_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `cpm_basis` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `cpm_basis` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.cpm_basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `cpm_basis` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.cpm_basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `discount_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Discount Eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `discount_eligibility` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `discount_eligibility` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.discount_eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `discount_eligibility` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.discount_eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.effective_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.effective_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `geographic_market` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `geographic_market` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.geographic_market');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `geographic_market` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.geographic_market');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `gross_rate` SET TAGS ('dbx_business_glossary_term' = 'Gross Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `gross_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `gross_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.gross_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `gross_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.gross_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.inventory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.inventory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.makegood_policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.makegood_policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `minimum_audience_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Audience Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `minimum_audience_guarantee` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `minimum_audience_guarantee` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.minimum_audience_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `minimum_audience_guarantee` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.minimum_audience_guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `mobile_rate_modifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `mobile_rate_modifier` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.rate_card_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.rate_card_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `net_rate` SET TAGS ('dbx_business_glossary_term' = 'Net Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `net_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `net_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.net_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `net_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.net_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `pmp_deal_rate` SET TAGS ('dbx_business_glossary_term' = 'Private marketplace deal rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_business_glossary_term' = 'Preemption Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_value_regex' = 'non_preemptible|preemptible_with_notice|immediately_preemptible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.preemption_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.preemption_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `programmatic_floor_cpm` SET TAGS ('dbx_business_glossary_term' = 'Programmatic floor CPM');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_value_regex' = '^RC-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.rate_card_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.rate_card_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|superseded|expired|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.rate_card_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.rate_card_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.rate_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.rate_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|package|digital|sponsorship|remnant');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.rate_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.rate_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Factor');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.seasonality_factor');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.seasonality_factor');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `source_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `source_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `source_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `source_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card._source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.spot_length_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.spot_length_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.advertising.rate_card.version');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.advertising.rate_card.version');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign` SET TAGS ('dbx_subdomain' = 'campaign_targeting');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`advertising_campaign` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` SET TAGS ('dbx_subdomain' = 'campaign_targeting');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` ALTER COLUMN `rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`creative` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_business_glossary_term' = 'Music Sync License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`placement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`placement` SET TAGS ('dbx_subdomain' = 'campaign_targeting');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`placement` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`placement` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`placement` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`targeting_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`targeting_rule` SET TAGS ('dbx_subdomain' = 'campaign_targeting');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`targeting_rule` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`targeting_rule` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ALTER COLUMN `audience_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ALTER COLUMN `device_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Playback Session Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ALTER COLUMN `viewership_record_id` SET TAGS ('dbx_business_glossary_term' = 'Viewership Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ALTER COLUMN `user_id_hash` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`impression` ALTER COLUMN `user_id_hash` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`click` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`click` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`click` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`click` ALTER COLUMN `user_id_hash` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`click` ALTER COLUMN `user_id_hash` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` SET TAGS ('dbx_subdomain' = 'performance_measurement');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ALTER COLUMN `audience_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ALTER COLUMN `user_id_hash` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`conversion` ALTER COLUMN `user_id_hash` SET TAGS ('dbx_pii' = 'true');
