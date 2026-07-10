-- Schema for Domain: advertising | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 19:30:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`advertising` COMMENT 'Manages the full advertising sales and campaign lifecycle — from upfront and scatter market deal negotiation through ad order entry, trafficking (Wide Orbit), DAI (Dynamic Ad Insertion), affidavit generation, and makegood processing. Tracks CPM, GRP, TRP, SOV, reach, frequency, and CPRP metrics. Owns ISCI codes, ad pod definitions, ad inventory, pricing, and campaign performance data feeding revenue reconciliation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` (
    `ad_inventory_id` BIGINT COMMENT 'Unique identifier for the advertising inventory record. Primary key.',
    `title_id` BIGINT COMMENT 'Reference to the specific program or content during which this ad inventory is available.',
    `ad_title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Inventory is generated from title airings. Business process: inventory forecasting by title, avails management, sell-through reporting, title-level CPM pricing, program-based inventory allocation.',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast or streaming channel where this inventory is available.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Inventory is forecasted, priced, and sold by Nielsen demographic segment for yield optimization and avails management. CPM/CPRP rates and GRP/TRP estimates vary by demographic. Essential for inventory',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Inventory forecasting depends on content rights availability. Sales planning tools must filter inventory by active license windows. Prevents overselling inventory in content with upcoming rights expir',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Inventory sourced from syndication partners, affiliate stations, or content distribution partners must track the supplying partner for revenue sharing calculations and inventory reconciliation. Real b',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Inventory is bucketed by daypart for pricing and availability management. Rate card application, proposal generation, and avail queries require linking inventory to master daypart definitions. Removes',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - ad inventory needs an owner for yield management accountability',
    `program_title_id` BIGINT COMMENT '',
    `ad_pod_position` STRING COMMENT 'The sequential position of this inventory slot within an ad pod (group of ads in a break). Position 1 is the first ad in the break.',
    `advertiser_restrictions` STRING COMMENT 'Comma-separated list of advertiser categories or specific advertisers that are restricted from purchasing this inventory due to content, competitive, or regulatory reasons.',
    `blackout_markets` STRING COMMENT 'Comma-separated list of designated market areas (DMA) or geographic regions where this inventory cannot be sold due to blackout restrictions.',
    `blackout_restriction` BOOLEAN COMMENT 'Indicates whether this inventory is subject to geographic broadcast restrictions (blackout) that prevent advertising in certain markets or regions.',
    `content_rating` STRING COMMENT 'The television content rating for the program associated with this inventory, which may restrict certain advertiser categories.. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory record was first created in the system.',
    `effective_date` DATE COMMENT 'The date from which this inventory record and its pricing become effective for sales purposes.',
    `estimated_grp` DECIMAL(18,2) COMMENT 'The estimated gross rating point (GRP) delivery for this inventory, representing the total audience reach multiplied by frequency. GRP is a standard broadcast audience measurement metric.',
    `estimated_impressions` BIGINT COMMENT 'The projected number of advertising impressions (individual ad views) this inventory will deliver, based on historical audience data.',
    `estimated_reach` BIGINT COMMENT 'The projected unique audience count (reach) that will be exposed to advertising in this inventory slot at least once.',
    `estimated_trp` DECIMAL(18,2) COMMENT 'The estimated target rating point (TRP) delivery for this inventory, representing the rating within a specific demographic target audience. TRP is used for targeted advertising campaigns.',
    `expiration_date` DATE COMMENT 'The date after which this inventory record is no longer valid or available for sale.',
    `held_units` STRING COMMENT 'The number of advertising units currently held or reserved pending final commitment, typically during proposal negotiation.',
    `hut_index` DECIMAL(18,2) COMMENT 'The percentage of homes using television during this inventory time period. HUT is a standard broadcast audience availability metric.',
    `inventory_code` STRING COMMENT 'Unique business identifier for this inventory slot, used in sales proposals and trafficking systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `inventory_date` DATE COMMENT 'The specific broadcast date for which this inventory is available.',
    `inventory_end_time` TIMESTAMP COMMENT 'The precise end time of the inventory window, including time zone information.',
    `inventory_start_time` TIMESTAMP COMMENT 'The precise start time of the inventory window, including time zone information.',
    `inventory_status` STRING COMMENT 'Current lifecycle status of the advertising inventory: available for sale, held pending commitment, sold and committed, preempted for higher-priority content, or blocked due to restrictions.. Valid values are `available|held|sold|preempted|blocked`',
    `inventory_type` STRING COMMENT 'Classification of the advertising inventory format: linear broadcast spot, video-on-demand (VOD) ad position, dynamic ad insertion (DAI) slot, free ad-supported streaming television (FAST) pod, or over-the-top (OTT) impression.. Valid values are `linear_spot|vod_preroll|vod_midroll|dai_slot|fast_pod|ott_impression`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this inventory record was last updated or modified.',
    `makegood_eligible` BOOLEAN COMMENT 'Indicates whether this inventory is eligible to be used for makegoods (compensatory ad spots provided when original spots did not air as scheduled).',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or contextual information about this inventory record.',
    `preemptible` BOOLEAN COMMENT 'Indicates whether this inventory can be preempted (bumped) for higher-priority programming or advertising. Preemptible inventory is typically sold at lower rates.',
    `pricing_tier` STRING COMMENT 'The pricing tier classification for this inventory based on audience quality and demand: premium (highest value), standard, value, or remnant (lowest value, unsold inventory).. Valid values are `premium|standard|value|remnant`',
    `put_index` DECIMAL(18,2) COMMENT 'The percentage of persons using television during this inventory time period. PUT is a standard broadcast audience availability metric.',
    `rate_card_cpm` DECIMAL(18,2) COMMENT 'The published rate card cost per thousand impressions (CPM) for this inventory. CPM is the standard pricing metric in advertising sales.',
    `rate_card_cprp` DECIMAL(18,2) COMMENT 'The published rate card cost per rating point (CPRP) for this inventory. CPRP is used in broadcast television pricing based on audience ratings.',
    `remaining_avails` STRING COMMENT 'The number of advertising units still available for sale, calculated as total available minus sold and held units.',
    `sales_category` STRING COMMENT 'The sales market category for this inventory: upfront (advance sales event), scatter (last-minute sales), local, national, digital, or programmatic.. Valid values are `upfront|scatter|local|national|digital|programmatic`',
    `sold_units` STRING COMMENT 'The number of advertising units that have been sold and committed to advertisers.',
    `total_available_units` STRING COMMENT 'The total number of advertising units (spots or impressions) available for sale in this inventory record.',
    `unit_duration_seconds` STRING COMMENT 'The standard duration in seconds for each advertising unit in this inventory (e.g., 15, 30, 60 seconds).',
    CONSTRAINT pk_ad_inventory PRIMARY KEY(`ad_inventory_id`)
) COMMENT 'Available advertising inventory record representing sellable ad time or impression capacity for a specific channel, daypart, program, and date window. Tracks total available units (spots or impressions), sold units, remaining avails, rate card CPM/CPRP, audience delivery estimate (GRP/TRP), HUT/PUT index, blackout restrictions, and inventory status (available, held, sold, preempted). Feeds the avails system for sales proposals and scatter market pricing.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` (
    `rate_card_id` BIGINT COMMENT 'Unique identifier for the advertising rate card. Primary key for the rate card entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Rate card pricing requires formal approval by revenue management or pricing strategy employee for governance and audit compliance. Replaces text approved_by field with proper FK for workforce integr',
    `channel_id` BIGINT COMMENT 'Identifier of the broadcast channel or streaming platform to which this rate card applies.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Rate cards are priced by Nielsen demographic cell (A18-49, W25-54, etc.) - fundamental to broadcast advertising economics. CPM/CPRP rates vary by demographic segment. Essential for proposal generation',
    `ad_pod_position` STRING COMMENT 'Position within the ad pod (group of ads in a commercial break) for which the rate applies. First and last positions typically command premium rates due to higher viewer attention.. Valid values are `first|middle|last|any`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the rate card was formally approved for use in ad sales and order entry.',
    `cpm_basis` DECIMAL(18,2) COMMENT 'Cost per thousand impressions or viewers that the rate is based on. CPM is a standard metric in advertising pricing used to normalize rates across different audience sizes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the rate card record was first created in the system.',
    `daypart` STRING COMMENT 'Time segment of the broadcast day for which the rate applies. Dayparts are standard time blocks used in media planning to segment audience availability and pricing (e.g., prime time 8-11pm, daytime 10am-4pm). [ENUM-REF-CANDIDATE: early_morning|morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight|weekend|sports|special_event — 12 candidates stripped; promote to reference product]',
    `discount_eligibility` STRING COMMENT 'Description of volume discounts, frequency discounts, or package deals that can be applied to this rate card for qualifying advertisers.',
    `effective_end_date` DATE COMMENT 'Date when the rate card expires and is no longer valid for new ad orders. Nullable for open-ended rate cards.',
    `effective_start_date` DATE COMMENT 'Date when the rate card becomes active and available for use in ad order pricing and proposals.',
    `geographic_market` STRING COMMENT 'Geographic market or Designated Market Area (DMA) to which the rate card applies. Can be national, regional, or local market identifier.',
    `gross_rate` DECIMAL(18,2) COMMENT 'Published rate for the ad spot before any discounts, commissions, or agency fees are applied. This is the list price used as the baseline for negotiations.',
    `grp_value` DECIMAL(18,2) COMMENT 'Gross Rating Point value associated with the rate, representing the percentage of the target audience reached multiplied by frequency. Used for planning and buying broadcast advertising.',
    `inventory_type` STRING COMMENT 'Type of advertising inventory covered by the rate card. Linear refers to traditional scheduled broadcast, VOD to video on demand, SVOD to subscription video on demand, AVOD to ad-supported video on demand, TVOD to transactional video on demand, OTT to over-the-top streaming, FAST to free ad-supported streaming television, and simulcast to simultaneous multi-platform broadcast. [ENUM-REF-CANDIDATE: linear|vod|svod|avod|tvod|ott|fast|simulcast — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the rate card record was last updated or modified.',
    `makegood_policy` STRING COMMENT 'Policy describing conditions under which makegoods (compensatory ad spots) will be provided if audience guarantees are not met or technical issues occur.',
    `minimum_audience_guarantee` STRING COMMENT 'Minimum guaranteed audience size (in thousands) for the daypart and demographic. If actual audience falls below this threshold, makegoods may be required.',
    `rate_card_name` STRING COMMENT 'Descriptive name of the rate card for easy identification, typically includes year and market or channel reference (e.g., 2024 Prime Time National Rate Card).',
    `net_rate` DECIMAL(18,2) COMMENT 'Rate after standard agency commission (typically 15%) and other standard deductions are applied. This is the effective rate paid by the advertiser.',
    `notes` STRING COMMENT 'Additional notes, terms, conditions, or special instructions related to the rate card, such as blackout dates, special event pricing, or advertiser category restrictions.',
    `preemption_priority` STRING COMMENT 'Indicates whether spots purchased at this rate can be preempted (bumped) for higher-paying advertisers. Non-preemptible rates are premium, while preemptible rates offer discounts but risk being moved or cancelled.. Valid values are `non_preemptible|preemptible_with_notice|immediately_preemptible`',
    `program_genre` STRING COMMENT 'Genre or category of programming for which the rate applies (e.g., News, Sports, Drama, Reality, Comedy). Certain genres command premium rates due to audience engagement and demographics.',
    `rate_card_number` STRING COMMENT 'Business identifier for the rate card, used for external reference and communication with sales teams and advertisers. Typically follows format RC-YYYYNNNN.. Valid values are `^RC-[0-9]{6,10}$`',
    `rate_card_status` STRING COMMENT 'Current lifecycle status of the rate card indicating its operational state and usability for ad order entry.. Valid values are `draft|pending_approval|active|superseded|expired|archived`',
    `rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate amounts (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `rate_type` STRING COMMENT 'Classification of the rate card by sales market type. Upfront rates are negotiated in advance for the broadcast year, scatter rates are for last-minute inventory, package rates bundle multiple spots, digital rates apply to OTT/streaming, sponsorship rates for integrated content, and remnant rates for unsold inventory.. Valid values are `upfront|scatter|package|digital|sponsorship|remnant`',
    `seasonality_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to base rates to account for seasonal demand variations (e.g., 1.25 for high-demand periods like holidays, 0.85 for low-demand summer months).',
    `spot_length_seconds` STRING COMMENT 'Duration of the advertising spot in seconds for which the rate applies. Common lengths are 15, 30, 60, and 120 seconds.',
    `trp_value` DECIMAL(18,2) COMMENT 'Target Rating Point value for the specific demographic audience segment. TRP is similar to GRP but focuses on a specific target demographic rather than total audience.',
    `version` STRING COMMENT 'Version number of the rate card to track revisions and updates. Follows semantic versioning (e.g., 1.0, 1.1, 2.0).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_rate_card PRIMARY KEY(`rate_card_id`)
) COMMENT 'Advertising rate card defining the standard pricing for ad inventory by channel, daypart, spot length, and audience demographic. Captures rate card version, effective date range, channel, daypart, spot length, gross rate, net rate, CPM basis, GRP value, audience demographic target, rate type (upfront, scatter, package, digital), and approval status. Used as the pricing baseline for ad order entry and proposal generation. Distinct from negotiated deal rates on individual orders.';

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`advertising` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`advertising` SET TAGS ('dbx_domain' = 'advertising');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` SET TAGS ('dbx_subdomain' = 'advertising_core');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Inventory ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `program_title_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `advertiser_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `blackout_markets` SET TAGS ('dbx_business_glossary_term' = 'Blackout Markets');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `blackout_restriction` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_impressions` SET TAGS ('dbx_business_glossary_term' = 'Estimated Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `estimated_trp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Target Rating Point (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `held_units` SET TAGS ('dbx_business_glossary_term' = 'Held Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `hut_index` SET TAGS ('dbx_business_glossary_term' = 'Homes Using Television (HUT) Index');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inventory End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inventory Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|held|sold|preempted|blocked');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `inventory_type` SET TAGS ('dbx_value_regex' = 'linear_spot|vod_preroll|vod_midroll|dai_slot|fast_pod|ott_impression');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `makegood_eligible` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `preemptible` SET TAGS ('dbx_business_glossary_term' = 'Preemptible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'premium|standard|value|remnant');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `put_index` SET TAGS ('dbx_business_glossary_term' = 'Persons Using Television (PUT) Index');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `rate_card_cprp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `remaining_avails` SET TAGS ('dbx_business_glossary_term' = 'Remaining Avails');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category` SET TAGS ('dbx_business_glossary_term' = 'Sales Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sales_category` SET TAGS ('dbx_value_regex' = 'upfront|scatter|local|national|digital|programmatic');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `sold_units` SET TAGS ('dbx_business_glossary_term' = 'Sold Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `total_available_units` SET TAGS ('dbx_business_glossary_term' = 'Total Available Units');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`ad_inventory` ALTER COLUMN `unit_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Unit Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` SET TAGS ('dbx_subdomain' = 'advertising_core');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_value_regex' = 'first|middle|last|any');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `cpm_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `discount_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Discount Eligibility');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `gross_rate` SET TAGS ('dbx_business_glossary_term' = 'Gross Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `grp_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `minimum_audience_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Audience Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `net_rate` SET TAGS ('dbx_business_glossary_term' = 'Net Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_business_glossary_term' = 'Preemption Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_value_regex' = 'non_preemptible|preemptible_with_notice|immediately_preemptible');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `program_genre` SET TAGS ('dbx_business_glossary_term' = 'Program Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_value_regex' = '^RC-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_card_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|superseded|expired|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|package|digital|sponsorship|remnant');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Factor');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `trp_value` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Point (TRP) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`advertising`.`rate_card` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
