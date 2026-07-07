-- Schema for Domain: sales | Business: Media_Broadcasting | Version: v2_mvm
-- Generated on: 2026-06-30 06:39:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`sales` COMMENT 'Manages the commercial sales pipeline for advertising, content licensing, syndication, and distribution deals. Owns accounts, opportunities, proposals, rate cards, upfront commitments, agency relationships, scatter market inventory, commission structures, and executed sales contracts. Powered by Salesforce Media Cloud, this domain tracks deal stages and feeds confirmed orders to advertising trafficking and billing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` (
    `ad_order_id` BIGINT COMMENT 'Unique identifier for the advertising sales order. Primary key. System-generated surrogate key for the ad order record. | Column ad_order_id (BIGINT) in sales.ad_order',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser (brand or company) placing the advertising order. Links to advertiser master record in Salesforce Media Cloud. | Column advertiser_id (BIGINT) in sales.ad_order',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Ad orders target specific Nielsen demographic segments (A18-49, W25-54, etc.) for campaign planning, rate card pricing, and GRP/TRP guarantees. Core to media buying operations and upfront/scatter deal | Column demographic_segment_id (BIGINT) in audience.ad_order',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to sales.proposal. Business justification: An ad_order is the execution artifact created when a proposal is accepted and signed. Linking ad_order back to its originating proposal enables full deal lifecycle traceability: opportunity → proposal',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser. Nullable if direct advertiser purchase. Links to agency master record. | Column sales_agency_id (BIGINT) in sales.ad_order',
    `sales_campaign_id` BIGINT COMMENT 'Foreign key linking to sales.campaign. Business justification: Normalize campaign reference from STRING name to proper FK. Ad order should be linked to campaign master record for rollup reporting and campaign management. Currently denormalized as campaign_name ST | Column campaign_id (BIGINT) in sales.ad_order',
    `opportunity_id` BIGINT COMMENT 'External reference to the originating sales opportunity in Salesforce Media Cloud CRM. 15 or 18 character Salesforce record ID. | Column salesforce_opportunity_id (BIGINT) in sales.ad_order',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Direct-sold addressable TV ad orders target specific subscribers for personalized advertising. Critical for programmatic guaranteed deals and advanced advertising attribution in streaming platforms. E | Column subscriber_id (BIGINT) in subscriber.ad_order',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Ad orders placed against upfront deal commitments must reference the parent upfront deal for budget tracking, audience guarantee reconciliation, and scatter conversion rights management. One upfront_d',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in sales.ad_order',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in sales.ad_order',
    `affidavit_required_flag` BOOLEAN COMMENT 'Indicates whether proof of broadcast affidavits must be provided to the advertiser. True = affidavits required; False = not required. Affidavits document actual air times and are often required for political advertising. | Column affidavit_required_flag (BOOLEAN) in sales.ad_order',
    `billing_cycle` STRING COMMENT 'Frequency and timing of invoice generation for this order. Weekly = invoiced every week; Monthly = invoiced monthly; End of Flight = single invoice after campaign completion; Milestone = invoiced at defined campaign milestones. | Column billing_cycle (STRING) in sales.ad_order. Valid values are `weekly|monthly|end_of_flight|milestone`',
    `commission_rate` DECIMAL(18,2) COMMENT 'Agency commission rate as a percentage of gross order value. Standard industry rate is 15%. Applied to calculate net revenue. | Column commission_rate (DECIMAL(5,2)) in sales.ad_order',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the advertising order was confirmed by the advertiser or agency. Marks transition from pending to confirmed status. | Column confirmed_timestamp (TIMESTAMP) in sales.ad_order',
    `contracted_cpm` DECIMAL(18,2) COMMENT 'Contracted Cost Per Mille (cost per thousand impressions) for this advertising order. Key pricing metric for media buying. | Column contracted_cpm (DECIMAL(10,2)) in sales.ad_order',
    `contracted_cprp` DECIMAL(18,2) COMMENT 'Contracted Cost Per Rating Point. Pricing metric calculated as total cost divided by GRP. Used for market efficiency comparison. | Column contracted_cprp (DECIMAL(10,2)) in sales.ad_order',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in sales.ad_order',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this advertising order record was first created in the system. Audit trail field. | Column created_timestamp (TIMESTAMP) in sales.ad_order',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this order (e.g., USD, GBP, EUR). | Column currency_code (STRING) in sales.ad_order. Valid values are `^[A-Z]{3}$`',
    `daypart_mix` STRING COMMENT 'Distribution of advertising spots across broadcast dayparts (time segments of broadcast day). Examples: Prime (8pm-11pm), Early Morning (6am-9am), Late Night (11pm-2am). Stored as comma-separated daypart allocations. | Column daypart_mix (STRING) in sales.ad_order',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Total discount percentage applied to this order. May include volume discounts, promotional discounts, or negotiated rate reductions. | Column discount_percentage (DECIMAL(5,2)) in sales.ad_order',
    `flight_end_date` DATE COMMENT 'Last date the advertising campaign is scheduled to air. End of the contracted broadcast period. | Column flight_end_date (DATE) in sales.ad_order',
    `flight_start_date` DATE COMMENT 'First date the advertising campaign is scheduled to air. Beginning of the contracted broadcast period. | Column flight_start_date (DATE) in sales.ad_order',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this advertising order record was last updated. Audit trail field for change tracking. | Column last_modified_timestamp (TIMESTAMP) in sales.ad_order',
    `makegood_policy` STRING COMMENT 'Policy for providing compensatory ad spots (makegoods) if contracted delivery is not met. Standard = industry-standard makegood terms; Guaranteed = full delivery guarantee; No Makegood = no compensation; Custom = special negotiated terms. | Column makegood_policy (STRING) in sales.ad_order. Valid values are `standard|guaranteed|no_makegood|custom`',
    `market_code` STRING COMMENT 'Designated Market Area (DMA) or geographic market code where the advertising will air. Used for Nielsen ratings alignment and regional pricing. | Column market_code (STRING) in sales.ad_order',
    `mmm_adstock_decay_rate` DECIMAL(18,2) COMMENT 'Rate at which advertising effect decays over time for MMM calculations',
    `mmm_channel_contribution` DECIMAL(18,2) COMMENT 'Marketing Mix Model estimated contribution of this channel to conversions',
    `mmm_saturation_point` DECIMAL(18,2) COMMENT 'Estimated spend level at which diminishing returns begin for this channel',
    `net_order_value` DECIMAL(18,2) COMMENT 'Net revenue value after agency commissions, discounts, and adjustments. Amount recognized for revenue reporting. | Column net_order_value (DECIMAL(18,2)) in sales.ad_order',
    `order_notes` STRING COMMENT 'Free-text notes and special instructions for this advertising order. May include trafficking instructions, creative specifications, or client preferences. | Column order_notes (STRING) in sales.ad_order',
    `order_number` STRING COMMENT 'Business identifier for the advertising order. Externally-known unique order number used in Wide Orbit traffic system and client communications. Also called broadcast order number or traffic order number. | Column order_number (STRING) in sales.ad_order. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the advertising order. Draft = initial entry; Pending = awaiting approval; Confirmed = accepted by advertiser; Active = currently running; Completed = flight finished; Cancelled = terminated; Invoiced = billed. [ENUM-REF-CANDIDATE: draft|pending|confirmed|active|completed|cancelled|invoiced — 7 candidates stripped; promote to reference product] | Column order_status (STRING) in sales.ad_order',
    `order_type` STRING COMMENT 'Classification of the advertising order based on sales method. Upfront = advance advertising sales event; Scatter = last-minute ad inventory sales; Direct = direct advertiser purchase; Programmatic = automated bidding; Sponsorship = integrated brand partnership; Barter = trade arrangement. | Column order_type (STRING) in sales.ad_order. Valid values are `upfront|scatter|direct|programmatic|sponsorship|barter`',
    `payment_terms` STRING COMMENT 'Contractual payment terms for this order (e.g., Net 30, Net 60, Due on Receipt). Defines when payment is due after invoice date. | Column payment_terms (STRING) in sales.ad_order',
    `political_ad_flag` BOOLEAN COMMENT 'Indicates whether this order contains political advertising content. True = political advertising; False = commercial advertising. Political ads have special FCC disclosure and equal-time requirements. | Column political_ad_flag (BOOLEAN) in sales.ad_order',
    `product_category` STRING COMMENT 'Industry classification of the advertised product or service (e.g., automotive, pharmaceutical, retail, financial services). Used for content clearance and regulatory compliance. | Column product_category (STRING) in sales.ad_order',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in sales.ad_order',
    `target_demographic` STRING COMMENT 'Primary audience demographic segment targeted by this advertising order (e.g., Adults 18-49, Women 25-54, Men 18-34). Used for TRP calculation and spot placement. | Column target_demographic (STRING) in sales.ad_order',
    `target_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points contracted for this order. GRP = Reach × Frequency, measuring total audience delivery weight. Used for campaign performance evaluation. | Column target_grp (DECIMAL(10,2)) in sales.ad_order',
    `target_trp` DECIMAL(18,2) COMMENT 'Target Rating Points for specific demographic audience. TRP measures delivery against a defined target audience segment rather than total audience. | Column target_trp (DECIMAL(10,2)) in sales.ad_order',
    `total_contracted_value` DECIMAL(18,2) COMMENT 'Total monetary value of the advertising order across all spots and placements. Gross revenue before agency commissions and discounts. | Column total_contracted_value (DECIMAL(18,2)) in sales.ad_order',
    `total_spot_count` STRING COMMENT 'Total number of advertising spots (commercial airings) contracted in this order across all placements and dayparts. | Column total_spot_count (INT) in sales.ad_order',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in sales.ad_order',
    `wide_orbit_order_reference` STRING COMMENT 'External reference to the corresponding order record in Wide Orbit traffic and billing system. Used for cross-system reconciliation and affidavit generation. | Column wide_orbit_order_reference (STRING) in sales.ad_order',
    CONSTRAINT pk_ad_order PRIMARY KEY(`ad_order_id`)
) COMMENT 'Master record for an advertising sales order (also called a broadcast order or traffic order) placed by an advertiser or agency. Captures the commercial agreement for a campaign buy including order number, advertiser, agency, account executive, total contracted value, currency, order status (pending, confirmed, cancelled, invoiced), order type (upfront, scatter, direct, programmatic), market, daypart mix, flight dates, billing instructions, Wide Orbit order reference, and Salesforce opportunity linkage. SSOT for the advertising order lifecycle. | Unity Catalog table: media_broadcasting_ecm.sales.ad_order Integrates with Salesforce Media Cloud (sales CRM).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` (
    `ad_order_line_id` BIGINT COMMENT 'Unique identifier for the advertising order line item. Primary key. | Column ad_order_line_id (BIGINT) in sales.ad_order_line',
    `ad_order_id` BIGINT COMMENT 'Reference to the parent advertising order header. Links this line item to its containing order. | Column ad_order_id (BIGINT) in sales.ad_order_line',
    `channel_id` BIGINT COMMENT 'Reference to the broadcast network or channel where this ad line will air. Determines distribution outlet. | Column channel_id (BIGINT) in scheduling.ad_order_line',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Ad order lines specify which content version to air adjacent to (e.g., HD, specific language version, broadcast-safe cut). Trafficking and compliance require knowing the exact version. This FK enables',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Each line item specifies demographic target for GRP/TRP delivery guarantees, CPM/CPRP pricing, and makegood determination. Essential for trafficking, billing reconciliation, and audience guarantee com | Column demographic_segment_id (BIGINT) in audience.ad_order_line',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Line-level rights verification for specific content/daypart combinations. Trafficking requires granular clearance to prevent airing spots during holdback periods or outside licensed windows. Operation | Column license_agreement_id (BIGINT) in rights.ad_order_line',
    `makegood_for_line_ad_order_line_id` BIGINT COMMENT 'Reference to the original ad order line that this line is compensating for (if this is a makegood spot). Null if not a makegood. | Column makegood_for_line_id (BIGINT) in sales.ad_order_line',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Broadcast order lines are contracted against specific program schedules (e.g., primetime block, sports season). This link enables inventory availability checks, makegood processing against the correct',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Order lines target specific dayparts for inventory allocation and pricing. Fulfillment tracking, avail matching, and rate card application require linking lines to master daypart definitions. Removes  | Column scheduling_daypart_id (BIGINT) in scheduling.ad_order_line',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in sales.ad_order_line',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in sales.ad_order_line',
    `actual_grp_delivered` DECIMAL(18,2) COMMENT 'Actual Gross Rating Points (GRP) delivered based on Nielsen measurement. Used for campaign performance analysis and makegood calculation. | Column actual_grp_delivered (DECIMAL(10,2)) in sales.ad_order_line',
    `actual_impressions_delivered` BIGINT COMMENT 'Actual number of impressions delivered for this line. Sourced from DAI (Dynamic Ad Insertion) systems or CDN (Content Delivery Network) logs for digital campaigns. | Column actual_impressions_delivered (BIGINT) in sales.ad_order_line',
    `actual_spots_aired` STRING COMMENT 'Actual number of spots that successfully aired for this line. Populated from affidavit reconciliation. Used for billing and makegood determination. | Column actual_spots_aired (INT) in sales.ad_order_line',
    `attribution_model_type` STRING COMMENT 'Type of attribution model applied (first-touch, last-touch, linear, time-decay, position-based, data-driven)',
    `attribution_weight` DECIMAL(18,2) COMMENT 'Fractional credit assigned to this touchpoint in multi-touch attribution',
    `competitive_separation_category` STRING COMMENT 'Product or industry category for competitive adjacency restrictions. Prevents competing advertisers from airing in the same pod. | Column competitive_separation_category (STRING) in sales.ad_order_line',
    `contracted_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points (GRP) contracted for this line. GRP measures total audience reach multiplied by frequency. | Column contracted_grp (DECIMAL(10,2)) in sales.ad_order_line',
    `contracted_impressions` BIGINT COMMENT 'Total number of impressions (individual ad views) contracted for this line item. Used for digital and OTT (Over-The-Top) campaigns. | Column contracted_impressions (BIGINT) in sales.ad_order_line',
    `contracted_spots` STRING COMMENT 'Total number of ad spots contracted for this line item. Represents the quantity commitment. | Column contracted_spots (INT) in sales.ad_order_line',
    `contracted_trp` DECIMAL(18,2) COMMENT 'Target Rating Points (TRP) contracted for this line. TRP measures reach within a specific demographic target. | Column contracted_trp (DECIMAL(10,2)) in sales.ad_order_line',
    `conversion_path_position` STRING COMMENT 'Position of this touchpoint in the customer conversion path',
    `copy_split_rule` STRING COMMENT 'Rules defining how multiple creative versions should be split across the contracted spots (e.g., 50/50, 70/30). Used for A/B testing or creative variation. | Column copy_split_rule (STRING) in sales.ad_order_line',
    `cpm` DECIMAL(18,2) COMMENT 'Cost Per Mille (CPM) - the cost per thousand impressions. Key pricing metric for advertising efficiency. | Column cpm (DECIMAL(10,2)) in sales.ad_order_line',
    `cprp` DECIMAL(18,2) COMMENT 'Cost Per Rating Point (CPRP) - the cost to achieve one rating point. Used to compare efficiency across dayparts and programs. | Column cprp (DECIMAL(10,2)) in sales.ad_order_line',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in sales.ad_order_line',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad order line record was first created in the system. Audit trail for record creation. | Column created_timestamp (TIMESTAMP) in sales.ad_order_line',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values on this line (e.g., USD, GBP, EUR). | Column currency_code (STRING) in sales.ad_order_line. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to this line (e.g., volume discount, agency commission). Expressed as a percentage (e.g., 15.00 for 15%). | Column discount_percentage (DECIMAL(5,2)) in sales.ad_order_line',
    `flight_end_date` DATE COMMENT 'End date of the advertising flight window for this line item. Defines when spots must complete airing. | Column flight_end_date (DATE) in sales.ad_order_line',
    `flight_start_date` DATE COMMENT 'Start date of the advertising flight window for this line item. Defines when spots can begin airing. | Column flight_start_date (DATE) in sales.ad_order_line',
    `inventory_type` STRING COMMENT 'Classification of ad inventory purchase type. Upfront is advance commitment; scatter is last-minute; preemptible can be bumped; makegood compensates for missed spots. | Column inventory_type (STRING) in sales.ad_order_line. Valid values are `upfront|scatter|preemptible|fixed|bonus|makegood`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ad order line record was last updated. Audit trail for record changes. | Column last_modified_timestamp (TIMESTAMP) in sales.ad_order_line',
    `line_number` STRING COMMENT 'Sequential line number within the parent ad order. Determines ordering and display sequence of line items. | Column line_number (INT) in sales.ad_order_line',
    `line_status` STRING COMMENT 'Current lifecycle status of the ad order line. Tracks progression from booking through execution and reconciliation. [ENUM-REF-CANDIDATE: booked|confirmed|scheduled|aired|preempted|makegooded|cancelled|expired — 8 candidates stripped; promote to reference product] | Column line_status (STRING) in sales.ad_order_line',
    `line_total_amount` DECIMAL(18,2) COMMENT 'Total revenue amount for this line item (unit rate × contracted spots). Base amount before discounts or adjustments. | Column line_total_amount (DECIMAL(15,2)) in sales.ad_order_line',
    `net_amount` DECIMAL(18,2) COMMENT 'Net revenue amount after discounts and before taxes. Used for revenue recognition and financial reporting. | Column net_amount (DECIMAL(15,2)) in sales.ad_order_line',
    `position_preference` STRING COMMENT 'Preferred position within the ad pod (group of ads in a break). Premium positions command higher rates. | Column position_preference (STRING) in sales.ad_order_line. Valid values are `first_in_pod|last_in_pod|middle_in_pod|any|fixed_position`',
    `preemption_priority` STRING COMMENT 'Priority level for preemption protection (1=highest, 10=lowest). Lower-priority spots may be bumped for higher-value inventory. | Column preemption_priority (INT) in sales.ad_order_line',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for this line is recognized for financial reporting. Typically aligned with air date or campaign completion. | Column revenue_recognition_date (DATE) in sales.ad_order_line',
    `rotation_instructions` STRING COMMENT 'Instructions for rotating multiple creatives within this line (e.g., even rotation, weighted rotation, sequential). Guides playout system behavior. | Column rotation_instructions (STRING) in sales.ad_order_line',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in sales.ad_order_line',
    `special_handling_notes` STRING COMMENT 'Free-text instructions for special handling requirements (e.g., live read, sponsorship billboard, product integration). Communicated to playout operators. | Column special_handling_notes (STRING) in sales.ad_order_line',
    `spot_length_seconds` STRING COMMENT 'Duration of the advertising spot in seconds. Standard lengths are 15, 30, 60, or 120 seconds. | Column spot_length_seconds (INT) in sales.ad_order_line',
    `touchpoint_sequence_code` STRING COMMENT 'Identifier linking touchpoints in a conversion path for attribution analysis',
    `trafficking_notes` STRING COMMENT 'Internal notes for trafficking team regarding execution details, creative delivery status, or special coordination requirements. | Column trafficking_notes (STRING) in sales.ad_order_line',
    `unit_rate` DECIMAL(18,2) COMMENT 'Price per individual ad spot or unit. Base rate before volume discounts or adjustments. | Column unit_rate (DECIMAL(15,2)) in sales.ad_order_line',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in sales.ad_order_line',
    CONSTRAINT pk_ad_order_line PRIMARY KEY(`ad_order_line_id`)
) COMMENT 'Individual line item within an advertising order representing a specific buy unit — a combination of network/channel, daypart, program, spot length, unit rate, contracted GRP/TRP/impression target, and flight window. Each line maps to a specific inventory unit and carries its own status (booked, preempted, makegooded, cancelled). Includes trafficking execution details: assigned ISCI creative(s), rotation instructions, copy split rules, position preferences, competitive adjacency restrictions, and special handling notes for the playout system (Wide Orbit). Sourced from Wide Orbit order line detail. Supports revenue recognition at the line level and feeds affidavit reconciliation. | Unity Catalog table: media_broadcasting_ecm.sales.ad_order_line Integrates with Salesforce Media Cloud (sales CRM).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` (
    `sales_campaign_id` BIGINT COMMENT 'Unique identifier for the advertising campaign. Primary key. | Column campaign_id (BIGINT) in sales.campaign',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization that owns this campaign. | Column advertiser_id (BIGINT) in sales.campaign',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Campaigns define primary demographic targets that drive all downstream planning, buying, measurement, and guarantee reconciliation. Core to upfront deals, scatter buying, and Nielsen ratings analysis. | Column demographic_segment_id (BIGINT) in audience.campaign',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: A sales_campaign is the strategic execution vehicle that originates from a qualified sales opportunity. One opportunity can spawn one or more campaigns (e.g., a multi-brand advertiser opportunity). Th',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser for this campaign. Nullable if direct advertiser relationship. | Column sales_agency_id (BIGINT) in sales.campaign',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Program sponsorship campaigns in broadcast are series-specific (e.g., Title Sponsor of Drama Series X). A sales campaign must reference the sponsored series for sponsorship billing, exclusivity enfo',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Brand ambassador and celebrity spokesperson campaigns must track featured talent for exclusivity enforcement, usage rights validation, residual calculations, and clearance verification across all camp | Column talent_profile_id (BIGINT) in talent.campaign',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in sales.campaign',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in sales.campaign',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign was approved and moved from draft or proposed status to active status. | Column approved_timestamp (TIMESTAMP) in sales.campaign',
    `attribution_model_type` STRING COMMENT 'Type of attribution model applied (first-touch, last-touch, linear, time-decay, position-based, data-driven)',
    `attribution_weight` DECIMAL(18,2) COMMENT 'Fractional credit assigned to this touchpoint in multi-touch attribution',
    `campaign_code` STRING COMMENT 'External business identifier or code for the campaign used in trafficking and billing systems. | Column campaign_code (STRING) in sales.campaign',
    `campaign_name` STRING COMMENT 'Business name of the advertising campaign used for identification and reporting. | Column campaign_name (STRING) in sales.campaign',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the advertising campaign. [ENUM-REF-CANDIDATE: draft|proposed|approved|active|paused|completed|cancelled — 7 candidates stripped; promote to reference product] | Column campaign_status (STRING) in sales.campaign',
    `campaign_type` STRING COMMENT 'Classification of the campaign objective and strategy. | Column campaign_type (STRING) in sales.campaign. Valid values are `brand_awareness|direct_response|political|sponsorship|promotional|product_launch`',
    `conversion_path_position` STRING COMMENT 'Position of this touchpoint in the customer conversion path',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in sales.campaign',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was first created in the system. | Column created_timestamp (TIMESTAMP) in sales.campaign',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this campaign. | Column currency_code (STRING) in sales.campaign. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'The date when the campaign is scheduled to end. Nullable for ongoing campaigns. | Column end_date (DATE) in sales.campaign',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether this campaign is eligible for makegood compensatory ad spots if contracted delivery targets are not met. | Column makegood_eligible_flag (BOOLEAN) in sales.campaign',
    `market_type` STRING COMMENT 'Geographic market scope classification for the campaign. | Column market_type (STRING) in sales.campaign. Valid values are `national|regional|local|dma_specific`',
    `mmm_adstock_decay_rate` DECIMAL(18,2) COMMENT 'Rate at which advertising effect decays over time for MMM calculations',
    `mmm_channel_contribution` DECIMAL(18,2) COMMENT 'Marketing Mix Model estimated contribution of this channel to conversions',
    `mmm_saturation_point` DECIMAL(18,2) COMMENT 'Estimated spend level at which diminishing returns begin for this channel',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this campaign record was last modified. | Column modified_timestamp (TIMESTAMP) in sales.campaign',
    `notes` STRING COMMENT 'Free-form text field for additional campaign instructions, special requirements, or internal notes. | Column notes (STRING) in sales.campaign',
    `priority_level` STRING COMMENT 'Priority classification for ad inventory allocation and scheduling conflicts. | Column priority_level (STRING) in sales.campaign. Valid values are `standard|priority|premium|guaranteed`',
    `product_brand` STRING COMMENT 'The product, service, or brand being advertised in this campaign. | Column product_brand (STRING) in sales.campaign',
    `programmatic_enabled_flag` BOOLEAN COMMENT 'Flag indicating programmatic campaign',
    `sales_channel` STRING COMMENT 'The sales channel through which the campaign was sold (upfront advance sales, scatter last-minute, programmatic automated, direct negotiated, or sponsorship). | Column sales_channel (STRING) in sales.campaign. Valid values are `upfront|scatter|programmatic|direct|sponsorship`',
    `salesforce_campaign_reference` STRING COMMENT 'External reference identifier linking to the campaign record in Salesforce Media Cloud CRM system. | Column salesforce_campaign_reference (STRING) in sales.campaign',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in sales.campaign',
    `start_date` DATE COMMENT 'The date when the campaign is scheduled to begin airing or serving ads. | Column start_date (DATE) in sales.campaign',
    `target_cpm` DECIMAL(18,2) COMMENT 'Contracted target Cost Per Mille representing the cost per thousand impressions. | Column target_cpm (DECIMAL(10,2)) in sales.campaign',
    `target_cprp` DECIMAL(18,2) COMMENT 'Contracted target Cost Per Rating Point representing the cost to achieve one rating point. | Column target_cprp (DECIMAL(10,2)) in sales.campaign',
    `target_frequency` DECIMAL(18,2) COMMENT 'Contracted average number of times each unique audience member should be exposed to the campaign. | Column target_frequency (DECIMAL(5,2)) in sales.campaign',
    `target_grp` DECIMAL(18,2) COMMENT 'Contracted target Gross Rating Points representing the total audience reach multiplied by frequency goal for the campaign. | Column target_grp (DECIMAL(10,2)) in sales.campaign',
    `target_impressions` BIGINT COMMENT 'Contracted total number of ad impressions to be delivered across the campaign. | Column target_impressions (BIGINT) in sales.campaign',
    `target_reach_percent` DECIMAL(18,2) COMMENT 'Contracted percentage of unique audience members to be reached by the campaign. | Column target_reach_percent (DECIMAL(5,2)) in sales.campaign',
    `target_sov_percent` DECIMAL(18,2) COMMENT 'Contracted target Share of Voice representing the percentage of total advertising impressions in the category or daypart. | Column target_sov_percent (DECIMAL(5,2)) in sales.campaign',
    `target_trp` DECIMAL(18,2) COMMENT 'Contracted target Target Rating Points representing reach and frequency goals for a specific demographic segment. | Column target_trp (DECIMAL(10,2)) in sales.campaign',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The total contracted budget amount for the entire campaign across all flights and orders. | Column total_budget_amount (DECIMAL(18,2)) in sales.campaign',
    `touchpoint_sequence_code` STRING COMMENT 'Identifier linking touchpoints in a conversion path for attribution analysis',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in sales.campaign',
    CONSTRAINT pk_sales_campaign PRIMARY KEY(`sales_campaign_id`)
) COMMENT 'Advertising campaign master record representing the strategic grouping of ad orders and flights for a single advertiser objective. Tracks campaign name, advertiser, product/brand being advertised, campaign type (brand awareness, direct response, political, sponsorship), total budget, contracted reach and frequency targets, GRP/TRP goals, SOV targets, campaign status, start and end dates, and Salesforce Media Cloud campaign reference. Parent entity above ad orders and flights. | Unity Catalog table: media_broadcasting_ecm.sales.campaign';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` (
    `advertiser_id` BIGINT COMMENT 'Unique identifier for the advertiser record. Primary key. | Column advertiser_id (BIGINT) in sales.advertiser',
    `account_id` BIGINT COMMENT 'The Salesforce Media Cloud account reference linking this advertiser to CRM opportunities, campaigns, and proposals. | Column sales_account_id (BIGINT) in sales.advertiser',
    `sales_agency_id` BIGINT COMMENT 'The identifier of the advertising agency that places media buys on behalf of this advertiser, if applicable. Null if the advertiser buys direct. | Column sales_agency_id (BIGINT) in sales.advertiser',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in sales.advertiser',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in sales.advertiser',
    `account_status` STRING COMMENT 'Current lifecycle status of the advertiser account indicating whether the advertiser is actively purchasing inventory. | Column account_status (STRING) in sales.advertiser. Valid values are `active|inactive|suspended|pending_approval|closed`',
    `annual_spend_tier` STRING COMMENT 'The classification tier based on annual advertising spend volume, used for pricing, service level, and upfront negotiation priority. | Column annual_spend_tier (STRING) in sales.advertiser. Valid values are `tier_1_platinum|tier_2_gold|tier_3_silver|tier_4_bronze|tier_5_standard`',
    `billing_address_line1` STRING COMMENT 'The primary street address line for billing and invoice delivery. | Column billing_address_line1 (STRING) in sales.advertiser',
    `billing_address_line2` STRING COMMENT 'The secondary address line for suite, floor, or building information. | Column billing_address_line2 (STRING) in sales.advertiser',
    `billing_city` STRING COMMENT 'The city or municipality for the billing address. | Column billing_city (STRING) in sales.advertiser',
    `billing_country_code` STRING COMMENT 'The three-letter ISO country code for the billing address (e.g., USA, CAN, GBR). | Column billing_country_code (STRING) in sales.advertiser. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'The postal or ZIP code for the billing address. | Column billing_postal_code (STRING) in sales.advertiser',
    `billing_state_province` STRING COMMENT 'The state, province, or region for the billing address. | Column billing_state_province (STRING) in sales.advertiser',
    `contract_end_date` DATE COMMENT 'The expiration date of the current master advertising services agreement or upfront deal, if applicable. | Column contract_end_date (DATE) in sales.advertiser',
    `contract_start_date` DATE COMMENT 'The effective start date of the current master advertising services agreement or upfront deal. | Column contract_start_date (DATE) in sales.advertiser',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in sales.advertiser',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this advertiser record was first created in the system. | Column created_timestamp (TIMESTAMP) in sales.advertiser',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum outstanding balance allowed for this advertiser before credit hold is applied, in USD. | Column credit_limit_amount (DECIMAL(15,2)) in sales.advertiser',
    `credit_status` STRING COMMENT 'The credit approval status indicating whether the advertiser is authorized to purchase advertising on credit terms. | Column credit_status (STRING) in sales.advertiser. Valid values are `approved|on_hold|under_review|declined`',
    `industry_category` STRING COMMENT 'The Interactive Advertising Bureau (IAB) taxonomy category classifying the advertisers primary business vertical (e.g., Automotive, Financial Services, Consumer Packaged Goods). | Column industry_category (STRING) in sales.advertiser',
    `is_political_advertiser` BOOLEAN COMMENT 'Boolean flag indicating whether this advertiser is a political candidate, party, or issue advocacy group subject to FCC political advertising disclosure requirements. | Column is_political_advertiser (BOOLEAN) in sales.advertiser',
    `legal_name` STRING COMMENT 'The full legal registered name of the advertising client or brand as it appears on contracts and invoices. | Column legal_name (STRING) in sales.advertiser',
    `notes` STRING COMMENT 'Free-text field for internal notes regarding special handling instructions, account history, or relationship management details. | Column notes (STRING) in sales.advertiser',
    `parent_company_name` STRING COMMENT 'The name of the parent or holding company if the advertiser is a subsidiary or brand within a larger corporate structure. | Column parent_company_name (STRING) in sales.advertiser',
    `payment_terms` STRING COMMENT 'The contractual payment terms specifying when payment is due after invoice date (e.g., Net 30, Net 60). | Column payment_terms (STRING) in sales.advertiser. Valid values are `net_30|net_60|net_90|prepay|credit_card|due_on_receipt`',
    `preferred_currency_code` STRING COMMENT 'The three-letter ISO currency code for invoicing and financial reporting (e.g., USD, EUR, GBP). | Column preferred_currency_code (STRING) in sales.advertiser. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary business contact for campaign communications and invoice delivery. | Column primary_contact_email (STRING) in sales.advertiser. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact at the advertiser organization for campaign coordination and billing inquiries. | Column primary_contact_name (STRING) in sales.advertiser',
    `primary_contact_phone` STRING COMMENT 'The business phone number of the primary contact for urgent campaign or billing matters. | Column primary_contact_phone (STRING) in sales.advertiser',
    `requires_ad_clearance` BOOLEAN COMMENT 'Boolean flag indicating whether this advertisers creative content requires pre-broadcast clearance review due to industry category (e.g., pharmaceuticals, alcohol, financial services). | Column requires_ad_clearance (BOOLEAN) in sales.advertiser',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in sales.advertiser',
    `tax_identifier` STRING COMMENT 'The advertisers federal tax identification number (EIN in USA, VAT number in EU) used for tax reporting and invoicing. | Column tax_identifier (STRING) in sales.advertiser',
    `trade_name` STRING COMMENT 'The doing-business-as (DBA) or brand name used in advertising campaigns and public-facing materials. | Column trade_name (STRING) in sales.advertiser',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in sales.advertiser',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this advertiser record was last modified. | Column updated_timestamp (TIMESTAMP) in sales.advertiser',
    `website_url` STRING COMMENT 'The primary website URL of the advertiser for brand reference and campaign landing page validation. | Column website_url (STRING) in sales.advertiser',
    `wide_orbit_advertiser_code` STRING COMMENT 'The unique advertiser identifier in the Wide Orbit traffic and billing system, used for ad scheduling, sales orders, and invoicing. | Column wide_orbit_advertiser_code (STRING) in sales.advertiser',
    CONSTRAINT pk_advertiser PRIMARY KEY(`advertiser_id`)
) COMMENT 'Master record for an advertising client (brand or direct advertiser) purchasing airtime or digital inventory. Captures advertiser legal name, trade name, industry category (IAB taxonomy), parent company, billing address, credit limit, credit status, payment terms, tax ID, Salesforce account reference, Wide Orbit advertiser code, and account manager assignment. Distinct from the agency that places buys on behalf of the advertiser. SSOT for advertiser identity within the advertising domain. | Unity Catalog table: media_broadcasting_ecm.sales.advertiser Integrates with Salesforce Media Cloud (sales CRM).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` (
    `sales_agency_id` BIGINT COMMENT 'Unique identifier for the advertising agency or media buying firm. Primary key. | Column sales_agency_id (BIGINT) in sales.sales_agency',
    `account_id` BIGINT COMMENT 'Reference identifier linking this agency to its corresponding account record in Salesforce Media Cloud CRM for tracking opportunities, campaigns, and proposals. | Column sales_account_id (BIGINT) in sales.sales_agency',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in sales.sales_agency',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in sales.sales_agency',
    `accreditation_date` DATE COMMENT 'Date when the agency was granted accreditation status by the broadcaster or industry body. | Column accreditation_date (DATE) in sales.sales_agency',
    `accreditation_expiry_date` DATE COMMENT 'Date when the current accreditation status expires and requires renewal. Nullable for indefinite accreditation. | Column accreditation_expiry_date (DATE) in sales.sales_agency',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the agency with industry bodies or the broadcaster, indicating creditworthiness and eligibility for commission-based billing. | Column accreditation_status (STRING) in sales.sales_agency. Valid values are `accredited|pending|not-accredited|suspended|revoked`',
    `agency_type` STRING COMMENT 'Classification of the agency based on its primary service offering and operational model. | Column agency_type (STRING) in sales.sales_agency. Valid values are `full-service|media-buying|digital|programmatic|creative|in-house`',
    `billing_address_line1` STRING COMMENT 'First line of the agencys billing address where invoices and financial correspondence should be sent. | Column billing_address_line1 (STRING) in sales.sales_agency',
    `billing_address_line2` STRING COMMENT 'Second line of the agencys billing address (suite, floor, building name). Nullable. | Column billing_address_line2 (STRING) in sales.sales_agency',
    `billing_city` STRING COMMENT 'City name for the agencys billing address. | Column billing_city (STRING) in sales.sales_agency',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the agencys billing address (e.g., USA, CAN, GBR). | Column billing_country_code (STRING) in sales.sales_agency. Valid values are `^[A-Z]{3}$`',
    `billing_model` STRING COMMENT 'Billing methodology used for this agency. Gross: agency bills advertiser full amount and remits net to broadcaster. Net: broadcaster bills agency net amount. Hybrid: mixed approach. | Column billing_model (STRING) in sales.sales_agency. Valid values are `gross|net|hybrid`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the agencys billing address. | Column billing_postal_code (STRING) in sales.sales_agency',
    `billing_state_province` STRING COMMENT 'State or province code for the agencys billing address (e.g., NY, CA, ON). | Column billing_state_province (STRING) in sales.sales_agency',
    `commission_rate` DECIMAL(18,2) COMMENT 'Standard commission percentage rate applied to media buys placed by this agency, expressed as a decimal (e.g., 0.1500 for 15%). Used for commission calculation and billing split. | Column commission_rate (DECIMAL(5,4)) in sales.sales_agency',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in sales.sales_agency',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX. | Column created_timestamp (TIMESTAMP) in sales.sales_agency',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount (in base currency) extended to the agency for outstanding ad orders before payment is required. Used for credit risk management. | Column credit_limit (DECIMAL(15,2)) in sales.sales_agency',
    `holding_company_group` STRING COMMENT 'Name of the parent holding company or agency network to which this agency belongs (e.g., WPP, Omnicom, Publicis, IPG, Dentsu). Null if independent. | Column holding_company_group (STRING) in sales.sales_agency',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this agency record. Used for audit trail and change tracking. | Column modified_by (STRING) in sales.sales_agency',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency record was last modified. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX. | Column modified_timestamp (TIMESTAMP) in sales.sales_agency',
    `sales_agency_name` STRING COMMENT 'Full legal or trade name of the advertising agency or media buying firm. | Column sales_agency_name (STRING) in sales.sales_agency',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or historical context about the agency relationship. | Column notes (STRING) in sales.sales_agency',
    `onboarding_date` DATE COMMENT 'Date when the agency was first onboarded and approved to place advertising orders with the broadcaster. | Column onboarding_date (DATE) in sales.sales_agency',
    `payment_terms_days` STRING COMMENT 'Standard number of days allowed for payment after invoice date (e.g., 30, 60, 90). Used for accounts receivable and cash flow forecasting. | Column payment_terms_days (INT) in sales.sales_agency',
    `preferred_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the agencys preferred billing currency (e.g., USD, CAD, GBP, EUR). | Column preferred_currency_code (STRING) in sales.sales_agency. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the agency for order confirmations, affidavits, and campaign communications. | Column primary_contact_email (STRING) in sales.sales_agency. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact or account executive at the agency responsible for media buying and campaign coordination. | Column primary_contact_name (STRING) in sales.sales_agency',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the agency contact, used for urgent campaign coordination and makegood processing. | Column primary_contact_phone (STRING) in sales.sales_agency',
    `sales_agency_status` STRING COMMENT 'Current operational status of the agency relationship. Active agencies can place orders; inactive/suspended/terminated agencies cannot. | Column sales_agency_status (STRING) in sales.sales_agency. Valid values are `active|inactive|suspended|pending-approval|terminated`',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in sales.sales_agency',
    `status_reason` STRING COMMENT 'Explanation or business reason for the current status, particularly for inactive, suspended, or terminated statuses (e.g., credit issues, contract expiration, voluntary closure). | Column status_reason (STRING) in sales.sales_agency',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number for the agency (e.g., EIN in USA, VAT number in EU) used for tax reporting and compliance. | Column tax_identifier (STRING) in sales.sales_agency',
    `termination_date` DATE COMMENT 'Date when the agency relationship was terminated or the agency ceased operations. Nullable for active agencies. | Column termination_date (DATE) in sales.sales_agency',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in sales.sales_agency',
    `website_url` STRING COMMENT 'Official website URL of the advertising agency for reference and verification purposes. | Column website_url (STRING) in sales.sales_agency',
    `wide_orbit_agency_code` STRING COMMENT 'Unique agency identifier code used in the Wide Orbit traffic and billing system for ad scheduling, sales orders, and invoicing. | Column wide_orbit_agency_code (STRING) in sales.sales_agency',
    `created_by` STRING COMMENT 'User identifier or system account that created this agency record. Used for audit trail and data lineage. | Column created_by (STRING) in sales.sales_agency',
    CONSTRAINT pk_sales_agency PRIMARY KEY(`sales_agency_id`)
) COMMENT 'Master record for an advertising agency or media buying firm that places ad orders on behalf of advertisers. Captures agency name, agency type (full-service, media buying, digital, programmatic), holding company group, commission rate, billing model (gross/net), contact details, Wide Orbit agency code, Salesforce account reference, and accreditation status. Tracks the agency-advertiser relationship for commission calculation and billing split. | Unity Catalog table: media_broadcasting_ecm.sales.sales_agency Integrates with Salesforce Media Cloud (sales CRM).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` (
    `ad_spot_id` BIGINT COMMENT 'Unique identifier for the individual advertisement spot placement. Primary key for the ad spot entity. | Column ad_spot_id (BIGINT) in sales.ad_spot',
    `ad_break_id` BIGINT COMMENT 'Foreign key linking to scheduling.ad_break. Business justification: Traffic and billing operations require linking each sold ad spot to its containing ad_break for affidavit generation, makegood tracking, and as-run log reconciliation. A broadcast traffic manager expe',
    `ad_order_line_id` BIGINT COMMENT 'Reference to the parent ad order line that booked this spot. Links the spot to the commercial agreement and campaign. | Column ad_order_line_id (BIGINT) in sales.ad_spot',
    `advertiser_id` BIGINT COMMENT 'Identifier for the advertiser (brand or company) whose creative aired in this spot. Links to advertiser master data. | Column advertiser_id (BIGINT) in sales.ad_spot',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Ad trafficking requires linking each aired spot to the exact creative asset_version delivered (specific codec, resolution, platform spec). This supports affidavit/proof-of-performance reporting, deliv',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Affidavit generation, Nielsen reporting, and billing reconciliation require direct channel lookup on each aired spot. channel_code (plain text) is a denormalized representation of scheduling.channel. ',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Individual spots are trafficked and measured against specific demographic targets for GRP/TRP delivery, makegood determination, and affidavit reconciliation. Essential for Nielsen ratings matching and | Column demographic_segment_id (BIGINT) in audience.ad_spot',
    `original_spot_ad_spot_id` BIGINT COMMENT 'Reference to the original ad spot that this makegood spot is compensating for. Populated only when makegood_flag is true. | Column original_spot_ad_spot_id (BIGINT) in sales.ad_spot',
    `playout_event_id` BIGINT COMMENT 'Foreign key linking to scheduling.playout_event. Business justification: Broadcast traffic reconciliation matches each sold ad_spot to its corresponding playout_event for affidavit certification, billing confirmation, and FCC compliance reporting. A traffic operations expe',
    `sales_agency_id` BIGINT COMMENT 'Identifier for the advertising agency that placed this spot on behalf of the advertiser. May be null for direct advertiser buys. | Column sales_agency_id (BIGINT) in sales.ad_spot',
    `sales_campaign_id` BIGINT COMMENT 'Identifier for the advertising campaign this spot belongs to. Groups related spots for performance analysis and reporting. | Column campaign_id (BIGINT) in sales.ad_spot',
    `schedule_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedule_slot. Business justification: Spots air within specific schedule slots. Affidavit generation, as-run reconciliation, and delivery verification require linking each spot to the exact slot it occupied. No existing column fits; creat | Column schedule_slot_id (BIGINT) in scheduling.ad_spot',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber.subscriber. Business justification: Addressable ad spot delivery tracking links each aired spot to the subscriber who viewed it. Essential for frequency capping, attribution, personalized ad delivery, and subscriber-level impression rec | Column subscriber_id (BIGINT) in subscriber.ad_spot',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Ad spots air during specific titles. Business process: traffic logs, affidavits, program-level ad performance analysis, Nielsen C3/C7 ratings reconciliation, content adjacency compliance. | Column title_id (BIGINT) in content.ad_spot',
    `viewer_profile_id` BIGINT COMMENT 'Foreign key linking to subscriber.viewer_profile. Business justification: Dynamic Ad Insertion (DAI) addressable advertising requires profile-level ad delivery tracking for frequency capping, profile-level attribution reporting, and kids-profile ad compliance (COPPA). A dom',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in sales.ad_spot',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in sales.ad_spot',
    `actual_air_time` TIMESTAMP COMMENT 'The actual date and time when this ad spot aired, as recorded in the broadcast affidavit. Used for proof of performance and billing reconciliation. | Column actual_air_time (TIMESTAMP) in sales.ad_spot',
    `ad_pod_position` STRING COMMENT 'Sequential position of this spot within the ad pod (group of ads in a commercial break). Position 1 is the first ad in the break. Pod position affects viewer attention and pricing. | Column ad_pod_position (INT) in sales.ad_spot',
    `affidavit_reference` STRING COMMENT 'Reference to the broadcast affidavit (proof of performance document) that certifies this spot aired as scheduled. Required for billing and advertiser verification. | Column affidavit_reference (STRING) in sales.ad_spot',
    `attribution_model_type` STRING COMMENT 'Type of attribution model applied (first-touch, last-touch, linear, time-decay, position-based, data-driven)',
    `attribution_weight` DECIMAL(18,2) COMMENT 'Fractional credit assigned to this touchpoint in multi-touch attribution',
    `billing_status` STRING COMMENT 'Current billing status of this spot. Tracks the spot through the billing lifecycle from unbilled through payment or dispute resolution. | Column billing_status (STRING) in sales.ad_spot. Valid values are `unbilled|billed|invoiced|paid|disputed|written_off`',
    `bonus_spot_flag` BOOLEAN COMMENT 'Indicates whether this spot was provided as a bonus (added value) to the advertiser at no additional charge. Used for revenue recognition and campaign value calculation. | Column bonus_spot_flag (BOOLEAN) in sales.ad_spot',
    `conversion_path_position` STRING COMMENT 'Position of this touchpoint in the customer conversion path',
    `cpm_amount` DECIMAL(18,2) COMMENT 'Cost per thousand impressions for this spot. Key pricing metric in advertising sales used to compare efficiency across different placements. | Column cpm_amount (DECIMAL(10,2)) in sales.ad_spot',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in sales.ad_spot',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ad spot record was first created in the system. Used for audit trail and data lineage. | Column created_timestamp (TIMESTAMP) in sales.ad_spot',
    `dai_flag` BOOLEAN COMMENT 'Indicates whether this spot was delivered via Dynamic Ad Insertion technology, allowing personalized ad delivery to different viewers or platforms. | Column dai_flag (BOOLEAN) in sales.ad_spot',
    `daypart` STRING COMMENT 'Time segment of the broadcast day when the spot aired. Dayparts are used for pricing, audience targeting, and inventory management. Standard dayparts include early morning (6-9am), daytime (9am-4pm), early fringe (4-6pm), prime access (6-8pm), prime time (8-11pm), late fringe (11pm-12am), late night (12-2am), and overnight (2-6am). [ENUM-REF-CANDIDATE: early_morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight — 8 candidates stripped; promote to reference product] | Column daypart (STRING) in sales.ad_spot',
    `delivery_platform` STRING COMMENT 'Platform through which the ad spot was delivered. Distinguishes between linear broadcast, OTT (Over-The-Top), VOD (Video On Demand), SVOD (Subscription VOD), AVOD (Ad-Supported VOD), TVOD (Transactional VOD), FAST (Free Ad-Supported Streaming TV), and simulcast delivery. [ENUM-REF-CANDIDATE: linear|ott|vod|svod|avod|tvod|fast|simulcast — 8 candidates stripped; promote to reference product] | Column delivery_platform (STRING) in sales.ad_spot',
    `grp_value` DECIMAL(18,2) COMMENT 'Gross Rating Point value delivered by this spot. Measures the size of the audience reached relative to the total market population. Sum of all rating points across the campaign. | Column grp_value (DECIMAL(8,2)) in sales.ad_spot',
    `impressions_delivered` BIGINT COMMENT 'Total number of impressions (views) delivered by this spot. Used for performance measurement and billing reconciliation. | Column impressions_delivered (BIGINT) in sales.ad_spot',
    `makegood_flag` BOOLEAN COMMENT 'Indicates whether this spot is a makegood (compensatory ad spot provided to an advertiser due to a previous preemption or underdelivery). | Column makegood_flag (BOOLEAN) in sales.ad_spot',
    `market_code` STRING COMMENT 'Designated Market Area (DMA) or geographic market code where the spot aired. Used for regional campaign tracking and market-specific pricing. | Column market_code (STRING) in sales.ad_spot',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ad spot record was last modified. Tracks changes to scheduling, status, or other attributes. | Column modified_timestamp (TIMESTAMP) in sales.ad_spot',
    `preempted_flag` BOOLEAN COMMENT 'Indicates whether this spot was preempted (bumped from its scheduled time slot). Preempted spots typically require makegood compensation. | Column preempted_flag (BOOLEAN) in sales.ad_spot',
    `preemption_reason` STRING COMMENT 'Explanation for why the spot was preempted, if applicable. Common reasons include breaking news, technical issues, programming overrun, or higher-priority advertiser. | Column preemption_reason (STRING) in sales.ad_spot',
    `rotation_pattern` STRING COMMENT 'Describes the rotation or sequencing pattern for this spot within the campaign (e.g., ROS - Run of Schedule, fixed position, alternating). Used for inventory management and fulfillment. | Column rotation_pattern (STRING) in sales.ad_spot',
    `scheduled_air_date` DATE COMMENT 'The date on which this ad spot was scheduled to air. Used for planning and inventory management. | Column scheduled_air_date (DATE) in sales.ad_spot',
    `scheduled_air_time` TIMESTAMP COMMENT 'The precise date and time when this ad spot was scheduled to air. Includes timezone information for accurate cross-platform scheduling. | Column scheduled_air_time (TIMESTAMP) in sales.ad_spot',
    `separation_requirement` STRING COMMENT 'Specifies any separation rules for this spot (e.g., competitive separation, minimum time between airings). Ensures advertiser requirements are met. | Column separation_requirement (STRING) in sales.ad_spot',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in sales.ad_spot',
    `spot_length_seconds` STRING COMMENT 'Duration of the advertisement spot in seconds. Common values include 15, 30, 60, 90, and 120 seconds. | Column spot_length_seconds (INT) in sales.ad_spot',
    `spot_rate_amount` DECIMAL(18,2) COMMENT 'The rate charged for this individual spot placement. May differ from the order line rate due to daypart, program, or inventory adjustments. | Column spot_rate_amount (DECIMAL(15,2)) in sales.ad_spot',
    `spot_rate_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the spot rate amount (e.g., USD, GBP, EUR). | Column spot_rate_currency (STRING) in sales.ad_spot. Valid values are `^[A-Z]{3}$`',
    `spot_status` STRING COMMENT 'Current lifecycle status of the ad spot. Tracks whether the spot was scheduled, successfully aired, preempted, cancelled, or requires makegood processing. | Column spot_status (STRING) in sales.ad_spot. Valid values are `scheduled|aired|preempted|cancelled|makegood_pending|makegood_fulfilled`',
    `touchpoint_sequence_code` STRING COMMENT 'Identifier linking touchpoints in a conversion path for attribution analysis',
    `traffic_log_reference` STRING COMMENT 'Reference identifier to the Wide Orbit traffic log entry that scheduled and tracked this spot. Used for audit trail and reconciliation. | Column traffic_log_reference (STRING) in sales.ad_spot',
    `trp_value` DECIMAL(18,2) COMMENT 'Target Rating Point value delivered by this spot. Measures audience reach within a specific demographic target segment, more precise than GRP. | Column trp_value (DECIMAL(8,2)) in sales.ad_spot',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in sales.ad_spot',
    CONSTRAINT pk_ad_spot PRIMARY KEY(`ad_spot_id`)
) COMMENT 'Individual scheduled advertisement placement (spot) within a broadcast or digital break. Represents the atomic unit of ad delivery — a single commercial airing with ISCI code, spot length (seconds), scheduled air date and time, channel/network, program, daypart, pod position, actual air time (from affidavit), preemption flag, makegoood flag, DAI flag, and Wide Orbit traffic log reference. Links to the ad order line that booked it and the creative (isci) that aired. | Unity Catalog table: media_broadcasting_ecm.sales.ad_spot Integrates with Salesforce Media Cloud (sales CRM).';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` (
    `upfront_deal_id` BIGINT COMMENT 'Unique identifier for the upfront advertising deal negotiation record. Primary key. Role: MASTER_AGREEMENT. | Column upfront_deal_id (BIGINT) in sales.upfront_deal',
    `advertiser_id` BIGINT COMMENT 'Reference to the advertiser organization purchasing the advertising inventory under this deal. Links to the advertiser master record. | Column advertiser_id (BIGINT) in sales.upfront_deal',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Upfront deals commit annual inventory against specific demographic guarantees (e.g., A18-49 GRP at negotiated CPM). Core to annual negotiation cycle, audience guarantee structuring, and scatter conver | Column demographic_segment_id (BIGINT) in audience.upfront_deal',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.package. Business justification: Broadcast upfront deals are structured around content packages — advertisers commit annual spend against specific content packages (primetime, sports, news) during upfront season. This FK is essential',
    `sales_agency_id` BIGINT COMMENT 'Reference to the media buying agency representing the advertiser in this deal negotiation. Nullable for direct advertiser deals. Links to the agency master record. | Column sales_agency_id (BIGINT) in sales.upfront_deal',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in sales.upfront_deal',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in sales.upfront_deal',
    `audience_guarantee_grp` DECIMAL(18,2) COMMENT 'Total Gross Rating Points (GRP) guaranteed to the advertiser across all flights and dayparts in this deal. GRP = Reach × Frequency, representing the total audience delivery commitment. | Column audience_guarantee_grp (DECIMAL(10,2)) in sales.upfront_deal',
    `audience_guarantee_impressions` BIGINT COMMENT 'Total number of ad impressions guaranteed to the advertiser. Alternative or complementary metric to GRP, especially for digital and cross-platform deals. | Column audience_guarantee_impressions (BIGINT) in sales.upfront_deal',
    `cancellation_option_window_days` STRING COMMENT 'Number of days before flight start date within which the advertiser may cancel or reduce the commitment without penalty. Common in upfront deals to provide flexibility. | Column cancellation_option_window_days (INT) in sales.upfront_deal',
    `channel_mix` STRING COMMENT 'Comma-separated list or description of broadcast channels, networks, or platforms included in this deal (e.g., Network Prime, Cable Bundle, OTT Streaming). Defines the inventory scope. | Column channel_mix (STRING) in sales.upfront_deal',
    `commitment_date` DATE COMMENT 'Date when the advertiser or agency verbally or formally committed to the deal terms. Nullable until commitment is secured. | Column commitment_date (DATE) in sales.upfront_deal',
    `cpm_rate` DECIMAL(18,2) COMMENT 'Cost per thousand impressions for CPM-based deals. Nullable if pricing basis is not CPM. Represents the unit price for audience delivery. | Column cpm_rate (DECIMAL(10,2)) in sales.upfront_deal',
    `cprp_rate` DECIMAL(18,2) COMMENT 'Cost per rating point for CPRP-based deals. Nullable if pricing basis is not CPRP. Represents the unit price per GRP delivered. | Column cprp_rate (DECIMAL(10,2)) in sales.upfront_deal',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in sales.upfront_deal',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this upfront deal record was first created in the system. Audit trail for record lifecycle tracking. | Column created_timestamp (TIMESTAMP) in sales.upfront_deal',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this deal. Typically USD for US-based broadcasters. | Column currency_code (STRING) in sales.upfront_deal. Valid values are `USD|CAD|GBP|EUR|AUD`',
    `daypart_mix` STRING COMMENT 'Comma-separated list or description of dayparts included in this deal (e.g., Prime Time, Early Morning, Late Night, Weekend). Daypart = time segment of broadcast day with distinct audience characteristics. | Column daypart_mix (STRING) in sales.upfront_deal',
    `deal_number` STRING COMMENT 'Externally-known unique business identifier for the upfront deal, typically formatted as prefix-year-sequence (e.g., UF-2024-000123). Used in all client-facing communications and internal references. | Column deal_number (STRING) in sales.upfront_deal. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{5,8}$`',
    `deal_status` STRING COMMENT 'Current lifecycle state of the upfront deal. Draft = initial creation; Submitted = sent to client; Negotiating = active discussions; Committed = verbal agreement; Executed = signed contract; Cancelled = deal terminated; Expired = proposal lapsed without commitment. [ENUM-REF-CANDIDATE: draft|submitted|negotiating|committed|executed|cancelled|expired — 7 candidates stripped; promote to reference product] | Column deal_status (STRING) in sales.upfront_deal',
    `deal_type` STRING COMMENT 'Classification of the advertising deal based on sales method and timing. Upfront = annual advance commitment during upfront season; Scatter = short-term last-minute inventory; Direct = negotiated one-off; Programmatic = automated auction-based; Sponsorship = integrated content partnership; Barter = trade arrangement. | Column deal_type (STRING) in sales.upfront_deal. Valid values are `upfront|scatter|direct|programmatic|sponsorship|barter`',
    `deal_year` STRING COMMENT 'Broadcast year for which this upfront deal applies, typically representing the September-to-August broadcast season (e.g., 2024 for 2024-2025 season). Critical for upfront planning and inventory allocation. | Column deal_year (INT) in sales.upfront_deal',
    `execution_date` DATE COMMENT 'Date when the deal contract was fully executed (signed by all parties). Nullable until contract is finalized. | Column execution_date (DATE) in sales.upfront_deal',
    `makegood_provision_flag` BOOLEAN COMMENT 'Indicates whether the deal includes makegood provisions for audience delivery shortfalls. True = makegoods required if guaranteed audience is not delivered; False = no makegood obligation. | Column makegood_provision_flag (BOOLEAN) in sales.upfront_deal',
    `mmm_adstock_decay_rate` DECIMAL(18,2) COMMENT 'Rate at which advertising effect decays over time for MMM calculations',
    `mmm_channel_contribution` DECIMAL(18,2) COMMENT 'Marketing Mix Model estimated contribution of this channel to conversions',
    `mmm_saturation_point` DECIMAL(18,2) COMMENT 'Estimated spend level at which diminishing returns begin for this channel',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this upfront deal record was last modified. Audit trail for change tracking and data lineage. | Column modified_timestamp (TIMESTAMP) in sales.upfront_deal',
    `negotiation_round_count` STRING COMMENT 'Number of formal negotiation rounds or proposal revisions submitted during the deal lifecycle. Tracks negotiation complexity and sales effort. | Column negotiation_round_count (INT) in sales.upfront_deal',
    `notes` STRING COMMENT 'Free-text field for capturing additional deal terms, special conditions, negotiation history, or internal comments not captured in structured fields. Used by account executives for context and handoff. | Column notes (STRING) in sales.upfront_deal',
    `option_exercise_deadline` DATE COMMENT 'Final date by which the advertiser must exercise any options included in the deal (e.g., additional quarters, scatter conversion, renewal). Nullable if no options are included. | Column option_exercise_deadline (DATE) in sales.upfront_deal',
    `pricing_basis` STRING COMMENT 'Pricing model used for this deal. CPM (Cost Per Mille) = cost per thousand impressions; CPRP (Cost Per Rating Point) = cost per GRP point; Flat Rate = fixed fee regardless of delivery; Performance = outcome-based pricing. | Column pricing_basis (STRING) in sales.upfront_deal. Valid values are `cpm|cprp|flat_rate|performance`',
    `proposal_date` DATE COMMENT 'Date when the initial deal proposal was formally submitted to the advertiser or agency. Marks the start of the negotiation lifecycle. | Column proposal_date (DATE) in sales.upfront_deal',
    `salesforce_opportunity_reference` STRING COMMENT 'External reference to the corresponding Salesforce Media Cloud Opportunity record. Enables cross-system traceability between the deal negotiation (Salesforce) and trafficking/billing (Wide Orbit). | Column salesforce_opportunity_reference (STRING) in sales.upfront_deal. Valid values are `^[a-zA-Z0-9]{15,18}$`',
    `scatter_conversion_rights` BOOLEAN COMMENT 'Indicates whether the advertiser has the right to convert unused upfront commitment into scatter market inventory at preferential rates. True = conversion allowed; False = no conversion rights. | Column scatter_conversion_rights (BOOLEAN) in sales.upfront_deal',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in sales.upfront_deal',
    `total_committed_spend` DECIMAL(18,2) COMMENT 'Total dollar value of advertising spend committed by the advertiser after negotiation. Nullable until commitment is secured. This is the final agreed revenue amount. | Column total_committed_spend (DECIMAL(18,2)) in sales.upfront_deal',
    `total_proposed_spend` DECIMAL(18,2) COMMENT 'Total dollar value of advertising spend proposed in the initial deal submission. Represents the gross revenue opportunity before negotiation adjustments. | Column total_proposed_spend (DECIMAL(18,2)) in sales.upfront_deal',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in sales.upfront_deal',
    CONSTRAINT pk_upfront_deal PRIMARY KEY(`upfront_deal_id`)
) COMMENT 'Master record for an advertising deal negotiation and commitment — covering the full lifecycle from initial proposal/RFP response through negotiation rounds to final commitment. Encompasses upfront bulk buys negotiated during the annual upfront sales event as well as significant scatter and direct deals requiring formal proposal stages. Captures deal ID, advertiser, agency, account executive, deal year, proposal date, total proposed/committed spend, audience guarantee (GRP/TRP/impression), audience demographic, channel/daypart mix, cancellation option windows, scatter conversion rights, pricing basis (CPM or CPRP), deal status (draft, submitted, negotiating, committed, executed, cancelled), option exercise deadlines, and Salesforce opportunity reference. SSOT for the pre-order deal negotiation lifecycle. | Unity Catalog table: media_broadcasting_ecm.sales.upfront_deal Integrates with Wide Orbit (traffic) and Salesforce Media Cloud (sales CRM) for realistic demos.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`account` (
    `account_id` BIGINT COMMENT 'Unique identifier for the sales account record. Primary key for the sales account entity representing advertising agencies, direct advertisers, content licensees, syndication buyers, and distribution partners. | Column sales_account_id (BIGINT) in sales.sales_account',
    `parent_account_sales_account_id` BIGINT COMMENT 'Reference to the parent sales account in a hierarchical account structure. Used to model agency networks, holding company subsidiaries, and multi-location advertiser organizations. | Column parent_account_sales_account_id (BIGINT) in sales.sales_account',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in sales.sales_account',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in sales.sales_account',
    `account_status` STRING COMMENT 'Current lifecycle status of the sales account. Active indicates the account is in good standing and can transact; inactive indicates dormant but not closed; suspended indicates temporary hold due to credit or compliance issues; pending indicates account setup in progress; closed indicates permanently terminated relationship. | Column account_status (STRING) in sales.sales_account. Valid values are `active|inactive|suspended|pending|closed`',
    `account_type` STRING COMMENT 'Classification of the sales account based on its commercial relationship with Media Broadcasting. Agency represents advertising agencies; direct_advertiser represents brands buying media directly; MVPD (Multichannel Video Programming Distributor) and vMVPD (Virtual Multichannel Video Programming Distributor) represent distribution partners; syndicator represents content resale partners; content_licensee represents organizations licensing content rights. | Column account_type (STRING) in sales.sales_account. Valid values are `agency|direct_advertiser|mvpd|vmvpd|syndicator|content_licensee`',
    `agency_commission_rate` DECIMAL(18,2) COMMENT 'The commission percentage paid to advertising agencies for media buys placed on behalf of their clients. Typically expressed as a decimal (e.g., 0.1500 for 15%). Null for non-agency accounts. | Column agency_commission_rate (DECIMAL(5,4)) in sales.sales_account',
    `annual_revenue_potential` DECIMAL(18,2) COMMENT 'The estimated annual revenue opportunity from this account based on historical spend, market share, and sales forecasts. Used for territory planning and quota allocation. | Column annual_revenue_potential (DECIMAL(18,2)) in sales.sales_account',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the master service agreement automatically renews at the end of the contract term. True means the contract renews unless either party provides notice; false means the contract expires and requires renegotiation. | Column auto_renewal_flag (BOOLEAN) in sales.sales_account',
    `billing_address_line1` STRING COMMENT 'The first line of the billing address where invoices should be sent. Typically contains street number and street name. | Column billing_address_line1 (STRING) in sales.sales_account',
    `billing_address_line2` STRING COMMENT 'The second line of the billing address for suite, floor, or department information. | Column billing_address_line2 (STRING) in sales.sales_account',
    `billing_city` STRING COMMENT 'The city component of the billing address. | Column billing_city (STRING) in sales.sales_account',
    `billing_contact_email` STRING COMMENT 'The email address of the primary billing contact for invoice delivery and payment correspondence. | Column billing_contact_email (STRING) in sales.sales_account. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'The full name of the primary billing contact at the account organization who handles invoices, payment processing, and financial inquiries. | Column billing_contact_name (STRING) in sales.sales_account',
    `billing_contact_phone` STRING COMMENT 'The phone number of the primary billing contact for urgent payment or invoice inquiries. | Column billing_contact_phone (STRING) in sales.sales_account',
    `billing_country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code for the billing address (e.g., USA, GBR, CAN). | Column billing_country_code (STRING) in sales.sales_account. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'The postal or ZIP code component of the billing address. | Column billing_postal_code (STRING) in sales.sales_account',
    `billing_state_province` STRING COMMENT 'The state or province component of the billing address. | Column billing_state_province (STRING) in sales.sales_account',
    `blackout_restrictions` STRING COMMENT 'Geographic or temporal restrictions on where or when this accounts advertising or content may be broadcast. Used to enforce exclusivity agreements, competitive conflicts, or regulatory blackout periods. | Column blackout_restrictions (STRING) in sales.sales_account',
    `contract_end_date` DATE COMMENT 'The expiration date of the current master service agreement or framework contract with this account. Null indicates an evergreen or open-ended agreement. | Column contract_end_date (DATE) in sales.sales_account',
    `contract_start_date` DATE COMMENT 'The effective start date of the current master service agreement or framework contract with this account. | Column contract_start_date (DATE) in sales.sales_account',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in sales.sales_account',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this sales account record was first created in the system. Used for audit trail and data lineage tracking. | Column created_timestamp (TIMESTAMP) in sales.sales_account',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum outstanding receivables balance allowed for this account before credit hold is applied. Expressed in the accounts preferred currency. | Column credit_limit_amount (DECIMAL(18,2)) in sales.sales_account',
    `credit_rating` STRING COMMENT 'The credit rating assigned to this account based on payment history, financial stability, and risk assessment. Used to determine payment terms, credit limits, and whether prepayment is required. NR indicates not rated. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D|NR — 11 candidates stripped; promote to reference product] | Column credit_rating (STRING) in sales.sales_account',
    `holding_company_name` STRING COMMENT 'The name of the parent holding company or corporate group to which this account belongs. Used to aggregate spend and manage relationships at the holding company level (e.g., WPP, Omnicom, Publicis Groupe for agencies). | Column holding_company_name (STRING) in sales.sales_account',
    `industry_vertical` STRING COMMENT 'The primary industry vertical or business sector of the account (e.g., Automotive, Financial Services, Retail, Pharmaceutical, Technology). Used for competitive separation and industry-specific rate cards. | Column industry_vertical (STRING) in sales.sales_account',
    `last_activity_date` DATE COMMENT 'The date of the most recent sales activity, campaign, or transaction associated with this account. Used to identify dormant accounts and trigger re-engagement campaigns. | Column last_activity_date (DATE) in sales.sales_account',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this sales account record was last updated. Used for change tracking and data synchronization. | Column last_modified_timestamp (TIMESTAMP) in sales.sales_account',
    `account_name` STRING COMMENT 'The legal or trading name of the sales account organization. This is the primary human-readable identifier for the account. | Column account_name (STRING) in sales.sales_account',
    `notes` STRING COMMENT 'Free-form text field for capturing important account-specific information, special handling instructions, relationship history, or strategic context that does not fit structured fields. | Column notes (STRING) in sales.sales_account',
    `payment_terms_days` STRING COMMENT 'The number of days allowed for payment after invoice date, as agreed in the master service agreement. Common values include 30, 60, or 90 days. Zero indicates prepayment required. | Column payment_terms_days (INT) in sales.sales_account',
    `preferred_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which this account prefers to transact and receive invoices (e.g., USD, GBP, EUR, CAD). | Column preferred_currency_code (STRING) in sales.sales_account. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary business contact for proposals, campaign planning, and general account communication. | Column primary_contact_email (STRING) in sales.sales_account. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact or account manager at the client organization who handles day-to-day commercial and operational matters. | Column primary_contact_name (STRING) in sales.sales_account',
    `primary_contact_phone` STRING COMMENT 'The phone number of the primary business contact for urgent campaign or operational matters. | Column primary_contact_phone (STRING) in sales.sales_account',
    `salesforce_account_reference` STRING COMMENT 'The source system identifier from Salesforce Media Cloud CRM. This is the external key used to synchronize account data between the lakehouse and the operational CRM system. | Column salesforce_account_reference (STRING) in sales.sales_account',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in sales.sales_account',
    `tax_id_number` STRING COMMENT 'The tax identification number (TIN), employer identification number (EIN), or value-added tax (VAT) registration number for this account. Used for tax reporting and compliance. | Column tax_id_number (STRING) in sales.sales_account',
    `tier` STRING COMMENT 'The strategic tier or classification of the account based on revenue potential, relationship depth, and strategic importance. Higher tiers receive preferential pricing, dedicated support, and priority inventory access. | Column account_tier (STRING) in sales.sales_account. Valid values are `platinum|gold|silver|bronze|standard`',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in sales.sales_account',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Master record for advertising agencies, direct advertisers, content licensees, syndication buyers, and distribution partners that engage in commercial transactions with Media Broadcasting. Serves as the SSOT for all sales-facing organizational identities — capturing account type (agency, direct, MVPD, syndicator), holding company hierarchy, credit rating, payment terms, assigned sales rep, market territory, agency commission rate, blackout restrictions, preferred currency, and CRM source ID from Salesforce Media Cloud. This is the commercial counterpart to subscriber identity and is the anchor entity for all sales pipeline activity. | Unity Catalog table: media_broadcasting_ecm.sales.sales_account';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'Unique identifier for the sales opportunity record. Primary key sourced from Salesforce Media Cloud Opportunity object. | Column opportunity_id (BIGINT) in sales.opportunity',
    `account_id` BIGINT COMMENT 'Reference to the advertiser or client account associated with this opportunity. Links to the master account record in Salesforce Media Cloud. | Column sales_account_id (BIGINT) in sales.opportunity',
    `sales_agency_id` BIGINT COMMENT 'Reference to the advertising agency representing the advertiser in this deal. Null for direct sales. Links to agency master record. | Column sales_agency_id (BIGINT) in sales.opportunity',
    `upfront_deal_id` BIGINT COMMENT 'Reference to the parent upfront commitment deal if this opportunity is part of an upfront negotiation. Null for scatter market and direct deals. Used to track upfront commitment fulfillment. | Column upfront_deal_id (BIGINT) in sales.opportunity',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in sales.opportunity',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in sales.opportunity',
    `campaign_objective` STRING COMMENT 'Primary marketing objective the advertiser aims to achieve with this campaign. Influences creative strategy, placement selection, and success metrics. [ENUM-REF-CANDIDATE: brand_awareness|product_launch|direct_response|lead_generation|traffic|engagement|video_views|app_installs — 8 candidates stripped; promote to reference product] | Column campaign_objective (STRING) in sales.opportunity',
    `close_date` DATE COMMENT 'Target date by which the sales team expects to close this opportunity (win or lose). Used for pipeline forecasting and sales velocity tracking. Updated as negotiations progress. | Column close_date (DATE) in sales.opportunity',
    `closed_date` DATE COMMENT 'Actual date when the opportunity was marked as closed-won or closed-lost. Null for open opportunities. Used for sales cycle analysis and win rate calculation. | Column closed_date (DATE) in sales.opportunity',
    `competitive_displacement` STRING COMMENT 'Free-text notes capturing competitive intelligence about which competitor this deal may displace or compete against. Used for win/loss analysis and competitive strategy. | Column competitive_displacement (STRING) in sales.opportunity',
    `cpm_rate` DECIMAL(18,2) COMMENT 'Cost per thousand impressions rate negotiated for this opportunity. Standard pricing metric for digital and streaming advertising. Expressed in currency per 1,000 impressions. | Column cpm_rate (DECIMAL(10,2)) in sales.opportunity',
    `cprp_rate` DECIMAL(18,2) COMMENT 'Cost per rating point negotiated for linear TV or radio buys. Standard pricing metric for broadcast advertising. Calculated as total cost divided by total GRPs delivered. | Column cprp_rate (DECIMAL(10,2)) in sales.opportunity',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in sales.opportunity',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this opportunity record was first created in Salesforce Media Cloud. Used for lead-to-close cycle time analysis and pipeline velocity tracking. | Column created_timestamp (TIMESTAMP) in sales.opportunity',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, GBP, EUR). Supports multi-currency deal tracking for international sales. | Column currency_code (STRING) in sales.opportunity. Valid values are `^[A-Z]{3}$`',
    `daypart` STRING COMMENT 'Time segment of the broadcast day targeted by this opportunity. Daypart classification affects pricing and audience demographics. Applicable primarily to linear TV and radio deals. [ENUM-REF-CANDIDATE: early_morning|daytime|early_fringe|prime_access|prime_time|late_fringe|late_night|overnight|weekend|sports|news — 11 candidates stripped; promote to reference product] | Column daypart (STRING) in sales.opportunity',
    `deal_type` STRING COMMENT 'Classification of the sales opportunity by transaction model. Upfront = advance commitment during upfront season; Scatter = last-minute inventory sales; Direct = direct-sold advertising; Programmatic Guaranteed = automated guaranteed buys; Content License = licensing content rights; Syndication = resale of content to multiple outlets. | Column deal_type (STRING) in sales.opportunity. Valid values are `upfront|scatter|direct|programmatic_guaranteed|content_license|syndication`',
    `demographic_target` STRING COMMENT 'Primary demographic audience segment targeted by this campaign (e.g., Adults 18-49, Women 25-54, Men 18-34). Used for audience guarantee and measurement alignment. | Column demographic_target (STRING) in sales.opportunity',
    `estimated_value` DECIMAL(18,2) COMMENT 'Total estimated revenue value of the opportunity in USD. For advertising deals, represents total campaign spend; for content licensing, represents license fee. Used for revenue forecasting and quota tracking. | Column estimated_value (DECIMAL(15,2)) in sales.opportunity',
    `flight_end_date` DATE COMMENT 'Planned end date for the advertising campaign or content distribution window. Defines the duration of the media buy or license period. | Column flight_end_date (DATE) in sales.opportunity',
    `flight_start_date` DATE COMMENT 'Planned start date for the advertising campaign or content distribution window. For advertising, marks the beginning of the ad flight; for content licensing, marks the start of the license window. | Column flight_start_date (DATE) in sales.opportunity',
    `forecast_category` STRING COMMENT 'Sales forecast category indicating confidence level for revenue recognition. Pipeline = early stage; Best Case = likely but not committed; Commit = high confidence; Closed = won. Used for revenue forecasting rollups. | Column forecast_category (STRING) in sales.opportunity. Valid values are `pipeline|best_case|commit|closed`',
    `is_upfront` BOOLEAN COMMENT 'Boolean flag indicating whether this opportunity is part of the annual upfront sales season. True = upfront commitment; False = scatter market or other deal type. Used for upfront tracking and reporting. | Column is_upfront (BOOLEAN) in sales.opportunity',
    `last_activity_date` DATE COMMENT 'Date of the most recent sales activity (call, email, meeting) logged against this opportunity. Used for pipeline hygiene monitoring and stale opportunity identification. | Column last_activity_date (DATE) in sales.opportunity',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this opportunity record. Used for data freshness validation and change tracking. Updated automatically on any field modification. | Column last_modified_timestamp (TIMESTAMP) in sales.opportunity',
    `lead_source` STRING COMMENT 'Origin channel of this sales opportunity. Tracks how the lead was generated for marketing attribution and lead source ROI analysis. [ENUM-REF-CANDIDATE: inbound|outbound|referral|event|partner|renewal|upsell — 7 candidates stripped; promote to reference product] | Column lead_source (STRING) in sales.opportunity',
    `loss_notes` STRING COMMENT 'Free-text detailed explanation of why the opportunity was lost. Captures competitive intelligence, pricing feedback, and strategic insights for future deals. | Column loss_notes (STRING) in sales.opportunity',
    `loss_reason` STRING COMMENT 'Primary reason for losing the opportunity if stage is closed-lost. Used for loss analysis, competitive intelligence, and sales process improvement. Null for won or open opportunities. | Column loss_reason (STRING) in sales.opportunity. Valid values are `budget|timing|competitor|no_decision|product_fit|pricing`',
    `opportunity_name` STRING COMMENT 'Descriptive name of the sales opportunity, typically including advertiser name, campaign type, and time period (e.g., Acme Corp Q4 Upfront Buy). | Column opportunity_name (STRING) in sales.opportunity',
    `next_step` STRING COMMENT 'Description of the next action or milestone required to advance this opportunity. Used for sales activity tracking and pipeline hygiene. Updated regularly by sales executive. | Column next_step (STRING) in sales.opportunity',
    `opportunity_number` STRING COMMENT 'Human-readable business identifier for the opportunity, typically auto-generated in format OPP-YYYYNNNN. Used in sales communications and reporting. | Column opportunity_number (STRING) in sales.opportunity. Valid values are `^OPP-[0-9]{8}$`',
    `probability` DECIMAL(18,2) COMMENT 'Estimated likelihood of closing this opportunity as a percentage (0.00 to 100.00). Typically aligned with stage (e.g., Proposal = 40%, Negotiation = 60%). Used for weighted pipeline forecasting. | Column probability (DECIMAL(5,2)) in sales.opportunity',
    `product_category` STRING COMMENT 'High-level classification of the media product being sold. Linear TV = traditional broadcast; Digital Video = online video ads; Streaming = OTT/SVOD/AVOD inventory; Content Licensing = rights to broadcast content. [ENUM-REF-CANDIDATE: linear_tv|digital_video|streaming|radio|podcast|display|social|sponsorship|content_licensing — 9 candidates stripped; promote to reference product] | Column product_category (STRING) in sales.opportunity',
    `requires_makegood` BOOLEAN COMMENT 'Boolean flag indicating whether this opportunity includes makegood provisions for audience delivery shortfalls. True = makegoods may be required if audience guarantees are not met. Used for inventory planning. | Column requires_makegood (BOOLEAN) in sales.opportunity',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in sales.opportunity',
    `stage` STRING COMMENT 'Current stage in the sales pipeline lifecycle. Tracks progression from initial prospecting through closure. Used for pipeline forecasting and sales funnel analysis. | Column stage (STRING) in sales.opportunity. Valid values are `prospecting|qualification|proposal|negotiation|closed_won|closed_lost`',
    `target_grp` DECIMAL(18,2) COMMENT 'Target Gross Rating Points representing the total audience reach multiplied by frequency. Standard metric for linear TV and radio campaign planning. One GRP = 1% of the target audience reached. | Column target_grp (DECIMAL(10,2)) in sales.opportunity',
    `target_impressions` BIGINT COMMENT 'Total number of ad impressions committed in this opportunity. Primary delivery metric for digital video, streaming, and programmatic deals. Measured in thousands or millions. | Column target_impressions (BIGINT) in sales.opportunity',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in sales.opportunity',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'A qualified sales pursuit representing a potential advertising campaign, content licensing deal, syndication agreement, or distribution carriage negotiation. Tracks deal stage (prospecting, proposal, negotiation, closed-won, closed-lost), estimated deal value, deal type (upfront, scatter, direct, programmatic guaranteed, content license, syndication), target flight dates, assigned sales executive, probability of close, and competitive displacement notes. Sourced from Salesforce Media Cloud Opportunity object. The primary pipeline entity feeding revenue forecasting and upfront commitment tracking. | Unity Catalog table: media_broadcasting_ecm.sales.opportunity';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Primary key for proposal',
    `account_id` BIGINT COMMENT 'FK to sales account',
    `advertiser_id` BIGINT COMMENT 'FK to advertiser',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: A proposal is created in response to a qualified sales opportunity (RFP response). One opportunity can generate multiple proposal versions/iterations. This FK closes the sales pipeline chain: opportun',
    `sales_agency_id` BIGINT COMMENT 'FK to sales agency',
    `sales_campaign_id` BIGINT COMMENT 'FK to campaign',
    `upfront_deal_id` BIGINT COMMENT 'Foreign key linking to sales.upfront_deal. Business justification: Proposals are frequently created as part of upfront deal negotiations — each negotiation round produces a new proposal version. Linking proposal to upfront_deal enables tracking of which proposals wer',
    `approval_date` DATE COMMENT 'Date proposal was approved',
    `approved_at` TIMESTAMP COMMENT 'Timestamp when proposal was approved',
    `channel_mix` STRING COMMENT 'Proposed channel distribution',
    `commission_rate` DECIMAL(18,2) COMMENT 'Agency commission rate',
    `cpm` DECIMAL(18,2) COMMENT 'Proposed cost per thousand',
    `created_at` TIMESTAMP COMMENT 'Record creation timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when record was created',
    `currency_code` STRING COMMENT 'Currency code for budget (ISO 4217)',
    `daypart_mix` STRING COMMENT 'Proposed daypart distribution',
    `discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage applied to proposal',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Discount percentage offered',
    `expiration_date` DATE COMMENT 'Date proposal expires',
    `expiry_date` DATE COMMENT 'Date proposal expires',
    `flight_end_date` DATE COMMENT 'Campaign flight end date',
    `flight_start_date` DATE COMMENT 'Campaign flight start date',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when record was last modified',
    `proposal_name` STRING COMMENT 'Name of the sales proposal',
    `net_proposed_value` DECIMAL(18,2) COMMENT 'Net value after discounts',
    `notes` STRING COMMENT 'Additional notes or comments',
    `payment_terms` STRING COMMENT 'Payment terms (net 30, net 60, etc.)',
    `proposal_date` DATE COMMENT 'Date proposal was created',
    `proposal_number` STRING COMMENT 'Unique proposal reference number',
    `proposal_status` STRING COMMENT 'Current status of the proposal (draft, submitted, approved, rejected)',
    `proposal_type` STRING COMMENT 'Type of proposal (upfront, scatter, sponsorship)',
    `proposed_grp` DECIMAL(18,2) COMMENT 'Proposed gross rating points',
    `proposed_impressions` BIGINT COMMENT 'Proposed impression delivery',
    `rejected_at` TIMESTAMP COMMENT 'Timestamp when proposal was rejected',
    `rejection_reason` STRING COMMENT 'Reason for rejection if applicable',
    `sales_agency_id_2` BIGINT COMMENT 'FK to sales agency',
    `submitted_at` TIMESTAMP COMMENT 'Timestamp when proposal was submitted',
    `submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when proposal was submitted',
    `target_demographic` STRING COMMENT 'Target demographic audience',
    `terms_and_conditions` STRING COMMENT 'Terms and conditions text',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total proposed budget amount',
    `total_proposed_value` DECIMAL(18,2) COMMENT 'Total proposed monetary value',
    `total_value` DECIMAL(18,2) COMMENT 'Total monetary value of the proposal',
    `updated_at` TIMESTAMP COMMENT 'Record last update timestamp',
    `valid_from_date` DATE COMMENT 'Start of proposal validity period',
    `valid_to_date` DATE COMMENT 'End of proposal validity period',
    `version` STRING COMMENT 'Version number of the proposal',
    `version_number` STRING COMMENT 'Proposal version number',
    `win_probability_percent` DECIMAL(18,2) COMMENT 'Estimated probability of winning the deal',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'A formal commercial offer presented to an advertiser, agency, or content buyer in response to an RFP or proactive pitch. Captures proposal version, total proposed value, CPM/GRP targets, daypart mix, platform mix (linear, OTT, FAST, AVOD), content adjacency preferences, audience demographic targets, flight start and end dates, proposal status (draft, submitted, revised, accepted, rejected), and expiry date. Linked to an opportunity and one or more rate cards. Sourced from Salesforce Media Cloud Proposal/Quote object. | Unity Catalog table: media_broadcasting_ecm.sales.proposal';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` (
    `proposal_line_id` BIGINT COMMENT 'Unique identifier for the proposal line item. Primary key. | Column proposal_line_id (BIGINT) in sales.proposal_line',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Each proposal line specifies inventory on a specific channel. Business process: line-item inventory allocation, channel-specific rate card application, audience delivery planning. Replaces denormalize | Column channel_id (BIGINT) in scheduling.proposal_line',
    `daypart_id` BIGINT COMMENT 'Foreign key linking to scheduling.daypart. Business justification: Proposal lines specify daypart for inventory being offered. Business process: daypart-based pricing, audience targeting, GRP/impression estimation. Replaces denormalized daypart text field with proper | Column daypart_id (BIGINT) in scheduling.proposal_line',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Rights compliance in proposal building: a proposal line for licensed content must reference the specific grant that authorizes the proposed platform/window/territory combination. Sales teams and right',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Individual proposal lines in content licensing proposals specify which media assets are included in each license grant. This enables line-level asset availability checking, format specification matchi | Column licensed_media_asset_id (BIGINT) in mediaasset.proposal_line',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.package. Business justification: Broadcast sales proposals are built around content packages (e.g., Sports Package, Primetime Drama Bundle). Each proposal line item specifies which content package is being offered. Without this FK, p',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Broadcast proposals are built against specific program schedules to quote inventory availability and CPM rates. Linking proposal_line to program_schedule enables pre-sale inventory checks and audience',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to sales.proposal. Business justification: proposal_line is a child line item of proposal — this is the critical missing parent-child FK. A proposal_line cannot exist without a parent proposal. The proposal_line table currently has no FK back ',
    `rate_card_id` BIGINT COMMENT 'Reference to the rate card used as the basis for pricing this proposal line. | Column rate_card_id (BIGINT) in advertising.proposal_line',
    `_created_at` TIMESTAMP COMMENT 'Medallion lineage column for _created_at | Column _created_at (TIMESTAMP) in sales.proposal_line',
    `_updated_at` TIMESTAMP COMMENT 'Medallion lineage column for _updated_at | Column _updated_at (TIMESTAMP) in sales.proposal_line',
    `agency_commission_percentage` DECIMAL(18,2) COMMENT 'Percentage commission allocated to the advertising agency for this line item. | Column agency_commission_percentage (DECIMAL(5,2)) in sales.proposal_line',
    `audience_guarantee_flag` BOOLEAN COMMENT 'Indicates whether this line includes an audience delivery guarantee requiring makegoods if underdelivered. | Column audience_guarantee_flag (BOOLEAN) in sales.proposal_line',
    `cpm` DECIMAL(18,2) COMMENT 'Cost per thousand impressions for this inventory line, a standard pricing metric in advertising. | Column cpm (DECIMAL(10,2)) in sales.proposal_line',
    `cprp` DECIMAL(18,2) COMMENT 'Cost per rating point for this line item, used in broadcast television pricing. | Column cprp (DECIMAL(15,2)) in sales.proposal_line',
    `created_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column created_at (TIMESTAMP) in sales.proposal_line',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal line item record was first created in the system. | Column created_timestamp (TIMESTAMP) in sales.proposal_line',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this line item. | Column currency_code (STRING) in sales.proposal_line. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute dollar amount of discount applied to this line item. | Column discount_amount (DECIMAL(15,2)) in sales.proposal_line',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to this line item (e.g., volume discount, upfront commitment discount). | Column discount_percentage (DECIMAL(5,2)) in sales.proposal_line',
    `flight_end_date` DATE COMMENT 'End date of the proposed campaign flight or license window for this line item. | Column flight_end_date (DATE) in sales.proposal_line',
    `flight_start_date` DATE COMMENT 'Start date of the proposed campaign flight or license window for this line item. | Column flight_start_date (DATE) in sales.proposal_line',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross value of this proposal line before any discounts or adjustments. | Column gross_amount (DECIMAL(15,2)) in sales.proposal_line',
    `guaranteed_impressions` BIGINT COMMENT 'Minimum number of impressions guaranteed to be delivered for this line item if audience guarantee applies. | Column guaranteed_impressions (BIGINT) in sales.proposal_line',
    `inventory_type` STRING COMMENT 'Type of advertising or content inventory unit being offered in this proposal line. [ENUM-REF-CANDIDATE: linear_spot|digital_preroll|digital_midroll|sponsorship|program_integration|content_license|syndication_slot|vod_placement|fast_channel|display_banner — 10 candidates stripped; promote to reference product] | Column inventory_type (STRING) in sales.proposal_line',
    `line_description` STRING COMMENT 'Detailed description of the inventory offering, targeting, and special terms for this proposal line. | Column line_description (STRING) in sales.proposal_line',
    `line_number` STRING COMMENT 'Sequential line number within the proposal for ordering and reference purposes. | Column line_number (INT) in sales.proposal_line',
    `line_status` STRING COMMENT 'Current status of this proposal line item in the sales negotiation lifecycle. | Column line_status (STRING) in sales.proposal_line. Valid values are `draft|proposed|negotiating|accepted|rejected|expired`',
    `makegood_eligible_flag` BOOLEAN COMMENT 'Indicates whether this line item is eligible for makegood spots if delivery guarantees are not met. | Column makegood_eligible_flag (BOOLEAN) in sales.proposal_line',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this proposal line item record was last modified. | Column modified_timestamp (TIMESTAMP) in sales.proposal_line',
    `net_amount` DECIMAL(18,2) COMMENT 'Net value of this proposal line after discounts and before agency commission. | Column net_amount (DECIMAL(15,2)) in sales.proposal_line',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this proposal line item. | Column notes (STRING) in sales.proposal_line',
    `platform` STRING COMMENT 'Distribution platform or channel where the inventory will be delivered. [ENUM-REF-CANDIDATE: linear_tv|ott|vod|svod|avod|fast|digital_web|mobile_app|social_media|podcast — 10 candidates stripped; promote to reference product] | Column platform (STRING) in sales.proposal_line',
    `proposed_grp` DECIMAL(18,2) COMMENT 'Estimated Gross Rating Points to be delivered, representing the sum of ratings achieved by the schedule. | Column proposed_grp (DECIMAL(10,2)) in sales.proposal_line',
    `proposed_impressions` BIGINT COMMENT 'Estimated number of impressions or views to be delivered for this line item. | Column proposed_impressions (BIGINT) in sales.proposal_line',
    `proposed_trp` DECIMAL(18,2) COMMENT 'Estimated Target Rating Points for the specific demographic audience being targeted. | Column proposed_trp (DECIMAL(10,2)) in sales.proposal_line',
    `source_system_code` STRING COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column source_id (STRING) in sales.proposal_line',
    `target_demographic` STRING COMMENT 'Audience demographic segment being targeted for this inventory (e.g., Adults 18-49, Women 25-54). | Column target_demographic (STRING) in sales.proposal_line',
    `unit_length_seconds` STRING COMMENT 'Duration of each advertising unit in seconds (e.g., 15, 30, 60 seconds for spots). | Column unit_length_seconds (INT) in sales.proposal_line',
    `unit_quantity` STRING COMMENT 'Number of advertising units or spots being proposed in this line (e.g., 30 spots, 5 sponsorships). | Column unit_quantity (INT) in sales.proposal_line',
    `unit_rate` DECIMAL(18,2) COMMENT 'Proposed rate per individual unit (e.g., cost per spot, cost per sponsorship). | Column unit_rate (DECIMAL(15,2)) in sales.proposal_line',
    `updated_at` TIMESTAMP COMMENT 'Medallion lineage tracking column for bronze->silver->gold tracing | Column updated_at (TIMESTAMP) in sales.proposal_line',
    CONSTRAINT pk_proposal_line PRIMARY KEY(`proposal_line_id`)
) COMMENT 'Individual line item within a sales proposal, representing a specific inventory unit being offered — a daypart block, a program sponsorship, a digital pre-roll package, a content license window, or a syndication slot. Captures unit type, platform, channel or property, daypart, audience demographic target, proposed impressions or GRPs, unit rate, CPM, total line value, and makegood eligibility flag. Enables granular negotiation at the inventory unit level before order commitment. | Unity Catalog table: media_broadcasting_ecm.sales.proposal_line Integrates with Salesforce Media Cloud (sales CRM).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`proposal`(`proposal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ADD CONSTRAINT `fk_sales_ad_order_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_ad_order_id` FOREIGN KEY (`ad_order_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order`(`ad_order_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ADD CONSTRAINT `fk_sales_ad_order_line_makegood_for_line_ad_order_line_id` FOREIGN KEY (`makegood_for_line_ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ADD CONSTRAINT `fk_sales_sales_campaign_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`account`(`account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ADD CONSTRAINT `fk_sales_advertiser_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ADD CONSTRAINT `fk_sales_sales_agency_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`account`(`account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_ad_order_line_id` FOREIGN KEY (`ad_order_line_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_order_line`(`ad_order_line_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_original_spot_ad_spot_id` FOREIGN KEY (`original_spot_ad_spot_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`ad_spot`(`ad_spot_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ADD CONSTRAINT `fk_sales_ad_spot_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ADD CONSTRAINT `fk_sales_upfront_deal_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ADD CONSTRAINT `fk_sales_account_parent_account_sales_account_id` FOREIGN KEY (`parent_account_sales_account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`account`(`account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`account`(`account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`account`(`account_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_advertiser_id` FOREIGN KEY (`advertiser_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`advertiser`(`advertiser_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`opportunity`(`opportunity_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_sales_agency_id` FOREIGN KEY (`sales_agency_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_agency`(`sales_agency_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_sales_campaign_id` FOREIGN KEY (`sales_campaign_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`sales_campaign`(`sales_campaign_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ADD CONSTRAINT `fk_sales_proposal_upfront_deal_id` FOREIGN KEY (`upfront_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`upfront_deal`(`upfront_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ADD CONSTRAINT `fk_sales_proposal_line_proposal_id` FOREIGN KEY (`proposal_id`) REFERENCES `vibe_media_broadcasting_v1`.`sales`.`proposal`(`proposal_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`sales` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`sales` SET TAGS ('dbx_domain' = 'sales');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.ad_order_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.ad_order_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.advertiser_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.advertiser_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Proposal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.salesforce_opportunity_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.salesforce_opportunity_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.subscriber_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.subscriber_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `affidavit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `affidavit_required_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `affidavit_required_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.affidavit_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `affidavit_required_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.affidavit_required_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'weekly|monthly|end_of_flight|milestone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.billing_cycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.billing_cycle');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.commission_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `commission_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.commission_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.confirmed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.confirmed_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cpm` SET TAGS ('dbx_business_glossary_term' = 'Contracted Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cpm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cpm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.contracted_cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cpm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.contracted_cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cprp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cprp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cprp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.contracted_cprp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `contracted_cprp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.contracted_cprp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.daypart_mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.daypart_mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.discount_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.discount_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.flight_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.flight_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.flight_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.flight_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_business_glossary_term' = 'Makegood Policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_value_regex' = 'standard|guaranteed|no_makegood|custom');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.makegood_policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `makegood_policy` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.makegood_policy');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `market_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `market_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.market_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `market_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.market_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `market_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `mmm_adstock_decay_rate` SET TAGS ('dbx_business_glossary_term' = 'Adstock Decay');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `mmm_channel_contribution` SET TAGS ('dbx_business_glossary_term' = 'MMM Channel Contribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `mmm_saturation_point` SET TAGS ('dbx_business_glossary_term' = 'MMM Saturation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.net_order_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `net_order_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.net_order_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.order_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.order_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.order_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.order_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.order_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.order_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|direct|programmatic|sponsorship|barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.order_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.order_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `order_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.payment_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.payment_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_business_glossary_term' = 'Political Ad Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.political_ad_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `political_ad_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.political_ad_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `product_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `product_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.product_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `product_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.product_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `product_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.target_demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.target_demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_demographic` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_grp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_grp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.target_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_grp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.target_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_trp` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_trp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_trp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.target_trp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `target_trp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.target_trp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_contracted_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contracted Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_contracted_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_contracted_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.total_contracted_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_contracted_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.total_contracted_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_spot_count` SET TAGS ('dbx_business_glossary_term' = 'Total Spot Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_spot_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_spot_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.total_spot_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `total_spot_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.total_spot_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `wide_orbit_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `wide_orbit_order_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `wide_orbit_order_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order.wide_orbit_order_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order` ALTER COLUMN `wide_orbit_order_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order.wide_orbit_order_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.ad_order_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.ad_order_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.ad_order_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `ad_order_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.ad_order_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.license_agreement_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `makegood_for_line_ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Makegood For Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `makegood_for_line_ad_order_line_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `makegood_for_line_ad_order_line_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.makegood_for_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `makegood_for_line_ad_order_line_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.makegood_for_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.scheduling_daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.scheduling_daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Gross Rating Points (GRP) Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.actual_grp_delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_grp_delivered` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.actual_grp_delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Impressions Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_impressions_delivered` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_impressions_delivered` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.actual_impressions_delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_impressions_delivered` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.actual_impressions_delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_spots_aired` SET TAGS ('dbx_business_glossary_term' = 'Actual Spots Aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_spots_aired` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_spots_aired` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.actual_spots_aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `actual_spots_aired` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.actual_spots_aired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `attribution_model_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `attribution_weight` SET TAGS ('dbx_business_glossary_term' = 'Attribution Weight');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `competitive_separation_category` SET TAGS ('dbx_business_glossary_term' = 'Competitive Separation Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `competitive_separation_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `competitive_separation_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.competitive_separation_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `competitive_separation_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.competitive_separation_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `competitive_separation_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_grp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_grp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_grp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.contracted_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_grp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.contracted_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_business_glossary_term' = 'Contracted Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.contracted_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_impressions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.contracted_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_spots` SET TAGS ('dbx_business_glossary_term' = 'Contracted Spots');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_spots` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_spots` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.contracted_spots');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_spots` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.contracted_spots');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_trp` SET TAGS ('dbx_business_glossary_term' = 'Contracted Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_trp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_trp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.contracted_trp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `contracted_trp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.contracted_trp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `conversion_path_position` SET TAGS ('dbx_business_glossary_term' = 'Path Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `copy_split_rule` SET TAGS ('dbx_business_glossary_term' = 'Copy Split Rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `copy_split_rule` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `copy_split_rule` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.copy_split_rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `copy_split_rule` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.copy_split_rule');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cpm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cpm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cpm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cprp` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cprp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cprp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.cprp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `cprp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.cprp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.discount_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.discount_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.flight_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.flight_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.flight_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.flight_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|preemptible|fixed|bonus|makegood');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.inventory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.inventory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.line_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.line_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.line_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.line_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.line_total_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.line_total_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.net_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.net_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `position_preference` SET TAGS ('dbx_business_glossary_term' = 'Position Preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `position_preference` SET TAGS ('dbx_value_regex' = 'first_in_pod|last_in_pod|middle_in_pod|any|fixed_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `position_preference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `position_preference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.position_preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `position_preference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.position_preference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_business_glossary_term' = 'Preemption Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.preemption_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `preemption_priority` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.preemption_priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.revenue_recognition_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.revenue_recognition_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `rotation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Rotation Instructions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `rotation_instructions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `rotation_instructions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.rotation_instructions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `rotation_instructions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.rotation_instructions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.special_handling_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `special_handling_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.special_handling_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length (Seconds)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.spot_length_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.spot_length_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `touchpoint_sequence_code` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Sequence');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_business_glossary_term' = 'Trafficking Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.trafficking_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `trafficking_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.trafficking_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.unit_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.unit_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_order_line.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_order_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_order_line.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.advertiser_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.advertiser_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.talent_profile_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Campaign Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.approved_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `attribution_model_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `attribution_weight` SET TAGS ('dbx_business_glossary_term' = 'Attribution Weight');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.campaign_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.campaign_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.campaign_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.campaign_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.campaign_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.campaign_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'brand_awareness|direct_response|political|sponsorship|promotional|product_launch');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.campaign_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.campaign_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `conversion_path_position` SET TAGS ('dbx_business_glossary_term' = 'Path Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.makegood_eligible_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.makegood_eligible_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'national|regional|local|dma_specific');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `market_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `market_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.market_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `market_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.market_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `market_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `mmm_adstock_decay_rate` SET TAGS ('dbx_business_glossary_term' = 'Adstock Decay');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `mmm_channel_contribution` SET TAGS ('dbx_business_glossary_term' = 'MMM Channel Contribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `mmm_saturation_point` SET TAGS ('dbx_business_glossary_term' = 'MMM Saturation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Campaign Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|priority|premium|guaranteed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.priority_level');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `product_brand` SET TAGS ('dbx_business_glossary_term' = 'Product or Brand Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `product_brand` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `product_brand` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.product_brand');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `product_brand` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.product_brand');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'upfront|scatter|programmatic|direct|sponsorship');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_channel` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_channel` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.sales_channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `sales_channel` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.sales_channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `salesforce_campaign_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Media Cloud Campaign Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `salesforce_campaign_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `salesforce_campaign_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.salesforce_campaign_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `salesforce_campaign_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.salesforce_campaign_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.target_cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_cpm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.target_cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_business_glossary_term' = 'Target Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.target_cprp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_cprp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.target_cprp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_frequency` SET TAGS ('dbx_business_glossary_term' = 'Target Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_frequency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_frequency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.target_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_frequency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.target_frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_grp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_grp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.target_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_grp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.target_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_impressions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_impressions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.target_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_impressions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.target_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_reach_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Reach Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_reach_percent` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_reach_percent` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.target_reach_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_reach_percent` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.target_reach_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_sov_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Share of Voice (SOV) Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_sov_percent` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_sov_percent` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.target_sov_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_sov_percent` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.target_sov_percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_trp` SET TAGS ('dbx_business_glossary_term' = 'Target Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_trp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_trp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.target_trp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `target_trp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.target_trp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Campaign Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.total_budget_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.total_budget_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `touchpoint_sequence_code` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Sequence');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.campaign.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_campaign` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.campaign.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.advertiser_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.advertiser_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.account_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.account_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `account_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_value_regex' = 'tier_1_platinum|tier_2_gold|tier_3_silver|tier_4_bronze|tier_5_standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.annual_spend_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.annual_spend_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `annual_spend_tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.billing_address_line1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.billing_address_line1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.billing_address_line2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.billing_address_line2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.billing_city');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_city` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.billing_city');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.billing_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.billing_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.billing_postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.billing_postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.billing_state_province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.billing_state_province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.contract_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.contract_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.contract_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.contract_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.credit_limit_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.credit_limit_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|on_hold|under_review|declined');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.credit_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.credit_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `credit_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `industry_category` SET TAGS ('dbx_business_glossary_term' = 'Industry Category (IAB Taxonomy)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `industry_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `industry_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.industry_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `industry_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.industry_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `industry_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_business_glossary_term' = 'Is Political Advertiser Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.is_political_advertiser');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `is_political_advertiser` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.is_political_advertiser');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Legal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.legal_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `legal_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.legal_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.parent_company_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.parent_company_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|prepay|credit_card|due_on_receipt');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.payment_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `payment_terms` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.payment_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.preferred_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.preferred_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.primary_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.primary_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_validation_regex' = '^+?[1-9]d{1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_14}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.primary_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.primary_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `requires_ad_clearance` SET TAGS ('dbx_business_glossary_term' = 'Requires Ad Clearance Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `requires_ad_clearance` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `requires_ad_clearance` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.requires_ad_clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `requires_ad_clearance` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.requires_ad_clearance');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.tax_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.tax_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Trade Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.trade_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `trade_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.trade_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.updated_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Website URL');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `website_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `website_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `website_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.website_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `website_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.website_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `wide_orbit_advertiser_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Advertiser Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `wide_orbit_advertiser_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `wide_orbit_advertiser_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.advertiser.wide_orbit_advertiser_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `wide_orbit_advertiser_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.advertiser.wide_orbit_advertiser_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`advertiser` ALTER COLUMN `wide_orbit_advertiser_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `account_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `account_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `account_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.accreditation_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.accreditation_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.accreditation_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.accreditation_expiry_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_value_regex' = 'accredited|pending|not-accredited|suspended|revoked');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.accreditation_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.accreditation_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_value_regex' = 'full-service|media-buying|digital|programmatic|creative|in-house');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.agency_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.agency_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.billing_address_line1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.billing_address_line1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.billing_address_line2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.billing_address_line2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.billing_city');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_city` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.billing_city');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.billing_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.billing_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'gross|net|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.billing_model');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_model` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.billing_model');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.billing_postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.billing_postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.billing_state_province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.billing_state_province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `commission_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `commission_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.commission_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `commission_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.commission_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.credit_limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `credit_limit` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.credit_limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_business_glossary_term' = 'Holding Company Group');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.holding_company_group');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `holding_company_group` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.holding_company_group');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.modified_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.sales_agency_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.sales_agency_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agency Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.onboarding_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.onboarding_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.payment_terms_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.payment_terms_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.preferred_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.preferred_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.primary_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.primary_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_validation_regex' = '^+?[1-9]d{1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_14}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.primary_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.primary_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_status` SET TAGS ('dbx_business_glossary_term' = 'Agency Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending-approval|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.sales_agency_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.sales_agency_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `sales_agency_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.status_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `status_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.status_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.tax_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.tax_identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.termination_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `termination_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.termination_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_validation_regex_^https?' = '//[^s]+$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.website_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `website_url` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.website_url');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `wide_orbit_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Wide Orbit Agency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `wide_orbit_agency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `wide_orbit_agency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.wide_orbit_agency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `wide_orbit_agency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.wide_orbit_agency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `wide_orbit_agency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `wide_orbit_agency_code` SET TAGS ('dbx_vendor_ref' = 'Wide Orbit');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_by` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_by` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_agency.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`sales_agency` ALTER COLUMN `created_by` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_agency.created_by');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.ad_spot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_spot_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.ad_spot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_break_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Break Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Order Line ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.ad_order_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_order_line_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.ad_order_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.advertiser_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.advertiser_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `original_spot_ad_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Original Spot ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `original_spot_ad_spot_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `original_spot_ad_spot_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.original_spot_ad_spot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `original_spot_ad_spot_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.original_spot_ad_spot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `playout_event_id` SET TAGS ('dbx_business_glossary_term' = 'Playout Event Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `sales_campaign_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.campaign_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Slot Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `schedule_slot_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.schedule_slot_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.subscriber_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.subscriber_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `title_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.title_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `viewer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Viewer Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.actual_air_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `actual_air_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.actual_air_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_business_glossary_term' = 'Ad Pod Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.ad_pod_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `ad_pod_position` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.ad_pod_position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `affidavit_reference` SET TAGS ('dbx_business_glossary_term' = 'Affidavit Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `affidavit_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `affidavit_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.affidavit_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `affidavit_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.affidavit_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `attribution_model_type` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `attribution_weight` SET TAGS ('dbx_business_glossary_term' = 'Attribution Weight');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'unbilled|billed|invoiced|paid|disputed|written_off');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `billing_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `billing_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.billing_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `billing_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.billing_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `billing_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `bonus_spot_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Spot Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `bonus_spot_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `bonus_spot_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.bonus_spot_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `bonus_spot_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.bonus_spot_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `conversion_path_position` SET TAGS ('dbx_business_glossary_term' = 'Path Position');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `cpm_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `cpm_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `cpm_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.cpm_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `cpm_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.cpm_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `dai_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Ad Insertion (DAI) Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `dai_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `dai_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.dai_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `dai_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.dai_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `daypart` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `daypart` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `daypart` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_business_glossary_term' = 'Delivery Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.delivery_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.delivery_platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `grp_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Rating Point (GRP) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `grp_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `grp_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.grp_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `grp_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.grp_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_business_glossary_term' = 'Impressions Delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.impressions_delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `impressions_delivered` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.impressions_delivered');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.makegood_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `makegood_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.makegood_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `market_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `market_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.market_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `market_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.market_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `market_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preempted_flag` SET TAGS ('dbx_business_glossary_term' = 'Preempted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preempted_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preempted_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.preempted_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preempted_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.preempted_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Preemption Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.preemption_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `preemption_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.preemption_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pattern');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.rotation_pattern');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.rotation_pattern');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.scheduled_air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.scheduled_air_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Air Time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_time` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_time` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.scheduled_air_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `scheduled_air_time` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.scheduled_air_time');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `separation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Separation Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `separation_requirement` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `separation_requirement` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.separation_requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `separation_requirement` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.separation_requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Length in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.spot_length_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_length_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.spot_length_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Spot Rate Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.spot_rate_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.spot_rate_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Spot Rate Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.spot_rate_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_rate_currency` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.spot_rate_currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_status` SET TAGS ('dbx_business_glossary_term' = 'Spot Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_status` SET TAGS ('dbx_value_regex' = 'scheduled|aired|preempted|cancelled|makegood_pending|makegood_fulfilled');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.spot_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.spot_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `spot_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `touchpoint_sequence_code` SET TAGS ('dbx_business_glossary_term' = 'Touchpoint Sequence');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `traffic_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Traffic Log Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `traffic_log_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `traffic_log_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.traffic_log_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `traffic_log_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.traffic_log_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `trp_value` SET TAGS ('dbx_business_glossary_term' = 'Target Rating Point (TRP) Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `trp_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `trp_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.trp_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `trp_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.trp_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.ad_spot.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`ad_spot` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.ad_spot.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.upfront_deal_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.upfront_deal_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_business_glossary_term' = 'Advertiser Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.advertiser_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `advertiser_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.advertiser_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.demographic_segment_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_grp` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_grp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_grp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.audience_guarantee_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_grp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.audience_guarantee_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_impressions` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_impressions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_impressions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.audience_guarantee_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `audience_guarantee_impressions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.audience_guarantee_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cancellation_option_window_days` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Option Window Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cancellation_option_window_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cancellation_option_window_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.cancellation_option_window_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cancellation_option_window_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.cancellation_option_window_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `channel_mix` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `channel_mix` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.channel_mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `channel_mix` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.channel_mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `commitment_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `commitment_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.commitment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `commitment_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.commitment_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.cpm_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.cpm_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP) Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.cprp_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.cprp_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR|AUD');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.daypart_mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.daypart_mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{5,8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.deal_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.deal_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.deal_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.deal_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|direct|programmatic|sponsorship|barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.deal_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.deal_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_year` SET TAGS ('dbx_business_glossary_term' = 'Deal Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_year` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_year` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.deal_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `deal_year` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.deal_year');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `execution_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `execution_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.execution_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `execution_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.execution_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `makegood_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Provision Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `makegood_provision_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `makegood_provision_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.makegood_provision_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `makegood_provision_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.makegood_provision_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `mmm_adstock_decay_rate` SET TAGS ('dbx_business_glossary_term' = 'Adstock Decay');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `mmm_channel_contribution` SET TAGS ('dbx_business_glossary_term' = 'MMM Channel Contribution');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `mmm_saturation_point` SET TAGS ('dbx_business_glossary_term' = 'MMM Saturation');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `negotiation_round_count` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Round Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `negotiation_round_count` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `negotiation_round_count` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.negotiation_round_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `negotiation_round_count` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.negotiation_round_count');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Deadline');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.option_exercise_deadline');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `option_exercise_deadline` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.option_exercise_deadline');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_value_regex' = 'cpm|cprp|flat_rate|performance');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.pricing_basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.pricing_basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.proposal_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.proposal_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `salesforce_opportunity_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `salesforce_opportunity_reference` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9]{15,18}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `salesforce_opportunity_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `salesforce_opportunity_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.salesforce_opportunity_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `salesforce_opportunity_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.salesforce_opportunity_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `salesforce_opportunity_reference` SET TAGS ('dbx_vendor_ref' = 'Salesforce');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `scatter_conversion_rights` SET TAGS ('dbx_business_glossary_term' = 'Scatter Conversion Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `scatter_conversion_rights` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `scatter_conversion_rights` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.scatter_conversion_rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `scatter_conversion_rights` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.scatter_conversion_rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Spend');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.total_committed_spend');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `total_committed_spend` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.total_committed_spend');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `total_proposed_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Proposed Spend');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `total_proposed_spend` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `total_proposed_spend` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.total_proposed_spend');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `total_proposed_spend` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.total_proposed_spend');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.upfront_deal.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`upfront_deal` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.upfront_deal.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` SET TAGS ('dbx_subdomain' = 'client_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `parent_account_sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sales Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `parent_account_sales_account_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `parent_account_sales_account_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.parent_account_sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `parent_account_sales_account_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.parent_account_sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.account_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.account_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'agency|direct_advertiser|mvpd|vmvpd|syndicator|content_licensee');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.account_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.account_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.agency_commission_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `agency_commission_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.agency_commission_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `annual_revenue_potential` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Potential');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `annual_revenue_potential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `annual_revenue_potential` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `annual_revenue_potential` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.annual_revenue_potential');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `annual_revenue_potential` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.annual_revenue_potential');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.auto_renewal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.auto_renewal_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.billing_address_line1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.billing_address_line1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.billing_address_line2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.billing_address_line2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.billing_city');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_city` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.billing_city');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.billing_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.billing_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.billing_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.billing_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_validation_regex' = '^+?[1-9]d{1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_14}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.billing_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.billing_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_validation_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.billing_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.billing_country_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.billing_postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.billing_postal_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.billing_state_province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.billing_state_province');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.blackout_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.blackout_restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.contract_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.contract_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.contract_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.contract_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.credit_limit_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.credit_limit_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.credit_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.credit_rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `holding_company_name` SET TAGS ('dbx_business_glossary_term' = 'Holding Company Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `holding_company_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `holding_company_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `holding_company_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.holding_company_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `holding_company_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.holding_company_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_business_glossary_term' = 'Industry Vertical');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.industry_vertical');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `industry_vertical` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.industry_vertical');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.last_activity_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.last_activity_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.account_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `account_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.account_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.payment_terms_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.payment_terms_days');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.preferred_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.preferred_currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_validation_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.primary_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.primary_contact_email');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.primary_contact_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_validation_regex' = '^+?[1-9]d{1');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_14}$' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.primary_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.primary_contact_phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `salesforce_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `salesforce_account_reference` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `salesforce_account_reference` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.salesforce_account_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `salesforce_account_reference` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.salesforce_account_reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `salesforce_account_reference` SET TAGS ('dbx_vendor_ref' = 'Salesforce');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.tax_id_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.tax_id_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tier` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tier` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.account_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tier` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.account_tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `tier` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.sales_account.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`account` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.sales_account.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` SET TAGS ('dbx_subdomain' = 'pipeline_conversion');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.opportunity_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.opportunity_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.sales_account_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.sales_agency_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.upfront_deal_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.upfront_deal_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Marketing Objective');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.campaign_objective');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `campaign_objective` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.campaign_objective');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `close_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `close_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.close_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `close_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.close_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `closed_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `closed_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.closed_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `closed_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.closed_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `competitive_displacement` SET TAGS ('dbx_business_glossary_term' = 'Competitive Displacement Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `competitive_displacement` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `competitive_displacement` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.competitive_displacement');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `competitive_displacement` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.competitive_displacement');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM) Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.cpm_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `cpm_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.cpm_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP) Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.cprp_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `cprp_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.cprp_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `daypart` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `daypart` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `daypart` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `daypart` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.daypart');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'upfront|scatter|direct|programmatic_guaranteed|content_license|syndication');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `deal_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `deal_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.deal_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `deal_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.deal_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `deal_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `demographic_target` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic Audience');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `demographic_target` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `demographic_target` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.demographic_target');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `demographic_target` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.demographic_target');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Deal Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `estimated_value` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `estimated_value` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.estimated_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `estimated_value` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.estimated_value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.flight_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.flight_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.flight_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.flight_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Forecast Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'pipeline|best_case|commit|closed');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.forecast_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.forecast_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `forecast_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `is_upfront` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `is_upfront` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `is_upfront` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.is_upfront');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `is_upfront` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.is_upfront');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sales Activity Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.last_activity_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.last_activity_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.last_modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_business_glossary_term' = 'Lead Source Channel');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.lead_source');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `lead_source` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.lead_source');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_notes` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason Detailed Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.loss_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.loss_notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_value_regex' = 'budget|timing|competitor|no_decision|product_fit|pricing');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.loss_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.loss_reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.opportunity_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.opportunity_name');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `next_step` SET TAGS ('dbx_business_glossary_term' = 'Next Action Step');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `next_step` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `next_step` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.next_step');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `next_step` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.next_step');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_value_regex' = '^OPP-[0-9]{8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.opportunity_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.opportunity_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `probability` SET TAGS ('dbx_business_glossary_term' = 'Close Probability Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `probability` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `probability` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.probability');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `probability` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.probability');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Media Product Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `product_category` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `product_category` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.product_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `product_category` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.product_category');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `product_category` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `requires_makegood` SET TAGS ('dbx_business_glossary_term' = 'Makegood Requirement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `requires_makegood` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `requires_makegood` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.requires_makegood');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `requires_makegood` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.requires_makegood');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'prospecting|qualification|proposal|negotiation|closed_won|closed_lost');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.stage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.stage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `target_grp` SET TAGS ('dbx_business_glossary_term' = 'Target Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `target_grp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `target_grp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.target_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `target_grp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.target_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `target_impressions` SET TAGS ('dbx_business_glossary_term' = 'Target Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `target_impressions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `target_impressions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.target_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `target_impressions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.target_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.opportunity.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`opportunity` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.opportunity.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` SET TAGS ('dbx_subdomain' = 'pipeline_conversion');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `sales_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Agency');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `upfront_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Upfront Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `channel_mix` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'CPM');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `daypart_mix` SET TAGS ('dbx_business_glossary_term' = 'Daypart Mix');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount %');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified At');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `net_proposed_value` SET TAGS ('dbx_business_glossary_term' = 'Net Proposed Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_grp` SET TAGS ('dbx_business_glossary_term' = 'Proposed GRP');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `proposed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Proposed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted At');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demo');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `total_proposed_value` SET TAGS ('dbx_business_glossary_term' = 'Proposed Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal` ALTER COLUMN `win_probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Win Probability');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` SET TAGS ('dbx_subdomain' = 'pipeline_conversion');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposal_line_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Line Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposal_line_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposal_line_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.proposal_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposal_line_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.proposal_line_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `channel_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.channel_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_business_glossary_term' = 'Daypart Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `daypart_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.daypart_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.licensed_media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.licensed_media_asset_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.rate_card_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.rate_card_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `_created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line._created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `_updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line._updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_business_glossary_term' = 'Agency Commission Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.agency_commission_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `agency_commission_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.agency_commission_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Audience Guarantee Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.audience_guarantee_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `audience_guarantee_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.audience_guarantee_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `cpm` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Mille (CPM)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `cpm` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `cpm` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `cpm` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.cpm');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `cprp` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Rating Point (CPRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `cprp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `cprp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.cprp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `cprp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.cprp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `created_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `created_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `created_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `created_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.created_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.created_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.currency_code');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.discount_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.discount_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.discount_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.discount_percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_business_glossary_term' = 'Flight End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.flight_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `flight_end_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.flight_end_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.flight_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `flight_start_date` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.flight_start_date');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.gross_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.gross_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.guaranteed_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `guaranteed_impressions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.guaranteed_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.inventory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.inventory_type');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `inventory_type` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_description` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_description` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.line_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_description` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.line_description');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_number` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_number` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.line_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_number` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.line_number');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|proposed|negotiating|accepted|rejected|expired');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.line_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.line_status');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Eligible Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.makegood_eligible_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `makegood_eligible_flag` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.makegood_eligible_flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.modified_timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.net_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.net_amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `notes` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `notes` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `notes` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Distribution Platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `platform` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `platform` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `platform` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.platform');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_grp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Gross Rating Points (GRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_grp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_grp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.proposed_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_grp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.proposed_grp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_impressions` SET TAGS ('dbx_business_glossary_term' = 'Proposed Impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_impressions` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_impressions` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.proposed_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_impressions` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.proposed_impressions');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_trp` SET TAGS ('dbx_business_glossary_term' = 'Proposed Target Rating Points (TRP)');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_trp` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_trp` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.proposed_trp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `proposed_trp` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.proposed_trp');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.source_id');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `target_demographic` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `target_demographic` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `target_demographic` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.target_demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `target_demographic` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.target_demographic');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `target_demographic` SET TAGS ('dbx_enum_ref_candidate' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_business_glossary_term' = 'Unit Length in Seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.unit_length_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_length_seconds` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.unit_length_seconds');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unit Quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_quantity` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_quantity` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.unit_quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_quantity` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.unit_quantity');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.unit_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.unit_rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_lineage' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_ddl_column_comment' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_uc_qualified_name' = 'media_broadcasting_ecm.sales.proposal_line.updated_at');
ALTER TABLE `vibe_media_broadcasting_v1`.`sales`.`proposal_line` ALTER COLUMN `updated_at` SET TAGS ('dbx_unity_catalog_col' = 'media_broadcasting.sales.proposal_line.updated_at');
