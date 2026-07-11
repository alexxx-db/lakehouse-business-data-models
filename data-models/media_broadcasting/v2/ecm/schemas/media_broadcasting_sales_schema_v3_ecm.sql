-- Schema for Domain: sales | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 19:30:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`sales` COMMENT 'Manages the commercial sales pipeline for advertising, content licensing, syndication, and distribution deals. Owns accounts, opportunities, proposals, rate cards, upfront commitments, agency relationships, scatter market inventory, commission structures, and executed sales contracts. Powered by Salesforce Media Cloud, this domain tracks deal stages and feeds confirmed orders to advertising trafficking and billing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` (
    `ad_order_id` BIGINT COMMENT 'Unique identifier for the advertising sales order. Primary key. System-generated surrogate key for the ad order record.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (brand or company) placing the advertising order. Links to advertiser master record in Salesforce Media Cloud.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Normalize campaign reference from STRING name to proper FK. Ad order should be linked to campaign master record for rollup reporting and campaign management. Currently denormalized as campaign_name ST',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Ad orders are sold by sales teams organized into cost centers. Commission calculation, sales performance analysis, and cost center P&L attribution require linking orders to the responsible cost center',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Ad orders target specific Nielsen demographic segments (A18-49, W25-54, etc.) for campaign planning, rate card pricing, and GRP/TRP guarantees. Core to media buying operations and upfront/scatter deal',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Ad orders must verify content rights before booking. Sales teams check license windows daily to ensure spots can legally air during contracted periods. Critical for revenue recognition and compliance.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Ad orders often involve content partners (studios, syndicators) whose programming forms the inventory being sold. Real business process: integrated sales where content acquisition and ad sales are coo',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative responsible for this advertising order. Links to employee/user master record.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Ad orders contribute to profit center performance. Segment EBITDA reporting and business unit P&L require linking orders to profit centers for accurate segment performance measurement and management r',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Ad orders generate revenue that must be classified for ASC 606 revenue recognition and EBITDA reporting. Monthly close process requires linking orders to revenue stream classification for proper finan',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser. Nullable if direct advertiser purchase. Links to agency master record.',
    `opportunity_id` BIGINT COMMENT 'External reference to the originating sales opportunity in Salesforce Media Cloud CRM. 15 or 18 character Salesforce record ID.',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Direct-sold addressable TV ad orders target specific subscribers for personalized advertising. Critical for programmatic guaranteed deals and advanced advertising attribution in streaming platforms. E',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Talent endorsement deals and spokesperson campaigns require linking ad orders to specific talent for usage rights tracking, exclusivity clause enforcement, and residual payment obligations when spots ',
    `affidavit_required_flag` BOOLEAN COMMENT 'Indicates whether proof of broadcast affidavits must be provided to the advertiser. True = affidavits required; False = not required. Affidavits document actual air times and are often required for political advertising.',
    `billing_cycle` STRING COMMENT 'Frequency and timing of invoice generation for this order. Weekly = invoiced every week; Monthly = invoiced monthly; End of Flight = single invoice after campaign completion; Milestone = invoiced at defined campaign milestones.. Valid values are `weekly|monthly|end_of_flight|milestone`',
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
    `market_code` STRING COMMENT 'Designated Market Area (DMA) or geographic market code where the advertising will air. Used for Nielsen ratings alignment and regional pricing.',
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
    `channel_id` BIGINT COMMENT 'Reference to the broadcast network or channel where this ad line will air. Determines distribution outlet.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Each line item specifies demographic target for GRP/TRP delivery guarantees, CPM/CPRP pricing, and makegood determination. Essential for trafficking, billing reconciliation, and audience guarantee com',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Normalize creative reference from STRING business key to proper FK. Order line specifies which creative asset to use for the buy. Currently denormalized as isci_code STRING; should FK to isci_creative',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Line-level rights verification for specific content/daypart combinations. Trafficking requires granular clearance to prevent airing spots during holdback periods or outside licensed windows. Operation',
    `makegood_for_line_id` BIGINT COMMENT 'Reference to the original ad order line that this line is compensating for (if this is a makegood spot). Null if not a makegood.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Order lines target specific dayparts for inventory allocation and pricing. Fulfillment tracking, avail matching, and rate card application require linking lines to master daypart definitions. Removes ',
    `title_id` BIGINT COMMENT 'Reference to the specific program or show during which the ad spot will air. Used for program-specific targeting.',
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
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Campaigns targeting children under 13 require COPPA declarations for data collection and privacy compliance. Broadcasters must link campaigns to declarations documenting parental consent mechanisms, d',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaigns are managed by sales teams within cost centers. Campaign ROI analysis and sales team performance measurement require linking campaigns to the responsible cost center for accurate profitabili',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Campaigns define primary demographic targets that drive all downstream planning, buying, measurement, and guarantee reconciliation. Core to upfront deals, scatter buying, and Nielsen ratings analysis.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Campaign planning depends on content availability windows. Media buyers negotiate campaign flights around rights constraints, especially for premium content. Enables available inventory by rights win',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Campaigns frequently involve co-marketing partnerships with content providers, integrated sponsorships, or campaigns tied to partner-supplied content blocks. Real business process: partnership marketi',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved the campaign for activation.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Campaigns represent revenue-generating activities requiring financial classification. ASC 606 performance obligations often align with campaigns. Revenue recognition and contract accounting processes ',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser for this campaign. Nullable if direct advertiser relationship.',
    `channel_id` BIGINT COMMENT 'add column scheduling_channel_id (BIGINT) with FK to scheduling.channel.channel_id - campaigns target specific channels and need direct channel linkage for trafficking',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: 1:1 marketing campaigns targeting individual subscribers for retention, upsell, winback, or personalized offers. Common in subscription businesses where campaigns are designed for specific subscriber ',
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
    `employee_id` BIGINT COMMENT 'The user identifier of the person who created this advertiser record.',
    `sales_account_id` BIGINT COMMENT 'The Salesforce Media Cloud account reference linking this advertiser to CRM opportunities, campaigns, and proposals.',
    `sales_agency_id` BIGINT COMMENT 'The identifier of the advertising agency that places media buys on behalf of this advertiser, if applicable. Null if the advertiser buys direct.',
    `tertiary_advertiser_updated_by_user_employee_id` BIGINT COMMENT 'The user identifier of the person who last modified this advertiser record.',
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
    `sales_account_id` BIGINT COMMENT 'Reference identifier linking this agency to its corresponding account record in Salesforce Media Cloud CRM for tracking opportunities, campaigns, and proposals.',
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
    `abr_profile_id` BIGINT COMMENT 'Foreign key linking to distribution.abr_profile. Business justification: ABR profile determines video quality for ad creative delivery. Broadcasters track which profile was used per spot to verify creative rendering quality, troubleshoot playback issues, and optimize ad en',
    `ad_order_line_id` BIGINT COMMENT 'Reference to the parent ad order line that booked this spot. Links the spot to the commercial agreement and campaign.',
    `ad_pod_id` BIGINT COMMENT 'Identifier for the ad pod (commercial break) containing this spot. Groups all spots that aired in the same break.',
    `advertiser_id` BIGINT COMMENT 'Identifier for the advertiser (brand or company) whose creative aired in this spot. Links to advertiser master data.',
    `campaign_id` BIGINT COMMENT 'Identifier for the advertising campaign this spot belongs to. Groups related spots for performance analysis and reporting.',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: Individual ad spot airings require closed caption compliance tracking for FCC accessibility regulations. Broadcasters must document caption accuracy, completeness, and synchronization for each aired s',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Individual spots are trafficked and measured against specific demographic targets for GRP/TRP delivery, makegood determination, and affidavit reconciliation. Essential for Nielsen ratings matching and',
    `device_type_id` BIGINT COMMENT 'Foreign key linking to distribution.device_type. Business justification: Ad delivery systems track device type per spot to verify creative compatibility (resolution, codec, DRM), measure device-specific performance, and support device-targeted campaigns. Critical for devic',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Normalize creative reference from STRING business key (isci_code) to proper FK. Ad spot must reference the creative asset that aired. Currently denormalized as isci_code STRING; should FK to isci_crea',
    `original_spot_ad_spot_id` BIGINT COMMENT 'Reference to the original ad spot that this makegood spot is compensating for. Populated only when makegood_flag is true.',
    `sales_agency_id` BIGINT COMMENT 'Identifier for the advertising agency that placed this spot on behalf of the advertiser. May be null for direct advertiser buys.',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Spots air within specific schedule slots. Affidavit generation, as-run reconciliation, and delivery verification require linking each spot to the exact slot it occupied. No existing column fits; creat',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Ad spots in OTT/FAST environments are delivered through specific streaming endpoints. Broadcasters track endpoint-per-spot for delivery verification, QoS monitoring, CDN cost allocation, and billing r',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Addressable ad spot delivery tracking links each aired spot to the subscriber who viewed it. Essential for frequency capping, attribution, personalized ad delivery, and subscriber-level impression rec',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Actual aired spots featuring talent trigger residual payment obligations, require talent clearance tracking for compliance, and enable usage rights validation for each exhibition event across linear a',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Ad spots air during specific titles. Business process: traffic logs, affidavits, program-level ad performance analysis, Nielsen C3/C7 ratings reconciliation, content adjacency compliance.',
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
    `delivery_platform` STRING COMMENT 'Platform through which the ad spot was delivered. Distinguishes between linear broadcast, OTT (Over-The-Top), VOD (Video On Demand), SVOD (Subscription VOD), AVOD (Ad-Supported VOD), TVOD (Transactional VOD), FAST (Free Ad-Supported Streaming TV), and simulcast delivery. [ENUM-REF-CANDIDATE: linear|ott|vod|svod|avod|tvod|fast|simulcast — 8 candidates stripped; promote to reference product]',
    `grp_value` DECIMAL(18,2) COMMENT 'Gross Rating Point value delivered by this spot. Measures the size of the audience reached relative to the total market population. Sum of all rating points across the campaign.',
    `impressions_delivered` BIGINT COMMENT 'Total number of impressions (views) delivered by this spot. Used for performance measurement and billing reconciliation.',
    `makegood_flag` BOOLEAN COMMENT 'Indicates whether this spot is a makegood (compensatory ad spot provided to an advertiser due to a previous preemption or underdelivery).',
    `market_code` STRING COMMENT 'Designated Market Area (DMA) or geographic market code where the spot aired. Used for regional campaign tracking and market-specific pricing.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` (
    `isci_creative_id` BIGINT COMMENT 'Unique identifier for the advertising creative asset record. Primary key for the ISCI creative entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (client company) that owns this creative asset. Links to the advertiser master record in the advertising domain.',
    `brand_id` BIGINT COMMENT 'Reference to the specific brand or product line being promoted in this creative. Links to the brand master record.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Creative content requires age-appropriate ratings for daypart placement and regulatory compliance. Broadcasters must verify ratings match target demographics and time slots, ensuring childrens progra',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Creative clearance restricted by content genre (alcohol ads in sports vs. childrens programming). Business process: standards & practices clearance workflows, content adjacency rules, advertiser cate',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: ISCI creatives must reference the master media asset containing the actual ad content file for trafficking, playout, and compliance verification. Core operational link between ad clearance and media a',
    `previous_version_isci_creative_id` BIGINT COMMENT 'Reference to the immediately preceding version of this creative, if this is a revision. Null for the original version. Enables version lineage tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this creative record in the system. Used for audit trail and accountability.',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Creative assets featuring talent require direct linkage for clearance status verification, usage rights validation, residual payment trigger calculation when spots air, and exclusivity conflict detect',
    `content_clearance_id` BIGINT COMMENT 'Foreign key linking to compliance.ad_standards_clearance. Business justification: Creative assets must pass ad standards clearance before airing. Broadcasters track clearance approval status, rejection reasons, and certificate numbers for each ISCI code to ensure only approved cont',
    `approval_status` STRING COMMENT 'Current state of the creative in the internal approval workflow. Tracks progression from draft through review to final approval or rejection. Only approved creatives can be trafficked for broadcast. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|revision_required|expired — 7 candidates stripped; promote to reference product]',
    `aspect_ratio` STRING COMMENT 'The proportional relationship between width and height of the video creative. Standard ratios include 16:9 (HD/widescreen), 4:3 (SD), 1:1 (square/social), 9:16 (vertical/mobile), and 21:9 (cinematic).. Valid values are `16:9|4:3|1:1|9:16|21:9`',
    `audio_standard` STRING COMMENT 'The audio encoding and channel configuration standard used in the creative. Includes stereo, surround sound formats (Dolby Digital, Dolby Atmos, DTS), and codec specifications (AAC).. Valid values are `stereo|dolby_digital|dolby_atmos|dts|aac|mono`',
    `checksum_md5` STRING COMMENT 'MD5 hash of the creative asset file used for integrity verification during transfer and playout. Ensures the file has not been corrupted or tampered with.. Valid values are `^[a-f0-9]{32}$`',
    `closed_caption_available` BOOLEAN COMMENT 'Indicates whether closed captioning (subtitles for the deaf and hard of hearing) is embedded or available for this creative. Required for FCC compliance on broadcast television.',
    `codec` STRING COMMENT 'The video compression codec used to encode the creative. Common codecs include H.264 (AVC), H.265 (HEVC), ProRes, DNxHD, MPEG-2, VP9, and AV1. Impacts file size, quality, and playback compatibility. [ENUM-REF-CANDIDATE: h264|h265|prores|dnxhd|mpeg2|vp9|av1 — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this creative record was first created in the system. Immutable audit field.',
    `creative_description` STRING COMMENT 'Detailed narrative description of the creative content, messaging, and visual elements. Used for trafficking, clearance review, and internal reference.',
    `creative_format` STRING COMMENT 'The media format and delivery channel for which this creative is designed. Determines playout system routing and technical specifications. [ENUM-REF-CANDIDATE: linear_tv|digital_pre_roll|digital_mid_roll|digital_post_roll|audio_radio|audio_podcast|ott_streaming|social_media|display_banner — 9 candidates stripped; promote to reference product]',
    `creative_title` STRING COMMENT 'The human-readable name or title of the advertising creative, typically describing the campaign theme or message (e.g., Summer Sale 2024, New Product Launch).',
    `dalet_asset_reference` STRING COMMENT 'Reference identifier linking this ISCI creative record to the corresponding digital asset file stored in the Dalet Galaxy Media Asset Management system. Used for asset retrieval and playout automation.',
    `effective_end_date` DATE COMMENT 'The date after which this creative is no longer authorized to air or be distributed. Enforces campaign end dates, product discontinuations, and time-sensitive offers. Null for open-ended creatives.',
    `effective_start_date` DATE COMMENT 'The date from which this creative is authorized to air or be distributed. Enforces campaign timing and seasonal restrictions.',
    `expiry_date` DATE COMMENT 'The date on which the creative record and associated clearances expire and must be renewed or retired. Distinct from effective_end_date; this represents the end of the creatives lifecycle validity.',
    `file_format` STRING COMMENT 'The digital container format of the creative asset file. Common video formats include MP4, MOV, MXF, AVI; audio formats include MP3, WAV, AAC. Determines compatibility with playout and MAM systems. [ENUM-REF-CANDIDATE: mp4|mov|mxf|avi|wmv|mpg|mp3|wav|aac — 9 candidates stripped; promote to reference product]',
    `file_size_mb` DECIMAL(18,2) COMMENT 'The size of the creative asset file in megabytes. Used for storage planning, bandwidth estimation, and delivery optimization.',
    `frame_rate` DECIMAL(18,2) COMMENT 'The number of frames per second (fps) in the video creative. Standard rates include 23.976/24 (film), 25 (PAL), 29.97/30 (NTSC), and 50/60 (high frame rate). Must match broadcast or streaming platform requirements.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this creative record is currently active and available for trafficking and playout. Inactive creatives are retained for historical reference but cannot be scheduled.',
    `isci_code` STRING COMMENT 'The standardized 12-character alphanumeric code uniquely identifying a commercial creative in the advertising industry. Format: 4-character advertiser code + 4-character brand code + 1-character media type (H=TV, M=Radio, V=Digital) + 3-digit sequence. This is the externally-known business identifier used across trafficking, playout, and affidavit systems.. Valid values are `^[A-Z0-9]{4}[A-Z0-9]{4}[HMV]d{3}$`',
    `language_code` STRING COMMENT 'The primary language of the creative audio and text content, expressed as ISO 639-1 two-letter code (e.g., en for English, es for Spanish) with optional ISO 3166-1 country code (e.g., en-US, es-MX).. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this creative record was most recently modified. Updated on every change for audit trail.',
    `political_ad_indicator` BOOLEAN COMMENT 'Indicates whether this creative is a political advertisement subject to FCC political advertising disclosure and equal time requirements. Triggers mandatory public inspection file documentation.',
    `product_category` STRING COMMENT 'The industry classification of the product or service being advertised (e.g., automotive, pharmaceuticals, financial services, food and beverage). Used for competitive separation and regulatory compliance.',
    `restricted_content_flags` STRING COMMENT 'Comma-separated list of content restriction flags indicating special handling requirements (e.g., alcohol, gambling, political, pharmaceutical, tobacco). Triggers daypart restrictions and disclosure requirements.',
    `spot_length_seconds` STRING COMMENT 'Duration of the commercial spot in seconds. Standard broadcast lengths include 15, 30, 60, 90, and 120 seconds. Critical for ad pod scheduling and inventory management.',
    `version_number` STRING COMMENT 'Sequential version number for this creative. Increments when revisions are made to the creative content or metadata. Supports version history and rollback.',
    `video_resolution` STRING COMMENT 'The pixel resolution of the video creative. Standard resolutions include SD (480p), HD (720p/1080p), and UHD (4K/8K). Determines quality tier and bandwidth requirements.. Valid values are `sd_480|hd_720|hd_1080|uhd_4k|uhd_8k`',
    CONSTRAINT pk_isci_creative PRIMARY KEY(`isci_creative_id`)
) COMMENT 'Master record for an advertising creative asset identified by its ISCI (Industry Standard Commercial Identification) code. Captures ISCI code, advertiser, brand, creative title, spot length, creative format (linear TV, digital pre-roll, audio, OTT), aspect ratio, audio standard, approval status, clearance status, expiry date, and Dalet Galaxy asset reference. SSOT for creative identity and clearance within the advertising workflow. Distinct from the digital asset file managed in the digitalasset domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` (
    `ad_pod_id` BIGINT COMMENT 'Unique identifier for the advertising pod. Primary key.',
    `title_id` BIGINT COMMENT 'Reference to the program or content episode during which this ad pod airs.',
    `ad_title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Ad pods are embedded within title airings. Business process: dynamic ad insertion planning, SCTE-35 cue point management, break placement optimization, pod-level inventory forecasting by title.',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast or streaming channel where this ad pod is scheduled.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Pod placement within licensed content requires rights verification. Ad ops checks license status before scheduling pods into programs. Prevents selling inventory in content with expired or restricted ',
    `program_schedule_id` BIGINT COMMENT 'Reference to the program schedule entry that contains this ad pod.',
    `program_title_id` BIGINT COMMENT '',
    `actual_end_time` TIMESTAMP COMMENT 'Actual date and time when the ad pod concluded airing, used for billing reconciliation and performance verification.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual date and time when the ad pod began airing, captured from playout automation for affidavit generation and makegood processing.',
    `alcohol_ad_allowed_flag` BOOLEAN COMMENT 'Indicates whether alcohol advertising is permitted within this ad pod, based on daypart restrictions and content adjacency policies.',
    `audience_target_demo` STRING COMMENT 'Primary demographic audience segment targeted by this ad pod, typically expressed in age-gender format (e.g., A18-49, W25-54, M18-34) per Nielsen measurement standards.',
    `blackout_flag` BOOLEAN COMMENT 'Indicates whether this ad pod is subject to geographic broadcast restrictions or blackout rules, preventing distribution in certain markets.',
    `break_position` STRING COMMENT 'Position of the ad break within the program content flow. Pre-roll occurs before content starts, mid-roll during content, post-roll after content ends, interstitial between segments, bumper as short transition, and outro at program conclusion.. Valid values are `pre-roll|mid-roll|post-roll|interstitial|bumper|outro`',
    `content_rating` STRING COMMENT 'TV Parental Guidelines rating of the program content surrounding this ad pod, used to ensure advertiser suitability and compliance with content adjacency requirements.. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` (
    `affidavit_id` BIGINT COMMENT 'Primary key for affidavit',
    `ad_sales_order_id` BIGINT COMMENT 'Reference to the sales order that authorized this ad spot placement.',
    `ad_spot_id` BIGINT COMMENT 'Reference to the contracted advertising spot that this affidavit confirms aired.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (client) who purchased the ad spot and to whom this affidavit is issued.',
    `makegood_id` BIGINT COMMENT 'Reference to the makegood order created to compensate for this discrepancy, if applicable.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign under which this spot was scheduled and aired.',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast channel or network on which the ad spot aired.',
    `employee_id` BIGINT COMMENT 'Reference to the user who verified and approved this affidavit for billing purposes.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice on which this affidavit was included for billing purposes.',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Normalize creative reference in proof-of-broadcast record. Affidavit confirms which creative actually aired. Currently denormalized as isci_code STRING; should FK to isci_creative master for referenti',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Affidavits prove compliance with content licensing terms. Rights holders require proof that ads aired only during licensed windows. Supports exploitation reporting and royalty statement reconciliation',
    `public_inspection_file_id` BIGINT COMMENT 'Foreign key linking to compliance.public_inspection_file. Business justification: Political advertising affidavits must be maintained in the public inspection file per FCC rules. Broadcasters link affidavits to public file entries documenting actual air dates, times, and rates char',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: Affidavits provide proof of performance for ASC 606 revenue recognition. Revenue assurance and external audit processes require linking affidavits to recognition events for compliance and audit trail ',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser, if applicable.',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Affidavits verify spot delivery within specific schedule slots. Already links to channel, but slot-level granularity is required for accurate as-run verification and makegood determination. Creating n',
    `title_id` BIGINT COMMENT 'Reference to the program during which the ad spot aired.',
    `actual_air_date` DATE COMMENT 'The date the ad spot actually aired as confirmed by playout system logs.',
    `actual_air_time` TIMESTAMP COMMENT 'The precise date and time the ad spot actually aired as confirmed by playout system logs. This is the principal business event timestamp for the affidavit.',
    `actual_spot_length_seconds` STRING COMMENT 'The actual duration in seconds that the ad spot aired as measured by playout system.',
    `ad_pod_position` STRING COMMENT 'Position of this ad spot within the ad pod (group of ads in a commercial break). First position is 1.',
    `affidavit_number` STRING COMMENT 'Business identifier for the affidavit document. Externally-known unique reference number used for billing finalization and compliance documentation.',
    `billing_amount` DECIMAL(18,2) COMMENT 'The amount billed for this ad spot as documented in this affidavit. Used for revenue recognition and reconciliation.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this affidavit meets all regulatory and contractual compliance requirements for FCC documentation and audit purposes.',
    `contracted_spot_length_seconds` STRING COMMENT 'The duration in seconds that was contracted and paid for in the sales order.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the billing amount.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time segment of the broadcast day during which the ad aired. Used for pricing and audience targeting analysis. [ENUM-REF-CANDIDATE: early_morning|morning|daytime|early_fringe|prime_access|prime_time|late_fringe|overnight — 8 candidates stripped; promote to reference product]',
    `delivery_method` STRING COMMENT 'Method by which the affidavit document was delivered to the advertiser or agency.. Valid values are `electronic|email|portal|mail|fax`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the affidavit was delivered to the advertiser or agency.',
    `discrepancy_description` STRING COMMENT 'Detailed explanation of the discrepancy, including root cause and impact. Used for makegood processing and client communication.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether there was any discrepancy between the contracted spot parameters and what actually aired. True if discrepancy exists, False if spot aired as contracted.',
    `discrepancy_type` STRING COMMENT 'Classification of the type of discrepancy if one occurred. None indicates spot aired exactly as contracted. [ENUM-REF-CANDIDATE: wrong_time|wrong_length|preempted|wrong_creative|wrong_channel|missed|none — 7 candidates stripped; promote to reference product]',
    `generation_timestamp` TIMESTAMP COMMENT 'Date and time when this affidavit record was first generated by the traffic system. This is the record audit created timestamp.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this affidavit record was last updated. Used for audit trail and change tracking.',
    `makegood_required_flag` BOOLEAN COMMENT 'Indicates whether a compensatory ad spot (makegood) must be scheduled due to the discrepancy. True triggers makegood workflow.',
    `notes` STRING COMMENT 'Additional notes or comments regarding this affidavit, including special circumstances, client communications, or internal annotations.',
    `playout_system_log_reference` STRING COMMENT 'Reference to the playout automation system log entry that provides technical proof of broadcast.',
    `preemption_reason` STRING COMMENT 'Explanation for why the ad spot was preempted if applicable. Common reasons include breaking news, emergency alerts, or programming overruns.',
    `reconciliation_status` STRING COMMENT 'Current status of the affidavit in the billing reconciliation workflow. Approved status enables invoice finalization.. Valid values are `pending|verified|approved|disputed|resolved|billed`',
    `scheduled_air_date` DATE COMMENT 'The date the ad spot was originally contracted and scheduled to air.',
    `scheduled_air_time` TIMESTAMP COMMENT 'The precise date and time the ad spot was originally contracted and scheduled to air.',
    `verification_method` STRING COMMENT 'Method used to verify that the ad spot aired as documented in this affidavit.. Valid values are `automated_playout_log|manual_review|third_party_monitoring|client_verification`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the affidavit was verified and approved for billing.',
    `wide_orbit_affidavit_reference` STRING COMMENT 'External reference identifier from the Wide Orbit traffic and billing system for cross-system reconciliation.',
    CONSTRAINT pk_affidavit PRIMARY KEY(`affidavit_id`)
) COMMENT 'Proof-of-broadcast affidavit record confirming that a contracted ad spot actually aired as scheduled. Captures affidavit number, ad spot reference, actual air date and time, channel, program, ISCI code, spot length, discrepancy flag (aired vs. contracted), discrepancy type (wrong time, wrong length, preempted, wrong creative), Wide Orbit affidavit reference, and reconciliation status. Required for billing finalization, makegood triggering, and FCC compliance documentation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` (
    `makegood_id` BIGINT COMMENT 'Primary key for makegood',
    `ad_order_id` BIGINT COMMENT 'Reference to the parent advertising order under which the original spot was booked.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser who purchased the original ad spot and is entitled to the makegood.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Makegood resolution requires approval by operations manager or account executive to authorize replacement inventory and confirm advertiser acceptance. Replaces text approved_by field with proper FK ',
    `cost_allocation_id` BIGINT COMMENT 'Foreign key linking to finance.cost_allocation. Business justification: Makegoods represent cost of service delivery failures. Cost of quality reporting and operational cost allocation require linking makegoods to cost allocation records for accurate cost center accountab',
    `ad_spot_id` BIGINT COMMENT 'Reference to the original ad spot that failed to air as scheduled and triggered this makegood.',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Normalize creative reference for the original spot being made good. Makegood record needs to reference which creative was supposed to air originally. Currently denormalized as original_isci_code STRIN',
    `channel_id` BIGINT COMMENT 'Reference to the channel on which the original ad spot was scheduled to air.',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser in the makegood negotiation, if applicable.',
    `actual_air_date` DATE COMMENT 'The date on which the makegood replacement spot actually aired, confirming fulfillment.',
    `actual_air_time` TIMESTAMP COMMENT 'The precise timestamp at which the makegood replacement spot actually aired.',
    `affidavit_date` DATE COMMENT 'The date on which the affidavit for the makegood spot was generated and issued.',
    `affidavit_generated_flag` BOOLEAN COMMENT 'Indicates whether a proof-of-broadcast affidavit has been generated for the aired makegood spot.',
    `approval_date` DATE COMMENT 'The date on which the advertiser or agency approved the makegood proposal.',
    `approval_status` STRING COMMENT 'Current status of the makegood proposal in the advertiser/agency approval workflow.. Valid values are `pending|approved|rejected|negotiating|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this makegood record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this makegood record was last updated.',
    `makegood_number` STRING COMMENT 'Business identifier for the makegood record, used in external communications and affidavits.. Valid values are `^MG-[0-9]{8}-[A-Z0-9]{6}$`',
    `notes` STRING COMMENT 'Free-form text field for additional comments, negotiation history, or special instructions related to the makegood.',
    `original_actual_grp` DECIMAL(18,2) COMMENT 'The actual GRP delivered by the original spot if it aired but underperformed, triggering a ratings shortfall makegood.',
    `original_contracted_grp` DECIMAL(18,2) COMMENT 'The GRP value that was contracted for the original ad spot, used to assess audience underdelivery.',
    `original_daypart` STRING COMMENT 'The broadcast daypart (time segment) in which the original spot was scheduled, such as Prime, Early Fringe, Late Night.',
    `original_program_name` STRING COMMENT 'The name of the program during which the original ad spot was scheduled to air.',
    `original_scheduled_date` DATE COMMENT 'The date on which the original ad spot was scheduled to air before the failure occurred.',
    `original_scheduled_time` TIMESTAMP COMMENT 'The precise timestamp at which the original ad spot was scheduled to air.',
    `original_spot_length_seconds` STRING COMMENT 'The duration in seconds of the original ad spot that failed to air.',
    `original_spot_rate` DECIMAL(18,2) COMMENT 'The contracted rate (in USD) for the original ad spot that failed to air.',
    `proposed_daypart` STRING COMMENT 'The broadcast daypart proposed for the makegood replacement spot.',
    `proposed_estimated_grp` DECIMAL(18,2) COMMENT 'The estimated GRP that the proposed makegood replacement spot is expected to deliver.',
    `proposed_program_name` STRING COMMENT 'The name of the program during which the makegood replacement spot is proposed to air.',
    `proposed_replacement_date` DATE COMMENT 'The date proposed by the broadcaster for airing the makegood replacement spot.',
    `proposed_replacement_time` TIMESTAMP COMMENT 'The precise timestamp proposed for airing the makegood replacement spot.',
    `proposed_spot_length_seconds` STRING COMMENT 'The duration in seconds of the proposed makegood replacement spot.',
    `reason_code` STRING COMMENT 'Categorical code indicating why the original spot failed to air and a makegood was issued.. Valid values are `preemption|technical_failure|ratings_shortfall|program_cancellation|schedule_change|weather_emergency`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances that led to the makegood issuance.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the advertiser or agency if the makegood proposal was rejected.',
    `resolution_status` STRING COMMENT 'Current lifecycle status of the makegood record, tracking whether it has been fulfilled or remains outstanding.. Valid values are `open|scheduled|aired|cancelled|expired`',
    CONSTRAINT pk_makegood PRIMARY KEY(`makegood_id`)
) COMMENT 'Compensatory ad spot record issued when a contracted spot fails to air as scheduled (due to preemption, technical failure, or audience underdelivery). Captures makegood ID, original ad spot reference, reason code (preemption, technical, ratings shortfall), proposed replacement spot details (channel, date, time, daypart, program), advertiser/agency approval status, approval date, and resolution status. Tracks the full makegood negotiation and fulfillment lifecycle.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` (
    `sales_proposal_id` BIGINT COMMENT 'Unique identifier for the sales proposal. Primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization to whom this proposal is being submitted. The ultimate client purchasing the advertising inventory.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Proposals are submitted to billing accounts for contract execution. Proposal approval workflows, contract management, and proposal-to-invoice conversion tracking require direct linkage to the billing ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Proposals specify primary channel for inventory offering. Sales teams build proposals around channel audience profiles and ratings. Business process: proposal generation, inventory packaging, channel-',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Proposals are prepared against cost center budgets for resource allocation and approval workflows. Enables budget availability checks and cost center-based approval routing in media sales operations.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Proposals specify demographic targets for reach/frequency planning, GRP/TRP projections, and CPM/CPRP pricing. Essential for sales process, rate card application, and client presentation. Replaces den',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or account executive responsible for this proposal.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Proposals must reference available content rights. Sales cannot propose inventory in content without valid licenses. Enables proposable inventory by rights window validation before client presentati',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Content licensing proposals reference specific media assets being offered for license. Sales teams need to link proposals to the actual program/film assets to generate accurate licensing terms, verify',
    `rep_id` BIGINT COMMENT 'Reference to the sales account executive responsible for this proposal and the advertiser relationship.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Proposals must be tagged to profit centers for segment-level pipeline visibility and revenue planning. Supports quarterly business review by segment and profit center revenue forecasting processes.',
    `rate_card_id` BIGINT COMMENT 'Reference to the primary rate card used as the pricing basis for this proposal.',
    `rfp_id` BIGINT COMMENT 'Foreign key linking to sales.rfp. Business justification: Proposals are often created in response to RFPs. This FK enables tracing proposals back to the RFP they respond to. N:1 relationship (one proposal per RFP in the context of a single seller responding)',
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
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount or price reduction offered in the proposal, applied to the total proposed value.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Overall discount percentage applied to the proposal (e.g., volume discount, upfront commitment discount). Null if no discount applied.',
    `expiry_date` DATE COMMENT 'Date when the proposal expires and is no longer valid for acceptance. After this date, pricing and inventory availability must be re-confirmed.',
    `flight_end_date` DATE COMMENT 'Proposed end date for the advertising campaign or content delivery period covered by this proposal.',
    `flight_start_date` DATE COMMENT 'Proposed start date for the advertising campaign or content delivery period covered by this proposal.',
    `guaranteed_impressions` BIGINT COMMENT 'Minimum number of impressions contractually guaranteed to be delivered, triggering makegood obligations if underdelivered.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal record was last updated or revised.',
    `makegood_policy` STRING COMMENT 'Description of the makegood policy for this proposal - the terms under which compensatory ad spots will be provided if delivery guarantees are not met.',
    `market_type` STRING COMMENT 'Sales market context for this proposal: upfront (advance commitment sales event), scatter (last-minute inventory sales), programmatic (automated bidding), or direct (one-to-one negotiation).. Valid values are `upfront|scatter|programmatic|direct`',
    `net_proposed_value` DECIMAL(18,2) COMMENT 'Net revenue value of the proposal after discounts and agency commissions. This is the expected revenue to the broadcaster.',
    `notes` STRING COMMENT 'Free-form notes and comments about the proposal, including special terms, negotiation history, or client-specific requirements.',
    `platform_mix` STRING COMMENT 'Distribution of proposed inventory across delivery platforms: linear (traditional broadcast), OTT (over-the-top streaming), FAST (free ad-supported streaming TV), AVOD (advertising video on demand), SVOD (subscription video on demand).',
    `proposal_date` DATE COMMENT 'Date when the proposal was created and issued to the advertiser or agency.',
    `proposal_description` STRING COMMENT 'Detailed narrative description of the proposal, including campaign objectives, creative strategy, and value proposition.',
    `proposal_name` STRING COMMENT 'Descriptive name or title of the proposal, typically reflecting the campaign or client name.',
    `proposal_number` STRING COMMENT 'Externally-visible unique business identifier for the proposal, used in client communications and internal tracking.',
    `proposal_source` STRING COMMENT 'Origin or trigger for this proposal: response to RFP (request for proposal), proactive sales pitch, contract renewal, upsell to existing client, or cross-sell of additional services.. Valid values are `rfp|proactive_pitch|renewal|upsell|cross_sell`',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the advertising proposal in the sales workflow.. Valid values are `draft|submitted|negotiating|accepted|rejected|expired`',
    `proposal_type` STRING COMMENT 'Category of commercial offer: advertising (spot sales), content licensing (rights acquisition), syndication (content resale), distribution (carriage agreements), sponsorship (branded integration), or upfront (advance commitment).. Valid values are `advertising|content_licensing|syndication|distribution|sponsorship|upfront`',
    `proposed_frequency` DECIMAL(18,2) COMMENT 'Proposed average frequency (number of times) that each reached individual in the target audience will be exposed to the campaign. Frequency = GRP / Reach.',
    `proposed_grp` DECIMAL(18,2) COMMENT 'Total Gross Rating Points (GRP) proposed to be delivered across all dayparts and channels. GRP measures the total exposure weight of the campaign.',
    `proposed_impressions` BIGINT COMMENT 'Total number of impressions (ad views) proposed to be delivered across all channels and platforms in this campaign.',
    `proposed_reach` DECIMAL(18,2) COMMENT 'Proposed reach as a percentage of the target audience that will be exposed to the campaign at least once. Reach measures unique audience coverage.',
    `proposed_trp` DECIMAL(18,2) COMMENT 'Total Target Rating Points (TRP) proposed to be delivered to the specific demographic target audience. TRP measures exposure within the target demo only.',
    `rejected_timestamp` TIMESTAMP COMMENT 'Timestamp when the proposal was rejected by the advertiser or agency. Null if not rejected.',
    `response_due_date` DATE COMMENT 'Requested or required date by which the client should provide a decision or response to the proposal.',
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
    CONSTRAINT pk_sales_proposal PRIMARY KEY(`sales_proposal_id`)
) COMMENT 'Pre-sale advertising proposal submitted to an advertiser or agency in response to an RFP or upfront/scatter negotiation. Captures proposal number, advertiser, agency, account executive, proposal date, expiry date, total proposed value, proposed GRP/TRP/impression delivery, channel mix, daypart mix, spot length mix, CPM/CPRP, audience demographic targets, proposal status (draft, submitted, negotiating, accepted, rejected), and Salesforce opportunity reference. Precedes the formal ad order.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` (
    `upfront_deal_id` BIGINT COMMENT 'Unique identifier for the upfront advertising deal negotiation record. Primary key. Role: MASTER_AGREEMENT.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization purchasing the advertising inventory under this deal. Links to the advertiser master record.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Upfront deals commit annual inventory against specific demographic guarantees (e.g., A18-49 GRP at negotiated CPM). Core to annual negotiation cycle, audience guarantee structuring, and scatter conver',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Upfront commitments tied to specific content rights portfolios. Multi-year upfront deals depend on multi-year content licenses. Sales executives negotiate upfronts around confirmed rights renewals for',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Upfront deals in broadcasting often involve content distribution partners (networks, studios) providing programming blocks or inventory commitments. Real business process: upfront negotiation tracking',
    `employee_id` BIGINT COMMENT 'Reference to the sales account executive responsible for negotiating and managing this upfront deal. Links to the employee/user master record.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Upfront deals establish multi-year revenue commitments requiring financial classification. Contract accounting and multi-year revenue forecasting require linking deals to revenue streams for proper co',
    `sales_agency_id` BIGINT COMMENT 'Reference to the media buying agency representing the advertiser in this deal negotiation. Nullable for direct advertiser deals. Links to the agency master record.',
    `tertiary_upfront_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this deal record. Links to the employee/user master record for audit and accountability.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` (
    `advertising_audience_guarantee_id` BIGINT COMMENT 'Unique identifier for the audience delivery guarantee record.',
    `ad_order_id` BIGINT COMMENT 'Reference to the advertising order associated with this guarantee.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Audience guarantees can be associated at campaign level (not just order or deal level). This FK enables campaign-level audience guarantee tracking. Nullable because guarantees may be order-specific or',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Audience guarantees are contractually bound to specific Nielsen demographic segments for GRP/TRP delivery measurement and makegood triggers. Core to upfront deals and scatter order compliance. Replace',
    `upfront_deal_id` BIGINT COMMENT 'Reference to the upfront deal if this guarantee is part of an advance advertising sales commitment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audience guarantee verification requires sign-off by revenue assurance analyst or audience measurement employee to confirm delivery metrics and trigger makegood/credit processes. Critical for revenue ',
    `contracted_grp` DECIMAL(18,2) COMMENT 'The guaranteed Gross Rating Point (GRP) delivery target contractually committed to the advertiser for the specified demographic.',
    `contracted_impressions` BIGINT COMMENT 'The guaranteed number of impressions committed to the advertiser for the campaign period.',
    `contracted_trp` DECIMAL(18,2) COMMENT 'The guaranteed Target Rating Point (TRP) delivery target for the specific demographic audience segment.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this audience guarantee record was first created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The monetary credit amount owed to the advertiser if makegoods are not provided for underdelivery.',
    `daypart` STRING COMMENT 'The time segment of the broadcast day during which the guarantee applies (e.g., Prime Time, Early Morning, Late Fringe).',
    `delivered_grp` DECIMAL(18,2) COMMENT 'The actual Gross Rating Point (GRP) delivered to date as measured by Nielsen or other audience measurement provider.',
    `delivered_impressions` BIGINT COMMENT 'The actual number of impressions delivered to date as measured by the audience measurement system.',
    `delivered_trp` DECIMAL(18,2) COMMENT 'The actual Target Rating Point (TRP) delivered to date for the specified demographic segment.',
    `delivery_percentage` DECIMAL(18,2) COMMENT 'The percentage of the contracted guarantee that has been delivered, calculated as (delivered / contracted) * 100.',
    `delivery_variance_grp` DECIMAL(18,2) COMMENT 'The difference between contracted and delivered GRP, calculated as delivered minus contracted (negative indicates underdelivery).',
    `guarantee_number` STRING COMMENT 'Business identifier for the audience guarantee, used for tracking and reporting purposes.',
    `guarantee_period_end_date` DATE COMMENT 'The end date of the period during which the audience guarantee applies.',
    `guarantee_period_start_date` DATE COMMENT 'The start date of the period during which the audience guarantee applies.',
    `guarantee_status` STRING COMMENT 'Current status of the audience guarantee: on_track (meeting targets), at_risk (trending toward underdelivery), underdelivered (below threshold), fulfilled (completed successfully), cancelled (guarantee voided).. Valid values are `on_track|at_risk|underdelivered|fulfilled|cancelled`',
    `last_measurement_date` DATE COMMENT 'The date of the most recent audience measurement update used to calculate delivery performance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this audience guarantee record was most recently updated.',
    `makegood_grp_owed` DECIMAL(18,2) COMMENT 'The amount of GRP that must be delivered through makegood spots to fulfill the guarantee obligation.',
    `makegood_required_flag` BOOLEAN COMMENT 'Indicates whether makegood spots are required due to underdelivery against the guarantee.',
    `market_code` STRING COMMENT 'The designated market area (DMA) or geographic market code where the audience guarantee applies.',
    `measurement_methodology` STRING COMMENT 'The specific measurement methodology or panel used for audience tracking (e.g., Nielsen C3, C7, Live+Same Day).',
    `measurement_source` STRING COMMENT 'The audience measurement provider or system used to track delivery against the guarantee (e.g., Nielsen, Comscore).. Valid values are `nielsen|comscore|rentrak|internal|other`',
    `network_station_code` STRING COMMENT 'The broadcast network or station identifier where the guaranteed audience delivery is measured.',
    `next_evaluation_date` DATE COMMENT 'The scheduled date for the next evaluation of guarantee delivery performance.',
    `notes` STRING COMMENT 'Free-form notes regarding the guarantee, including special conditions, adjustments, or client communications.',
    `underdelivery_threshold_percentage` DECIMAL(18,2) COMMENT 'The contractual threshold percentage below which underdelivery triggers makegood or credit obligations (e.g., 95% means delivery below 95% triggers makegoods).',
    CONSTRAINT pk_advertising_audience_guarantee PRIMARY KEY(`advertising_audience_guarantee_id`)
) COMMENT 'Audience delivery guarantee record associated with an ad order or upfront deal, specifying the contracted GRP/TRP/impression target and tracking actual delivery against that target. Captures guarantee ID, order or deal reference, audience demographic (age/gender cell), contracted GRP, delivered GRP, delivery variance, delivery percentage, underdelivery threshold, guarantee period, Nielsen measurement source, and guarantee status (on-track, at-risk, underdelivered, fulfilled). Triggers makegood or credit processes on underdelivery.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` (
    `dai_event_id` BIGINT COMMENT 'Unique identifier for the dynamic ad insertion event record. Primary key.',
    `ad_spot_id` BIGINT COMMENT 'Foreign key linking to sales.ad_spot. Business justification: DAI (Dynamic Ad Insertion) events fulfill contracted ad spots in streaming/OTT environments. This FK links the real-time insertion event back to the ad spot it delivered, enabling reconciliation betwe',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization that owns the inserted ad creative.',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign under which this ad insertion was executed.',
    `dai_media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Dynamic ad insertion events must track which specific media asset file was served to the viewer for billing reconciliation, QC audits, and content delivery verification. Essential for programmatic ad ',
    `device_type_id` BIGINT COMMENT 'Foreign key linking to distribution.device_type. Business justification: DAI systems track device type per insertion event to select device-compatible creatives, measure device-specific fill rates, and support device targeting. Essential for device-level DAI analytics and ',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Normalize creative reference in dynamic ad insertion event. DAI event tracks which creative was inserted in real-time. Currently denormalized as isci_code STRING; should FK to isci_creative master to ',
    `media_asset_id` BIGINT COMMENT 'Reference to the content asset (program, episode, or video) during which the ad was inserted.',
    `playback_session_id` BIGINT COMMENT 'Unique identifier for the streaming session in which this ad insertion occurred. Links to the viewers active playback session.',
    `revenue_recognition_event_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition_event. Business justification: DAI events trigger programmatic revenue recognition. Real-time revenue tracking and digital advertising accounting require linking insertion events to recognition events for accurate programmatic reve',
    `scte_marker_id` BIGINT COMMENT 'SCTE-35 cue point identifier that triggered the dynamic ad insertion opportunity.',
    `segment_id` BIGINT COMMENT 'Reference to the audience segment used for targeting this ad insertion. Represents the viewer demographic or behavioral profile.',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: DAI insertion events occur at specific streaming endpoints. DAI systems track which endpoint handled each insertion for delivery confirmation, latency monitoring, CDN cost allocation, and infrastructu',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Every dynamic ad insertion event occurs within an authenticated subscriber streaming session. Subscriber identity is required for addressable advertising decisioning, personalization, frequency manage',
    `content_asset_id` BIGINT COMMENT '',
    `ad_decision_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the DAI platform made the ad selection decision for this insertion opportunity.',
    `ad_duration_seconds` STRING COMMENT 'Duration of the inserted ad creative in seconds (e.g., 15, 30, 60 seconds).',
    `ad_pod_position` STRING COMMENT 'Sequential position of this ad within the ad pod (group of ads in a break). Position 1 is the first ad in the pod.',
    `ad_server_transaction_reference` STRING COMMENT 'Transaction identifier from the upstream ad server (e.g., Wide Orbit, FreeWheel) that authorized this ad insertion.',
    `bid_price_cpm` DECIMAL(18,2) COMMENT 'Winning bid price in CPM (cost per thousand impressions) for this ad insertion in programmatic auction scenarios.',
    `cdn_node_reference` STRING COMMENT 'Identifier of the CDN edge node that delivered the ad content to the viewer. Used for delivery performance tracking.',
    `click_through_url` STRING COMMENT 'Destination URL if the viewer clicked on the ad. Used for engagement tracking and attribution.',
    `completion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of the ad duration that was actually viewed by the user before skipping or abandoning (0.00 to 100.00).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DAI event record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for revenue and bid price amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dai_platform_name` STRING COMMENT 'Name of the DAI platform that executed this ad insertion (e.g., Google DAI, FreeWheel, Adobe Primetime).',
    `dai_platform_version` STRING COMMENT 'Version identifier of the DAI platform software used for this insertion event.',
    `delivery_confirmed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the CDN confirmed successful delivery of the ad content to the viewers device.',
    `device_type` STRING COMMENT 'Type of device on which the ad was inserted and viewed (e.g., smart TV, mobile phone, tablet, desktop, set-top box, gaming console).. Valid values are `smart_tv|mobile_phone|tablet|desktop|set_top_box|gaming_console`',
    `fallback_reason` STRING COMMENT 'Reason code or description explaining why a fallback ad was used instead of the primary targeted ad (e.g., targeting mismatch, inventory unavailable, technical constraint).',
    `geo_location_code` STRING COMMENT 'Geographic location code (DMA, postal code, or country code) of the viewer at the time of ad insertion, used for geo-targeting.',
    `impression_fired_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the impression tracking URL was successfully fired and acknowledged.',
    `impression_fired_timestamp` TIMESTAMP COMMENT 'Timestamp when the impression tracking beacon was fired, marking the billable impression event.',
    `impression_tracking_url` STRING COMMENT 'URL fired to record the ad impression event. Used for third-party verification and billing reconciliation.',
    `insertion_point_timecode` STRING COMMENT 'Timecode within the content stream where the ad insertion was triggered, typically corresponding to an SCTE-35 cue marker.',
    `insertion_status` STRING COMMENT 'Status outcome of the ad insertion attempt: inserted (successful), fallback (backup ad used), no-fill (no ad available), error (technical failure), or skipped (viewer action).. Valid values are `inserted|fallback|no_fill|error|skipped`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this DAI event record was last modified or updated.',
    `platform_type` STRING COMMENT 'Delivery platform type for the ad insertion: OTT (Over-The-Top), linear broadcast, VOD (Video On Demand), or FAST (Free Ad-Supported Streaming Television).. Valid values are `ott|linear|vod|fast`',
    `privacy_signal` STRING COMMENT 'Privacy signal or consent string passed from the viewers device (e.g., IAB TCF consent string, US Privacy string).',
    `quartile_reached` STRING COMMENT 'Highest quartile milestone reached during ad playback: start, first quartile (25%), midpoint (50%), third quartile (75%), complete (100%), or none.. Valid values are `start|first_quartile|midpoint|third_quartile|complete|none`',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Revenue amount attributed to this ad insertion event, calculated based on CPM, impressions, and contract terms.',
    `source_system_name` STRING COMMENT 'Name of the source system that generated this DAI event record (e.g., Google DAI API, FreeWheel event stream).',
    `user_consent_status` STRING COMMENT 'Privacy consent status of the viewer for personalized ad targeting: granted, denied, not required (non-EU), or unknown.. Valid values are `granted|denied|not_required|unknown`',
    `user_interaction_type` STRING COMMENT 'Type of user interaction with the ad during playback: none, click-through, skip, pause, mute, or expand.. Valid values are `none|click|skip|pause|mute|expand`',
    `viewability_status` STRING COMMENT 'Viewability measurement status indicating whether the ad met viewability criteria (e.g., 50% of pixels visible for 2+ seconds per IAB standards).. Valid values are `viewable|not_viewable|unmeasured`',
    CONSTRAINT pk_dai_event PRIMARY KEY(`dai_event_id`)
) COMMENT 'Dynamic Ad Insertion event record capturing a real-time ad decision and insertion for OTT/streaming delivery. Captures DAI event ID, stream session reference, content asset, insertion point (SCTE-35 cue), ad decision timestamp, selected ISCI creative, advertiser, campaign, targeting parameters applied (audience segment, geo, device type), insertion status (inserted, fallback, no-fill), CDN delivery confirmation, and impression tracking URL fired. Sourced from the DAI platform (e.g., Google DAI, FreeWheel). Distinct from linear broadcast spot trafficking.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` (
    `impression_delivery_id` BIGINT COMMENT 'Unique identifier for the digital or streaming advertising impression delivery record.',
    `ad_order_line_id` BIGINT COMMENT 'Reference to the specific ad order line item that this impression fulfills.',
    `ad_spot_id` BIGINT COMMENT 'Foreign key linking to sales.ad_spot. Business justification: Impression delivery records track the actual delivery of ad impressions. This FK links delivery metrics back to the specific ad spot that was aired/streamed, enabling performance tracking and billing ',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign under which this impression was delivered.',
    `device_type_id` BIGINT COMMENT 'Foreign key linking to distribution.device_type. Business justification: Impression delivery systems track device type for viewability measurement, creative compatibility verification, and device-targeted campaign reporting. Essential for device-level impression analytics ',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Normalize creative reference in digital impression delivery record. Impression delivery tracks which creative was served across streaming platforms. Currently denormalized as isci_code STRING; should ',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Impression delivery records must reference the actual media asset served for accurate measurement, third-party verification, and discrepancy resolution. Critical for Nielsen/Comscore certification and',
    `playback_session_id` BIGINT COMMENT 'Unique identifier for the streaming session during which the impression was delivered.',
    `scte_marker_id` BIGINT COMMENT 'SCTE-35 cue point identifier that triggered the Dynamic Ad Insertion event, if applicable.',
    `segment_id` BIGINT COMMENT 'Reference to the audience segment targeted for this impression delivery.',
    `streaming_endpoint_id` BIGINT COMMENT 'Foreign key linking to distribution.streaming_endpoint. Business justification: Impression delivery records track where ads were served. In OTT/streaming, impressions are delivered through specific endpoints. Linking enables join to CDN infrastructure, latency analysis, geographi',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Impression delivery tracking requires subscriber identity for addressable advertising attribution, cross-device frequency capping, reach/frequency reporting, and subscriber-level ad exposure analysis.',
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
    `geo_target_code` STRING COMMENT 'ISO country or region code representing the geographic targeting applied to this impression.. Valid values are `^[A-Z]{2,3}$`',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` (
    `sales_scatter_order_id` BIGINT COMMENT 'Unique identifier for the scatter market advertising order. Primary key for the sales scatter order entity.',
    `ad_billing_order_id` BIGINT COMMENT 'Foreign key linking to billing.ad_billing_order. Business justification: Scatter orders are billed through ad billing orders in WideOrbit. Scatter market revenue tracking, order fulfillment reconciliation, and scatter vs. upfront revenue reporting require direct linkage fr',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser placing the scatter market order. Links to the advertiser master record.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Scatter market orders are station-specific and must reference the broadcast license for regulatory compliance, public file requirements, and FCC reporting. Same regulatory requirements as upfront orde',
    `campaign_id` BIGINT COMMENT 'Reference to the parent advertising campaign this scatter order belongs to. Links scatter buys to broader campaign strategy.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Scatter orders specify channel for spot placement. Business process: scatter market inventory allocation, last-minute inventory sales, channel-specific scatter pricing.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Scatter orders specify daypart for purchased inventory. Business process: scatter pricing by daypart, daypart fulfillment tracking. Replaces denormalized daypart text field with proper FK.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Scatter orders target specific demographics for short-term inventory buys with demographic-specific CPM pricing and GRP/TRP delivery expectations. Core to scatter market operations and yield managemen',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Scatter orders may source inventory from affiliate partners or syndicated content blocks requiring partner tracking for inventory sourcing and revenue allocation. Real business process: scatter invent',
    `employee_id` BIGINT COMMENT 'Reference to the sales account executive responsible for this scatter order. Used for commission calculation and performance tracking.',
    `opportunity_id` BIGINT COMMENT 'External identifier linking this scatter order to the originating sales opportunity in Salesforce Media Cloud. Enables CRM integration and sales pipeline tracking.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Scatter orders generate spot revenue requiring classification for financial reporting. Revenue recognition and yield management reporting require linking scatter orders to revenue stream classificatio',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser for this scatter order. Nullable if direct advertiser buy.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative who negotiated and closed this scatter order.',
    `scatter_order_id` BIGINT COMMENT 'Foreign key linking to sales.scatter_order. Business justification: sales_scatter_order and scatter_order appear to represent the same business entity at different lifecycle stages (proposal vs. confirmed). Linking them tracks the progression from scatter order reques',
    `agency_commission_rate` DECIMAL(18,2) COMMENT 'Agency commission rate percentage deducted from the gross order value. Standard agency commission is typically 15% in the advertising industry.',
    `audience_guarantee_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this scatter order includes an audience delivery guarantee. If true, makegoods may be required if delivery falls short.',
    `cancellation_deadline_date` DATE COMMENT 'Last date by which the advertiser may cancel this scatter order without penalty. After this date, cancellation fees may apply.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate percentage applied to this scatter order for sales representative compensation. Expressed as a percentage (e.g., 15.00 for 15%).',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Timestamp when the scatter order was confirmed by the advertiser or agency. Represents commitment to the buy and triggers inventory allocation.',
    `contract_terms` STRING COMMENT 'Free-text field capturing special contractual terms, conditions, or notes specific to this scatter order. May include payment terms, delivery guarantees, or custom provisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scatter order record was first created in the system. Audit trail for order lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this scatter order. Supports multi-currency advertising sales.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time segment of the broadcast day targeted for scatter spot placement. Critical for audience targeting and pricing. Daypart represents the time-of-day classification used in broadcast scheduling. [ENUM-REF-CANDIDATE: early_morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight|weekend — 9 candidates stripped; promote to reference product]',
    `delivered_grps` DECIMAL(18,2) COMMENT 'Actual Gross Rating Points (GRPs) delivered for linear broadcast inventory. Compared against requested GRPs to assess fulfillment.',
    `delivered_impressions` BIGINT COMMENT 'Actual number of advertising impressions delivered for this scatter order. Compared against requested impressions to assess fulfillment.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the scatter order, if any. May include volume discounts or promotional adjustments.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the scatter order total. May reflect volume discounts, promotional pricing, or negotiated rate adjustments.',
    `flight_end_date` DATE COMMENT 'Last date of the advertising campaign flight period when spots may air.',
    `flight_start_date` DATE COMMENT 'First date of the advertising campaign flight period when spots may air.',
    `fulfillment_status` STRING COMMENT 'Current fulfillment status of the scatter order. Tracks whether requested impressions or GRPs have been delivered as scheduled.. Valid values are `pending|partial|complete|under_delivered|over_delivered`',
    `inventory_type` STRING COMMENT 'Type of advertising inventory being purchased in the scatter market. Indicates the delivery platform or format.. Valid values are `linear|vod|ott|digital|streaming`',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether this scatter order is eligible for makegood spots if original spots are preempted or underdeliver. Makegoods are compensatory ad spots provided when contracted delivery is not met.',
    `market_type` STRING COMMENT 'Geographic market scope for the scatter order. Determines pricing, inventory availability, and audience measurement methodology.. Valid values are `national|local|regional|dma_specific`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the scatter order record. Tracks order changes and updates throughout the lifecycle.',
    `negotiated_cpm` DECIMAL(18,2) COMMENT 'Negotiated Cost Per Mille (CPM) rate for this scatter order. Represents the cost per thousand impressions. Scatter market CPM is typically at a premium to upfront rates.',
    `negotiated_cprp` DECIMAL(18,2) COMMENT 'Negotiated Cost Per Rating Point (CPRP) for linear broadcast inventory. Represents the cost per single rating point.',
    `net_order_amount` DECIMAL(18,2) COMMENT 'Final order amount after discounts and adjustments. Represents the actual revenue expected from this scatter order.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Net monetary value of the scatter order after discounts and before agency commission. Represents the revenue to the broadcaster.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this scatter order. May include special instructions, scheduling preferences, or internal coordination details.',
    `order_date` DATE COMMENT 'Date the scatter order was placed. Represents the business event timestamp when the advertiser or agency committed to the scatter buy.',
    `order_number` STRING COMMENT 'Business identifier for the scatter order, typically generated by the sales or traffic system. Used for external communication and tracking.',
    `order_status` STRING COMMENT 'Current lifecycle status of the scatter order. Tracks progression from draft through fulfillment or cancellation. Preempted status indicates the order was bumped by higher-priority inventory. [ENUM-REF-CANDIDATE: draft|submitted|confirmed|scheduled|in_flight|completed|cancelled|preempted — 8 candidates stripped; promote to reference product]',
    `platform` STRING COMMENT 'Distribution platform where the advertising will be delivered. Supports multi-platform scatter buying.. Valid values are `broadcast|cable|satellite|streaming|mobile|web`',
    `political_ad_flag` BOOLEAN COMMENT 'Indicates whether this scatter order is for political advertising. Political ads have special regulatory requirements including disclosure, equal time provisions, and public file obligations.',
    `preemptibility_class` STRING COMMENT 'Classification of whether and how scatter spots can be preempted by higher-value inventory. Non-preemptible spots are guaranteed to air; preemptible spots may be bumped for higher-paying advertisers. Critical distinction from upfront deals.. Valid values are `non_preemptible|preemptible_with_notice|immediately_preemptible`',
    `preemption_protection_level` STRING COMMENT 'Numeric priority level for preemption protection (1-10, where 10 is highest protection). Determines which orders are preempted first when inventory conflicts arise.',
    `preemption_risk_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this scatter order is subject to preemption by higher-rated inventory. True indicates the order may be bumped if higher-priority demand emerges.',
    `priority_level` STRING COMMENT 'Priority level assigned to this scatter order. Determines preemption risk and scheduling preference. Higher priority orders are less likely to be preempted.. Valid values are `standard|priority|premium|guaranteed`',
    `product_category` STRING COMMENT 'Industry category of the advertised product or service. Used for competitive separation, content adjacency rules, and regulatory compliance.',
    `requested_air_end_date` DATE COMMENT 'Last date of the requested air window for scatter market spots. Defines the flight period for the scatter campaign.',
    `requested_air_start_date` DATE COMMENT 'First date of the requested air window for scatter market spots. Typically 4-12 weeks from order date, distinguishing scatter from upfront buys.',
    `requested_grps` DECIMAL(18,2) COMMENT 'Total Gross Rating Points (GRPs) requested for linear broadcast inventory. Represents reach multiplied by frequency.',
    `requested_impressions` BIGINT COMMENT 'Total number of advertising impressions requested by the advertiser for this scatter order. Used for digital and streaming inventory.',
    `requested_spots` STRING COMMENT 'Number of individual advertising spots or units requested in this scatter order.',
    `requires_clearance_flag` BOOLEAN COMMENT 'Indicates whether advertising creative requires legal or standards clearance before airing. Common for political ads, pharmaceutical products, and sensitive content.',
    `sales_channel` STRING COMMENT 'Channel through which the scatter order was sold. Affects commission structure, pricing, and order processing workflow.. Valid values are `direct|agency|programmatic|network`',
    `scatter_cpm_amount` DECIMAL(18,2) COMMENT 'Cost per thousand impressions for this scatter order. Typically at a premium to upfront CPM due to short lead time and market conditions. CPM is the standard pricing metric in broadcast advertising.',
    `spot_length_seconds` STRING COMMENT 'Duration of each advertising spot in seconds. Standard lengths are 15, 30, or 60 seconds. Affects pricing and inventory allocation.',
    `target_demographic` STRING COMMENT 'Primary demographic audience segment targeted by this scatter order (e.g., Adults 18-49, Women 25-54). Used for audience guarantee and measurement.',
    `target_frequency` DECIMAL(18,2) COMMENT 'Target average number of times each individual in the target audience will be exposed to the advertising. Frequency complements reach in campaign effectiveness measurement.',
    `target_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points for the scatter order. GRP measures the total exposure of the campaign across the target audience, calculated as reach multiplied by frequency.',
    `target_reach_percent` DECIMAL(18,2) COMMENT 'Target percentage of unique individuals in the target demographic to be reached by this scatter campaign. Reach represents unduplicated audience exposure.',
    `target_trp` DECIMAL(18,2) COMMENT 'Target Rating Points for the specific demographic segment. TRP is similar to GRP but focuses on a specific target audience rather than total audience.',
    `total_order_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the scatter order before discounts or adjustments. Calculated from spot count, CPM, and estimated impressions.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the scatter order before any adjustments. Calculated based on negotiated rates and requested volume.',
    `total_spots_ordered` STRING COMMENT 'Total number of advertising spots purchased in this scatter order. Represents the quantity of impressions the advertiser is buying.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this scatter order record was last modified. Audit trail for record updates.',
    `wide_orbit_order_number` STRING COMMENT 'External order number assigned by Wide Orbit traffic and billing system for scatter market buys. Used for cross-system reconciliation and affidavit tracking.. Valid values are `^SO-[0-9]{8}$`',
    CONSTRAINT pk_sales_scatter_order PRIMARY KEY(`sales_scatter_order_id`)
) COMMENT 'Ad order record for scatter market buys — short-notice advertising purchases made outside the upfront window, typically 4-12 weeks before air. Captures scatter order ID, advertiser, agency, order date, requested air window, channel, daypart, spot length, scatter CPM (typically at premium to upfront), audience target, preemptibility class (non-preemptible, preemptible at rate, immediately preemptible), and order status. Distinct from upfront deals due to different pricing, lead time, and preemption rules.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` (
    `sponsorship_id` BIGINT COMMENT 'Unique identifier for the sponsorship deal. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser who is sponsoring the content.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Sponsorship deals are often part of broader advertising campaigns. This FK links the sponsorship to its parent campaign for integrated campaign management and reporting. Nullable because some sponsors',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Sponsorships require tracking the content partner (network, producer, syndicator) delivering the sponsored property, distinct from the agency. Real business process: sponsorship fulfillment verificati',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Sponsored content requires explicit rights clearance. Integration rights (product placement, billboards) often negotiated separately from standard ad spots. License_agreement specifies sponsorship-spe',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the sponsorship deal.',
    `quaternary_sponsorship_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the sponsorship record.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Sponsorships represent non-spot revenue requiring separate classification for financial reporting. Sponsorship revenue recognition and non-spot revenue reporting require linking sponsorships to their ',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the sponsor, if applicable.',
    `opportunity_id` BIGINT COMMENT 'Reference to the originating sales opportunity in Salesforce Media Cloud CRM system.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Series-level sponsorships (season-long partnerships, franchise deals). Business process: upfront sponsorship packages, multi-season partnership agreements, series franchise sponsorship valuation, seas',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Talent-driven sponsorships including celebrity endorsements and spokesperson deals require direct talent linkage for contract fulfillment tracking, exclusivity enforcement, usage rights validation, an',
    `tertiary_sponsorship_employee_id` BIGINT COMMENT 'Reference to the sales account executive responsible for managing this sponsorship relationship.',
    `title_id` BIGINT COMMENT 'Unique identifier for the sponsored program or content asset in the Media Asset Management (MAM) system.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the sponsorship deal was approved and moved to active status.',
    `audience_guarantee_flag` BOOLEAN COMMENT 'Indicates whether the sponsorship includes audience delivery guarantees measured by Nielsen or other measurement providers.',
    `billboard_count` STRING COMMENT 'Number of billboard mentions or placements included in the sponsorship package.',
    `category_exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the sponsor has category exclusivity rights for the sponsored content.',
    `sponsorship_code` STRING COMMENT 'Business identifier or code for the sponsorship deal used in trafficking and billing systems.',
    `contract_reference_number` STRING COMMENT 'Legal contract or insertion order number associated with the sponsorship agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sponsorship record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the sponsorship value.. Valid values are `^[A-Z]{3}$`',
    `deliverables_description` STRING COMMENT 'Detailed description of sponsorship deliverables including billboards, opens/closes, product integration, logo placement, mentions, and other sponsor benefits.',
    `exclusive_category` STRING COMMENT 'Product or service category for which the sponsor holds exclusivity rights (e.g., automotive, telecommunications, financial services).',
    `exclusivity_terms` STRING COMMENT 'Description of category exclusivity provisions preventing competing sponsors within the same product or service category.',
    `flight_end_date` DATE COMMENT 'End date of the sponsorship flight period when sponsor benefits conclude.',
    `flight_start_date` DATE COMMENT 'Start date of the sponsorship flight period when sponsor benefits begin.',
    `fulfillment_percentage` DECIMAL(18,2) COMMENT 'Percentage of sponsorship deliverables that have been completed and delivered to the sponsor.',
    `fulfillment_status` STRING COMMENT 'Status indicating progress toward completing all sponsorship deliverables and obligations.. Valid values are `not started|in progress|partially fulfilled|fully fulfilled|overdelivered`',
    `guaranteed_impressions` BIGINT COMMENT 'Minimum number of impressions guaranteed to the sponsor across all deliverables and platforms.',
    `logo_placement_flag` BOOLEAN COMMENT 'Indicates whether sponsor logo placement is included in the deliverables.',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether the sponsorship is eligible for makegood compensation if deliverables are not met or audience guarantees are missed.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sponsorship record was last modified.',
    `sponsorship_name` STRING COMMENT 'Descriptive name of the sponsorship deal for business reference and reporting.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the sponsorship deal.',
    `platform_distribution` STRING COMMENT 'Platforms where the sponsored content will be distributed (linear broadcast, OTT, VOD, digital, social media).',
    `product_integration_flag` BOOLEAN COMMENT 'Indicates whether product integration within content is part of the sponsorship agreement.',
    `sponsored_content_type` STRING COMMENT 'Type of content being sponsored (program, series, event, segment, etc.).. Valid values are `program|series|segment|event|daypart|channel`',
    `sponsored_program_name` STRING COMMENT 'Name of the specific program, series, or event being sponsored.',
    `sponsorship_status` STRING COMMENT 'Current lifecycle status of the sponsorship deal. [ENUM-REF-CANDIDATE: draft|proposed|negotiating|approved|active|fulfilled|cancelled|expired — 8 candidates stripped; promote to reference product]',
    `sponsorship_type` STRING COMMENT 'Classification of the sponsorship arrangement indicating the level and nature of sponsor integration.. Valid values are `presenting sponsor|title sponsor|segment sponsor|branded content|product integration|event sponsor`',
    `target_demographic` STRING COMMENT 'Primary demographic audience segment targeted by the sponsorship (e.g., Adults 18-49, Women 25-54).',
    `value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the sponsorship deal.',
    CONSTRAINT pk_sponsorship PRIMARY KEY(`sponsorship_id`)
) COMMENT 'Master record for a program or content sponsorship deal where an advertiser sponsors a specific program, segment, event, or content series. Captures sponsorship ID, advertiser, agency, sponsored program or event, sponsorship type (presenting sponsor, title sponsor, segment sponsor, branded content), sponsorship value, deliverables (billboards, opens/closes, product integration, logo placement), exclusivity terms, flight dates, and fulfillment status. Distinct from standard spot advertising — sponsorships carry integration and exclusivity obligations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` (
    `political_ad_disclosure_id` BIGINT COMMENT 'Unique identifier for the FCC-mandated political advertising disclosure record. Primary key for political ad disclosure tracking and public inspection file maintenance.',
    `ad_order_id` BIGINT COMMENT 'Reference to the parent advertising order under which this political ad was sold and scheduled.',
    `ad_spot_id` BIGINT COMMENT 'Reference to the specific advertising spot that aired. Links to the broadcast ad inventory and trafficking system for proof of performance.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser entity representing the political candidate committee, issue advocacy group, or Political Action Committee (PAC) that purchased the advertising.',
    `isci_creative_id` BIGINT COMMENT 'Foreign key linking to sales.isci_creative. Business justification: Normalize creative reference in FCC political ad disclosure. Disclosure must reference which creative aired for compliance tracking. Currently denormalized as isci_code STRING; should FK to isci_creat',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the political ad disclosure record. Supports audit trail and accountability for regulatory compliance documentation.',
    `public_inspection_file_id` BIGINT COMMENT 'Foreign key linking to compliance.public_inspection_file. Business justification: Political ad disclosures are required public file documents under FCC regulations. Broadcasters must link disclosure records to public inspection file entries showing sponsor identification, rates cha',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Political advertising has specific revenue recognition and FCC reporting requirements. Political advertising revenue reporting and regulatory compliance require linking political ads to their revenue ',
    `air_date` DATE COMMENT 'The date on which the political advertisement aired. Used for public inspection file chronological organization and lowest unit rate window determination.',
    `air_time` TIMESTAMP COMMENT 'The precise timestamp when the political advertisement was broadcast. Required for affidavit generation and proof of performance documentation.',
    `candidate_name` STRING COMMENT 'Full name of the political candidate featured in or sponsoring the advertisement. Required for candidate ads and independent expenditure communications. Null for issue-only advocacy.',
    `candidate_office` STRING COMMENT 'The elected office being sought by the candidate (e.g., President, U.S. Senator, Governor, State Representative). Required for candidate-related political ads.',
    `contract_number` STRING COMMENT 'Reference number of the advertising contract or agreement under which the political ad was purchased. Links disclosure to sales order and billing documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the political ad disclosure record was first created in the system. Audit trail for compliance tracking and record retention.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this disclosure record. Typically USD for U.S. broadcast stations.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'The broadcast daypart segment during which the political ad aired (e.g., Prime Time, Early Morning, Late Fringe). Affects lowest unit rate calculation and advertising value assessment.',
    `disclosure_number` STRING COMMENT 'Unique business identifier for the political ad disclosure record used in public inspection files and FCC reporting. Human-readable reference number for regulatory compliance tracking.',
    `disclosure_status` STRING COMMENT 'Current lifecycle status of the political ad disclosure record. Tracks progression from initial filing through amendments to final archival in public inspection file.. Valid values are `filed|pending|amended|archived`',
    `disclosure_text` STRING COMMENT 'The exact on-air or written disclosure statement required by FCC regulations identifying who paid for the advertisement. Must include paid for by language and sponsoring organization name.',
    `election_date` DATE COMMENT 'Date of the election for which the political advertisement is relevant. Used to determine lowest unit rate windows (45 days for primary, 60 days for general election).',
    `election_type` STRING COMMENT 'Type of election associated with the political advertisement. Determines applicable lowest unit rate periods and disclosure requirements.. Valid values are `primary|general|special|runoff|recall`',
    `equal_time_obligation_flag` BOOLEAN COMMENT 'Indicates whether this political ad triggers FCC equal time obligations requiring the broadcaster to offer comparable advertising opportunities to opposing candidates.',
    `filing_date` DATE COMMENT 'Date when the political ad disclosure record was filed in the public inspection file. FCC requires immediate disclosure upon request and placement in public file as soon as possible.',
    `lowest_unit_rate_amount` DECIMAL(18,2) COMMENT 'The lowest unit rate available for the class of time and daypart in which the political ad aired. Used to verify compliance with FCC lowest unit rate requirements for candidate advertising.',
    `lowest_unit_rate_applied` BOOLEAN COMMENT 'Indicates whether the FCC-mandated lowest unit rate was applied to this political ad spot. Required to be true for candidate ads within 45 days of primary or 60 days of general election.',
    `market_code` STRING COMMENT 'Nielsen Designated Market Area (DMA) code or other market identifier for the geographic region where the political ad aired. Used for reach analysis and compliance tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the political ad disclosure record. Tracks amendments and updates for compliance audit purposes.',
    `notes` STRING COMMENT 'Additional notes, comments, or clarifications regarding the political ad disclosure. May include special circumstances, amendments, or compliance officer annotations.',
    `political_ad_type` STRING COMMENT 'Classification of the political advertisement according to FCC categories. Determines applicable disclosure requirements, lowest unit rate eligibility, and equal time obligations.. Valid values are `candidate|ballot_issue|pac|independent_expenditure|electioneering_communication|issue_advocacy`',
    `rate_class` STRING COMMENT 'The advertising rate class or tier under which the political ad was sold (e.g., preemptible, non-preemptible, fixed position). Determines lowest unit rate calculation and equal time obligations.',
    `reasonable_access_flag` BOOLEAN COMMENT 'Indicates whether this ad purchase was made under FCC reasonable access requirements mandating broadcasters provide federal candidates reasonable access to purchase advertising time.',
    `sponsor_contact_email` STRING COMMENT 'Email address of the primary contact at the sponsoring organization for correspondence regarding the political advertising campaign.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sponsor_contact_name` STRING COMMENT 'Name of the primary contact person at the sponsoring organization responsible for the political advertising campaign.',
    `sponsor_contact_phone` STRING COMMENT 'Phone number of the primary contact at the sponsoring organization. Required for FCC public inspection file and reasonable access compliance.',
    `sponsoring_organization` STRING COMMENT 'Legal name of the organization sponsoring or paying for the political advertisement. May be a candidate committee, PAC, super PAC, issue advocacy group, or independent expenditure committee.',
    `spot_length_seconds` STRING COMMENT 'Duration of the political advertisement in seconds. Standard lengths are 15, 30, or 60 seconds. Affects rate calculation and inventory management.',
    `spot_rate_charged` DECIMAL(18,2) COMMENT 'The actual rate charged for the political ad spot. Must comply with lowest unit rate requirements during pre-election windows for candidate ads.',
    `station_call_sign` STRING COMMENT 'FCC-assigned call letters identifying the broadcast station that aired the political advertisement. Required for public inspection file organization and regulatory reporting.. Valid values are `^[KW][A-Z]{3,4}(-TV|-FM|-AM)?$`',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the political advertising contract. Required disclosure for public inspection file and transparency in political advertising spending.',
    `total_spots_contracted` STRING COMMENT 'Total number of advertising spots contracted under the political advertising agreement. Used for campaign tracking and public disclosure of advertising volume.',
    CONSTRAINT pk_political_ad_disclosure PRIMARY KEY(`political_ad_disclosure_id`)
) COMMENT 'FCC-mandated political advertising disclosure record for political candidate and issue advertising. Captures disclosure ID, ad spot reference, advertiser (candidate committee or issue group), political ad type (candidate, ballot issue, PAC), sponsoring organization, FCC-required disclosure text, lowest unit rate applied, equal time obligation flag, reasonable access flag, station file reference, and filing date. Required for FCC political file compliance and public inspection file maintenance.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` (
    `sales_account_id` BIGINT COMMENT 'Unique identifier for the sales account record. Primary key for the sales account entity representing advertising agencies, direct advertisers, content licensees, syndication buyers, and distribution partners.',
    `rep_id` BIGINT COMMENT 'Reference to the primary sales representative or account executive responsible for managing this account relationship and driving revenue.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Sales accounts must be associated with the contracting legal entity for proper invoicing, tax treatment, and intercompany elimination. Required for contract execution authority, tax jurisdiction deter',
    `parent_account_sales_account_id` BIGINT COMMENT 'Reference to the parent sales account in a hierarchical account structure. Used to model agency networks, holding company subsidiaries, and multi-location advertiser organizations.',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to sales.sales_territory. Business justification: Sales accounts are assigned to territories for territory management. Currently sales_account has market_territory as a STRING, which should be normalized to a FK to sales_territory. This FK enables pr',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` (
    `sales_contact_id` BIGINT COMMENT 'Unique identifier for the sales contact record. Primary key.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account executive responsible for managing this contact relationship.',
    `sales_account_id` BIGINT COMMENT 'Reference to the parent sales account or advertiser organization this contact belongs to.',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency this contact represents, if applicable. Null for direct brand contacts.',
    `employee_id` BIGINT COMMENT 'Reference to the system user who originally created this contact record.',
    `sales_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the system user who most recently modified this contact record.',
    `last_modified_by_user_employee_id` BIGINT COMMENT '',
    `budget_authority_usd` DECIMAL(18,2) COMMENT 'Estimated annual advertising budget the contact controls or influences, in USD. Used for opportunity sizing and account prioritization.',
    `contact_source` STRING COMMENT 'Origin or acquisition channel through which this contact was first captured. Used for lead source attribution and ROI analysis.. Valid values are `upfront_event|trade_show|referral|inbound_inquiry|purchased_list|partner`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact. Inactive or departed contacts are excluded from active sales campaigns.. Valid values are `active|inactive|on_leave|departed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact record was first created in the system.',
    `decision_authority_level` STRING COMMENT 'Level of purchasing authority the contact holds within their organization. Critical for routing proposals and negotiating upfront commitments.. Valid values are `final_approver|recommender|influencer|gatekeeper`',
    `do_not_contact` BOOLEAN COMMENT 'Master suppression flag indicating the contact has requested no further outreach. Overrides all other opt-in settings.',
    `email_address` STRING COMMENT 'Primary business email address for the sales contact. Used for proposal delivery, upfront negotiation, and campaign communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given name of the sales contact individual.',
    `full_name` STRING COMMENT 'Complete display name of the sales contact, typically concatenation of first and last name.',
    `last_contact_date` DATE COMMENT 'Date of the most recent sales interaction or touchpoint with this contact. Used for relationship health scoring.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact record was most recently updated.',
    `last_name` STRING COMMENT 'Family name or surname of the sales contact individual.',
    `linkedin_profile_url` STRING COMMENT 'URL to the contacts LinkedIn professional profile. Used for relationship intelligence and network mapping.',
    `mailing_address_line1` STRING COMMENT 'Primary street address line for physical correspondence and contract delivery.',
    `mailing_address_line2` STRING COMMENT 'Secondary address line for suite, floor, or department information.',
    `mailing_city` STRING COMMENT 'City name for the contacts mailing address.',
    `mailing_country_code` STRING COMMENT 'Three-letter ISO country code for the contacts mailing address (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `mailing_postal_code` STRING COMMENT 'Postal or ZIP code for the contacts mailing address.',
    `mailing_state_province` STRING COMMENT 'State, province, or region for the contacts mailing address.',
    `mobile_number` STRING COMMENT 'Mobile or cellular phone number for urgent or time-sensitive communication during upfront or scatter market negotiations.',
    `next_follow_up_date` DATE COMMENT 'Scheduled date for the next planned outreach or follow-up activity with this contact.',
    `notes` STRING COMMENT 'Free-form text field for sales team to capture relationship notes, preferences, and context about the contact.',
    `opt_in_email` BOOLEAN COMMENT 'Indicates whether the contact has explicitly consented to receive marketing and promotional emails.',
    `opt_in_phone` BOOLEAN COMMENT 'Indicates whether the contact has consented to receive phone calls for sales and marketing purposes.',
    `opt_in_sms` BOOLEAN COMMENT 'Indicates whether the contact has consented to receive SMS text messages for time-sensitive sales notifications.',
    `phone_number` STRING COMMENT 'Primary business telephone number for direct contact. May include extension.',
    `preferred_communication_channel` STRING COMMENT 'Contacts stated preference for how they wish to be reached for sales discussions and proposal reviews.. Valid values are `email|phone|mobile|video_conference|in_person`',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether this contact is the primary point of contact for their account. Used for proposal routing and commission attribution.',
    `relationship_tier` STRING COMMENT 'Classification of the contacts relationship strength and priority level. Strategic contacts receive white-glove service and early access to upfront inventory.. Valid values are `strategic|preferred|standard|new`',
    `role_type` STRING COMMENT 'Functional role classification of the contact in the sales process. Determines routing and approval workflows.. Valid values are `media_buyer|media_planner|brand_manager|legal_counsel|finance_approver|agency_executive`',
    `title` STRING COMMENT 'Professional job title or position of the contact within their organization (e.g., Media Buyer, Brand Manager, VP of Marketing).',
    CONSTRAINT pk_sales_contact PRIMARY KEY(`sales_contact_id`)
) COMMENT 'Individual buyer, decision-maker, or agency representative associated with a sales account. Tracks name, title, role (media buyer, planner, brand manager, legal), email, phone, preferred communication channel, opt-in status, and relationship tier. Sourced from Salesforce Media Cloud Contact object. Supports upfront negotiation tracking, proposal routing, and commission attribution. Distinct from subscriber identity — this is a B2B commercial contact, not a consumer.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Unique identifier for the sales opportunity record. Primary key sourced from Salesforce Media Cloud Opportunity object.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Opportunities represent potential deals with billing accounts. Sales pipeline reporting, revenue forecasting, and opportunity-to-invoice tracking require linking opportunities to the billing account t',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Sales opportunities for facility-based services (studio bookings, transmission capacity, uplink services) require facility identification for availability checks, pricing, and resource allocation duri',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Sales opportunities for broadcast advertising must reference the licensed station where ads will air for FCC compliance tracking, public inspection file requirements, and regulatory reporting. Station',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Opportunities must be assigned to cost centers for budget tracking, P&L attribution, and sales forecast roll-up by business unit. Essential for financial planning and variance analysis in media sales ',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or account executive assigned as the primary owner of this opportunity. Used for commission calculation and territory management.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Opportunities require profit center attribution for segment reporting, EBITDA tracking, and management reporting by business line (Linear TV, Streaming, Syndication). Critical for quarterly business r',
    `sales_account_id` BIGINT COMMENT 'Reference to the advertiser or client account associated with this opportunity. Links to the master account record in Salesforce Media Cloud.',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser in this deal. Null for direct sales. Links to agency master record.',
    `sales_team_id` BIGINT COMMENT 'Reference to the sales team or division responsible for this opportunity (e.g., National Sales, Local Sales, Digital Sales). Used for team performance tracking and territory alignment.',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to sales.sales_territory. Business justification: Opportunities belong to sales territories for territory management and quota allocation. This FK enables territory-based opportunity tracking. N:1 relationship. New attribute needed for territory mana',
    `upfront_deal_id` BIGINT COMMENT 'Reference to the parent upfront commitment deal if this opportunity is part of an upfront negotiation. Null for scatter market and direct deals. Used to track upfront commitment fulfillment.',
    `campaign_objective` STRING COMMENT 'Primary marketing objective the advertiser aims to achieve with this campaign. Influences creative strategy, placement selection, and success metrics. [ENUM-REF-CANDIDATE: brand_awareness|product_launch|direct_response|lead_generation|traffic|engagement|video_views|app_installs — 8 candidates stripped; promote to reference product]',
    `close_date` DATE COMMENT 'Target date by which the sales team expects to close this opportunity (win or lose). Used for pipeline forecasting and sales velocity tracking. Updated as negotiations progress.',
    `closed_date` DATE COMMENT 'Actual date when the opportunity was marked as closed-won or closed-lost. Null for open opportunities. Used for sales cycle analysis and win rate calculation.',
    `competitive_displacement` STRING COMMENT 'Free-text notes capturing competitive intelligence about which competitor this deal may displace or compete against. Used for win/loss analysis and competitive strategy.',
    `cpm_rate` DECIMAL(18,2) COMMENT 'Cost per thousand impressions rate negotiated for this opportunity. Standard pricing metric for digital and streaming advertising. Expressed in currency per 1,000 impressions.',
    `cprp_rate` DECIMAL(18,2) COMMENT 'Cost per rating point negotiated for linear TV or radio buys. Standard pricing metric for broadcast advertising. Calculated as total cost divided by total GRPs delivered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity record was first created in Salesforce Media Cloud. Used for lead-to-close cycle time analysis and pipeline velocity tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, GBP, EUR). Supports multi-currency deal tracking for international sales.. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time segment of the broadcast day targeted by this opportunity. Daypart classification affects pricing and audience demographics. Applicable primarily to linear TV and radio deals. [ENUM-REF-CANDIDATE: early_morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight|weekend|sports|news — 11 candidates stripped; promote to reference product]',
    `deal_type` STRING COMMENT 'Classification of the sales opportunity by transaction model. Upfront = advance commitment during upfront season; Scatter = last-minute inventory sales; Direct = direct-sold advertising; Programmatic Guaranteed = automated guaranteed buys; Content License = licensing content rights; Syndication = resale of content to multiple outlets.. Valid values are `upfront|scatter|direct|programmatic_guaranteed|content_license|syndication`',
    `demographic_target` STRING COMMENT 'Primary demographic audience segment targeted by this campaign (e.g., Adults 18-49, Women 25-54, Men 18-34). Used for audience guarantee and measurement alignment.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Total estimated revenue value of the opportunity in USD. For advertising deals, represents total campaign spend; for content licensing, represents license fee. Used for revenue forecasting and quota tracking.',
    `flight_end_date` DATE COMMENT 'Planned end date for the advertising campaign or content distribution window. Defines the duration of the media buy or license period.',
    `flight_start_date` DATE COMMENT 'Planned start date for the advertising campaign or content distribution window. For advertising, marks the beginning of the ad flight; for content licensing, marks the start of the license window.',
    `forecast_category` STRING COMMENT 'Sales forecast category indicating confidence level for revenue recognition. Pipeline = early stage; Best Case = likely but not committed; Commit = high confidence; Closed = won. Used for revenue forecasting rollups.. Valid values are `pipeline|best_case|commit|closed`',
    `is_upfront` BOOLEAN COMMENT 'Boolean flag indicating whether this opportunity is part of the annual upfront sales season. True = upfront commitment; False = scatter market or other deal type. Used for upfront tracking and reporting.',
    `last_activity_date` DATE COMMENT 'Date of the most recent sales activity (call, email, meeting) logged against this opportunity. Used for pipeline hygiene monitoring and stale opportunity identification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this opportunity record. Used for data freshness validation and change tracking. Updated automatically on any field modification.',
    `lead_source` STRING COMMENT 'Origin channel of this sales opportunity. Tracks how the lead was generated for marketing attribution and lead source ROI analysis. [ENUM-REF-CANDIDATE: inbound|outbound|referral|event|partner|renewal|upsell — 7 candidates stripped; promote to reference product]',
    `loss_notes` STRING COMMENT 'Free-text detailed explanation of why the opportunity was lost. Captures competitive intelligence, pricing feedback, and strategic insights for future deals.',
    `loss_reason` STRING COMMENT 'Primary reason for losing the opportunity if stage is closed-lost. Used for loss analysis, competitive intelligence, and sales process improvement. Null for won or open opportunities.. Valid values are `budget|timing|competitor|no_decision|product_fit|pricing`',
    `opportunity_name` STRING COMMENT 'Descriptive name of the sales opportunity, typically including advertiser name, campaign type, and time period (e.g., Acme Corp Q4 Upfront Buy).',
    `next_step` STRING COMMENT 'Description of the next action or milestone required to advance this opportunity. Used for sales activity tracking and pipeline hygiene. Updated regularly by sales executive.',
    `opportunity_number` STRING COMMENT 'Human-readable business identifier for the opportunity, typically auto-generated in format OPP-YYYYNNNN. Used in sales communications and reporting.. Valid values are `^OPP-[0-9]{8}$`',
    `probability` DECIMAL(18,2) COMMENT 'Estimated likelihood of closing this opportunity as a percentage (0.00 to 100.00). Typically aligned with stage (e.g., Proposal = 40%, Negotiation = 60%). Used for weighted pipeline forecasting.',
    `product_category` STRING COMMENT 'High-level classification of the media product being sold. Linear TV = traditional broadcast; Digital Video = online video ads; Streaming = OTT/SVOD/AVOD inventory; Content Licensing = rights to broadcast content. [ENUM-REF-CANDIDATE: linear_tv|digital_video|streaming|radio|podcast|display|social|sponsorship|content_licensing — 9 candidates stripped; promote to reference product]',
    `requires_makegood` BOOLEAN COMMENT 'Boolean flag indicating whether this opportunity includes makegood provisions for audience delivery shortfalls. True = makegoods may be required if audience guarantees are not met. Used for inventory planning.',
    `stage` STRING COMMENT 'Current stage in the sales pipeline lifecycle. Tracks progression from initial prospecting through closure. Used for pipeline forecasting and sales funnel analysis.. Valid values are `prospecting|qualification|proposal|negotiation|closed_won|closed_lost`',
    `target_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points representing the total audience reach multiplied by frequency. Standard metric for linear TV and radio campaign planning. One GRP = 1% of the target audience reached.',
    `target_impressions` BIGINT COMMENT 'Total number of ad impressions committed in this opportunity. Primary delivery metric for digital video, streaming, and programmatic deals. Measured in thousands or millions.',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'A qualified sales pursuit representing a potential advertising campaign, content licensing deal, syndication agreement, or distribution carriage negotiation. Tracks deal stage (prospecting, proposal, negotiation, closed-won, closed-lost), estimated deal value, deal type (upfront, scatter, direct, programmatic guaranteed, content license, syndication), target flight dates, assigned sales executive, probability of close, and competitive displacement notes. Sourced from Salesforce Media Cloud Opportunity object. The primary pipeline entity feeding revenue forecasting and upfront commitment tracking.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` (
    `proposal_line_id` BIGINT COMMENT 'Unique identifier for the proposal line item. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Each proposal line specifies inventory on a specific channel. Business process: line-item inventory allocation, channel-specific rate card application, audience delivery planning. Replaces denormalize',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Proposal lines specify daypart for inventory being offered. Business process: daypart-based pricing, audience targeting, GRP/impression estimation. Replaces denormalized daypart text field with proper',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Individual proposal lines in content licensing proposals specify which media assets are included in each license grant. This enables line-level asset availability checking, format specification matchi',
    `employee_id` BIGINT COMMENT 'Reference to the sales user who created this proposal line item.',
    `sales_product_id` BIGINT COMMENT 'Reference to the advertising product or content license offering being proposed in this line.',
    `rate_card_id` BIGINT COMMENT 'Reference to the rate card used as the basis for pricing this proposal line.',
    `sales_proposal_id` BIGINT COMMENT 'Reference to the parent sales proposal containing this line item.',
    `agency_commission_percentage` DECIMAL(18,2) COMMENT 'Percentage commission allocated to the advertising agency for this line item.',
    `audience_guarantee_flag` BOOLEAN COMMENT 'Indicates whether this line includes an audience delivery guarantee requiring makegoods if underdelivered.',
    `cpm` DECIMAL(18,2) COMMENT 'Cost per thousand impressions for this inventory line, a standard pricing metric in advertising.',
    `cprp` DECIMAL(18,2) COMMENT 'Cost per rating point for this line item, used in broadcast television pricing.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal line item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this line item.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute dollar amount of discount applied to this line item.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to this line item (e.g., volume discount, upfront commitment discount).',
    `flight_end_date` DATE COMMENT 'End date of the proposed campaign flight or license window for this line item.',
    `flight_start_date` DATE COMMENT 'Start date of the proposed campaign flight or license window for this line item.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross value of this proposal line before any discounts or adjustments.',
    `guaranteed_impressions` BIGINT COMMENT 'Minimum number of impressions guaranteed to be delivered for this line item if audience guarantee applies.',
    `inventory_type` STRING COMMENT 'Type of advertising or content inventory unit being offered in this proposal line. [ENUM-REF-CANDIDATE: linear_spot|digital_preroll|digital_midroll|sponsorship|program_integration|content_license|syndication_slot|vod_placement|fast_channel|display_banner — 10 candidates stripped; promote to reference product]',
    `line_description` STRING COMMENT 'Detailed description of the inventory offering, targeting, and special terms for this proposal line.',
    `line_number` STRING COMMENT 'Sequential line number within the proposal for ordering and reference purposes.',
    `line_status` STRING COMMENT 'Current status of this proposal line item in the sales negotiation lifecycle.. Valid values are `draft|proposed|negotiating|accepted|rejected|expired`',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether this line item is eligible for makegood spots if delivery guarantees are not met.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal line item record was last modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net value of this proposal line after discounts and before agency commission.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this proposal line item.',
    `platform` STRING COMMENT 'Distribution platform or channel where the inventory will be delivered. [ENUM-REF-CANDIDATE: linear_tv|ott|vod|svod|avod|fast|digital_web|mobile_app|social_media|podcast — 10 candidates stripped; promote to reference product]',
    `proposed_grp` DECIMAL(18,2) COMMENT 'Estimated Gross Rating Points to be delivered, representing the sum of ratings achieved by the schedule.',
    `proposed_impressions` BIGINT COMMENT 'Estimated number of impressions or views to be delivered for this line item.',
    `proposed_trp` DECIMAL(18,2) COMMENT 'Estimated Target Rating Points for the specific demographic audience being targeted.',
    `target_demographic` STRING COMMENT 'Audience demographic segment being targeted for this inventory (e.g., Adults 18-49, Women 25-54).',
    `unit_length_seconds` STRING COMMENT 'Duration of each advertising unit in seconds (e.g., 15, 30, 60 seconds for spots).',
    `unit_quantity` STRING COMMENT 'Number of advertising units or spots being proposed in this line (e.g., 30 spots, 5 sponsorships).',
    `unit_rate` DECIMAL(18,2) COMMENT 'Proposed rate per individual unit (e.g., cost per spot, cost per sponsorship).',
    CONSTRAINT pk_proposal_line PRIMARY KEY(`proposal_line_id`)
) COMMENT 'Individual line item within a sales proposal, representing a specific inventory unit being offered — a daypart block, a program sponsorship, a digital pre-roll package, a content license window, or a syndication slot. Captures unit type, platform, channel or property, daypart, audience demographic target, proposed impressions or GRPs, unit rate, CPM, total line value, and makegood eligibility flag. Enables granular negotiation at the inventory unit level before order commitment.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` (
    `upfront_commitment_id` BIGINT COMMENT 'Unique identifier for the upfront commitment record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser account that made this upfront commitment.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Upfront commitments are multi-million dollar contractual obligations with billing accounts. Accounts receivable forecasting, commitment fulfillment tracking, and option exercise billing require linkin',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Upfront commitments result from closed opportunities during the upfront sales cycle. This FK enables tracing commitments back to their originating opportunities. N:1 relationship. New attribute needed',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Upfront commitments represent multi-year revenue contracts requiring revenue stream mapping for recognition scheduling and deferred revenue tracking. Critical for upfront revenue recognition over flig',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser in this upfront deal.',
    `rep_id` BIGINT COMMENT 'FK to sales.rep',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Upfront commitments are the binding financial commitments resulting from upfront deal negotiations. This FK links the commitment back to the deal negotiation that produced it, tracking the progression',
    `adjusted_commitment_amount` DECIMAL(18,2) COMMENT 'The current binding commitment amount after all option exercises and cancellations have been applied. Calculated as total_committed_spend minus total_cancelled_amount.',
    `audience_guarantee_flag` BOOLEAN COMMENT 'Indicates whether the upfront commitment includes audience delivery guarantees based on ratings or impressions.',
    `cancellation_option_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total commitment that the advertiser has the option to cancel at defined option dates, typically 50%.',
    `commitment_date` DATE COMMENT 'The date when the upfront commitment was formally executed and became binding.',
    `commitment_number` STRING COMMENT 'Business identifier for the upfront commitment, used in sales and billing communications.',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the upfront commitment. [ENUM-REF-CANDIDATE: draft|pending_approval|confirmed|active|partially_fulfilled|fulfilled|cancelled|expired — 8 candidates stripped; promote to reference product]',
    `committed_grp_volume` DECIMAL(18,2) COMMENT 'The total GRP volume committed by the advertiser across the upfront period. GRP represents the sum of ratings achieved by the campaign.',
    `committed_impression_volume` BIGINT COMMENT 'The total number of impressions committed by the advertiser across the upfront period, typically used for digital and streaming platforms.',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the executed upfront contract document.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this upfront commitment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the committed spend amount.. Valid values are `^[A-Z]{3}$`',
    `daypart_allocation` STRING COMMENT 'The broadcast daypart segments allocated for this upfront commitment (e.g., Prime Time, Early Morning, Late Night). Multiple dayparts may be specified.',
    `delivered_spend_to_date` DECIMAL(18,2) COMMENT 'The cumulative dollar amount that has been delivered against this upfront commitment through actual ad orders and campaigns.',
    `digital_allocation_amount` DECIMAL(18,2) COMMENT 'The portion of the total committed spend allocated to digital platform inventory.',
    `effective_end_date` DATE COMMENT 'The date when the upfront commitment period ends, typically the end of the broadcast season.',
    `effective_start_date` DATE COMMENT 'The date when the upfront commitment period begins, typically the start of the broadcast season.',
    `first_option_date` DATE COMMENT 'The first date on which the advertiser may exercise their cancellation option.',
    `fulfillment_percentage` DECIMAL(18,2) COMMENT 'The percentage of the adjusted commitment that has been fulfilled through delivered spend. Calculated as (delivered_spend_to_date / adjusted_commitment_amount) * 100.',
    `guaranteed_cpm` DECIMAL(18,2) COMMENT 'The guaranteed CPM rate negotiated for this upfront commitment. CPM represents the cost per thousand impressions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this upfront commitment record was last modified.',
    `linear_allocation_amount` DECIMAL(18,2) COMMENT 'The portion of the total committed spend allocated to linear (traditional broadcast) television inventory.',
    `makegood_provision_flag` BOOLEAN COMMENT 'Indicates whether the upfront commitment includes provisions for makegood spots (compensatory ad spots) if delivery guarantees are not met.',
    `notes` STRING COMMENT 'Free-form notes and comments related to this upfront commitment, including special terms, conditions, or historical context.',
    `remaining_commitment_balance` DECIMAL(18,2) COMMENT 'The remaining dollar amount yet to be fulfilled against the adjusted commitment. Calculated as adjusted_commitment_amount minus delivered_spend_to_date.',
    `second_option_date` DATE COMMENT 'The second date on which the advertiser may exercise their cancellation option, if applicable.',
    `streaming_allocation_amount` DECIMAL(18,2) COMMENT 'The portion of the total committed spend allocated to streaming (OTT, SVOD, AVOD) platform inventory.',
    `target_demographic` STRING COMMENT 'The primary audience demographic segment targeted by this upfront commitment (e.g., Adults 18-49, Women 25-54).',
    `third_option_date` DATE COMMENT 'The third date on which the advertiser may exercise their cancellation option, if applicable.',
    `total_cancelled_amount` DECIMAL(18,2) COMMENT 'The cumulative dollar amount that has been cancelled by the advertiser across all option exercise events.',
    `total_committed_spend` DECIMAL(18,2) COMMENT 'The total dollar amount the advertiser or agency committed to spend during the upfront period.',
    `total_exercised_amount` DECIMAL(18,2) COMMENT 'The cumulative dollar amount that has been exercised (confirmed for delivery) across all option exercise events.',
    `upfront_year` STRING COMMENT 'The broadcast season year for this upfront commitment, typically formatted as YYYY-YYYY (e.g., 2024-2025).. Valid values are `^d{4}-d{4}$`',
    CONSTRAINT pk_upfront_commitment PRIMARY KEY(`upfront_commitment_id`)
) COMMENT 'A binding advance advertising sales commitment made during the annual upfront market, representing a guaranteed spend level from an advertiser or agency across a broadcast season. Captures upfront year, advertiser account, agency, total committed spend, committed GRP or impression volume, platform allocation (linear, digital, streaming), cancellation option windows (typically 50% cancellable at defined dates), option exercise history (exercise date, exercised amount, cancelled amount per window, cancellation reason), resulting adjusted commitment after each option date, and fulfillment tracking against actual delivered orders. The SSOT for upfront deal obligations feeding scatter market inventory availability calculations — cancelled options release inventory to the scatter pool.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`scatter_order` (
    `scatter_order_id` BIGINT COMMENT 'Primary key for scatter_order',
    `advertiser_id` BIGINT COMMENT 'add column sales_advertiser_id (BIGINT) with FK to sales.advertiser.advertiser_id - scatter orders are placed by advertisers and need direct linkage',
    `channel_id` BIGINT COMMENT 'add column scheduling_channel_id (BIGINT) with FK to scheduling.channel.channel_id - scatter orders target specific channels for ad placement',
    `upfront_commitment_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_commitment. Business justification: Scatter orders may convert from or reference upfront commitments when buyers exercise scatter conversion rights (upfront_deal.scatter_conversion_rights field). Nullable FK as most scatter orders are s',
    CONSTRAINT pk_scatter_order PRIMARY KEY(`scatter_order_id`)
) COMMENT 'A short-term advertising inventory purchase made in the scatter market outside of upfront commitments, typically placed weeks or days before air date. Captures order date, advertiser, agency, campaign flight dates, inventory type, platform, daypart, requested impressions or GRPs, negotiated CPM, total order value, priority level, preemption risk flag, and fulfillment status. Scatter orders are priced at prevailing market rates (typically at a premium to upfront) and are subject to preemption by higher-rated inventory. Feeds Wide Orbit traffic scheduling.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` (
    `ad_sales_order_id` BIGINT COMMENT 'Unique identifier for the advertising sales order. Primary key for this entity.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser who is purchasing the advertising inventory under this order.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Ad orders must specify the licensed station for regulatory compliance, political ad disclosure requirements, public inspection file inclusion, and FCC reporting. Core operational requirement for broad',
    `campaign_id` BIGINT COMMENT 'Reference to the advertising campaign that this order is fulfilling.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Orders specify primary channel for spot placement. Business process: order entry, inventory reservation, channel-level revenue tracking. Supports multi-channel orders at line level while tracking prim',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Orders must be booked to the correct legal entity for revenue recognition, tax compliance, and statutory reporting. Essential for order-to-cash legal entity routing, VAT/sales tax calculation, and ent',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Ad sales orders are the result of closed/won opportunities. This FK is critical for sales pipeline traceability and win/loss analysis. N:1 relationship (one opportunity leads to one order). New attrib',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Ad sales orders must map to revenue streams for ASC 606/IFRS 15 compliance. Different deal types (upfront, scatter, programmatic) have distinct recognition rules. Essential for revenue recognition aut',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser and managing the media buy on their behalf.',
    `sales_proposal_id` BIGINT COMMENT 'Foreign key linking to sales.sales_proposal. Business justification: Ad sales orders are executed based on accepted proposals. This FK enables tracing orders back to the proposal that was accepted. N:1 relationship (one proposal leads to one order). New attribute neede',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative who closed this advertising order and is responsible for account management.',
    `upfront_commitment_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_commitment. Business justification: Ad sales orders are often drawn down from upfront commitments. This FK links the executed order back to the advance commitment that funded it. Nullable because not all ad sales orders come from upfron',
    `affidavit_required` BOOLEAN COMMENT 'Indicates whether proof-of-broadcast affidavits are required for this order to verify that ads were delivered as contracted.',
    `approval_timestamp` TIMESTAMP COMMENT 'The timestamp when this advertising sales order was approved and authorized for trafficking and fulfillment.',
    `approved_by` STRING COMMENT 'The name or identifier of the manager or executive who approved this advertising sales order.',
    `billing_contact_email` STRING COMMENT 'The email address of the billing contact for invoice delivery and payment communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'The name of the primary billing contact at the advertiser or agency responsible for payment processing.',
    `cancellation_terms` STRING COMMENT 'The contractual terms and conditions under which the advertiser or broadcaster may cancel the order, including notice periods and penalties.',
    `commission_rate` DECIMAL(18,2) COMMENT 'The commission rate percentage applied to this order for sales representative compensation.',
    `contract_signed_date` DATE COMMENT 'The date when the advertising sales contract was executed and signed by both parties.',
    `contracted_cpm` DECIMAL(18,2) COMMENT 'The contracted cost per thousand impressions agreed upon for this advertising order.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order value and financial terms.. Valid values are `^[A-Z]{3}$`',
    `daypart_mix` STRING COMMENT 'Description of the distribution of ad spots across broadcast dayparts such as prime time, daytime, late night, and early morning.',
    `deal_type` STRING COMMENT 'The type of advertising sales deal. Upfront represents advance commitments during upfront sales events, scatter represents last-minute inventory purchases, direct represents direct advertiser buys, and programmatic_guaranteed represents automated guaranteed deals.. Valid values are `upfront|scatter|direct|programmatic_guaranteed`',
    `flight_end_date` DATE COMMENT 'The date when the advertising campaign flight ends and ad delivery concludes.',
    `flight_start_date` DATE COMMENT 'The date when the advertising campaign flight begins and ad delivery commences.',
    `grp_guarantee` DECIMAL(18,2) COMMENT 'The guaranteed Gross Rating Points committed to the advertiser, representing the total percentage of the target audience reached multiplied by frequency.',
    `impression_guarantee` BIGINT COMMENT 'The total number of impressions guaranteed to be delivered under this advertising order.',
    `isci_codes` STRING COMMENT 'Comma-separated list of ISCI codes identifying the creative assets approved for use in this advertising order.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this order record was last updated or modified.',
    `makegood_provisions` STRING COMMENT 'The contractual provisions defining how compensatory ad spots will be provided if the broadcaster fails to deliver the guaranteed audience or impressions.',
    `order_date` DATE COMMENT 'The date when the advertising sales order was placed and confirmed by the advertiser or agency.',
    `order_notes` STRING COMMENT 'Free-text notes and comments related to this advertising order, capturing special instructions, client requests, or operational considerations.',
    `order_number` STRING COMMENT 'The externally-known business identifier for this advertising sales order, used for client communication and billing reference.',
    `order_status` STRING COMMENT 'Current lifecycle status of the advertising sales order in the fulfillment workflow.. Valid values are `confirmed|in_flight|completed|cancelled|preempted`',
    `payment_terms` STRING COMMENT 'The contractual payment terms defining when payment is due, such as net 30, net 60, or payment upon delivery.',
    `platform_mix` STRING COMMENT 'Description of the distribution of advertising inventory across platforms such as linear TV, OTT, digital, mobile, and social channels.',
    `political_ad_flag` BOOLEAN COMMENT 'Indicates whether this order contains political advertising content, which requires special disclosure and compliance tracking per FCC regulations.',
    `preemption_risk_level` STRING COMMENT 'The level of risk that this order may be preempted by higher-priority advertising inventory. Non-preemptible orders have guaranteed placement, while high-risk orders may be bumped for premium advertisers.. Valid values are `non_preemptible|low|medium|high`',
    `priority_class` STRING COMMENT 'The priority classification of this order in the ad scheduling and trafficking system, determining placement precedence during inventory conflicts.',
    `target_audience` STRING COMMENT 'Description of the demographic and psychographic target audience for this advertising order, used for audience measurement and guarantee validation.',
    `total_order_value` DECIMAL(18,2) COMMENT 'The total contracted monetary value of the advertising sales order across all line items and flights.',
    CONSTRAINT pk_ad_sales_order PRIMARY KEY(`ad_sales_order_id`)
) COMMENT 'The executed and confirmed advertising sales order representing a binding commercial agreement to deliver a specific advertising campaign across defined inventory. Encompasses all order types including upfront fulfillment orders, scatter market purchases, direct buys, and programmatic guaranteed deals. Captures order number, deal type (upfront, scatter, direct, programmatic_guaranteed), advertiser, agency, campaign name, total order value, contracted CPM, GRP or impression guarantee, platform mix, flight start and end dates, cancellation terms, makegood provisions, preemption risk level, priority class, affidavit requirements, ISCI codes for creative, and order status (confirmed, in-flight, completed, cancelled, preempted). This is the primary handoff entity from sales to advertising trafficking in Wide Orbit.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` (
    `order_line_id` BIGINT COMMENT 'Unique identifier for the order line item. Primary key for the order line entity.',
    `ad_order_id` BIGINT COMMENT 'Reference to the parent ad sales order that contains this line item. Links to the ad_order entity.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Individual spot placements must be tied to specific broadcast licenses for regulatory reporting, affidavit generation, political ad tracking, and compliance verification. Direct operational requiremen',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Each order line specifies the channel for spot placement. Business process: trafficking, playout scheduling, channel-level delivery tracking. Replaces denormalized channel_name text field with proper ',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Order lines specify daypart for purchased inventory. Business process: order fulfillment, daypart delivery tracking, makegood allocation. Replaces denormalized daypart text field with proper FK.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Order lines (individual spots/units) are billed as invoice lines. Spot-level delivery reconciliation, makegood tracking, affidavit verification, and billing dispute resolution require direct linkage f',
    `proposal_line_id` BIGINT COMMENT 'Foreign key linking to sales.proposal_line. Business justification: Order lines are the executed versions of proposal lines. This FK enables tracing order line execution back to the original proposal line. N:1 relationship (one proposal line can lead to multiple order',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Order lines may have different revenue recognition treatments (guaranteed vs. preemptible, linear vs. digital). Required for line-level revenue recognition, performance obligation tracking, and makego',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Confirmed order lines map to specific schedule slots for playout. Business process: traffic-to-playout handoff, as-run reconciliation, affidavit generation, delivery verification against contracted im',
    `actual_grp_delivered` DECIMAL(18,2) COMMENT 'Actual GRP delivered for this line item. Used to compare against contracted GRP for linear TV performance tracking.',
    `actual_impressions_delivered` BIGINT COMMENT 'Actual number of impressions delivered for this line item. Used to compare against contracted impressions for performance tracking.',
    `air_date` DATE COMMENT 'Specific date when the ad unit is scheduled to air or be delivered. For single-spot placements.',
    `air_end_date` DATE COMMENT 'End date of the flight period for this ad unit. Defines the conclusion of the campaign window.',
    `air_start_date` DATE COMMENT 'Start date of the flight period for this ad unit. Used for campaigns spanning multiple days or weeks.',
    `contracted_grp` DECIMAL(18,2) COMMENT 'Gross Rating Points contracted for this line item. Represents the total audience reach multiplied by frequency, used for linear TV buys.',
    `contracted_impressions` BIGINT COMMENT 'Number of impressions (ad views) contracted for this line item. Used primarily for digital and OTT placements with impression-based guarantees.',
    `contracted_trp` DECIMAL(18,2) COMMENT 'Target Rating Points contracted for this line item. Similar to GRP but focused on a specific target demographic audience.',
    `cpm` DECIMAL(18,2) COMMENT 'Cost per thousand impressions for this line item. Standard digital advertising pricing metric.',
    `cprp` DECIMAL(18,2) COMMENT 'Cost per rating point for this line item. Standard linear TV pricing metric calculated as total cost divided by GRP or TRP.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was first created in the system.',
    `creative_title` STRING COMMENT 'Title or name of the creative asset (commercial, video ad) that will be played for this line item.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line item pricing (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `dai_enabled_flag` BOOLEAN COMMENT 'Indicates whether this line item uses Dynamic Ad Insertion technology for personalized, server-side ad stitching in streaming content.',
    `delivery_status` STRING COMMENT 'Current delivery status of the line item: scheduled, in progress, delivered, under-delivered, over-delivered, cancelled, or makegood issued. [ENUM-REF-CANDIDATE: scheduled|in_progress|delivered|under_delivered|over_delivered|cancelled|makegood_issued — 7 candidates stripped; promote to reference product]',
    `geographic_market` STRING COMMENT 'Geographic market or Designated Market Area (DMA) where this line item will be delivered. Used for local vs national buys.',
    `guaranteed_flag` BOOLEAN COMMENT 'Indicates whether this line item has a guaranteed delivery commitment (impressions, GRPs, or placement) versus best-effort delivery.',
    `isci_code` STRING COMMENT 'Industry Standard Commercial Identification code for the creative asset associated with this line item. Used for trafficking and affidavit verification.. Valid values are `^[A-Z0-9]{4}[A-Z0-9]{4}[HMV]$`',
    `line_number` STRING COMMENT 'Sequential line number within the parent order, used for ordering and referencing specific line items in the order.',
    `line_status` STRING COMMENT 'Current lifecycle status of the order line: draft, confirmed, trafficked (sent to playout), aired, invoiced, cancelled, or on hold. [ENUM-REF-CANDIDATE: draft|confirmed|trafficked|aired|invoiced|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total revenue value for this order line item. Calculated as unit rate multiplied by quantity or contracted impressions/GRPs.',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether this line item is eligible for makegood spots (compensatory ad placements) if delivery targets are not met.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was last modified or updated.',
    `notes` STRING COMMENT 'Free-form notes or special instructions for this order line item. May include trafficking instructions, creative specifications, or delivery requirements.',
    `platform` STRING COMMENT 'Platform or channel where the ad unit will be delivered: linear TV, OTT (Over-The-Top), VOD (Video On Demand), SVOD, AVOD, FAST, digital web, mobile app, social media, or podcast. [ENUM-REF-CANDIDATE: linear_tv|ott|vod|svod|avod|tvod|fast|digital_web|mobile_app|social|podcast — 11 candidates stripped; promote to reference product]',
    `product_category` STRING COMMENT 'Product or service category being advertised (e.g., automotive, financial services, consumer packaged goods). Used for competitive separation and content adjacency rules.',
    `program_title` STRING COMMENT 'Title of the specific program, show, or content where the ad unit is scheduled to appear.',
    `programmatic_flag` BOOLEAN COMMENT 'Indicates whether this line item was sold through programmatic advertising channels (automated bidding and buying).',
    `sales_type` STRING COMMENT 'Type of sales transaction: upfront (advance commitment), scatter (last-minute inventory), direct, programmatic, sponsorship, or barter.. Valid values are `upfront|scatter|direct|programmatic|sponsorship|barter`',
    `spot_length_seconds` STRING COMMENT 'Duration of the ad spot in seconds (e.g., 15, 30, 60). Standard commercial lengths used for pricing and scheduling.',
    `target_demographic` STRING COMMENT 'Target audience demographic for this line item (e.g., Adults 18-49, Women 25-54). Used for audience guarantee and measurement.',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate charged per individual ad unit (per spot, per impression block, per sponsorship). The base pricing for this line item.',
    `unit_type` STRING COMMENT 'Type of advertising unit being sold: a 30-second spot, digital pre-roll, sponsorship billboard, branded content integration, or other ad format. [ENUM-REF-CANDIDATE: spot|pre_roll|mid_roll|post_roll|sponsorship|billboard|branded_content|overlay|companion_banner|native_ad — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_order_line PRIMARY KEY(`order_line_id`)
) COMMENT 'Individual line item within a confirmed ad sales order, representing a specific ad placement unit — a 30-second spot in a named program, a digital pre-roll unit, a sponsorship billboard, or a branded content integration. Captures line number, unit type, platform, channel, program or content title, daypart, air date or date range, spot length, contracted impressions or GRPs, unit rate, CPM, line total value, creative ISCI code, DAI flag, and delivery status. The granular unit of trafficking instruction passed to Wide Orbit for scheduling and playout.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` (
    `content_license_deal_id` BIGINT COMMENT 'Unique identifier for the content license deal. Primary key for this entity.',
    `broadcast_standard_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_standard. Business justification: Content license agreements specify technical delivery requirements (ATSC 3.0, DVB-T2, ISDB-T) that licensees must support. Essential for contract compliance verification, content mastering specificati',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: License deals may grant rights to air content on specific channels. Business process: rights clearance verification, channel programming strategy, license fee allocation by channel.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: License deals are executed by specific legal entities (often different from operating entity) for IP ownership and tax optimization. Required for licensing entity determination, withholding tax calcul',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Content licensing deals must reference content ratings for territory restrictions, platform rights compliance (TVOD/SVOD age gates), parental control requirements, and regulatory obligations. Essentia',
    `content_library_id` BIGINT COMMENT 'Reference to a content library or collection being licensed. May be null if the deal covers a single title rather than a library.',
    `title_id` BIGINT COMMENT 'Reference to the specific content title or program being licensed. May be null if the deal covers a library or collection rather than a single title.',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or account manager responsible for negotiating and managing this content license deal.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Content license deals are negotiated with content owners/licensors who are formal partners (studios, production companies, distributors). Critical for tracking licensor relationships, managing royalty',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Content license deals directly license specific media assets (films, series episodes, specials) to distribution partners. This link is essential for rights management, delivery fulfillment, asset acce',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Content license deals result from closed opportunities. This FK enables tracing license deals back to their originating opportunities. N:1 relationship. New attribute needed for pipeline traceability.',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Content license deals must reference the master production project for series-level licensing (multi-season packages, format rights, remake rights), rights clearance verification, delivery obligation ',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: License deals have complex revenue recognition (minimum guarantees, revenue shares, holdbacks) requiring specific revenue stream mapping. Critical for licensing revenue recognition, deferred revenue c',
    `sales_account_id` BIGINT COMMENT 'Reference to the third-party broadcaster, streaming platform, Multichannel Video Programming Distributor (MVPD), or international distributor acquiring the content license.',
    `sales_agency_id` BIGINT COMMENT 'Foreign key linking to sales.sales_agency. Business justification: Content licensing deals may involve agencies representing the licensee. This FK tracks agency involvement in content licensing transactions. Nullable because many content deals are direct (no agency i',
    `sales_team_id` BIGINT COMMENT 'Reference to the sales team or business unit responsible for this content license deal.',
    `approval_date` DATE COMMENT 'The date when the deal received final internal approval to proceed to execution.',
    `commission_eligible_flag` BOOLEAN COMMENT 'Indicates whether this deal is eligible for sales commission calculation and payout.',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'The commission rate percentage applicable to this deal for sales compensation purposes.',
    `contract_document_url` STRING COMMENT 'Reference URL or file path to the executed contract document or agreement for this content license deal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this content license deal record was first created in the system.',
    `deal_name` STRING COMMENT 'Business-friendly name or title assigned to this content license deal for identification and reference purposes.',
    `deal_number` STRING COMMENT 'Externally-known unique business identifier or contract number for this content license deal, used for tracking and reference across systems.',
    `deal_status` STRING COMMENT 'Current lifecycle status of the content license deal, tracking its progression from initial negotiation through execution and eventual closure. [ENUM-REF-CANDIDATE: draft|negotiation|pending_approval|approved|executed|active|expired|terminated|cancelled — 9 candidates stripped; promote to reference product]',
    `deal_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the license deal, representing the expected or guaranteed revenue from this agreement.',
    `deal_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the deal value amount.. Valid values are `^[A-Z]{3}$`',
    `eidr_identifier` STRING COMMENT 'Entertainment Identifier Registry (EIDR) unique identifier for the content covered by this license deal, used for global content identification.',
    `executed_date` DATE COMMENT 'The date when the contract was formally executed and signed by all parties, making it legally binding.',
    `holdback_restrictions` STRING COMMENT 'Description of any holdback periods or exclusivity restrictions that limit when or how the content can be exploited, including blackout periods or sequential windowing requirements.',
    `isan_identifier` STRING COMMENT 'International Standard Audiovisual Number (ISAN) uniquely identifying the audiovisual content covered by this license deal.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this content license deal record was most recently updated or modified.',
    `license_end_date` DATE COMMENT 'The date when the license period expires and the licensee must cease exploitation of the content.',
    `license_fee_structure` STRING COMMENT 'The pricing model or fee structure governing how the licensee compensates the licensor for the content rights.. Valid values are `flat_fee|per_episode|revenue_share|minimum_guarantee_plus_revenue_share|tiered`',
    `license_start_date` DATE COMMENT 'The date when the license period begins and the licensee is granted rights to exploit the content.',
    `license_type` STRING COMMENT 'Classification of the licensing arrangement indicating the exclusivity and rights structure of the deal.. Valid values are `exclusive|non-exclusive|sub-license|co-exclusive`',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount that the licensee commits to pay regardless of actual usage or revenue performance. Applicable for revenue share deals with minimum guarantees.',
    `notes` STRING COMMENT 'Free-form notes or comments capturing additional context, special terms, or important details about this content license deal.',
    `payment_schedule` STRING COMMENT 'Description of the payment terms and schedule, including milestones, installments, or recurring payment frequency for the license fees.',
    `platform_rights_avod` BOOLEAN COMMENT 'Indicates whether the license grants rights for Advertising-Supported Video On Demand (AVOD) distribution.',
    `platform_rights_fast` BOOLEAN COMMENT 'Indicates whether the license grants rights for Free Ad-Supported Streaming Television (FAST) channels.',
    `platform_rights_linear` BOOLEAN COMMENT 'Indicates whether the license grants rights for traditional scheduled linear broadcasting.',
    `platform_rights_svod` BOOLEAN COMMENT 'Indicates whether the license grants rights for Subscription Video On Demand (SVOD) distribution.',
    `platform_rights_tvod` BOOLEAN COMMENT 'Indicates whether the license grants rights for Transactional Video On Demand (TVOD) distribution.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the licensee has an option to renew the license upon expiration.',
    `renewal_terms` STRING COMMENT 'Description of the renewal terms and conditions if a renewal option exists, including pricing adjustments and notification requirements.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue that the licensee will share with the licensor, applicable for revenue share fee structures.',
    `termination_clause` STRING COMMENT 'Description of the conditions and procedures under which either party may terminate the license agreement prior to the natural expiration date.',
    `territory` STRING COMMENT 'Geographic territory or territories where the licensee is granted rights to distribute or broadcast the content. May include country codes, regions, or worldwide designation.',
    CONSTRAINT pk_content_license_deal PRIMARY KEY(`content_license_deal_id`)
) COMMENT 'A negotiated agreement to license specific content titles or libraries to third-party broadcasters, streaming platforms, MVPDs, or international distributors. Captures deal name, licensee account, content title or library scope, license type (exclusive, non-exclusive, sub-license), territory, platform rights granted (linear, SVOD, AVOD, TVOD, FAST), license fee structure (flat, per-episode, revenue share), deal value, payment schedule, holdback restrictions, ISAN or EIDR content identifiers, and deal status. Owned by sales as the commercial negotiation record; rights domain owns the resulting rights windows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` (
    `sales_syndication_deal_id` BIGINT COMMENT 'Unique identifier for the syndication deal record. Primary key for the sales syndication deal entity.',
    `package_id` BIGINT COMMENT 'Reference to the content package (series, strip, specials, or program bundle) being syndicated under this deal.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Syndication deals result from closed opportunities. This FK enables tracing syndication deals back to their originating opportunities. N:1 relationship. New attribute needed for pipeline traceability.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this syndication deal record.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Syndication deals with barter splits and cash components require revenue stream mapping for proper accounting treatment. Enables barter revenue recognition and syndication revenue reporting in media o',
    `sales_account_id` BIGINT COMMENT 'Reference to the syndicator, station group, or distributor account that is the counterparty to this syndication deal.',
    `sales_agency_id` BIGINT COMMENT 'Foreign key linking to sales.sales_agency. Business justification: Syndication deals may involve agencies representing station groups or syndicators. This FK tracks agency involvement in syndication transactions. Nullable because many syndication deals are direct.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account executive responsible for negotiating and managing this syndication deal.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Syndication deals license specific program assets to local stations/broadcasters. While content_package_id references the editorial package, syndication_media_asset_id links to the actual broadcast ma',
    `barter_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of advertising inventory retained by the syndicator versus sold by the station. For example, 70/30 split means syndicator retains 70% of ad inventory and station sells 30%. Null for pure cash deals.',
    `cash_license_fee_amount` DECIMAL(18,2) COMMENT 'Total cash license fee paid by the station or station group to the syndicator for the content rights over the deal term. Null for pure barter deals.',
    `clearance_percentage_target` DECIMAL(18,2) COMMENT 'Target percentage of U.S. television households or market coverage that must be achieved for the syndication deal to be considered successful. Clearance is the percentage of the national audience that has access to the syndicated program.',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of the deal value paid as commission to the sales representative or sales team.',
    `contract_document_url` STRING COMMENT 'URL or file path to the executed syndication contract document stored in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this syndication deal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this syndication deal.. Valid values are `USD|CAD|GBP|EUR|AUD`',
    `daypart_restriction` STRING COMMENT 'Time-of-day restrictions for when the syndicated content may be broadcast. Dayparts are segments of the broadcast day such as early morning, daytime, early fringe, prime access, prime time, late fringe, and overnight.',
    `deal_name` STRING COMMENT 'Human-readable name of the syndication deal, typically including the content title and syndicator or station group name.',
    `deal_number` STRING COMMENT 'Externally-known business identifier for the syndication deal, used in contracts and communications with syndicators and station groups.',
    `deal_status` STRING COMMENT 'Current lifecycle status of the syndication deal. Draft: initial creation. Proposed: submitted to counterparty. Negotiation: terms being discussed. Approved: internally approved, awaiting execution. Active: contract executed and in effect. Suspended: temporarily paused. Terminated: ended before expiration. Expired: reached natural end date. [ENUM-REF-CANDIDATE: draft|proposed|negotiation|approved|active|suspended|terminated|expired — 8 candidates stripped; promote to reference product]',
    `deal_term_months` STRING COMMENT 'Duration of the syndication deal in months, representing the period during which the content may be broadcast under the agreed terms.',
    `effective_end_date` DATE COMMENT 'Date when the syndication deal expires and the content rights are no longer available for broadcast under this agreement.',
    `effective_start_date` DATE COMMENT 'Date when the syndication deal becomes active and the content rights become available for broadcast.',
    `episode_count` STRING COMMENT 'Total number of episodes or program units included in the syndication package.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the syndication deal grants exclusive broadcast rights within the specified territory. True means no other station in the territory may air the content during the deal term.',
    `holdback_period_days` STRING COMMENT 'Number of days after original network broadcast before the content becomes available for syndication. Holdback is an exclusivity period that protects the original broadcaster.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this syndication deal record was most recently updated.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special terms, or internal comments about the syndication deal.',
    `payment_schedule` STRING COMMENT 'Schedule for cash license fee payments. Upfront: full payment at deal execution. Monthly/Quarterly/Annual: periodic installments. Upon-delivery: payment when content is delivered. Milestone-based: payments tied to specific events.. Valid values are `upfront|monthly|quarterly|annual|upon-delivery|milestone-based`',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the syndication deal includes an option for the station or station group to renew the content rights for an additional term.',
    `renewal_terms` STRING COMMENT 'Description of the renewal option terms, including renewal period, pricing adjustments, and notice requirements.',
    `runs_per_episode` STRING COMMENT 'Number of times each episode may be broadcast during the deal term. Common values are 2, 4, 6, or unlimited.',
    `station_count` STRING COMMENT 'Number of broadcast stations or outlets that have committed to air the syndicated content under this deal.',
    `syndication_type` STRING COMMENT 'Classification of the syndication deal structure. First-run: original content produced for syndication. Off-network: previously aired network content. Barter: compensation via ad inventory. Cash-plus-barter: hybrid of cash license fee and ad inventory. Cash: pure license fee with no barter component.. Valid values are `first-run|off-network|barter|cash-plus-barter|cash`',
    `territory` STRING COMMENT 'Geographic territory covered by the syndication deal, typically defined by Designated Market Areas (DMAs), regions, or countries where the content may be broadcast.',
    CONSTRAINT pk_sales_syndication_deal PRIMARY KEY(`sales_syndication_deal_id`)
) COMMENT 'A commercial agreement to distribute and resell content programming to multiple broadcast stations, cable networks, or digital outlets through syndication. Captures syndication deal name, syndicator or station group account, content package (series, strip, specials), syndication type (first-run, off-network, barter, cash-plus-barter), barter split (percentage of ad inventory retained vs. sold), cash license fee, territory, clearance percentage target, station count, deal term, and status. Distinct from content_license_deal in that syndication involves barter inventory and multi-station clearance mechanics.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` (
    `carriage_deal_id` BIGINT COMMENT 'Unique identifier for the carriage deal. Primary key for this entity.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Carriage agreements are license-specific - distribution partners carry specific licensed stations. Must-carry designation and retransmission consent are license-level FCC regulatory concepts requiring',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Carriage deals specify which channel is being carried by the distributor. Business process: channel distribution, carriage fee calculation, retransmission consent tracking. Replaces denormalized chann',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Carriage agreements are legal contracts executed by specific broadcast license-holding entities. Required for FCC compliance reporting and retransmission consent legal entity tracking in media broadca',
    `distribution_partner_id` BIGINT COMMENT 'Reference to the MVPD, vMVPD, cable, or satellite operator account that is party to this carriage agreement.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Carriage deals result from closed opportunities. This FK enables tracing carriage deals back to their originating opportunities. N:1 relationship. New attribute needed for pipeline traceability.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Carriage agreements specify the origination facility for signal delivery to distribution partners. Required for signal handoff coordination, technical specifications, SLA monitoring, and operational e',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Carriage fees are recurring subscription-like revenue requiring specific revenue stream treatment for recognition and forecasting. Essential for carriage fee revenue recognition and subscriber-based r',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Carriage deals are commercial agreements with MVPDs/operators. While carriage_deal.partner_id links to distribution.distribution_partner (technical/operational), this FK links to sales_account for the',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Carriage deals are negotiated by sales reps and should be attributed to them for performance tracking and commission calculation. This FK enables rep attribution for carriage deals. N:1 relationship. ',
    `advertising_revenue_share_pct` DECIMAL(18,2) COMMENT 'Percentage of advertising revenue generated on the carried channel(s) that is shared with the operator, if applicable.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the carriage agreement automatically renews for successive terms unless either party provides notice of termination.',
    `billing_frequency` STRING COMMENT 'Frequency at which carriage fees are invoiced to the operator: monthly (standard), quarterly, or annually.. Valid values are `monthly|quarterly|annually`',
    `blackout_zone_restrictions` STRING COMMENT 'Geographic regions or designated market areas (DMAs) where content must be blacked out due to territorial rights restrictions or sports blackout rules.',
    `carriage_fee_per_subscriber` DECIMAL(18,2) COMMENT 'Monthly fee paid by the operator per subscriber for carriage of the channel(s). Core revenue metric for retransmission consent and negotiated carriage deals.',
    `carriage_status` STRING COMMENT 'Current lifecycle state of the carriage agreement: draft (initial proposal), negotiation (under discussion), executed (signed but not yet effective), active (currently in force), suspended (temporarily paused), expired (term ended), terminated (cancelled before term end), or renewed (extended for additional term). [ENUM-REF-CANDIDATE: draft|negotiation|executed|active|suspended|expired|terminated|renewed — 8 candidates stripped; promote to reference product]',
    `channel_position_number` STRING COMMENT 'Specific channel number or position assigned by the operator in their electronic program guide (EPG) and channel lineup.',
    `contract_term_months` STRING COMMENT 'Duration of the carriage agreement in months, from effective start to end date.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carriage deal record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this carriage agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deal_name` STRING COMMENT 'Human-readable name or title for this carriage agreement, typically including operator and channel lineup.',
    `deal_number` STRING COMMENT 'Externally-known business identifier for this carriage agreement, used in contracts and invoicing.',
    `deal_type` STRING COMMENT 'Classification of the carriage agreement structure: must-carry (mandatory channel inclusion per FCC rules), retransmission consent (negotiated fee-based carriage), negotiated carriage (standard commercial agreement), wholesale distribution (bulk channel package), or direct-to-consumer (OTT platform carriage).. Valid values are `must_carry|retransmission_consent|negotiated_carriage|wholesale_distribution|direct_to_consumer`',
    `dispute_resolution_method` STRING COMMENT 'Agreed-upon method for resolving disputes arising from the carriage agreement: negotiation, mediation, arbitration, or litigation.. Valid values are `negotiation|mediation|arbitration|litigation`',
    `effective_end_date` DATE COMMENT 'Date when the carriage agreement term expires. Nullable for open-ended or evergreen agreements.',
    `effective_start_date` DATE COMMENT 'Date when the carriage agreement becomes binding and channel delivery obligations commence.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law specified in the carriage agreement (e.g., State of New York, England and Wales).',
    `hd_tier_flag` BOOLEAN COMMENT 'Indicates whether the channel(s) are carried in the operators high-definition tier.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carriage deal record was last updated in the system.',
    `minimum_subscriber_guarantee` STRING COMMENT 'Minimum number of subscribers the operator guarantees for billing purposes, regardless of actual subscriber count. Used to establish revenue floor.',
    `most_favored_nation_clause` BOOLEAN COMMENT 'Indicates whether the agreement includes a most-favored-nation clause guaranteeing the operator receives terms no less favorable than those offered to other operators.',
    `must_carry_designation` BOOLEAN COMMENT 'Indicates whether this carriage is mandated under FCC must-carry rules, requiring cable operators to carry local broadcast stations without compensation.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or operational notes related to this carriage agreement.',
    `payment_terms_net_days` STRING COMMENT 'Number of days from invoice date within which the operator must remit carriage fee payment (e.g., Net 30, Net 60).',
    `performance_guarantee_sla` STRING COMMENT 'Service level agreement terms specifying uptime, signal quality, and technical performance guarantees for channel delivery.',
    `renewal_option_date` DATE COMMENT 'Date by which either party must exercise renewal option or provide notice of non-renewal.',
    `retransmission_consent_designation` BOOLEAN COMMENT 'Indicates whether this carriage is governed by retransmission consent rules, allowing broadcasters to negotiate compensation for signal rebroadcast.',
    `retransmission_consent_fee` DECIMAL(18,2) COMMENT 'Specific fee negotiated under retransmission consent rules for rebroadcast authorization of over-the-air signals. May be same as or distinct from general carriage fee.',
    `sd_tier_flag` BOOLEAN COMMENT 'Indicates whether the channel(s) are carried in the operators standard-definition tier.',
    `signed_date` DATE COMMENT 'Date when the carriage agreement was executed by all parties.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the carriage agreement.',
    `tier_placement` STRING COMMENT 'Operator service tier in which the channel(s) are placed: basic (lowest tier), expanded basic, digital, premium, or specialized tiers (sports, news, entertainment), or a-la-carte (individual channel purchase). [ENUM-REF-CANDIDATE: basic|expanded_basic|digital|premium|sports|news|entertainment|a_la_carte — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_carriage_deal PRIMARY KEY(`carriage_deal_id`)
) COMMENT 'A commercial agreement with an MVPD, vMVPD, or cable/satellite operator for the carriage of one or more broadcast channels or streaming services. Captures operator account, channel lineup, carriage fee per subscriber per month, must-carry vs. retransmission consent designation, retransmission consent fee, blackout zone restrictions, HD/SD tier, minimum subscriber guarantee, deal term, renewal option dates, and carriage status. Feeds billing domain for monthly carriage fee invoicing and distribution domain for channel delivery obligations.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` (
    `agency_commission_id` BIGINT COMMENT 'Unique identifier for the agency commission record. Primary key.',
    `ad_order_id` BIGINT COMMENT 'Reference to the advertising order for which this commission was earned. Links to the ad order transaction.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Agency commissions are calculated on invoiced amounts and may be invoiced separately to agencies. Commission reconciliation, agency payment processing, and commission expense tracking require direct l',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency that earned this commission. Links to the agency master record in the advertising domain.',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Agency commissions should be tied to the sales rep who closed the deal for proper commission tracking and rep performance analysis. This FK enables rep-level commission tracking. N:1 relationship. New',
    `applicable_deal_types` STRING COMMENT 'Comma-separated list of deal types to which this commission structure applies (e.g., upfront, scatter, sponsorship, programmatic). Empty indicates all deal types are eligible.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the commission for payment. Required for audit compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the commission was approved for payment. Null if not yet approved.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the commission amount was calculated by the system. Used for audit trail and version control.',
    `commission_amount` DECIMAL(18,2) COMMENT 'The total commission amount earned by the agency for this order, calculated based on commission rate and basis. Expressed in the transaction currency.',
    `commission_basis` STRING COMMENT 'The financial basis on which the commission is calculated. Gross billings includes all charges before discounts; net billings deducts agency commission; net net deducts both agency commission and cash discount; revenue recognized uses the accounting revenue figure.. Valid values are `gross_billings|net_billings|net_net|revenue_recognized`',
    `commission_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to calculate the commission. Expressed as a decimal (e.g., 0.1500 for 15%). Null when commission_type is flat_fee.',
    `commission_status` STRING COMMENT 'Current lifecycle status of the commission record. Pending indicates awaiting calculation; calculated means amount determined but not approved; approved is ready for payment; paid indicates payment completed; disputed flags reconciliation issues; reversed indicates a reversal transaction; cancelled means the commission was voided. [ENUM-REF-CANDIDATE: pending|calculated|approved|paid|disputed|reversed|cancelled — 7 candidates stripped; promote to reference product]',
    `commission_structure_code` STRING COMMENT 'Business identifier for the commission structure applied to this record. Used for reporting and reconciliation across systems.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `commission_type` STRING COMMENT 'Classification of the commission structure. Standard represents the typical 15% agency commission; negotiated indicates custom rates; tiered applies different rates based on volume; performance-based ties commission to campaign outcomes; flat fee is a fixed amount; hybrid combines multiple methods.. Valid values are `standard|negotiated|tiered|performance_based|flat_fee|hybrid`',
    `contract_reference` STRING COMMENT 'Reference to the agency contract or master service agreement that governs this commission structure. Used to link commission records to contractual terms.',
    `cost_center` STRING COMMENT 'The cost center responsible for this commission expense. Used for internal management accounting and budget tracking.. Valid values are `^[A-Z0-9]{4,12}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the commission amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Description of the reason for commission dispute if commission_status is disputed. Documents agency objections, calculation errors, or contractual interpretation differences.',
    `dispute_resolution_date` DATE COMMENT 'The date on which a disputed commission was resolved and either approved for payment or cancelled.',
    `effective_end_date` DATE COMMENT 'The date on which this commission structure expires and is no longer applicable to new orders. Null indicates an open-ended structure.',
    `effective_start_date` DATE COMMENT 'The date from which this commission structure becomes active and applicable to new orders.',
    `fiscal_period` STRING COMMENT 'The fiscal period (year-quarter or year-month) in which this commission is recognized for financial reporting. Format: YYYY-QN for quarters or YYYY-MM for months (e.g., 2024-Q2, 2024-06).. Valid values are `^[0-9]{4}-(Q[1-4]|[0-9]{2})$`',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this commission expense is posted for financial accounting.. Valid values are `^[0-9]{4,10}$`',
    `notes` STRING COMMENT 'General free-text notes or comments about this commission record. Used for special instructions, context, or operational details.',
    `order_gross_amount` DECIMAL(18,2) COMMENT 'The gross billing amount of the associated ad order before any deductions. Used as the basis for commission calculation when commission_basis is gross_billings.',
    `order_net_amount` DECIMAL(18,2) COMMENT 'The net billing amount of the associated ad order after agency commission deduction. Used as the basis for commission calculation when commission_basis is net_billings.',
    `override_approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved the commission override. Required for audit compliance when override_flag is true.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this commission record was manually overridden from the standard calculation. True when a manual adjustment was applied; false for standard automated calculation.',
    `override_reason` STRING COMMENT 'Business justification for manual override of the commission calculation. Required when override_flag is true. Documents special circumstances, contractual exceptions, or correction rationale.',
    `payment_date` DATE COMMENT 'The actual date on which the commission payment was made to the agency. Null if not yet paid.',
    `payment_due_date` DATE COMMENT 'The date by which the commission payment is due to the agency per contractual terms.',
    `payment_method` STRING COMMENT 'The payment instrument used to remit the commission. ACH (Automated Clearing House) for electronic bank transfer; wire transfer for same-day funds; check for paper payment; credit memo for account credit; offset for netting against agency payables.. Valid values are `ach|wire_transfer|check|credit_memo|offset`',
    `payment_reference_number` STRING COMMENT 'External reference number for the payment transaction (e.g., check number, wire confirmation, ACH trace number). Used for reconciliation and audit.',
    `reconciliation_date` DATE COMMENT 'The date on which this commission record was successfully reconciled with agency statements and financial records.',
    `reconciliation_notes` STRING COMMENT 'Free-text notes documenting reconciliation activities, discrepancies found, resolution steps, or special handling instructions. Used for audit trail and dispute resolution.',
    `reconciliation_status` STRING COMMENT 'Status of the financial reconciliation process for this commission. Tracks whether the commission calculation and payment have been verified and matched to agency statements.. Valid values are `not_started|in_progress|reconciled|discrepancy_found|escalated`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this commission record was first created in the system. Part of the audit trail.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this record in the source operational system. Used for traceability and data lineage.',
    CONSTRAINT pk_agency_commission PRIMARY KEY(`agency_commission_id`)
) COMMENT 'The commission structure and earned commission records for advertising agencies acting on behalf of advertisers. Captures agency account, commission rate (standard 15% agency commission or negotiated rate), commission basis (gross billings, net billings), applicable deal types, effective date range, earned commission amount per order, payment status, and reconciliation notes. Supports commission calculation for billing and financial reconciliation. Distinct from talent residuals (managed in rights/talent domain) — this is purely the commercial agency fee structure.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` (
    `rep_id` BIGINT COMMENT 'Primary key for rep',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee master record in the HR/workforce domain. Links the sales rep to their core employee profile.',
    `manager_rep_id` BIGINT COMMENT 'Foreign key reference to the sales manager or team lead who supervises this sales representative. Self-referential relationship within the sales rep hierarchy.',
    `sales_team_id` BIGINT COMMENT 'Foreign key linking to sales.sales_team. Business justification: rep product has sales_team_name (STRING) but no FK to sales_team. This is denormalized - the team name should be retrieved via JOIN to sales_team. Adding sales_team_id FK allows normalization. Standar',
    `account_portfolio_segment` STRING COMMENT 'Classification of the account portfolio managed by the sales representative. Indicates whether they manage agency relationships, direct advertiser accounts, distribution partners (MVPD/vMVPD), OTT platforms, syndication buyers, or other client segments. [ENUM-REF-CANDIDATE: agency|direct_advertiser|mvpd|vmvpd|ott_platform|syndicator|international|government — 8 candidates stripped; promote to reference product]',
    `annual_quota_amount` DECIMAL(18,2) COMMENT 'Total annual revenue quota assigned to the sales representative for the current quota period. Measured in the companys reporting currency.',
    `assignment_end_date` DATE COMMENT 'Date the sales representatives current territory or account portfolio assignment ended. Null if currently active in the assignment.',
    `assignment_start_date` DATE COMMENT 'Date the sales representative began their current territory or account portfolio assignment. May differ from hire date if reassigned.',
    `commission_plan_type` STRING COMMENT 'Type of commission structure applied to the sales representative. Defines how commissions are calculated based on sales performance (e.g., base salary plus commission, commission-only, tiered rates, accelerators for exceeding quota).. Valid values are `base_plus_commission|commission_only|tiered|accelerator|team_based|hybrid`',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'Standard commission rate percentage applied to qualified sales revenue. May vary by deal type or quota attainment tier.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales representative record was first created in the system.',
    `deal_type_specialization` STRING COMMENT 'Primary deal type or sales channel specialization for the representative. Indicates whether they focus on national TV advertising, digital campaigns, content licensing, syndication deals, or other revenue streams. [ENUM-REF-CANDIDATE: national_tv|local_tv|digital|syndication|licensing|upfront|scatter|programmatic|sponsorship|multi_platform — 10 candidates stripped; promote to reference product]',
    `digital_certified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the sales representative is certified and authorized to sell digital advertising inventory, including OTT, streaming, and programmatic channels.',
    `email_address` STRING COMMENT 'Primary business email address for the sales representative used for client communication and internal correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `hire_date` DATE COMMENT 'Date the sales representative was hired or onboarded into the sales organization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales representative record was last updated or modified.',
    `rep_name` STRING COMMENT 'Full legal name of the sales representative as it appears in business records and communications.',
    `office_location` STRING COMMENT 'Primary office location or city where the sales representative is based. May be a physical office or designated home office location.',
    `performance_tier` STRING COMMENT 'Performance classification or tier assigned to the sales representative based on quota attainment and sales metrics. Used for recognition, compensation adjustments, and coaching.. Valid values are `top_performer|exceeds_expectations|meets_expectations|needs_improvement|new_hire`',
    `phone_number` STRING COMMENT 'Primary business phone number for the sales representative used for client outreach and deal negotiations.',
    `quota_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quota amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `quota_period_end_date` DATE COMMENT 'End date of the current quota period for the sales representative.',
    `quota_period_start_date` DATE COMMENT 'Start date of the current quota period for the sales representative. Typically aligns with fiscal year or calendar year.',
    `rep_status` STRING COMMENT 'Current operational status of the sales representative within the sales organization. Indicates whether they are actively selling, on leave, or no longer with the company.. Valid values are `active|inactive|on_leave|terminated|suspended`',
    `salesforce_user_reference` STRING COMMENT 'Unique user identifier in Salesforce Media Cloud CRM system. Links the sales rep record to their Salesforce user profile for opportunity tracking and pipeline management.',
    `territory_assignment` STRING COMMENT 'Geographic or market territory assigned to the sales representative. May be defined by region, DMA (Designated Market Area), or account segment.',
    `upfront_certified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the sales representative is certified and authorized to negotiate and close upfront advertising deals. Upfront deals are advance commitments made during the annual upfront sales event.',
    CONSTRAINT pk_rep PRIMARY KEY(`rep_id`)
) COMMENT 'The sales representative or account executive profile within the sales domain, capturing the commercial assignment and quota context for each seller. Tracks rep name, employee ID (FK to HR/workforce), territory assignment, account portfolio, deal type specialization (national TV, digital, syndication, licensing), annual quota, quota period, commission plan type, manager, and active status. This is the sales-domain view of the seller — not a duplicate of HR employee master — focused on commercial assignment, quota, and territory rather than HR attributes.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` (
    `sales_territory_id` BIGINT COMMENT 'Unique identifier for the sales territory. Primary key.',
    `rep_id` BIGINT COMMENT 'Identifier of the primary sales representative or account executive assigned to this territory.',
    `sales_team_id` BIGINT COMMENT 'Identifier of the sales team collectively responsible for this territory, if team-based assignment is used.',
    `parent_territory_sales_territory_id` BIGINT COMMENT 'Identifier of the parent territory in a hierarchical territory structure. Null for top-level territories.',
    `employee_id` BIGINT COMMENT 'Identifier of the sales manager or director responsible for overseeing this territory and its assigned reps.',
    `account_count` STRING COMMENT 'Number of active advertiser or agency accounts assigned to this territory.',
    `account_segment` STRING COMMENT 'Classification of accounts within this territory by size or relationship type: enterprise (largest accounts), major (key accounts), mid_market, small_business, agency (advertising agencies), or direct (direct advertisers).. Valid values are `enterprise|major|mid_market|small_business|agency|direct`',
    `commission_rate_percent` DECIMAL(18,2) COMMENT 'Standard commission percentage rate applied to sales within this territory for compensation calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this territory record was first created in the system.',
    `dma_list` STRING COMMENT 'Comma-separated list of Nielsen DMA codes or names included in this territory for broadcast market segmentation.',
    `effective_end_date` DATE COMMENT 'Date when this territory definition expires or is superseded. Null for open-ended territories.',
    `effective_start_date` DATE COMMENT 'Date when this territory definition becomes active and assignments take effect.',
    `geographic_coverage` STRING COMMENT 'Textual description of the geographic area covered by this territory (e.g., states, DMAs, postal codes, countries). Free-form field for complex geographic definitions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this territory record was last updated or modified.',
    `notes` STRING COMMENT 'Free-form notes or comments about this territory, including special instructions, historical context, or operational considerations.',
    `priority_level` STRING COMMENT 'Strategic priority assigned to this territory for resource allocation and management focus: high, medium, low, or strategic (top-tier focus).. Valid values are `high|medium|low|strategic`',
    `product_line_focus` STRING COMMENT 'Primary advertising product lines or inventory types this territory is authorized to sell (e.g., Linear TV, Digital Video, OTT/Streaming, Radio, Display, Sponsorships). Comma-separated for multiple product lines.',
    `revenue_target_amount` DECIMAL(18,2) COMMENT 'Annual or period revenue quota assigned to this territory, used for quota allocation and performance tracking.',
    `revenue_target_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue target amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `sales_channel` STRING COMMENT 'Primary sales channel or go-to-market approach for this territory: direct (direct sales team), agency (sold through agencies), programmatic (automated buying), self_service (online self-serve), or partner (channel partners).. Valid values are `direct|agency|programmatic|self_service|partner`',
    `scatter_market_flag` BOOLEAN COMMENT 'Indicates whether this territory handles scatter market (last-minute, short-term) ad inventory sales. True if scatter sales are part of territory scope.',
    `territory_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the territory for reporting and system integration (e.g., NE-01, AUTO-WEST, MAJ-CA).. Valid values are `^[A-Z0-9]{3,10}$`',
    `territory_description` STRING COMMENT 'Detailed textual description of the territory scope, coverage rules, special conditions, and strategic objectives.',
    `territory_name` STRING COMMENT 'Business name of the sales territory (e.g., Northeast Region, Automotive Vertical, Major Accounts West).',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory: active (in use), inactive (not currently assigned), pending (awaiting activation), suspended (temporarily disabled), or archived (historical record).. Valid values are `active|inactive|pending|suspended|archived`',
    `territory_type` STRING COMMENT 'Classification of the territory structure: geographic (region-based), account_segment (by account size or tier), vertical (industry-based such as automotive, pharma, retail, entertainment), hybrid (combination), national (entire country), or regional (multi-state or multi-market).. Valid values are `geographic|account_segment|vertical|hybrid|national|regional`',
    `upfront_participation_flag` BOOLEAN COMMENT 'Indicates whether this territory participates in annual upfront advertising sales events. True if territory is included in upfront planning and commitments.',
    `vertical_industry_focus` STRING COMMENT 'Primary industry vertical or sector this territory specializes in (e.g., Automotive, Pharmaceutical, Retail, Entertainment, Financial Services, Technology). Used for vertical-based territory models.',
    CONSTRAINT pk_sales_territory PRIMARY KEY(`sales_territory_id`)
) COMMENT 'Defines the geographic, account-based, or vertical market territory assigned to sales teams and individual reps. Captures territory name, territory type (geographic region, account segment, vertical — automotive, pharma, retail, entertainment), assigned sales rep or team, revenue target, account count, and effective date range. Supports territory management, quota allocation, and pipeline reporting by market segment. Managed within Salesforce Media Cloud territory management module.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` (
    `rfp_id` BIGINT COMMENT 'Unique identifier for the request for proposal record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser or brand issuing the RFP. Links to the advertiser master entity.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: RFPs feed the opportunity pipeline. When an RFP is qualified, it becomes an opportunity. This FK enables tracing opportunities back to their originating RFPs. N:1 relationship (one RFP can lead to one',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser and submitting the RFP on their behalf. Nullable if direct advertiser submission.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account executive responsible for managing this RFP and preparing the response proposal.',
    `employee_id` BIGINT COMMENT 'add column workforce_employee_id (BIGINT) with FK to workforce.employee.employee_id - RFPs need an assigned owner for response management',
    `award_decision_date` DATE COMMENT 'Date when the advertiser or agency communicated their final decision on the RFP (awarded or lost). Nullable until decision is made.',
    `awarded_amount` DECIMAL(18,2) COMMENT 'Total dollar value of the campaign if the RFP was awarded to the broadcaster. Nullable if RFP was lost or still pending. Used for revenue forecasting and sales performance tracking.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amounts (e.g., USD, GBP, EUR). Ensures consistent financial reporting across international campaigns.. Valid values are `^[A-Z]{3}$`',
    `budget_range_max` DECIMAL(18,2) COMMENT 'Maximum budget amount the advertiser is willing to commit for the campaign. Defines the upper bound for proposal pricing.',
    `budget_range_min` DECIMAL(18,2) COMMENT 'Minimum budget amount the advertiser is willing to commit for the campaign. Used for opportunity qualification and inventory allocation.',
    `campaign_objective` STRING COMMENT 'High-level business goal or marketing objective the advertiser seeks to achieve through this campaign (e.g., brand awareness, product launch, direct response, seasonal promotion).',
    `competitive_separation_requirements` STRING COMMENT 'Rules for separating this advertisers spots from competing brands within the same ad pod or program. Typically specifies minimum time separation or exclusivity within a break.',
    `content_adjacency_restrictions` STRING COMMENT 'Advertiser-specified restrictions on content types or genres where ads should not appear (e.g., no violent content, no political programming, no competitive sports). Used for brand safety and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RFP record was first created in the system. Used for audit trail and data lineage.',
    `daypart_requirements` STRING COMMENT 'Specific broadcast daypart preferences or requirements (e.g., Prime Time, Early Morning, Late Night, Weekend). Dayparts are time segments of the broadcast day used for scheduling and pricing.',
    `desired_frequency` DECIMAL(18,2) COMMENT 'Target average number of times each unique viewer should be exposed to the advertisement during the campaign. Frequency is a key metric for message reinforcement.',
    `desired_grp_target` DECIMAL(18,2) COMMENT 'Target Gross Rating Points the advertiser seeks to achieve. GRP is a standard audience measurement metric representing the sum of all rating points delivered by a campaign.',
    `desired_impressions` BIGINT COMMENT 'Total number of ad impressions the advertiser seeks to purchase. An impression represents a single ad view by a viewer.',
    `desired_reach_percent` DECIMAL(18,2) COMMENT 'Target percentage of unique audience members the advertiser wants to reach at least once during the campaign. Reach is a key audience delivery metric.',
    `flight_end_date` DATE COMMENT 'Desired end date for the advertising campaign flight. Defines the conclusion of the campaign delivery window.',
    `flight_start_date` DATE COMMENT 'Desired start date for the advertising campaign flight. Defines the beginning of the campaign delivery window.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this RFP record was last updated. Tracks changes throughout the RFP review and response process.',
    `loss_reason` STRING COMMENT 'Explanation or categorization of why the RFP was lost if not awarded. Used for competitive analysis and sales process improvement. Nullable if RFP was awarded or still pending.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional context, special requirements, internal comments, or follow-up actions related to the RFP. Used for collaboration and knowledge transfer.',
    `platform_preference` STRING COMMENT 'Advertisers preferred distribution platforms for the campaign. May include linear television, Connected TV (CTV), digital video, streaming (OTT), or cross-platform packages. Multiple platforms may be specified.',
    `pricing_model_preference` STRING COMMENT 'Advertisers preferred pricing structure for the campaign. Options include Cost Per Mille (CPM), Cost Per Rating Point (CPRP), flat rate, performance-based, or hybrid models.. Valid values are `cpm|cprp|flat-rate|performance-based|hybrid`',
    `priority_level` STRING COMMENT 'Internal priority classification assigned to the RFP based on strategic value, budget size, client relationship, or competitive factors. Used for resource allocation and response sequencing.. Valid values are `critical|high|medium|low`',
    `response_due_date` DATE COMMENT 'Deadline by which the broadcaster must submit a response proposal to the RFP. Critical for sales team prioritization and workflow management.',
    `response_submitted_date` DATE COMMENT 'Date when the broadcaster submitted their proposal response to the RFP. Nullable until response is completed. Used to track response turnaround time.',
    `rfp_number` STRING COMMENT 'Business identifier for the RFP, typically assigned by the source system or agency. Used for external reference and tracking.. Valid values are `^RFP-[0-9]{6,10}$`',
    `rfp_status` STRING COMMENT 'Current lifecycle status of the RFP in the sales pipeline. Tracks progression from receipt through final disposition.. Valid values are `received|in-review|responded|awarded|lost|declined`',
    `source` STRING COMMENT 'Origin channel through which the RFP was received. Distinguishes between agency-mediated, direct advertiser, programmatic platform, upfront market, scatter market, or network referral submissions.. Valid values are `agency|direct|programmatic-platform|upfront|scatter|network-referral`',
    `submission_date` DATE COMMENT 'Date when the RFP was received or submitted by the advertiser, agency, or content buyer. Principal business event timestamp for the RFP lifecycle.',
    `target_age_range` STRING COMMENT 'Specific age demographic range requested by the advertiser (e.g., 18-34, 25-54, 35-49). Used for audience targeting and rate card selection.',
    `target_audience_description` STRING COMMENT 'Narrative description of the desired audience demographics and psychographics, including age range, gender, household income (HHI), geography, interests, and behavioral attributes.',
    `target_gender` STRING COMMENT 'Gender demographic targeting requirement specified in the RFP. May be male, female, all genders, or unspecified.. Valid values are `male|female|all|unspecified`',
    `target_geography` STRING COMMENT 'Geographic targeting requirements, including designated market areas (DMAs), regions, states, or national coverage. May include multiple geographies separated by delimiters.',
    CONSTRAINT pk_rfp PRIMARY KEY(`rfp_id`)
) COMMENT 'A Request for Proposal received from an advertiser, agency, or content buyer soliciting inventory availability, pricing, and audience delivery options for an upcoming campaign or content acquisition. Captures RFP source (agency, direct, programmatic platform), submission date, response due date, campaign objectives, target audience demographics (age, gender, HHI, geography), budget range, platform preferences (linear, CTV, digital, cross-platform), daypart requirements, content adjacency restrictions, competitive separation requirements, desired flight dates, and RFP status (received, in-review, responded, awarded, lost). The upstream trigger for proposal creation and opportunity qualification in the sales pipeline. Response quality and turnaround time are key competitive differentiators in winning agency business.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` (
    `avail_id` BIGINT COMMENT 'Unique identifier for the advertising inventory availability record.',
    `order_line_id` BIGINT COMMENT 'Reference to the confirmed ad order line that has purchased this inventory, if sold.',
    `ad_pod_id` BIGINT COMMENT 'Foreign key linking to sales.ad_pod. Business justification: Avails represent inventory availability within ad pods. This FK links the available inventory slot to its containing ad pod for proper inventory management and scheduling. Nullable because some avails',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to technology.broadcast_facility. Business justification: Advertising avails are facility-specific inventory units for local/regional sales. Facility identification enables inventory management, geographic targeting, and transmission capacity planning. Criti',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Available inventory slots are station-specific and must reference the broadcast license for regulatory tracking, compliance verification, and ensuring sold inventory matches licensed station capabilit',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast channel or platform where this inventory is available.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created this availability record.',
    `rate_card_id` BIGINT COMMENT 'Reference to the rate card that defines pricing for this inventory type and daypart.',
    `sales_account_id` BIGINT COMMENT 'Reference to the advertiser or agency account that currently holds this inventory.',
    `sales_proposal_id` BIGINT COMMENT 'Reference to the sales proposal that includes this availability, if applicable.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative responsible for selling this inventory.',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: When an avail is sold and confirmed, it maps to a specific schedule slot for playout. Business process: order fulfillment, traffic-to-playout handoff, as-run reconciliation, affidavit generation.',
    `title_id` BIGINT COMMENT 'Reference to the program or content title during which this advertising slot is available.',
    `ad_pod_position` STRING COMMENT 'Position of this spot within the ad pod or commercial break (1 for first position, 2 for second, etc.).',
    `air_date` DATE COMMENT 'Scheduled broadcast date when this advertising slot will air.',
    `air_time` TIMESTAMP COMMENT 'Precise scheduled broadcast timestamp when this advertising slot will air.',
    `break_type` STRING COMMENT 'Type of commercial break where this inventory is positioned (opening, mid-break, closing, standalone).. Valid values are `opening|mid_break|closing|standalone`',
    `avail_code` STRING COMMENT 'Business identifier code for this availability record, typically generated by the traffic system.',
    `content_rating` STRING COMMENT 'Parental guidance rating of the program content surrounding this advertising slot (TV-Y, TV-Y7, TV-G, TV-PG, TV-14, TV-MA).. Valid values are `TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this availability record was first created in the system.',
    `daypart` STRING COMMENT 'Time segment of the broadcast day when this inventory is available (early morning, morning, daytime, early fringe, prime access, prime time, late fringe, late night, overnight). [ENUM-REF-CANDIDATE: early_morning|morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight — 9 candidates stripped; promote to reference product]',
    `floor_cpm_usd` DECIMAL(18,2) COMMENT 'Minimum Cost Per Thousand Impressions (CPM) rate in USD that the seller will accept for this inventory.',
    `floor_rate_usd` DECIMAL(18,2) COMMENT 'Minimum unit rate in USD that the seller will accept for this advertising slot.',
    `genre` STRING COMMENT 'Content genre or category of the program where this advertising slot is available (e.g., News, Sports, Drama, Comedy, Reality).',
    `geographic_market` STRING COMMENT 'Designated Market Area (DMA) or geographic market where this inventory will be broadcast or streamed.',
    `hold_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the current hold on this inventory will expire if not confirmed.',
    `hold_placed_timestamp` TIMESTAMP COMMENT 'Date and time when the current hold was placed on this inventory.',
    `hold_status` STRING COMMENT 'Current reservation status of this inventory (available, first hold, second hold, third hold, released, sold, expired). [ENUM-REF-CANDIDATE: available|first_hold|second_hold|third_hold|released|sold|expired — 7 candidates stripped; promote to reference product]',
    `inventory_type` STRING COMMENT 'Type of advertising unit available for sale (spot, sponsorship, integration, digital pre-roll, mid-roll, post-roll, overlay, branded content). [ENUM-REF-CANDIDATE: spot|sponsorship|integration|pre_roll|mid_roll|post_roll|overlay|branded_content — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this availability record was last updated.',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether this inventory is eligible for makegood compensation if performance guarantees are not met.',
    `notes` STRING COMMENT 'Additional notes or special instructions related to this availability (e.g., creative restrictions, special positioning requirements).',
    `platform_type` STRING COMMENT 'Distribution platform type where this inventory is available (linear, VOD, SVOD, AVOD, TVOD, OTT, FAST, digital). [ENUM-REF-CANDIDATE: linear|vod|svod|avod|tvod|ott|fast|digital — 8 candidates stripped; promote to reference product]',
    `preemptible_flag` BOOLEAN COMMENT 'Indicates whether this inventory can be preempted by higher-priority advertising (true) or is guaranteed (false).',
    `projected_grp` DECIMAL(18,2) COMMENT 'Estimated Gross Rating Points this slot is expected to deliver, representing the percentage of the target audience reached multiplied by frequency.',
    `projected_impressions` BIGINT COMMENT 'Estimated number of viewer impressions this advertising slot is expected to deliver based on historical audience data.',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment this inventory is projected to reach (e.g., Adults 18-49, Women 25-54, Men 18-34).',
    `unit_length_seconds` STRING COMMENT 'Duration of the advertising unit in seconds (e.g., 15, 30, 60 for traditional spots).',
    `window_end_date` DATE COMMENT 'End date of the availability window for content licensing or sponsorship opportunities.',
    `window_start_date` DATE COMMENT 'Start date of the availability window for content licensing or sponsorship opportunities.',
    CONSTRAINT pk_avail PRIMARY KEY(`avail_id`)
) COMMENT 'An inventory availability record representing a specific advertising slot, sponsorship position, or content window that is available for sale at a given point in time. Captures channel or platform, program or content title, daypart, air date or window, unit type (spot, sponsorship, integration, digital pre-roll), spot length, available impressions or GRPs, audience demographic projection, floor CPM, hold status (available, first hold, second hold, released, sold), holding account reference, hold expiry date, and source system (Wide Orbit, programmatic SSP). Avails are the sellable inventory units that sales reps present to buyers and that proposals are built from. Sourced from Wide Orbit inventory management and EPG scheduling. Updated in near-real-time as holds are placed and orders confirmed.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` (
    `upfront_option_exercise_id` BIGINT COMMENT 'Unique identifier for the upfront option exercise record. Primary key.',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (brand or company) that holds the upfront commitment and is exercising this option.',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically sales manager or director) who approved this option exercise, if approval was required.',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser in this upfront commitment and option exercise, if applicable.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative who managed this option exercise transaction and communicated with the advertiser or agency.',
    `tertiary_upfront_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this option exercise record.',
    `upfront_commitment_id` BIGINT COMMENT 'Reference to the parent upfront commitment contract under which this option exercise occurs.',
    `adjusted_commitment_amount` DECIMAL(18,2) COMMENT 'The resulting total commitment amount for the parent upfront deal after this option exercise is applied. Used to track the cumulative impact of option exercises on the overall upfront commitment.',
    `amendment_document_reference` STRING COMMENT 'Reference identifier or file path to the contract amendment document associated with this option exercise, if applicable.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this option exercise requires internal management approval before being finalized. True for exercises that deviate from standard terms or involve significant cancellations.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this option exercise was approved by management, if approval was required.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the primary reason the advertiser cancelled or reduced this option window commitment.. Valid values are `budget_reallocation|market_conditions|campaign_performance|strategic_shift|advertiser_request|other`',
    `cancellation_reason_notes` STRING COMMENT 'Free-text explanation providing additional context for the cancellation or reduction decision. Captured from sales representative or advertiser communication.',
    `cancelled_amount` DECIMAL(18,2) COMMENT 'The dollar amount the advertiser cancelled or declined to commit for this option window. Calculated as original_committed_spend minus exercised_amount.',
    `cancelled_grp_volume` DECIMAL(18,2) COMMENT 'The Gross Rating Point volume cancelled or declined for this option window. Calculated as committed_grp_volume minus exercised_grp_volume.',
    `committed_grp_volume` DECIMAL(18,2) COMMENT 'The Gross Rating Point volume originally committed for this option window. GRP is a standard audience measurement metric representing reach multiplied by frequency.',
    `contract_amendment_required_flag` BOOLEAN COMMENT 'Indicates whether this option exercise triggers a formal contract amendment or addendum to the original upfront agreement. True for material changes that require legal documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this option exercise record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this option exercise record (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `daypart_allocation` STRING COMMENT 'The broadcast daypart(s) allocated for this option window (e.g., Prime Time, Early Morning, Late Night, Weekend). Daypart is a time segment of the broadcast day used for scheduling and pricing.',
    `digital_allocation_amount` DECIMAL(18,2) COMMENT 'The portion of the exercised amount allocated to digital platform inventory (web, mobile app, connected TV).',
    `exercise_method` STRING COMMENT 'The communication channel or method through which the advertiser submitted their option exercise decision (e.g., email notification, phone call, self-service portal, in-person meeting, automatic per contract terms).. Valid values are `email|phone|portal|meeting|automatic`',
    `exercise_status` STRING COMMENT 'Current status of this option exercise. Confirmed means the advertiser exercised the full option amount; partially_confirmed means a reduced amount was exercised; cancelled means the option was declined; expired means the deadline passed without action; pending means the option window is open but not yet exercised.. Valid values are `confirmed|partially_confirmed|cancelled|expired|pending`',
    `exercised_amount` DECIMAL(18,2) COMMENT 'The dollar amount the advertiser confirmed and committed to spend for this option window. May equal original_committed_spend (full exercise) or be less (partial exercise).',
    `exercised_grp_volume` DECIMAL(18,2) COMMENT 'The Gross Rating Point volume the advertiser confirmed for this option window after exercise. May be less than committed_grp_volume if partially exercised.',
    `inventory_release_date` DATE COMMENT 'The date on which cancelled inventory from this option exercise was released to scatter market availability. Critical for scatter market inventory planning and sales.',
    `inventory_released_flag` BOOLEAN COMMENT 'Indicates whether the cancelled inventory from this option exercise has been released back to scatter market availability. True means inventory is available for scatter sales; False means it is still held or being reallocated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this option exercise record was most recently updated.',
    `linear_allocation_amount` DECIMAL(18,2) COMMENT 'The portion of the exercised amount allocated to traditional linear (scheduled) television broadcast inventory.',
    `notes` STRING COMMENT 'General free-text notes and comments about this option exercise, including negotiation details, special terms, or follow-up actions required.',
    `option_deadline_date` DATE COMMENT 'The contractual deadline date by which the advertiser must exercise this option window. Failure to exercise by this date may result in automatic cancellation or confirmation per contract terms.',
    `option_exercise_date` DATE COMMENT 'The date on which the advertiser exercised (confirmed or cancelled) this option window. This is the business event date when the decision was made.',
    `option_exercise_number` STRING COMMENT 'Business identifier for this option exercise event, typically formatted as commitment number plus option window sequence.',
    `option_window_number` STRING COMMENT 'Sequential number of the option window within the upfront commitment (e.g., 1 for first option, 2 for second option, 3 for third option). Upfront deals typically have multiple option dates where advertisers can confirm or cancel portions of their commitment.',
    `original_committed_spend` DECIMAL(18,2) COMMENT 'The original dollar amount committed for this option window at the time the upfront deal was signed. This is the baseline amount subject to the option exercise decision.',
    `streaming_allocation_amount` DECIMAL(18,2) COMMENT 'The portion of the exercised amount allocated to Over-The-Top (OTT) streaming platform inventory (SVOD, AVOD, FAST channels).',
    `target_demographic` STRING COMMENT 'The audience demographic segment this option window commitment was intended to reach (e.g., Adults 18-49, Women 25-54, Men 18-34). Standard Nielsen demographic notation.',
    CONSTRAINT pk_upfront_option_exercise PRIMARY KEY(`upfront_option_exercise_id`)
) COMMENT 'Records the exercise or cancellation of option windows within an upfront commitment, capturing the advertisers decision to confirm, reduce, or cancel a portion of their advance commitment at each contractual option date. Captures upfront commitment reference, option window number, option exercise date, original committed spend for the window, exercised amount, cancelled amount, reason for cancellation, and resulting adjusted commitment. Critical for scatter market inventory release calculations — cancelled upfront options free inventory for scatter sales.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` (
    `forecast_id` BIGINT COMMENT 'Unique identifier for the revenue forecast record.',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Sales forecasts are segmented by daypart for revenue planning. Business process: daypart-level revenue forecasting, quota allocation, inventory yield optimization by daypart.',
    `employee_id` BIGINT COMMENT 'Identifier of the sales manager who approved this forecast submission.',
    `prior_forecast_id` BIGINT COMMENT 'Self-referencing FK on forecast (prior_forecast_id)',
    `sales_account_id` BIGINT COMMENT 'Identifier of the account this forecast is associated with, if forecast is account-specific.',
    `rep_id` BIGINT COMMENT 'Identifier of the sales representative who submitted this forecast.',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to sales.sales_territory. Business justification: Forecasts are often segmented by sales territory for territory-level revenue projections and quota tracking. This FK enables territory-based forecasting. N:1 relationship. New attribute needed to esta',
    `account_segment` STRING COMMENT 'Segmentation of the account type for this forecast: enterprise (large advertisers), mid-market, small business, agency (media buying agencies), direct (direct-to-advertiser).. Valid values are `enterprise|mid_market|small_business|agency|direct`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast was approved by the sales manager.',
    `attainment_percentage` DECIMAL(18,2) COMMENT 'Percentage of quota represented by the total forecasted revenue (forecasted revenue / quota * 100).',
    `best_case_revenue` DECIMAL(18,2) COMMENT 'Revenue amount in the best case forecast category (optimistic scenario including stretch opportunities).',
    `broadcast_year` STRING COMMENT 'Broadcast year (September to August cycle) this forecast applies to, represented as the starting calendar year.',
    `carriage_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from carriage fee agreements (distribution payments from cable/satellite providers).',
    `forecast_category` STRING COMMENT 'Classification of the forecast confidence level: commit (high confidence), best case (optimistic), pipeline (possible), omitted (excluded from forecast), closed (already won).. Valid values are `commit|best_case|pipeline|omitted|closed`',
    `closed_revenue` DECIMAL(18,2) COMMENT 'Revenue amount from deals already closed and won during this forecast period.',
    `commit_revenue` DECIMAL(18,2) COMMENT 'Revenue amount in the commit forecast category (high confidence deals expected to close).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this forecast.. Valid values are `^[A-Z]{3}$`',
    `deal_type` STRING COMMENT 'Type of sales deal being forecasted: upfront (advance commitment), scatter (last-minute inventory), licensing (content rights), syndication (content resale), carriage (distribution fee), sponsorship (branded integration).. Valid values are `upfront|scatter|licensing|syndication|carriage|sponsorship`',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter this forecast applies to (Q1, Q2, Q3, Q4).. Valid values are `Q1|Q2|Q3|Q4`',
    `forecast_number` STRING COMMENT 'Business-readable unique identifier for the forecast submission.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast record.. Valid values are `draft|submitted|approved|rejected|locked|archived`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was last modified.',
    `licensing_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from content licensing deals (selling rights to broadcast or distribute content).',
    `manager_override_amount` DECIMAL(18,2) COMMENT 'Revenue amount adjusted by sales manager override, used when manager believes rep forecast needs correction.',
    `manager_override_reason` STRING COMMENT 'Explanation provided by sales manager for any override adjustment to the forecast.',
    `forecast_name` STRING COMMENT 'Descriptive name for the forecast record, typically including period and rep name.',
    `notes` STRING COMMENT 'Free-text notes and commentary from the sales representative about assumptions, risks, or opportunities in this forecast.',
    `period_end_date` DATE COMMENT 'End date of the time period this forecast covers.',
    `period_start_date` DATE COMMENT 'Start date of the time period this forecast covers.',
    `period_type` STRING COMMENT 'Time period granularity for this forecast: quarter, broadcast year (Sept-Aug), calendar year, or month.. Valid values are `quarter|broadcast_year|calendar_year|month`',
    `pipeline_revenue` DECIMAL(18,2) COMMENT 'Revenue amount in the pipeline forecast category (possible deals still in early stages).',
    `quota_amount` DECIMAL(18,2) COMMENT 'Assigned sales quota target for this sales rep and period.',
    `scatter_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from scatter market deals (last-minute ad inventory sales outside upfront commitments).',
    `submission_date` DATE COMMENT 'Date when this forecast version was submitted by the sales representative.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this forecast version was submitted.',
    `syndication_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from syndication deals (reselling content to multiple outlets).',
    `total_forecasted_revenue` DECIMAL(18,2) COMMENT 'Total projected revenue amount for this forecast period across all deal types and categories.',
    `update_frequency` STRING COMMENT 'Expected frequency of forecast updates for this period: weekly (standard selling periods), daily (upfront season), monthly (long-range planning), ad hoc (as needed).. Valid values are `weekly|daily|monthly|ad_hoc`',
    `upfront_revenue` DECIMAL(18,2) COMMENT 'Forecasted revenue from upfront deals (advance advertising commitments made during upfront season).',
    `variance_to_quota` DECIMAL(18,2) COMMENT 'Difference between total forecasted revenue and quota amount (positive indicates over-quota forecast, negative indicates gap).',
    `version` STRING COMMENT 'Version number of this forecast submission, incremented with each revision for the same period.',
    `weighted_pipeline_value` DECIMAL(18,2) COMMENT 'Total pipeline value adjusted by probability weights for each opportunity, providing a risk-adjusted forecast.',
    CONSTRAINT pk_forecast PRIMARY KEY(`forecast_id`)
) COMMENT 'Revenue forecast record capturing projected bookings by sales rep, territory, account segment, deal type (upfront, scatter, licensing, syndication, carriage), and time period (quarter, broadcast year). Tracks forecast version, submission date, forecast category (commit, best case, pipeline, omitted), total forecasted revenue, weighted pipeline value, variance to quota, and manager override amount. Enables sales leadership to project revenue attainment against quota, identify pipeline gaps, and allocate resources. Updated weekly during active selling periods and daily during upfront season.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` (
    `sales_deal_approval_id` BIGINT COMMENT 'Unique identifier for the sales deal approval workflow record.',
    `ad_sales_order_id` BIGINT COMMENT 'Reference to the advertising sales order requiring approval. Used when the approval is triggered at the order stage rather than opportunity stage.',
    `carriage_deal_id` BIGINT COMMENT 'Foreign key linking to sales.carriage_deal. Business justification: Carriage deals require approval due to their strategic importance and long-term nature. This FK enables tracking approval workflow for carriage deals. N:1 relationship. New attribute needed for approv',
    `content_license_deal_id` BIGINT COMMENT 'Foreign key linking to sales.content_license_deal. Business justification: Content license deals require approval due to rights complexity and deal value. This FK enables tracking approval workflow for license deals. N:1 relationship. New attribute needed for approval workfl',
    `escalated_sales_deal_approval_id` BIGINT COMMENT 'Self-referencing FK on sales_deal_approval (escalated_sales_deal_approval_id)',
    `opportunity_id` BIGINT COMMENT 'Reference to the sales opportunity requiring approval. Links to the opportunity being evaluated for non-standard terms or high-value thresholds.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the user assigned to review and approve this deal. Links to the employee or user record in the system.',
    `sales_proposal_id` BIGINT COMMENT 'Foreign key linking to sales.sales_proposal. Business justification: Proposals may require approval before being sent to clients, especially for non-standard pricing or terms. This FK enables tracking approval workflow for proposals. N:1 relationship. New attribute nee',
    `sales_scatter_order_id` BIGINT COMMENT 'Foreign key linking to sales.sales_scatter_order. Business justification: Scatter orders may require approval when they involve non-standard pricing, extended payment terms, or high-value deals. This FK enables tracking approval workflow for scatter orders. N:1 relationship',
    `sales_syndication_deal_id` BIGINT COMMENT 'Reference to the syndication deal requiring approval. Used for content licensing and syndication agreements that exceed standard authority levels.',
    `tertiary_quinary_sales_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the approval record. Tracks who made the most recent update for audit and accountability purposes.',
    `tertiary_sales_submitted_by_user_employee_id` BIGINT COMMENT 'Identifier of the sales representative or user who submitted the deal for approval. Tracks originator for accountability and commission purposes.',
    `upfront_commitment_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_commitment. Business justification: Upfront commitments typically require approval due to their high value and multi-year nature. This FK enables tracking approval workflow for upfront commitments. N:1 relationship. New attribute needed',
    `approval_conditions` STRING COMMENT 'Specific conditions, stipulations, or requirements attached to the approval. May include contingencies such as legal review, credit check, or contract amendments that must be satisfied before execution.',
    `approval_decision_timestamp` TIMESTAMP COMMENT 'Date and time when the approver made their decision (approved, rejected, or escalated). Used to calculate approval cycle time and SLA compliance.',
    `approval_expiry_timestamp` TIMESTAMP COMMENT 'Date and time by which the approval decision must be made. If no decision is rendered by this time, the approval may auto-escalate or expire.',
    `approval_notes` STRING COMMENT 'Free-text comments and observations recorded by the approver during the review process. Captures context, concerns, or additional instructions.',
    `approval_number` STRING COMMENT 'Business identifier for the approval workflow instance. Format: APV-YYYYMMDD followed by sequence number for tracking and audit purposes.. Valid values are `^APV-[0-9]{8}$`',
    `approval_status` STRING COMMENT 'Current state of the approval workflow. Tracks progression from submission through final decision or escalation to higher authority.. Valid values are `pending|approved|rejected|escalated|withdrawn|expired`',
    `approval_tier` STRING COMMENT 'Hierarchical approval level triggered by deal characteristics. Higher tiers required for larger values, extended terms, or non-standard conditions.. Valid values are `tier_1_manager|tier_2_director|tier_3_vp|tier_4_svp|tier_5_cfo|tier_6_ceo`',
    `approval_trigger_reason` STRING COMMENT 'Business justification for why this deal requires management approval. May include multiple reasons such as value threshold exceeded, below-floor pricing, extended payment terms, custom barter arrangement, or non-standard cancellation options.',
    `approver_email` STRING COMMENT 'Email address of the approver for notification and communication regarding the approval request.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `approver_name` STRING COMMENT 'Full name of the individual assigned to approve this deal. Captured for audit trail and reporting purposes.',
    `approver_role` STRING COMMENT 'Functional role or title of the individual authorized to approve at this tier. Examples: Sales Manager, Finance Director, VP Sales, CFO.',
    `below_floor_pricing_flag` BOOLEAN COMMENT 'Indicates whether the negotiated rate falls below the established rate card floor, requiring pricing exception approval.',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Indicates whether the deal requires compliance review for regulatory adherence, political advertising rules, or industry standards compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the approval workflow record was first created in the system. Marks the initiation of the approval process.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deal value amount. Ensures proper financial evaluation across multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `custom_barter_arrangement_flag` BOOLEAN COMMENT 'Indicates whether the deal involves non-cash barter or trade arrangements requiring special approval and valuation review.',
    `deal_type` STRING COMMENT 'Classification of the commercial deal requiring approval. Determines which approval tier and rules apply based on deal structure and risk profile. [ENUM-REF-CANDIDATE: upfront|scatter|syndication|sponsorship|barter|digital|streaming|linear — 8 candidates stripped; promote to reference product]',
    `deal_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the deal requiring approval. Used to determine appropriate approval tier based on value thresholds.',
    `escalated_to_tier` STRING COMMENT 'The higher approval tier to which this request has been escalated. Tracks the escalation path through the approval hierarchy.. Valid values are `tier_1_manager|tier_2_director|tier_3_vp|tier_4_svp|tier_5_cfo|tier_6_ceo`',
    `escalation_reason` STRING COMMENT 'Justification for escalating the approval to a higher tier. Documents why the current approver is unable or unwilling to make the decision at their level.',
    `extended_payment_terms_flag` BOOLEAN COMMENT 'Indicates whether the deal includes payment terms that exceed standard credit policy, requiring finance approval.',
    `finance_review_required_flag` BOOLEAN COMMENT 'Indicates whether the deal requires finance department review for credit risk, revenue recognition, or payment terms validation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the approval record was last updated. Tracks changes to status, approver assignments, or conditions throughout the workflow lifecycle.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether the deal requires legal department review before final approval. Triggered by contract complexity, liability concerns, or regulatory considerations.',
    `non_standard_cancellation_flag` BOOLEAN COMMENT 'Indicates whether the deal includes cancellation options or terms that deviate from standard contract provisions.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the approver when rejecting the deal. Captures business rationale for denial to inform sales team and support future negotiations.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the approval decision was made within the target SLA timeframe. Used for performance monitoring and process improvement.',
    `sla_target_hours` STRING COMMENT 'Target number of hours within which the approval decision should be made. Defines the expected response time for this approval tier.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the approval request was submitted into the workflow. Marks the start of the approval cycle for SLA tracking.',
    `value_threshold_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the deal value exceeds the sales representatives approval authority limit, triggering escalation to management.',
    CONSTRAINT pk_sales_deal_approval PRIMARY KEY(`sales_deal_approval_id`)
) COMMENT 'Workflow record capturing the approval chain and sign-off status for high-value or non-standard commercial deals requiring management, legal, or finance authorization before execution. Tracks deal reference (opportunity or order), approval tier triggered (value threshold, non-standard terms, extended payment, below-floor pricing), approver role, approver identity, approval status (pending, approved, rejected, escalated), approval timestamp, conditions attached, and delegation rules. Critical for deals exceeding rate card floors, extended cancellation options, or custom barter arrangements.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` (
    `proposal_distribution_id` BIGINT COMMENT 'Unique identifier for this proposal distribution record. Primary key.',
    `sales_proposal_id` BIGINT COMMENT 'Foreign key linking to the sales proposal that was distributed to the contact.',
    `sales_contact_id` BIGINT COMMENT 'Foreign key linking to the sales contact who received the proposal.',
    `proposal_sales_contact_id` BIGINT COMMENT 'Foreign key to the sales contact who received the proposal.',
    `contact_sales_contact_id` BIGINT COMMENT '',
    `feedback_notes` STRING COMMENT 'Free-text notes capturing the contacts specific feedback, questions, objections, or comments about the proposal. Used for proposal refinement and competitive intelligence.',
    `opened_flag` BOOLEAN COMMENT 'Indicates whether this contact has opened or viewed the proposal materials. Tracked via email tracking pixels or document management system access logs.',
    `opened_timestamp` TIMESTAMP COMMENT 'Timestamp of the first time this contact opened or accessed the proposal. Null if never opened. Used for engagement scoring and follow-up prioritization.',
    `recipient_type` STRING COMMENT 'Role of the contact in receiving this proposal: primary recipient, carbon copy, blind carbon copy, internal reviewer, or approver. Determines routing and notification behavior.',
    `response_date` DATE COMMENT 'Date when this contact provided formal feedback or response to the proposal. Null if no response received. Used for conversion tracking and sales cycle analysis.',
    `response_type` STRING COMMENT 'Classification of the contacts response to the proposal: accepted, rejected, revision requested, questions raised, or no response. Drives workflow routing and follow-up actions.',
    `sent_date` TIMESTAMP COMMENT 'Timestamp when the proposal was sent or distributed to this specific contact. Used for tracking response time and follow-up scheduling.',
    CONSTRAINT pk_proposal_distribution PRIMARY KEY(`proposal_distribution_id`)
) COMMENT 'This association product represents the distribution event between sales_proposal and sales_contact. It captures the operational tracking of which contacts received which proposals, their engagement with the proposal materials, and their responses. Each record links one sales_proposal to one sales_contact with attributes that exist only in the context of this distribution relationship.. Existence Justification: In media broadcasting sales operations, a single proposal is routinely distributed to multiple contacts within an advertiser organization and agency (e.g., media buyer, brand manager, legal counsel, CFO for approval), and each contact receives and responds to multiple proposals over time. The business actively manages proposal distribution as an operational process with engagement tracking (who opened it, when, what feedback they provided) to prioritize follow-ups and refine proposals. This is not an analytical correlation but a core sales workflow that humans create, update, and query.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` (
    `facility_service_agreement_id` BIGINT COMMENT 'Unique identifier for the facility service agreement record. Primary key for the association.',
    `broadcast_facility_id` BIGINT COMMENT 'Foreign key linking to the broadcast facility where services are being provided. Identifies the physical infrastructure location (studio, transmission site, uplink center, or NOC) covered by the service agreement.',
    `rep_id` BIGINT COMMENT 'Reference to the sales representative or account executive responsible for managing this facility service agreement. This is the person who negotiated the contract and handles renewals, amendments, and account relationship for this specific facility service.',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to the sales account that has contracted for facility services. Identifies the commercial entity (agency, advertiser, licensee, or partner) in the service agreement.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the facility service agreement. Draft indicates negotiation in progress, active indicates services are being provided, suspended indicates temporary hold, expired indicates contract period ended, terminated indicates early cancellation, renewed indicates contract was extended.',
    `billing_frequency` STRING COMMENT 'The cadence at which the sales account is invoiced for facility services under this agreement. Defines whether billing occurs monthly (most common for ongoing services), quarterly (for larger contracts), annually (for full facility leases), per-use (for ad-hoc studio rentals), or at milestones (for project-based services).',
    `contracted_capacity` STRING COMMENT 'The amount or extent of facility capacity allocated to this sales account under the agreement. Format varies by service type: hours per month for studio rental, bandwidth allocation for transmission, rack units for colocation, percentage of facility for full lease. This defines the resource commitment.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this facility service agreement record was first created in the system. Used for audit trail and contract lifecycle tracking.',
    `effective_end_date` DATE COMMENT 'The date when this facility service agreement expires or is terminated. After this date, the sales account no longer has contracted access to the facility services unless the agreement is renewed. Null indicates an open-ended or evergreen agreement.',
    `effective_start_date` DATE COMMENT 'The date when this facility service agreement becomes active and the sales account gains access to the contracted facility services. Marks the beginning of the contract period and the start of billing.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this facility service agreement record was last updated. Tracks changes to contract terms, capacity allocations, or status changes.',
    `rate_card_reference` STRING COMMENT 'Reference identifier to the pricing rate card or pricing schedule that governs billing for this service agreement. Links to the commercial pricing structure negotiated for this account-facility combination, which may differ from standard rates based on volume commitments or strategic relationship.',
    `service_type` STRING COMMENT 'Classification of the service being provided under this agreement. Defines what type of facility access or service the sales account has contracted for (e.g., studio rental for production, transmission services for broadcast distribution, uplink services for satellite feeds, colocation for equipment hosting, managed services for technical operations, or full facility lease).',
    CONSTRAINT pk_facility_service_agreement PRIMARY KEY(`facility_service_agreement_id`)
) COMMENT 'This association product represents the contractual service agreement between a sales account and a broadcast facility. It captures the commercial terms under which a sales account (advertising agency, direct advertiser, content licensee, or distribution partner) contracts for services at a specific broadcast facility (studio, transmission site, uplink center, or NOC). Each record links one sales account to one broadcast facility with attributes that define the service type, capacity allocation, pricing, and contract lifecycle dates that exist only in the context of this commercial relationship.. Existence Justification: In media broadcasting operations, large sales accounts (networks, station groups, advertising agencies, content licensees) routinely contract for services across multiple broadcast facilities simultaneously—a major advertiser may need studio access at multiple production facilities, transmission services at regional sites, and uplink capacity at satellite centers. Conversely, each broadcast facility serves multiple sales accounts concurrently, with different service types, capacity allocations, and commercial terms per account. The business actively manages these facility service agreements as distinct commercial contracts with lifecycle tracking, capacity management, and account-specific pricing.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` (
    `campaign_funding_id` BIGINT COMMENT 'Unique identifier for this campaign funding allocation record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the advertising campaign being funded by this opportunity allocation',
    `cost_center_id` BIGINT COMMENT 'add column finance_cost_center_id (BIGINT) with FK to finance.cost_center.cost_center_id - campaign funding must be tracked against cost centers for budget control',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to the sales opportunity providing funding for this campaign',
    `allocation_amount` DECIMAL(18,2) COMMENT 'The dollar amount from this opportunity allocated to fund this specific campaign. Sum of all allocation_amounts for an opportunity should not exceed the opportunitys estimated_value.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the opportunitys total estimated value allocated to this campaign. Used for portfolio buys and umbrella deals where a single opportunity funds multiple campaigns.',
    `campaign_funding_status` STRING COMMENT 'Current status of this funding allocation. Proposed = opportunity not yet closed, Committed = opportunity closed-won and funding committed, Active = campaign is running with this funding, Completed = flight dates passed, Cancelled = allocation removed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this funding allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocation_amount. Typically matches both the opportunity and campaign currency codes.',
    `flight_end_date` DATE COMMENT 'The end date for this specific opportunity-campaign allocation. May differ from the campaigns overall end date if the opportunity only funds a portion of the campaigns flight window.',
    `flight_start_date` DATE COMMENT 'The start date for this specific opportunity-campaign allocation. May differ from the campaigns overall start date if the opportunity only funds a portion of the campaigns flight window.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this funding allocation record was last modified.',
    `notes` STRING COMMENT 'Free-form text field for additional context about this funding allocation, such as special terms, budget source details, or reconciliation notes.',
    CONSTRAINT pk_campaign_funding PRIMARY KEY(`campaign_funding_id`)
) COMMENT 'This association product represents the funding relationship between sales opportunities and advertising campaigns in media broadcasting. It captures how opportunity pipeline deals are allocated to fund specific campaigns, tracking the portion of each opportunitys budget committed to each campaign. Each record links one opportunity to one campaign with allocation amounts, percentages, flight dates, and funding status that exist only in the context of this relationship. Critical for revenue recognition, upfront commitment tracking, and reconciling sales pipeline to campaign delivery.. Existence Justification: In media broadcasting sales operations, large advertisers frequently split a single campaign across multiple sales opportunities representing different budget sources, quarters, or sales representatives. Conversely, umbrella deals and portfolio buys result in a single opportunity funding portions of multiple campaigns. Sales teams actively manage these funding allocations during upfront negotiations, tracking allocation amounts, percentages, and flight date ranges for each opportunity-campaign pairing.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` (
    `brand_id` BIGINT COMMENT 'Primary key for brand',
    `parent_brand_id` BIGINT COMMENT 'Reference to the parent brand in a brand hierarchy. Used for sub-brands, regional variants, or digital extensions of a master brand. Null for top-level brands.',
    `advertiser_id` BIGINT COMMENT 'add column sales_advertiser_id (BIGINT) with FK to sales.advertiser.advertiser_id - brands belong to advertisers and need parent entity linkage',
    `brand_type` STRING COMMENT 'Classification of the brand by its primary distribution or business model: network (broadcast network), station (local affiliate), digital_platform (online property), streaming_service (SVOD/AVOD), syndication (content distributor), or studio (production house).',
    `call_sign` STRING COMMENT 'The FCC-assigned call sign for broadcast stations (e.g., WABC-TV, KNBC). Null for non-broadcast brands.',
    `brand_code` STRING COMMENT 'Short alphanumeric code used as a unique business identifier for the brand in sales systems, rate cards, and trafficking systems. Typically 3-10 uppercase characters.',
    `content_genre` STRING COMMENT 'The primary content genre or programming category associated with the brand. Used for content licensing, syndication categorization, and advertiser alignment.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand record was first created in the system. Used for audit trail and data lineage tracking.',
    `brand_description` STRING COMMENT 'Detailed narrative description of the brand, its positioning, audience, and content offering. Used in sales proposals, syndication packages, and agency presentations.',
    `distribution_channel` STRING COMMENT 'The primary distribution channel through which the brand delivers content to audiences.',
    `dma_code` STRING COMMENT 'The Nielsen Designated Market Area code representing the geographic television market. Used for local advertising sales and market-specific rate cards.',
    `is_ad_supported` BOOLEAN COMMENT 'Indicates whether the brand carries advertising inventory. True for ad-supported brands (AVOD, linear TV); false for subscription-only or ad-free brands (SVOD).',
    `is_subscription_based` BOOLEAN COMMENT 'Indicates whether the brand operates on a subscription revenue model (SVOD, cable subscription). Used to distinguish revenue streams in sales reporting.',
    `is_syndication_eligible` BOOLEAN COMMENT 'Indicates whether the brand is eligible for content syndication deals. True if the brand can license content to third-party distributors; false otherwise.',
    `launch_date` DATE COMMENT 'The date the brand was officially launched or made available for commercial sales and distribution.',
    `logo_url` STRING COMMENT 'URL to the official brand logo asset. Used in sales proposals, rate cards, and advertising creative materials.',
    `brand_name` STRING COMMENT 'The official name of the brand as recognized in the market and used in advertising sales, content licensing, and syndication deals.',
    `nielsen_station_code` STRING COMMENT 'The unique station or network code assigned by Nielsen for audience measurement and ratings reporting. Critical for upfront commitments and post-campaign analysis.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to the brand. Used by sales teams for context and deal-specific information.',
    `owner` STRING COMMENT 'The legal entity or corporate parent that owns the brand. Used for rights management, licensing, and syndication agreements.',
    `primary_market` STRING COMMENT 'The primary geographic market or country where the brand operates, represented as a 3-letter ISO country code (e.g., USA, CAN, GBR).',
    `programmatic_enabled` BOOLEAN COMMENT 'Indicates whether the brand supports programmatic advertising sales through automated buying platforms and real-time bidding (RTB).',
    `retirement_date` DATE COMMENT 'The date the brand was retired or discontinued from active sales and distribution. Null for active brands.',
    `sales_contact_email` STRING COMMENT 'Primary email address for sales inquiries and agency outreach for this brand. Organizational contact data classified as confidential.',
    `sales_contact_phone` STRING COMMENT 'Primary phone number for sales inquiries and agency outreach for this brand. Organizational contact data classified as confidential.',
    `salesforce_account_code` STRING COMMENT 'The unique Salesforce Account ID linking this brand to the Salesforce Media Cloud CRM system. Used for opportunity tracking, pipeline management, and sales contract association.',
    `brand_status` STRING COMMENT 'Current lifecycle status of the brand. Active brands are available for sales and trafficking; inactive brands are no longer sold; pending brands are in setup; retired brands are archived; suspended brands are temporarily unavailable.',
    `tagline` STRING COMMENT 'The official marketing tagline or slogan associated with the brand. Used in advertising creative and promotional materials.',
    `target_audience` STRING COMMENT 'The primary demographic or psychographic audience segment the brand targets (e.g., Adults 18-49, Kids 2-11, Upscale Millennials). Used for advertising sales targeting and rate card positioning.',
    `tier` STRING COMMENT 'The commercial tier or positioning of the brand in the sales hierarchy. Premium brands command higher CPM rates; value brands offer lower-cost inventory.',
    `updated_by` STRING COMMENT 'The username or identifier of the user who last updated this brand record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand record was last modified. Used for audit trail, change tracking, and data synchronization.',
    `upfront_participation` BOOLEAN COMMENT 'Indicates whether the brand participates in the annual upfront advertising sales market. True for brands that sell inventory in upfront commitments; false for scatter-only brands.',
    `website_url` STRING COMMENT 'The primary website URL for the brand. Used for digital advertising integration, content syndication links, and agency reference.',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master reference table for brand. Referenced by brand_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` (
    `sales_team_id` BIGINT COMMENT 'Primary key for sales_team',
    `employee_id` BIGINT COMMENT 'Identifier of the sales manager or director who leads this sales team.',
    `parent_sales_team_id` BIGINT COMMENT 'Identifier of the parent sales team if this team is part of a hierarchical sales organization structure. Null for top-level teams.',
    `channel_focus` STRING COMMENT 'The distribution channel or platform this sales team primarily sells inventory or content for.',
    `commission_structure` STRING COMMENT 'The commission or incentive structure applied to this sales team (e.g., flat rate per deal, tiered based on quota attainment, revenue share percentage).',
    `contact_email` STRING COMMENT 'Primary email address for contacting the sales team or team manager.',
    `contact_phone` STRING COMMENT 'Primary phone number for reaching the sales team or team manager.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales team record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quota and revenue targets (e.g., USD, GBP, EUR).',
    `effective_end_date` DATE COMMENT 'Date when this sales team was dissolved, merged, or became inactive. Null for currently active teams.',
    `effective_start_date` DATE COMMENT 'Date when this sales team was established or became active in the organization.',
    `market_segment` STRING COMMENT 'The market segment or customer category this sales team focuses on (e.g., local advertisers, national agencies, direct clients, programmatic buyers).',
    `notes` STRING COMMENT 'Free-form notes or comments about the sales team, including special responsibilities, strategic focus areas, or organizational context.',
    `office_location` STRING COMMENT 'Primary office location or city where this sales team is based (e.g., New York, Los Angeles, Chicago).',
    `product_focus` STRING COMMENT 'Primary product or content type this sales team specializes in selling (e.g., linear TV spots, streaming inventory, sports programming, news sponsorships).',
    `quota_amount` DECIMAL(18,2) COMMENT 'The revenue or sales target assigned to this team for the current fiscal period, expressed in the base currency.',
    `quota_period` STRING COMMENT 'The time period over which the sales quota is measured (e.g., monthly, quarterly, annual, upfront season).',
    `region` STRING COMMENT 'Geographic region or market territory assigned to this sales team (e.g., Northeast, West Coast, National, International).',
    `salesforce_team_code` STRING COMMENT 'External identifier for this sales team in Salesforce Media Cloud, used for integration and synchronization.',
    `sales_team_status` STRING COMMENT 'Current operational status of the sales team indicating whether it is actively selling, temporarily suspended, or undergoing organizational changes.',
    `team_code` STRING COMMENT 'Short alphanumeric code used to identify the sales team in systems and reports (e.g., ECAS, NSYN, DSW).',
    `team_name` STRING COMMENT 'Official name of the sales team (e.g., East Coast Advertising Sales, National Syndication Team, Digital Sales West).',
    `team_size` STRING COMMENT 'Number of active sales representatives or account executives currently assigned to this team.',
    `team_type` STRING COMMENT 'Classification of the sales team based on the primary revenue stream or sales function they manage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sales team record was last modified in the system.',
    CONSTRAINT pk_sales_team PRIMARY KEY(`sales_team_id`)
) COMMENT 'Master reference table for sales_team. Referenced by sales_team_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` (
    `sales_product_id` BIGINT COMMENT 'Primary key for product',
    `product_id` BIGINT COMMENT 'add column billing_product_id (BIGINT) with FK to billing.product.product_id - sales products must link to billing products for order-to-cash reconciliation',
    `audience_demographic` STRING COMMENT 'Target audience demographic profile for the product (e.g., Adults 18-49, Women 25-54).',
    `available_from_date` DATE COMMENT 'Date when this product becomes available for sale and booking.',
    `available_until_date` DATE COMMENT 'Date when this product is no longer available for sale, applicable to seasonal or limited-time offerings.',
    `base_rate` DECIMAL(18,2) COMMENT 'Standard list price for one unit of the product before discounts, premiums, or negotiated adjustments.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Standard commission percentage paid to sales representatives or agencies on sales of this product.',
    `content_rating` STRING COMMENT 'Age-appropriateness or content rating associated with the programming or content (e.g., TV-PG, TV-14, TV-MA).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base rate and pricing.',
    `daypart` STRING COMMENT 'Broadcast daypart or time segment when the product is available (e.g., Prime Time, Early Morning, Late Night).',
    `sales_product_description` STRING COMMENT 'Detailed description of the product, including its features, benefits, and target audience.',
    `duration_seconds` STRING COMMENT 'Length of the advertising spot or content segment in seconds, applicable to time-based media products.',
    `effective_date` DATE COMMENT 'Date when the current version of this product definition became effective, used for rate card versioning and historical tracking.',
    `estimated_reach` BIGINT COMMENT 'Projected number of unique viewers, listeners, or users reached by one unit of this product.',
    `expiration_date` DATE COMMENT 'Date when the current version of this product definition expires and is superseded by a new version.',
    `genre` STRING COMMENT 'Genre or category of the content associated with this product (e.g., News, Sports, Drama, Comedy).',
    `geographic_market` STRING COMMENT 'Geographic market or designated market area (DMA) where the product is available for sale.',
    `inventory_type` STRING COMMENT 'Classification of inventory availability and priority: guaranteed delivery, preemptible by higher-value bookings, remnant unsold inventory, or programmatically traded.',
    `is_makegood_eligible` BOOLEAN COMMENT 'Indicates whether this product is eligible for makegood compensation if delivery guarantees are not met.',
    `is_premium` BOOLEAN COMMENT 'Indicates whether this is a premium product commanding higher rates due to high demand, exclusive positioning, or superior audience quality.',
    `is_sponsorable` BOOLEAN COMMENT 'Indicates whether this product can be sold as a sponsorship package with brand integration opportunities.',
    `maximum_order_quantity` STRING COMMENT 'Maximum number of units that can be purchased in a single order for this product, used to manage inventory scarcity.',
    `minimum_order_quantity` STRING COMMENT 'Minimum number of units that must be purchased in a single order for this product.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product record was last modified.',
    `sales_product_name` STRING COMMENT 'Human-readable name of the advertising or content product offered for sale.',
    `notes` STRING COMMENT 'Additional notes, special instructions, or internal comments about the product for sales and operations teams.',
    `platform` STRING COMMENT 'Specific platform or network where the product is distributed (e.g., ABC Network, Hulu, ESPN+).',
    `product_category` STRING COMMENT 'Media channel category for the product, indicating the distribution platform or medium.',
    `product_manager_name` STRING COMMENT 'Name of the product manager or business owner responsible for this product offering.',
    `product_type` STRING COMMENT 'Classification of the product by its commercial nature: advertising inventory, content licensing, syndication rights, or distribution deals.',
    `sales_channel` STRING COMMENT 'Primary sales channel or market through which this product is sold.',
    `sales_product_status` STRING COMMENT 'Current lifecycle status of the product in the sales catalog.',
    `unit_of_measure` STRING COMMENT 'The standard unit by which this product is sold and measured (e.g., 30-second spot, thousand impressions, episode license).',
    CONSTRAINT pk_sales_product PRIMARY KEY(`sales_product_id`)
) COMMENT 'Master reference table for product. Referenced by product_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_brief` (
    `sales_brief_id` BIGINT COMMENT 'Primary key for proposal',
    `campaign_id` BIGINT COMMENT 'Auto-generated FK linking siloed proposal to campaign',
    `advertiser_id` BIGINT COMMENT 'add column sales_advertiser_id (BIGINT) with FK to sales.advertiser.advertiser_id - proposals are created for specific advertisers and need direct linkage',
    `rep_id` BIGINT COMMENT 'add column sales_rep_id (BIGINT) with FK to sales.rep.rep_id - proposals are owned by sales reps who manage the client relationship',
    CONSTRAINT pk_sales_brief PRIMARY KEY(`sales_brief_id`)
) COMMENT 'A formal commercial offer presented to an advertiser, agency, or content buyer in response to an RFP or proactive pitch. Captures proposal version, total proposed value, CPM/GRP targets, daypart mix, platform mix (linear, OTT, FAST, AVOD), content adjacency preferences, audience demographic targets, flight start and end dates, proposal status (draft, submitted, revised, accepted, rejected), and expiry date. Linked to an opportunity and one or more rate cards. Sourced from Salesforce Media Cloud Proposal/Quote object.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Primary key for proposal',
    `advertiser_id` BIGINT COMMENT 'proposals are created for specific advertisers and need direct linkage',
    `rep_id` BIGINT COMMENT 'proposals are owned by sales reps who manage the client relationship',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Proposal records for sales opportunities';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_makegood_for_line_id` FOREIGN KEY (`makegood_for_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ADD CONSTRAINT `fk_sales_campaign_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ADD CONSTRAINT `fk_sales_sales_agency_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_original_spot_ad_spot_id` FOREIGN KEY (`original_spot_ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`brand`(`brand_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ADD CONSTRAINT `fk_sales_isci_creative_previous_version_isci_creative_id` FOREIGN KEY (`previous_version_isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_ad_sales_order_id` FOREIGN KEY (`ad_sales_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order`(`ad_sales_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_makegood_id` FOREIGN KEY (`makegood_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`makegood`(`makegood_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ADD CONSTRAINT `fk_sales_affidavit_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ADD CONSTRAINT `fk_sales_makegood_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_rfp_id` FOREIGN KEY (`rfp_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rfp`(`rfp_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ADD CONSTRAINT `fk_sales_sales_proposal_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ADD CONSTRAINT `fk_sales_advertising_audience_guarantee_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ADD CONSTRAINT `fk_sales_dai_event_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ADD CONSTRAINT `fk_sales_impression_delivery_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ADD CONSTRAINT `fk_sales_sales_scatter_order_scatter_order_id` FOREIGN KEY (`scatter_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`scatter_order`(`scatter_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ADD CONSTRAINT `fk_sales_sponsorship_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ADD CONSTRAINT `fk_sales_political_ad_disclosure_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ADD CONSTRAINT `fk_sales_political_ad_disclosure_ad_spot_id` FOREIGN KEY (`ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ADD CONSTRAINT `fk_sales_political_ad_disclosure_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ADD CONSTRAINT `fk_sales_political_ad_disclosure_isci_creative_id` FOREIGN KEY (`isci_creative_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`isci_creative`(`isci_creative_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_parent_account_sales_account_id` FOREIGN KEY (`parent_account_sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ADD CONSTRAINT `fk_sales_sales_account_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ADD CONSTRAINT `fk_sales_sales_contact_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ADD CONSTRAINT `fk_sales_sales_contact_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ADD CONSTRAINT `fk_sales_sales_contact_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sales_team_id` FOREIGN KEY (`sales_team_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_team`(`sales_team_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_sales_product_id` FOREIGN KEY (`sales_product_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_product`(`sales_product_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_sales_proposal_id` FOREIGN KEY (`sales_proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_proposal`(`sales_proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ADD CONSTRAINT `fk_sales_upfront_commitment_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ADD CONSTRAINT `fk_sales_upfront_commitment_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ADD CONSTRAINT `fk_sales_upfront_commitment_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ADD CONSTRAINT `fk_sales_upfront_commitment_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ADD CONSTRAINT `fk_sales_upfront_commitment_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`scatter_order` ADD CONSTRAINT `fk_sales_scatter_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`scatter_order` ADD CONSTRAINT `fk_sales_scatter_order_upfront_commitment_id` FOREIGN KEY (`upfront_commitment_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment`(`upfront_commitment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_sales_proposal_id` FOREIGN KEY (`sales_proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_proposal`(`sales_proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ADD CONSTRAINT `fk_sales_ad_sales_order_upfront_commitment_id` FOREIGN KEY (`upfront_commitment_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment`(`upfront_commitment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_proposal_line_id` FOREIGN KEY (`proposal_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`proposal_line`(`proposal_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ADD CONSTRAINT `fk_sales_content_license_deal_sales_team_id` FOREIGN KEY (`sales_team_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_team`(`sales_team_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ADD CONSTRAINT `fk_sales_sales_syndication_deal_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ADD CONSTRAINT `fk_sales_carriage_deal_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ADD CONSTRAINT `fk_sales_agency_commission_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ADD CONSTRAINT `fk_sales_agency_commission_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ADD CONSTRAINT `fk_sales_agency_commission_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_manager_rep_id` FOREIGN KEY (`manager_rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ADD CONSTRAINT `fk_sales_rep_sales_team_id` FOREIGN KEY (`sales_team_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_team`(`sales_team_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ADD CONSTRAINT `fk_sales_sales_territory_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ADD CONSTRAINT `fk_sales_sales_territory_sales_team_id` FOREIGN KEY (`sales_team_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_team`(`sales_team_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ADD CONSTRAINT `fk_sales_sales_territory_parent_territory_sales_territory_id` FOREIGN KEY (`parent_territory_sales_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ADD CONSTRAINT `fk_sales_rfp_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ADD CONSTRAINT `fk_sales_rfp_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ADD CONSTRAINT `fk_sales_rfp_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ADD CONSTRAINT `fk_sales_rfp_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`order_line`(`order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_ad_pod_id` FOREIGN KEY (`ad_pod_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_pod`(`ad_pod_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_sales_proposal_id` FOREIGN KEY (`sales_proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_proposal`(`sales_proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ADD CONSTRAINT `fk_sales_avail_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ADD CONSTRAINT `fk_sales_upfront_option_exercise_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ADD CONSTRAINT `fk_sales_upfront_option_exercise_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ADD CONSTRAINT `fk_sales_upfront_option_exercise_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ADD CONSTRAINT `fk_sales_upfront_option_exercise_upfront_commitment_id` FOREIGN KEY (`upfront_commitment_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment`(`upfront_commitment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_prior_forecast_id` FOREIGN KEY (`prior_forecast_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`forecast`(`forecast_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ADD CONSTRAINT `fk_sales_forecast_sales_territory_id` FOREIGN KEY (`sales_territory_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_territory`(`sales_territory_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_ad_sales_order_id` FOREIGN KEY (`ad_sales_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order`(`ad_sales_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_carriage_deal_id` FOREIGN KEY (`carriage_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`carriage_deal`(`carriage_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_content_license_deal_id` FOREIGN KEY (`content_license_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`content_license_deal`(`content_license_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_escalated_sales_deal_approval_id` FOREIGN KEY (`escalated_sales_deal_approval_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval`(`sales_deal_approval_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_sales_proposal_id` FOREIGN KEY (`sales_proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_proposal`(`sales_proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_sales_scatter_order_id` FOREIGN KEY (`sales_scatter_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order`(`sales_scatter_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_sales_syndication_deal_id` FOREIGN KEY (`sales_syndication_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal`(`sales_syndication_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ADD CONSTRAINT `fk_sales_sales_deal_approval_upfront_commitment_id` FOREIGN KEY (`upfront_commitment_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment`(`upfront_commitment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ADD CONSTRAINT `fk_sales_proposal_distribution_sales_proposal_id` FOREIGN KEY (`sales_proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_proposal`(`sales_proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ADD CONSTRAINT `fk_sales_proposal_distribution_sales_contact_id` FOREIGN KEY (`sales_contact_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_contact`(`sales_contact_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ADD CONSTRAINT `fk_sales_proposal_distribution_proposal_sales_contact_id` FOREIGN KEY (`proposal_sales_contact_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_contact`(`sales_contact_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ADD CONSTRAINT `fk_sales_proposal_distribution_contact_sales_contact_id` FOREIGN KEY (`contact_sales_contact_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_contact`(`sales_contact_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ADD CONSTRAINT `fk_sales_facility_service_agreement_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ADD CONSTRAINT `fk_sales_facility_service_agreement_sales_account_id` FOREIGN KEY (`sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_account`(`sales_account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ADD CONSTRAINT `fk_sales_campaign_funding_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ADD CONSTRAINT `fk_sales_campaign_funding_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ADD CONSTRAINT `fk_sales_brand_parent_brand_id` FOREIGN KEY (`parent_brand_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`brand`(`brand_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ADD CONSTRAINT `fk_sales_brand_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ADD CONSTRAINT `fk_sales_sales_team_parent_sales_team_id` FOREIGN KEY (`parent_sales_team_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_team`(`sales_team_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_brief` ADD CONSTRAINT `fk_sales_sales_brief_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_brief` ADD CONSTRAINT `fk_sales_sales_brief_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_brief` ADD CONSTRAINT `fk_sales_sales_brief_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`rep`(`rep_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Executive ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `affidavit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'weekly|monthly|end_of_flight|milestone');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `makegood_for_line_id` SET TAGS ('dbx_business_glossary_term' = 'Makegood For Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `makegood_for_line_id` SET TAGS ('dbx_self_ref_relationship' = 'makegood');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tertiary_advertiser_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tertiary_advertiser_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tertiary_advertiser_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Identifier');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `abr_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Abr Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `original_spot_ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Original Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_business_glossary_term' = 'Delivery Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `grp_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Impressions Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` SET TAGS ('dbx_subdomain' = 'creative_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Commercial Identification (ISCI) Creative ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `previous_version_isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Version ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `content_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Standards Clearance Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_business_glossary_term' = 'Aspect Ratio');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `aspect_ratio` SET TAGS ('dbx_value_regex' = '16:9|4:3|1:1|9:16|21:9');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `audio_standard` SET TAGS ('dbx_business_glossary_term' = 'Audio Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `audio_standard` SET TAGS ('dbx_value_regex' = 'stereo|dolby_digital|dolby_atmos|dts|aac|mono');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Checksum (MD5 Hash)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_value_regex' = '^[a-f0-9]{32}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `closed_caption_available` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Available');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `codec` SET TAGS ('dbx_business_glossary_term' = 'Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_description` SET TAGS ('dbx_business_glossary_term' = 'Creative Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_format` SET TAGS ('dbx_business_glossary_term' = 'Creative Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `creative_title` SET TAGS ('dbx_business_glossary_term' = 'Creative Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `dalet_asset_reference` SET TAGS ('dbx_business_glossary_term' = 'Dalet Galaxy Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Megabytes)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `frame_rate` SET TAGS ('dbx_business_glossary_term' = 'Frame Rate (Frames Per Second)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `isci_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Commercial Identification (ISCI) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `isci_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}[A-Z0-9]{4}[HMV]d{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `political_ad_indicator` SET TAGS ('dbx_business_glossary_term' = 'Political Advertisement Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `restricted_content_flags` SET TAGS ('dbx_business_glossary_term' = 'Restricted Content Flags');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `video_resolution` SET TAGS ('dbx_business_glossary_term' = 'Video Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`isci_creative` ALTER COLUMN `video_resolution` SET TAGS ('dbx_value_regex' = 'sd_480|hd_720|hd_1080|uhd_4k|uhd_8k');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `ad_title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `program_title_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `alcohol_ad_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Alcohol Ad Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `audience_target_demo` SET TAGS ('dbx_business_glossary_term' = 'Audience Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `blackout_flag` SET TAGS ('dbx_business_glossary_term' = 'Blackout Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_business_glossary_term' = 'Break Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `break_position` SET TAGS ('dbx_value_regex' = 'pre-roll|mid-roll|post-roll|interstitial|bumper|outro');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_pod` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` SET TAGS ('dbx_subdomain' = 'creative_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `affidavit_id` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `ad_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `makegood_id` SET TAGS ('dbx_business_glossary_term' = 'Makegood Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `public_inspection_file_id` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `actual_air_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `actual_spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `affidavit_number` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Billing Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `contracted_spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Contracted Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Delivery Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'electronic|email|portal|mail|fax');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Delivery Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Generation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `makegood_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `playout_system_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Playout System Log ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Preemption Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|verified|approved|disputed|resolved|billed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `scheduled_air_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `scheduled_air_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'automated_playout_log|manual_review|third_party_monitoring|client_verification');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`affidavit` ALTER COLUMN `wide_orbit_affidavit_reference` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Affidavit Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` SET TAGS ('dbx_subdomain' = 'creative_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `makegood_id` SET TAGS ('dbx_business_glossary_term' = 'Makegood Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Original Ad Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Original Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Original Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `actual_air_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `affidavit_date` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `affidavit_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Generated Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Makegood Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|negotiating|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `makegood_number` SET TAGS ('dbx_business_glossary_term' = 'Makegood Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `makegood_number` SET TAGS ('dbx_value_regex' = '^MG-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Makegood Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `original_actual_grp` SET TAGS ('dbx_business_glossary_term' = 'Original Actual Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `original_contracted_grp` SET TAGS ('dbx_business_glossary_term' = 'Original Contracted Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `original_daypart` SET TAGS ('dbx_business_glossary_term' = 'Original Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `original_program_name` SET TAGS ('dbx_business_glossary_term' = 'Original Program Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `original_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Original Scheduled Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `original_scheduled_time` SET TAGS ('dbx_business_glossary_term' = 'Original Scheduled Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `original_spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Original Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `original_spot_rate` SET TAGS ('dbx_business_glossary_term' = 'Original Spot Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `original_spot_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `proposed_daypart` SET TAGS ('dbx_business_glossary_term' = 'Proposed Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `proposed_estimated_grp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Estimated Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `proposed_program_name` SET TAGS ('dbx_business_glossary_term' = 'Proposed Program Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `proposed_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Replacement Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `proposed_replacement_time` SET TAGS ('dbx_business_glossary_term' = 'Proposed Replacement Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `proposed_spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Proposed Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Makegood Reason Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'preemption|technical_failure|ratings_shortfall|program_cancellation|schedule_change|weather_emergency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Makegood Reason Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Makegood Resolution Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`makegood` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|scheduled|aired|cancelled|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `sales_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Proposal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Executive Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Account Executive Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `rfp_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `accepted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accepted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `campaign_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `campaign_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `cancellation_terms` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `channel_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_business_glossary_term' = 'Competitive Situation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `competitive_situation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `content_adjacency_preferences` SET TAGS ('dbx_business_glossary_term' = 'Content Adjacency Preferences');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `cprp` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `daypart_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `demographic_target` SET TAGS ('dbx_business_glossary_term' = 'Demographic Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|programmatic|direct');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `net_proposed_value` SET TAGS ('dbx_business_glossary_term' = 'Net Proposed Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Proposal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `platform_mix` SET TAGS ('dbx_business_glossary_term' = 'Platform Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposal_description` SET TAGS ('dbx_business_glossary_term' = 'Proposal Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposal_name` SET TAGS ('dbx_business_glossary_term' = 'Proposal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposal_source` SET TAGS ('dbx_business_glossary_term' = 'Proposal Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposal_source` SET TAGS ('dbx_value_regex' = 'rfp|proactive_pitch|renewal|upsell|cross_sell');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|negotiating|accepted|rejected|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'advertising|content_licensing|syndication|distribution|sponsorship|upfront');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposed_frequency` SET TAGS ('dbx_business_glossary_term' = 'Proposed Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposed_grp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Proposed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposed_reach` SET TAGS ('dbx_business_glossary_term' = 'Proposed Reach Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `proposed_trp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejected Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `spot_length_mix_summary` SET TAGS ('dbx_business_glossary_term' = 'Spot Length Mix Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Submitted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `target_cpm` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `terms_and_conditions` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `total_proposed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Proposed Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_proposal` ALTER COLUMN `win_probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Win Probability Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` SET TAGS ('dbx_subdomain' = 'deal_execution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Executive Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `tertiary_upfront_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `tertiary_upfront_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `tertiary_upfront_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` SET TAGS ('dbx_subdomain' = 'creative_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `advertising_audience_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Advertising Audience Guarantee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `contracted_grp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_business_glossary_term' = 'Contracted Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `contracted_trp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Target Rating Point (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `delivered_grp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `delivered_impressions` SET TAGS ('dbx_business_glossary_term' = 'Delivered Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `delivered_trp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Target Rating Point (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `delivery_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `delivery_variance_grp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Variance Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `guarantee_number` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `guarantee_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `guarantee_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `guarantee_status` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `guarantee_status` SET TAGS ('dbx_value_regex' = 'on_track|at_risk|underdelivered|fulfilled|cancelled');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `last_measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Measurement Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `makegood_grp_owed` SET TAGS ('dbx_business_glossary_term' = 'Makegood Gross Rating Point (GRP) Owed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `makegood_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'nielsen|comscore|rentrak|internal|other');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `network_station_code` SET TAGS ('dbx_business_glossary_term' = 'Network Station Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `next_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Evaluation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertising_audience_guarantee` ALTER COLUMN `underdelivery_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Underdelivery Threshold Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` SET TAGS ('dbx_subdomain' = 'creative_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `dai_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `dai_media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Content Asset ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Stream Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `revenue_recognition_event_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_business_glossary_term' = 'SCTE (Society of Cable Telecommunications Engineers) Cue ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `content_asset_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `ad_decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ad Decision Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `ad_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ad Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `ad_server_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Ad Server Transaction ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `bid_price_cpm` SET TAGS ('dbx_business_glossary_term' = 'Bid Price CPM (Cost Per Mille)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `bid_price_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `cdn_node_reference` SET TAGS ('dbx_business_glossary_term' = 'CDN (Content Delivery Network) Node ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `click_through_url` SET TAGS ('dbx_business_glossary_term' = 'Click-Through URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `completion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Completion Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `dai_platform_name` SET TAGS ('dbx_business_glossary_term' = 'DAI (Dynamic Ad Insertion) Platform Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `dai_platform_version` SET TAGS ('dbx_business_glossary_term' = 'DAI (Dynamic Ad Insertion) Platform Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `delivery_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'smart_tv|mobile_phone|tablet|desktop|set_top_box|gaming_console');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `fallback_reason` SET TAGS ('dbx_business_glossary_term' = 'Fallback Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `geo_location_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `impression_fired_flag` SET TAGS ('dbx_business_glossary_term' = 'Impression Fired Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `impression_fired_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Impression Fired Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `impression_tracking_url` SET TAGS ('dbx_business_glossary_term' = 'Impression Tracking URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `insertion_point_timecode` SET TAGS ('dbx_business_glossary_term' = 'Insertion Point Timecode');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `insertion_status` SET TAGS ('dbx_business_glossary_term' = 'Insertion Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `insertion_status` SET TAGS ('dbx_value_regex' = 'inserted|fallback|no_fill|error|skipped');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'ott|linear|vod|fast');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `privacy_signal` SET TAGS ('dbx_business_glossary_term' = 'Privacy Signal');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `quartile_reached` SET TAGS ('dbx_business_glossary_term' = 'Quartile Reached');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `quartile_reached` SET TAGS ('dbx_value_regex' = 'start|first_quartile|midpoint|third_quartile|complete|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `user_consent_status` SET TAGS ('dbx_business_glossary_term' = 'User Consent Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `user_consent_status` SET TAGS ('dbx_value_regex' = 'granted|denied|not_required|unknown');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `user_interaction_type` SET TAGS ('dbx_business_glossary_term' = 'User Interaction Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `user_interaction_type` SET TAGS ('dbx_value_regex' = 'none|click|skip|pause|mute|expand');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `viewability_status` SET TAGS ('dbx_business_glossary_term' = 'Viewability Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`dai_event` ALTER COLUMN `viewability_status` SET TAGS ('dbx_value_regex' = 'viewable|not_viewable|unmeasured');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` SET TAGS ('dbx_subdomain' = 'creative_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `impression_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Impression Delivery ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `device_type_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_business_glossary_term' = 'Stream Session ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `playback_session_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `scte_marker_id` SET TAGS ('dbx_business_glossary_term' = 'Society of Cable Telecommunications Engineers (SCTE) Cue ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Audience Segment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `streaming_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Streaming Endpoint Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `geo_target_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Target Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`impression_delivery` ALTER COLUMN `geo_target_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` SET TAGS ('dbx_subdomain' = 'deal_execution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `sales_scatter_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Scatter Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `ad_billing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Billing Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Executive ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `scatter_order_id` SET TAGS ('dbx_business_glossary_term' = 'Scatter Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `cancellation_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `contract_terms` SET TAGS ('dbx_business_glossary_term' = 'Contract Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `delivered_grps` SET TAGS ('dbx_business_glossary_term' = 'Delivered Gross Rating Points (GRPs)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `delivered_impressions` SET TAGS ('dbx_business_glossary_term' = 'Delivered Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'pending|partial|complete|under_delivered|over_delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `inventory_type` SET TAGS ('dbx_value_regex' = 'linear|vod|ott|digital|streaming');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'national|local|regional|dma_specific');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `negotiated_cpm` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `negotiated_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `negotiated_cprp` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `negotiated_cprp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `net_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Order Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Scatter Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Scatter Order Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Distribution Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'broadcast|cable|satellite|streaming|mobile|web');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Political Advertisement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `preemptibility_class` SET TAGS ('dbx_business_glossary_term' = 'Preemptibility Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `preemptibility_class` SET TAGS ('dbx_value_regex' = 'non_preemptible|preemptible_with_notice|immediately_preemptible');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `preemption_protection_level` SET TAGS ('dbx_business_glossary_term' = 'Preemption Protection Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `preemption_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Preemption Risk Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|priority|premium|guaranteed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `requested_air_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Air End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `requested_air_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Air Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `requested_grps` SET TAGS ('dbx_business_glossary_term' = 'Requested Gross Rating Points (GRPs)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `requested_impressions` SET TAGS ('dbx_business_glossary_term' = 'Requested Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `requested_spots` SET TAGS ('dbx_business_glossary_term' = 'Requested Spot Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `requires_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Clearance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|agency|programmatic|network');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `scatter_cpm_amount` SET TAGS ('dbx_business_glossary_term' = 'Scatter Cost Per Mille (CPM) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `target_frequency` SET TAGS ('dbx_business_glossary_term' = 'Target Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `target_reach_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Reach Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `target_trp` SET TAGS ('dbx_business_glossary_term' = 'Target Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `total_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Order Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `total_spots_ordered` SET TAGS ('dbx_business_glossary_term' = 'Total Spots Ordered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `wide_orbit_order_number` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_scatter_order` ALTER COLUMN `wide_orbit_order_number` SET TAGS ('dbx_value_regex' = '^SO-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `quaternary_sponsorship_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `quaternary_sponsorship_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `quaternary_sponsorship_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `tertiary_sponsorship_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Executive Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `tertiary_sponsorship_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `tertiary_sponsorship_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Program Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `billboard_count` SET TAGS ('dbx_business_glossary_term' = 'Billboard Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `category_exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Category Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `deliverables_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `exclusive_category` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `exclusivity_terms` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `fulfillment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'not started|in progress|partially fulfilled|fully fulfilled|overdelivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `logo_placement_flag` SET TAGS ('dbx_business_glossary_term' = 'Logo Placement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `platform_distribution` SET TAGS ('dbx_business_glossary_term' = 'Platform Distribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `product_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Integration Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `sponsored_content_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `sponsored_content_type` SET TAGS ('dbx_value_regex' = 'program|series|segment|event|daypart|channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `sponsored_program_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Program Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `sponsorship_type` SET TAGS ('dbx_value_regex' = 'presenting sponsor|title sponsor|segment sponsor|branded content|product integration|event sponsor');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sponsorship` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Value Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` SET TAGS ('dbx_subdomain' = 'creative_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `political_ad_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Disclosure ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `isci_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Isci Creative Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `public_inspection_file_id` SET TAGS ('dbx_business_glossary_term' = 'Public Inspection File Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `air_date` SET TAGS ('dbx_business_glossary_term' = 'Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `air_time` SET TAGS ('dbx_business_glossary_term' = 'Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `candidate_name` SET TAGS ('dbx_business_glossary_term' = 'Candidate Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `candidate_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `candidate_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `candidate_office` SET TAGS ('dbx_business_glossary_term' = 'Candidate Office');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `disclosure_number` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_value_regex' = 'filed|pending|amended|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `disclosure_text` SET TAGS ('dbx_business_glossary_term' = 'FCC-Required Disclosure Text');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `election_date` SET TAGS ('dbx_business_glossary_term' = 'Election Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `election_type` SET TAGS ('dbx_business_glossary_term' = 'Election Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `election_type` SET TAGS ('dbx_value_regex' = 'primary|general|special|runoff|recall');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `equal_time_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Equal Time Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `lowest_unit_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Lowest Unit Rate (LUR) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `lowest_unit_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Lowest Unit Rate (LUR) Applied Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `political_ad_type` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `political_ad_type` SET TAGS ('dbx_value_regex' = 'candidate|ballot_issue|pac|independent_expenditure|electioneering_communication|issue_advocacy');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `reasonable_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Reasonable Access Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `sponsor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `sponsor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Contact Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `sponsor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `sponsoring_organization` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Organization');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `spot_rate_charged` SET TAGS ('dbx_business_glossary_term' = 'Spot Rate Charged');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `station_call_sign` SET TAGS ('dbx_business_glossary_term' = 'Station Call Sign');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `station_call_sign` SET TAGS ('dbx_value_regex' = '^[KW][A-Z]{3,4}(-TV|-FM|-AM)?$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`political_ad_disclosure` ALTER COLUMN `total_spots_contracted` SET TAGS ('dbx_business_glossary_term' = 'Total Spots Contracted');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `parent_account_sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sales Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_account` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `sales_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contact Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `sales_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `sales_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `sales_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `budget_authority_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Authority in United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `budget_authority_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `contact_source` SET TAGS ('dbx_business_glossary_term' = 'Contact Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `contact_source` SET TAGS ('dbx_value_regex' = 'upfront_event|trade_show|referral|inbound_inquiry|purchased_list|partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|departed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `decision_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Decision Authority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `decision_authority_level` SET TAGS ('dbx_value_regex' = 'final_approver|recommender|influencer|gatekeeper');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Mailing State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `next_follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Next Follow-Up Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-In Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_business_glossary_term' = 'Phone Opt-In Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `opt_in_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'Short Message Service (SMS) Opt-In Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|video_conference|in_person');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_business_glossary_term' = 'Relationship Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|standard|new');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'media_buyer|media_planner|brand_manager|legal_counsel|finance_approver|agency_executive');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_contact` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Executive Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `sales_team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Marketing Objective');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `competitive_displacement` SET TAGS ('dbx_business_glossary_term' = 'Competitive Displacement Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP) Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|direct|programmatic_guaranteed|content_license|syndication');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `demographic_target` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic Audience');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Deal Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Forecast Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'pipeline|best_case|commit|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `is_upfront` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sales Activity Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_notes` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason Detailed Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_value_regex' = 'budget|timing|competitor|no_decision|product_fit|pricing');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `next_step` SET TAGS ('dbx_business_glossary_term' = 'Next Action Step');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_value_regex' = '^OPP-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `probability` SET TAGS ('dbx_business_glossary_term' = 'Close Probability Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Media Product Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `requires_makegood` SET TAGS ('dbx_business_glossary_term' = 'Makegood Requirement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'prospecting|qualification|proposal|negotiation|closed_won|closed_lost');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposal_line_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Line Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `sales_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `sales_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `cprp` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|proposed|negotiating|accepted|rejected|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Distribution Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_grp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Proposed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_trp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Unit Length in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unit Quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` SET TAGS ('dbx_subdomain' = 'deal_execution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `upfront_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Commitment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `rep_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `adjusted_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Commitment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `cancellation_option_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Option Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_business_glossary_term' = 'Commitment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `committed_grp_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Gross Rating Point (GRP) Volume');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `committed_impression_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Impression Volume');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `daypart_allocation` SET TAGS ('dbx_business_glossary_term' = 'Daypart Allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `delivered_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Delivered Spend To Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `digital_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Digital Allocation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `first_option_date` SET TAGS ('dbx_business_glossary_term' = 'First Option Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `fulfillment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `guaranteed_cpm` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `linear_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Linear Allocation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `makegood_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Provision Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `remaining_commitment_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Commitment Balance');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `second_option_date` SET TAGS ('dbx_business_glossary_term' = 'Second Option Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `streaming_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Streaming Allocation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `third_option_date` SET TAGS ('dbx_business_glossary_term' = 'Third Option Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `total_cancelled_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cancelled Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Spend');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `total_exercised_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Exercised Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `upfront_year` SET TAGS ('dbx_business_glossary_term' = 'Upfront Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_commitment` ALTER COLUMN `upfront_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`scatter_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`scatter_order` SET TAGS ('dbx_subdomain' = 'deal_execution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`scatter_order` ALTER COLUMN `scatter_order_id` SET TAGS ('dbx_business_glossary_term' = 'scatter_order Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`scatter_order` ALTER COLUMN `upfront_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Commitment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `ad_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Sales Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `sales_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Proposal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `upfront_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Commitment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `affidavit_required` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `cancellation_terms` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `contracted_cpm` SET TAGS ('dbx_business_glossary_term' = 'Contracted Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|direct|programmatic_guaranteed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `grp_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `impression_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Impression Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `isci_codes` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Commercial Identification (ISCI) Codes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `makegood_provisions` SET TAGS ('dbx_business_glossary_term' = 'Makegood Provisions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'confirmed|in_flight|completed|cancelled|preempted');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `platform_mix` SET TAGS ('dbx_business_glossary_term' = 'Platform Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `preemption_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Preemption Risk Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `preemption_risk_level` SET TAGS ('dbx_value_regex' = 'non_preemptible|low|medium|high');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `priority_class` SET TAGS ('dbx_business_glossary_term' = 'Priority Class');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_sales_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `proposal_line_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Line Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Gross Rating Points (GRP) Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `actual_impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `air_date` SET TAGS ('dbx_business_glossary_term' = 'Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `air_end_date` SET TAGS ('dbx_business_glossary_term' = 'Air End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `air_start_date` SET TAGS ('dbx_business_glossary_term' = 'Air Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `contracted_grp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_business_glossary_term' = 'Contracted Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `contracted_trp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `cprp` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `cprp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `creative_title` SET TAGS ('dbx_business_glossary_term' = 'Creative Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `dai_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Enabled Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `guaranteed_flag` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Delivery Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `isci_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Standard Commercial Identification (ISCI) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `isci_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}[A-Z0-9]{4}[HMV]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Item Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Distribution Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Product Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `program_title` SET TAGS ('dbx_business_glossary_term' = 'Program Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `programmatic_flag` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `sales_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `sales_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|direct|programmatic|sponsorship|barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`order_line` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Ad Unit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` SET TAGS ('dbx_subdomain' = 'deal_execution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `content_license_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Content License Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `broadcast_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Standard Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `content_library_id` SET TAGS ('dbx_business_glossary_term' = 'Content Library Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Owner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Licensor Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `sales_team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Deal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `deal_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `deal_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Executed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Holdback Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `isan_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Standard Audiovisual Number (ISAN) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `license_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'License Fee Structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `license_fee_structure` SET TAGS ('dbx_value_regex' = 'flat_fee|per_episode|revenue_share|minimum_guarantee_plus_revenue_share|tiered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'exclusive|non-exclusive|sub-license|co-exclusive');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `platform_rights_avod` SET TAGS ('dbx_business_glossary_term' = 'Advertising-Supported Video On Demand (AVOD) Platform Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `platform_rights_fast` SET TAGS ('dbx_business_glossary_term' = 'Free Ad-Supported Streaming Television (FAST) Platform Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `platform_rights_linear` SET TAGS ('dbx_business_glossary_term' = 'Linear Platform Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `platform_rights_svod` SET TAGS ('dbx_business_glossary_term' = 'Subscription Video On Demand (SVOD) Platform Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `platform_rights_tvod` SET TAGS ('dbx_business_glossary_term' = 'Transactional Video On Demand (TVOD) Platform Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`content_license_deal` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Licensed Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` SET TAGS ('dbx_subdomain' = 'deal_execution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `sales_syndication_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Syndication Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Syndicator Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `barter_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Barter Split Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `cash_license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash License Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `cash_license_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `clearance_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Clearance Percentage Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR|AUD');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `daypart_restriction` SET TAGS ('dbx_business_glossary_term' = 'Daypart Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Syndication Deal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Syndication Deal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Syndication Deal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `deal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Deal Term in Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_value_regex' = 'upfront|monthly|quarterly|annual|upon-delivery|milestone-based');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `runs_per_episode` SET TAGS ('dbx_business_glossary_term' = 'Runs Per Episode');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `station_count` SET TAGS ('dbx_business_glossary_term' = 'Station Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `syndication_type` SET TAGS ('dbx_business_glossary_term' = 'Syndication Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `syndication_type` SET TAGS ('dbx_value_regex' = 'first-run|off-network|barter|cash-plus-barter|cash');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_syndication_deal` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Syndication Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` SET TAGS ('dbx_subdomain' = 'deal_execution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `carriage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `distribution_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Origination Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `advertising_revenue_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Advertising Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `advertising_revenue_share_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `blackout_zone_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Zone Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `carriage_fee_per_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Per Subscriber Per Month');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `carriage_fee_per_subscriber` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `carriage_status` SET TAGS ('dbx_business_glossary_term' = 'Carriage Deal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `channel_position_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Position Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Duration (Months)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Carriage Deal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Carriage Deal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Carriage Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'must_carry|retransmission_consent|negotiated_carriage|wholesale_distribution|direct_to_consumer');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'negotiation|mediation|arbitration|litigation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `hd_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'High Definition (HD) Tier Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Subscriber Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `minimum_subscriber_guarantee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `most_favored_nation_clause` SET TAGS ('dbx_business_glossary_term' = 'Most Favored Nation (MFN) Clause');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `must_carry_designation` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Designation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Carriage Deal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `payment_terms_net_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Net Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `performance_guarantee_sla` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Service Level Agreement (SLA)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `renewal_option_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `retransmission_consent_designation` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Designation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `retransmission_consent_fee` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `retransmission_consent_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `sd_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Standard Definition (SD) Tier Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`carriage_deal` ALTER COLUMN `tier_placement` SET TAGS ('dbx_business_glossary_term' = 'Tier Placement');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `agency_commission_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `applicable_deal_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Deal Types');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `commission_basis` SET TAGS ('dbx_business_glossary_term' = 'Commission Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `commission_basis` SET TAGS ('dbx_value_regex' = 'gross_billings|net_billings|net_net|revenue_recognized');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `commission_status` SET TAGS ('dbx_business_glossary_term' = 'Commission Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `commission_structure_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Structure Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `commission_structure_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `commission_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `commission_type` SET TAGS ('dbx_value_regex' = 'standard|negotiated|tiered|performance_based|flat_fee|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|[0-9]{2})$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commission Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `order_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Gross Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `order_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Net Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `override_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Override Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_memo|offset');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|reconciled|discrepancy_found|escalated');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`agency_commission` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Rep Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `manager_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Sales Representative ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `sales_team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `account_portfolio_segment` SET TAGS ('dbx_business_glossary_term' = 'Account Portfolio Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Sales Quota Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `annual_quota_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Assignment End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Assignment Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `commission_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Plan Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `commission_plan_type` SET TAGS ('dbx_value_regex' = 'base_plus_commission|commission_only|tiered|accelerator|team_based|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `commission_plan_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `deal_type_specialization` SET TAGS ('dbx_business_glossary_term' = 'Deal Type Specialization');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `digital_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Sales Certified Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Hire Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `rep_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `rep_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `rep_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Office Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Sales Performance Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'top_performer|exceeds_expectations|meets_expectations|needs_improvement|new_hire');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `quota_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `quota_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `quota_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quota Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `rep_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated|suspended');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `salesforce_user_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `salesforce_user_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `salesforce_user_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `territory_assignment` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Assignment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rep` ALTER COLUMN `upfront_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Upfront Sales Certified Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Representative ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `sales_team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Sales Team ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `parent_territory_sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Territory ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Manager ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `account_count` SET TAGS ('dbx_business_glossary_term' = 'Account Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `account_segment` SET TAGS ('dbx_business_glossary_term' = 'Account Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `account_segment` SET TAGS ('dbx_value_regex' = 'enterprise|major|mid_market|small_business|agency|direct');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `commission_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `dma_list` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) List');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|strategic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `product_line_focus` SET TAGS ('dbx_business_glossary_term' = 'Product Line Focus');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `revenue_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `revenue_target_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `revenue_target_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'direct|agency|programmatic|self_service|partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `scatter_market_flag` SET TAGS ('dbx_business_glossary_term' = 'Scatter Market Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'geographic|account_segment|vertical|hybrid|national|regional');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `upfront_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Upfront Participation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_territory` ALTER COLUMN `vertical_industry_focus` SET TAGS ('dbx_business_glossary_term' = 'Vertical Industry Focus');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `rfp_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `award_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Award Decision Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `awarded_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `budget_range_max` SET TAGS ('dbx_business_glossary_term' = 'Budget Range Maximum');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `budget_range_min` SET TAGS ('dbx_business_glossary_term' = 'Budget Range Minimum');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `competitive_separation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Competitive Separation Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `content_adjacency_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Content Adjacency Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `daypart_requirements` SET TAGS ('dbx_business_glossary_term' = 'Daypart Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `desired_frequency` SET TAGS ('dbx_business_glossary_term' = 'Desired Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `desired_grp_target` SET TAGS ('dbx_business_glossary_term' = 'Desired Gross Rating Point (GRP) Target');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `desired_impressions` SET TAGS ('dbx_business_glossary_term' = 'Desired Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `desired_reach_percent` SET TAGS ('dbx_business_glossary_term' = 'Desired Reach Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `platform_preference` SET TAGS ('dbx_business_glossary_term' = 'Platform Preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `pricing_model_preference` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `pricing_model_preference` SET TAGS ('dbx_value_regex' = 'cpm|cprp|flat-rate|performance-based|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `rfp_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `rfp_number` SET TAGS ('dbx_value_regex' = '^RFP-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `rfp_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `rfp_status` SET TAGS ('dbx_value_regex' = 'received|in-review|responded|awarded|lost|declined');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'agency|direct|programmatic-platform|upfront|scatter|network-referral');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `target_age_range` SET TAGS ('dbx_business_glossary_term' = 'Target Age Range');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `target_audience_description` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `target_gender` SET TAGS ('dbx_business_glossary_term' = 'Target Gender');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `target_gender` SET TAGS ('dbx_value_regex' = 'male|female|all|unspecified');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `target_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `target_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`rfp` ALTER COLUMN `target_geography` SET TAGS ('dbx_business_glossary_term' = 'Target Geography');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `avail_id` SET TAGS ('dbx_business_glossary_term' = 'Avail ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `ad_pod_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Facility Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Holding Account ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `sales_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `air_date` SET TAGS ('dbx_business_glossary_term' = 'Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `air_time` SET TAGS ('dbx_business_glossary_term' = 'Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `break_type` SET TAGS ('dbx_business_glossary_term' = 'Break Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `break_type` SET TAGS ('dbx_value_regex' = 'opening|mid_break|closing|standalone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `avail_code` SET TAGS ('dbx_business_glossary_term' = 'Avail Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `content_rating` SET TAGS ('dbx_value_regex' = 'TV-Y|TV-Y7|TV-G|TV-PG|TV-14|TV-MA');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `floor_cpm_usd` SET TAGS ('dbx_business_glossary_term' = 'Floor Cost Per Mille (CPM) USD');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `floor_cpm_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `floor_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Floor Rate USD');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `floor_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `hold_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiry Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `hold_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `preemptible_flag` SET TAGS ('dbx_business_glossary_term' = 'Preemptible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `projected_grp` SET TAGS ('dbx_business_glossary_term' = 'Projected Gross Rating Point (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `projected_impressions` SET TAGS ('dbx_business_glossary_term' = 'Projected Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Unit Length Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Window End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`avail` ALTER COLUMN `window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Window Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` SET TAGS ('dbx_subdomain' = 'deal_execution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `upfront_option_exercise_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Option Exercise ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `tertiary_upfront_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `tertiary_upfront_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `tertiary_upfront_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `upfront_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Commitment ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `adjusted_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Commitment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `amendment_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = 'budget_reallocation|market_conditions|campaign_performance|strategic_shift|advertiser_request|other');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `cancellation_reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `cancelled_amount` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `cancelled_grp_volume` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Gross Rating Point (GRP) Volume');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `committed_grp_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Gross Rating Point (GRP) Volume');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `contract_amendment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `daypart_allocation` SET TAGS ('dbx_business_glossary_term' = 'Daypart Allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `digital_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Digital Allocation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `exercise_method` SET TAGS ('dbx_business_glossary_term' = 'Exercise Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `exercise_method` SET TAGS ('dbx_value_regex' = 'email|phone|portal|meeting|automatic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `exercise_status` SET TAGS ('dbx_business_glossary_term' = 'Exercise Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `exercise_status` SET TAGS ('dbx_value_regex' = 'confirmed|partially_confirmed|cancelled|expired|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `exercised_amount` SET TAGS ('dbx_business_glossary_term' = 'Exercised Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `exercised_grp_volume` SET TAGS ('dbx_business_glossary_term' = 'Exercised Gross Rating Point (GRP) Volume');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `inventory_release_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Release Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `inventory_released_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Released Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `linear_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Linear Allocation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `option_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Option Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `option_exercise_date` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `option_exercise_number` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `option_window_number` SET TAGS ('dbx_business_glossary_term' = 'Option Window Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `original_committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Original Committed Spend');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `streaming_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Streaming Allocation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_option_exercise` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `prior_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Forecast Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `prior_forecast_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `account_segment` SET TAGS ('dbx_business_glossary_term' = 'Account Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `account_segment` SET TAGS ('dbx_value_regex' = 'enterprise|mid_market|small_business|agency|direct');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approval Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `attainment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quota Attainment Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `best_case_revenue` SET TAGS ('dbx_business_glossary_term' = 'Best Case Category Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `broadcast_year` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `carriage_revenue` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'commit|best_case|pipeline|omitted|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `closed_revenue` SET TAGS ('dbx_business_glossary_term' = 'Closed Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `commit_revenue` SET TAGS ('dbx_business_glossary_term' = 'Commit Category Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|licensing|syndication|carriage|sponsorship');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|locked|archived');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `licensing_revenue` SET TAGS ('dbx_business_glossary_term' = 'Content Licensing Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `manager_override_amount` SET TAGS ('dbx_business_glossary_term' = 'Manager Override Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `manager_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Manager Override Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `forecast_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'quarter|broadcast_year|calendar_year|month');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `pipeline_revenue` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Category Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Quota Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `scatter_revenue` SET TAGS ('dbx_business_glossary_term' = 'Scatter Market Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Submission Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Submission Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `syndication_revenue` SET TAGS ('dbx_business_glossary_term' = 'Syndication Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `total_forecasted_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Forecasted Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Forecast Update Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `update_frequency` SET TAGS ('dbx_value_regex' = 'weekly|daily|monthly|ad_hoc');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `upfront_revenue` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Revenue');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `variance_to_quota` SET TAGS ('dbx_business_glossary_term' = 'Variance to Quota');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`forecast` ALTER COLUMN `weighted_pipeline_value` SET TAGS ('dbx_business_glossary_term' = 'Weighted Pipeline Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` SET TAGS ('dbx_subdomain' = 'deal_execution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `sales_deal_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Deal Approval ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `ad_sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Sales Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `carriage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `content_license_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Content License Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `escalated_sales_deal_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated Sales Deal Approval Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `escalated_sales_deal_approval_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `sales_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Proposal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `sales_scatter_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Scatter Order Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `sales_syndication_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Syndication Deal ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `tertiary_quinary_sales_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `tertiary_quinary_sales_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `tertiary_quinary_sales_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `tertiary_sales_submitted_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `tertiary_sales_submitted_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `tertiary_sales_submitted_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `upfront_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Commitment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approval_decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approval_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approval_number` SET TAGS ('dbx_value_regex' = '^APV-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated|withdrawn|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approval_tier` SET TAGS ('dbx_business_glossary_term' = 'Approval Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approval_tier` SET TAGS ('dbx_value_regex' = 'tier_1_manager|tier_2_director|tier_3_vp|tier_4_svp|tier_5_cfo|tier_6_ceo');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approval_trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Approval Trigger Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_business_glossary_term' = 'Approver Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `below_floor_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Below Floor Pricing Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `custom_barter_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Custom Barter Arrangement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `escalated_to_tier` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `escalated_to_tier` SET TAGS ('dbx_value_regex' = 'tier_1_manager|tier_2_director|tier_3_vp|tier_4_svp|tier_5_cfo|tier_6_ceo');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `extended_payment_terms_flag` SET TAGS ('dbx_business_glossary_term' = 'Extended Payment Terms Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `finance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Finance Review Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `non_standard_cancellation_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Standard Cancellation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_deal_approval` ALTER COLUMN `value_threshold_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Value Threshold Exceeded Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` SET TAGS ('dbx_association_edges' = 'sales.sales_proposal,sales.sales_contact');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `proposal_distribution_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Distribution ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `sales_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Distribution - Sales Proposal Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `sales_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Distribution - Sales Contact Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `proposal_sales_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contact ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `contact_sales_contact_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `feedback_notes` SET TAGS ('dbx_business_glossary_term' = 'Feedback Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `opened_flag` SET TAGS ('dbx_business_glossary_term' = 'Opened Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `response_type` SET TAGS ('dbx_business_glossary_term' = 'Response Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_distribution` ALTER COLUMN `sent_date` SET TAGS ('dbx_business_glossary_term' = 'Sent Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` SET TAGS ('dbx_association_edges' = 'sales.sales_account,technology.broadcast_facility');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `facility_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Service Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `broadcast_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Service Agreement - Broadcast Facility Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Service Agreement - Sales Account Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `contracted_capacity` SET TAGS ('dbx_business_glossary_term' = 'Contracted Capacity');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `rate_card_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`facility_service_agreement` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` SET TAGS ('dbx_subdomain' = 'deal_execution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` SET TAGS ('dbx_association_edges' = 'advertising.campaign,sales.opportunity');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `campaign_funding_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Funding Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Funding - Campaign Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Funding - Opportunity Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `campaign_funding_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`campaign_funding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `parent_brand_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Brand Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `brand_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `call_sign` SET TAGS ('dbx_business_glossary_term' = 'Call Sign');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `content_genre` SET TAGS ('dbx_business_glossary_term' = 'Content Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `brand_description` SET TAGS ('dbx_business_glossary_term' = 'Brand Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Dma Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `is_ad_supported` SET TAGS ('dbx_business_glossary_term' = 'Is Ad Supported');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `is_subscription_based` SET TAGS ('dbx_business_glossary_term' = 'Is Subscription Based');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `is_syndication_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Syndication Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `logo_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Logo Url');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `nielsen_station_code` SET TAGS ('dbx_business_glossary_term' = 'Nielsen Station Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `primary_market` SET TAGS ('dbx_business_glossary_term' = 'Primary Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `programmatic_enabled` SET TAGS ('dbx_business_glossary_term' = 'Programmatic Enabled');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `sales_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Sales Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `sales_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `sales_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `sales_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Sales Contact Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `sales_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `sales_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `salesforce_account_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `tagline` SET TAGS ('dbx_business_glossary_term' = 'Brand Tagline');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `upfront_participation` SET TAGS ('dbx_business_glossary_term' = 'Upfront Participation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`brand` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Website Url');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `sales_team_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Team Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `parent_sales_team_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Team Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `channel_focus` SET TAGS ('dbx_business_glossary_term' = 'Channel Focus');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `commission_structure` SET TAGS ('dbx_business_glossary_term' = 'Commission Structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `product_focus` SET TAGS ('dbx_business_glossary_term' = 'Product Focus');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Quota Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `quota_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `quota_period` SET TAGS ('dbx_business_glossary_term' = 'Quota Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `salesforce_team_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Team Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `sales_team_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `team_code` SET TAGS ('dbx_business_glossary_term' = 'Team Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Team Size');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Team Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_team` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` SET TAGS ('dbx_subdomain' = 'creative_delivery');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `sales_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `audience_demographic` SET TAGS ('dbx_business_glossary_term' = 'Audience Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `available_from_date` SET TAGS ('dbx_business_glossary_term' = 'Available From Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `available_until_date` SET TAGS ('dbx_business_glossary_term' = 'Available Until Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `base_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `sales_product_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `estimated_reach` SET TAGS ('dbx_business_glossary_term' = 'Estimated Reach');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `genre` SET TAGS ('dbx_business_glossary_term' = 'Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `is_makegood_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Makegood Eligible');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `is_premium` SET TAGS ('dbx_business_glossary_term' = 'Is Premium');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `is_sponsorable` SET TAGS ('dbx_business_glossary_term' = 'Is Sponsorable');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `sales_product_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `product_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `sales_product_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_product` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_brief` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_brief` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_brief` ALTER COLUMN `sales_brief_id` SET TAGS ('dbx_business_glossary_term' = 'proposal Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_brief` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to campaign');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` SET TAGS ('dbx_subdomain' = 'campaign_planning');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'proposal Identifier');
