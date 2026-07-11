-- Schema for Domain: sales | Business: Media_Broadcasting | Version: v3_mvm
-- Generated on: 2026-07-10 21:14:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`sales` COMMENT 'Manages the commercial sales pipeline for advertising, content licensing, syndication, and distribution deals. Owns accounts, opportunities, proposals, rate cards, upfront commitments, agency relationships, scatter market inventory, commission structures, and executed sales contracts. Powered by Salesforce Media Cloud, this domain tracks deal stages and feeds confirmed orders to advertising trafficking and billing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` (
    `ad_order_id` BIGINT COMMENT 'Unique identifier for the advertising sales order. Primary key. System-generated surrogate key for the ad order record.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (brand or company) placing the advertising order. Links to advertiser master record in Salesforce Media Cloud.',
    `affiliate_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.affiliate_agreement. Business justification: Ad orders for local affiliate insertion avails reference the affiliate agreement governing preemption rights, local_ad_avails_minutes_per_hour, and retransmission_revenue_split. Sales operations requi',
    `billing_account_id` BIGINT COMMENT 'External reference to the originating sales opportunity in Salesforce Media Cloud CRM. 15 or 18 character Salesforce record ID.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Ad orders are sold by sales teams organized into cost centers. Commission calculation, sales performance analysis, and cost center P&L attribution require linking orders to the responsible cost center',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Normalize campaign reference from STRING name to proper FK. Ad order should be linked to campaign master record for rollup reporting and campaign management. Currently denormalized as campaign_name ST',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Ad orders are contracted against specific delivery channels (e.g., FAST channel, OTT tier, linear). Ad trafficking, billing reconciliation, and order fulfillment all require knowing the target deliver',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Ad orders target specific Nielsen demographic segments (A18-49, W25-54, etc.) for campaign planning, rate card pricing, and GRP/TRP guarantees. Core to media buying operations and upfront/scatter deal',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: OTT ad orders are sold against specific OTT platforms (e.g., Peacock, Paramount+). Platform-specific CPM rates, DAI configuration, and billing are tied to the OTT platform. Ad sales reporting by platf',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Ad orders often involve content partners (studios, syndicators) whose programming forms the inventory being sold. Real business process: integrated sales where content acquisition and ad sales are coo',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to sales.proposal. Business justification: An ad order is the confirmed execution of an accepted proposal. The proposal captures the pre-sale terms (CPM, GRP targets, flight dates, daypart mix), and the ad_order is the binding commercial recor',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser. Nullable if direct advertiser purchase. Links to agency master record.',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Ad orders placed against barter/syndication inventory must reference the syndication agreement governing barter spot allocation, run limits, and clearance obligations. Traffic and billing teams requir',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Ad orders are placed against geographic markets governed by rights territory rules (blackout, exclusivity, holdback). Territory-based revenue reporting and rights clearance validation at order level r',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: An advertising order is frequently the execution of a committed upfront deal. The upfront_deal establishes the annual commitment (total spend, audience guarantees, channel mix), and individual ad_orde',
    `affidavit_required_flag` BOOLEAN COMMENT 'Indicates whether proof of broadcast affidavits must be provided to the advertiser. True = affidavits required; False = not required. Affidavits document actual air times and are often required for political advertising.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Agency commission rate as a percentage of gross order value. Standard industry rate is 15%. Applied to calculate net revenue.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the advertising order was confirmed by the advertiser or agency. Marks transition from pending to confirmed status.',
    `contracted_cpm` DECIMAL(18,2) COMMENT 'Contracted Cost Per Mille (cost per thousand impressions) for this advertising order. Key pricing metric for media buying.',
    `contracted_cprp` DECIMAL(18,2) COMMENT 'Contracted Cost Per Rating Point. Pricing metric calculated as total cost divided by GRP. Used for market efficiency comparison.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this advertising order record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this order (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `daypart_mix` STRING COMMENT 'Distribution of advertising spots across broadcast dayparts (time segments of broadcast day). Examples: Prime (8pm-11pm), Early Morning (6am-9am), Late Night (11pm-2am). Stored as comma-separated daypart allocations.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Total discount percentage applied to this order. May include volume discounts, promotional discounts, or negotiated rate reductions.',
    `flight_end_date` DATE COMMENT 'Last date the advertising campaign is scheduled to air. End of the contracted broadcast period.',
    `flight_start_date` DATE COMMENT 'First date the advertising campaign is scheduled to air. Beginning of the contracted broadcast period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this advertising order record was last updated. Audit trail field for change tracking.',
    `makegood_policy` STRING COMMENT 'Policy for providing compensatory ad spots (makegoods) if contracted delivery is not met. Standard = industry-standard makegood terms; Guaranteed = full delivery guarantee; No Makegood = no compensation; Custom = special negotiated terms.. Valid values are `standard|guaranteed|no_makegood|custom`',
    `net_order_value` DECIMAL(18,2) COMMENT 'Net revenue value after agency commissions, discounts, and adjustments. Amount recognized for revenue reporting.',
    `order_notes` STRING COMMENT 'Free-text notes and special instructions for this advertising order. May include trafficking instructions, creative specifications, or client preferences.',
    `order_number` STRING COMMENT 'Business identifier for the advertising order. Externally-known unique order number used in Wide Orbit traffic system and client communications. Also called broadcast order number or traffic order number.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the advertising order. Draft = initial entry; Pending = awaiting approval; Confirmed = accepted by advertiser; Active = currently running; Completed = flight finished; Cancelled = terminated; Invoiced = billed. [ENUM-REF-CANDIDATE: draft|pending|confirmed|active|completed|cancelled|invoiced — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the advertising order based on sales method. Upfront = advance advertising sales event; Scatter = last-minute ad inventory sales; Direct = direct advertiser purchase; Programmatic = automated bidding; Sponsorship = integrated brand partnership; Barter = trade arrangement.. Valid values are `upfront|scatter|direct|programmatic|sponsorship|barter`',
    `payment_terms` STRING COMMENT 'Contractual payment terms for this order (e.g., Net 30, Net 60, Due on Receipt). Defines when payment is due after invoice date.',
    `political_ad_flag` BOOLEAN COMMENT 'Indicates whether this order contains political advertising content. True = political advertising; False = commercial advertising. Political ads have special FCC disclosure and equal-time requirements.',
    `product_category` STRING COMMENT 'Industry classification of the advertised product or service (e.g., automotive, pharmaceutical, retail, financial services). Used for content clearance and regulatory compliance.',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment targeted by this advertising order (e.g., Adults 18-49, Women 25-54, Men 18-34). Used for TRP calculation and spot placement.',
    `target_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points contracted for this order. GRP = Reach × Frequency, measuring total audience delivery weight. Used for campaign performance evaluation.',
    `target_trp` DECIMAL(18,2) COMMENT 'Target Rating Points for specific demographic audience. TRP measures delivery against a defined target audience segment rather than total audience.',
    `total_contracted_value` DECIMAL(18,2) COMMENT 'Total monetary value of the advertising order across all spots and placements. Gross revenue before agency commissions and discounts.',
    `total_spot_count` STRING COMMENT 'Total number of advertising spots (commercial airings) contracted in this order across all placements and dayparts.',
    `wide_orbit_order_reference` STRING COMMENT 'External reference to the corresponding order record in Wide Orbit traffic and billing system. Used for cross-system reconciliation and affidavit generation.',
    CONSTRAINT pk_ad_order PRIMARY KEY(`ad_order_id`)
) COMMENT 'Master record for an advertising sales order (also called a broadcast order or traffic order) placed by an advertiser or agency. Captures the commercial agreement for a campaign buy including order number, advertiser, agency, account executive, total contracted value, currency, order status (pending, confirmed, cancelled, invoiced), order type (upfront, scatter, direct, programmatic), market, daypart mix, flight dates, billing instructions, Wide Orbit order reference, and Salesforce opportunity linkage. SSOT for the advertising order lifecycle.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` (
    `ad_order_line_id` BIGINT COMMENT 'Unique identifier for the advertising order line item. Primary key.',
    `ad_order_id` BIGINT COMMENT 'Reference to the parent advertising order header. Links this line item to its containing order.',
    `ad_pod_id` BIGINT COMMENT 'Foreign key linking to sales.ad_pod. Business justification: An ad order line represents a specific buy unit that is often targeted to a particular ad pod (break position within a program). The ad_pod defines the break container with its inventory class, daypar',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast network or channel where this ad line will air. Determines distribution outlet.',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level ad trafficking is standard broadcast operations — order lines are placed against specific episodes for adjacency targeting, competitive separation, and affidavit reporting. The existing ',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Ad trafficking enforces content-adjacency rules: each order line must reference the content rating of adjacent programming to prevent adult-rated spots airing near childrens content. Traffic coordina',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Ad order lines specify inventory at the channel/daypart level. The delivery channel (FAST, OTT, linear) determines ad insertion method, pricing tier, and trafficking instructions. Line-level delivery ',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Each line item specifies demographic target for GRP/TRP delivery guarantees, CPM/CPRP pricing, and makegood determination. Essential for trafficking, billing reconciliation, and audience guarantee com',
    `makegood_for_line_ad_order_line_id` BIGINT COMMENT 'Reference to the original ad order line that this line is compensating for (if this is a makegood spot). Null if not a makegood.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Order lines target specific dayparts for inventory allocation and pricing. Fulfillment tracking, avail matching, and rate card application require linking lines to master daypart definitions. Removes ',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Normalize creative reference from STRING business key to proper FK. Order line specifies which creative asset to use for the buy. Currently denormalized as isci_code STRING; should FK to isci_creative',
    `actual_grp_delivered` DECIMAL(18,2) COMMENT 'Actual Gross Rating Points (GRP) delivered based on Nielsen measurement. Used for campaign performance analysis and makegood calculation.',
    `actual_impressions_delivered` BIGINT COMMENT 'Actual number of impressions delivered for this line. Sourced from DAI (Dynamic Ad Insertion) systems or CDN (Content Delivery Network) logs for digital campaigns.',
    `actual_spots_aired` STRING COMMENT 'Actual number of spots that successfully aired for this line. Populated from affidavit reconciliation. Used for billing and makegood determination.',
    `competitive_separation_category` STRING COMMENT 'Product or industry category for competitive adjacency restrictions. Prevents competing advertisers from airing in the same pod.',
    `contracted_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points (GRP) contracted for this line. GRP measures total audience reach multiplied by frequency.',
    `contracted_impressions` BIGINT COMMENT 'Total number of impressions (individual ad views) contracted for this line item. Used for digital and OTT (Over-The-Top) campaigns.',
    `contracted_spots` STRING COMMENT 'Total number of ad spots contracted for this line item. Represents the quantity commitment.',
    `contracted_trp` DECIMAL(18,2) COMMENT 'Target Rating Points (TRP) contracted for this line. TRP measures reach within a specific demographic target.',
    `copy_split_rule` STRING COMMENT 'Rules defining how multiple creative versions should be split across the contracted spots (e.g., 50/50, 70/30). Used for A/B testing or creative variation.',
    `cpm` DECIMAL(18,2) COMMENT 'Cost Per Mille (CPM) - the cost per thousand impressions. Key pricing metric for advertising efficiency.',
    `cprp` DECIMAL(18,2) COMMENT 'Cost Per Rating Point (CPRP) - the cost to achieve one rating point. Used to compare efficiency across dayparts and programs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad order line record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values on this line (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to this line (e.g., volume discount, agency commission). Expressed as a percentage (e.g., 15.00 for 15%).',
    `flight_end_date` DATE COMMENT 'End date of the advertising flight window for this line item. Defines when spots must complete airing.',
    `flight_start_date` DATE COMMENT 'Start date of the advertising flight window for this line item. Defines when spots can begin airing.',
    `inventory_type` STRING COMMENT 'Classification of ad inventory purchase type. Upfront is advance commitment; scatter is last-minute; preemptible can be bumped; makegood compensates for missed spots.. Valid values are `upfront|scatter|preemptible|fixed|bonus|makegood`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad order line record was last updated. Audit trail for record changes.',
    `line_number` STRING COMMENT 'Sequential line number within the parent ad order. Determines ordering and display sequence of line items.',
    `line_status` STRING COMMENT 'Current lifecycle status of the ad order line. Tracks progression from booking through execution and reconciliation. [ENUM-REF-CANDIDATE: booked|confirmed|scheduled|aired|preempted|makegooded|cancelled|expired — 8 candidates stripped; promote to reference product]',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total revenue amount for this line item (unit rate × contracted spots). Base amount before discounts or adjustments.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net revenue amount after discounts and before taxes. Used for revenue recognition and financial reporting.',
    `position_preference` STRING COMMENT 'Preferred position within the ad pod (group of ads in a break). Premium positions command higher rates.. Valid values are `first_in_pod|last_in_pod|middle_in_pod|any|fixed_position`',
    `preemption_priority` STRING COMMENT 'Priority level for preemption protection (1=highest, 10=lowest). Lower-priority spots may be bumped for higher-value inventory.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for this line is recognized for financial reporting. Typically aligned with air date or campaign completion.',
    `rotation_instructions` STRING COMMENT 'Instructions for rotating multiple creatives within this line (e.g., even rotation, weighted rotation, sequential). Guides playout system behavior.',
    `special_handling_notes` STRING COMMENT 'Free-text instructions for special handling requirements (e.g., live read, sponsorship billboard, product integration). Communicated to playout operators.',
    `spot_length_seconds` STRING COMMENT 'Duration of the advertising spot in seconds. Standard lengths are 15, 30, 60, or 120 seconds.',
    `trafficking_notes` STRING COMMENT 'Internal notes for trafficking team regarding execution details, creative delivery status, or special coordination requirements.',
    `unit_rate` DECIMAL(18,2) COMMENT 'Price per individual ad spot or unit. Base rate before volume discounts or adjustments.',
    CONSTRAINT pk_ad_order_line PRIMARY KEY(`ad_order_line_id`)
) COMMENT 'Individual line item within an advertising order representing a specific buy unit — a combination of network/channel, daypart, program, spot length, unit rate, contracted GRP/TRP/impression target, and flight window. Each line maps to a specific inventory unit and carries its own status (booked, preempted, makegooded, cancelled). Includes trafficking execution details: assigned ISCI creative(s), rotation instructions, copy split rules, position preferences, competitive adjacency restrictions, and special handling notes for the playout system (Wide Orbit). Sourced from Wide Orbit order line detail. Supports revenue recognition at the line level and feeds affidavit reconciliation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the advertising campaign. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization that owns this campaign.',
    `affiliate_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.affiliate_agreement. Business justification: Campaigns targeting affiliate station inventory reference the affiliate agreement for local avail constraints, minimum_clearance_percentage, and performance_standard_grp_minimum. Network sales teams r',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Campaign-level billing account assignment drives invoice routing, credit limit checks, and payment terms enforcement. Media billing operations require knowing which billing account governs a campaign',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Campaigns are managed by sales teams within cost centers. Campaign ROI analysis and sales team performance measurement require linking campaigns to the responsible cost center for accurate profitabili',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Ad sales campaigns are planned and reported against specific delivery channels (FAST, OTT, linear). Campaign performance reporting, pacing, and billing require knowing which delivery channel the campa',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Campaigns define primary demographic targets that drive all downstream planning, buying, measurement, and guarantee reconciliation. Core to upfront deals, scatter buying, and Nielsen ratings analysis.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Campaigns targeting children under 13 require COPPA declarations for data collection and privacy compliance. Broadcasters must link campaigns to declarations documenting parental consent mechanisms, d',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Campaigns frequently involve co-marketing partnerships with content providers, integrated sponsorships, or campaigns tied to partner-supplied content blocks. Real business process: partnership marketi',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Campaigns targeting regulated audiences (COPPA for childrens, political disclosure rules, alcohol advertising restrictions) must reference the applicable regulatory obligation. Compliance teams track',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser for this campaign. Nullable if direct advertiser relationship.',
    `channel_id` BIGINT COMMENT 'add column scheduling_channel_id (BIGINT) with FK to scheduling.channel.channel_id - campaigns target specific channels and need direct channel linkage for trafficking',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series-level sponsorship campaigns are a core broadcast sales process — an advertiser sponsors an entire series (e.g., presented by Brand X). Campaign planning, upfront negotiations, and audience de',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Campaigns running on syndicated content reference the syndication agreement for barter spot allocation, exclusivity windows, and revenue share reporting. Campaign managers must link campaigns to syndi',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Brand ambassador and celebrity spokesperson campaigns must track featured talent for exclusivity enforcement, usage rights validation, residual calculations, and clearance verification across all camp',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign was approved and moved from draft or proposed status to active status.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the advertising campaign. [ENUM-REF-CANDIDATE: draft|proposed|approved|active|paused|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `campaign_type` STRING COMMENT 'Classification of the campaign objective and strategy.. Valid values are `brand_awareness|direct_response|political|sponsorship|promotional|product_launch`',
    `campaign_code` STRING COMMENT 'External business identifier or code for the campaign used in trafficking and billing systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this campaign.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'The date when the campaign is scheduled to end. Nullable for ongoing campaigns.',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether this campaign is eligible for makegood compensatory ad spots if contracted delivery targets are not met.',
    `market_type` STRING COMMENT 'Geographic market scope classification for the campaign.. Valid values are `national|regional|local|dma_specific`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was last modified.',
    `campaign_name` STRING COMMENT 'Business name of the advertising campaign used for identification and reporting.',
    `notes` STRING COMMENT 'Free-form text field for additional campaign instructions, special requirements, or internal notes.',
    `priority_level` STRING COMMENT 'Priority classification for ad inventory allocation and scheduling conflicts.. Valid values are `standard|priority|premium|guaranteed`',
    `product_brand` STRING COMMENT 'The product, service, or brand being advertised in this campaign.',
    `sales_channel` STRING COMMENT 'The sales channel through which the campaign was sold (upfront advance sales, scatter last-minute, programmatic automated, direct negotiated, or sponsorship).. Valid values are `upfront|scatter|programmatic|direct|sponsorship`',
    `salesforce_campaign_reference` STRING COMMENT 'External reference identifier linking to the campaign record in Salesforce Media Cloud CRM system.',
    `start_date` DATE COMMENT 'The date when the campaign is scheduled to begin airing or serving ads.',
    `target_cpm` DECIMAL(18,2) COMMENT 'Contracted target Cost Per Mille representing the cost per thousand impressions.',
    `target_cprp` DECIMAL(18,2) COMMENT 'Contracted target Cost Per Rating Point representing the cost to achieve one rating point.',
    `target_frequency` DECIMAL(18,2) COMMENT 'Contracted average number of times each unique audience member should be exposed to the campaign.',
    `target_grp` DECIMAL(18,2) COMMENT 'Contracted target Gross Rating Points representing the total audience reach multiplied by frequency goal for the campaign.',
    `target_impressions` BIGINT COMMENT 'Contracted total number of ad impressions to be delivered across the campaign.',
    `target_reach_percent` DECIMAL(18,2) COMMENT 'Contracted percentage of unique audience members to be reached by the campaign.',
    `target_sov_percent` DECIMAL(18,2) COMMENT 'Contracted target Share of Voice representing the percentage of total advertising impressions in the category or daypart.',
    `target_trp` DECIMAL(18,2) COMMENT 'Contracted target Target Rating Points representing reach and frequency goals for a specific demographic segment.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The total contracted budget amount for the entire campaign across all flights and orders.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Advertising campaign master record representing the strategic grouping of ad orders and flights for a single advertiser objective. Tracks campaign name, advertiser, product/brand being advertised, campaign type (brand awareness, direct response, political, sponsorship), total budget, contracted reach and frequency targets, GRP/TRP goals, SOV targets, campaign status, start and end dates, and Salesforce Media Cloud campaign reference. Parent entity above ad orders and flights.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` (
    `advertiser_id` BIGINT COMMENT 'Unique identifier for the advertiser record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Advertiser onboarding requires assigning a billing account for AR management, credit limit enforcement, and invoice delivery. Every media broadcaster links advertisers to billing accounts as the found',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Advertisers in regulated industries (alcohol, pharmaceuticals, political committees) are subject to specific regulatory obligations tracked at the advertiser level for compliance screening and onboard',
    `sales_agency_id` BIGINT COMMENT 'The identifier of the advertising agency that places media buys on behalf of this advertiser, if applicable. Null if the advertiser buys direct.',
    `account_status` STRING COMMENT 'Current lifecycle status of the advertiser account indicating whether the advertiser is actively purchasing inventory.. Valid values are `active|inactive|suspended|pending_approval|closed`',
    `annual_spend_tier` STRING COMMENT 'The classification tier based on annual advertising spend volume, used for pricing, service level, and upfront negotiation priority.. Valid values are `tier_1_platinum|tier_2_gold|tier_3_silver|tier_4_bronze|tier_5_standard`',
    `billing_address_line1` STRING COMMENT 'The primary street address line for billing and invoice delivery.',
    `billing_address_line2` STRING COMMENT 'The secondary address line for suite, floor, or building information.',
    `billing_city` STRING COMMENT 'The city or municipality for the billing address.',
    `billing_country_code` STRING COMMENT 'The three-letter ISO country code for the billing address (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'The postal or ZIP code for the billing address.',
    `billing_state_province` STRING COMMENT 'The state, province, or region for the billing address.',
    `contract_end_date` DATE COMMENT 'The expiration date of the current master advertising services agreement or upfront deal, if applicable.',
    `contract_start_date` DATE COMMENT 'The effective start date of the current master advertising services agreement or upfront deal.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this advertiser record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum outstanding balance allowed for this advertiser before credit hold is applied, in USD.',
    `credit_status` STRING COMMENT 'The credit approval status indicating whether the advertiser is authorized to purchase advertising on credit terms.. Valid values are `approved|on_hold|under_review|declined`',
    `industry_category` STRING COMMENT 'The Interactive Advertising Bureau (IAB) taxonomy category classifying the advertisers primary business vertical (e.g., Automotive, Financial Services, Consumer Packaged Goods).',
    `is_political_advertiser` BOOLEAN COMMENT 'Boolean flag indicating whether this advertiser is a political candidate, party, or issue advocacy group subject to FCC political advertising disclosure requirements.',
    `legal_name` STRING COMMENT 'The full legal registered name of the advertising client or brand as it appears on contracts and invoices.',
    `notes` STRING COMMENT 'Free-text field for internal notes regarding special handling instructions, account history, or relationship management details.',
    `parent_company_name` STRING COMMENT 'The name of the parent or holding company if the advertiser is a subsidiary or brand within a larger corporate structure.',
    `payment_terms` STRING COMMENT 'The contractual payment terms specifying when payment is due after invoice date (e.g., Net 30, Net 60).. Valid values are `net_30|net_60|net_90|prepay|credit_card|due_on_receipt`',
    `preferred_currency_code` STRING COMMENT 'The three-letter ISO currency code for invoicing and financial reporting (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary business contact for campaign communications and invoice delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact at the advertiser organization for campaign coordination and billing inquiries.',
    `primary_contact_phone` STRING COMMENT 'The business phone number of the primary contact for urgent campaign or billing matters.',
    `requires_ad_clearance` BOOLEAN COMMENT 'Boolean flag indicating whether this advertisers creative content requires pre-broadcast clearance review due to industry category (e.g., pharmaceuticals, alcohol, financial services).',
    `tax_identifier` STRING COMMENT 'The advertisers federal tax identification number (EIN in USA, VAT number in EU) used for tax reporting and invoicing.',
    `trade_name` STRING COMMENT 'The doing-business-as (DBA) or brand name used in advertising campaigns and public-facing materials.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this advertiser record was last modified.',
    `website_url` STRING COMMENT 'The primary website URL of the advertiser for brand reference and campaign landing page validation.',
    `wide_orbit_advertiser_code` STRING COMMENT 'The unique advertiser identifier in the Wide Orbit traffic and billing system, used for ad scheduling, sales orders, and invoicing.',
    CONSTRAINT pk_advertiser PRIMARY KEY(`advertiser_id`)
) COMMENT 'Master record for an advertising client (brand or direct advertiser) purchasing airtime or digital inventory. Captures advertiser legal name, trade name, industry category (IAB taxonomy), parent company, billing address, credit limit, credit status, payment terms, tax ID, Salesforce account reference, Wide Orbit advertiser code, and account manager assignment. Distinct from the agency that places buys on behalf of the advertiser. SSOT for advertiser identity within the advertising domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` (
    `sales_agency_id` BIGINT COMMENT 'Unique identifier for the advertising agency or media buying firm. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Sales agencies are billed for commission adjustments and agency fees via a dedicated billing account. Media broadcasters maintain separate billing accounts for agencies to track agency-level AR, commi',
    `accreditation_date` DATE COMMENT 'Date when the agency was granted accreditation status by the broadcaster or industry body.',
    `accreditation_expiry_date` DATE COMMENT 'Date when the current accreditation status expires and requires renewal. Nullable for indefinite accreditation.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the agency with industry bodies or the broadcaster, indicating creditworthiness and eligibility for commission-based billing.. Valid values are `accredited|pending|not-accredited|suspended|revoked`',
    `agency_type` STRING COMMENT 'Classification of the agency based on its primary service offering and operational model.. Valid values are `full-service|media-buying|digital|programmatic|creative|in-house`',
    `billing_address_line1` STRING COMMENT 'First line of the agencys billing address where invoices and financial correspondence should be sent.',
    `billing_address_line2` STRING COMMENT 'Second line of the agencys billing address (suite, floor, building name). Nullable.',
    `billing_city` STRING COMMENT 'City name for the agencys billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the agencys billing address (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `billing_model` STRING COMMENT 'Billing methodology used for this agency. Gross: agency bills advertiser full amount and remits net to broadcaster. Net: broadcaster bills agency net amount. Hybrid: mixed approach.. Valid values are `gross|net|hybrid`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the agencys billing address.',
    `billing_state_province` STRING COMMENT 'State or province code for the agencys billing address (e.g., NY, CA, ON).',
    `commission_rate` DECIMAL(18,2) COMMENT 'Standard commission percentage rate applied to media buys placed by this agency, expressed as a decimal (e.g., 0.1500 for 15%). Used for commission calculation and billing split.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount (in base currency) extended to the agency for outstanding ad orders before payment is required. Used for credit risk management.',
    `holding_company_group` STRING COMMENT 'Name of the parent holding company or agency network to which this agency belongs (e.g., WPP, Omnicom, Publicis, IPG, Dentsu). Null if independent.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this agency record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was last modified. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `sales_agency_name` STRING COMMENT 'Full legal or trade name of the advertising agency or media buying firm.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or historical context about the agency relationship.',
    `onboarding_date` DATE COMMENT 'Date when the agency was first onboarded and approved to place advertising orders with the broadcaster.',
    `payment_terms_days` STRING COMMENT 'Standard number of days allowed for payment after invoice date (e.g., 30, 60, 90). Used for accounts receivable and cash flow forecasting.',
    `preferred_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the agencys preferred billing currency (e.g., USD, CAD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the agency for order confirmations, affidavits, and campaign communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact or account executive at the agency responsible for media buying and campaign coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the agency contact, used for urgent campaign coordination and makegood processing.',
    `sales_agency_status` STRING COMMENT 'Current operational status of the agency relationship. Active agencies can place orders; inactive/suspended/terminated agencies cannot.. Valid values are `active|inactive|suspended|pending-approval|terminated`',
    `status_reason` STRING COMMENT 'Explanation or business reason for the current status, particularly for inactive, suspended, or terminated statuses (e.g., credit issues, contract expiration, voluntary closure).',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number for the agency (e.g., EIN in USA, VAT number in EU) used for tax reporting and compliance.',
    `termination_date` DATE COMMENT 'Date when the agency relationship was terminated or the agency ceased operations. Nullable for active agencies.',
    `website_url` STRING COMMENT 'Official website URL of the advertising agency for reference and verification purposes.',
    `wide_orbit_agency_code` STRING COMMENT 'Unique agency identifier code used in the Wide Orbit traffic and billing system for ad scheduling, sales orders, and invoicing.',
    `created_by` STRING COMMENT 'User identifier or system account that created this agency record. Used for audit trail and data lineage.',
    CONSTRAINT pk_sales_agency PRIMARY KEY(`sales_agency_id`)
) COMMENT 'Master record for an advertising agency or media buying firm that places ad orders on behalf of advertisers. Captures agency name, agency type (full-service, media buying, digital, programmatic), holding company group, commission rate, billing model (gross/net), contact details, Wide Orbit agency code, Salesforce account reference, and accreditation status. Tracks the agency-advertiser relationship for commission calculation and billing split.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` (
    `ad_spot_id` BIGINT COMMENT 'Unique identifier for the individual advertisement spot placement. Primary key for the ad spot entity.',
    `ad_order_line_id` BIGINT COMMENT 'Reference to the parent ad order line that booked this spot. Links the spot to the commercial agreement and campaign.',
    `ad_pod_id` BIGINT COMMENT 'Identifier for the ad pod (commercial break) containing this spot. Groups all spots that aired in the same break.',
    `advertiser_id` BIGINT COMMENT 'Identifier for the advertiser (brand or company) whose creative aired in this spot. Links to advertiser master data.',
    `affiliate_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.affiliate_agreement. Business justification: Ad spots inserted at affiliate stations reference the affiliate agreement for local insertion rights compliance, preemption_rights enforcement, and retransmission_revenue_split reporting. Traffic and ',
    `campaign_id` BIGINT COMMENT 'Identifier for the advertising campaign this spot belongs to. Groups related spots for performance analysis and reporting.',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Ad spots must be traceable to the specific episode in which they aired for affidavit/proof-of-performance reporting, residuals calculation, and audience measurement reconciliation. The existing title_',
    `deliverable_id` BIGINT COMMENT 'Foreign key linking to production.deliverable. Business justification: Ad spots air specific creative assets (deliverables) produced internally or by agencies. Trafficking systems must link scheduled spots to the actual video/audio deliverable for playout, affidavit gene',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Ad spots are aired on specific delivery channels. Affidavit reconciliation, post-log reporting, and billing verification require the exact delivery channel FK. delivery_platform is a plain-text denorm',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Individual spots are trafficked and measured against specific demographic targets for GRP/TRP delivery, makegood determination, and affidavit reconciliation. Essential for Nielsen ratings matching and',
    `device_type_id` BIGINT COMMENT 'Foreign key linking to distribution.device_type. Business justification: Ad delivery systems track device type per spot to verify creative compatibility (resolution, codec, DRM), measure device-specific performance, and support device-targeted campaigns. Critical for devic',
    `original_spot_ad_spot_id` BIGINT COMMENT 'Reference to the original ad spot that this makegood spot is compensating for. Populated only when makegood_flag is true.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Individual aired spots for political, alcohol, or other regulated categories must be traceable to the specific regulatory obligation (e.g., FCC political ad rules, state alcohol restrictions). Complia',
    `sales_agency_id` BIGINT COMMENT 'Identifier for the advertising agency that placed this spot on behalf of the advertiser. May be null for direct advertiser buys.',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Spots air within specific schedule slots. Affidavit generation, as-run reconciliation, and delivery verification require linking each spot to the exact slot it occupied. No existing column fits; creat',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Actual aired spots featuring talent trigger residual payment obligations, require talent clearance tracking for compliance, and enable usage rights validation for each exhibition event across linear a',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Ad spots are subject to territory-specific blackout restrictions and exclusivity rules defined in rights_territory. Traffic operations must validate each spot against the applicable rights territory b',
    `viewer_profile_id` BIGINT COMMENT 'Foreign key linking to subscriber.viewer_profile. Business justification: DAI ad spot targeting and frequency capping in OTT requires knowing which viewer profile within a household received the spot. Profile-level ad delivery tracking is a standard OTT ad operations requir',
    `actual_air_time` TIMESTAMP COMMENT 'The actual date and time when this ad spot aired, as recorded in the broadcast affidavit. Used for proof of performance and billing reconciliation.',
    `ad_pod_position` STRING COMMENT 'Sequential position of this spot within the ad pod (group of ads in a commercial break). Position 1 is the first ad in the break. Pod position affects viewer attention and pricing.',
    `affidavit_reference` STRING COMMENT 'Reference to the broadcast affidavit (proof of performance document) that certifies this spot aired as scheduled. Required for billing and advertiser verification.',
    `billing_status` STRING COMMENT 'Current billing status of this spot. Tracks the spot through the billing lifecycle from unbilled through payment or dispute resolution.. Valid values are `unbilled|billed|invoiced|paid|disputed|written_off`',
    `bonus_spot_flag` BOOLEAN COMMENT 'Indicates whether this spot was provided as a bonus (added value) to the advertiser at no additional charge. Used for revenue recognition and campaign value calculation.',
    `channel_code` STRING COMMENT 'Code identifying the broadcast channel or network where the spot aired (e.g., ABC, NBC, ESPN). Links to channel master data.',
    `cpm_amount` DECIMAL(18,2) COMMENT 'Cost per thousand impressions for this spot. Key pricing metric in advertising sales used to compare efficiency across different placements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ad spot record was first created in the system. Used for audit trail and data lineage.',
    `dai_flag` BOOLEAN COMMENT 'Indicates whether this spot was delivered via Dynamic Ad Insertion technology, allowing personalized ad delivery to different viewers or platforms.',
    `daypart` STRING COMMENT 'Time segment of the broadcast day when the spot aired. Dayparts are used for pricing, audience targeting, and inventory management. Standard dayparts include early morning (6-9am), daytime (9am-4pm), early fringe (4-6pm), prime access (6-8pm), prime time (8-11pm), late fringe (11pm-12am), late night (12-2am), and overnight (2-6am). [ENUM-REF-CANDIDATE: early_morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight — 8 candidates stripped; promote to reference product]',
    `grp_value` DECIMAL(18,2) COMMENT 'Gross Rating Point value delivered by this spot. Measures the size of the audience reached relative to the total market population. Sum of all rating points across the campaign.',
    `impressions_delivered` BIGINT COMMENT 'Total number of impressions (views) delivered by this spot. Used for performance measurement and billing reconciliation.',
    `makegood_flag` BOOLEAN COMMENT 'Indicates whether this spot is a makegood (compensatory ad spot provided to an advertiser due to a previous preemption or underdelivery).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ad spot record was last modified. Tracks changes to scheduling, status, or other attributes.',
    `preempted_flag` BOOLEAN COMMENT 'Indicates whether this spot was preempted (bumped from its scheduled time slot). Preempted spots typically require makegood compensation.',
    `preemption_reason` STRING COMMENT 'Explanation for why the spot was preempted, if applicable. Common reasons include breaking news, technical issues, programming overrun, or higher-priority advertiser.',
    `rotation_pattern` STRING COMMENT 'Describes the rotation or sequencing pattern for this spot within the campaign (e.g., ROS - Run of Schedule, fixed position, alternating). Used for inventory management and fulfillment.',
    `scheduled_air_date` DATE COMMENT 'The date on which this ad spot was scheduled to air. Used for planning and inventory management.',
    `scheduled_air_time` TIMESTAMP COMMENT 'The precise date and time when this ad spot was scheduled to air. Includes timezone information for accurate cross-platform scheduling.',
    `separation_requirement` STRING COMMENT 'Specifies any separation rules for this spot (e.g., competitive separation, minimum time between airings). Ensures advertiser requirements are met.',
    `spot_length_seconds` STRING COMMENT 'Duration of the advertisement spot in seconds. Common values include 15, 30, 60, 90, and 120 seconds.',
    `spot_rate_amount` DECIMAL(18,2) COMMENT 'The rate charged for this individual spot placement. May differ from the order line rate due to daypart, program, or inventory adjustments.',
    `spot_rate_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the spot rate amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `spot_status` STRING COMMENT 'Current lifecycle status of the ad spot. Tracks whether the spot was scheduled, successfully aired, preempted, cancelled, or requires makegood processing.. Valid values are `scheduled|aired|preempted|cancelled|makegood_pending|makegood_fulfilled`',
    `traffic_log_reference` STRING COMMENT 'Reference identifier to the Wide Orbit traffic log entry that scheduled and tracked this spot. Used for audit trail and reconciliation.',
    `trp_value` DECIMAL(18,2) COMMENT 'Target Rating Point value delivered by this spot. Measures audience reach within a specific demographic target segment, more precise than GRP.',
    CONSTRAINT pk_ad_spot PRIMARY KEY(`ad_spot_id`)
) COMMENT 'Individual scheduled advertisement placement (spot) within a broadcast or digital break. Represents the atomic unit of ad delivery — a single commercial airing with ISCI code, spot length (seconds), scheduled air date and time, channel/network, program, daypart, pod position, actual air time (from affidavit), preemption flag, makegoood flag, DAI flag, and Wide Orbit traffic log reference. Links to the ad order line that booked it and the creative (isci) that aired.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` (
    `ad_pod_id` BIGINT COMMENT 'Unique identifier for the advertising pod. Primary key.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Ad pods are embedded within title airings. Business process: dynamic ad insertion planning, SCTE-35 cue point management, break placement optimization, pod-level inventory forecasting by title.',
    `affiliate_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.affiliate_agreement. Business justification: Ad pods designated for local affiliate insertion reference the affiliate agreement governing local_ad_avails_minutes_per_hour and local_insertion_rights_flag. Traffic systems require this link to corr',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast or streaming channel where this ad pod is scheduled.',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Ad pods (commercial breaks) are placed within specific episodes in broadcast trafficking. Episode-level pod assignment is required for scheduling, SCTE-35 cue point management, and DAI configuration. ',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Ad pods must be validated against the surrounding programs content rating to enforce advertiser separation and parental-control requirements. The existing plain `content_rating` column is a denormali',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Ad pods are associated with specific delivery channels (FAST channel, linear, OTT). The delivery channel determines ad insertion method (server-side DAI vs. linear SCTE-35), monetization model, and in',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Ad pods are priced and sold against specific demographic segments — CPM rate cards and inventory class are segment-driven. The plain column audience_target_demo is a denormalized representation; repla',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: OTT ad pods are configured per OTT platform with platform-specific DAI rules, max spot counts, and SCTE-35 cue configurations. Ad pod inventory management and DAI yield optimization require knowing wh',
    `program_schedule_id` BIGINT COMMENT 'Reference to the program schedule entry that contains this ad pod.',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Ad pods in syndicated programming reference the syndication agreement to enforce barter_spot_count limits and clearance obligations per break. Scheduling and traffic teams require this link to allocat',
    `actual_end_time` TIMESTAMP COMMENT 'Actual date and time when the ad pod concluded airing, used for billing reconciliation and performance verification.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual date and time when the ad pod began airing, captured from playout automation for affidavit generation and makegood processing.',
    `alcohol_ad_allowed_flag` BOOLEAN COMMENT 'Indicates whether alcohol advertising is permitted within this ad pod, based on daypart restrictions and content adjacency policies.',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether this ad pod is subject to geographic broadcast restrictions or blackout rules, preventing distribution in certain markets.',
    `break_position` STRING COMMENT 'Position of the ad break within the program content flow. Pre-roll occurs before content starts, mid-roll during content, post-roll after content ends, interstitial between segments, bumper as short transition, and outro at program conclusion.. Valid values are `pre-roll|mid-roll|post-roll|interstitial|bumper|outro`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ad pod record was first created in the system, used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values associated with this ad pod (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `dai_enabled_flag` BOOLEAN COMMENT 'Indicates whether this ad pod supports Dynamic Ad Insertion for personalized, server-side ad stitching in streaming environments.',
    `daypart` STRING COMMENT 'Time segment of the broadcast day during which this ad pod airs, used for audience targeting and pricing. Early morning (6-9 AM), daytime (9 AM-4 PM), early fringe (4-6 PM), prime access (6-8 PM), prime time (8-11 PM), late fringe (11 PM-midnight), late night (midnight-2 AM), overnight (2-6 AM). [ENUM-REF-CANDIDATE: early_morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight — 8 candidates stripped; promote to reference product]',
    `estimated_grp` DECIMAL(18,2) COMMENT 'Projected Gross Rating Points for this ad pod, representing the sum of all rating points delivered across all spots within the pod.',
    `estimated_reach` STRING COMMENT 'Projected unique audience count (in thousands) expected to view this ad pod, based on historical ratings and program performance.',
    `geographic_market_code` STRING COMMENT 'Nielsen Designated Market Area (DMA) code or equivalent geographic market identifier where this ad pod airs, used for regional targeting and blackout enforcement.',
    `inventory_class` STRING COMMENT 'Classification of the ad pod inventory by pricing tier and sales priority. Premium for high-demand slots, standard for regular inventory, remnant for unsold last-minute inventory, bonus for value-added makegoods.. Valid values are `premium|standard|remnant|bonus`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ad pod record was most recently updated, used for change tracking and reconciliation.',
    `max_spot_count` STRING COMMENT 'Maximum number of individual ad spots that can be scheduled within this pod, governing inventory capacity.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or operational notes related to this ad pod.',
    `platform_type` STRING COMMENT 'Distribution platform type for this ad pod. Linear for traditional scheduled broadcast, VOD (Video On Demand) for on-demand viewing, SVOD (Subscription Video On Demand) for subscription services, AVOD (Advertising-Supported Video On Demand) for ad-supported streaming, TVOD (Transactional Video On Demand) for pay-per-view, OTT (Over-The-Top) for internet delivery, FAST (Free Ad-Supported Streaming Television) for linear streaming channels. [ENUM-REF-CANDIDATE: linear|vod|svod|avod|tvod|ott|fast — 7 candidates stripped; promote to reference product]',
    `pod_code` STRING COMMENT 'Unique business identifier or code for the ad pod used in trafficking and billing systems.',
    `pod_duration_seconds` STRING COMMENT 'Total duration of the ad pod in seconds, representing the maximum time allocated for all ad spots within this break.',
    `pod_name` STRING COMMENT 'Human-readable name or label for the ad pod, often used for internal identification and trafficking purposes.',
    `pod_rate_card_cpm` DECIMAL(18,2) COMMENT 'Standard rate card Cost Per Mille (cost per thousand impressions) for this ad pod, used as the baseline pricing for inventory sales negotiations.',
    `pod_status` STRING COMMENT 'Current lifecycle status of the ad pod. Scheduled indicates planned but not locked, confirmed indicates inventory committed, aired indicates successfully broadcast, preempted indicates replaced by higher-priority content, cancelled indicates removed from schedule, makegoods_required indicates compensatory spots needed due to delivery issues.. Valid values are `scheduled|confirmed|aired|preempted|cancelled|makegoods_required`',
    `pod_type` STRING COMMENT 'Classification of the ad pod by content purpose. Commercial for paid advertising, promotional for network self-promotion, PSA (Public Service Announcement) for non-profit messaging, network for national inventory, affiliate for station-level inventory, local for regional inventory.. Valid values are `commercial|promotional|psa|network|affiliate|local`',
    `political_ad_allowed_flag` BOOLEAN COMMENT 'Indicates whether political advertising is permitted within this ad pod, subject to FCC equal time and disclosure requirements.',
    `sales_market` STRING COMMENT 'Market channel through which the ad pod inventory was sold. Upfront for advance commitment sales, scatter for last-minute inventory sales, programmatic for automated bidding platforms, direct for one-on-one advertiser deals.. Valid values are `upfront|scatter|programmatic|direct`',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned date and time when the ad pod is scheduled to conclude, calculated from start time plus pod duration.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned date and time when the ad pod is scheduled to begin airing, in ISO 8601 format with timezone.',
    `scte35_cue_point_reference` STRING COMMENT 'Reference identifier for the SCTE-35 (Society of Cable Telecommunications Engineers) cue point that triggers this ad pod insertion in the broadcast stream.',
    CONSTRAINT pk_ad_pod PRIMARY KEY(`ad_pod_id`)
) COMMENT 'Definition of an advertising break pod within a program or channel schedule — the container that holds a sequence of ad spots. Captures pod ID, channel, program, break position (pre-roll, mid-roll, post-roll, interstitial), pod duration (seconds), maximum spot count, pod type (commercial, promotional, PSA), SCTE-35 cue point reference, and DAI-enabled flag. Governs inventory capacity and break structure for trafficking and DAI systems.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Unique identifier for the sales proposal. Primary key for this entity.',
    `affiliate_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.affiliate_agreement. Business justification: Proposals for local affiliate ad avails must reference the affiliate agreement that defines local_ad_avails_minutes_per_hour and local_insertion_rights_flag. Sales teams must verify available local in',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Proposals are prepared against cost center budgets for resource allocation and approval workflows. Enables budget availability checks and cost center-based approval routing in media sales operations.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: A proposal is the pre-sale document submitted for a specific advertising campaign. Once accepted, the proposal maps directly to a campaign record. Adding campaign_id to proposal formalizes this lifecy',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Proposals specify primary channel for inventory offering. Sales teams build proposals around channel audience profiles and ratings. Business process: proposal generation, inventory packaging, channel-',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Media proposals are built against specific delivery channels to price inventory correctly. Sales planners need the delivery channel FK to pull accurate rate cards, availability, and audience data. pla',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Proposals specify demographic targets for reach/frequency planning, GRP/TRP projections, and CPM/CPRP pricing. Essential for sales process, rate card application, and client presentation. Replaces den',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: OTT-specific proposals require referencing the target OTT platform for accurate inventory availability, pricing, and audience reach estimates. Sales planners building OTT proposals need this FK. platf',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization to whom this proposal is being submitted. The ultimate client purchasing the advertising inventory.',
    `proposal_sales_advertiser_id` BIGINT COMMENT '',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Pre-sale proposals for regulated categories (political, alcohol, childrens programming) must reference the applicable regulatory obligation so sales planners can flag compliance requirements before c',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser in this proposal negotiation. Nullable if the advertiser is buying direct.',
    `accepted_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal was accepted by the advertiser or agency. Null if not yet accepted or if rejected.',
    `agency_commission_percentage` DECIMAL(18,2) COMMENT 'Agency commission percentage to be paid to the agency from the gross proposal value. Typically 15% in the industry. Null if direct advertiser buy.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal was internally approved for submission to the client.',
    `audience_guarantee_flag` BOOLEAN COMMENT 'Indicates whether the proposal includes an audience delivery guarantee with makegood provisions if targets are not met.',
    `campaign_end_date` DATE COMMENT 'Proposed end date for the advertising campaign covered by this proposal.',
    `campaign_start_date` DATE COMMENT 'Proposed start date for the advertising campaign covered by this proposal.',
    `cancellation_terms` STRING COMMENT 'Terms and conditions for cancellation of the proposal or resulting order, including notice periods and penalties.',
    `channel_mix_summary` STRING COMMENT 'High-level summary of the proposed channel distribution (e.g., 60% Linear TV, 30% OTT, 10% Digital). Detailed channel breakdown is in proposal line items.',
    `competitive_situation` STRING COMMENT 'Internal notes on competitive dynamics, other bidders, and strategic positioning for this proposal.',
    `content_adjacency_preferences` STRING COMMENT 'Client-specified preferences or restrictions for content types adjacent to ad placements (e.g., sports, news, drama, avoid violent content).',
    `cpm` DECIMAL(18,2) COMMENT 'Proposed Cost Per Mille (CPM) - the cost per thousand impressions. Key pricing metric for advertising inventory.',
    `cprp` DECIMAL(18,2) COMMENT 'Proposed Cost Per Rating Point (CPRP) - the cost to achieve one rating point in the target demographic. Key pricing metric for broadcast advertising.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this proposal (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `daypart_mix` STRING COMMENT 'Distribution of proposed ad spots across broadcast dayparts (e.g., Prime Time, Early Morning, Late Night, Weekend), expressed as percentages or spot counts per daypart.',
    `daypart_mix_summary` STRING COMMENT 'High-level summary of the proposed daypart distribution (e.g., 40% Prime, 30% Early Fringe, 20% Late Night, 10% Weekend). Detailed daypart breakdown is in proposal line items.',
    `demographic_target` STRING COMMENT 'Primary audience demographic segment targeted by this proposal, expressed in standard Nielsen notation (e.g., Adults 25-54, Women 18-49).',
    `proposal_description` STRING COMMENT 'Detailed narrative description of the proposal, including campaign objectives, creative strategy, and value proposition.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount or price reduction offered in the proposal, applied to the total proposed value.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Overall discount percentage applied to the proposal (e.g., volume discount, upfront commitment discount). Null if no discount applied.',
    `expiry_date` DATE COMMENT 'Date when the proposal expires and is no longer valid for acceptance. After this date, pricing and inventory availability must be re-confirmed.',
    `flight_end_date` DATE COMMENT 'Proposed end date for the advertising campaign or content delivery period covered by this proposal.',
    `flight_start_date` DATE COMMENT 'Proposed start date for the advertising campaign or content delivery period covered by this proposal.',
    `guaranteed_impressions` BIGINT COMMENT 'Minimum number of impressions contractually guaranteed to be delivered, triggering makegood obligations if underdelivered.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal record was last updated or revised.',
    `makegood_policy` STRING COMMENT 'Description of the makegood policy for this proposal - the terms under which compensatory ad spots will be provided if delivery guarantees are not met.',
    `market_type` STRING COMMENT 'Sales market context for this proposal: upfront (advance commitment sales event), scatter (last-minute inventory sales), programmatic (automated bidding), or direct (one-to-one negotiation).. Valid values are `upfront|scatter|programmatic|direct`',
    `proposal_name` STRING COMMENT 'Descriptive name or title of the proposal, typically reflecting the campaign or client name.',
    `net_proposed_value` DECIMAL(18,2) COMMENT 'Net revenue value of the proposal after discounts and agency commissions. This is the expected revenue to the broadcaster.',
    `notes` STRING COMMENT 'Free-form notes and comments about the proposal, including special terms, negotiation history, or client-specific requirements.',
    `platform_mix` STRING COMMENT 'Distribution of proposed inventory across delivery platforms: linear (traditional broadcast), OTT (over-the-top streaming), FAST (free ad-supported streaming TV), AVOD (advertising video on demand), SVOD (subscription video on demand).',
    `proposal_date` DATE COMMENT 'Date when the proposal was created and issued to the advertiser or agency.',
    `proposal_number` STRING COMMENT 'Externally-visible unique business identifier for the proposal, used in client communications and internal tracking.',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the advertising proposal in the sales workflow.. Valid values are `draft|submitted|negotiating|accepted|rejected|expired`',
    `proposal_type` STRING COMMENT 'Category of commercial offer: advertising (spot sales), content licensing (rights acquisition), syndication (content resale), distribution (carriage agreements), sponsorship (branded integration), or upfront (advance commitment).. Valid values are `advertising|content_licensing|syndication|distribution|sponsorship|upfront`',
    `proposed_frequency` DECIMAL(18,2) COMMENT 'Proposed average frequency (number of times) that each reached individual in the target audience will be exposed to the campaign. Frequency = GRP / Reach.',
    `proposed_grp` DECIMAL(18,2) COMMENT 'Total Gross Rating Points (GRP) proposed to be delivered across all dayparts and channels. GRP measures the total exposure weight of the campaign.',
    `proposed_impressions` BIGINT COMMENT 'Total number of impressions (ad views) proposed to be delivered across all channels and platforms in this campaign.',
    `proposed_reach` DECIMAL(18,2) COMMENT 'Proposed reach as a percentage of the target audience that will be exposed to the campaign at least once. Reach measures unique audience coverage.',
    `proposed_trp` DECIMAL(18,2) COMMENT 'Total Target Rating Points (TRP) proposed to be delivered to the specific demographic target audience. TRP measures exposure within the target demo only.',
    `rejected_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal was rejected by the advertiser or agency. Null if not rejected.',
    `response_due_date` DATE COMMENT 'Requested or required date by which the client should provide a decision or response to the proposal.',
    `source` STRING COMMENT 'Origin or trigger for this proposal: response to RFP (request for proposal), proactive sales pitch, contract renewal, upsell to existing client, or cross-sell of additional services.. Valid values are `rfp|proactive_pitch|renewal|upsell|cross_sell`',
    `spot_length_mix_summary` STRING COMMENT 'High-level summary of the proposed spot length distribution (e.g., 80% :30s, 15% :15s, 5% :60s). Detailed spot length breakdown is in proposal line items.',
    `submitted_date` DATE COMMENT 'Date when the proposal was formally submitted to the client or agency for review.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal was formally submitted to the advertiser or agency. Null if still in draft status.',
    `target_cpm` DECIMAL(18,2) COMMENT 'Proposed cost per thousand impressions, a key pricing metric for advertising proposals.',
    `target_grp` DECIMAL(18,2) COMMENT 'Proposed total gross rating points representing reach multiplied by frequency, a standard broadcast audience metric.',
    `target_impressions` BIGINT COMMENT 'Total number of ad impressions or exposures proposed to be delivered across all platforms and dayparts.',
    `terms_and_conditions` STRING COMMENT 'Legal and commercial terms governing the proposal, including payment terms, cancellation policies, makegood provisions, and liability clauses.',
    `total_proposed_value` DECIMAL(18,2) COMMENT 'Total gross revenue value of the proposal in the base currency, before any discounts or agency commissions. Sum of all proposed line items.',
    `version_number` STRING COMMENT 'Sequential version number tracking revisions and iterations of the proposal in response to client feedback or negotiation.',
    `win_probability_percent` DECIMAL(18,2) COMMENT 'Sales team estimated probability of winning this proposal, expressed as a percentage (0-100).',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Pre-sale advertising proposal submitted to an advertiser or agency in response to an RFP or upfront/scatter negotiation. Captures proposal number, advertiser, agency, account executive, proposal date, expiry date, total proposed value, proposed GRP/TRP/impression delivery, channel mix, daypart mix, spot length mix, CPM/CPRP, audience demographic targets, proposal status (draft, submitted, negotiating, accepted, rejected), and Salesforce opportunity reference. Precedes the formal ad order.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` (
    `upfront_deal_id` BIGINT COMMENT 'Unique identifier for the upfront advertising deal negotiation record. Primary key. Role: MASTER_AGREEMENT.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization purchasing the advertising inventory under this deal. Links to the advertiser master record.',
    `affiliate_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.affiliate_agreement. Business justification: Upfront deals for affiliate network inventory reference the affiliate agreement defining revenue_share_percentage, local_ad_avails_minutes_per_hour, and network_compensation_model. Upfront sales teams',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Upfront deals are multi-million dollar annual commitments billed in installments against a specific billing account. Billing operations require this link to generate quarterly installment invoices, tr',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: An upfront deal commitment is executed against a specific advertising campaign. The upfront_deal tracks the full lifecycle from negotiation to commitment, and the resulting campaign is the execution v',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Upfront deals commit annual inventory against specific demographic guarantees (e.g., A18-49 GRP at negotiated CPM). Core to annual negotiation cycle, audience guarantee structuring, and scatter conver',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Upfront deals may commit advertisers to exclusive sponsorship of specific high-value production projects (tentpole events, original series). Deal terms include project-specific inventory guarantees, i',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: OTT upfront deals commit advertiser spend against a specific OTT platform for a broadcast year. Platform-specific upfront commitments, audience guarantees, and makegood obligations require this FK. No',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Upfront deals in broadcasting often involve content distribution partners (networks, studios) providing programming blocks or inventory commitments. Real business process: upfront negotiation tracking',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to sales.proposal. Business justification: An upfront deal originates from a proposal submitted to the advertiser or agency. The upfront_deal is the child record that formalizes the negotiated commitment from the pre-sale proposal. Adding prop',
    `sales_agency_id` BIGINT COMMENT 'Reference to the media buying agency representing the advertiser in this deal negotiation. Nullable for direct advertiser deals. Links to the agency master record.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Upfront deals in broadcast are negotiated at the series/program level — advertisers commit spend against specific series inventory for the broadcast season. This is a defining characteristic of the up',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Upfront deals in broadcasting are negotiated for specific geographic territories with territory-specific pricing, exclusivity, and rights constraints. Sales planning and rights clearance for upfront c',
    `audience_guarantee_grp` DECIMAL(18,2) COMMENT 'Total Gross Rating Points (GRP) guaranteed to the advertiser across all flights and dayparts in this deal. GRP = Reach × Frequency, representing the total audience delivery commitment.',
    `audience_guarantee_impressions` BIGINT COMMENT 'Total number of ad impressions guaranteed to the advertiser. Alternative or complementary metric to GRP, especially for digital and cross-platform deals.',
    `cancellation_option_window_days` STRING COMMENT 'Number of days before flight start date within which the advertiser may cancel or reduce the commitment without penalty. Common in upfront deals to provide flexibility.',
    `channel_mix` STRING COMMENT 'Comma-separated list or description of broadcast channels, networks, or platforms included in this deal (e.g., Network Prime, Cable Bundle, OTT Streaming). Defines the inventory scope.',
    `commitment_date` DATE COMMENT 'Date when the advertiser or agency verbally or formally committed to the deal terms. Nullable until commitment is secured.',
    `cpm_rate` DECIMAL(18,2) COMMENT 'Cost per thousand impressions for CPM-based deals. Nullable if pricing basis is not CPM. Represents the unit price for audience delivery.',
    `cprp_rate` DECIMAL(18,2) COMMENT 'Cost per rating point for CPRP-based deals. Nullable if pricing basis is not CPRP. Represents the unit price per GRP delivered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this upfront deal record was first created in the system. Audit trail for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this deal. Typically USD for US-based broadcasters.. Valid values are `USD|CAD|GBP|EUR|AUD`',
    `daypart_mix` STRING COMMENT 'Comma-separated list or description of dayparts included in this deal (e.g., Prime Time, Early Morning, Late Night, Weekend). Daypart = time segment of broadcast day with distinct audience characteristics.',
    `deal_number` STRING COMMENT 'Externally-known unique business identifier for the upfront deal, typically formatted as prefix-year-sequence (e.g., UF-2024-000123). Used in all client-facing communications and internal references.. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{5,8}$`',
    `deal_status` STRING COMMENT 'Current lifecycle state of the upfront deal. Draft = initial creation; Submitted = sent to client; Negotiating = active discussions; Committed = verbal agreement; Executed = signed contract; Cancelled = deal terminated; Expired = proposal lapsed without commitment. [ENUM-REF-CANDIDATE: draft|submitted|negotiating|committed|executed|cancelled|expired — 7 candidates stripped; promote to reference product]',
    `deal_type` STRING COMMENT 'Classification of the advertising deal based on sales method and timing. Upfront = annual advance commitment during upfront season; Scatter = short-term last-minute inventory; Direct = negotiated one-off; Programmatic = automated auction-based; Sponsorship = integrated content partnership; Barter = trade arrangement.. Valid values are `upfront|scatter|direct|programmatic|sponsorship|barter`',
    `deal_year` STRING COMMENT 'Broadcast year for which this upfront deal applies, typically representing the September-to-August broadcast season (e.g., 2024 for 2024-2025 season). Critical for upfront planning and inventory allocation.',
    `execution_date` DATE COMMENT 'Date when the deal contract was fully executed (signed by all parties). Nullable until contract is finalized.',
    `makegood_provision_flag` BOOLEAN COMMENT 'Indicates whether the deal includes makegood provisions for audience delivery shortfalls. True = makegoods required if guaranteed audience is not delivered; False = no makegood obligation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this upfront deal record was last modified. Audit trail for change tracking and data lineage.',
    `negotiation_round_count` STRING COMMENT 'Number of formal negotiation rounds or proposal revisions submitted during the deal lifecycle. Tracks negotiation complexity and sales effort.',
    `notes` STRING COMMENT 'Free-text field for capturing additional deal terms, special conditions, negotiation history, or internal comments not captured in structured fields. Used by account executives for context and handoff.',
    `option_exercise_deadline` DATE COMMENT 'Final date by which the advertiser must exercise any options included in the deal (e.g., additional quarters, scatter conversion, renewal). Nullable if no options are included.',
    `pricing_basis` STRING COMMENT 'Pricing model used for this deal. CPM (Cost Per Mille) = cost per thousand impressions; CPRP (Cost Per Rating Point) = cost per GRP point; Flat Rate = fixed fee regardless of delivery; Performance = outcome-based pricing.. Valid values are `cpm|cprp|flat_rate|performance`',
    `proposal_date` DATE COMMENT 'Date when the initial deal proposal was formally submitted to the advertiser or agency. Marks the start of the negotiation lifecycle.',
    `salesforce_opportunity_reference` STRING COMMENT 'External reference to the corresponding Salesforce Media Cloud Opportunity record. Enables cross-system traceability between the deal negotiation (Salesforce) and trafficking/billing (Wide Orbit).. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `scatter_conversion_rights` BOOLEAN COMMENT 'Indicates whether the advertiser has the right to convert unused upfront commitment into scatter market inventory at preferential rates. True = conversion allowed; False = no conversion rights.',
    `total_committed_spend` DECIMAL(18,2) COMMENT 'Total dollar value of advertising spend committed by the advertiser after negotiation. Nullable until commitment is secured. This is the final agreed revenue amount.',
    `total_proposed_spend` DECIMAL(18,2) COMMENT 'Total dollar value of advertising spend proposed in the initial deal submission. Represents the gross revenue opportunity before negotiation adjustments.',
    CONSTRAINT pk_upfront_deal PRIMARY KEY(`upfront_deal_id`)
) COMMENT 'Master record for an advertising deal negotiation and commitment — covering the full lifecycle from initial proposal/RFP response through negotiation rounds to final commitment. Encompasses upfront bulk buys negotiated during the annual upfront sales event as well as significant scatter and direct deals requiring formal proposal stages. Captures deal ID, advertiser, agency, account executive, deal year, proposal date, total proposed/committed spend, audience guarantee (GRP/TRP/impression), audience demographic, channel/daypart mix, cancellation option windows, scatter conversion rights, pricing basis (CPM or CPRP), deal status (draft, submitted, negotiating, committed, executed, cancelled), option exercise deadlines, and Salesforce opportunity reference. SSOT for the pre-order deal negotiation lifecycle.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` (
    `impression_delivery_id` BIGINT COMMENT 'Unique identifier for the digital or streaming advertising impression delivery record.',
    `ad_billing_order_id` BIGINT COMMENT 'Foreign key linking to billing.ad_billing_order. Business justification: Impression delivery records are the source of truth for billing reconciliation — actual impressions vs. contracted. Linking to ad_billing_order enables make-good calculations, under-delivery billing a',
    `ad_order_line_id` BIGINT COMMENT 'Reference to the specific ad order line item that this impression fulfills.',
    `ad_pod_id` BIGINT COMMENT 'Foreign key linking to sales.ad_pod. Business justification: An impression delivery record tracks a served ad insertion within a specific ad pod (break). The impression_delivery already has ad_pod_position (the position within the break) but lacks a direct FK t',
    `ad_spot_id` BIGINT COMMENT 'Foreign key linking to sales.ad_spot. Business justification: Impression delivery records track the actual delivery of ad impressions. This FK links delivery metrics back to the specific ad spot that was aired/streamed, enabling performance tracking and billing ',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign under which this impression was delivered.',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level impression attribution is required for audience measurement reporting (Nielsen, Comscore), advertiser billing reconciliation, and campaign delivery verification. Knowing which episode an',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Impression delivery reporting by delivery channel (FAST, OTT, linear) is a core ad ops and billing reconciliation report. Advertisers receive channel-level delivery reports. No existing FK covers this',
    `device_type_id` BIGINT COMMENT 'Foreign key linking to distribution.device_type. Business justification: Impression delivery systems track device type for viewability measurement, creative compatibility verification, and device-targeted campaign reporting. Essential for device-level impression analytics ',
    `playback_session_id` BIGINT COMMENT 'Unique identifier for the streaming session during which the impression was delivered.',
    `schedule_slot_id` BIGINT COMMENT 'SCTE-35 cue point identifier that triggered the Dynamic Ad Insertion event, if applicable.',
    `segment_id` BIGINT COMMENT 'Reference to the audience segment targeted for this impression delivery.',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Impression delivery records track where ads were served. In OTT/streaming, impressions are delivered through specific endpoints. Linking enables join to CDN infrastructure, latency analysis, geographi',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Impression delivery tracking requires subscriber identity for addressable advertising attribution, cross-device frequency capping, reach/frequency reporting, and subscriber-level ad exposure analysis.',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Impression delivery records for syndicated content reference the syndication agreement for revenue share calculation, reporting_frequency compliance, and recoupment tracking. Finance and partner relat',
    `territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Impression delivery records must be linked to rights_territory for royalty calculation (territory breakdown in royalty_statement) and rights compliance reporting. Actual delivery must be validated aga',
    `viewer_profile_id` BIGINT COMMENT 'Foreign key linking to subscriber.viewer_profile. Business justification: OTT Dynamic Ad Insertion (DAI) delivers impressions to specific viewer profiles within a household, not just subscribers. Profile-level ad attribution and frequency capping reporting — a named operati',
    `ad_pod_position` STRING COMMENT 'Sequential position of this ad within the ad pod (group of ads in a break).',
    `browser_type` STRING COMMENT 'Web browser used to view the impression, if applicable.',
    `cdn_delivery_confirmed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the CDN confirmed successful delivery of the impression.',
    `cdn_node_reference` STRING COMMENT 'Identifier of the CDN edge node that delivered the impression.',
    `channel_name` STRING COMMENT 'Name of the streaming channel or digital property where the impression was served.',
    `click_through_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of impressions that resulted in a click-through, calculated as click-throughs divided by total impressions served.',
    `click_throughs` BIGINT COMMENT 'Number of times viewers clicked on the ad to visit the advertisers destination.',
    `completed_views` BIGINT COMMENT 'Number of impressions where the viewer watched the ad to completion.',
    `completion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of impressions that were viewed to completion, calculated as completed views divided by total impressions served.',
    `content_genre` STRING COMMENT 'Genre of the content during which the ad impression was served.',
    `content_rating` STRING COMMENT 'Age-appropriateness rating of the content during which the ad was served. [ENUM-REF-CANDIDATE: G|PG|PG-13|R|TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA — 10 candidates stripped; promote to reference product]',
    `cpm_realized` DECIMAL(18,2) COMMENT 'Actual cost per thousand impressions realized for this delivery event.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this impression delivery record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue amount.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time segment of the broadcast day during which the impression was delivered.. Valid values are `Early Morning|Daytime|Prime Time|Late Night|Overnight`',
    `delivery_date` DATE COMMENT 'Calendar date on which the impression was delivered, used for daily aggregation and reporting.',
    `delivery_timestamp` TIMESTAMP COMMENT 'Exact date and time when the impression was delivered to the viewer.',
    `device_type` STRING COMMENT 'Type of device on which the impression was delivered. [ENUM-REF-CANDIDATE: CTV|Mobile|Tablet|Desktop|Smart TV|Gaming Console|Set-Top Box — 7 candidates stripped; promote to reference product]',
    `impression_tracking_url` STRING COMMENT 'URL used to track and verify the impression delivery event.',
    `insertion_status` STRING COMMENT 'Status indicating whether the ad was successfully inserted, a fallback was used, or no ad was available.. Valid values are `Inserted|Fallback|No-Fill|Error|Skipped`',
    `insertion_type` STRING COMMENT 'Technical method used to insert the ad into the content stream or page. [ENUM-REF-CANDIDATE: DAI|SCTE-35|Server-Side|Client-Side|Display|Pre-Roll|Mid-Roll|Post-Roll — 8 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this impression delivery record was last modified.',
    `operating_system` STRING COMMENT 'Operating system of the device that received the impression.',
    `platform_type` STRING COMMENT 'Type of digital platform where the impression was delivered.. Valid values are `OTT|AVOD|FAST|SVOD|Display|Mobile App`',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Total revenue generated from this impression delivery event.',
    `third_party_verification_source` STRING COMMENT 'Name of the third-party verification service that validated this impression delivery.. Valid values are `IAS|DoubleVerify|Nielsen DAR|Moat|Comscore|None`',
    `total_impressions_served` BIGINT COMMENT 'Total number of impressions delivered in this event.',
    `verification_status` STRING COMMENT 'Status of third-party verification for this impression.. Valid values are `Verified|Unverified|Pending|Failed|Not Applicable`',
    `viewability_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of impressions that met viewability standards, calculated as viewable impressions divided by total impressions served.',
    `viewable_impressions` BIGINT COMMENT 'Number of impressions that met the IAB viewability standard (50% of pixels in view for 2+ seconds for display, 50% for 2+ seconds for video).',
    CONSTRAINT pk_impression_delivery PRIMARY KEY(`impression_delivery_id`)
) COMMENT 'Digital and streaming advertising delivery record tracking served impressions and ad insertions across OTT, AVOD, FAST, and digital display campaigns. Covers both Dynamic Ad Insertion (DAI) events triggered by SCTE-35 cues in streaming and standard digital impression serving. Captures delivery date, channel/platform, campaign, ad order line, ISCI creative, insertion type (DAI/SCTE-35, server-side, client-side, display), targeting parameters applied (audience segment, geo, device type), total impressions served, viewable impressions, completed views, click-throughs, CPM realized, insertion status (inserted, fallback, no-fill), CDN delivery confirmation, impression tracking URL, stream session reference, and third-party verification source (IAS, DoubleVerify, Nielsen DAR). Feeds digital billing reconciliation, campaign pacing, and DAI platform reporting.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` (
    `sales_account_id` BIGINT COMMENT 'Unique identifier for the sales account record. Primary key for the sales account entity representing advertising agencies, direct advertisers, content licensees, syndication buyers, and distribution partners.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Sales accounts (CRM entities) must be linked to billing accounts (AR entities) for unified account management. Media broadcasters use this link to synchronize credit limits, payment terms, and account',
    `parent_account_sales_account_id` BIGINT COMMENT 'Reference to the parent sales account in a hierarchical account structure. Used to model agency networks, holding company subsidiaries, and multi-location advertiser organizations.',
    `account_name` STRING COMMENT 'The legal or trading name of the sales account organization. This is the primary human-readable identifier for the account.',
    `account_status` STRING COMMENT 'Current lifecycle status of the sales account. Active indicates the account is in good standing and can transact; inactive indicates dormant but not closed; suspended indicates temporary hold due to credit or compliance issues; pending indicates account setup in progress; closed indicates permanently terminated relationship.. Valid values are `active|inactive|suspended|pending|closed`',
    `account_tier` STRING COMMENT 'The strategic tier or classification of the account based on revenue potential, relationship depth, and strategic importance. Higher tiers receive preferential pricing, dedicated support, and priority inventory access.. Valid values are `platinum|gold|silver|bronze|standard`',
    `account_type` STRING COMMENT 'Classification of the sales account based on its commercial relationship with Media Broadcasting. Agency represents advertising agencies; direct_advertiser represents brands buying media directly; MVPD (Multichannel Video Programming Distributor) and vMVPD (Virtual Multichannel Video Programming Distributor) represent distribution partners; syndicator represents content resale partners; content_licensee represents organizations licensing content rights.. Valid values are `agency|direct_advertiser|mvpd|vmvpd|syndicator|content_licensee`',
    `agency_commission_rate` DECIMAL(18,2) COMMENT 'The commission percentage paid to advertising agencies for media buys placed on behalf of their clients. Typically expressed as a decimal (e.g., 0.1500 for 15%). Null for non-agency accounts.',
    `annual_revenue_potential` DECIMAL(18,2) COMMENT 'The estimated annual revenue opportunity from this account based on historical spend, market share, and sales forecasts. Used for territory planning and quota allocation.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the master service agreement automatically renews at the end of the contract term. True means the contract renews unless either party provides notice; false means the contract expires and requires renegotiation.',
    `billing_address_line1` STRING COMMENT 'The first line of the billing address where invoices should be sent. Typically contains street number and street name.',
    `billing_address_line2` STRING COMMENT 'The second line of the billing address for suite, floor, or department information.',
    `billing_city` STRING COMMENT 'The city component of the billing address.',
    `billing_contact_email` STRING COMMENT 'The email address of the primary billing contact for invoice delivery and payment correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'The full name of the primary billing contact at the account organization who handles invoices, payment processing, and financial inquiries.',
    `billing_contact_phone` STRING COMMENT 'The phone number of the primary billing contact for urgent payment or invoice inquiries.',
    `billing_country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code for the billing address (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'The postal or ZIP code component of the billing address.',
    `billing_state_province` STRING COMMENT 'The state or province component of the billing address.',
    `blackout_restrictions` STRING COMMENT 'Geographic or temporal restrictions on where or when this accounts advertising or content may be broadcast. Used to enforce exclusivity agreements, competitive conflicts, or regulatory blackout periods.',
    `contract_end_date` DATE COMMENT 'The expiration date of the current master service agreement or framework contract with this account. Null indicates an evergreen or open-ended agreement.',
    `contract_start_date` DATE COMMENT 'The effective start date of the current master service agreement or framework contract with this account.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this sales account record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum outstanding receivables balance allowed for this account before credit hold is applied. Expressed in the accounts preferred currency.',
    `credit_rating` STRING COMMENT 'The credit rating assigned to this account based on payment history, financial stability, and risk assessment. Used to determine payment terms, credit limits, and whether prepayment is required. NR indicates not rated. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D|NR — 11 candidates stripped; promote to reference product]',
    `holding_company_name` STRING COMMENT 'The name of the parent holding company or corporate group to which this account belongs. Used to aggregate spend and manage relationships at the holding company level (e.g., WPP, Omnicom, Publicis Groupe for agencies).',
    `industry_vertical` STRING COMMENT 'The primary industry vertical or business sector of the account (e.g., Automotive, Financial Services, Retail, Pharmaceutical, Technology). Used for competitive separation and industry-specific rate cards.',
    `last_activity_date` DATE COMMENT 'The date of the most recent sales activity, campaign, or transaction associated with this account. Used to identify dormant accounts and trigger re-engagement campaigns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this sales account record was last updated. Used for change tracking and data synchronization.',
    `notes` STRING COMMENT 'Free-form text field for capturing important account-specific information, special handling instructions, relationship history, or strategic context that does not fit structured fields.',
    `payment_terms_days` STRING COMMENT 'The number of days allowed for payment after invoice date, as agreed in the master service agreement. Common values include 30, 60, or 90 days. Zero indicates prepayment required.',
    `preferred_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this account prefers to transact and receive invoices (e.g., USD, GBP, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary business contact for proposals, campaign planning, and general account communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact or account manager at the client organization who handles day-to-day commercial and operational matters.',
    `primary_contact_phone` STRING COMMENT 'The phone number of the primary business contact for urgent campaign or operational matters.',
    `salesforce_account_reference` STRING COMMENT 'The source system identifier from Salesforce Media Cloud CRM. This is the external key used to synchronize account data between the lakehouse and the operational CRM system.',
    `tax_id_number` STRING COMMENT 'The tax identification number (TIN), employer identification number (EIN), or value-added tax (VAT) registration number for this account. Used for tax reporting and compliance.',
    CONSTRAINT pk_sales_account PRIMARY KEY(`sales_account_id`)
) COMMENT 'Master record for advertising agencies, direct advertisers, content licensees, syndication buyers, and distribution partners that engage in commercial transactions with Media Broadcasting. Serves as the SSOT for all sales-facing organizational identities — capturing account type (agency, direct, MVPD, syndicator), holding company hierarchy, credit rating, payment terms, assigned sales rep, market territory, agency commission rate, blackout restrictions, preferred currency, and CRM source ID from Salesforce Media Cloud. This is the commercial counterpart to subscriber identity and is the anchor entity for all sales pipeline activity.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_makegood_for_line_ad_order_line_id` FOREIGN KEY (`makegood_for_line_ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_original_spot_ad_spot_id` FOREIGN KEY (`original_spot_ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_proposal_sales_advertiser_id` FOREIGN KEY (`proposal_sales_advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_parent_account_sales_account_id` FOREIGN KEY (`parent_account_sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_fk_namespace_reconciled' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `affidavit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cpm` SET TAGS ('dbx_business_glossary_term' = 'Contracted Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cprp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_value_regex' = 'standard|guaranteed|no_makegood|custom');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|direct|programmatic|sponsorship|barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_trp` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_contracted_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contracted Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_spot_count` SET TAGS ('dbx_business_glossary_term' = 'Total Spot Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `wide_orbit_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `makegood_for_line_ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Makegood For Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_fk_namespace_reconciled' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Gross Rating Points (GRP) Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_spots_aired` SET TAGS ('dbx_business_glossary_term' = 'Actual Spots Aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `competitive_separation_category` SET TAGS ('dbx_business_glossary_term' = 'Competitive Separation Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_grp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_business_glossary_term' = 'Contracted Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_spots` SET TAGS ('dbx_business_glossary_term' = 'Contracted Spots');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_trp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `copy_split_rule` SET TAGS ('dbx_business_glossary_term' = 'Copy Split Rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cprp` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|preemptible|fixed|bonus|makegood');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `position_preference` SET TAGS ('dbx_business_glossary_term' = 'Position Preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `position_preference` SET TAGS ('dbx_value_regex' = 'first_in_pod|last_in_pod|middle_in_pod|any|fixed_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_business_glossary_term' = 'Preemption Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `rotation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Rotation Instructions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` SET TAGS ('dbx_subdomain' = 'client_relationships');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'brand_awareness|direct_response|political|sponsorship|promotional|product_launch');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'national|regional|local|dma_specific');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Campaign Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|priority|premium|guaranteed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `product_brand` SET TAGS ('dbx_business_glossary_term' = 'Product or Brand Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'upfront|scatter|programmatic|direct|sponsorship');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `salesforce_campaign_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Media Cloud Campaign Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_frequency` SET TAGS ('dbx_business_glossary_term' = 'Target Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_reach_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Reach Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_sov_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Share of Voice (SOV) Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `target_trp` SET TAGS ('dbx_business_glossary_term' = 'Target Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Campaign Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` SET TAGS ('dbx_subdomain' = 'client_relationships');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_value_regex' = 'tier_1_platinum|tier_2_gold|tier_3_silver|tier_4_bronze|tier_5_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|on_hold|under_review|declined');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `industry_category` SET TAGS ('dbx_business_glossary_term' = 'Industry Category (IAB Taxonomy)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_business_glossary_term' = 'Is Political Advertiser Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Legal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|prepay|credit_card|due_on_receipt');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `requires_ad_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Ad Clearance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Trade Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Website URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `wide_orbit_advertiser_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Advertiser Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` SET TAGS ('dbx_subdomain' = 'client_relationships');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|pending|not-accredited|suspended|revoked');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_value_regex' = 'full-service|media-buying|digital|programmatic|creative|in-house');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'gross|net|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_business_glossary_term' = 'Holding Company Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agency Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_status` SET TAGS ('dbx_business_glossary_term' = 'Agency Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending-approval|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `wide_orbit_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Agency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `deliverable_id` SET TAGS ('dbx_business_glossary_term' = 'Creative Deliverable Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `original_spot_ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Original Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `viewer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Viewer Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `affidavit_reference` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'unbilled|billed|invoiced|paid|disputed|written_off');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `bonus_spot_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Spot Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `cpm_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `dai_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `grp_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Impressions Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preempted_flag` SET TAGS ('dbx_business_glossary_term' = 'Preempted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Preemption Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pattern');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `separation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Separation Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Spot Rate Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Spot Rate Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_status` SET TAGS ('dbx_business_glossary_term' = 'Spot Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_status` SET TAGS ('dbx_value_regex' = 'scheduled|aired|preempted|cancelled|makegood_pending|makegood_fulfilled');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `traffic_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Traffic Log Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `trp_value` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Point (TRP) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `alcohol_ad_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Ad Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_business_glossary_term' = 'Break Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_value_regex' = 'pre-roll|mid-roll|post-roll|interstitial|bumper|outro');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `dai_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'DAI (Dynamic Ad Insertion) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `estimated_grp` SET TAGS ('dbx_business_glossary_term' = 'Estimated GRP (Gross Rating Point)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `geographic_market_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `inventory_class` SET TAGS ('dbx_business_glossary_term' = 'Inventory Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `inventory_class` SET TAGS ('dbx_value_regex' = 'premium|standard|remnant|bonus');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `max_spot_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Spot Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_code` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Pod Duration (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_name` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_rate_card_cpm` SET TAGS ('dbx_business_glossary_term' = 'Pod Rate Card CPM (Cost Per Mille)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_rate_card_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_status` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_status` SET TAGS ('dbx_value_regex' = 'scheduled|confirmed|aired|preempted|cancelled|makegoods_required');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_type` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `pod_type` SET TAGS ('dbx_value_regex' = 'commercial|promotional|psa|network|affiliate|local');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `political_ad_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `sales_market` SET TAGS ('dbx_business_glossary_term' = 'Sales Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `sales_market` SET TAGS ('dbx_value_regex' = 'upfront|scatter|programmatic|direct');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `scte35_cue_point_reference` SET TAGS ('dbx_business_glossary_term' = 'SCTE-35 Cue Point ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Proposal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `accepted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accepted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `campaign_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `campaign_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `cancellation_terms` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_business_glossary_term' = 'Competitive Situation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `content_adjacency_preferences` SET TAGS ('dbx_business_glossary_term' = 'Content Adjacency Preferences');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `cprp` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `demographic_target` SET TAGS ('dbx_business_glossary_term' = 'Demographic Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_description` SET TAGS ('dbx_business_glossary_term' = 'Proposal Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|programmatic|direct');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_name` SET TAGS ('dbx_business_glossary_term' = 'Proposal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `net_proposed_value` SET TAGS ('dbx_business_glossary_term' = 'Net Proposed Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Proposal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `platform_mix` SET TAGS ('dbx_business_glossary_term' = 'Platform Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|negotiating|accepted|rejected|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'advertising|content_licensing|syndication|distribution|sponsorship|upfront');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_frequency` SET TAGS ('dbx_business_glossary_term' = 'Proposed Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_grp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Proposed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_reach` SET TAGS ('dbx_business_glossary_term' = 'Proposed Reach Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_trp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejected Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Proposal Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'rfp|proactive_pitch|renewal|upsell|cross_sell');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `spot_length_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Spot Length Mix Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Submitted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_cpm` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `total_proposed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Proposed Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `win_probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` SET TAGS ('dbx_subdomain' = 'deal_negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_grp` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_impressions` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cancellation_option_window_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Option Window Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP) Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR|AUD');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{5,8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|direct|programmatic|sponsorship|barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_year` SET TAGS ('dbx_business_glossary_term' = 'Deal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `makegood_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Provision Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `negotiation_round_count` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Round Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Deadline');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_value_regex' = 'cpm|cprp|flat_rate|performance');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `salesforce_opportunity_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `salesforce_opportunity_reference` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `scatter_conversion_rights` SET TAGS ('dbx_business_glossary_term' = 'Scatter Conversion Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Spend');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `total_proposed_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Proposed Spend');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` SET TAGS ('dbx_subdomain' = 'deal_negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `impression_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Impression Delivery ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `ad_billing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Billing Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Stream Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Society of Cable Telecommunications Engineers (SCTE) Cue ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `viewer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Viewer Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `browser_type` SET TAGS ('dbx_business_glossary_term' = 'Browser Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `cdn_delivery_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Delivery Confirmed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `cdn_node_reference` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Node ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `click_through_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Click-Through Rate (CTR) Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `click_throughs` SET TAGS ('dbx_business_glossary_term' = 'Click-Throughs');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `completed_views` SET TAGS ('dbx_business_glossary_term' = 'Completed Views');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `completion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Completion Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `content_genre` SET TAGS ('dbx_business_glossary_term' = 'Content Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `cpm_realized` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Realized');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `daypart` SET TAGS ('dbx_value_regex' = 'Early Morning|Daytime|Prime Time|Late Night|Overnight');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `impression_tracking_url` SET TAGS ('dbx_business_glossary_term' = 'Impression Tracking Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `insertion_status` SET TAGS ('dbx_business_glossary_term' = 'Insertion Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `insertion_status` SET TAGS ('dbx_value_regex' = 'Inserted|Fallback|No-Fill|Error|Skipped');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `insertion_type` SET TAGS ('dbx_business_glossary_term' = 'Insertion Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'OTT|AVOD|FAST|SVOD|Display|Mobile App');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `third_party_verification_source` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Verification Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `third_party_verification_source` SET TAGS ('dbx_value_regex' = 'IAS|DoubleVerify|Nielsen DAR|Moat|Comscore|None');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `total_impressions_served` SET TAGS ('dbx_business_glossary_term' = 'Total Impressions Served');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Verified|Unverified|Pending|Failed|Not Applicable');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `viewability_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Viewability Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `viewable_impressions` SET TAGS ('dbx_business_glossary_term' = 'Viewable Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` SET TAGS ('dbx_subdomain' = 'client_relationships');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `parent_account_sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sales Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'agency|direct_advertiser|mvpd|vmvpd|syndicator|content_licensee');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `annual_revenue_potential` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Potential');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `annual_revenue_potential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `holding_company_name` SET TAGS ('dbx_business_glossary_term' = 'Holding Company Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `salesforce_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_financial' = 'true');
