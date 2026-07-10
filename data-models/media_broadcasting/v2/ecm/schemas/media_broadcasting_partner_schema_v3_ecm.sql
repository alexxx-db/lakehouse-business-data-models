-- Schema for Domain: partner | Business:  | Version: v3_ecm
-- Generated on: 2026-07-10 19:30:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_media_broadcasting_v1`.`partner` COMMENT 'Manages relationships, contracts, and negotiations with studios, syndicators, content providers, MVPDs, and third-party distribution partners. Tracks partner agreements, content acquisition deals, co-production arrangements, and affiliate relationships that feed into rights, distribution, and finance domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` (
    `partner_contact_id` BIGINT COMMENT 'Unique identifier for the partner contact record. Primary key.',
    `compliance_consent_record_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_record. Business justification: Partner contacts (especially EU/UK/California partners) require GDPR/CCPA consent records for marketing communications, data processing agreements, and third-party data sharing. B2B consent tracking e',
    `employee_id` BIGINT COMMENT 'Reference to the internal Media Broadcasting employee who owns and manages the relationship with this partner contact. Typically a business development manager or account executive.',
    `partner_id` BIGINT COMMENT 'Reference to the partner organization this contact is associated with. Links to the partner master record.',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: In media broadcasting, partner contacts are sometimes talent themselves (producer-directors, showrunners with production companies, talent-owned studios). Essential for dual-role tracking, conflict of',
    `assistant_email` STRING COMMENT 'The email address of the contacts executive assistant, used for meeting coordination and scheduling.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assistant_name` STRING COMMENT 'The name of the contacts executive assistant or administrative support person, if applicable. Used for scheduling and coordination.',
    `assistant_phone` STRING COMMENT 'The phone number of the contacts executive assistant, used for urgent scheduling needs and coordination.',
    `communication_language` STRING COMMENT 'The preferred language for business communications with this contact, specified using ISO 639-1 two-letter language codes (e.g., EN, ES, FR).',
    `contact_status` STRING COMMENT 'Current lifecycle status of the partner contact. Indicates whether the contact is actively engaged, temporarily unavailable, or no longer with the partner organization.. Valid values are `active|inactive|on_leave|terminated`',
    `contract_signatory` BOOLEAN COMMENT 'Boolean flag indicating whether this contact has legal authority to sign contracts and binding agreements on behalf of the partner organization.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this partner contact record was first created in the system. Used for audit trail and data lineage.',
    `decision_making_authority` STRING COMMENT 'The level of decision-making authority the contact has within their organization for partnership matters, contract negotiations, and business agreements.. Valid values are `full|limited|advisory|none`',
    `department` STRING COMMENT 'The department or division within the partner organization where the contact works (e.g., Legal, Finance, Content Operations, Business Development).',
    `email_address` STRING COMMENT 'Primary email address for the partner contact. Used for official communications, contract negotiations, and business correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `end_date` DATE COMMENT 'The date when this individual ceased to be an active contact, either due to role change, departure from the partner organization, or relationship termination.',
    `first_name` STRING COMMENT 'The first name or given name of the partner contact individual.',
    `full_name` STRING COMMENT 'The complete formatted name of the partner contact, typically combining first, middle, and last names.',
    `is_primary_contact` BOOLEAN COMMENT 'Boolean flag indicating whether this contact is the primary or main point of contact for the partner organization.',
    `job_title` STRING COMMENT 'The official job title or position of the contact within the partner organization (e.g., Vice President of Content Acquisition, Director of Business Development, Legal Counsel).',
    `last_contact_date` DATE COMMENT 'The date of the most recent business interaction or communication with this partner contact. Used for relationship health tracking.',
    `last_name` STRING COMMENT 'The last name or family name of the partner contact individual.',
    `linkedin_profile_url` STRING COMMENT 'The URL to the contacts professional LinkedIn profile, used for professional networking and background verification.',
    `mobile_number` STRING COMMENT 'Mobile or cell phone number for the partner contact, used for urgent communications and on-the-go accessibility.',
    `nda_signed_date` DATE COMMENT 'The date when the contact signed a non-disclosure agreement with Media Broadcasting, if applicable. Used to track confidentiality obligations.',
    `next_scheduled_contact_date` DATE COMMENT 'The planned date for the next scheduled interaction or follow-up with this partner contact. Supports proactive relationship management.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional information, preferences, interaction history, or special considerations related to the partner contact.',
    `office_location` STRING COMMENT 'The physical office location or city where the contact is based within the partner organization.',
    `phone_number` STRING COMMENT 'Primary business phone number for the partner contact, including country code and extension if applicable.',
    `preferred_communication_method` STRING COMMENT 'The contacts preferred method of communication for business interactions and negotiations.. Valid values are `email|phone|mobile|video_conference|in_person`',
    `role_type` STRING COMMENT 'The functional role category of the contact within the partnership context. Defines the primary area of responsibility and engagement. [ENUM-REF-CANDIDATE: executive|legal|business_development|technical|finance|operations|marketing — 7 candidates stripped; promote to reference product]',
    `start_date` DATE COMMENT 'The date when this individual became a contact for the partner organization or when the relationship with Media Broadcasting began.',
    `time_zone` STRING COMMENT 'The time zone where the contact is primarily located, using IANA time zone database format (e.g., America/New_York, Europe/London). Used for scheduling meetings and calls.',
    `updated_by` STRING COMMENT 'The user identifier or name of the person who last modified this partner contact record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this partner contact record was last modified. Used for audit trail and change tracking.',
    `created_by` STRING COMMENT 'The user identifier or name of the person who created this partner contact record in the system.',
    CONSTRAINT pk_partner_contact PRIMARY KEY(`partner_contact_id`)
) COMMENT 'Individual contacts associated with a partner organization — executives, legal representatives, business development leads, technical liaisons, and finance contacts. Tracks name, title, role type, communication preferences, and relationship owner within Media Broadcasting. Supports negotiation workflows and partner relationship management.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` (
    `acquisition_deal_id` BIGINT COMMENT 'Unique identifier for the content acquisition deal. Primary key for the acquisition deal entity.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Acquisition deals for broadcast distribution must verify licensed coverage matches contracted territories. Compliance officers cross-reference deal territories against FCC-licensed footprints to ensur',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Acquisition deals often specify target broadcast channels for content placement (e.g., primetime slot on flagship channel). Critical for content scheduling coordination, deal fulfillment tracking, and',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Acquisition deals specify required content ratings (TV-MA, TV-14, PG, etc.) as contractual obligations. Buyers require sellers to deliver content with appropriate ratings for licensed territories and ',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Acquisition deals for childrens content (directed to kids under 13) require COPPA compliance declarations covering data collection on associated websites, apps, and interactive platforms. Contracts s',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Content acquisition costs are allocated to cost centers for budget management, variance analysis, and content spend tracking. Essential for production vs. acquisition cost analysis and departmental bu',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Acquisition deals are evaluated and priced based on target demographic appeal of the content being acquired. Essential for content acquisition ROI analysis and portfolio strategy.',
    `employee_id` BIGINT COMMENT 'Reference to the internal business development or acquisitions executive responsible for negotiating and managing this deal.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the broadcasters legal entity that is the contracting party for this acquisition deal, relevant for multi-entity corporate structures.',
    `partner_id` BIGINT COMMENT 'Reference to the studio, syndicator, or independent content provider from whom content is being acquired. Links to partner master data.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Acquisition deals impact specific profit center EBITDA through content amortization and revenue generation. Critical for segment P&L reporting, content ROI analysis, and business unit performance meas',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Acquisition deals for content rights often originate from identified sales opportunities when proactively pursuing content for the portfolio. Tracks deal pipeline from opportunity identification throu',
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
    `title_id` BIGINT COMMENT 'Reference to the specific content title, episode, season, or package being acquired in this line item.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Deal lines license specific assets, not just titles. MAM systems must link assets to deal lines for automated rights validation, windowing enforcement, royalty calculation, and compliance reporting in',
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
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Distribution agreements for linear broadcast channels reference specific licensed facilities. Retransmission consent agreements, carriage deals, and network distribution contracts all specify call sig',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Distribution agreements specify which channels carry content (e.g., cable carriage agreements, affiliate distribution). Fundamental to carriage fee calculation, must-carry compliance, channel position',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Distribution agreements are executed by specific legal entities for proper revenue recognition, tax jurisdiction determination, and SOX compliance. Essential for carriage fee revenue allocation and in',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Distribution agreements specify which DMAs/markets the partner can distribute content in. Essential for territorial rights management and ensuring distribution partners operate within contracted geogr',
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
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Syndication agreements for broadcast distribution require the syndicating station to hold valid FCC licenses covering the agreed territories. Clearance obligations and territorial exclusivity are defi',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Syndication deals specify broadcast channels for content airing (e.g., off-network syndication to local stations). Essential for syndication scheduling, clearance tracking, run limit enforcement, and ',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Syndication agreements specify acceptable content ratings for target dayparts and audience demographics. Syndicators require content rated appropriately for early fringe, access, or late-night windows',
    `title_id` BIGINT COMMENT 'Reference to the primary content title being syndicated under this agreement.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Syndication deals require legal entity tracking for revenue allocation, tax treatment, and intercompany elimination. Critical for ASC 606 performance obligation tracking and multi-territory revenue re',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Syndication of childrens programming requires COPPA declarations covering data collection practices on associated digital platforms, companion websites, and mobile apps. Syndicators must ensure stati',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Syndication agreements grant rights to specific markets/DMAs. Essential for syndication clearance tracking and ensuring syndication partners broadcast only in contracted markets.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Syndication agreements grant rights to specific asset packages (e.g., 100-episode library). Direct asset link enables automated rights clearance in playout systems, run-limit enforcement, and syndicat',
    `employee_id` BIGINT COMMENT 'Reference to the Media Broadcasting employee who negotiated and finalized this syndication agreement.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Syndication agreements for selling content distribution rights originate from sales opportunities when the sales team identifies potential syndication partners. Links the sales pipeline to executed sy',
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
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Co-production agreements allocate responsibility for obtaining content ratings in different territories (MPAA for US theatrical, TV Parental Guidelines for US broadcast, BBFC for UK, etc.). Partners m',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Co-production investments are capitalized and tracked at legal entity level for consolidation, IP ownership accounting, and residuals liability. Essential for balance sheet classification and intercom',
    `coppa_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.coppa_declaration. Business justification: Co-productions targeting children must allocate COPPA compliance responsibilities between production partners, especially for digital/interactive components, companion apps, and online games. Agreemen',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Co-production investments are budgeted and tracked at cost center level for production accounting, budget variance analysis, and departmental spend control. Essential for production finance and cost a',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Coproduction agreements require executive sponsor tracking for approval authority, strategic oversight, and escalation. High-value IP investments need clear internal ownership beyond approval_authorit',
    `partner_id` BIGINT COMMENT 'Reference to the primary partner organization responsible for managing the co-production.',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Co-production agreements frequently specify lead talent (star, showrunner, director) as part of the deal structure—attached talent drives financing approval and production greenlight decisions. Critic',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Co-production agreements directly reference the production project being co-financed and co-produced. Linking enables tracking budget contributions, IP ownership splits, delivery obligations, and fina',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Coproduction agreements are title-specific investments requiring direct linkage for production finance tracking, IP ownership percentage calculation, delivery milestone management, and revenue waterfa',
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
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Affiliate agreements are channel-specific contracts between networks and local stations. Core to network-affiliate relationship management, affiliation fee calculation, must-air programming compliance',
    `affiliate_network_channel_id` BIGINT COMMENT 'Reference to the parent network or broadcast network entity that is the counterparty to this affiliate agreement.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: affiliate_agreement.affiliate_station_id represents the affiliate station partner. Renaming to affiliate_station_partner_id for clarity (ends with partner_partner_partner_id pattern). Links to partner',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Network-affiliate agreements are fundamentally tied to the affiliate stations FCC broadcast license. The agreement references the stations call sign, facility ID, licensed market (DMA), and coverage',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Affiliate agreements are market-specific; each affiliate station serves a specific DMA. Essential for network-affiliate relationship management and ensuring proper market coverage. Removes denormalize',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Affiliate agreements generate intercompany transactions requiring legal entity tracking for network compensation accounting, retransmission revenue split allocation, and consolidation elimination. Cri',
    `primary_affiliate_station_channel_id` BIGINT COMMENT 'Reference to the local broadcast station or regional affiliate partner that is party to this agreement.',
    `affiliate_station_channel_id` BIGINT COMMENT '',
    `network_channel_id` BIGINT COMMENT '',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` (
    `deal_negotiation_id` BIGINT COMMENT 'Unique identifier for the deal negotiation record. Primary key for the deal negotiation entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deal negotiations consume business unit resources tracked via cost centers for budget management, headcount allocation, and deal closing cost analysis. Essential for content acquisition and distributi',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Deal negotiations for content acquisition/distribution target specific demographic segments (e.g., acquiring sports content to reach M18-49). Essential for content strategy planning and deal valuation',
    `opportunity_id` BIGINT COMMENT 'Reference to the originating sales opportunity in Salesforce Media Cloud that initiated this deal negotiation.',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity (studio, syndicator, content provider, MVPD, or distributor) involved in this negotiation.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or business development executive assigned as the primary negotiator for this deal.',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Deal negotiations for original content (pre-sales, co-production, distribution) reference the production project being negotiated. Linking enables tracking which projects are under negotiation, deal p',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Deals are evaluated against profit center P&L targets for strategic prioritization, EBITDA impact analysis, and segment performance reporting. Critical for content investment ROI tracking and business',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Major deal negotiations (M&A, license transfers, ownership changes, foreign ownership increases) trigger FCC filing requirements for prior approval or notification (Form 314, 315, 602). Deal teams mus',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to partner.acquisition_deal. Business justification: deal_negotiation tracks the negotiation lifecycle. When negotiation completes successfully, it results in an executed deal. New FK: resulting_acquisition_deal_id → acquisition_deal.acquisition_deal_id',
    `affiliate_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.affiliate_agreement. Business justification: deal_negotiation can result in affiliate_agreement. New FK: resulting_affiliate_agreement_id → affiliate_agreement.affiliate_agreement_id. Nullable (populated only when negotiation results in affiliat',
    `coproduction_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.coproduction_agreement. Business justification: deal_negotiation can result in coproduction_agreement. New FK: resulting_coproduction_agreement_id → coproduction_agreement.coproduction_agreement_id. Nullable (populated only when negotiation results',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: deal_negotiation can result in distribution_agreement. New FK: resulting_distribution_agreement_id → distribution_agreement.distribution_agreement_id. Nullable (populated only when negotiation results',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: deal_negotiation can result in syndication_agreement. New FK: resulting_syndication_agreement_id → syndication_agreement.syndication_agreement_id. Nullable (populated only when negotiation results in ',
    `sweeps_period_id` BIGINT COMMENT 'Foreign key linking to audience.sweeps_period. Business justification: Deal negotiations often reference specific sweeps periods for performance guarantees and pricing (e.g., guaranteed 5.0 rating in May sweeps). Critical for upfront deal structuring and performance-ba',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Deal negotiations target specific content genres for portfolio strategy. Pipeline forecasting by genre, content gap analysis, competitive positioning assessment, and strategic acquisition planning req',
    `tertiary_deal_legal_reviewer_employee_id` BIGINT COMMENT 'Reference to the legal counsel or attorney assigned to review this deal negotiation.',
    `actual_close_date` DATE COMMENT 'Actual date on which the deal was finalized and executed. Null if deal is still in negotiation or was not closed.',
    `agreed_deal_value` DECIMAL(18,2) COMMENT 'Final agreed total monetary value of the deal after negotiation, in the deal currency. Null until deal is finalized.',
    `approval_chain` STRING COMMENT 'Comma-separated list of approval roles or levels required for this deal (e.g., Business Unit Head, Legal, CFO, CEO, Board) based on deal value and risk.',
    `approval_conditions` STRING COMMENT 'Specific conditions or requirements that must be met before final approval can be granted (e.g., legal clearance, budget confirmation, board ratification).',
    `business_unit` STRING COMMENT 'The business unit or division sponsoring this deal negotiation (e.g., Linear Broadcasting, Streaming, News, Sports).',
    `contract_effective_date` DATE COMMENT 'Date on which the finalized contract becomes legally effective and binding on the parties.',
    `contract_expiration_date` DATE COMMENT 'Date on which the contract term ends and rights revert or require renewal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deal negotiation record was first created in the system.',
    `deal_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this deal negotiation.. Valid values are `^[A-Z]{3}$`',
    `deal_name` STRING COMMENT 'Human-readable name or title for the deal negotiation, typically including partner name and content description.',
    `deal_number` STRING COMMENT 'Externally-visible unique business identifier for the deal negotiation, used in communications and contract references.. Valid values are `^DEAL-[0-9]{6,10}$`',
    `deal_type` STRING COMMENT 'Classification of the deal negotiation by business purpose: content acquisition, licensing, distribution, co-production, syndication, or carriage agreement.. Valid values are `content_acquisition|content_licensing|distribution_agreement|co_production|syndication|carriage_agreement`',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this negotiation has been escalated to senior management or executive leadership for resolution (True) or is proceeding normally (False).',
    `escalation_reason` STRING COMMENT 'Explanation of why the negotiation was escalated, including specific issues requiring executive intervention.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the deal includes exclusive rights (True) or non-exclusive rights (False).',
    `key_open_issues` STRING COMMENT 'Summary of the primary unresolved issues or sticking points in the negotiation that require resolution before deal closure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this deal negotiation record was most recently updated.',
    `legal_review_status` STRING COMMENT 'Current status of the legal departments review of the deal terms and contract language.. Valid values are `not_started|in_progress|completed|approved|rejected|conditional_approval`',
    `negotiation_stage` STRING COMMENT 'Current stage in the deal negotiation workflow lifecycle, from initial term sheet through final execution or closure. [ENUM-REF-CANDIDATE: term_sheet|initial_proposal|counter_offer|redline_review|legal_review|business_approval|executive_approval|board_approval|final_execution|closed_won|closed_lost — 11 candidates stripped; promote to reference product]',
    `negotiation_start_date` DATE COMMENT 'Date on which formal negotiation discussions began for this deal.',
    `negotiation_status` STRING COMMENT 'Current operational status of the negotiation indicating whether it is actively progressing, on hold, escalated, or completed. [ENUM-REF-CANDIDATE: active|on_hold|escalated|pending_approval|approved|rejected|cancelled|completed — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, negotiation history, or special considerations relevant to this deal.',
    `payment_structure` STRING COMMENT 'Description of the proposed or agreed payment terms and structure (e.g., upfront, milestone-based, revenue share, minimum guarantee plus percentage).',
    `proposed_deal_value` DECIMAL(18,2) COMMENT 'Total monetary value proposed by the initiating party for this deal, in the deal currency.',
    `redline_version_count` STRING COMMENT 'Number of redlined contract versions exchanged during the negotiation process, indicating negotiation complexity.',
    `rights_duration_years` STRING COMMENT 'Duration in years for which content rights are being negotiated or agreed.',
    `rights_territory` STRING COMMENT 'Geographic territory or territories for which content rights are being negotiated (e.g., USA, North America, Worldwide excluding China).',
    `risk_rating` STRING COMMENT 'Overall risk assessment for this deal negotiation based on financial exposure, legal complexity, and strategic importance.. Valid values are `low|medium|high|critical`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this deal negotiation is subject to SOX-compliant authorization controls due to materiality thresholds (True) or not (False).',
    `target_close_date` DATE COMMENT 'Target date by which the parties aim to finalize and execute the deal agreement.',
    `term_sheet_date` DATE COMMENT 'Date on which the initial term sheet was presented or agreed upon by the parties.',
    `windowing_strategy` STRING COMMENT 'Description of the sequential release strategy and holdback periods being negotiated (e.g., theatrical window, SVOD window, linear broadcast window).',
    CONSTRAINT pk_deal_negotiation PRIMARY KEY(`deal_negotiation_id`)
) COMMENT 'Tracks the full deal workflow lifecycle from initial term sheet through counter-offers, redlines, legal review, internal approval routing, and final execution. Captures negotiation stage, assigned negotiator, key open issues, proposed vs. agreed terms, escalation flags, approval chain (business unit, legal, CFO, board), approval conditions, and target close date. Supports SOX-compliant deal authorization controls and integrates with Salesforce Media Cloud opportunity-to-contract workflows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` (
    `deal_amendment_id` BIGINT COMMENT 'Unique identifier for the deal amendment record. Primary key.',
    `distribution_agreement_id` BIGINT COMMENT 'Reference to the parent partner agreement being amended. Links to the original acquisition deal, distribution agreement, syndication agreement, or co-production arrangement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contract amendments require structured tracking of internal initiator for audit trail, approval workflow routing, and accountability. Replaces text field initiator_contact_name with proper FK for work',
    `superseded_by_amendment_deal_amendment_id` BIGINT COMMENT 'Reference to a subsequent amendment that replaces or supersedes this amendment. Null if this amendment is still current.',
    `amendment_number` STRING COMMENT 'Business identifier for the amendment, typically following a sequential or hierarchical numbering scheme (e.g., AMD-001, AMD-002). Used for external reference and tracking.. Valid values are `^AMD-[A-Z0-9]{6,12}$`',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment: draft (in preparation), pending_approval (submitted for review), approved (authorized but not yet signed), executed (fully signed and in effect), rejected (declined by one or both parties), superseded (replaced by a newer amendment).. Valid values are `draft|pending_approval|approved|executed|rejected|superseded`',
    `amendment_type` STRING COMMENT 'Classification of the amendment by its primary purpose: financial (pricing, payment terms, royalty rates), territorial (geographic rights expansion or restriction), term_extension (contract duration changes), content_scope (addition or removal of titles/episodes), rights_modification (windowing, exclusivity, sublicensing changes), or technical (delivery specifications, format requirements).. Valid values are `financial|territorial|term_extension|content_scope|rights_modification|technical`',
    `approval_chain` STRING COMMENT 'Structured or comma-separated list of internal approvers and their approval status (e.g., Legal:Approved, Finance:Approved, VP Content:Pending). Tracks the internal authorization workflow.',
    `business_justification` STRING COMMENT 'Narrative explanation of the business rationale for the amendment, including strategic objectives, market conditions, performance issues, or regulatory requirements driving the change.',
    `clauses_modified` STRING COMMENT 'Comma-separated list or structured reference to the specific contract clauses, sections, or articles being amended (e.g., Section 3.2 Payment Terms, Section 5.1 Territory, Exhibit A Content Schedule).',
    `content_scope_change` STRING COMMENT 'Description of changes to the content covered by the agreement, including titles, episodes, seasons, or genres added or removed. Null for amendments that do not modify content scope.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the amendment record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial_impact_amount (e.g., USD, GBP, EUR). Null if no financial impact.. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'File path, document management system identifier, or URI pointing to the executed amendment document (PDF, DOCX, or scanned image).',
    `effective_date` DATE COMMENT 'The date on which the amendment terms become binding and enforceable. May be retroactive, concurrent with execution, or future-dated.',
    `execution_date` DATE COMMENT 'The date on which all required parties signed the amendment, making it legally binding. Distinct from effective_date which governs when terms apply.',
    `expiration_date` DATE COMMENT 'The date on which the amendment terms cease to apply, if the amendment has a defined term. Null for amendments that permanently modify the agreement.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'The net financial impact of the amendment in the agreements base currency. Positive values indicate increased cost or revenue commitment; negative values indicate savings or reduced revenue. Null for non-financial amendments.',
    `initiated_by` STRING COMMENT 'Indicates which party requested the amendment: internal (broadcaster initiated), partner (studio/syndicator/distributor initiated), or mutual (jointly proposed).. Valid values are `internal|partner|mutual`',
    `internal_signatory_name` STRING COMMENT 'Name of the authorized representative from the broadcasting organization who signed the amendment.',
    `internal_signatory_title` STRING COMMENT 'Job title or role of the internal signatory (e.g., SVP Content Acquisition, Chief Business Officer).',
    `legal_review_date` DATE COMMENT 'Date on which legal review was completed and the amendment was cleared for execution.',
    `legal_reviewer_name` STRING COMMENT 'Name of the legal counsel or attorney who reviewed and approved the amendment language for compliance and risk.',
    `modified_by` STRING COMMENT 'User identifier or name of the individual who last modified the amendment record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the amendment record. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or internal commentary related to the amendment negotiation, execution, or impact.',
    `partner_signatory_name` STRING COMMENT 'Name of the authorized representative from the partner organization who signed the amendment.',
    `partner_signatory_title` STRING COMMENT 'Job title or role of the partner signatory (e.g., VP Business Affairs, Director of Distribution).',
    `rights_modification_description` STRING COMMENT 'Narrative description of changes to rights granted, including windowing adjustments, exclusivity modifications, sublicensing permissions, or platform restrictions. Null for amendments that do not modify rights.',
    `term_extension_months` STRING COMMENT 'Number of months by which the agreement term is extended (positive) or shortened (negative). Null for amendments that do not modify the agreement duration.',
    `territory_change_description` STRING COMMENT 'Narrative description of territorial rights changes, including countries or regions added or removed from the agreement scope. Null for non-territorial amendments.',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created the amendment record in the system.',
    CONSTRAINT pk_deal_amendment PRIMARY KEY(`deal_amendment_id`)
) COMMENT 'Formal amendments and modifications to executed partner agreements — acquisition deals, distribution agreements, syndication agreements, and co-production arrangements. Tracks amendment type (financial, territorial, term extension, content scope change), effective date, approval chain, and the specific clauses modified. Maintains a complete amendment history for each agreement.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` (
    `delivery_obligation_id` BIGINT COMMENT 'Primary key for delivery_obligation',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: Content delivery obligations include captioning deliverables (caption files, format specs, accuracy requirements). Acceptance testing verifies caption files meet FCC technical and quality standards be',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Content delivery specifications include rating certification requirements. Delivered assets must include on-screen rating cards, content descriptor overlays, and rating certification documentation. Ac',
    `title_id` BIGINT COMMENT 'Reference to the content title that must be delivered under this obligation.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Delivery obligations specify exact technical versions (resolution, codec, bitrate, DRM). QC acceptance workflows, redelivery tracking, and technical compliance verification require version-level preci',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Delivery obligations specify exact version/format requirements (HD vs 4K, dubbed vs subtitled). Tracks which specific version satisfies contractual delivery for acceptance sign-off, QC validation, and',
    `distribution_agreement_id` BIGINT COMMENT 'Reference to the parent partner agreement under which this delivery obligation exists.',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Delivery obligations are contractual commitments tied to specific license agreements. Direct FK enables delivery tracking against license terms, SLA compliance monitoring, and penalty calculation base',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Core business process: partners have contractual obligations to deliver specific assets. Direct asset link enables MAM integration for delivery tracking, acceptance workflows, automated compliance rep',
    `partner_id` BIGINT COMMENT 'Reference to the partner to whom content must be delivered or from whom content is expected.',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Content delivery obligations tie to specific broadcast schedules for fulfillment tracking (e.g., deliver episode 3 days before scheduled air date). Critical for partner SLA compliance, on-time deliver',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Content delivery obligations require assigned internal owner for accountability, escalation routing, and performance tracking. Critical for SLA compliance monitoring and breach response in content sup',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` (
    `carriage_fee_schedule_id` BIGINT COMMENT 'Unique identifier for the carriage fee schedule. Primary key for this entity.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Carriage fee schedules for broadcast retransmission consent agreements reference specific licensed stations by call sign, facility ID, and market designation. Fee structures are negotiated per-station',
    `carriage_agreement_id` BIGINT COMMENT 'Reference to the parent carriage agreement that governs this fee schedule. Links to the master distribution agreement between Media Broadcasting and the MVPD or vMVPD.',
    `channel_id` BIGINT COMMENT 'Reference to the specific Media Broadcasting channel covered by this fee schedule. A single carriage agreement may have multiple schedules for different channels.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Carriage fees are sometimes tiered based on the demographic performance of the channel (e.g., higher fees for channels delivering key demos). Essential for carriage fee negotiation and optimization.',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Carriage fees vary by content genre (sports premium vs general entertainment). Rate card negotiation, subscriber value modeling, and per-genre revenue allocation in distribution agreements require gen',
    `partner_id` BIGINT COMMENT 'Reference to the MVPD, vMVPD, or distribution partner who pays carriage fees under this schedule.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Carriage fees are recognized through defined revenue streams with specific accounting treatment, commission structures, and subscriber-based revenue recognition. Critical for distribution revenue acco',
    `audit_rights_flag` BOOLEAN COMMENT 'Boolean indicator of whether Media Broadcasting retains the right to audit the distributors subscriber counts and fee calculations to ensure compliance with the schedule terms.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Boolean indicator of whether this fee schedule automatically renews at the end of its term unless either party provides termination notice.',
    `base_fee_per_subscriber` DECIMAL(18,2) COMMENT 'The baseline carriage fee amount charged per subscriber per month. This is the foundational rate before any escalations, discounts, or adjustments are applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule record was first created in the system. Used for audit trail and data lineage purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which carriage fees are denominated and invoiced.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date on which this fee schedule expires or is superseded. Nullable for open-ended schedules that remain in force until renegotiated or terminated.',
    `effective_start_date` DATE COMMENT 'Date on which this fee schedule becomes effective and carriage fees begin to be calculated according to its terms.',
    `escalation_frequency` STRING COMMENT 'Frequency at which fee escalations are applied. Defines how often the base fee is adjusted according to the escalation type and rate.. Valid values are `none|annual|biannual|quarterly|monthly|custom`',
    `escalation_rate_percentage` DECIMAL(18,2) COMMENT 'Annual percentage rate by which the base fee per subscriber increases, if escalation type is fixed percentage. Expressed as a percentage (e.g., 3.00 for 3% annual increase).',
    `escalation_type` STRING COMMENT 'Method by which carriage fees increase over time. Options include no escalation, fixed annual percentage increase, Consumer Price Index (CPI) indexing, negotiated increases at specified intervals, or tiered increases based on subscriber growth.. Valid values are `none|fixed_percentage|cpi_indexed|negotiated|tiered`',
    `fee_type` STRING COMMENT 'Classification of the fee structure. Indicates whether fees are charged per subscriber, as a flat monthly rate, in tiers based on subscriber count, volume-based with discounts, a hybrid model, or as a percentage of revenue share.. Valid values are `per_subscriber|flat_rate|tiered|volume_based|hybrid|revenue_share`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule record was last updated. Tracks the most recent change to any field in the record for audit and compliance purposes.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied as a penalty for late payment of carriage fees beyond the payment terms. Expressed as an annual percentage rate or per-period rate.',
    `maximum_fee_cap` DECIMAL(18,2) COMMENT 'The maximum total carriage fee amount per billing period, regardless of subscriber count. Protects the distributor from excessive fees in high-subscriber scenarios.',
    `mfn_provision_flag` BOOLEAN COMMENT 'Boolean indicator of whether this schedule includes a Most-Favored-Nation clause. If true, the distributor is entitled to the most favorable carriage fee terms that Media Broadcasting offers to any comparable distributor.',
    `mfn_scope` STRING COMMENT 'Defines the scope and conditions under which the MFN provision applies, including comparable distributor criteria, geographic limitations, and exclusions.',
    `minimum_guaranteed_fee` DECIMAL(18,2) COMMENT 'The minimum total carriage fee amount guaranteed per billing period, regardless of subscriber count. Protects Media Broadcasting revenue in low-subscriber scenarios.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, exceptions, or clarifications related to this fee schedule that do not fit structured fields.',
    `payment_frequency` STRING COMMENT 'Frequency at which carriage fees are invoiced and paid by the distributor. Defines the billing cycle for this fee schedule.. Valid values are `monthly|quarterly|annual|custom`',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due. Standard payment terms such as Net 30, Net 60, or custom terms.',
    `schedule_name` STRING COMMENT 'Business-friendly name or identifier for this fee schedule, used for internal reference and reporting purposes.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the fee schedule. Indicates whether the schedule is in draft, actively in force, temporarily suspended, expired, terminated early, or superseded by a newer version.. Valid values are `draft|active|suspended|expired|terminated|superseded`',
    `schedule_version` STRING COMMENT 'Version identifier for this fee schedule, used to track amendments, renegotiations, and historical changes to fee structures over the life of the agreement.',
    `subscriber_count_source` STRING COMMENT 'Source of subscriber count data used to calculate carriage fees. Options include distributor self-reporting, third-party audit, Nielsen measurement, or Media Broadcasting internal estimates.. Valid values are `distributor_reported|third_party_audit|nielsen|internal_estimate`',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate this fee schedule prior to its natural expiration date.',
    `volume_discount_tier_1_rate` DECIMAL(18,2) COMMENT 'Discounted per-subscriber fee rate applicable when subscriber count exceeds the Tier 1 threshold.',
    `volume_discount_tier_1_threshold` BIGINT COMMENT 'Subscriber count threshold at which the first volume discount tier is triggered. Distributors exceeding this subscriber count qualify for a reduced per-subscriber fee.',
    `volume_discount_tier_2_rate` DECIMAL(18,2) COMMENT 'Discounted per-subscriber fee rate applicable when subscriber count exceeds the Tier 2 threshold.',
    `volume_discount_tier_2_threshold` BIGINT COMMENT 'Subscriber count threshold at which the second volume discount tier is triggered, offering further per-subscriber fee reduction.',
    `volume_discount_tier_3_rate` DECIMAL(18,2) COMMENT 'Discounted per-subscriber fee rate applicable when subscriber count exceeds the Tier 3 threshold.',
    `volume_discount_tier_3_threshold` BIGINT COMMENT 'Subscriber count threshold at which the third volume discount tier is triggered, offering the deepest per-subscriber fee reduction.',
    CONSTRAINT pk_carriage_fee_schedule PRIMARY KEY(`carriage_fee_schedule_id`)
) COMMENT 'Fee schedule governing carriage payments from MVPDs and vMVPDs for distribution of Media Broadcasting channels. Defines per-subscriber fee tiers, escalation clauses, most-favored-nation (MFN) provisions, volume discount thresholds, and payment frequency. Reference entity used to calculate carriage fee invoices in the billing domain.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` (
    `performance_obligation_id` BIGINT COMMENT 'Unique identifier for the partner performance obligation record. Primary key.',
    `accessibility_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.accessibility_obligation. Business justification: Partner SLAs for content delivery include accessibility obligations (captioning accuracy thresholds, audio description delivery, caption format compliance) that map to FCC/CVAA regulatory accessibilit',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Performance obligations often specify demographic delivery targets (e.g., must deliver 3.0 A18-49 rating). Essential for SLA monitoring, compliance verification, and makegood determination.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Performance obligations (minimum plays, promotional commitments, playlist inclusion) are measured against specific assets. Direct asset link enables automated compliance monitoring, breach detection, ',
    `partner_agreement_id` BIGINT COMMENT 'Reference to the parent partner agreement under which this performance obligation is defined.',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity responsible for fulfilling this performance obligation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SLA obligations require structured employee assignment for breach monitoring, cure period management, and escalation. Replaces text field responsible_party with FK for workload reporting, performance ',
    `sweeps_period_id` BIGINT COMMENT 'Foreign key linking to audience.sweeps_period. Business justification: Performance obligations often reference sweeps periods for measurement (e.g., must achieve X rating during November sweeps). Essential for contract compliance verification during key measurement win',
    `breach_count` STRING COMMENT 'The cumulative number of times this performance obligation has been breached since the effective start date or last reset.',
    `compliance_status` STRING COMMENT 'Current compliance state of the performance obligation based on the most recent measurement period.. Valid values are `compliant|non_compliant|at_risk|under_review|not_yet_measured|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this performance obligation record was first created in the system.',
    `cure_deadline_date` DATE COMMENT 'The calculated deadline by which the partner must cure the most recent breach to avoid penalties. Null if no active breach exists.',
    `cure_period_days` STRING COMMENT 'The number of days allowed for the partner to remedy a breach before penalties or escalation actions are triggered, as defined in the agreement.',
    `effective_end_date` DATE COMMENT 'The date when this performance obligation expires or is no longer enforceable. Null indicates an open-ended obligation tied to the agreement term.',
    `effective_start_date` DATE COMMENT 'The date when this performance obligation becomes active and enforceable under the partner agreement.',
    `escalation_level` STRING COMMENT 'The current escalation level for this performance obligation based on breach severity and frequency, as defined in the agreement escalation matrix.. Valid values are `none|level_1|level_2|level_3|executive|legal`',
    `last_breach_date` DATE COMMENT 'The date of the most recent breach event for this performance obligation.',
    `last_measured_date` DATE COMMENT 'The date when the performance obligation was last evaluated for compliance.',
    `last_measured_value` DECIMAL(18,2) COMMENT 'The actual measured value from the most recent compliance evaluation period.',
    `last_notification_date` DATE COMMENT 'The date when the partner was last notified regarding the compliance status or breach of this performance obligation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this performance obligation record was last modified.',
    `makegood_provision_flag` BOOLEAN COMMENT 'Indicates whether this obligation includes a makegood provision requiring compensatory ad spots or content delivery in case of non-compliance.',
    `makegood_spots_required` STRING COMMENT 'The number of compensatory advertising spots or content deliveries required to remedy a breach, if makegood provision applies.',
    `measurement_period` STRING COMMENT 'The time period over which the performance obligation is measured and evaluated for compliance. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|per_broadcast|per_delivery — 7 candidates stripped; promote to reference product]',
    `monitoring_system` STRING COMMENT 'The name or identifier of the system or platform used to monitor and measure compliance with this performance obligation (e.g., Nielsen, Akamai CDN, internal monitoring tool).',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this performance obligation, including special conditions, waivers, or historical context.',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether the partner must be formally notified of compliance status or breach events for this obligation.',
    `obligation_code` STRING COMMENT 'Business identifier code for the performance obligation, used for tracking and reporting purposes.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `obligation_description` STRING COMMENT 'Detailed description of the performance obligation, including specific terms, conditions, and expectations as stated in the partner agreement.',
    `obligation_name` STRING COMMENT 'Human-readable name describing the performance obligation (e.g., Uptime Guarantee, Content Delivery Timeliness, Ratings Performance Threshold).',
    `obligation_type` STRING COMMENT 'Category of performance obligation as defined in the partner agreement. Determines the measurement and compliance framework applied.. Valid values are `uptime_guarantee|content_delivery_sla|ratings_performance|subscriber_penetration|makegood_provision|quality_of_service`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary value of the penalty applied per breach or per measurement period, if the penalty type is financial. Expressed in the agreement currency.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `penalty_type` STRING COMMENT 'The type of penalty or remedy applied when this performance obligation is breached, as specified in the partner agreement.. Valid values are `financial_credit|makegood_spots|service_credit|termination_right|escalation|none`',
    `reporting_frequency` STRING COMMENT 'The frequency at which compliance reporting is required for this performance obligation, as specified in the partner agreement.. Valid values are `real_time|daily|weekly|monthly|quarterly|on_demand`',
    `sla_metric` STRING COMMENT 'The specific metric being measured for this obligation (e.g., System Uptime Percentage, Content Delivery Time, Average Rating Points, Subscriber Count).',
    `threshold_operator` STRING COMMENT 'The comparison operator used to evaluate compliance against the threshold value (e.g., greater than or equal to 99.9% uptime).. Valid values are `greater_than|greater_than_or_equal|less_than|less_than_or_equal|equal|between`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The numeric threshold or target value that must be met or exceeded to satisfy the performance obligation.',
    `unit_of_measure` STRING COMMENT 'The unit in which the threshold value is expressed (e.g., percentage, hours, rating points, subscriber count, minutes).',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Tracks contractual performance obligations and SLA commitments within partner agreements — uptime guarantees, content delivery timeliness, ratings performance thresholds, subscriber penetration targets, and makegood provisions. Monitors compliance status, breach events, and cure period tracking. Supports revenue assurance and financial reconciliation processes.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` (
    `minimum_guarantee_id` BIGINT COMMENT 'Unique identifier for the minimum guarantee commitment within a content acquisition deal.',
    `acquisition_deal_id` BIGINT COMMENT 'Reference to the parent content acquisition deal that contains this minimum guarantee commitment.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: MG advances post to specific GL accounts for balance sheet classification, amortization tracking, and recoupment accounting. Critical for content asset accounting and deferred cost management.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: MG recoupment is calculated against specific asset performance (views, revenue, plays). Direct asset link enables automated royalty accounting, overage calculation, and partner statements showing whic',
    `partner_id` BIGINT COMMENT 'Reference to the studio, syndicator, or content provider receiving the minimum guarantee payment.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: MG recoupment tracking requires linking actual invoiced revenue (syndication fees, royalty statements) back to the guarantee for overage calculation, royalty true-ups, and partner financial reporting.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: MG recoupment flows through specific revenue streams for ASC 606 compliance, performance obligation tracking, and royalty accounting. Essential for revenue recognition method determination and deferre',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` (
    `payment_term_id` BIGINT COMMENT 'Unique identifier for the partner payment term record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Payment terms require approver tracking for financial controls, SOX compliance, and audit trail. Approval_required_flag exists but no FK to capture who approved - essential for segregation of duties r',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Payment terms specify GL accounts for AP posting, cash flow forecasting, and financial statement classification. Essential for accounts payable automation, payment processing, and balance sheet accura',
    `partner_id` BIGINT COMMENT 'Reference to the partner (studio, syndicator, content provider, MVPD, or third-party distributor) to whom this payment term applies.',
    `payment_schedule_id` BIGINT COMMENT 'Reference to a detailed payment schedule record that breaks down this term into multiple installments or recurring payments.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment term record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, GBP, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this payment term expires or is superseded by a new term. Null if the term remains active indefinitely or until contract termination.',
    `effective_start_date` DATE COMMENT 'The date from which this payment term becomes active and enforceable under the contract.',
    `invoice_required_flag` BOOLEAN COMMENT 'Indicates whether the partner must submit an invoice before payment can be processed. True if invoice is required, False if payment is automatic or self-billed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment term record was most recently updated.',
    `late_payment_grace_period_days` STRING COMMENT 'Number of days after the payment due date during which no late payment penalty is assessed, allowing the payer time to remit without financial consequence.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage penalty or interest rate applied to overdue payments, typically expressed as an annual percentage rate (APR) or per-period rate as defined in the contract.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the payment obligation before any adjustments, taxes, or withholdings. Expressed in the currency specified in the currency_code field.',
    `payment_approval_required_flag` BOOLEAN COMMENT 'Indicates whether internal approval is required before payment can be released. True if approval workflow must be completed, False if payment is automatic upon due date.',
    `payment_bank_account_number` BIGINT COMMENT 'Reference to the partners bank account record where payment should be remitted. Used for wire transfer and ACH payments.',
    `payment_due_date` DATE COMMENT 'The date by which the payment must be made to the partner to avoid late payment penalties or interest charges.',
    `payment_frequency` STRING COMMENT 'Recurrence pattern for the payment: one-time (single payment), monthly, quarterly, semi-annual, annual, or upon milestone (event-driven).. Valid values are `one_time|monthly|quarterly|semi_annual|annual|upon_milestone`',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to settle the payment: wire transfer, ACH (Automated Clearing House), check, letter of credit, escrow, or barter (non-cash exchange).. Valid values are `wire_transfer|ach|check|letter_of_credit|escrow|barter`',
    `payment_milestone` STRING COMMENT 'Business event or condition that triggers this payment obligation (e.g., Upon Delivery, First Broadcast, Quarterly Arrears, Upon Execution, Net 30 Days from Invoice).',
    `payment_notes` STRING COMMENT 'Internal notes or comments regarding this payment term, including any special handling instructions, dispute history, or reconciliation issues.',
    `payment_remittance_email` STRING COMMENT 'Email address to which payment remittance advice and confirmation should be sent. May differ from the partners primary contact email.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment term: pending (not yet active), scheduled (future payment), due (payment date reached), paid (completed), overdue (past due date), disputed (under review), or waived (obligation removed). [ENUM-REF-CANDIDATE: pending|scheduled|due|paid|overdue|disputed|waived — 7 candidates stripped; promote to reference product]',
    `payment_terms_description` STRING COMMENT 'Free-text narrative describing the payment terms, including any special conditions, contingencies, or negotiated clauses not captured in structured fields.',
    `term_number` STRING COMMENT 'Business identifier for this payment term, often used in invoicing and reconciliation. May follow partner-specific or internal numbering conventions.',
    `term_type` STRING COMMENT 'Classification of the payment term based on the nature of the financial obligation: acquisition fee (content licensing), carriage fee (distribution payment), syndication fee (content resale), co-production contribution (shared production cost), royalty (usage-based payment), or residual (talent reuse payment).. Valid values are `acquisition_fee|carriage_fee|syndication_fee|co_production_contribution|royalty|residual`',
    `withholding_tax_jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the jurisdiction whose tax laws govern the withholding obligation (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Percentage of the payment amount that must be withheld for tax purposes based on the partners jurisdiction and applicable tax treaties. Expressed as a percentage (e.g., 15.00 for 15%).',
    CONSTRAINT pk_payment_term PRIMARY KEY(`payment_term_id`)
) COMMENT 'Payment terms and schedules agreed with partners for acquisition fees, carriage fees, syndication fees, and co-production cost contributions. Captures payment milestones, due dates, currency, payment method, late payment penalty clauses, and withholding tax obligations by jurisdiction. Used by the billing domain to generate partner-facing invoices and payment schedules.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` (
    `territory_grant_id` BIGINT COMMENT 'Unique identifier for the territory grant record. Primary key.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Territory grants in distribution agreements must align with licensed broadcast coverage areas. Grants reference DMA codes, coverage contours, and geographic service areas defined by FCC broadcast lice',
    `title_id` BIGINT COMMENT 'Reference to the content title for which territorial rights are granted.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Rights grants require legal reviewer tracking for clearance verification, compliance sign-off, and dispute resolution. Clearance_status exists but no FK to attorney who verified - critical for legal w',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Territory grants in partner domain represent distribution rights that must align with underlying license_agreement terms for territory scope, exclusivity, and windowing. Direct FK enables rights clear',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Territory rights are granted at asset level for international distribution. Playout systems check asset-territory combinations before transmission to prevent rights violations, enable geo-blocking, an',
    `partner_agreement_id` BIGINT COMMENT 'Reference to the parent partner agreement under which this territorial grant is defined.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Territory grants license content rights to specific partners (broadcasters, streaming platforms, theatrical distributors) for defined geographic regions. Links rights grants to partner master for righ',
    `scheduling_availability_window_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_availability_window. Business justification: Territory grants in partner agreements define where/when content can be scheduled (e.g., exclusive US broadcast rights 2024-2026). Essential for rights-compliant scheduling, avoiding territorial viola',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` (
    `partner_audit_event_id` BIGINT COMMENT 'Unique identifier for the partner audit event record. Primary key.',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Partner audits (royalty audits, revenue share audits, compliance audits) generate findings that must be tracked in the compliance system for remediation, dispute resolution, and regulatory reporting. ',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Partner audits (royalty audits, subscriber count verification audits, revenue share audits) examine specific invoices for accuracy. Linking audit events to invoices enables audit trail documentation, ',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Audits often dispute specific title performance data, revenue allocation, or delivery compliance. Audit finding resolution, adjustment calculation, evidence documentation, and settlement negotiation r',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Partner audits require internal coordinator tracking for liaison with external auditors, document gathering, response management, and follow-up. Essential for audit workload planning, response time tr',
    `partner_agreement_id` BIGINT COMMENT 'Identifier of the specific partner agreement under which the audit right is being exercised. Links to the contract containing audit provisions.',
    `partner_id` BIGINT COMMENT 'Identifier of the partner subject to the audit. Links to the partner being audited under contractual audit rights.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The final monetary adjustment agreed upon or imposed as a result of the audit, representing the net financial settlement. Positive values indicate amounts owed to the auditing party; negative values indicate refunds or credits.',
    `adjustment_amount_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the adjustment amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `audit_cost` DECIMAL(18,2) COMMENT 'The total cost incurred for conducting the audit, including audit firm fees, internal resource costs, travel expenses, and other related costs. Used for cost recovery and budget tracking.',
    `audit_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `audit_finding_summary` STRING COMMENT 'High-level summary of the audit findings, including key discrepancies, compliance issues, or areas of concern identified during the audit.',
    `audit_firm_name` STRING COMMENT 'Name of the external audit firm or internal audit team conducting the audit. May be a third-party accounting firm, specialized media audit firm, or internal audit department.',
    `audit_initiated_date` DATE COMMENT 'The date on which the audit was formally initiated, typically when the audit notice was sent to the partner or when the audit firm was engaged.',
    `audit_period_end_date` DATE COMMENT 'The ending date of the period being audited. Defines the end of the time window for which records, transactions, and compliance are being examined.',
    `audit_period_start_date` DATE COMMENT 'The beginning date of the period being audited. Defines the start of the time window for which records, transactions, and compliance are being examined.',
    `audit_reference_number` STRING COMMENT 'External reference number or code assigned to this audit event by the auditing party or audit firm for tracking and correspondence purposes.',
    `audit_scope` STRING COMMENT 'Detailed description of the scope of the audit, including the specific content, time periods, territories, revenue streams, or cost categories being examined.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit event. Planned audits are scheduled but not started; in-progress audits are actively being conducted; fieldwork complete indicates data collection is done; draft report indicates preliminary findings are documented; final report indicates audit is complete; disputed indicates findings are contested; resolved indicates disputes are settled; closed indicates all actions are complete. [ENUM-REF-CANDIDATE: planned|in_progress|fieldwork_complete|draft_report|final_report|disputed|resolved|closed — 8 candidates stripped; promote to reference product]',
    `audit_trigger` STRING COMMENT 'The event or condition that initiated the audit. Scheduled audits are routine contractual audits; threshold breach audits are triggered by variance thresholds; dispute audits arise from disagreements; regulatory audits are mandated by authorities; random audits are part of compliance sampling; partner request audits are initiated by the partner.. Valid values are `scheduled|threshold_breach|dispute|regulatory|random|partner_request`',
    `audit_type` STRING COMMENT 'Category of audit being performed. Content usage audits verify content delivery and usage reporting; subscriber count audits verify subscriber numbers for carriage fee calculations; royalty statement audits verify royalty calculations and payments; carriage fee audits verify fee calculations; co-production cost audits verify shared production expenses; rights compliance audits verify adherence to licensing terms.. Valid values are `content_usage|subscriber_count|royalty_statement|carriage_fee|co_production_cost|rights_compliance`',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective actions required or agreed upon, including process changes, system enhancements, training, or compliance measures.',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which the partner must complete the required corrective actions. Used for tracking compliance with audit remediation requirements.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective actions are required from the partner as a result of the audit findings. True if process improvements, system changes, or compliance remediation is mandated.',
    `cost_recovery_status` STRING COMMENT 'Status of recovering audit costs from the partner when contractually permitted. Not applicable if costs are not recoverable; pending if recovery not yet initiated; invoiced if bill sent; partially recovered if some payment received; fully recovered if all costs reimbursed; waived if costs forgiven.. Valid values are `not_applicable|pending|invoiced|partially_recovered|fully_recovered|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit event record was first created in the system. Used for data lineage and audit trail purposes.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The total monetary amount in dispute as a result of audit findings, representing the financial discrepancy between reported and audited figures. Null if no financial dispute exists.',
    `disputed_amount_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the disputed amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `draft_report_date` DATE COMMENT 'The date on which the draft audit report was issued to the partner for review and response before finalization.',
    `fieldwork_end_date` DATE COMMENT 'The date on which the audit fieldwork was completed, when auditors finished their on-site or remote examination activities.',
    `fieldwork_start_date` DATE COMMENT 'The date on which the audit fieldwork began, when auditors started examining records, conducting interviews, and gathering evidence.',
    `final_report_date` DATE COMMENT 'The date on which the final audit report was issued, incorporating partner responses and auditor conclusions.',
    `finding_category` STRING COMMENT 'Classification of the severity and nature of audit findings. No findings indicates clean audit; minor discrepancy indicates immaterial variances; material discrepancy indicates significant financial impact; compliance breach indicates contractual violations; fraud suspected indicates potential intentional misrepresentation; process weakness indicates control deficiencies.. Valid values are `no_findings|minor_discrepancy|material_discrepancy|compliance_breach|fraud_suspected|process_weakness`',
    `follow_up_audit_date` DATE COMMENT 'The scheduled or actual date of the follow-up audit to verify corrective action implementation and compliance.',
    `follow_up_audit_required` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify implementation of corrective actions or to re-examine areas of concern. True if subsequent audit is mandated.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor responsible for conducting and overseeing the audit engagement.',
    `notes` STRING COMMENT 'Additional notes, comments, or context about the audit event, including special circumstances, escalations, or other relevant information not captured in structured fields.',
    `partner_response_date` DATE COMMENT 'The date on which the partner formally responded to the draft or final audit report, providing their position on the findings.',
    `partner_response_summary` STRING COMMENT 'Summary of the partners formal response to the audit findings, including their agreement, disagreement, explanations, or proposed corrective actions.',
    `resolution_date` DATE COMMENT 'The date on which the audit findings and any disputes were fully resolved, either through acceptance, negotiation, arbitration, or legal settlement.',
    `resolution_status` STRING COMMENT 'Current status of the resolution process for audit findings. Pending indicates no response yet; accepted indicates partner agrees with findings; partially accepted indicates agreement on some findings; rejected indicates partner disputes findings; negotiating indicates active discussions; arbitration indicates formal dispute resolution; litigation indicates legal proceedings; settled indicates final agreement reached. [ENUM-REF-CANDIDATE: pending|accepted|partially_accepted|rejected|negotiating|arbitration|litigation|settled — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit event record was last modified. Used for tracking changes and data currency.',
    CONSTRAINT pk_partner_audit_event PRIMARY KEY(`partner_audit_event_id`)
) COMMENT 'Business audit events related to partner agreement compliance — content usage audits, subscriber count verifications for carriage fee calculations, royalty statement audits, and co-production cost audits. Tracks audit trigger, scope, findings, disputed amounts, resolution status, and audit firm. Distinct from IT audit logs — these are contractual audit rights exercised under partner agreements.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` (
    `partner_dispute_id` BIGINT COMMENT 'Unique identifier for the partner dispute record. Primary key.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Partner disputes involving regulatory violations (content standards breaches, license term violations, political advertising equal time disputes, closed captioning failures) must be logged as complian',
    `contract_id` BIGINT COMMENT 'Reference to the contract or agreement under which the dispute arose. Links to the partner contract record.',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Disputes frequently concern specific title rights interpretation, royalty calculations, or delivery specifications. Legal case management, settlement negotiation, evidence gathering, and contract inte',
    `employee_id` BIGINT COMMENT 'Reference to the internal user or team member currently responsible for managing the dispute.',
    `partner_id` BIGINT COMMENT 'Reference to the partner involved in the dispute. Links to the partner master record.',
    `acknowledgment_date` DATE COMMENT 'Date on which the receiving party formally acknowledged receipt of the dispute.',
    `actual_resolution_date` DATE COMMENT 'Actual date on which the dispute was resolved or closed.',
    `arbitration_body` STRING COMMENT 'Name of the arbitration organization or body handling the dispute (e.g., American Arbitration Association, JAMS).',
    `arbitration_case_number` STRING COMMENT 'External case or docket number assigned by the arbitration body.',
    `arbitration_required` BOOLEAN COMMENT 'Indicates whether the dispute requires or has entered binding arbitration per contractual dispute resolution clauses.',
    `assigned_to_department` STRING COMMENT 'Name of the internal department or functional area currently handling the dispute (e.g., Finance, Legal, Operations).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the original disputed amount if different from USD.. Valid values are `^[A-Z]{3}$`',
    `dispute_category` STRING COMMENT 'High-level category grouping disputes by functional area for reporting and routing purposes.. Valid values are `financial|operational|contractual|technical|legal|compliance`',
    `dispute_description` STRING COMMENT 'Detailed narrative description of the dispute, including the nature of the disagreement, relevant facts, and partner claims.',
    `dispute_number` STRING COMMENT 'Externally-visible unique reference number assigned to the dispute for tracking and communication purposes.',
    `dispute_status` STRING COMMENT 'Current lifecycle state of the dispute. Tracks progression from initiation through resolution or closure. [ENUM-REF-CANDIDATE: open|under_review|escalated|pending_evidence|negotiation|mediation|arbitration|resolved|closed|withdrawn — 10 candidates stripped; promote to reference product]',
    `dispute_type` STRING COMMENT 'Classification of the dispute by its primary subject matter. Determines escalation path and resolution workflow.. Valid values are `payment_discrepancy|content_delivery_failure|ratings_shortfall|carriage_fee_calculation|rights_violation|sla_breach`',
    `disputed_amount_usd` DECIMAL(18,2) COMMENT 'The monetary value in dispute, expressed in USD. Represents the financial exposure or claim amount.',
    `disputed_period_end_date` DATE COMMENT 'End date of the time period to which the dispute relates.',
    `disputed_period_start_date` DATE COMMENT 'Start date of the time period to which the dispute relates (e.g., billing cycle, content delivery window).',
    `escalation_level` STRING COMMENT 'Current escalation tier within the dispute resolution hierarchy, from operational to executive or legal levels.. Valid values are `level_1|level_2|level_3|executive|legal`',
    `evidence_submitted_date` DATE COMMENT 'Date on which supporting evidence was submitted by the disputing party.',
    `filed_date` DATE COMMENT 'Date on which the dispute was formally filed or raised by either party.',
    `initiated_by` STRING COMMENT 'Indicates whether the dispute was raised by the partner or by the internal organization.. Valid values are `partner|internal`',
    `legal_hold_date` DATE COMMENT 'Date on which the legal hold was initiated for this dispute.',
    `legal_hold_status` BOOLEAN COMMENT 'Indicates whether a legal hold has been placed on records and communications related to this dispute for litigation preservation.',
    `mediation_required` BOOLEAN COMMENT 'Indicates whether the dispute requires or has entered formal mediation per contractual dispute resolution clauses.',
    `notes` STRING COMMENT 'Free-form notes and comments related to the dispute, including internal observations, partner communications, and status updates.',
    `preventive_action_taken` STRING COMMENT 'Description of corrective or preventive actions implemented to avoid recurrence of similar disputes.',
    `priority` STRING COMMENT 'Business priority assigned to the dispute based on financial impact, relationship risk, and contractual obligations.. Valid values are `critical|high|medium|low`',
    `resolution_outcome` STRING COMMENT 'Final outcome of the dispute resolution process, indicating which party prevailed or if a settlement was reached.. Valid values are `partner_favor|internal_favor|mutual_settlement|withdrawn|dismissed|arbitration_award`',
    `resolution_summary` STRING COMMENT 'Narrative summary of the resolution terms, settlement agreement, or arbitration decision.',
    `root_cause_analysis` STRING COMMENT 'Documented analysis of the underlying cause of the dispute, used for process improvement and future prevention.',
    `settlement_amount_usd` DECIMAL(18,2) COMMENT 'Final settlement amount agreed upon or awarded, expressed in USD. May differ from the originally disputed amount.',
    `supporting_evidence_location` STRING COMMENT 'File path, document repository reference, or Media Asset Management (MAM) location where supporting evidence and documentation are stored.',
    `target_resolution_date` DATE COMMENT 'Target date by which the dispute should be resolved per contractual Service Level Agreement (SLA) or internal policy.',
    `updated_by` STRING COMMENT 'User identifier or system account that last modified the dispute record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was last modified.',
    `created_by` STRING COMMENT 'User identifier or system account that created the dispute record.',
    CONSTRAINT pk_partner_dispute PRIMARY KEY(`partner_dispute_id`)
) COMMENT 'Formal disputes raised by or against partners regarding agreement terms, payment discrepancies, content delivery failures, ratings shortfalls, or carriage fee calculations. Tracks dispute type, disputed amount, supporting evidence, escalation path, legal hold status, and resolution outcome. Feeds financial reconciliation and legal compliance workflows.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` (
    `partner_content_window_id` BIGINT COMMENT 'Unique identifier for the content window record. Primary key.',
    `acquisition_deal_id` BIGINT COMMENT 'Reference to the acquisition, distribution, or syndication agreement under which this window is granted.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Windowing strategies require business owner tracking for activation decisions, performance monitoring, and renewal negotiations. Critical for accountability in SVOD/AVOD/TVOD window management and rev',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Distribution windows (theatrical, premium cable, broadcast, SVOD) have different rating requirements and standards. Theatrical windows use MPAA ratings; broadcast windows use TV Parental Guidelines. W',
    `title_id` BIGINT COMMENT 'Reference to the specific content title (film, series, episode, or program) to which this window applies.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Windowing plans specify which technical version (theatrical cut vs streaming edit, language dub, HDR format) is available in each distribution window. Platform delivery orchestration, DRM policy appli',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Content windows are often structured around demographic appeal (e.g., theatrical window targets broader demos, SVOD window targets younger demos). Essential for windowing strategy optimization and rev',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Windows define when/where specific assets can be exploited (SVOD window, linear window, international window). Direct asset link required for automated compliance checks in playout systems, preventing',
    `partner_id` BIGINT COMMENT 'Reference to the internal employee or team responsible for managing and monitoring this content window (e.g., rights manager, distribution coordinator).',
    `activation_date` DATE COMMENT 'The actual date on which the content was made available on the platform, which may differ from the planned window_start_date due to operational delays or early releases.',
    `content_format` STRING COMMENT 'The technical video format or resolution standard required for delivery in this window (e.g., SD, HD, 4K, 8K, HDR, Dolby Vision).. Valid values are `sd|hd|4k|8k|hdr|dolby_vision`',
    `contract_reference_number` STRING COMMENT 'External reference number or identifier for the legal contract or agreement document that governs this window. Used for audit and compliance traceability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this content window record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this window record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deactivation_date` DATE COMMENT 'The actual date on which the content was removed from the platform, which may differ from the planned window_end_date due to early termination or extensions.',
    `drm_requirement` STRING COMMENT 'The DRM technology required to protect the content during this window (e.g., Widevine, FairPlay, PlayReady, Multi-DRM, or none for unprotected distribution).. Valid values are `none|widevine|fairplay|playready|multi_drm`',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this window grants exclusive distribution rights to the platform (True) or allows concurrent distribution on other platforms (False).',
    `exclusivity_scope` STRING COMMENT 'Defines the boundaries of exclusivity (e.g., platform-exclusive, territory-exclusive, window-type-exclusive, non-exclusive). Provides context when exclusivity_flag is True.',
    `holdback_period_days` STRING COMMENT 'The mandatory waiting period (in days) between the end of the previous window and the start of this window, ensuring sequential exclusivity and protecting prior windows.',
    `language_availability` STRING COMMENT 'Languages in which the content must be made available during this window (e.g., English, Spanish, French). Comma-separated list of ISO 639-1 language codes.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user or system process that last modified this record. Used for audit and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this content window record was most recently updated. Used for audit trail and change tracking.',
    `marketing_rights_included_flag` BOOLEAN COMMENT 'Indicates whether the platform has rights to use promotional materials, trailers, and marketing assets for this window (True) or must obtain separate clearance (False).',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum payment guaranteed to the content provider for this window, regardless of actual revenue performance. Expressed in the deal currency.',
    `monetization_model` STRING COMMENT 'The revenue model associated with this window (e.g., subscription-based SVOD, advertising-supported AVOD, transactional TVOD, free, or hybrid).. Valid values are `subscription|advertising|transactional|free|hybrid`',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes related to this window (e.g., blackout restrictions, co-exclusive arrangements, partner-specific requirements).',
    `performance_guarantee_description` STRING COMMENT 'Free-text description of any performance commitments tied to this window (e.g., minimum viewership targets, promotional spend requirements, platform placement guarantees).',
    `platform_name` STRING COMMENT 'Name of the specific distribution platform, service, or channel authorized for this window (e.g., Netflix, Hulu, HBO Max, ABC Network).',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the platform has an option to renew or extend this window under predefined terms (True) or the window is non-renewable (False).',
    `renewal_terms` STRING COMMENT 'Free-text description of the terms under which this window may be renewed (e.g., pricing adjustments, duration, notice period). Populated when renewal_option_flag is True.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of revenue generated during this window that is shared with the content provider or partner, as defined in the acquisition deal.',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the platform is permitted to sublicense the content to third parties during this window (True) or must distribute directly (False).',
    `subtitle_requirement` STRING COMMENT 'Specifies subtitle languages required for this window to meet accessibility and localization obligations. Comma-separated list of ISO 639-1 language codes.',
    `territory_coverage` STRING COMMENT 'Geographic territories or markets where this window is valid (e.g., USA, CAN, GBR, Worldwide, North America). May be comma-separated list of ISO 3166-1 alpha-3 country codes or region names.',
    `window_duration_days` STRING COMMENT 'The total length of the distribution window in days, calculated from start to end date. Used for planning and compliance tracking.',
    `window_end_date` DATE COMMENT 'The date on which this distribution window expires and the content must be removed from the platform or the rights revert. Nullable for perpetual windows.',
    `window_sequence_number` STRING COMMENT 'Ordinal position of this window in the sequential release strategy (e.g., 1 for theatrical, 2 for SVOD, 3 for AVOD). Defines the chronological order of windowing.',
    `window_start_date` DATE COMMENT 'The date on which this distribution window becomes active and the content may be released on the specified platform.',
    `window_status` STRING COMMENT 'Current lifecycle status of the content window (e.g., planned, active, expired, terminated early, suspended, or extended beyond original end date).. Valid values are `planned|active|expired|terminated|suspended|extended`',
    `window_type` STRING COMMENT 'The distribution model or platform type for this release window (e.g., theatrical, SVOD, AVOD, TVOD, linear broadcast, syndication). [ENUM-REF-CANDIDATE: theatrical|svod|avod|tvod|linear|syndication|vod|fast|free_to_air|pay_per_view — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_partner_content_window PRIMARY KEY(`partner_content_window_id`)
) COMMENT 'Defines the sequential release windows (theatrical, SVOD, AVOD, TVOD, linear, syndication) granted to or from partners for specific content titles under acquisition, distribution, or syndication agreements. Tracks window type, platform exclusivity, start and end dates, holdback periods, and window sequencing order. Authoritative source for windowing strategy within the partner domain, complementing the rights domains rights window records.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` (
    `renewal_id` BIGINT COMMENT 'Unique identifier for the partner renewal record. Primary key for tracking renewal lifecycle events across acquisition deals, distribution agreements, affiliate agreements, and syndication contracts.',
    `partner_agreement_id` BIGINT COMMENT 'Reference to the specific partner agreement being renewed. May link to acquisition deals, distribution agreements, affiliate agreements, syndication contracts, or co-production arrangements depending on agreement type.',
    `partner_id` BIGINT COMMENT 'Reference to the partner organization whose agreement is up for renewal. Links to the partner master record for studios, syndicators, content providers, MVPDs, and third-party distribution partners.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing this partner relationship and driving the renewal process. Typically a content acquisition manager, distribution director, or partnership manager.',
    `quaternary_renewal_legal_reviewer_employee_id` BIGINT COMMENT 'Reference to the legal counsel assigned to review renewal terms, assess risk, and ensure compliance with regulatory requirements and corporate policies.',
    `tertiary_renewal_finance_approver_employee_id` BIGINT COMMENT 'Reference to the finance executive responsible for budget approval and financial impact assessment. Required approval level varies based on deal value thresholds.',
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

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` (
    `partner_deal_approval_id` BIGINT COMMENT 'Unique identifier for the deal approval record. Primary key for the deal approval workflow entity.',
    `acquisition_deal_id` BIGINT COMMENT 'Reference to the acquisition deal requiring approval. Links to the acquisition deal being evaluated for sign-off.',
    `affiliate_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.affiliate_agreement. Business justification: deal_approval should support affiliate_agreement approvals. New FK: affiliate_agreement_id → affiliate_agreement.affiliate_agreement_id. Nullable (only populated when approving affiliate agreements).',
    `coproduction_agreement_id` BIGINT COMMENT 'Reference to the co-production agreement requiring approval. Nullable when approval is for acquisition deals or distribution agreements.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deal approvals require cost center budget authority validation and spend authorization. Essential for SOX compliance, budget control, and approval workflow routing based on departmental spending limit',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: deal_approval currently supports acquisition_deal and coproduction_agreement approvals. Should also support distribution_agreement approvals. New FK: distribution_agreement_id → distribution_agreement',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Deal approvals validate profit center P&L impact and strategic alignment. Critical for segment-level investment decisions, EBITDA covenant compliance, and business unit accountability in content inves',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: High-value deal approvals (especially license transfers, ownership changes, foreign ownership increases, or control transfers) require concurrent FCC regulatory filings. Approval workflows must verify',
    `sox_control_id` BIGINT COMMENT 'Reference to the SOX internal control that governs this approval workflow. Links to the authorization control framework for audit and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Approval workflow requires structured submitter tracking for audit trail and workload reporting. Has approver_employee_id FK but submitter is text fields - need FK for submission volume by employee, a',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: deal_approval should support syndication_agreement approvals. New FK: syndication_agreement_id → syndication_agreement.syndication_agreement_id. Nullable (only populated when approving syndication agr',
    `approval_conditions` STRING COMMENT 'Stipulations or requirements that must be satisfied before deal execution. Examples include legal review completion, budget reallocation, or third-party consent.',
    `approval_decision` STRING COMMENT 'Final determination rendered by the approver. Conditional approvals require fulfillment of specified conditions before execution.. Valid values are `approved|rejected|conditional_approval|deferred|escalated`',
    `approval_expiration_date` DATE COMMENT 'Date after which the approval is no longer valid and must be resubmitted. Ensures approvals reflect current business conditions and deal terms.',
    `approval_level` STRING COMMENT 'Organizational tier required for sign-off. Escalation level determined by deal value, risk profile, and strategic impact.. Valid values are `business_unit|legal|finance|cfo|ceo|board`',
    `approval_request_number` STRING COMMENT 'Business identifier for the approval request. Human-readable reference number used in communications and audit trails.. Valid values are `^APR-[0-9]{8}-[A-Z0-9]{6}$`',
    `approval_status` STRING COMMENT 'Current state of the approval workflow. Tracks progression through the sign-off process from submission to final decision. [ENUM-REF-CANDIDATE: pending|in_review|approved|rejected|conditional|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `approval_threshold_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the deal value exceeds the monetary threshold requiring elevated approval. True triggers escalation to CFO or board per SOX authorization controls.',
    `approver_email` STRING COMMENT 'Email address of the approver for notification and audit purposes. Used for workflow routing and decision confirmation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `approver_name` STRING COMMENT 'Full name of the individual who rendered the approval decision. Confidential for audit trail and accountability purposes.',
    `approver_role` STRING COMMENT 'Functional role of the individual or committee authorized to approve. Examples include VP Content Acquisition, General Counsel, Chief Financial Officer (CFO), Board of Directors.',
    `audit_trail_notes` STRING COMMENT 'Free-text field for additional context, clarifications, or audit annotations. Supports SOX compliance documentation and internal control testing.',
    `carriage_fee_commitment_amount` DECIMAL(18,2) COMMENT 'Distribution payment obligation to Multichannel Video Programming Distributors (MVPD) or virtual Multichannel Video Programming Distributors (vMVPD). Material carriage fee agreements require CFO sign-off.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the approval record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `deal_type` STRING COMMENT 'Category of partner deal requiring approval. Determines the approval workflow path and required sign-off levels.. Valid values are `acquisition|distribution|coproduction|syndication|licensing|carriage`',
    `deal_value_amount` DECIMAL(18,2) COMMENT 'Total financial commitment of the deal requiring approval. Includes minimum guarantees (MG), license fees, and revenue share commitments. Used to determine approval threshold.',
    `deal_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deal value. Required for multi-currency deal portfolio management.. Valid values are `^[A-Z]{3}$`',
    `decision_timestamp` TIMESTAMP COMMENT 'Date and time when the approval decision was rendered. Critical for SOX audit trails and time-sensitive deal execution.',
    `escalation_count` STRING COMMENT 'Number of times the approval request has been escalated to a higher authority. Tracks workflow complexity and decision-making bottlenecks.',
    `finance_review_completed_date` DATE COMMENT 'Date when finance department completed their review and cleared the deal for approval. Nullable if finance review is not required or still pending.',
    `finance_review_required_flag` BOOLEAN COMMENT 'Indicates whether finance department review is mandatory before approval. True for deals with material budget impact or complex payment structures.',
    `ip_ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of intellectual property rights retained or acquired in co-production arrangements. IP ownership implications require legal and executive approval.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system process that last modified the approval record. Supports audit trail and change management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the approval record was last updated. Tracks changes to approval status, conditions, or decision outcomes.',
    `legal_review_completed_date` DATE COMMENT 'Date when legal counsel completed their review and cleared the deal for approval. Nullable if legal review is not required or still pending.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether legal counsel review is mandatory before approval. True for deals with IP ownership, exclusivity, or complex rights structures.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Upfront or guaranteed payment commitment in the deal. Acquisition deals above MG thresholds trigger mandatory CFO or board approval per SOX controls.',
    `rejection_reason` STRING COMMENT 'Explanation provided when approval is denied. Documents business rationale for audit and learning purposes.',
    `risk_tier` STRING COMMENT 'Risk classification of the deal based on financial exposure, partner creditworthiness, and strategic impact. High and critical tiers require elevated approval levels.. Valid values are `low|medium|high|critical`',
    `strategic_importance` STRING COMMENT 'Business significance of the deal to corporate objectives. Transformational deals require board-level approval regardless of financial threshold.. Valid values are `routine|important|strategic|transformational`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the approval request was submitted into the workflow. Marks the start of the approval lifecycle for Service Level Agreement (SLA) tracking.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URI to supporting documentation attached to the approval request. Includes deal summaries, financial models, and legal memos.',
    `target_execution_date` DATE COMMENT 'Desired date for deal execution and contract signing. Used to prioritize approval workflow and ensure timely decision-making.',
    CONSTRAINT pk_partner_deal_approval PRIMARY KEY(`partner_deal_approval_id`)
) COMMENT 'Approval workflow records for partner deals requiring internal sign-off before execution — acquisition deals above MG thresholds, distribution agreements with carriage fee commitments, and co-production arrangements with IP ownership implications. Tracks approver role, approval level (business unit, legal, CFO, board), decision, conditions, and timestamp. Supports SOX-compliant deal authorization controls.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` (
    `license_ownership_id` BIGINT COMMENT 'Unique identifier for this ownership relationship record. Primary key for the license_ownership association.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to the broadcast license in which the partner holds an attributable interest',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the partner entity that holds an attributable interest in the broadcast license',
    `attribution_status` STRING COMMENT 'Regulatory classification indicating whether this ownership interest is attributable under FCC rules (typically interests above 5% for voting stock, 33% for limited partnerships, or any officer/director position). Values: Attributable, Non-Attributable, Pending Review, Exempt.',
    `control_relationship_type` STRING COMMENT 'Nature of the control or ownership relationship between the partner and the licensed entity. Values: Equity Owner, Parent Company, Officer, Director, General Partner, Limited Partner, Creditor, Other.',
    `disclosure_required` BOOLEAN COMMENT 'Indicates whether this ownership interest must be disclosed on FCC Form 323 or equivalent regulatory filings. True if the interest meets attribution thresholds or involves officers/directors.',
    `effective_date` DATE COMMENT 'Date when this ownership or control relationship became effective. Used for tracking ownership changes over time and determining applicable regulatory filing deadlines.',
    `filing_reference` STRING COMMENT 'Reference number or identifier for the regulatory filing (FCC Form 323, license transfer application, etc.) that documents this ownership relationship. Used for audit trail and compliance verification.',
    `notes` STRING COMMENT 'Free-text field for additional context about the ownership relationship, including special arrangements, regulatory waivers, or pending ownership changes.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of equity or voting interest that the partner holds in the licensed entity. Used to determine attributable interest under FCC ownership rules. Values range from 0.01 to 100.00.',
    `position_title` STRING COMMENT 'Official title or position held by the partner representative in the licensed entity (e.g., CEO, Board Member, General Partner). Applicable when control_relationship_type is Officer, Director, or General Partner.',
    `termination_date` DATE COMMENT 'Date when this ownership or control relationship was terminated or transferred. Null if the relationship is currently active.',
    `voting_rights_percentage` DECIMAL(18,2) COMMENT 'Percentage of voting rights held by the partner, which may differ from equity ownership percentage in cases of dual-class stock or special voting arrangements. Critical for FCC attribution analysis.',
    CONSTRAINT pk_license_ownership PRIMARY KEY(`license_ownership_id`)
) COMMENT 'This association product represents the ownership and control relationship between partners and broadcast licenses. It captures the attributable interest that partners (equity investors, parent companies, affiliated entities) hold in licensed broadcast stations, including ownership percentages, control relationships, and regulatory disclosure requirements for FCC Form 323 and license transfer applications. Each record links one partner to one broadcast license with attributes that exist only in the context of this ownership relationship.. Existence Justification: In media broadcasting, partners (equity investors, parent companies, affiliated entities) can hold ownership or control interests in multiple broadcast licenses, and each broadcast license can have multiple attributable partners with varying ownership percentages and control relationships. The FCC and other regulatory bodies require detailed tracking of these ownership relationships for Form 323 filings, license transfers, and compliance with ownership concentration rules. This is an operational relationship that broadcasters actively manage for regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` (
    `deal_compliance_obligation_id` BIGINT COMMENT 'Unique identifier for this deal-specific compliance obligation record. Primary key.',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to the content acquisition deal that triggers this compliance obligation',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation applicable to this acquisition deal',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to the audit trail, documentation, or evidence supporting compliance verification for this deal-obligation pairing',
    `certification_required` BOOLEAN COMMENT 'Indicates whether formal certification or attestation is required for this deal-obligation combination',
    `compliance_status` STRING COMMENT 'Current compliance status for this deal-obligation pairing: pending (awaiting verification), verified (compliant), non_compliant (violation identified), waived (exemption granted), not_applicable (obligation does not apply to this specific deal)',
    `compliance_verification_date` DATE COMMENT 'Date when compliance with this specific obligation was verified for this acquisition deal',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review or re-verification of this obligation for this deal',
    `notes` STRING COMMENT 'Free-text notes documenting special circumstances, exemptions, or additional context for this deal-obligation compliance relationship',
    `obligation_triggered_date` DATE COMMENT 'Date when this regulatory obligation was triggered or became applicable to this acquisition deal, typically aligned with deal execution or content delivery',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual or team responsible for ensuring compliance with this obligation for this specific deal',
    CONSTRAINT pk_deal_compliance_obligation PRIMARY KEY(`deal_compliance_obligation_id`)
) COMMENT 'This association product represents the compliance relationship between acquisition deals and regulatory obligations. It captures the specific regulatory obligations triggered by each content acquisition deal, tracking compliance verification status, responsible parties, and certification requirements. Each record links one acquisition deal to one regulatory obligation with attributes that exist only in the context of this deal-specific compliance requirement.. Existence Justification: In media broadcasting operations, a single acquisition deal can trigger multiple distinct regulatory obligations (content rating certification, COPPA compliance for kids content, closed captioning requirements, political disclosure rules, territorial licensing restrictions), and each regulatory obligation applies to multiple acquisition deals across the content portfolio. Compliance teams actively manage these deal-obligation pairings, tracking verification status, responsible parties, certification requirements, and audit trails for each combination. This is an operational compliance management process, not an analytical correlation.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Primary key for vendor',
    `parent_vendor_id` BIGINT COMMENT 'Reference to the parent vendor if this vendor is a subsidiary or division of a larger vendor organization, enabling hierarchical vendor relationships.',
    `address_line_1` STRING COMMENT 'The first line of the vendors primary business address including street number and name.',
    `address_line_2` STRING COMMENT 'The second line of the vendors primary business address for suite, floor, or building information.',
    `city` STRING COMMENT 'The city or municipality where the vendors primary business address is located.',
    `vendor_code` STRING COMMENT 'The externally-known unique business identifier or code assigned to the vendor for operational reference.',
    `contract_end_date` DATE COMMENT 'The date on which the master vendor agreement or contract expires or is scheduled for renewal.',
    `contract_start_date` DATE COMMENT 'The date on which the master vendor agreement or contract becomes effective.',
    `country_code` STRING COMMENT 'The three-letter ISO country code representing the country where the vendor is headquartered.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'The maximum credit amount extended to the vendor for outstanding payables before payment is required.',
    `currency_code` STRING COMMENT 'The three-letter ISO currency code representing the vendors preferred currency for transactions.',
    `duns_number` STRING COMMENT 'The nine-digit DUNS number assigned by Dun & Bradstreet to uniquely identify the vendor business entity.',
    `insurance_certificate_expiration_date` DATE COMMENT 'The date on which the vendors current insurance certificate expires, requiring renewal for continued partnership.',
    `last_transaction_date` DATE COMMENT 'The date of the most recent business transaction or interaction with the vendor.',
    `minority_owned_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor is certified as a minority-owned business enterprise.',
    `modified_by` STRING COMMENT 'The user identifier or name of the person who last modified this vendor record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was last modified or updated.',
    `vendor_name` STRING COMMENT 'The full legal name of the vendor organization as registered for business purposes.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional notes, comments, or special instructions related to the vendor relationship.',
    `onboarding_date` DATE COMMENT 'The date on which the vendor was officially onboarded and approved for business transactions.',
    `payment_method` STRING COMMENT 'The preferred payment method for remitting payments to the vendor.',
    `payment_terms` STRING COMMENT 'The standard payment terms agreed upon with the vendor specifying when payment is due after invoice receipt.',
    `performance_rating` STRING COMMENT 'The overall performance rating of the vendor based on delivery quality, timeliness, and service level adherence.',
    `postal_code` STRING COMMENT 'The postal or ZIP code for the vendors primary business address.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor has preferred status for priority consideration in content acquisition and partnership opportunities.',
    `primary_contact_email` STRING COMMENT 'The primary email address for operational communication with the vendor.',
    `primary_contact_name` STRING COMMENT 'The full name of the primary contact person at the vendor organization.',
    `primary_contact_phone` STRING COMMENT 'The primary telephone number for reaching the vendor for business communications.',
    `risk_rating` STRING COMMENT 'The assessed risk level associated with doing business with this vendor based on financial stability, compliance history, and operational reliability.',
    `small_business_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor qualifies as a small business under applicable regulatory definitions.',
    `state_province` STRING COMMENT 'The state, province, or region where the vendors primary business address is located.',
    `tax_identification_number` STRING COMMENT 'The tax identification number or employer identification number (EIN) assigned to the vendor by the tax authority.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor relationship indicating whether the vendor is actively engaged, suspended, or terminated.',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on their role in the media ecosystem (e.g., studio, syndicator, content provider, MVPD, distributor, production company).',
    `website_url` STRING COMMENT 'The primary website URL for the vendor organization.',
    `woman_owned_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor is certified as a woman-owned business enterprise.',
    `created_by` STRING COMMENT 'The user identifier or name of the person who created this vendor record.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master reference table for vendor. Referenced by vendor_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` (
    `partner_agreement_id` BIGINT COMMENT 'Primary key for partner_agreement',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity within the organization that is party to this agreement.',
    `master_partner_agreement_id` BIGINT COMMENT 'Self-referencing FK on partner_agreement (master_partner_agreement_id)',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity (studio, syndicator, content provider, MVPD, distributor) that is party to this agreement.',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the partner agreement.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the partner agreement, used in contracts and communications.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the partner agreement indicating its operational state.',
    `agreement_type` STRING COMMENT 'Classification of the partner agreement based on its business purpose: content acquisition, syndication, co-production, distribution, affiliate, or licensing.',
    `amendment_count` STRING COMMENT 'Number of amendments or modifications made to the original agreement.',
    `approval_authority` STRING COMMENT 'Name or title of the executive or committee that approved this agreement.',
    `approval_date` DATE COMMENT 'Date when the agreement received final internal approval.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews upon expiration.',
    `confidentiality_period_years` STRING COMMENT 'Duration in years that confidentiality obligations remain in effect after agreement termination.',
    `content_category` STRING COMMENT 'Primary category of content covered by this agreement.',
    `contract_owner` STRING COMMENT 'Name or identifier of the business unit or individual responsible for managing this agreement.',
    `contract_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the partner agreement over its full term.',
    `contract_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner agreement record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'Method specified in the agreement for resolving disputes between parties.',
    `document_reference` STRING COMMENT 'Reference identifier or storage location for the physical or digital contract document.',
    `effective_end_date` DATE COMMENT 'Date when the partner agreement expires or terminates. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the partner agreement becomes legally binding and operational.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this agreement grants exclusive rights to the partner.',
    `execution_date` DATE COMMENT 'Date when the agreement was signed or executed by all parties.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and governing law applicable to this agreement (e.g., State of California, UK Law).',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner agreement record was last updated in the system.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount specified in the agreement for breach or damages.',
    `notes` STRING COMMENT 'Additional notes, comments, or special conditions related to the partner agreement.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required for termination or non-renewal of the agreement.',
    `payment_terms` STRING COMMENT 'Description of payment schedule, milestones, and conditions specified in the agreement.',
    `performance_guarantee_amount` DECIMAL(18,2) COMMENT 'Monetary value of performance guarantees or minimum commitments specified in the agreement.',
    `renewal_date` DATE COMMENT 'Date when the agreement is scheduled for renewal review or automatic renewal.',
    `renewal_term_months` STRING COMMENT 'Duration in months for each renewal period if auto-renewal is enabled.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the partner under this agreement, if applicable.',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated, if applicable.',
    `territory_coverage` STRING COMMENT 'Geographic territories or regions covered by this partner agreement (e.g., North America, EMEA, Global).',
    CONSTRAINT pk_partner_agreement PRIMARY KEY(`partner_agreement_id`)
) COMMENT 'Master reference table for partner_agreement. Referenced by partner_agreement_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` (
    `payment_schedule_id` BIGINT COMMENT 'Primary key for payment_schedule',
    `contract_id` BIGINT COMMENT 'Reference to the partner contract or agreement that governs this payment schedule.',
    `partner_id` BIGINT COMMENT 'Reference to the studio, syndicator, content provider, MVPD (Multichannel Video Programming Distributor), or third-party distribution partner receiving payment.',
    `revised_payment_schedule_id` BIGINT COMMENT 'Self-referencing FK on payment_schedule (revised_payment_schedule_id)',
    `advance_amount` DECIMAL(18,2) COMMENT 'Upfront payment amount advanced to the partner against future royalties or revenue share, to be recouped from subsequent earnings.',
    `amendment_count` STRING COMMENT 'The number of times this payment schedule has been amended or modified since its original creation.',
    `approved_by` STRING COMMENT 'Name or identifier of the business user or executive who approved this payment schedule for activation.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this payment schedule was formally approved and authorized for execution.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the payment schedule automatically renews at the end of its term unless explicitly terminated.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payment schedule (e.g., USD, EUR, GBP).',
    `effective_end_date` DATE COMMENT 'The date when this payment schedule expires or is no longer in effect. Nullable for open-ended schedules.',
    `effective_start_date` DATE COMMENT 'The date when this payment schedule becomes effective and binding.',
    `escalation_clause_flag` BOOLEAN COMMENT 'Indicates whether the payment schedule includes an escalation clause that increases payment amounts over time or based on performance milestones.',
    `escalation_percentage` DECIMAL(18,2) COMMENT 'The percentage increase applied to payment amounts under the escalation clause, if applicable (e.g., 5.00 represents 5% annual increase).',
    `final_payment_date` DATE COMMENT 'The scheduled date for the final payment under this payment schedule, marking the end of the payment obligation.',
    `first_payment_date` DATE COMMENT 'The scheduled date for the first payment under this payment schedule.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum guaranteed payment amount that must be paid to the partner regardless of performance or revenue, common in content licensing and distribution agreements.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment schedule record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information about the payment schedule.',
    `payment_account_number` STRING COMMENT 'The partners bank account number or payment account identifier to which payments under this schedule are remitted.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The standard payment amount for each scheduled payment installment, in the specified currency. May be fixed or variable depending on schedule type.',
    `payment_calculation_basis` STRING COMMENT 'The basis or formula used to calculate payment amounts: fixed amount, gross revenue, net revenue, subscriber count, viewership metrics, per episode, or per season.',
    `payment_frequency` STRING COMMENT 'Frequency at which payments are scheduled to be made under this schedule: one-time, monthly, quarterly, semi-annual, annual, upon delivery, or upon broadcast.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to execute payments: wire transfer, ACH (Automated Clearing House), check, letter of credit, escrow, or direct deposit.',
    `payment_priority` STRING COMMENT 'Business priority level assigned to this payment schedule for cash flow management and payment processing sequencing.',
    `payment_routing_number` STRING COMMENT 'The bank routing number or SWIFT code for the partners payment account, used for wire transfers and ACH transactions.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date or trigger event within which payment must be made (e.g., Net 30, Net 60).',
    `payment_trigger_event` STRING COMMENT 'The business event or milestone that triggers payment obligation, such as content delivery, broadcast date, subscriber threshold, or contract execution.',
    `recoupment_flag` BOOLEAN COMMENT 'Indicates whether advances or minimum guarantees are subject to recoupment from future revenue or royalty payments.',
    `recoupment_percentage` DECIMAL(18,2) COMMENT 'The percentage of future payments that will be withheld to recoup advances or minimum guarantees (e.g., 100.00 represents full recoupment).',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required before the renewal date to terminate or modify the payment schedule.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of revenue to be shared with the partner, applicable for revenue-sharing payment schedules (e.g., 25.00 represents 25%).',
    `royalty_rate` DECIMAL(18,2) COMMENT 'The royalty rate percentage or per-unit rate applied to calculate royalty payments for content usage, licensing, or distribution.',
    `schedule_number` STRING COMMENT 'Business-facing unique identifier or reference number for this payment schedule, used in partner communications and financial reporting.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the payment schedule: draft (under negotiation), active (in effect), suspended (temporarily paused), completed (all payments made), terminated (cancelled), or amended (modified).',
    `schedule_type` STRING COMMENT 'Classification of the payment schedule based on the nature of the financial obligation: content acquisition, licensing fee, royalty, revenue share, minimum guarantee, advance, or co-production arrangement.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'The total monetary value of all payments scheduled under this payment schedule over its entire term, in the specified currency.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'The tax withholding rate percentage applied to payments for cross-border transactions or as required by tax regulations (e.g., 15.00 represents 15%).',
    CONSTRAINT pk_payment_schedule PRIMARY KEY(`payment_schedule_id`)
) COMMENT 'Master reference table for payment_schedule. Referenced by payment_schedule_id.';

CREATE OR REPLACE TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` (
    `partner_id` BIGINT COMMENT 'Unique identifier for the partner_partner data product (auto-inserted pre-linking).',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the partner entity. Primary key for the partner master record.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_coproduction_agreement_id` FOREIGN KEY (`coproduction_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement`(`coproduction_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ADD CONSTRAINT `fk_partner_deal_negotiation_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ADD CONSTRAINT `fk_partner_deal_amendment_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ADD CONSTRAINT `fk_partner_deal_amendment_superseded_by_amendment_deal_amendment_id` FOREIGN KEY (`superseded_by_amendment_deal_amendment_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`deal_amendment`(`deal_amendment_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_partner_agreement_id` FOREIGN KEY (`partner_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner_agreement`(`partner_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ADD CONSTRAINT `fk_partner_performance_obligation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_payment_schedule_id` FOREIGN KEY (`payment_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`payment_schedule`(`payment_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_partner_agreement_id` FOREIGN KEY (`partner_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner_agreement`(`partner_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_partner_agreement_id` FOREIGN KEY (`partner_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner_agreement`(`partner_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ADD CONSTRAINT `fk_partner_partner_audit_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ADD CONSTRAINT `fk_partner_partner_dispute_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_partner_agreement_id` FOREIGN KEY (`partner_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner_agreement`(`partner_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ADD CONSTRAINT `fk_partner_renewal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_affiliate_agreement_id` FOREIGN KEY (`affiliate_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement`(`affiliate_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_coproduction_agreement_id` FOREIGN KEY (`coproduction_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement`(`coproduction_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ADD CONSTRAINT `fk_partner_partner_deal_approval_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ADD CONSTRAINT `fk_partner_license_ownership_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ADD CONSTRAINT `fk_partner_deal_compliance_obligation_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ADD CONSTRAINT `fk_partner_vendor_parent_vendor_id` FOREIGN KEY (`parent_vendor_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ADD CONSTRAINT `fk_partner_partner_agreement_master_partner_agreement_id` FOREIGN KEY (`master_partner_agreement_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner_agreement`(`partner_agreement_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ADD CONSTRAINT `fk_partner_partner_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ADD CONSTRAINT `fk_partner_payment_schedule_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ADD CONSTRAINT `fk_partner_payment_schedule_revised_payment_schedule_id` FOREIGN KEY (`revised_payment_schedule_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`payment_schedule`(`payment_schedule_id`);
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ADD CONSTRAINT `fk_partner_partner_parent_partner_id` FOREIGN KEY (`parent_partner_id`) REFERENCES `vibe_media_broadcasting_v1`.`partner`.`partner`(`partner_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_media_broadcasting_v1`.`partner` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_media_broadcasting_v1`.`partner` SET TAGS ('dbx_domain' = 'partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `partner_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `compliance_consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Owner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_business_glossary_term' = 'Assistant Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `assistant_name` SET TAGS ('dbx_business_glossary_term' = 'Assistant Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_business_glossary_term' = 'Assistant Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `communication_language` SET TAGS ('dbx_business_glossary_term' = 'Communication Language');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `contract_signatory` SET TAGS ('dbx_business_glossary_term' = 'Contract Signatory Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `decision_making_authority` SET TAGS ('dbx_business_glossary_term' = 'Decision Making Authority Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `decision_making_authority` SET TAGS ('dbx_value_regex' = 'full|limited|advisory|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contact End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile Uniform Resource Locator (URL)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `nda_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Signed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `next_scheduled_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Contact Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `preferred_communication_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `preferred_communication_method` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|video_conference|in_person');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Zone');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_contact` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` SET TAGS ('dbx_subdomain' = 'deal_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Owner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Provider Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` SET TAGS ('dbx_subdomain' = 'deal_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `acquisition_deal_line_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Line Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`acquisition_deal_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` SET TAGS ('dbx_subdomain' = 'deal_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`distribution_agreement` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` SET TAGS ('dbx_subdomain' = 'deal_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiated By Employee Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`syndication_agreement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` SET TAGS ('dbx_subdomain' = 'deal_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Production Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `coppa_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Coppa Declaration Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Talent Profile Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`coproduction_agreement` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Production Title Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` SET TAGS ('dbx_subdomain' = 'deal_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliate_network_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Network Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Station Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Network Legal Entity Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `primary_affiliate_station_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Station Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliate_station_channel_id` SET TAGS ('dbx_business_role_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`affiliate_agreement` ALTER COLUMN `network_channel_id` SET TAGS ('dbx_business_role_fk' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` SET TAGS ('dbx_subdomain' = 'deal_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `deal_negotiation_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Negotiation Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Negotiator Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Acquisition Deal Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Affiliate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Coproduction Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `sweeps_period_id` SET TAGS ('dbx_business_glossary_term' = 'Sweeps Period Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Target Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `tertiary_deal_legal_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `tertiary_deal_legal_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `tertiary_deal_legal_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `agreed_deal_value` SET TAGS ('dbx_business_glossary_term' = 'Agreed Deal Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `agreed_deal_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `approval_chain` SET TAGS ('dbx_business_glossary_term' = 'Approval Chain');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `deal_currency` SET TAGS ('dbx_business_glossary_term' = 'Deal Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `deal_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Deal Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `deal_number` SET TAGS ('dbx_value_regex' = '^DEAL-[0-9]{6,10}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'content_acquisition|content_licensing|distribution_agreement|co_production|syndication|carriage_agreement');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `key_open_issues` SET TAGS ('dbx_business_glossary_term' = 'Key Open Issues');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `key_open_issues` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|approved|rejected|conditional_approval');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `negotiation_stage` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Stage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `negotiation_status` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `payment_structure` SET TAGS ('dbx_business_glossary_term' = 'Payment Structure');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `payment_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `proposed_deal_value` SET TAGS ('dbx_business_glossary_term' = 'Proposed Deal Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `proposed_deal_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `redline_version_count` SET TAGS ('dbx_business_glossary_term' = 'Redline Version Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `rights_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Rights Duration (Years)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `rights_territory` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `target_close_date` SET TAGS ('dbx_business_glossary_term' = 'Target Close Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `term_sheet_date` SET TAGS ('dbx_business_glossary_term' = 'Term Sheet Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_negotiation` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` SET TAGS ('dbx_subdomain' = 'deal_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `deal_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Amendment Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `superseded_by_amendment_deal_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Amendment Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_value_regex' = '^AMD-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|executed|rejected|superseded');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'financial|territorial|term_extension|content_scope|rights_modification|technical');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `approval_chain` SET TAGS ('dbx_business_glossary_term' = 'Approval Chain');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `approval_chain` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `business_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `clauses_modified` SET TAGS ('dbx_business_glossary_term' = 'Clauses Modified');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `clauses_modified` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `content_scope_change` SET TAGS ('dbx_business_glossary_term' = 'Content Scope Change');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `content_scope_change` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Execution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Amendment Initiated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `initiated_by` SET TAGS ('dbx_value_regex' = 'internal|partner|mutual');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `internal_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Internal Signatory Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `internal_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `internal_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Internal Signatory Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `internal_signatory_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `legal_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `legal_reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `partner_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Signatory Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `partner_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `partner_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Partner Signatory Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `partner_signatory_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `rights_modification_description` SET TAGS ('dbx_business_glossary_term' = 'Rights Modification Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `rights_modification_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `term_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Term Extension Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `territory_change_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Change Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `territory_change_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_amendment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` SET TAGS ('dbx_subdomain' = 'contractual_obligations');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Obligation Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Delivered Asset Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`delivery_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` SET TAGS ('dbx_subdomain' = 'financial_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `carriage_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Schedule ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `base_fee_per_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Base Fee Per Subscriber');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Escalation Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_value_regex' = 'none|annual|biannual|quarterly|monthly|custom');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `escalation_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Escalation Rate Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Escalation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `escalation_type` SET TAGS ('dbx_value_regex' = 'none|fixed_percentage|cpi_indexed|negotiated|tiered');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'per_subscriber|flat_rate|tiered|volume_based|hybrid|revenue_share');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `maximum_fee_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Fee Cap');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `mfn_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Most-Favored-Nation (MFN) Provision Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `mfn_scope` SET TAGS ('dbx_business_glossary_term' = 'Most-Favored-Nation (MFN) Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `minimum_guaranteed_fee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guaranteed Fee');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|custom');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|superseded');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `subscriber_count_source` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Count Source');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `subscriber_count_source` SET TAGS ('dbx_value_regex' = 'distributor_reported|third_party_audit|nielsen|internal_estimate');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_1_rate` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 1 Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_1_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 1 Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_2_rate` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 2 Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_2_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 2 Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_3_rate` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 3 Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_3_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 3 Threshold');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'contractual_obligations');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Performance Obligation Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `accessibility_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Obligation Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `partner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `sweeps_period_id` SET TAGS ('dbx_business_glossary_term' = 'Sweeps Period Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|at_risk|under_review|not_yet_measured|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `cure_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Cure Deadline Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `cure_period_days` SET TAGS ('dbx_business_glossary_term' = 'Cure Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|level_1|level_2|level_3|executive|legal');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `last_breach_date` SET TAGS ('dbx_business_glossary_term' = 'Last Breach Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `last_measured_date` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `last_measured_value` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `last_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Notification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `makegood_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Makegood Provision Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `makegood_spots_required` SET TAGS ('dbx_business_glossary_term' = 'Makegood Spots Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `monitoring_system` SET TAGS ('dbx_business_glossary_term' = 'Monitoring System');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'uptime_guarantee|content_delivery_sla|ratings_performance|subscriber_penetration|makegood_provision|quality_of_service');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'financial_credit|makegood_spots|service_credit|termination_right|escalation|none');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly|quarterly|on_demand');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `sla_metric` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_business_glossary_term' = 'Threshold Operator');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_value_regex' = 'greater_than|greater_than_or_equal|less_than|less_than_or_equal|equal|between');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`performance_obligation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` SET TAGS ('dbx_subdomain' = 'financial_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `minimum_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Provider ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`minimum_guarantee` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` SET TAGS ('dbx_subdomain' = 'financial_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Payment Term Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `invoice_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `late_payment_grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Grace Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Bank Account Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_bank_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annual|annual|upon_milestone');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|letter_of_credit|escrow|barter');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_milestone` SET TAGS ('dbx_business_glossary_term' = 'Payment Milestone');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_remittance_email` SET TAGS ('dbx_business_glossary_term' = 'Payment Remittance Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_remittance_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_remittance_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `payment_terms_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `term_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'acquisition_fee|carriage_fee|syndication_fee|co_production_contribution|royalty|residual');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `withholding_tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Jurisdiction');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `withholding_tax_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_term` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` SET TAGS ('dbx_subdomain' = 'contractual_obligations');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `territory_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Grant ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `partner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`territory_grant` ALTER COLUMN `scheduling_availability_window_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Window Id (Foreign Key)');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `partner_audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Audit Event ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Invoice Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Disputed Content Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Coordinator Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `partner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `adjustment_amount_currency` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `adjustment_amount_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_cost` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_finding_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Firm Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Initiated Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_trigger` SET TAGS ('dbx_business_glossary_term' = 'Audit Trigger');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_trigger` SET TAGS ('dbx_value_regex' = 'scheduled|threshold_breach|dispute|regulatory|random|partner_request');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'content_usage|subscriber_count|royalty_statement|carriage_fee|co_production_cost|rights_compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `cost_recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `cost_recovery_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|invoiced|partially_recovered|fully_recovered|waived');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `disputed_amount_currency` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `disputed_amount_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `draft_report_date` SET TAGS ('dbx_business_glossary_term' = 'Draft Report Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `fieldwork_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `fieldwork_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `final_report_date` SET TAGS ('dbx_business_glossary_term' = 'Final Report Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'no_findings|minor_discrepancy|material_discrepancy|compliance_breach|fraud_suspected|process_weakness');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `follow_up_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `follow_up_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `partner_response_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Response Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `partner_response_summary` SET TAGS ('dbx_business_glossary_term' = 'Partner Response Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_audit_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `partner_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Dispute Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Disputed Title Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Acknowledgment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `arbitration_body` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Body');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `arbitration_case_number` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Case Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `arbitration_required` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `assigned_to_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Department');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_business_glossary_term' = 'Dispute Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_value_regex' = 'financial|operational|contractual|technical|legal|compliance');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'payment_discrepancy|content_delivery_failure|ratings_shortfall|carriage_fee_calculation|rights_violation|sla_breach');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `disputed_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount in United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `disputed_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Disputed Period End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `disputed_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Disputed Period Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|executive|legal');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `evidence_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submitted Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `filed_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Filed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Dispute Initiated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `initiated_by` SET TAGS ('dbx_value_regex' = 'partner|internal');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `legal_hold_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `legal_hold_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `mediation_required` SET TAGS ('dbx_business_glossary_term' = 'Mediation Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `preventive_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Taken');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'partner_favor|internal_favor|mutual_settlement|withdrawn|dismissed|arbitration_award');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `resolution_summary` SET TAGS ('dbx_business_glossary_term' = 'Resolution Summary');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `settlement_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount in United States Dollars (USD)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `supporting_evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Supporting Evidence Location');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_dispute` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` SET TAGS ('dbx_subdomain' = 'contractual_obligations');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `partner_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Content Window Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Window Owner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `content_format` SET TAGS ('dbx_business_glossary_term' = 'Content Format');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `content_format` SET TAGS ('dbx_value_regex' = 'sd|hd|4k|8k|hdr|dolby_vision');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_value_regex' = 'none|widevine|fairplay|playready|multi_drm');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `language_availability` SET TAGS ('dbx_business_glossary_term' = 'Language Availability');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `marketing_rights_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Rights Included Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `monetization_model` SET TAGS ('dbx_value_regex' = 'subscription|advertising|transactional|free|hybrid');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `performance_guarantee_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Description');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `performance_guarantee_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `subtitle_requirement` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Requirement');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `territory_coverage` SET TAGS ('dbx_business_glossary_term' = 'Territory Coverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `window_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Window Duration in Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Window End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `window_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Window Sequence Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Window Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `window_status` SET TAGS ('dbx_business_glossary_term' = 'Window Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `window_status` SET TAGS ('dbx_value_regex' = 'planned|active|expired|terminated|suspended|extended');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_content_window` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Renewal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `partner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `quaternary_renewal_legal_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `quaternary_renewal_legal_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `quaternary_renewal_legal_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `tertiary_renewal_finance_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Approver Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `tertiary_renewal_finance_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`renewal` ALTER COLUMN `tertiary_renewal_finance_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `partner_deal_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Approval Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Production Agreement Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Identifier (ID)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approval_decision` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approval_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|conditional_approval|deferred|escalated');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approval_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'business_unit|legal|finance|cfo|ceo|board');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approval_request_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Request Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approval_request_number` SET TAGS ('dbx_value_regex' = '^APR-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approval_threshold_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Exceeded Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_business_glossary_term' = 'Approver Email Address');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approver_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `carriage_fee_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Commitment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `carriage_fee_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'acquisition|distribution|coproduction|syndication|licensing|carriage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `deal_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `deal_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `escalation_count` SET TAGS ('dbx_business_glossary_term' = 'Escalation Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `finance_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Finance Review Completed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `finance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Finance Review Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `ip_ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `ip_ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `legal_review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_value_regex' = 'routine|important|strategic|transformational');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_deal_approval` ALTER COLUMN `target_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Execution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` SET TAGS ('dbx_association_edges' = 'partner.partner_partner,compliance.broadcast_license');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `license_ownership_id` SET TAGS ('dbx_business_glossary_term' = 'License Ownership Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'License Ownership - Broadcast License Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'License Ownership - Partner Partner Partner Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `attribution_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `control_relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Control Relationship Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Required Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Ownership Effective Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Ownership Relationship Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `position_title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Ownership Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`license_ownership` ALTER COLUMN `voting_rights_percentage` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` SET TAGS ('dbx_association_edges' = 'partner.acquisition_deal,compliance.regulatory_obligation');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ALTER COLUMN `deal_compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Compliance Obligation ID');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Compliance Obligation - Acquisition Deal Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Compliance Obligation - Regulatory Obligation Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ALTER COLUMN `compliance_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verification Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ALTER COLUMN `obligation_triggered_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Triggered Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`deal_compliance_obligation` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `parent_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Vendor Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Duns Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `insurance_certificate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiration Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `minority_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority Owned Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `small_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `woman_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Woman Owned Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`vendor` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` SET TAGS ('dbx_subdomain' = 'deal_agreements');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `partner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `master_partner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Partner Agreement Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `master_partner_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `confidentiality_period_years` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Period Years');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `content_category` SET TAGS ('dbx_business_glossary_term' = 'Content Category');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `contract_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `contract_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `contract_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Currency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `performance_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `performance_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner_agreement` ALTER COLUMN `territory_coverage` SET TAGS ('dbx_business_glossary_term' = 'Territory Coverage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` SET TAGS ('dbx_subdomain' = 'financial_terms');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Identifier');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `revised_payment_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revised Payment Schedule Id');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `revised_payment_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `advance_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `advance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `escalation_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `escalation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Escalation Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `final_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `first_payment_date` SET TAGS ('dbx_business_glossary_term' = 'First Payment Date');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Account Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Payment Calculation Basis');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Routing Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `payment_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Payment Trigger Event');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `recoupment_flag` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Flag');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `recoupment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`payment_schedule` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for partner_partner');
ALTER TABLE `vibe_media_broadcasting_v1`.`partner`.`partner` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
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
