-- Schema for Domain: marketing | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:45:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_restaurants_v1`.`marketing` COMMENT 'Manages promotional campaign planning, LTO execution, advertising spend, media channel performance (digital, social, traditional), brand positioning, local store marketing, guest segmentation, and campaign ROI measurement. Drives traffic, average daily transactions (ADT), and comparable store sales (comp sales) lift.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for each marketing campaign.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.franchise_agreement. Business justification: Needed to associate campaigns with the governing franchise agreement, ensuring marketing fees are charged per agreement and supporting audit of compliance with contract terms.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Required for Campaign Contract Management report linking each marketing campaign to its signed procurement contract for media spend compliance.',
    `food_recall_id` BIGINT COMMENT 'Foreign key linking to foodsafety.food_recall. Business justification: Recall campaigns are created to communicate product recalls; linking campaign to recall record tracks effectiveness and regulatory compliance.',
    `guest_segment_id` BIGINT COMMENT 'Guest segment (e.g., families, millennials) the campaign targets.',
    `ingredient_id` BIGINT COMMENT 'Foreign key linking to supply.ingredient. Business justification: Required for Ingredient Launch Campaigns that promote a newly sourced ingredient; marketing needs to reference the specific ingredient being advertised.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for the Campaign Ownership Report that tracks which employee owns each marketing campaign, a standard operational metric in restaurant marketing.',
    `supply_supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Needed for Supplier Co‑Brand Campaigns where a marketing campaign is jointly run with a specific supplier; ties campaign to the supplier record.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Required for campaign planning and ROI reporting by linking each marketing campaign to the specific franchise territory it targets, enabling territory-level spend allocation and compliance tracking.',
    `trade_area_id` BIGINT COMMENT 'Foreign key linking to realestate.trade_area. Business justification: Campaign planning uses trade‑area segmentation to allocate spend; linking enables trade‑area ROI reporting and compliance with market‑targeting strategy.',
    `actual_adt_lift_pct` DECIMAL(18,2) COMMENT 'Measured increase in Average Daily Transactions after campaign execution.',
    `actual_comp_sales_lift_pct` DECIMAL(18,2) COMMENT 'Measured lift in comparable store sales after campaign execution.',
    `actual_end_date` DATE COMMENT 'Date the campaign actually ended.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Actual monetary spend recorded for the campaign.',
    `actual_start_date` DATE COMMENT 'Date the campaign actually started.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned monetary budget allocated to the campaign.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign.. Valid values are `planned|active|completed|cancelled`',
    `campaign_type` STRING COMMENT 'Classification of the campaign by scope and delivery channel.. Valid values are `national|local|digital|traditional|online|social`',
    `channel_mix` STRING COMMENT 'Combination of media channels used (e.g., digital, social, TV, radio).',
    `campaign_code` STRING COMMENT 'Business identifier or code used to reference the campaign in external systems.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the campaign complies with all applicable foodservice marketing regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created.',
    `campaign_description` STRING COMMENT 'Detailed narrative describing the purpose and scope of the campaign.',
    `expected_adt_lift_pct` DECIMAL(18,2) COMMENT 'Planned increase in Average Daily Transactions expressed as a percentage.',
    `expected_comp_sales_lift_pct` DECIMAL(18,2) COMMENT 'Planned lift in comparable store sales expressed as a percentage.',
    `is_lto` BOOLEAN COMMENT 'True if the campaign includes a Limited‑Time Offer (LTO).',
    `is_test_campaign` BOOLEAN COMMENT 'Indicates whether the campaign is a test or pilot (true) or a production campaign (false).',
    `lto_end_date` DATE COMMENT 'End date of the Limited‑Time Offer component, if applicable.',
    `lto_start_date` DATE COMMENT 'Start date of the Limited‑Time Offer component, if applicable.',
    `campaign_name` STRING COMMENT 'Human‑readable name of the campaign.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the campaign.',
    `objective` STRING COMMENT 'Primary business goal of the campaign (e.g., ADT lift, comparable store sales, brand awareness).',
    `objective_metric` STRING COMMENT 'Metric used to measure the campaigns objective.. Valid values are `adt_lift|comp_sales_lift|brand_awareness|traffic`',
    `owning_brand` STRING COMMENT 'Brand within Restaurants that owns and sponsors the campaign.',
    `planned_end_date` DATE COMMENT 'Date the campaign is scheduled to conclude.',
    `planned_start_date` DATE COMMENT 'Date the campaign is scheduled to begin.',
    `target_daypart` STRING COMMENT 'Daypart (e.g., breakfast, lunch, dinner) the campaign is aimed at.',
    `target_geography` STRING COMMENT 'Geographic region(s) targeted by the campaign (e.g., USA, CAN).',
    `target_market` STRING COMMENT 'Market segment or demographic the campaign is aimed at (e.g., urban millennials).',
    `target_store_count` STRING COMMENT 'Number of restaurant locations the campaign is intended to cover.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign record.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for every marketing campaign executed by Restaurants, including promotional campaigns, LTO (Limited Time Offer) launches, brand awareness drives, and traffic-building initiatives. Captures campaign name, type (national/local/digital/traditional), objective (ADT lift, comp sales, brand awareness), status (planned/active/completed/cancelled), planned and actual start/end dates, target daypart, target guest segment, owning brand, channel mix, budget allocation, and campaign owner. SSOT for campaign identity across all marketing execution.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` (
    `campaign_execution_id` BIGINT COMMENT 'Unique identifier for the campaign execution record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.franchise_agreement. Business justification: Links each campaign execution to the specific franchise agreement authorizing it, required for royalty calculations and legal compliance verification.',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchise associated with the execution (if applicable).',
    `campaign_franchisee_id` BIGINT COMMENT 'Identifier of the franchise associated with the execution (if applicable).',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Each execution belongs to a single campaign; linking enables traceability of spend and performance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for the Campaign Execution Oversight Report, linking the employee responsible for executing a campaign to the execution record.',
    `health_inspection_id` BIGINT COMMENT 'Foreign key linking to foodsafety.health_inspection. Business justification: Compliance check: marketing verifies latest health inspection before launching campaign execution to ensure unit meets safety standards.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Required for budgeting, ROI calculation, and compliance reporting of campaign execution at a specific restaurant location.',
    `actual_adt_lift_percent` DECIMAL(18,2) COMMENT 'Observed percentage increase in ADT after execution.',
    `actual_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'Observed percentage lift in comparable store sales.',
    `actual_end_date` DATE COMMENT 'Actual date when the campaign ended.',
    `actual_launch_date` DATE COMMENT 'Actual date when the campaign went live.',
    `campaign_execution_status` STRING COMMENT 'Current lifecycle status of the campaign execution.. Valid values are `planned|launched|completed|cancelled|paused`',
    `channel_spend_amount` DECIMAL(18,2) COMMENT 'Total monetary spend allocated to the execution channel.',
    `clicks` STRING COMMENT 'Number of clicks generated by the campaign.',
    `conversions` STRING COMMENT 'Number of conversion actions (e.g., orders) attributed to the campaign.',
    `cost_per_click` DECIMAL(18,2) COMMENT 'Average cost incurred per click.',
    `cost_per_impression` DECIMAL(18,2) COMMENT 'Average cost incurred per thousand impressions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign execution record was created.',
    `creative_version` STRING COMMENT 'Identifier for the creative version used in the execution.',
    `currency_code` STRING COMMENT 'Three‑letter currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `deviation_reason` STRING COMMENT 'Explanation of any deviation from the original campaign plan.',
    `execution_channel` STRING COMMENT 'Channel through which the campaign was executed.. Valid values are `digital|social|ooH|radio|tv|in_store_pos`',
    `execution_code` STRING COMMENT 'Business identifier code assigned to the campaign execution.',
    `execution_owner` STRING COMMENT 'Person or team responsible for executing the campaign.',
    `execution_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary execution event (e.g., launch).',
    `expected_adt_lift_percent` DECIMAL(18,2) COMMENT 'Projected percentage increase in ADT due to the campaign.',
    `expected_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'Projected percentage lift in comparable store sales.',
    `impressions` STRING COMMENT 'Number of times the campaign was displayed.',
    `launch_date` DATE COMMENT 'Planned date for the campaign launch.',
    `market_dma` STRING COMMENT 'Geographic market or DMA where the campaign is executed.',
    `media_vendor` STRING COMMENT 'Name of the media vendor or agency delivering the campaign.',
    `notes` STRING COMMENT 'Free‑form field for any additional information about the execution.',
    `planned_end_date` DATE COMMENT 'Planned date for the campaign to end.',
    `restaurant_scope` STRING COMMENT 'Scope of restaurants included in the execution.. Valid values are `all_units|franchise_group|company_owned|selected_units`',
    `roi_percent` DECIMAL(18,2) COMMENT 'Calculated ROI percentage for the campaign execution.',
    `target_audience` STRING COMMENT 'Description of the intended audience for the campaign.',
    `target_segment` STRING COMMENT 'Segment of customers the campaign targets.. Valid values are `loyal_customers|new_customers|families|students|business|tourists`',
    `tracking_url` STRING COMMENT 'URL used to track digital campaign performance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_campaign_execution PRIMARY KEY(`campaign_execution_id`)
) COMMENT 'Transactional record capturing the actual execution of a campaign within a specific market, restaurant group, or channel. Tracks execution status, launch date, actual vs. planned go-live, execution channel (digital, social, OOH, radio, TV, in-store POS), market/DMA, restaurant scope (all units, franchise group, company-owned), execution owner, and any deviations from the campaign plan. Enables operational tracking of campaign rollout across thousands of restaurant units.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`marketing_lto` (
    `marketing_lto_id` BIGINT COMMENT 'Unique identifier for the marketing_lto data product (auto-inserted pre-linking).',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: LTOs are created for specific campaigns; linking provides ownership.',
    `menu_item_id` BIGINT COMMENT 'add column menu_item_id (BIGINT) with FK to menu.menu_item.menu_item_id - marketing LTOs must reference the menu item being promoted as limited-time',
    CONSTRAINT pk_marketing_lto PRIMARY KEY(`marketing_lto_id`)
) COMMENT 'Master record for Limited Time Offers (LTOs) — the cornerstone of QSR marketing strategy. Captures LTO name, associated menu item(s), promotional price, offer window (start/end date), daypart applicability, channel availability (DT, OLO, 3PD, dine-in), target guest segment, PMIX impact forecast, sourcing readiness flag, and regulatory compliance status (FDA labeling). Links to campaign and menu domain for full LTO lifecycle management from ideation through execution.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` (
    `media_plan_id` BIGINT COMMENT 'Unique identifier for the media plan.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with this media plan.',
    `agency_name` STRING COMMENT 'Advertising agency partner responsible for executing the media plan.',
    `approval_status` STRING COMMENT 'Current approval state of the media plan.. Valid values are `pending|approved|rejected`',
    `brand_name` STRING COMMENT 'Brand associated with the media plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the media plan record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the planned spend.. Valid values are `^[A-Z]{3}$`',
    `daypart_target` STRING COMMENT 'Primary daypart(s) targeted by the media plan.. Valid values are `breakfast|lunch|dinner|late_night|all_day`',
    `digital_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to digital advertising channels.',
    `effective_from` DATE COMMENT 'Date when the media plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the media plan ends or expires.',
    `frequency_target` STRING COMMENT 'Target average number of times each individual is exposed.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the media plan is currently active.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the media plan.. Valid values are `draft|pending|active|suspended|closed|cancelled`',
    `ooh_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to out-of-home advertising.',
    `plan_code` STRING COMMENT 'External reference code for the media plan used in marketing systems.',
    `plan_description` STRING COMMENT 'Detailed description of the media plan objectives and scope.',
    `plan_name` STRING COMMENT 'Descriptive name of the media plan.',
    `plan_type` STRING COMMENT 'Category of the media plan indicating its scope.. Valid values are `brand|regional|national|global`',
    `print_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to print advertising.',
    `radio_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to radio advertising.',
    `reach_target` BIGINT COMMENT 'Target number of unique individuals to be reached.',
    `social_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to social media advertising.',
    `target_dma` STRING COMMENT 'Designated Designated Market Area code for the media plans geographic focus.. Valid values are `^[A-Z]{3}$`',
    `total_planned_spend` DECIMAL(18,2) COMMENT 'Total amount of advertising spend planned for the media plan.',
    `tv_spend` DECIMAL(18,2) COMMENT 'Planned spend allocated to television advertising.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the media plan record.',
    CONSTRAINT pk_media_plan PRIMARY KEY(`media_plan_id`)
) COMMENT 'Master record for the media planning document that defines how advertising spend is allocated across channels (TV, radio, digital, social, OOH, print) for a given campaign or fiscal period. Captures plan name, planning period, total planned spend, channel mix breakdown, target DMA/market, agency partner, brand, daypart targeting, reach and frequency targets, and approval status. SSOT for pre-buy media strategy and spend authorization.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` (
    `media_buy_id` BIGINT COMMENT 'Unique system-generated identifier for the media buy record.',
    `ad_creative_id` BIGINT COMMENT 'Reference to the creative asset used for this placement.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this media buy.',
    `media_channel_id` BIGINT COMMENT 'Foreign key linking to marketing.media_channel. Business justification: Media buy records need to reference a specific media channel; replace string column with proper FK.',
    `media_plan_id` BIGINT COMMENT 'Reference to the overarching media plan that includes this buy.',
    `supplier_id` BIGINT COMMENT 'Identifier of the media vendor or publisher providing the ad placement.',
    `media_vendor_procurement_supplier_id` BIGINT COMMENT 'Identifier of the media vendor or publisher providing the ad placement.',
    `actual_cpm` DECIMAL(18,2) COMMENT 'Effective CPM based on actual impressions delivered.',
    `actual_grps` DECIMAL(18,2) COMMENT 'GRPs measured after the flight completed.',
    `actual_impressions` BIGINT COMMENT 'Number of impressions actually served during the flight.',
    `ad_format` STRING COMMENT 'Creative format of the advertisement.. Valid values are `video|image|text|audio`',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of discounts, fees, or other adjustments applied to the contracted amount.',
    `agency_name` STRING COMMENT 'Name of the advertising agency managing the purchase, if applicable.',
    `audience_segment` STRING COMMENT 'Target audience segment or demographic for the placement.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Maximum budget allocated for this media buy within the campaign.',
    `buy_number` STRING COMMENT 'Business-facing identifier or purchase order number for the media placement.',
    `buy_timestamp` TIMESTAMP COMMENT 'Exact date and time when the media purchase was executed.',
    `contract_end_date` DATE COMMENT 'Effective end date of the media contract (null if open‑ended).',
    `contract_start_date` DATE COMMENT 'Effective start date of the media contract.',
    `contracted_amount` DECIMAL(18,2) COMMENT 'Total contracted gross spend for the media placement before discounts or fees.',
    `contracted_grps` DECIMAL(18,2) COMMENT 'Total GRPs purchased for the flight.',
    `contracted_impressions` BIGINT COMMENT 'Number of impressions (or equivalent) guaranteed in the contract.',
    `cpm_rate` DECIMAL(18,2) COMMENT 'Agreed cost per thousand impressions, expressed in the transaction currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the media buy record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the transaction.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `flight_end_date` DATE COMMENT 'Last calendar date the ad is scheduled to run.',
    `flight_start_date` DATE COMMENT 'First calendar date the ad is scheduled to run.',
    `invoice_number` STRING COMMENT 'Invoice number issued by the vendor for this media purchase.',
    `is_programmatic` BOOLEAN COMMENT 'Indicates whether the buy was executed programmatically.',
    `market_dma` STRING COMMENT 'Geographic market or DMA where the media placement is targeted.',
    `media_buy_status` STRING COMMENT 'Current lifecycle status of the media buy.. Valid values are `planned|booked|active|completed|cancelled`',
    `net_spend` DECIMAL(18,2) COMMENT 'Final net amount paid after adjustments.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the media buy.',
    `payment_status` STRING COMMENT 'Current payment processing status for the media buy.. Valid values are `pending|paid|failed|partial`',
    `placement_name` STRING COMMENT 'Descriptive name of the specific ad placement or slot.',
    `placement_size` STRING COMMENT 'Dimensions or size specification of the ad slot (e.g., 300x250).',
    `publisher_name` STRING COMMENT 'Name of the network, platform, or publisher delivering the ad.',
    `reconciliation_status` STRING COMMENT 'Status of financial reconciliation against the media plan.. Valid values are `matched|unmatched|pending`',
    `targeting_criteria` STRING COMMENT 'Free‑text description of targeting rules (e.g., geo, interest, device).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the media buy record.',
    CONSTRAINT pk_media_buy PRIMARY KEY(`media_buy_id`)
) COMMENT 'Transactional record for each marketing expenditure line item — the single financial ledger for all campaign spending. Captures media placement purchases (TV spots, digital display, paid social, SEM, OOH panels, radio spots), production costs, agency fees, and in-store material costs. Records buy/spend date, spend category (media placement/production/agency fee/in-store materials), channel type, publisher/network/vendor, placement or service name, flight dates, contracted impressions/GRPs (for media), CPM/CPP rate, actual spend amount, invoice reference, market/DMA code, budget line item, variance to plan, reconciliation status against the media plan, and campaign budget pacing status. SSOT for all granular campaign expenditure tracking, post-buy analysis, spend pacing, and campaign-level financial reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` (
    `media_channel_id` BIGINT COMMENT 'Unique identifier for the media channel record.',
    `campaign_id` BIGINT COMMENT 'add column campaign_id (BIGINT) with FK to marketing.campaign.campaign_id - media channels are isolated reference tables but have no inbound FKs except from media_buy; confirm inbound exists or connect',
    `active_status` STRING COMMENT 'Current operational status of the channel.. Valid values are `active|inactive|paused|retired`',
    `average_cpm` DECIMAL(18,2) COMMENT 'Typical cost per thousand impressions for the channel.',
    `media_channel_category` STRING COMMENT 'High-level classification of the channel.. Valid values are `traditional|digital|social|in_store|out_of_home`',
    `channel_code` STRING COMMENT 'Unique business code for the media channel.',
    `channel_group` STRING COMMENT 'Higher-level grouping such as Paid Media or Earned Media.',
    `channel_owner` STRING COMMENT 'Internal team or individual responsible for the channel.',
    `compliance_notes` STRING COMMENT 'Notes on regulatory compliance such as FDA advertising rules.',
    `cost_model` STRING COMMENT 'Pricing model for media buying on the channel.. Valid values are `cpm|cpc|cpa|cpl|fixed_fee`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the channel record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for cost values.. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'Originating system of record for the channel data.',
    `media_channel_description` STRING COMMENT 'Detailed description of the channel and its typical usage.',
    `effective_end_date` DATE COMMENT 'Date when the channel is retired or no longer used.',
    `effective_start_date` DATE COMMENT 'Date when the channel became active for use.',
    `geographic_scope` STRING COMMENT 'Geographic reach of the channel.. Valid values are `local|regional|national|global`',
    `is_programmatic` BOOLEAN COMMENT 'Indicates if the channel supports programmatic buying.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit for the channel.',
    `measurement_methodology` STRING COMMENT 'Primary metric used to measure channel performance.. Valid values are `impressions|clicks|views|conversions|reach|engagement`',
    `media_channel_name` STRING COMMENT 'Human readable name of the media channel.',
    `platform` STRING COMMENT 'Specific platform or network hosting the channel, e.g., Google, Facebook, CBS.',
    `primary_audience` STRING COMMENT 'Main audience segment targeted by the channel.',
    `sub_category` STRING COMMENT 'More specific classification within the category, e.g., paid search, display, etc.',
    `targeting_capabilities` STRING COMMENT 'Supported targeting options such as demographic, geographic, or behavioral.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the channel record.',
    CONSTRAINT pk_media_channel PRIMARY KEY(`media_channel_id`)
) COMMENT 'Reference master for all marketing media channels and platforms used by Restaurants — TV, radio, digital display, paid search (SEM), paid social (Facebook, Instagram, TikTok, Snapchat), OOH (billboards, transit), email, SMS, in-app push, in-store POS signage, 3PD platform ads (DoorDash, Uber Eats, Grubhub). Captures channel name, channel category (traditional/digital/social/in-store/3PD), platform/network, targeting capabilities, measurement methodology (impressions/clicks/GRPs/reach), cost model (CPM/CPC/CPP/flat), and active status. Enables consistent channel classification across media plans, buys, and performance reporting.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` (
    `ad_creative_id` BIGINT COMMENT 'Unique system-generated identifier for the advertising creative asset.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that uses this creative.',
    `ad_creative_status` STRING COMMENT 'Current lifecycle state of the creative asset.. Valid values are `draft|pending|approved|active|retired`',
    `ad_format_specifications` STRING COMMENT 'Technical specifications required for the ad format (e.g., bitrate, codec).',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the creative received legal approval.',
    `archive_date` DATE COMMENT 'Date when the creative was moved to archive.',
    `asset_url` STRING COMMENT 'Direct URL to the stored creative file in the DAM.',
    `brand_compliance_status` STRING COMMENT 'Result of brand compliance review for the creative.. Valid values are `compliant|non_compliant|pending`',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Marketing budget assigned to this creative.',
    `call_to_action_text` STRING COMMENT 'Text of the call‑to‑action displayed in the creative.',
    `channel_suitability` STRING COMMENT 'Media channels where the creative is approved for deployment.. Valid values are `tv|radio|digital|social|in_store|email`',
    `compliance_review_date` DATE COMMENT 'Date of the most recent brand compliance review.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the creative record was first created.',
    `creative_category` STRING COMMENT 'High‑level category grouping for the creative.. Valid values are `brand|product|seasonal|promo`',
    `creative_code` STRING COMMENT 'External code or SKU assigned to the creative for inventory and tracking.',
    `creative_description` STRING COMMENT 'Narrative description of the creative asset.',
    `creative_name` STRING COMMENT 'Human‑readable name of the creative asset used for reporting and search.',
    `creative_owner` STRING COMMENT 'Name of the internal team or individual responsible for the creative.',
    `creative_subcategory` STRING COMMENT 'More specific sub‑category within the main creative category.',
    `creative_tags` STRING COMMENT 'Comma‑separated list of tags for search and categorization.',
    `creative_type` STRING COMMENT 'Category of the creative asset indicating its media form.. Valid values are `video|static|audio|copy`',
    `dam_reference_code` STRING COMMENT 'Identifier of the asset within the Digital Asset Management system.',
    `dimensions` STRING COMMENT 'Pixel dimensions of the creative (e.g., 1920x1080).',
    `duration_seconds` STRING COMMENT 'Length of the creative in seconds; applicable to video and audio assets.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date and time after which the creative should no longer be used.',
    `file_format` STRING COMMENT 'File format of the creative asset (e.g., mp4, jpg, png).',
    `file_size_bytes` BIGINT COMMENT 'Size of the creative file in bytes.',
    `is_archived` BOOLEAN COMMENT 'Indicates whether the creative has been archived and is no longer active.',
    `is_dynamic` BOOLEAN COMMENT 'Indicates whether the creative contains dynamic or personalized content.',
    `language` STRING COMMENT 'Language of the creative content.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent deployment of the creative.',
    `legal_approval_status` STRING COMMENT 'Legal department approval outcome for the creative.. Valid values are `approved|rejected|pending`',
    `legal_review_date` DATE COMMENT 'Date of the most recent legal approval review.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the creative.',
    `production_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to produce the creative, expressed in US dollars.',
    `roi_estimate` DECIMAL(18,2) COMMENT 'Projected return on investment percentage for the creative.',
    `target_audience` STRING COMMENT 'Primary audience segment for which the creative is designed.',
    `target_market` STRING COMMENT 'Geographic or demographic market for which the creative is intended.',
    `tracking_pixel_url` STRING COMMENT 'URL of the tracking pixel embedded in the creative for performance measurement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the creative record.',
    `usage_rights` STRING COMMENT 'Legal usage rights associated with the creative.. Valid values are `internal|licensed|royalty_free`',
    `version_number` STRING COMMENT 'Sequential version number of the creative asset.',
    CONSTRAINT pk_ad_creative PRIMARY KEY(`ad_creative_id`)
) COMMENT 'Master record for each advertising creative asset used in marketing campaigns — TV spots, radio scripts, digital banner ads, social media posts, email templates, in-store POS materials, menu board graphics, and app push notifications. Captures creative name, format (video/static/audio/copy), dimensions/specs, brand compliance status, legal approval status, version number, associated campaign, channel suitability, production cost, and asset URL/DAM reference. SSOT for creative asset management.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`promotion` (
    `promotion_id` BIGINT COMMENT 'Unique system-generated identifier for the promotion.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Promotions are launched under a campaign; linking enables aggregation of promotion performance.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Allows tracking of promotions originated by individual franchisees, supporting franchisee-specific performance dashboards and reimbursement of promotion costs.',
    `item_category_id` BIGINT COMMENT 'Foreign key linking to inventory.item_category. Business justification: Promotion eligibility is defined by item categories; linking enables promotion performance reporting per category.',
    `supply_supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Supplier‑Sponsored Promotions require tracking which supplier funded the promotion; creates a FK to the supplier entity.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Store‑specific promotions must be tied to the unit for performance tracking, local compliance, and redemption reporting.',
    `applicable_channels` STRING COMMENT 'Sales channels where the promotion can be redeemed (POS, online ordering, third‑party delivery, mobile app).. Valid values are `pos|olo|3pd|app`',
    `promotion_code` STRING COMMENT 'Business code used to reference the promotion in POS and reporting systems.',
    `promotion_description` STRING COMMENT 'Detailed marketing description of the promotion displayed to guests.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Fixed monetary discount applied when the promotion is used.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied when the promotion is used.',
    `eligibility_criteria` STRING COMMENT 'Business rules defining eligibility (e.g., purchase of specific SKU, time of day).',
    `eligible_guest_segments` STRING COMMENT 'Guest segmentation criteria (e.g., loyalty tier, new guest, student) that qualify for the promotion.',
    `end_date` DATE COMMENT 'Date when the promotion expires; null if open‑ended.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the promotion excludes other concurrent promotions.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether the promotion can be combined with other promotions.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum order total required for the promotion to be eligible.',
    `promotion_name` STRING COMMENT 'Human‑readable name of the promotional offer.',
    `promo_category` STRING COMMENT 'High‑level business grouping of the promotion for reporting purposes.. Valid values are `seasonal|new_product|clearance|holiday|loyalty|event`',
    `promo_source` STRING COMMENT 'Origin of the promotion (e.g., corporate, franchisee, external partner).. Valid values are `internal|franchise|partner|vendor`',
    `promotion_status` STRING COMMENT 'Current lifecycle status of the promotion.. Valid values are `active|inactive|pending|expired|draft`',
    `promotion_type` STRING COMMENT 'Category of the promotion defining the pricing mechanic (e.g., discount, buy‑one‑get‑one).. Valid values are `discount|bogo|bundle|coupon|loyalty|gift`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the promotion record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the promotion record.',
    `redemption_count` STRING COMMENT 'Running total of how many times the promotion has been redeemed.',
    `redemption_limit_per_customer` STRING COMMENT 'Maximum number of times a single guest may redeem the promotion.',
    `start_date` DATE COMMENT 'Date when the promotion becomes effective and can be redeemed.',
    `total_redemption_limit` STRING COMMENT 'Overall cap on the number of redemptions across all guests.',
    CONSTRAINT pk_promotion PRIMARY KEY(`promotion_id`)
) COMMENT 'Master record for all guest-facing promotional offers and their issued instruments (coupons) — including discounts, BOGOs (buy-one-get-one), combo deals, value meals, loyalty reward redemptions, digital app deals, and physical/digital coupons. Captures promotion name, type (discount/BOGO/bundle/coupon/loyalty/app-exclusive), discount value or percentage, minimum purchase threshold, channel eligibility (POS/OLO/3PD/app), guest segment targeting, redemption limits, and associated campaign. For coupon-type promotions: coupon code, coupon format (single-use/multi-use/loyalty-exclusive/app-only/printed), eligible menu items or categories, issue date, expiry date, maximum redemption count, and fraud prevention flags (velocity checks, geo-fencing). SSOT for all promotional offer mechanics and issued coupon instruments.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` (
    `promotion_redemption_id` BIGINT COMMENT 'Unique identifier for the promotion redemption record.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign linked to the promotion.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who processed the redemption.',
    `profile_id` BIGINT COMMENT 'Identifier of the guest who redeemed the promotion.',
    `promotion_id` BIGINT COMMENT 'Identifier of the promotion that was redeemed.',
    `member_id` BIGINT COMMENT 'Identifier of the loyalty member associated with the redemption.',
    `promotion_member_id` BIGINT COMMENT 'Identifier of the loyalty member associated with the redemption.',
    `promotion_profile_id` BIGINT COMMENT 'Identifier of the guest who redeemed the promotion.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where redemption occurred.',
    `promotion_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit where redemption occurred.',
    `channel` STRING COMMENT 'Channel through which the redemption was captured (POS, online ordering, third‑party delivery, mobile app).. Valid values are `POS|OLO|3PD|APP`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the redemption record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `daypart` STRING COMMENT 'Meal period during which the redemption occurred.. Valid values are `breakfast|lunch|dinner|late_night`',
    `device_code` STRING COMMENT 'Identifier of the POS or kiosk device that captured the redemption.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied when discount is percent‑based.',
    `discount_type` STRING COMMENT 'Indicates whether the discount is a fixed amount or a percentage.. Valid values are `amount|percent`',
    `is_test_redemption` BOOLEAN COMMENT 'True if the redemption was a test or training transaction.',
    `loyalty_member_flag` BOOLEAN COMMENT 'Indicates if the guest is a loyalty program member at the time of redemption.',
    `order_value_after_discount` DECIMAL(18,2) COMMENT 'Total order amount after applying the promotion discount.',
    `order_value_before_discount` DECIMAL(18,2) COMMENT 'Total order amount before applying the promotion discount.',
    `promotion_redemption_status` STRING COMMENT 'Current lifecycle status of the redemption.. Valid values are `redeemed|voided|pending|failed|cancelled`',
    `redemption_number` STRING COMMENT 'Business identifier for the redemption event, often displayed to staff.',
    `redemption_timestamp` TIMESTAMP COMMENT 'Date and time when the promotion was redeemed.',
    `ticket_number` STRING COMMENT 'POS ticket or order number associated with the redemption.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the redemption record.',
    CONSTRAINT pk_promotion_redemption PRIMARY KEY(`promotion_redemption_id`)
) COMMENT 'Transactional record capturing each instance of a guest redeeming a promotional offer at a restaurant. Captures redemption timestamp, channel (POS/OLO/3PD/app), restaurant unit, promotion redeemed, discount amount applied, order value before and after discount, guest identifier (if known), and loyalty member flag. Enables measurement of promotion uptake, discount liability, and incremental traffic driven by promotional activity.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment` (
    `marketing_guest_segment_id` BIGINT COMMENT 'Unique identifier for the marketing_guest_segment data product (auto-inserted pre-linking).',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Guest segments are defined for targeting specific campaigns.',
    `guest_segment_id` BIGINT COMMENT 'add column guest_segment_id (BIGINT) with FK to guest.guest_segment.guest_segment_id - marketing guest segments should reference the master guest segment definition to avoid duplication',
    CONSTRAINT pk_marketing_guest_segment PRIMARY KEY(`marketing_guest_segment_id`)
) COMMENT 'Master record for marketing-defined guest segments used to target campaigns and promotions. Captures segment name, segment type (behavioral/demographic/psychographic/occasion-based/value-tier), definition criteria (visit frequency, ACV, daypart preference, channel preference, cuisine affinity), segment size estimate, data source (CRM/loyalty/POS), creation date, and active status. Distinct from loyalty tiers — these are marketing targeting constructs used for campaign audience selection and personalization.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` (
    `local_store_marketing_id` BIGINT COMMENT 'System-generated unique identifier for each local store marketing initiative.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: LSM initiatives are tied to a campaign; description duplicates campaign description.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant or franchise group sponsoring the initiative.',
    `local_unit_id` BIGINT COMMENT 'Identifier of the restaurant or franchise group sponsoring the initiative.',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Needed for Local Store Marketing Materials Procurement process to track which supplier provides promotional assets for each initiative.',
    `actual_adt_lift_percent` DECIMAL(18,2) COMMENT 'Measured increase in Average Daily Transactions after execution.',
    `actual_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'Measured lift in comparable store sales after the initiative.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Total amount actually spent on the initiative.',
    `approval_date` DATE COMMENT 'Date when the initiative received approval.',
    `approval_status` STRING COMMENT 'Current approval state of the initiative.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name of the person or role that approved the initiative.',
    `channel` STRING COMMENT 'Primary media channel used for the initiative.. Valid values are `digital|social|traditional|outdoor|radio`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the initiative complies with local marketing fund rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for spend amounts.. Valid values are `USD|CAD|EUR`',
    `end_date` DATE COMMENT 'Date the initiative is scheduled to conclude.',
    `execution_end_date` DATE COMMENT 'Actual date when execution of the initiative ended.',
    `execution_start_date` DATE COMMENT 'Actual date when execution of the initiative started.',
    `expected_adt_lift_percent` DECIMAL(18,2) COMMENT 'Projected increase in Average Daily Transactions expressed as a percentage.',
    `expected_comp_sales_lift_percent` DECIMAL(18,2) COMMENT 'Projected lift in comparable store sales expressed as a percentage.',
    `initiative_code` STRING COMMENT 'Business identifier or code used to reference the initiative across systems.',
    `initiative_name` STRING COMMENT 'Human‑readable name of the marketing initiative.',
    `initiative_type` STRING COMMENT 'Category of the local marketing initiative.. Valid values are `community_event|local_sponsorship|school_partnership|sports_tie_in|neighborhood_flyer`',
    `lmf_fund_amount` DECIMAL(18,2) COMMENT 'Total amount allocated to the restaurant from the Local Marketing Fund for this initiative.',
    `lmf_fund_used` DECIMAL(18,2) COMMENT 'Portion of the allocated fund that has been spent.',
    `lmf_remaining_amount` DECIMAL(18,2) COMMENT 'Remaining balance of the allocated fund after spending.',
    `local_store_marketing_status` STRING COMMENT 'Current lifecycle status of the initiative.. Valid values are `planned|active|completed|cancelled|on_hold`',
    `market_dma` STRING COMMENT 'Geographic market or DMA where the initiative is targeted.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the initiative.',
    `planned_spend` DECIMAL(18,2) COMMENT 'Budgeted amount allocated for the initiative before execution.',
    `start_date` DATE COMMENT 'Date the initiative is scheduled to begin.',
    `target_audience` STRING COMMENT 'Description of the guest segment the initiative aims to reach.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_local_store_marketing PRIMARY KEY(`local_store_marketing_id`)
) COMMENT 'Master record for Local Store Marketing (LSM) initiatives executed at the individual restaurant or market level — distinct from national/regional campaigns. Captures LSM initiative name, sponsoring restaurant(s) or franchise group, initiative type (community event, local sponsorship, school partnership, sports team tie-in, neighborhood flyer, grand opening, catering push), planned spend, actual spend, execution dates, market/DMA code, target radius, estimated impressions, measured traffic lift, Local Marketing Fund (LMF) draw-down reference, and approval status from franchisor or co-op board. Enables franchisee-level marketing activity tracking, LMF compliance, and local initiative ROI measurement.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`fund` (
    `fund_id` BIGINT COMMENT 'Unique identifier for the marketing fund record.',
    `legal_entity_id` BIGINT COMMENT 'add column legal_entity_id (BIGINT) with FK to finance.legal_entity.legal_entity_id - marketing funds are isolated with no FKs; they must belong to a legal entity for financial accountability',
    `balance_amount` DECIMAL(18,2) COMMENT 'Current remaining balance of the fund.',
    `fund_code` STRING COMMENT 'External code or number identifying the marketing fund.',
    `compliance_status` STRING COMMENT 'Current compliance status of the fund with regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `contribution_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of gross sales contributed to the fund.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fund record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `fund_description` STRING COMMENT 'Narrative description of the fund purpose and scope.',
    `effective_end_date` DATE COMMENT 'Date when the fund ends or is terminated, if applicable.',
    `effective_start_date` DATE COMMENT 'Date when the fund becomes effective.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the fund data pertains.',
    `fund_status` STRING COMMENT 'Current lifecycle status of the fund.. Valid values are `active|inactive|suspended|closed|pending`',
    `fund_type` STRING COMMENT 'Category of the fund based on its scope.. Valid values are `national|regional|local`',
    `governing_body` STRING COMMENT 'Entity responsible for overseeing the fund.. Valid values are `franchisor|co_op_board`',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether fund contributions are subject to tax.',
    `fund_name` STRING COMMENT 'Descriptive name of the marketing fund.',
    `notes` STRING COMMENT 'Free-form field for any supplemental information about the fund.',
    `reporting_requirements` STRING COMMENT 'Text describing mandatory reporting obligations for the fund.',
    `total_contributions_amount` DECIMAL(18,2) COMMENT 'Total monetary contributions collected for the fund in the fiscal period.',
    `total_spend_authorized_amount` DECIMAL(18,2) COMMENT 'Total amount authorized for spending from the fund.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fund record.',
    CONSTRAINT pk_fund PRIMARY KEY(`fund_id`)
) COMMENT 'Master record for marketing fund accounts — including National Advertising Fund (NAF), Regional Marketing Co-ops, and Local Marketing Funds (LMF) — with full contribution transaction history. Fund-level attributes: fund name, fund type (national/regional/local), contribution rate (% of gross sales), total contributions collected in period, total spend authorized, fund balance, governing body (franchisor/co-op board), and fiscal year. Contribution transaction detail: contributing restaurant unit, contribution period (week/month), gross sales basis, contribution rate applied, contribution amount, payment date, payment method, and reconciliation status. SSOT for marketing fund financial governance, franchisee contribution compliance monitoring, co-op spend authorization, fund balance tracking, and contribution audit trail.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` (
    `fund_contribution_id` BIGINT COMMENT 'System-generated unique identifier for each marketing fund contribution record.',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Enables attribution of fund contributions to the contributing franchisee, essential for fund balance reporting and franchisee-level financial statements.',
    `fund_id` BIGINT COMMENT 'Identifier of the marketing fund to which the contribution is applied.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant unit (company‑owned or franchised) that made the contribution.',
    `fund_unit_id` BIGINT COMMENT 'Identifier of the restaurant unit (company‑owned or franchised) that made the contribution.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the contribution was approved.',
    `approved_by` STRING COMMENT 'Identifier of the employee who approved the contribution.',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Monetary amount contributed to the marketing fund for the period.',
    `contribution_number` STRING COMMENT 'External reference number assigned to the contribution for tracking and audit purposes.',
    `contribution_period_type` STRING COMMENT 'Granularity of the contribution period (e.g., week, month).. Valid values are `week|month|quarter|year`',
    `contribution_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to the gross sales to determine the contribution amount (e.g., 0.0250 = 2.5%).',
    `contribution_timestamp` TIMESTAMP COMMENT 'Date and time when the contribution was generated based on sales data.',
    `contribution_type` STRING COMMENT 'Classification of the contribution based on fund scope or program.. Valid values are `co_op|local|national|regional`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the contribution amount (e.g., USD).',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'Total sales amount (pre‑deductions) used as the basis for calculating the contribution.',
    `lifecycle_status` STRING COMMENT 'Current processing state of the contribution record.. Valid values are `draft|pending|approved|reconciled|rejected|cancelled`',
    `notes` STRING COMMENT 'Free‑form text for any additional comments or exceptions related to the contribution.',
    `payment_date` DATE COMMENT 'Date on which the contribution amount was paid to the fund.',
    `period_end_date` DATE COMMENT 'Last calendar date of the contribution period.',
    `period_start_date` DATE COMMENT 'First calendar date of the contribution period (week or month).',
    `reconciliation_status` STRING COMMENT 'Current status of the contributions financial reconciliation.. Valid values are `pending|reconciled|exception|adjusted`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contribution record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contribution record.',
    CONSTRAINT pk_fund_contribution PRIMARY KEY(`fund_contribution_id`)
) COMMENT 'Transactional record capturing each contribution made to a marketing fund by a restaurant unit (company-owned or franchised). Captures contributing restaurant, fund, contribution period (week/month), gross sales basis, contribution rate applied, contribution amount, payment date, and reconciliation status. Enables fund balance tracking, franchisee contribution compliance monitoring, and co-op spend authorization.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` (
    `digital_campaign_performance_id` BIGINT COMMENT 'Unique surrogate identifier for each digital campaign performance record.',
    `ad_creative_id` BIGINT COMMENT 'Identifier of the specific creative asset (image, video, etc.) used in the ad.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign to which this performance record belongs.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Actual spend incurred to date for the campaign.',
    `ad_format` STRING COMMENT 'Creative format type used in the ad.. Valid values are `video|image|carousel|story`',
    `ad_group_code` BIGINT COMMENT 'Identifier of the ad group within the campaign.',
    `ad_group_name` STRING COMMENT 'Human‑readable name of the ad group.',
    `attribution_model` STRING COMMENT 'Method used to assign credit to ad interactions.. Valid values are `last_click|first_click|linear|time_decay|position_based`',
    `audience_segment` STRING COMMENT 'Targeted guest segment (e.g., families, millennials, high‑spenders).',
    `bidding_strategy` STRING COMMENT 'Algorithmic bidding model applied to the campaign.. Valid values are `cpc|cpm|cpv|cpa`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Allocated budget for the campaign period.',
    `campaign_end_date` DATE COMMENT 'Planned end date of the marketing campaign.',
    `campaign_goal` STRING COMMENT 'Primary business objective the campaign is intended to achieve.. Valid values are `app_download|order|coupon_claim|brand_awareness|store_visit|lead`',
    `campaign_start_date` DATE COMMENT 'Planned start date of the marketing campaign.',
    `channel` STRING COMMENT 'Digital advertising channel or network delivering the impressions (e.g., Meta, Google, TikTok, programmatic DSPs).. Valid values are `meta|google|tiktok|programmatic|snapchat|twitter`',
    `click_through_rate` DECIMAL(18,2) COMMENT 'Percentage of impressions that resulted in clicks (CTR = clicks / impressions * 100).',
    `clicks` BIGINT COMMENT 'Number of user clicks on the ad.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Percentage of clicks that resulted in a conversion.',
    `conversions` BIGINT COMMENT 'Number of desired actions (app downloads, OLO orders, coupon claims) attributed to the ad.',
    `cost_per_acquisition` DECIMAL(18,2) COMMENT 'Average cost to acquire a conversion (spend divided by conversions).',
    `cost_per_click` DECIMAL(18,2) COMMENT 'Average cost incurred for each click (spend divided by clicks).',
    `cost_per_mille` DECIMAL(18,2) COMMENT 'Average cost per one thousand impressions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for spend values.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `daypart` STRING COMMENT 'Time‑of‑day segment targeted by the campaign.. Valid values are `breakfast|lunch|dinner|late_night`',
    `device_type` STRING COMMENT 'Device category on which the ad was served.. Valid values are `mobile|desktop|tablet`',
    `digital_campaign_performance_status` STRING COMMENT 'Current lifecycle status of the performance record.. Valid values are `active|paused|completed|cancelled`',
    `estimated_reach` BIGINT COMMENT 'Projected number of unique users who could see the ad.',
    `event_date` DATE COMMENT 'Calendar date on which the performance metrics were recorded.',
    `frequency_average` DECIMAL(18,2) COMMENT 'Average number of times each user was exposed to the ad.',
    `geographic_region` STRING COMMENT 'Three‑letter country code representing the primary market for the ad.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `impressions` BIGINT COMMENT 'Number of times the ad was displayed to users.',
    `is_lto` BOOLEAN COMMENT 'Indicates whether the campaign is tied to a limited‑time offer.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the performance record.',
    `platform` STRING COMMENT 'Higher‑level platform grouping (e.g., social, search, display).',
    `revenue_attributed` DECIMAL(18,2) COMMENT 'Revenue directly linked to conversions from the campaign.',
    `roi_percent` DECIMAL(18,2) COMMENT 'ROI expressed as a percentage ((revenue - spend) / spend * 100).',
    `spend` DECIMAL(18,2) COMMENT 'Total monetary amount spent on the campaign for the reporting period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the performance record.',
    `video_views` BIGINT COMMENT 'Number of times a video ad was viewed.',
    `view_through_rate` DECIMAL(18,2) COMMENT 'Percentage of impressions that resulted in a view of the video ad.',
    CONSTRAINT pk_digital_campaign_performance PRIMARY KEY(`digital_campaign_performance_id`)
) COMMENT 'Transactional record capturing daily or weekly digital and social channel performance metrics for active campaigns. Captures impressions served, clicks, click-through rate (CTR), video views, view-through rate (VTR), cost per click (CPC), cost per thousand impressions (CPM), conversions (app downloads, OLO orders, coupon claims), conversion rate, total spend by channel and creative, platform-specific metrics (Meta reach, Google Quality Score, TikTok completion rate), and A/B test variant performance. Sourced from digital ad platform APIs (Meta Ads Manager, Google Ads, TikTok Ads, programmatic DSPs). Enables real-time digital media optimization, creative performance comparison, and digital ROI measurement feeding into campaign_roi.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` (
    `campaign_spend_id` BIGINT COMMENT 'Unique system-generated identifier for each campaign spend record.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign to which this spend belongs.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor or agency providing the service or media.',
    `campaign_vendor_procurement_supplier_id` BIGINT COMMENT 'Identifier of the vendor or agency providing the service or media.',
    `approval_status` STRING COMMENT 'Current approval state of the spend.. Valid values are `approved|rejected|pending`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the spend.',
    `budget_line_item_code` STRING COMMENT 'Code of the budget line item to which this spend is allocated.',
    `campaign_phase` STRING COMMENT 'Lifecycle phase of the campaign to which the spend belongs.. Valid values are `planning|execution|post`',
    `campaign_spend_status` STRING COMMENT 'Current processing status of the spend record.. Valid values are `pending|posted|cancelled|adjusted`',
    `channel` STRING COMMENT 'Primary media channel through which the spend was executed.. Valid values are `digital|social|traditional|in_store|ooh`',
    `cost_center_code` STRING COMMENT 'Internal cost center to which the spend is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the spend record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the spend amount.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the spend before net calculation.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (Q1‑Q4) for financial reporting.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the spend is recorded.',
    `invoice_date` DATE COMMENT 'Date on the vendor invoice.',
    `invoice_number` STRING COMMENT 'Reference number of the vendor invoice linked to the spend.',
    `is_estimated` BOOLEAN COMMENT 'Indicates whether the spend amount is an estimate (true) or actual (false).',
    `is_recurring` BOOLEAN COMMENT 'True if the spend is part of a recurring contract or schedule.',
    `media_type` STRING COMMENT 'Specific media format or vehicle used for the spend.. Valid values are `TV|radio|online|print|outdoor|other`',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net amount after tax and discount adjustments.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the spend.',
    `payment_date` DATE COMMENT 'Date on which payment was made to the vendor.',
    `payment_method` STRING COMMENT 'Method used to settle the invoice.. Valid values are `credit_card|bank_transfer|cash|check|other`',
    `payment_status` STRING COMMENT 'Status of payment against the vendor invoice.. Valid values are `paid|unpaid|partial`',
    `spend_amount` DECIMAL(18,2) COMMENT 'Total gross amount of the spend before taxes, discounts, or adjustments.',
    `spend_category` STRING COMMENT 'Classification of spend type for budgeting and reporting.. Valid values are `media|production|agency_fees|in_store_materials|other`',
    `spend_description` STRING COMMENT 'Free‑text description providing context for the spend.',
    `spend_reference` STRING COMMENT 'External reference code or number assigned to the spend entry by the finance system.',
    `spend_timestamp` TIMESTAMP COMMENT 'Date and time when the spend was incurred or recorded.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the spend.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate percentage used to calculate tax_amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the spend record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between actual spend and planned budget amount (positive if over, negative if under).',
    `variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance between actual spend and budget.',
    `vendor_name` STRING COMMENT 'Legal name of the vendor or agency associated with the spend.',
    CONSTRAINT pk_campaign_spend PRIMARY KEY(`campaign_spend_id`)
) COMMENT 'Transactional record tracking actual marketing spend against a campaign, broken down by channel, vendor/agency, and time period. Captures campaign reference, spend category (media/production/agency fees/in-store materials), vendor/agency name, invoice reference, spend amount, currency, spend date, budget line item, and variance to plan. Enables campaign budget management, spend pacing, and ROI calculation. Distinct from media_buy (which is placement-level) — this is the financial spend ledger for the campaign.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`coupon` (
    `coupon_id` BIGINT COMMENT 'Unique identifier for the coupon record.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that issued the coupon.',
    `menu_item_id` BIGINT COMMENT 'Foreign key linking to menu.menu_item. Business justification: Required for Coupon Management: link item‑specific coupons to the menu item they discount, enabling redemption tracking, inventory impact analysis, and compliance reporting.',
    `channel_restriction` STRING COMMENT 'Sales channel(s) where the coupon is valid.. Valid values are `POS|OLO|3PD|APP`',
    `coupon_code` STRING COMMENT 'Human‑readable code assigned to the coupon for issuance and redemption tracking.',
    `coupon_status` STRING COMMENT 'Current lifecycle state of the coupon.. Valid values are `active|expired|revoked|pending|cancelled`',
    `coupon_type` STRING COMMENT 'Classification of the coupon indicating its usage rules.. Valid values are `single_use|multi_use|loyalty_exclusive|app_only|printed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the coupon record was first created in the system.',
    `coupon_description` STRING COMMENT 'Full marketing description and terms of the coupon.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount when discount_type is fixed_amount.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage value of the discount when discount_type is percentage.',
    `discount_type` STRING COMMENT 'Mechanism by which the coupon provides a discount.. Valid values are `percentage|fixed_amount|free_item`',
    `eligible_item_category` STRING COMMENT 'Menu category or SKU that the coupon can be applied to.',
    `expiry_date` DATE COMMENT 'Date after which the coupon can no longer be redeemed.',
    `fraud_prevention_flag` BOOLEAN COMMENT 'Flag indicating whether the coupon is subject to fraud monitoring.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the coupon excludes the use of other promotions.',
    `is_stackable` BOOLEAN COMMENT 'Indicates whether the coupon can be used together with other promotions.',
    `issue_date` DATE COMMENT 'Date the coupon was generated and made available.',
    `max_redemptions` STRING COMMENT 'Total number of times the coupon may be redeemed across all customers.',
    `coupon_name` STRING COMMENT 'Descriptive name of the coupon used in marketing materials.',
    `notes` STRING COMMENT 'Free‑form field for internal remarks about the coupon.',
    `per_customer_limit` STRING COMMENT 'Maximum number of redemptions allowed per individual guest.',
    `redemption_count` STRING COMMENT 'Number of times the coupon has already been redeemed.',
    `redemption_window_end` DATE COMMENT 'End date of the period during which the coupon may be redeemed.',
    `redemption_window_start` DATE COMMENT 'Start date of the period during which the coupon may be redeemed.',
    `store_scope` STRING COMMENT 'Geographic or store‑level scope where the coupon is valid.. Valid values are `all|selected|specific`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the coupon record.',
    `usage_limit_type` STRING COMMENT 'Specifies whether the coupon has a usage limit.. Valid values are `unlimited|limited`',
    CONSTRAINT pk_coupon PRIMARY KEY(`coupon_id`)
) COMMENT 'Master record for physical and digital coupons issued as part of marketing campaigns or standalone promotional activity. Captures coupon code, coupon type (single-use/multi-use/loyalty-exclusive/app-only/printed), face value or discount type, eligible menu items or categories, channel restrictions (POS/OLO/3PD/app), issue date, expiry date, maximum redemption count, and fraud prevention flags. Distinct from promotion (which defines the offer mechanic) — coupon is the specific issued instrument.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`influencer` (
    `influencer_id` BIGINT COMMENT 'System-generated unique identifier for the influencer record.',
    `campaign_id` BIGINT COMMENT 'add column campaign_id (BIGINT) with FK to marketing.campaign.campaign_id - influencer table only connects via influencer_activation; needs direct campaign association for master data integrity',
    `average_comments_per_post` BIGINT COMMENT 'Mean number of comments per post across recent campaigns.',
    `average_likes_per_post` BIGINT COMMENT 'Mean number of likes per post across recent campaigns.',
    `average_views_per_post` BIGINT COMMENT 'Mean number of video or image views per post across recent campaigns.',
    `brand_safety_rating` STRING COMMENT 'Internal rating (1‑5) of the influencers brand safety risk.',
    `campaigns_participated_count` STRING COMMENT 'Total number of marketing campaigns the influencer has been involved with.',
    `content_category` STRING COMMENT 'Primary content theme of the influencer.. Valid values are `food|lifestyle|family|gaming|travel|fitness`',
    `contract_end_date` DATE COMMENT 'Effective end date of the influencer contract; null if open‑ended.',
    `contract_start_date` DATE COMMENT 'Effective start date of the influencer contract.',
    `contracted_fee` DECIMAL(18,2) COMMENT 'Total fee agreed for the influencers participation in a campaign.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the influencer record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the contracted fee.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `email` STRING COMMENT 'Primary email address for communication and invoicing.',
    `engagement_rate` DECIMAL(18,2) COMMENT 'Average engagement rate (likes+comments)/followers expressed as a percentage.',
    `exclusivity_terms` STRING COMMENT 'Text describing any exclusivity or non-compete conditions.',
    `follower_count` BIGINT COMMENT 'Total number of followers/subscribers on the primary platform at the time of record capture.',
    `full_name` STRING COMMENT 'Legal full name of the influencer as used in contracts and payments.',
    `influencer_status` STRING COMMENT 'Current lifecycle status of the influencer record.. Valid values are `active|inactive|suspended|pending`',
    `is_exclusive` BOOLEAN COMMENT 'True if the influencer is under an exclusivity agreement for the brand.',
    `last_campaign_date` DATE COMMENT 'Date of the most recent campaign the influencer participated in.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the influencer.',
    `payment_terms` STRING COMMENT 'Text describing payment schedule and method (e.g., net‑30, upfront).',
    `phone_number` STRING COMMENT 'Primary telephone number for the influencer.',
    `platform_handle` STRING COMMENT 'Username or handle of the influencer on the primary platform.',
    `platform_url` STRING COMMENT 'Direct URL to the influencers profile on the primary platform.',
    `primary_platform` STRING COMMENT 'Main social media platform where the influencer creates content.. Valid values are `instagram|tiktok|youtube|x|facebook|snapchat`',
    `region` STRING COMMENT 'Primary geographic region where the influencers audience is located. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|JPN|CHN|IND — promote to reference product]',
    `tier` STRING COMMENT 'Tier classification based on audience size and impact.. Valid values are `nano|micro|macro|mega`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the influencer record.',
    `verified_status` BOOLEAN COMMENT 'Indicates whether the influencers account is verified on the platform.',
    CONSTRAINT pk_influencer PRIMARY KEY(`influencer_id`)
) COMMENT 'Master record for social media influencers and brand ambassadors engaged by Restaurants, including full activation/engagement history. Influencer profile: name, platform(s) (Instagram, TikTok, YouTube, X), follower count by platform, engagement rate, content category (food/lifestyle/family/gaming), tier (nano/micro/macro/mega), contracted fee, exclusivity terms, brand safety rating, and active status. Activation detail: activation type (sponsored post/story/reel/video/event appearance), campaign reference, contracted deliverables, content go-live dates, platform, actual impressions delivered, engagement metrics (likes/comments/shares), earned media value (EMV), payment amount, and FTC disclosure compliance status. SSOT for influencer program management, contract fulfillment tracking, and creator-led marketing ROI measurement.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` (
    `influencer_activation_id` BIGINT COMMENT 'System‑generated unique identifier for each influencer activation record.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign to which this activation belongs.',
    `influencer_id` BIGINT COMMENT 'Unique identifier of the influencer participating in the activation.',
    `activation_number` STRING COMMENT 'Human‑readable identifier assigned to the activation for tracking and reconciliation.',
    `activation_timestamp` TIMESTAMP COMMENT 'Date‑time when the activation was executed or went live.',
    `activation_type` STRING COMMENT 'Category of influencer deliverable (e.g., sponsored post, story, reel, video, event appearance).. Valid values are `sponsored_post|story|reel|video|event_appearance`',
    `actual_comments` BIGINT COMMENT 'Number of comment interactions on the influencer content.',
    `actual_impressions` BIGINT COMMENT 'Number of times the influencer content was displayed to users.',
    `actual_likes` BIGINT COMMENT 'Count of like interactions on the influencer content.',
    `actual_shares` BIGINT COMMENT 'Number of times the influencer content was shared or retweeted.',
    `compliance_status` STRING COMMENT 'Current compliance verification state of the activation.. Valid values are `compliant|non_compliant|pending_review`',
    `content_go_live_date` DATE COMMENT 'Planned or actual date when the influencer content was published.',
    `contract_end_date` DATE COMMENT 'Date when the influencer contract expires or is terminated.',
    `contract_start_date` DATE COMMENT 'Date when the influencer contract became effective.',
    `contract_terms` STRING COMMENT 'Key payment and deliverable terms defined in the influencer agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the activation record was first created in the system.',
    `deliverables` STRING COMMENT 'Description of the content or service the influencer agreed to provide.',
    `earned_media_value` DECIMAL(18,2) COMMENT 'Estimated monetary value of the organic reach generated by the influencer activation.',
    `ftc_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the influencer included the required FTC disclosure on the content.',
    `influencer_activation_status` STRING COMMENT 'Current lifecycle state of the influencer activation.. Valid values are `pending|active|completed|cancelled|draft`',
    `influencer_category` STRING COMMENT 'Segment classification based on audience size and relationship type.. Valid values are `macro|micro|nano|celebrity|brand_ambassador|employee`',
    `influencer_engagement_rate` DECIMAL(18,2) COMMENT 'Average engagement rate (percentage) of the influencers audience.',
    `influencer_follower_count` BIGINT COMMENT 'Number of followers the influencer had at the time of contract signing.',
    `influencer_handle` STRING COMMENT 'Username or handle of the influencer on the platform.',
    `influencer_region` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code representing the influencers primary market.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the activation.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Compensation paid to the influencer for the activation.',
    `payment_currency` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for influencer payment.',
    `platform` STRING COMMENT 'Social platform where the influencer content was posted.. Valid values are `instagram|tiktok|youtube|facebook|twitter|snapchat`',
    `total_engagement` BIGINT COMMENT 'Aggregate of likes, comments, and shares for the activation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the activation record.',
    CONSTRAINT pk_influencer_activation PRIMARY KEY(`influencer_activation_id`)
) COMMENT 'Transactional record for each influencer engagement or activation tied to a campaign. Captures influencer reference, campaign reference, activation type (sponsored post/story/reel/video/event appearance), contracted deliverables, content go-live date, platform, actual impressions delivered, engagement (likes/comments/shares), earned media value (EMV), payment amount, and compliance status (FTC disclosure). Enables influencer ROI measurement and contract fulfillment tracking.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` (
    `campaign_roi_id` BIGINT COMMENT 'Unique surrogate key for each campaign ROI record.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign to which this ROI measurement belongs.',
    `unit_id` BIGINT COMMENT 'add column restaurant_unit_id (BIGINT) with FK to restaurant.unit.unit_id - ROI should be measurable at unit level for local store marketing effectiveness',
    `attribution_methodology` STRING COMMENT 'Method used to attribute incremental revenue to the campaign.. Valid values are `matched_market|mmm|last_touch|first_touch|custom`',
    `campaign_roi_status` STRING COMMENT 'Current lifecycle status of the ROI measurement.. Valid values are `calculated|validated|rejected`',
    `channel` STRING COMMENT 'Primary media channel or delivery platform used for the campaign (e.g., digital, social, TV, radio).',
    `cogs_impact_amount` DECIMAL(18,2) COMMENT 'Additional cost of goods sold directly attributable to the campaign.',
    `confidence_level` STRING COMMENT 'Statistical confidence in the ROI measurement (high, medium, low).. Valid values are `high|medium|low`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `incremental_revenue` DECIMAL(18,2) COMMENT 'Additional revenue attributed to the campaign during the measurement period.',
    `incremental_transactions` STRING COMMENT 'Count of additional average daily transactions generated by the campaign.',
    `is_test_roi` BOOLEAN COMMENT 'Indicates whether the ROI record was generated from a test or pilot campaign.',
    `market_dma` STRING COMMENT 'Geographic market area (DMA) where the campaign was executed.',
    `measurement_period_end` DATE COMMENT 'Last date of the period over which ROI is measured.',
    `measurement_period_start` DATE COMMENT 'First date of the period over which ROI is measured.',
    `measurement_source` STRING COMMENT 'Origin of the data used for ROI calculation.. Valid values are `internal|external|third_party`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Exact point in time when the ROI measurement was recorded.',
    `net_incremental_profit` DECIMAL(18,2) COMMENT 'Incremental profit after subtracting COGS and other direct costs from incremental revenue.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the ROI measurement.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the ROI record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ROI record.',
    `roi_code` STRING COMMENT 'Human‑readable code assigned to the ROI record for tracking and reporting.',
    `roi_percent` DECIMAL(18,2) COMMENT 'ROI expressed as a percentage: (Net Incremental Profit / Total Spend) * 100.',
    `spend_amount` DECIMAL(18,2) COMMENT 'Total amount of money spent on the campaign across all channels.',
    `version_number` STRING COMMENT 'Version of the ROI record for audit and change tracking.',
    CONSTRAINT pk_campaign_roi PRIMARY KEY(`campaign_roi_id`)
) COMMENT 'Transactional record capturing the return on investment (ROI) and comparable store sales (comp sales / SSS) lift measurement for a completed campaign, calculated at the campaign, channel, or market level. Captures total campaign spend, incremental revenue attributed, incremental transactions (ADT lift), ACV change, comp sales lift percentage, COGS impact, net incremental profit, ROI percentage, measurement period, baseline sales (pre-campaign), actual sales during campaign, attribution methodology (matched market/MMM/last-touch/test-vs-control), and confidence level. SSOT for post-campaign financial performance evaluation, comp sales attribution, and future budget allocation decisions.';

CREATE OR REPLACE TABLE `vibe_restaurants_v1`.`marketing`.`content_template` (
    `content_template_id` BIGINT COMMENT 'Primary key for content_template',
    `base_content_template_id` BIGINT COMMENT 'Self-referencing FK on content_template (base_content_template_id)',
    `approval_status` STRING COMMENT 'Approval workflow status for the template.',
    `audience_segment` STRING COMMENT 'Target audience segment identifier for which the template is designed.',
    `channel` STRING COMMENT 'Primary channel(s) where the template is deployed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the template record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date after which the template is no longer valid (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the template becomes valid for use.',
    `format` STRING COMMENT 'File or rendering format of the template.',
    `gdpr_compliant` BOOLEAN COMMENT 'Flag indicating whether the template complies with GDPR requirements.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this template is the default for its type/segment.',
    `language` STRING COMMENT 'ISO 639‑1 language code of the template content.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent campaign that used this template.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the template.',
    `content_template_status` STRING COMMENT 'Current lifecycle status of the template.',
    `template_code` STRING COMMENT 'Business identifier/code used to reference the template in marketing systems.',
    `template_name` STRING COMMENT 'Human‑readable name of the content template.',
    `template_type` STRING COMMENT 'Category of the template indicating its marketing purpose.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the template record.',
    `usage_count` BIGINT COMMENT 'Cumulative count of times the template has been used in campaigns.',
    `version_number` STRING COMMENT 'Sequential version number of the template.',
    CONSTRAINT pk_content_template PRIMARY KEY(`content_template_id`)
) COMMENT 'Master reference table for content_template. Referenced by content_template_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_lto` ADD CONSTRAINT `fk_marketing_marketing_lto_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ADD CONSTRAINT `fk_marketing_media_buy_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ADD CONSTRAINT `fk_marketing_media_buy_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ADD CONSTRAINT `fk_marketing_media_buy_media_channel_id` FOREIGN KEY (`media_channel_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`media_channel`(`media_channel_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ADD CONSTRAINT `fk_marketing_media_buy_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ADD CONSTRAINT `fk_marketing_media_channel_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ADD CONSTRAINT `fk_marketing_ad_creative_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment` ADD CONSTRAINT `fk_marketing_marketing_guest_segment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ADD CONSTRAINT `fk_marketing_local_store_marketing_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ADD CONSTRAINT `fk_marketing_fund_contribution_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`fund`(`fund_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ADD CONSTRAINT `fk_marketing_digital_campaign_performance_ad_creative_id` FOREIGN KEY (`ad_creative_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`ad_creative`(`ad_creative_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ADD CONSTRAINT `fk_marketing_digital_campaign_performance_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ADD CONSTRAINT `fk_marketing_campaign_spend_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ADD CONSTRAINT `fk_marketing_coupon_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ADD CONSTRAINT `fk_marketing_influencer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ADD CONSTRAINT `fk_marketing_influencer_activation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ADD CONSTRAINT `fk_marketing_influencer_activation_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ADD CONSTRAINT `fk_marketing_campaign_roi_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ADD CONSTRAINT `fk_marketing_content_template_base_content_template_id` FOREIGN KEY (`base_content_template_id`) REFERENCES `vibe_restaurants_v1`.`marketing`.`content_template`(`content_template_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_restaurants_v1`.`marketing` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_restaurants_v1`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `food_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Food Recall Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Guest Segment');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `supply_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `trade_area_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `actual_adt_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual ADT Lift Percentage');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `actual_comp_sales_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual Comparable Store Sales Lift Percentage');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'national|local|digital|traditional|online|social');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `expected_adt_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Expected ADT Lift Percentage');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `expected_comp_sales_lift_pct` SET TAGS ('dbx_business_glossary_term' = 'Expected Comparable Store Sales Lift Percentage');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `is_lto` SET TAGS ('dbx_business_glossary_term' = 'Limited‑Time Offer Flag');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `is_test_campaign` SET TAGS ('dbx_business_glossary_term' = 'Test Campaign Flag');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `lto_end_date` SET TAGS ('dbx_business_glossary_term' = 'LTO End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `lto_start_date` SET TAGS ('dbx_business_glossary_term' = 'LTO Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `objective_metric` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective Metric');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `objective_metric` SET TAGS ('dbx_value_regex' = 'adt_lift|comp_sales_lift|brand_awareness|traffic');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `owning_brand` SET TAGS ('dbx_business_glossary_term' = 'Owning Brand');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `target_daypart` SET TAGS ('dbx_business_glossary_term' = 'Target Daypart');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `target_geography` SET TAGS ('dbx_business_glossary_term' = 'Target Geography');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `target_store_count` SET TAGS ('dbx_business_glossary_term' = 'Target Store Count');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `actual_adt_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual ADT Lift Percentage');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `actual_comp_sales_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Comparable Store Sales Lift Percentage');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Launch Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `campaign_execution_status` SET TAGS ('dbx_value_regex' = 'planned|launched|completed|cancelled|paused');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `channel_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Channel Spend Amount (Monetary Value)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks Count');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `conversions` SET TAGS ('dbx_business_glossary_term' = 'Conversions Count');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `cost_per_click` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC) Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `cost_per_impression` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Impression (CPM) Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `creative_version` SET TAGS ('dbx_business_glossary_term' = 'Creative Version Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `deviation_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Deviation from Campaign Plan');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `execution_channel` SET TAGS ('dbx_business_glossary_term' = 'Execution Channel (Digital, Social, Out-of-Home, Radio, TV, In-Store POS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `execution_channel` SET TAGS ('dbx_value_regex' = 'digital|social|ooH|radio|tv|in_store_pos');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `execution_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Execution Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `execution_owner` SET TAGS ('dbx_business_glossary_term' = 'Execution Owner (Employee or Team)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Event Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `expected_adt_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Average Daily Transactions (ADT) Lift Percentage');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `expected_comp_sales_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Comparable Store Sales Lift Percentage');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions Count');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Launch Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `market_dma` SET TAGS ('dbx_business_glossary_term' = 'Market Designated Market Area (DMA) Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `media_vendor` SET TAGS ('dbx_business_glossary_term' = 'Media Vendor Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes or Comments');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `restaurant_scope` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Scope of Campaign Execution');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `restaurant_scope` SET TAGS ('dbx_value_regex' = 'all_units|franchise_group|company_owned|selected_units');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment Percentage');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `target_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `target_segment` SET TAGS ('dbx_value_regex' = 'loyal_customers|new_customers|families|students|business|tourists');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `tracking_url` SET TAGS ('dbx_business_glossary_term' = 'Tracking URL for Campaign Metrics');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_execution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_lto` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_lto` SET TAGS ('dbx_subdomain' = 'promotional_offers');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_lto` ALTER COLUMN `marketing_lto_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for marketing_lto');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_lto` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` SET TAGS ('dbx_subdomain' = 'media_advertising');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `daypart_target` SET TAGS ('dbx_business_glossary_term' = 'Daypart Target');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `daypart_target` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night|all_day');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `digital_spend` SET TAGS ('dbx_business_glossary_term' = 'Digital Spend (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `frequency_target` SET TAGS ('dbx_business_glossary_term' = 'Frequency Target (Impressions per Person)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Lifecycle Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|pending|active|suspended|closed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `ooh_spend` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Home Spend (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Description');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Type');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'brand|regional|national|global');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `print_spend` SET TAGS ('dbx_business_glossary_term' = 'Print Spend (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `radio_spend` SET TAGS ('dbx_business_glossary_term' = 'Radio Spend (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `reach_target` SET TAGS ('dbx_business_glossary_term' = 'Reach Target (Individuals)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `social_spend` SET TAGS ('dbx_business_glossary_term' = 'Social Media Spend (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `target_dma` SET TAGS ('dbx_business_glossary_term' = 'Target DMA Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `target_dma` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `total_planned_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Spend (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `tv_spend` SET TAGS ('dbx_business_glossary_term' = 'TV Spend (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` SET TAGS ('dbx_subdomain' = 'media_advertising');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `media_buy_id` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `media_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Media Channel Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `media_vendor_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `actual_cpm` SET TAGS ('dbx_business_glossary_term' = 'Actual CPM');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `actual_grps` SET TAGS ('dbx_business_glossary_term' = 'Actual Gross Rating Points (GRPs)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `actual_impressions` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions Delivered');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `ad_format` SET TAGS ('dbx_value_regex' = 'video|image|text|audio');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `buy_number` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Number');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `buy_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `contracted_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Gross Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `contracted_grps` SET TAGS ('dbx_business_glossary_term' = 'Contracted Gross Rating Points (GRPs)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_business_glossary_term' = 'Contracted Impressions');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Rate');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `is_programmatic` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Flag');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `market_dma` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `media_buy_status` SET TAGS ('dbx_business_glossary_term' = 'Media Buy Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `media_buy_status` SET TAGS ('dbx_value_regex' = 'planned|booked|active|completed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `net_spend` SET TAGS ('dbx_business_glossary_term' = 'Net Spend (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|failed|partial');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `placement_name` SET TAGS ('dbx_business_glossary_term' = 'Placement Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `placement_size` SET TAGS ('dbx_business_glossary_term' = 'Placement Size');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `publisher_name` SET TAGS ('dbx_business_glossary_term' = 'Publisher Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|pending');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `targeting_criteria` SET TAGS ('dbx_business_glossary_term' = 'Targeting Criteria');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_buy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` SET TAGS ('dbx_subdomain' = 'media_advertising');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `media_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Media Channel ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Active Status (CAS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|paused|retired');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `average_cpm` SET TAGS ('dbx_business_glossary_term' = 'Average CPM (Cost per Mille) (AVG_CPM)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `media_channel_category` SET TAGS ('dbx_business_glossary_term' = 'Media Channel Category (MCCAT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `media_channel_category` SET TAGS ('dbx_value_regex' = 'traditional|digital|social|in_store|out_of_home');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Media Channel Code (MCC)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `channel_group` SET TAGS ('dbx_business_glossary_term' = 'Channel Group (GROUP)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `channel_owner` SET TAGS ('dbx_business_glossary_term' = 'Channel Owner (OWNER)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (COMP)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `cost_model` SET TAGS ('dbx_business_glossary_term' = 'Cost Model (CM)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `cost_model` SET TAGS ('dbx_value_regex' = 'cpm|cpc|cpa|cpl|fixed_fee');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `media_channel_description` SET TAGS ('dbx_business_glossary_term' = 'Channel Description (CDESC)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope (GEO)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'local|regional|national|global');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `is_programmatic` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Flag (PROG)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date (LAD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology (MM)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_value_regex' = 'impressions|clicks|views|conversions|reach|engagement');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `media_channel_name` SET TAGS ('dbx_business_glossary_term' = 'Media Channel Name (MCN)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform / Network (PLTF)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `primary_audience` SET TAGS ('dbx_business_glossary_term' = 'Primary Audience (PAUD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `sub_category` SET TAGS ('dbx_business_glossary_term' = 'Media Channel Sub-Category (MCSUB)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `targeting_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Targeting Capabilities (TCAP)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`media_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` SET TAGS ('dbx_subdomain' = 'media_advertising');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Advertising Creative ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `ad_creative_status` SET TAGS ('dbx_business_glossary_term' = 'Creative Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `ad_creative_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|active|retired');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `ad_format_specifications` SET TAGS ('dbx_business_glossary_term' = 'Ad Format Specifications');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `asset_url` SET TAGS ('dbx_business_glossary_term' = 'Asset URL');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `brand_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `call_to_action_text` SET TAGS ('dbx_business_glossary_term' = 'Call‑to‑Action Text');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `channel_suitability` SET TAGS ('dbx_business_glossary_term' = 'Channel Suitability');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `channel_suitability` SET TAGS ('dbx_value_regex' = 'tv|radio|digital|social|in_store|email');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `creative_category` SET TAGS ('dbx_business_glossary_term' = 'Creative Category');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `creative_category` SET TAGS ('dbx_value_regex' = 'brand|product|seasonal|promo');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `creative_code` SET TAGS ('dbx_business_glossary_term' = 'Creative Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `creative_description` SET TAGS ('dbx_business_glossary_term' = 'Creative Description');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `creative_name` SET TAGS ('dbx_business_glossary_term' = 'Creative Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `creative_owner` SET TAGS ('dbx_business_glossary_term' = 'Creative Owner');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `creative_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Creative Subcategory');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `creative_tags` SET TAGS ('dbx_business_glossary_term' = 'Creative Tags');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `creative_type` SET TAGS ('dbx_business_glossary_term' = 'Creative Type');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `creative_type` SET TAGS ('dbx_value_regex' = 'video|static|audio|copy');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `dam_reference_code` SET TAGS ('dbx_business_glossary_term' = 'DAM Reference ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `dimensions` SET TAGS ('dbx_business_glossary_term' = 'Dimensions');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Is Archived');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `is_dynamic` SET TAGS ('dbx_business_glossary_term' = 'Is Dynamic');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `legal_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `legal_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `production_cost` SET TAGS ('dbx_business_glossary_term' = 'Production Cost (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `roi_estimate` SET TAGS ('dbx_business_glossary_term' = 'ROI Estimate (%)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `tracking_pixel_url` SET TAGS ('dbx_business_glossary_term' = 'Tracking Pixel URL');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `usage_rights` SET TAGS ('dbx_value_regex' = 'internal|licensed|royalty_free');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`ad_creative` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` SET TAGS ('dbx_subdomain' = 'promotional_offers');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `item_category_id` SET TAGS ('dbx_business_glossary_term' = 'Item Category Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `supply_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_business_glossary_term' = 'Applicable Channels');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_value_regex' = 'pos|olo|3pd|app');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promotion_description` SET TAGS ('dbx_business_glossary_term' = 'Promotion Description');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `eligible_guest_segments` SET TAGS ('dbx_business_glossary_term' = 'Eligible Guest Segments');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Exclusive');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Is Stackable');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promo_category` SET TAGS ('dbx_business_glossary_term' = 'Promotion Category');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promo_category` SET TAGS ('dbx_value_regex' = 'seasonal|new_product|clearance|holiday|loyalty|event');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promo_source` SET TAGS ('dbx_business_glossary_term' = 'Promotion Source');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promo_source` SET TAGS ('dbx_value_regex' = 'internal|franchise|partner|vendor');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|draft');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'discount|bogo|bundle|coupon|loyalty|gift');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `redemption_limit_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Customer');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion` ALTER COLUMN `total_redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Limit');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` SET TAGS ('dbx_subdomain' = 'promotional_offers');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Redemption ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_member_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'POS|OLO|3PD|APP');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'amount|percent');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `is_test_redemption` SET TAGS ('dbx_business_glossary_term' = 'Test Redemption Flag');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `loyalty_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Member Flag');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `order_value_after_discount` SET TAGS ('dbx_business_glossary_term' = 'Order Value After Discount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `order_value_before_discount` SET TAGS ('dbx_business_glossary_term' = 'Order Value Before Discount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `promotion_redemption_status` SET TAGS ('dbx_value_regex' = 'redeemed|voided|pending|failed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `redemption_number` SET TAGS ('dbx_business_glossary_term' = 'Redemption Number');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`promotion_redemption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment` SET TAGS ('dbx_subdomain' = 'promotional_offers');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment` ALTER COLUMN `marketing_guest_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for marketing_guest_segment');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`marketing_guest_segment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` SET TAGS ('dbx_subdomain' = 'fund_operations');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `local_store_marketing_id` SET TAGS ('dbx_business_glossary_term' = 'Local Store Marketing Initiative ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `local_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Restaurant ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `actual_adt_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual ADT Lift (%)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `actual_comp_sales_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Comparable Store Sales Lift (%)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'digital|social|traditional|outdoor|radio');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `execution_end_date` SET TAGS ('dbx_business_glossary_term' = 'Execution End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `execution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `expected_adt_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected ADT Lift (%)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `expected_comp_sales_lift_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Comparable Store Sales Lift (%)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `initiative_code` SET TAGS ('dbx_business_glossary_term' = 'Initiative Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `initiative_name` SET TAGS ('dbx_business_glossary_term' = 'Initiative Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `initiative_type` SET TAGS ('dbx_business_glossary_term' = 'Initiative Type');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `initiative_type` SET TAGS ('dbx_value_regex' = 'community_event|local_sponsorship|school_partnership|sports_tie_in|neighborhood_flyer');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `lmf_fund_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Marketing Fund Allocated Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `lmf_fund_used` SET TAGS ('dbx_business_glossary_term' = 'Local Marketing Fund Used Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `lmf_remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Marketing Fund Remaining Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `local_store_marketing_status` SET TAGS ('dbx_business_glossary_term' = 'Initiative Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `local_store_marketing_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|on_hold');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `market_dma` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Initiative Notes');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `planned_spend` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`local_store_marketing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` SET TAGS ('dbx_subdomain' = 'fund_operations');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Fund Balance');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `contribution_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Contribution Rate (Percent)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `fund_description` SET TAGS ('dbx_business_glossary_term' = 'Fund Description');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Type');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'national|regional|local');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `governing_body` SET TAGS ('dbx_value_regex' = 'franchisor|co_op_board');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `total_contributions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Contributions Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `total_spend_authorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Authorized');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` SET TAGS ('dbx_subdomain' = 'fund_operations');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `fund_contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Contribution ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund ID (FUND_ID)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID (REST_ID)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `fund_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Unit ID (REST_ID)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVER)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Contribution Amount (AMOUNT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `contribution_number` SET TAGS ('dbx_business_glossary_term' = 'Contribution Number (CONTRIB_NO)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `contribution_period_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Period Type (PERIOD_TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `contribution_period_type` SET TAGS ('dbx_value_regex' = 'week|month|quarter|year');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Contribution Rate (RATE)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `contribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contribution Event Timestamp (EVENT_TS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Type (TYPE)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `contribution_type` SET TAGS ('dbx_value_regex' = 'co_op|local|national|regional');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Amount (GROSS_SALES)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Contribution Lifecycle Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|reconciled|rejected|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Payment Date (PAYMENT_DT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Period End Date (END_DT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Period Start Date (START_DT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status (RECON_STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|exception|adjusted');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`fund_contribution` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `digital_campaign_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Campaign Performance ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Creative ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `ad_format` SET TAGS ('dbx_value_regex' = 'video|image|carousel|story');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `ad_group_code` SET TAGS ('dbx_business_glossary_term' = 'Ad Group ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `ad_group_name` SET TAGS ('dbx_business_glossary_term' = 'Ad Group Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|time_decay|position_based');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `bidding_strategy` SET TAGS ('dbx_business_glossary_term' = 'Bidding Strategy');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `bidding_strategy` SET TAGS ('dbx_value_regex' = 'cpc|cpm|cpv|cpa');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `campaign_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `campaign_goal` SET TAGS ('dbx_business_glossary_term' = 'Campaign Goal');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `campaign_goal` SET TAGS ('dbx_value_regex' = 'app_download|order|coupon_claim|brand_awareness|store_visit|lead');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `campaign_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Advertising Channel');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'meta|google|tiktok|programmatic|snapchat|twitter');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `click_through_rate` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `conversions` SET TAGS ('dbx_business_glossary_term' = 'Conversions');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `cost_per_acquisition` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Acquisition (CPA)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `cost_per_click` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `cost_per_mille` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'breakfast|lunch|dinner|late_night');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|desktop|tablet');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `digital_campaign_performance_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Record Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `digital_campaign_performance_status` SET TAGS ('dbx_value_regex' = 'active|paused|completed|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `frequency_average` SET TAGS ('dbx_business_glossary_term' = 'Average Frequency');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `is_lto` SET TAGS ('dbx_business_glossary_term' = 'Limited‑Time Offer Flag');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Advertising Platform');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `revenue_attributed` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percent');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `spend` SET TAGS ('dbx_business_glossary_term' = 'Total Spend');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `video_views` SET TAGS ('dbx_business_glossary_term' = 'Video Views');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`digital_campaign_performance` ALTER COLUMN `view_through_rate` SET TAGS ('dbx_business_glossary_term' = 'View-Through Rate (VTR)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `campaign_spend_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Spend Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `campaign_vendor_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `budget_line_item_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Item Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `campaign_phase` SET TAGS ('dbx_business_glossary_term' = 'Campaign Phase');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `campaign_phase` SET TAGS ('dbx_value_regex' = 'planning|execution|post');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `campaign_spend_status` SET TAGS ('dbx_business_glossary_term' = 'Spend Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `campaign_spend_status` SET TAGS ('dbx_value_regex' = 'pending|posted|cancelled|adjusted');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'digital|social|traditional|in_store|ooh');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Spend');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Spend');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `media_type` SET TAGS ('dbx_value_regex' = 'TV|radio|online|print|outdoor|other');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Spend Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Spend Notes');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|cash|check|other');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount (Gross)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `spend_category` SET TAGS ('dbx_business_glossary_term' = 'Spend Category');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `spend_category` SET TAGS ('dbx_value_regex' = 'media|production|agency_fees|in_store_materials|other');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `spend_description` SET TAGS ('dbx_business_glossary_term' = 'Spend Description');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `spend_reference` SET TAGS ('dbx_business_glossary_term' = 'Spend Reference Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `spend_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Spend Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Variance Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Spend Variance Percent');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_spend` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` SET TAGS ('dbx_subdomain' = 'promotional_offers');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Marketing Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `menu_item_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Item Id (Foreign Key)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `channel_restriction` SET TAGS ('dbx_business_glossary_term' = 'Channel Restriction (POS, Online Ordering, Third‑Party Delivery, App)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `channel_restriction` SET TAGS ('dbx_value_regex' = 'POS|OLO|3PD|APP');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `coupon_status` SET TAGS ('dbx_business_glossary_term' = 'Coupon Lifecycle Status (e.g., Active, Expired, Revoked, Pending, Cancelled)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `coupon_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending|cancelled');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `coupon_type` SET TAGS ('dbx_business_glossary_term' = 'Coupon Type (e.g., Single‑Use, Multi‑Use, Loyalty‑Exclusive, App‑Only, Printed)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `coupon_type` SET TAGS ('dbx_value_regex' = 'single_use|multi_use|loyalty_exclusive|app_only|printed');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `coupon_description` SET TAGS ('dbx_business_glossary_term' = 'Coupon Description (Marketing Copy and Terms)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (Fixed Monetary Value) (USD)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage (Percent of Transaction) (PCT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type (Percentage, Fixed Amount, Free Item)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_item');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `eligible_item_category` SET TAGS ('dbx_business_glossary_term' = 'Eligible Item Category (Menu Category or SKU)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Coupon Expiry Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `fraud_prevention_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Prevention Flag (Indicates Potential Fraudulent Use)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Flag (Indicates if Coupon Excludes Other Promotions)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag (Indicates if Coupon Can Be Combined with Others)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Coupon Issue Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `max_redemptions` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Count');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `coupon_name` SET TAGS ('dbx_business_glossary_term' = 'Coupon Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes or Internal Comments');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `per_customer_limit` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Customer');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Current Redemption Count');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `redemption_window_end` SET TAGS ('dbx_business_glossary_term' = 'Redemption Window End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `redemption_window_start` SET TAGS ('dbx_business_glossary_term' = 'Redemption Window Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `store_scope` SET TAGS ('dbx_business_glossary_term' = 'Store Scope (All Stores, Selected Stores, Specific Stores)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `store_scope` SET TAGS ('dbx_value_regex' = 'all|selected|specific');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `usage_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Limit Type (Unlimited or Limited)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`coupon` ALTER COLUMN `usage_limit_type` SET TAGS ('dbx_value_regex' = 'unlimited|limited');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` SET TAGS ('dbx_subdomain' = 'media_advertising');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `average_comments_per_post` SET TAGS ('dbx_business_glossary_term' = 'Average Comments Per Post (AVG_COMMENTS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `average_likes_per_post` SET TAGS ('dbx_business_glossary_term' = 'Average Likes Per Post (AVG_LIKES)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `average_views_per_post` SET TAGS ('dbx_business_glossary_term' = 'Average Views Per Post (AVG_VIEWS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `brand_safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Rating (BSR)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `campaigns_participated_count` SET TAGS ('dbx_business_glossary_term' = 'Campaign Participation Count (CAMPAIGN_COUNT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category (CATEGORY)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `content_category` SET TAGS ('dbx_value_regex' = 'food|lifestyle|family|gaming|travel|fitness');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date (END_DT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date (START_DT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `contracted_fee` SET TAGS ('dbx_business_glossary_term' = 'Contracted Fee (FEE)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `contracted_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `contracted_fee` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Influencer Email Address (EMAIL)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `engagement_rate` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate (ENG_RATE)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `exclusivity_terms` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Terms (EXCL)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `follower_count` SET TAGS ('dbx_business_glossary_term' = 'Follower Count (FOLLOWERS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Influencer Full Name (NAME)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `influencer_status` SET TAGS ('dbx_business_glossary_term' = 'Influencer Status (STATUS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `influencer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag (EXCLUSIVE)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `last_campaign_date` SET TAGS ('dbx_business_glossary_term' = 'Last Campaign Date (LAST_CAMPAIGN_DT)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Influencer Phone Number (PHONE)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `platform_handle` SET TAGS ('dbx_business_glossary_term' = 'Platform Handle (HANDLE)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `platform_url` SET TAGS ('dbx_business_glossary_term' = 'Platform Profile URL (URL)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `primary_platform` SET TAGS ('dbx_business_glossary_term' = 'Primary Social Media Platform (PLATFORM)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `primary_platform` SET TAGS ('dbx_value_regex' = 'instagram|tiktok|youtube|x|facebook|snapchat');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (REGION)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Influencer Tier (TIER)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'nano|micro|macro|mega');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer` ALTER COLUMN `verified_status` SET TAGS ('dbx_business_glossary_term' = 'Verified Status (VERIFIED)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` SET TAGS ('dbx_subdomain' = 'media_advertising');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `influencer_activation_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Activation ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer ID');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `activation_number` SET TAGS ('dbx_business_glossary_term' = 'Activation Number');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `activation_type` SET TAGS ('dbx_business_glossary_term' = 'Activation Type');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `activation_type` SET TAGS ('dbx_value_regex' = 'sponsored_post|story|reel|video|event_appearance');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `actual_comments` SET TAGS ('dbx_business_glossary_term' = 'Actual Comments');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `actual_impressions` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `actual_likes` SET TAGS ('dbx_business_glossary_term' = 'Actual Likes');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `actual_shares` SET TAGS ('dbx_business_glossary_term' = 'Actual Shares');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `content_go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Content Go‑Live Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `contract_terms` SET TAGS ('dbx_business_glossary_term' = 'Contract Terms');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `deliverables` SET TAGS ('dbx_business_glossary_term' = 'Contracted Deliverables');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `earned_media_value` SET TAGS ('dbx_business_glossary_term' = 'Earned Media Value (EMV)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `ftc_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'FTC Disclosure Flag');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `influencer_activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `influencer_activation_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|cancelled|draft');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `influencer_category` SET TAGS ('dbx_business_glossary_term' = 'Influencer Category');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `influencer_category` SET TAGS ('dbx_value_regex' = 'macro|micro|nano|celebrity|brand_ambassador|employee');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `influencer_engagement_rate` SET TAGS ('dbx_business_glossary_term' = 'Influencer Engagement Rate');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `influencer_follower_count` SET TAGS ('dbx_business_glossary_term' = 'Influencer Follower Count');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `influencer_handle` SET TAGS ('dbx_business_glossary_term' = 'Influencer Social Handle');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `influencer_region` SET TAGS ('dbx_business_glossary_term' = 'Influencer Region');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Activation Notes');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platform');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'instagram|tiktok|youtube|facebook|twitter|snapchat');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `total_engagement` SET TAGS ('dbx_business_glossary_term' = 'Total Engagement');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`influencer_activation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` SET TAGS ('dbx_subdomain' = 'campaign_management');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `campaign_roi_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ROI Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_business_glossary_term' = 'Attribution Methodology');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_value_regex' = 'matched_market|mmm|last_touch|first_touch|custom');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `campaign_roi_status` SET TAGS ('dbx_business_glossary_term' = 'ROI Record Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `campaign_roi_status` SET TAGS ('dbx_value_regex' = 'calculated|validated|rejected');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `cogs_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'COGS Impact Amount');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `incremental_revenue` SET TAGS ('dbx_business_glossary_term' = 'Incremental Revenue');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `incremental_transactions` SET TAGS ('dbx_business_glossary_term' = 'Incremental Transactions (ADT Lift)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `is_test_roi` SET TAGS ('dbx_business_glossary_term' = 'Test ROI Flag');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `market_dma` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA)');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'internal|external|third_party');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `net_incremental_profit` SET TAGS ('dbx_business_glossary_term' = 'Net Incremental Profit');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'ROI Record Notes');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `roi_code` SET TAGS ('dbx_business_glossary_term' = 'ROI Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment Percentage');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Campaign Spend');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`campaign_roi` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` SET TAGS ('dbx_subdomain' = 'media_advertising');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `content_template_id` SET TAGS ('dbx_business_glossary_term' = 'Content Template Identifier');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `base_content_template_id` SET TAGS ('dbx_business_glossary_term' = 'Base Content Template Id');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `base_content_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Format');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'Gdpr Compliant');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `content_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_restaurants_v1`.`marketing`.`content_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
