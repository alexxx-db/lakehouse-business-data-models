-- Schema for Domain: partner | Business: Media_Broadcasting | Version: v3_mvm
-- Generated on: 2026-07-10 21:14:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`partner` COMMENT 'Manages relationships, contracts, and negotiations with studios, syndicators, content providers, MVPDs, and third-party distribution partners. Tracks partner agreements, content acquisition deals, co-production arrangements, and affiliate relationships that feed into rights, distribution, and finance domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` (
    `acquisition_deal_id` BIGINT COMMENT 'Unique identifier for the content acquisition deal. Primary key for the acquisition deal entity.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Acquisition deals for content rights often originate from identified sales opportunities when proactively pursuing content for the portfolio. Tracks deal pipeline from opportunity identification throu',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Acquisition deals for broadcast distribution must verify licensed coverage matches contracted territories. Compliance officers cross-reference deal territories against FCC-licensed footprints to ensur',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Acquisition deals often specify target broadcast channels for content placement (e.g., primetime slot on flagship channel). Critical for content scheduling coordination, deal fulfillment tracking, and',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Acquisition deals specify required content ratings (TV-MA, TV-14, PG, etc.) as contractual obligations. Buyers require sellers to deliver content with appropriate ratings for licensed territories and ',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Acquisition deals are evaluated and priced based on target demographic appeal of the content being acquired. Essential for content acquisition ROI analysis and portfolio strategy.',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Acquisition deals for childrens content (directed to kids under 13) require COPPA compliance declarations covering data collection on associated websites, apps, and interactive platforms. Contracts s',
    `partner_id` BIGINT COMMENT 'Reference to the studio, syndicator, or independent content provider from whom content is being acquired. Links to partner master data.',
    `content_delivery_format` STRING COMMENT 'Technical specifications for content delivery including file formats, resolution standards, and delivery methods (e.g., HD 1080p ProRes, 4K HEVC, physical media, digital file transfer).',
    `content_package_scope` STRING COMMENT 'Detailed description of the content included in this acquisition deal, including series titles, episode counts, seasons, or film packages.',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the executed contract document stored in the document management system.',
    `contract_execution_date` DATE COMMENT 'Date when the acquisition deal contract was formally signed and executed by all parties, marking the transition from negotiation to binding agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this acquisition deal record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this acquisition deal (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `deal_effective_date` DATE COMMENT 'Date when the acquisition deal terms become effective and rights begin to accrue, which may differ from execution date.',
    `deal_expiration_date` DATE COMMENT 'Date when the acquisition deal expires and rights revert to the content provider, marking the end of the license period.',
    `deal_number` STRING COMMENT 'Externally-known business identifier for the acquisition deal, typically formatted with prefix and sequential number for tracking and reference in contracts and communications.. Valid values are `^[A-Z]{2,4}-[0-9]{4,8}$`',
    `deal_status` STRING COMMENT 'Current lifecycle status of the acquisition deal from initial draft through negotiation, execution, and eventual expiration or termination. [ENUM-REF-CANDIDATE: draft|negotiation|legal_review|approved|executed|active|expired|terminated|cancelled — 9 candidates stripped; promote to reference product]',
    `deal_title` STRING COMMENT 'Human-readable name or title of the acquisition deal, typically reflecting the content package or series being acquired.',
    `deal_type` STRING COMMENT 'Classification of the deal structure indicating the financial arrangement: flat fee (fixed payment), revenue share (percentage of revenue), minimum guarantee (MG with upside), hybrid (combination), or barter (exchange of services/inventory).. Valid values are `flat_fee|revenue_share|minimum_guarantee|hybrid|barter`',
    `deal_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the acquisition deal in the specified currency, representing the gross commitment before adjustments.',
    `distribution_rights` STRING COMMENT 'Comma-separated list of distribution platforms and methods covered by this deal (e.g., linear, SVOD, AVOD, TVOD, FAST, syndication, VOD).',
    `episode_count` STRING COMMENT 'Total number of episodes included in the acquisition deal for episodic content such as television series.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the acquisition deal grants exclusive rights within the specified territory, preventing the content provider from licensing to competitors.',
    `exclusivity_scope` STRING COMMENT 'Detailed description of exclusivity terms, including platform restrictions, genre exclusivity, or time-based exclusivity windows.',
    `holdback_period_days` STRING COMMENT 'Number of days during which content must be withheld from certain distribution channels or platforms as part of windowing strategy or exclusivity terms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this acquisition deal record was most recently updated, supporting audit trail and change tracking requirements.',
    `license_term_months` STRING COMMENT 'Duration of the content license in months, representing the period during which the broadcaster has rights to exploit the acquired content.',
    `marketing_materials_included_flag` BOOLEAN COMMENT 'Indicates whether the deal includes delivery of marketing and promotional materials such as trailers, key art, press kits, and promotional clips.',
    `metadata_requirements` STRING COMMENT 'Specifications for content metadata to be delivered with the content package, including descriptive, technical, and rights metadata standards.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment to the content provider regardless of performance, applicable for minimum guarantee and hybrid deal structures.',
    `negotiation_start_date` DATE COMMENT 'Date when formal negotiations for this acquisition deal commenced.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special terms, or contextual information about the acquisition deal not captured in structured fields.',
    `payment_schedule` STRING COMMENT 'Detailed schedule of payment milestones and amounts, including upfront payments, delivery payments, and ongoing royalty schedules.',
    `performance_guarantees` STRING COMMENT 'Contractual performance commitments such as minimum broadcast hours, promotional support, or audience delivery guarantees required by the content provider.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the broadcaster has the option to renew or extend the acquisition deal beyond the initial term.',
    `renewal_terms` STRING COMMENT 'Detailed terms governing deal renewal, including notice periods, pricing adjustments, and conditions for exercising renewal options.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the content provider for revenue share and hybrid deal structures, typically applied after minimum guarantee recoupment.',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the broadcaster is permitted to sublicense the acquired content to third parties such as MVPDs, vMVPDs, or international distributors.',
    `sublicensing_terms` STRING COMMENT 'Detailed terms and restrictions governing sublicensing rights, including revenue sharing with original content provider and territorial limitations.',
    `territory_coverage` STRING COMMENT 'Geographic territories or markets covered by this acquisition deal, specified as comma-separated ISO 3166-1 alpha-3 country codes or regional designations (e.g., USA, CAN, GBR, or NORTH_AMERICA).',
    `total_runtime_hours` DECIMAL(18,2) COMMENT 'Aggregate runtime of all content included in the acquisition deal, measured in hours, used for inventory planning and scheduling.',
    `windowing_strategy` STRING COMMENT 'Sequential release strategy defining the order and timing of content availability across different platforms and distribution channels.. Valid values are `day_and_date|theatrical_holdback|svod_first|linear_first|staggered|simultaneous`',
    CONSTRAINT pk_acquisition_deal PRIMARY KEY(`acquisition_deal_id`)
) COMMENT 'Master record for content acquisition deals negotiated with studios, syndicators, and independent content providers. Captures deal structure (flat fee, revenue share, MG/minimum guarantee), content package scope, exclusivity terms, territory coverage, windowing strategy (SVOD, AVOD, TVOD, linear), and deal status through the full negotiation-to-execution lifecycle. Source of truth for content acquisition commitments feeding into the rights and finance domains.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` (
    `acquisition_deal_line_id` BIGINT COMMENT 'Unique identifier for the acquisition deal line item. Primary key for this entity.',
    `acquisition_deal_id` BIGINT COMMENT 'Reference to the parent acquisition deal that contains this line item. Links this line to the master deal agreement.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Individual titles and episodes in acquisition deal lines have specific rating requirements for the licensed territory and platform. Compliance verification at the line-item level ensures each delivere',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level licensing is common in broadcast acquisitions (e.g., licensing specific pilot or finale episodes separately). Linking deal lines to episodes enables episode-level rights clearance, per-e',
    `title_id` BIGINT COMMENT 'Reference to the specific content title, episode, season, or package being acquired in this line item.',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Deal lines are scoped to specific seasons in multi-season acquisitions. Season-level line items are required for per-season license fee invoicing, delivery obligation generation, and rights window man',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Individual deal line items frequently reference a series (e.g., Series X — all episodes, all territories). Series-level line items drive per-series license fee allocation, rights clearance verificat',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Content acquisition deals often include attached talent as a key deal point—star power drives content valuation and marketing strategy. Essential for deal valuation models, marketing rights clearance,',
    `content_rating` STRING COMMENT 'Age or content rating classification for this content line item (e.g., G, PG, PG-13, R, TV-Y, TV-PG, TV-14, TV-MA). Determines broadcast daypart and audience targeting.',
    `content_type` STRING COMMENT 'Classification of the content being acquired in this line item. Determines rights structure and windowing strategy. [ENUM-REF-CANDIDATE: film|series|season|episode|documentary|special|sports_event|news_package|music_video|short_form — 10 candidates stripped; promote to reference product]',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this acquisition deal line record. Supports audit and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this acquisition deal line record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this line item.. Valid values are `^[A-Z]{3}$`',
    `delivery_due_date` DATE COMMENT 'The date by which the content provider must deliver the content asset for this line item. Critical for production scheduling and playout planning.',
    `delivery_format` STRING COMMENT 'Technical format and delivery method for the content asset associated with this line item. Determines ingest and playout requirements. [ENUM-REF-CANDIDATE: hd|4k|sd|film|digital_file|tape|satellite|ftp|aspera|physical_media — 10 candidates stripped; promote to reference product]',
    `delivery_status` STRING COMMENT 'Current status of content delivery for this line item. Tracks the fulfillment lifecycle from order to ingest.. Valid values are `pending|in_transit|received|ingested|rejected|delayed`',
    `distribution_rights` STRING COMMENT 'Comma-separated list of distribution rights granted for this content line item. May include linear, VOD, SVOD, AVOD, TVOD, theatrical, home video, digital download, streaming, broadcast, cable, satellite, OTT, FAST, syndication, etc. [ENUM-REF-CANDIDATE: promote to reference product and junction table for complex rights matrices]',
    `dubbing_languages` STRING COMMENT 'Comma-separated list of ISO 639 language codes for dubbed audio tracks included with this content line item. Supports multi-territory distribution.',
    `eidr_identifier` STRING COMMENT 'Unique EIDR identifier for the content in this line item. Global standard for audiovisual content identification.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z]$`',
    `episode_count` STRING COMMENT 'Number of episodes included in this line item if the content type is series or season. Null for single-title content.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the rights granted for this line item are exclusive (true) or non-exclusive (false). Impacts windowing and competitive distribution.',
    `genre_primary` STRING COMMENT 'Primary genre classification for the content in this line item. Used for programming strategy and audience analytics.',
    `holdback_restrictions` STRING COMMENT 'Description of any holdback periods or exclusivity restrictions that limit when or how this content can be exploited. Includes blackout periods and sequential windowing constraints.',
    `language_code` STRING COMMENT 'Primary language of the content in this line item. ISO 639 two or three-letter language code.. Valid values are `^[a-z]{2,3}$`',
    `license_duration_months` STRING COMMENT 'Total duration of the license term expressed in months. Calculated from start and end dates for reporting and windowing analysis.',
    `license_fee_amount` DECIMAL(18,2) COMMENT 'The base license fee amount for this specific content line item. Represents the core acquisition cost before adjustments.',
    `license_term_end_date` DATE COMMENT 'The date when the license rights for this content line item expire. Marks the end of the rights window.',
    `license_term_start_date` DATE COMMENT 'The date when the license rights for this content line item become effective. Marks the beginning of the rights window.',
    `line_number` STRING COMMENT 'Sequential line number within the parent acquisition deal. Used for ordering and referencing specific line items within the deal.',
    `line_status` STRING COMMENT 'Current lifecycle status of this acquisition deal line item. Tracks progression from negotiation through fulfillment and expiration.. Valid values are `draft|active|fulfilled|cancelled|expired|suspended`',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guarantee payment amount for this line item. Represents the floor payment regardless of performance or usage.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this acquisition deal line record. Supports audit and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this acquisition deal line record was last modified. Audit trail for change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this acquisition deal line item. Captures special terms, exceptions, or operational instructions.',
    `payment_schedule` STRING COMMENT 'Payment structure for this line item. Defines when and how license fees and guarantees are paid to the content provider.. Valid values are `upfront|on_delivery|installment|revenue_share|hybrid`',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice or delivery milestone until payment is due for this line item. Standard commercial payment terms.',
    `production_year` STRING COMMENT 'Year the content was originally produced or released. Used for catalog management and rights valuation.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate for revenue-sharing or usage-based royalty payments on this content line item. Applied to calculate residuals beyond minimum guarantee.',
    `runs_allowed` STRING COMMENT 'Maximum number of broadcast or exhibition runs permitted for this content line item during the license term. Null indicates unlimited runs.',
    `runtime_minutes` STRING COMMENT 'Total runtime duration in minutes for the content in this line item. Used for scheduling and inventory management.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639 language codes for subtitles or closed captions included with this content line item. Supports accessibility and localization requirements.',
    `territory_code` STRING COMMENT 'Geographic territory or market where rights are granted for this content line item. May be country code, region code, or multi-territory identifier. [ENUM-REF-CANDIDATE: promote to reference product for complex territory hierarchies]',
    CONSTRAINT pk_acquisition_deal_line PRIMARY KEY(`acquisition_deal_line_id`)
) COMMENT 'Individual line items within a content acquisition deal, each representing a specific title, episode, season, or content package with its own financial terms, window schedule, territory rights, and delivery obligations. Enables granular tracking of per-title economics within a multi-title deal and feeds rights windowing and royalty calculation processes.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` (
    `distribution_agreement_id` BIGINT COMMENT 'Unique identifier for the distribution agreement. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Distribution agreements with MVPDs/cable operators require billing accounts to invoice monthly carriage fees, track retransmission consent payments, and manage receivables. Essential for carriage fee ',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Distribution agreements for linear broadcast channels reference specific licensed facilities. Retransmission consent agreements, carriage deals, and network distribution contracts all specify call sig',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Distribution agreements specify which channels carry content (e.g., cable carriage agreements, affiliate distribution). Fundamental to carriage fee calculation, must-carry compliance, channel position',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Distribution agreements in the streaming era are platform-specific, governing rights for a particular OTT platform. Business affairs and platform operations teams must link distribution_agreements to ',
    `partner_id` BIGINT COMMENT 'Reference to the distribution partner (MVPD, vMVPD, cable operator, satellite provider, OTT aggregator) that is party to this agreement.',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the distribution agreement, used in contracts and communications with distribution partners.. Valid values are `^DA-[0-9]{6,10}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the distribution agreement indicating its operational state. [ENUM-REF-CANDIDATE: draft|negotiation|active|suspended|terminated|expired|renewal_pending — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the distribution agreement based on the nature of the relationship and regulatory framework (e.g., carriage, retransmission consent, must-carry, syndication, OTT distribution, affiliate).. Valid values are `carriage|retransmission_consent|must_carry|syndication|ott_distribution|affiliate`',
    `approval_date` DATE COMMENT 'Date when the distribution agreement received final internal approval before execution.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive who provided final approval for this distribution agreement.',
    `audit_rights_included` BOOLEAN COMMENT 'Indicates whether Media Broadcasting retains the right to audit the distributors subscriber counts, revenue reports, and compliance with agreement terms.',
    `blackout_restrictions` STRING COMMENT 'Description of geographic or content-based blackout restrictions that apply to this distribution agreement (e.g., sports blackouts, regional exclusions).',
    `carriage_fee_amount` DECIMAL(18,2) COMMENT 'Base carriage fee amount per the agreement structure. Interpretation depends on carriage_fee_structure (e.g., per-subscriber monthly rate, annual flat fee).',
    `carriage_fee_structure` STRING COMMENT 'Pricing model for carriage fees paid by the distributor to Media Broadcasting (per-subscriber, flat rate, tiered, revenue share, hybrid).. Valid values are `per_subscriber|flat_rate|tiered|revenue_share|hybrid`',
    `channel_positioning_tier` STRING COMMENT 'Service tier or package level where the channels must be positioned in the distributors lineup (basic, expanded basic, digital, premium, sports tier, custom).. Valid values are `basic|expanded_basic|digital|premium|sports_tier|custom`',
    `channels_included` STRING COMMENT 'List or description of Media Broadcasting channels covered by this distribution agreement (e.g., primary network, secondary channels, HD feeds, regional variants).',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed distribution agreement contract document stored in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the distribution agreement becomes legally binding and operational.',
    `expiration_date` DATE COMMENT 'Date when the distribution agreement terminates or expires. Nullable for evergreen agreements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution agreement record was last updated in the system.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount from the distributor over the agreement term, regardless of actual subscriber counts or usage.',
    `must_carry_obligation` BOOLEAN COMMENT 'Indicates whether this agreement includes must-carry obligations under FCC regulations requiring the distributor to carry the broadcast signal.',
    `negotiated_by` STRING COMMENT 'Name or identifier of the Media Broadcasting executive or team responsible for negotiating this distribution agreement.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which the distributor must remit carriage fees to Media Broadcasting.',
    `renewal_terms` STRING COMMENT 'Description of renewal terms including automatic renewal provisions, notice periods, and renegotiation triggers.',
    `reporting_frequency` STRING COMMENT 'Frequency at which the distributor must provide subscriber counts, viewership data, and revenue reports to Media Broadcasting.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `retransmission_consent_granted` BOOLEAN COMMENT 'Indicates whether Media Broadcasting has granted retransmission consent allowing the distributor to rebroadcast the signal.',
    `sla_response_time_hours` STRING COMMENT 'Maximum response time in hours for addressing service disruptions or technical issues under the SLA.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Minimum uptime percentage guaranteed under the Service Level Agreement (SLA) for signal delivery and availability.',
    `streaming_rights_included` BOOLEAN COMMENT 'Indicates whether the agreement includes rights for the distributor to offer live streaming or simulcast of Media Broadcasting channels via OTT platforms.',
    `svod_rights_included` BOOLEAN COMMENT 'Indicates whether the agreement includes rights for the distributor to offer Subscription Video On Demand (SVOD) access as part of a subscription package.',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated, if applicable. Nullable for active agreements.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement prior to expiration.',
    `termination_reason` STRING COMMENT 'Reason for early termination of the agreement, if applicable (e.g., breach of contract, mutual agreement, business closure).',
    `territory` STRING COMMENT 'Geographic territory or market covered by this distribution agreement. May include country codes, DMA codes, or regional descriptors.',
    `tvod_rights_included` BOOLEAN COMMENT 'Indicates whether the agreement includes rights for the distributor to offer Transactional Video On Demand (TVOD) access where viewers pay per transaction.',
    `vod_rights_included` BOOLEAN COMMENT 'Indicates whether the agreement includes rights for the distributor to offer Video On Demand (VOD) access to Media Broadcasting content.',
    `vod_window_days` STRING COMMENT 'Number of days that content remains available in the distributors VOD library after initial broadcast, if VOD rights are included.',
    CONSTRAINT pk_distribution_agreement PRIMARY KEY(`distribution_agreement_id`)
) COMMENT 'Formal distribution agreements with MVPDs, vMVPDs, cable operators, satellite providers, and OTT aggregators governing carriage of Media Broadcasting channels and content. Tracks carriage fee structures, must-carry obligations, retransmission consent terms, blackout restrictions, channel positioning commitments, and SLA obligations. Distinct from content acquisition deals — this governs outbound distribution rather than inbound content.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` (
    `syndication_agreement_id` BIGINT COMMENT 'Unique identifier for the syndication agreement. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Syndication agreements for selling content distribution rights originate from sales opportunities when the sales team identifies potential syndication partners. Links the sales pipeline to executed sy',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Syndication agreements for broadcast distribution require the syndicating station to hold valid FCC licenses covering the agreed territories. Clearance obligations and territorial exclusivity are defi',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Syndication deals specify broadcast channels for content airing (e.g., off-network syndication to local stations). Essential for syndication scheduling, clearance tracking, run limit enforcement, and ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Syndication agreements grant rights to specific markets/DMAs. Essential for syndication clearance tracking and ensuring syndication partners broadcast only in contracted markets.',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Syndication deals frequently cover specific seasons (e.g., Seasons 1–3 only). Season-level syndication tracking drives per-season royalty calculations, run-limit enforcement, and holdback window man',
    `partner_id` BIGINT COMMENT 'Reference to the third-party broadcaster, regional station, or international network acquiring syndication rights.',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Syndication deals may require talent consent/clearance for promotional use and residual payment routing, especially for above-the-line talent with approval rights. Essential for talent clearance workf',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the syndication agreement, used in contracts and communications with syndication partners.. Valid values are `^SYN-[A-Z0-9]{8,12}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the syndication agreement. [ENUM-REF-CANDIDATE: draft|negotiation|pending_approval|active|suspended|terminated|expired — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the syndication agreement based on geographic scope and compensation structure.. Valid values are `domestic_syndication|international_syndication|regional_syndication|barter_syndication|cash_syndication|cash_plus_barter`',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether Media Broadcasting retains the right to audit the syndication partners broadcast logs and financial records.',
    `barter_spot_count` STRING COMMENT 'Number of advertising spots retained by Media Broadcasting per episode in barter syndication arrangements.',
    `broadcast_standard` STRING COMMENT 'Technical broadcast standard required for content delivery in the syndication territory.. Valid values are `ATSC|DVB|ISDB|DTMB`',
    `clearance_obligation` STRING COMMENT 'Party responsible for obtaining broadcast clearances and rights verification in the syndication territory.. Valid values are `broadcaster|syndicator|shared`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this syndication agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement.. Valid values are `^[A-Z]{3}$`',
    `delivery_format` STRING COMMENT 'Technical format and specifications for content delivery to the syndication partner (e.g., HD 1080p, 4K, file-based, tape).',
    `effective_end_date` DATE COMMENT 'Date when the syndication agreement expires and content rights revert. Nullable for open-ended agreements subject to termination clauses.',
    `effective_start_date` DATE COMMENT 'Date when the syndication agreement becomes binding and content rights become available for syndication.',
    `episode_count` STRING COMMENT 'Total number of episodes included in the syndication agreement. Applicable for series content.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the syndication partner has exclusive broadcast rights in the granted territory during the agreement period.',
    `exclusivity_window_end_date` DATE COMMENT 'End date of the exclusivity period. Nullable if exclusivity_flag is false.',
    `exclusivity_window_start_date` DATE COMMENT 'Start date of the exclusivity period during which no other syndication partner may broadcast the content in the granted territory. Nullable if exclusivity_flag is false.',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'Total flat fee amount for the entire syndication agreement. Applicable when syndication_fee_structure is flat_fee or hybrid.',
    `holdback_period_days` STRING COMMENT 'Number of days after original broadcast during which content cannot be syndicated, protecting the original broadcast window.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this syndication agreement record was last updated.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount regardless of actual revenue or performance. Applicable in revenue-share agreements.',
    `notes` STRING COMMENT 'Free-form notes capturing special terms, amendments, or contextual information about the syndication agreement.',
    `payment_terms` STRING COMMENT 'Detailed payment schedule and terms, including milestones, installments, and due dates.',
    `per_episode_fee_amount` DECIMAL(18,2) COMMENT 'Fee amount charged per episode. Applicable when syndication_fee_structure is per_episode or hybrid.',
    `performance_guarantee` STRING COMMENT 'Minimum performance commitments required from the syndication partner, such as minimum broadcast frequency or audience reach targets.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that the syndication partner must provide notice to exercise renewal option.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the syndication partner has an option to renew the agreement upon expiration.',
    `reporting_frequency` STRING COMMENT 'Frequency at which the syndication partner must provide broadcast logs, audience metrics, and revenue reports.. Valid values are `weekly|monthly|quarterly|annually`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of advertising or subscription revenue shared with Media Broadcasting. Applicable when syndication_fee_structure is revenue_share or hybrid.',
    `run_limit` STRING COMMENT 'Maximum number of times each episode may be broadcast by the syndication partner during the agreement term.',
    `signed_date` DATE COMMENT 'Date when the syndication agreement was executed by all parties.',
    `syndication_fee_structure` STRING COMMENT 'Compensation model governing how the syndication partner pays for content rights.. Valid values are `flat_fee|per_episode|revenue_share|barter|hybrid`',
    `termination_clause` STRING COMMENT 'Conditions and procedures under which either party may terminate the agreement prior to the effective end date.',
    `territory_grant` STRING COMMENT 'Geographic territories where the syndication partner is granted broadcast rights. Pipe-separated list of ISO 3166-1 alpha-3 country codes or regional designations. [ENUM-REF-CANDIDATE: USA|CAN|GBR|AUS|DEU|FRA|JPN|BRA|MEX|IND|CHN — promote to reference product]',
    CONSTRAINT pk_syndication_agreement PRIMARY KEY(`syndication_agreement_id`)
) COMMENT 'Agreements governing the syndication of Media Broadcasting content to third-party broadcasters, regional stations, and international networks. Captures syndication fee structure, exclusivity windows, holdback periods, territory grants, episode count, run limitations, and clearance obligations. Feeds the scheduling and rights domains for cleared content availability.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` (
    `coproduction_agreement_id` BIGINT COMMENT 'Unique identifier for the co-production agreement record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Co-production partners need billing accounts to track investment contributions, cost-sharing invoices, and revenue distribution settlements. Critical for partner investment invoicing and profit-sharin',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Co-production agreements allocate responsibility for obtaining content ratings in different territories (MPAA for US theatrical, TV Parental Guidelines for US broadcast, BBFC for UK, etc.). Partners m',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Co-production agreements frequently specify lead talent (star, showrunner, director) as part of the deal structure—attached talent drives financing approval and production greenlight decisions. Critic',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Co-productions targeting children must allocate COPPA compliance responsibilities between production partners, especially for digital/interactive components, companion apps, and online games. Agreemen',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Co-production agreements directly reference the production project being co-financed and co-produced. Linking enables tracking budget contributions, IP ownership splits, delivery obligations, and fina',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Coproduction agreements must comply with content regulations, labor laws, cross-border production rules, and local content quotas. Compliance teams track regulatory obligations per coproduction to ens',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: Co-production agreements define distribution window strategies for co-produced content (e.g., theatrical first, then SVOD). Business affairs teams must link coproduction_agreements to release_windows ',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the co-production agreement, used in contracts and communications.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the co-production agreement. [ENUM-REF-CANDIDATE: draft|negotiation|active|suspended|completed|terminated|expired — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the co-production agreement based on the number and nature of participating parties.. Valid values are `bilateral|multilateral|international|domestic|studio_partnership|network_partnership`',
    `amendment_count` STRING COMMENT 'Number of formal amendments made to the original co-production agreement.',
    `approval_authority` STRING COMMENT 'Designation of which partner or committee has final approval authority over key creative and business decisions.',
    `audit_rights` STRING COMMENT 'Provisions allowing partners to audit financial records and production accounts related to the co-production.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO currency code for the total budget amount.. Valid values are `^[A-Z]{3}$`',
    `confidentiality_terms` STRING COMMENT 'Non-disclosure obligations and confidentiality requirements binding all co-production partners.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this co-production agreement record was first created in the system.',
    `creative_control_level` STRING COMMENT 'Degree of creative decision-making authority held by our organization in the production process.. Valid values are `full|majority|shared|minority|consultative`',
    `credit_obligation` STRING COMMENT 'Contractual requirements for on-screen and promotional credits for each co-production partner.',
    `delivery_date` DATE COMMENT 'Contractual date by which the completed content must be delivered to all co-production partners.',
    `dispute_resolution_method` STRING COMMENT 'Agreed-upon mechanism for resolving disputes between co-production partners.. Valid values are `arbitration|mediation|litigation|negotiation`',
    `distribution_rights_allocation` STRING COMMENT 'Description of how distribution rights are divided among co-production partners by territory and platform.',
    `effective_date` DATE COMMENT 'Date when the co-production agreement becomes legally binding and operational.',
    `expiration_date` DATE COMMENT 'Date when the co-production agreement terminates or expires. Nullable for open-ended agreements.',
    `force_majeure_provision` STRING COMMENT 'Contractual terms addressing obligations and liabilities in the event of unforeseeable circumstances preventing performance.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of the co-production agreement.',
    `insurance_requirements` STRING COMMENT 'Mandatory insurance coverage types and amounts required for the co-production.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the co-production agreement.',
    `notes` STRING COMMENT 'Additional comments, special provisions, or contextual information about the co-production agreement.',
    `our_investment_amount` DECIMAL(18,2) COMMENT 'Financial contribution amount committed by our organization to the co-production.',
    `our_investment_percentage` DECIMAL(18,2) COMMENT 'Percentage of total production budget contributed by our organization.',
    `our_ip_ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of intellectual property rights owned by our organization in the co-produced content.',
    `our_primary_territory` STRING COMMENT 'Geographic territory or territories where our organization holds primary distribution rights.',
    `production_end_date` DATE COMMENT 'Scheduled or actual date when principal photography or production activities are completed.',
    `production_start_date` DATE COMMENT 'Scheduled or actual date when principal photography or production activities commence.',
    `production_type` STRING COMMENT 'Category of content being co-produced (film, television series, documentary, etc.).. Valid values are `film|series|documentary|special|miniseries|pilot`',
    `residuals_sharing_formula` STRING COMMENT 'Formula or methodology for distributing residual payments to talent among co-production partners.',
    `revenue_sharing_model` STRING COMMENT 'Methodology for distributing revenues generated from the co-produced content among partners.. Valid values are `proportional|waterfall|hybrid|fixed_split|recoupment_based`',
    `signed_date` DATE COMMENT 'Date when all parties executed the co-production agreement.',
    `termination_clause` STRING COMMENT 'Conditions and procedures under which the co-production agreement may be terminated by any party.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total production budget for the co-produced content across all partners.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this co-production agreement record was last modified in the system.',
    CONSTRAINT pk_coproduction_agreement PRIMARY KEY(`coproduction_agreement_id`)
) COMMENT 'Co-production arrangements with studios, production houses, and international broadcasters for jointly financed and produced content. Tracks co-production budget splits, creative control provisions, IP ownership percentages, territorial distribution rights allocation, credit obligations, and residuals sharing. Bridges the partner, production, and rights domains.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` (
    `affiliate_agreement_id` BIGINT COMMENT 'Unique identifier for the affiliate agreement record. Primary key.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: affiliate_agreement.affiliate_station_id represents the affiliate station partner. Renaming to affiliate_station_partner_id for clarity (ends with partner_partner_partner_id pattern). Links to partner',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Network-affiliate relationships require billing accounts for monthly affiliation fee invoicing, network compensation payments, and retransmission revenue share settlements. Core business process for a',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Network-affiliate agreements are fundamentally tied to the affiliate stations FCC broadcast license. The agreement references the stations call sign, facility ID, licensed market (DMA), and coverage',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: Affiliate agreements specify the delivery channel through which the network feeds programming to affiliate stations. Technical operations and affiliate relations teams must link each affiliate_agreeme',
    `channel_id` BIGINT COMMENT 'Reference to the local broadcast station or regional affiliate partner that is party to this agreement.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Affiliate agreements are market-specific; each affiliate station serves a specific DMA. Essential for network-affiliate relationship management and ensuring proper market coverage. Removes denormalize',
    `affiliation_fee_amount` DECIMAL(18,2) COMMENT 'Monthly or annual fee paid by the network to the affiliate station for carrying network programming, or reverse compensation paid by affiliate to network. Negative values indicate reverse compensation.',
    `affiliation_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the affiliation fee amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `affiliation_fee_frequency` STRING COMMENT 'Frequency at which affiliation fees are calculated and paid between network and affiliate.. Valid values are `monthly|quarterly|annual|per_broadcast_hour`',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the affiliate agreement, used in contracts, invoicing, and legal correspondence.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the affiliate agreement indicating its operational state and enforceability. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|renewed — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the affiliate relationship: primary affiliation (main channel), secondary affiliation, multicast channel, digital subchannel, network-owned station, or independent affiliate.. Valid values are `primary|secondary|multi_cast|digital_subchannel|network_owned|independent`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at expiration unless either party provides notice of non-renewal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this affiliate agreement record was first created in the system.',
    `digital_rights_included_flag` BOOLEAN COMMENT 'Indicates whether the affiliate agreement includes rights to distribute network content via digital platforms, streaming services, and Over-The-Top (OTT) channels.',
    `dispute_resolution_method` STRING COMMENT 'Contractually agreed method for resolving disputes between network and affiliate: litigation, binding arbitration, mediation, or good-faith negotiation.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `effective_date` DATE COMMENT 'Date on which the affiliate agreement becomes legally binding and operational obligations commence.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the affiliate has exclusive rights to broadcast network programming within its designated territory, preventing the network from contracting with competing stations in the same market.',
    `exclusivity_territory` STRING COMMENT 'Geographic territory within which the affiliate has exclusive rights to broadcast network programming, typically defined by DMA boundaries, county lists, or signal contours.',
    `expiration_date` DATE COMMENT 'Date on which the affiliate agreement terminates unless renewed or extended. Nullable for evergreen agreements.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law that applies to the interpretation and enforcement of the affiliate agreement (e.g., State of New York, State of California).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this affiliate agreement record was most recently updated or amended.',
    `local_ad_avails_minutes_per_hour` DECIMAL(18,2) COMMENT 'Number of minutes per hour of network programming that the affiliate may use for local advertising insertion, typically 2-4 minutes per hour.',
    `local_insertion_rights_flag` BOOLEAN COMMENT 'Indicates whether the affiliate has the right to insert local advertising spots during designated network programming breaks (ad pods).',
    `minimum_clearance_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of network programming hours that the affiliate is contractually obligated to broadcast, typically 85-95% for primary affiliates. Expressed as percentage (e.g., 90.00 for 90%).',
    `must_air_programming_hours` DECIMAL(18,2) COMMENT 'Minimum number of weekly hours of network programming that the affiliate must broadcast without preemption, including prime-time, news, and sports.',
    `network_compensation_model` STRING COMMENT 'Economic model governing compensation flow between network and affiliate: fixed fee paid to affiliate, revenue share from advertising, audience-based payments, hybrid model, or reverse compensation where affiliate pays network.. Valid values are `fixed_fee|revenue_share|audience_based|hybrid|reverse_compensation`',
    `performance_measurement_methodology` STRING COMMENT 'Audience measurement methodology used to assess affiliate performance against contractual standards (Nielsen ratings, Comscore, proprietary measurement, or multi-source approach).. Valid values are `nielsen_ratings|comscore|proprietary|multi_source`',
    `performance_standard_grp_minimum` DECIMAL(18,2) COMMENT 'Minimum Gross Rating Points (GRP) that the affiliate must deliver for network programming to meet performance standards and avoid penalties or compensation adjustments.',
    `preemption_notice_hours` STRING COMMENT 'Minimum number of hours advance notice the affiliate must provide to the network before preempting scheduled programming, typically 24-72 hours except for breaking news.',
    `preemption_rights` STRING COMMENT 'Extent to which the affiliate may preempt scheduled network programming for local content, special events, or breaking news. Preemption typically requires advance notice and makegoods.. Valid values are `none|limited|full|news_only|sports_excluded`',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that either party must provide written notice of intent to terminate or renegotiate, typically 90 to 180 days.',
    `retransmission_consent_included_flag` BOOLEAN COMMENT 'Indicates whether the affiliate agreement includes provisions for retransmission consent negotiations with Multichannel Video Programming Distributors (MVPDs) and virtual MVPDs (vMVPDs).',
    `retransmission_revenue_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of retransmission consent fees collected from MVPDs that the affiliate must share with the network. Expressed as percentage (e.g., 30.00 for 30% to network).',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of advertising revenue or other monetization that is shared between network and affiliate under revenue-sharing compensation models. Expressed as percentage (e.g., 15.00 for 15%).',
    `signed_date` DATE COMMENT 'Date on which the affiliate agreement was executed by authorized signatories from both network and affiliate parties.',
    `simulcast_requirement_flag` BOOLEAN COMMENT 'Indicates whether the affiliate is required to simulcast network programming simultaneously across multiple platforms (linear broadcast, digital streaming, mobile apps).',
    `term_length_months` STRING COMMENT 'Duration of the affiliate agreement term expressed in months, typically ranging from 12 to 60 months for broadcast affiliations.',
    `termination_for_cause_provisions` STRING COMMENT 'Description of conditions under which either party may terminate the agreement for cause, including breach of clearance obligations, payment defaults, license revocation, or material violations of broadcast standards.',
    `termination_notice_days` STRING COMMENT 'Number of days advance written notice required for voluntary termination without cause, typically 90-180 days.',
    CONSTRAINT pk_affiliate_agreement PRIMARY KEY(`affiliate_agreement_id`)
) COMMENT 'Affiliate relationship agreements with local broadcast stations, regional affiliates, and network affiliate groups. Tracks affiliation fees, network compensation, programming obligations, local insertion rights, must-air requirements, and affiliate performance standards. Distinct from MVPD distribution agreements — affiliates are broadcast station partners, not pay-TV distributors.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` (
    `delivery_obligation_id` BIGINT COMMENT 'Primary key for delivery_obligation',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to partner.acquisition_deal. Business justification: Delivery obligations arise directly from content acquisition deals — when a studio or syndicator commits to deliver content under an acquisition deal, specific delivery obligations are created. A null',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Delivery obligations for broadcast distribution must reference the specific license under which content will air. Required for FCC public inspection file compliance, technical format verification, and',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Content delivery specifications include rating certification requirements. Delivered assets must include on-screen rating cards, content descriptor overlays, and rating certification documentation. Ac',
    `content_episode_id` BIGINT COMMENT 'Foreign key linking to content.content_episode. Business justification: Episode-level delivery obligations are the most granular and operationally critical unit — each episode has its own delivery deadline, QC status, and acceptance date. This link drives episode-level de',
    `coproduction_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.coproduction_agreement. Business justification: Co-production agreements generate delivery obligations for jointly produced content — each co-production partner has specific delivery commitments (masters, localized versions, technical assets). A nu',
    `delivery_channel_id` BIGINT COMMENT 'Foreign key linking to distribution.delivery_channel. Business justification: A delivery_obligation specifies the channel through which contractual content delivery must be fulfilled. Operations and partner management teams track obligation fulfillment against specific delivery',
    `distribution_agreement_id` BIGINT COMMENT 'Reference to the parent partner agreement under which this delivery obligation exists.',
    `partner_id` BIGINT COMMENT 'Reference to the partner to whom content must be delivered or from whom content is expected.',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Content delivery obligations tie to specific broadcast schedules for fulfillment tracking (e.g., deliver episode 3 days before scheduled air date). Critical for partner SLA compliance, on-time deliver',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Delivery obligations must track compliance with technical standards (closed captioning, audio description, format specifications) mandated by regulations. Essential for SLA tracking, penalty calculati',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Syndication agreements generate delivery obligations for content to be delivered to third-party broadcasters and regional stations. A nullable FK to syndication_agreement enables direct linkage betwee',
    `acceptance_date` DATE COMMENT 'Date on which the partner formally accepted the delivered content as meeting technical and contractual specifications.',
    `actual_delivery_date` DATE COMMENT 'Date on which the content was actually delivered to the partner, null if not yet delivered.',
    `audio_description_required` BOOLEAN COMMENT 'Indicates whether audio description track must be included for visually impaired audiences.',
    `audio_track_languages` STRING COMMENT 'Comma-separated list of audio track languages that must be included in the delivery, using ISO 639 codes.',
    `closed_caption_required` BOOLEAN COMMENT 'Indicates whether closed captioning must be included in the delivered content to meet accessibility and regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery obligation record was first created in the system.',
    `delivery_deadline` DATE COMMENT 'Contractually agreed date by which the content must be delivered to the partner.',
    `delivery_location` STRING COMMENT 'Physical or network location where the content must be delivered, such as FTP server address, CDN endpoint, or facility address.',
    `delivery_method` STRING COMMENT 'Technical method or channel through which the content will be delivered to the partner.. Valid values are `physical_media|ftp|aspera|cdn|satellite|fiber`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery obligation indicating progress toward fulfillment.. Valid values are `pending|in_progress|delivered|accepted|rejected|overdue`',
    `drm_requirement` STRING COMMENT 'Digital rights management protection required for the delivered content to prevent unauthorized access and distribution.. Valid values are `none|widevine|fairplay|playready|multi_drm`',
    `eidr_identifier` STRING COMMENT 'Universal unique identifier from the Entertainment Identifier Registry for the content being delivered.',
    `episode_count` STRING COMMENT 'Number of episodes included in this delivery obligation for series or multi-episode content.',
    `file_size_gb` DECIMAL(18,2) COMMENT 'Total file size in gigabytes of the content package to be delivered.',
    `isan_identifier` STRING COMMENT 'International Standard Audiovisual Number uniquely identifying the audiovisual work being delivered.',
    `language_version` STRING COMMENT 'Primary language version of the content to be delivered, using ISO 639 language codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery obligation record was most recently updated.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this delivery obligation record.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special instructions, or issues related to this delivery obligation.',
    `obligation_number` STRING COMMENT 'Business identifier for the delivery obligation, typically referenced in contracts and communications.',
    `obligation_type` STRING COMMENT 'Classification of the delivery obligation indicating the direction and nature of content flow.. Valid values are `inbound|outbound|co_production|syndication|licensing`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty amount incurred for late delivery or non-compliance with delivery specifications, in the contract currency.',
    `priority_level` STRING COMMENT 'Business priority assigned to this delivery obligation to guide resource allocation and scheduling.. Valid values are `low|medium|high|critical`',
    `qc_completion_date` DATE COMMENT 'Date on which quality control review was completed and content was approved for delivery.',
    `quality_control_status` STRING COMMENT 'Status of quality control review process for the content before delivery to ensure technical compliance.. Valid values are `not_started|in_progress|passed|failed|waived`',
    `redelivery_required` BOOLEAN COMMENT 'Indicates whether the content must be redelivered due to rejection or technical issues with the initial delivery.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the partner for rejecting the delivered content, typically citing technical or contractual non-compliance.',
    `required_bitrate_mbps` DECIMAL(18,2) COMMENT 'Minimum or target bitrate in megabits per second required for the delivered content to meet quality standards.',
    `required_codec` STRING COMMENT 'Video and audio codec specifications required for the delivery, such as H.264, H.265, AAC, or Dolby Digital.',
    `required_format` STRING COMMENT 'Technical delivery format required by the partner, such as HLS (HTTP Live Streaming), MPEG-DASH (Dynamic Adaptive Streaming over HTTP), or mezzanine file format.',
    `required_resolution` STRING COMMENT 'Video resolution specification required for delivery, ranging from standard definition to ultra-high definition.. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `sla_compliance` BOOLEAN COMMENT 'Indicates whether the delivery was completed within the service level agreement timeframe specified in the partner contract.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of subtitle language tracks that must be included in the delivery, using ISO 639 codes.',
    `technical_standard` STRING COMMENT 'Broadcasting or streaming technical standard that the delivery must comply with, such as ATSC (Advanced Television Systems Committee) or DVB (Digital Video Broadcasting).',
    CONSTRAINT pk_delivery_obligation PRIMARY KEY(`delivery_obligation_id`)
) COMMENT 'Tracks specific content delivery obligations owed to or from partners under acquisition, syndication, and co-production agreements. Captures required delivery format (HLS, MPEG-DASH, ISAN-tagged mezzanine), delivery deadline, technical specification compliance (ATSC, DVB), delivery status, and acceptance confirmation. Bridges partner agreements with the digital asset and distribution domains.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` (
    `minimum_guarantee_id` BIGINT COMMENT 'Unique identifier for the minimum guarantee commitment within a content acquisition deal.',
    `acquisition_deal_id` BIGINT COMMENT 'Reference to the parent content acquisition deal that contains this minimum guarantee commitment.',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Minimum guarantee commitments exist not only in acquisition deals (existing FK) but also in distribution agreements — distribution_agreement has a minimum_guarantee_amount field indicating MG commitme',
    `partner_id` BIGINT COMMENT 'Reference to the studio, syndicator, or content provider receiving the minimum guarantee payment.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to production.budget. Business justification: Minimum guarantee advances from partners (acquisition/distribution deals) are capitalized assets amortized against specific production budgets. Finance teams track MG recoupment per production for ROI',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: MG recoupment tracking requires linking actual invoiced revenue (syndication fees, royalty statements) back to the guarantee for overage calculation, royalty true-ups, and partner financial reporting.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Minimum guarantee recoupment calculations require knowing which series generated the revenue being applied against the MG. Series-level MG tracking drives recoupment waterfall calculations, overage ro',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Syndication agreements include minimum guarantee commitments (syndication_agreement has minimum_guarantee_amount field). A nullable FK to syndication_agreement enables the minimum_guarantee product to',
    `accounting_treatment_code` STRING COMMENT 'The financial accounting classification for the minimum guarantee: asset (capitalized content cost), expense (immediate P&L impact), deferred expense (amortized over time), prepaid (advance payment), or liability (obligation to provider).. Valid values are `asset|expense|deferred_expense|prepaid|liability`',
    `amortization_method` STRING COMMENT 'The method used to amortize the minimum guarantee cost over its useful life: straight-line (equal periods), usage-based (viewership-driven), revenue-based (proportional to earnings), accelerated (front-loaded), or none (expensed immediately).. Valid values are `straight_line|usage_based|revenue_based|accelerated|none`',
    `contract_reference_number` STRING COMMENT 'The master contract or agreement number that governs this minimum guarantee commitment. Links to the legal contract document for audit and compliance.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `cost_center_code` STRING COMMENT 'The cost center or business unit responsible for the minimum guarantee commitment. Used for internal financial allocation and performance tracking.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this minimum guarantee record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the minimum guarantee amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date when the minimum guarantee commitment expires or the recoupment period ends. After this date, overage terms may continue but the MG obligation is closed.',
    `effective_start_date` DATE COMMENT 'The date when the minimum guarantee commitment becomes active and revenue recoupment begins. Typically aligned with content delivery or first broadcast date.',
    `final_payment_date` DATE COMMENT 'The date when the last scheduled minimum guarantee payment was made or is due. Relevant for installment or milestone-based payment structures.',
    `first_payment_date` DATE COMMENT 'The date when the initial minimum guarantee payment was made or is scheduled to be made to the content provider.',
    `fully_recouped_date` DATE COMMENT 'The date when the minimum guarantee was fully recouped and the outstanding balance reached zero. After this date, overage royalty terms apply to additional revenue.',
    `general_ledger_account_code` STRING COMMENT 'The general ledger account code in the ERP system where minimum guarantee transactions are recorded for financial reporting and reconciliation.. Valid values are `^[0-9]{4,10}$`',
    `is_cross_collateralized` BOOLEAN COMMENT 'Indicates whether this minimum guarantee can be recouped from revenue generated by other content titles or deals with the same provider (true) or is isolated to this specific deal (false).',
    `is_recoupable` BOOLEAN COMMENT 'Indicates whether the minimum guarantee can be recouped from revenue (true) or is a non-recoupable floor payment (false). Non-recoupable MGs are paid regardless of performance with no offset.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this minimum guarantee record was last updated. Tracks changes to amounts, status, or recoupment calculations.',
    `last_recoupment_calculation_date` DATE COMMENT 'The date when the most recent recoupment calculation was performed, updating the recouped to date and outstanding balance amounts.',
    `mg_amount` DECIMAL(18,2) COMMENT 'The floor payment amount owed to the content provider regardless of actual viewership or revenue performance. This is the baseline financial commitment.',
    `mg_number` STRING COMMENT 'Business identifier for the minimum guarantee commitment, used in contracts and financial reconciliation.. Valid values are `^MG-[A-Z0-9]{6,12}$`',
    `mg_status` STRING COMMENT 'Current lifecycle state of the minimum guarantee: draft (under negotiation), active (in effect), partially recouped (some revenue applied), fully recouped (MG threshold met), overage (revenue exceeds MG), expired (term ended), or terminated (contract cancelled). [ENUM-REF-CANDIDATE: draft|active|partially_recouped|fully_recouped|overage|expired|terminated — 7 candidates stripped; promote to reference product]',
    `mg_type` STRING COMMENT 'Classification of the minimum guarantee structure: flat (single fixed payment), tiered (stepped payments based on milestones), performance-based (adjusted by viewership), hybrid (combination), recoupable (can be offset by revenue share), or non-recoupable (floor payment regardless of performance).. Valid values are `flat|tiered|performance_based|hybrid|recoupable|non_recoupable`',
    `next_recoupment_calculation_date` DATE COMMENT 'The scheduled date for the next recoupment calculation cycle. Typically aligned with monthly, quarterly, or annual reporting periods.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, exceptions, or business notes related to the minimum guarantee commitment. Used for operational communication and audit trail.',
    `outstanding_balance_amount` DECIMAL(18,2) COMMENT 'Remaining minimum guarantee amount not yet recouped. Calculated as MG amount minus recouped to date amount. When zero, the MG is fully recouped.',
    `overage_amount` DECIMAL(18,2) COMMENT 'Revenue earned beyond the minimum guarantee threshold. Once the MG is fully recouped, additional revenue share payments are calculated on this overage amount per the contract terms.',
    `overage_royalty_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to overage revenue to calculate additional royalty payments owed to the content provider after the minimum guarantee is fully recouped. Typically ranges from 0.00 to 100.00 percent.',
    `payment_schedule_type` STRING COMMENT 'The timing structure for minimum guarantee payments: upfront (single payment at signing), milestone (tied to delivery/broadcast events), installment (fixed periodic payments), quarterly, annual, upon delivery (when content is delivered), or upon broadcast (when content airs). [ENUM-REF-CANDIDATE: upfront|milestone|installment|quarterly|annual|upon_delivery|upon_broadcast — 7 candidates stripped; promote to reference product]',
    `payment_terms_description` STRING COMMENT 'Detailed narrative of the payment schedule, milestones, and conditions governing the minimum guarantee disbursement. Includes specific dates, amounts, and triggering events.',
    `recouped_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative revenue amount that has been applied against the minimum guarantee as of the current reporting period. Tracks progress toward full recoupment.',
    `recoupment_basis` STRING COMMENT 'The revenue or performance metric against which the minimum guarantee is recouped: gross revenue (total), net revenue (after costs), advertising revenue (CPM/GRP-based), subscription revenue (SVOD/ARPU), combined revenue (multi-stream), or viewership metric (Nielsen ratings, reach).. Valid values are `gross_revenue|net_revenue|advertising_revenue|subscription_revenue|combined_revenue|viewership_metric`',
    `recoupment_percentage` DECIMAL(18,2) COMMENT 'The percentage of revenue (based on recoupment basis) that is applied toward recouping the minimum guarantee. Typically ranges from 0.00 to 100.00 percent.',
    `recoupment_period_months` STRING COMMENT 'The duration in months over which the minimum guarantee can be recouped from revenue. Common periods are 12, 24, 36, or 60 months depending on content type and windowing strategy.',
    `recoupment_waterfall_description` STRING COMMENT 'Detailed explanation of the revenue allocation sequence and priority order for recouping the minimum guarantee. Defines which revenue streams are applied first and how costs are deducted before recoupment.',
    CONSTRAINT pk_minimum_guarantee PRIMARY KEY(`minimum_guarantee_id`)
) COMMENT 'Minimum guarantee (MG) commitments within content acquisition deals — the floor payment owed to a content provider regardless of actual viewership or revenue performance. Tracks MG amount, recoupment schedule, earned-against-MG balance, recoupment waterfall, and overage terms. Critical for financial reconciliation and royalty management in the finance and rights domains.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` (
    `territory_grant_id` BIGINT COMMENT 'Unique identifier for the territory grant record. Primary key.',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to partner.acquisition_deal. Business justification: Territory grants define the geographic scope of rights within partner agreements. Acquisition deals are the primary source of territory grants in content acquisition — the deal negotiates which territ',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Territory grants in distribution agreements must align with licensed broadcast coverage areas. Grants reference DMA codes, coverage contours, and geographic service areas defined by FCC broadcast lice',
    `title_id` BIGINT COMMENT 'Reference to the content title for which territorial rights are granted.',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Distribution agreements with MVPDs and OTT aggregators define territorial distribution rights. Territory grants are the granular records of those geographic grants within a distribution agreement. A n',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Territory grants in partner domain represent distribution rights that must align with underlying license_agreement terms for territory scope, exclusivity, and windowing. Direct FK enables rights clear',
    `ott_platform_id` BIGINT COMMENT 'Foreign key linking to distribution.ott_platform. Business justification: Territory grants in partner agreements define where/when content can be scheduled (e.g., exclusive US broadcast rights 2024-2026). Essential for rights-compliant scheduling, avoiding territorial viola',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Territory grants license content rights to specific partners (broadcasters, streaming platforms, theatrical distributors) for defined geographic regions. Links rights grants to partner master for righ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Territory grants must comply with jurisdiction-specific broadcast regulations, retransmission consent rules, local content quotas, and advertising restrictions. Compliance teams track regulatory oblig',
    `release_window_id` BIGINT COMMENT 'Foreign key linking to distribution.release_window. Business justification: Territory grants are valid only within specific release windows (e.g., a territory grant activates during the SVOD window). Rights management requires linking territory_grant to release_window to enfo',
    `season_id` BIGINT COMMENT 'Foreign key linking to content.season. Business justification: Territory grants are frequently scoped to specific seasons (e.g., granting SVOD rights for Season 1 only in a territory). Season-level territory grants drive rights availability calculations, windowin',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Territory grants in broadcasting are primarily made at the series level (granting linear rights to a series in a territory). Series-level territory grant tracking is essential for rights clearance, bl',
    `avod_rights_flag` BOOLEAN COMMENT 'Indicates whether Advertising-Supported Video On Demand distribution rights are included in this grant.',
    `blackout_zone_indicator` BOOLEAN COMMENT 'Flag indicating whether this grant defines a blackout zone where distribution is explicitly prohibited rather than authorized.',
    `carriage_fee_applicable_flag` BOOLEAN COMMENT 'Indicates whether a carriage fee (distribution payment) is required for this territorial grant.',
    `clearance_status` STRING COMMENT 'Current rights clearance status for this territorial grant. Pending indicates awaiting verification; cleared indicates rights verified and distribution authorized; restricted indicates conditional clearance with limitations; expired indicates grant period has ended; revoked indicates rights withdrawn.. Valid values are `pending|cleared|restricted|expired|revoked`',
    `clearance_verification_date` DATE COMMENT 'Date when rights clearance was last verified for this territorial grant.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for single-country grants (e.g., USA, GBR, CAN). Null for multi-country or regional grants.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this territory grant record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory grant record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial terms associated with this grant (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `dma_code` STRING COMMENT 'Nielsen Designated Market Area code for US local market grants. Used for local broadcast and cable distribution rights.. Valid values are `^[0-9]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the territorial grant expires and distribution rights terminate. Null for perpetual grants.',
    `effective_start_date` DATE COMMENT 'Date when the territorial grant becomes effective and distribution is authorized to begin.',
    `grant_reference_code` STRING COMMENT 'Business identifier for the territory grant, used in contracts and rights clearance documentation.. Valid values are `^TG-[A-Z0-9]{6,12}$`',
    `grant_type` STRING COMMENT 'Type of territorial grant indicating exclusivity level. Exclusive grants prohibit other licensees in the territory; non-exclusive allows multiple licensees; co-exclusive allows a limited number of licensees; holdback restricts distribution during a specific window; reserved indicates rights retained by licensor.. Valid values are `exclusive|non-exclusive|co-exclusive|holdback|reserved`',
    `holdback_restriction` STRING COMMENT 'Description of any holdback period or exclusivity restrictions that limit distribution during specific windows or in relation to other platforms. For example, a 90-day theatrical holdback before SVOD release.',
    `language_restriction` STRING COMMENT 'Comma-separated list of ISO 639-2 language codes specifying which language versions are covered by this grant. Null if all language versions are included.',
    `linear_rights_flag` BOOLEAN COMMENT 'Indicates whether traditional scheduled broadcast (linear) distribution rights are included in this grant.',
    `media_format_restriction` STRING COMMENT 'Restrictions on media formats or technical specifications (e.g., HD only, 4K excluded, standard definition only). Null if no format restrictions apply.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount for this territorial grant, regardless of actual distribution revenue. Null if no minimum guarantee applies.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this territory grant record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory grant record was last modified.',
    `must_carry_obligation_flag` BOOLEAN COMMENT 'Indicates whether this grant is subject to must-carry regulations requiring mandatory channel inclusion by distributors.',
    `notes` STRING COMMENT 'Free-text notes capturing additional terms, conditions, or clarifications specific to this territorial grant.',
    `platform_scope` STRING COMMENT 'Comma-separated list of distribution platforms covered by this grant. May include: linear (traditional broadcast), SVOD (Subscription Video On Demand), AVOD (Advertising-Supported Video On Demand), TVOD (Transactional Video On Demand), OTT (Over-The-Top), theatrical, home video, FAST (Free Ad-Supported Streaming Television), MVPD (Multichannel Video Programming Distributor), vMVPD (Virtual Multichannel Video Programming Distributor).',
    `region_name` STRING COMMENT 'Named region for multi-country grants (e.g., North America, European Union, Asia-Pacific, Latin America). Used when grant covers multiple countries as a group.',
    `retransmission_consent_required_flag` BOOLEAN COMMENT 'Indicates whether retransmission consent (rebroadcast authorization) is required for this territorial grant under FCC regulations.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage royalty rate applicable to revenue generated from distribution in this territory. Used for royalty calculations in the finance domain.',
    `sublicense_permitted_flag` BOOLEAN COMMENT 'Indicates whether the licensee is authorized to sublicense the territorial rights to third parties.',
    `svod_rights_flag` BOOLEAN COMMENT 'Indicates whether Subscription Video On Demand distribution rights are included in this grant.',
    `territory_scope` STRING COMMENT 'Geographic scope of the grant. May be a country code (ISO 3166-1 alpha-3), region name, Designated Market Area (DMA) code, or custom territory definition.',
    `tvod_rights_flag` BOOLEAN COMMENT 'Indicates whether Transactional Video On Demand (pay-per-view, rental, electronic sell-through) distribution rights are included in this grant.',
    `window_type` STRING COMMENT 'Distribution window classification indicating the sequential release strategy phase. Windowing controls when content is available on different platforms to maximize revenue across release stages. [ENUM-REF-CANDIDATE: theatrical|home_video|pay_tv|free_tv|svod|avod|tvod|syndication|perpetual — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_territory_grant PRIMARY KEY(`territory_grant_id`)
) COMMENT 'Specific territorial rights grants within partner agreements — defining the geographic scope (country, region, DMA, blackout zone) for which content rights are licensed or distribution is authorized. Tracks grant type (exclusive, non-exclusive), platform scope (linear, SVOD, AVOD, TVOD), holdback restrictions, and effective window. Feeds the rights domain for clearance and blackout enforcement.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` (
    `renewal_id` BIGINT COMMENT 'Unique identifier for the partner renewal record. Primary key for tracking renewal lifecycle events across acquisition deals, distribution agreements, affiliate agreements, and syndication contracts.',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to partner.acquisition_deal. Business justification: The renewal product tracks the renewal lifecycle for expiring partner agreements including acquisition deals. A renewal record must reference the specific acquisition deal being renewed to enable dire',
    `affiliate_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.affiliate_agreement. Business justification: Affiliate agreements with local broadcast stations and regional affiliates are subject to periodic renewal. A nullable FK to affiliate_agreement enables direct linkage when agreement_type = affiliate',
    `coproduction_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.coproduction_agreement. Business justification: Co-production arrangements with studios and international broadcasters have defined terms and require renewal tracking. A nullable FK to coproduction_agreement enables direct linkage when agreement_ty',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Renewal tracks lifecycle for distribution agreements with MVPDs, cable operators, and OTT aggregators. A nullable FK to distribution_agreement enables direct linkage when agreement_type = distributio',
    `partner_id` BIGINT COMMENT 'Reference to the partner organization whose agreement is up for renewal. Links to the partner master record for studios, syndicators, content providers, MVPDs, and third-party distribution partners.',
    `series_id` BIGINT COMMENT 'Foreign key linking to content.series. Business justification: Contract renewals in broadcasting are driven by series performance. Linking renewal to series enables series-level renewal pipeline reporting, strategic importance assessment based on ratings, and ren',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Syndication agreements with third-party broadcasters and regional stations require renewal tracking. A nullable FK to syndication_agreement enables direct linkage when agreement_type = syndication_ag',
    `agreement_type` STRING COMMENT 'Classification of the partner agreement being renewed. Determines which business rules, approval workflows, and financial terms apply to the renewal process.. Valid values are `acquisition_deal|distribution_agreement|affiliate_agreement|syndication_contract|coproduction_agreement|carriage_agreement`',
    `approval_workflow_stage` STRING COMMENT 'Current stage in the multi-level approval process. Workflow stages and required approvers vary based on deal value thresholds, strategic importance, and organizational governance policies. [ENUM-REF-CANDIDATE: business_owner_review|legal_review|finance_review|executive_review|board_approval|final_approval|completed — 7 candidates stripped; promote to reference product]',
    `auto_renewal_clause_flag` BOOLEAN COMMENT 'Indicates whether the original agreement contains an automatic renewal provision. When true, agreement renews automatically unless explicit non-renewal notice is provided by the decision due date.',
    `auto_renewal_terms` STRING COMMENT 'Detailed description of automatic renewal provisions including renewal term length, rate escalation clauses, and conditions under which auto-renewal applies. Critical for preventing unintended contract extensions.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this renewal record was first created in the system. Typically corresponds to renewal trigger date when automated workflow initiates the renewal evaluation process.',
    `decision_due_date` DATE COMMENT 'Deadline by which the organization must communicate renewal decision to the partner. Failure to meet this date may trigger auto-renewal clauses or result in unintended agreement lapse.',
    `key_terms_summary` STRING COMMENT 'Executive summary of material changes and key provisions in the proposed renewal including pricing adjustments, rights modifications, performance guarantees, and strategic commitments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this renewal record. Tracks progression through workflow stages, term modifications, and status changes throughout the renewal lifecycle.',
    `non_renewal_reason` STRING COMMENT 'Detailed explanation when renewal outcome is not_renewed or terminated. Captures business rationale such as poor content performance, unfavorable terms, strategic realignment, or partner performance issues.',
    `notes` STRING COMMENT 'Free-form text field for capturing negotiation history, stakeholder feedback, special considerations, and contextual information relevant to the renewal decision and process.',
    `original_agreement_end_date` DATE COMMENT 'Expiration date of the current agreement term. Triggers renewal workflow initiation based on advance notice requirements specified in the contract.',
    `original_agreement_start_date` DATE COMMENT 'Effective start date of the current agreement term being renewed. Provides historical context for relationship duration and performance evaluation.',
    `original_deal_value_amount` DECIMAL(18,2) COMMENT 'Total financial value of the current agreement term being renewed. Provides baseline for evaluating proposed renewal terms and calculating value change percentage.',
    `outcome` STRING COMMENT 'Final disposition of the renewal process. Renewed indicates acceptance of proposed terms; renegotiated indicates material changes from original proposal; not_renewed or terminated indicates relationship conclusion.. Valid values are `renewed|not_renewed|renegotiated|extended|terminated|pending`',
    `outcome_date` DATE COMMENT 'Date when final renewal decision was communicated to the partner. Critical for audit trail, compliance verification, and preventing disputes over notice timing.',
    `partner_performance_rating` STRING COMMENT 'Overall assessment of partner performance during the current agreement term. Evaluates content quality, delivery timeliness, audience performance, rights compliance, and relationship collaboration. Key input to renewal decision.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `proposed_deal_value_amount` DECIMAL(18,2) COMMENT 'Total financial value of the proposed renewed agreement over its full term. Used for budget planning, financial forecasting, and executive approval thresholds.',
    `proposed_deal_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the proposed deal value. Essential for multi-currency contract management and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `proposed_end_date` DATE COMMENT 'Intended expiration date for the renewed agreement. Calculated from proposed start date plus proposed term length.',
    `proposed_payment_terms` STRING COMMENT 'Detailed payment schedule and terms for the renewed agreement including payment frequency, milestone-based payments, minimum guarantees, revenue share percentages, and payment methods.',
    `proposed_renewal_term_months` STRING COMMENT 'Duration in months for the proposed renewed agreement. May differ from original term based on negotiation outcomes, market conditions, or strategic relationship objectives.',
    `proposed_rights_scope` STRING COMMENT 'Description of content rights, distribution territories, platform exclusivity, windowing strategies, and sublicensing provisions proposed for the renewed agreement. Critical for rights management and content strategy alignment.',
    `proposed_start_date` DATE COMMENT 'Intended effective date for the renewed agreement. Typically aligns with original agreement end date to ensure continuity, but may include gap or overlap periods based on negotiation.',
    `renegotiation_priority` STRING COMMENT 'Business priority level for renegotiation efforts. Critical priority indicates strategic partnerships requiring executive involvement; low priority may allow standard renewal terms.. Valid values are `critical|high|medium|low`',
    `renegotiation_required_flag` BOOLEAN COMMENT 'Indicates whether material terms must be renegotiated rather than simply renewed under existing terms. Set to true when market conditions, partner performance, or strategic priorities require substantive changes.',
    `renewal_number` STRING COMMENT 'Business identifier for this renewal instance. Typically follows a pattern incorporating the original agreement number plus renewal sequence (e.g., ACQ-2023-001-R02 for second renewal).',
    `renewal_status` STRING COMMENT 'Current lifecycle state of the renewal process. Tracks progression through review, negotiation, approval workflow stages, and final outcome determination. [ENUM-REF-CANDIDATE: pending_review|under_negotiation|legal_review|finance_approval|executive_approval|approved|declined|expired|cancelled — 9 candidates stripped; promote to reference product]',
    `risk_assessment` STRING COMMENT 'Evaluation of risks associated with renewal including financial exposure, rights clearance issues, regulatory compliance concerns, partner stability, and competitive threats. Informs approval requirements and contract protections.',
    `strategic_importance` STRING COMMENT 'Assessment of the partners strategic value to the organizations content strategy, audience reach, and competitive positioning. Critical and high importance partners receive priority attention in renewal negotiations.. Valid values are `critical|high|medium|low`',
    `trigger_date` DATE COMMENT 'Date when the renewal evaluation process was initiated. Typically calculated based on original agreement end date minus advance notice period (e.g., 90 days, 180 days) specified in contract terms.',
    `value_change_percentage` DECIMAL(18,2) COMMENT 'Percentage change between original deal value and proposed renewal value. Positive values indicate cost increases; negative values indicate cost reductions. Critical metric for financial impact assessment.',
    CONSTRAINT pk_renewal PRIMARY KEY(`renewal_id`)
) COMMENT 'Tracks the renewal lifecycle for expiring partner agreements — acquisition deals, distribution agreements, affiliate agreements, and syndication contracts. Captures renewal trigger date, auto-renewal clause status, renegotiation flag, proposed new terms, approval workflow stage, and renewal outcome. Enables proactive deal management and prevents unintended agreement lapses.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` (
    `partner_id` BIGINT COMMENT 'Unique identifier for the partner_partner data product (auto-inserted pre-linking).',
    `parent_partner_id` BIGINT COMMENT 'Reference to the parent partner entity in cases where this partner is a subsidiary or division of a larger corporate entity. Enables tracking of corporate hierarchies and consolidated relationships. Null for top-level parent entities.',
    `annual_content_volume_hours` DECIMAL(18,2) COMMENT 'Estimated or actual annual volume of content hours acquired from or distributed through this partner. Used for capacity planning, content pipeline forecasting, and partner performance evaluation.',
    `annual_revenue_contribution_usd` DECIMAL(18,2) COMMENT 'Estimated or actual annual revenue contribution from this partner relationship in USD. Includes content licensing fees, distribution revenue share, advertising revenue, or other monetization streams. Used for partner valuation and ROI analysis.',
    `partner_code` STRING COMMENT 'Externally-known unique business identifier for the partner used in operational systems, contracts, and inter-company communications. Typically assigned during onboarding.. Valid values are `^[A-Z0-9]{3,12}$`',
    `content_specialization` STRING COMMENT 'Primary content genres, formats, or categories that the partner specializes in producing or distributing. Examples include scripted drama, unscripted reality, sports, news, childrens programming, documentary, or multi-genre. Supports content acquisition strategy and partner matching.',
    `contract_renewal_date` DATE COMMENT 'Next scheduled date for master agreement renewal or renegotiation with this partner. Used for relationship management planning, contract pipeline tracking, and ensuring continuity of content supply or distribution.',
    `corporate_hierarchy_level` STRING COMMENT 'Numeric level in the corporate hierarchy tree where 1 represents the ultimate parent entity and higher numbers represent deeper subsidiary levels. Used for roll-up reporting and consolidated analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner record was first created in the system. Used for audit trail, data lineage tracking, and record age analysis.',
    `credit_rating` STRING COMMENT 'External credit rating assigned by rating agencies such as Moodys, S&P, or Fitch. Used for financial risk assessment, contract negotiation, and determining payment terms or guarantees required.',
    `distribution_territories` STRING COMMENT 'Geographic territories or markets where the partner operates or holds distribution rights. Stored as comma-separated list of country codes or region identifiers. Critical for rights management and windowing strategy.',
    `domicile_country_code` STRING COMMENT 'Three-letter ISO country code representing the legal domicile jurisdiction where the partner entity is incorporated or registered. Determines applicable regulatory frameworks and tax treaties.. Valid values are `^[A-Z]{3}$`',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to identify business entities globally. Used for credit assessment, vendor management, and corporate hierarchy tracking.. Valid values are `^[0-9]{9}$`',
    `headquarters_address_line1` STRING COMMENT 'First line of the physical headquarters address including street number and street name. Used for legal correspondence, contract execution, and regulatory filings.',
    `headquarters_address_line2` STRING COMMENT 'Second line of the physical headquarters address for suite, floor, building name, or other secondary address details.',
    `headquarters_city` STRING COMMENT 'City or municipality where the partner headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code for the headquarters location. May differ from domicile_country_code if the operational headquarters is in a different jurisdiction than legal incorporation.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the headquarters address. Format varies by country postal system.',
    `headquarters_state_province` STRING COMMENT 'State, province, or primary administrative subdivision where the partner headquarters is located. Format varies by country.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the partnership includes exclusivity provisions that restrict either party from engaging with competing partners in specified territories, content categories, or distribution channels. Critical for rights management and competitive strategy.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that performed the most recent modification to this partner record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner record was most recently updated. Used for change tracking, data freshness monitoring, and audit trail.',
    `partner_name` STRING COMMENT 'The full legal name of the partner organization as registered with governing authorities. Used for contracts, invoicing, and legal documentation.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special considerations, relationship history, or operational notes about the partner that do not fit structured fields. Used by relationship managers for institutional knowledge capture.',
    `onboarding_stage` STRING COMMENT 'Current stage in the partner onboarding workflow. Tracks progression from initial prospect through due diligence, contract negotiation, legal review, approval, and final onboarding completion.. Valid values are `prospect|due_diligence|contract_negotiation|legal_review|approved|onboarded`',
    `partner_type` STRING COMMENT 'Primary classification of the partner based on their role in the media ecosystem. Studios produce original content, syndicators distribute content to multiple outlets, content providers supply licensed material, MVPDs are traditional cable/satellite distributors, vMVPDs are virtual distributors, and OTT aggregators operate streaming platforms.. Valid values are `studio|syndicator|content_provider|mvpd|vmvpd|ott_aggregator`',
    `preferred_payment_terms` STRING COMMENT 'Standard payment terms negotiated with the partner for content licensing, royalties, or service fees. Examples include Net 30, Net 60, advance against royalties, or milestone-based payments. Feeds into accounts payable and cash flow planning.',
    `primary_contact_email` STRING COMMENT 'Primary email address for the main business contact at the partner organization. Used for operational communications, contract notifications, and relationship management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the partner organization responsible for day-to-day relationship management and operational coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the main business contact at the partner organization. Includes country code and extension where applicable.',
    `relationship_end_date` DATE COMMENT 'Date when the business relationship with this partner was formally terminated or is scheduled to end. Null for active ongoing relationships. Used for historical analysis and transition planning.',
    `relationship_start_date` DATE COMMENT 'Date when the business relationship with this partner was formally established, typically corresponding to the first executed agreement or onboarding completion. Used for relationship tenure analysis and anniversary tracking.',
    `relationship_status` STRING COMMENT 'Current lifecycle state of the business relationship. Active indicates ongoing business, pending indicates onboarding in progress, suspended indicates temporary hold, inactive indicates no current agreements, and terminated indicates relationship ended.. Valid values are `active|inactive|suspended|pending|terminated`',
    `risk_tier` STRING COMMENT 'Internal risk classification based on financial stability, contract compliance history, operational reliability, and strategic importance. Used for relationship management prioritization and escalation protocols.. Valid values are `low|medium|high|critical`',
    `strategic_tier` STRING COMMENT 'Classification of the partners strategic importance to the business. Tier 1 represents critical strategic partners with significant content volume or distribution reach, Tier 2 represents important but not critical partners, Tier 3 represents transactional relationships, and emerging represents new partners under evaluation.. Valid values are `tier_1|tier_2|tier_3|emerging`',
    `subtype` STRING COMMENT 'Secondary classification providing additional granularity within the partner type. Examples include major studio vs independent studio, first-run syndicator vs off-network syndicator, FAST channel operator, co-production house, or affiliate network.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number for the partner entity. Format varies by jurisdiction (e.g., EIN in USA, VAT number in EU, GST number in other regions). Used for tax reporting and compliance.',
    CONSTRAINT pk_partner PRIMARY KEY(`partner_id`)
) COMMENT 'Master record for all external business partners including studios, syndicators, content providers, MVPDs, vMVPDs, FAST channel operators, and third-party distribution partners. Serves as the SSOT for partner identity, classification, legal entity details, and relationship status. Tracks partner type (studio, syndicator, MVPD, OTT aggregator, co-production house), corporate hierarchy, domicile jurisdiction, and onboarding lifecycle stage.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` (
    `coproduction_participation_id` BIGINT COMMENT 'Unique identifier for this co-production participation record. Primary key.',
    `coproduction_agreement_id` BIGINT COMMENT 'Foreign key linking to the co-production agreement that this participation record is associated with.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the partner organization participating in this co-production agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this participation record was first created in the system.',
    `credit_obligation` STRING COMMENT 'Specific on-screen and promotional credit requirements for this partner in the co-production. Identified in detection phase as relationship-specific data.',
    `effective_date` DATE COMMENT 'Date when this partners participation in the co-production agreement became effective.',
    `investment_percentage` DECIMAL(18,2) COMMENT 'The percentage of total co-production budget contributed by this partner. Must sum to 100% across all participants for a given agreement. Identified in detection phase as relationship-specific data.',
    `ip_ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of intellectual property ownership held by this partner in the co-produced content. Identified in detection phase as relationship-specific data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this participation record was most recently updated.',
    `notes` STRING COMMENT 'Additional comments or contextual information about this partners participation in the co-production.',
    `participation_status` STRING COMMENT 'Current status of this partners participation in the co-production agreement.',
    `partner_role` STRING COMMENT 'The specific role this partner plays in the co-production arrangement (e.g., Lead Producer, Co-Financier, Co-Distributor, Creative Partner). Identified in detection phase as relationship-specific data.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of revenue from the co-produced content allocated to this partner. Identified in detection phase as relationship-specific data.',
    `termination_date` DATE COMMENT 'Date when this partners participation in the co-production agreement ended or will end. Nullable for ongoing participations.',
    `territory_rights_allocation` STRING COMMENT 'Geographic territories or markets where this partner holds distribution rights for the co-produced content. Identified in detection phase as relationship-specific data.',
    CONSTRAINT pk_coproduction_participation PRIMARY KEY(`coproduction_participation_id`)
) COMMENT 'This association product represents the participation relationship between a co-production agreement and a partner organization. It captures the multi-party nature of co-production arrangements where multiple partners (studios, production houses, international broadcasters) jointly finance and produce content. Each record links one co-production agreement to one participating partner with financial terms (investment percentage, IP ownership percentage, revenue share), creative terms (partner role, credit obligations), and territorial rights allocation that exist only in the context of this specific partnership arrangement.. Existence Justification: In the media broadcasting industry, co-production agreements are inherently multi-party arrangements where multiple partners (studios, production houses, international broadcasters) jointly finance and produce content. Each partners participation has distinct financial terms (investment percentage, IP ownership percentage, revenue share), creative terms (role, credit obligations), and territorial rights. The current models lead_partner_id captures only the primary partner, leaving co-financing and co-distribution partners unmodeled, which fails to represent the fundamental business reality that co-productions involve multiple simultaneous partnerships.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_coproduction_agreement_id` FOREIGN KEY (`coproduction_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement`(`coproduction_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_coproduction_agreement_id` FOREIGN KEY (`coproduction_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement`(`coproduction_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ADD CONSTRAINT `fk_partner_partner_parent_partner_id` FOREIGN KEY (`parent_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ADD CONSTRAINT `fk_partner_coproduction_participation_coproduction_agreement_id` FOREIGN KEY (`coproduction_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement`(`coproduction_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ADD CONSTRAINT `fk_partner_coproduction_participation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`partner` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`partner` SET TAGS ('dbx_domain' = 'partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` SET TAGS ('dbx_subdomain' = 'content_acquisition');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Provider Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `content_delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `content_package_scope` SET TAGS ('dbx_business_glossary_term' = 'Content Package Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `contract_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `deal_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `deal_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4,8}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `deal_title` SET TAGS ('dbx_business_glossary_term' = 'Deal Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'flat_fee|revenue_share|minimum_guarantee|hybrid|barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `distribution_rights` SET TAGS ('dbx_business_glossary_term' = 'Distribution Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `license_term_months` SET TAGS ('dbx_business_glossary_term' = 'License Term in Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `marketing_materials_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Materials Included Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `metadata_requirements` SET TAGS ('dbx_business_glossary_term' = 'Metadata Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `performance_guarantees` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantees');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `sublicensing_terms` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `territory_coverage` SET TAGS ('dbx_business_glossary_term' = 'Territory Coverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `total_runtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime in Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_value_regex' = 'day_and_date|theatrical_holdback|svod_first|linear_first|staggered|simultaneous');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` SET TAGS ('dbx_subdomain' = 'content_acquisition');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `acquisition_deal_line_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Line Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `content_rating` SET TAGS ('dbx_business_glossary_term' = 'Content Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `delivery_due_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|received|ingested|rejected|delayed');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `distribution_rights` SET TAGS ('dbx_business_glossary_term' = 'Distribution Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `dubbing_languages` SET TAGS ('dbx_business_glossary_term' = 'Dubbing Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z]$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `genre_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Genre');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Holdback Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `license_duration_months` SET TAGS ('dbx_business_glossary_term' = 'License Duration in Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `license_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'License Term End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `license_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Term Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|active|fulfilled|cancelled|expired|suspended');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_value_regex' = 'upfront|on_delivery|installment|revenue_share|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_business_glossary_term' = 'Runs Allowed');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Minutes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` SET TAGS ('dbx_subdomain' = 'content_acquisition');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Ott Platform Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^DA-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'carriage|retransmission_consent|must_carry|syndication|ott_distribution|affiliate');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `audit_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Included Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_value_regex' = 'per_subscriber|flat_rate|tiered|revenue_share|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `channel_positioning_tier` SET TAGS ('dbx_business_glossary_term' = 'Channel Positioning Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `channel_positioning_tier` SET TAGS ('dbx_value_regex' = 'basic|expanded_basic|digital|premium|sports_tier|custom');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `channels_included` SET TAGS ('dbx_business_glossary_term' = 'Channels Included');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `must_carry_obligation` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `negotiated_by` SET TAGS ('dbx_business_glossary_term' = 'Negotiated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Granted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `streaming_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Streaming Rights Included Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `svod_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Subscription Video On Demand (SVOD) Rights Included Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Distribution Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `tvod_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Transactional Video On Demand (TVOD) Rights Included Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `vod_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Rights Included Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `vod_window_days` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Window Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` SET TAGS ('dbx_subdomain' = 'content_acquisition');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^SYN-[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'domestic_syndication|international_syndication|regional_syndication|barter_syndication|cash_syndication|cash_plus_barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `barter_spot_count` SET TAGS ('dbx_business_glossary_term' = 'Barter Spot Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_value_regex' = 'ATSC|DVB|ISDB|DTMB');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `clearance_obligation` SET TAGS ('dbx_business_glossary_term' = 'Clearance Obligation');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `clearance_obligation` SET TAGS ('dbx_value_regex' = 'broadcaster|syndicator|shared');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `exclusivity_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `exclusivity_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `per_episode_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Per Episode Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `per_episode_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `performance_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annually');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `run_limit` SET TAGS ('dbx_business_glossary_term' = 'Run Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `syndication_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Syndication Fee Structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `syndication_fee_structure` SET TAGS ('dbx_value_regex' = 'flat_fee|per_episode|revenue_share|barter|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `territory_grant` SET TAGS ('dbx_business_glossary_term' = 'Territory Grant');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` SET TAGS ('dbx_subdomain' = 'content_acquisition');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Production Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'bilateral|multilateral|international|domestic|studio_partnership|network_partnership');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `audit_rights` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `confidentiality_terms` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `confidentiality_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `creative_control_level` SET TAGS ('dbx_business_glossary_term' = 'Creative Control Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `creative_control_level` SET TAGS ('dbx_value_regex' = 'full|majority|shared|minority|consultative');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `credit_obligation` SET TAGS ('dbx_business_glossary_term' = 'Credit Obligation');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `distribution_rights_allocation` SET TAGS ('dbx_business_glossary_term' = 'Distribution Rights Allocation');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `distribution_rights_allocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `force_majeure_provision` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Provision');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `our_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Our Investment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `our_investment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `our_investment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Our Investment Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `our_investment_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `our_ip_ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Our Intellectual Property (IP) Ownership Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `our_ip_ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `our_primary_territory` SET TAGS ('dbx_business_glossary_term' = 'Our Primary Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `production_end_date` SET TAGS ('dbx_business_glossary_term' = 'Production End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `production_type` SET TAGS ('dbx_value_regex' = 'film|series|documentary|special|miniseries|pilot');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `residuals_sharing_formula` SET TAGS ('dbx_business_glossary_term' = 'Residuals Sharing Formula');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `residuals_sharing_formula` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Sharing Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_value_regex' = 'proportional|waterfall|hybrid|fixed_split|recoupment_based');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Station Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Station Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Fee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Fee Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_frequency` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Fee Payment Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|per_broadcast_hour');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|multi_cast|digital_subchannel|network_owned|independent');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `digital_rights_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Distribution Rights Included Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Territorial Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `exclusivity_territory` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Territory Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `local_ad_avails_minutes_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Local Advertising Availabilities Minutes Per Hour');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `local_insertion_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Local Advertising Insertion Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `minimum_clearance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Network Clearance Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `must_air_programming_hours` SET TAGS ('dbx_business_glossary_term' = 'Must-Air Programming Hours Per Week');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `network_compensation_model` SET TAGS ('dbx_business_glossary_term' = 'Network Compensation Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `network_compensation_model` SET TAGS ('dbx_value_regex' = 'fixed_fee|revenue_share|audience_based|hybrid|reverse_compensation');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `network_compensation_model` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `network_compensation_model` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `performance_measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Performance Measurement Methodology');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `performance_measurement_methodology` SET TAGS ('dbx_value_regex' = 'nielsen_ratings|comscore|proprietary|multi_source');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `performance_standard_grp_minimum` SET TAGS ('dbx_business_glossary_term' = 'Performance Standard Gross Rating Points (GRP) Minimum');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `preemption_notice_hours` SET TAGS ('dbx_business_glossary_term' = 'Preemption Notice Period in Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `preemption_rights` SET TAGS ('dbx_business_glossary_term' = 'Network Programming Preemption Rights');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `preemption_rights` SET TAGS ('dbx_value_regex' = 'none|limited|full|news_only|sports_excluded');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `retransmission_consent_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Included Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `retransmission_revenue_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Revenue Split Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `retransmission_revenue_split_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `simulcast_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Requirement Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `term_length_months` SET TAGS ('dbx_business_glossary_term' = 'Agreement Term Length in Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `termination_for_cause_provisions` SET TAGS ('dbx_business_glossary_term' = 'Termination for Cause Provisions');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` SET TAGS ('dbx_subdomain' = 'content_acquisition');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Obligation Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `content_episode_id` SET TAGS ('dbx_business_glossary_term' = 'Content Episode Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Coproduction Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `audio_description_required` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `audio_track_languages` SET TAGS ('dbx_business_glossary_term' = 'Audio Track Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `closed_caption_required` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_deadline` SET TAGS ('dbx_business_glossary_term' = 'Delivery Deadline');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'physical_media|ftp|aspera|cdn|satellite|fiber');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|delivered|accepted|rejected|overdue');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_business_glossary_term' = 'DRM (Digital Rights Management) Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_value_regex' = 'none|widevine|fairplay|playready|multi_drm');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'EIDR (Entertainment Identifier Registry) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'File Size (GB)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `isan_identifier` SET TAGS ('dbx_business_glossary_term' = 'ISAN (International Standard Audiovisual Number) Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `language_version` SET TAGS ('dbx_business_glossary_term' = 'Language Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound|co_production|syndication|licensing');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `qc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'QC (Quality Control) Completion Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `redelivery_required` SET TAGS ('dbx_business_glossary_term' = 'Redelivery Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `required_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Required Bitrate (Mbps)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `required_codec` SET TAGS ('dbx_business_glossary_term' = 'Required Codec');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `required_format` SET TAGS ('dbx_business_glossary_term' = 'Required Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `required_resolution` SET TAGS ('dbx_business_glossary_term' = 'Required Resolution');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `required_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `sla_compliance` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `technical_standard` SET TAGS ('dbx_business_glossary_term' = 'Technical Standard');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` SET TAGS ('dbx_subdomain' = 'content_acquisition');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `minimum_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Provider ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Production Budget Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `accounting_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Accounting Treatment Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `accounting_treatment_code` SET TAGS ('dbx_value_regex' = 'asset|expense|deferred_expense|prepaid|liability');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `accounting_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `accounting_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Amortization Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `amortization_method` SET TAGS ('dbx_value_regex' = 'straight_line|usage_based|revenue_based|accelerated|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `final_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `first_payment_date` SET TAGS ('dbx_business_glossary_term' = 'First Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `fully_recouped_date` SET TAGS ('dbx_business_glossary_term' = 'Fully Recouped Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `is_cross_collateralized` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Collateralized Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `is_recoupable` SET TAGS ('dbx_business_glossary_term' = 'Is Recoupable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `last_recoupment_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recoupment Calculation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_number` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_number` SET TAGS ('dbx_value_regex' = '^MG-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_status` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_type` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_type` SET TAGS ('dbx_value_regex' = 'flat|tiered|performance_based|hybrid|recoupable|non_recoupable');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `next_recoupment_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recoupment Calculation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `overage_amount` SET TAGS ('dbx_business_glossary_term' = 'Overage Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `overage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `overage_royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Overage Royalty Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `overage_royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `payment_terms_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `recouped_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Recouped to Date Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `recouped_to_date_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `recoupment_basis` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `recoupment_basis` SET TAGS ('dbx_value_regex' = 'gross_revenue|net_revenue|advertising_revenue|subscription_revenue|combined_revenue|viewership_metric');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `recoupment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `recoupment_period_months` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Period Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `recoupment_waterfall_description` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Waterfall Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` SET TAGS ('dbx_subdomain' = 'content_acquisition');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `territory_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Grant ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `ott_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `release_window_id` SET TAGS ('dbx_business_glossary_term' = 'Release Window Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `avod_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Advertising-Supported Video On Demand (AVOD) Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `blackout_zone_indicator` SET TAGS ('dbx_business_glossary_term' = 'Blackout Zone Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `carriage_fee_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Applicable Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|restricted|expired|revoked');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `clearance_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `dma_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `grant_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Reference Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `grant_reference_code` SET TAGS ('dbx_value_regex' = '^TG-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_business_glossary_term' = 'Grant Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_value_regex' = 'exclusive|non-exclusive|co-exclusive|holdback|reserved');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `holdback_restriction` SET TAGS ('dbx_business_glossary_term' = 'Holdback Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `language_restriction` SET TAGS ('dbx_business_glossary_term' = 'Language Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `linear_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Linear Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `media_format_restriction` SET TAGS ('dbx_business_glossary_term' = 'Media Format Restriction');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `must_carry_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Obligation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grant Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Region Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `retransmission_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Permitted Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `svod_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Subscription Video On Demand (SVOD) Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `tvod_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Transactional Video On Demand (TVOD) Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Renewal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Coproduction Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `series_id` SET TAGS ('dbx_business_glossary_term' = 'Series Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'acquisition_deal|distribution_agreement|affiliate_agreement|syndication_contract|coproduction_agreement|carriage_agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `approval_workflow_stage` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Stage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `auto_renewal_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `auto_renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `decision_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Decision Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `key_terms_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Terms Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `key_terms_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `non_renewal_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Renewal Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `original_agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Agreement End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `original_agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Original Agreement Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `original_deal_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Deal Value Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `original_deal_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Renewal Outcome');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'renewed|not_renewed|renegotiated|extended|terminated|pending');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Outcome Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `partner_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Partner Performance Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `partner_performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `proposed_deal_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Proposed Deal Value Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `proposed_deal_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `proposed_deal_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Proposed Deal Value Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `proposed_deal_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `proposed_end_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Renewal End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `proposed_payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Proposed Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `proposed_payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `proposed_renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Proposed Renewal Term Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `proposed_rights_scope` SET TAGS ('dbx_business_glossary_term' = 'Proposed Rights Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `proposed_rights_scope` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `proposed_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Renewal Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `renegotiation_priority` SET TAGS ('dbx_business_glossary_term' = 'Renegotiation Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `renegotiation_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `renegotiation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renegotiation Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `renewal_number` SET TAGS ('dbx_business_glossary_term' = 'Renewal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Trigger Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `value_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Value Change Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for partner_partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `parent_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `annual_content_volume_hours` SET TAGS ('dbx_business_glossary_term' = 'Annual Content Volume in Hours');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `annual_content_volume_hours` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `annual_revenue_contribution_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Contribution in United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `annual_revenue_contribution_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Business Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `content_specialization` SET TAGS ('dbx_business_glossary_term' = 'Content Specialization');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `contract_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `corporate_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Corporate Hierarchy Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `distribution_territories` SET TAGS ('dbx_business_glossary_term' = 'Distribution Territories');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `domicile_country_code` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `domicile_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Relationship Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Legal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partner Relationship Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_business_glossary_term' = 'Partner Onboarding Stage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_value_regex' = 'prospect|due_diligence|contract_negotiation|legal_review|approved|onboarded');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'studio|syndicator|content_provider|mvpd|vmvpd|ott_aggregator');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `preferred_payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Relationship Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Partner Risk Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `risk_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Partner Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|emerging');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Partner Subtype Classification');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` SET TAGS ('dbx_association_edges' = 'partner.coproduction_agreement,partner.partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `coproduction_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Production Participation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Coproduction Participation - Coproduction Agreement Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Coproduction Participation - Partner Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `credit_obligation` SET TAGS ('dbx_business_glossary_term' = 'Credit Obligation');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `investment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Investment Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `investment_percentage` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `ip_ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'IP Ownership Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `ip_ownership_percentage` SET TAGS ('dbx_legal' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Participation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `partner_role` SET TAGS ('dbx_business_glossary_term' = 'Partner Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_participation` ALTER COLUMN `territory_rights_allocation` SET TAGS ('dbx_business_glossary_term' = 'Territory Rights Allocation');
