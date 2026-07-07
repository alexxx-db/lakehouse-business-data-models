-- Schema for Domain: marketing | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 05:32:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`marketing` COMMENT 'Owns brand management, consumer engagement campaigns, digital marketing, and market research. Manages campaign planning, media spend, creative assets, influencer partnerships, social media engagement, marketing attribution, brand health metrics, SOV (Share of Voice), SOM, consumer sentiment analysis, and Nielsen IQ panel insights.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` (
    `marketing_brand_id` BIGINT COMMENT 'Unique identifier for the brand record. Primary key for the brand master data product.',
    `employee_id` BIGINT COMMENT 'The brand manager employee id of the marketing brand record',
    `parent_brand_marketing_brand_id` BIGINT COMMENT 'Reference to the parent brand in the brand hierarchy. Null for masterbrand level. Used to establish brand family relationships and roll-up reporting.',
    `product_brand_id` BIGINT COMMENT 'FK to authoritative SSOT table product.product_brand (cross-domain duplicate resolution).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the marketing brand record',
    `annual_marketing_budget` DECIMAL(18,2) COMMENT 'Total allocated marketing investment for the brand for the fiscal year, including media spend, trade promotion, consumer promotion, and agency fees.',
    `annual_revenue_target` DECIMAL(18,2) COMMENT 'Planned annual revenue goal for the brand in the base currency. Used for budget planning, performance tracking, and brand portfolio prioritization.',
    `architecture_tier` STRING COMMENT 'Classification of the brand within the corporate brand architecture hierarchy. Masterbrand represents the corporate umbrella, subbrand is a distinct offering under the masterbrand, endorsed carries both corporate and product brand, ingredient brand is a component brand, private label is retailer-owned, and house brand is a proprietary store brand.. Valid values are `masterbrand|subbrand|endorsed|ingredient|private_label|house_brand`',
    `awareness_percent` DECIMAL(18,2) COMMENT 'Percentage of target consumers who recognize or recall the brand when prompted or unprompted. Measured through consumer surveys and market research panels.',
    `brand_category` STRING COMMENT 'Primary product category or market segment in which the brand competes. Examples include personal care, household cleaning, health and wellness, beauty, food and beverage.',
    `brand_code` STRING COMMENT 'Unique alphanumeric code assigned to the brand for operational reference across systems. Used in SKU (Stock Keeping Unit) hierarchies, trade promotion systems, and financial reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `brand_description` STRING COMMENT 'Detailed narrative describing the brands purpose, value proposition, and positioning in the market. Used for internal reference and marketing brief development.',
    `brand_equity_score` DECIMAL(18,2) COMMENT 'The brand equity score of the marketing brand record',
    `brand_health_index` DECIMAL(18,2) COMMENT 'The brand health index of the marketing brand record',
    `brand_name` STRING COMMENT 'The official registered name of the brand as it appears on product packaging, marketing materials, and consumer-facing communications.',
    `brand_positioning` STRING COMMENT 'The brand positioning of the marketing brand record',
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
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who approved this campaign for execution. Links to workforce/user master data.',
    `category_id` BIGINT COMMENT 'Reference to the product category this campaign targets. Links to the category hierarchy.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaign expense allocation requires charging campaign spend to a specific cost center for budgeting.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Campaigns are often created to support specific ESG commitments; linking enables compliance tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Campaign costs are posted to a specific GL account to support detailed expense reporting.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the primary brand being promoted in this campaign. Links to the brand master data.',
    `owner_employee_id` BIGINT COMMENT 'The owner employee id of the campaign record',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Campaign planning and ROI attribution need a primary SKU reference to allocate budget and measure lift per product.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Campaign planning aligns with R&D product development projects to synchronize launch timing and messaging.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Campaign Sponsorship Procurement: marketing campaigns often have a sponsoring supplier; linking enables sponsor spend tracking and ROI calculation.',
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
    `creative_asset_id` BIGINT COMMENT 'Reference to the creative asset used in this flight. Links to creative asset management system for creative performance analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Flight manager (employee) oversees execution; essential for flight performance review and responsibility logs.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand being promoted in this flight. Enables brand-level campaign performance aggregation.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Flight schedules are executed at individual retail stores; linking flight to store enables store‑level media execution tracking and OTIF reporting.',
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
    `product_category` STRING COMMENT 'Product category or SKU (Stock Keeping Unit) group being promoted. Supports category-level marketing effectiveness analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the campaign flight record',
    `reach` BIGINT COMMENT 'Estimated number of unique individuals exposed to the campaign flight. Used for audience coverage analysis.',
    `roas` DECIMAL(18,2) COMMENT 'Return on Ad Spend expressed as a ratio (revenue generated divided by ad spend). Primary metric for campaign profitability assessment.',
    `scheduled_end_date` DATE COMMENT 'Planned end date for the flight media run. Defines the flight duration for budget allocation and performance measurement.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for the flight media run. Used for campaign planning and scheduling.',
    `source_system_code` STRING COMMENT 'The source system code of the campaign flight record',
    `start_date` DATE COMMENT 'The start date of the campaign flight record',
    `target_audience` STRING COMMENT 'Description of the target audience segment for this flight (e.g., demographic, psychographic, behavioral criteria). Supports audience-specific performance analysis.',
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
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this media plan.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand for which this media plan is created.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Media planner employee owns the plan; needed for budget approval audit and planner workload tracking.',
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
    `target_audience` STRING COMMENT 'Description of the target audience demographic or segment for this media plan (e.g., Adults 25-54, Moms with Kids, HHI 75K+).',
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
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign associated with this media spend transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Media spend invoices are posted against cost centers to track advertising costs per organizational unit.',
    `employee_id` BIGINT COMMENT 'Reference to the user or system that performed the reconciliation of this media spend record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Accounting of media spend requires a GL account reference for journal entry creation.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand for which this media spend was incurred.',
    `media_plan_id` BIGINT COMMENT 'Reference to the media plan that authorized this spend.',
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
    `invoice_number` STRING COMMENT 'The invoice number from the media owner or agency billing system for this spend transaction.',
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
    `target_audience` STRING COMMENT 'The demographic or psychographic target audience for this media placement (e.g., Adults 25-54, Moms with Kids, High-Income Households).',
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
    `employee_id` BIGINT COMMENT 'Identifier of the individual or team responsible for the creative asset content and lifecycle management.',
    `label_version_id` BIGINT COMMENT 'Foreign key linking to regulatory.label_version. Business justification: Creative assets used in label design must be tied to the specific label version for regulatory approval traceability.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand associated with this creative asset.',
    `parent_asset_creative_asset_id` BIGINT COMMENT 'Identifier of the parent creative asset if this asset is a derivative, localized version, or variant of another asset.',
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
    `creative_agency_name` STRING COMMENT 'Name of the external creative agency or partner that produced the creative asset.',
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
    `target_audience_segment` STRING COMMENT 'Primary target audience or consumer segment for the creative asset (e.g., Millennials, Parents with young children, Health-conscious consumers).',
    `thumbnail_url` STRING COMMENT 'URL of the thumbnail or preview image for the creative asset.',
    `uom` STRING COMMENT 'The uom of the creative asset record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the creative asset record',
    `usage_rights` STRING COMMENT 'Description of usage rights, licensing terms, or restrictions governing how the creative asset may be used (e.g., Global rights, North America only, Digital channels only).',
    `usage_rights_expiry` DATE COMMENT 'The usage rights expiry of the creative asset record',
    `version_number` STRING COMMENT 'Version number or identifier for the creative asset (e.g., v1.0, v2.1, Final).',
    `width_pixels` STRING COMMENT 'Width dimension of the creative asset in pixels (applicable to images, videos, and display ads).',
    CONSTRAINT pk_creative_asset PRIMARY KEY(`creative_asset_id`)
) COMMENT 'Master record for each creative asset and content item (TV commercial, digital banner, social post, print ad, packaging visual, influencer brief, video, blog post, email template) used in marketing campaigns or published on owned/earned channels. Captures asset name, format, dimensions, file type, brand, campaign association, creative concept, approval status, rights/usage restrictions, expiry date, DAM reference ID, and content publishing metadata (planned publish date, actual publish date, publishing channel, content status, content type, target audience segment, content owner). Serves as the unified creative and content management record supporting brand compliance, creative reuse tracking, DAM integration, and coordinated omnichannel content calendar planning. No separate content calendar product exists — all scheduling and publishing metadata lives here.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` (
    `influencer_id` BIGINT COMMENT 'Unique identifier for the influencer or content creator partner. Primary key.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to marketing.agency. Business justification: Influencers are often managed through a marketing agency; adding agency_id captures that relationship without creating a bidirectional link.',
    `employee_id` BIGINT COMMENT 'Identifier of the marketing team member or user who onboarded this influencer into the system.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: An influencer is typically contracted by a specific brand; adding brand_id creates the parent relationship and enables brand‑level reporting.',
    `shopper_id` BIGINT COMMENT 'add column shopper_id (BIGINT) with FK to consumer.shopper.shopper_id - influencers may also be tracked as shoppers/consumers',
    `agent_contact` STRING COMMENT 'Contact email or phone number for the influencers agent or manager.',
    `agent_name` STRING COMMENT 'Name of the influencers agent, manager, or talent representation, if applicable.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the influencer record',
    `audience_age_range` STRING COMMENT 'Dominant age demographic of the influencers audience, used for campaign targeting and brand alignment.. Valid values are `13-17|18-24|25-34|35-44|45-54|55-64|65+`',
    `audience_gender_split` STRING COMMENT 'Gender distribution of the influencers audience (e.g., 60% Female, 40% Male). Used for campaign targeting.',
    `audience_geography` STRING COMMENT 'Primary geographic markets where the influencers audience is concentrated, expressed as comma-separated ISO 3-letter country codes (e.g., USA, CAN, GBR).',
    `average_post_impressions` BIGINT COMMENT 'Average total impressions (views) per post, calculated from historical campaign performance data.',
    `average_post_reach` BIGINT COMMENT 'Average number of unique users reached per post, calculated from historical campaign performance data.',
    `brand_safety_score` DECIMAL(18,2) COMMENT 'Brand safety assessment score (0.00 to 5.00) evaluating the influencers content for alignment with brand values, absence of controversial content, and reputational risk. Higher scores indicate safer partnerships.',
    `influencer_category` STRING COMMENT 'The influencer category of the influencer record',
    `influencer_code` STRING COMMENT 'The influencer code of the influencer record',
    `contact_email` STRING COMMENT 'The contact email of the influencer record',
    `content_category` STRING COMMENT 'Primary content category or niche that the influencer specializes in, used for brand and campaign alignment. [ENUM-REF-CANDIDATE: Beauty|Fashion|Lifestyle|Fitness|Food|Travel|Parenting|Tech|Gaming|Home — 10 candidates stripped; promote to reference product]',
    `contract_end_date` DATE COMMENT 'Expiration or termination date of the current contract. Null for open-ended or retainer agreements.',
    `contract_fee` DECIMAL(18,2) COMMENT 'The contract fee of the influencer record',
    `contract_start_date` DATE COMMENT 'Effective start date of the current or most recent contract with the influencer.',
    `contract_status` STRING COMMENT 'Current contractual relationship status with the influencer. Active indicates an ongoing partnership; Inactive indicates no current contract but available for future engagement.. Valid values are `Active|Inactive|Pending|Suspended|Terminated`',
    `contract_type` STRING COMMENT 'Type of contractual agreement governing the influencer partnership. Retainer and Ambassador indicate long-term relationships; One-Time and Campaign-Based are transactional.. Valid values are `One-Time|Campaign-Based|Retainer|Ambassador|Exclusive`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this influencer record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for influencer payments (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `influencer_description` STRING COMMENT 'The influencer description of the influencer record',
    `effective_from` DATE COMMENT 'The effective from of the influencer record',
    `effective_until` DATE COMMENT 'The effective until of the influencer record',
    `email_address` STRING COMMENT 'Primary email address for business communication and contract correspondence with the influencer.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `engagement_rate` DECIMAL(18,2) COMMENT 'The engagement rate of the influencer record',
    `engagement_rate_pct` DECIMAL(18,2) COMMENT 'The engagement rate pct of the influencer record',
    `engagement_rate_percent` DECIMAL(18,2) COMMENT 'Average engagement rate (likes, comments, shares divided by followers) expressed as a percentage. Key metric for influencer effectiveness.',
    `exclusivity_category` STRING COMMENT 'Product category or categories covered by the exclusivity clause (e.g., Beauty, Personal Care, Household). Null if no exclusivity.',
    `exclusivity_clause` BOOLEAN COMMENT 'Indicates whether the influencer is under an exclusivity agreement preventing them from promoting competing brands.',
    `follower_count` BIGINT COMMENT 'Total number of followers across the primary platform at the time of last update. Used for tier classification and reach estimation.',
    `full_name` STRING COMMENT 'Legal or professional full name of the influencer or content creator.',
    `handle` STRING COMMENT 'Primary social media handle or username of the influencer (e.g., @username). Used as the public identifier across platforms.. Valid values are `^@?[A-Za-z0-9_.]{1,30}$`',
    `influencer_status` STRING COMMENT 'The influencer status of the influencer record',
    `is_active` BOOLEAN COMMENT 'Indicates whether this influencer record is currently active and available for campaign engagement. False indicates archived or inactive status.',
    `last_campaign_date` DATE COMMENT 'Date of the most recent campaign engagement with this influencer. Used for recency analysis and re-engagement planning.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this influencer record was last modified or updated.',
    `influencer_name` STRING COMMENT 'The influencer name of the influencer record',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, preferences, special requirements, or historical observations about the influencer partnership.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the influencer for campaign engagements.. Valid values are `Net 30|Net 60|Upon Delivery|50% Upfront|Barter|Product Seeding`',
    `performance_rating` DECIMAL(18,2) COMMENT 'Internal performance rating (0.00 to 5.00) based on historical campaign ROI (Return on Investment), content quality, professionalism, and deliverable timeliness.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the influencer or their management team.',
    `platform` STRING COMMENT 'The platform of the influencer record',
    `preferred_contact_method` STRING COMMENT 'Preferred method for business communication with the influencer or their representation.. Valid values are `Email|Phone|Agent|Manager|Direct Message`',
    `primary_platform` STRING COMMENT 'The primary social media platform where the influencer has the largest following or engagement.. Valid values are `Instagram|TikTok|YouTube|Facebook|Twitter|LinkedIn`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the influencer record',
    `secondary_platforms` STRING COMMENT 'Comma-separated list of additional social media platforms where the influencer maintains an active presence.',
    `source_system_code` STRING COMMENT 'Unique identifier of this influencer record in the source system, used for data lineage and reconciliation.',
    `tier` STRING COMMENT 'The tier of the influencer record',
    `total_campaigns_participated` STRING COMMENT 'Cumulative count of campaigns the influencer has participated in with Consumer Goods. Used for partnership history and performance tracking.',
    `uom` STRING COMMENT 'The uom of the influencer record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the influencer record',
    CONSTRAINT pk_influencer PRIMARY KEY(`influencer_id`)
) COMMENT 'Master record for influencer and content creator partners engaged by Consumer Goods, including full engagement/activation history. Captures influencer handle, platform(s), follower count, engagement rate, audience demographics, content category, tier (nano, micro, macro, mega), brand safety score, contract status, preferred contact, and historical campaign participation. Engagement detail records capture: engagement type (sponsored post, product seeding, brand ambassador, event appearance), campaign association, contracted deliverables, content submission dates, approval status, agreed fee, actual fee paid, platform, post URLs, reach, impressions, engagement metrics, and content performance. Serves as the SSOT for influencer partner identity, roster management, and all activation history. No separate engagement product exists — all engagement transactional data lives here as detail records.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` (
    `consumer_segment_id` BIGINT COMMENT 'Unique identifier for the marketing consumer segment. Primary key.',
    `marketing_brand_id` BIGINT COMMENT 'The marketing brand id of the consumer segment record',
    `employee_id` BIGINT COMMENT 'Identifier of the marketing team member or business unit responsible for managing and activating this segment.',
    `age_range_lower` STRING COMMENT 'Lower bound of the age range for consumers in this segment (in years). Null if age is not a defining characteristic.',
    `age_range_upper` STRING COMMENT 'Upper bound of the age range for consumers in this segment (in years). Null if age is not a defining characteristic.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the consumer segment record',
    `average_basket_size_usd` DECIMAL(18,2) COMMENT 'Average transaction or basket size in USD for consumers in this segment, used for campaign ROI modeling.',
    `brand_affinity` STRING COMMENT 'Brands or brand categories that this segment shows strong preference or loyalty toward. Used for brand-specific campaign targeting.',
    `category_affinity` STRING COMMENT 'Product categories that this segment shows high purchase propensity or engagement with.',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` (
    `market_research_study_id` BIGINT COMMENT 'Unique identifier for the market research study or syndicated data subscription. Primary key.',
    `agency_id` BIGINT COMMENT 'The agency id of the market research study record',
    `category_id` BIGINT COMMENT 'Foreign key reference to the product category being researched in this study.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee or marketing manager who is the business owner and primary stakeholder for this market research study.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key reference to the brand that is the primary focus of this market research study.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Market research studies are commissioned for specific R&D projects to validate concepts and guide product strategy.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the market research study record',
    `analysis_completion_date` DATE COMMENT 'The date when the research analysis and reporting were finalized and delivered.',
    `average_basket_size` DECIMAL(18,2) COMMENT 'The average number of units or volume purchased per transaction by panel households during the measurement period.',
    `brand_awareness_pct` DECIMAL(18,2) COMMENT 'The percentage of respondents who demonstrated awareness of the brand, either aided or unaided, as measured in the brand health tracker.',
    `brand_consideration_pct` DECIMAL(18,2) COMMENT 'The percentage of respondents who would consider purchasing the brand, as measured in the brand health tracker.',
    `brand_preference_pct` DECIMAL(18,2) COMMENT 'The percentage of respondents who prefer the brand over competitors, as measured in the brand health tracker.',
    `business_unit` STRING COMMENT 'The business unit or division that commissioned and is responsible for the market research study (e.g., Skincare, Haircare, Home Care).',
    `buyer_demographics` STRING COMMENT 'Summary of the demographic profile of buyers identified in the consumer panel, including age, gender, income, household composition, and other relevant characteristics.',
    `market_research_study_code` STRING COMMENT 'The market research study code of the market research study record',
    `cost` DECIMAL(18,2) COMMENT 'The cost of the market research study record',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where the research study is conducted (e.g., USA, GBR, DEU).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the market research study record was first created in the system.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the study investment amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_provider_name` STRING COMMENT 'The name of the syndicated data provider for ongoing panel subscriptions or continuous measurement services.',
    `data_source_system` STRING COMMENT 'The name of the source system or platform from which the market research study data and metadata were extracted (e.g., Nielsen IQ, Kantar Portal, internal research repository).',
    `market_research_study_description` STRING COMMENT 'The market research study description of the market research study record',
    `effective_from` DATE COMMENT 'The effective from of the market research study record',
    `effective_until` DATE COMMENT 'The effective until of the market research study record',
    `field_end_date` DATE COMMENT 'The field end date of the market research study record',
    `field_start_date` DATE COMMENT 'The field start date of the market research study record',
    `fieldwork_end_date` DATE COMMENT 'The date when data collection or fieldwork for the research study was completed.',
    `fieldwork_start_date` DATE COMMENT 'The date when data collection or fieldwork for the research study began.',
    `household_penetration_pct` DECIMAL(18,2) COMMENT 'The percentage of households in the target market that have purchased the brand or category during the measurement period, as reported by consumer panel data.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the market research study record is currently active and relevant for reporting and analysis.',
    `key_findings` STRING COMMENT 'The key findings of the market research study record',
    `key_findings_summary` STRING COMMENT 'Executive summary of the key insights, findings, and actionable recommendations from the market research study.',
    `market_research_study_status` STRING COMMENT 'The market research study status of the market research study record',
    `methodology` STRING COMMENT 'Detailed description of the research methodology employed, including sampling approach, data collection method (online survey, in-person interview, focus group, panel tracking), and analytical techniques.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the market research study record was last modified or updated.',
    `market_research_study_name` STRING COMMENT 'The market research study name of the market research study record',
    `notes` STRING COMMENT 'The notes of the market research study record',
    `nps_score` STRING COMMENT 'The Net Promoter Score calculated from the research study, measuring customer loyalty and likelihood to recommend the brand on a scale from -100 to +100.',
    `purchase_frequency` DECIMAL(18,2) COMMENT 'The average number of purchase occasions per buying household during the measurement period, as reported by consumer panel data.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the market research study record',
    `repeat_rate_pct` DECIMAL(18,2) COMMENT 'The percentage of buyers who made repeat purchases of the brand or product during the measurement period, indicating loyalty and retention.',
    `research_agency_name` STRING COMMENT 'The name of the external market research agency or syndicated data provider conducting or supplying the study (e.g., Nielsen IQ, Kantar, Circana, Ipsos).',
    `research_objective` STRING COMMENT 'The primary business objective or research question that the study was designed to address (e.g., measure brand health, test new product concept, understand usage barriers, track competitive dynamics).',
    `research_type` STRING COMMENT 'The type or methodology of the market research study. Includes quantitative surveys, qualitative focus groups, usage and attitude (U&A) studies, concept testing, packaging tests, Net Promoter Score (NPS) surveys, brand health trackers, and consumer panel subscriptions. [ENUM-REF-CANDIDATE: quantitative|qualitative|usage_and_attitude|concept_test|pack_test|nps|brand_health_tracker|consumer_panel — 8 candidates stripped; promote to reference product]',
    `sample_size` STRING COMMENT 'The total number of respondents or households included in the research study sample.',
    `source_system_code` STRING COMMENT 'The unique identifier of the market research study in the source system or research agency platform.',
    `study_code` STRING COMMENT 'The unique business identifier or project code assigned to the market research study for tracking and reference purposes.',
    `study_investment_amount` DECIMAL(18,2) COMMENT 'The total financial investment or cost incurred for commissioning and conducting the market research study, including agency fees, fieldwork costs, and data licensing.',
    `study_name` STRING COMMENT 'The official name or title of the market research study or syndicated data subscription.',
    `study_status` STRING COMMENT 'The current lifecycle status of the market research study. Tracks progression from planning through fieldwork, analysis, and completion.. Valid values are `planned|in_fieldwork|analysis|completed|cancelled|on_hold`',
    `study_type` STRING COMMENT 'The study type of the market research study record',
    `subscription_end_date` DATE COMMENT 'The end date or renewal date of the syndicated data subscription or continuous panel tracking service.',
    `subscription_start_date` DATE COMMENT 'The start date of the syndicated data subscription or continuous panel tracking service.',
    `subscription_type` STRING COMMENT 'Indicates whether the research study is a one-time project or part of an ongoing syndicated data subscription with periodic updates.. Valid values are `one_time|annual|quarterly|monthly|continuous`',
    `switching_behavior_index` DECIMAL(18,2) COMMENT 'A metric indicating the rate at which consumers switch between brands within the category, as measured by consumer panel data.',
    `target_audience` STRING COMMENT 'Description of the target consumer segment or demographic profile for the research study (e.g., women 25-45, households with children, premium beauty buyers).',
    `target_market` STRING COMMENT 'The geographic market or region where the research study is being conducted (e.g., North America, Western Europe, APAC).',
    `uom` STRING COMMENT 'The uom of the market research study record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the market research study record',
    CONSTRAINT pk_market_research_study PRIMARY KEY(`market_research_study_id`)
) COMMENT 'Master record for each market research study or syndicated data subscription commissioned or conducted by Consumer Goods. Captures study name, research type (quantitative, qualitative, U&A, concept test, pack test, NPS, brand health tracker, consumer panel), research agency/data provider (Nielsen IQ, Kantar, Circana, Ipsos), fieldwork dates, target market, sample size, methodology, status, key findings summary, and periodic panel metrics (household penetration, purchase frequency, basket size, repeat rate, switching behavior, buyer demographics). Serves as the SSOT for all primary and syndicated research investment, output tracking, and consumer panel insight management. Enables research ROI tracking and insight activation across brand strategy.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` (
    `brand_health_tracker_id` BIGINT COMMENT 'Unique identifier for the brand health tracking record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Brand health metrics are overseen by a brand health analyst; needed for audit, KPI ownership, and resource planning.',
    `category_id` BIGINT COMMENT 'Reference to the product category for which brand health is tracked.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the primary competing brand used for benchmarking.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Brand health metrics are evaluated per R&D project to measure impact of new product introductions on brand equity.',
    `aided_awareness_pct` DECIMAL(18,2) COMMENT 'Percentage of consumers who recognize the brand when prompted with a list of brands in the category.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the brand health tracker record',
    `awareness_pct` DECIMAL(18,2) COMMENT 'The awareness pct of the brand health tracker record',
    `brand_equity_index` DECIMAL(18,2) COMMENT 'Composite index score measuring overall brand strength combining awareness, consideration, preference, and loyalty metrics.',
    `brand_health_tracker_status` STRING COMMENT 'The brand health tracker status of the brand health tracker record',
    `brand_spend_amount` DECIMAL(18,2) COMMENT 'Total advertising spend for this brand during the measurement period.',
    `channel_type` STRING COMMENT 'Distribution channel context for the brand health measurement.. Valid values are `retail|ecommerce|dtc|wholesale|all_channels`',
    `brand_health_tracker_code` STRING COMMENT 'The brand health tracker code of the brand health tracker record',
    `competitor_som_value_pct` DECIMAL(18,2) COMMENT 'Primary competitor share of market by value for benchmarking purposes.',
    `competitor_sov_total_pct` DECIMAL(18,2) COMMENT 'Primary competitor total share of voice for benchmarking purposes.',
    `consideration_pct` DECIMAL(18,2) COMMENT 'Percentage of consumers who would consider purchasing the brand.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand health tracking record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Primary data source provider for this brand health tracking record.. Valid values are `nielsen_iq|kantar|circana|brandwatch|sprinklr|proprietary_study`',
    `brand_health_tracker_description` STRING COMMENT 'The brand health tracker description of the brand health tracker record',
    `effective_from` DATE COMMENT 'The effective from of the brand health tracker record',
    `effective_until` DATE COMMENT 'The effective until of the brand health tracker record',
    `equity_index` DECIMAL(18,2) COMMENT 'The equity index of the brand health tracker record',
    `innovation_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for brand innovation attribute on a scale of 1-10.',
    `market_geography` STRING COMMENT 'Geographic market where brand health is measured (country, region, or city).',
    `measurement_date` DATE COMMENT 'The measurement date of the brand health tracker record',
    `measurement_period` STRING COMMENT 'The measurement period of the brand health tracker record',
    `measurement_timestamp` TIMESTAMP COMMENT 'Timestamp when the brand health metrics were measured or compiled.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand health tracking record was last modified.',
    `brand_health_tracker_name` STRING COMMENT 'The brand health tracker name of the brand health tracker record',
    `net_sentiment_score` DECIMAL(18,2) COMMENT 'Net sentiment score calculated as positive percentage minus negative percentage, ranging from -100 to +100.',
    `notes` STRING COMMENT 'The notes of the brand health tracker record',
    `nps_score` DECIMAL(18,2) COMMENT 'Net Promoter Score measuring likelihood of consumers to recommend the brand, calculated as percentage of promoters minus percentage of detractors.',
    `preference_pct` DECIMAL(18,2) COMMENT 'Percentage of consumers who prefer this brand over competitors in the category.',
    `purchase_intent_pct` DECIMAL(18,2) COMMENT 'Percentage of consumers who intend to purchase the brand in the next purchase cycle.',
    `quality_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for product quality attribute on a scale of 1-10.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the brand health tracker record',
    `region` STRING COMMENT 'The region of the brand health tracker record',
    `share_of_conversation_pct` DECIMAL(18,2) COMMENT 'Brand share of total social media conversation volume within the category.',
    `social_mention_volume` BIGINT COMMENT 'Total number of social media mentions for the brand during the tracking period.',
    `social_sentiment_negative_pct` DECIMAL(18,2) COMMENT 'Percentage of social media mentions with negative sentiment during the tracking period.',
    `social_sentiment_neutral_pct` DECIMAL(18,2) COMMENT 'Percentage of social media mentions with neutral sentiment during the tracking period.',
    `social_sentiment_positive_pct` DECIMAL(18,2) COMMENT 'Percentage of social media mentions with positive sentiment during the tracking period.',
    `som_value_pct` DECIMAL(18,2) COMMENT 'Brand share of total category sales measured by value (revenue) for the period and geography.',
    `som_volume_pct` DECIMAL(18,2) COMMENT 'Brand share of total category sales measured by volume (units) for the period and geography.',
    `source_system_code` STRING COMMENT 'The source system code of the brand health tracker record',
    `sov_digital_pct` DECIMAL(18,2) COMMENT 'Share of voice for digital advertising (display, search, video) as percentage of total category digital spend.',
    `sov_ooh_pct` DECIMAL(18,2) COMMENT 'Share of voice for out-of-home advertising (billboards, transit, etc.) as percentage of total category OOH spend.',
    `sov_social_pct` DECIMAL(18,2) COMMENT 'Share of voice for social media advertising as percentage of total category social spend.',
    `sov_total_pct` DECIMAL(18,2) COMMENT 'Total share of voice across all media channels as percentage of total category advertising spend.',
    `sov_tv_pct` DECIMAL(18,2) COMMENT 'Share of voice for television advertising as percentage of total category TV spend.',
    `spontaneous_awareness_pct` DECIMAL(18,2) COMMENT 'Percentage of consumers who mention the brand unprompted when asked about the category.',
    `sustainability_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for environmental and social responsibility attribute on a scale of 1-10.',
    `total_category_spend_amount` DECIMAL(18,2) COMMENT 'Total advertising spend across all brands in the category for the measurement period.',
    `tracking_period_end_date` DATE COMMENT 'End date of the brand health measurement period.',
    `tracking_period_start_date` DATE COMMENT 'Start date of the brand health measurement period.',
    `trust_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for brand trust and reliability attribute on a scale of 1-10.',
    `uom` STRING COMMENT 'The uom of the brand health tracker record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the brand health tracker record',
    `value_perception_score` DECIMAL(18,2) COMMENT 'Consumer perception score for value-for-money attribute on a scale of 1-10.',
    CONSTRAINT pk_brand_health_tracker PRIMARY KEY(`brand_health_tracker_id`)
) COMMENT 'Consolidated periodic brand performance scorecard capturing all consumer perception, market position, competitive share, media share, and social sentiment metrics for a brand in a specific market and time period. Captures awareness (spontaneous, aided), consideration, preference, purchase intent, NPS, brand equity index, SOV% (Share of Voice by channel — TV, digital, OOH, social), SOM% (value share, volume share by category/channel/geography), total category spend, competitor benchmarks, social sentiment scores (positive/neutral/negative breakdown), mention volume, share of conversation, platform distribution, net sentiment score, and key image attribute scores. Sourced from Nielsen Ad Intel/Kantar media monitoring (SOV), Nielsen IQ Retail Measurement/Circana (SOM), proprietary brand tracking studies (awareness/equity), and social listening platforms (sentiment). Serves as the single authoritative brand scorecard enabling longitudinal brand health monitoring, SOV vs. SOM gap analysis, competitive benchmarking, market share trend tracking, and sentiment trend analysis.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` (
    `sov_measurement_id` BIGINT COMMENT 'Unique identifier for the Share of Voice measurement record.',
    `campaign_id` BIGINT COMMENT 'The campaign id of the sov measurement record',
    `employee_id` BIGINT COMMENT 'Identifier of the marketing analyst or user who created or validated the Share of Voice measurement record.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand being measured for Share of Voice.',
    `category_id` BIGINT COMMENT 'Identifier of the product category for which Share of Voice is measured.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the sov measurement record',
    `brand_rank` STRING COMMENT 'Rank of the brand by Share of Voice within the category (1 = highest SOV).',
    `brand_som_percentage` DECIMAL(18,2) COMMENT 'The brands Share of Market (sales-based market share) during the same measurement period, used for SOV vs. SOM gap analysis.',
    `brand_sov_percentage` DECIMAL(18,2) COMMENT 'The brands Share of Voice as a percentage of total category advertising spend during the measurement period.',
    `brand_spend` DECIMAL(18,2) COMMENT 'The brand spend of the sov measurement record',
    `brand_spend_amount` DECIMAL(18,2) COMMENT 'Total advertising spend by the brand during the measurement period.',
    `sov_measurement_category` STRING COMMENT 'The sov measurement category of the sov measurement record',
    `category_spend` DECIMAL(18,2) COMMENT 'The category spend of the sov measurement record',
    `channel` STRING COMMENT 'The channel of the sov measurement record',
    `sov_measurement_code` STRING COMMENT 'The sov measurement code of the sov measurement record',
    `competitor_count` STRING COMMENT 'Number of competitor brands included in the category Share of Voice calculation.',
    `competitor_set` STRING COMMENT 'The competitor set of the sov measurement record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the Share of Voice measurement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for spend amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Source system or vendor providing the Share of Voice measurement data (e.g., Nielsen Ad Intel, Kantar Media, Comscore).. Valid values are `Nielsen Ad Intel|Kantar Media|Comscore|Internal`',
    `sov_measurement_description` STRING COMMENT 'The sov measurement description of the sov measurement record',
    `effective_from` DATE COMMENT 'The effective from of the sov measurement record',
    `effective_until` DATE COMMENT 'The effective until of the sov measurement record',
    `frequency` DECIMAL(18,2) COMMENT 'Average number of times the target audience was exposed to the brands advertising during the measurement period.',
    `grp` DECIMAL(18,2) COMMENT 'Gross Rating Points achieved by the brand during the measurement period, representing reach multiplied by frequency.',
    `impressions_count` BIGINT COMMENT 'Total number of advertising impressions delivered by the brand during the measurement period.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the Share of Voice measurement record is currently active (True) or archived (False).',
    `market_geography` STRING COMMENT 'Geographic market where the Share of Voice is measured (e.g., USA, GBR, DEU).',
    `measurement_date` DATE COMMENT 'Date when the Share of Voice measurement was calculated and recorded.',
    `measurement_methodology` STRING COMMENT 'Methodology used to calculate Share of Voice (e.g., spend-based, impression-based, GRP-based).',
    `measurement_period` STRING COMMENT 'The measurement period of the sov measurement record',
    `measurement_period_end_date` DATE COMMENT 'End date of the Share of Voice measurement period.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the Share of Voice measurement period.',
    `measurement_status` STRING COMMENT 'Status of the Share of Voice measurement record (Preliminary, Final, Revised, Archived).. Valid values are `Preliminary|Final|Revised|Archived`',
    `media_channel` STRING COMMENT 'Media channel through which advertising spend is measured (TV, Digital, Radio, Print, Out-of-Home, Social Media).. Valid values are `TV|Digital|Radio|Print|OOH|Social Media`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the Share of Voice measurement record was last modified.',
    `sov_measurement_name` STRING COMMENT 'The sov measurement name of the sov measurement record',
    `notes` STRING COMMENT 'Additional notes or commentary regarding the Share of Voice measurement, including data quality issues, anomalies, or contextual information.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the sov measurement record',
    `reach_percentage` DECIMAL(18,2) COMMENT 'Percentage of the target audience reached by the brands advertising during the measurement period.',
    `share_of_spend_pct` DECIMAL(18,2) COMMENT 'The share of spend pct of the sov measurement record',
    `share_of_voice_pct` DECIMAL(18,2) COMMENT 'The share of voice pct of the sov measurement record',
    `source_system_code` STRING COMMENT 'Unique identifier of the Share of Voice measurement record in the source system.',
    `sov_measurement_status` STRING COMMENT 'The sov measurement status of the sov measurement record',
    `sov_percent` DECIMAL(18,2) COMMENT 'The sov percent of the sov measurement record',
    `sov_som_gap` DECIMAL(18,2) COMMENT 'Difference between brand SOV percentage and brand SOM percentage (SOV - SOM). Positive gap indicates over-investment; negative gap indicates under-investment.',
    `top_competitor_brand_name` STRING COMMENT 'Name of the competitor brand with the highest Share of Voice in the category during the measurement period.',
    `top_competitor_sov_percentage` DECIMAL(18,2) COMMENT 'Share of Voice percentage of the top competitor brand in the category.',
    `total_category_spend_amount` DECIMAL(18,2) COMMENT 'Total advertising spend across all brands in the category during the measurement period.',
    `uom` STRING COMMENT 'The uom of the sov measurement record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sov measurement record',
    CONSTRAINT pk_sov_measurement PRIMARY KEY(`sov_measurement_id`)
) COMMENT 'Periodic Share of Voice (SOV) measurement record capturing a brands advertising share relative to total category spend across media channels, market, and time period. Captures brand SOV%, competitor SOV%, total category spend, brand spend, channel (TV, digital, OOH, social), data source (Nielsen Ad Intel, Kantar), and measurement period. Enables SOV vs. SOM gap analysis.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` (
    `digital_performance_id` BIGINT COMMENT 'Unique identifier for the digital campaign performance record. Primary key for this transactional performance measurement entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Digital performance metrics are compiled by a marketing analyst; link enables attribution of analysis effort and audit.',
    `campaign_flight_id` BIGINT COMMENT 'Reference to the specific campaign flight or wave. Links this performance record to the flight-level execution plan.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign. Links this performance record to the campaign master data.',
    `creative_asset_id` BIGINT COMMENT 'Identifier for the specific creative asset used in this campaign execution. Links performance to creative master data for creative effectiveness analysis.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand being promoted in this campaign. Links performance to brand master data for brand-level reporting.',
    `media_plan_id` BIGINT COMMENT 'The media plan id of the digital performance record',
    `ad_format` STRING COMMENT 'The specific creative format of the digital ad (e.g., carousel, single image, video, story, banner, interstitial, native). Describes the presentation style of the creative asset.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the digital performance record',
    `attribution_model` STRING COMMENT 'The attribution methodology used to assign conversion credit to this touchpoint. Defines how conversions are credited across the customer journey.. Valid values are `Last Click|First Click|Linear|Time Decay|Position Based|Data Driven`',
    `attribution_window_days` STRING COMMENT 'The number of days after ad interaction during which conversions are attributed to this campaign. Defines the lookback period for conversion tracking.',
    `channel` STRING COMMENT 'The digital marketing channel type. Categorizes the advertising medium (social, search, display, video, programmatic, native, email). [ENUM-REF-CANDIDATE: Social|Search|Display|Video|Programmatic|Native|Email — 7 candidates stripped; promote to reference product]',
    `clicks` BIGINT COMMENT 'Total number of clicks on the ad. Measures user engagement and intent to interact with the campaign.',
    `digital_performance_code` STRING COMMENT 'The digital performance code of the digital performance record',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Conversion rate expressed as a decimal (conversions divided by clicks). Measures the effectiveness of the ad in driving desired actions.',
    `conversion_rate_pct` DECIMAL(18,2) COMMENT 'The conversion rate pct of the digital performance record',
    `conversions` BIGINT COMMENT 'Total number of conversions attributed to this campaign on this date and channel. Represents completed desired actions (purchase, sign-up, download, etc.) as defined by the campaign objective.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total media spend for this campaign on this date and channel. Represents the actual cost incurred for ad delivery.',
    `cpa` DECIMAL(18,2) COMMENT 'Average cost per conversion (total cost divided by conversions). Measures the efficiency of conversion-focused campaigns.',
    `cpc` DECIMAL(18,2) COMMENT 'Average cost per click (total cost divided by clicks). Key efficiency metric for click-based campaigns.',
    `cpm` DECIMAL(18,2) COMMENT 'Cost per thousand impressions (total cost divided by impressions, multiplied by 1000). Standard metric for awareness campaigns.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the digital performance record',
    `ctr` DECIMAL(18,2) COMMENT 'Click-through rate expressed as a decimal (clicks divided by impressions). Key engagement metric indicating ad relevance and creative effectiveness.',
    `ctr_pct` DECIMAL(18,2) COMMENT 'The ctr pct of the digital performance record',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount (e.g., USD, EUR, GBP). Enables multi-currency campaign performance tracking.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The source system or API from which this performance data was ingested (e.g., Meta Ads API, Google Ads API, TikTok Ads Manager). Tracks data lineage and integration source.',
    `digital_performance_description` STRING COMMENT 'The digital performance description of the digital performance record',
    `device_type` STRING COMMENT 'The device category on which the ad was served and performance was measured. Segments performance by device form factor.. Valid values are `Mobile|Desktop|Tablet|Connected TV|Other`',
    `digital_performance_status` STRING COMMENT 'The digital performance status of the digital performance record',
    `effective_from` DATE COMMENT 'The effective from of the digital performance record',
    `effective_until` DATE COMMENT 'The effective until of the digital performance record',
    `frequency` DECIMAL(18,2) COMMENT 'Average number of times each unique user saw the ad (impressions divided by reach). Measures ad exposure intensity per user.',
    `geography` STRING COMMENT 'Three-letter ISO country code representing the geographic market where the ad was served. Enables market-level performance analysis.. Valid values are `^[A-Z]{3}$`',
    `impressions` BIGINT COMMENT 'Total number of times the ad was displayed to users. Represents the reach volume of the campaign on this date and channel.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance record was ingested into the lakehouse from the source platform API. Supports data freshness monitoring and audit trail.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this performance record is currently active and should be included in reporting. Supports soft-delete and data quality management.',
    `measurement_date` DATE COMMENT 'The date on which this digital performance was measured and recorded. Represents the business event timestamp for this transactional record at campaign-channel-date grain.',
    `digital_performance_name` STRING COMMENT 'The digital performance name of the digital performance record',
    `notes` STRING COMMENT 'The notes of the digital performance record',
    `performance_date` DATE COMMENT 'The performance date of the digital performance record',
    `placement_type` STRING COMMENT 'The specific placement or inventory type within the platform (e.g., feed, stories, in-stream, search results, display network). Identifies where the ad appeared within the platform ecosystem.',
    `platform` STRING COMMENT 'The digital advertising platform where the campaign was executed. Identifies the ad network or publisher platform (e.g., Meta, Google, TikTok, programmatic DSP). [ENUM-REF-CANDIDATE: Meta|Google|TikTok|Programmatic DSP|YouTube|LinkedIn|Twitter — 7 candidates stripped; promote to reference product]',
    `product_category` STRING COMMENT 'The product category being promoted in this campaign. Enables category-level performance analysis and cross-category comparison.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the digital performance record',
    `reach` BIGINT COMMENT 'Total number of unique users who saw the ad at least once. Measures unduplicated audience size exposed to the campaign.',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue attributed to conversions from this campaign on this date and channel. Used to calculate ROAS and campaign profitability.',
    `roas` DECIMAL(18,2) COMMENT 'Return on ad spend expressed as a ratio (revenue generated divided by cost). Key profitability metric for performance marketing campaigns.',
    `source_system_code` STRING COMMENT 'The source system code of the digital performance record',
    `spend` DECIMAL(18,2) COMMENT 'The spend of the digital performance record',
    `target_audience` STRING COMMENT 'Description of the target audience segment for this campaign execution. Defines the demographic, behavioral, or interest-based targeting criteria applied.',
    `uom` STRING COMMENT 'The uom of the digital performance record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the digital performance record',
    `video_completion_rate` DECIMAL(18,2) COMMENT 'Percentage of video views that were watched to completion. Expressed as a decimal. Measures video creative engagement quality.',
    `video_quartile_25_pct` DECIMAL(18,2) COMMENT 'Percentage of video views that reached the 25% completion point. Expressed as a decimal. Tracks early engagement drop-off.',
    `video_quartile_50_pct` DECIMAL(18,2) COMMENT 'Percentage of video views that reached the 50% completion point (midpoint). Expressed as a decimal. Measures sustained viewer interest.',
    `video_quartile_75_pct` DECIMAL(18,2) COMMENT 'Percentage of video views that reached the 75% completion point. Expressed as a decimal. Indicates strong creative engagement.',
    `video_views` BIGINT COMMENT 'Total number of video views for video ad formats. Counts views meeting the platforms minimum view threshold (typically 3 seconds or more).',
    `view_through_conversions` BIGINT COMMENT 'Number of conversions attributed to users who viewed but did not click the ad, then converted within the attribution window. Measures passive ad influence.',
    CONSTRAINT pk_digital_performance PRIMARY KEY(`digital_performance_id`)
) COMMENT 'Transactional record of digital campaign performance metrics captured at the campaign-channel-date grain. Captures impressions, clicks, CTR, video views, view-through rate, conversions, cost-per-click (CPC), cost-per-acquisition (CPA), ROAS (Return on Ad Spend), reach, frequency, and platform (Meta, Google, TikTok, programmatic DSP). Sourced from digital ad platforms via API integration.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` (
    `attribution_id` BIGINT COMMENT 'Primary key for attribution',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Attribution models are maintained by an analyst; linking provides accountability and traceability for model changes.',
    `sku_id` BIGINT COMMENT 'Identifier of the product purchased or converted in the attributed event.',
    `attribution_sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Attribution models assign conversion revenue to specific SKUs; FK ensures accurate SKU‑level performance metrics.',
    `campaign_flight_id` BIGINT COMMENT 'Identifier of the specific campaign flight (time-bound execution) receiving attribution credit.',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign receiving attribution credit for this conversion.',
    `creative_asset_id` BIGINT COMMENT 'Identifier of the creative asset (ad, banner, video) shown at this touchpoint.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand associated with the attributed conversion.',
    `shopper_id` BIGINT COMMENT 'Identifier of the consumer who completed the conversion or purchase event.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the attribution record',
    `attributed_conversions` DECIMAL(18,2) COMMENT 'Fractional conversion count credited to this touchpoint (e.g., 0.25 conversions for 25% attribution weight).',
    `attributed_revenue` DECIMAL(18,2) COMMENT 'The attributed revenue of the attribution record',
    `attributed_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue amount credited to this touchpoint based on the attribution weight.',
    `attribution_status` STRING COMMENT 'Status of the attribution record (final, provisional, recalculated, voided).. Valid values are `final|provisional|recalculated|voided`',
    `calculation_timestamp` TIMESTAMP COMMENT 'Date and time when the attribution calculation was performed.',
    `channel` STRING COMMENT 'Marketing channel that received attribution credit (paid search, organic search, display, social media, email, affiliate, direct, referral, video, mobile app, TV, radio, print, outdoor, in-store). [ENUM-REF-CANDIDATE: paid_search|organic_search|display|social_media|email|affiliate|direct|referral|video|mobile_app|tv|radio|print|outdoor|in_store — 15 candidates stripped; promote to reference product]',
    `attribution_code` STRING COMMENT 'The attribution code of the attribution record',
    `conversion_event_code` BIGINT COMMENT 'Identifier of the conversion event (purchase, sign-up, download) being attributed.',
    `conversion_timestamp` TIMESTAMP COMMENT 'Date and time when the conversion event occurred.',
    `conversion_type` STRING COMMENT 'Type of conversion event being attributed (purchase, add-to-cart, sign-up, download, lead, subscription, trial, engagement). [ENUM-REF-CANDIDATE: purchase|add_to_cart|sign_up|download|lead|subscription|trial|engagement — 8 candidates stripped; promote to reference product]',
    `cpa` DECIMAL(18,2) COMMENT 'Cost per acquisition for this attributed touchpoint (media spend attributed / attributed conversions).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this attribution record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for attributed revenue amount.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Source system or platform that provided the attribution data (Google Analytics, Adobe Analytics, internal MTA platform, etc.).',
    `attribution_description` STRING COMMENT 'The attribution description of the attribution record',
    `device_type` STRING COMMENT 'Type of device used by the consumer at this touchpoint (desktop, mobile, tablet, smart TV, wearable, other).. Valid values are `desktop|mobile|tablet|smart_tv|wearable|other`',
    `effective_from` DATE COMMENT 'The effective from of the attribution record',
    `effective_until` DATE COMMENT 'The effective until of the attribution record',
    `geography` STRING COMMENT 'Three-letter country code where the conversion occurred.. Valid values are `^[A-Z]{3}$`',
    `is_direct_conversion` BOOLEAN COMMENT 'Flag indicating whether this was a direct conversion with no prior touchpoints (True/False).',
    `is_view_through` BOOLEAN COMMENT 'Flag indicating whether this touchpoint was a view-through impression (ad viewed but not clicked) (True/False).',
    `lookback_window_days` STRING COMMENT 'Number of days in the attribution lookback window used to identify contributing touchpoints.',
    `market_segment` STRING COMMENT 'Consumer market segment targeted by the attributed campaign.',
    `measurement_window_days` STRING COMMENT 'The measurement window days of the attribution record',
    `media_spend_attributed_amount` DECIMAL(18,2) COMMENT 'Portion of media spend allocated to this touchpoint based on attribution weight.',
    `model` STRING COMMENT 'The model of the attribution record',
    `model_type` STRING COMMENT 'Type of attribution model applied to assign credit (last-touch, first-touch, linear, time-decay, position-based, data-driven MTA).. Valid values are `last_touch|first_touch|linear|time_decay|position_based|data_driven`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this attribution record was last modified.',
    `attribution_name` STRING COMMENT 'The attribution name of the attribution record',
    `notes` STRING COMMENT 'Additional notes or comments about this attribution record.',
    `platform` STRING COMMENT 'Digital platform or publisher where the touchpoint occurred (Google Ads, Facebook, Instagram, YouTube, etc.).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the attribution record',
    `roas` DECIMAL(18,2) COMMENT 'Return on Ad Spend calculated for this attributed touchpoint (attributed revenue / media spend attributed).',
    `sku` STRING COMMENT 'Stock Keeping Unit code of the product involved in the conversion event.',
    `source_system_code` STRING COMMENT 'The source system code of the attribution record',
    `time_to_conversion_hours` DECIMAL(18,2) COMMENT 'Number of hours elapsed between this touchpoint and the final conversion event.',
    `total_touchpoints` STRING COMMENT 'Total number of marketing touchpoints in the consumer journey leading to this conversion.',
    `touchpoint` STRING COMMENT 'The touchpoint of the attribution record',
    `touchpoint_sequence_number` STRING COMMENT 'Position of this touchpoint in the consumer journey sequence (1 = first touch, N = last touch).',
    `touchpoint_timestamp` TIMESTAMP COMMENT 'Date and time when this specific marketing touchpoint occurred.',
    `uom` STRING COMMENT 'The uom of the attribution record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the attribution record',
    `weight` DECIMAL(18,2) COMMENT 'Fractional credit assigned to this touchpoint by the attribution model (0.0000 to 1.0000, sum across all touchpoints = 1.0).',
    CONSTRAINT pk_attribution PRIMARY KEY(`attribution_id`)
) COMMENT 'Marketing attribution record linking consumer purchase or conversion events to contributing marketing touchpoints (campaign, channel, creative) using a defined attribution model (last-touch, first-touch, linear, data-driven, MTA). Captures attributed revenue, attributed conversions, attribution model type, touchpoint sequence, channel contribution weight, and brand. Enables ROI measurement across the marketing mix.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` (
    `social_listening_record_id` BIGINT COMMENT 'Unique identifier for the social listening record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Social listening reports are authored by a social media analyst; required for report sign‑off and workload tracking.',
    `campaign_id` BIGINT COMMENT 'The campaign id of the social listening record record',
    `category_id` BIGINT COMMENT 'Reference to the product category being monitored.',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand being monitored in this social listening record.',
    `sku_id` BIGINT COMMENT 'Reference to the specific product being monitored, if applicable.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the social listening record record',
    `capture_date` DATE COMMENT 'The capture date of the social listening record record',
    `social_listening_record_code` STRING COMMENT 'The social listening record code of the social listening record record',
    `competitive_brand_mention_flag` BOOLEAN COMMENT 'Indicates whether competitive brands were mentioned alongside the monitored brand.',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where mentions originated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this social listening record was first created in the system.',
    `crisis_alert_flag` BOOLEAN COMMENT 'Indicates whether the mention volume or sentiment triggered a brand crisis alert threshold.',
    `currency_code` STRING COMMENT 'The currency code of the social listening record record',
    `data_collection_timestamp` TIMESTAMP COMMENT 'Timestamp when the social listening data was collected from the source platform.',
    `data_source_provider` STRING COMMENT 'Name of the social listening platform or vendor that provided the data (e.g., Brandwatch, Sprinklr, Talkwalker).',
    `social_listening_record_description` STRING COMMENT 'The social listening record description of the social listening record record',
    `effective_from` DATE COMMENT 'The effective from of the social listening record record',
    `effective_until` DATE COMMENT 'The effective until of the social listening record record',
    `engagement` BIGINT COMMENT 'The engagement of the social listening record record',
    `engagement_count` BIGINT COMMENT 'Total engagement actions (likes, shares, comments, retweets) across all mentions.',
    `facebook_mention_count` BIGINT COMMENT 'Number of mentions originating from Facebook platform.',
    `geography_scope` STRING COMMENT 'Geographic scope of the social listening monitoring.. Valid values are `global|regional|country|local`',
    `impressions_estimate` BIGINT COMMENT 'Estimated total number of times the mentions were displayed.',
    `influencer_mention_count` BIGINT COMMENT 'Number of mentions originating from identified influencer accounts.',
    `instagram_mention_count` BIGINT COMMENT 'Number of mentions originating from Instagram platform.',
    `language_codes` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes detected in the mentions.',
    `mention_count` BIGINT COMMENT 'The mention count of the social listening record record',
    `mention_volume` BIGINT COMMENT 'The mention volume of the social listening record record',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this social listening record was last modified.',
    `monitoring_topic` STRING COMMENT 'The specific topic, keyword, or hashtag being monitored in social media channels.',
    `social_listening_record_name` STRING COMMENT 'The social listening record name of the social listening record record',
    `negative_mention_count` BIGINT COMMENT 'Number of mentions classified as negative sentiment.',
    `negative_pct` DECIMAL(18,2) COMMENT 'The negative pct of the social listening record record',
    `net_sentiment_score` DECIMAL(18,2) COMMENT 'Calculated net sentiment score representing overall sentiment balance, typically ranging from -100 to +100.',
    `neutral_mention_count` BIGINT COMMENT 'Number of mentions classified as neutral sentiment.',
    `notes` STRING COMMENT 'The notes of the social listening record record',
    `observation_period_end_date` DATE COMMENT 'The end date of the time period for which social listening data was collected.',
    `observation_period_start_date` DATE COMMENT 'The start date of the time period for which social listening data was collected.',
    `platform` STRING COMMENT 'The platform of the social listening record record',
    `positive_mention_count` BIGINT COMMENT 'Number of mentions classified as positive sentiment.',
    `positive_pct` DECIMAL(18,2) COMMENT 'The positive pct of the social listening record record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the social listening record record',
    `reach` BIGINT COMMENT 'The reach of the social listening record record',
    `reach_estimate` BIGINT COMMENT 'Estimated number of unique users who were exposed to the mentions.',
    `record_date` DATE COMMENT 'The record date of the social listening record record',
    `reddit_mention_count` BIGINT COMMENT 'Number of mentions originating from Reddit platform.',
    `sentiment_analysis_model` STRING COMMENT 'Name or version of the sentiment analysis algorithm or model used to classify mentions.',
    `sentiment_label` STRING COMMENT 'The sentiment label of the social listening record record',
    `sentiment_score` DECIMAL(18,2) COMMENT 'The sentiment score of the social listening record record',
    `share_of_conversation_percent` DECIMAL(18,2) COMMENT 'Percentage of total category or competitive conversation captured by this brand or product.',
    `social_listening_record_status` STRING COMMENT 'The social listening record status of the social listening record record',
    `source_system_code` STRING COMMENT 'Unique identifier of this record in the source system.',
    `tiktok_mention_count` BIGINT COMMENT 'Number of mentions originating from TikTok platform.',
    `top_theme_1` STRING COMMENT 'The most frequently discussed theme or topic within the mentions.',
    `top_theme_2` STRING COMMENT 'The second most frequently discussed theme or topic within the mentions.',
    `top_theme_3` STRING COMMENT 'The third most frequently discussed theme or topic within the mentions.',
    `topic` STRING COMMENT 'The topic of the social listening record record',
    `total_mention_volume` BIGINT COMMENT 'Total number of social media mentions captured during the observation period.',
    `twitter_mention_count` BIGINT COMMENT 'Number of mentions originating from Twitter/X platform.',
    `uom` STRING COMMENT 'The uom of the social listening record record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the social listening record record',
    `youtube_mention_count` BIGINT COMMENT 'Number of mentions originating from YouTube platform.',
    CONSTRAINT pk_social_listening_record PRIMARY KEY(`social_listening_record_id`)
) COMMENT 'Transactional record of social media listening and sentiment monitoring results for a brand, product, or topic at a given time period. Captures mention volume, sentiment breakdown (positive, neutral, negative), share of conversation, top themes, platform distribution (Twitter/X, Instagram, TikTok, Reddit, YouTube), net sentiment score, and data source. Enables consumer sentiment trend analysis and brand reputation monitoring.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` (
    `nielsen_panel_insight_id` BIGINT COMMENT 'Unique identifier for the Nielsen panel insight record. Primary key for this data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Nielsen insights are analyzed by a market analyst; link supports audit of insight generation and analyst KPI.',
    `category_id` BIGINT COMMENT 'Identifier for the product category to which this panel insight applies.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier for the brand to which this panel insight applies.',
    `sku_id` BIGINT COMMENT 'Identifier for the specific SKU to which this panel insight applies. Nullable for category or brand-level insights.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the nielsen panel insight record',
    `average_basket_size` DECIMAL(18,2) COMMENT 'Average quantity (units or volume) purchased per transaction by buying households during the panel period.',
    `average_price_per_unit` DECIMAL(18,2) COMMENT 'Average price paid per unit or volume by panel households during the panel period.',
    `avg_price` DECIMAL(18,2) COMMENT 'The avg price of the nielsen panel insight record',
    `brand_name` STRING COMMENT 'Name of the brand measured in this panel insight.',
    `brand_switching_rate` DECIMAL(18,2) COMMENT 'Percentage of households that switched from this brand to a competitor brand during the panel period. Expressed as a decimal.',
    `buyer_age_group` STRING COMMENT 'Age group classification of the primary buyer in panel households.. Valid values are `18-24|25-34|35-44|45-54|55-64|65+`',
    `buyer_household_size` STRING COMMENT 'Number of people in the buying household.. Valid values are `1|2|3|4|5+`',
    `buyer_income_bracket` STRING COMMENT 'Annual household income bracket of the primary buyer in panel households.. Valid values are `Under 25K|25K-50K|50K-75K|75K-100K|100K-150K|Over 150K`',
    `buyer_presence_of_children` BOOLEAN COMMENT 'Indicates whether children are present in the buying household.',
    `buyer_profile_segment` STRING COMMENT 'Demographic or psychographic segment classification of the primary buyer households (e.g., Millennials with Kids, Affluent Seniors, Budget-Conscious Families).',
    `buying_households_count` BIGINT COMMENT 'Number of panel households that purchased the category, brand, or SKU during the panel period.',
    `nielsen_panel_insight_category` STRING COMMENT 'The nielsen panel insight category of the nielsen panel insight record',
    `nielsen_panel_insight_code` STRING COMMENT 'The nielsen panel insight code of the nielsen panel insight record',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this panel insight record was first created in the lakehouse silver layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the total spend amount (e.g., USD, CAD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `data_extract_date` DATE COMMENT 'Date when this panel insight data was extracted from the Nielsen IQ source system.',
    `data_source_system` STRING COMMENT 'Source system from which this panel insight was extracted (e.g., Nielsen IQ Consumer Panel, Nielsen Homescan).',
    `nielsen_panel_insight_description` STRING COMMENT 'The nielsen panel insight description of the nielsen panel insight record',
    `distribution_acv_pct` DECIMAL(18,2) COMMENT 'The distribution acv pct of the nielsen panel insight record',
    `dollar_sales` DECIMAL(18,2) COMMENT 'The dollar sales of the nielsen panel insight record',
    `effective_from` DATE COMMENT 'The effective from of the nielsen panel insight record',
    `effective_until` DATE COMMENT 'The effective until of the nielsen panel insight record',
    `gtin` STRING COMMENT 'The GTIN (UPC, EAN) of the SKU measured in this panel insight. Nullable for category or brand-level insights.. Valid values are `^d{8}$|^d{12,14}$`',
    `household_penetration_rate` DECIMAL(18,2) COMMENT 'Percentage of panel households that purchased the category, brand, or SKU during the panel period. Expressed as a decimal (e.g., 0.2345 = 23.45%).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this panel insight record is currently active and valid for use in analytics and reporting.',
    `loyalty_index` DECIMAL(18,2) COMMENT 'Nielsen IQ loyalty index score measuring the strength of repeat purchase behavior for this brand or SKU. Higher values indicate stronger loyalty.',
    `market` STRING COMMENT 'The market of the nielsen panel insight record',
    `market_geography` STRING COMMENT 'Geographic market or region covered by this panel insight (e.g., USA, CAN, GBR, DEU).',
    `market_share_pct` DECIMAL(18,2) COMMENT 'The market share pct of the nielsen panel insight record',
    `measurement_level` STRING COMMENT 'Indicates the level of aggregation for this panel insight: category-level, brand-level, or SKU-level.. Valid values are `category|brand|sku`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this panel insight record was last modified in the lakehouse silver layer.',
    `nielsen_panel_insight_name` STRING COMMENT 'The nielsen panel insight name of the nielsen panel insight record',
    `nielsen_panel_insight_status` STRING COMMENT 'The nielsen panel insight status of the nielsen panel insight record',
    `notes` STRING COMMENT 'The notes of the nielsen panel insight record',
    `panel_code` STRING COMMENT 'Unique identifier for the Nielsen consumer panel from which this insight was derived.',
    `panel_name` STRING COMMENT 'The panel name of the nielsen panel insight record',
    `panel_period_end_date` DATE COMMENT 'The end date of the panel measurement period for which this insight was captured.',
    `panel_period_start_date` DATE COMMENT 'The start date of the panel measurement period for which this insight was captured.',
    `period` STRING COMMENT 'The period of the nielsen panel insight record',
    `product_description` STRING COMMENT 'Descriptive name or label of the product measured in this panel insight.',
    `purchase_frequency` DECIMAL(18,2) COMMENT 'Average number of purchase occasions per buying household during the panel period.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the nielsen panel insight record',
    `repeat_purchase_rate` DECIMAL(18,2) COMMENT 'Percentage of buying households that made more than one purchase during the panel period. Expressed as a decimal (e.g., 0.6500 = 65%).',
    `share_of_category_spend` DECIMAL(18,2) COMMENT 'Percentage of total category spend captured by this brand or SKU within the panel. Expressed as a decimal (e.g., 0.1250 = 12.5%).',
    `share_of_category_volume` DECIMAL(18,2) COMMENT 'Percentage of total category volume (units) captured by this brand or SKU within the panel. Expressed as a decimal.',
    `source_system_code` STRING COMMENT 'The source system code of the nielsen panel insight record',
    `total_panel_households` BIGINT COMMENT 'Total number of households in the Nielsen panel for this geography and period.',
    `total_purchase_occasions` BIGINT COMMENT 'Total number of purchase transactions recorded for the category, brand, or SKU during the panel period.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Total dollar amount spent by panel households on the category, brand, or SKU during the panel period.',
    `total_units_purchased` DECIMAL(18,2) COMMENT 'Total quantity (units or volume) of the category, brand, or SKU purchased by panel households during the panel period.',
    `unit_sales` BIGINT COMMENT 'The unit sales of the nielsen panel insight record',
    `uom` STRING COMMENT 'The uom of the nielsen panel insight record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the nielsen panel insight record',
    CONSTRAINT pk_nielsen_panel_insight PRIMARY KEY(`nielsen_panel_insight_id`)
) COMMENT 'Periodic consumer panel insight record sourced from Nielsen IQ panel data. Captures category, brand, SKU-level household penetration, purchase frequency, basket size, repeat rate, switching behavior, buyer profile demographics, and panel period. Serves as the authoritative source for Nielsen IQ consumer panel metrics used in brand and category strategy decisions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` (
    `agency_id` BIGINT COMMENT 'Unique identifier for the marketing agency partner. Primary key for the agency master record.',
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

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` (
    `marketing_budget_id` BIGINT COMMENT 'Unique identifier for the marketing budget allocation record. Primary key.',
    `category_id` BIGINT COMMENT 'Identifier of the product category to which this budget allocation is assigned. Null for brand-level or corporate-level budgets.',
    `cost_center_id` BIGINT COMMENT 'The cost center id of the marketing budget record',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Budget allocations are often earmarked to meet ESG commitments; linking enables financial ESG tracking.',
    `finance_budget_id` BIGINT COMMENT 'FK to authoritative SSOT table finance.finance_budget (cross-domain duplicate resolution).',
    `gl_account_id` BIGINT COMMENT 'The gl account id of the marketing budget record',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand to which this budget allocation is assigned. Null for multi-brand or corporate-level budgets.',
    `employee_id` BIGINT COMMENT 'Identifier of the marketing leader or business owner responsible for managing and executing this budget allocation.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The allocated amount of the marketing budget record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the marketing budget record',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount of the marketing budget record',
    `budget_category` STRING COMMENT 'The budget category of the marketing budget record',
    `budget_code` STRING COMMENT 'The budget code of the marketing budget record',
    `budget_name` STRING COMMENT 'The budget name of the marketing budget record',
    `budget_period` STRING COMMENT 'The budget period of the marketing budget record',
    `marketing_budget_code` STRING COMMENT 'The marketing budget code of the marketing budget record',
    `committed_amount` DECIMAL(18,2) COMMENT 'The committed amount of the marketing budget record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the marketing budget record',
    `currency_code` STRING COMMENT 'The currency code of the marketing budget record',
    `marketing_budget_description` STRING COMMENT 'The marketing budget description of the marketing budget record',
    `effective_from` DATE COMMENT 'The effective from of the marketing budget record',
    `effective_until` DATE COMMENT 'The effective until of the marketing budget record',
    `fiscal_year` STRING COMMENT 'The fiscal year of the marketing budget record',
    `marketing_budget_status` STRING COMMENT 'The marketing budget status of the marketing budget record',
    `marketing_budget_name` STRING COMMENT 'The marketing budget name of the marketing budget record',
    `notes` STRING COMMENT 'The notes of the marketing budget record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the marketing budget record',
    `remaining_amount` DECIMAL(18,2) COMMENT 'The remaining amount of the marketing budget record',
    `source_system_code` STRING COMMENT 'The source system code of the marketing budget record',
    `spent_amount` DECIMAL(18,2) COMMENT 'The spent amount of the marketing budget record',
    `uom` STRING COMMENT 'The uom of the marketing budget record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the marketing budget record',
    CONSTRAINT pk_marketing_budget PRIMARY KEY(`marketing_budget_id`)
) COMMENT 'Marketing budget allocation record capturing planned and approved marketing investment by brand, category, channel, campaign type, and fiscal period. Captures total budget, working media budget, non-working budget, agency fees, research budget, committed spend, actual spend, variance, and budget owner. Distinct from finance domain general ledger — this is the marketing-owned investment planning record. [SSOT: authoritative table is finance.finance_budget; this table is a deprecated duplicate.] [SSOT] Superseded by authoritative table finance.finance_budget for concept budget. SSOT: canonical table is finance.finance_budget. [SSOT: authoritative table is finance.finance_budget; this is a deprecated duplicate for concept budget.] [Non-authoritative; defers to SSOT finance.finance_budget for concept budget.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` (
    `market_share_record_id` BIGINT COMMENT 'Unique identifier for the market share measurement record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Market share reports are produced by an analyst; linking enables responsibility tracking and report version control.',
    `category_id` BIGINT COMMENT 'Identifier of the product category within which market share is calculated.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand for which market share is measured.',
    `sku_id` BIGINT COMMENT 'Identifier of the specific SKU for which market share is measured. Nullable when measurement is at brand or category level.',
    `acv_percent` DECIMAL(18,2) COMMENT 'Percentage of total category sales volume represented by stores carrying the brand or SKU (weighted distribution).',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the market share record record',
    `brand_value_amount` DECIMAL(18,2) COMMENT 'Total sales value (revenue) for the brand or SKU during the measurement period.',
    `brand_volume_quantity` DECIMAL(18,2) COMMENT 'Total sales volume (units) for the brand or SKU during the measurement period.',
    `market_share_record_category` STRING COMMENT 'The market share record category of the market share record record',
    `category_total_value_amount` DECIMAL(18,2) COMMENT 'Total sales value (revenue) for the entire category during the measurement period.',
    `category_total_volume_quantity` DECIMAL(18,2) COMMENT 'Total sales volume (units) for the entire category during the measurement period.',
    `channel` STRING COMMENT 'Retail channel or trade class within which market share is measured (e.g., total market, food, drug, mass, club, convenience, ecommerce). [ENUM-REF-CANDIDATE: total_market|food|drug|mass|club|convenience|ecommerce — 7 candidates stripped; promote to reference product]',
    `market_share_record_code` STRING COMMENT 'The market share record code of the market share record record',
    `confidence_level` STRING COMMENT 'Data quality or confidence level assigned to this measurement (high, medium, low) based on sample size or data completeness.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Source of the market share data (e.g., Nielsen IQ Retail Measurement, IRI/Circana, internal sales data, other syndicated source).. Valid values are `nielsen_iq|iri_circana|internal|other`',
    `data_source_report_code` STRING COMMENT 'Unique identifier or reference number from the source system report.',
    `market_share_record_description` STRING COMMENT 'The market share record description of the market share record record',
    `effective_from` DATE COMMENT 'The effective from of the market share record record',
    `effective_until` DATE COMMENT 'The effective until of the market share record record',
    `geography` STRING COMMENT 'The geography of the market share record record',
    `geography_code` STRING COMMENT 'Code representing the specific geographic area (e.g., country code, state code, metro code) for the measurement.',
    `geography_level` STRING COMMENT 'Geographic granularity at which market share is measured (national, regional, state, metro, local).. Valid values are `national|regional|state|metro|local`',
    `geography_name` STRING COMMENT 'Human-readable name of the geographic area for the measurement.',
    `is_projected` BOOLEAN COMMENT 'Flag indicating whether this record contains projected/estimated data (true) or actual reported data (false).',
    `market` STRING COMMENT 'The market of the market share record record',
    `market_definition` STRING COMMENT 'Description of the market scope and boundaries used for the share calculation (e.g., total category, specific segment, competitive set).',
    `market_share_record_status` STRING COMMENT 'The market share record status of the market share record record',
    `measurement_date` DATE COMMENT 'Date when the market share measurement was captured or reported by the data source.',
    `measurement_period_end_date` DATE COMMENT 'End date of the time period for which market share is measured.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the time period for which market share is measured (e.g., week, month, quarter).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last modified in the data platform.',
    `market_share_record_name` STRING COMMENT 'The market share record name of the market share record record',
    `notes` STRING COMMENT 'Additional notes, commentary, or context about this market share measurement (e.g., data anomalies, market events, methodology changes).',
    `period` STRING COMMENT 'The period of the market share record record',
    `period_type` STRING COMMENT 'Granularity of the measurement period (weekly, monthly, quarterly, yearly).. Valid values are `weekly|monthly|quarterly|yearly`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the market share record record',
    `rank_position` STRING COMMENT 'Competitive rank position of the brand or SKU within the category for this period (1 = market leader).',
    `share_change_pct` DECIMAL(18,2) COMMENT 'The share change pct of the market share record record',
    `share_point_change` DECIMAL(18,2) COMMENT 'Change in value share percentage points compared to the previous comparable period (positive = gain, negative = loss).',
    `source_system_code` STRING COMMENT 'Unique identifier of this record in the source system.',
    `tdp_count` STRING COMMENT 'Total Distribution Points representing the weighted percentage of stores carrying the brand or SKU.',
    `uom` STRING COMMENT 'The uom of the market share record record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the market share record record',
    `value_share_pct` DECIMAL(18,2) COMMENT 'The value share pct of the market share record record',
    `value_share_percent` DECIMAL(18,2) COMMENT 'Market share expressed as a percentage of total category sales value (revenue). Also known as dollar share or revenue share.',
    `volume_share_pct` DECIMAL(18,2) COMMENT 'The volume share pct of the market share record record',
    `volume_share_percent` DECIMAL(18,2) COMMENT 'Market share expressed as a percentage of total category sales volume (units). Also known as unit share.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for volume quantities (e.g., units, cases, liters, kilograms).',
    `year_over_year_change_percent` DECIMAL(18,2) COMMENT 'Percentage change in value share compared to the same period in the prior year.',
    CONSTRAINT pk_market_share_record PRIMARY KEY(`market_share_record_id`)
) COMMENT 'Periodic market share (SOM) measurement record capturing a brands or SKUs value and volume share within a defined category, channel, and geography at a given time period. Captures value share %, volume share %, category total value, brand value, data source (Nielsen IQ Retail Measurement, IRI/Circana), market definition, and period. Enables SOM trend tracking and competitive benchmarking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` (
    `sponsorship_id` BIGINT COMMENT 'Unique identifier for the sponsorship agreement record. Primary key.',
    `agency_id` BIGINT COMMENT 'The agency id of the sponsorship record',
    `campaign_id` BIGINT COMMENT 'The campaign id of the sponsorship record',
    `category_id` BIGINT COMMENT 'Reference to the product category or business unit associated with this sponsorship for portfolio management and reporting.',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Sponsorship contracts include ESG objectives; linking enables monitoring of sustainability outcomes.',
    `gl_account_id` BIGINT COMMENT 'The gl account id of the sponsorship record',
    `marketing_brand_id` BIGINT COMMENT 'Reference to the brand associated with this sponsorship agreement.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or executive who approved this sponsorship agreement.',
    `activation_budget` DECIMAL(18,2) COMMENT 'The activation budget of the sponsorship record',
    `activation_rights` STRING COMMENT 'Detailed description of marketing activation rights granted under the sponsorship, including logo usage, signage, hospitality, content creation, social media, and promotional activities.',
    `agency_partner_name` STRING COMMENT 'Name of the external agency or consultant managing sponsorship activation and measurement.',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the sponsorship record',
    `annual_value_amount` DECIMAL(18,2) COMMENT 'Annual monetary value of the sponsorship agreement, calculated as total contract value divided by contract duration in years.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this sponsorship agreement was formally approved by authorized stakeholders.',
    `sponsorship_code` STRING COMMENT 'Internal business identifier or code used to reference this sponsorship in financial and marketing systems.',
    `contract_document_url` STRING COMMENT 'Reference URL or file path to the signed sponsorship contract document stored in the document management system.',
    `contract_duration_years` DECIMAL(18,2) COMMENT 'The length of the sponsorship contract expressed in years, including fractional years for partial-year agreements.',
    `contract_end_date` DATE COMMENT 'The date when the sponsorship agreement expires or terminates.',
    `contract_start_date` DATE COMMENT 'The date when the sponsorship agreement becomes effective and rights begin.',
    `contract_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the sponsorship contract over its full term.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this sponsorship record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this sponsorship record.. Valid values are `^[A-Z]{3}$`',
    `sponsorship_description` STRING COMMENT 'The sponsorship description of the sponsorship record',
    `effective_from` DATE COMMENT 'The effective from of the sponsorship record',
    `effective_until` DATE COMMENT 'The effective until of the sponsorship record',
    `end_date` DATE COMMENT 'The end date of the sponsorship record',
    `estimated_value` DECIMAL(18,2) COMMENT 'The estimated value of the sponsorship record',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this sponsorship includes category exclusivity rights preventing competitors from sponsoring the same property.',
    `exclusivity_scope` STRING COMMENT 'Description of the scope of exclusivity rights, including product categories, geographic territories, and competitive restrictions.',
    `fee` DECIMAL(18,2) COMMENT 'The fee of the sponsorship record',
    `hospitality_entitlements` STRING COMMENT 'Description of hospitality benefits included in the sponsorship, such as VIP tickets, suite access, meet-and-greet opportunities, and event passes.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this sponsorship record is currently active and valid for reporting and analytics.',
    `measurement_framework` STRING COMMENT 'Description of the measurement methodology and key performance indicators (KPIs) used to evaluate sponsorship effectiveness and ROI.',
    `media_rights` STRING COMMENT 'Description of media and broadcast rights included in the sponsorship, such as commercial time, broadcast mentions, digital content rights, and streaming access.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this sponsorship record was last modified or updated.',
    `sponsorship_name` STRING COMMENT 'The official name or title of the sponsorship agreement as recognized in marketing materials and contracts.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about the sponsorship agreement, activation plans, or special considerations.',
    `objective` STRING COMMENT 'Primary marketing objective or strategic goal for this sponsorship investment. [ENUM-REF-CANDIDATE: brand_awareness|brand_positioning|consumer_engagement|market_entry|loyalty_building|product_launch|corporate_social_responsibility — 7 candidates stripped; promote to reference product]',
    `partner` STRING COMMENT 'The partner of the sponsorship record',
    `payment_schedule` STRING COMMENT 'Description of the payment terms and schedule for the sponsorship contract, including installment amounts and due dates.',
    `performance_obligations` STRING COMMENT 'Contractual performance obligations and deliverables required from the sponsored property, including appearances, content creation, and promotional activities.',
    `property_name` STRING COMMENT 'The name of the sponsored property (e.g., team name, event name, celebrity name, venue name).',
    `property_type` STRING COMMENT 'The category of property being sponsored (e.g., sports team, entertainment event, festival, celebrity, influencer). [ENUM-REF-CANDIDATE: sports_team|sports_league|sports_event|entertainment_event|music_festival|cultural_event|celebrity|influencer|venue|broadcast_property|esports — 11 candidates stripped; promote to reference product]',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the sponsorship record',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the sponsorship contract includes an option for renewal at the end of the current term.',
    `renewal_terms` STRING COMMENT 'Description of the renewal terms, conditions, and pricing structure if renewal option exists.',
    `rights_fee` DECIMAL(18,2) COMMENT 'The rights fee of the sponsorship record',
    `roi_target_percent` DECIMAL(18,2) COMMENT 'Target return on investment percentage for this sponsorship, used for performance evaluation and portfolio optimization.',
    `source_system_code` STRING COMMENT 'The unique identifier for this sponsorship record in the source operational system.',
    `sponsorship_status` STRING COMMENT 'Current lifecycle status of the sponsorship agreement. [ENUM-REF-CANDIDATE: draft|negotiation|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `sponsorship_type` STRING COMMENT 'The sponsorship type of the sponsorship record',
    `start_date` DATE COMMENT 'The start date of the sponsorship record',
    `target_audience` STRING COMMENT 'Description of the target consumer audience or demographic segment this sponsorship is intended to reach.',
    `termination_clause` STRING COMMENT 'Description of contract termination conditions, notice periods, and penalties for early termination by either party.',
    `territory_scope` STRING COMMENT 'Geographic territory or market scope covered by the sponsorship agreement, using three-letter ISO country codes or regional descriptors.',
    `tier` STRING COMMENT 'The level or tier of sponsorship (e.g., title sponsor, presenting sponsor, official sponsor, associate sponsor) indicating prominence and rights.. Valid values are `title|presenting|official|associate|supporting|partner`',
    `uom` STRING COMMENT 'The uom of the sponsorship record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the sponsorship record',
    CONSTRAINT pk_sponsorship PRIMARY KEY(`sponsorship_id`)
) COMMENT 'Master record for brand sponsorship agreements with sports, entertainment, events, or cultural properties. Captures sponsorship name, property type (sports team, event, festival, celebrity), brand, sponsorship tier, contract value, activation rights, exclusivity terms, territory, contract start/end dates, renewal option, and performance obligations. Enables sponsorship portfolio management and ROI tracking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` (
    `marketing_event_id` BIGINT COMMENT 'Unique identifier for the marketing event record. Primary key.',
    `agency_id` BIGINT COMMENT 'FK to marketing.agency',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the event plan.',
    `campaign_id` BIGINT COMMENT 'The campaign id of the marketing event record',
    `esg_commitment_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_commitment. Business justification: Events have sustainability plans tied to ESG commitments; FK supports event ESG reporting.',
    `marketing_brand_id` BIGINT COMMENT 'Identifier of the brand sponsoring or owning this marketing event.',
    `category_id` BIGINT COMMENT 'Identifier of the product category featured in this event.',
    `promotion_event_id` BIGINT COMMENT 'FK to authoritative SSOT table promotion.promotion_event (cross-domain duplicate resolution).',
    `trade_account_id` BIGINT COMMENT 'Identifier of the retail account or customer associated with retailer-focused events.',
    `actual_attendance` STRING COMMENT 'The actual attendance of the marketing event record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the marketing event record',
    `budget_amount` DECIMAL(18,2) COMMENT 'The budget amount of the marketing event record',
    `marketing_event_code` STRING COMMENT 'The marketing event code of the marketing event record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the marketing event record',
    `currency_code` STRING COMMENT 'The currency code of the marketing event record',
    `marketing_event_description` STRING COMMENT 'The marketing event description of the marketing event record',
    `effective_from` DATE COMMENT 'The effective from of the marketing event record',
    `effective_until` DATE COMMENT 'The effective until of the marketing event record',
    `event_budget` DECIMAL(18,2) COMMENT 'The event budget of the marketing event record',
    `event_code` STRING COMMENT 'The event code of the marketing event record',
    `event_date` DATE COMMENT 'The event date of the marketing event record',
    `event_name` STRING COMMENT 'The event name of the marketing event record',
    `event_status` STRING COMMENT 'The event status of the marketing event record',
    `event_type` STRING COMMENT 'The event type of the marketing event record',
    `expected_attendance` STRING COMMENT 'The expected attendance of the marketing event record',
    `location` STRING COMMENT 'The location of the marketing event record',
    `marketing_event_status` STRING COMMENT 'The marketing event status of the marketing event record',
    `marketing_event_name` STRING COMMENT 'The marketing event name of the marketing event record',
    `notes` STRING COMMENT 'The notes of the marketing event record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the marketing event record',
    `source_system_code` STRING COMMENT 'The source system code of the marketing event record',
    `uom` STRING COMMENT 'The uom of the marketing event record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the marketing event record',
    `venue` STRING COMMENT 'The venue of the marketing event record',
    CONSTRAINT pk_marketing_event PRIMARY KEY(`marketing_event_id`)
) COMMENT 'Master record for brand-owned or brand-sponsored marketing events including product launches, consumer activations, trade shows, sampling events, pop-up experiences, and retailer sell-in presentations. Captures event name, event type, brand, location, planned date, actual date, attendance target, actual attendance, budget, actual cost, and event outcome. Distinct from trade promotion events (owned by promotion domain). [SSOT: authoritative table is promotion.promotion_event; this table is a deprecated duplicate.] [SSOT: authoritative table is promotion.promotion_event; this is a deprecated duplicate for concept event.] [Non-authoritative; defers to SSOT promotion.promotion_event for concept event.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` (
    `brand_assignment_id` BIGINT COMMENT 'Primary key for the brand_assignment association',
    `employee_id` BIGINT COMMENT 'The brand assigned by employee id of the brand assignment record',
    `brand_employee_id` BIGINT COMMENT 'The brand employee id of the brand assignment record',
    `campaign_id` BIGINT COMMENT 'The campaign id of the brand assignment record',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to the brand',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to the trade account',
    `allocation_pct` DECIMAL(18,2) COMMENT 'The allocation pct of the brand assignment record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the brand assignment record',
    `approval_status` STRING COMMENT 'The approval status of the brand assignment record',
    `assigned_by` STRING COMMENT 'The assigned by of the brand assignment record',
    `assignment_end_date` DATE COMMENT 'The assignment end date of the brand assignment record',
    `assignment_notes` STRING COMMENT 'The assignment notes of the brand assignment record',
    `assignment_reason` STRING COMMENT 'Reason for the brand assignment.',
    `assignment_role` STRING COMMENT 'The assignment role of the brand assignment record',
    `assignment_start_date` DATE COMMENT 'The assignment start date of the brand assignment record',
    `assignment_type` STRING COMMENT 'Type of brand assignment.',
    `brand_assignment_status` STRING COMMENT 'Current status of the brand at the trade account',
    `brand_assignment_code` STRING COMMENT 'The brand assignment code of the brand assignment record',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `currency_code` STRING COMMENT 'The currency code of the brand assignment record',
    `brand_assignment_description` STRING COMMENT 'The brand assignment description of the brand assignment record',
    `distribution_tier` STRING COMMENT 'The distribution tier of the brand assignment record',
    `effective_date` DATE COMMENT 'Effective date of assignment.',
    `effective_from` DATE COMMENT 'Assignment effective start date.',
    `effective_until` DATE COMMENT 'Assignment effective end date.',
    `end_date` DATE COMMENT 'End date of assignment.',
    `expiry_date` DATE COMMENT 'The expiry date of the brand assignment record',
    `is_primary` BOOLEAN COMMENT 'The is primary of the brand assignment record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the brand assignment record',
    `launch_date` DATE COMMENT 'Date the brand was launched for the trade account',
    `brand_assignment_name` STRING COMMENT 'The brand assignment name of the brand assignment record',
    `notes` STRING COMMENT 'The notes of the brand assignment record',
    `primary_brand_flag` BOOLEAN COMMENT 'Indicates if this brand is the primary brand for the trade accounts shelf planning',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the brand assignment record',
    `responsibility_scope` STRING COMMENT 'The responsibility scope of the brand assignment record',
    `source_system_code` STRING COMMENT 'The source system code of the brand assignment record',
    `uom` STRING COMMENT 'The uom of the brand assignment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the brand assignment record',
    CONSTRAINT pk_brand_assignment PRIMARY KEY(`brand_assignment_id`)
) COMMENT 'This association captures the operational relationship between trade accounts and brands. It records when a brand is launched at a specific trade account, its current status, and whether it is the primary brand for shelf planning.. Existence Justification: Brands are allocated to trade accounts for shelf planning and promotional purposes. Each trade account can carry multiple brands, and each brand can be sold through multiple trade accounts. The assignment is actively managed and includes attributes such as launch date, status, and a primary‑brand flag.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` (
    `brand_distribution_allocation_id` BIGINT COMMENT 'Primary key for the brand_distribution_allocation association',
    `distribution_facility_id` BIGINT COMMENT 'Distribution facility.',
    `marketing_brand_id` BIGINT COMMENT 'Foreign key linking to the brand',
    `sku_id` BIGINT COMMENT 'add column sku_id (BIGINT) with FK to product.sku.sku_id - allocation typically targets specific SKUs within a brand',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to the supply network node',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - allocations have an owner/approver',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The allocated amount of the brand distribution allocation record',
    `allocated_budget` DECIMAL(18,2) COMMENT 'The allocated budget of the brand distribution allocation record',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The allocated quantity of the brand distribution allocation record',
    `allocated_volume` DECIMAL(18,2) COMMENT 'The allocated volume of the brand distribution allocation record',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Monetary or volume amount allocated.',
    `allocation_basis` STRING COMMENT 'Method used to derive the allocation (volume, revenue, market_share).',
    `allocation_method` STRING COMMENT 'The allocation method of the brand distribution allocation record',
    `allocation_pct` DECIMAL(18,2) COMMENT 'Allocation percentage.',
    `allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of the nodes capacity allocated to the brand',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of brand budget allocated',
    `allocation_period` STRING COMMENT 'The allocation period of the brand distribution allocation record',
    `allocation_status` STRING COMMENT 'The allocation status of the brand distribution allocation record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the brand distribution allocation record',
    `approved_by` STRING COMMENT 'The approved by of the brand distribution allocation record',
    `brand_distribution_allocation_status` STRING COMMENT 'The brand distribution allocation status of the brand distribution allocation record',
    `channel` STRING COMMENT 'Distribution channel',
    `brand_distribution_allocation_code` STRING COMMENT 'The brand distribution allocation code of the brand distribution allocation record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the brand distribution allocation record',
    `currency_code` STRING COMMENT 'The currency code of the brand distribution allocation record',
    `brand_distribution_allocation_description` STRING COMMENT 'The brand distribution allocation description of the brand distribution allocation record',
    `effective_date` DATE COMMENT 'The effective date of the brand distribution allocation record',
    `effective_end_date` DATE COMMENT 'Date when the allocation ends',
    `effective_from` DATE COMMENT 'The effective from of the brand distribution allocation record',
    `effective_start_date` DATE COMMENT 'Date when the allocation becomes effective',
    `effective_until` DATE COMMENT 'The effective until of the brand distribution allocation record',
    `end_date` DATE COMMENT 'Date the allocation expires.',
    `expiry_date` DATE COMMENT 'The expiry date of the brand distribution allocation record',
    `fiscal_period` STRING COMMENT 'The fiscal period of the brand distribution allocation record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the brand distribution allocation record',
    `brand_distribution_allocation_name` STRING COMMENT 'The brand distribution allocation name of the brand distribution allocation record',
    `notes` STRING COMMENT 'Additional notes',
    `primary_flag` BOOLEAN COMMENT 'Indicates if this node is the primary distribution point for the brand',
    `priority_rank` STRING COMMENT 'The priority rank of the brand distribution allocation record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the brand distribution allocation record',
    `source_system_code` STRING COMMENT 'The source system code of the brand distribution allocation record',
    `uom` STRING COMMENT 'The uom of the brand distribution allocation record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the brand distribution allocation record',
    CONSTRAINT pk_brand_distribution_allocation PRIMARY KEY(`brand_distribution_allocation_id`)
) COMMENT 'This association captures the allocation of brands to supply network nodes, including the percentage of inventory allocated, primary flag, and the effective date range for each allocation.. Existence Justification: Brands are actively allocated to supply network nodes with defined allocation percentages, primary flags, and effective date ranges. The planning team manages these allocations, and a single brand can be stocked at many nodes while a node can carry many brands.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` (
    `campaign_inventory_allocation_id` BIGINT COMMENT 'Primary key for the campaign_inventory_allocation association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the campaign',
    `media_plan_id` BIGINT COMMENT 'The media plan id of the campaign inventory allocation record',
    `sku_id` BIGINT COMMENT 'The sku id of the campaign inventory allocation record',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to the stock position',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Allocated inventory quantity.',
    `allocated_units` BIGINT COMMENT 'The allocated units of the campaign inventory allocation record',
    `allocation_date` DATE COMMENT 'Date of allocation.',
    `allocation_end_date` DATE COMMENT 'End date of the allocation period',
    `allocation_pct` DECIMAL(18,2) COMMENT 'The allocation pct of the campaign inventory allocation record',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the stock position allocated to the campaign',
    `allocation_period` STRING COMMENT 'The allocation period of the campaign inventory allocation record',
    `allocation_start_date` DATE COMMENT 'Start date of the allocation period',
    `allocation_status` STRING COMMENT 'The allocation status of the campaign inventory allocation record',
    `allocation_uom` STRING COMMENT 'The allocation uom of the campaign inventory allocation record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the campaign inventory allocation record',
    `approved_by` STRING COMMENT 'The approved by of the campaign inventory allocation record',
    `campaign_inventory_allocation_status` STRING COMMENT 'Allocation status.',
    `campaign_inventory_allocation_code` STRING COMMENT 'The campaign inventory allocation code of the campaign inventory allocation record',
    `consumed_quantity` DECIMAL(18,2) COMMENT 'The consumed quantity of the campaign inventory allocation record',
    `consumed_units` BIGINT COMMENT 'The consumed units of the campaign inventory allocation record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the campaign inventory allocation record',
    `currency_code` STRING COMMENT 'The currency code of the campaign inventory allocation record',
    `campaign_inventory_allocation_description` STRING COMMENT 'The campaign inventory allocation description of the campaign inventory allocation record',
    `effective_date` DATE COMMENT 'The effective date of the campaign inventory allocation record',
    `effective_from` DATE COMMENT 'The effective from of the campaign inventory allocation record',
    `effective_until` DATE COMMENT 'The effective until of the campaign inventory allocation record',
    `expiry_date` DATE COMMENT 'The expiry date of the campaign inventory allocation record',
    `inventory_type` STRING COMMENT 'The inventory type of the campaign inventory allocation record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the campaign inventory allocation record',
    `campaign_inventory_allocation_name` STRING COMMENT 'The campaign inventory allocation name of the campaign inventory allocation record',
    `notes` STRING COMMENT 'The notes of the campaign inventory allocation record',
    `priority_rank` STRING COMMENT 'The priority rank of the campaign inventory allocation record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the campaign inventory allocation record',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'The reserved quantity of the campaign inventory allocation record',
    `source_system_code` STRING COMMENT 'The source system code of the campaign inventory allocation record',
    `unit_cost` DECIMAL(18,2) COMMENT 'The unit cost of the campaign inventory allocation record',
    `uom` STRING COMMENT 'Unit of measure.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the campaign inventory allocation record',
    CONSTRAINT pk_campaign_inventory_allocation PRIMARY KEY(`campaign_inventory_allocation_id`)
) COMMENT 'This association product represents the allocation relationship between a marketing campaign and a stock position. It captures the percentage of inventory allocated and the start/end dates of the allocation period for each link.. Existence Justification: A marketing campaign allocates portions of inventory at specific locations to support promotional activities. Each allocation is defined by a percentage and a time window, and the same inventory can be allocated to multiple campaigns over time, while a campaign can allocate to many stock positions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` (
    `marketing_offset_allocation_id` BIGINT COMMENT 'Primary key for the offset_allocation association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the campaign',
    `carbon_offset_id` BIGINT COMMENT 'Foreign key linking to the carbon offset',
    `gl_account_id` BIGINT COMMENT 'The gl account id of the marketing offset allocation record',
    `marketing_brand_id` BIGINT COMMENT 'The marketing brand id of the marketing offset allocation record',
    `distribution_offset_allocation_id` BIGINT COMMENT 'References authoritative SSOT record in distribution.distribution_offset_allocation.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The allocated amount of the marketing offset allocation record',
    `allocated_co2e_tonnes` DECIMAL(18,2) COMMENT 'The allocated co2e tonnes of the marketing offset allocation record',
    `allocation_amount` DECIMAL(18,2) COMMENT 'Amount of credits allocated from this offset to the campaign (tCO2e)',
    `allocation_basis` STRING COMMENT 'The allocation basis of the marketing offset allocation record',
    `allocation_currency` STRING COMMENT 'The allocation currency of the marketing offset allocation record',
    `allocation_date` DATE COMMENT 'The allocation date of the marketing offset allocation record',
    `allocation_method` STRING COMMENT 'Method of allocation.',
    `allocation_pct` DECIMAL(18,2) COMMENT 'The allocation pct of the marketing offset allocation record',
    `allocation_period` STRING COMMENT 'The allocation period of the marketing offset allocation record',
    `allocation_status` STRING COMMENT 'The allocation status of the marketing offset allocation record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the marketing offset allocation record',
    `approved_by` STRING COMMENT 'The approved by of the marketing offset allocation record',
    `carbon_offset_amount` DECIMAL(18,2) COMMENT 'Carbon offset amount allocated.',
    `marketing_offset_allocation_code` STRING COMMENT 'The marketing offset allocation code of the marketing offset allocation record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the marketing offset allocation record',
    `credit_quantity_purchased` DECIMAL(18,2) COMMENT 'Quantity of carbon credits purchased for the allocation (tCO2e)',
    `currency_code` STRING COMMENT 'The currency code of the marketing offset allocation record',
    `marketing_offset_allocation_description` STRING COMMENT 'The marketing offset allocation description of the marketing offset allocation record',
    `effective_date` DATE COMMENT 'The effective date of the marketing offset allocation record',
    `effective_from` DATE COMMENT 'The effective from of the marketing offset allocation record',
    `effective_until` DATE COMMENT 'The effective until of the marketing offset allocation record',
    `emission_quantity_tco2e` DECIMAL(18,2) COMMENT 'Emissions offset in tonnes CO2 equivalent.',
    `emission_scope` STRING COMMENT 'The emission scope of the marketing offset allocation record',
    `expiry_date` DATE COMMENT 'The expiry date of the marketing offset allocation record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the marketing offset allocation record',
    `marketing_offset_allocation_status` STRING COMMENT 'The marketing offset allocation status of the marketing offset allocation record',
    `marketing_offset_allocation_name` STRING COMMENT 'The marketing offset allocation name of the marketing offset allocation record',
    `notes` STRING COMMENT 'The notes of the marketing offset allocation record',
    `offset_quantity_tonnes` DECIMAL(18,2) COMMENT 'The offset quantity tonnes of the marketing offset allocation record',
    `offset_tonnes_co2e` DECIMAL(18,2) COMMENT 'The offset tonnes co2e of the marketing offset allocation record',
    `purchase_cost` DECIMAL(18,2) COMMENT 'The purchase cost of the marketing offset allocation record',
    `purchase_date` DATE COMMENT 'Date the carbon offset was purchased for the campaign',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the marketing offset allocation record',
    `reporting_period` STRING COMMENT 'The reporting period of the marketing offset allocation record',
    `source_system_code` STRING COMMENT 'The source system code of the marketing offset allocation record',
    `uom` STRING COMMENT 'The uom of the marketing offset allocation record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the marketing offset allocation record',
    `verification_status` STRING COMMENT 'The verification status of the marketing offset allocation record',
    CONSTRAINT pk_marketing_offset_allocation PRIMARY KEY(`marketing_offset_allocation_id`)
) COMMENT 'Represents the allocation of carbon offset credits to marketing campaigns. Each record links one campaign to one carbon offset and captures allocation-specific details such as the amount allocated, purchase date, and quantity purchased.. Existence Justification: A marketing campaign can be linked to multiple carbon offset credits, and a single carbon offset credit can be allocated across several campaigns. The business actively records each allocation with details such as allocation amount, purchase date, and quantity purchased, which are managed by sustainability and marketing teams. [SSOT] Superseded by authoritative table distribution.distribution_offset_allocation for concept offset_allocation. SSOT: canonical table is distribution.distribution_offset_allocation. [SSOT for concept offset_allocation.]';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` (
    `campaign_submission_link_id` BIGINT COMMENT 'Primary key for the CampaignSubmissionLink association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to campaign',
    `creative_asset_id` BIGINT COMMENT 'The creative asset id of the campaign submission link record',
    `employee_id` BIGINT COMMENT 'Employee who reviewed the submission.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to submission',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the campaign submission link record',
    `approval_date` DATE COMMENT 'Date the claim was approved for this campaign‑submission pairing',
    `approval_flag` BOOLEAN COMMENT 'The approval flag of the campaign submission link record',
    `approval_status` STRING COMMENT 'Current approval status of the claim for this pairing',
    `campaign_submission_link_status` STRING COMMENT 'Submission status.',
    `claim_type` STRING COMMENT 'Type of claim being approved in this campaign‑submission pairing',
    `campaign_submission_link_code` STRING COMMENT 'The campaign submission link code of the campaign submission link record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the campaign submission link record',
    `currency_code` STRING COMMENT 'The currency code of the campaign submission link record',
    `campaign_submission_link_description` STRING COMMENT 'The campaign submission link description of the campaign submission link record',
    `effective_from` DATE COMMENT 'The effective from of the campaign submission link record',
    `effective_until` DATE COMMENT 'The effective until of the campaign submission link record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the campaign submission link record',
    `link_status` STRING COMMENT 'The link status of the campaign submission link record',
    `campaign_submission_link_name` STRING COMMENT 'The campaign submission link name of the campaign submission link record',
    `notes` STRING COMMENT 'The notes of the campaign submission link record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the campaign submission link record',
    `regulatory_jurisdiction` STRING COMMENT 'The regulatory jurisdiction of the campaign submission link record',
    `review_date` DATE COMMENT 'The review date of the campaign submission link record',
    `review_status` STRING COMMENT 'The review status of the campaign submission link record',
    `reviewed_by` STRING COMMENT 'The reviewed by of the campaign submission link record',
    `reviewer` STRING COMMENT 'The reviewer of the campaign submission link record',
    `reviewer_name` STRING COMMENT 'The reviewer name of the campaign submission link record',
    `source_system_code` STRING COMMENT 'The source system code of the campaign submission link record',
    `submission_date` DATE COMMENT 'The submission date of the campaign submission link record',
    `submission_type` STRING COMMENT 'Type of submission.',
    `submission_url` STRING COMMENT 'The submission url of the campaign submission link record',
    `submitted_by` STRING COMMENT 'The submitted by of the campaign submission link record',
    `submitted_date` DATE COMMENT 'The submitted date of the campaign submission link record',
    `uom` STRING COMMENT 'The uom of the campaign submission link record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the campaign submission link record',
    CONSTRAINT pk_campaign_submission_link PRIMARY KEY(`campaign_submission_link_id`)
) COMMENT 'This association product represents the contractual link between a marketing campaign and a regulatory submission. It captures claim_type, approval_status, and approval_date that are specific to each campaign‑submission pairing.. Existence Justification: In Consumer Goods, a marketing campaign often requires regulatory submissions to obtain claim approvals. A single campaign may depend on several submissions (e.g., different claims or regions) and a single submission can be used to support multiple campaigns.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` (
    `campaign_assignment_id` BIGINT COMMENT 'Primary key for the campaign_assignment association',
    `agency_id` BIGINT COMMENT 'The agency id of the campaign assignment record',
    `employee_id` BIGINT COMMENT 'Assigned employee.',
    `campaign_employee_id` BIGINT COMMENT 'Foreign key linking to the employee',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the campaign',
    `marketing_brand_id` BIGINT COMMENT 'add column marketing_brand_id (BIGINT) with FK to marketing.marketing_brand.marketing_brand_id - campaign assignment is brand-scoped',
    `trade_account_id` BIGINT COMMENT 'add column trade_account_id (BIGINT) with FK to sales.trade_account.trade_account_id - campaign assignments often target specific trade accounts',
    `allocation_pct` DECIMAL(18,2) COMMENT 'The allocation pct of the campaign assignment record',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the employees time allocated to the campaign',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the campaign assignment record',
    `assigned_by` STRING COMMENT 'The assigned by of the campaign assignment record',
    `assigned_date` DATE COMMENT 'Date the campaign assignment was made.',
    `assigned_to` STRING COMMENT 'Person, team, or agency assigned',
    `assignment_date` DATE COMMENT 'The assignment date of the campaign assignment record',
    `assignment_end_date` DATE COMMENT 'Date when the employee stopped working on the campaign',
    `assignment_notes` STRING COMMENT 'The assignment notes of the campaign assignment record',
    `assignment_role` STRING COMMENT 'The assignment role of the campaign assignment record',
    `assignment_start_date` DATE COMMENT 'Date when the employee started working on the campaign',
    `assignment_status` STRING COMMENT 'The assignment status of the campaign assignment record',
    `assignment_type` STRING COMMENT 'Type of campaign assignment',
    `campaign_assignment_status` STRING COMMENT 'The campaign assignment status of the campaign assignment record',
    `campaign_assignment_code` STRING COMMENT 'The campaign assignment code of the campaign assignment record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the campaign assignment record',
    `currency_code` STRING COMMENT 'The currency code of the campaign assignment record',
    `campaign_assignment_description` STRING COMMENT 'The campaign assignment description of the campaign assignment record',
    `effective_date` DATE COMMENT 'The effective date of the campaign assignment record',
    `effective_from` DATE COMMENT 'The effective from of the campaign assignment record',
    `effective_until` DATE COMMENT 'The effective until of the campaign assignment record',
    `end_date` DATE COMMENT 'The end date of the campaign assignment record',
    `expiry_date` DATE COMMENT 'The expiry date of the campaign assignment record',
    `is_primary` BOOLEAN COMMENT 'The is primary of the campaign assignment record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the campaign assignment record',
    `campaign_assignment_name` STRING COMMENT 'The campaign assignment name of the campaign assignment record',
    `notes` STRING COMMENT 'The notes of the campaign assignment record',
    `priority` STRING COMMENT 'Priority level',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the campaign assignment record',
    `responsibility_area` STRING COMMENT 'Functional area of responsibility (creative, media, analytics).',
    `responsibility_description` STRING COMMENT 'Description of responsibilities',
    `responsibility_scope` STRING COMMENT 'The responsibility scope of the campaign assignment record',
    `role` STRING COMMENT 'The role of the employee on the campaign (e.g., Planner, Creative, Analyst)',
    `source_system_code` STRING COMMENT 'The source system code of the campaign assignment record',
    `start_date` DATE COMMENT 'The start date of the campaign assignment record',
    `uom` STRING COMMENT 'The uom of the campaign assignment record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the campaign assignment record',
    CONSTRAINT pk_campaign_assignment PRIMARY KEY(`campaign_assignment_id`)
) COMMENT 'This association captures the staffing of marketing campaigns. Each record links one campaign to one employee and stores attributes that belong to the assignment such as role, allocation percentage, and assignment dates.. Existence Justification: A marketing campaign is staffed by multiple employees (e.g., planners, creatives, analysts) and an employee can be assigned to multiple campaigns over time. The assignment is actively managed, with role, allocation percentage, and start/end dates captured for each employee‑campaign pairing.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` (
    `event_participation_id` BIGINT COMMENT 'Primary key for the event_participation association',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee',
    `influencer_id` BIGINT COMMENT 'The influencer id of the event participation record',
    `marketing_event_id` BIGINT COMMENT 'Foreign key linking to the marketing event',
    `shopper_id` BIGINT COMMENT 'The shopper id of the event participation record',
    `amount` DECIMAL(18,2) COMMENT 'The amount of the event participation record',
    `attendance_confirmed` BOOLEAN COMMENT 'The attendance confirmed of the event participation record',
    `attendance_flag` BOOLEAN COMMENT 'The attendance flag of the event participation record',
    `attendance_status` STRING COMMENT 'The attendance status of the event participation record',
    `attended` BOOLEAN COMMENT 'The attended of the event participation record',
    `attended_flag` BOOLEAN COMMENT 'The attended flag of the event participation record',
    `check_in_time` TIMESTAMP COMMENT 'The check in time of the event participation record',
    `check_in_timestamp` TIMESTAMP COMMENT 'The check in timestamp of the event participation record',
    `check_out_timestamp` TIMESTAMP COMMENT 'The check out timestamp of the event participation record',
    `event_participation_code` STRING COMMENT 'The event participation code of the event participation record',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp of the event participation record',
    `currency_code` STRING COMMENT 'The currency code of the event participation record',
    `event_participation_description` STRING COMMENT 'The event participation description of the event participation record',
    `effective_from` DATE COMMENT 'The effective from of the event participation record',
    `effective_until` DATE COMMENT 'The effective until of the event participation record',
    `engagement_score` DECIMAL(18,2) COMMENT 'The engagement score of the event participation record',
    `event_participation_status` STRING COMMENT 'Participation status.',
    `feedback_rating` STRING COMMENT 'The feedback rating of the event participation record',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp of the event participation record',
    `lead_captured` BOOLEAN COMMENT 'The lead captured of the event participation record',
    `lead_generated_flag` BOOLEAN COMMENT 'The lead generated flag of the event participation record',
    `event_participation_name` STRING COMMENT 'The event participation name of the event participation record',
    `notes` STRING COMMENT 'The notes of the event participation record',
    `participant_role` STRING COMMENT 'Role of participant.',
    `participation_date` DATE COMMENT 'Date of participation.',
    `participation_hours` DECIMAL(18,2) COMMENT 'Hours of participation.',
    `participation_status` STRING COMMENT 'The participation status of the event participation record',
    `participation_type` STRING COMMENT 'The participation type of the event participation record',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the event participation record',
    `registration_date` DATE COMMENT 'The registration date of the event participation record',
    `role` STRING COMMENT 'The function or responsibility of the employee in the event (e.g., coordinator, presenter, host)',
    `source_system_code` STRING COMMENT 'The source system code of the event participation record',
    `uom` STRING COMMENT 'The uom of the event participation record',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp of the event participation record',
    CONSTRAINT pk_event_participation PRIMARY KEY(`event_participation_id`)
) COMMENT 'Association representing the participation of employees in marketing events, capturing the employees role and the start/end dates of their involvement for each event.. Existence Justification: Marketing events are staffed by multiple employees (coordinators, hosts, presenters) and each employee can be assigned to many events over time. The business actively records each employees role and the dates they participated in the event for planning, reporting, and post‑event analysis.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ADD CONSTRAINT `fk_marketing_marketing_brand_parent_brand_marketing_brand_id` FOREIGN KEY (`parent_brand_marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ADD CONSTRAINT `fk_marketing_campaign_flight_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ADD CONSTRAINT `fk_marketing_media_spend_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ADD CONSTRAINT `fk_marketing_creative_asset_parent_asset_creative_asset_id` FOREIGN KEY (`parent_asset_creative_asset_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ADD CONSTRAINT `fk_marketing_influencer_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ADD CONSTRAINT `fk_marketing_influencer_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ADD CONSTRAINT `fk_marketing_consumer_segment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ADD CONSTRAINT `fk_marketing_market_research_study_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ADD CONSTRAINT `fk_marketing_brand_health_tracker_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ADD CONSTRAINT `fk_marketing_sov_measurement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ADD CONSTRAINT `fk_marketing_sov_measurement_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ADD CONSTRAINT `fk_marketing_digital_performance_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ADD CONSTRAINT `fk_marketing_digital_performance_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ADD CONSTRAINT `fk_marketing_digital_performance_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ADD CONSTRAINT `fk_marketing_digital_performance_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ADD CONSTRAINT `fk_marketing_digital_performance_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_campaign_flight_id` FOREIGN KEY (`campaign_flight_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign_flight`(`campaign_flight_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ADD CONSTRAINT `fk_marketing_attribution_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ADD CONSTRAINT `fk_marketing_social_listening_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ADD CONSTRAINT `fk_marketing_social_listening_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ADD CONSTRAINT `fk_marketing_nielsen_panel_insight_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ADD CONSTRAINT `fk_marketing_marketing_budget_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ADD CONSTRAINT `fk_marketing_market_share_record_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ADD CONSTRAINT `fk_marketing_sponsorship_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ADD CONSTRAINT `fk_marketing_marketing_event_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ADD CONSTRAINT `fk_marketing_brand_assignment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ADD CONSTRAINT `fk_marketing_brand_assignment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ADD CONSTRAINT `fk_marketing_brand_distribution_allocation_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ADD CONSTRAINT `fk_marketing_campaign_inventory_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ADD CONSTRAINT `fk_marketing_campaign_inventory_allocation_media_plan_id` FOREIGN KEY (`media_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`media_plan`(`media_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ADD CONSTRAINT `fk_marketing_marketing_offset_allocation_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ADD CONSTRAINT `fk_marketing_marketing_offset_allocation_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ADD CONSTRAINT `fk_marketing_campaign_submission_link_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ADD CONSTRAINT `fk_marketing_campaign_submission_link_creative_asset_id` FOREIGN KEY (`creative_asset_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`creative_asset`(`creative_asset_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ADD CONSTRAINT `fk_marketing_campaign_assignment_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`agency`(`agency_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ADD CONSTRAINT `fk_marketing_campaign_assignment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ADD CONSTRAINT `fk_marketing_campaign_assignment_marketing_brand_id` FOREIGN KEY (`marketing_brand_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_brand`(`marketing_brand_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ADD CONSTRAINT `fk_marketing_event_participation_influencer_id` FOREIGN KEY (`influencer_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`influencer`(`influencer_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ADD CONSTRAINT `fk_marketing_event_participation_marketing_event_id` FOREIGN KEY (`marketing_event_id`) REFERENCES `vibe_consumer_goods_v1`.`marketing`.`marketing_event`(`marketing_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`marketing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_consumer_goods_v1`.`marketing` SET TAGS ('dbx_domain' = 'marketing');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_deprecated_ssot_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_ssot_alias_of' = 'product.product_brand');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_ssot_owner' = 'brand');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_ssot' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_deprecated_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_ssot_concept' = 'brand');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_ssot_duplicate_of' = 'product.product_brand');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_ssot_status' = 'deprecated_duplicate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` SET TAGS ('dbx_ssot_authoritative' = 'product.product_brand');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Manager Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `parent_brand_marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Product Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_ssot_resolution' = 'true');
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
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_equity_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Equity Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_health_index` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Index');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_health_index` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_health_index` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_brand` ALTER COLUMN `brand_positioning` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning');
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
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `reach` SET TAGS ('dbx_business_glossary_term' = 'Reach');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `roas` SET TAGS ('dbx_business_glossary_term' = 'Return on Ad Spend (ROAS)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `video_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_flight` ALTER COLUMN `video_views` SET TAGS ('dbx_business_glossary_term' = 'Video Views');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` SET TAGS ('dbx_subdomain' = 'media_investment');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Grp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `target_reach_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Reach Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `total_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` SET TAGS ('dbx_subdomain' = 'media_investment');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_spend_id` SET TAGS ('dbx_business_glossary_term' = 'Media Spend ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan ID');
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
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
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
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `variance_to_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance to Plan Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `video_views_delivered` SET TAGS ('dbx_business_glossary_term' = 'Video Views Delivered');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`media_spend` ALTER COLUMN `working_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Working Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Content Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `parent_asset_creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
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
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `creative_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Creative Agency Name');
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
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Thumbnail URL');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `usage_rights_expiry` SET TAGS ('dbx_business_glossary_term' = 'Usage Rights Expiry');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`creative_asset` ALTER COLUMN `width_pixels` SET TAGS ('dbx_business_glossary_term' = 'Width (Pixels)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarded By User Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `agent_contact` SET TAGS ('dbx_business_glossary_term' = 'Agent Contact Information');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `agent_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `agent_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent or Manager Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `audience_age_range` SET TAGS ('dbx_business_glossary_term' = 'Primary Audience Age Range');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `audience_age_range` SET TAGS ('dbx_value_regex' = '13-17|18-24|25-34|35-44|45-54|55-64|65+');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split` SET TAGS ('dbx_business_glossary_term' = 'Audience Gender Distribution');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `audience_gender_split` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `audience_geography` SET TAGS ('dbx_business_glossary_term' = 'Primary Audience Geography');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `audience_geography` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `audience_geography` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `average_post_impressions` SET TAGS ('dbx_business_glossary_term' = 'Average Post Impressions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `average_post_reach` SET TAGS ('dbx_business_glossary_term' = 'Average Post Reach');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `brand_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Safety Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `influencer_category` SET TAGS ('dbx_business_glossary_term' = 'Influencer Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `influencer_code` SET TAGS ('dbx_business_glossary_term' = 'Influencer Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `contact_email` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Content Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `contract_fee` SET TAGS ('dbx_business_glossary_term' = 'Contract Fee');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending|Suspended|Terminated');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'One-Time|Campaign-Based|Retainer|Ambassador|Exclusive');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `influencer_description` SET TAGS ('dbx_business_glossary_term' = 'Influencer Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Influencer Email Address');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `engagement_rate` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `engagement_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `engagement_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Engagement Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `exclusivity_category` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `exclusivity_clause` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `follower_count` SET TAGS ('dbx_business_glossary_term' = 'Total Follower Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Influencer Full Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `handle` SET TAGS ('dbx_business_glossary_term' = 'Influencer Handle');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `handle` SET TAGS ('dbx_value_regex' = '^@?[A-Za-z0-9_.]{1,30}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `influencer_status` SET TAGS ('dbx_business_glossary_term' = 'Influencer Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `last_campaign_date` SET TAGS ('dbx_business_glossary_term' = 'Last Campaign Participation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `influencer_name` SET TAGS ('dbx_business_glossary_term' = 'Influencer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Influencer Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'Net 30|Net 60|Upon Delivery|50% Upfront|Barter|Product Seeding');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Influencer Performance Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Influencer Phone Number');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `platform` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `platform` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'Email|Phone|Agent|Manager|Direct Message');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `primary_platform` SET TAGS ('dbx_business_glossary_term' = 'Primary Social Media Platform');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `primary_platform` SET TAGS ('dbx_value_regex' = 'Instagram|TikTok|YouTube|Facebook|Twitter|LinkedIn');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `primary_platform` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `primary_platform` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `secondary_platforms` SET TAGS ('dbx_business_glossary_term' = 'Secondary Social Media Platforms');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `secondary_platforms` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `secondary_platforms` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `total_campaigns_participated` SET TAGS ('dbx_business_glossary_term' = 'Total Campaigns Participated');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`influencer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` SET TAGS ('dbx_subdomain' = 'audience_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `consumer_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consumer Segment ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `age_range_lower` SET TAGS ('dbx_business_glossary_term' = 'Age Range Lower Bound');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `age_range_upper` SET TAGS ('dbx_business_glossary_term' = 'Age Range Upper Bound');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `average_basket_size_usd` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Size (USD)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `brand_affinity` SET TAGS ('dbx_business_glossary_term' = 'Brand Affinity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`consumer_segment` ALTER COLUMN `category_affinity` SET TAGS ('dbx_business_glossary_term' = 'Category Affinity');
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
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` SET TAGS ('dbx_subdomain' = 'audience_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `market_research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Market Research Study ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Study Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `analysis_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completion Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `average_basket_size` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Size');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `brand_awareness_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Awareness Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `brand_consideration_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Consideration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `brand_preference_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Preference Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `buyer_demographics` SET TAGS ('dbx_business_glossary_term' = 'Buyer Demographics');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `market_research_study_code` SET TAGS ('dbx_business_glossary_term' = 'Market Research Study Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `data_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Data Provider Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `market_research_study_description` SET TAGS ('dbx_business_glossary_term' = 'Market Research Study Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `field_end_date` SET TAGS ('dbx_business_glossary_term' = 'Field End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `field_start_date` SET TAGS ('dbx_business_glossary_term' = 'Field Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `fieldwork_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `fieldwork_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `household_penetration_pct` SET TAGS ('dbx_business_glossary_term' = 'Household Penetration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `key_findings` SET TAGS ('dbx_business_glossary_term' = 'Key Findings');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `market_research_study_status` SET TAGS ('dbx_business_glossary_term' = 'Market Research Study Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Research Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `market_research_study_name` SET TAGS ('dbx_business_glossary_term' = 'Market Research Study Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `purchase_frequency` SET TAGS ('dbx_business_glossary_term' = 'Purchase Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `repeat_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Repeat Rate Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `research_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Research Agency Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `research_objective` SET TAGS ('dbx_business_glossary_term' = 'Research Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `research_type` SET TAGS ('dbx_business_glossary_term' = 'Research Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Study Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `study_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Study Investment Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `study_investment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|in_fieldwork|analysis|completed|cancelled|on_hold');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `subscription_end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `subscription_start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `subscription_type` SET TAGS ('dbx_business_glossary_term' = 'Subscription Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `subscription_type` SET TAGS ('dbx_value_regex' = 'one_time|annual|quarterly|monthly|continuous');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `switching_behavior_index` SET TAGS ('dbx_business_glossary_term' = 'Switching Behavior Index');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `target_market` SET TAGS ('dbx_business_glossary_term' = 'Target Market');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_research_study` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Tracker ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Competitor Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `aided_awareness_pct` SET TAGS ('dbx_business_glossary_term' = 'Aided Awareness Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `awareness_pct` SET TAGS ('dbx_business_glossary_term' = 'Awareness Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_equity_index` SET TAGS ('dbx_business_glossary_term' = 'Brand Equity Index');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Tracker Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Brand Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|ecommerce|dtc|wholesale|all_channels');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Tracker Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `competitor_som_value_pct` SET TAGS ('dbx_business_glossary_term' = 'Competitor Share of Market (SOM) Value Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `competitor_sov_total_pct` SET TAGS ('dbx_business_glossary_term' = 'Competitor Share of Voice (SOV) Total Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `consideration_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Consideration Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'nielsen_iq|kantar|circana|brandwatch|sprinklr|proprietary_study');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Tracker Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `equity_index` SET TAGS ('dbx_business_glossary_term' = 'Equity Index');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `innovation_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Innovation Perception Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `market_geography` SET TAGS ('dbx_business_glossary_term' = 'Market Geography');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `market_geography` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `market_geography` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Health Tracker Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `brand_health_tracker_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `net_sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Net Sentiment Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `preference_pct` SET TAGS ('dbx_business_glossary_term' = 'Brand Preference Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `purchase_intent_pct` SET TAGS ('dbx_business_glossary_term' = 'Purchase Intent Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `quality_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Perception Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `share_of_conversation_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Conversation Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `social_mention_volume` SET TAGS ('dbx_business_glossary_term' = 'Social Mention Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `social_sentiment_negative_pct` SET TAGS ('dbx_business_glossary_term' = 'Social Sentiment Negative Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `social_sentiment_neutral_pct` SET TAGS ('dbx_business_glossary_term' = 'Social Sentiment Neutral Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `social_sentiment_positive_pct` SET TAGS ('dbx_business_glossary_term' = 'Social Sentiment Positive Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `som_value_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Market (SOM) Value Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `som_volume_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Market (SOM) Volume Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `sov_digital_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Digital Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `sov_ooh_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Out-of-Home (OOH) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `sov_social_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Social Media Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `sov_total_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Total Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `sov_tv_pct` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Television Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `spontaneous_awareness_pct` SET TAGS ('dbx_business_glossary_term' = 'Spontaneous Awareness Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `sustainability_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Perception Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `total_category_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Category Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `tracking_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Tracking Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `tracking_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tracking Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `trust_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Trust Perception Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_health_tracker` ALTER COLUMN `value_perception_score` SET TAGS ('dbx_business_glossary_term' = 'Value Perception Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` SET TAGS ('dbx_subdomain' = 'media_investment');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `sov_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) Measurement ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `brand_rank` SET TAGS ('dbx_business_glossary_term' = 'Brand Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `brand_som_percentage` SET TAGS ('dbx_business_glossary_term' = 'Brand Share of Market (SOM) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `brand_sov_percentage` SET TAGS ('dbx_business_glossary_term' = 'Brand Share of Voice (SOV) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `brand_spend` SET TAGS ('dbx_business_glossary_term' = 'Brand Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `brand_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Brand Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `brand_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `sov_measurement_category` SET TAGS ('dbx_business_glossary_term' = 'Sov Measurement Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `category_spend` SET TAGS ('dbx_business_glossary_term' = 'Category Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `sov_measurement_code` SET TAGS ('dbx_business_glossary_term' = 'Sov Measurement Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `competitor_count` SET TAGS ('dbx_business_glossary_term' = 'Competitor Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `competitor_set` SET TAGS ('dbx_business_glossary_term' = 'Competitor Set');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'Nielsen Ad Intel|Kantar Media|Comscore|Internal');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `sov_measurement_description` SET TAGS ('dbx_business_glossary_term' = 'Sov Measurement Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `grp` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Points (GRP)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `impressions_count` SET TAGS ('dbx_business_glossary_term' = 'Impressions Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `market_geography` SET TAGS ('dbx_business_glossary_term' = 'Market Geography');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `market_geography` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `market_geography` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'Preliminary|Final|Revised|Archived');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `media_channel` SET TAGS ('dbx_business_glossary_term' = 'Media Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `media_channel` SET TAGS ('dbx_value_regex' = 'TV|Digital|Radio|Print|OOH|Social Media');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `sov_measurement_name` SET TAGS ('dbx_business_glossary_term' = 'Sov Measurement Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `reach_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reach Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `share_of_spend_pct` SET TAGS ('dbx_business_glossary_term' = 'Share Of Spend Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `share_of_voice_pct` SET TAGS ('dbx_business_glossary_term' = 'Share Of Voice Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `sov_measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Sov Measurement Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `sov_percent` SET TAGS ('dbx_business_glossary_term' = 'Sov Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `sov_som_gap` SET TAGS ('dbx_business_glossary_term' = 'Share of Voice (SOV) vs Share of Market (SOM) Gap');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `top_competitor_brand_name` SET TAGS ('dbx_business_glossary_term' = 'Top Competitor Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `top_competitor_sov_percentage` SET TAGS ('dbx_business_glossary_term' = 'Top Competitor Share of Voice (SOV) Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `total_category_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Category Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sov_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `digital_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Performance ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `ad_format` SET TAGS ('dbx_business_glossary_term' = 'Ad Format');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `attribution_model` SET TAGS ('dbx_value_regex' = 'Last Click|First Click|Linear|Time Decay|Position Based|Data Driven');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `attribution_window_days` SET TAGS ('dbx_business_glossary_term' = 'Attribution Window Days');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `clicks` SET TAGS ('dbx_business_glossary_term' = 'Clicks');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `digital_performance_code` SET TAGS ('dbx_business_glossary_term' = 'Digital Performance Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate (CVR)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `conversion_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `conversions` SET TAGS ('dbx_business_glossary_term' = 'Conversions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `cpa` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Acquisition (CPA)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `cpc` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Click (CPC)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Thousand Impressions (CPM)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `ctr` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `ctr_pct` SET TAGS ('dbx_business_glossary_term' = 'Ctr Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `digital_performance_description` SET TAGS ('dbx_business_glossary_term' = 'Digital Performance Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'Mobile|Desktop|Tablet|Connected TV|Other');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `digital_performance_status` SET TAGS ('dbx_business_glossary_term' = 'Digital Performance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `geography` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `geography` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `impressions` SET TAGS ('dbx_business_glossary_term' = 'Impressions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `digital_performance_name` SET TAGS ('dbx_business_glossary_term' = 'Digital Performance Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `performance_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Digital Platform');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `platform` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `platform` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `reach` SET TAGS ('dbx_business_glossary_term' = 'Reach');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `roas` SET TAGS ('dbx_business_glossary_term' = 'Return on Ad Spend (ROAS)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `spend` SET TAGS ('dbx_business_glossary_term' = 'Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `video_completion_rate` SET TAGS ('dbx_business_glossary_term' = 'Video Completion Rate (VCR)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `video_quartile_25_pct` SET TAGS ('dbx_business_glossary_term' = 'Video 25% Quartile Completion Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `video_quartile_50_pct` SET TAGS ('dbx_business_glossary_term' = 'Video 50% Quartile Completion Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `video_quartile_75_pct` SET TAGS ('dbx_business_glossary_term' = 'Video 75% Quartile Completion Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `video_views` SET TAGS ('dbx_business_glossary_term' = 'Video Views');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`digital_performance` ALTER COLUMN `view_through_conversions` SET TAGS ('dbx_business_glossary_term' = 'View-Through Conversions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `attribution_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `campaign_flight_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `attributed_conversions` SET TAGS ('dbx_business_glossary_term' = 'Attributed Conversions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `attributed_revenue` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_value_regex' = 'final|provisional|recalculated|voided');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attribution Calculation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Marketing Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `attribution_code` SET TAGS ('dbx_business_glossary_term' = 'Attribution Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `conversion_event_code` SET TAGS ('dbx_business_glossary_term' = 'Conversion Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `conversion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Conversion Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `conversion_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `cpa` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Acquisition (CPA)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `attribution_description` SET TAGS ('dbx_business_glossary_term' = 'Attribution Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|smart_tv|wearable|other');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `geography` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `geography` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `is_direct_conversion` SET TAGS ('dbx_business_glossary_term' = 'Is Direct Conversion');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `is_view_through` SET TAGS ('dbx_business_glossary_term' = 'Is View-Through');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `lookback_window_days` SET TAGS ('dbx_business_glossary_term' = 'Lookback Window (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `measurement_window_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Days');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `media_spend_attributed_amount` SET TAGS ('dbx_business_glossary_term' = 'Media Spend Attributed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Model');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'last_touch|first_touch|linear|time_decay|position_based|data_driven');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `attribution_name` SET TAGS ('dbx_business_glossary_term' = 'Attribution Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `platform` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `platform` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `roas` SET TAGS ('dbx_business_glossary_term' = 'Return on Ad Spend (ROAS)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `time_to_conversion_hours` SET TAGS ('dbx_business_glossary_term' = 'Time to Conversion (Hours)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `total_touchpoints` SET TAGS ('dbx_business_glossary_term' = 'Total Touchpoints');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `touchpoint` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `touchpoint_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `touchpoint_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`attribution` ALTER COLUMN `weight` SET TAGS ('dbx_business_glossary_term' = 'Attribution Weight');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` SET TAGS ('dbx_subdomain' = 'audience_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `social_listening_record_id` SET TAGS ('dbx_business_glossary_term' = 'Social Listening Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `capture_date` SET TAGS ('dbx_business_glossary_term' = 'Capture Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `social_listening_record_code` SET TAGS ('dbx_business_glossary_term' = 'Social Listening Record Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `competitive_brand_mention_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Brand Mention Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `crisis_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Crisis Alert Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `data_collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `data_source_provider` SET TAGS ('dbx_business_glossary_term' = 'Data Source Provider');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `social_listening_record_description` SET TAGS ('dbx_business_glossary_term' = 'Social Listening Record Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `engagement` SET TAGS ('dbx_business_glossary_term' = 'Engagement');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `engagement_count` SET TAGS ('dbx_business_glossary_term' = 'Engagement Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `facebook_mention_count` SET TAGS ('dbx_business_glossary_term' = 'Facebook Mention Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `geography_scope` SET TAGS ('dbx_business_glossary_term' = 'Geography Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `geography_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country|local');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `geography_scope` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `geography_scope` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `impressions_estimate` SET TAGS ('dbx_business_glossary_term' = 'Impressions Estimate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `influencer_mention_count` SET TAGS ('dbx_business_glossary_term' = 'Influencer Mention Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `instagram_mention_count` SET TAGS ('dbx_business_glossary_term' = 'Instagram Mention Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `language_codes` SET TAGS ('dbx_business_glossary_term' = 'Language Codes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `mention_count` SET TAGS ('dbx_business_glossary_term' = 'Mention Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `mention_volume` SET TAGS ('dbx_business_glossary_term' = 'Mention Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `monitoring_topic` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Topic');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `social_listening_record_name` SET TAGS ('dbx_business_glossary_term' = 'Social Listening Record Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `negative_mention_count` SET TAGS ('dbx_business_glossary_term' = 'Negative Mention Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `negative_pct` SET TAGS ('dbx_business_glossary_term' = 'Negative Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `net_sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Net Sentiment Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `neutral_mention_count` SET TAGS ('dbx_business_glossary_term' = 'Neutral Mention Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `observation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Observation Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `observation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Observation Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `platform` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `platform` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `positive_mention_count` SET TAGS ('dbx_business_glossary_term' = 'Positive Mention Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `positive_pct` SET TAGS ('dbx_business_glossary_term' = 'Positive Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `reach` SET TAGS ('dbx_business_glossary_term' = 'Reach');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `reach_estimate` SET TAGS ('dbx_business_glossary_term' = 'Reach Estimate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `reddit_mention_count` SET TAGS ('dbx_business_glossary_term' = 'Reddit Mention Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `sentiment_analysis_model` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Analysis Model');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `sentiment_label` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Label');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `share_of_conversation_percent` SET TAGS ('dbx_business_glossary_term' = 'Share of Conversation Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `social_listening_record_status` SET TAGS ('dbx_business_glossary_term' = 'Social Listening Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `tiktok_mention_count` SET TAGS ('dbx_business_glossary_term' = 'TikTok Mention Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `top_theme_1` SET TAGS ('dbx_business_glossary_term' = 'Top Theme 1');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `top_theme_2` SET TAGS ('dbx_business_glossary_term' = 'Top Theme 2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `top_theme_3` SET TAGS ('dbx_business_glossary_term' = 'Top Theme 3');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `topic` SET TAGS ('dbx_business_glossary_term' = 'Topic');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `total_mention_volume` SET TAGS ('dbx_business_glossary_term' = 'Total Mention Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `twitter_mention_count` SET TAGS ('dbx_business_glossary_term' = 'Twitter (X) Mention Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`social_listening_record` ALTER COLUMN `youtube_mention_count` SET TAGS ('dbx_business_glossary_term' = 'YouTube Mention Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` SET TAGS ('dbx_subdomain' = 'audience_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `nielsen_panel_insight_id` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Panel Insight ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `average_basket_size` SET TAGS ('dbx_business_glossary_term' = 'Average Basket Size');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `average_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Average Price Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `avg_price` SET TAGS ('dbx_business_glossary_term' = 'Avg Price');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `brand_switching_rate` SET TAGS ('dbx_business_glossary_term' = 'Brand Switching Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `buyer_age_group` SET TAGS ('dbx_business_glossary_term' = 'Buyer Age Group');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `buyer_age_group` SET TAGS ('dbx_value_regex' = '18-24|25-34|35-44|45-54|55-64|65+');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `buyer_household_size` SET TAGS ('dbx_business_glossary_term' = 'Buyer Household Size');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `buyer_household_size` SET TAGS ('dbx_value_regex' = '1|2|3|4|5+');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `buyer_income_bracket` SET TAGS ('dbx_business_glossary_term' = 'Buyer Income Bracket');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `buyer_income_bracket` SET TAGS ('dbx_value_regex' = 'Under 25K|25K-50K|50K-75K|75K-100K|100K-150K|Over 150K');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `buyer_presence_of_children` SET TAGS ('dbx_business_glossary_term' = 'Buyer Presence of Children');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `buyer_profile_segment` SET TAGS ('dbx_business_glossary_term' = 'Buyer Profile Segment');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `buying_households_count` SET TAGS ('dbx_business_glossary_term' = 'Buying Households Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `nielsen_panel_insight_category` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Panel Insight Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `nielsen_panel_insight_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Panel Insight Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `data_extract_date` SET TAGS ('dbx_business_glossary_term' = 'Data Extract Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `nielsen_panel_insight_description` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Panel Insight Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `distribution_acv_pct` SET TAGS ('dbx_business_glossary_term' = 'Distribution Acv Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `dollar_sales` SET TAGS ('dbx_business_glossary_term' = 'Dollar Sales');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^d{8}$|^d{12,14}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `household_penetration_rate` SET TAGS ('dbx_business_glossary_term' = 'Household Penetration Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `loyalty_index` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Index');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `market_geography` SET TAGS ('dbx_business_glossary_term' = 'Market Geography');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `market_geography` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `market_geography` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `market_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Market Share Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `measurement_level` SET TAGS ('dbx_business_glossary_term' = 'Measurement Level');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `measurement_level` SET TAGS ('dbx_value_regex' = 'category|brand|sku');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `nielsen_panel_insight_name` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Panel Insight Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `nielsen_panel_insight_status` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Panel Insight Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `panel_code` SET TAGS ('dbx_business_glossary_term' = 'Panel ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `panel_name` SET TAGS ('dbx_business_glossary_term' = 'Panel Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `panel_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Panel Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `panel_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Panel Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `purchase_frequency` SET TAGS ('dbx_business_glossary_term' = 'Purchase Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `repeat_purchase_rate` SET TAGS ('dbx_business_glossary_term' = 'Repeat Purchase Rate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `share_of_category_spend` SET TAGS ('dbx_business_glossary_term' = 'Share of Category Spend');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `share_of_category_volume` SET TAGS ('dbx_business_glossary_term' = 'Share of Category Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `total_panel_households` SET TAGS ('dbx_business_glossary_term' = 'Total Panel Households');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `total_purchase_occasions` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Occasions');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `total_units_purchased` SET TAGS ('dbx_business_glossary_term' = 'Total Units Purchased');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `unit_sales` SET TAGS ('dbx_business_glossary_term' = 'Unit Sales');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`nielsen_panel_insight` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`agency` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
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
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_subdomain' = 'media_investment');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_deprecated_ssot_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_ssot_alias_of' = 'finance.finance_budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_ssot_role' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_ssot_canonical' = 'finance.finance_budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_deprecated_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_ssot_concept' = 'budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_ssot_duplicate_of' = 'finance.finance_budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_ssot_status' = 'deprecated_duplicate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` SET TAGS ('dbx_ssot_authoritative' = 'finance.finance_budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `marketing_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `marketing_budget_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `marketing_budget_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `marketing_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `marketing_budget_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Budget Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Spent Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` SET TAGS ('dbx_subdomain' = 'audience_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `market_share_record_id` SET TAGS ('dbx_business_glossary_term' = 'Market Share Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `acv_percent` SET TAGS ('dbx_business_glossary_term' = 'All Commodity Volume (ACV) Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `brand_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Brand Value Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `brand_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Brand Volume Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `market_share_record_category` SET TAGS ('dbx_business_glossary_term' = 'Market Share Record Category');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `category_total_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Category Total Value Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `category_total_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Category Total Volume Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Retail Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `market_share_record_code` SET TAGS ('dbx_business_glossary_term' = 'Market Share Record Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'nielsen_iq|iri_circana|internal|other');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `data_source_report_code` SET TAGS ('dbx_business_glossary_term' = 'Data Source Report ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `market_share_record_description` SET TAGS ('dbx_business_glossary_term' = 'Market Share Record Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography_code` SET TAGS ('dbx_business_glossary_term' = 'Geography Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography_code` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography_level` SET TAGS ('dbx_business_glossary_term' = 'Geography Level');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography_level` SET TAGS ('dbx_value_regex' = 'national|regional|state|metro|local');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography_level` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography_level` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography_name` SET TAGS ('dbx_business_glossary_term' = 'Geography Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography_name` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `geography_name` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `is_projected` SET TAGS ('dbx_business_glossary_term' = 'Is Projected');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `market_definition` SET TAGS ('dbx_business_glossary_term' = 'Market Definition');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `market_share_record_status` SET TAGS ('dbx_business_glossary_term' = 'Market Share Record Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `market_share_record_name` SET TAGS ('dbx_business_glossary_term' = 'Market Share Record Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|yearly');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `rank_position` SET TAGS ('dbx_business_glossary_term' = 'Rank Position');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `share_change_pct` SET TAGS ('dbx_business_glossary_term' = 'Share Change Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `share_point_change` SET TAGS ('dbx_business_glossary_term' = 'Share Point Change');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `tdp_count` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Points (TDP) Count');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `value_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Value Share Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `value_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Value Share Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `volume_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Volume Share Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `volume_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Volume Share Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`market_share_record` ALTER COLUMN `year_over_year_change_percent` SET TAGS ('dbx_business_glossary_term' = 'Year Over Year (YOY) Change Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `activation_budget` SET TAGS ('dbx_business_glossary_term' = 'Activation Budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `activation_rights` SET TAGS ('dbx_business_glossary_term' = 'Activation Rights');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `agency_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Partner Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `annual_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Value Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `annual_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `contract_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration in Years');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `contract_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `contract_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_description` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `fee` SET TAGS ('dbx_business_glossary_term' = 'Fee');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `hospitality_entitlements` SET TAGS ('dbx_business_glossary_term' = 'Hospitality Entitlements');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `measurement_framework` SET TAGS ('dbx_business_glossary_term' = 'Measurement Framework');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `media_rights` SET TAGS ('dbx_business_glossary_term' = 'Media Rights');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Objective');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `partner` SET TAGS ('dbx_business_glossary_term' = 'Partner');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `performance_obligations` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligations');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `property_name` SET TAGS ('dbx_business_glossary_term' = 'Property Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `property_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Property Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `rights_fee` SET TAGS ('dbx_business_glossary_term' = 'Rights Fee');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `roi_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `sponsorship_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `termination_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'title|presenting|official|associate|supporting|partner');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`sponsorship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_deprecated_ssot_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_ssot_alias_of' = 'promotion.promotion_event');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_ssot_owner' = 'event');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_ssot' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_ssot_role' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_ssot_canonical' = 'promotion.promotion_event');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_deprecated_duplicate' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_ssot_concept' = 'event');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_ssot_duplicate_of' = 'promotion.promotion_event');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_ssot_status' = 'deprecated_duplicate');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` SET TAGS ('dbx_ssot_authoritative' = 'promotion.promotion_event');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `marketing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `agency_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `esg_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Commitment Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_ssot_resolution' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Account ID');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `actual_attendance` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendance');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `marketing_event_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `marketing_event_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `event_budget` SET TAGS ('dbx_business_glossary_term' = 'Event Budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `event_name` SET TAGS ('dbx_business_glossary_term' = 'Event Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `expected_attendance` SET TAGS ('dbx_business_glossary_term' = 'Expected Attendance');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `marketing_event_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `marketing_event_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_event` ALTER COLUMN `venue` SET TAGS ('dbx_business_glossary_term' = 'Venue');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` SET TAGS ('dbx_association_edges' = 'customer.trade_account,marketing.brand');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `brand_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Assignment - Brand Assignment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `brand_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `brand_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `brand_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Assignment - Marketing Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Assignment - Trade Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Assigned By');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `brand_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Assignment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `brand_assignment_status` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `brand_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Assignment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `brand_assignment_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Assignment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `distribution_tier` SET TAGS ('dbx_business_glossary_term' = 'Distribution Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Launch Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `launch_date` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `brand_assignment_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Assignment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `primary_brand_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Brand Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `primary_brand_flag` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `responsibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` SET TAGS ('dbx_association_edges' = 'supply.network_node,marketing.brand');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `brand_distribution_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation - Brand Distribution Allocation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `distribution_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Facility Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation - Marketing Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation - Supply Network Node Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocated_budget` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocated_volume` SET TAGS ('dbx_business_glossary_term' = 'Allocated Volume');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation - Allocation Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocation_period` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `brand_distribution_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `brand_distribution_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `brand_distribution_allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation - Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation - Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `brand_distribution_allocation_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `primary_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Distribution Allocation - Primary Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`brand_distribution_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` SET TAGS ('dbx_association_edges' = 'marketing.campaign,inventory.stock_position');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `campaign_inventory_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Inventory Allocation - Allocation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Inventory Allocation - Campaign Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `media_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Media Plan Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Inventory Allocation - Stock Position Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocated_units` SET TAGS ('dbx_business_glossary_term' = 'Allocated Units');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocation_period` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `allocation_uom` SET TAGS ('dbx_business_glossary_term' = 'Allocation Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `campaign_inventory_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Inventory Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `campaign_inventory_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Inventory Allocation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `consumed_units` SET TAGS ('dbx_business_glossary_term' = 'Consumed Units');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `campaign_inventory_allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Inventory Allocation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `campaign_inventory_allocation_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Inventory Allocation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_inventory_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` SET TAGS ('dbx_subdomain' = 'media_investment');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` SET TAGS ('dbx_association_edges' = 'marketing.campaign,sustainability.carbon_offset');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` SET TAGS ('dbx_ssot_concept' = 'offset_allocation');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` SET TAGS ('dbx_ssot' = 'secondary');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` SET TAGS ('dbx_ssot_canonical' = 'distribution.distribution_offset_allocation');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` SET TAGS ('dbx_ssot_role' = 'primary');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` SET TAGS ('dbx_ssot_status' = 'authoritative');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `marketing_offset_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Offset Allocation - Offset Allocation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Offset Allocation - Campaign Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Offset Allocation - Carbon Offset Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `marketing_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Brand Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `distribution_offset_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Offset Allocation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `distribution_offset_allocation_id` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `allocated_co2e_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Allocated Co2e Tonnes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `allocation_currency` SET TAGS ('dbx_business_glossary_term' = 'Allocation Currency');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `allocation_period` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `carbon_offset_amount` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `marketing_offset_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Offset Allocation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `credit_quantity_purchased` SET TAGS ('dbx_business_glossary_term' = 'Purchased Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `marketing_offset_allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Marketing Offset Allocation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `emission_quantity_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Emission Quantity Tco2e');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `emission_scope` SET TAGS ('dbx_business_glossary_term' = 'Emission Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `marketing_offset_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Offset Allocation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `marketing_offset_allocation_name` SET TAGS ('dbx_business_glossary_term' = 'Marketing Offset Allocation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `offset_quantity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Offset Quantity Tonnes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `offset_tonnes_co2e` SET TAGS ('dbx_business_glossary_term' = 'Offset Tonnes Co2e');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `purchase_cost` SET TAGS ('dbx_business_glossary_term' = 'Purchase Cost');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`marketing_offset_allocation` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` SET TAGS ('dbx_association_edges' = 'marketing.campaign,regulatory.submission');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `campaign_submission_link_id` SET TAGS ('dbx_business_glossary_term' = 'Campaignsubmissionlink - Association Product Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaignsubmissionlink - Campaign Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `creative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Asset Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Campaignsubmissionlink - Submission Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `campaign_submission_link_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Submission Link Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `campaign_submission_link_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Submission Link Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `campaign_submission_link_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Submission Link Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `link_status` SET TAGS ('dbx_business_glossary_term' = 'Link Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `campaign_submission_link_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Submission Link Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_pii_personal_data' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `reviewer` SET TAGS ('dbx_business_glossary_term' = 'Reviewer');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `submission_url` SET TAGS ('dbx_business_glossary_term' = 'Submission Url');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `submitted_by` SET TAGS ('dbx_business_glossary_term' = 'Submitted By');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_submission_link` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` SET TAGS ('dbx_subdomain' = 'campaign_execution');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` SET TAGS ('dbx_association_edges' = 'marketing.campaign,workforce.employee');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `campaign_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Assignment - Campaign Assignment Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assignee Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `campaign_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Assignment - Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `campaign_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `campaign_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Assignment - Campaign Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Pct');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `assigned_by` SET TAGS ('dbx_business_glossary_term' = 'Assigned By');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `campaign_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Assignment Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `campaign_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Assignment Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `campaign_assignment_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Assignment Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `campaign_assignment_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Assignment Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `responsibility_area` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Area');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `responsibility_description` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `responsibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Scope');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`campaign_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` SET TAGS ('dbx_subdomain' = 'audience_insights');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` SET TAGS ('dbx_association_edges' = 'marketing.event,workforce.employee');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` SET TAGS ('dbx_vibe_required_structure' = 'v2');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `event_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Event Participation - Event Participation Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Event Participation - Employee Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `influencer_id` SET TAGS ('dbx_business_glossary_term' = 'Influencer Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `marketing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Participation - Marketing Event Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `attendance_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Attendance Confirmed');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `attendance_flag` SET TAGS ('dbx_business_glossary_term' = 'Attendance Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `attended` SET TAGS ('dbx_business_glossary_term' = 'Attended');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `attended_flag` SET TAGS ('dbx_business_glossary_term' = 'Attended Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `check_in_time` SET TAGS ('dbx_business_glossary_term' = 'Check In Time');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check In Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `check_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check Out Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `event_participation_code` SET TAGS ('dbx_business_glossary_term' = 'Event Participation Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `event_participation_description` SET TAGS ('dbx_business_glossary_term' = 'Event Participation Description');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `event_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Event Participation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `feedback_rating` SET TAGS ('dbx_business_glossary_term' = 'Feedback Rating');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `lead_captured` SET TAGS ('dbx_business_glossary_term' = 'Lead Captured');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `lead_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead Generated Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `event_participation_name` SET TAGS ('dbx_business_glossary_term' = 'Event Participation Name');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `participant_role` SET TAGS ('dbx_business_glossary_term' = 'Participant Role');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `participation_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `participation_hours` SET TAGS ('dbx_business_glossary_term' = 'Participation Hours');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `participation_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Type');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Participation Role');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Uom');
ALTER TABLE `vibe_consumer_goods_v1`.`marketing`.`event_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
