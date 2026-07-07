-- Schema for Domain: marketing | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-27 07:48:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`marketing` COMMENT 'Owns brand management, consumer engagement campaigns, digital marketing, and market research. Manages campaign planning, media spend, creative assets, influencer partnerships, social media engagement, marketing attribution, brand health metrics, SOV (Share of Voice), SOM, consumer sentiment analysis, and Nielsen IQ panel insights.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` (
    `marketing_brand_id` BIGINT COMMENT 'Unique identifier for the brand record. Primary key for the brand master data product.',
    `parent_brand_marketing_brand_id` BIGINT COMMENT 'Reference to the parent brand in the brand hierarchy. Null for masterbrand level. Used to establish brand family relationships and roll-up reporting.',
    `product_brand_id` BIGINT COMMENT 'FK to authoritative SSOT table product.product_brand (cross-domain duplicate resolution).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Brand P&L reporting in CPG requires each brand mapped to a profit center. Finance controllers and brand managers run brand contribution margin reports using this link. Without it, brand-level profitab',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the marketing brand record',
    `annual_marketing_budget` DECIMAL(18,2) COMMENT 'Total allocated marketing investment for the brand for the fiscal year, including media spend, trade promotion, consumer promotion, and agency fees.',
    `annual_revenue_target` DECIMAL(18,2) COMMENT 'Planned annual revenue goal for the brand in the base currency. Used for budget planning, performance tracking, and brand portfolio prioritization.',
    `architecture_tier` STRING COMMENT 'Classification of the brand within the corporate brand architecture hierarchy. Masterbrand represents the corporate umbrella, subbrand is a distinct offering under the masterbrand, endorsed carries both corporate and product brand, ingredient brand is a component brand, private label is retailer-owned, and house brand is a proprietary store brand.. Valid values are `masterbrand|subbrand|endorsed|ingredient|private_label|house_brand`',
    `awareness_percent` DECIMAL(18,2) COMMENT 'Percentage of target consumers who recognize or recall the brand when prompted or unprompted. Measured through consumer surveys and market research panels.',
    `brand_category` STRING COMMENT 'Primary product category or market segment in which the brand competes. Examples include personal care, household cleaning, health and wellness, beauty, food and beverage.',
    `brand_code` STRING COMMENT 'Unique alphanumeric code assigned to the brand for operational reference across systems. Used in SKU (Stock Keeping Unit) hierarchies, trade promotion systems, and financial reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `brand_description` STRING COMMENT 'Detailed narrative describing the brands purpose, value proposition, and positioning in the market. Used for internal reference and marketing brief development.',
    `brand_name` STRING COMMENT 'The official registered name of the brand as it appears on product packaging, marketing materials, and consumer-facing communications.',
    `brand_status` STRING COMMENT 'Operational status of the brand. Active indicates current market presence with ongoing marketing investment, inactive is temporarily paused, pending launch is approved but not yet in market, under review is strategic assessment phase, sunset is planned phase-out, and archived is historical record only.. Valid values are `active|inactive|pending_launch|under_review|sunset|archived`',
    `brand_tier` STRING COMMENT 'The brand tier of the marketing brand record',
    `marketing_brand_code` STRING COMMENT 'The marketing brand code of the marketing brand record',
    `consideration_percent` DECIMAL(18,2) COMMENT 'Percentage of target consumers who would consider purchasing the brand when making a category purchase decision. Key indicator of brand relevance and competitive positioning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand record was first created in the system. Used for data lineage and audit trail purposes.',
    `currency_code` STRING COMMENT 'The currency code of the marketing brand record',
    `marketing_brand_description` STRING COMMENT 'The marketing brand description of the marketing brand record',
    `discontinuation_date` DATE COMMENT 'Date when the brand was officially discontinued or withdrawn from active marketing. Null for active brands. Used for portfolio rationalization reporting and historical analysis.',
    `effective_from` DATE COMMENT 'The effective from of the marketing brand record',
    `effective_until` DATE COMMENT 'The effective until of the marketing brand record',
    `equity_score` DECIMAL(18,2) COMMENT 'Composite metric measuring the overall strength and value of the brand based on consumer awareness, perceived quality, brand associations, and loyalty. Typically scaled 0-100 with higher scores indicating stronger brand equity.',
    `geographic_market_scope` STRING COMMENT 'Geographic reach of the brands distribution and marketing activities. Global indicates worldwide presence, regional covers multiple countries in a region, national is single-country, and local is sub-national markets.. Valid values are `global|regional|national|local`',
    `global_brand_flag` BOOLEAN COMMENT 'The global brand flag of the marketing brand record',
    `guidelines_url` STRING COMMENT 'URL or file path to the comprehensive brand guidelines document containing logo usage, color specifications, typography, tone of voice, and visual identity standards.',
    `health_index` DECIMAL(18,2) COMMENT 'The brand health index of the marketing brand record',
    `is_licensed_brand` BOOLEAN COMMENT 'Boolean flag indicating whether the brand is operated under a licensing agreement from another entity. True indicates licensed brand, false indicates owned brand.',
    `is_private_label` BOOLEAN COMMENT 'Boolean flag indicating whether the brand is a private label or store brand owned by a retail customer rather than the manufacturer. True indicates private label, false indicates manufacturer-owned brand.',
    `launch_date` DATE COMMENT 'Date when the brand was first introduced to the market. Used for brand age calculations, anniversary campaigns, and lifecycle analysis.',
    `lifecycle_stage` STRING COMMENT 'Current stage of the brand in its market lifecycle. Development indicates pre-launch planning, launch is initial market introduction, growth is rapid expansion phase, maturity is stable market presence, decline is decreasing market share, revitalization is strategic renewal effort, and discontinued indicates end of active marketing. [ENUM-REF-CANDIDATE: development|launch|growth|maturity|decline|revitalization|discontinued — 7 candidates stripped; promote to reference product]',
    `logo_asset_url` STRING COMMENT 'URL or file path to the official brand logo asset in the digital asset management system. Used for marketing materials, packaging design, and digital campaigns.',
    `market_share_pct` DECIMAL(18,2) COMMENT 'The market share pct of the marketing brand record',
    `marketing_brand_status` STRING COMMENT 'The marketing brand status of the marketing brand record',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand record was last updated. Used for change tracking and data quality monitoring.',
    `marketing_brand_name` STRING COMMENT 'The marketing brand name of the marketing brand record',
    `notes` STRING COMMENT 'The notes of the marketing brand record',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score measuring consumer willingness to recommend the brand to others. Calculated as percentage of promoters minus percentage of detractors, ranging from -100 to +100.',
    `owner` STRING COMMENT 'Legal entity or business unit that owns the intellectual property rights to the brand. May differ from the manufacturing or distribution entity.',
    `portfolio_role` STRING COMMENT 'The portfolio role of the marketing brand record',
    `positioning` STRING COMMENT 'The brand positioning of the marketing brand record',
    `positioning_statement` STRING COMMENT 'Concise statement defining the brands unique value proposition, competitive differentiation, and emotional benefit to the target consumer. Foundation for all marketing communications.',
    `preference_percent` DECIMAL(18,2) COMMENT 'Percentage of target consumers who prefer this brand over competitive alternatives. Indicates brand loyalty and pricing power potential.',
    `primary_color_hex` STRING COMMENT 'Hexadecimal color code for the primary brand color used in packaging, marketing materials, and digital assets. Ensures consistent brand identity across touchpoints.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `primary_distribution_channel` STRING COMMENT 'Main channel through which the brand reaches consumers. Examples include mass retail, specialty retail, e-commerce, DTC (Direct to Consumer), professional/salon, or foodservice.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the marketing brand record',
    `som_percent` DECIMAL(18,2) COMMENT 'Brands percentage of total category sales volume or value. Primary metric for competitive market position and growth tracking.',
    `source_system_code` STRING COMMENT 'The source system code of the marketing brand record',
    `sov_percent` DECIMAL(18,2) COMMENT 'Brands share of total advertising and promotional activity within the category, measured across paid media, earned media, and owned channels. Key indicator of marketing investment relative to competitors.',
    `subcategory` STRING COMMENT 'Specific subcategory within the broader brand category. Provides granular classification for competitive analysis and shelf placement strategy.',
    `sustainability_certification` STRING COMMENT 'Third-party sustainability certifications or eco-labels associated with the brand, such as FSC (Forest Stewardship Council), RSPO (Roundtable on Sustainable Palm Oil), or B Corp. Multiple certifications separated by semicolons.',
    `target_consumer_segment` STRING COMMENT 'Primary demographic and psychographic profile of the intended consumer audience for the brand. Includes age range, income level, lifestyle attributes, and purchase behaviors.',
    `target_segment` STRING COMMENT 'The target segment of the marketing brand record',
    `target_som_percent` DECIMAL(18,2) COMMENT 'Strategic target for the brands market share. Used for annual planning, performance evaluation, and resource allocation decisions.',
    `target_sov_percent` DECIMAL(18,2) COMMENT 'Strategic target for the brands share of voice in the category. Used for media planning and budget allocation decisions. Typically set to exceed current SOM (Share of Market) to drive growth.',
    `trademark_expiration_date` DATE COMMENT 'Date when the current trademark registration expires and requires renewal. Critical for maintaining legal protection of brand assets.',
    `trademark_jurisdiction` STRING COMMENT 'Geographic territories or countries where the brand trademark is registered and legally protected. May include multiple jurisdictions separated by semicolons.',
    `trademark_registration_date` DATE COMMENT 'Date when the trademark was officially registered with the relevant trademark authority. Used for renewal tracking and IP portfolio management.',
    `trademark_registration_number` STRING COMMENT 'Official registration number assigned by the trademark authority for the brand name, logo, or other protected brand elements. Used for legal protection and IP (Intellectual Property) management.',
    `uom` STRING COMMENT 'The uom of the marketing brand record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the marketing brand record',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Estimated financial value of the brand as an intangible asset. Calculated using income, market, or cost approaches for financial reporting and M&A (Mergers and Acquisitions) purposes.',
    CONSTRAINT pk_marketing_brand PRIMARY KEY(`marketing_brand_id`)
) COMMENT 'Master record for each brand in the Consumer Goods portfolio. Captures brand identity, positioning, architecture tier (masterbrand, subbrand, endorsed), target consumer segment, brand equity scores, SOV (Share of Voice) benchmarks, brand health KPI targets, and lifecycle stage. Serves as the SSOT for brand master data referenced across campaign, media, and trade promotion domains. [SSOT: authoritative table is product.product_brand; this table is a deprecated duplicate.] [SSOT: authoritative table is product.product_brand; this is a deprecated duplicate for concept brand.] [Non-authoritative; defers to SSOT product.product_brand for concept brand.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the marketing campaign. Primary key.',
    `agency_id` BIGINT COMMENT 'FK to marketing.agency',
    `budget_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_budget. Business justification: Campaigns draw from approved marketing budgets. Linking campaign to marketing_budget enables campaign-level budget tracking, variance analysis (planned vs. actual spend against approved budget), and f',
    `category_id` BIGINT COMMENT 'Reference to the product category this campaign targets. Links to the category hierarchy.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Campaign already has target_segment_id pointing to the cross-domain marketing.segment entity. This new FK links campaign to the marketing domains own consumer_segment master, which captures marketing-',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaign expense allocation requires charging campaign spend to a specific cost center for budgeting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Campaign costs are posted to a specific GL account to support detailed expense reporting.',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.hierarchy. Business justification: CPG campaigns are planned at product hierarchy levels (division, portfolio, category group) for portfolio-level P&L reporting and brand architecture alignment. A campaign for Premium Skincare maps t',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Campaign planning and ROI attribution need a primary SKU reference to allocate budget and measure lift per product.',
    `product_brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: CPG campaigns are executed at product brand level (e.g., Dove campaign) for brand ROI tracking and trade promotion planning. campaign.marketing_brand_id links to marketing_brand, but product_brand i',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Campaign ROI and marketing spend attribution by brand/business unit P&L requires campaigns linked to profit centers. CPG marketing finance teams report campaign spend against profit center budgets. Co',
    `segment_id` BIGINT COMMENT 'Reference to the predefined consumer segment this campaign is designed to reach. Links to consumer segmentation master data.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Campaigns are often targeted to specific key trade accounts; the marketing team needs to link each campaign to the account for promotion planning and performance reporting.',
    `actual_end_date` DATE COMMENT 'The actual date the campaign concluded. May differ from planned end date due to extensions, early termination, or performance-based adjustments.',
    `actual_media_spend_amount` DECIMAL(18,2) COMMENT 'The actual total media spend incurred for this campaign, in the companys reporting currency. Includes all paid media costs across channels.',
    `actual_production_cost_amount` DECIMAL(18,2) COMMENT 'The actual cost incurred for creative production, including all content creation, design, video production, and asset development expenses.',
    `actual_spend` DECIMAL(18,2) COMMENT 'The actual spend of the campaign record',
    `actual_start_date` DATE COMMENT 'The actual date the campaign went live and began execution. May differ from planned start date due to operational adjustments.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the campaign record',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this campaign was formally approved for execution by authorized stakeholders, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount of the campaign record',
    `campaign_status` STRING COMMENT 'Current lifecycle state of the campaign: draft (initial planning), planned (scheduled), approved (ready for execution), active (currently running), paused (temporarily suspended), completed (finished), or cancelled (terminated before completion). [ENUM-REF-CANDIDATE: draft|planned|approved|active|paused|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `campaign_type` STRING COMMENT 'Classification of the campaign by execution approach: ATL (Above The Line - mass media), BTL (Below The Line - targeted), digital (online channels), shopper (in-store/retail), influencer (social media partnerships), or integrated (multi-channel).. Valid values are `ATL|BTL|digital|shopper|influencer|integrated`',
    `channel_mix` STRING COMMENT 'Comma-separated list or description of marketing channels used in the campaign (e.g., TV, digital display, social media, print, radio, OOH, in-store).',
    `campaign_code` STRING COMMENT 'Short alphanumeric code used to identify and track the campaign across systems, media buys, and analytics platforms.',
    `country_codes` STRING COMMENT 'Comma-separated list of three-letter ISO 3166-1 alpha-3 country codes where the campaign is executed (e.g., USA,CAN,MEX).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this campaign record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `creative_concept` STRING COMMENT 'High-level description of the creative theme, messaging strategy, and visual identity used in the campaign.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this campaign record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `campaign_description` STRING COMMENT 'Detailed narrative description of the campaigns purpose, strategy, key messages, and expected outcomes.',
    `effective_from` DATE COMMENT 'The effective from of the campaign record',
    `effective_until` DATE COMMENT 'The effective until of the campaign record',
    `end_date` DATE COMMENT 'The end date of the campaign record',
    `geography_scope` STRING COMMENT 'Geographic reach of the campaign: global (worldwide), regional (multi-country region), national (single country), or local (city/metro area).. Valid values are `global|regional|national|local`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the campaign is currently active (True) or inactive (False). Active campaigns are either running or scheduled to run.',
    `kpi_target` STRING COMMENT 'The kpi target of the campaign record',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this campaign record was last updated or modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `campaign_name` STRING COMMENT 'The official name or title of the marketing campaign as used in internal planning and external communications.',
    `notes` STRING COMMENT 'The notes of the campaign record',
    `objective` STRING COMMENT 'Primary business goal of the campaign: awareness (brand visibility), consideration (product evaluation), conversion (purchase), loyalty (retention), launch (new product introduction), or relaunch (product refresh).. Valid values are `awareness|consideration|conversion|loyalty|launch|relaunch`',
    `planned_end_date` DATE COMMENT 'The originally scheduled date for campaign conclusion as defined during planning phase.',
    `planned_media_spend_amount` DECIMAL(18,2) COMMENT 'The budgeted total media spend allocated to this campaign during the planning phase, in the companys reporting currency.',
    `planned_production_cost_amount` DECIMAL(18,2) COMMENT 'The budgeted cost for creative production, including content creation, design, video production, and asset development.',
    `planned_start_date` DATE COMMENT 'The originally scheduled date for campaign launch as defined during planning phase.',
    `primary_channel` STRING COMMENT 'The primary channel of the campaign record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the campaign record',
    `roi_pct` DECIMAL(18,2) COMMENT 'The roi pct of the campaign record',
    `source_system_code` STRING COMMENT 'The unique identifier for this campaign in the source operational system, used for traceability and reconciliation.',
    `start_date` DATE COMMENT 'The start date of the campaign record',
    `target_audience` STRING COMMENT 'Textual description of the intended consumer segment for this campaign, including demographic, psychographic, and behavioral characteristics.',
    `target_reach` BIGINT COMMENT 'The target reach of the campaign record',
    `total_budget` DECIMAL(18,2) COMMENT 'The total budget of the campaign record',
    `uom` STRING COMMENT 'The uom of the campaign record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the campaign record',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for each marketing campaign executed by Consumer Goods. Captures campaign name, type (ATL, BTL, digital, shopper, influencer, integrated), objective, target audience, brand association, channel mix, planned vs. actual media spend, campaign start/end dates, creative concept, campaign status, and owning brand/category. Sourced from Salesforce Consumer Goods Cloud and internal campaign management systems.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` (
    `campaign_flight_id` BIGINT COMMENT 'Unique identifier for the campaign flight record. Primary key.',
    `agency_id` BIGINT COMMENT 'FK to marketing.agency',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign. A single campaign may have multiple flights across different channels or geographies.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: Campaign flights are executed at product category level for category-specific media buying and Nielsen/IRI category share-of-voice measurement. campaign_flight.product_category is a denormalized text ',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Campaign flights target specific consumer segments. The existing target_audience column is a free-text string that should be normalized to a FK reference to the marketing domains consumer_segment mas',
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset used in this flight. Links to creative asset management system for creative performance analysis.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand being promoted in this flight. Enables brand-level campaign performance aggregation.',
    `media_plan_id` BIGINT COMMENT 'Foreign key linking to marketing.media_plan. Business justification: Campaign flights are the execution of media plans. Linking a flight to its originating media plan enables plan vs. actual comparison at the flight level — comparing planned impressions, planned spend,',
    `actual_end_date` DATE COMMENT 'Actual date when the flight media execution ended. Captures real execution timeline for post-campaign analysis.',
    `actual_impressions` BIGINT COMMENT 'Actual number of impressions delivered during the flight. Core metric for reach and frequency analysis.',
    `actual_start_date` DATE COMMENT 'Actual date when the flight media execution began. Used for variance analysis against planned schedule.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the campaign flight record',
    `attribution_model` STRING COMMENT 'Attribution methodology used to assign conversion credit to this flight. Critical for multi-touch attribution analysis.. Valid values are `last_click|first_click|linear|time_decay|position_based`',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget allocated to this flight. Represents the planned media spend for this specific flight execution.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount of the campaign flight record',
    `budget_spent_amount` DECIMAL(18,2) COMMENT 'Actual amount spent on this flight. Used for budget variance analysis and Return on Ad Spend (ROAS) calculation.',
    `campaign_flight_status` STRING COMMENT 'The campaign flight status of the campaign flight record',
    `channel` STRING COMMENT 'Primary media channel for this flight execution. Supports omnichannel campaign measurement across digital, TV, out-of-home, print, social media, and search.. Valid values are `digital|tv|ooh|print|social|search`',
    `clicks` BIGINT COMMENT 'Total number of clicks generated by the flight. Primary engagement metric for digital and search campaigns.',
    `campaign_flight_code` STRING COMMENT 'The campaign flight code of the campaign flight record',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Conversion rate expressed as a decimal (conversions divided by clicks or impressions). Measures campaign effectiveness in driving desired actions.',
    `conversions` BIGINT COMMENT 'Total number of conversions attributed to this flight. Conversion definition varies by campaign objective (purchase, sign-up, download, etc.).',
    `cpa` DECIMAL(18,2) COMMENT 'Average cost per conversion for this flight. Critical metric for performance marketing and Return on Investment (ROI) analysis.',
    `cpc` DECIMAL(18,2) COMMENT 'Average cost per click for this flight. Key efficiency metric for paid search and digital campaigns.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this flight record was first created in the system. Used for audit trail and data lineage.',
    `ctr` DECIMAL(18,2) COMMENT 'Click-through rate expressed as a decimal (clicks divided by impressions). Key performance indicator for digital campaign effectiveness.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this flight record.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Source system or platform from which performance data was captured (e.g., Meta API, Google Ads API, agency post-buy report, Nielsen IQ). Used for data lineage and quality assessment.',
    `campaign_flight_description` STRING COMMENT 'The campaign flight description of the campaign flight record',
    `effective_from` DATE COMMENT 'The effective from of the campaign flight record',
    `effective_until` DATE COMMENT 'The effective until of the campaign flight record',
    `end_date` DATE COMMENT 'The end date of the campaign flight record',
    `flight_budget` DECIMAL(18,2) COMMENT 'The flight budget of the campaign flight record',
    `flight_code` STRING COMMENT 'The flight code of the campaign flight record',
    `flight_name` STRING COMMENT 'Descriptive name of the campaign flight for business user identification and reporting.',
    `flight_number` STRING COMMENT 'Business identifier for the flight within the campaign. Used for external reporting and agency coordination.',
    `flight_status` STRING COMMENT 'Current lifecycle status of the campaign flight.. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `frequency` DECIMAL(18,2) COMMENT 'Average number of times an individual was exposed to the campaign (impressions divided by reach). Measures message repetition.',
    `grp` DECIMAL(18,2) COMMENT 'Gross Rating Points for traditional media (TV, radio, OOH). Measures total audience delivery as a percentage of target population multiplied by frequency.',
    `impressions_target` BIGINT COMMENT 'The impressions target of the campaign flight record',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this flight record was last updated. Supports change tracking and data freshness monitoring.',
    `market_geography` STRING COMMENT 'Geographic market or region where the flight is executed. Supports market-level performance tracking and regional campaign optimization.',
    `measurement_date` DATE COMMENT 'Date on which performance metrics were measured or reported. Supports daily granular performance tracking at the campaign-channel-market-date grain.',
    `campaign_flight_name` STRING COMMENT 'The campaign flight name of the campaign flight record',
    `notes` STRING COMMENT 'Free-text notes or comments about the flight execution, performance anomalies, or special circumstances. Supports qualitative context for quantitative performance data.',
    `placement_type` STRING COMMENT 'Specific placement or ad format type within the channel (e.g., banner, video, native, sponsored post, display, search text ad). Enables placement-level optimization.',
    `planned_impressions` BIGINT COMMENT 'The planned impressions of the campaign flight record',
    `platform` STRING COMMENT 'Specific advertising platform or network (e.g., Meta, Google Ads, TikTok, programmatic DSP, linear TV network). Enables platform-specific performance analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the campaign flight record',
    `reach` BIGINT COMMENT 'Estimated number of unique individuals exposed to the campaign flight. Used for audience coverage analysis.',
    `roas` DECIMAL(18,2) COMMENT 'Return on Ad Spend expressed as a ratio (revenue generated divided by ad spend). Primary metric for campaign profitability assessment.',
    `scheduled_end_date` DATE COMMENT 'Planned end date for the flight media run. Defines the flight duration for budget allocation and performance measurement.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for the flight media run. Used for campaign planning and scheduling.',
    `source_system_code` STRING COMMENT 'The source system code of the campaign flight record',
    `start_date` DATE COMMENT 'The start date of the campaign flight record',
    `target_impressions` BIGINT COMMENT 'Planned number of impressions for this flight. Used for media planning and performance target setting.',
    `uom` STRING COMMENT 'The uom of the campaign flight record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the campaign flight record',
    `video_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of video views that were completed (watched to end). Measures creative engagement quality.',
    `video_views` BIGINT COMMENT 'Total number of video views for video creative flights. Applicable to digital video, social, and TV campaigns.',
    CONSTRAINT pk_campaign_flight PRIMARY KEY(`campaign_flight_id`)
) COMMENT 'Transactional record of campaign execution at the flight level, capturing performance metrics across ALL channels (digital, TV, OOH, print, social, search, programmatic) at the campaign-channel-market-date grain. Defines scheduled media run dates, channel, market/geography, budget allocation, and flight-level performance targets. Captures planned and actual impressions, clicks, CTR, video views, view-through rate, conversions, CPC, CPA, ROAS, reach, frequency, GRPs (traditional), and platform-specific metrics (Meta, Google, TikTok, programmatic DSP). A single campaign may have multiple flights across different channels or geographies. Sourced from digital ad platform APIs, agency post-buy reports, and media monitoring systems. Serves as the unified granular performance record for omnichannel campaign measurement.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` (
    `media_plan_id` BIGINT COMMENT 'Unique identifier for the media plan record. Primary key.',
    `agency_id` BIGINT COMMENT 'The agency id of the media plan record',
    `budget_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_budget. Business justification: Media plans are constrained by and draw from approved marketing budgets. Linking media_plan to marketing_budget enables plan-level budget utilization tracking, ensures media plans are created within a',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this media plan.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: CPG media plans are structured by product category for share-of-voice analysis and category-level media investment benchmarking (e.g., Nielsen SOV reports). Media plans span multiple campaigns; a dire',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Media plans are designed to reach specific consumer segments. The existing target_audience column is a free-text string that should be normalized to a FK reference to the marketing domains consumer_s',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand for which this media plan is created.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Contract-governed media planning: media plans in consumer goods are authorized by agency or media-buying contracts negotiated through procurement. Linking media_plan to supplier_contract enables compl',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the media plan record',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this media plan.',
    `approved_date` DATE COMMENT 'Date when this media plan was formally approved for execution.',
    `budget_allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of total campaign or brand budget allocated to this media plan line.',
    `media_plan_code` STRING COMMENT 'The media plan code of the media plan record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this media plan record was first created in the system.',
    `creative_format` STRING COMMENT 'Format of the creative asset planned for this media (e.g., 30-second spot, banner ad, full-page print, billboard).',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the planned spend amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time segment of day for broadcast media (e.g., Prime Time, Early Morning, Late Night, Daytime).',
    `media_plan_description` STRING COMMENT 'The media plan description of the media plan record',
    `effective_from` DATE COMMENT 'The effective from of the media plan record',
    `effective_until` DATE COMMENT 'The effective until of the media plan record',
    `end_date` DATE COMMENT 'The end date of the media plan record',
    `flight_end_date` DATE COMMENT 'End date of the media flight or execution period for this plan.',
    `flight_start_date` DATE COMMENT 'Start date of the media flight or execution period for this plan.',
    `frequency` DECIMAL(18,2) COMMENT 'The frequency of the media plan record',
    `kpi_target` STRING COMMENT 'Target Key Performance Indicator metric and value for measuring media plan success (e.g., Reach 70%, CTR 2.5%, ROAS 3.0).',
    `market` STRING COMMENT 'Geographic market or Designated Market Area (DMA) targeted by this media plan (e.g., USA, New York DMA, UK).',
    `media_channel` STRING COMMENT 'Primary media channel category for this plan line (TV, digital, out-of-home, print, social, search, programmatic, radio, cinema, podcast). [ENUM-REF-CANDIDATE: tv|digital|ooh|print|social|search|programmatic|radio|cinema|podcast — promote to reference product]',
    `media_owner` STRING COMMENT 'Name of the media owner or publisher (e.g., NBC, Google, Meta, Clear Channel).',
    `media_plan_status` STRING COMMENT 'The media plan status of the media plan record',
    `media_subchannel` STRING COMMENT 'Detailed subchannel or platform within the primary media channel (e.g., Facebook, Google Display, National TV, Local Radio).',
    `media_type` STRING COMMENT 'The media type of the media plan record',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this media plan record was last modified or updated.',
    `media_plan_name` STRING COMMENT 'The media plan name of the media plan record',
    `notes` STRING COMMENT 'Free-text notes, comments, or special instructions related to this media plan.',
    `objective` STRING COMMENT 'Primary marketing objective for this media plan (awareness, consideration, conversion, retention, trial).. Valid values are `awareness|consideration|conversion|retention|trial`',
    `plan_code` STRING COMMENT 'Unique business identifier or code for the media plan used for external reference and tracking.',
    `plan_name` STRING COMMENT 'Business-friendly name or title of the media plan document.',
    `plan_period` STRING COMMENT 'The plan period of the media plan record',
    `plan_status` STRING COMMENT 'Current lifecycle status of the media plan indicating its approval and execution state.. Valid values are `draft|submitted|approved|active|completed|cancelled`',
    `plan_type` STRING COMMENT 'Classification of the media plan by planning horizon and purpose.. Valid values are `annual|quarterly|campaign|product_launch|seasonal|tactical`',
    `plan_version` STRING COMMENT 'Version number of this media plan document to track revisions and iterations.',
    `planned_budget` DECIMAL(18,2) COMMENT 'The planned budget of the media plan record',
    `planned_cpm` DECIMAL(18,2) COMMENT 'Planned cost per thousand impressions for this media investment.',
    `planned_cpp` DECIMAL(18,2) COMMENT 'Planned cost per rating point for broadcast media investments.',
    `planned_frequency` DECIMAL(18,2) COMMENT 'Planned average number of times the target audience will be exposed to the media message.',
    `planned_grp` DECIMAL(18,2) COMMENT 'Planned Gross Rating Points representing the total reach multiplied by frequency for the target audience.',
    `planned_impressions` BIGINT COMMENT 'Total number of planned impressions (ad exposures) for this media plan.',
    `planned_reach` BIGINT COMMENT 'The planned reach of the media plan record',
    `planned_reach_percent` DECIMAL(18,2) COMMENT 'Planned percentage of the target audience reached at least once during the planning period.',
    `planned_spend_amount` DECIMAL(18,2) COMMENT 'Total planned media spend amount for this media plan in the base currency.',
    `planning_period_end_date` DATE COMMENT 'End date of the period covered by this media plan.',
    `planning_period_start_date` DATE COMMENT 'Start date of the period covered by this media plan.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the media plan record',
    `source_system_code` STRING COMMENT 'The source system code of the media plan record',
    `start_date` DATE COMMENT 'The start date of the media plan record',
    `target_grp` DECIMAL(18,2) COMMENT 'The target grp of the media plan record',
    `target_reach_pct` DECIMAL(18,2) COMMENT 'The target reach pct of the media plan record',
    `total_budget` DECIMAL(18,2) COMMENT 'The total budget of the media plan record',
    `uom` STRING COMMENT 'The uom of the media plan record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the media plan record',
    CONSTRAINT pk_media_plan PRIMARY KEY(`media_plan_id`)
) COMMENT 'Formal media plan document capturing planned media investments across channels (TV, digital, OOH, print, social, search, programmatic) for a brand or campaign. Includes planned impressions, GRPs, reach, frequency, CPM, total planned spend, agency, media owner, market, and planning period. Serves as the authoritative pre-buy record for media investment decisions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` (
    `media_spend_id` BIGINT COMMENT 'Unique identifier for the media spend transaction record. Primary key for the media spend data product.',
    `agency_id` BIGINT COMMENT 'The agency id of the media spend record',
    `campaign_flight_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign_flight. Business justification: Media spend is incurred at the campaign flight level. Linking spend records to their originating flight enables granular spend tracking, flight-level ROI analysis, and reconciliation of invoiced spend',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this media spend transaction.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Media spend is tracked against target consumer segments for attribution and ROI analysis. The existing target_audience column is a free-text string that should be normalized to a FK reference to the m',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media spend invoices are posted against cost centers to track advertising costs per organizational unit.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Accounting of media spend requires a GL account reference for journal entry creation.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand for which this media spend was incurred.',
    `media_plan_id` BIGINT COMMENT 'Reference to the media plan that authorized this spend.',
    `supplier_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_invoice. Business justification: Media spend reconciliation: media spend records must be matched against supplier invoices from media vendors for three-way match and campaign actual-spend validation. media_spend.invoice_number is a d',
    `agency_fee_amount` DECIMAL(18,2) COMMENT 'The agency service fee or commission charged for managing the media buy.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the media spend record',
    `buy_type` STRING COMMENT 'The method by which the media inventory was purchased (e.g., Programmatic, Direct, Auction, Guaranteed).. Valid values are `Programmatic|Direct|Auction|Guaranteed|Preferred Deal|Private Marketplace`',
    `channel` STRING COMMENT 'The channel of the media spend record',
    `clicks` BIGINT COMMENT 'The clicks of the media spend record',
    `clicks_delivered` BIGINT COMMENT 'The total number of clicks generated by the media placement for this spend transaction.',
    `media_spend_code` STRING COMMENT 'The media spend code of the media spend record',
    `country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code where the media spend was incurred (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `cpc` DECIMAL(18,2) COMMENT 'The cpc of the media spend record',
    `cpc_actual` DECIMAL(18,2) COMMENT 'The actual cost per click (CPC) achieved for this media spend, calculated as working spend divided by clicks delivered.',
    `cpm` DECIMAL(18,2) COMMENT 'The cpm of the media spend record',
    `cpm_actual` DECIMAL(18,2) COMMENT 'The actual cost per thousand impressions (CPM) achieved for this media spend, calculated as (working spend / impressions) * 1000.',
    `cpv_actual` DECIMAL(18,2) COMMENT 'The actual cost per video view (CPV) achieved for this media spend, calculated as working spend divided by video views delivered.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this media spend record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the spend amounts are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `media_spend_description` STRING COMMENT 'The media spend description of the media spend record',
    `effective_from` DATE COMMENT 'The effective from of the media spend record',
    `effective_until` DATE COMMENT 'The effective until of the media spend record',
    `geography_scope` STRING COMMENT 'The geographic scope of the media placement (e.g., National, Regional, Local, Global).. Valid values are `National|Regional|Local|Global`',
    `impressions` BIGINT COMMENT 'The impressions of the media spend record',
    `impressions_delivered` BIGINT COMMENT 'The total number of ad impressions delivered for this spend transaction.',
    `invoiced_spend_amount` DECIMAL(18,2) COMMENT 'The total amount invoiced by the media owner or agency for this media spend transaction.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this media spend record is currently active and valid (True) or has been voided or superseded (False).',
    `market_name` STRING COMMENT 'The name of the specific market or Designated Market Area (DMA) where the media was placed (e.g., New York, Los Angeles, London).',
    `media_channel` STRING COMMENT 'The media channel through which the advertising was delivered (e.g., TV, Digital Display, Social Media, Search). [ENUM-REF-CANDIDATE: TV|Radio|Print|Digital Display|Social Media|Search|Video|Out-of-Home|Programmatic|Influencer|Podcast|Streaming|Email|Mobile|Affiliate|Sponsorship|Other — 17 candidates stripped; promote to reference product]',
    `media_owner_name` STRING COMMENT 'The name of the media owner or publisher that provided the advertising inventory (e.g., Google, Meta, NBC Universal).',
    `media_spend_status` STRING COMMENT 'The media spend status of the media spend record',
    `media_subchannel` STRING COMMENT 'The specific subchannel or platform within the media channel (e.g., Facebook, Google Ads, CNN, Spotify).',
    `media_vehicle` STRING COMMENT 'The media vehicle of the media spend record',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this media spend record was last modified or updated.',
    `media_spend_name` STRING COMMENT 'The media spend name of the media spend record',
    `non_working_spend_amount` DECIMAL(18,2) COMMENT 'The portion of invoiced spend allocated to agency fees, production costs, and other non-media expenses (non-working media).',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this media spend transaction, including reconciliation notes or dispute details.',
    `payment_date` DATE COMMENT 'The date on which the invoice for this media spend was paid.',
    `payment_status` STRING COMMENT 'The payment status of the invoice associated with this media spend transaction.. Valid values are `Pending|Paid|Overdue|Disputed|Cancelled`',
    `placement_type` STRING COMMENT 'The type of media placement or ad format (e.g., Banner, Video Pre-Roll, Native, Sponsored Post, 30-Second Spot).',
    `planned_spend_amount` DECIMAL(18,2) COMMENT 'The originally planned or committed spend amount from the media plan for this channel and period.',
    `production_cost_amount` DECIMAL(18,2) COMMENT 'The cost of creative production, ad serving, and other production-related expenses included in this spend transaction.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the media spend record',
    `reconciled_timestamp` TIMESTAMP COMMENT 'The timestamp when this media spend record was reconciled against the media plan and delivery metrics.',
    `reconciliation_status` STRING COMMENT 'The current reconciliation status of this spend transaction against the media plan and delivery metrics.. Valid values are `Pending|Reconciled|Disputed|Approved|Rejected`',
    `source_system_code` STRING COMMENT 'The unique identifier for this media spend record in the source system.',
    `spend_amount` DECIMAL(18,2) COMMENT 'The spend amount of the media spend record',
    `spend_date` DATE COMMENT 'The date on which the media spend was incurred or invoiced.',
    `spend_period` STRING COMMENT 'The fiscal or calendar period (e.g., 2024-Q1, 2024-03) to which this spend is allocated for reporting purposes.',
    `uom` STRING COMMENT 'The uom of the media spend record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the media spend record',
    `variance_to_plan_amount` DECIMAL(18,2) COMMENT 'The difference between invoiced spend and planned spend (invoiced minus planned), indicating over- or under-spend.',
    `vendor_name` STRING COMMENT 'The vendor name of the media spend record',
    `video_views_delivered` BIGINT COMMENT 'The total number of video views or completions delivered for video media placements.',
    `working_spend_amount` DECIMAL(18,2) COMMENT 'The portion of invoiced spend that directly purchased media inventory (working media), excluding agency fees and production costs.',
    CONSTRAINT pk_media_spend PRIMARY KEY(`media_spend_id`)
) COMMENT 'Transactional record of actual media spend incurred per channel, campaign, brand, and time period. Captures invoiced spend, committed spend, variance to plan, media owner, agency fees, working vs. non-working spend classification, and cost-per-metric actuals (CPM, CPC, CPV). Sourced from agency billing systems and reconciled against media plan commitments.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` (
    `creative_asset_id` BIGINT COMMENT 'Unique identifier for the creative asset record. Primary key.',
    `agency_id` BIGINT COMMENT 'The agency id of the creative asset record',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign this creative asset is associated with.',
    `consumer_segment_id` BIGINT COMMENT 'Foreign key linking to marketing.consumer_segment. Business justification: Creative assets are designed for specific consumer segments. The existing target_audience_segment column is a free-text string that should be normalized to a FK reference to the marketing domains con',
    `parent_asset_creative_asset_id` BIGINT COMMENT 'Identifier of the parent creative asset if this asset is a derivative, localized version, or variant of another asset.',
    `product_brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: Brand equity creative assets (TV spots, brand guidelines, hero imagery) are owned at product brand level, not SKU level. creative_asset.sku_id covers SKU-specific assets; product_brand_id covers brand',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Creative assets (images, packaging) are created per SKU; linking enables asset tracking, compliance, and reuse.',
    `actual_end_date` DATE COMMENT 'Actual date when the creative asset was withdrawn or archived from active use.',
    `actual_publish_date` DATE COMMENT 'Actual date when the creative asset was published or went live.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the creative asset record',
    `approval_status` STRING COMMENT 'Current approval status of the creative asset in the review workflow (draft, pending review, approved, rejected, expired).. Valid values are `draft|pending_review|approved|rejected|expired`',
    `asset_code` STRING COMMENT 'Unique business identifier or code assigned to the creative asset for tracking and reference purposes.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the creative asset (e.g., Spring Campaign Hero Banner, Product Launch Video 30s).',
    `asset_type` STRING COMMENT 'Classification of the creative asset by media type (video, image, audio, document, HTML, social post, email template). [ENUM-REF-CANDIDATE: video|image|audio|document|html|social_post|email_template — 7 candidates stripped; promote to reference product]',
    `creative_asset_code` STRING COMMENT 'The creative asset code of the creative asset record',
    `compliance_notes` STRING COMMENT 'Notes or comments from compliance and legal review regarding the creative asset.',
    `compliance_review_status` STRING COMMENT 'Status of regulatory and legal compliance review for the creative asset (not required, pending, approved, rejected).. Valid values are `not_required|pending|approved|rejected`',
    `content_category` STRING COMMENT 'Business category or use case of the creative asset (TV commercial, digital banner, social media, print ad, packaging visual, influencer brief, blog post, email content, landing page, infographic). [ENUM-REF-CANDIDATE: tv_commercial|digital_banner|social_media|print_ad|packaging_visual|influencer_brief|blog_post|email_content|landing_page|infographic — 10 candidates stripped; promote to reference product]',
    `content_format` STRING COMMENT 'Specific file format or content format of the asset (e.g., MP4, JPEG, PNG, PDF, GIF, HTML5).',
    `content_status` STRING COMMENT 'Current publishing lifecycle status of the creative asset (planned, scheduled, published, archived, withdrawn).. Valid values are `planned|scheduled|published|archived|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the creative asset record was first created in the system.',
    `creative_asset_status` STRING COMMENT 'The creative asset status of the creative asset record',
    `creative_concept` STRING COMMENT 'High-level creative concept or theme of the asset (e.g., Family Moments, Sustainability Focus, Product Innovation).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the production cost amount.. Valid values are `^[A-Z]{3}$`',
    `dam_reference_code` STRING COMMENT 'Unique identifier or reference code in the Digital Asset Management system where the asset is stored.',
    `creative_asset_description` STRING COMMENT 'Detailed textual description of the creative asset content, purpose, and key messaging.',
    `duration_seconds` STRING COMMENT 'Duration of the creative asset in seconds (applicable to video and audio assets).',
    `effective_from` DATE COMMENT 'The effective from of the creative asset record',
    `effective_until` DATE COMMENT 'The effective until of the creative asset record',
    `file_reference` STRING COMMENT 'The file reference of the creative asset record',
    `file_size_bytes` BIGINT COMMENT 'Size of the creative asset file in bytes.',
    `file_url` STRING COMMENT 'The file url of the creative asset record',
    `format` STRING COMMENT 'The format of the creative asset record',
    `geographic_scope` STRING COMMENT 'Geographic regions or markets where the creative asset is approved for use (e.g., Global, USA, EMEA).',
    `height_pixels` STRING COMMENT 'Height dimension of the creative asset in pixels (applicable to images, videos, and display ads).',
    `is_master_version` BOOLEAN COMMENT 'Flag indicating whether this is the master or primary version of the creative asset (True) or a derivative/variant (False).',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags associated with the creative asset for search and discovery purposes.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code representing the primary language of the creative asset content.. Valid values are `^[a-z]{2}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the creative asset record was last modified or updated.',
    `creative_asset_name` STRING COMMENT 'The creative asset name of the creative asset record',
    `notes` STRING COMMENT 'The notes of the creative asset record',
    `planned_end_date` DATE COMMENT 'Planned date for the creative asset to be withdrawn or archived from active use.',
    `planned_publish_date` DATE COMMENT 'Planned or scheduled date for the creative asset to be published or go live.',
    `production_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to produce the creative asset.',
    `publishing_channel` STRING COMMENT 'Primary channel or platform where the creative asset is published or distributed (e.g., Facebook, Instagram, YouTube, Website, Email, TV).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the creative asset record',
    `rights_expiry_date` DATE COMMENT 'Date when the usage rights or licensing for the creative asset expire.',
    `source_system_code` STRING COMMENT 'Unique identifier of the creative asset in the source system.',
    `storage_location_url` STRING COMMENT 'Full URL or file path where the creative asset is stored in the DAM or content repository.',
    `thumbnail_url` STRING COMMENT 'URL of the thumbnail or preview image for the creative asset.',
    `uom` STRING COMMENT 'The uom of the creative asset record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the creative asset record',
    `usage_rights` STRING COMMENT 'Description of usage rights, licensing terms, or restrictions governing how the creative asset may be used (e.g., Global rights, North America only, Digital channels only).',
    `usage_rights_expiry` DATE COMMENT 'The usage rights expiry of the creative asset record',
    `version_number` STRING COMMENT 'Version number or identifier for the creative asset (e.g., v1.0, v2.1, Final).',
    `width_pixels` STRING COMMENT 'Width dimension of the creative asset in pixels (applicable to images, videos, and display ads).',
    CONSTRAINT pk_creative_asset PRIMARY KEY(`creative_asset_id`)
) COMMENT 'Master record for each creative asset and content item (TV commercial, digital banner, social post, print ad, packaging visual, influencer brief, video, blog post, email template) used in marketing campaigns or published on owned/earned channels. Captures asset name, format, dimensions, file type, brand, campaign association, creative concept, approval status, rights/usage restrictions, expiry date, DAM reference ID, and content publishing metadata (planned publish date, actual publish date, publishing channel, content status, content type, target audience segment, content owner). Serves as the unified creative and content management record supporting brand compliance, creative reuse tracking, DAM integration, and coordinated omnichannel content calendar planning. No separate content calendar product exists — all scheduling and publishing metadata lives here.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` (
    `consumer_segment_id` BIGINT COMMENT 'Unique identifier for the marketing consumer segment. Primary key.',
    `marketing_brand_id` BIGINT COMMENT 'The marketing brand id of the consumer segment record',
    `age_range_lower` STRING COMMENT 'Lower bound of the age range for consumers in this segment (in years). Null if age is not a defining characteristic.',
    `age_range_upper` STRING COMMENT 'Upper bound of the age range for consumers in this segment (in years). Null if age is not a defining characteristic.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the consumer segment record',
    `average_basket_size_usd` DECIMAL(18,2) COMMENT 'Average transaction or basket size in USD for consumers in this segment, used for campaign ROI modeling.',
    `brand_affinity` STRING COMMENT 'Brands or brand categories that this segment shows strong preference or loyalty toward. Used for brand-specific campaign targeting.',
    `cltv_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated Customer Lifetime Value in USD for consumers in this segment, used for prioritization and investment decisions.',
    `consumer_segment_code` STRING COMMENT 'The consumer segment code of the consumer segment record',
    `consumer_segment_status` STRING COMMENT 'The consumer segment status of the consumer segment record',
    `content_preference` STRING COMMENT 'Types of marketing content that resonate with this segment (e.g., educational, promotional, user-generated, influencer, video).',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this segment is applicable (e.g., USA, GBR, DEU).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was first created in the system.',
    `currency_code` STRING COMMENT 'The currency code of the consumer segment record',
    `data_source` STRING COMMENT 'Primary data source or vendor used to define and validate this segment (e.g., Nielsen IQ, internal CRM, third-party data provider).',
    `demographic_profile` STRING COMMENT 'The demographic profile of the consumer segment record',
    `consumer_segment_description` STRING COMMENT 'The consumer segment description of the consumer segment record',
    `digital_engagement_level` STRING COMMENT 'Level of digital channel engagement and activity for consumers in this segment (social media, email, mobile app, e-commerce).. Valid values are `high|medium|low|minimal|not_specified`',
    `effective_end_date` DATE COMMENT 'Date when this segment definition is scheduled to be retired or replaced. Null for open-ended segments.',
    `effective_from` DATE COMMENT 'The effective from of the consumer segment record',
    `effective_start_date` DATE COMMENT 'Date when this segment definition became active and available for campaign targeting.',
    `effective_until` DATE COMMENT 'The effective until of the consumer segment record',
    `geographic_scope` STRING COMMENT 'Geographic reach or focus of this consumer segment (global, regional, national, or local).. Valid values are `global|regional|national|local|not_specified`',
    `income_bracket` STRING COMMENT 'Income level classification for consumers in this segment, used for targeting and media planning.. Valid values are `low|lower_middle|middle|upper_middle|high|not_specified`',
    `innovation_adoption_profile` STRING COMMENT 'Consumer adoption curve classification for new product launches and innovations (based on Rogers Diffusion of Innovations theory).. Valid values are `innovator|early_adopter|early_majority|late_majority|laggard|not_specified`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this segment is currently active and available for use in campaign planning and targeting.',
    `key_characteristics` STRING COMMENT 'Defining behavioral, demographic, or psychographic characteristics that distinguish this segment from others.',
    `last_refresh_date` DATE COMMENT 'Date when the segment definition, size estimate, or characteristics were last updated or recalculated.',
    `messaging_tone_preference` STRING COMMENT 'Preferred messaging tone and style for communications to this segment (e.g., aspirational, practical, humorous, authoritative).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this segment record was last modified or updated.',
    `consumer_segment_name` STRING COMMENT 'The consumer segment name of the consumer segment record',
    `notes` STRING COMMENT 'The notes of the consumer segment record',
    `nps_score_average` DECIMAL(18,2) COMMENT 'Average Net Promoter Score for consumers in this segment, indicating brand loyalty and advocacy potential.',
    `price_sensitivity_level` STRING COMMENT 'Degree of price sensitivity and responsiveness to promotions and discounts for consumers in this segment.. Valid values are `high|medium|low|not_specified`',
    `promotion_responsiveness` STRING COMMENT 'Level of responsiveness to trade promotions, coupons, and special offers for consumers in this segment.. Valid values are `high|medium|low|not_specified`',
    `psychographic_profile` STRING COMMENT 'The psychographic profile of the consumer segment record',
    `purchase_frequency_profile` STRING COMMENT 'Typical purchase frequency behavior of consumers in this segment for relevant product categories.. Valid values are `high_frequency|medium_frequency|low_frequency|occasional|not_specified`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the consumer segment record',
    `refresh_frequency` STRING COMMENT 'Planned frequency for updating segment membership and characteristics to maintain accuracy.. Valid values are `daily|weekly|monthly|quarterly|annually|ad_hoc`',
    `region_codes` STRING COMMENT 'Comma-separated list of regional codes or identifiers where this segment is applicable (e.g., state, province, metro area codes).',
    `segment_code` STRING COMMENT 'Unique business identifier code for the consumer segment used across marketing systems and campaign planning tools.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `segment_description` STRING COMMENT 'Detailed description of the consumer segment including defining characteristics, behaviors, and strategic rationale.',
    `segment_name` STRING COMMENT 'Human-readable name of the consumer segment used in campaign planning and reporting.',
    `segment_size` BIGINT COMMENT 'The segment size of the consumer segment record',
    `segment_size_estimate` BIGINT COMMENT 'Estimated number of consumers or households that belong to this segment based on the most recent segmentation analysis.',
    `segment_size_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total addressable consumer base that this segment represents.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the consumer segment indicating whether it is actively used in campaign targeting.. Valid values are `active|inactive|draft|archived|under_review`',
    `segment_type` STRING COMMENT 'The segment type of the consumer segment record',
    `segmentation_methodology` STRING COMMENT 'Detailed methodology, algorithm, or analytical approach used to create this segment (e.g., RFM analysis, cluster analysis, decision tree).',
    `segmentation_model_type` STRING COMMENT 'The methodology or model used to define this consumer segment (behavioral, psychographic, demographic, geographic, needs-based, or hybrid).. Valid values are `behavioral|psychographic|demographic|geographic|needs_based|hybrid`',
    `size_estimate` BIGINT COMMENT 'The size estimate of the consumer segment record',
    `social_media_platform_preference` STRING COMMENT 'Preferred social media platforms for consumers in this segment (e.g., Facebook, Instagram, TikTok, Twitter). Comma-separated list.',
    `source_system_code` STRING COMMENT 'The source system code of the consumer segment record',
    `strategic_priority_tier` STRING COMMENT 'Strategic importance ranking of this segment for marketing investment and campaign focus (tier 1 being highest priority).. Valid values are `tier_1|tier_2|tier_3|tier_4|not_prioritized`',
    `sustainability_consciousness_level` STRING COMMENT 'Level of environmental and sustainability awareness and preference for eco-friendly products within this segment.. Valid values are `high|medium|low|not_specified`',
    `target_channel_affinity` STRING COMMENT 'Preferred marketing and sales channels for reaching this segment (e.g., digital, retail, DTC, social media, email). Comma-separated list of channel preferences.',
    `uom` STRING COMMENT 'The uom of the consumer segment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the consumer segment record',
    `value_index` DECIMAL(18,2) COMMENT 'The value index of the consumer segment record',
    CONSTRAINT pk_consumer_segment PRIMARY KEY(`consumer_segment_id`)
) COMMENT 'Reference master for consumer segmentation definitions used in targeting and campaign planning. Captures segment name, segmentation model (behavioral, psychographic, demographic, needs-based), segment size estimate, key characteristics, target channel affinity, brand affinity, and strategic priority tier. Used to align campaign targeting across digital, retail, and DTC channels. Distinct from consumer profile (owned by consumer domain).';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` (
    `agency_id` BIGINT COMMENT 'Unique identifier for the marketing agency partner. Primary key for the agency master record.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Agency contract management: marketing agencies are governed by formal procurement contracts. Linking agency directly to supplier_contract enables compliance teams to verify contract coverage, payment ',
    `supplier_id` BIGINT COMMENT 'Supplier record for this agency vendor.',
    `address_line1` STRING COMMENT 'First line of the agencys primary business address (street address, building number).',
    `address_line2` STRING COMMENT 'Second line of the agencys primary business address (suite, floor, building name). Nullable.',
    `agency_status` STRING COMMENT 'The agency status of the agency record',
    `agency_type` STRING COMMENT 'Primary classification of the agency based on core service offering: creative (brand and campaign creative development), media (media planning and buying), digital (digital marketing and social media), pr (public relations and communications), shopper (shopper marketing and retail execution), research (market research and consumer insights).. Valid values are `creative|media|digital|pr|shopper|research`',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the agency record',
    `annual_retainer_amount` DECIMAL(18,2) COMMENT 'Total annual retainer fee amount committed under the current contract. Null if engagement is project-based only.',
    `assigned_brands` STRING COMMENT 'Comma-separated list of Consumer Goods brand names or brand identifiers that this agency is contracted to support.',
    `city` STRING COMMENT 'City of the agencys primary business address.',
    `agency_code` STRING COMMENT 'Internal short code or identifier used to reference the agency in operational systems and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `contact_email` STRING COMMENT 'The contact email of the agency record',
    `contact_name` STRING COMMENT 'The contact name of the agency record',
    `contract_end_date` DATE COMMENT 'Scheduled expiration or termination date of the current agency contract. Null for open-ended agreements.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current agency contract or master service agreement.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the agency contract: active (contract in force), pending (contract under negotiation or awaiting signature), suspended (temporarily paused), terminated (ended before expiration), expired (contract term ended).. Valid values are `active|pending|suspended|terminated|expired`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the agencys primary business address (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts associated with this agency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `agency_description` STRING COMMENT 'The agency description of the agency record',
    `duns_number` STRING COMMENT 'Dun & Bradstreet DUNS number for the agency, used for vendor identification and credit assessment.. Valid values are `^[0-9]{9}$`',
    `effective_from` DATE COMMENT 'The effective from of the agency record',
    `effective_until` DATE COMMENT 'The effective until of the agency record',
    `engagement_model` STRING COMMENT 'Basis of the commercial relationship: retainer (ongoing monthly/annual fee), project (discrete project-based fees), hybrid (combination of retainer and project fees), performance (fee tied to performance metrics).. Valid values are `retainer|project|hybrid|performance`',
    `fee_structure` STRING COMMENT 'Description of the agencys fee arrangement, including rate type (hourly, monthly retainer, project-based, commission percentage, performance-based) and any tiered or volume-based pricing.',
    `holding_group` STRING COMMENT 'Name of the parent holding company or network to which the agency belongs (e.g., WPP, Omnicom, Publicis, IPG, Dentsu). Null if the agency is independent.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this agency record is currently active and available for assignment to campaigns and projects. False indicates the agency relationship has been terminated or is inactive.',
    `is_minority_owned` BOOLEAN COMMENT 'Indicates whether the agency is certified as a minority-owned business enterprise (MBE) for supplier diversity tracking and reporting.',
    `is_preferred_vendor` BOOLEAN COMMENT 'Indicates whether the agency is designated as a preferred or strategic vendor with priority consideration for new projects and campaigns.',
    `is_woman_owned` BOOLEAN COMMENT 'Indicates whether the agency is certified as a woman-owned business enterprise (WBE) for supplier diversity tracking and reporting.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review or scorecard assessment for this agency.',
    `markets_served` STRING COMMENT 'Comma-separated list of geographic markets or regions where the agency provides services to Consumer Goods (e.g., North America, EMEA, APAC, LATAM, or specific country codes).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was last modified or updated.',
    `agency_name` STRING COMMENT 'Legal or trade name of the marketing agency partner.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about the agency relationship, capabilities, or historical performance.',
    `onboarding_date` DATE COMMENT 'Date when the agency was formally onboarded and added to the approved agency roster for Consumer Goods.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the agency (e.g., Net 30, Net 60, milestone-based, advance payment). Defines when invoices are due.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating assigned to the agency based on quality of work, timeliness, collaboration, and business impact. Used for agency benchmarking and roster optimization.. Valid values are `excellent|good|satisfactory|needs_improvement|poor`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the agencys primary business address.',
    `primary_contact` STRING COMMENT 'The primary contact of the agency record',
    `primary_contact_email` STRING COMMENT 'Email address of the primary agency contact for operational communication and coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary point of contact at the agency for day-to-day engagement and escalation.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary agency contact.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the agency record',
    `retainer_amount` DECIMAL(18,2) COMMENT 'The retainer amount of the agency record',
    `retainer_fee` DECIMAL(18,2) COMMENT 'The retainer fee of the agency record',
    `scope_of_services` STRING COMMENT 'Detailed description of the services provided by the agency under the current engagement (e.g., brand strategy, creative production, media planning, digital campaign execution, influencer management, market research).',
    `source_system_code` STRING COMMENT 'Unique identifier of this agency record in the source operational system, used for traceability and reconciliation.',
    `specialization` STRING COMMENT 'The specialization of the agency record',
    `state_province` STRING COMMENT 'State, province, or region of the agencys primary business address.',
    `tax_number` STRING COMMENT 'Tax identification number or employer identification number (EIN) of the agency for tax reporting and compliance purposes.',
    `termination_date` DATE COMMENT 'Date when the agency relationship was formally terminated or the agency was removed from the active roster. Null if the agency is still active.',
    `uom` STRING COMMENT 'The uom of the agency record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the agency record',
    CONSTRAINT pk_agency PRIMARY KEY(`agency_id`)
) COMMENT 'Master record for marketing agency partners engaged by Consumer Goods. Captures agency name, agency type (creative, media, digital, PR, shopper, research, influencer), holding group, scope of services, retainer vs. project basis, primary contact, contract status, performance rating, markets served, assigned brands, and fee structure. Serves as the SSOT for agency partner identity and roster management within the marketing domain. Enables agency performance benchmarking and spend consolidation analysis.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the marketing budget allocation record. Primary key.',
    `category_id` BIGINT COMMENT 'Identifier of the product category to which this budget allocation is assigned. Null for brand-level or corporate-level budgets.',
    `cost_center_id` BIGINT COMMENT 'The cost center id of the marketing budget record',
    `gl_account_id` BIGINT COMMENT 'The gl account id of the marketing budget record',
    `hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.hierarchy. Business justification: CPG marketing budgets are allocated at portfolio hierarchy levels (division, business unit) above category for annual operating plan (AOP) and zero-based budgeting processes. marketing_budget.category',
    `product_brand_id` BIGINT COMMENT 'Foreign key linking to product.product_brand. Business justification: CPG marketing budgets are allocated at product brand level for brand P&L management and brand investment tracking (e.g., A&P spend per brand). marketing_budget links to marketing_brand but not product',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Marketing budgets in CPG are approved and tracked at profit center level for brand P&L accountability. Budget vs. actual reporting by profit center is a standard finance-marketing governance process. ',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The allocated amount of the marketing budget record',
    `amount` DECIMAL(18,2) COMMENT 'The budget amount of the marketing budget record',
    `budget_category` STRING COMMENT 'The budget category of the marketing budget record',
    `budget_code` STRING COMMENT 'The budget code of the marketing budget record',
    `committed_amount` DECIMAL(18,2) COMMENT 'The committed amount of the marketing budget record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the marketing budget record',
    `currency_code` STRING COMMENT 'The currency code of the marketing budget record',
    `effective_from` DATE COMMENT 'The effective from of the marketing budget record',
    `effective_until` DATE COMMENT 'The effective until of the marketing budget record',
    `fiscal_year` STRING COMMENT 'The fiscal year of the marketing budget record',
    `marketing_budget_code` STRING COMMENT 'The marketing budget code of the marketing budget record',
    `marketing_budget_description` STRING COMMENT 'The marketing budget description of the marketing budget record',
    `marketing_budget_name` STRING COMMENT 'The marketing budget name of the marketing budget record',
    `marketing_budget_status` STRING COMMENT 'The marketing budget status of the marketing budget record',
    `budget_name` STRING COMMENT 'The budget name of the marketing budget record',
    `notes` STRING COMMENT 'The notes of the marketing budget record',
    `period` STRING COMMENT 'The budget period of the marketing budget record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the marketing budget record',
    `remaining_amount` DECIMAL(18,2) COMMENT 'The remaining amount of the marketing budget record',
    `source_system_code` STRING COMMENT 'The source system code of the marketing budget record',
    `spent_amount` DECIMAL(18,2) COMMENT 'The spent amount of the marketing budget record',
    `uom` STRING COMMENT 'The uom of the marketing budget record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the marketing budget record',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Marketing budget allocation record capturing planned and approved marketing investment by brand, category, channel, campaign type, and fiscal period. Captures total budget, working media budget, non-working budget, agency fees, research budget, committed spend, actual spend, variance, and budget owner. Distinct from finance domain general ledger — this is the marketing-owned investment planning record. [SSOT: authoritative table is finance.finance_budget; this table is a deprecated duplicate.] [SSOT] Superseded by authoritative table finance.finance_budget for concept budget. SSOT: canonical table is finance.finance_budget. [SSOT: authoritative table is finance.finance_budget; this is a deprecated duplicate for concept budget.] [Non-authoritative; defers to SSOT finance.finance_budget for concept budget.]';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_parent_brand_marketing_brand_id` FOREIGN KEY (`parent_brand_marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`budget`(`budget_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`budget`(`budget_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_consumer_segment_id` FOREIGN KEY (`consumer_segment_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`consumer_segment`(`consumer_segment_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_parent_asset_creative_asset_id` FOREIGN KEY (`parent_asset_creative_asset_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ADD CONSTRAINT `fk_marketing_consumer_segment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`marketing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `parent_brand_marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `annual_marketing_budget` SET TAGS ('dbx_business_glossary_term' = 'Annual Marketing Budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `annual_marketing_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Target');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `annual_revenue_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `architecture_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Architecture Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `architecture_tier` SET TAGS ('dbx_value_regex' = 'masterbrand|subbrand|endorsed|ingredient|private_label|house_brand');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `awareness_percent` SET TAGS ('dbx_business_glossary_term' = 'Brand Awareness Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_category` SET TAGS ('dbx_business_glossary_term' = 'Brand Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_launch|under_review|sunset|archived');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `marketing_brand_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `consideration_percent` SET TAGS ('dbx_business_glossary_term' = 'Brand Consideration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `marketing_brand_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Discontinuation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `equity_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Equity Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `geographic_market_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `geographic_market_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `geographic_market_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `geographic_market_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `global_brand_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Brand Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `guidelines_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Guidelines Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `health_index` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Index');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `health_index` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `health_index` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `is_licensed_brand` SET TAGS ('dbx_business_glossary_term' = 'Is Licensed Brand Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `is_private_label` SET TAGS ('dbx_business_glossary_term' = 'Is Private Label Brand Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Brand Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `logo_asset_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Logo Asset Uniform Resource Locator (URL)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `market_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Market Share Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `marketing_brand_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `marketing_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `portfolio_role` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Role');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `positioning` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `positioning_statement` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Statement');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `preference_percent` SET TAGS ('dbx_business_glossary_term' = 'Brand Preference Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_business_glossary_term' = 'Primary Brand Color Hexadecimal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `primary_color_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `primary_distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Distribution Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `som_percent` SET TAGS ('dbx_business_glossary_term' = 'Share of Market (SOM) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `sov_percent` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Brand Subcategory');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `target_consumer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Consumer Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `target_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `target_som_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Share of Market (SOM) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `target_sov_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Share of Voice (SOV) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `trademark_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Trademark Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `trademark_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Trademark Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `trademark_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Trademark Registration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `trademark_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Trademark Registration Number');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Brand Valuation Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Target Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `actual_media_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Media Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `actual_production_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'ATL|BTL|digital|shopper|influencer|integrated');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `creative_concept` SET TAGS ('dbx_business_glossary_term' = 'Creative Concept Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `geography_scope` SET TAGS ('dbx_business_glossary_term' = 'Geography Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `geography_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `geography_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `geography_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `kpi_target` SET TAGS ('dbx_business_glossary_term' = 'Kpi Target');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_value_regex' = 'awareness|consideration|conversion|loyalty|launch|relaunch');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `planned_media_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Media Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `planned_production_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `primary_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `roi_pct` SET TAGS ('dbx_business_glossary_term' = 'Roi Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `target_reach` SET TAGS ('dbx_business_glossary_term' = 'Target Reach');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `total_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `actual_impressions` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'last_click|first_click|linear|time_decay|position_based');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `budget_spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Spent Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_flight_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'digital|tv|ooh|print|social|search');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_flight_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `conversions` SET TAGS ('dbx_business_glossary_term' = 'Conversions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `cpa` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Acquisition (CPA)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `cpc` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `ctr` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_flight_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `flight_budget` SET TAGS ('dbx_business_glossary_term' = 'Flight Budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `flight_code` SET TAGS ('dbx_business_glossary_term' = 'Flight Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `flight_name` SET TAGS ('dbx_business_glossary_term' = 'Flight Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `flight_status` SET TAGS ('dbx_business_glossary_term' = 'Flight Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `flight_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `grp` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Points (GRP)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `impressions_target` SET TAGS ('dbx_business_glossary_term' = 'Impressions Target');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `market_geography` SET TAGS ('dbx_business_glossary_term' = 'Market Geography');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `market_geography` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `market_geography` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_flight_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `planned_impressions` SET TAGS ('dbx_business_glossary_term' = 'Planned Impressions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `platform` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `platform` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `reach` SET TAGS ('dbx_business_glossary_term' = 'Reach');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `roas` SET TAGS ('dbx_business_glossary_term' = 'Return on Ad Spend (ROAS)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `video_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `video_views` SET TAGS ('dbx_business_glossary_term' = 'Video Views');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` SET TAGS ('dbx_subdomain' = 'media_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `budget_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `media_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `creative_format` SET TAGS ('dbx_business_glossary_term' = 'Creative Format');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `media_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `kpi_target` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Target');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `media_channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `media_owner` SET TAGS ('dbx_business_glossary_term' = 'Media Owner');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `media_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `media_subchannel` SET TAGS ('dbx_business_glossary_term' = 'Media Subchannel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `media_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `objective` SET TAGS ('dbx_value_regex' = 'awareness|consideration|conversion|retention|trial');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_period` SET TAGS ('dbx_business_glossary_term' = 'Plan Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|completed|cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|campaign|product_launch|seasonal|tactical');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planned_budget` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planned_cpm` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Per Thousand (CPM)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planned_cpp` SET TAGS ('dbx_business_glossary_term' = 'Planned Cost Per Point (CPP)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planned_frequency` SET TAGS ('dbx_business_glossary_term' = 'Planned Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planned_grp` SET TAGS ('dbx_business_glossary_term' = 'Planned Gross Rating Points (GRP)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planned_impressions` SET TAGS ('dbx_business_glossary_term' = 'Planned Impressions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planned_reach` SET TAGS ('dbx_business_glossary_term' = 'Planned Reach');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planned_reach_percent` SET TAGS ('dbx_business_glossary_term' = 'Planned Reach Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Grp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `target_reach_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Reach Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `total_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` SET TAGS ('dbx_subdomain' = 'media_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_spend_id` SET TAGS ('dbx_business_glossary_term' = 'Media Spend ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `agency_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Agency Fee Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `buy_type` SET TAGS ('dbx_business_glossary_term' = 'Buy Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `buy_type` SET TAGS ('dbx_value_regex' = 'Programmatic|Direct|Auction|Guaranteed|Preferred Deal|Private Marketplace');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `clicks_delivered` SET TAGS ('dbx_business_glossary_term' = 'Clicks Delivered');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_spend_code` SET TAGS ('dbx_business_glossary_term' = 'Media Spend Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `cpc` SET TAGS ('dbx_business_glossary_term' = 'Cpc');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `cpc_actual` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC) Actual');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cpm');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `cpm_actual` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Thousand Impressions (CPM) Actual');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `cpv_actual` SET TAGS ('dbx_business_glossary_term' = 'Cost Per View (CPV) Actual');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_spend_description` SET TAGS ('dbx_business_glossary_term' = 'Media Spend Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `geography_scope` SET TAGS ('dbx_business_glossary_term' = 'Geography Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `geography_scope` SET TAGS ('dbx_value_regex' = 'National|Regional|Local|Global');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `geography_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `geography_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Impressions Delivered');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `invoiced_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Media Owner Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_spend_status` SET TAGS ('dbx_business_glossary_term' = 'Media Spend Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_subchannel` SET TAGS ('dbx_business_glossary_term' = 'Media Subchannel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_vehicle` SET TAGS ('dbx_business_glossary_term' = 'Media Vehicle');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_spend_name` SET TAGS ('dbx_business_glossary_term' = 'Media Spend Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `non_working_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Non-Working Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'Pending|Paid|Overdue|Disputed|Cancelled');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `planned_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `production_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `reconciled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'Pending|Reconciled|Disputed|Approved|Rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `spend_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `spend_period` SET TAGS ('dbx_business_glossary_term' = 'Spend Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `variance_to_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance to Plan Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `video_views_delivered` SET TAGS ('dbx_business_glossary_term' = 'Video Views Delivered');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `working_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Working Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `parent_asset_creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `actual_publish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Publish Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_code` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `content_format` SET TAGS ('dbx_business_glossary_term' = 'Content Format');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `content_status` SET TAGS ('dbx_business_glossary_term' = 'Content Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `content_status` SET TAGS ('dbx_value_regex' = 'planned|scheduled|published|archived|withdrawn');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `creative_concept` SET TAGS ('dbx_business_glossary_term' = 'Creative Concept');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `dam_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Digital Asset Management (DAM) Reference ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration (Seconds)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `file_reference` SET TAGS ('dbx_business_glossary_term' = 'File Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `file_url` SET TAGS ('dbx_business_glossary_term' = 'File Url');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Format');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `height_pixels` SET TAGS ('dbx_business_glossary_term' = 'Height (Pixels)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `is_master_version` SET TAGS ('dbx_business_glossary_term' = 'Is Master Version');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `planned_publish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Publish Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `production_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `publishing_channel` SET TAGS ('dbx_business_glossary_term' = 'Publishing Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `rights_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rights Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `storage_location_url` SET TAGS ('dbx_business_glossary_term' = 'Storage Location URL');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `usage_rights_expiry` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Expiry');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Width (Pixels)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consumer Segment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `age_range_lower` SET TAGS ('dbx_business_glossary_term' = 'Age Range Lower Bound');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `age_range_upper` SET TAGS ('dbx_business_glossary_term' = 'Age Range Upper Bound');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `average_basket_size_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Size (USD)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `brand_affinity` SET TAGS ('dbx_business_glossary_term' = 'Brand Affinity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `cltv_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Estimate (USD)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `consumer_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `consumer_segment_status` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `content_preference` SET TAGS ('dbx_business_glossary_term' = 'Content Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `demographic_profile` SET TAGS ('dbx_business_glossary_term' = 'Demographic Profile');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `consumer_segment_description` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `digital_engagement_level` SET TAGS ('dbx_business_glossary_term' = 'Digital Engagement Level');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `digital_engagement_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|minimal|not_specified');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|national|local|not_specified');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `income_bracket` SET TAGS ('dbx_business_glossary_term' = 'Income Bracket');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `income_bracket` SET TAGS ('dbx_value_regex' = 'low|lower_middle|middle|upper_middle|high|not_specified');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `innovation_adoption_profile` SET TAGS ('dbx_business_glossary_term' = 'Innovation Adoption Profile');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `innovation_adoption_profile` SET TAGS ('dbx_value_regex' = 'innovator|early_adopter|early_majority|late_majority|laggard|not_specified');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `key_characteristics` SET TAGS ('dbx_business_glossary_term' = 'Key Characteristics');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `last_refresh_date` SET TAGS ('dbx_business_glossary_term' = 'Last Refresh Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `messaging_tone_preference` SET TAGS ('dbx_business_glossary_term' = 'Messaging Tone Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `consumer_segment_name` SET TAGS ('dbx_business_glossary_term' = 'Consumer Segment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `nps_score_average` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Average');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `price_sensitivity_level` SET TAGS ('dbx_business_glossary_term' = 'Price Sensitivity Level');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `price_sensitivity_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_specified');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `promotion_responsiveness` SET TAGS ('dbx_business_glossary_term' = 'Promotion Responsiveness');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `promotion_responsiveness` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_specified');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `psychographic_profile` SET TAGS ('dbx_business_glossary_term' = 'Psychographic Profile');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `purchase_frequency_profile` SET TAGS ('dbx_business_glossary_term' = 'Purchase Frequency Profile');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `purchase_frequency_profile` SET TAGS ('dbx_value_regex' = 'high_frequency|medium_frequency|low_frequency|occasional|not_specified');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Refresh Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `refresh_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|ad_hoc');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `region_codes` SET TAGS ('dbx_business_glossary_term' = 'Region Codes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segment_size` SET TAGS ('dbx_business_glossary_term' = 'Segment Size');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segment_size_estimate` SET TAGS ('dbx_business_glossary_term' = 'Segment Size Estimate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segment_size_percentage` SET TAGS ('dbx_business_glossary_term' = 'Segment Size Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|under_review');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segmentation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segmentation_model_type` SET TAGS ('dbx_business_glossary_term' = 'Segmentation Model Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `segmentation_model_type` SET TAGS ('dbx_value_regex' = 'behavioral|psychographic|demographic|geographic|needs_based|hybrid');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `size_estimate` SET TAGS ('dbx_business_glossary_term' = 'Size Estimate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `social_media_platform_preference` SET TAGS ('dbx_business_glossary_term' = 'Social Media Platform Preference');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `social_media_platform_preference` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `social_media_platform_preference` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `strategic_priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|not_prioritized');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `sustainability_consciousness_level` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Consciousness Level');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `sustainability_consciousness_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_specified');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `target_channel_affinity` SET TAGS ('dbx_business_glossary_term' = 'Target Channel Affinity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `value_index` SET TAGS ('dbx_business_glossary_term' = 'Value Index');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Agency Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Agency Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `agency_status` SET TAGS ('dbx_business_glossary_term' = 'Agency Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_value_regex' = 'creative|media|digital|pr|shopper|research');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `annual_retainer_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Retainer Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `annual_retainer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `assigned_brands` SET TAGS ('dbx_business_glossary_term' = 'Assigned Brands');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Agency City');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `contact_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Country Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `agency_description` SET TAGS ('dbx_business_glossary_term' = 'Agency Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `engagement_model` SET TAGS ('dbx_business_glossary_term' = 'Engagement Model');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `engagement_model` SET TAGS ('dbx_value_regex' = 'retainer|project|hybrid|performance');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `fee_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `holding_group` SET TAGS ('dbx_business_glossary_term' = 'Holding Group');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `is_minority_owned` SET TAGS ('dbx_business_glossary_term' = 'Minority-Owned Business Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `is_preferred_vendor` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `is_woman_owned` SET TAGS ('dbx_business_glossary_term' = 'Woman-Owned Business Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `markets_served` SET TAGS ('dbx_business_glossary_term' = 'Markets Served');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agency Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Onboarding Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `retainer_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainer Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `retainer_fee` SET TAGS ('dbx_business_glossary_term' = 'Retainer Fee');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Specialization');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Agency State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Termination Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `marketing_budget_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `marketing_budget_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `marketing_budget_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `marketing_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Spent Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
